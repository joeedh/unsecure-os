#include "stddef.h"
#include "stdint.h"

#include "memfile.h"

#include "fs_file.h"
#include "fs_interface.h"
#include "poll.h"

#include "../tty/tty.h"
#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../libc/list.h"
#include "../../libc/kmalloc.h"
#include "../../libc/stdio.h"
#include "../../io.h"
#include "../../task/task.h"
#include "../../task/process.h"
#include "../../task/lock.h"
#include "../../timer.h"
#include "../../libc/path.h"
#include "fs_vfstable.h"

#include "dirent.h"

extern FSInterface *rootfs;
extern BlockDeviceIF *rootdevice;

static List open_files;

static int prepare_path(const unsigned char *pathin, unsigned char *pathout, int outsize);

int fs_vfs_add(char *prefix, FSInterface *fs, BlockDeviceIF *device) {
  vfs_table = krealloc(vfs_table, sizeof(VFSEntry)*(vfs_table_size+1));
  
  strcpy(vfs_table[vfs_table_size].prefix, prefix);
  vfs_table[vfs_table_size].fs = fs;
  vfs_table[vfs_table_size].device = device;
  vfs_table[vfs_table_size].flag = VFS_ENABLED;
  
  vfs_table_size++;
  
  return 0;
}

int fs_vfs_get(const char *path, FSInterface **fs, BlockDeviceIF **device) {
  *fs = rootfs;
  *device = rootdevice;
  
  int max_match = 0, max=-1;
  int len = strlen(path);
  
  for (int i=0; i<vfs_table_size; i++) {
    int len2 = strlen(vfs_table[i].prefix);
    int j=0;
    
    if (len2 > len)
      continue;
    if (!(vfs_table[i].flag & VFS_ENABLED))
      continue;
    
    for (j=0; j<len2; j++) {
      if (path[j] != vfs_table[i].prefix[j]) {
        break;
      }
    }
    
    if (j == len2 && j > max) {
      max_match = i;
      max = j;
    }
  }
  
  if (max != -1) {
    e9printf("Found a virtual file system device: %s\n", vfs_table[max_match].prefix);
    
    *fs = vfs_table[max_match].fs;
    *device = vfs_table[max_match].device;
  }
  
  return 0;
}

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

int _fs_error(void *fsinterface, int code, unsigned char *error) {
  FSInterface *fs = fsinterface;

  fs->lasterror = code;
  strncpy(fs->lasterror_message, error, sizeof(fs->lasterror_message)-1);
  
  if (error)
    e9printf("IO Error:%d: %s\n", code, error);
  else
    e9printf("IO Error:%d:", code);
  
  return code;
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

int lseek(int fd, int off, int whence) {
  if (!_valid_file(fd)) {
    klogf("Invalid file %x\n", fd);
    return -1;
  }
 
  FSFile *file = (FSFile*) fd;
  int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  int ret = -1, *cursor = ((file->mode & O_PIPE_MODE) && reverse) ? &file->pipe_rcursor : &file->cursor;
  
  _lock_file(file);
  if (file->fs->lseek) {
    ret = file->fs->lseek(file->fs, file->device, file->internalfd, off, whence);
    
    if (ret < 0) {
      _unlock_file(file);
      return ret;
    }
    
    *cursor = ret;
  }
  
  _unlock_file(file);
  
  return ret;
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
    struct stat sdata;
    
    file->fs->stat(file->fs, file->device, (int)file, &sdata);
    
    unsigned int size = sdata.st_size;
    *cursor = *cursor % size;
  }
  
  _unlock_file(file);
  
  return ret;
}

