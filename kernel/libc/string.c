#include "string.h"

int atoi(const char *str) {
  unsigned char *c = (unsigned char*) str;
  
  int ret = 0;
  int isneg = 1;
  
  c += strspn(c, "\n\t\r \v\b");
  
  if (*c == '-') {
    c++;
    isneg = -1;
  } else if (*c == '+') {
    c++;
  }
  
  while (*c) {
    if (*c < '0' || *c > '9') {
      break;
    }
    
    int code = (*c) - '0';
    
    ret *= 10;
    ret += code;
    
    c++;
  }
  
  return isneg*ret;
}
