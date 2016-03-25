#ifndef _KPROCESS_H
#define _KPROCESS_H

#include "../timer.h"
#include "task.h"
#include "../io.h"
#include "../libc/list.h"
#include "lock.h"
#include "rwlock.h"

#define MAX_PROC_THREADS 32
#define DEFAULT_STDFILE_SIZE 1024*32

enum {
  PROC_RUNNING = 1,
  PROC_ZOMBIE = 2
};

//keep in sync with PROCESS_SIZE in asm/definitions.nasm!
typedef struct Process {
  struct Process *next, *prev;
  
  volatile int pid;
  char name[32];
  char calling_path[32];
  char working_path[256];
  
  int (*entryfunc)(int argc, char **argv);
  void (*finishfunc)(int retval, int tid, int pid);
  
  int argc;
  char **argv, **environ;
  
  volatile int stdin, stdout, stderr;
  RWLock resource_lock;
  RWLock environ_lock;
  
  void *exec_image;
  
  List memory; //list of MemNodes references (via LinkNodes)
  List open_files;
  List threads;
  List childprocs;
  
  volatile int flags, state;
  volatile int retval, used;
} Process;

void process_initialize();

int process_set_stdout(Process *process, int stdout);
int process_set_stderr(Process *process, int stderr);
int process_set_stdin(Process *process, int stdin);
Process *process_from_pid(intptr_t pid, int skiplocks);

Process *process_get_current();
int process_get_stdin(Process *p);
int process_get_stdout(Process *p);
int process_get_stderr(Process *p);
  
Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv));
int process_start(Process *process);

int process_set_finish(Process *process, void *finishfunc);
int process_wait(Process *process);
int process_close(Process *process);

struct FILE;
int print_procs(struct FILE *file);

int exit(int retval);

#endif /* _KPROCESS_H */
