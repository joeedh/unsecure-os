#include "stdlib.h"
#include "stdio.h"
#include "string.h"

#include "spawn.h"
#include "wait.h"

#include "keyboard.h"

#include "unistd.h"
#include "dirent.h"
#include "dynstr.h"

#include "sh.h"

#include "termios.h"
#include "stropts.h"

#define kfree free
#define kmalloc malloc

//just include the stupid list implementation in the kernel
#include "../kernel/libc/list.c"


int stty_line_mode() {
  int lflag=0;
  
  ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&lflag);
  lflag |= ECHO;
  ioctl(stdin->fd, TCSET_LOCALFLAG, lflag);
  
  //turn on line editing mode for child processes
  ioctl(stdin->fd, TCSET_BUFM, BUFM_LINE);
}

int stty_raw_mode() {
  int lflag=0;
  
  ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&lflag);
  lflag &= ~ECHO;
  ioctl(stdin->fd, TCSET_LOCALFLAG, lflag);
  
  //turn on raw mode for command line editing, which shell buffers itself
  ioctl(stdin->fd, TCSET_BUFM, BUFM_RAW);  
}

static int _lflag, _bufm;
static void stty_save_mode() {
  ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&_lflag);
  ioctl(stdin->fd, TCGET_BUFM, (intptr_t)&_bufm);
}

static void stty_restore_mode() {
  ioctl(stdin->fd, TCSET_LOCALFLAG, (intptr_t)_lflag);
  ioctl(stdin->fd, TCSET_BUFM, (intptr_t)_bufm);
}

int mygetc(FILE *file) {
  while (feof(file)) {
    task_yield();
  }
  
  return fgetc(file);
}

int startswith(const char *str, const char *name) {
  char *a = (char*) str;
  char *b = (char*) name;
  
  while (*a && *b) {
    if (*a != *b)
      return 0;
    
    a++;
    b++;
  }
  
  return !*b;
}

int commandexec_export(ShellState *state, int argc, char **argv) {
  int len, n, i;
  char buf[256];
  
  if (argc != 2) {
    goto error;
  }
  
  len = strlen(argv[1]);
  n = strcspn(argv[1], "=");
  
  if (n >= len) {
    goto error;
  }
  
  i = 0;
  while (argv[1][i] && argv[1][i] == '\t' || argv[1][i] == ' ') {
    i++;
  }
  
  n = strcspn(argv[1]+i, "=");
  memcpy(buf, argv[1]+i, n);
  buf[n] = 0;
  
  const char *val = argv[1]+i+n+1;
  
  //e9printf("%s:%s\n", buf, val);
  
  setenv(buf, val, 1);
  
  return 0;
  
error:
  fprintf(stdout, "Error: expected 'export ENV_VAR=value', with no spaces around '='\n");
  return -1;
}

int commandexec_changedir(ShellState *state, int argc, char **argv) {
  if (argc < 2) {
    printf("failed to change dir: missing argument\n");
    return -1;
  }
  
  char curworkingdir[256];
  char _dir[256];
  char lastcur[256];

  getcwd(curworkingdir, sizeof(curworkingdir));
  
  strncpy(lastcur, curworkingdir, sizeof(lastcur));
  strncpy(_dir, argv[1], sizeof(_dir));

  char *dir = strtrim(_dir);
  int dlen = strlen(dir)-1;

  //e9printf("dir argument: %d'%s'\n", strlen(dir), dir);

  if (dir[dlen-1] == '/') {
    dir[dlen-1] = 0;
  }

  if (!strcmp(dir, "..")) {
    //fprintf(stdout, "  descending\n");
    int len = strlen(curworkingdir);
    
    while (len >= 1 && curworkingdir[len-1] != '/') {
      curworkingdir[len-1] = 0;
      len--;
    }
    
    if (len > 1 && curworkingdir[len-1] == '/') {
      curworkingdir[len-1] = 0;
    } else if (len == 0) {
      curworkingdir[len++] = '/';
      curworkingdir[len++] = 0;
    }
    
    int ret = chdir(curworkingdir);
    getcwd(state->cwd, sizeof(state->cwd));
    return ret;
  }

  if (dir[0] == '/') {
    strcpy(curworkingdir, dir);
  } else {
    if (curworkingdir[strlen(curworkingdir)-1] != '/') {
      strcat(curworkingdir, "/");
    }
    strcat(curworkingdir, dir);
  }

  DIR *fdir = opendir(curworkingdir);
  
  if (!fdir) {
    fprintf(stdout, "Error: Invalid directory %s\n", curworkingdir);
    strcpy(curworkingdir, lastcur);
    
    return -1;
  } else {
    closedir(fdir);
    
    if (chdir(curworkingdir) != 0) {
      fprintf(stdout, "Error: can't change directory to %s\n", curworkingdir);
      return -1;
    }
  }
  
  getcwd(state->cwd, sizeof(state->cwd));
  return 0;
}

