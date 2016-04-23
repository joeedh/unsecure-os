#ifndef _DMESG_H
#define _DMESG_H

void dmesg_initialize();
int dmesg_read(unsigned char *buf, int bytes, int start);
int dmesg_size();

#define DMESG_BUFFER_SIZE (32*1024)

#endif /* _DMESG_H */
