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

#include "dirent.h"

static List open_files;

int bad_fsdev(FSInterface *fs, BlockDeviceIF *device) {
  return fs->magic != FSINTERFACE_MAGIC || device->magic != BLOCKDEVICE_MAGIC;
}

void filesystem_initialize() {
  memset(&open_files, 0, sizeof(open_files));
}

void _fs_fsinterface_init(FSInterface *fs) {
  klock_init(&fs->lock);
  fs->magic = FSINTERFACE_MAGIC;
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
  
  return bad_fsdev(file->fs, file->device);
}

int read(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd))
    return 0;
  
  FSFile *file = (FSFile*) fd;
  klock_lock(&file->lock);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->fs, file->device) & O_RDONLY)) {
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
  
  ret = file->fs->pread(file->fs, file->device, file->internalfd, buf, bytes, *cursor);
  *cursor += ret;
  
  //kprintf("cursorr: %d, ret: %d\n", *cursor, ret);
  
  if (file->mode & O_PIPE_MODE) {
    stat sdata;
    
    file->fs->stat(file->fs, file->device, (int)file, &sdata, NULL);
    unsigned int size = sdata.st_msize;
    
    *cursor = *cursor % size;
  }
  
  klock_unlock(&file->lock);
  return ret;
}

int write(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd))
    return -1;
  
  FSFile *file = (FSFile*) fd;

  klock_lock(&file->lock);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->fs, file->device) & O_RDONLY)) {
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    klock_unlock(&file->lock);
    return -1;
  }
  
  if (!file->fs->pread) {
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    klock_unlock(&file->lock);
    return -1;
  }
  
  int ret, *cursor = !((file->mode & O_PIPE_MODE) && reverse) ? &file->pipe_rcursor : &file->cursor;
  
  ret = file->fs->pwrite(file->fs, file->device, file->internalfd, buf, bytes, *cursor);
  *cursor += ret;
  
  //kprintf("cursorw: %d, ret: %d\n", *cursor, ret);
  
  if (file->mode & O_PIPE_MODE) {
    stat sdata;
    
    file->fs->stat(file->fs, file->device, (int)file, &sdata, NULL);
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
    return -1;
  
  FSFile *file = (FSFile*) fd;

  klock_lock(&file->lock);
  file->fs->flush(file->fs, file->device, file->internalfd);
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

extern FSInterface *rootfs;
extern BlockDeviceIF *rootdevice;

//static struct {struct dirent item, DIR dir} dirs[32];
//unsigned int curdir = 0;

DIR *opendir(const unsigned char *path) {
  BlockDeviceIF *device = rootdevice;
  FSInterface *fs = rootfs;
  
  if (bad_fsdev(fs, device)) {
    kprintf("File system driver corruption!\n");
    return NULL;
  }
  
  if (!path)
    return NULL;

  klock_lock(&rootdevice->lock);
  klock_lock(&rootfs->lock);
  
  int inode = fs->path_to_inode(fs, device, path, strlen(path));
  if (inode < 0) {
    klock_unlock(&rootfs->lock);
    klock_unlock(&rootdevice->lock);
    return NULL;
  }
  
  DIR *ret = opendir_inode(inode);
  
  klock_unlock(&rootfs->lock);
  klock_unlock(&rootdevice->lock);
  
  return ret;
}

DIR *opendir_inode(int inode) {
  BlockDeviceIF *device = rootdevice;
  FSInterface *fs = rootfs;
  
  if (bad_fsdev(fs, device)) {
    kprintf("File system driver corruption!\n");
    return NULL;
  }
  
  klock_lock(&fs->lock);
  klock_lock(&device->lock);
  
  DIR *dir2 = NULL;
  
  uintptr_t addr = (uintptr_t) kmalloc(sizeof(DIR) + sizeof(dirent));
  addr += sizeof(dirent);
  dir2 = (DIR*)addr;

  memset(dir2, 0, sizeof(dir2));
  
  int ret = fs->opendir_inode(fs, device, dir2, inode);
  
  if (ret == 0) {
  }
  
  klock_unlock(&device->lock);
  klock_unlock(&fs->lock);
  
  return dir2;
}

int closedir(DIR *dir) {
  if (bad_fsdev(rootfs, rootdevice)) {
    kprintf("File system driver corruption!\n");
    return -1;
  }
  
  klock_lock(&rootfs->lock);
  klock_lock(&rootdevice->lock);
  
  uintptr_t addr = (uintptr_t) dir;
  addr -= sizeof(dirent);
  
  kfree((void*)addr);

  klock_unlock(&rootdevice->lock);
  klock_unlock(&rootfs->lock);
  
  return 0;
}

struct dirent *readdir(DIR *dir) {
  if (bad_fsdev(rootfs, rootdevice)) {
    kprintf("File system driver corruption!\n");
    return NULL;
  }
  
  if (!dir) {
    kprintf("DIR WAS NULL!\n");
    return NULL;
  }
  
  struct dirent *entry = (struct dirent*) dir;
  entry--;
 
  BlockDeviceIF *device = rootdevice;
  FSInterface *fs = rootfs;
  
  klock_lock(&device->lock);
  klock_lock(&fs->lock);
  
  memset(entry, 0, sizeof(*entry));
  int ret = fs->readdir(fs, device, entry, dir);
  
  klock_unlock(&fs->lock);
  klock_unlock(&device->lock);
  
  if (ret != 0) {
    //kprintf("RET: %d\n", ret);
    return NULL;
  } else {
    return entry;
  }
}

void rewinddir(DIR *dir) {
  if (bad_fsdev(rootfs, rootdevice)) {
    kprintf("File system driver corruption!\n");
    return;
  }
}

