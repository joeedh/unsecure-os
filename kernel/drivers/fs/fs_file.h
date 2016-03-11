#ifndef _FS_FILE_H
#define _FS_FILE_H

#include "stddef.h"
#include "stdint.h"
#include "fs_interface.h"

typedef struct FSFile {
  struct FSFile *next, *prev;
  
  int inode;
  unsigned char *name;
  unsigned char *path;
  
  BlockDeviceIF *device;
  FSInterface *fs;
  
  int pid;
  int access;
  int error;
  int cursor;
  
  //internel file descriptor
  int internalfd;
} FSFile;

extern void filesystem_initialize();

#endif /* _FS_FILE_H */
