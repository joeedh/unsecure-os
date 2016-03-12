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
  int size;
} MemFile;

static int kpipefile_pread(BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
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

static int kpipefile_pwrite(BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
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

static int kpipefile_close(BlockDeviceIF *device, int file) {
  return 0;
}

static int kpipefile_flush(BlockDeviceIF *device, int file) {
  return 0;
}

static int kpipefile_accessmode(BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

FSInterface kpipefile_iface;

int kpipefile_create(int size) {
  memset(&kpipefile_iface, 0, sizeof(kpipefile_iface));
  
  kpipefile_iface.flush = kpipefile_flush;
  kpipefile_iface.pread = kpipefile_pread;
  kpipefile_iface.pwrite = kpipefile_pwrite;
  kpipefile_iface.close = kpipefile_close;
  kpipefile_iface.accessmode = kpipefile_accessmode;
  
  FSFile *file = kmalloc(sizeof(FSFile));
  
  file->name = "TTY";
  file->path = "/dev/console";
  file->pid = 0;
  file->access = O_RDWR|O_SEARCH;
  
  file->device = NULL;
  file->fs = &kpipefile_iface;
  file->inode = 0;
  file->custom = size;
  
  MemFile *data = kmalloc(size + sizeof(MemFile));
  data->size = size;
  
  file->internalfd = (int)(data + 1);
  
  return (int)file;
}

void kpipefile_file_close(FSFile *file) {
  
}
