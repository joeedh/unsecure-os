#include "../syscalls/syscalls.h"
#include "process_management.h"
#include "process.h"
#include "task.h"
#include "lock.h"
#include "../drivers/fs/fs_interface.h"
#include "../drivers/fs/fs_file.h"
#include "../io.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "rwlock.h"
#include "../timer.h"
#include "../libc/list.h"
#include "../libc/path.h"
#include "../loader/elfloader.h"
#include "../userinclude/wait.h"

extern RWLock _procsys_lock;

//need to figure out how multithreaded heaps work

typedef struct PMemRef {
  struct PMemRef *next, *prev;
  int magic1;
  void *data;
  int magic2;
} PMemRef;
#define PMEMREF_MAGIC1  492385433
#define PMEMREF_MAGIC2  922394571

void pfreeall(Process *p) {
  PMemRef *ref, *next;
  
  krwlock_lock(&p->resource_lock);
  for (ref=p->memory.first; ref; ref=next) {
    next = ref->next;
    
    kfree(ref->data);
    kfree(ref);
  }
  
  p->memory.first = p->memory.last = NULL;
  krwlock_unlock(&p->resource_lock);
}

void *pmalloc(size_t size) {
  if (!size)
    return NULL;

  Process *p = process_get_current();
  if (!p) {
    kerror(-1, "No active process!");
  }
  
  void *ret = kmalloc(size);
  
  if (ret) {
    krwlock_lock(&p->resource_lock);
    
    PMemRef *node = kmalloc(sizeof(PMemRef));
    node->magic1 = PMEMREF_MAGIC1;
    node->magic2 = PMEMREF_MAGIC2;
    
    kmalloc_set_custom_ptr(ret, node);
    
    node->data = ret;
    klist_append(&p->memory, node);
    
    krwlock_unlock(&p->resource_lock);
  }
  
  return ret;
}

int pfree(void *mem) {
    PMemRef *ref = kmalloc_get_custom_ptr(mem);
    if (!ref)
      return -1;
   
    Process *p = process_get_current();
    if (!p) {
      kerror(-1, "No active process!");
    }
    
    krwlock_lock(&p->resource_lock);
    if (ref->magic1 != PMEMREF_MAGIC1 || ref->magic2 != PMEMREF_MAGIC2) {
      krwlock_unlock(&p->resource_lock);
      return -1;
    }
    
    kfree(ref->data);
    kfree(ref);
    
    krwlock_unlock(&p->resource_lock);
    return 0;
}

int _start_proc(int argc, char **argv) {
  void **ptrs = (void**)argv;
  
  int stdout = (int)ptrs[0];
  int stdin = (int)ptrs[1];
  int stderr = (int)ptrs[2];
  
  SysCallPtr *calltable = ptrs[3];
  argv = ptrs[4];
  char **envp = ptrs[5];
  
  //XXX todo: make sure calltable, which is a copy of _syscalltable, is freed on process exit!
  
  int (*_start)(SysCallPtr *syscalls, int stdin, int stdout, int stderr, char **argv, char **envv)
            = ptrs[6];
  
  kfree(ptrs);
  
  return _start(calltable, stdin, stdout, stderr, argv, envp);
}

//returns pid (positive number) if successful, or a negative number otherwise
//should never return 0

void _finishfunc(int retval, int tid, int pid) {
  Process *p = process_from_pid(pid, 1);
  
  if (p) {
    process_close(p);
  }
}

int posix_spawn(int *pid_out, const char *path, char *file_actions, char *attrp, char **argv, char **envp) {
  int file = open(path, O_EXEC|O_RDONLY);
  
  if (file < 0) {
    return -1;
  }
  
  struct stat st;
  if (fstat(file, &st) != 0) {
    return -1;
  }
  
  size_t size = st.st_size;
  if (st.st_size <= 0) {
    return -1;
  }
  
  unsigned char *data = kmalloc(size);
  int nread = read(file, data, size);
  
  if (nread <= 0) {
    kfree(data);
    close(file);
    return -1;
  }
  
  close(file);
  
  ElfFile *elf = elfloader_load(data, size);
  unsigned char *ret = elfloader_instantiate(elf);
  void *entry = ret + (elf->header.e_entry - elf->vbase);
  
  //int (*_start)(SysCallPtr *syscalls, char **argv, char **envv)
  //          = entry;
  
  Process *p = process_get_current();
  if (!p) {
    kerror(-1, "no active process!");
  }
  
  int stdout = process_get_stdout(p);
  int stdin = process_get_stdin(p);
  int stderr = process_get_stderr(p);
  
  void **ptrs = kmalloc(sizeof(void*)*7);
  if (!ptrs) {
    kfree(data);
    return -1;
  }
  
  SysCallPtr *syscallcpy = kmalloc(_totsyscalls*sizeof(void*));
  if (!syscallcpy) {
    kfree(data);
    return -1;
  }
  
  memcpy(syscallcpy, _syscalltable, _totsyscalls*sizeof(void*));
  
  //get argc
  int argc = 0;
  while (argv[argc]) {
    argc++;
  }
  
  char **argvcpy = kmalloc(sizeof(void*)*(1+argc));
  
  for (int i=0; i<argc; i++) {
    argvcpy[i] = kmalloc(strlen(argv[i])+1);
    strlcpy(argvcpy[i], argv[i], strlen(argv[i])+1);
  }
  
  //NULL-terminate
  argvcpy[argc] = NULL;
  
  ptrs[0] = (void*)stdout;
  ptrs[1] = (void*)stdin;
  ptrs[2] = (void*)stderr;
  ptrs[3] = syscallcpy;
  ptrs[4] = argvcpy;
  ptrs[5] = envp;
  ptrs[6] = entry;
  ptrs[7] = NULL;
  
  //don't nead elf data anymore now
  //that we have the process image
  elfloader_free(elf);
  
  Process *newp = spawn_process(path, 1, (char**) ptrs, _start_proc);
  if (!newp) {
    kfree(data);
    return -1;
  }

  strncpy(newp->working_path, p->working_path, sizeof(newp->working_path));
  
  process_set_stdin(newp, stdin);
  process_set_stdout(newp, stdout);
  process_set_stderr(newp, stderr);
  
  process_set_finish(newp, _finishfunc);
  
  int newpid = newp->pid;
  process_start(newp);
  
  if (pid_out)
    *pid_out = newpid;
  
  return 0;
}

int system(const char *string) {
  if (string == NULL) {
    return -1;
  }
  
  char *argv[MAX_ARGV];
  
  int argc = shlex((char*) string, argv);
  if (argc <= 0) {
    return -1;
  }
  
  char **newargv = kmalloc(sizeof(void*)*(1+argc));
  memcpy(newargv, argv, argc*sizeof(void*));
  newargv[argc] = NULL;
  
  Process *p = process_get_current();
  if (!p) {
    kerror(-1, "no active processes\n");
  }
  
  krwlock_lock(&p->environ_lock);
  char **envp = p->environ;
  int len=0;
  
  while (envp[len++]);
  len++;
  
  char **newenvp = kmalloc(sizeof(void*)*len);
  int i;
  
  for (i=0; i<len-1; i++) {
    newenvp[i] = envp[i];
  }
  newenvp[i] = 0;
  
  krwlock_unlock(&p->environ_lock);
  
  int pid;
  
  if (posix_spawn(&pid, argv[0], NULL, NULL, argv, envp) != 0) {
    kfree(newenvp);
    kfree(newargv);
    
    return -1;
  }
  
  int status, options=0;
  
  waitpid(pid, &status, options);
  
  kfree(newenvp);
  kfree(newargv);
  
  return status;
}
