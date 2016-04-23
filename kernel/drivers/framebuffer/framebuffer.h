#ifndef _KERNEL_FRAMEBUFFER_H
#define _KERNEL_FRAMEBUFFER_H

#include <stddef.h>
#include <stdint.h>
#include "../../task/lock.h"
#include "../../task/rwlock.h"

enum {
  BW=0,
  RGB=1,
  RGBA=2,
  ARGB=3,
  ABGR=4,
  BGR=5
};

typedef struct Framebuffer {
  void (*lock)(void *self);
  void (*unlock)(void *self);
  void __attribute__((fastcall)) (*blit)(void *self, unsigned char *src, int sx, int sy, int sw, 
               int sh, int sformat, int dx, int dy, int dw, int th) ;
  void (*flip)(void *self); //optional
  int (*get_info)(void *self, int *wid, int *hgt, int *depth);
} Framebuffer;

void framebuffer_init(void *bootinfo);
void framebuffer_lock();
void framebuffer_unlock();
__attribute__((fastcall)) void framebuffer_blit(unsigned char *src, int sx, int sy, int sw, int sh, int sformat, int dx, int dy, int dw, int dh);
void framebuffer_flip(); //is not guaranteed to exist, may be nop
int framebuffer_get_info(int *wid, int *hgt, int *depth);

#endif /* _KERNEL_FRAMEBUFFER_H */
