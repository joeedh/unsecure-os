#ifndef _TTY_H
#define _TTY_H

#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>

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
  COLOR_DEFAULT=COLOR_LIGHT_GREY
};

#define TTY_BUFFER_ROWS 900

void terminal_initialize();
void terminal_setcolor(uint8_t color);
void terminal_putchar(unsigned char c);
void terminal_writestring(const unsigned char* data);
void terminal_clear();
void terminal_flush();

int terminal_move_cursor(int delta);

//resets hardware cursor to internal x/y cursor
int terminal_reset_hcursor();
int terminal_get_hcursor();
int terminal_set_hcursor(int x, int y);
void terminal_resetscroll();

int terminal_scroll(int delta);

#define DEBUG_KEY  5
void terminal_set_debug(unsigned int channel, unsigned int chr, unsigned int clr);

//outputs in hex
void terminal_set_idebug(int basechannel, int len, int i, int clr);

#endif /* _TTY_H */