#ifndef _SIGNAL_H
#define _SIGNAL_H

#include <stddef.h>
#include <stdint.h>

typedef voltaile int sig_atomic_t;
typedef unsigned int sigset_t;
//typedef int pid_t

union sigval {
  int sival_int;
  void *sival_ptr;
};

typedef struct sigevent {
  int sigev_notify;
  int sigev_signo;
  int sigev_value;
  int (*sigev_notify_function)(union sigval val);
} sigevent;

typedef struct sigaction {
  void (*sa_handler)(int signal);
  sigset_t sa_mask;
  int sa_flags;
  void (*sa_sigaction)(int signal, siginfo_t *info, void *data);
} sigaction;

typedef struct siginfo_t {
  int si_signo, si_code, si_errno;
  int si_pid, si_uid; //set by SIGCHLD
  void *si_addr; //set by SIGILL, SIGFPE, SIGSEGV, SIGBUS
  int si_status; //exit value or signal
  int si_band; //set by SIGPOLL
  union sigval si_value;
} siginfo_t;

typedef struct mcontext_t {
  uintptr_t eax, ebx, ecx, edx;
  uintptr_t ebp, esp, eip, edi, esi;
  uintptr_t eflags;
  
  unsigned char fpu[256];
} mcontext_t;

typedef struct stack_t {
  void *ss_sp;
  size_t ss_size;
  int ss_flags;
} stack_t;
typedef uintptr_t stack_t;

typedef struct ucontext_t {
  ucontext_t *uc_link;
  sigset_t uc_sigmask;
  stack_t uc_stack;
  mcontext_t uc_mcontext; //saved context
} ucontext_t;

enum {
  SIG_DFL, //request default
  SIG_ERR, //return value from signal() in case of error
  SIG_HOLD, //request that signel be held
  SIG_IGN, //request that  signal be ignored
};

enum {
  SIGABRT=(1<<0), //A terminate
  SIGALRM=(1<<1), //T terminate
  SIGBUS=(1<<2), //A terminate
  SIGCHLD=(1<<3), //ignore.  means child stopped
  SIGCONT=(1<<4), //contiue if stopped
  SIGFPE=(1<<5), //A terminate
  SIGHUP=(1<<6), //T terminate
  SIGILL=(1<<7), //A terminate.  means illegal instruction
  SIGINT=(1<<8), //T terminate.  means terminal interrupt signal
  SIGKILL=(1<<9), //T terminate
  SIGPIPE=(1<<10), //T terminate.  means wait for pipe
  SIGQUIT=(1<<11), //A terminate.  means request quit
  SIGSEGV=(1<<12), //A terminate.  means segmentation fault
  SIGSTOP=(1<<13), //stop
  SIGTERM=(1<<14), //T terminate
  SIGTSTP=(1<<15), //stop
  SIGTTIN=(1<<16), //stop
  SIGTTOU=(1<<17), //stop
  SIGUSR1=(1<<18), //T terminate
  SIGUSR2=(1<<19), //T terminate
  SIGPOLL=(1<<20), //T terminate
  SIGPROF=(1<<21), //T terminate
  SIGSYS=(1<<22), //A terminate
  SIGTRAP=(1<<23), //A terminate
  SIGURG=(1<<24), //ignore
  SIGVTALARM=(1<<25), //T terminate
  SIGXCPU=(1<<26), //A termiate. means CPU time limit exceeded
  SIGXFSZ=(1<<27) //A terminate. means file size limit exceeded
};

//#define SIGRTMIN
//#define SIGRTMAX

enum {
  SIG_BLOCK,
  SIG_UNBLOCK,
  SIG_SETMASK
};

enum {
  SA_NOCLDSTOP=(1<<0),
  SA_ONSTACK=(1<<1),
  SA_RESETHAND=(1<<2),
  SA_RESTART=(1<<3),
  SA_SIGINFO=(1<<4),
  SA_NOCLDWAIT=(1<<5),
  SA_NODEFER=(1<<6),
  SS_ONSTACK=(1<<7),
  SS_DISABLE=(1<<8),
  MINSIGSTKSZ=(1<<9),
  SIGSTKSZ=(1<<10)
};

enum {
  ILL_ILLOPC, //illegal opcode
  ILL_ILLOPN, //illegal operand
  ILL_ILLADR, //illegal addressing mode
  ILL_ILLTRP, //illegal trap
  ILL_PRVOPC, //privileged opcode
  ILL_PRVREG, //privileged register
  ILL_COPROC,
  ILL_BADSTK,
  ILL_INTDIV,
  ILL_INTOVF,
  ILL_FLTDIV,
  ILL_FLTOVF,
  ILL_FLTUND,
  ILL_FLTRES,
  ILL_FLTINV,
  ILL_FLTSUB,
  SEGV_MAPERR,
  SEGV_ACCERR,
  BUS_ADRALN,
  BUS_ADRERR,
  BUS_OBJERR,
  TRAP_BKPT,
  TRAP_TRACE,
  CLD_EXITED,
  CLD_KILLED,
  CLD_DUMPED,
  CLD_TRAPPED,
  CLD_STOPPED,
  CLD_CONTINUED,
  POLL_IN,
  POLL_OUT,
  POLL_MSG,
  POLL_ERR,
  POLL_PRI,
  POLL_HUP,
  SI_USER,
  SI_QUEUE,
  SI_TIMER,
  SI_ASYNCIO,
  SI_MESGQ
};

#endif /* _SIGNAL_H */
