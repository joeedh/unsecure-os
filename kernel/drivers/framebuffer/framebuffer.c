#include "framebuffer.h"
#include "../vesa/vesa.h"

Framebuffer *the_framebuffer;

void framebuffer_lock() {
  the_framebuffer->lock(the_framebuffer);
}

void framebuffer_unlock() {
  the_framebuffer->unlock(the_framebuffer);
}

__attribute__((fastcall)) void framebuffer_blit(unsigned char *src, int sx, int sy, int sw, 
                                                int sh, int sformat, int dx, int dy, int dw, int dh) 
{
  the_framebuffer->blit(the_framebuffer, src, sx, sy, sw, sh, sformat, dx, dy, dw, dh);
}

void framebuffer_flip() { //is not guaranteed to exist, may be nop
  the_framebuffer->flip(the_framebuffer);
}

int framebuffer_get_info(int *wid, int *hgt, int *depth) {
  return the_framebuffer->get_info(the_framebuffer, wid, hgt, depth);
}

void framebuffer_init(void *bootinfo) {
  the_framebuffer = vesa_init(bootinfo);
}
