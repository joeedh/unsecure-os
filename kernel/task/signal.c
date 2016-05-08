#include "../exception.h"
#include "../interrupts.h"
#include "../io.h"

#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/stdlib.h"
#include "../libc/stdio.h"
#include "../libc/list.h"

#include "task.h"
#include "process.h"
#include "process_management.h"

#include "lock.h"
#include "rwlock.h"

#include "signal.h"

static int sibmap[255];

void init_sibmap() {
  //page 484 intel docs
  unsigned char map[] = {
    0x04, 0x0C, 0x14, 0x1C, 0x24, 0x2C, 0x34, 0x3C,
    0x44, 0x4C, 0x54, 0x5C, 0x64, 0x6C, 0x74, 0x7C,
    0x84, 0x8C, 0x94, 0x9C, 0xA4, 0xAC, 0xB4, 0xBC
  };
  
  memset(sibmap, 0, sizeof(sibmap));
  
  for (int i=0; i<(int)sizeof(map); i++) {
    sibmap[map[i]] = 1;
  }
}

static inline int get_modrm_op_length(unsigned char *inst) {
  int size = 2;
  
  int modrm = inst[1];
  
  //int reg = (modrm>>3) & 7;
  //int mod = (modrm>>6);
  //int rm = modrm & 7;
  
  if (sibmap[modrm]) {
    //XXX check me
    size += 5;
  }
  
  return size;
}

static int div0_handler(int code, int codedata, CPUState *cpustate) {
  e9printf("division by zero! stack: %x, eip: %x\n", cpustate->esp, cpustate->eip);
  //_exit(-1);
  
  unsigned char *inst = cpustate->eip;
    
  //skip prefixes
  while (*inst == 0x66 || *inst == 0x67 || *inst == 0x0f)
    inst++;
  
  e9printf("  inst: %x %x %x %x %x\n", inst[0], inst[1], inst[2], inst[3], inst[4]);
  
  switch (inst[0]) {
    case 0xf7: {
      int opsize = get_modrm_op_length(inst);
      e9printf("  instruction size: %d\n", opsize);
      inst += opsize;
      e9printf("  final inst: %x %x %x %x %x\n", inst[0], inst[1], inst[2], inst[3], inst[4]);
      break;
    }
    default:
      e9printf("  unknown division instruction %x\n", inst[0]);
      _exit(-1);
      return 0;
  }

  _exception_resume(inst, cpustate->esp);
  
  //we never reach here, _exception_resume jmps back into thread
  return 1;
}

void signal_initialize() {
  init_sibmap();
  
  exception_push_handler(0, div0_handler);
}

//returns 1 if task should resume execution, 0 if not
int do_signal_handler(int signal, int tid) {
  unsigned int state = safe_entry();
  Task *task = task_from_tid(tid);
  
  if (!task) {
    e9printf("do_signal_handler: invalid tid %d\n", tid);
    
    safe_exit(state);
    return 0;
  }
  
  uintptr_t mask;
  
  if (!task->signals) {
    mask = DEFAULT_SIGMASK;
  } else {
    mask = task->signals->mask;
  }
  
  if (mask & (1<<signal)) {
    safe_exit(state);
    return 1;
  }
  
  safe_exit(state);
  return 0;
}

//signal, tid are stored in argc, argv
static int signal_task_main(int argc, char **argv) {
  if (do_signal_handler(argc, (int)argv)) {
    task_unsuspend(argc);
  } else {
    //destroy task
    unsigned int state = safe_entry();
    Task *task = task_from_tid(argc);
    
    if (!task) {
      //eek!
      e9printf("signal_task_main: invalid tid %d\n", argc);
      
      safe_exit(state);
      return -1;
    }
    
    extern void task_cleanup(volatile Task *task, int retval);
    
    task_cleanup(task, -1);
    safe_exit(state);
  }
  
  return 0;
}

static int indirect_task_signal_main(int argc, char **argv) {
  task_signal(argc, (int)argv);
  return 0;
}

int task_signal(int tid, int signal) {
  unsigned int state = safe_entry();
  
  if (tid == k_curtaskp->tid) {
    spawn_task(tid, (char**)signal, indirect_task_signal_main, NULL, (Process*) k_curtaskp->proc);
    
    safe_exit(state);
    task_yield();
    return 0;
  }
  
  Task *task = task_from_tid(tid);
  if (!task) {
    e9printf("task_signal: invalid tid %d\n", tid);
    safe_exit(state);
    
    return -1;
  }
  
  task_suspend(tid);
  spawn_task(signal, (char**)tid, signal_task_main, NULL, (Process*) task->proc);
  
  safe_exit(state);
  
  return 0;
}
