#ifndef _SH_H
#define _SH_H

#define MAX_ARGV 2048

enum {
  WAITING_FOR_CHILD = 1
};

typedef struct List {
  void *first, *last;
} List;
#define LIST_DEFINED

typedef struct ChildProc {
  struct ChildProc *next, *prev;
  char command[256];
  char *argv[MAX_ARGV];
  int argc;
  int pid;
} ChildProc;

typedef struct ShellState {
  char cwd[512];
  char commandbuf[4192];
  
  int commandlen, cursorx;
  
  int waitflag;
  int echo;
  FILE *pipe;
  
  List running_procs;
  ChildProc *blocking_proc;
} ShellState;

#endif /* _SH_H */
