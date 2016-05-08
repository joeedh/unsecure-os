#include "task.h"

#include "../definitions/memory.h"

#include "../io.h"
#include "../interrupts.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../drivers/keyboard/keyboard.h"
#include "../drivers/tty/tty.h"
#include "rwlock.h"

#include "process.h"
#include "../exception.h"

//#define TASK_DEBUG

#ifdef TASK_DEBUG
  #define taskdebug(...) e9printf(__VA_ARGS__)
#else
  #define taskdebug(...)
#endif

static RWLock tlock = RWLOCK_INIT;

#ifdef LOCK_DEBUG
volatile int disable_all_locks = 0;
#endif

volatile Task tasks[MAX_TASKS];
volatile Task volatile * volatile k_lasttaskp;
volatile Task volatile * volatile k_curtaskp;

volatile int k_totaltasks;

unsigned long taskstacks[MAX_TASKS];
volatile unsigned long k_tidbase;


//used to set default task->sleep
const unsigned int task_switch_granularity = 10;

extern void __initMainTask();
extern void *stack_top;

void tasks_initialize() {
  krwlock_init(&tlock);
  
  k_totaltasks = 1;
  k_tidbase = 1; //0 is reserved for freed tasks
  
  memset((void*)taskstacks, 0, sizeof(taskstacks));
  memset((void*)tasks, 0, sizeof(Task)*MAX_TASKS);
  
  //init main thread
  volatile Task *task = tasks;
  
  task->flag = TASK_ALIVE|TASK_SCHEDULED;
  task->tid = k_tidbase++;
  task->stack = stack_top;
  
  task->next = task->prev = task;
  task->sleep = task_switch_granularity;
  task->flag = TASK_ALIVE|TASK_SCHEDULED;
  
  //set main idle task
  k_curtaskp = k_lasttaskp = task;
  
  //e9printf("    calling __initMainTask\n");
  
  //sets task->head
  //__initMainTask();
  //e9printf("    done.\n");
}

static unsigned int alloc_stack() {
  //krwlock_lock(&tlock);
  
  for (int i=0; i<MAX_TASKS; i++) {
    if (taskstacks[i] == 0) {
      unsigned int addr = MEM_STACK_BASE + MEM_STACK_INDV_SIZE*i;
      
      //align to 16-byte boundary
      if (addr & 15)
        addr = 16 - (addr & 15);
      
      taskstacks[i] = addr;
      
      //krwlock_unlock(&tlock);
      return addr;
    }
  }
  
  //krwlock_unlock(&tlock);
  kerror(0, "Failed to allocated stack");
  
  return 0L;
}

void _null_finishcb(int retval, int tid, int pid) {
}

void _e9print_task_stack(Task *task) {
  e9printf("task: %x\n", task);
  e9printf("task->head: %x\n", task->head);
  e9printf("stack:\n");

  unsigned int *stack = (unsigned int*) task->head;
  for (int i=0; i<17; i++) {
    e9printf("%d:  %x\n", i, stack[i]);
  }
}

extern void kcli_main();

void isr0_debug() {
  //extern volatile int _keydriver_isr0_flag;
  
  /*
  if (_keydriver_isr0_flag) {
    _keydriver_isr0_flag = 0;
    
    e9printf("key down message in isr0 handler!\n");
    
    e9printf("kcli_main: %p\n", kcli_main);
    e9printf("===========CURRENT===========\n");
    _e9print_task_stack(k_curtaskp);
    
    e9printf("\n-------------NEXT------------\n");
    _e9print_task_stack(k_curtaskp->next);
  }
  //*/
}

void free_stack(unsigned long stack) {
  int found = 0;
  
  for (int i=1; i<MAX_TASKS+1; i++) {
    if (taskstacks[i] == stack) {
      taskstacks[i] = 0;
      found = 1;
      break;
    }
  }
  
  if (!found) {
    e9printf("FAILED TO FREE STACK\n");
  }
}

void _old_on_exception(int code, int codedata, void *instruction, void *stack) {
#if 0
  e9printf("_on_exception called.  code: %d, codedata: %d, eip: %p, old stack: %p\n", code, codedata, instruction, stack);
  e9printf("  eax: %x, ebx: %x, edx: %x\n", read_eax(), read_ebx(), read_edx());
  e9printf("  ebp: %x, esp: %x, eip: %x\n\n", read_ebp(), read_esp(), get_eip());
  
  if (code == 0) {
    //handle
    unsigned char *inst = instruction;
    
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
        break;
    }
    
    e9printf("  resuming. . .\n");
    _exception_resume(inst, stack);
    
    //resume execution after division instruction
    /*
    asm(  "mfence\n\t"
          "mov %0, %%eax\n\t"
          "mov %1, %%esp\n\t"
          "jmp %%eax"
          ::"g"((uintptr_t)inst), "g"((uintptr_t)stack)
        );
    */
  }
  
  _exit(-1);
