#ifndef _LOCK_H

#include "critical_section.h"
#define Lock CriticalSection

#define klock_init ksection_init
#define klock_lock ksection_lock
#define klock_unlock ksection_unlock

#if 0
#define _LOCK_H

#include "../libc/string.h"
#include "../io.h"
#include "../interrupts.h"
#include "task.h"
#include "../libc/libk.h"

//#define LOCK_DEBUG
#ifdef LOCK_DEBUG
  extern volatile unsigned int enable_klock_debug;
  //#define enable_klock_debug 0
#endif

typedef volatile struct Lock {
  volatile int state;
  volatile unsigned int owner;
#ifdef LOCK_DEBUG
  const char *file;
  int line;
#endif
} Lock;

#ifdef LOCK_DEBUG
  #define DEBUG_ARGS , const char *file, int line) {
  #define klock_init(lock) _klock_init(lock, __FILE__, __LINE__)
  #define klock_lock(lock) _klock_lock(lock, __FILE__, __LINE__)
  #define klock_unlock(lock) _klock_unlock(lock, __FILE__, __LINE__)
#else
  #define DEBUG_ARGS
  #define klock_init _klock_init
  #define klock_lock _klock_lock
  #define klock_unlock _klock_unlock
#endif

#define SPINLOCK 0
#define IRQLOCK  1
#define NOTHING  2

#define LOCKMETHOD SPINLOCK

static const char *_get_filename(const char *file) {
  char *ret = strrchr(file, '/');
  return !ret || !ret[1] ? file : ret+1;
}

#if LOCKMETHOD == NOTHING
static inline void _klock_init(Lock *lock DEBUG_ARGS) {
}
static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
}
static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
}

#elif LOCKMETHOD == IRQLOCK
static inline void _klock_init(Lock *lock DEBUG_ARGS) {
  lock->state = lock->owner = 0;
  
#ifdef LOCK_DEBUG
  lock->file = file;
  lock->line = line;
  
  if (enable_klock_debug && !inside_irq) {
    kprintf("klock(init): %s:%d\n", _get_filename(file), line);
  }
#endif
}

//interrupt version
static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
  #ifdef LOCK_DEBUG
    lock->file = file;
    lock->line = line;
  #endif
  
  if (lock->state == 0) {
    lock->owner = safe_entry();
  }
  
#ifdef LOCK_DEBUG
  if (enable_klock_debug && !inside_irq) {
    //for (int i=0; i<lock->state; i++) {
    //  kprintf("  ");
   // }
  }
  
  kprintf("klock(lock): %s:%d\n", _get_filename(file), line);
#endif

  lock->state++;
}

static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
  if (--lock->state <= 0) {
    if (lock->state == 0) {
      safe_exit(lock->owner);
    }
    
    lock->state = 0;
  }
  
#ifdef LOCK_DEBUG
  if (enable_klock_debug && !inside_irq) {
    //for (int i=0; i<lock->state; i++) {
    //  kprintf("-");
    //}
    
    kprintf("klock(unlock): %s:%d\n", _get_filename(file), line);
  }
#endif
}

#elif LOCKMETHOD == SPINLOCK
static inline void _klock_init(Lock *lock DEBUG_ARGS) {
  lock->state = lock->owner = 0;
  
  #ifdef LOCK_DEBUG
  if (enable_klock_debug && !inside_irq) {
    lock->file = file;
    lock->line = line;
    kprintf("klock(init): %s:%d\n", _get_filename(file), line);
  }
  #endif
}


//spinlock version
static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
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
  
  volatile unsigned int state = safe_entry();
  
  if (lock->owner != 0) {
    safe_exit(state);
    goto restart;
  }
  
  lock->owner = tid;
  lock->state = 1;
  
  safe_exit(state);
  
  #ifdef LOCK_DEBUG
  kprintf("klock(lock): %s:%d\n", _get_filename(file), line);
  #endif
}

static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
  volatile unsigned int tid = k_curtaskp->tid;
  
  if (lock->owner != tid) {
    return; //hrm, bad unlock call
  }
  
  if (!--lock->state) {
    volatile unsigned int state = safe_entry();
    lock->owner = 0;
    safe_exit(state);
  }
  
  #ifdef LOCK_DEBUG
  kprintf("klock(unlock): %s:%d\n", _get_filename(file), line);
  #endif
}
#endif

#ifdef enable_klock_debug
#undef enable_klock_debug
#endif

#endif

#endif /* _LOCK_H */
