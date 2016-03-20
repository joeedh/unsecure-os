#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/string.h"
#include "../libc/stdlib.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../task/process.h"
#include "../task/process_management.h"

#include "../userinclude/wait.h"

#include "../drivers/fs/fs_file.h"
#include "../drivers/tty/tty.h"
#include "../drivers/keyboard/keyboard.h"

#define SYSCALL_INTERN
#include "syscalls.h"

#define SYSCALL(call) call

void *pmallocwrap(int size) {
  return pmalloc(size);
}

void pfreewrap(void *mem) {
  pfree(mem);
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
  SYSCALL(pmallocwrap),
  SYSCALL(pfreewrap),
  SYSCALL(flush),
  SYSCALL(keyboard_poll),
  SYSCALL(keyboard_isprint),
  SYSCALL(keyboard_handle_case),
  SYSCALL(posix_spawn),
  SYSCALL(open),
  SYSCALL(close)
};

int _totsyscalls = sizeof(_syscalltable) / sizeof(void*);