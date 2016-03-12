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
  int written;
} MemFile;

static int kmemfile_pread(BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  int size = file->written;
  
  //kprintf("system read: %d %d, written: %d\n", fileoff, bufsize, file->written);
  
  if (fileoff >= (unsigned int)size) 
    return 0;
  
  unsigned char *a = (unsigned char*)(file + 1);
  unsigned char *b = (unsigned char*)buf;
  
  size_t i=0;
  
  while (fileoff < (unsigned int)size && i < (unsigned int)bufsize) {
    b[i] = a[fileoff];
    
    fileoff++;
    i++;
  }
  
  return i;
}

static int kmemfile_pwrite(BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  int size = file->size;
  
  //kprintf("system write: %d %d, written: %d\n", fileoff, bufsize, file->written);
  
  if (fileoff > (unsigned int)size || (fileoff+bufsize) >= (unsigned int)file->size)
    return 0;
  
  if ((unsigned int)file->written < (unsigned int)fileoff + (unsigned int)bufsize)
    file->written = (int)(fileoff + bufsize);
  
  unsigned char *a = (unsigned char*)(file + 1);
  unsigned char *b = (unsigned char*)buf;
  
  size_t i=0;
  
  while (fileoff < (unsigned int)size && i < (unsigned int)bufsize) {
    a[fileoff] = b[i];
    
    fileoff++;
    i++;
  }
  
  return i;
}

static int kmemfile_close(BlockDeviceIF *device, int file) {
  return 0;
}

static int kmemfile_flush(BlockDeviceIF *device, int file) {
  return 0;
}

static int kmemfile_accessmode(BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

static int kmemfile_fstat(BlockDeviceIF *device, int filefd, struct stat *buf) {
  if (buf == NULL)
    return -1;
  
  memset(buf, 0, sizeof(*buf));

  MemFile *file = (MemFile*)filefd;
  file--;
  
  buf->st_msize = file->size; //(file->mode & O_PIPE_MODE) ? file->size : file->written;
  
  return 0;
}

FSInterface kmemfile_iface;

int kmemfile_create(int size) {
  memset(&kmemfile_iface, 0, sizeof(kmemfile_iface));
  
  kmemfile_iface.flush = kmemfile_flush;
  kmemfile_iface.pread = kmemfile_pread;
  kmemfile_iface.pwrite = kmemfile_pwrite;
  kmemfile_iface.close = kmemfile_close;
  kmemfile_iface.accessmode = kmemfile_accessmode;
  kmemfile_iface.fstat = kmemfile_fstat;
  
  FSFile *file = kmalloc(sizeof(FSFile));
 
  _fs_file_init(file);
  
  file->name = "TTY";
  file->path = "/dev/console";
  file->pid = 0;
  file->access = O_RDWR|O_SEARCH;
  
  file->device = NULL;
  file->fs = &kmemfile_iface;
  file->inode = 0;
  file->custom = size;
  
  MemFile *data = kmalloc(size + sizeof(MemFile));
  data->size = size;
  data->written = 0;
  
  file->internalfd = (int)(data + 1);
  
  return (int)file;
}

void kmemfile_file_close(FSFile *file) {
  
}
