#ifndef _SYSCALLS_H
#define _SYSCALLS_H

#include <stddef.h>
#include <stdint.h>

typedef union {
  int (*icall0i)(void);
  int (*icall1i)(int a);
  int (*icall2i)(int a, int b);
  int (*icall3i)(int a, int b, int c);
  int (*icall4i)(int a, int b, int c, int e);
  int (*icall5i)(int a, int b, int c, int e, int d);
  
  //for memory allocation
  intptr_t (*pcall0i)();
  intptr_t (*pcall1i)(int a);
  void (*vcall1i)(intptr_t ptr);
} SysCallPtr;

#ifdef __KERNEL_BUILD__
#ifndef SYSCALL_INTERN
extern SysCallPtr _syscalltable[];
#endif
#endif

enum {
  SYS_EXIT,
  SYS_READ,
  SYS_WRITE,
  SYS_OPENDIR,
  SYS_CLOSEDIR,
  SYS_READDIR,
  SYS_OPENDIR_INODE,
  SYS_PIPE,
  SYS_WAIT,
  SYS_WAITPID,
  SYS_KMALLOC,
  SYS_KFREE,
  SYS_FLUSH,
  //SYS_ERRNO
};

#endif /* _SYSCALLS_H */
