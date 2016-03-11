#ifndef _BLOCKDEVICE_H
#define _BLOCKDEVICE_H

typedef struct BlockDeviceIF {
  size_t (*blocksize   )(void *self);
  size_t (*disksize    )(void *self);
  size_t (*read        )(void *self, size_t start, size_t size, void *buf);
  size_t (*write       )(void *self, size_t start, size_t size, void *buf);
  void   (*flush       )(void *self);
  void   (*close_device)(void *self);
} BlockDeviceIF;

#endif /* _BLOCKDEVICE_H */
