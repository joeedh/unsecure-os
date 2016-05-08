#ifndef _KTASK_H
#define _KTASK_H

#include "stddef.h"
#include "stdint.h"

#include "../timer.h"
#include "signal.h"

//SIZEOF task structure (ensure to update
//assembler too: 32 (for 32-bit mode)

typedef struct CPUState {
  uintptr_t eflags; //0
  uintptr_t edi;    //1
  uintptr_t esi;    //2
  uintptr_t ebp;    //3
  void *esp;        //4
  uintptr_t ebx;    //5
  uintptr_t edx;    //6
  uintptr_t ecx;    //7
  uintptr_t eax;    //8
  void *eip;        //9
} CPUState;

typedef struct SignalInfo {
  uintptr_t mask;
  void *handlers[TOTSIGNAL];
} SignalInfo;

typedef volatile struct Task {
  volatile void *head;  //0 top of stack
  
  volatile struct Task *next; //4
  volatile struct Task *prev; //8
  
  int scratch; //12 used in assembly code
  int argc;    //16
  char **argv; //20
  
  volatile void *stack; //24 starting top of stack
  volatile void *entry; //28 entry point
  
  volatile int tid; //32
  intptr_t pid;
  volatile unsigned int flag; //36
  
  volatile int sleep; //40 sleep ticks left
  
  void (*finishcb)(int retval, int tid, int pid); //44
  volatile struct Process * volatile proc; //48
  
  CPUState exc_cpustate; //56
  SignalInfo *signals; //can be NULL
  int pad;
} Task;

extern volatile Task volatile * volatile k_curtaskp;

enum { //note: this is a bitfield
  TASK_DEAD  = 0,
  TASK_ALIVE = 1,
  TASK_SCHEDULED = 2,
  TASK_SUSPENDED = 4
};

void tasks_initialize();

Task *cur_task();
void next_task();

struct Process;

//implemented in core_x86.nasm
void task_yield();

//schedules a thread interrupt
//int task_interrupt(int tid, void (*func)(void));

void task_suspend(int tid);
void task_unsuspend(int tid);
int task_signal(int tid, int signal);
int task_set_signals(int tid, SignalInfo *signals);

Task *task_from_tid(int tid);
void task_destroy(int tid, int retval, int wait_if_inside);
int spawn_task(int argc, char **argv, int (*main)(int argc, char **argv),
                void (*finishcb)(int retval, int tid, int pid), struct Process *proc);

//if all tasks are sleeping, switches to first one (idle task)
volatile Task *get_next_task();

//version of get_next_task that decrements ->sleep as it goes along
volatile Task *get_next_task_timer(); 

extern volatile unsigned int kernel_tick;

//inside_XXX are defined in interrupts.h
#define CAN_YIELD (!inside_exc && !inside_irq)

#endif /* _KTASK_H */
