#ifndef _KMEMORY_H
#define _KMEMORY_H

#define ALIGN8(a) (((a) & 7) ? ((a) + 8 - ((a) & 7)) : (a))
#ifndef MIN2
#define MIN2(a, b) ((a) < (b) ? (a) : (b))
#endif

#include "task_def.h"

#define MEM_STACK_INDV_SIZE ALIGN8(1024*512)
#define MEM_STACK_BASE ALIGN8(1024*1024*12 + MEM_STACK_INDV_SIZE)
#define MEM_STACK_END ALIGN8(MEM_STACK_BASE + MEM_STACK_INDV_SIZE*MAX_TASKS)

#define MEM_STACK_SIZE (MEM_STACK_END - MEM_STACK_BASE)

#define MEM_BITMAP_START ALIGN8((uintptr_t)MEM_STACK_END+1024*32)
#define MEM_BITMAP_END   ALIGN8((uintptr_t)MEM_STACK_END+1024*1024*4)
#define MEM_BITMAP_SIZE (MEM_BITMAP_END - MEM_BITMAP_START)

#define MEM_BITMAP_SET(blockid)
#define MEM_BITMAP_UNSET(blockid)
#define MEM_BITMAP_TEST(blockid)

#define ADDR_TO_BLOCKIDX(addr)
#define BLOCKIDX_TO_ADDR(addr)

#define MEM_BASE ALIGN8(MEM_BITMAP_END+1024*32)
#define MEM_END ALIGN8(MEM_BITMAP_END+1024*1024*400)
#define MEM_SIZE (MEM_END-MEM_BASE)

#endif /* _KMEMORY_H */
