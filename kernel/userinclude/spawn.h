#ifndef _SPAWN_H
#define _SPAWN_H

int posix_spawn(int *pid_out, const char *path, char *file_actions, char *attrp, char **argv, char **envp);
int getpid();

#endif /* _SPAWN_H */
