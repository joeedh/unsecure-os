#ifndef _PROCESS_SPAWN_H
#define _PROCESS_SPAWN_H

#include <stddef.h>
#include <stdint.h>
#include "../libc/string.h"

struct Process;

void *pmalloc(size_t size);
void *prealloc(void *mem, size_t size);
int pfree(void *mem);
void pfreeall(struct Process *proc);

int posix_spawn(int *pid_out, const char *path, char *file_actions, char *attrp, char **argv, char **envp);

#endif /* _PROCESS_SPAWN_H */
