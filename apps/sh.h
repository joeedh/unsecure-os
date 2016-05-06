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

struct LinkNode;
typedef struct ShellState {
  char cwd[512];
  char commandbuf[4192];
  
  int commandlen, cursorx;
  
  int waitflag;
  int echo;
  FILE *pipe;
  
  List running_procs;
  ChildProc *blocking_proc;
  
  List history;
  struct LinkNode *history_cur;
  int historyflag;
} ShellState;

int stty_line_mode();
int stty_raw_mode();

#endif /* _SH_H */
