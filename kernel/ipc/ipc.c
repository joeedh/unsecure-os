#include "../task/task.h"
#include "../task/process.h"
#include "../task/rwlock.h"
#include "../libc/list.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/kmalloc.h"

extern RWLock _procsys_lock;
extern List running_processes;

//send message to all processes
int ipc_broadcast(int id, char *data, int datasize) {
  Process *p;
  
  krwlock_rlock(&_procsys_lock);
  
  for (p=running_processes.first; p; p=p->next) {
    write(p->temp_ipc, &id, 4);
    write(p->temp_ipc, data, datasize);
  }
  
  krwlock_unrlock(&_procsys_lock);
  
  return 0;
}

//send message to specific process
int ipc_post(int dstpid, int id, char *data, int datasize) {
  krwlock_rlock(&_procsys_lock);
  
  Process *p = process_from_pid(dstpid);
  if (!p) {
    return -1;
  }
  
  write(p->temp_ipc, &id, 4);
  write(p->temp_ipc, data, datasize);
  
  krwlock_unrlock(&_procsys_lock);
  
  return 0;
}

int ipc_get(int *srcpid, int *type, void **data, int *datasize) {
}

int ipc_poll() {
  
}

enum {
  T_OK,
  T_ERR,
  T_RESEND
};

/*
while (ipc_poll()) {
  int pid, type, datasize;
  char *data;
  
  if (!ipc_get(&pid, &type, &data, &datasize)) {
    break;
  }
  
  switch (type) {
  }
}
*/
