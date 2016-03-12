#ifndef _FS_FILE_H
#define _FS_FILE_H

#include "stddef.h"
#include "stdint.h"
#include "fs_interface.h"
#include "../../task/lock.h"

#define PIPE_SIZE (1024*512)

typedef struct FSFile {
  struct FSFile *next, *prev;
  
  int inode;
  unsigned char *name;
  unsigned char *path;
  Lock lock;
  
  BlockDeviceIF *device;
  FSInterface *fs;
  
  int pid, access, error, cursor, mode;
  int pipe_rcursor; //pipe read cursor
  
  intptr_t custom, magic;
  
  //internel file descriptor
  intptr_t internalfd;
} FSFile;

#define _FILE_MAGIC 235433413

void _fs_file_init(FSFile *file);

extern void filesystem_initialize();

int read(int fd, void *buf, unsigned int bytes);
int write(int fd, void *buf, unsigned int bytes);
int flush(int fd);
int pipe(int fds[2]);

#endif /* _FS_FILE_H */
