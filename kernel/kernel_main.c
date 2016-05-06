#include "drivers/fs/fs_file.h"
#include "drivers/fs/fs_interface.h"
#include "drivers/blockdevice/blockdevice.h"
#include "drivers/fs/memfile.h"
#include "drivers/ext2/ext2.h"
#include "drivers/blockdevice/memblock.h"
#include "drivers/tty/tty.h"
#include "drivers/keyboard/keyboard.h"
#include "drivers/tty/tty_file.h"
#include "drivers/hdd/hdd.h"
#include "drivers/pci/pci.h"
#include "io.h"
#include "interrupts.h"
#include "gdt.h"
#include "definitions/memory.h"

#include "drivers/fs/dirent.h"

#include "libc/string.h"
#include "libc/libk.h"
#include "libc/kmalloc.h"
#include "dmesg/dmesg.h"

#include "task/task.h"
#include "task/process.h"

#include "SudoBios.h"

extern void parse_bootinfo(void *bootinfo1);
extern void fpu_initialize();

volatile unsigned int enable_klock_debug;

#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif

extern volatile unsigned int k_debug;
volatile unsigned int k_debug2;
extern Task tasks[];

FSInterface *rootfs;
BlockDeviceIF *rootdevice;

extern char _tinyext2_fs[];
extern unsigned int _tinyext2_fs_size;

void setup_root() {
  size_t size = _tinyext2_fs_size;
  size_t bsize = 512;
  
   //how to deal with remainder/rounding?
   //for now, just truncate
  size = size - (size % bsize);
  
  BlockDeviceIF *device = kmemblock_new(bsize, _tinyext2_fs_size/bsize, _tinyext2_fs);
  //device->write(device, 0, size, _tinyext2_fs);
  
  FSInterface *fs = kext2fs_create(device);
  rootfs = fs;
  
  if (fs->mount_filesystem) {
    fs->mount_filesystem(fs, device);
  }
  
  rootdevice = device;
  rootfs = fs;
  
  //set up a /proc
  extern FSInterface *init_procfs();
  
  FSInterface *procfs = init_procfs();
  fs_vfs_add("/proc", procfs, rootdevice);
}

void test_rootfs() {
  //struct stat mstat;
  //int totentries;

  //totentries = rootfs->dir_entrycount(rootfs, rootdevice, 2);
  
  //rootfs->stat(rootfs, rootdevice, 2, &mstat, NULL);
  
  //kprintf("stat size: %d\n", mstat.st_size);
  //kprintf("totentries: %d\n", totentries);
  
  
  DIR *dir = opendir_inode(2);
  struct dirent *entry;
  int i=0;
  
  while ((entry = readdir(dir))) {
    kprintf("  %d:%s\n", entry->d_ino, entry->d_name);
    
    if (i++ > 5000) {
      kprintf("infinite loop!\n");
      break;
    }
  }

  closedir(dir);
  kprintf("\n");
  
  /*
  dir = opendir("/usr/include");
  while ((entry = readdir(dir))) {
    kprintf("  %d:%s\n", entry->d_ino, entry->d_name);
    
    if (i++ > 5000) {
      kprintf("infinite loop!\n");
      break;
    }
  }
  
  closedir(dir);
  //*/
}

