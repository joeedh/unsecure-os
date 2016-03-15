#ifndef _BLOCKDEVICE_H
#define _BLOCKDEVICE_H

#include "stddef.h"
#include "stdint.h"
#include "../../task/lock.h"

#define BLOCKDEVICE_MAGIC 239458355

typedef struct BlockDeviceIF {
  unsigned int magic;
  
  size_t (*blocksize   )(void *self);
  size_t (*disksize    )(void *self);
  size_t (*readblock   )(void *self, size_t block, void *buf);
  size_t (*writeblock  )(void *self, size_t block, void *buf);
  
  //read/write will be provided by _kblockdevice_init if they do not
  //exist when it is called by device drivers
  size_t (*read        )(void *self, size_t start, size_t size, void *buf);
  size_t (*write       )(void *self, size_t start, size_t size, void *buf);
  size_t (*flush       )(void *self);
  size_t (*close_device)(void *self);
  
  Lock lock;
} BlockDeviceIF;

//any unset fields must be memset prior to calling _kblockdevice_init
void _kblockdevice_init(void *self);

#endif /* _BLOCKDEVICE_H */
