#ifndef _VESA_H
#define _VESA_H
#include "../framebuffer/framebuffer.h"

typedef struct VesaFramebuffer {
  Framebuffer head;
  RWLock lock;
  int width, height, depth, linepad, format;
} VesaFramebuffer;

Framebuffer *vesa_init(void *bootinfo);

#endif /* _VESA_H */