int whereis(char *name, char *outpath, int outsize) {
  int n, stop=0;
  char buf[256];
  
  char *path = getenv("PATH");
  char *c = path;
  DIR *dir;
  struct dirent *entry;
  
  /*
  e9printf("PATH: %s\n", path);
  //return -1;
  
  extern char **environ;
  int i=0;
  while (environ[i]) {
    e9printf("  ENV: '%s'\n", environ[i]);
    i++;
  }
  //*/
  
  do {
    n = strcspn(c, ":");
    if (n <= 0) {
      n = strlen(c);
      stop = 1;
    }
    
    n = n >= sizeof(buf) ? sizeof(buf)-1 : n;
    
    strncpy(buf, c, sizeof(buf)-1);
    buf[n++] = 0;
    
    dir = opendir(buf);
    if (!dir) {
      c += n;
      
      //bad directory
      printf("bad dir in path: '%s'\n", buf);
      continue;
    }
    
    while ((entry = readdir(dir))) {
      //e9printf("  entry: '%s' '%s'\n", entry->d_name, name);
      
      if (!strcmp(entry->d_name, name)) {
        strncpy(outpath, buf, outsize);
        
        if (name[0] != '/' && buf[strlen(buf)-1] != '/') {
          strncat(outpath, "/", outsize);
        }
        
        strncat(outpath, name, outsize);
        
        //e9printf("found: '%s'\n", outpath);
        
        return 0;
      }
    }
    closedir(dir);
    
    c += n;
  } while (!stop);
  
  return -1;
}

typedef struct shlexstate {
  char **envp;
  int curenv, state;
  char *c, *scratch;
} shlexstate;

static char *myshlex2_putenv(char *c, shlexstate *state);

static char *myshlex2_state0(char *c, shlexstate *state) {
  switch (*c) {
    case ' ':
    case '\t':
      state->curenv++;
      c++;
      break;
    case '$': {
      c = myshlex2_putenv(c, state);
      break;
    }
    case '\"':
      state->state = 1;
      break;
    default:
      s_putchar(state->envp[state->curenv], *c);
      c++;
      break;
  }
  
  return c;
}
static char *myshlex2_state1(char *c, shlexstate *state) {
  switch (*c) {
    case '"':
      state->state = 0;
      state->curenv++;
      c++;
      break;
    case '\\':
      c++;
    case '$': {
      c = myshlex2_putenv(c, state);
      break;
    }
    default:
      s_putchar(state->envp[state->curenv], *c);
      c++;
      break;
  }
  
  return c;
}

typedef char *(*shlexfunc)(char *c, shlexstate *state);

static shlexfunc shlex_states[2] = {
  myshlex2_state0,
  myshlex2_state1
};

static char *myshlex2_putenv(char *c, shlexstate *state) {
  int valid = 0;
  char *env;
  
  s_reset(state->scratch);
  do {
    c++;
    
    char ch = *c;
    
    valid = ch;
    valid = valid || (ch >= 'A' && ch <= 'Z');
    valid = valid || (ch >= 'a' && ch <= 'z');
    valid = valid || (ch >= '0' || ch <= '9');
    valid = valid || (ch == '_');
    
    if (valid) {
      s_putchar(state->scratch, *c);
    }
  } while (valid);
  
  env = getenv(state->scratch);
  //e9printf("env: %s:'%s'\n", state->scratch, env);
  
  if (env) {
    int oldstate = state->state;
    char *c2 = (char*)env;
    state->state = 0;
    
    while (*c2) {
      c2 = shlex_states[state->state](c2, state);
    }
    
    state->state = oldstate;
  }
  
  return c;
}

int myshlex2(char *line, char *envp[MAX_ARGV]) {
  char *c = line;
  
  shlexstate state;
  
  memset(&state, 0, sizeof(shlexstate));
  state.envp = (char**) envp;
  state.scratch = NULL;
  
  /* STATES:
     0 -> main
     1 -> string literal
  */
  
  memset(envp, 0, sizeof(void*)*MAX_ARGV);
  
  while (c && *c) {
    c = shlex_states[state.state](c, &state);
  }
  
  envp[state.curenv+1] = NULL;
  return state.curenv;
}

