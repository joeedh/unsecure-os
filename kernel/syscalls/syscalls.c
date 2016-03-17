#include "../libc/libc.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/string.h"
#include "../libc/stdlib.h"
#include "../libc/ctype.h"
#include "../task/process.h"
#include "wait.h"
#include "../drivers/fs/fs_file.h"
#include "../drivers/tty/tty.h"

#define SYSCALL(call) {call, #call}

struct {
  void *syscall;
  char *name;
} syscalls[] = {
  SYSCALL(exit),
  SYSCALL(read),
  SYSCALL(write),
  SYSCALL(openir),
  SYSCALL(closedir),
  SYSCALL(readdir),
  SYSCALL(opendir_inode),
  SYSCALL(pipe),
  SYSCALL(wait),
  SYSCALL(waitpid),  
};
