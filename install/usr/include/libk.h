#ifndef _LIBK_H
#define _LIBK_H

#include <stdarg.h>

int kerror(int code, char *message);

int kputint(int n);
int kputuint(unsigned int n);
int kputuhex(unsigned int n);
short getchar_nowait();

void libc_initialize();

int kprintf(char *fmt,...);

#ifndef E9PRINTF_DEFINED
#define E9PRINTF_DEFINED
int e9printf(char *fmt, ...);
#endif

int vs_e9printf(const unsigned char *args, va_list vl);

#define klogf e9printf
//int klogf(char *fmt,...);

#endif /* _LIBK_H */