int pread(int fd, void *buf, unsigned int bytes, unsigned int off) {
  if (!_valid_file(fd)) {
    klogf("Invalid file %x\n", fd);
    return -1;
  }
  
  FSFile *file = (FSFile*) fd;
  _lock_file(file);
  
  //int reverse = (!!(file->mode & O_PIPE_MODE)) ^ (!!(file->mode & _O_REVERSE));
  
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
  
  int ret = file->fs->pread(file->fs, file->device, file->internalfd, buf, bytes, off);
  
  //wrap around in pipe mode
  if (ret > 0 && ret < (int)bytes && (file->mode & O_PIPE_MODE)) {
    ret = file->fs->pread(file->fs, file->device, file->internalfd, buf+ret, bytes-ret, 0);
  }
  
  if (ret < 0) {
    _unlock_file(file);
    
    file->fs->lasterror_message[sizeof(file->fs->lasterror_message)-1] = 0;
    strncpy(file->errmsg, file->fs->lasterror_message, sizeof(file->errmsg)-1);
    file->errno = file->fs->lasterror;
    
    klogf("Read error:%d: %s\n", file->fs->lasterror, file->fs->lasterror_message);
    return -1;
  }
  
  //klogf("cursorr: %d, ret: %d\n", *cursor, ret);
  
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
    struct stat sdata;
    
    file->fs->stat(file->fs, file->device, (int)file, &sdata);
    unsigned int size = sdata.st_size;
    
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
  if (file->fs->flush) {
    file->fs->flush(file->fs, file->device, file->internalfd);
  }
  _unlock_file(file);
  
  return 0;
}

void *mmap(void *addr, size_t length, int prot, int flags, int fd, int offset) {
  if (!_valid_file(fd))
    return NULL;
  
  FSFile *file = (FSFile*) fd;
  void *ret = NULL;
  
  _lock_file(file);
  if (file->fs->mmap) {
    ret = file->fs->mmap(file->fs, file->device, addr, length, prot, flags, file->internalfd, offset);
  }
  _unlock_file(file);
  
  return ret;
}

int munmap(void *addr, size_t length) {
  /* XXX eh? no file descriptor here? why?
  if (!_valid_file(fd))
    return -1;
  
  FSFile *file = (FSFile*) fd;
  int ret = 0;
  
  _lock_file(file);
  if (file->fs->munmap) {
    ret = file->fs->munmap(file->fs, file->device, addr, length);
  } else {
    return _fs_error(file->fs, -1, "Munmap unsupported");
  }
  
  _unlock_file(file);
  
  return ret;
  */
  return -1;
}

int ftruncate(int fd, size_t size) {
  if (!_valid_file(fd))
    return -1;
  
  FSFile *file = (FSFile*) fd;
  int ret = 0;
  
  _lock_file(file);
  if (file->fs->ftruncate) {
    ret = file->fs->ftruncate(file->fs, file->device, file->internalfd, fd);
  }
  _unlock_file(file);
  
  return ret;
}

int pipe(int fds[2]) {
  FSFile *file = (FSFile*) kmemfile_create(PIPE_SIZE, 0);
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
  int ret = file->fs->tell(file->fs, file->device, file->internalfd);
  _unlock_file(file);
  
  return ret;
}

int stat(const char *path, struct stat *out) {
  if (!out)
    return -1;

  klock_lock(&rootdevice->lock);
  klock_lock(&rootfs->lock);
  
  unsigned char path2[MAX_PATH];
  prepare_path(path, (unsigned char*)path2, sizeof(path2));
  
  int inode = rootfs->path_to_inode(rootfs, rootdevice, path2, strlen(path2));
  //e9printf("PATH: %s, PATH2: %s, INODE: %d\n", path, path2, inode);

  if (inode < 0) {
    klock_unlock(&rootfs->lock);
    klock_unlock(&rootdevice->lock);
    return -1;
  }
  
  int ret = rootfs->stat(rootfs, rootdevice, inode, out);
  
  //e9printf("RET: %d, st_mode: %d\n", ret, out->st_mode);
  
  klock_unlock(&rootfs->lock);
  klock_unlock(&rootdevice->lock);
  return ret;
}

int fstat(int fd, struct stat *out) {
  FSFile *file = (FSFile*)fd;
  
  if (!out)
    return -1;
  if (!_valid_file(fd))
    return -1;
  
  _lock_file(file);
  int ret = file->fs->fstat(file->fs, file->device, file->internalfd, out);
  _unlock_file(file);
  
  return ret;
}

