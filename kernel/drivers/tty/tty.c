typedef struct TTYBuffer {
  unsigned short * volatile buffer, *buffer_out;
  unsigned char * volatile linelasts; //last column of each line

  int width, height, scrolly, scrolly_off;
  int cursorx, cursory;
  int escape_mode, escape_state[15], escape_statelen;

  int lastwritten;
  int fg, bg, lastfg, intensity;

  void (*flip)(struct TTYBuffer *self);
} TTYBuffer;

#include <stdint.h>
#include <stddef.h>
#include "tty.h"
#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../task/lock.h"

uint8_t make_color(enum vga_color fg, enum vga_color bg);
void tty_scroll(TTYBuffer *tty, int delta);

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

int cursorx=0, cursory=0;
/*
int smemset(unsigned short *a, unsigned short val, int len) {
  int i;

  for (i=0; i<len; i++, a++) {
    *a = val;
  }

  return 0;
}

int smemcpy(unsigned short *a, unsigned short *b, int len) {
  int i = 0;

  for (i=0; i<len; i++) {
    *a = *b;
    a++, b++;
  }

  return 0;
}
//*/

uint16_t make_vgaentry(unsigned char c, enum vga_color fg, enum vga_color bg);

static Lock tty_lock = LOCK_INIT;
//static CriticalSection tty_lock = {0,};
 
uint8_t make_color(enum vga_color fg, enum vga_color bg) {
  return fg | bg << 4;
}

uint16_t make_vgaentry(unsigned char c, enum vga_color fg, enum vga_color bg) {
  uint8_t color = make_color(fg, bg);
  uint16_t c16 = c;
  uint16_t color16 = color;

  return c16 | (color16 << 8);
}

int tty_putchar(TTYBuffer *tty, unsigned char code);

int tty_move_cursor(TTYBuffer *tty, int deltax, int deltay) {
  tty->cursorx += deltax;
  tty->cursory += deltay;

  if (tty->cursorx < 0)
    tty->cursorx = 0;
  if (tty->cursorx >= tty->width)
    tty->cursorx = tty->width-1;

  if (tty->cursory < 0)
    tty->cursory = 0;
  if (tty->cursory >= tty->height)
    tty->cursory = tty->height-1;

  return 0;
}

#define DF(val, defaultv) ((val) == 0xff ? defaultv : (val))

void tty_hide_cursor(TTYBuffer *tty) {
}
void tty_show_cursor(TTYBuffer *tty) {
}

int sgr_color_table1[] = {
  COLOR_BLACK,
  COLOR_RED,
  COLOR_GREEN,
  COLOR_BROWN,//COLOR_YELLOW,
  COLOR_BLUE,
  COLOR_MAGENTA,
  COLOR_CYAN,
  COLOR_LIGHT_GREY
};
int sgr_color_table2[] = { //bright
  COLOR_BLACK,
  COLOR_LIGHT_RED,
  COLOR_LIGHT_GREEN,
  COLOR_LIGHT_BROWN,//COLOR_YELLOW,
  COLOR_LIGHT_BLUE,
  COLOR_LIGHT_MAGENTA,
  COLOR_LIGHT_CYAN,
  COLOR_WHITE, 
  COLOR_WHITE,//just to be safe...
  COLOR_WHITE,
  COLOR_WHITE
};

void tty_set_sgr(TTYBuffer *tty, short c1, short c2) {
  int code = (c1 - '0')*10 + (c2 - '0');

  switch (code) {
  case 0:
  case 22:
    tty->fg = COLOR_DEFAULT;
    tty->bg = 0;
    tty->intensity = 0;
    break;
  case 1:
    tty->intensity = 1;
    break;
  case 9: //hide
    tty->lastfg = tty->fg;
    tty->fg = tty->bg;
    break;
  case 28: //reveal
    tty->fg = tty->lastfg;
    break;
  case 30:
  case 31:
  case 32:
  case 33:
  case 34:
  case 35:
  case 36:
  case 37:
    tty->fg = tty->intensity ? sgr_color_table2[code - 30] : sgr_color_table1[code - 30];
    break;
  case 40:
  case 41:
  case 42:
  case 43:
  case 44:
  case 45:
  case 46:
  case 47:
    tty->bg = tty->intensity ? sgr_color_table2[code - 40] : sgr_color_table1[code - 40];
    break;
  }
}

