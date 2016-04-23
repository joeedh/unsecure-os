#include "../task/task.h"
#include "../task/process.h"
#include "../task/rwlock.h"

/*temporary ipc system*/

//send message to all processes
int ipc_broadcast(int id, char *data, int datasize);

//send message to specific process
int ipc_post(int dstpid, int id, char *data, int datasize);
int ipc_get(int *srcpid, int *type, void **data, int *datasize);
int ipc_poll();

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
