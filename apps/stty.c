#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>

#include <stropts.h>
#include <termios.h>

#define START(n) if (!strcmp(cmd, n)) {
#define CASE(n) } else if (!strcmp(cmd, n)) {
#define DEFAULT } else {
#define END }

int main(int argc, char **argv) {
  int iflag, oflag, cflag, lflag;
  int retval = 0;
  int changedflag = 0;
  
  ioctl(stdin->fd, TCGET_INFLAG, (intptr_t) &iflag);
  ioctl(stdin->fd, TCGET_OUTFLAG, (intptr_t) &oflag);
  ioctl(stdin->fd, TCGET_CTLFLAG, (intptr_t) &cflag);
  ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t) &lflag);
  
  for (int i=1; i<argc; i++) {
    char *cmd = argv[i];
    
    START("echo")
      lflag |= ECHO;
      changedflag |= ECHO;
    CASE("-echo")
      lflag &= ~ECHO;
      changedflag |= ECHO;
    CASE("raw")
      ioctl(stdin->fd, TCSET_BUFM, BUFM_RAW);
    CASE("-raw")
      ioctl(stdin->fd, TCSET_BUFM, BUFM_LINE);
      
      if (!(changedflag & ECHO)) {
        lflag |= ECHO;
      }
    DEFAULT
      fprintf(stderr, "Error: unknown command %s\n", cmd);
      retval = -1;
    END
  }
  
  ioctl(stdin->fd, TCSET_INFLAG, iflag);
  ioctl(stdin->fd, TCSET_OUTFLAG, oflag);
  ioctl(stdin->fd, TCSET_CTLFLAG, cflag);
  ioctl(stdin->fd, TCSET_LOCALFLAG, lflag);
  
  return retval;
}
