#include <stddef.h>
#include <stdint.h>
#include "ioctl.h"
#include "../../libc/libk.h"
#include "fs_file.h"
#include "../tty/termios.h"

int ioctl(int fd, intptr_t req, intptr_t arg) {
  if (req >= TERMIOS_START && req <= TERMIOS_END)
    return termios_ioctl_handle(fd, req, arg);
  else if (req >= GENERICFILE_START && req <= GENERICFILE_END)
    return fs_ioctl_handle(fd, req, arg);
  return -1;
}
