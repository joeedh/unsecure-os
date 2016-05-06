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
  int a, b, size;
} MemFile;

static int kmempipe_eof(void *vself, BlockDeviceIF *device, int filefd, size_t off) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  return file->b == file->a;
}

static int kmempipe_pread(void *self, BlockDeviceIF *device, int filefd, const char *_buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  //e9printf("read: a,b: %d, %d\n", file->a, file->b);
  
  char *rbuf = (char*)filefd;
  char *buf = (char*)_buf;
  
  int size = file->size;
  int c = file->a, i;
  
  for (i=0; c != file->b && i<(int)bufsize; i++) {
    buf[i] = rbuf[c];
    c = (c + 1) % size;
  }
  
  file->a = c;
  return i;
}

static int kmempipe_pwrite(void *self, BlockDeviceIF *device, int filefd, const char *buf, size_t bufsize, size_t fileoff) {
  MemFile *file = (MemFile*)filefd;
  file--;

  char *rbuf = (char*)filefd;
  int size = file->size;
  
  int c = file->b, i;
  
  for (i=0; c != file->a-1 && i<(int)bufsize; i++) {
    rbuf[c] = buf[i];
    c = (c + 1) % size;
  }
  
  file->b = c;
  
  //e9printf("a,b: %d, %d, bufsize: %d\n", file->a, file->b, bufsize);
  return i;
}

static int kmempipe_close(void *self, BlockDeviceIF *device, int filefd) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  e9printf("close pipe\n");
  
  kfree(file);
  return 0;
}

static int kmempipe_flush(void *self, BlockDeviceIF *device, int file) {
  return 0;
}

static int kmempipe_accessmode(void *self, BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

static int kmempipe_fstat(void *self, BlockDeviceIF *device, int filefd, struct stat *buf) {
  if (buf == NULL)
    return -1;
  
  memset(buf, 0, sizeof(*buf));

  MemFile *file = (MemFile*)filefd;
  file--;
  
  if (file->b > file->a) {
    buf->st_size = file->b - file->a;
  } else {
    buf->st_size = file->b + (file->size - file->a);
  }
  
  return 0;
}

static int kmempipe_setmode(void *vself, BlockDeviceIF *device, int filefd, int mode) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  return 0;
}

static int kmempipe_clearmode(void *vself, BlockDeviceIF *device, int filefd, int mode) {
  MemFile *file = (MemFile*)filefd;
  file--;
  
  return 0;
}

int kmempipe_create(int size, int added_flags) {
  FSInterface *fs = kmalloc(sizeof(*fs));
  
  memset(fs, 0, sizeof(*fs));
  _fs_fsinterface_init(fs);

  fs->flush = kmempipe_flush;
  fs->pread = kmempipe_pread;
  fs->pwrite = kmempipe_pwrite;
  fs->close = kmempipe_close;
  fs->accessmode = kmempipe_accessmode;
  fs->fstat = kmempipe_fstat;
  fs->eof = kmempipe_eof;
  fs->setmode = kmempipe_setmode;
  fs->clearmode = kmempipe_clearmode;
  
  //fs->mode |= added_flags;
  
  FSFile *file = kmalloc(sizeof(FSFile));
 
  _fs_file_init(file);
  
  file->name = "pipe";
  file->path = "pipe";
  file->pid = 0;
  file->access = O_RDWR|O_SEARCH;
  
  file->device = NULL;
  file->fs = fs;
  file->inode = 0;
  file->custom = size;
  
  MemFile *data = kmalloc(size + sizeof(MemFile));
  memset(data, 0, sizeof(*data));
  
  data->size = size;
  data->a = data->b = 0;
  
  file->internalfd = (int)(data + 1);
  
  return (int)file;
}
