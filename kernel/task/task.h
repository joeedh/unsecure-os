#ifndef _KTASK_H
#define _KTASK_H

#include "stddef.h"
#include "stdint.h"

#include "../timer.h"

//SIZEOF task structure (ensure to update
//assembler too: 32 (for 32-bit mode)

typedef volatile struct Task {
  volatile void *head;  //0 top of stack
  
  volatile struct Task *next; //4
  volatile struct Task *prev; //8
  
  int scratch; //12 used in assembly code
  int argc; //16
  char **argv; //20
  
  volatile void *stack; //24 starting top of stack
  volatile void *entry; //28 entry point
  
  volatile int tid; //32
  intptr_t pid;
  volatile unsigned int flag; //36
  
  volatile int sleep; //40 sleep ticks left
  
  void (*finishcb)(int retval, int tid, int pid); //44
  volatile struct Process * volatile proc;
} Task;

extern volatile Task volatile * volatile k_curtaskp;

enum { //note: this is a bitfield
  TASK_DEAD  = 0,
  TASK_ALIVE = 1,
  TASK_SCHEDULED = 2
};

void tasks_initialize();

Task *cur_task();
void next_task();

struct Process;

//implemented in core_x86.nasm
void task_yield();

//schedules a thread interrupt
int thread_interrupt(int tid, void (*func)(void));

//Task *task_get(int tid);
void task_destroy(int tid, int retval, int wait_if_inside);
int spawn_task(int argc, char **argv, int (*main)(int argc, char **argv),
                void (*finishcb)(int retval, int tid, int pid), struct Process *proc);

//if all tasks are sleeping, switches to first one (idle task)
volatile Task *get_next_task();

//version of get_next_task that decrements ->sleep as it goes along
volatile Task *get_next_task_timer(); 

extern volatile unsigned int kernel_tick;

//static inline void task_sleep(unsigned int ms) {
//}

#endif /* _KTASK_H */
