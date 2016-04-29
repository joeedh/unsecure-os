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

static int msg_idgen = 0;

//send message to all processes
int ipc_broadcast(int id, char *data, int datasize) {
  Process *p;
  
  RLOCK_PROCSYS
  
  for (p=running_processes.first; p; p=p->next) {
    write(p->temp_ipc, &id, 4);
    write(p->temp_ipc, data, datasize);
  }
  
  UNRLOCK_PROCSYS
  
  return 0;
}

//send message to specific process
//returns message id, that can be used to
//identify a reply.
int ipc_post(int dstpid, int type, char *data, int datasize) {
  RLOCK_PROCSYS
  
  Process *p = process_from_pid(dstpid);
  if (!p) {
    UNRLOCK_PROCSYS
    return -1;
  }

  int fd = p->temp_ipc;
  UNRLOCK_PROCSYS
  
  int id = msg_idgen++;
  
  write(fd, &id, 4);
  write(fd, &type, 4);
  write(fd, &datasize, 4);
  write(fd, data, datasize);
  
  return 0;
}

int ipc_get(int *_srcpid, int *_id, int *_type, void **_data, int *_datasize) {
  RLOCK_PROCSYS
  
  Process *p = process_from_pid(dstpid);
  if (!p) {
    UNRLOCK_PROCSYS
    return -1;
  }

  int fd = p->temp_ipc;
  UNRLOCK_PROCSYS
  
  int id, type, datasize;
  char *data;
  
  read(fd, &id, sizeof(int));
  read(fd, &type, sizeof(int));
  read(fd, datasize, sizeof(int));
  
  char *data = malloc(datasize);
  
  read(fd, data, datasize);
  
  return data;
}

//waits for reply
int ipc_wait(int pid, int reqid, int *type, void **data, int *datasize) {
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
