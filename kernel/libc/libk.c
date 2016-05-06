#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#include "libk.h"
#include "../io.h"

/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#include "../drivers/tty/tty.h"

volatile unsigned int k_debug = 0;

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

int kerror(int code, char *message) {
  interrupts_disable();
  
  //terminal_clear();
  
  int ret=0;
  
  ret += kprintf("===========================================================\n");
  ret += kprintf("KERNEL ERROR:%d: %s\n", code, message);
  //ret += kprintf("===========================================================\n");
  
  //freeze
  while (1) {
  }
  
  return ret;
}
