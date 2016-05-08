#ifndef _EXCEPTION_H
#define _EXCEPTION_H

#include <stddef.h>
#include <stdint.h>
#include "libc/list.h"

#define TOTEXCEPTION  32

/*
NOTE: exception handlers are allowed to change program flow, i.e. jump out of the dispatcher (_on_exception).

Also, exceptions handlers are invoked *after* the underlying ISR handler returns with iret.
*/

struct CPUState;

//returns 1 if exception handled, 0 otherwise
typedef int (*ExceptionHandler)(int code, int codedata, struct CPUState *cpudata);

int exception_push_handler(int code, ExceptionHandler handler);
int exception_pop_handler(int code, ExceptionHandler handler);
void exception_init_stacks();
void exception_handlers_init();

extern List exception_stacks[TOTEXCEPTION];

//for use within exception handlers.
extern void _exception_resume(void *eip, void *esp);


#endif /* _EXCEPTION_H */
