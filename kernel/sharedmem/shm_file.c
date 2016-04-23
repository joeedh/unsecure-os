#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "../libc/stdio.h"
#include "../drivers/fs/unistd.h"
#include "../io.h"

#include "shm_file.h"

static int shmfile_lseek(void *vself, BlockDeviceIF *device, int file, int off, int whence) {
  SharedMemFS *self = vself;
  
  switch (whence) {
    case SEEK_SET:
      self->fptr = off;
      break;
    case SEEK_CUR:
      if (off > 0 && off >= (int)self->size - (int)self->fptr) {
        self->fptr = self->size;
      } else if (off < 0 && -off > (int)self->fptr) {
        self->fptr = 0;
      } else {
        self->fptr += off;
      }
      break;
    case SEEK_END:
      if (off < 0) {
        self->fptr = self->size;
      } else if (off >= (int)self->size) {
        self->fptr = 0;
      } else {
        self->fptr = self->size - off;
      }
      break;
  }
  
  return 0;
}

static int shmfile_rewind(void *vself, BlockDeviceIF *device, int file) {
  SharedMemFS *self = vself;
  self->fptr = 0;
  
  return 0;
}

static int shmfile_tell(void *vself, BlockDeviceIF *device, int file) {
  SharedMemFS *self = vself;
  return self->fptr;
}

static int shmfile_eof(void *vself, BlockDeviceIF *device, int file) {
  SharedMemFS *self = vself;
  
  return self->fptr >= self->size ? -1 : 0;
}

static int shmfile_flush(void *vself, BlockDeviceIF *device, int file) {
  //SharedMemFS *self = vself;
  //do nothing, for now
  return 0;
}

static int shm_pread(void *vself, BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff) {
  SharedMemFS *self = vself;
  
  unsigned char *b = (unsigned char*)self->mem;
  unsigned char *a = (unsigned char*) buf;
  int i=0;
  
  if (!self->mem) {
    return _fs_error(self, -1, "Shared memory was NULL");
  }
  
  b += fileoff;
  
  for (i=0; i<(int)bufsize; i++, a++, b++) {
    if (i + fileoff >= self->size) {
      break;
    }
    
    *a = *b;
  }
  
  return i;
}

int _shm_realloc(SharedMemFS *self, size_t size) {
  void *mem = kmalloc(size);
  
  if (self->mem) {
    memcpy(mem, self->mem, self->size < size ? self->size : size);
    kfree(self->mem);
  }
  
  self->mem = mem;
  self->size = size;
  
  return 0;
}

static int shm_pwrite(void *vself, BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff) {
  SharedMemFS *self = vself;
  
  unsigned char *b = (unsigned char*)self->mem;
  unsigned char *a = (unsigned char*) buf;
  int i=0;
  
  if (fileoff +  bufsize == 0) {
    return _fs_error(self, -1, "Tried to read zero bytes (nonsense!)");
  }
  
  if (fileoff + bufsize >= self->size) {
    _shm_realloc(self, (fileoff+bufsize)*2);
  }
  
  if (!self->mem) {
    return _fs_error(self, -1, "Shared memory was NULL");
  }
  
  b += fileoff;
  
  for (int i=0; i<(int)bufsize; i++, a++, b++) {
    if (i + fileoff >= self->size) {
      break;
    }
    
    *b = *a;
  }
  
  return i;
}

static void *shm_mmap(void *vself, BlockDeviceIF *device, void *addr, size_t length, int prot, int flags, int fd, int offset) {
  SharedMemFS *self = vself;
  
  return (unsigned char*)self->mem + offset;
}

static int shm_munmap(void *vself, BlockDeviceIF *device, void *addr, size_t length) {
  //SharedMemFS *self = vself;
  return 0;
}

static int shm_ftruncate(void *vself, BlockDeviceIF *device, int fd, size_t size) {
  SharedMemFS *self = vself;
  
  if (size > 0 && self->size != size) {
    return _shm_realloc(self, size);
  } else if (size == 0 && self->mem) {
    self->size = 0;
    
    kfree(self->mem);
    self->mem = NULL;
  }
  
  return 0;
}

FSInterface *make_shared_mem() {
  SharedMemFS *f = kmalloc(sizeof(SharedMemFS));
  
  memset(f, 0, sizeof(*f));
  
  f->head.eof = shmfile_eof;
  f->head.tell = shmfile_tell;
  f->head.lseek = shmfile_lseek;
  f->head.rewind = shmfile_rewind;
  f->head.flush = shmfile_flush;
  //f->head.chmod = shmfile_chmod;
  //f->head.chuser = shmfile_chuser;
  //f->head.chgroup = shmfile_chgroup;
  f->head.pread = shm_pread;
  f->head.pwrite = shm_pwrite;
  
  f->head.mmap = shm_mmap;
  f->head.munmap = shm_munmap;
  f->head.ftruncate = shm_ftruncate;
  
  return (FSInterface*) f;
}
