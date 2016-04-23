#include "../libc/kmalloc.h"
#include "../task/lock.h"

#include "dmesg.h"
#include "../drivers/fs/memfile.h"
#include "../drivers/fs/fs_interface.h"
#include "../drivers/fs/fs_file.h"
#include "../libc/stdio.h"

static FILE *dmesg;
static FILE _dmesg;

static Lock dmesg_lock;

void dmesg_initialize() {
  klock_init(&dmesg_lock);
  
  dmesg = &_dmesg;
  _dmesg.fd = kmemfile_create(DMESG_BUFFER_SIZE, 0);
}

int dmesg_read(unsigned char *buf, int bytes, int start) {
  return 0;//return pread(dmesg, buf, bytes, start);
}

int dmesg_size() {
  return DMESG_BUFFER_SIZE;
}
