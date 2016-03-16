#include "path.h"
#include "string.h"
#include "libk.h"

static unsigned int my_strhas(int ch, unsigned char *str) {
  while (*str) {
    if (*str == ch)
      return 1;
    str++;
  }
  
  return 0;
}

static unsigned char *my_strtrim(const unsigned char *str, unsigned char *trimchars) {
  char *c = (unsigned char*) str;
  
  while (*c && my_strhas(*c, trimchars)) {
    c++;
  }
  
  int end = strlen(c)-1;
  
  while (end >= 0 && my_strhas(c[end], trimchars)) {
    end--;
  }
  
  if (!my_strhas(c[end], trimchars)) {
    end++;
  }
  
  c[end] = 0;
  return c;
}

int normpath(unsigned char *path) {
  return 0;
/*
  if (!path) {
    return -1;
  }
  
  unsigned char *start = my_strtrim(path, " \t\n\r\v/");
  
  if (start != path) {
    strcpy(path, start);
  }
  
  int c=0;
  int len = strlen(path), had_space;
  unsigned char buf[256];
  unsigned char *out = buf;
  
  for (int i=0; i<len; i++) {
    c = path[i];
    had_space = 0;
    
    while(my_strhas(c, " \n\r\t/")) {
      had_space = 1;
      i++;
    }
    
    if (had_space) {
      i--;
    }
    
    *out++ = c;
  }
  
  *out = 0;
  buf[255] = 0;
  
  if (buf[0] != '/') {
    strcpy(path+1, buf);
    path[0] = '/';
    
    if (!buf[0]) {
      path[1] = 0;
    }
  } else {
    strcpy(path, buf);
  }
  
  return 0;
*/
}

