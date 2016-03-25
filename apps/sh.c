#include "stdlib.h"
#include "stdio.h"
#include "string.h"

#include "spawn.h"
#include "keyboard.h"

#define MAX_ARGV 2048

//modifies/splits line
int shlex(char *line, char *outbuf[MAX_ARGV]) {
  int n=0, argc=0;
  
  while ((n = strcspn(line, " \t\n\r\""))) {
    outbuf[argc++] = line;
    
    line[n] = 0;
    line += n+1;
  }
  
  if (*line)
    *line = 0;
  
  outbuf[argc++] = 0;
  
  return argc;
}

enum {
  WAITING_FOR_CHILD = 1
};

typedef struct ChildProc {
  struct ChildProc *next, *prev;
  char command[256];
} ChildProc;

typedef struct ShellState {
  char cwd[512];
  char commandbuf[4192];
  int commandlen;
  
  int waitflag;
  int echo;
  FILE *pipe;
} ShellState;

int commandexec(ShellState *state, int argc, char **argv) {
  int pid;
  if (argc == 0) {
    printf("Error: no arguments\n");
    return -1;
  }
  
  extern char **env;
  
  int ret = posix_spawn(&pid, argv[0], NULL, NULL, argv, env);
  
  if (ret != 0) {
    printf("Error: Can't execute %s\n", argv[0]);
  }
  
  return ret;
}

int printprompt(ShellState *state) {
  printf("%s> ", state->cwd);
}

int interactive(ShellState *state, int argc, char **argv) {
  printprompt(state);
  
  while (1)  {
    short code = (short)keyboard_poll();
    
    if (code < 0 || (code & 128)) {
      continue;
    }
    
    if (keyboard_isprint(code) || code == '\r' || code == '\n' || code == '\t') {
      if (state->pipe != NULL) {
        fputc(code, state->pipe);
        //outbuf[MAX_ARGV]
        if (state->echo) {
          fputc(code, stdout);
        }
        
        continue;
      }
      
      if (code == '\n') {
        printf("\n");
        printprompt(state);
        
        state->commandbuf[state->commandlen] = 0;
        state->commandlen = 0;
        
        char *argv[MAX_ARGV];
        
        int argc = shlex(state->commandbuf, argv);
        
        if (argc > 0) {
          commandexec(state, argc, argv);
        }
      } else if (code == '\r') {
        state->commandlen = 0;
        
        fputc('\r', stdout);
        printprompt(state);
      } else if (code == '\t') {
        printf("tab!\n");
      } else {
        state->commandbuf[state->commandlen++] = code;
        fputc(code, stdout);
      }
    }
  }
}

int main(int argc, char **argv) {
  ShellState state;
  
  memset(&state, 0, sizeof(state));
  state.pipe = NULL;
  
  return interactive(&state, argc, argv);
}
