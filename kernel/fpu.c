#include "io.h"
#include "interrupts.h"
#include "libc/libk.h"
#include "libc/kmalloc.h"

extern void __initFPU();

void fpu_initialize() {
  //*
  __initFPU();
  
  int i = read_cr0();
  CR0 *cr0 = (CR0*) &i;
  
  //cr0->numeric_error = 1;
  //cr0->task_switched = 0;
  cr0->fpu_emulation = 0;
  //cr0->monitor_coprocessor = 1;
  
  int cr4 = read_cr4();
  cr4 |= (1<<9) | (1<<10) | (1<<18);
  
  //write_cr0(i);
  //write_cr4(cr4);
  //*/
}
