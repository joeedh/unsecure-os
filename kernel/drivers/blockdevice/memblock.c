#include "memblock.h"
#include "../../libc/kmalloc.h"
#include "../../libc/string.h"
#include "../../libc/libk.h"

static size_t blocksize(void *vself) {
  MemBlockDevice *self = vself;
  return self->blocksize;
}

static size_t disksize(void *vself) {
  MemBlockDevice *self = vself;
  return self->blocksize*self->totblocks;
}

static size_t readblock(void *vself, size_t block, void *buf) {
  MemBlockDevice *self = vself;
  
  //kprintf("  read block %d %x %x %d\n", block, buf, self->data, self->blocksize);
  
  if (block >= self->totblocks)
    return 0;
  
  memcpy(buf, self->data + block*self->blocksize, self->blocksize);
  
  return self->blocksize;
}

static size_t writeblock(void *vself, size_t block, void *buf) {
  MemBlockDevice *self = vself;
  
  if (block >= self->totblocks)
    return 0;
  
  memcpy(self->data + block*self->blocksize, buf, self->blocksize);
  
  return self->blocksize;
}

static size_t flush(void *vself) {
  return 0;
}

static size_t close_device(void *vself) {
  MemBlockDevice *self = vself;
  
  kfree(self->data);
  kfree(self);
  
  return 0;
}

BlockDeviceIF *kmemblock_new(int blcksize, int blockcount, void *existing) {
  MemBlockDevice *dev = kmalloc(sizeof(MemBlockDevice));
  
  memset(dev, 0, sizeof(*dev));

  dev->blocksize = blcksize;
  dev->totblocks = blockcount;
  
  if (existing) {
    dev->shouldfree = 0;
    dev->data = existing;
  } else {
    dev->data = kmalloc(blcksize*blockcount);
    dev->shouldfree = 1;
  }
  
  _kblockdevice_init(dev);
  
  dev->head.blocksize = blocksize;
  dev->head.disksize = disksize;
  dev->head.readblock = readblock;
  dev->head.writeblock = writeblock;
  dev->head.flush = flush;
  dev->head.close_device = close_device;
  
  klock_init(&dev->head.lock);
  
  return (BlockDeviceIF *) dev;
}

/*
typedef struct BlockDeviceIF {
  size_t (*blocksize   )(void *self);
  size_t (*disksize    )(void *self);
  size_t (*readblock   )(void *self, size_t block, void *buf);
  size_t (*writeblock  )(void *self, size_t block, void *buf);
  
  //read/write will be provided by _kblockdevice_init if they do not
  //exist when it is called by device drivers
  size_t (*read        )(void *self, size_t start, size_t size, void *buf);
  size_t (*write       )(void *self, size_t start, size_t size, void *buf);
  void   (*flush       )(void *self);
  void   (*close_device)(void *self);
} BlockDeviceIF;
*/