#ifndef _KPROCESS_H
#define _KPROCESS_H

#if 0
  #define RLOCK_PROCSYS e9printf("rlock: %s:%d: procsys\n", __FILE__, __LINE__), krwlock_rlock(&_procsys_lock);
  #define UNRLOCK_PROCSYS e9printf("unrlock: %s:%d: procsys\n", __FILE__, __LINE__), krwlock_unrlock(&_procsys_lock);

  #define LOCK_PROCSYS e9printf("wlock: %s:%d: procsys\n", __FILE__, __LINE__), krwlock_lock(&_procsys_lock);
  #define UNLOCK_PROCSYS e9printf("unwlock: %s:%d: procsys\n", __FILE__, __LINE__), krwlock_unlock(&_procsys_lock);
#else
  #define RLOCK_PROCSYS krwlock_rlock(&_procsys_lock);
  #define UNRLOCK_PROCSYS krwlock_unrlock(&_procsys_lock);

  #define LOCK_PROCSYS krwlock_lock(&_procsys_lock);
  #define UNLOCK_PROCSYS krwlock_unlock(&_procsys_lock);
#endif

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

typedef void (*ProcFinishFunc)(int retval, int tid, int pid);

//keep in sync with PROCESS_SIZE in asm/definitions.nasm!
typedef struct Process {
  struct Process *next, *prev;
  
  volatile int pid;
  char name[32];
  unsigned char calling_path[32];
  unsigned char working_path[256];
  
  int (*entryfunc)(int argc, char **argv);
  ProcFinishFunc finishfunc;
  
  int argc;
  char **argv, **environ;
  
  volatile int stdin, stdout, stderr, temp_ipc, pad; //temp_ipc is file descriptor used by temporary ipc system
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

int emergency_proc_exit();

Process *process_get_current(int skiplocks);
int process_get_stdin(Process *p);
int process_get_stdout(Process *p);
int process_get_stderr(Process *p);
void process_finishinit();

Process *spawn_process(const char *name, int argc, char **argv, int (*main)(int argc, char **argv));
int process_start(Process *process);

int process_set_finish(Process *process, void *finishfunc);
int process_wait(Process *process);
int process_close(Process *process);

struct FILE;
int print_procs(struct FILE *file);

int _exit(int retval);
int getpid();

#endif /* _KPROCESS_H */
