#ifndef __KERNEL_BUILD__
#include "stdio.h"
#include "../syscalls/syscalls.h"

extern int main(int argc, char **argv);
extern void libc_initialize();

unsigned char **environ;

FILE *stdin, *stdout, *stderr;
FILE _stdin, _stdout, _stderr;
SysCallPtr *syscalls;
int errno;

int _start(SysCallPtr *calltable, int sin, int sout, 
           int serr, char **argv, char **envv) 
{
  syscalls = calltable;
  
  environ = (unsigned char**) envv;
  
  errno = 0;
  stdin = &_stdin;
  stdout = &_stdout;
  stderr = &_stderr;
  
  stdin->fd = sin, stdout->fd = sout, stderr->fd = serr;
  
  int argc = 0;
  while (argv[argc]) {
    argc++;
  }
  
  libc_initialize();
  
  return main(argc, argv);
}
#endif
