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
#include "../../libc/path.h"

#include "dirent.h"

extern FSInterface *rootfs;
extern BlockDeviceIF *rootdevice;

static List open_files;

int bad_fsdev(FSInterface *fs, BlockDeviceIF *device) {
  return !fs || fs->magic != FSINTERFACE_MAGIC || (device && device->magic != BLOCKDEVICE_MAGIC);
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

void _fs_error(void *fsinterface, int code, unsigned char *error) {
  FSInterface *fs = fsinterface;

  fs->lasterror = code;
  strncpy(fs->lasterror_message, error, sizeof(fs->lasterror_message)-1);
}

void _fs_file_init(FSFile *file) {
  memset(file, 0, sizeof(*file));
  
  klock_init(&file->lock);
  file->magic = _FILE_MAGIC;
  file->closed = 0;
}

int _valid_file(int fd) {
  FSFile *file = (FSFile*)fd;
  
  if (!file)
    return 0;
  
  if (file->magic != _FILE_MAGIC)
    return 0;
  
  if (file->closed)
    return 0;
  
  return !bad_fsdev(file->fs, file->device);
}

static void _lock_file(FSFile *file) {
  klock_lock(&file->lock);
  klock_lock(&file->fs->lock);
  
  if (file->device) {
    klock_lock(&file->device->lock);
  }
}

static void _unlock_file(FSFile *file) {
  if (file->device) {
    klock_unlock(&file->device->lock);
  }
  
  klock_unlock(&file->fs->lock);
  klock_unlock(&file->lock);
}

int read(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd)) {
    klogf("Invalid file %x\n", fd);
    return -1;
  }
  
  FSFile *file = (FSFile*) fd;
  _lock_file(file);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->fs, file->device) & O_RDONLY)) {
    klogf("Permission error: %d\n", file->access);
    
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    _unlock_file(file);
    return -1;
  }
  
  if (!file->fs->pread) {
    klogf("Read not supported by filesystem: %x\n", file->fs->pread);
    
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    _unlock_file(file);
    return -1;
  }
  
  int ret, *cursor = ((file->mode & O_PIPE_MODE) && reverse) ? &file->pipe_rcursor : &file->cursor;
  
  ret = file->fs->pread(file->fs, file->device, file->internalfd, buf, bytes, *cursor);
  
  if (ret < 0) {
    _unlock_file(file);
    
    file->fs->lasterror_message[sizeof(file->fs->lasterror_message)-1] = 0;
    strncpy(file->errmsg, file->fs->lasterror_message, sizeof(file->errmsg)-1);
    file->errno = file->fs->lasterror;
    
    klogf("Read error:%d: %s\n", file->fs->lasterror, file->fs->lasterror_message);
    return -1;
  }
  
  *cursor += ret;
  
  //klogf("cursorr: %d, ret: %d\n", *cursor, ret);
  
  if (file->mode & O_PIPE_MODE) {
    stat sdata;
    
    file->fs->stat(file->fs, file->device, (int)file, &sdata, NULL);
    unsigned int size = sdata.st_msize;
    
    *cursor = *cursor % size;
  }
  
  _unlock_file(file);
  
  return ret;
}

int write(int fd, void *buf, unsigned int bytes) {
  if (!_valid_file(fd))
    return -1;
  
  FSFile *file = (FSFile*) fd;

  _lock_file(file);
  
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->fs, file->device) & O_RDONLY)) {
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    
    _unlock_file(file);
    return -1;
  }
  
  if (!file->fs->pread) {
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    
    _unlock_file(file);
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
  
  _unlock_file(file);
    
  return ret;
}

int flush(int fd) {
  if (!_valid_file(fd))
    return -1;
  
  FSFile *file = (FSFile*) fd;

  _lock_file(file);
  file->fs->flush(file->fs, file->device, file->internalfd);
  _unlock_file(file);
  
  return 0;
}

int pipe(int fds[2]) {
  FSFile *file = (FSFile*) kmemfile_create(PIPE_SIZE);
  file->mode |= O_PIPE_MODE;
  
  file->pipe_rcursor = 0;
  file->closed = 0;
  
  FSFile *file2 = kmalloc(sizeof(FSFile));
  *file2 = *file;
  file2->mode |= _O_REVERSE;
  
  fds[0] = (int)file;
  fds[1] = (int)file2;
  
  return 0;
}


int tell(int fd) {
  FSFile *file = (FSFile*)fd;
  
  if (!_valid_file(fd))
    return -1;
  
  _lock_file(file);
  int ret = file->fs->tell(file->fs, file->device, file->internalhd);
  _unlock_file(file);
  
  return ret;
}

int fstat(int fd, struct stat *out) {
  FSFile *file = (FSFile*)fd;
  
  if (!out)
    return -1;
  if (!_valid_file(fd))
    return -1;
  
  _lock_file(file);
  int ret = file->fs->fstat(file->fs, file->device, file->internalhd, out);
  _unlock_file(file);
  
  return ret;
}

int open(const unsigned char *path, int modeflags) {
  unsigned char path2[MAX_PATH];
  strcpy(path2, path);
  normpath(path2, sizeof(path2));
  
  FSFile *file = kmalloc(sizeof(FSFile));
  
  memset(file, 0, sizeof(*file));
  _fs_file_init(file);
  
  file->fs = rootfs;
  file->device = rootdevice;
  file->access = modeflags;
  
  file->internalfd = file->fs->open(file->fs, file->device, path2, strlen(path2), modeflags);
  
  if (file->internalfd < 0) {
    kfree(file);
    return -1;
  }
  
  return (int)file;
}

int close(int fd) {
  FSFile *file = (FSFile*)fd;
  
  if (!_valid_file(fd))
    return -1;
  
  file->closed = 1;

  _lock_file(file);
  file->fs->close(file->fs, file->device, file->internalfd);
  _unlock_file(file);
  
  return 0;
}

//static struct {struct dirent item, DIR dir} dirs[32];
//unsigned int curdir = 0;

DIR *opendir(const unsigned char *path) {
  if (!path)
    return NULL;
  
  unsigned char path2[MAX_PATH];
  strcpy(path2, path);
  normpath(path2, sizeof(path2));
  
  BlockDeviceIF *device = rootdevice;
  FSInterface *fs = rootfs;
  
  if (bad_fsdev(fs, device)) {
    kprintf("File system driver corruption!\n");
    return NULL;
  }

  klock_lock(&rootdevice->lock);
  klock_lock(&rootfs->lock);
  
  int inode = fs->path_to_inode(fs, device, path2, strlen(path2));
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

