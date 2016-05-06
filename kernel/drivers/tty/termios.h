#ifndef _TERMIOS_H
#define _TERMIOS_H

#include <stddef.h>
#include <stdint.h>

#ifdef __KERNEL_BUILD__
#include "../fs/ioctl.h"
//#include "../../task/process.h"
#else
#include "stropts.h"
#endif

typedef unsigned char cc_t;
typedef enum { 
  B0,
  B50=50,
  B75=75,
  B110=110,
  B134=134,
  B150=150,
  B200=200,
  B300=300,
  B600=600,
  B1200=1200,
  B1800=1800,
  B2400=2400,
  B4800=4800,
  B9600=9600,
  B19200=19200,
  B38400=38400
} speed_t;

typedef int tcflag_t;

#define NCCS 33

typedef struct termios {
  tcflag_t c_iflag; //input modes
  tcflag_t c_oflag; //output modes
  tcflag_t c_cflag; //control modes
  tcflag_t c_lflag; //local modes
  cc_t c_cc[NCCS]; //control characters
  char pad[7];
} termios;

#define VEOF = 0
#define VINTR = 1
#define VKILL = 2
#define VQUIT = 3
#define VSTART = 4
#define VSTOP = 5
#define VSUSP = 6
#define VTIME = 7
#define VMIN = 8
#define VERASE ='\b'
#define VEOL = '\n'

//input modes
enum {
  BRKINT=(1<<0),
  ICRNL=(1<<1),
  IGNBRK=(1<<2),
  IGNCR=(1<<3),
  IGNCR2=(1<<4),
  INLCR=(1<<5),
  INPCK=(1<<6),
  ISTRIP=(1<<7),
  IXANY=(1<<8),
  IXOFF=(1<<9),
  IXON=(1<<10),
  PARMRK=(1<<11)
};

//output modes
enum {
  OPOST=(1<<0),
  ONLCR=(1<<1),
  OCRNL_NL=(1<<2),
  OCRNL_NL2=(1<<3),
  ONOCR=(1<<4),
  ONLRET=(1<<5),
  OFDEL=(1<<6),
  OFILL=(1<<7),
  NLDLY=(1<<8),
  NLDLY2=(1<<9),
  CRDLY=(1<<10),
  CRDLY2=(1<<11),
  CRDLY3=(1<<12),
  CRDLY4=(1<<13),
  CRDLY5=(1<<14),
  TABDLY=(1<<15),
  TABDLY2=(1<<16),
  TABDLY3=(1<<17),
  TABDLY4=(1<<18),
  TABDLY5=(1<<19),
  BSDLY=(1<<20),
  BSDLY2=(1<<21),
  VTDLY=(1<<22),
  VTDLY2=(1<<23),
  FFDLY=(1<<24),
  FFDLY2=(1<<25),
};

//control flags
enum {
  CSIZE=(1<<0), //defaults to 8
  CSIZE_CS5=(1<<3),
  CSIZE_CS6=(1<<1),
  CSIZE_CS7=(1<<2),
  CSTOPB=(1<<4),
  CREAD=(1<<5),
  PARENB=(1<<6),
  PARODD=(1<<7),
  HUPCL=(1<<8),
  CLOCAL=(1<<9)
};

//local modes
enum {
  ECHO=1<<0,
  ECHOE=1<<1,
  ECHOK=1<<2,
  ECHONL=1<<3,
  ICANON=1<<4,
  IEXTEN=1<<5,
  ISIG=1<<6, //enable signals
  NOFLS=1<<7, //disable flush after interrupt or quit
  TOSTOP=1<<8 //Send SIGTTOU for background output.
};

//tcsetattr
enum {
  TCSANOW,
  TCSADRAIN,
  TCSAFLUSH
};

//tcflush
enum {
  TCIFLUSH,
  TCIOFLUSH,
  TCOFLUSH
};

//tcflow
enum {
  TCIOFF,
  TCION,
  TCOOFF,
  TCOON
};

enum {
  BUFM_LINE,
  BUFM_RAW
};

enum {
  TCSET_BUFM = TERMIOS_START,
  TCSET_INFLAG,
  TCSET_OUTFLAG,
  TCSET_CTLFLAG,
  TCSET_LOCALFLAG,
  TCGET_BUFM,
  TCGET_INFLAG,
  TCGET_OUTFLAG,
  TCGET_CTLFLAG,
  TCGET_LOCALFLAG
};

/*
speed_t cfgetispeed(const struct termios *);
speed_t cfgetospeed(const struct termios *);
int     cfsetispeed(struct termios *, speed_t);
int     cfsetospeed(struct termios *, speed_t);
int     tcdrain(int);
int     tcflow(int, int);
int     tcflush(int, int);
int     tcgetattr(int, struct termios *);
int     tcgetsid(int); //XXX: should return pid_t
int     tcsendbreak(int, int);
int     tcsetattr(int, int, const struct termios *);
//*/

#ifdef __KERNEL_BUILD__
int termios_ioctl_handle(int fd, intptr_t req, intptr_t arg);
#endif

#endif /* _TERMIOS_H */
