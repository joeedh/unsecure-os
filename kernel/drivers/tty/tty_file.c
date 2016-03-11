#include "tty.h"

#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../io.h"
#include "../../task/task.h"
#include "../../timer.h"

#include "../fs/fs_interface.h"
#include "../fs/fs_file.h"

static int tty_pread(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff) {
  return 0;
}

static int tty_pwrite(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff) {
  return 0;
}

static int tty_close(BlockDeviceIF *device, int file) {
  return 0;
}

static int tty_flush(BlockDeviceIF *device, int file) {
  return 0;
}

static int tty_accessmode(BlockDeviceIF *device) {
  return O_RDWR|O_SEARCH;
}

FSInterface tty_iface;
FSFile tty_file;

void tty_file_initialize() {
  memset(&tty_iface, 0, sizeof(tty_iface));
  memset(&tty_file, 0, sizeof(tty_file));
  
  tty_iface.flush = tty_flush;
  tty_iface.pread = tty_pread;
  tty_iface.pwrite = tty_pwrite;
  tty_iface.close = tty_close;
  tty_iface.accessmode = tty_accessmode;
  
  tty_file.name = "TTY";
  tty_file.path = "/dev/console";
  tty_file.pid = 0;
  tty_file.access = O_RDWR|O_SEARCH;
  
  tty_file.device = NULL;
  tty_file.fs = &tty_iface;
  tty_file.inode = 0;
}

int tty_file_open() {
  return (int)(&tty_file);
}

void tty_file_close(FSFile *file) {
  //do nothing
}

/*
//device parameter is a BlockDeviceIF
typedef struct FSInterface {
  char *name;
  
  //see ACCESS_*** enum
  int (*accessmode);
  int (*open)(BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*openat)(int fd, BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag);
  int (*close)(BlockDeviceIF *device, int fd);
  int (*stat)(BlockDeviceIF *device, const char *utf8path, int utf8path_size);
  
  //returns number of bytes written
  int (*pwrite)(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  
  //returns number of bytes read
  int (*pread)(BlockDeviceIF *device, int file, const char *buf, size_t bufsize, size_t fileoff);
  int (*lseek)(BlockDeviceIF *device, int file, size_t off, size_t whence);
  int (*rewind)(BlockDeviceIF *device, int file);
  int (*tell)(BlockDeviceIF *device, int file);
  int (*eof)(BlockDeviceIF *device, int file);
  
  void (*mount_filesystem)(BlockDeviceIF *device);
  void (*unmount_filesystem)(BlockDeviceIF *device);
  
  Inode (*path_to_inode)(BlockDeviceIF *device, const char *utf8path, int utf8path_size);
  int (*inode_to_path)(BlockDeviceIF *device, Inode inode, const char *utf8path, int utf8path_size);
  
  //directories
  size_t (BlockDeviceIF *device, *dir_entrycount)(Inode dir_inode);
  Inode (BlockDeviceIF *device, *dir_getentry(Inode dir_inode, Inode inode);
  
  int stat(BlockDeviceIF *device, Inode inode, struct stat *buf);
  
  int chmod(BlockDeviceIF *device, Inode inode, int permissions);
  int chuser(BlockDeviceIF *device, Inode inode, int userid);
  int chgroup(BlockDeviceIF *device, Inode inode, int groupid);
} FSInterface;
*/