#endif
}

int task_set_signals(int tid, SignalInfo *signals) {
  unsigned int state = safe_entry();
  Task *task = task_from_tid(tid);
  
  if (!task) {
    e9printf("task_set_signals: invalid tid %d\n", tid);
    
    safe_exit(state);
    return -1;
  }
  
  task->signals = signals;
  
  safe_exit(state);
  return 0;
}

//*
void task_cleanup(volatile Task *task, int retval) {
  task->finishcb(retval, task->tid, task->pid);
  
  if (task->flag == TASK_DEAD) {
    interrupts_enable();
    return;
  }
  
  int iscurrent = task == k_curtaskp;
  
  //krwlock_lock(&tlock);
  interrupts_disable();
  
  //take out of schedule loop
  task->tid = 0; //clear tid
  task->prev->next = task->next;
  task->next->prev = task->prev;
  task->flag = TASK_DEAD;

  //krwlock_unlock(&tlock);
  
  if (iscurrent) {
    free_stack((unsigned long) task->stack);
    interrupts_enable();
    if (CAN_YIELD) {
      task_yield();
    }
    
    while (1) { //wait for switch
      e9printf("task_cleanup: zombie!\n");
      
      if (CAN_YIELD) {
        task_yield();
      }
    }
  } else {
    free_stack((unsigned long) task->stack);
    interrupts_enable();
  }
  
  interrupts_enable();
}
//*/

void task_destroy(int tid, int retval, int wait_if_inside) {
  interrupts_disable();
  
  Task *task = task_from_tid(tid);
  
  if (task && task->tid == tid && (task->flag & TASK_SCHEDULED)) {
    task->flag = TASK_DEAD;
    
    //remove from schedule queue
    task->next->prev = task->prev;
    task->prev->next = task->next;
    
    task_cleanup(task, retval);
    
    interrupts_enable();
    
    //we're in the killed task? wait for task switch
    if (wait_if_inside && task == k_curtaskp) { 
      while (1) {
      }
    }
    
    return;
  }
  
  interrupts_enable();
}

extern void __initTask3(void *start, Task *newtask);
extern void __saveStack();

typedef struct wrapper {
  int argc;
  void *argv;
  int (*main)(int argc, char **argv);
  volatile Task *task;
} wrapper;

void wrapped_main(int argc, char **argv) {
  wrapper *data = (wrapper*)argv;
  
  int ret = data->main(data->argc, data->argv);
  
  //task_cleanup kills the thread
  task_cleanup(data->task, ret);
  
  while (1) {
    task_yield();
  }
}

void _task_cleanup() {
  interrupts_disable();

  volatile Task *task = k_curtaskp;
  int retval = read_eax();
  
  task_cleanup(task, retval);
  interrupts_enable();
}

Task *task_from_tid(int tid) {
  for (int i=0; i<MAX_TASKS; i++) {
    if (tasks[i].tid == tid) 
      return tasks + i;
  }
  
  return NULL;
}

int spawn_task(int argc, char **argv, int (*main)(int argc, char **argv),
                void (*finishcb)(int retval, int tid, int pid), struct Process *proc) {
  interrupts_disable();
  taskdebug("spawning task\n");
  
  volatile Task *task = NULL;
  volatile unsigned int *stack;
  int i;
  
  if (finishcb == NULL) {
    finishcb = _null_finishcb;
  }
  
  for (i=0; i<MAX_TASKS; i++) {
    if (tasks[i].flag == TASK_DEAD) {
      task = tasks + i;
      break;
    }
  }
  
  if (!task) {
    kerror(0, "hit maximum task limit");
    interrupts_enable();
    return -1;
  }
  
  if (i+1 > k_totaltasks) {
    k_totaltasks = i+1;
  }
  
  task->finishcb = finishcb;
  task->prev = (Task*) k_curtaskp;
  task->next = k_curtaskp->next;
  
  k_curtaskp->next->prev = task;
  k_curtaskp->next = task;

  unsigned int addr = alloc_stack();
  
  task->flag = TASK_ALIVE|TASK_SCHEDULED;
  task->stack = (void*)addr;
  task->entry = (void*)main;
  task->tid = k_tidbase++;
  task->sleep = task_switch_granularity;
  task->argc = argc;
  task->argv = argv;
  task->pid = proc->pid;
  task->proc = proc;
  
  stack = (unsigned int*) task->stack;

  //e9printf(":argc: %x, argv: %x stack: %x\n", (unsigned int) argc, (unsigned int) argv, (unsigned int)task->stack);
    
  *stack-- = (unsigned int) argv;
  *stack-- = (unsigned int) argc;
  
  //for (int i=0; i<16; i++) {
  //  *stack-- = 0;
  //}
  
  task->head = stack;
  
  int tid = task->tid;
  
  /*
  extern unsigned char myTss[0x64];
  e9printf("Ready.  myTss: %x\n", myTss);
  int i2=0;
  while (i2++ < 250000) {
  }
  //*/

  taskdebug("adding task %d to thread queue\n", tid);
  
  /*
  asm("push %eax");
  asm("push %ebp");
  asm("push %ecx");
  asm("push %ebx");
  __initTask3(main, task);
  asm("pop %ebx");
  asm("pop %ecx");
  asm("pop %ebp");
  asm("pop %eax");//*/

  //asm("push %ebp");
  __initTask3(main, task);
  //asm("pop %ebp");
  
  interrupts_enable();
  
  //_e9print_task_stack(task);
  //e9printf("kcli_main: %x\n", kcli_main);
  
  taskdebug("task spawned successfuly\n");
  
  return tid;
}

