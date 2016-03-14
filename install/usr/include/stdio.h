#ifndef _STDIO_H
#define _STDIO_H

#include <stddef.h>
#include <stdint.h>

typedef struct FILE {
  int fd;
} FILE;

#ifndef __KERNEL_BUILD__
extern FILE *stdout, *stderr, *stdin;
#endif

int fprintf(FILE *file, char *fmt, ...);
int fread(void *ptr, size_t size, size_t count, FILE *file);
int fwrite(void *ptr, size_t size, size_t count, FILE *file);
int fgetc(FILE *file);
int fputc(int ch, FILE *file);

#define EOF (-1)

#endif /* _STDIO_H */
