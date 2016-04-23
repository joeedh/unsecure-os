#ifndef _STDLIB_H
#define _STDLIB_H

#include <stddef.h>
#include <stdint.h>

int system(const char *string);

#ifndef __KERNEL_BUILD__

#ifndef SKIP_DEF_TASK_YIELD
void task_yield(void);
#endif

char *getenv(const char *name);
int setenv(const char *envname, const char *envval, int overwrite);

void *_malloc(size_t size, char *file, int line);
void _free(void *ptr, char *file, int line);

#define malloc(size) _malloc(size, __FILE__, __LINE__)
#define free(ptr) _free(ptr, __FILE__, __LINE__)

#endif

#endif /* _STDLIB_H */
