#include "kmalloc.h"
#include "../io.h"
#include "string.h"
#include "libk.h"
#include "list.h"
#include "../task/task.h"
#include "../task/lock.h"
#include "../drivers/tty/tty.h"

#define MEM_BITMAP_START ((uintptr_t)MEM_STACK_END+1024*32)
#define MEM_BITMAP_END   ((uintptr_t)MEM_STACK_END+1024*1024*4)
#define MEM_BITMAP_SIZE (MEM_BITMAP_END - MEM_BITMAP_START)

#define MEM_BITMAP_SET(blockid)
#define MEM_BITMAP_UNSET(blockid)
#define MEM_BITMAP_TEST(blockid)

#define ADDR_TO_BLOCKIDX(addr)
#define BLOCKIDX_TO_ADDR(addr)

#define MEM_BASE (MEM_BITMAP_END+1024*32)
#define MEM_END (MEM_BITMAP_END+1024*1024*400)
#define MEM_SIZE (MEM_END-MEM_BASE)

#define MAGIC_HEAD_CHECKSUM 45436334
#define MAGIC_TAIL_CHECKSUM 25463450

#define MEM_FREED (-5)

Lock kmalloc_lock;

typedef struct MemNode {
  struct MemNode *next, *prev;
  
  size_t size, checksum;
  char *file;
  int line;
  int pid; //MEM_FREED is put here
  struct MemNode *pair;
} MemNode;

static List freelist, alloclist;

//e.g. memory-mappped device data, acpi, etc
typedef struct MemHole {
  unsigned int base;
  unsigned int length;
  const unsigned char *name;
} MemHole;

static MemHole holes[32];
static int tothole = 0;

void kmalloc_add_hole(unsigned int base, unsigned int len, const unsigned char *name) {
  MemHole *hole = holes + tothole++;
  
  hole->base = base;
  hole->length = len;
  hole->name = name;
}

void kmalloc_init_with_holes() {
  //smemset((short*)MEM_BITMAP_START, 0, MEM_BITMAP_SIZE/2+32);
  
  klock_init(&kmalloc_lock);
  
  memset(&freelist, 0, sizeof(freelist));
  memset(&alloclist, 0, sizeof(alloclist));
  
  //the motherblock!
  //we're assuming it's not within a memory mapped hole. . .
  
  unsigned char *base = (unsigned char*)MEM_BASE;
  MemHole *hole = holes;
  
  int i = 0;
  for (i=0; i<tothole; i++, hole++) {
    if (hole->base >= MEM_BASE) {
      break;
    }
  }
  
  //add closing hole at end of memory
  holes[tothole++].base = MEM_END;
  holes[tothole].length = 0;
  
  for (; i<tothole; i++, hole++) {
    MemNode *head = (MemNode*)base;
    size_t len = hole[i].base - ((unsigned int)base) - 256; //add some protection from buffer overruns
    
    if (len < sizeof(MemNode)*2+4) {
      base = (unsigned char*)(hole[i].base + hole[i].length);
      continue;
    }
    
    head->file = NULL; 
    head->pair = NULL;
    head->line = head->pid = 0;
    
    head->size = len - sizeof(MemNode)*2;
    
    MemNode *tail = (MemNode*)( ((unsigned char*)head) + sizeof(MemNode) + len );
    *tail = *head;
    
    head->pair = tail;
    tail->pair = head;
    head->pid = tail->pid = 0;
    head->checksum = MAGIC_HEAD_CHECKSUM;
    tail->checksum = MAGIC_TAIL_CHECKSUM;
    
    klist_append(&freelist, head);
  }
}

void kmalloc_init() {
  //smemset((short*)MEM_BITMAP_START, 0, MEM_BITMAP_SIZE/2+32);
  
  klock_init(&kmalloc_lock);
  
  memset(&freelist, 0, sizeof(freelist));
  memset(&alloclist, 0, sizeof(alloclist));
  
  //the motherblock!
  MemNode *head = (MemNode*)MEM_BASE;
  
  head->file = NULL; 
  head->pair = NULL;
  head->line = head->pid = 0;
  
  head->size = MEM_SIZE - sizeof(MemNode)*2 - 32;
  
  MemNode *tail = (MemNode*)(MEM_END - sizeof(MemNode) - 32);
  *tail = *head;
  
  head->pair = tail;
  tail->pair = head;
  head->pid = tail->pid = 0;
  head->checksum = MAGIC_HEAD_CHECKSUM;
  tail->checksum = MAGIC_TAIL_CHECKSUM;
  
  freelist.first = freelist.last = head;
}

