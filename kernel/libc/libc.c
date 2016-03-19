#include <stddef.h>
#include <stdint.h>

size_t strlen(const unsigned char* str) {
  size_t i = 0;
  while (str[i]) {
    i++;
  }
  
  return i;
}

#ifndef __KERNEL_BUILD__
#include "../syscalls/syscalls.h"

extern SysCallPtr *syscalls;

#define SYS_I0V(name, i) int name() \
 { return syscalls[i].icall0i(); }
#define SYS_I1I(name, i) int name(int a)\
 { return syscalls[i].icall1i(a); }
#define SYS_I2I(name, i) int name(int a, int b)\
 { return syscalls[i].icall2i(a, b); }
#define SYS_I3I(name, i) int name(int a, int b, int c)\
 { return syscalls[i].icall3i(a, b, c); }
#define SYS_I4I(name, i) int name(int a, int b, int c, int d)\
 { return syscalls[i].icall4i(a, b, c, d); }
#define SYS_I5I(name, i) int name(int a, int b, int c, int d, int e)\
 { return syscalls[i].icall5i(a, b, c, d, e); }
#define SYS_V1P1(name, i) void name(void *ptr) \
 { return syscalls[i].vcall1p(ptr); }
#define SYS_P1I1(name, i) void name(unsigned int size) \
 { return syscalls[i].pcall1i(size); }

#define STUB(name) void name(){}

SYS_I1I(exit, SYS_EXIT);
SYS_I1I(read, SYS_READ);
SYS_I1I(write, SYS_WRITE);
SYS_I1I(opendir, SYS_OPENDIR);
SYS_I1I(closedir, SYS_CLOSEDIR);
SYS_I1I(readdir, SYS_READDIR);
SYS_I1I(opendir_inode, SYS_OPENDIR_INODE);
SYS_I1I(pipe, SYS_PIPE);
SYS_I1I(wait, SYS_WAIT);
SYS_I1I(waitpid, SYS_WAITPID);
SYS_P1I(malloc, SYS_KMALLOC);
SYS_I1I(free, SYS_KFREE);
SYS_I1I(flush, SYS_FLUSH);

#endif
