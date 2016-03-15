#ifndef _MEMBLOCK_H
#define _MEMBLOCK_H

#include "blockdevice.h"

typedef struct MemBlockDevice {
  BlockDeviceIF head;
  unsigned char *data;
  unsigned int blocksize;
  unsigned int totblocks;
  unsigned int shouldfree;
} MemBlockDevice;

BlockDeviceIF *kmemblock_new(int blocksize, int blockcount, void *existing);
  
#endif /* _MEMBLOCK_H */
