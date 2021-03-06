#include "stdint.h"
#include "stddef.h"

#define SKIP_DEF_TASK_YIELD
#include "stdlib.h"
#include "stdio.h"

#include "../drivers/fs/fs_file.h"

#ifndef __KERNEL_BUILD__
  #define pmalloc _pmalloc
  #define pfree _pfree
  #define prealloc _prealloc
#endif

extern void *pmalloc(size_t size);
extern void pfree(void *ptr);
extern void *prealloc(void *ptr, size_t size);

#ifndef malloc
#define malloc(size) _malloc(size, __FILE__, __LINE__)
#endif
void *_malloc(size_t size, char *file, int line) {
  return pmalloc(size);
}

#ifndef free
#define free(ptr) _free(ptr, __FILE__, __LINE__)
#endif
void _free(void *ptr, char *file, int line) {
  if (!ptr)
    return;
  
  pfree(ptr);
}

#ifndef realloc
#define realloc(ptr) _realloc(ptr, __FILE__, __LINE__)
#endif
void *_realloc(void *ptr, size_t size, char *file, int line) {
  return prealloc(ptr, size);
}

size_t ftell(FILE *file) {
  return (size_t) tell(file->fd);
}

int fseek(FILE *file, size_t off, int whence) {
  return lseek(file->fd, off, whence);
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

int feof(FILE *file) {
  return peof(file->fd);
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

int fflush(FILE *file) {
  if (!file) {
    return -1;
  }
  
  return flush(file->fd);
}

#ifndef __KERNEL_BUILD__
int printf(char *fmt, ...) {
  va_list vl;
  
  va_start(vl, fmt);
  int ret = vfprintf(stdout, fmt, vl);
  va_end(vl);
  
  return ret;
}
#endif
