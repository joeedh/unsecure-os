#include "kmalloc.h"
#include "../io.h"
#include "string.h"
#include "libk.h"
#include "list.h"
#include "../task/task.h"
#include "../task/lock.h"
#include "../task/critical_section.h"
#include "../drivers/tty/tty.h"
#include "../definitions/memory.h"

#define MAGIC_HEAD_CHECKSUM 45436334
#define MAGIC_TAIL_CHECKSUM 25463450

#define MEM_FREED (-5)

//Lock kmalloc_lock
CriticalSection kmalloc_lock = {0,};

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
  
  ksection_init(&kmalloc_lock);
  
  memset(&freelist, 0, sizeof(freelist));
  memset(&alloclist, 0, sizeof(alloclist));
  
  //the motherblock!
  //we're assuming it's not within a memory mapped hole. . .
  
  uintptr_t base = MEM_BASE;
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
    base = ALIGN8(base);
    
    MemNode *head = (MemNode*)base;
    size_t len;
    
    if (hole[i].base < (unsigned int)base) {
      base = hole[i].base + hole[i].length + 32; //add some protection from buffer overruns
      continue;
    } else {
      base = hole[i].base - 32; //add some protection from buffer overruns
    }
    
    len = (base - (uintptr_t)head);
    
    if (len < sizeof(MemNode)*2+4) {
      base = hole[i].base + hole[i].length + 32; //add some protection from buffer overruns
      continue;
    }
    
    head->file = NULL; 
    head->pair = NULL;
    head->line = head->pid = 0;
    
    head->size = len - sizeof(MemNode)*2;
    
    MemNode *tail = (MemNode*)(((uintptr_t)(head+1)) + head->size);
    *tail = *head;
    
    if ((uintptr_t)tail > base) {
      kerror(-1, "kmalloc error!\n");
      while (1) {
      }
    }
    
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
  
  ksection_init(&kmalloc_lock);
  
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
  
  ksection_lock(&kmalloc_lock);
  
  //pad to eight bytes
  size_t size2 = size + sizeof(MemNode)*2;
  size2 += (8 - (size2 & 7));
  
  for (mem = freelist.first; mem->next; mem = mem->next) {
    if (mem->size >= size2) {
      break;
    }
  }
  
  if (!mem) {
    ksection_unlock(&kmalloc_lock);
    return NULL; //ran out of memory! eek!!!
  }
  
  klist_remove(&freelist, mem);
  klist_prepend(&alloclist, mem);
  
  mem->file = file;
  mem->line = line;
  mem->pid = k_curtaskp->tid;

    //do we not need to split?
  if (mem->size == size2) {
    mem->checksum = MAGIC_HEAD_CHECKSUM;
    mem->pair->checksum = MAGIC_TAIL_CHECKSUM;
    
    ksection_unlock(&kmalloc_lock);
    return ++mem;
  }
  
  size_t size3 = size2 - sizeof(MemNode)*2;
  
  uintptr_t base = (uintptr_t) mem;
  
  MemNode *head1 = mem;
  MemNode *tail1 = (MemNode*) (base + sizeof(MemNode) + size3);
  MemNode *head2 = (MemNode*) (base + sizeof(MemNode)*2 + size3);
  MemNode *tail2 = mem->pair;
  
  tail1->checksum = tail2->checksum = MAGIC_TAIL_CHECKSUM;
  head1->checksum = head2->checksum = MAGIC_HEAD_CHECKSUM;
  
  *tail1 = *head1;
  *head2 = *tail2;
  
  head1->pair = tail1;
  tail1->pair = head1;
  
  head2->pair = tail2;
  tail2->pair = head2;
  
  uintptr_t n = ((uintptr_t)tail2) - ((uintptr_t)head2);
  
  head1->size = tail1->size = size3;
  head2->size = tail2->size = n - sizeof(MemNode);
  
  klist_append(&freelist, head2);
  
  ksection_unlock(&kmalloc_lock);
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
  
  if (mem->pid == MEM_FREED)
    return 0;
  
  uintptr_t addr = ((uintptr_t)mem) + mem->size + sizeof(MemNode);
  
  if (addr != (uintptr_t)mem->pair) {
    klogf("HEAP ERROR: %x: Block tail error! %x should be %x\n", mem, mem->pair, addr);
    return 0;
  }
  
  uintptr_t base = (uintptr_t)vmem;
  
  if (base & 7) {
    klogf("eek, alignment error! %x\n", vmem);
    return 0;
  }
  
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
  
  ksection_lock(&kmalloc_lock);
  
  if (!_ktestmem(vmem)) {
    ksection_unlock(&kmalloc_lock);
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

  ksection_unlock(&kmalloc_lock);
  
  return 1;
}

