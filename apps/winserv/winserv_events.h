#ifndef _WINSERV_EVENTS_H
#define _WINSERV_EVENTS_H

#include "winserv.h"

//the size is aligned to eight bytes
typedef struct WndEvent {
  WndHandle wnd;  
#if sizeof(void*) == 8
  int type, flags;
#else
  short type, flags;
#endif
  uintptr_t args[4];
} WndEvent;

/*
try not to be too windows-like
*/
enum {
  WM_DRAW,
  WM_POSTDRAW,
  WM_RESIZE,
  WM_MOVE,
  WM_INVALIDATED,
  WM_MOUSE,
  WM_MULTITOUCH,
  WM_KEYBOARD,
  WM_EXIT,
  WM_MINIMIZE,
  WM_MAXIMIZE,
  WM_FOCUS,
  WM_DEFOCUS,
  WM_ALIVE,
  WM_SERVER_CRASHED,
  WM_ACK, //acknowledged event, for events that don't reply
  WM_NEWWINDOW,
  WM_SHOWWINDOW,
  WM_HIDEWINDOW,
  WM_FLIPWINDOW,
  WM_STARTDRAG,
  WM_CLIPSET,
  WM_GETFRAMEBUFFER,
  WM_INT32,
  WM_INTPTR,
  
  WM_WININFO, //get window info from 
};
 
typedef struct WinGetFramebufferReq {
  WndHandle hwnd;
} WinGetFramebufferReq;

typedef struct WinInfoReply {
  WndHandle wnd;
  short x, y, width, height, flags, state;
} WinInfoReply;

//individual event structs map to WndEvent->args.
//they need not be 8-byte aligned (though I believe
//the compiler will do that for us).

typedef struct DrawEvent {
  unsigned char *fbo; //framebuffer
  short fbo_width, fbo_height, fbo_depth, pad;
} DrawEvent;

typedef struct InvalidateEvent {
  short x, y, width, height;
} InvalidateEvent;

typedef struct MouseEvent {
  short x, y, button_mask, pad;
} MouseEvent;

#endif /* _WINSERV_EVENTS_H */