void startup_kernel(void *bootinfo1) {
  e9printf("starting kernel.  bootinfo: %p . .\n", bootinfo1);
  e9printf("  sizeof(void*): %d, sizeof(int): %d, sizeof(long): %d\n", 
               (int)sizeof(void*), (int)sizeof(int), (int)sizeof(long));
  e9printf("  sizeof(Process): %d, sizeof(Task): %d\n", sizeof(Process), sizeof(Task));
  //while (1) {
  //}
  
  _cpu_exception_flag = 0;
  rootfs = NULL;
  
//  extern volatile unsigned int enable_klock_debug;
  
  enable_klock_debug = 0;
  
  e9printf("initializing gdt. . .\n");
  gdt_initialize();

  e9printf("parsing boot info. . .\n");
  parse_bootinfo(bootinfo1);

  libc_initialize();
  kmalloc_init_with_holes();
  dmesg_initialize();
  
  e9printf("initializing multitasking. . .\n");

  e9printf("  timer. . .\n");
  timer_initialize();
  e9printf("  tasks. . .\n");
  tasks_initialize();
  e9printf("  process. . .\n");
  process_initialize();
  
  e9printf("initializing framebuffer. . .\n");
  extern void framebuffer_init();
  framebuffer_init();
  
  /* Initialize terminal interface */
  e9printf("initializing terminal. . .\n");
  terminal_initialize();
  
  /* keyboard */
  e9printf("initializing keyboard. . .\n");
  keyboard_initialize();
  
  e9printf("initializing interrupts. . .\n");
  kprintf("\ninitializing interrupts. . .\n");
  
  interrupts_initialize();
  e9printf("flush pending keyboard data. . .\n");
  keyboard_post_irq_enable();
  io_wait();
  
  pci_initialize();
  hdd_initialize();
  
  e9printf("initializing the fpu. . .\n");
  fpu_initialize();
  
  //e9printf("testing kmalloc. . .\n");
  //test_kmalloc();

  e9printf("initializing filesystem. . .\n");
  filesystem_initialize();
  tty_file_initialize();
  
  //kprintf("\nmounting file system. . .\n");
  e9printf("mounting root filesystem. . .\n");
  setup_root();
  
  interrupts_enable();
  //e9printf("\ntesting file system code. . .\n");
  //test_rootfs();
  
  e9printf("loading SudoBios. . .\n");
  SBIOS_init();
  
  process_finishinit();
  
  e9printf("kernel startup complete.\n");
  kprintf("Kernel started\n Exception flag: %d\n", _cpu_exception_flag);
  
  debug_check_interrupts();
}

int kernel_task1(int argc, char **argv);
int kernel_task2(int argc, char **argv);

extern void _tst_call(void *addr);
extern volatile int k_totaltasks;
int kcli_main(int argc, char **argv);

void kernel_testcall() {
  kernel_task1(0, NULL);
}

int test_task_finish(int argc, char **argv) {
  kprintf("Start task finish\n");
  
  terminal_flush();
  
  kprintf("End task finish\n");
  return 5;
}

void test_task_finish_finish(int ret, int tid, int pid) {
  kprintf("-> %x %x %x\n", ret, tid, pid);
}

extern void *_bootinfo;

#if 0
void test_examine_far_call_stack() {
  interrupts_disable();
  
  unsigned char tmp[256];
  unsigned char *head = &tmp[200];
  extern void __farTestA_tag();
  
  memset(tmp, 0xff, sizeof(tmp));
  
  extern uintptr_t __farTestA(void *stack_head);
  unsigned char *tail = (unsigned char*) __farTestA(head);
  unsigned int* itail = (unsigned int*)tail;
  
  kprintf("%x:\n", __farTestA_tag);
  kprintf(":: %x %x %x %x %x", tail[0], tail[1], tail[2], tail[3], tail[4]);
  kprintf(" %x %x %x   %x %x\n", tail[5], tail[6], tail[7], tail[8], tail[9]);
  kprintf(": %x %x %x\n", itail[0], itail[1], itail[2]);

  kprintf("\n\n");
  
  head = &tmp[200];
  extern void __farTestB_tag();
  
  memset(tmp, 0xff, sizeof(tmp));
  
  extern uintptr_t __farTestB(void *stack_head);
  tail = (unsigned char*) __farTestB(head);
  itail = (unsigned int*)tail;
  
  kprintf("%x:\n", __farTestB_tag);
  kprintf(":: %x %x %x %x %x", tail[0], tail[1], tail[2], tail[3], tail[4]);
  kprintf(" %x %x %x   %x %x\n", tail[5], tail[6], tail[7], tail[8], tail[9]);
  kprintf(": %x %x %x\n", itail[0], itail[1], itail[2]);
}
#endif

