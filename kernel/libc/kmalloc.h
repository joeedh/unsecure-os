#ifndef _KMALLOC_H
#define _KMALLOC_H

#include <stdint.h>
#include <stddef.h>

void kmalloc_init();

void *_kmalloc(size_t size, char *file, int line);
int _kfree(void *mem, char *file, int line);
int _kprintblocks(char *file, int line);
int test_kmalloc();

#define kmalloc(size) _kmalloc(size, __FILE__, __LINE__)
#define kfree(mem) _kfree(mem, __FILE__, __LINE__)
#define kprintblocks() _kprintblocks(__FILE__, __LINE__)

#endif /* _KMALLOC_H */