static int apply_esc_command(TTYBuffer *tty, unsigned char code) {
  int s1 = tty->escape_statelen > 0 ? tty->escape_state[0] : 0xff;

  int is_dec = (code == 'l' || code == 'h') && tty->escape_statelen == 3;
  is_dec = is_dec && (tty->escape_state[0] == '?' && tty->escape_state[1] == '2' && tty->escape_state[2] == '5');
  if (is_dec) {
    switch (code) {
    case 'l':
      tty_hide_cursor(tty);
      break;
    case 'h':
      tty_show_cursor(tty);
    }
  }

  switch (code) {
    case 'D': //left
      tty_move_cursor(tty, -DF(s1, 1), 0);
      break;
    case 'C': //right
      tty_move_cursor(tty, DF(s1, 1), 0);
      break;
    case 'A': //up
      tty_move_cursor(tty, 0, DF(s1, 1));
      break;
    case 'B': //down
      tty_move_cursor(tty, 0, -DF(s1, 1));
      break;
    case 'S': //scroll up
      tty_scroll(tty, -DF(s1, 1));
      break;
    case 'T': //scroll down
      tty_scroll(tty, DF(s1, 1));
      break;
    case 'm': { //set graphics parameters
      int i, codea=0, codeb=0;
      
      for (i=0; i<tty->escape_statelen; i ++) {
        if (i < tty->escape_statelen-1 && tty->escape_state[i+1] == ';') {
          codea = tty->escape_state[i];
          i++;
        } if (i < tty->escape_statelen-1) {
          codea = tty->escape_state[i];
          codeb = tty->escape_state[i+1];
          i += 2;
        }

        tty_set_sgr(tty, codea, codeb);
      }
      break;
    }
  }

  return 0;
}

int tty_do_escape(TTYBuffer *tty, unsigned char code) {
  if (tty->escape_mode == 27) {
    if (code != '[' && code >= 64 && code < 95) {
      //simple command
      tty->escape_statelen = 0;
      tty->escape_mode = 0;
      return 0;
    } else if (code != '[') {
      //bad multipart command
      tty->escape_statelen = 0;
      tty->escape_mode = 0;

      tty_putchar(tty, 7);
      return 0;
    } else {
      tty->escape_mode = '[';
      return 0;
    }
  }

  int bad = 0;
  /*bad = (tty->escape_mode != 27 && code >= 64 && code < 127);
    bad = bad && tty->escape_statelen == 0;//*/
  bad = bad || tty->escape_statelen >= (int)(sizeof(tty->escape_state)/sizeof(*tty->escape_state));

  if (bad) {
    tty->escape_statelen = 0;
    tty->escape_mode = 0;

    tty_putchar(tty, 7);
    return 0;
  }

  if (tty->escape_mode != 27 && code >= 64 && code < 127) {
    apply_esc_command(tty, code);

    tty->escape_statelen = 0;
    tty->escape_mode = 0;
    return 0;
  }

  tty->escape_mode = code;
  tty->escape_state[tty->escape_statelen++] = code;

  return 0;
}

int tty_putchar(TTYBuffer *tty, unsigned char code) {
  //klock_lock(&tty_lock);
   
  if (tty->escape_mode) {
    tty_do_escape(tty, code);
    return 0;
  }

  if (code == 27) {
    //escape key!
    tty->escape_mode = 27;
    return 0;
  } else if (code == 155) { //single code version of ESC[
    tty->escape_mode = 155;
    return 0;
  }

  int x = tty->cursorx;
  int y = tty->cursory;

  int idx = y * tty->width + x;

  if (code == 8) {
  x--;

  if (x < 0) {
    y--;

    if (y < 0) {
      y = tty->height-1;
    }

    x = tty->linelasts[y];

    if (x == 255) {
      x = tty->width - 1;
    }
  }

  idx = y * tty->width + x;
    tty->buffer[idx] = make_vgaentry(' ', tty->fg, tty->bg);
  } else if (code == '\r') {
    int i;

    for (i=0; i<x; i++) {
      idx = y*tty->width + i;
      tty->buffer[idx] = make_vgaentry(' ', tty->fg, tty->bg);
    }

    x = 0;
  } else if (code == '\n') {
  tty->linelasts[y] = x;
    x = 0;
    y++;
  } else if (code == '\t') {
    tty_putchar(tty, ' ');
    tty_putchar(tty, ' ');
    tty_putchar(tty, ' ');
    tty_putchar(tty, ' ');
    return 0;
  } else {
    tty->buffer[idx] = make_vgaentry(code, tty->fg, tty->bg);
    
  x++;

    if (x >= tty->width) {
      x = 0;
      y++;
    }
  }
  
  if (y >= tty->height) {
    y = 0;
    //tty->scrolly_off = (tty->scrolly_off+1) % tty->height;
  }
  
  tty->cursorx = x;
  tty->cursory = y;
  
  if (y > VGA_HEIGHT) {
    tty->scrolly_off = y - VGA_HEIGHT + 1;
  }
  //klock_unlock(&tty_lock);
  
  return 0;
}

static TTYBuffer tty;

