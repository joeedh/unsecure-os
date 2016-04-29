#ifndef _FRAMEBUFFER_TTY_H
#define _FRAMEBUFFER_TTY_H

#include "tty.h"

#define UPDATE_RATE_MS  50

typedef struct FbTTY {
  int sizex, sizey;
  int cellx, celly;
  int cols, rows;
  unsigned short *textarray;
  unsigned char *font;
  unsigned char *backbuffer;
  int scrsizex, scrsizey, scrdepth, pad;
  int cursorx, cursory;
} FbTTY;

void tty_fb_init(int width, int height);
unsigned short *tty_fb_get_textarray();
void tty_fb_flip();
void tty_fb_setcursor(int x, int y);

#endif /*_FRAMEBUFFER_TTY_H*/