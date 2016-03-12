#include "stddef.h"
#include "stdint.h"

#include "memfile.h"

#include "fs_file.h"
#include "fs_interface.h"
#include "../tty/tty.h"
#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../libc/list.h"
#include "../../libc/kmalloc.h"
#include "../../libc/stdio.h"
#include "../../io.h"
#include "../../task/task.h"
#include "../../task/lock.h"
#include "../../timer.h"


static List open_files;

void filesystem_initialize() {
  open_files.first = open_files.last = NULL;
}

static void _set_error(int err, const char *message) {
}

void _fs_file_init(FSFile *file) {
  memset(file, 0, sizeof(*file));
  
  klock_init(&file->lock);
  file->magic = _FILE_MAGIC;
}

int _valid_file(int fd) {
  FSFile *file = (FSFile*)fd;
  
  if (!file)
    return 0;
  
  if (file->magic != _FILE_MAGIC)
    return 0;
  
  return 1;
}
int read(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd))
    return 0;
  
  FSFile *file = (FSFile*) fd;
  
  klock_lock(&file->lock);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->device) & O_RDONLY)) {
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    klock_unlock(&file->lock);
    return 0;
  }
  
  if (!file->fs->pread) {
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    klock_unlock(&file->lock);
    return 0;
  }
  
  int ret, *cursor = ((file->mode & O_PIPE_MODE) && reverse) ? &file->pipe_rcursor : &file->cursor;
  
  ret = file->fs->pread(file->device, file->internalfd, buf, bytes, *cursor);
  *cursor += ret;
  
  //kprintf("cursorr: %d, ret: %d\n", *cursor, ret);
  
  if (file->mode & O_PIPE_MODE) {
    stat sdata;
    
    file->fs->stat(file->device, (int)file, &sdata);
    unsigned int size = sdata.st_msize;
    
    *cursor = *cursor % size;
  }
  
  klock_unlock(&file->lock);
  return ret;
}

int write(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd))
    return 0;
  
  FSFile *file = (FSFile*) fd;

  klock_lock(&file->lock);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->device) & O_RDONLY)) {
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    klock_unlock(&file->lock);
    return 0;
  }
  
  if (!file->fs->pread) {
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    klock_unlock(&file->lock);
    return 0;
  }
  
  int ret, *cursor = !((file->mode & O_PIPE_MODE) && reverse) ? &file->pipe_rcursor : &file->cursor;
  
  ret = file->fs->pwrite(file->device, file->internalfd, buf, bytes, *cursor);
  *cursor += ret;
  
  //kprintf("cursorw: %d, ret: %d\n", *cursor, ret);
  
  if (file->mode & O_PIPE_MODE) {
    stat sdata;
    
    file->fs->stat(file->device, (int)file, &sdata);
    unsigned int size = sdata.st_msize;
    
    if (*cursor != (int)size) {
      *cursor = *cursor % size;
    }
  }
  
  klock_unlock(&file->lock);
  return ret;
}

int flush(int fd) {
  if (!_valid_file(fd))
    return 0;
  
  FSFile *file = (FSFile*) fd;

  klock_lock(&file->lock);
  file->fs->flush(file->device, file->internalfd);
  klock_unlock(&file->lock);
  
  return 0;
}

int pipe(int fds[2]) {
  FSFile *file = (FSFile*) kmemfile_create(PIPE_SIZE);
  file->mode |= O_PIPE_MODE;
  
  file->pipe_rcursor = 0;
  
  FSFile *file2 = kmalloc(sizeof(FSFile));
  *file2 = *file;
  file2->mode |= _O_REVERSE;
  
  fds[0] = (int)file;
  fds[1] = (int)file2;
  
  return 0;
}
