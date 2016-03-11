#include "stddef.h"
#include "stdint.h"

#include "fs_file.h"
#include "fs_interface.h"
#include "../tty/tty.h"
#include "../../libc/libk.h"
#include "../../libc/string.h"
#include "../../libc/list.h"
#include "../../io.h"
#include "../../task/task.h"
#include "../../timer.h"

static List open_files;

void filesystem_initialize() {
  open_files.first = open_files.last = NULL;
}

static void _set_error(int err, const char *message) {
}

int read(int fd, void *buf, unsigned int bytes) {
  FSFile *file = (FSFile*) fd;
  
  if (!(file->access & O_RDONLY) || !(file->fs->accessmode(file->device) & O_RDONLY)) {
    _set_error(FILE_PERMISSIONS_ERROR, "Invalid permissions");
    return 0;
  }
  
  if (!file->fs->pread) {
    _set_error(FILE_TYPE_ERROR, "Read not supported by the filesystem driver");
    return 0;
  }
  
  int ret = file->fs->pread(file->device, file->internalfd, buf, bytes, file->cursor);
  
  file->cursor += ret;
  
  return ret;
}
