#include <stddef.h>
#include <stdint.h>

#include "../../io.h"
#include "../../task/lock.h"
#include "../fs/fs_interface.h"
#include "../fs/fs_file.h"
#include "../../libc/string.h"
#include "../../libc/libk.h"
#include "../../libc/kmalloc.h"
#include "../../libc/stdio.h"

#define EXT2_DEBUG  0

//INODES START AT 1!

//BLOCKS START AT 0!

typedef struct SuperBlock {
  int32_t totinode;
  
  int32_t totblock;
  int32_t totblock_supervisor;
  int32_t totblock_unalloc;
  int32_t totinode_unalloc;
  
  int32_t block_containing_superblock;
  
  int32_t blocksize_encoded;
  int32_t fragmentsize_encoded;
  
  int32_t blocks_per_group;
  int32_t fragments_per_group;
  int32_t inodes_per_group;
  
  int32_t mount_time;
  int32_t write_time;
  
  uint16_t mounts_since_fsck;
  uint16_t mounts_before_fsck;
  uint16_t ext2_signature;
  uint16_t fs_state;
  uint16_t error_behavior;
  uint16_t minor_version;
  
  int32_t last_fsck_time;
  int32_t fsck_invoke_interval;
  int32_t osid;
  int32_t major_version;
  
  uint16_t uid_that_accesses_reserved;
  uint16_t gid_that_accesses_reserved;
} SuperBlock;

typedef struct SuperBlockExt {
  int32_t first_inode;
  uint16_t inode_size;
  uint16_t blockgroup_containing_superblock;
  int32_t optfeatures;
  int32_t reqfeatures;
  int32_t rofeatures;
  
  char fid[16];
  char volume[64];
  
  int32_t compression;
  
  char block_file_prealloc, block_dir_prealloc;
  
  uint16_t unused;
  int32_t journal_inode;
  int32_t journal_device;
  int32_t orphan_inode_head;
} SuperBlockExt;

enum {
  FSTATE_CLEAN     = 1,
  FSTATE_CORRUPTED = 2
};

//error handlers enumeration
enum {
  ERRH_IGNORE_ERROR,
  ERRH_REMOUNT_RO,
  ERRH_KERNEL_PANIC
};

enum {
  OS_LINUX,
  OS_HURD,
  OS_MASIX,
  OS_FREEBSD,
  OS_OTHERBSD
};

//optional features
enum {
  FT_PREALLOC_CONTIG_BLOCKS=1,
  FT_AFS_SERVER_INODES=2,
  FT_HAS_JOURNAL=4,
  FT_HAS_EXT_ATTRS=8,
  FT_CAN_REALLOC_WITHIN_PARTITIONS=0x10,
  FT_DIR_USE_HASH_INDEX = 0x20
};

#define MIN2(a, b) ((a) < (b) ? (a) : (b))
#define MAX2(a, b) ((a) > (b) ? (a) : (b))

//required features
enum {
  FT_COMPRESSION=0x01,
  FT_DIRS_HAVE_TYPE_FIELD=0x02,
  FT_FS_MUST_REPLAY_JOURNAL=0x04,
  FT_FS_USES_JOURNAL=0x08
};

enum {
  FT_SPARSE_SUPERDESCRT = 0x01,
  FT_64BIT_FILE_SIZE = 0x02,
  FT_CONTENTS_IN_BINARYTREE = 0x04
};

typedef struct BlockGroup {
  int32_t blockusage; //0
  int32_t inodeusage; //4
  
  int32_t inodetable; //8
  
  uint16_t totfree_blocks; //12
  uint16_t totfree_inodes; //14
  uint16_t totdirectories; //16
  uint16_t spad;   //18
  uint16_t pad[6]; //20
} BlockGroup;

typedef struct INode {
  uint16_t type;
  uint16_t userid;
  
  uint32_t size_lower32;
  uint32_t atime;
  uint32_t ctime;
  uint32_t mtime;
  uint32_t dtime; //deletion time
  
  
  uint16_t groupid;
  uint16_t hardlinks;
  
  uint32_t blockdevice_sectors;
  uint32_t flags;
  uint32_t os_value;
  
  uint32_t direct_ptrs[12];
  
  uint32_t indirect1;
  uint32_t indirect2;
  uint32_t indirect3;
  
  uint32_t generation;
  uint32_t ext_attr; //file acl if a file
  uint32_t size_upper32; //directory acl if a directory
  uint32_t os_value2[3];
} INode;

