#ifndef _KMALLOC_H
#define _KMALLOC_H

#include <stdint.h>
#include <stddef.h>

void kmalloc_init();
void kmalloc_init_with_holes();

//can only be run before kmalloc_init***
void kmalloc_add_hole(unsigned int base, unsigned int len, const unsigned char *name);

void *_kmalloc(size_t size, char *file, int line);
void *_krealloc(void *memory, size_t newsize, char *file, int line);
int _kfree(void *mem, char *file, int line);
int _kprintblocks(char *file, int line);
int test_kmalloc();

#define kmalloc(size) _kmalloc(size, __FILE__, __LINE__)
#define krealloc(mem, size) _krealloc(mem, size, __FILE__, __LINE__)
#define kfree(mem) _kfree(mem, __FILE__, __LINE__)
#define kprintblocks() _kprintblocks(__FILE__, __LINE__)

#endif /* _KMALLOC_H */