void kernel_main(void *bootinfo1) {
  _bootinfo = bootinfo1;
  
  startup_kernel(bootinfo1);
  
  //test_examine_far_call_stack();
  //while (1) {
  //}
  
  /*
  interrupts_disable();
  while (1) {
  }
  return;
  //*/
  
  interrupts_disable();
  
  kprintf("sizeof(Task): %d\n", (int) sizeof(Task));
  kprintf("sizeof(Process): %d\n", (int) sizeof(Process));
  
  kprintf("sizeof(TSS): %d\n", (int) sizeof(TSS));
  e9printf("sizeof(TSS): %d\n", (int) sizeof(TSS));
  
  extern int found_vbe3_pmid;
  kprintf("found_vbe3_pmid: %d\n", found_vbe3_pmid);
  
  //test_kmalloc();
  //while (1) {
  //}
  //test_kmalloc();
  
  //char *argv[] = {"yay", "one", "two", "three"};
  Process *proc = spawn_process("tty", 1, NULL, kcli_main); //4, argv, kcli_main);
  process_start(proc);

  asm("CLI");
  e9printf("KP: %p %p %p\n", k_curtaskp, k_curtaskp->next, k_curtaskp->next->next);
  asm("STI");
  //int i = 0;
  
  while (1) {
    task_yield();

    /*i = (i + 1) & ((1<<16)-1);
    if (i == 0) {
      e9printf("yay\n");
    }*/
  }
  
  //paranoia check to ensure interrupts are now enabled
  interrupts_enable();
  
  kprintf("Started task!\n");
  terminal_flush();
  
  unsigned int last_tick = 0;
  unsigned int counter = 0;
  
  debug_check_interrupts();
  interrupts_enable();
  
  asm("CLI");
  e9printf("KP: %p %p %p\n", k_curtaskp, k_curtaskp->next, k_curtaskp->next->next);
  asm("STI");
  
  while (1) {
  }
  
  //kprintf("k_totaltasks: %d\n", k_totaltasks);
  while (1) {
    //asm("PAUSE");
    debug_check_interrupts();
    
    continue;
    
    if (last_tick != kernel_tick) {
      counter++;
      kprintf("%d\n", counter);
      //kprintf("  TIMER: %d, k_totaltasks: %d k_debug %x\n", kernel_tick, k_totaltasks, (unsigned int) k_debug);
      last_tick = kernel_tick;
    }
    //task_sleep(1);
  }
}

int kernel_task2(int argc, char **argv) {
  unsigned int last_tick = -1;
  
  kprintf("start!\n");
  terminal_flush();
  
  unsigned int counter = 0;
  
  while (1) {
    if (last_tick != kernel_tick) {
      counter++;
      kprintf("-%d\n", counter);
      //kprintf("  TIMER: %d, k_totaltasks: %d k_debug %x\n", kernel_tick, k_totaltasks, (unsigned int) k_debug);
      last_tick = kernel_tick;
    }
    //kprintf("one\n");
    
    //task_sleep(5);
  }
}