enum { //inode type field
  TYPE_FIFO=0x1000,
  TYPE_CHARACTER_DEVICE=0x2000,
  TYPE_DIRECTORY=0x4000,
  TYPE_BLOCKDEVICE=0x6000,
  TYPE_REGULAR_FILE=0x8000,
  TYPE_SYMLINK=0xA000,
  TYPE_SOCKET=0xC000
};

enum { //permissions
  P_ALL_EXEC    = 1,
  P_ALL_WRITE   = 2,
  P_ALL_READ    = (1<<2),
  P_GROUP_EXEC  = (1<<3),
  P_GROUP_WRITE = (1<<4),
  P_GROUP_READ  = (1<<5),
  P_USER_EXEC   = (1<<6),
  P_USER_WRITE  = (1<<7),
  P_USER_READ   = (1<<8),
  P_STICKY_BIT  = (1<<9),
  P_SET_GROUP_ID= (1<<10),
  P_SET_USER_ID = (1<<11)
};

enum { //inode flags
  INODE_SECURE_DELETE = 1,
  INODE_BACKUP_ON_DELETE = 2,
  INODE_COMPRESS     = (1<<2),
  INODE_SYNC_UPDATES = (1<<3), //write to disk immediately, no write cacheing
  INODE_IMMUTABLE    = (1<<4),
  INODE_APPEND_ONLY  = (1<<5),
  INODE_IGNORE_IN_DUMP = (1<<6),
  INODE_DONT_UPDATE_ATIME = (1<<7),
  INODE_HASH_INDEXED_DIR = (1<<16),
  INODE_AFS_DIRECTORY = (1<<17),
  INODE_JOURNAL_FILE_DATA = (1<<18)
};

typedef struct ext2fs {
    FSInterface head;
    SuperBlock superblock;
    SuperBlockExt superext;
    
    int access, allowed_access;
    int readmeta, totgroup;
    
    BlockDeviceIF *last_device;
    size_t blocksize;
    
    int error;
} ext2fs;

typedef struct DirEntry {
  uint32_t inode;
  uint16_t entrysize;
  uint8_t namesize_lower;
  uint8_t typebits;
} DirEntry;

size_t ext2fs_readmeta(BlockDeviceIF *device, ext2fs *efs) {
  //if (efs->last_device == device && !efs->readmeta)
  //  return 0;
  
  efs->last_device = device;
  efs->readmeta = 0;
  
  int count = device->read(device, 1024, sizeof(efs->superblock), &efs->superblock);
  count += device->read(device, 1024+sizeof(efs->superblock), sizeof(efs->superext), &efs->superext);
  
  efs->blocksize = 1024 << efs->superblock.blocksize_encoded;
  size_t totblock = efs->superblock.totblock;
  size_t totinode = efs->superblock.totinode;
  
  if (efs->superblock.blocks_per_group == 0 || efs->superblock.inodes_per_group) {
    efs->error = 1;
    return 0; //eek!
  }
  
  size_t sum1 = totblock / efs->superblock.blocks_per_group;
  
  //round up
  if (totblock % efs->superblock.blocks_per_group)
    sum1++;
  
  size_t sum2 = totinode / efs->superblock.inodes_per_group;
  if (totinode % efs->superblock.inodes_per_group)
    sum2++;
  
  if (sum1 != sum2) {
    efs->error = 1;
  }
  
  efs->totgroup = sum1;
  
  return count;
}

static int accessmode(void *self, BlockDeviceIF *device) {
  ext2fs *efs = self;
  
  return efs->access;
}

static inline size_t inode_to_group(size_t inode, ext2fs *efs) {
  return (inode - 1) / efs->superblock.inodes_per_group;
}

static inline size_t find_inode(BlockDeviceIF *device, size_t inode, ext2fs *efs,
                                size_t *block_out, size_t *local_out) 
{
  size_t blocksize = 1024<<efs->superblock.blocksize_encoded;
  
  size_t superblock_block = efs->superblock.block_containing_superblock; //1024 / blocksize;
  size_t grouptable = superblock_block + 1;
  
  if (efs->superblock.inodes_per_group == 0) {
    efs->error = 1;
    return 0; //eek!
  }
  
  //size_t group = inode_to_group(inode, efs);
  size_t group = (inode - 1) / efs->superblock.inodes_per_group;
  size_t index = (inode - 1) % efs->superblock.inodes_per_group;
  
  //kprintf("inodes per group: %d\n", efs->superblock.inodes_per_group);
  //kprintf("block size: %d, superblock: %d, block descr block: %d\n", blocksize, superblock_block, grouptable);
  BlockGroup groupdef;
  
  size_t start = grouptable*blocksize + group*sizeof(BlockGroup);
  
  //kprintf("group: %d\n", group);
  
  memset(&groupdef, 0, sizeof(BlockGroup));
  device->read(device, start, sizeof(BlockGroup), &groupdef);
  
  start = groupdef.inodetable*blocksize;
  
  //kprintf("start: %d\n", start);
  
  size_t block = (start + index*efs->superext.inode_size) / blocksize;
  size_t local = (start + index*efs->superext.inode_size) % blocksize;
  
  if (block_out)
    *block_out = block;
  if (local_out)
    *local_out = local;
  
  return start + index*efs->superext.inode_size;
}

