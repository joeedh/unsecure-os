//combined spinlock + irqlock
#ifndef _CRITICAL_SECTION_H
#define _CRITICAL_SECTION_H

#include "../libc/string.h"
#include "../io.h"
#include "../interrupts.h"
#include "task.h"
#include "../libc/libk.h"

typedef volatile struct CriticalSection {
  volatile int state, irqstate;
  volatile unsigned int owner, pad;
#ifdef CRITICAL_SECTION_DEBUG
  const char *file;
  int line;
#endif
} CriticalSection;

#ifdef CRITICAL_SECTION_DEBUG
  #define DEBUG_ARGS , const char *file, int line) {
  #define ksection_init(lock) _ksection_init(lock, __FILE__, __LINE__)
  #define ksection_lock(lock) _ksection_lock(lock, __FILE__, __LINE__)
  #define ksection_unlock(lock) _ksection_unlock(lock, __FILE__, __LINE__)
#else
  #define DEBUG_ARGS
  #define ksection_init _ksection_init
  #define ksection_lock _ksection_lock
  #define ksection_unlock _ksection_unlock
#endif


static inline void _ksection_init(CriticalSection *lock DEBUG_ARGS) {
  lock->state = lock->owner = lock->irqstate = 0;
}


//spinlock version
static inline void _ksection_lock(CriticalSection *lock DEBUG_ARGS) {
  volatile unsigned int tid = k_curtaskp->tid;
  
  if (lock->owner == tid) {
    lock->state++;
    return;
  }

restart:
  do {
    k_curtaskp->sleep = 1;
    //asm("PAUSE");
  } while (lock->owner != 0);
  
  //volatile unsigned int state = safe_entry();
  
  if (lock->owner != 0) {
    //safe_exit(state);
    goto restart;
  }
  
  //lock->irqstate = state;
  lock->owner = tid;
  lock->state = 1;
}

static inline void _ksection_unlock(CriticalSection *lock DEBUG_ARGS) {
  volatile unsigned int tid = k_curtaskp->tid;
  
  if (lock->owner != tid) {
    return; //hrm, bad unlock call
  }
  
  if (!--lock->state) {
    //volatile unsigned int state = lock->irqstate;
    
    //lock->irqstate = 0xffff;
    lock->owner = 0;
    //safe_exit(state);
  }
}
#endif /* _CRITICAL_SECTION_H */
