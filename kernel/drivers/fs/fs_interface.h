#ifndef _FS_INTERFACE_H
#define _FS_INTERFACE_H

#include "stddef.h"
#include "stdint.h"

#include "../blockdevice/blockdevice.h"
#include "../fs/dirent.h"
#include "../../task/lock.h"

#include "stat.h"

#define MAX_PATH 255

struct pollfd;

//XXX look up in posix
//also, why do we always use integers for file
//handles.  perhaps I shall typedef them,
//but, keep them integers.

enum { //is a bitfield
  O_EXEC=1,
  O_RDONLY=2,
  O_RDWR=2|8,
  O_SEARCH=4,
  O_WRONLY=8,
  O_APPEND=(1<<4),
  O_CLOEXEC=(1<<5),
  O_CREAT=(1<<6),
  O_DIRECTORY=(1<<7),
  O_DSYNC=(1<<8),
  O_EXCL=(1<<9),
  O_NOCTTY=(1<<10),
  O_NOFOLLOW=(1<<11),
  O_NONBLOCK=(1<<12),
  O_RSYNC=(1<<13),
  O_SYNC=(1<<14),
  O_TRUNC=(1<<15), //erase files on opening
  O_TTY_INIT=(1<<16),
  O_PIPE_MODE=(1<<17),
  _O_REVERSE=(1<<18)
};

enum {
  FILE_OKAY=0,
  FILE_READ_ERROR=1,
  FILE_WRITE_ERROR=2,
  FILE_ACCESS_ERROR=3,
  FILE_PERMISSIONS_ERROR=4,
  FILE_TYPE_ERROR=5
};

//note that all string parameters are null terminated, even if they require
//their buffer size be passed in as well.

#define FSINTERFACE_MAGIC 34668324

//device parameter is a BlockDeviceIF
typedef struct FSInterface {
  unsigned int magic;
  char *name;
  
  //see ACCESS_*** enum
  int (*accessmode)(void *self, BlockDeviceIF *device);
  int (*open)(void *self, BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*openat)(void *self, int fd, BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*close)(void *self, BlockDeviceIF *device, int fd);
  
  //addr is ignored if paging disabled
  void *(*mmap)(void *self, BlockDeviceIF *device, void *addr, size_t length, int prot, int flags, int fd, int offset);
  int (*munmap)(void *self, BlockDeviceIF *device, void *addr, size_t length);
  
  int (*ftruncate)(void *self, BlockDeviceIF *device, int fd, size_t size);
  int (*poll)(void *self, BlockDeviceIF *device, int fd, struct pollfd *pfd, int timeout_ms);
  
  //returns number of bytes written
  int (*pwrite)(void *self, BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  
  //returns number of bytes read
  int (*pread)(void *self, BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  
  int (*lseek)(void *self, BlockDeviceIF *device, int file, int off, int whence);
  int (*rewind)(void *self, BlockDeviceIF *device, int file);
  int (*tell)(void *self, BlockDeviceIF *device, int file);
  int (*eof)(void *self, BlockDeviceIF *device, int file);
  
  int (*flush)(void *self, BlockDeviceIF *device, int file);
  
  void (*mount_filesystem)(void *self, BlockDeviceIF *device);
  void (*unmount_filesystem)(void *self, BlockDeviceIF *device);
  
  //returns -1 if failed to find inode, otherwise returns inode
  int (*path_to_inode)(void *self, BlockDeviceIF *device, const char *utf8path, int utf8path_size);
  //int (*inode_to_path)(void *self, BlockDeviceIF *device, int inode, const char *utf8path, int utf8path_size);

  //these two return -1 if failed to open directory
  int (*opendir_inode)(void *self, BlockDeviceIF *device, DIR *dir, int inode);
  int (*opendir)(void *self, BlockDeviceIF *device, DIR *dir, const char *path);
  
  DIR *(*closedir)(void *self, BlockDeviceIF *device, DIR *dir);
  
  //returns 1 if no more directory entires, otherwise returns 0.  returns -1 on error.
  int (*readdir)(void *self, BlockDeviceIF *device, struct dirent *, DIR *dir);
  
  //rewind directory pointer
  int (*rewinddir)(void *self, BlockDeviceIF *device, DIR *dir);
  
  //-----      directories    -----
  size_t (*dir_entrycount)(void *self, BlockDeviceIF *device, int dir_inode);
  
  //namebuf is optional
  int (*dir_getentry)(void *self, BlockDeviceIF *device, int dir_inode, int inode, char namebuf[MAX_PATH]);
  
  //namebuf is optional
  int (*stat)(void *self, BlockDeviceIF *device, int inode, struct stat *buf);
  int (*fstat)(void *self, BlockDeviceIF *device, int fd, struct stat *buf);
  
  int (*chmod)(void *self, BlockDeviceIF *device, int inode, int permissions);
  int (*chuser)(void *self, BlockDeviceIF *device, int inode, int userid);
  int (*chgroup)(void *self, BlockDeviceIF *device, int inode, int groupid);
  
  unsigned char lasterror_message[512];
  int lasterror;
  Lock lock;
} FSInterface;

//note: does NOT lock fsinterface!!
int _fs_error(void *fsinterface, int code, unsigned char *error);

#endif /* _FS_INTERFACE_H */
