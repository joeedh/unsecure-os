#ifndef _TTY_H
#define _TTY_H

#include <stdint.h>
#include <stddef.h>

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

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

#ifdef __cplusplus
extern "C" {
#endif

uint8_t make_color(enum vga_color fg, enum vga_color bg);
uint16_t make_vgaentry(unsigned char c, uint8_t color);

void terminal_initialize();
void _set_buffer(unsigned short *buffer);
void terminal_flush();
void terminal_putchar(unsigned char ch);
void terminal_scroll(int delta);
void terminal_resetscroll();

#ifdef __cplusplus
}
#endif
#endif /* _TTY_H */