int kernel_task1(int argc, char **argv) {
  extern unsigned char thegdt[][GDT_SIZE];
  
	/* Since there is no support for newlines in terminal_putchar
         * yet, '\n' will produce some VGA specific character instead.
         * This is normal.
         */
	terminal_writestring("Hello, kernel World!\nLine1\nLine2\n\tLine3\n");
  
  unsigned int cr0 = read_cr0();
  
  terminal_writestring("cr0: ");
  kputuint(cr0&1);
  terminal_putchar(';');
  terminal_putchar('\n');
  
  terminal_writestring("ss: ");
  kputuint(read_ss());
  terminal_putchar(';');
  terminal_putchar('\n');
  
  terminal_writestring("ds: ");
  kputuint(read_ds());
  terminal_putchar(';');
  terminal_putchar('\n');
  
  terminal_writestring("cs: ");
  kputuint(read_cs());
  terminal_putchar(';');
  terminal_putchar('\n');
  
  extern void read_gdtr(gdtrptr *ptr);
  gdtrptr ptr;
  ptr.a = ptr.b = ptr.c = ptr.pad = 0;
  
  read_gdtr(&ptr);
  
  unsigned long addr = ptr.b | (ptr.c<<16);
  
  terminal_putchar('\n');
  kputuint(ptr.a);
  terminal_putchar('\n');
  
  kputuint(ptr.b);
  terminal_putchar('\n');
  
  kputuint(ptr.c);
  terminal_putchar('\n');
  
  kputuint(ptr.pad);
  terminal_putchar('\n');
  terminal_putchar('\n');
  
  kprintf("-->: |%d| \n", k_debug);
  
  kprintf("gdt: %x %x\n", (unsigned int)addr, (unsigned int)thegdt);
  char *gdt1 = (char*)addr;
  GDTEntry *entry = (GDTEntry*) addr;
  entry++;
  
  for (int i=0; i<4; i++, entry++) {
    
    //kprintf("%b %b %b %b  %b %b %b %b\n", 
    //         gdt1[0], gdt1[1], gdt1[2], gdt1[3], gdt1[4], gdt1[5], gdt1[6], gdt1[7]);
    
    kprintf("limit1: %d, base1: %d, base2: %d, type: %d, s: %d, dpl: %d, p: %d, \n\
          limit2: %d, avl: %d, l: %d, db: %d, g: %d, base3: %d\n\n",
             entry->limit1, entry->base1, entry->base2, entry->type, entry->s,
             entry->dpl, entry->p, entry->limit2, entry->avl, entry->l, entry->db,
             entry->g, entry->base3);
  }
  kprintf("\n");
  
  GDT gdt;
  gdt_decode(gdt1+8, &gdt);
  kprintf("limit: %x, base: %x, type: %x\n", gdt.limit, gdt.base, gdt.type);

  gdt_decode(gdt1+16, &gdt);
  kprintf("limit: %x, base: %x, type: %x\n", gdt.limit, gdt.base, gdt.type);

  gdt_decode(gdt1+24, &gdt);
  kprintf("limit: %x, base: %x, type: %x\n", gdt.limit, gdt.base, gdt.type);

  gdt_decode(gdt1+32, &gdt);
  kprintf("limit: %x, base: %x, type: %x\n", gdt.limit, gdt.base, gdt.type);
  //kprintf("yay %d %s\n", 15, "yay2");
  
  kprintf("\n");
  
  extern void read_lidt(gdtrptr *ptr);
  read_lidt(&ptr);
  addr = ptr.b | (ptr.c<<16);
  
  kprintf("idt: %x %x\n", addr, (unsigned int)idt_table);
  IDTEntry *idt = (IDTEntry *)idt_table;
  
  kprintf("idt:\n\toffset1: %d\n\tselector: %d\n\tunused_must_be_zero: %d\n\tgate_type: %d\n\t\
should_be_set: %d\n\tis32: %d\
\n\tshould_be_unset: %d\n\tdpl: %d\n\tp: %d\n\toffset2: %d\n", idt->offset1, idt->selector,
           idt->unused_must_be_zero, idt->gate_type, idt->should_be_set, idt->is32, 
           idt->should_be_unset, idt->dpl, idt->p, idt->offset2);
  
  extern void isr_1();
  
  addr = idt->offset1 | (idt->offset2<<16);
  kprintf("isr_1: %x %x\n", addr, (unsigned int)isr_1);
  kprintf("sizeof(IDTEntry): %d\n", sizeof(IDTEntry));
  
  unsigned int eflags = read_eflags();
  kprintf("eflags: %x\n", eflags & (1<<9));
  
  EFLAGS *ef = (EFLAGS*)(&eflags);
  kprintf("eflags: {\n");
#define _(a) kprintf("\t%s: %d\n", #a, ef->a);
  _(carry);
  _(parity);
  _(adjust);
  _(zero);
  _(sign);
  _(trap);
  _(interrupts);
  _(direction);
  _(overflow);
  _(iopl);
  _(nested_task);
  _(resume);
  _(virtual_8086_mode);
  _(alignment_check);
  _(virtual_interrupt);
  _(virtual_interrupt_pending);
  _(id);
  
  kprintf("}\n");
  
  //extern unsigned int kb_queue_b;
  
  kprintf("T: %x %x\n", k_debug, kernel_task2);
  
  #if 1
  unsigned int last_tick = kernel_tick;
  //short lastchar = -1;
  
  terminal_flush();
  
  while (1) {
    short ch = getchar_nowait();
    
    if (ch >= 0) {// && ch != lastchar) {
      terminal_putchar(((unsigned char)ch)&127);
      //lastchar = ch;
      
      //if (ch == '\n') {
        terminal_flush();
      //}
    }
    
    //if (kernel_tick % 10 == 0) {
    if (kernel_tick != last_tick) {
      //kprintf("timer tick: %d\n", kernel_tick);
      last_tick = kernel_tick;
    }
    
    //task_sleep(5);
  }
  #endif
  
  while (1) {
    //safety check to prevent return;
  }
}