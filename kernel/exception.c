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

List exception_stacks[TOTEXCEPTION];

//preallocate linknodes to hold exception handlers
LinkNode exception_stacknodes[8192];

//does nothing
int null_handler(int code, int codedata, CPUState *cpudata) {
  return 0;
}

static LinkNode *exc_alloc_node() {
  int totnodes = sizeof(exception_stacknodes) / sizeof(*exception_stacknodes);
  
  for (int i=0; i<totnodes; i++) {
    if (!exception_stacknodes[i].data) {
      exception_stacknodes[i].data = null_handler;
      return exception_stacknodes + i;
    }
  }
  
  kerror(-1, "OVERUN in pushing exxception handler!!\n");
  return NULL;
}

static void exc_free_node(LinkNode *node) {
  node->data = NULL;
}

int exception_push_handler(int code, ExceptionHandler handler) {
  LinkNode *node = exc_alloc_node();
  node->data = handler;
  
  if (code > (int)(sizeof(exception_stacks) / sizeof(*exception_stacks))) {
    e9printf("exception_add_handler: invalid code: %d\n", code);
    kerror(-1, "invalid code");
    return -1;
  }
  
  klist_prepend(exception_stacks+code, node);
  
  return 0;
}

int exception_pop_handler(int code, ExceptionHandler handler) {
  unsigned int state = safe_entry();
  
  if (code > (int)(sizeof(exception_stacks) / sizeof(*exception_stacks))) {
    e9printf("exception_add_handler: invalid code: %d\n", code);
    
    kerror(-1, "invalid code");
    
    safe_exit(state);
    return -1;
  }
  
  for (LinkNode *node=exception_stacks[code].first; node; node=node->next) {
    if (node->data == handler) {
      klist_remove(exception_stacks+code, node);
      exc_free_node(node);
      
      safe_exit(state);
      return 0; //success
    }
  }
  
  e9printf("failed to find handler %x for %d\n", handler, code);
  
  safe_exit(state);
  return -1; //couldn't find handler
}

void exception_init_stacks() {
  memset(exception_stacks, 0, sizeof(exception_stacks));
  memset(exception_stacknodes, 0, sizeof(exception_stacknodes));
}

//exception dispatcher
void _on_exception(int code, int codedata, CPUState *cpudata) {
  e9printf("_on_exception called.  code: %d, codedata: %d, cpudata: %p\n", code, codedata, cpudata);
  e9printf("  eax: %x, ebx: %x, edx: %x\n", read_eax(), read_ebx(), read_edx());
  e9printf("  ebp: %x, esp: %x, eip: %x\n\n", read_ebp(), read_esp(), get_eip());

  //sanitize code, just to be safe
  code = code & 31;
  
  int handled = 0;
  for (LinkNode *node=exception_stacks[code].first; node; node=node->next) {
    ExceptionHandler handler = node->data;
    
    if (handler(code, codedata, cpudata)) {
      handled = 1;
      break;
    }
  }
  
  if (!handled) {
    e9printf("Unhandled exception %d\n", code);
    kerror(-1, "Unhandled exception");
  }
}
