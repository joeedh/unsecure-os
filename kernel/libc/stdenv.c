//usermode environment stuff
#ifndef __KERNEL_BUILD__

#include "string.h"
#include "stdlib.h"
#include "stdio.h"

extern char **environ;

static int startswith(const char *str, const char *name) {
  char *a = (char*)str;
  char *b = (char*)name;
  
  while (*a && *b) {
    if (*a != *b)
      return 0;
    
    a++;
    b++;
  }
  
  return !*b;
}

int setenv(const char *envname, const char *envval, int overwrite) {
  int allocsize = 0;
  int i=0, totentry=0;
  
  //calculate allocation size for changed environment
  while (environ[i]) {
    if (!startswith(environ[i], envname)) {
      allocsize += strlen(environ[i]) + 2;
      totentry++;
    }
    
    i++;
  }
  
  //add in size of new entry
  allocsize += strlen(envname) + strlen(envval) + 2;
  totentry++;
  
  //reserve space for null terminator
  totentry++; 
  
  //for now, environment changes will always leak memory
  //eek!
  
  allocsize += totentry*sizeof(void*);
  char *newenv = malloc(allocsize);
  
  memset(newenv, 0, allocsize);
  
  //put environ pointers in front
  char **envp = (char**) newenv;
  newenv += sizeof(void*)*totentry;
  
  i = 0;
  int k=0, didset=0;
  
  while (environ[i]) {
    if (!startswith(environ[i], envname)) {
      int n = strlen(environ[i]);
      
      envp[k++] = newenv;
      memcpy((char*) newenv, (char*) environ[i], n);
      newenv[n++] = 0;
      
      newenv += n;
    } else {
      didset = 1;
      
      if (overwrite) {
        int n = strlen(envname);
        
        envp[k++]  = newenv;
        
        memcpy((char*) newenv, (char*) envname, n);
        newenv[n++] = '=';
        newenv += n;
        
        n = strlen(envval);
        memcpy((char*) newenv, (char*) envval, n);
        newenv[n++] = 0;
        
        newenv += n;
      } else {
        int n = strlen(environ[i]);
        
        envp[k++] = newenv;
        memcpy((char*) newenv, (char*) environ[i], n);
        newenv[n++] = 0;
        
        newenv += n;
      }
    }
    
    i++;
  }
  
  if (!didset) {
    int n = strlen(envname);
    
    envp[k++]  = newenv;

    memcpy((char*) newenv, (char*) envname, n);
    newenv[n++] = '=';
    newenv += n;
    
    n = strlen(envval);
    memcpy((char*) newenv, (char*) envval, n);
    newenv[n++] = 0;
    
    newenv += n;
  }
  
  envp[k] = NULL; //null-terminate
  
  //set environ.  according to posix, this need not
  //be thread safe. . . why?
  
  environ = envp;
  
  return 0;
}

char *getenv(const char *name) {
  int i=0;
  
  while (environ[i]) {
    e9printf("->%s|%s|%d\n", environ[i], name, startswith(environ[i], name));
    
    if (startswith(environ[i], name)) {
      int n = strcspn(environ[i], "=");
      int add = environ[i][n] == 0 ? 0 : 1;
      
      return environ[i]+n+add;
    }
    
    i++;
  }
  
  return NULL;
}

#endif
