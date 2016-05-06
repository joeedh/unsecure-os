#ifndef _KDEBUG_H
#define _KDEBUG_H

#include <stddef.h>
#include <stdint.h>

//if base is zero than current (roughly) value of eip register is used
void stacktrace(uintptr_t base, int (*printfcb)(char *fmt, ...));

#endif /* _KDEBUG_H */

