#include "exception.h"
#include "interrupts.h"
#include "io.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "libc/stdlib.h"
#include "libc/stdio.h"
#include "libc/list.h"
#include "task/task.h"
#include "task/process.h"
#include "task/process_management.h"
#include "task/lock.h"
#include "task/rwlock.h"

static int default_exception_handler(int code, int codedata, CPUState *cpudata) {
  _exit(-1);
  return 1;
}

void exception_handlers_init() {
  for (int i=0; i<32; i++) {
    exception_push_handler(i, default_exception_handler);
  }
}
