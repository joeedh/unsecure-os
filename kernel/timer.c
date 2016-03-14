#include "timer.h"
#include "io.h"
#include "task/task.h"

extern void set_PIT_count();
volatile unsigned int kernel_tick;

void timer_initialize() {
  kernel_tick = 0;
  set_PIT_count();
}