//fileoff is offset of indirect block
static size_t read_indirect(BlockDeviceIF *device, ext2fs *efs, int fileoff, int blockoff, int depth) {
  int block = blockoff, d = depth;
  size_t blocksize = efs->blocksize, totpointer = blocksize / 4;
  
  for (int i=depth-1; i >= 0; i--) {
    d = i;
    block = blockoff;
    
    while (d > 0) {
      block /= totpointer;
      d--;
    }
    block = block % totpointer;
    
    int block2;
    device->read(device, fileoff + block*4, 4, &block2);
    
    fileoff = block2*blocksize;
  }
  
  return fileoff/blocksize;
}

static size_t get_inode_block(INode *inode, BlockDeviceIF *device, ext2fs *efs, size_t block) {
  size_t blocksize = efs->blocksize, totpointer = blocksize / 4;
  
  if (block < 12) {
    return inode->direct_ptrs[block];
  }
  block -= 12;
  
  if (block < totpointer) {
    return read_indirect(device, efs, inode->indirect1, block, 1);
  } else if (block < 65536) {
    return read_indirect(device, efs, inode->indirect2, block, 2);
  } else {
    return read_indirect(device, efs, inode->indirect3, block, 3);
  }
}

static size_t read_inode_contents(BlockDeviceIF *device, ext2fs *efs, 
                                  int theinode, int fileoff, unsigned char *buf, int size) 
{
  size_t c = 0;
  INode _inode, *inode = &_inode;
  size_t block, local;
  size_t blocksize = efs->blocksize;

  if (efs->superblock.inodes_per_group == 0 || blocksize == 0) {
    efs->error = 1;
    return 0; //eek!
  }
  
  size_t ioff = find_inode(device, theinode, efs, &block, &local);
  
  //kprintf("reading inode again. . .\n");
  
  device->read(device, ioff, sizeof(INode), &_inode);
  
  size_t i1 = fileoff / blocksize;
  size_t i2 = (fileoff+size) / blocksize;
  
  //kprintf("  i1: %d, i2: %d\n", i1, i2);
  
  for (size_t i=i1; i <= i2; i++) {
    size_t bi = get_inode_block(inode, device, efs, i);
      
    //kprintf("  bi: %d, buf: %d\n", buf);
  
    if (i == i1) {
      int a = fileoff % blocksize;
      int b = blocksize - (fileoff % blocksize);
      
      b = MIN2(a + size, b);
      device->read(device, blocksize*bi + a, b-a, buf);
      
      c += b-a;
    } else if (i == i2) {
      int len = (fileoff + size) % blocksize;
      
      device->read(device, blocksize*bi, len, buf+c);
      c += len;
    } else {
      device->read(device, blocksize*bi, blocksize, buf + c);
      c += blocksize;
    }
  }
  return c;
}

//returns number of entries
static size_t foreach_direntry(ext2fs *self, BlockDeviceIF *device, int dir_inode,
                             void (*callback)(int inode, const unsigned char *namebuf)) 
{
  ext2fs_readmeta(device, self);

  size_t blocksize = 1024<<self->superblock.blocksize_encoded;

  if (self->superblock.inodes_per_group == 0 || blocksize == 0) {
    self->error = 1;
    return 0; //eek!
  }
  
  
  size_t block, ilocal;
  size_t fileoff = find_inode(device, dir_inode, self, &block, &ilocal);
  
  INode _inode, *inode = &_inode;
  
  device->read(device, fileoff, sizeof(INode), &_inode);
  
  DirEntry entry;
  unsigned char buf[255];
  
#ifdef EXT2_DEBUG
  kprintf("reading inode contents. . .\n");
#endif
  
  size_t i = 0, size = inode->size_lower32;
  size_t totentry = 0;
  
  while (i < size) {
    read_inode_contents(device, self, dir_inode, i, (unsigned char*)&entry, sizeof(entry));
    size_t starti = i;
    
    if (entry.inode == 0 && entry.entrysize == 0) {
      break;
    }
    
    i += sizeof(entry);
    //kprintf("inode: %d, entrysize: %d\n", entry.inode, entry.entrysize);
    
    read_inode_contents(device, self, dir_inode, i, buf, entry.namesize_lower);
    i += entry.namesize_lower;
    
    buf[entry.namesize_lower] = buf[254] = 0;
    
    i = starti + entry.entrysize;

    if ((i & 3) != 0) {
      i += 4 - (i & 3);
    }
    
    if (entry.inode == 0) {
      continue;
    }
    
    totentry++;
    
    if (callback != NULL) {
      callback(entry.inode, buf);
    }
  }
  
  return totentry;
}