//prepends cwd, normpathifys, etc
static int prepare_path(const unsigned char *pathin, unsigned char *pathout, int outsize) {
  if (pathin[0] == '/') { //do nothing?
    strncpy(pathout, pathin, outsize);
    return 0;
  }
  
  Process *p = process_get_current(0);
  
  if (!p) {
    strncpy(pathout, pathin, outsize);
    pathout[outsize-1] = 0;
    
    return -1;
  }
  
  pathout[0] = 0;
  strcat(pathout, p->working_path);
  int len = strlen(pathout);
  
  if (len == 0 && pathin[0] != '/') {
    strcat(pathout, "/");
  } else if (len != 0 && pathin[0] == '/' && pathout[len-1] == '/') {
    pathout[len-1] = 0;
  }
  
  strcat(pathout, (unsigned char*)pathin);
  normpath(pathout, outsize);
  
  return 0;
}

int open(const unsigned char *path, int modeflags) {
  unsigned char path2[MAX_PATH];
  
  prepare_path(path, (unsigned char*)path2, sizeof(path2));
  
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
  
  LinkNode *node = kmalloc(sizeof(LinkNode));
  node->data = file;
  
  Process *p = process_get_current(0);
  klist_append(&p->open_files, node);
  
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

  Process *p = process_get_current(0);
  LinkNode *node;
  
  for (node=p->open_files.first; node; node=node->next) {
    if (node->data == file) {
      klist_remove(&p->open_files, node);
      kfree(node);
      break;
    }
  }
  
  return 0;
}

//static struct {struct dirent item, DIR dir} dirs[32];
//unsigned int curdir = 0;

DIR *opendir(const unsigned char *path) {
  if (!path)
    return NULL;
  
  unsigned char path2[MAX_PATH];
  
  //strncpy(path2, path, sizeof(path2));
  //normpath(path2, sizeof(path2));
  prepare_path(path, (unsigned char*)path2, sizeof(path2));
    
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
  
  FSFile *dirfile = kmalloc(sizeof(FSFile));
  memset(dirfile, 0, sizeof(*dirfile));
  dirfile->fs = rootfs;
  dirfile->device = rootdevice;
  ret->dirfd = (int)dirfile;
  
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
  
  FSFile *dirfile = kmalloc(sizeof(FSFile));
  memset(dirfile, 0, sizeof(*dirfile));
  dirfile->fs = rootfs;
  dirfile->device = rootdevice;
  dir2->dirfd = (int)dirfile;
  
  return dir2;
}

int closedir(DIR *dir) {
  if (bad_fsdev(rootfs, rootdevice)) {
    kprintf("File system driver corruption!\n");
    return -1;
  }
  
  FSFile *dirfile = (FSFile*) dir->dirfd;
  kfree(dirfile);
  dir->dirfd = 0;
  
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

int chdir(char *path) {
  Process *p = process_get_current(0);
  
  if (!p) 
    return -1;
  
  DIR *dir = opendir(path);
  if (!dir) {
    e9printf("not a directory: '%s'\n", path);
    return -2; //directory doesn't exist
  }
  closedir(dir);
  
  krwlock_lock(&p->environ_lock);
  
  strncpy(p->working_path, path, sizeof(p->working_path));
  p->working_path[sizeof(p->working_path)-1] = 0;
  
  krwlock_unlock(&p->environ_lock);
  
  return 0;
}

char *getcwd(char *buf, size_t size) {
  Process *p = process_get_current(0);
  
  if (!p) 
    return NULL;
  
  krwlock_rlock(&p->environ_lock);
  
  strncpy(buf, p->working_path, size);
  buf[size-1] = 0;
  
  krwlock_unrlock(&p->environ_lock);
  
  return buf;
}

int poll(struct pollfd pollfds[], nfds_t len, int timeout_ms) {
  int ret = 0;
  
  //hrm, what sort of locking should I do.  read locks?
  
  for (int i=0; i<len; i++) {
    if (!_valid_file(pollfds[i].fd)) {
      kprintf("poll() error!\n");
      return -1;
    }
    
    FSFile *file = (FSFile*) pollfds[i].fd;
    
    if (file->fs->poll && file->fs->poll(file->fs, file->device, file->internalfd, pollfds+i, timeout_ms) < 0) {
      ret = -1;
    }
  }
  
  return ret;
}
