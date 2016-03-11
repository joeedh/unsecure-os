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

volatile unsigned int k_debug;

size_t strlen(const unsigned char* str) {
	size_t ret = 0;
	while ( str[ret] != 0 )
		ret++;
	return ret;
}

int kputint(int n) {
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
    terminal_putchar(buf[--i]);
  }
  
  return 0;
}

int kputuint(unsigned int n) {
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
    terminal_putchar(buf[--i]);
  }
  
  return 0;
}

static unsigned char hexline[] = "0123456789abcdef";

int kputuhex(unsigned int n) {
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
  
  terminal_putchar('0');
  terminal_putchar('x');
  
  while (i > 0) {
    terminal_putchar(buf[--i]);
  }
  
  return i+2;
}

unsigned char uppermap[255];
unsigned char lowermap[255];

int toupper(int c) {
  c = c & 255;
  
  return uppermap[c];
}

int tolower(int c) {
  c = c & 255;
  
  return lowermap[c];
}

int isupper(int c) {
  c = c & 255;
  
  return c == uppermap[c];
}

int islower(int c) {
  c = c & 255;
  
  return c == lowermap[c];
}

int isprint(int c) {
  return c > 0x1f && c != 0x7f;
}

void libk_initialize() {
  k_debug = 0;
  
  for (int i=0; i<255; i++) {
    uppermap[i] = lowermap[i] = i;
  }
  
  for (int i='a'; i <= 'z'; i++) {
    uppermap[i] = i - 'a' + 'A';
  }
  
  uppermap['`'] = '~';
  uppermap['1'] = '!';
  uppermap['2'] = '@';
  uppermap['3'] = '#';
  uppermap['4'] = '$';
  uppermap['5'] = '%';
  uppermap['6'] = '^';
  uppermap['7'] = '&';
  uppermap['8'] = '*';
  uppermap['9'] = '(';
  uppermap['0'] = ')';
  
  uppermap['-'] = '_';
  uppermap['='] = '+';
  uppermap['['] = '{';
  uppermap[']'] = '}';
  
  uppermap[';'] = ':';
  uppermap['\''] = '"';
  uppermap[','] = '<';
  uppermap['.'] = '>';
  uppermap['/'] = '?';
  uppermap['\\'] = '|';
  
  for (int i=0; i<255; i++) {
    lowermap[uppermap[i]] = i;
  }
}

int kerror(int code, char *message) {
  terminal_clear();
  
  int ret=0;
  
  ret += kprintf("===========================================================\n");
  ret += kprintf("KERNEL ERROR:%d: %s\n", code, message);
  ret += kprintf("===========================================================\n");
  
  return ret;
}
