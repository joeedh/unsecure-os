#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>

#include "winserv_intern.h"
#include "winserv_events.h"

static WndProcess *wnd_getproc(int pid) {
}

int server_pid;
char *Wnd_GetFrameBuffer(WndHandle h) {
  int id = ipc_post(server_pid, WM_GETFRAMEBUFFER, &h, sizeof(WndHandle));
  
  if (id < 0) {
    //eek
    continue;
  }
  
  int type, datasize;
  char *data;
  
  while (ipc_wait(server_pid, id, &type, &data, &datasize)) {
    task_yield();
  }
  
  return *(WndHandle*)data;
}

static int wnd_handle_msg(WndState *state, WndProcess *p, int id, int type, char *data, int datasize) {
  switch (type) {
    WM_GETFRAMEBUFFER: {
      WinGetFramebufferReq *req = (WinGetFramebufferReq*)data;
      WndWindow *wnd = req->hwnd;
      
      ipc_post(p->pid, WM_INTPTR, &wnd->framebuffer, sizeof(void*));
      //int ipc_post(int dstpid, int id, char *data, int datasize);

      break;
    }
    default:
      break;
  }
}

int wnd_serv(WndState *state) {
  while (1) {
    while (ipc_poll()) {
      int pid, type, datasize, id;
      char *data;
      
      id = ipc_get(&pid, &type, &data, &datasize);
      if (id < 0) {
        //eek
        continue;
      }
      
      WndProcess *p = wnd_getproc(pid);
      wnd_handle_msg(state, p, id, type, data, datasize);
    }
    task_yield();
  }
}

int main(int argc, char **argv) {
  WndState state;
  
  memset(&state, 0, sizeof(state));
  
  wnd_serv(&state);
}
