#include <stddef.h>
#include <stdint.h>

#include "io.h"
#include "task/task.h"
#include "task/lock.h"
#include "interrupts.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "libc/stdio.h"

#include "drivers/tty/tty.h"
#include "definitions/memory.h"

typedef struct Sym {
  uint32_t addr; 
  char name[45];
} Sym;

Sym unknown_sym = {
  0x0,
  "(unknown)"
};

extern Sym _kernel_symbols[];
extern unsigned int _kernel_symbols_count;


const Sym *find_symbol(uint32_t addr) {
  int len = _kernel_symbols_count;
  Sym *lastsym = NULL;
  uintptr_t lastaddr = 0;
  
  for (int i=0; i<len; i++) {
    Sym *sym = _kernel_symbols + i;
    
    //kprintf("%x:%s\n", sym->addr, sym->name);
    if (sym->addr <= addr && sym->addr > lastaddr) {
      lastaddr = sym->addr;
      lastsym = sym;
    }
  }
  
  return lastsym ? lastsym : &unknown_sym;
}

void stacktrace() {
#if 1
  
  unsigned int esp = read_esp(), ebp = read_ebp();
  unsigned int *stack = (unsigned int*)esp;
  unsigned int addr = get_eip();
  
  if (ebp == 0 || ebp < 700*1024) {
    kprintf("(ebp: %x): Missing frame pointer information (try compiling with debug info enabled, -g)\n", ebp);
    return;
  }
  
  if (esp & 3) {
    esp = 4 - (esp & 3);
  }
  if (ebp & 3) {
    ebp = 4 - (ebp & 3);
  }
  
  stack = (unsigned int*)(esp);
  //kprintf("addr: %x\n", addr);
  
  kprintf("stack: %x %x %x  %x %x %x\n", stack[0], stack[1], stack[2], stack[3], stack[4], stack[5]);
  //kprintf("       %x %x %x  %x %x %x\n", stack[6], stack[7], stack[8], stack[9], stack[10], stack[11]);
  
  unsigned int ebp2 = read_ebp();
  kprintf("esp: %x, ebp: %x, cur ebp: %x\n", esp, ebp, ebp2);
  
  const Sym *head = find_symbol(addr);
  kprintf("\n%s:    %x\n", head->name, head->addr);
  
  addr = ebp = read_ebp();
  stack = (unsigned int*)addr;
  
  for (int i=0; i<6; i++) {
    //kprintf("-=-=-=%x %x %x %x %x %x-=-=-=\n", *(stack), *(stack+1), *(stack+2), *(stack+3), *(stack+4));
    uint32_t retptr = *(stack+1);
    unsigned int *nextstack = (unsigned int*)(*stack);
    
    if (retptr < 1024) { //far call?
      kprintf("    far call detected! %x\n", retptr);
      retptr = *(stack + 2); //ignore segment info, for now
    }
    
    const Sym *sym = find_symbol(retptr);
    kprintf("  %^%s%^:    %x %x%^\n", COLOR_CYAN, sym->name, COLOR_WHITE, retptr, sym->addr, COLOR_DEFAULT);
    
    stack = nextstack;
    if ((unsigned int)stack < 700*1024 || (unsigned int)stack > MEM_END) {
      break; //bad location
    }
  }
  
  //kprintf("eip: %x\n", addr);
#endif
}
