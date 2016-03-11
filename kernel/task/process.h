#ifndef _KPROCESS_H

#include "../timer.h"
#include "task.h"
#include "../io.h"
#include "../libc/list.h"

#define MAX_PROC_THREADS 32

typedef struct Process {
  int pid;
  char name[32];
  char calling_path[32];
  char working_path[255];
  
  int stdin, stdout, stderr;
  
  List memory; //list of MemNode references
  List open_files;
  List threads;
  
  int flags, state;
  int retval;
} Process;

#endif /* _KPROCESS_H */