//modifies/splits line
int myshlex(char *line, char *outbuf[MAX_ARGV]) {
  int n=0, argc=0, stop=0;
  
  if (!line || line[0] == 0) {
    outbuf[0] = NULL;
    return 0;
  }
  
  while (!stop && argc < MAX_ARGV-1 && (n = strcspn(line, " \t\n\r\""))) {
    outbuf[argc++] = line;
    
    if (line[n] == 0) {
      stop = 1;
    }
    
    line[n] = 0;
    line += n+1;
  }
  
  if (*line)
    *line = 0;
  
  outbuf[argc] = NULL;
  return argc;
}

int commandexec_spawn(ShellState *state, int argc, char **argv) {
  int pid;
  char binpath[256];
  binpath[0] = 0;
  
  if (argc == 0) {
    printf("Error: no arguments\n");
    return -1;
  }
  
  if (whereis(argv[0], binpath, sizeof(binpath))) {
    printf("Error: Unknown command %s\n", argv[0]);
    return -1;
  }
  
  extern char **environ;
  
  stty_save_mode();
  stty_line_mode();
  
  int ret = posix_spawn(&pid, binpath, NULL, NULL, argv, environ);
  
  if (ret != 0) {
    printf("Error: Can't execute %s\n", argv[0]);
    return ret;
  }
  
  ChildProc *proc = malloc(sizeof(ChildProc));
  
  memset(proc, 0, sizeof(ChildProc));
  strlcpy(proc->command, argv[0], sizeof(proc->command));
  proc->pid = pid;
  
  state->blocking_proc = proc;
  
  return ret;
}

int commandexec(ShellState *state, int argc, char **argv) {
  //e9printf(":: %c%c%x\n", argv[0][0], argv[0][1], argv[0][2]);
  
  if (argc == 0)
    return -1;
  else if (startswith(argv[0], "export"))
    return commandexec_export(state, argc, argv);
  else if (startswith(argv[0], "cd"))
    return commandexec_changedir(state, argc, argv);
  else
    return commandexec_spawn(state, argc, argv);

}
int printprompt(ShellState *state) {
  printf("%s$ ", state->cwd);
}

int history_add(ShellState *state, char *command) {
  LinkNode *last = (LinkNode*) state->history.last;
  
  if (last && strcmp((const char*)last->data, command)==0) {
    return -1; //ignore duplicate entries
  }
  
  LinkNode *node = malloc(sizeof(LinkNode));
  node->data = strdup(command);
  
  klist_append(&state->history, node);
  
  return 0;
}

