#include "stdio.h"
#include "../drivers/fs/fs_file.h"
#include <stdarg.h>

int fprintf(FILE *file, char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  int ret = vfprintf(file, fmt, vl);
  va_end(vl);
  
  return ret;
}
