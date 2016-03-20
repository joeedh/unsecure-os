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

#define PRINTF int vsprintf(unsigned char **arg, char *args, va_list vl)
#define PUTCHAR(c) myfputchar(arg, c)
#define KPRINTNUMARG arg

#include "vprintf.h"

int sprintf(char *out, char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  unsigned char *ptr = (unsigned char*) out;
  
  int ret = vsprintf(&ptr, fmt, vl);
  va_end(vl);
  
  return ret;
}
