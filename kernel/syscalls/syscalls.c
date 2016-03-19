#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/string.h"
#include "../libc/stdlib.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../task/process.h"
#include "wait.h"
#include "../drivers/fs/fs_file.h"
#include "../drivers/tty/tty.h"

#define SYSCALL_INTERN
#include "syscalls.h"

#define SYSCALL(call) call

void *kmallocwrap(int size) {
  return kmalloc(size);
}

void kfreewrap(void *mem) {
  kfree(mem);
}

void *_syscalltable[] = {
  SYSCALL(exit),
  SYSCALL(read),
  SYSCALL(write),
  SYSCALL(opendir),
  SYSCALL(closedir),
  SYSCALL(readdir),
  SYSCALL(opendir_inode),
  SYSCALL(pipe),
  SYSCALL(wait),
  SYSCALL(waitpid),
  SYSCALL(kmallocwrap),
  SYSCALL(kfreewrap),
  SYSCALL(flush)
};
