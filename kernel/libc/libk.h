#ifndef _LIBK_H
#define _LIBK_H

int kerror(int code, char *message);

int kputint(int n);
int kputuint(unsigned int n);
int kputuhex(unsigned int n);
short getchar_nowait();

void libk_initialize();

int kprintf(char *fmt,...);
int e9printf(char *fmt, ...);

#define klogf e9printf
//int klogf(char *fmt,...);

#endif /* _LIBK_H */
