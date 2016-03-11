#ifndef _TTY_H
#define _TTY_H

#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>

void terminal_initialize();
void terminal_setcolor(uint8_t color);
void terminal_putentryat(unsigned char c, uint8_t color, size_t x, size_t y);
void terminal_rowpush();
void terminal_putchar(unsigned char c);
void terminal_writestring(const unsigned char* data);
void terminal_clear();
void terminal_flush();

int terminal_get_cursor();
int terminal_set_cursor(int row, int column);

#endif /* _TTY_H */