void *_krealloc(void *memory, size_t newsize, char *file, int line) {
  if (!memory) {
    return _kmalloc(newsize, file, line);
  }
  
  //ksection_lock(&kmalloc_lock);
  int bad = _ktestmem(memory);
  
  if (bad) {
    //ksection_unlock(&kmalloc_lock);
    return NULL;
  }
  
  MemNode *node = memory;
  node--;
  
  int cpylen = node->size < newsize ? node->size : newsize;

  void *newmem = kmalloc(newsize);
  memcpy(newmem, memory, cpylen);
  _kfree(memory, file, line);

  //ksection_unlock(&kmalloc_lock);
  return newmem;
}

static void _kprintf_block(MemNode *node, int indent) {
  unsigned char buf[64];
  
  int len = node->file ? strnlen(node->file, 64) : 0;
  memcpy(buf, node->file, len);
  buf[len] = 0;
  
  for (int i=0; i<indent; i++)
    kprintf("\t");
  kprintf("Memory Block at \n");
  
  for (int i=0; i<indent; i++)
    kprintf("\t");
  kprintf("\tsize: %d, hchecksum: %d, tchecksum: %d, pair: %x\n", node->size, node->checksum,
          node->pair->checksum, node->pair);
          
  for (int i=0; i<indent; i++)
    kprintf("\t");
  kprintf("\t%s:%d\n", buf, node->line);
  
  terminal_flush();
}

int _kprintblocks(char *file, int line) {
  MemNode *node;
  
  ksection_lock(&kmalloc_lock);
  
  kprintf("===Allocated blocks===\n");
  
  for (node = alloclist.first; node; node=node->next) {
    if (!_ktestmem(node+1)) {
      //print bad blocks later
      break;
    }
    
    _kprintf_block(node, 0);
    terminal_flush();
  }
  
  kprintf("\n");
  terminal_flush();
  
  int bad = 0;
  
  kprintf("==== Bad blocks ===\n");
  for (node = alloclist.first; node; node=node->next) {
    if (!_ktestmem(node+1)) {
      kprintf("Bad ");
      _kprintf_block(node, 0);
      bad = 1;
    }
  }
  
  if (bad) { //only do overlap test if no bad blocks
    ksection_unlock(&kmalloc_lock);
    return -1;
  }
  
  //overlap test
  for (MemNode *n1 = alloclist.first; node; node=node->next) {
    for (MemNode *n2 = alloclist.first; n2; n2=n2->next) {
      if (n1 == n2)
        continue;
      
      uintptr_t a1 = (uintptr_t)n1, a2 = ((uintptr_t)n1->pair) + sizeof(MemNode);
      uintptr_t b1 = (uintptr_t)n2, b2 = ((uintptr_t)n2->pair) + sizeof(MemNode);
      
      if (a2 >  b1 && a1 < b2) {
        klogf("HEAP ERROR: overlapping blocks:\n");
        _kprintf_block(n1, 1);
        _kprintf_block(n2, 1);
      }
    }
  }
  
  ksection_unlock(&kmalloc_lock);
  
  return -bad;
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
