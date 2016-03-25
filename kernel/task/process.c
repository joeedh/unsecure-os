#include "process.h"
#include "process_management.h"
#include "task.h"

#include "../definitions/memory.h"

#include "../io.h"
#include "../interrupts.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "../libc/list.h"
#include "../libc/stdio.h"

#include "../drivers/keyboard/keyboard.h"
#include "../drivers/tty/tty.h"
#include "../drivers/fs/memfile.h"
#include "../task/task.h"
#include "../task/lock.h"
#include "../task/rwlock.h"
#include "../timer.h"

#define PROCESS_DEBUG

#ifdef PROCESS_DEBUG
  #define procdebug(...) e9printf(__VA_ARGS__)
#else
  #define procdebug(...)
#endif

List running_processes, finishing_processes;
volatile unsigned int pidgen;

RWLock _procsys_lock = LOCK_INIT;

static Process kernelproc;
static LinkNode kernelproc_thread;

extern Process processes[MAX_TASKS];
static int used_processes[MAX_TASKS] = {0,};

//caches return status of recently finish processes
#define RETCACHE_SIZE 8192
static volatile int retcache[RETCACHE_SIZE*2];
static volatile unsigned int retcache_cur;
static RWLock retcache_lock;

static void _nullop_proc_finishfunc(int retval, int tid, int pid) {
}

void process_initialize() {
  memset(retcache, 0, sizeof(retcache));
  retcache_cur = 0;
  krwlock_init(&retcache_lock);
  
  pidgen = 1;
  krwlock_init(&_procsys_lock);
  
  memset(used_processes, 0, sizeof(used_processes));
  memset(processes, 0, sizeof(processes));
  memset(&running_processes, 0, sizeof(running_processes));
  memset(&finishing_processes, 0, sizeof(finishing_processes));
  
  //create main process
  Process *process = &kernelproc;
  
  //k_curtaskp should already exist and point at main thread
  k_curtaskp->proc = process;
  
  memset(process, 0, sizeof(Process));

  process->pid = 0;
  process->state = PROC_RUNNING;
  process->finishfunc = _nullop_proc_finishfunc;
  
  LinkNode *node = &kernelproc_thread;
  node->data = (Task*) k_curtaskp->tid; //initial thread
  
  klist_append(&running_processes, process);
  klist_append(&process->threads, node);
  
  used_processes[0] = 1;
}

Process *process_from_pid(intptr_t pid, int ignorelock) {
  if (!ignorelock) {
    krwlock_rlock(&_procsys_lock);
  }
  
  Process *p = NULL;
  for (p=running_processes.first; p; p=p->next) {
    if (p->pid == pid) {
      break;
    }
  }
  
  if (!ignorelock) {
    krwlock_unrlock(&_procsys_lock);
  }
  
  return p;
}

Process *process_get_current() {
  volatile unsigned int state = safe_entry();

  Process *ret = (Process*) k_curtaskp->proc;

  safe_exit(state);
  return ret;
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
  krwlock_lock(&_procsys_lock);
  
  Process *p = NULL;
  int i = 0;
  
  for (i=0; i<MAX_TASKS; i++) {
    if (!used_processes[i]) {
      p = processes + i;
      p->used = 1;
      
      used_processes[i] = 1;
      break;
    }
  }
  
  if (i == MAX_TASKS) {
    krwlock_unlock(&_procsys_lock);

    e9printf("Hit maximum number of processes!\n");
    return NULL;
  }
  
  krwlock_unlock(&_procsys_lock);
  return processes + i;
}

static void free_process(Process *p) {
  krwlock_lock(&_procsys_lock);
  int found = 0;
  
  for (int i=0; i<MAX_TASKS; i++) {
    if (processes + i == p) {
      found = 1;
      used_processes[i] = 0;
      break;
    }
  }
  
  if (!found) {
    krwlock_unlock(&_procsys_lock);
  
    e9printf("FAILED TO FREE PROCESS STRUCT\n");
    return;
  }
  
  //clear p->used
  p->used = 0;
  
  krwlock_unlock(&_procsys_lock);
}

//returns. . .pid?
Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv)) {
  procdebug("creating new process\n");
  
  krwlock_lock(&_procsys_lock);
  
  Process *process = alloc_process(); //kmalloc(sizeof(Process));

  memset(process, 0, sizeof(Process));

  krwlock_init(&process->resource_lock);
  
  process->used = 1;
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
  
  krwlock_unlock(&_procsys_lock);
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
  krwlock_lock(&_procsys_lock);

  procdebug("process finish: retval: %d, tid: %d, pid: %d\n", retval, tid, pid);
  
  Process *p = process_from_pid(pid, 0);

  int didlock = 0;
  
  if (have_interrupts()) {
    didlock = 1;
    krwlock_lock(&retcache_lock);
  }
  
  //cache pid for if we need it later
  retcache[retcache_cur++] = pid;
  retcache[retcache_cur++] = retval;
  retcache_cur = retcache_cur % (RETCACHE_SIZE*2);
  //
  
  if (didlock) {
    krwlock_unlock(&retcache_lock);
  }
  
  if (!p) {
    e9printf("    reval: %x, tid: %x, pid: %x\n", retval, tid, pid);
    e9printf("KERNEL ERROR: process_from_pid returned NULL!\n");
    
    krwlock_unlock(&_procsys_lock);
    return;
  }

  p->state &= ~PROC_RUNNING;
  
  klist_remove((List*)&running_processes, p);
  klist_append((List*)&finishing_processes, p);

  p->retval = retval;

  krwlock_unlock(&_procsys_lock);
  p->finishfunc(retval, tid, pid);  
}

