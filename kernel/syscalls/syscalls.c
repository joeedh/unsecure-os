#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/string.h"
#include "../libc/stdlib.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../task/process.h"
#include "../task/process_management.h"
#include "../task/task.h"
#include "../task/rwlock.h"
#include "../userinclude/wait.h"

#include "../drivers/fs/fs_file.h"
#include "../drivers/fs/unistd.h"
#include "../drivers/tty/tty.h"
#include "../drivers/keyboard/keyboard.h"

#include "../SudoBios.h"
#include "../sharedmem/shm.h"
#include "../dmesg/dmesg.h"

#define SYSCALL_INTERN
#include "syscalls.h"

#define SYSCALL(call) call

extern RWLock _procsys_lock;

void *pmallocwrap(int size) {
  return pmalloc(size);
}

void pfreewrap(void *mem) {
  pfree(mem);
}

/*
int popenwrap(unsigned char *path, int mode) {
  int ret = open(path, mode);
  
  if (ret < 0) {
    return ret;
  }
  
  krwlock_rlock(&_procsys_lock);
  
  Process *p = process_get_current(1);
  
  LinkNode *node = kmalloc(sizeof(LinkNode));
  node->data = (void*)ret;
  klist_append(&p->open_files, node);
  
  krwlock_unrlock(&_procsys_lock);
}//*/

/*Scratch syscall for testing various things*/
int ktesterfunc(int arg) {
  return SBIOS_CallBios(arg);
}

/*I thought of doing this with formal dynamic linking.
  but then, would I be able to turn it into a real syscall
  system?  not sure elf can do that*/  
void *_syscalltable[] = {
  SYSCALL(_exit),
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
  SYSCALL(keyboard_casepoll),
  SYSCALL(posix_spawn),
  SYSCALL(open),
  SYSCALL(close),
  SYSCALL(chdir),
  SYSCALL(getcwd),
  SYSCALL(task_yield),
  SYSCALL(vs_e9printf),
  SYSCALL(getpid),
  SYSCALL(ktesterfunc),
  SYSCALL(shm_open),
  SYSCALL(mmap),
  SYSCALL(munmap),
  SYSCALL(ftruncate),
  SYSCALL(dmesg_read),
  SYSCALL(lseek),
  SYSCALL(pread),
  SYSCALL(dmesg_size),
  SYSCALL(stat),
  SYSCALL(clock)
};

int _totsyscalls = sizeof(_syscalltable) / sizeof(void*);