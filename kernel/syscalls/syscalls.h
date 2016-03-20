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
  
  int (*icall1p)(void *pointer);
  int (*icall6p)(void *p1, void *p2, void *p3, void *p4, void *p5, void *p6);
  
  //for memory allocation
  intptr_t (*pcall0i)();
  void *(*pcall1i)(int a);
  void (*vcall1i)(intptr_t ptr);
} SysCallPtr;

#ifdef __KERNEL_BUILD__
#ifndef SYSCALL_INTERN
extern SysCallPtr _syscalltable[];
extern int _totsyscalls;
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
  SYS_PMALLOC,
  SYS_PFREE,
  SYS_FLUSH,
  SYS_KEYBOARD_POLL,
  SYS_KEYBOARD_ISPRINT,
  SYS_KEYBOARD_HANDLE_CASE,
  SYS_POSIX_SPAWN,
  SYS_FILE_OPEN,
  SYS_FILE_CLOSE
};

#endif /* _SYSCALLS_H */
