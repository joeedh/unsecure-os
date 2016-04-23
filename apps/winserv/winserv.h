#ifndef _WINSERV_H
#define _WINSERV_H

#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef WndHandle void*;

WndHandle Wnd_NewWindow(char *classname, char *title, int width, int height, int type, int flags);
int Wnd_ShowWindow(WndHandle wnd);
int Wnd_HideWindow(WndHandle wnd);
int Wnd_FlipWindow(WndHandle wnd);

unsigned char *Wnd_GetFramebuffer(WndHandle wnd, int *width, int *height, int *depth);

WndRect *Wnd_GetDirtyRect(WndHandle wnd, int i);
int Wnd_TotDirtyRects(WndHandle wnd);

int Wnd_GetLastError(WndHandle wnd);
int Wnd_StartDrag(WndHandle wnd, char *data, *datasize, *mime, int (*onDragEnd)(WndHandle src, WndHandle dst));

int Wnd_ClipSet(WndHandle wnd, char *type, char *data, int datasize);
int Wnd_ClipGetSize(WndHandle wnd, char *type);
int Wnd_ClipGet(WndHandle wnd, char *type, char *data);

/*
typedef struct UnicodeComputer {
  char *(*linewrap)(void *self, char *buf);
  char *(*layout)(void *self, char *buf);
  
  void (*set_locale)(void *self, char *buf);
} UnicodeComputer;
//*/

#endif /* _WINSERV_H */
