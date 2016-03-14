#include <stddef.h>
#include <stdint.h>

#include "io.h"
#include "task/task.h"
#include "task/lock.h"
#include "interrupts.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "libc/stdio.h"

typedef struct Sym {
  uint32_t addr; 
  char name[45];
} Sym;

void stacktrace() {
#if 1
  extern Sym _kernel_symbols[];
  extern unsigned int _kernel_symbols_count;
  
  unsigned int esp = read_esp(), ebp = read_ebp();
  unsigned int *stack = (unsigned int*)esp;
  unsigned int addr = get_eip(), lastaddr=0;
  Sym *lastsym = NULL;
  
  if (esp & 3) {
    esp = 4 - (esp & 3);
  }
  if (ebp & 3) {
    ebp = 4 - (ebp & 3);
  }
  
  stack = (unsigned int*)(esp);
  kprintf("addr: %x\n", addr);
  
  kprintf("stack: %x %x %x  %x %x %x\n", stack[0], stack[1], stack[2], stack[3], stack[4], stack[5]);
  kprintf("       %x %x %x  %x %x %x\n", stack[6], stack[7], stack[8], stack[9], stack[10], stack[11]);
  
  unsigned int ebp2 = read_ebp();
  kprintf("esp: %x, ebp: %x, cur ebp: %x\n", esp, ebp, ebp2);
  
  int len = _kernel_symbols_count;
  
  for (int i=0; i<len; i++) {
    Sym *sym = _kernel_symbols + i;
    
    //kprintf("%x:%s\n", sym->addr, sym->name);
    if (sym->addr <= addr && sym->addr > lastaddr) {
      lastaddr = sym->addr;
      lastsym = sym;
    }
  }
  
  if (lastsym != NULL) {
    kprintf("at: %x:%s\n", lastaddr, lastsym->name);
    kprintf("    %x\n", stacktrace);
  }
  
  kprintf("eip: %x\n", addr);
#endif
}
