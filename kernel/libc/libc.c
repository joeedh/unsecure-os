#include <stddef.h>
#include <stdint.h>

size_t strlen(const unsigned char* str) {
  size_t i = 0;
  while (str[i]) {
    i++;
  }
  
  return i;
}

#ifndef __KERNEL_BUILD__

#define STUB(name) void name(){}

STUB(fprintf);
STUB(read);
STUB(write);
STUB(open);
STUB(opendir);
STUB(readdir);
STUB(closedir);

#endif
