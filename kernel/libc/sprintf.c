#include "stdio.h"

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#include "../drivers/fs/fs_file.h"

#define COLOR_HANDLER

static int myfputchar(unsigned char **arg, unsigned char c) {
  **arg = c;
  (*arg)++;
  **arg = 0;
  
  return 1;
}

#define PRINTF int _vsprintf1(unsigned char **arg, char *args, va_list vl)
#define PUTCHAR(c) myfputchar(arg, c)
#define KPRINTNUMARG arg

#include "vprintf.h"

int vsprintf(char *out, char *fmt, va_list vl) {
  unsigned char *ptr = (unsigned char*) out;
  
  return _vsprintf1(&ptr, fmt, vl);
}

int sprintf(char *out, char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  int ret = vsprintf(out, fmt, vl);
  va_end(vl);
  
  return ret;
}
