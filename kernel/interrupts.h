#ifndef _INTERRUPTS_H
#define _INTERRUPTS_H

#include "libc/libk.h"
#include "io.h"
#include <stdint.h>

#define PIC1		0x20		/* IO base address for master PIC */
#define PIC2		0xA0		/* IO base address for slave PIC */
#define PIC1_COMMAND	PIC1
#define PIC1_DATA	(PIC1+1)
#define PIC2_COMMAND	PIC2
#define PIC2_DATA	(PIC2+1)
#define PIC_READ_IRR                0x0a    /* OCW3 irq ready next CMD read */
#define PIC_READ_ISR                0x0b    /* OCW3 irq service next CMD read */

#define PIC_EOI		0x20		/* End-of-interrupt command code */

void interrupts_initialize();

extern volatile unsigned int inside_irq;

static inline void debug_check_interrupts() {
  unsigned int state = read_eflags();
  if (!(state & (1<<9))) {
    kprintf("interrupts were DISABLED!!!!!\n");
    asm("STI");
  }
}

//well. . .this is a diagnostic structure anyway,
//so I don't feel like figuring out what I did wrong to
//make it not be aligned
#pragma GCC diagnostic ignored "-Wpadded"
typedef struct EFLAGS {
  unsigned int carry:1;
  unsigned int always_set1:1;
  unsigned int parity:1;
  unsigned int always_unset1:1;
  
  unsigned int adjust:1;
  unsigned int reserved:1;
  unsigned int zero:1;
  unsigned int sign:1;
  unsigned int trap:1;
  
  unsigned int interrupts:1;
  unsigned int direction:1;
  unsigned int overflow:1;
  
  unsigned int iopl:2;
  
  unsigned int nested_task:1;
  unsigned int resume:1;
  unsigned int virtual_8086_mode:1;
  unsigned int alignment_check:1;
  
  unsigned int virtual_interrupt:1;
  unsigned int virtual_interrupt_pending:1;
  unsigned int id:1;
  
  unsigned int reserved2:10;
} EFLAGS;

typedef struct IDTEntry {
  unsigned int offset1:16;
  unsigned int selector:16;
  unsigned int unused_must_be_zero:8;
  unsigned int gate_type:2;
  unsigned int should_be_set:1;
  unsigned int is32:1;
  unsigned int should_be_unset:1;
  unsigned int dpl:2;
  unsigned int p:1;
  unsigned int offset2:16;
}  __attribute__((packed)) IDTEntry;

extern IDTEntry idt_table[256];

struct IDTDescr{
   uint16_t offset_1; // offset bits 0..15
   uint16_t selector; // a code segment selector in GDT or LDT
   uint8_t zero;      // unused, set to 0
   uint8_t type_attr; // type and attributes, see below
   uint16_t offset_2; // offset bits 16..31
}  __attribute__((packed));

typedef struct interrupt_record {
  int (*callback)(unsigned int irq);
  unsigned int flag;
} interrupt_record;

static inline int are_interrupts_enabled()
{
    unsigned long flags;
    asm volatile ( "pushf\n\t"
                   "pop %0"
                   : "=g"(flags) );
    return flags & (1 << 9);
}

static inline void lidt(void* base, uint16_t size)
{   // This function works in 32 and 64bit mode
    struct {
        uint16_t length;
        void*    base;
    } __attribute__((packed)) IDTR = { size, base };
 
    asm ( "lidt %0" : : "m"(IDTR) );  // let the compiler choose an addressing mode
}
 
static void PIC_sendEOI(unsigned char irq)
{
	if(irq >= 8)
		outb(PIC2_COMMAND,PIC_EOI);
 
	outb(PIC1_COMMAND,PIC_EOI);
}

#endif /* _INTERRUPTS_H */
