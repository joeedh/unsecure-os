#include "path.h"
#include "string.h"
#include "libk.h"

//modifies/splits line
int shlex(char *line, char *outbuf[MAX_ARGV]) {
  int n=0, argc=0;
  
  while ((n = strcspn(line, " \t\n\r\""))) {
    outbuf[argc++] = line;
    
    line[n] = 0;
    line += n+1;
  }
  
  if (*line)
    *line = 0;
  
  outbuf[argc++] = 0;
  
  return argc;
}

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

int normpath(unsigned char *path, size_t buffersize) {
  unsigned char buf[255];
  
  //strcpy(buf, strtrim(path));
  strcpy(buf, path);
  
  buf[254] = 0;
  
  int len = strlen(buf);
  int j = 0;
  
  for (int i=0; i<len; i++) {
    unsigned char c = buf[i];
    unsigned char n = buf[(i < len-1 ? i+1 : i)];
    unsigned int found = 0;
    
    path[j++] = c;
    
    while (i < len-1 && c == n && my_strhas(c, " \t\r\n\v/")) {
      c = buf[i], n = buf[i+1];
      found = 1;
      i++;
    }
    
    if (found)
      i--;
  }
  
  path[j] = 0;
  len = j, j = 0;
  
  strcpy(buf, strtrim(path));
  strcpy(path, buf);
  len = strlen(path);

  unsigned char *path2 = path;
  
  j = 0;
  while (path2[0] == '/' && path2[1] == '/') {
    path2++;
  }
  
  if (path2[0] != '/') {
    buf[j++] = '/';
  }
  
  for (int i=0; i<len; i++) {
    if (i > 0 && i == len-1 && path2[i] == '/') {
      break;
    }
    buf[j++] = path2[i];
  }
  buf[j] = 0;
  
  strcpy(path, strtrim(buf));
  
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

