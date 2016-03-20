#ifndef _PATH_H
#define _PATH_H

#include <stddef.h>
#include <stdint.h>

#define MAX_ARGV 4192

int normpath(unsigned char *path, size_t buffersize);
int shlex(char *line, char *outbuf[MAX_ARGV]);


#endif /* _PATH_H */
