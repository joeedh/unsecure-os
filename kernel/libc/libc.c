#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>
#include "../userinclude/errno.h"

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

#ifdef PREFIX_DEFINED
#define PREFIX(name) _##name
#else
#define PREFIX(name) name
#endif

#define SYS_V0V(name, i) void PREFIX(name)() \
 { return syscalls[i].vcall0v(); }
#define SYS_I0V(name, i) int PREFIX(name)() \
 { return syscalls[i].icall0i(); }
#define SYS_I1I(name, i) int PREFIX(name)(int a)\
 { return syscalls[i].icall1i(a); }
#define SYS_I2I(name, i) int PREFIX(name)(int a, int b)\
 { return syscalls[i].icall2i(a, b); }
#define SYS_I3I(name, i) int PREFIX(name)(int a, int b, int c)\
 { return syscalls[i].icall3i(a, b, c); }
#define SYS_I4I(name, i) int PREFIX(name)(int a, int b, int c, int d)\
 { return syscalls[i].icall4i(a, b, c, d); }
#define SYS_I5I(name, i) int PREFIX(name)(int a, int b, int c, int d, int e)\
 { return syscalls[i].icall5i(a, b, c, d, e); }
#define SYS_I6I(name, i) int PREFIX(name)(int a, int b, int c, int d, int e, int f)\
 { return syscalls[i].icall6i(a, b, c, d, e, f); }
#define SYS_V1P1(name, i) void PREFIX(name)(void *ptr) \
 { return syscalls[i].vcall1p(ptr); }
#define SYS_P1I(name, i) void *PREFIX(name)(unsigned int size) \
 { return syscalls[i].pcall1i(size); }
#define SYS_P1P1I1(name, i) void *PREFIX(name)(void *pointer, int size) \
 { return syscalls[i].pcall1p1i(pointer, size); }
#define SYS_I1P(name, i) int PREFIX(name)(void *pointer) \
 { return syscalls[i].icall1p(pointer); }
#define SYS_I6P(name, i) int PREFIX(name)(void *p1, void *p2, void *p3, void *p4, void *p5, void *p6) \
 { return syscalls[i].icall6p(p1, p2, p3, p4, p5, p6); }

#define ESYS_I4I(name, i) int PREFIX(name)(int a, int b, int c, int d)\
 { int ret = syscalls[i].icall4i(a, b, c, d); if (ret) errno = -ret; return ret;}
#define ESYS_I3I(name, i) int PREFIX(name)(int a, int b, int c)\
 { int ret = syscalls[i].icall3i(a, b, c); if (ret) errno = -ret; return ret;}
#define ESYS_I2I(name, i) int PREFIX(name)(int a, int b)\
 { int ret = syscalls[i].icall2i(a, b); if (ret) errno = -ret; return ret;}
#define ESYS_I1I(name, i) int PREFIX(name)(int a)\
 { int ret = syscalls[i].icall1i(a); if (ret) errno = -ret; return ret;}

#define STUB(name) void PREFIX(name)(){}

#ifdef PREFIX_DEFINED
SYS_I1I(exit, SYS_EXIT);
#else
SYS_I1I(_exit, SYS_EXIT);
#endif
//void exit(int status) {
  //deal with cleanup stuff later
//  _exit(status);
//}

ESYS_I3I(read, SYS_READ);
ESYS_I3I(write, SYS_WRITE);
ESYS_I1I(opendir, SYS_OPENDIR);
ESYS_I1I(closedir, SYS_CLOSEDIR);
ESYS_I1I(readdir, SYS_READDIR);
ESYS_I1I(opendir_inode, SYS_OPENDIR_INODE);
SYS_I1I(pipe, SYS_PIPE);
SYS_I1I(wait, SYS_WAIT);
SYS_I1I(waitpid, SYS_WAITPID);
SYS_P1I(_pmalloc, SYS_PMALLOC);
SYS_I1I(_pfree, SYS_PFREE);
ESYS_I1I(flush, SYS_FLUSH);
SYS_I0V(keyboard_poll, SYS_KEYBOARD_POLL);
SYS_I1I(keyboard_isprint, SYS_KEYBOARD_ISPRINT);
SYS_I1I(keyboard_handle_case, SYS_KEYBOARD_HANDLE_CASE);
SYS_I0V(keyboard_casepoll, SYS_KEYBOARD_CASEPOLL);
SYS_I6P(posix_spawn, SYS_POSIX_SPAWN);
ESYS_I2I(open, SYS_FILE_OPEN);
SYS_I1P(close, SYS_FILE_CLOSE);
SYS_I1P(chdir, SYS_CHANGEDIR);
SYS_P1P1I1(getcwd, SYS_GETCWD);
SYS_V0V(task_yield, SYS_THREAD_YIELD);
SYS_I0V(getpid, SYS_GETPID);
SYS_I1I(ktesterfunc, SYS_KTESTERFUNC);
SYS_I3I(shm_open, SYS_SHM_OPEN); //XXX 64-bit type error!
SYS_I6I(mmap, SYS_MMAP); //XXX 64-bit type error!
SYS_I2I(munmap, SYS_MUNMAP); //XXX 64-bit type error!
ESYS_I2I(ftruncate, SYS_FTRUNCATE); //XXX 64-bit type error!
SYS_I3I(dmesg_read, SYS_DMESG_READ); //XXX 64-bit type error!
ESYS_I3I(lseek, SYS_LSEEK);
ESYS_I4I(pread, SYS_PREAD);
SYS_I0V(dmesg_size, SYS_DMESG_SIZE);
ESYS_I2I(stat, SYS_STAT); //XXX 64-bit type error!

int e9printf(char *fmt, ...) {
  va_list va;
  int (*ve9printf)(char *fmt, ...) = (void*) syscalls[SYS_VE9PRINTF].vcall0v;
  
  va_start(va, fmt);
  int ret = ve9printf(fmt, va);
  va_end(va);
  
  return ret;
}

#endif
