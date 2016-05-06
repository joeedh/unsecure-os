#ifndef __KERNEL_BUILD__
#include "../userinclude/wait.h"

#include "stddef.h"
#include "stdint.h"
#include "stdlib.h"
#include "stdio.h"
#include "string.h"
#include "path.h"
#include "../userinclude/spawn.h"

extern char **environ;

int system(const char *string) {
  if (string == NULL) {
    return -1;
  }
  
  char *argv[MAX_ARGV];
  
  int argc = shlex((char*) string, argv);
  if (argc <= 0) {
    return -1;
  }
  
  char **newargv = malloc(sizeof(void*)*(1+argc));
  int pid;

  memcpy(newargv, argv, argc*sizeof(void*));
  newargv[argc] = NULL;
  
  if (posix_spawn(&pid, argv[0], NULL, NULL, newargv, environ) != 0) {
    free(newargv);
    
    return -1;
  }
  
  int status, options=0;
  
  waitpid(pid, &status, options);
  
  free(newargv);
  
  return status;
}
#endif
