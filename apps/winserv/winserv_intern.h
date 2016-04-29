#ifndef _WINSERV_INTERN_H
#define _WINSERV_INTERN_H

#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct WndProcess {
  struct WndProcess *next, *prev;
  
  int pid, permissions;
  List windows;
  
  int pipe[2];
} WndProcess;

enum {
  ACCESS_DND=1, //drag and drop
  ACCESS_FULLSCREEN=2, //fullscreen
  ACCESS_MODAL=4, //modal, similar to fullscreen
};

typedef struct WndWindow {
  int x, y, width, height, state, flags;
  unsigned char *framebuffer;
} WndWindow;

typedef struct WndClipboard {
  char type[16];
  
  void (*set)(void *self, void *data, int datasize);
  void (*getsize)(void *self);
  void (*get)(void *self, void *data);
  void (*is_empty)(void *self);
} WndClipboard;

typedef struct WndCursor {
  int type;
} WndCursor;

typedef struct WndDnDState {
  WndWindow *src, *dst;
  WndCursor cursor;
} WndDnDState;

typedef struct WndState {
  List windows, processes;
  List modalstack;
  
  FILE *session_journal;
} WndState;

typedef struct WndRect {
  int x, y, width, height;
} WndRect;

/*
typedef struct UnicodeMachine {
  char *(*linewrap)(void *self, char *buf);
  char *(*layout)(void *self, char *buf);
  
  void (*set_locale)(void *self, char *buf);
} UnicodeMachine;
//*/

#endif /* _WINSERV_INTERN_H */
