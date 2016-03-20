int wait(int *stat_loc);
int waitpid(int pid, int *stat_loc, int options);

enum {
  WCONTINUED=1,
  WNOHANG=2,
  WUNTRACED=4
};