typedef struct ext2DIR {
  int dir_inode;
  size_t i, size, entryi, entryinode, finished;
  char buf[80]; //XXX eek!
  INode inode;
} ext2DIR;

static int ext2_opendir_inode(void *vself, BlockDeviceIF *device, DIR *vdir, int inode) {
  ext2fs *self = vself;
  ext2DIR *dir = (ext2DIR*) vdir;
  
  memset(dir, 0, sizeof(*dir));
  
  dir->dir_inode = inode;
  dir->i = 0;
  dir->finished = 0;
  
  ext2fs_readmeta(device, self);

  size_t blocksize = 1024<<self->superblock.blocksize_encoded;

  if (self->superblock.inodes_per_group == 0 || blocksize == 0) {
    self->error = 1;
    return -1; //eek!
  }
  
  
  size_t block, ilocal;
  size_t fileoff = find_inode(device, dir->dir_inode, self, &block, &ilocal);
  
  device->read(device, fileoff, sizeof(INode), &dir->inode);
  
  if (!(dir->inode.type & TYPE_DIRECTORY)) {
    return -1; //eek!
  }
  
  dir->i = 0;
  dir->size = dir->inode.size_lower32;
  
  return 0;
}

static int ext2_readdir(void *vself, BlockDeviceIF *device, struct dirent *outentry, DIR *vdir) {
  ext2fs *self = vself;
  ext2DIR *dir = (ext2DIR*)vdir;
  DirEntry entry;
  size_t i = dir->i, size = dir->size;
  
  memset(outentry, 0, sizeof(*outentry));
  
  if (i >= dir->size) {
    dir->finished = 1;
    kprintf("dir->finished was set: %d\n", dir->finished);
    return 1;
  }
  
  do {
    read_inode_contents(device, self, dir->dir_inode, i, (unsigned char*)&entry, sizeof(entry));
    size_t starti = i;
    
    if (entry.inode == 0 && entry.entrysize == 0) {
      dir->finished = 1;
      kprintf("at end\n");
      return 1;
    }
    
    i += sizeof(entry);
    //kprintf("inode: %d, entrysize: %d\n", entry.inode, entry.entrysize);
    
    read_inode_contents(device, self, dir->dir_inode, i, dir->buf, entry.namesize_lower);
    i += entry.namesize_lower;
    
    dir->buf[entry.namesize_lower] = dir->buf[sizeof(dir->buf)-1] = 0;
    
    i = starti + entry.entrysize;

    if ((i & 3) != 0) {
      i += 4 - (i & 3);
    }
    
    if (entry.inode == 0) {
      continue;
    }
  
    dir->entryi++;
    dir->entryinode = entry.inode;
    dir->i = i;
    
    outentry->d_ino = entry.inode;
    memcpy(outentry->d_name, dir->buf, MIN2((size_t)entry.entrysize+1, (size_t)sizeof(dir->buf)));
  } while (i < size && entry.inode == 0);
  
  return 0;
}

