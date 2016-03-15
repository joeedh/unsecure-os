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
#include "../task/lock.h"
#include "../timer.h"

List running_processes, finishing_processes;
volatile unsigned int pidgen;
volatile Process *curproc;
static Lock plock;

static Process kernelproc;
static LinkNode kernelproc_thread;

extern Process processes[MAX_TASKS];

static void _nullop_proc_finishfunc(int retval, int tid, int pid) {
}

void process_initialize() {
  pidgen = 1;
  klock_init(&plock);
  
  memset(processes, 0, sizeof(processes));
  memset(&running_processes, 0, sizeof(running_processes));
  memset(&finishing_processes, 0, sizeof(finishing_processes));
  
  //create main process
  Process *process = &kernelproc;

  memset(process, 0, sizeof(Process));

  process->pid = 0;
  process->state = PROC_RUNNING;
  process->finishfunc = _nullop_proc_finishfunc;
  
  LinkNode *node = &kernelproc_thread;
  node->data = (Task*) k_curtaskp; //initial thread
  
  klist_append(&running_processes, process);
  klist_append(&process->threads, node);
}

Process *process_from_pid(intptr_t pid) {
  klock_lock(&plock);
  unsigned int state = safe_entry();
  
  Process *p = NULL;
  for (p=running_processes.first; p; p=p->next) {
    if (p->pid == pid) {
      break;
    }
  }
  
  safe_exit(state);
  klock_unlock(&plock);
  
  return p;
}

Process *process_get_current() {
  klock_lock(&plock);
  unsigned int state = safe_entry();
  
  volatile intptr_t pid = k_curtaskp->pid;
  
  //kprintf("pid: %x\n", pid);
  
  Process *p = NULL;
  
  for (p=running_processes.first; p; p=p->next) {
    //kprintf("  pid2: %x\n", p->pid);
    
    if (p->pid == pid) {
      break;
    }
  }
  
  safe_exit(state);
  klock_unlock(&plock);
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


static Process *alloc_process() {
  klock_lock(&plock);
  unsigned int state = safe_entry(); //disable interrupts;
  Process *p = NULL;
  int i = 0;
  
  for (i=0; i<MAX_TASKS; i++) {
    if (!processes[i].used) {
      p = processes + i;
      p->used = 1;
      break;
    }
  }
  
  if (i == MAX_TASKS) {
    klock_unlock(&plock);
    safe_exit(state);

    kerror(0, "Hit maximum number of processors!");
    return NULL;
  }
  
  klock_unlock(&plock);
  safe_exit(state);
  
  return processes + i;
}

static void free_process(Process *p) {
  klock_lock(&plock);
  unsigned int state = safe_entry(); //disable interrupts;
  
  //clear p->used
  p->used = 0;
  
  klock_unlock(&plock);
  safe_exit(state);
}

//returns. . .pid?
Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv)) {
  klock_lock(&plock);
  unsigned int state = safe_entry();
  
  Process *process = alloc_process(); //kmalloc(sizeof(Process));

  memset(process, 0, sizeof(Process));

  process->retval = 0;
  process->stdin = 0; 
  process->stdin = 0;
  process->entryfunc = main;
  process->pid = pidgen++;
  process->finishfunc = _nullop_proc_finishfunc;
  process->state = 0;
  
  process->argv = argv;
  process->argc = argc;
  
  strncpy(process->name, name, sizeof(process->name));
  
  safe_exit(state);
  klock_unlock(&plock);
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
  klock_lock(&plock);
  unsigned int state = safe_entry();

  Process *p = process_from_pid(pid);

  if (!p) {
    kprintf("    reval: %x, tid: %x, pid: %x\n", retval, tid, pid);
    kprintf("KERNEL ERROR: process_from_pid returned NULL!\n");
    
    safe_exit(state);
    klock_unlock(&plock);
    return;
  }

  p->state &= ~PROC_RUNNING;
  
  klist_remove((List*)&running_processes, p);
  klist_append((List*)&finishing_processes, p);

  p->retval = retval;

  safe_exit(state);
  klock_unlock(&plock);
  p->finishfunc(retval, tid, pid);  
}

int process_start(Process *process) {
  klock_lock(&plock);
  volatile unsigned int state = safe_entry();
  
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

  //kprintf("  argc  : %x\n", process->argc);
  //kprintf("  argv  : %x\n", process->argv);
  //kprintf("  main  : %x\n", process->entryfunc);
  //kprintf("  finish: %x\n", _process_finish);
  //kprintf("  pid   : %x\n", process->pid);
  
  safe_exit(state);
  klock_unlock(&plock);
  
  thread->data = (void*)spawn_task(process->argc, process->argv, process->entryfunc, _process_finish, process->pid);
  
  return 0;
}

int process_close(Process *process) {
  klock_lock(&plock);
  unsigned int state = safe_entry();

  if (process->state & PROC_ZOMBIE) {
    safe_exit(state);
    klock_unlock(&plock);
    return -1;
  }

  //kill running threads
  LinkNode *node, *next;
  for (node = process->threads.first; node; node=next) {
    next = node->next;
    Task *task = node->data;
    
    if (task->flag != TASK_DEAD) {
      task_destroy(task, process->retval, 0);
    }
    
    kfree(node);
  }
  
  process->threads.first = process->threads.last = NULL;
  
  //XXX do cleanup stuff!
  if (process->state & PROC_RUNNING) {
    klist_remove((List*)&running_processes, process);
  } else {
    klist_remove((List*)&finishing_processes, process);
  }

  process->state |= PROC_ZOMBIE;
  process->state &= ~PROC_RUNNING;
  
  free_process(process); //kfree(process);
  
  safe_exit(state);
  klock_unlock(&plock);
  
  return 0;
}

int process_wait(Process *process) {
  while (process->state & PROC_RUNNING) {
  }
  
  return 0;
}
