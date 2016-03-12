#include "stdint.h"
#include "stddef.h"

#include "stdio.h"
#include "../drivers/fs/fs_file.h"

int fread(void *ptr, size_t size, size_t count, FILE *file) {
  int ret = 0;
  unsigned char *c = ptr;
  
  for (size_t i=0; i<count; i++) {
    int bsread = (int)read(file->fd, c, size);
    
    c += bsread;
    ret += bsread;
  }
  
  return ret;
}

int fwrite(void *ptr, size_t size, size_t count, FILE *file) {
  int ret = 0;
  unsigned char *c = ptr;
  
  for (size_t i=0; i<count; i++) {
    int bswrote = (int)write(file->fd, c, size);
    
    c += bswrote;
    ret += bswrote;
  }
  
  return ret;
}

int fgetc(FILE *file) {
  char buf[4];
  int read = fread(buf, 1, 1, file);
  
  if (read) {
    return buf[0];
  } else {
    return EOF;
  }
}

int fputc(int ch, FILE *file) {
  char buf[4];
  buf[0] = ch;
  
  int written = fwrite(buf, 1, 1, file);
  
  return written ? 0 : EOF;
}
