#ifndef _VFS_TABLE_H
#define _VFS_TABLE_H

#include "fs_interface.h"

typedef struct VFSEntry {
  char prefix[255];
  
  FSInterface *fs;
  BlockDeviceIF *device;
  
  int flag;
} VFSEntry;

//VFSEntry->flag
enum {
  VFS_ENABLED=1
};

extern VFSEntry *vfs_table;
extern int vfs_table_size;

#endif /* _VFS_TABLE_H */
