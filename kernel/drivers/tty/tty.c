#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif
 
/* This tutorial will only work for the 32-bit ix86 targets. */
#if !defined(__i386__)
#error "This tutorial needs to be compiled with a ix86-elf compiler"
#endif
 
#include "../../libc/string.h"
#include "../../io.h"
#include "tty.h"
#include "../../task/lock.h"
#include "../../task/critical_section.h"


static Lock tty_lock = LOCK_INIT;
//static CriticalSection tty_lock = {0,};

#define XY2IDX(x, y) ((((y) + terminal_row_off) % VGA_HEIGHT)*VGA_WIDTH + (x));
 
uint8_t make_color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

uint16_t make_vgaentry(unsigned char c, uint8_t color) {
	uint16_t c16 = c;
	uint16_t color16 = color;

	return c16 | (color16 << 8);
}
 
static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
 
volatile size_t terminal_row, terminal_row_off;
volatile size_t terminal_column;
volatile uint8_t terminal_color;
uint16_t * volatile terminal_buffer_out;
extern uint16_t * volatile terminal_buffer;

static volatile unsigned int tty_cache_len = 0;
static volatile unsigned int debug_entries[32] = {0,};
static volatile unsigned int debug_backup[32] = {0,};

void terminal_buffer_flip() {
  //unsigned int state = safe_entry();
  
  int ilen = (int)(sizeof(debug_entries) / sizeof(int));
  for (int i=0; i<ilen; i++) {
    int i2 = VGA_WIDTH*((terminal_row_off) % VGA_HEIGHT) + i + 5;
    
    debug_backup[i] = terminal_buffer[i2];
    terminal_buffer[i2] = debug_entries[i];
  }
  
  if (terminal_row_off == 0) {
    smemcpy(terminal_buffer_out, terminal_buffer, VGA_WIDTH*VGA_HEIGHT);
  } else {
    uint16_t *a = terminal_buffer + terminal_row_off*VGA_WIDTH;
    uint16_t *b = terminal_buffer;
    
    
    smemcpy(terminal_buffer_out, a, VGA_WIDTH*(VGA_HEIGHT-terminal_row_off));
    smemcpy(terminal_buffer_out +
            VGA_WIDTH*(VGA_HEIGHT-terminal_row_off), b, VGA_WIDTH*terminal_row_off);
  }
  
  for (int i=0; i<ilen; i++) {
    int i2 = VGA_WIDTH*((terminal_row_off) % VGA_HEIGHT) + i + 5;
    
    debug_backup[i] = terminal_buffer[i2];
    terminal_buffer[i2] = debug_backup[i];
  }
  
  //safe_exit(state);
}

void terminal_flush() {
  klock_lock(&tty_lock);
  
  terminal_buffer_flip();
  
  klock_unlock(&tty_lock);
}

static unsigned char hexline[] = "0123456789ABCDEF";

void terminal_set_idebug(int basechannel, int len, int n, int clr) {
  int i = basechannel + len - 1;
  int sign = n < 0;
  
  //clear
  for (int j=basechannel; j<basechannel+len; j++) {
    terminal_buffer_out[5+j] = debug_entries[j] = make_vgaentry(' ', 0);
  }
  
  n = sign ? -n : n;
  
  terminal_buffer_out[5+i] = debug_entries[i] = make_vgaentry('h', clr);
  i--;
  
  while (n > 0 && i >= basechannel) {
    unsigned char chr = hexline[(n % 16)];
    
    terminal_buffer_out[5+i] = debug_entries[i] = make_vgaentry(chr, clr);
    
    n /= 16;
    i--;
  }
  
  if (sign && i >= basechannel) {
    terminal_buffer_out[5+i] = debug_entries[i] = make_vgaentry('-', clr);
  }
}

void terminal_set_debug(unsigned int channel, unsigned int chr, unsigned int clr) {
  terminal_buffer_out[5+channel] = debug_entries[channel] = make_vgaentry(chr, clr);
}

void terminal_initialize() {
	terminal_row = terminal_row_off = 0;
	terminal_column = 0;
	terminal_color = make_color(COLOR_DEFAULT, COLOR_BLACK);
	terminal_buffer_out = (uint16_t*) 0xB8000;
  
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = make_vgaentry(' ', terminal_color);
      terminal_buffer_out[index] = make_vgaentry(' ', terminal_color);
		}
	}
  
  klock_init(&tty_lock);
}

