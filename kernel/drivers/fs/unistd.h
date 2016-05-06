#ifndef _UNISTD_H
#define _UNISTD_H

//#define SEEK_CUR 1
//#define SEEK_SET 2
//#define SEEK_END 3

#include <stddef.h>
#include <stdint.h>

int chdir(char *path);
char *getcwd(char *buf, size_t size);

#ifndef __KERNEL_BUILD__
int ftruncate(int fd, size_t size);
int mmap(void *addr, size_t length, int prot, int flags, int fd, int offset);
int munmap(void *addr, size_t length);
int peof(int fd);

#endif /* __KERNEL_BUILD__ */

#endif /* _UNISTD_H */
