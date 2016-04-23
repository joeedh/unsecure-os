#ifndef _STDIO_H
#define _STDIO_H

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#define SEEK_SET  1
#define SEEK_CUR  2
#define SEEK_END  3

typedef struct FILE {
  int fd;
} FILE;

#ifndef __KERNEL_BUILD__
extern FILE *stdout, *stderr, *stdin;
#endif

#ifndef __KERNEL_BUILD__
int printf(char *fmt, ...);
#endif

int vfprintf(FILE *arg, char *args, va_list vl);

#ifndef E9PRINTF_DEFINED
#define E9PRINTF_DEFINED
int e9printf(char *fmt, ...);
#endif

int fprintf(FILE *file, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int fflush(FILE *file);

FILE *fopen(char *path, char *mode);
int fclose(FILE *file);

int fread(void *ptr, size_t size, size_t count, FILE *file);
int fwrite(void *ptr, size_t size, size_t count, FILE *file);
int fgetc(FILE *file);
int fputc(int ch, FILE *file);

FILE *popen(const char *command, const char *mode);

#define EOF (-1)

#endif /* _STDIO_H */
