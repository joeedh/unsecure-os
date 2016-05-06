#ifndef _IOCTL_H
#define _IOCTL_H

#define TERMIOS_START       0
#define TERMIOS_END         256

#define GENERICFILE_START  512
#define GENERICFILE_END    768

int ioctl(int fd, intptr_t req, intptr_t arg);

#endif /* _IOCTL_H */
