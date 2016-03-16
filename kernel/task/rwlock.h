#ifndef _K_RWLOCK_H
#define _K_RWLOCK_H

#include "Lock.h"
typedef volatile struct RWLock {
  int counter, pad;
  Lock b, g;
} RWLock;

#define RWLOCK_INIT {0,}

static inline void krwlock_init(RWLock *rw) {
  memset(rw, 0, sizeof(*rw));
  
  rw->counter = 0;
  
  klock_init(&rw->b);
  klock_init(&rw->g);
}

static inline void krwlock_rlock(RWLock *rw) {
  klock_lock(&rw->b);
  
  rw->counter++;
  
  if (rw->counter == 1) {
    klock_lock(&rw->g);
  }
  
  klock_unlock(&rw->b);
}

static inline void krwlock_unrlock(RWLock *rw) {
  klock_lock(&rw->b);
  
  rw->counter--;
  
  if (rw->counter == 0) {
    klock_unlock(&rw->g);
  }
  
  klock_unlock(&rw->b);
}


static inline void krwlock_lock(RWLock *rw) {
  klock_lock(&rw->g);
}

static inline void krwlock_unlock(RWLock *rw) {
  klock_unlock(&rw->g);
}

#endif /* _K_RWLOCK_H */

