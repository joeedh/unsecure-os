#ifndef _POLL_H
#define _POLL_H

typedef struct pollfd {
  int fd;
  short events, revents;
} pollfd;

typedef int nfds_t;

enum {
  POLLIN=1<<0, //can read without blocking ('other than high-priority blocking')
  POLLRDNORM=1<<1, //can read without blocking
  POLLRDBAND=1<<2, 
  POLLPRI=1<<3, //high priority data can be read without blocking
  POLLOUT=1<<4, //can write without blocking ('other than high-priority blocking')
  POLLWRNORM=1<<5, //can write without blocking
  POLLWRBAND=1<<6,
  POLLERR=1<<7,
  POLLHUP=1<<8,
  POLLNVAL=1<<9 //internal fd member (revents only)
};

int poll(struct pollfd[], nfds_t len, int timeout_ms);

#endif /* _POLL_H */
