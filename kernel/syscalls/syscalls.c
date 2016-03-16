//non-syscall non-mmu mode

//. . .monolithic minix 1.0!

//wait.  that would be linux.


const unsigned char allowed_syscalls[] = {
  "", //restart_syscall
  "exit",
  "fork",
  "read",
  "write",
  "open",
  "close",
  "",//waitpid,
  "",//link,
  "",//unlink,
  "",//execve
  "",//chdir
  "",//time
  
  //"pipe",
  //"opendir",
  //"opendir_inode",
  //"readdir",
  //"closedir"
};
