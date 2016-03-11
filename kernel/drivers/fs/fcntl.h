#ifndef _FCNTL_H
#define _FCNTL_H

int open(const unsigned char *path, int oflag, ...);
int openat(int fd, const unsigned char *path, int oflag, ...);



#endif /* _FCNTL_H */