int interactive(ShellState *state, int argc, char **argv) {
  printprompt(state);
  
  //shell echos itself during command editing mode
  stty_raw_mode();
  stty_save_mode();
  
  while (1)  {
    task_yield();
    
    if (state->blocking_proc) {
      int status;
      
      if (waitpid(state->blocking_proc->pid, &status, WNOHANG) == state->blocking_proc->pid) {
        stty_restore_mode();
        
        state->blocking_proc = NULL;
        printprompt(state);
      }
    }
    
    short code = -1;
    
    if (!feof(stdin)) {
      code = (short) fgetc(stdin);
      //e9printf("got code: %x\n", code);
    }
    
    if (code < 0 || (code & 128)) {
      continue;
    }
    
    short ch = code & 127;
    
    //e9printf("bleh\n");
    
    if (isprint(ch) || ch == '\r' || ch == '\n' || ch == '\t') {
      if (state->pipe != NULL) {
        fputc(ch, state->pipe);
        
        //outbuf[MAX_ARGV]
        if (state->echo) {
          fputc(ch, stdout);
        }
        
        continue;
      }
      
      if (ch == '\n') {
        char buf[sizeof(state->commandbuf)];
        char *argv2[MAX_ARGV];
        int argc2;
        
        fputc('\n', stdout);
        
        state->commandbuf[state->commandlen] = 0;
        strlcpy(buf, state->commandbuf, sizeof(buf));
        
        history_add(state, state->commandbuf);
        
        if (state->history_cur && state->history_cur->next)
          state->history_cur = state->history_cur->next;
        
        argc2 = myshlex(buf, argv2);
        
        state->cursorx = 0;
        state->commandlen = 0;
        
        //e9printf("argc: %d, argv: %x\n", argc2, argv2);
        //for (int i=0; i<argc2; i++) {
          //e9printf("    '%s'\n", argv2[i]);
        //}
        
        if (argc2 > 0) {
          commandexec(state, argc2, argv2);
        }
        
        if (!state->blocking_proc) {
          printprompt(state);
        }
        
        state->historyflag = 1;
      } else if (ch == '\r') {
        state->cursorx = 0;
        state->commandlen = 0;
        
        fputc('\r', stdout);
        printprompt(state);
      } else if (ch == '\t') {
        printf("tab!\n");
      } else {
        int i = state->cursorx;
        
        //clear from cursor to end of line
        fputc(27, stdout);
        fputc('[', stdout);
        fputc('K', stdout);

        fputc(ch, stdout);
        
        i = state->commandlen;
        while (i > state->cursorx) {
          fputc(state->commandbuf[i-1], stdout);
          
          state->commandbuf[i] = state->commandbuf[i-1];
          i--;
        }
        
        i = state->cursorx;
        while (i < state->commandlen) {
          fputc(27, stdout);
          fputc('[', stdout);
          fputc('D', stdout);
          
          i++;
        }
        
        state->commandbuf[state->cursorx] = ch;
        state->cursorx++;
        state->commandlen++;
        
        state->historyflag = 0;
      }
    } else {
      if (ch == 27) { //escape key
        int a, b, c, d;
        
        a = mygetc(stdin);
        
        if (a == '[') {
          b = mygetc(stdin);
          switch (b) {
            case 'A':
              ch = KEY_UP;
              break;
            case 'B':
              ch = KEY_DOWN;
              break;
            case 'C':
              ch = KEY_RIGHT;
              break;
            case 'D':
              ch = KEY_LEFT;
              break;
            case '5':
              b = mygetc(stdin);
              if (b == '~') {
                ch = KEY_PAGEUP;
              }
              break;
            case '6':
              b = mygetc(stdin);
              if (b == '~') {
                ch = KEY_PAGEDOWN;
              }
              break;
            case 'H':
              //ch = KEY_HOME;
              break;
          }
        }
      }
      
      switch (ch) {
        case KEY_LEFT: {
          if (state->cursorx > 0) {
            fputc(27, stdout);
            fputc('[', stdout);
            fputc('D', stdout);
            
            state->cursorx--;
          }          
          break;
        }
        case KEY_RIGHT: {
          if (state->cursorx < state->commandlen) {
            fputc(27, stdout);
            fputc('[', stdout);
            fputc('C', stdout);
            
            state->cursorx++;          
          }          
          break;
        }
        case KEY_ENTER:
          break;
        case KEY_DELETE:
          break;
        case '\x7F':
        case '\b': {
          if (state->cursorx > 0) {
            for (int i=state->cursorx; i<state->commandlen-1; i++) {
              state->commandbuf[i] = state->commandbuf[i+1];
            }
            
            state->commandlen--;
            state->cursorx--;
            
            fputc(8, stdout);
          }
          
          state->historyflag = 0;
          break;
        }
        case KEY_PAGEUP:
          //printf("\33[\x0fS");
          fputc(27, stdout);
          fputc('[', stdout);
          fputc(15, stdout);
          fputc('S', stdout);
          break;
        case KEY_PAGEDOWN:
          fputc(27, stdout);
          fputc('[', stdout);
          fputc(15, stdout);
          fputc('T', stdout);
          break;
        
        case KEY_UP:
        case KEY_DOWN:
          if (!state->history.first)
            break;
          if (!state->history_cur) 
            state->history_cur = state->history.last;
          
          if (ch == KEY_UP && state->history_cur->prev)
            state->history_cur = state->history_cur->prev;
          else if (ch == KEY_DOWN && state->history_cur->next)
            state->history_cur = state->history_cur->next;
            
          if (!state->history_cur) 
            break;
          
          int len = strlen((const char*)state->history_cur->data);
          strlcpy(state->commandbuf, (const char*)state->history_cur->data, len+1);
          
          state->cursorx = len;
          state->commandlen = len;
          
          fputc('\r', stdout);
          printprompt(state);
          fprintf(stdout, "%s", state->commandbuf);
          fflush(stdout);
          
          state->historyflag = 1;
          break;
      }
    }
  }
}

int main(int argc, char **argv) {
  ShellState state;
  
  e9printf("started shell!\n");
  
  fprintf(stdout, "started!\n");
  fflush(stdout);
  
  //while (1) {
  //  __asm__("STI");
  //  task_yield();
  //}
  
  memset(&state, 0, sizeof(state));
  state.pipe = NULL;

  if (argc > 1) {
    if (chdir(argv[1])) {
      printf("Error: can't change directory to %s\n", argv[1]);
      return -1;
    }
  }
  
  if (!getcwd(state.cwd, sizeof(state.cwd))) {
    //something went wrong getting current working path
    printf("Warning: could not get current working path!\n");
    state.cwd[0] = 0; //set to empty string
  }
  
  //set PATH variable if it does not already exist
  setenv("PATH", "/bin:/usr/bin:/sbin:/usr/sbin", 0);
  
  //strncpy(newp->working_path, p->working_path, sizeof(newp->working_path));
  
  return interactive(&state, argc, argv);
}
