#include "task.h"

#include "../io.h"
#include "../interrupts.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../drivers/keyboard/keyboard.h"
#include "../drivers/tty/tty.h"

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

void tasks_initialize() {
  k_totaltasks = 1;
  k_tidbase = 1;
  k_curtaskp = k_lasttaskp = NULL;
  
  memset((void*)taskstacks, 0, sizeof(taskstacks));
  memset((void*)tasks, 0, sizeof(Task)*MAX_TASKS);
  
  //init main thread
  volatile Task *task = tasks;
  
  task->flag = TASK_ALIVE;
  task->tid = k_tidbase++;
  task->stack = stack_top;
  
  task->next = task->prev = task;
  task->sleep = task_switch_granularity;
  
  //set main idle task
  k_curtaskp = k_lasttaskp = task;
  
  //sets task->head
  __initMainTask();
}

static unsigned int alloc_stack() {
  for (int i=0; i<MAX_TASKS; i++) {
    if (taskstacks[i] == 0) {
      unsigned int addr = MEM_STACK_BASE + MEM_STACK_INDV_SIZE*i;
      
      taskstacks[i] = addr;
      
      return addr;
    }
  }
  
  kerror(0, "Failed to allocated stack");
  
  return 0L;
}

void free_stack(unsigned long stack) {
  for (int i=1; i<MAX_TASKS+1; i++) {
    if (taskstacks[i] == stack) {
      taskstacks[i] = 0;
      break;
    }
  }
}
/*
void task_cleanup(Task *task) {
  asm("CLI");
  
  free_stack((unsigned long) task->stack);
  task->flag = TASK_DEAD;
  
  asm("STI");
}
//*/

extern void __initTask(void *stack, void *start);
extern void __initTask2(volatile unsigned int *stack, void *start, volatile Task *newtask);
extern void __saveStack();

void spawn_task(int argc, char **argv, int (*main)(int argc, char **argv)) {
  asm("cli");

  volatile Task *task = NULL;
  volatile unsigned int *stack;
  int i;
  
  for (i=0; i<MAX_TASKS; i++) {
    if (tasks[i].flag == TASK_DEAD) {
      task = tasks + i;
      break;
    }
  }
  
  if (!task) {
    kerror(0, "hit maximum task limit");
    asm("sti");
    return;
  }
  
  if (i+1 > k_totaltasks) {
    k_totaltasks = i+1;
  }
  
  task->prev = (Task*) k_curtaskp;
  task->next = k_curtaskp->next;
  
  k_curtaskp->next->prev = task;
  k_curtaskp->next = task;

  k_lasttaskp = k_curtaskp;

  unsigned int addr = alloc_stack();
  
  task->flag = TASK_ALIVE;
  task->stack = (void*)addr;
  task->entry = (void*)main;
  task->tid = k_tidbase++;
  task->sleep = task_switch_granularity;
  
  stack = (unsigned int*) task->stack;

  *stack-- = (unsigned int) argv;
  *stack-- = (unsigned int) argc;
  
  task->head = stack;

  //switch to task.  will re-enable interrupts
  __initTask2(stack, main, task);
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
