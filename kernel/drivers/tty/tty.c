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

//static Lock tty_lock;

#define XY2IDX(x, y) ((((y) + terminal_row_off) % VGA_HEIGHT)*VGA_WIDTH + (x));

/* Hardware text mode color constants. */
enum vga_color {
	COLOR_BLACK = 0,
	COLOR_BLUE = 1,
	COLOR_GREEN = 2,
	COLOR_CYAN = 3,
	COLOR_RED = 4,
	COLOR_MAGENTA = 5,
	COLOR_BROWN = 6,
	COLOR_LIGHT_GREY = 7,
	COLOR_DARK_GREY = 8,
	COLOR_LIGHT_BLUE = 9,
	COLOR_LIGHT_GREEN = 10,
	COLOR_LIGHT_CYAN = 11,
	COLOR_LIGHT_RED = 12,
	COLOR_LIGHT_MAGENTA = 13,
	COLOR_LIGHT_BROWN = 14,
	COLOR_WHITE = 15,
};
 
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
 
size_t terminal_row, terminal_row_off;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer_out;
extern uint16_t* terminal_buffer;
volatile unsigned int tty_cache_len = 0;

void terminal_buffer_flip() {
  //klock_lock(&tty_lock);
  unsigned int state = safe_entry();
  
  if (terminal_row_off == 0) {
    smemcpy(terminal_buffer_out, terminal_buffer, VGA_WIDTH*VGA_HEIGHT);
  } else {
    uint16_t *a = terminal_buffer + terminal_row_off*VGA_WIDTH;
    uint16_t *b = terminal_buffer;
    
    
    smemcpy(terminal_buffer_out, a, VGA_WIDTH*(VGA_HEIGHT-terminal_row_off));
    smemcpy(terminal_buffer_out +
            VGA_WIDTH*(VGA_HEIGHT-terminal_row_off), b, VGA_WIDTH*terminal_row_off);
  }
  
  safe_exit(state);
  
  //klock_unlock(&tty_lock);
}

void terminal_flush() {
  terminal_buffer_flip();
}

void terminal_initialize() {
	terminal_row = terminal_row_off = 0;
	terminal_column = 0;
	terminal_color = make_color(COLOR_LIGHT_GREY, COLOR_BLACK);
	terminal_buffer_out = (uint16_t*) 0xB8000;
  
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = make_vgaentry(' ', terminal_color);
      terminal_buffer_out[index] = make_vgaentry(' ', terminal_color);
		}
	}
  
  //klock_init(&tty_lock);
}

void terminal_clear() {
  //klock_lock(&tty_lock);
  
  memset(terminal_buffer, 0, VGA_WIDTH*VGA_HEIGHT*2);
  terminal_row = terminal_column = 0;
  //terminal_buffer_flip();
  
  //klock_unlock(&tty_lock);
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
  volatile unsigned int state = safe_entry();
  //klock_lock(&tty_lock);
  
  tty_cache_len++;
  
  if (c == '\t') {
    terminal_putchar(' ');
    terminal_putchar(' ');
    
    safe_exit(state);
    //klock_unlock(&tty_lock);
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
  
  //klock_unlock(&tty_lock);
  safe_exit(state);
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
