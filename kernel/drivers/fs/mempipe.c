#include "../tty/tty.h"

#include "../../libc/kmalloc.h"
#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../io.h"
#include "../../task/task.h"
#include "../../timer.h"

#include "../fs/fs_interface.h"
#include "../fs/fs_file.h"

//size of memory file is stored in fsfile->custom

typedef struct MemFile {
  FSInterface head;
  int size, used, ptr, pad;
} MemFile;

static int kpipefile_pread(void *self, BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  int count = 0;
  int size = file->size;
  
  kprintf("system read\n");
  
  if (fileoff >= (unsigned int)size) 
    return 0;
  
  unsigned char *a = (unsigned char*)(file + 1);
  unsigned char *b = (unsigned char*)buf;
  
  count = (int)fileoff - (int)bufsize < 0 ? (int)fileoff : (int)bufsize;
  
  if (fileoff == 0) //no space left to write
    return 0;
    
  a += fileoff - count;
  for (int i=0; i<count; i++, a++, b++) {
    *b = *a;
  }
  
  return count;
}

static int kpipefile_pwrite(void *self, BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  int count = 0;
  int size = file->size;
  
  kprintf("system write\n");
  
  if (fileoff >= (unsigned int)size) {
    return 0;
  }
  
  unsigned char *a = (unsigned char*)(file + 1);
  unsigned char *b = (unsigned char*)buf;
  
  count = (int)fileoff + (int)bufsize > size ? (int)fileoff - (int)bufsize : (int)bufsize;
  if (count < 0) //no space left to write
    return 0;
    
  a += fileoff;
  for (int i=0; i<count; i++, a++, b++) {
    *a = *b;
  }
  
  return count;
}

static int kpipefile_close(void *self, BlockDeviceIF *device, int file) {
  return 0;
}

static int kpipefile_flush(void *self, BlockDeviceIF *device, int file) {
  return 0;
}

static int kpipefile_accessmode(void *self, BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

static int fpipefile_poll(void *self, BlockDeviceIF *device, int fd, struct pollfd *pfd, int timeout_ms) {
 return 0; 
}

int kpipefile_create(int size) {
  FSInterface *fs = kmalloc(sizeof(*fs));
  
  memset(fs, 0, sizeof(*fs));
  _fs_fsinterface_init(fs);
  
  fs->flush = kpipefile_flush;
  fs->pread = kpipefile_pread;
  fs->pwrite = kpipefile_pwrite;
  fs->close = kpipefile_close;
  fs->accessmode = kpipefile_accessmode;
  fs->poll = fpipefile_poll;
  
  FSFile *file = kmalloc(sizeof(FSFile));
  
  file->name = "TTY";
  file->path = "/dev/console";
  file->pid = 0;
  file->access = O_RDWR|O_SEARCH;
  
  file->device = NULL;
  file->fs = fs;
  file->inode = 0;
  file->custom = size;
  
  MemFile *data = kmalloc(size + sizeof(MemFile));
  data->size = size;
  
  file->internalfd = (int)(data + 1);
  
  return (int)file;
}

void kpipefile_file_close(FSFile *file) {
  
}
