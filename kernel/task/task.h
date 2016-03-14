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
  
  volatile unsigned int tid; //32
  intptr_t pid;
  volatile unsigned int flag; //36
  
  volatile int sleep; //40 sleep ticks left
  
  void (*finishcb)(int retval, int tid, int pid); //44
  volatile int pad;
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

void task_destroy(volatile Task *task, int retval, int wait_if_inside);
void task_switch(volatile void *stack);
int spawn_task(int argc, char **argv, int (*main)(int argc, char **argv),
                void (*finishcb)(int retval, int tid, int pid), intptr_t pid);

//if all tasks are sleeping, switches to first one (idle task)
volatile Task *get_next_task();

//version of get_next_task that decrements ->sleep as it goes along
volatile Task *get_next_task_timer(); 

extern volatile unsigned int kernel_tick;

static inline void task_sleep(unsigned int ms) {
  //asm("cli");
  //k_curtaskp->sleep = ms;
  //asm("sti");
  
  /*
  asm("cli");
  
  k_curtaskp->sleep = ms; //XXX detect if timer isn't in milisecond mode
  task_switch(get_next_task());
  
  //asm("int 0x0");
  
  asm("sti");
  //*/
}

static inline void task_sleep2(unsigned int ms) {
//  task_switch(k_curtaskp->next);
//}
#if 1
  //*
  volatile unsigned int start_tick = kernel_tick;
  volatile unsigned int tick = start_tick;
  
#if TICKS_PER_SECOND != 1000
  ms /= (1000/TICKS_PER_SECOND);
#endif
  
  do {
    tick = kernel_tick;
    
    task_switch(k_curtaskp->next);
  } while (tick - start_tick < ms);
  //*/
}
#endif

#endif /* _KTASK_H */
