#include "process.h"
#include "task.h"

#include "../io.h"
#include "../interrupts.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "../libc/list.h"
#include "../drivers/keyboard/keyboard.h"
#include "../drivers/tty/tty.h"
#include "../drivers/fs/memfile.h"
#include "../task/task.h"
#include "../timer.h"

volatile List running_processes, finishing_processes;
volatile unsigned int pidgen;
volatile Process *curproc;

void process_initialize() {
  pidgen = 1;
}

Process *process_from_pid(intptr_t pid) {
  asm("CLI");
  Process *p = NULL;
  
  for (p=running_processes.first; p; p=p->next) {
    if (p->pid == pid) {
      break;
    }
  }
  
  asm("STI");
  return p;
}

Process *process_get_current() {
  asm("CLI");
  volatile intptr_t pid = k_curtaskp->pid;
  
  kprintf("pid: %x\n", pid);
  
  Process *p = NULL;
  
  for (p=running_processes.first; p; p=p->next) {
    kprintf("  pid2: %x\n", p->pid);
    
    if (p->pid == pid) {
      break;
    }
  }
  
  asm("STI");
  return p;
  
/*
//kindof a bit stupid. . .searches process threads
//for one whose pid matches k_curtaskp->pid

  Process *p = NULL;
  
  for (p=running_processes.first; p; p=p->next) {
    LinkNode *t;
    
    for (t=p->threads.first; t; t=t->next) {
      unsigned int tid = (unsigned int)t->data;
      
      if (tid == k_curtaskp->tid) {
        return p;
      }
    }
  }
  
  asm("STI");
  return NULL;
  */
}

int process_get_stdin(Process *p) {
  return p ? p->stdin : -1;
}

int process_get_stdout(Process *p) {
  return p ? p->stdout : -1;
}

int process_get_stderr(Process *p) {
  return p ? p->stderr : -1;
}

static void _nullop_proc_finishfunc(int retval, int tid, int pid) {
}

//returns. . .pid?
Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv)) {
  Process *process = kmalloc(sizeof(Process));

  memset(process, 0, sizeof(Process));
  
  process->stdin = 0; 
  process->stdin = 0;
  process->entryfunc = main;
  process->pid = pidgen++;
  process->finishfunc = _nullop_proc_finishfunc;
  process->state = 0;
  
  process->argv = argv;
  process->argc = argc;
  
  strncpy(process->name, name, sizeof(process->name));
  
  return process;
}

int process_set_stdout(Process *process, int stdout) {
  process->stdout = stdout;
  return 0;
}

int process_set_stderr(Process *process, int stderr) {
  process->stderr = stderr;
  return 0;
}

int process_set_stdin(Process *process, int stdin) {
  process->stdin = stdin;
  return 0;
}

int process_set_finish(Process *process, void *finishfunc) {
  process->finishfunc = finishfunc;
  return 0;
}

void _process_finish(int retval, int tid, int pid) {
  Process *p = process_from_pid(pid);
  
  if (!p) {
    asm("CLI");
    
    kprintf("KERNEL ERROR: process_from_pid returned NULL!\n");
    kprintf("    reval: %x, tid: %x, pid: %x\n");
    
    asm("STI");
    return;
  }
  
  unsigned int state = safe_entry();

  p->state &= ~PROC_RUNNING;
  
  klist_remove((List*)&running_processes, p);
  klist_append((List*)&finishing_processes, p);

  safe_exit(state);
  p->finishfunc(retval, tid, pid);  
}

int process_start(Process *process) {
  LinkNode *thread = kmalloc(sizeof(LinkNode));
  
  if (process->stdin == 0) {
    process->stdin = kmemfile_create(DEFAULT_STDFILE_SIZE);
  }
  if (process->stdout == 0) {
    process->stdout = kmemfile_create(DEFAULT_STDFILE_SIZE);
  }
  if (process->stderr == 0) {
    process->stderr = kmemfile_create(DEFAULT_STDFILE_SIZE);
  }
  
  process->state |= PROC_RUNNING;
  
  klist_append((List*)&running_processes, process);
  klist_append((List*)&process->threads, thread);

  thread->data = (void*)spawn_task(process->argc, process->argv, process->entryfunc, _process_finish, process->pid);
  
  return 0;
}

int process_close(Process *process) {
  unsigned int state = safe_entry();

  if (process->state & PROC_ZOMBIE) {
    safe_exit(state);
    return -1;
  }

  //XXX do cleanup stuff!
  if (process->state & PROC_RUNNING) {
    klist_remove((List*)&running_processes, process);
  } else {
    klist_remove((List*)&finishing_processes, process);
  }

  process->state |= PROC_ZOMBIE;
  process->state &= ~PROC_RUNNING;
  
  safe_exit(state);
  
  return 0;
}

int process_wait(Process *process) {
  //XXX implement me!
  kprintf("process_wait(): implement me!\n");
  
  while (process->state & PROC_RUNNING) {
  }
  
  return -1;
}
