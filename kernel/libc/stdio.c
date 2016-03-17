#include "stdint.h"
#include "stddef.h"

#include "stdio.h"
#include "../drivers/fs/fs_file.h"
#include "kmalloc.h"

void *_malloc(size_t size, char *file, int line) {
  return _kmalloc(size, file, line);
}

void _free(void *ptr, char *file, int line) {
  _kfree(ptr, file, line);
}

FILE *fopen(char *path, char *mode) {
  if (!path || !mode)
    return NULL;
  
  int modeflags = 0;
  unsigned char *c = (unsigned char*) mode;
  
  while (*c) {
    if (*c == 'w' && !(modeflags & O_APPEND)) {
      modeflags |= O_WRONLY|O_TRUNC;
    }  else if (*c == '+') {
      modeflags &= ~O_TRUNC;
      modeflags |= O_WRONLY|O_RDONLY;
    } else if (*c == 'b') { //let's just ignore the stupid text-vs-binary mode
      c++;
      continue;
    } else if (*c == 'a') {
      modeflags |= O_WRONLY|O_APPEND;
    } else if (*c == 'r') {
      modeflags |= O_RDONLY;
    }
    
    c++;
  }
  
  if (modeflags == 0) {
    return NULL;
  }
  
  int fd = open(path, modeflags);
  
  if (fd < 0) {
    return NULL;
  }
  
  FILE *file = malloc(sizeof(FILE));
  memset(file, 0, sizeof(FILE));
  
  file->fd = fd;
  return file;
}

int fclose(FILE *file) {
  if (!file)
    return -1;
  
  int ret = close(file->fd);
  free(file);
  
  return ret;
}

int fread(void *ptr, size_t size, size_t count, FILE *file) {
  int ret = 0;
  unsigned char *c = ptr;
  
  for (size_t i=0; i<count; i++) {
    int bsread = read(file->fd, c, size);
    
    if (bsread < 0) {
      return -1;
    }
    
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
