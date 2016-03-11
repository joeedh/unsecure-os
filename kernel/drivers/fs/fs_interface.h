#ifndef _FS_INTERFACE_H
#define _FS_INTERFACE_H

#include "stddef.h"
#include "stdint.h"

#include "../blockdevice/blockdevice.h"

//XXX look up in posix
typedef struct stat {
  int st_msize, st_mtime, st_atime, st_flags, st_user, st_group;
} stat;

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
  O_TTY_INIT=(1<<16)
};

enum {
  FILE_OKAY=0,
  FILE_READ_ERROR=1,
  FILE_WRITE_ERROR=2,
  FILE_ACCESS_ERROR=3,
  FILE_PERMISSIONS_ERROR=4,
  FILE_TYPE_ERROR=5
};

//device parameter is a BlockDeviceIF
typedef struct FSInterface {
  char *name;
  
  //see ACCESS_*** enum
  int (*accessmode)(BlockDeviceIF *device);
  int (*open)(BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*openat)(int fd, BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*close)(BlockDeviceIF *device, int fd);
  
  //returns number of bytes written
  int (*pwrite)(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  
  //returns number of bytes read
  int (*pread)(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  int (*lseek)(BlockDeviceIF *device, int file, size_t off, size_t whence);
  int (*rewind)(BlockDeviceIF *device, int file);
  int (*tell)(BlockDeviceIF *device, int file);
  int (*eof)(BlockDeviceIF *device, int file);
  
  int (*flush)(BlockDeviceIF *device, int file);
  
  void (*mount_filesystem)(BlockDeviceIF *device);
  void (*unmount_filesystem)(BlockDeviceIF *device);
  
  int (*path_to_inode)(BlockDeviceIF *device, const char *utf8path, int utf8path_size);
  int (*inode_to_path)(BlockDeviceIF *device, int inode, const char *utf8path, int utf8path_size);
  
  //directories
  size_t (*dir_entrycount)(BlockDeviceIF *device, int dir_inode);
  int (*dir_getentry)(BlockDeviceIF *device, int dir_inode, int inode);
  
  int (*stat)(BlockDeviceIF *device, int inode, struct stat *buf);
  
  int (*chmod)(BlockDeviceIF *device, int inode, int permissions);
  int (*chuser)(BlockDeviceIF *device, int inode, int userid);
  int (*chgroup)(BlockDeviceIF *device, int inode, int groupid);
} FSInterface;

#endif /* _FS_INTERFACE_H */
