#ifndef __KERNEL_BUILD__
#include "stdio.h"
#include "../syscalls/syscalls.h"

extern int main(int argc, char **argv);

unsigned char **env;

FILE *stdin, *stdout, *stderr;
FILE _stdin, _stdout, _stderr;
SysCallPtr *syscalls;

int _start(SysCallPtr *calltable, int sin, int sout, 
           int serr, char **argv, char **envv) 
{
  syscalls = calltable;
  
  env = envv;
  
  stdin = &_stdin;
  stdout = &_stdout;
  stderr = &_stderr;
  
  stdin->fd = sin, stdout->fd = sout, stderr->fd = serr;
  
  int argc = 0;
  while (argv[argc]) {
    argc++;
  }
  
  return main(argc, argv);
}
#endif
