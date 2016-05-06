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
  int simple_pipemode, pad;
} MemFile;

static int kmemfile_eof(void *vself, BlockDeviceIF *device, int filefd, size_t off) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  return off >= (size_t)file->written;
}

static int kmemfile_pread(void *self, BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
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
  
  if (file->simple_pipemode) {
    b = (unsigned char*)buf;
    
    //shift
    for (int j=i; j<file->written; j++) {
      b[j-i] = b[j]; 
    }
      
    file->written -= i;
  }
  
  if (file->written < 0) {
    //error!
    e9printf("ERROR in memory_file.c: file->written was less than zero! it was: %d\n", file->written);
    //hrm. . .return an error code?
    
    file->written = 0;
  }
  
  return i;
}

static int kmemfile_pwrite(void *self, BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  int size = file->size;
  
  //kprintf("system write: %d %d, written: %d\n", fileoff, bufsize, file->written);
  
  if (fileoff > (unsigned int)size || (fileoff+bufsize) >= (unsigned int)file->size)
    return 0;
  
  unsigned char *a = (unsigned char*)(file + 1);
  unsigned char *b = (unsigned char*)buf;
  
  size_t i=0;
  
  while (fileoff < (unsigned int)size && i < (unsigned int)bufsize) {
    a[fileoff] = b[i];
    
    fileoff++;
    i++;
  }
  
  if ((unsigned int)file->written < (unsigned int)fileoff)
    file->written = (int)fileoff;
  
  return i;
}

static int kmemfile_close(void *self, BlockDeviceIF *device, int file) {
  return 0;
}

static int kmemfile_flush(void *self, BlockDeviceIF *device, int file) {
  return 0;
}

static int kmemfile_accessmode(void *self, BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

static int kmemfile_fstat(void *self, BlockDeviceIF *device, int filefd, struct stat *buf) {
  if (buf == NULL)
    return -1;
  
  memset(buf, 0, sizeof(*buf));

  MemFile *file = (MemFile*)filefd;
  file--;
  
  buf->st_size = file->size; //(file->mode & O_PIPE_MODE) ? file->size : file->written;
  
  return 0;
}

static int kmemfile_setmode(void *vself, BlockDeviceIF *device, int filefd, int mode) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  if (mode == O_NOSEEK)
    file->simple_pipemode = 1;
  
  return 0;
}

static int kmemfile_clearmode(void *vself, BlockDeviceIF *device, int filefd, int mode) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  if (mode == O_NOSEEK)
    file->simple_pipemode = 0;
  
  return 0;
}

int kmemfile_create(int size, int added_flags) {
  FSInterface *fs = kmalloc(sizeof(*fs));
  
  memset(fs, 0, sizeof(*fs));
  _fs_fsinterface_init(fs);

  fs->flush = kmemfile_flush;
  fs->pread = kmemfile_pread;
  fs->pwrite = kmemfile_pwrite;
  fs->close = kmemfile_close;
  fs->accessmode = kmemfile_accessmode;
  fs->fstat = kmemfile_fstat;
  fs->eof = kmemfile_eof;
  fs->setmode = kmemfile_setmode;
  fs->clearmode = kmemfile_clearmode;
  
  //fs->mode |= added_flags;
  
  FSFile *file = kmalloc(sizeof(FSFile));
 
  _fs_file_init(file);
  
  file->name = "TTY";
  file->path = "/dev/console";
  file->pid = 0;
  file->access = O_RDWR|O_SEARCH;
  
  file->device = NULL;
  file->fs = fs;
  file->inode = 0;
  file->custom = size;
  
  MemFile *data = kmalloc(size + sizeof(MemFile));
  memset(data, 0, sizeof(*data));
  
  data->size = size;
  data->written = 0;
  
  file->internalfd = (int)(data + 1);
  
  return (int)file;
}

void kmemfile_file_close(FSFile *file) {
  
}
