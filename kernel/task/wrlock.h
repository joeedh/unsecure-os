#ifndef _LOCK_H
#if 0
  #include "critical_section.h"
  #define Lock CriticalSection

  #define klock_init ksection_init
  #define klock_lock ksection_lock
  #define klock_unlock ksection_unlock

#else
  
#define _LOCK_H

#include "../debug.h"
#include "../libc/string.h"
#include "../io.h"
#include "../interrupts.h"
#include "task.h"
#include "../libc/libk.h"

#ifdef DEBUGSKIP
#undef DEBUGSKIP
#endif

#ifdef DEBUG_ARGS
#undef DEBUG_ARGS
#endif

#define LOCK_DEBUG
#ifdef LOCK_DEBUG
  extern volatile unsigned int enable_klock_debug;
  #define enable_klock_debug 1
#endif

typedef volatile struct Lock {
  volatile int state;
  volatile unsigned int owner;
  volatile short access, pad;
#ifdef LOCK_DEBUG
  const char *file;
  int line;
#endif
} Lock;

#ifdef LOCK_DEBUG
  volatile int disable_all_locks;
  #define DEBUGSKIP if (disable_all_locks) return;
  
  #define DEBUG_ARGS , const char *file, int line
  #define klock_init(lock) _klock_init(lock, __FILE__, __LINE__)
  #define klock_lock(lock) _klock_lock(lock, __FILE__, __LINE__)
  #define klock_rlock(lock) _klock_rlock(lock, __FILE__, __LINE__)
  #define klock_unlock(lock) _klock_unlock(lock, __FILE__, __LINE__)
  #define klock_clearlock(lock) _klock_clearlock(lock, __FILE__, __LINE__)
  #define LOCKDEBUG(name) if (lock->state) {\
      {unsigned int _state = safe_entry();\
      disable_all_locks = 1;\
      if (enable_klock_debug && !inside_irq) {\
        e9printf("%d: klock(" #name "): %s:%d\n", lock->state, _get_filename(file), line);\
      }\
      disable_all_locks = 0; safe_exit(_state);}};
#else
  #define DEBUGSKIP
  #define DEBUG_ARGS
  #define klock_init _klock_init
  #define klock_lock _klock_lock
  #define klock_rlock _klock_rlock
  #define klock_unlock _klock_unlock
  #define klock_clearlock _klock_clearlock
  #define LOCKDEBUG(name)
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
#define LOCK_INIT {0,}
static inline void _klock_init(Lock *lock DEBUG_ARGS) {
}
static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
}
static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
}

#elif LOCKMETHOD == IRQLOCK
#define LOCK_INIT {0,}

static inline void _klock_init(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  lock->state = lock->owner = 0;
  
  LOCKDEBUG(klock_init);
}

//interrupt version
static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  #ifdef LOCK_DEBUG
    lock->file = file;
    lock->line = line;
  #endif
  
  if (lock->state == 0) {
    lock->owner = safe_entry();
  }
  
  LOCKDEBUG(lock);

  lock->state++;
}

static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  if (lock->owner != 0 && --lock->state <= 0) {
    lock->owner = 0;
    lock->state = 0;
    safe_exit(lock->owner);
  }
  
  LOCKDEBUG(unlock);
}

static inline void _klock_clearlock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  if (lock->owner != 0) {
    lock->owner = 0;
    lock->state = 0;
    safe_exit(lock->owner);
  }
  
  LOCKDEBUG(unlock);
}

#elif LOCKMETHOD == SPINLOCK
#define LOCK_INIT {0,}

static inline void _klock_init(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  lock->state = lock->owner = 0;
  
  LOCKDEBUG(init);
}

static inline void _klock_lock_(Lock *lock DEBUG_ARGS, int mode);
#define LOCKR  1
#define LOCKW  2

static inline void _klock_lock(Lock *lock DEBUG_ARGS) {
  _klock_lock_(lock DEBUG_ARGS, LOCKR|LOCKW);
}


static inline void _klock_rlock(Lock *lock DEBUG_ARGS) {
  _klock_lock_(lock DEBUG_ARGS, LOCKR);
}

//spinlock version
static inline void _klock_lock_(Lock *lock DEBUG_ARGS, int mode) {
  DEBUGSKIP
  
  volatile unsigned int tid = k_curtaskp->tid;
  
  #ifdef LOCK_DEBUG
  unsigned int state1 = safe_entry();
  
  if (lock->state && !(mode === LOCKR && lock->access == LOCKR)) {
    stacktrace(0, e9printf);
  }
  
  safe_exit(state1);
  #endif
  
  LOCKDEBUG(lock);
  
  if (lock->owner == tid) {
    #ifdef LOCK_DEBUG
      lock->file = file;
      lock->line = line;
    #endif

    lock->state++;
    return;
  }

restart:
  do {
    //k_curtaskp->sleep = 1;
    //asm("PAUSE");
  } while (lock->owner != 0 && !(mode === LOCKR && lock->access == LOCKR));
  
  volatile unsigned int state = safe_entry();
  
  if (lock->owner != 0 && !(mode === LOCKR && lock->access == LOCKR)) {
    safe_exit(state);
    goto restart;
  }
  
  if (mode === LOCKR && lock->access == LOCKR) { //rlock mode
    lock->pad++;
    if (!lock->owner) {
      lock->owner = tid;
    }
    
    lock->access |= LOCKR;
  } else {
    lock->owner = tid;
    lock->state = 1;
    lock->pad++;
  }
  
  #ifdef LOCK_DEBUG
    lock->file = file;
    lock->line = line;
  #endif
  
  safe_exit(state);
}

static inline void _klock_unlock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  volatile unsigned int tid = k_curtaskp->tid;
  
  if (lock->owner != tid) {
    return; //hrm, bad unlock call
  }
  
  if (!--lock->state) {
    volatile unsigned int state = safe_entry();
    lock->owner = lock->state = 0;
    safe_exit(state);
  }
  
  LOCKDEBUG(unlock);
}

static inline void _klock_unrlock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  volatile unsigned int tid = k_curtaskp->tid;
  volatile unsigned int state = safe_entry();
  
  lock->pad--;
  if (lock->pad == 0) {
    lock->flag &= ~LOCKR;
  }
  safe_exit();
  
  if (lock->owner != tid) {
    return; //hrm, bad unlock call
  }
  
  if (!--lock->state) {
    volatile unsigned int state = safe_entry();
    lock->owner = lock->state = 0;
    safe_exit(state);
  }
  
  LOCKDEBUG(unlock);
}

static inline void _klock_clearlock(Lock *lock DEBUG_ARGS) {
  DEBUGSKIP
  
  volatile unsigned int tid = k_curtaskp->tid;
  
  if (lock->owner != tid) {
    return; //we don't own the lock
  }
  
  volatile unsigned int state = safe_entry();
  lock->state = lock->owner = lock->pad = lock->access = 0;
  safe_exit(state);
  
  LOCKDEBUG(unlock);
}

#undef LOCKR
#undef LOCKW

#endif

#ifdef DEBUGSKIP
#undef DEBUGSKIP
#endif

#ifdef enable_klock_debug
#undef enable_klock_debug
#endif

#endif

#ifdef DEBUG_ARGS
#undef DEBUG_ARGS
#endif

#endif /* _LOCK_H */
