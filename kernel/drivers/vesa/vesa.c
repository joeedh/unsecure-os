#include "vesa.h"
#include "../../libc/libk.h"
#include "../../libc/kmalloc.h"

uintptr_t vesa_origin, vesa_width, vesa_height, vesa_bpp, vesa_type;

void vesa_lock(void *self) {
  VesaFramebuffer *vesa = self;
  krwlock_lock(&vesa->lock);
}

void vesa_unlock(void *self) {
  VesaFramebuffer *vesa = self;
  krwlock_unlock(&vesa->lock);
}

static int formatmap[] = {
  1,
  3,
  4,
  4,
  4,
  3
};

__attribute__((fastcall)) void vesa_blit(void *self, unsigned char *src, int sx, int sy, int sw, 
               int sh, int sformat, int dx, int dy, int dw, int dh);
__attribute__((fastcall)) void vesa_blit(void *self, unsigned char *src, int sx, int sy, int sw, 
               int sh, int sformat, int dx, int dy, int dw, int dh)
{
  //return; //XXX
  
  VesaFramebuffer *vesa = self;
  
  int sz = formatmap[sformat];
  
  unsigned char *mem = (unsigned char*) vesa_origin;
  unsigned char *a, *b;
  int lastx = sx+dw;
  int lasty = sy+dh;
  
  lastx = lastx < 0 ? 0 : lastx;
  lastx = lastx > sw ? sw : lastx;
  lasty = lasty < 0 ? 0 : lasty;
  lasty = lasty > sh ? sh : lasty;
  
  for (int j=sy; j <= lasty; j++) {
    for (int i=sx; i <= lastx; i++) {
      a = mem + (((dy+j-sy)*vesa->width + dx+i-sx)<<2);
      b = src + (j*sw + i)*sz;
      
      for (int k=0; k<4; k++, a++) {
        *a = *b;
        
        if (k < sz)
          b++;
      }
    }
  }
}

int vesa_get_info(void *self, int *wid, int *hgt, int *depth) {
  VesaFramebuffer *vesa = self;
  
  if (wid) *wid = vesa->width;
  if (hgt) *hgt = vesa->height;
  if (depth) *depth = vesa->depth;
  
  return 0;
}

void vesa_flip(void *self) { //optional
}

static VesaFramebuffer vesa;
      
Framebuffer *vesa_init(void *bootinfo) {
  e9printf("vesa init\n");
  
  memset(&vesa, 0, sizeof(vesa));
  krwlock_init(&vesa.lock);
  
  //XXX get from bootinfo header
  vesa.width = vesa_width;
  vesa.height = vesa_height;
  vesa.depth = vesa_bpp;
  vesa.linepad = 0;
  vesa.format = RGBA;
  
  vesa.head.lock = vesa_lock;
  vesa.head.unlock = vesa_unlock;
  vesa.head.flip = vesa_flip;
  vesa.head.blit = vesa_blit;
  vesa.head.get_info = vesa_get_info;
  
  //memset((unsigned char*) vesa_origin, 255, vesa_width*vesa_height*(vesa_bpp>>3));
  
  //int *i = (int*) vesa_origin;
  //int max = (vesa_width*vesa_height);
  //for (int j=0; j<max; j++) {
  //  *i++ = 0xfffffff;
  //}
  
  //extern void imemset(void *a, unsigned int val, int len);
  //imemset((void*)vesa_origin, 0xfffffff, vesa_width*vesa_height);
  
  return (Framebuffer*)&vesa;
}
