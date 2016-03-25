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

#define TASK_DEBUG
#ifdef TASK_DEBUG
  #define taskdebug(...) e9printf(__VA_ARGS__)
#else
  #define taskdebug(...)
#endif

static RWLock tlock = RWLOCK_INIT;

#ifdef LOCK_DEBUG
volatile int disable_all_locks = 0;
#endif

extern volatile Task tasks[];
volatile Task volatile * volatile k_lasttaskp;
volatile Task volatile * volatile k_curtaskp;

volatile int k_totaltasks;

unsigned long taskstacks[MAX_TASKS];
volatile unsigned long k_tidbase;

//used to set default task->sleep
const unsigned int task_switch_granularity = 10;

extern void __initMainTask();
extern void *stack_top;
static Task *task_get(int tid);

void tasks_initialize() {
  krwlock_init(&tlock);
  
  k_totaltasks = k_tidbase = 1;
  
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
  
  e9printf("    calling __initMainTask\n");
  
  //sets task->head
  asm("pusha");
  asm("pushf");
  __initMainTask();
  asm("popf");
  asm("popa");
  
  
  e9printf("    done.\n");
}

static unsigned int alloc_stack() {
  //krwlock_lock(&tlock);
  
  for (int i=0; i<MAX_TASKS; i++) {
    if (taskstacks[i] == 0) {
      unsigned int addr = MEM_STACK_BASE + MEM_STACK_INDV_SIZE*i;
      
      //align to 8-byte boundary
      if (addr & 7)
        addr = 8 - (addr & 7);
      
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
  extern volatile int _keydriver_isr0_flag;
  
  if (_keydriver_isr0_flag) {
    _keydriver_isr0_flag = 0;
    
    e9printf("key down message in isr0 handler!\n");
    
    e9printf("kcli_main: %p\n", kcli_main);
    e9printf("===========CURRENT===========\n");
    _e9print_task_stack(k_curtaskp);
    
    e9printf("\n-------------NEXT------------\n");
    _e9print_task_stack(k_curtaskp->next);
  }
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
    
    while (1) { //wait for switch
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
  
  Task *task = task_get(tid);
  
  if (task && task->tid == tid && (task->flag & TASK_SCHEDULED)) {
    task->flag = TASK_DEAD;
    
    //remove from schedule queue
    task->next->prev = task->prev;
    task->prev->next = task->next;
    
    task_cleanup(task, retval);
    
    interrupts_enable();
    
    //we're in the killed task? wait for task switch
    if (task == k_curtaskp) { 
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
  }
}

void _task_cleanup() {
  interrupts_disable();

  volatile Task *task = k_curtaskp;
  int retval = read_eax();
  
  task_cleanup(task, retval);
  interrupts_enable();
}

static Task *task_get(int tid) {
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
  
  asm("push %eax");
  asm("push %ebp");
  asm("push %ecx");
  asm("push %ebx");
  __initTask3(main, task);
  asm("pop %ebx");
  asm("pop %ecx");
  asm("pop %ebp");
  asm("pop %eax");

  interrupts_enable();
  
  _e9print_task_stack(task);
  e9printf("kcli_main: %x\n", kcli_main);
  
  taskdebug("task spawned successfuly\n");
  
  return tid;
}

Task *cur_task() {
  return (Task*) k_curtaskp;
}

void set_k_curtaskp(Task *task) {
  k_curtaskp = task;
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
