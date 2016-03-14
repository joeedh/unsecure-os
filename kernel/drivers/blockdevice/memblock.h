#ifndef _MEMBLOCK_H
#define _MEMBLOCK_H

#include "blockdevice.h"

typedef struct MemBlockDevice {
  BlockDeviceIF head;
  unsigned char *data;
  unsigned int blocksize;
  unsigned int totblocks;
} MemBlockDevice;

BlockDeviceIF *kmemblock_new(int blocksize, int blockcount);
  
#endif /* _MEMBLOCK_H */