void *_kmalloc(size_t size, char *file, int line) {
  MemNode *mem;
  
  klock_lock(&kmalloc_lock);
  
  //pad to eight bytes
  size_t size2 = size + sizeof(MemNode)*2;
  size2 += (8 - (size2 & 7));
  
  for (mem = freelist.first; mem->next; mem = mem->next) {
    if (mem->size >= size2) {
      break;
    }
  }
  
  if (!mem) {
    klock_unlock(&kmalloc_lock);
    return NULL; //ran out of memory! eek!!!
  }
  
  klist_remove(&freelist, mem);
  klist_prepend(&alloclist, mem);
  
  //do we not need to split?
  if (mem->size == size2) {
    mem->file = file;
    mem->line = line;
    mem->checksum = MAGIC_HEAD_CHECKSUM;
    mem->pair->checksum = MAGIC_TAIL_CHECKSUM;
    
    mem->pid = k_curtaskp->tid;
    
    klock_unlock(&kmalloc_lock);
    return ++mem;
  }
  
  MemNode *tail2 = mem->pair;
  
  //create new tail/head in middle of segment
  unsigned char *c = (unsigned char*) (mem + 1);
  MemNode *tail = (MemNode*) (c + size2 - sizeof(MemNode));
  MemNode *head2 = tail + 1;
  
  //size_t size3 = (sizeof(MemNode)*2 + mem->size);
  
  *tail = *mem;
  *head2 = *tail;
  
  head2->next = head2->prev = tail->next = tail->prev = NULL;
  
  tail->size = size2;
  tail->pair = mem;
  
  head2->size = ((unsigned char*)mem->pair) - (unsigned char*)(head2 + 1);
  mem->pair->size = size;
  head2->pair = mem->pair;
  mem->pair->pair = head2;
  
  mem->file = tail->file = file;
  mem->line = tail->line = line;
  mem->pid = tail->pid = k_curtaskp->tid;
  
  //link in new head to free list
  klist_prepend(&freelist, head2);
  
  mem->pair = tail;
  
  mem->checksum = head2->checksum = MAGIC_HEAD_CHECKSUM;
  tail->checksum = tail2->checksum =  MAGIC_TAIL_CHECKSUM;
  
  klock_unlock(&kmalloc_lock);
  return ++mem;
}

int _ktestmem(void *vmem) {
  if (!vmem) 
    return 0;
  
  unsigned int cmem = (unsigned int) vmem;
  
  if (cmem < MEM_BASE || cmem > MEM_END) {
    return 0;
  }
  
  MemNode *mem = vmem;
  mem--;
  
  if (mem->checksum != MAGIC_HEAD_CHECKSUM && mem->checksum != MAGIC_TAIL_CHECKSUM)
    return 0;
  
  return 1;
}

static int merge_blocks(MemNode *mem, int depth) {
  return 0; //XXX
  
  mem--;
  
  MemNode *tail = mem->pair;
  MemNode *head2 = tail + 1;
  
  //XXX update linked lists
  mem->pid = tail->pid = MEM_FREED;
  
  if (head2->pid == MEM_FREED) {
    //XXX remove from linked list
    klist_remove(&freelist, head2);
    
    size_t size = ((unsigned int)head2->pair) - ((unsigned int)mem) + sizeof(MemNode);
    size_t appsize = size - sizeof(MemNode)*2;
    
    MemNode *tail2 = head2->pair;
    
    mem->size = tail2->size = appsize;
    
    mem->pair = tail2;
    tail2->pair = mem;
    
    return merge_blocks(mem, depth+1) + 1;
  }
  
  return 1;
}

int _kfree(void *vmem, char *file, int line) {
  if (!vmem) 
    return 1;
  
  klock_lock(&kmalloc_lock);
  
  if (!_ktestmem(vmem)) {
    klock_unlock(&kmalloc_lock);
    return 1;
  }
  
  MemNode *mem = vmem;
  mem--;
  
  MemNode *tail = mem->pair;
  //MemNode *head2 = tail + 1;
  
  //XXX update linked lists
  ;
  
  klist_remove(&alloclist, mem);
  klist_append(&freelist, mem);
  
  mem->pid = tail->pid = MEM_FREED;
  merge_blocks(mem, 0);

  klock_unlock(&kmalloc_lock);
  
  return 1;
}

int _kprintblocks(char *file, int line) {
  MemNode *node;
  
  klock_lock(&kmalloc_lock);
  
  kprintf("===Allocated blocks===\n");
  
  for (node = alloclist.first; node; node=node->next) {
    if (!_ktestmem(node+1)) {
      //print bad blocks later
      break;
    }
    kprintf("Block %x:\n", node);
    kprintf("\tsize: %d, checksum: %d, pair: %x\n", node->size, node->checksum, node->pair);
    terminal_flush();
  }
  
  kprintf("\n");
  terminal_flush();
  
  kprintf("==== Bad blocks ===\n");
  for (node = alloclist.first; node; node=node->next) {
    if (!_ktestmem(node+1)) {
      kprintf("Bad memory block at %x:\n", node);
      kprintf("\tsize: %d, hchecksum: %d, tchecksum: %d, pair: %x\n", node->size, node->checksum, node->pair->checksum, node->pair);
      terminal_flush();
    }
  }
  
  terminal_flush();
  
  klock_unlock(&kmalloc_lock);
  
  return 0;
}

int test_kmalloc() {
  kprintf("KMalloc test!\n");
  
  kprintf("freelist.first1: %x\n", freelist.first);
  
  char *a = kmalloc(8);
  strcpy(a, "test123");
  
  kprintf("freelist.first2: %x\n", freelist.first);
  
  char *b = kmalloc(8);
  strcpy(b, "7654321");
  
  kprintf("freelist.first3: %x\n", freelist.first);
  
  kprintf("a: %s\n", a);
  kprintf("b: %s\n", b);
  
  kprintf("freelist.first4: %x\n", freelist.first);
  
  kprintblocks();
  
  kfree(a);
  kfree(b);
  
  kprintf("freelist.first5: %x\n", freelist.first);
  
  kprintblocks();
  
  kprintf("done\n");
  
  return 0;
}
