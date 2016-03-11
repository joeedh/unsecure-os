#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#include "libk.h"
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#include "../drivers/tty/tty.h"

#include "string.h"

#define PUTCHAR(c) terminal_putchar(c)

int kprintf(char *args,...) {
  int written = 0;
  int c,  n, len = strlen(args);
  va_list vl;
  
  va_start(vl, args);
  
  for (int i=0; i<len; i++) {
    c = args[i], n = args[i==len-1 ? i : i+1];
    
    if (c == '%') {
      switch (n) {
        case '%':
          i++;
          written++;
          PUTCHAR('%');
          break;
        case 'c':
          PUTCHAR(c);
          i++;
          written++;
          break;
        case 'i':
        case 'd':
          written += kputint(va_arg(vl, int));
          i++;
          break;
        case 'b':
        case 'I':
        case 'D':
          written += kputuint(va_arg(vl, unsigned int));
          i++;
          break;
        case 'x':
          written += kputuhex(va_arg(vl, unsigned int));
          i++;
          break;
        case 'p': {
          void *p = va_arg(vl, void*);
          unsigned int f = (unsigned int)p;
          
          written += kputuhex(f);
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
  va_end(vl);
  
  return written;
}

