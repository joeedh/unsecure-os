#ifndef _FS_FILE_H
#define _FS_FILE_H

#include "stddef.h"
#include "stdint.h"
#include "fs_interface.h"
#include "../../task/lock.h"

#define PIPE_SIZE (1024*512)

typedef struct FSFile {
  struct FSFile *next, *prev;
  
  int inode, closed;
  unsigned char *name;
  unsigned char *path;
  Lock lock;
  
  BlockDeviceIF *device;
  FSInterface *fs;
  
  int pid, access, error, cursor, mode;
  int pipe_rcursor; //pipe read cursor
  
  intptr_t custom, magic;
  
  //internel file descriptor
  intptr_t internalfd;
  
  int errno;
  unsigned char errmsg[512];
} FSFile;

#define _FILE_MAGIC 235433413

void _fs_file_init(FSFile *file);
void _fs_fsinterface_init(FSInterface *fs);
int fs_vfs_add(char *prefix, FSInterface *fs, BlockDeviceIF *device);
int fs_vfs_get(char *path, FSInterface **fs, BlockDeviceIF **device);

int bad_fsdev(FSInterface *fs, BlockDeviceIF *device);

extern void filesystem_initialize();

int read(int fd, void *buf, unsigned int bytes);
int write(int fd, void *buf, unsigned int bytes);
int pread(int fd, void *buf, unsigned int bytes, unsigned int off);

int flush(int fd);
int pipe(int fds[2]);
int open(const unsigned char *path, int modeflags);
int close(int fd);
int fstat(int fd, struct stat *out);
int tell(int fd);
int ftruncate(int fd, size_t size);

void *mmap(void *addr, size_t length, int prot, int flags, int fd, int offset);
int munmap(void *addr, size_t length);

int lseek(int fd, int off, int whence);

#endif /* _FS_FILE_H */
