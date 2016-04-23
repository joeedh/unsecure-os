//for printing via Boch's i/o port e9 hack

#include "stdint.h"
#include "string.h"
#include "libk.h"
#include "../io.h"
#include "../interrupts.h"
#include <stdarg.h>

#define COLOR_HANDLER
#define PRINTF int vs_e9printf(const unsigned char *args, va_list vl)
#define PUTCHAR(ch) outb(0xE9, ch)
#define KPRINTNUMARG NULL

//#define DISABLE_E9PRINTF

#ifdef DISABLE_E9PRINTF
int vs_e9printf(const unsigned char *args, va_list vl) {
  return 0;
}
int e9printf(char *fmt, ...) {
  return 0;
}
#else
 
#include "vprintf.h"

int e9printf(char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  int ret = vs_e9printf(fmt, vl);
  va_end(vl);
  
  return ret;
}
#endif
