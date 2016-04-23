#ifndef _STAT_H
#define _STAT_H

typedef struct timespec {
  long tv_sec, tv_nsec;
} timespec;

//XXX look up in posix
struct stat {
  int st_dev, st_ino, st_mode, st_nlink, st_uid, st_gid, st_rdev;
  int st_size; 
  struct timespec st_atim, st_mtim, st_ctim;
  int st_blksize, st_blocks;
};

int stat(const char *path, struct stat *buf);

enum {
  S_IFBLK=1<<15,
  S_IFCHR=1<<16,
  S_IFFIFO=1<<17,
  S_IFREG=1<<18,
  S_IFDIR=1<<19,
  S_IFLNK=1<<20,
  S_IFSOCK=1<<21,
  S_IXOTH = 0x01,
  S_IWOTH = 0x02,
  S_IROTH = 0x04,
  S_IRWXO = 0x07,
  S_IXGRP = 0x010,
  S_IWGRP = 0x020,
  S_IRGRP = 0x040,
  S_IRWXG = 0x070,
  S_IWUSR = 0x0200,
  S_IXUSR = 0x0100,
  S_IRUSR = 0x0400,
  S_IRWXU = 0x0700,
  S_ISVTX = 0x01000,
  S_ISGID = 0x02000,
  S_ISUID = 0x04000
};

#define ST_ISBLK(m) ((m) & S_IFBLK)
#define ST_ISDIR(m) ((m) & S_IFDIR)
#define ST_ISCHR(m) ((m) & S_IFCHR)
#define ST_ISFIFO(m) ((m) & S_IFFIFO)
#define ST_ISREG(m) ((m) & S_IFREG)
#define ST_ISLNK(m) ((m) & S_IFLNK)
#define ST_ISSOCK(m) ((m) & S_IFSOCK)

#endif /* _STAT_H */
