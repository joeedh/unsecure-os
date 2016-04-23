#ifndef _SHM_FILE_H
#define _SHM_FILE_H

#include "stddef.h"
#include "stdint.h"

#include "../task/rwlock.h"

#include "shm.h"
#include "../drivers/fs/fs_interface.h"
#include "../drivers/fs/fs_file.h"

typedef struct SharedMemFS {
  FSInterface head;
  char *mem;
  size_t size, fptr;
  
  RWLock lock;
  int users;
  unsigned char name[512];
} SharedMemFS;

FSInterface *make_shared_mem();

#endif /* _SHM_FILE_H */
