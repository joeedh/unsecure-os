#include "../libc/vsprintf.h"
#include "../libc/kmalloc.h"
#include "../task/lock.h"

#include "dmesg.h"

unsigned char *dmesg_ringbuf = NULL;
volatile unsigned int dmesg_ringcur = 0;

static Lock dmesg_lock;

void dmesg_initialize() {
  klock_init(&dmesg_lock);
  
  dmesg_ringbuf = kmalloc(DMESG_BUFFER_SIZE + 2048); //XXX buffer overflow hack!
  dmesg_ringcur = 0;
}

int dkprintf(char *fmt, ...) {
  klock_lock(&dmesg_lock);
  
  char *buf = dmesg_ringbuf + dmesg_ringcur;
  
  va_list vl;
  va_start(vl, fmt);
  int ret = vsprintf(buf, fmt, vl);
  va_end(vl);
  
  if (ret > 0) {
    dmesg_ringcur = (dmesg_ringcur + ret) % (DMESG_BUFFER_SIZE);
  }
  
  klock_unlock(&dmesg_lock);
  
  return ret;
}

int dmesg_chanaged_start(int state) {
  return dmesg_ringcur;
}
int dmesg_changed(int state) {
  return state != dmesg_ringcur;
}

int dmesg_read(unsigned char *buf, int bytes, int start) {
  size_t i, j = start < 0 ? dmesg_ringcur : start;
  
  for (i=0; i<bytes-1; i++) {
    unsigned char ch = dmesg_ringbuf[(i+j) % (DMESG_BUFFER_SIZE)];
    *buf++ = ch;
  }
  
  *buf++ = 0;
  return (i+j) % (DMESG_BUFFER_SIZE);
}

