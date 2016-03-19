#if 0
#include <stddef.h>
#include <stdint.h>

#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "../libc/stdio.h"

#include "disasm.h"

static unsigned char *null_string = "";

//strdup
static inline unsigned char *mystrdup(unsigned char *buf) {
  size_t len = strlen(buf);
  if (len == 0) {
    return null_string;
  }
  
  unsigned char *ret = kmalloc(len+1);
  strcpy(ret, buf);
  
  return buf;
}

static int getint(char *string) {
  int ret = 0;
  unsigned char *c = &ret;
  
  c[0] = string[0];
  c[1] = string[1];
  c[2] = string[2];
  c[3] = string[3];
  
  return ret;
}
/*
#define C0(code, name) case code: return name
#define C1i(code, name):\
  case code:\
    sprintf(buf, #name " %x:%x", code, getint(asm+1));\
    return mystrdup(buf);
*/  
#endif