Task *cur_task() {
  return (Task*) k_curtaskp;
}

//if all tasks are sleeping, returns first one
//(idle thread)
volatile Task *get_next_task() {
  volatile Task *first = k_curtaskp, *cur = first;
  volatile Task *next = first->next;
  int i=0;
  
  do {
    if (!cur->sleep) {
      //next = cur;
      break;
    } else if (cur->sleep > 0) {
      cur->sleep--;
    }
    
    cur = cur->next;
  } while (cur != first && i++ < 5);
  
  return next;
}

volatile Task *get_next_task_timer() {
  volatile Task *first = k_curtaskp, *cur = first;
  volatile Task *next = tasks;
  int found=0;
  int i=0;
  
  do {
    if (cur->sleep > 0) {
      cur->sleep--;
    } else if (!found && !cur->sleep) {
      next = cur;
      found = 1;
      //break;
    }
    
    cur = cur->next;
  } while (cur != first && i++ < k_totaltasks);
  
  return next;
}

int task_interrupt(int tid, void (*func)(void));
int _task_interrupt_proc(int argc, char **argv) {
  interrupts_disable();
  
  e9printf("interrupting thread!\n");
  task_interrupt(argc, (void*)argv);
  e9printf("done.\n");
  
  interrupts_enable();
  return 0;
}

void *_thread_ctx_push(void *stack);

int task_interrupt(int tid, void (*func)(void)) {
  unsigned int state = safe_entry();
  
  Task *task = task_from_tid(tid);
  
  if (!task) {
    safe_exit(state);
    return -1;
  }
  
  if (task == k_curtaskp) {
    e9printf("spawning thread interrupt task\n");
    
    spawn_task(tid, (void*) func, _task_interrupt_proc, NULL, (Process*) k_curtaskp->proc);
    safe_exit(state);
    
    //don't yield, we might be in an irq or exception handler -> task_yield();
    
    return 0;
  }
  
  uintptr_t *stack = (uintptr_t*) task->head;
  uintptr_t eip = stack[11]; //XXX check me!
  
  //stack--;
  
  *--stack = eip;
  *--stack = read_eflags() | (1<<9); //make sure interrupts are enabled
  *--stack = 0x08;
  *--stack = (uintptr_t) func;
  
  stack = _thread_ctx_push(stack);
  
  task->head = stack;
  
  //XXX remove from scheduling queue
  task->prev->next = task->next;
  task->next->prev = task->prev;
  
  safe_exit(state);
  return 0;
}

void next_task() {
  volatile Task *task = get_next_task();
  k_curtaskp = task;
  //k_curtaskp = k_curtaskp->next; //task;
  
  
  /*
  if (k_totaltasks < 2) {
    return;
  }
  
  Task *task = NULL;
  
  for (int i=1; i<k_totaltasks; i++) {
    int j = (k_curtaski + i) % k_totaltasks;

    if (tasks[j].flag != TASK_DEAD) {
      task = tasks + j;
      k_curtaski = j;
      break;
    }      
  }
  
  k_curtaskp = task;
  
  return;*/
}

void task_suspend(int tid) {
  unsigned int state = safe_entry();
  
  Task *task = task_from_tid(tid);
  if (!task) {
    e9printf("task_suspend: invalid tid %d\n", tid);
    
    safe_exit(state);
    return;
  }
  
  if (!(task->flag & TASK_SUSPENDED)) {
    task->prev->next = task->next;
    task->next->prev = task->prev;
  }
  
  task->flag |= TASK_SUSPENDED;
  
  safe_exit(state);
}

void task_unsuspend(int tid) {
  unsigned int state = safe_entry();
  
  Task *task = task_from_tid(tid);
  if (!task) {
    e9printf("task_unsuspend: invalid tid %d\n", tid);
    
    safe_exit(state);
    return;
  }
  
  if (task->flag & TASK_SUSPENDED) {
    task->flag &= ~TASK_SUSPENDED;
    
    k_curtaskp->next->prev = task;
    
    task->next = k_curtaskp->next;
    task->prev = k_curtaskp;
    
    k_curtaskp->next = task;
  }
  
  safe_exit(state);
}

