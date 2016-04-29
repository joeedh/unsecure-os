#include <stdint.h>
#include "drivers/fs/fs_interface.h"
#include "drivers/fs/fs_file.h"
#include "drivers/fs/dirent.h"
#include "drivers/blockdevice/blockdevice.h"
#include "libc/stdio.h"
#include "libc/kmalloc.h"
#include "libc/path.h"
#include "loader/elfloader.h"
#include "interrupts.h"
#include "debug.h"

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"
#include "task/process.h"
#include "task/process_management.h"
#include "syscalls/syscalls.h"

#include "libc/stdlib.h"

int kcli_finish(int retval, int tid, int pid) {
  Process *p = process_from_pid(pid, 0);
  
  if (p) {
    process_close(p);
  }
  
  return 0;
}

int kcli_exec(char *name, int argc, char **argv, int (*main)(int argc, char **argv), int wait) 
{
  interrupts_enable();
  //uintptr_t addr = (uintptr_t)main;
  
  //return -1; //XXX
  
  Process *proc = spawn_process(name, argc, argv, main);
  Process *self = process_get_current(0);
  
  process_set_stdin(proc, process_get_stdin(self));
  process_set_stdout(proc, process_get_stdout(self));
  process_set_stderr(proc, process_get_stderr(self));
  
  //if (!wait) {
  process_set_finish(proc, kcli_finish);
  //}
  
  process_start(proc);
  
  if (wait) {
    //process_wait(proc);
    //process_close(proc);
  }
  
  return 0;
}

static int spawn_shell(FILE *stdout) {
  char buf2[256];
  char *argv[MAX_ARGV];
  char *envp[1] = {NULL};
  int pid;

  sprintf(buf2, "/bin/sh /");
  
  fprintf(stdout, "executing: %s\n\n", buf2);
  fflush(stdout);
  
  int argc = shlex((char*) buf2, argv);
  if (argc <= 0) {
    return -1;
  }

  if (posix_spawn(&pid, argv[0], NULL, NULL, argv, envp) != 0) {
    fprintf(stdout, "error executing /bin/sh!\n");
  }
  
  return 0;
}

int kcli_main(int argc, char **argv) {
  e9printf("Started kcli_main\n");
  
  //kprintf(" stdout: %d\n\n", process_get_stdout());
  Process *proc = process_get_current(0);
  e9printf("proc: %p\n", proc);
  
  //make libc wrapper of stdout/stderr
  FILE _file = {proc->stdout};
  //FILE _errfile = {proc->stderr};
  
  FILE *stdout = &_file;
  //FILE *stderr = &_errfile;
 
  debug_check_interrupts();
  
  //spawn shell
  spawn_shell(stdout);
  
  while (1) {
    int printcode;
    int hadcode = 0;
    int _i=0;
    
    while (_i++ < 100) {
      //printcode = fgetc(stderr);
      //if (printcode == EOF)
      printcode = fgetc(stdout);
      
      if (printcode != EOF) {
        terminal_putchar(printcode);
        hadcode = 1;
      }
    }
    
    if (hadcode) {
      terminal_flush();
    }
    
    task_yield();
  }
}