static size_t dir_entrycount(void *vself, BlockDeviceIF *device, int dir_inode) {
  ext2fs *self = vself;
  ext2fs_readmeta(device, self);
  //static size_t foreach_direntry(ext2fs *self, BlockDeviceIF *device, int dir_inode,
  //                           void (*callback)(int inode, const unsigned char *namebuf)) 
  return foreach_direntry(self, device, dir_inode, NULL);
  
  size_t blocksize = 1024<<self->superblock.blocksize_encoded;

  if (self->superblock.inodes_per_group == 0 || blocksize == 0) {
    self->error = 1;
    return 0; //eek!
  }

  
  size_t block, ilocal;
  size_t fileoff = find_inode(device, dir_inode, self, &block, &ilocal);
  
  INode _inode, *inode = &_inode;
  
  device->read(device, fileoff, sizeof(INode), &_inode);
  
  DirEntry entry;
  unsigned char buf[255];
  
  //kprintf("reading inode contents. . .\n");
  
  size_t i = 0, size = inode->size_lower32;
  
  //for (int k=0; k<20; k++) {
  while (i < size) {
    read_inode_contents(device, self, dir_inode, i, (unsigned char*)&entry, sizeof(entry));
    size_t starti = i;
    
    if (entry.inode == 0 && entry.entrysize == 0) {
      break;
    }
    
    i += sizeof(entry);
    
    read_inode_contents(device, self, dir_inode, i, buf, entry.namesize_lower);
    i += entry.namesize_lower;
    
    buf[entry.namesize_lower] = buf[254] = 0;
    
    i = starti + entry.entrysize;

    if ((i & 3) != 0) {
      i += 4 - (i & 3);
    }
    
    if (entry.inode == 0) {
      continue;
    }
  }
  
  return 0;
}

static int dir_lookup(void *vself, BlockDeviceIF *device, int dir_inode, const char *name) {
  ext2fs *self = vself;
  DIR dir;
  struct dirent entry;

  int ret = ext2_opendir_inode(self, device, &dir, dir_inode);
  if (ret != 0) {
    return -1;
  }
  
  while (1) {
    ret = ext2_readdir(self, device, &entry, &dir);
    if (ret != 0) {
      return -1;
    }
    
    //paranoia check. . .
    //entry->name[MIN2(MAX_PATH, sizeof(*entry->name)] = 0;
    if (strcmp(entry.d_name, name) == 0) {
      return entry.d_ino;
    }
  }
  
  return -1;
}

//returns -1 if failed to find inode
int ext2_path_to_inode(void *vself, BlockDeviceIF *device, const char *utf8path, int utf8path_size) {
  ext2fs *self = vself;
  ext2fs_readmeta(device, self);
  
  unsigned char buf[MAX_PATH*2];
  
  strncpy(buf, utf8path, sizeof(buf));
  buf[sizeof(buf)-1] = 0;
  
  //trim white space
  
  int c = strlen(buf);
  while (c > 1 && iswhitespace(buf[c])) {
    c--;
  }
  
  unsigned char *start = (unsigned char*)buf;
  while (start < (unsigned char*)(buf + c) && iswhitespace(*start)) {
    start++;
  }
  
  //just root directory? if so, return 2
  if (start[0] == '/' && start[1] == 0) {
    return 2;
  }
  
  //kprintf("start: %s\n", start);
  
  //otherwise, split
  if (start[0] == '/') {
    start++;
  }
  
  int inode = 2;
  
  int len = strlen(start);
  unsigned char *str = start;
  while (str < start + len) {
    size_t i = strcspn(str, "/");
    
    if (i == 0) {
      i = strlen(str);
    }
  
    str[i] = 0;
    //kprintf("a directory: %s\n", str);
    
    inode = dir_lookup(self, device, inode, str);
    if (inode <= 0) {
      return -1;
    }
    
    str += i+1;
  }
  
  //kprintf("inode: %d\n", inode);
  
  return inode;
}

static int ext3_stat(void *self, BlockDeviceIF *device, int inode, struct stat *buf, char namebuf[MAX_PATH]) {
  ext2fs *fs = self;
  ext2fs_readmeta(device, fs);
  
  memset(buf, 0, sizeof(*buf));
  
  if (namebuf != NULL) {
    namebuf[0] = 0;
  }
  
  return 0;
}

FSInterface *kext2fs_create(BlockDeviceIF *device) {
  ext2fs *fs = kmalloc(sizeof(*fs));
  
  memset(fs, 0, sizeof(*fs));
  _fs_fsinterface_init((FSInterface*)fs);
  
  fs->readmeta = 1;
  fs->allowed_access = fs->access = O_RDONLY|O_SEARCH|O_EXEC;
  
  fs->head.stat = ext3_stat;
  //fs->head.dir_getentry = dir_getentry;
  fs->head.dir_entrycount = dir_entrycount;
  fs->head.accessmode = accessmode;
  fs->head.opendir_inode = ext2_opendir_inode;
  fs->head.readdir = ext2_readdir;
  fs->head.path_to_inode = ext2_path_to_inode;

  return (FSInterface*) fs;
}
