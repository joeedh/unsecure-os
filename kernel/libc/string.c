#include "string.h"

#ifndef __KERNEL_BUILD__
#include "stdlib.h"

char *strdup(const char *str) {
  int len = strlen(str);
  char *ret = malloc(len+1);
  
  strcpy(ret, str);
  ret[len] = 0;
  
  return ret;
}
#endif

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

void libc_initialize() {
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
