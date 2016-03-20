#ifndef _STDIO_H
#define _STDIO_H

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

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

void *_malloc(size_t size, char *file, int line);
void _free(void *ptr, char *file, int line);

#define malloc(size) _malloc(size, __FILE__, __LINE__)
#define free(ptr) _free(ptr, __FILE__, __LINE__)

#define EOF (-1)

#endif /* _STDIO_H */
