/*
a simple printf template based on C macros.

supports:
  %x    : hex integer
  %d/%i : decimal integer
  %s    : string
  %^    : change font color (see enumeration in drivers/tty/tty.h)
*/

#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#include "libk.h"

#ifndef COLOR_HANDLER
#define COLOR_HANDLER terminal_setcolor(va_arg(vl, unsigned int));
#else
#define COLOR_HANDLER
#endif

/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#include "../drivers/tty/tty.h"

#include "string.h"

#ifndef PUTCHAR
#define PUTCHAR(c) terminal_putchar(c)
#endif

#ifndef PRINTF
#define PRINTF int kprintf(char *args,...)
#endif

#ifndef KPRINTNUMARG 
#define KPRINTNUMARG NULL
#endif

static unsigned char hexline[] = "0123456789abcdef";

static int mykputuhex(void *arg, unsigned int n) {
  static unsigned char buf[32];
  int i = 0, n2 = n;
  
  if (n2 == 0) {
    buf[i++] = '0';
  }
  
  if (n2 < 0)
    n2 = -n2;
  
  while (n2 > 0) {
    unsigned char ch = (n2 % 16);
    
    buf[i++] = hexline[ch];
    n2 /= 16;
  }
  
  PUTCHAR('0');
  PUTCHAR('x');
  
  while (i > 0) {
    i--;
    PUTCHAR(buf[i]);
  }
  
  return i+2;
}

static int mykputint(void *arg, int n) {
  static unsigned char buf[32];
  int i = 0, n2 = n;
  
  if (n2 == 0) {
    buf[i++] = '0';
  }
  
  if (n2 < 0)
    n2 = -n2;
  
  while (n2 > 0) {
    unsigned char ch = (n2 % 10) + 48;
    
    buf[i++] = ch;
    n2 /= 10;
  }
  
  if (n < 0) {
    buf[i++] = '-';
  }
  
  while (i > 0) {
    i--;
    PUTCHAR(buf[i]);
  }
  
  return 0;
}

static int mykputuint(void *arg, unsigned int n) {
  static unsigned char buf[32];
  int i = 0, n2 = n;
  
  if (n2 == 0) {
    buf[i++] = '0';
  }
  
  if (n2 < 0)
    n2 = -n2;
  
  while (n2 > 0) {
    unsigned char ch = (n2 % 10) + 48;
    
    buf[i++] = ch;
    n2 /= 10;
  }
  
  while (i > 0) {
    i--;
    PUTCHAR(buf[--i]);
  }
  
  return 0;
}

PRINTF {
  int written = 0;
  int c,  n, len = strlen(args);
  
  for (int i=0; i<len; i++) {
    c = args[i], n = args[i==len-1 ? i : i+1];
    
    if (c == '%') {
      switch (n) {
        case '%':
          i++;
          written++;
          PUTCHAR('%');
          break;
        case '^':
          COLOR_HANDLER
          i++;
          break;
        case 'c':
          PUTCHAR(va_arg(vl, int));
          i++;
          written++;
          break;
        case 'i':
        case 'd':
          written += mykputint(KPRINTNUMARG, va_arg(vl, int));
          i++;
          break;
        case 'b':
        case 'I':
        case 'D':
          written += mykputuint(KPRINTNUMARG, va_arg(vl, unsigned int));
          i++;
          break;
        case 'x':
          written += mykputuhex(KPRINTNUMARG, va_arg(vl, unsigned int));
          i++;
          break;
        case 'p': {
          void *p = va_arg(vl, void*);
          unsigned int f = (unsigned int)p;
          
          written += mykputuhex(KPRINTNUMARG, f);
          i++;
          break;
        }
        case 's': {
          char *ptr = va_arg(vl, char *);
          int len = strlen(ptr);
          
          for (int j=0; j<len; j++) {
            PUTCHAR(ptr[j]);
            written++;
          }
          
          i++;
          break;
        }
        case 'f':
          PUTCHAR('u'); written++;
          PUTCHAR('n'); written++;
          PUTCHAR('s'); written++;
          PUTCHAR('u'); written++;
          PUTCHAR('p'); written++;
          PUTCHAR('p'); written++;
          PUTCHAR('o'); written++;
          PUTCHAR('r'); written++;
          PUTCHAR('t'); written++;
          PUTCHAR('e'); written++;
          PUTCHAR('d'); written++;
          break;
      }
    } else {
      PUTCHAR(c);
      written++;
    }
    //p = c;
  }
 
  return written;
}
