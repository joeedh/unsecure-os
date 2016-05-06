#include "termios.h"
#include "tty.h"

int termios_ioctl_handle(int fd, intptr_t req, intptr_t arg) {
  struct termios *settings = terminal_get_termios();
  unsigned int *iptr = (unsigned int*) arg;
  
  switch (req) {
    case TCSET_BUFM:
      terminal_set_bufmode(arg);
      break;
    case TCSET_INFLAG:
      settings->c_iflag = arg;
      break;
    case TCSET_OUTFLAG:
      settings->c_oflag = arg;
      break;
    case TCSET_CTLFLAG:
      settings->c_cflag = arg;
      break;
    case TCSET_LOCALFLAG:
      settings->c_lflag = arg;
      break;
    case TCGET_BUFM:
      *iptr = terminal_get_bufmode();
      break;
    case TCGET_INFLAG:
      *iptr = settings->c_iflag;
      break;
    case TCGET_OUTFLAG:
      *iptr = settings->c_oflag;
      break;
    case TCGET_CTLFLAG:
      *iptr = settings->c_cflag;
      break;
    case TCGET_LOCALFLAG:
      *iptr = settings->c_lflag;
      break;
  }
  
  return -1;
}
