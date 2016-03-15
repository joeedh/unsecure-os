#ifndef _DIRENT_H
#define _DIRENT_H

#include <stddef.h>
#include <stdint.h>

typedef struct dirent {
  int d_ino, pad;
  char d_name[256];
} dirent;

typedef struct DIR {
  unsigned char private[256];
} DIR;

DIR *opendir(const unsigned char *path);
DIR *opendir_inode(int inode);
int closedir(DIR *dir);
struct dirent *readdir(DIR *dir);
void rewinddir(DIR *dir);

//int readdir_r(DIR *dir, struct dirent *dirent, struct dirent **restrict);
//int scandir(const char *, struct dirent ***, int (*)

#endif /* _DIRENT_H */
