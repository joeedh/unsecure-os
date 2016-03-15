#ifndef _KPROCESS_H

#include "../timer.h"
#include "task.h"
#include "../io.h"
#include "../libc/list.h"

#define MAX_PROC_THREADS 32
#define DEFAULT_STDFILE_SIZE 1024*32

enum {
  PROC_RUNNING = 1,
  PROC_ZOMBIE = 2
};

typedef struct Process {
  struct Process *next, *prev;
  
  volatile int pid;
  char name[32];
  char calling_path[32];
  char working_path[256];
  
  volatile void *entryfunc;
  void (*finishfunc)(int retval, int tid, int pid);
  
  int argc;
  char **argv;
  
  volatile int stdin, stdout, stderr;
  
  List memory; //list of MemNode references
  List open_files;
  List threads;
  
  volatile int flags, state;
  volatile int retval, used;
} Process;

void process_initialize();

int process_set_stdout(Process *process, int stdout);
int process_set_stderr(Process *process, int stderr);
int process_set_stdin(Process *process, int stdin);
Process *process_from_pid(intptr_t pid);

Process *process_get_current();
int process_get_stdin(Process *p);
int process_get_stdout(Process *p);
int process_get_stderr(Process *p);
  
Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv));
int process_start(Process *process);

int process_set_finish(Process *process, void *finishfunc);
int process_wait(Process *process);
int process_close(Process *process);


#endif /* _KPROCESS_H */