void terminal_clear() {
  klock_lock(&tty_lock);
  
  memset(terminal_buffer, 0, VGA_WIDTH*VGA_HEIGHT*2);
  terminal_row = terminal_column = 0;
  terminal_buffer_flip();
  
  klock_unlock(&tty_lock);
}
 
void terminal_setcolor(uint8_t color) {
	terminal_color = color;
}
 
void terminal_putentryat(unsigned char c, uint8_t color, size_t x, size_t y) {
	const size_t index = XY2IDX(x, y);
	terminal_buffer[index] = make_vgaentry(c, color);
}

void terminal_rowpush() {
  //klock_lock(&tty_lock);
  
  //smemcpy(terminal_buffer, terminal_buffer+VGA_WIDTH, VGA_WIDTH*(VGA_HEIGHT-1));
  
  terminal_row_off = (terminal_row_off + 1) % VGA_HEIGHT;

  unsigned int row2zero = (terminal_row_off + VGA_HEIGHT - 1) % VGA_HEIGHT;
  smemset(terminal_buffer+row2zero*VGA_WIDTH, 0, VGA_WIDTH);
  
  //terminal_buffer_flip();

  //klock_unlock(&tty_lock);
}

void terminal_putchar(unsigned char c) {
  klock_lock(&tty_lock);
  //volatile unsigned int state = safe_entry();
  
  tty_cache_len++;
  
  if (c == '\t') {
    klock_unlock(&tty_lock);

    terminal_putchar(' ');
    terminal_putchar(' ');
    return;
  }
  
  if (tty_cache_len > 50) {
    tty_cache_len = 0;
    terminal_buffer_flip();
  }
  
  if (c == '\n') {
    terminal_column = 0;
    if (++terminal_row == VGA_HEIGHT) {
      terminal_rowpush();
      terminal_row--;
    } else {
      //terminal_buffer_flip();
    }
  } else if (c == '\r') {
    /*
    size_t index = terminal_row * VGA_WIDTH + terminal_column;
    
    while (index > (size_t)0 && (terminal_buffer[index]&0xFF) != '\r' && (terminal_buffer[index] &0xFF) != '\n') 
    {
      terminal_buffer[index] = 0;
      index--;
    }

    index += 2;
    */
    for (size_t j=0; j<terminal_column; j++) {
      size_t index = XY2IDX(j, terminal_row);
      terminal_buffer[index] = 0;
    }
    
    terminal_column = 0;
  } else {
    terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
    
    if (++terminal_column == VGA_WIDTH) {
      terminal_column = 0;
      if (++terminal_row == VGA_HEIGHT) {
        terminal_rowpush();
        terminal_row--;
      }
    }
  }
  
  klock_unlock(&tty_lock);
  //safe_exit(state);
}
 
void terminal_writestring(const unsigned char* data) {
	size_t datalen = strlen(data);
  
	for (size_t i = 0; i < datalen; i++)
		terminal_putchar(data[i]);
}

int terminal_get_cursor() {
  return 0;
}

int terminal_set_cursor(int x, int y) {
  size_t index = XY2IDX(x, y);
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

int terminal_reset_cursor() {
  terminal_set_cursor(terminal_column, terminal_row);
  return 0;
}

//#define XY2IDX(x, y) ((((y) + terminal_row_off) % VGA_HEIGHT)*VGA_WIDTH + (x));

int terminal_move_cursor(int delta) {
  //deliberately not using xy2idx here
  int idx = terminal_row*VGA_WIDTH + terminal_column + delta;
  while (idx < 0) {
    idx += VGA_WIDTH*VGA_HEIGHT;
  }
  
  idx = idx % (VGA_WIDTH*VGA_HEIGHT);
  
  int x = idx % VGA_WIDTH;
  int y = idx / VGA_WIDTH;
  
  terminal_row = (size_t) y;
  terminal_column = (size_t) x;
  
  terminal_reset_cursor();
  
  /*
  while (delta > 0) {
    int aoff = delta < 0 ? -delta : delta;
    
    terminal_column += delta;
    
    if (terminal_column < 0) {
      delta += VGA_WIDTH;
      terminal_column = VGA_WIDTH-1;
    } else if (terminal_column >= VGA_WIDTH) {
      delta -= VGA_WIDTH;
      terminal_column = 0;
    } else {
      break;
    }
  }*/
  
  return 0;
}
