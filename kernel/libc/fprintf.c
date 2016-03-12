#include "stdio.h"
#include "../drivers/fs/fs_file.h"

static int myfputchar(FILE *file, unsigned char c) {
  unsigned char buf[32];
  buf[0] = c;
  
  int ret = write(file->fd, buf, 1);
  
  if (ret && (c == '\r' || c == '\n')) {
    flush(file->fd);
  }
  
  return ret;
}

//int write(int fd, void *buf, unsigned int bytes) {


#define PRINTF int fprintf(FILE *arg, char *args,...)
#define PUTCHAR(c) myfputchar(arg, c)
#define KPRINTNUMARG arg

#include "printf.c"
