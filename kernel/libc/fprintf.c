#include "stdio.h"
#include "../drivers/fs/fs_file.h"
#include <stdarg.h>

static int myfputchar(FILE *file, unsigned char c) {
  unsigned char buf[32];
  buf[0] = c;
  
  int ret = write(file->fd, buf, 1);
  
  if (ret && (c == '\r' || c == '\n')) {
    flush(file->fd);
  }
  
  return ret;
}

//int write(int fd, void *buf, unsigned int bytes) {

#define PRINTF int vfprintf(FILE *arg, char *args, va_list vl)
#define PUTCHAR(c) myfputchar(arg, c)
#define COLOR_HANDLER
#define KPRINTNUMARG arg

#include "vprintf.h"

int fprintf(FILE *file, char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  int ret = vfprintf(file, fmt, vl);
  va_end(vl);
  
  return ret;
}