int process_start(Process *process) {
  krwlock_lock(&_procsys_lock);
  
  procdebug("starting process. . .\n");
  
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

  //e9printf("  argc  : %x\n", process->argc);
  //e9printf("  argv  : %x\n", process->argv);
  //e9printf("  main  : %x\n", process->entryfunc);
  //e9printf("  finish: %x\n", _process_finish);
  //e9printf("  pid   : %x\n", process->pid);
  
  krwlock_unlock(&_procsys_lock);
  
  procdebug("spawning process task. . .\n");
  thread->data = (void*) spawn_task(process->argc, process->argv, process->entryfunc, _process_finish, process);
  
  return 0;
}

int process_close(Process *process) {
  krwlock_lock(&_procsys_lock);

  if (process->state & PROC_ZOMBIE) {
    krwlock_unlock(&_procsys_lock);
    return -1;
  }

  //kill running threads
  LinkNode *node, *next;
  for (node = process->threads.first; node; node=next) {
    next = node->next;
    task_destroy((int)node->data, process->retval, 0);
    
    kfree(node);
  }
  
  process->threads.first = process->threads.last = NULL;
  
  //free any remaining allocated memory
  pfreeall(process);
  
  if (process->state & PROC_RUNNING) {
    klist_remove((List*)&running_processes, process);
  } else {
    klist_remove((List*)&finishing_processes, process);
  }

  process->state |= PROC_ZOMBIE;
  process->state &= ~PROC_RUNNING;
  
  free_process(process); //kfree(process);
  
  krwlock_unlock(&_procsys_lock);
  
  return 0;
}

int print_procs(FILE *file) {
  krwlock_rlock(&_procsys_lock);
  unsigned char **lines = NULL;
  int totline = 0, totused=0;
  
  for (Process *proc = running_processes.first; proc; proc=proc->next) {
    if (totline >= totused) {
      totused = (totused + 1)*2;
      lines = krealloc(lines, totused*sizeof(void*));
    }
    
    unsigned char *buf = kmalloc(256);
    strcpy(buf, proc->name);
    buf[255] = 0;
    
    lines[totline++] = buf;
  }
  krwlock_unrlock(&_procsys_lock);
  
  fprintf(file, "=========Running processes============\n");
  for (int i=0; i<totline; i++) {
    fprintf(file, "\t%s\n", lines[i]);
    kfree(lines[i]);
  }
  fprintf(file, "\n");
  
  kfree(lines);
  
  return 0;
}

int process_wait(Process *process) {
  while (process->state & PROC_RUNNING) {
  }
  
  return 0;
}

int wait(int *stat_loc) {
  return 0;
}

static int _find_retval(int pid, int *pidout) {
  int dolock = have_interrupts();
  int ret, found=0;
  
  if (dolock) {
    krwlock_rlock(&retcache_lock);
  }
  
  for (int i=0; i<RETCACHE_SIZE; i++) {
    int j = (retcache_cur - i*2 + RETCACHE_SIZE*2) % (RETCACHE_SIZE*2);
    
    if (retcache[j] == pid) {
      ret = retcache[j+1];
      found = 1;
      
      break;
    }
  }
  
  if (dolock) {
    krwlock_unrlock(&retcache_lock);
  }
  
  if (found)
    *pidout = ret;
  else
    *pidout = 0;
  
  return !found ? -1 : 0;
}

int waitpid(int pid, int *stat_loc, int options) {
  if (!stat_loc)
    return -1;

  Process *p = process_from_pid(pid, 0);
  
  if (!p) {
    return _find_retval(pid, stat_loc);
  }
  
  while (p->state & PROC_RUNNING) {
  }
  
  int ret = -1;
  
  interrupts_disable();
  
  if ((p = process_from_pid(pid, 1))) {
    ret = p->retval;
  } else {
    interrupts_enable();
    return _find_retval(pid, stat_loc);
  }
  
  interrupts_enable();
  
  *stat_loc = ret;
  return 0;
}

FILE *popen(const char *command, const char *mode) {
  return NULL;
}

int exit(int retval) {
  e9printf("implement me!\n");
  return 0; //implement me!
}