void tty_flip(TTYBuffer *tty) {
  int scroll = tty->scrolly + tty->scrolly_off;
  
  //sync cursor
  int cy = tty->cursory - scroll;
  if (cy >= 0 && cy < VGA_HEIGHT) {
    cursory = cy;
  }

  int cx = tty->cursorx;
  if (cx >= 0 && cx < VGA_WIDTH) {
    cursorx = cx;
  }

  for (int _i=0; _i<VGA_HEIGHT; _i++) {
    int i = _i;
    int j = (_i + scroll) % tty->height;
  while (j < 0) {
    j += tty->height;
  }

    
    smemcpy(tty->buffer_out + i*VGA_WIDTH, tty->buffer + j*VGA_WIDTH, VGA_WIDTH);
  }
}

extern uint16_t * volatile terminal_history;
extern uint8_t * volatile terminal_linelasts;
extern uint16_t * volatile terminal_buffer;

void terminal_initialize() {
  memset(&tty, 0, sizeof(tty));
  
  tty.linelasts = terminal_linelasts;
  tty.width = VGA_WIDTH;
  tty.height = TTY_BUFFER_ROWS;
  tty.buffer = terminal_history;
  tty.buffer_out = (uint16_t*) 0xB8000;
  tty.flip = tty_flip;
  tty.fg = COLOR_DEFAULT;

  smemset(tty.buffer, 32, tty.width*tty.height);
  memset(terminal_linelasts, 255, sizeof(terminal_linelasts));
  //klock_init(&tty_lock);
}

void _set_buffer(unsigned short *buffer) {
  tty.buffer_out = buffer;
}

void terminal_flush() {
  tty.flip(&tty);
}

void terminal_putchar(unsigned char ch) {
  //klock_lock(&klock);
  
  tty_putchar(&tty, ch);
  
  if (tty.lastwritten++ > 100) {
    tty.lastwritten = 0;
    tty.flip(&tty);
  }
  
  //klock_unlock(&klock);
}

void tty_scroll(TTYBuffer *tty, int delta) {
  tty->scrolly += delta;
}

int terminal_scroll(int delta) {
  tty_scroll(&tty, delta);
  tty.flip(&tty);
  return 0;
}

void terminal_resetscroll() {
  tty.scrolly = 0;
  tty.flip(&tty);
}

void terminal_setcolor(uint8_t color) {
  tty.fg = color;
}

void terminal_writestring(const unsigned char* data) {
	size_t datalen = strlen(data);
  
	for (size_t i = 0; i < datalen; i++)
		terminal_putchar(data[i]);
}

int terminal_get_hcursor() {
  return 0;
}

int terminal_set_hcursor(int x, int y) {
  size_t index = y*VGA_WIDTH + x;
  //0x03BA
  //0x03DA
  //0x03Dx
  
  short iomode = inb(0x3CC);
  short crt_addr = iomode & 128 ? 0x03B4 : 0x03D4;
  short crt_data = iomode & 128 ? 0x03B5 : 0x03D5;
  //short input_status = iomode & 1 ? 0x03BA : 0x03DA;

  outb(crt_addr, 0xF);
  outb(crt_data, index & 255);
  
  index = index >> 8;
  
  outb(crt_addr, 0xE);
  outb(crt_data, index & 255);
  
  return 0;
}

int terminal_reset_hcursor() {
 // unsigned int toff = terminal_row_off % VGA_HEIGHT;
  
 // terminal_set_hcursor(terminal_column, (terminal_row + VGA_HEIGHT - toff) % VGA_HEIGHT);
  return 0;
}

int terminal_move_cursor(int delta) {
  tty_move_cursor(&tty, delta, 0);
  
  return 0;
}

/************ debug stuff *****************/

static volatile unsigned int debug_entries[32] = {0,};
static volatile unsigned int debug_backup[32] = {0,};

static unsigned char hexline[] = "0123456789ABCDEF";

void terminal_set_idebug(int basechannel, int len, int n, int clr) {
  int i = basechannel + len - 1;
  int sign = n < 0;
  
  //clear
  for (int j=basechannel; j<basechannel+len; j++) {
    tty.buffer_out[5+j] = debug_entries[j] = make_vgaentry(' ', 0, 0);
  }
  
  n = sign ? -n : n;
  
  tty.buffer_out[5+i] = debug_entries[i] = make_vgaentry('h', clr, 0);
  i--;
  
  while (n > 0 && i >= basechannel) {
    unsigned char chr = hexline[(n % 16)];
    
    tty.buffer_out[5+i] = debug_entries[i] = make_vgaentry(chr, clr, 0);
    
    n /= 16;
    i--;
  }
  
  if (sign && i >= basechannel) {
    tty.buffer_out[5+i] = debug_entries[i] = make_vgaentry('-', clr, 0);
  }
}

void terminal_set_debug(unsigned int channel, unsigned int chr, unsigned int clr) {
  tty.buffer_out[5+channel] = debug_entries[channel] = make_vgaentry(chr, clr, 0);
}
