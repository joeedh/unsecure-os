#include "blockdevice.h"
#include "../../libc/libk.h"
#include "../../libc/kmalloc.h"
#include "../../io.h"
#include "../../task/lock.h"

//(void *self, size_t start, size_t size, void *buf);
size_t _kblockdevice_default_read(void *vself, size_t start, size_t size, void *vbuf) {
  unsigned char scratchbuf[4192]; //XXX heh another buffer overrun. . .haha!
  unsigned char *buf = vbuf;
  
  BlockDeviceIF *self = vself;
  size_t blocksize = self->blocksize(self);
  size_t totblock = self->disksize(self) / blocksize;
  
  //kprintf("read %d %d %d %x %d %d\n", start, size, blocksize, buf, totblock, self->disksize(self));
  //return 0;
  
  size_t block = start/blocksize;
  size_t i = start % blocksize;
  size_t read = 0;
  
  //kprintf("self->readblock: %x\n", self->readblock);
  self->readblock(self, block, scratchbuf);
  
  for (; read < size && block < totblock; i++, read++) {
    //kprintf("block: %d %d\n", block, totblock);
    //kprintf("i: %d, size: %d, read: %d, for-test: %d\n", i, size,  read,(int)(read < size && block < totblock));
    
    if (read > 0 && (i % blocksize) == 0) {
      block++;
      
      if (block >= totblock) {
        break;
      }
    
      size_t ret = self->readblock(self, block, scratchbuf);
      
      //kprintf("self->readblock: %x, ret: %d\n", self->readblock, ret);
      if (!ret) {
        break;
      }
      i = 0;
    }
    
    buf[read] = scratchbuf[i];
  }
  
  //kprintf("block: %d %d\n", block, totblock);
  //kprintf("i: %d, size: %d, read: %d, for-test: %d\n", i, size,  read, (int)(read < size && block < totblock));
  //kprintf("read: %d\n", read);
  
  return read;
}

#define MIN2(a, b) ((a) < (b) ? (a) : (b))
#define MAX2(a, b) ((a) > (b) ? (a) : (b))

size_t _kblockdevice_default_write(void *vself, size_t start, size_t size, void *buf) {
  BlockDeviceIF *self = vself;
  unsigned char scratch1[2048];//, scratch2[2048];
  
  size_t blocksize = self->blocksize(self);
  size_t i = 0, j = 0;
  size_t blocka = start / blocksize, blockb = (start + size) / blocksize;
  size_t totblock = blockb - blocka;
  
  for (i=0; i<=totblock; i++) {
    if (i == 0) {
      self->readblock(self, blocka, scratch1);
      int a = start % blocksize;
      int b = MIN2((blocksize - a), a + size);
      
      memcpy(scratch1+a, buf, b-a);
      j += b-a;
      
      self->writeblock(self, blocka, scratch1);
    } else if (i == totblock) {
      self->readblock(self, blocka+i, scratch1);
      
      int len = (start + size) % blocksize;
      memcpy(scratch1, buf+j, len);
      
      self->writeblock(self, blocka+i, scratch1);
      j += len;
    } else {
      self->writeblock(self, blocka+i, buf+j);
      j += blocksize;
    }
  }
  
  return j;
}

void _kblockdevice_init(void *vself) {
  BlockDeviceIF *self = vself;
  
  if (!self->read)
    self->read = _kblockdevice_default_read;
  if (!self->write)
    self->write = _kblockdevice_default_write;
}
