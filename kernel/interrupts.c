#include "libc/ctype.h"
#include "libc/string.h"
#include "libc/libk.h"
#include "drivers/tty/tty.h"
#include "drivers/keyboard/keyboard.h"
#include "definitions/memory.h"
#include "task/task.h"
#include "debug.h"

#include "io.h"
#include "interrupts.h"

volatile unsigned int inside_irq;

/*
The PIC has an internal register called the IMR, or the Interrupt Mask Register. It is 8 bits wide. This register is a bitmap of the request lines going into the PIC. When a bit is set, the PIC ignores the request and continues normal operation. Note that setting the mask on a higher request line will not affect a lower line. Masking IRQ2 will cause the Slave PIC to stop raising IRQs.
*/
void IRQ_set_mask(unsigned char IRQline) {
    uint16_t port;
    uint8_t value;
 
    if(IRQline < 8) {
        port = PIC1_DATA;
    } else {
        port = PIC2_DATA;
        IRQline -= 8;
    }
    value = inb(port) | (1 << IRQline);
    outb(port, value);        
}
 
void IRQ_clear_mask(unsigned char IRQline) {
    uint16_t port;
    uint8_t value;
 
    if(IRQline < 8) {
        port = PIC1_DATA;
    } else {
        port = PIC2_DATA;
        IRQline -= 8;
    }
    value = inb(port) & ~(1 << IRQline);
    outb(port, value);        
}

/* reinitialize the PIC controllers, giving them specified vector offsets
   rather than 8h and 70h, as configured by default */
 
#define ICW1_ICW4  0x01    /* ICW4 (not) needed */
#define ICW1_SINGLE  0x02    /* Single (cascade) mode */
#define ICW1_INTERVAL4  0x04    /* Call address interval 4 (8) */
#define ICW1_LEVEL  0x08    /* Level triggered (edge) mode */
#define ICW1_INIT  0x10    /* Initialization - required! */
 
#define ICW4_8086  0x01    /* 8086/88 (MCS-80/85) mode */
#define ICW4_AUTO  0x02    /* Auto (normal) EOI */
#define ICW4_BUF_SLAVE  0x08    /* Buffered mode/slave */
#define ICW4_BUF_MASTER  0x0C    /* Buffered mode/master */
#define ICW4_SFNM  0x10    /* Special fully nested (not) */

/*
arguments:
  offset1 - vector offset for master PIC
    vectors on the master become offset1..offset1+7
  offset2 - same for slave PIC: offset2..offset2+7
*/
void PIC_remap(int offset1, int offset2)
{
  unsigned char a1, a2;
 
  a1 = inb(PIC1_DATA);                        // save masks
  a2 = inb(PIC2_DATA);
 
  outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  // starts the initialization sequence (in cascade mode)
  io_wait();
  outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
  io_wait();
  outb(PIC1_DATA, offset1);                 // ICW2: Master PIC vector offset
  io_wait();
  outb(PIC2_DATA, offset2);                 // ICW2: Slave PIC vector offset
  io_wait();
  outb(PIC1_DATA, 4);                       // ICW3: tell Master PIC that there is a slave PIC at IRQ2 (0000 0100)
  io_wait();
  outb(PIC2_DATA, 2);                       // ICW3: tell Slave PIC its cascade identity (0000 0010)
  io_wait();
 
  outb(PIC1_DATA, ICW4_8086);
  io_wait();
  outb(PIC2_DATA, ICW4_8086);
  io_wait();
 
  outb(PIC1_DATA, a1);   // restore saved masks.
  outb(PIC2_DATA, a2);
}

extern void _disable_PIC();

void disable_PIC() {
  _disable_PIC();
 // asm volatile("mov %al, 0xff"::);
 // asm volatile("out 0xa1, %%al"::);
 // asm volatile("out 0x21, %%al"::);
}

 
/* Helper func */
static uint16_t __pic_get_irq_reg(int ocw3)
{
    /* OCW3 to PIC CMD to get the register values.  PIC2 is chained, and
     * represents IRQs 8-15.  PIC1 is IRQs 0-7, with 2 being the chain */
    outb(PIC1, ocw3);
    outb(PIC2, ocw3);
    
    return (inb(PIC2) << 8) | inb(PIC1);
}
 
/* Returns the combined value of the cascaded PICs irq request register */
uint16_t PIC_get_irr(void)
{
    return __pic_get_irq_reg(PIC_READ_IRR);
}
 
/* Returns the combined value of the cascaded PICs in-service register */
uint16_t PIC_get_isr(void)
{
    return __pic_get_irq_reg(PIC_READ_ISR);
}

static inline int kprintinfo() {
  stacktrace(kprintf);
  
  kprintf("\n============================\n");
  terminal_flush();
  
  kprintf("eax: %x, ecx: %x, esp: %x\n", read_eax(), read_ecx(), read_esp());
  kprintf("ebp: %x, ebx: %x, eflags: %x\n", read_ebp(), read_ebx(), read_eflags());
  kprintf("\ninstruction pointer: %x\n", get_eip);
  kprintf("k_curtaskp: %x\n", k_curtaskp);
  terminal_flush();
  
  return 0;
}

volatile int last_irq = 0;

#define EXC_HANDLE(n) \
extern void exr_##n();\
void _exc_handler##n(unsigned int flag) {\
  _cpu_exception_flag |= 1<<n;\
}


#define DEATH_EXCEPTION(n) \
extern void exr_##n();\
void _exc_handler##n(unsigned int flag) {\
  _cpu_exception_flag |= flag;\
  kprintinfo();\
  kerror(n, "Got exception " #n);\
}

#define WARN_EXCEPTION(n) \
extern void exr_##n();\
void _exc_handler##n(unsigned int flag) {\
  _cpu_exception_flag |= flag;\
  kprintinfo();\
  kprintf("====Got exception " #n "=====\n");\
}

DEATH_EXCEPTION(0); //divide by zero #DE

EXC_HANDLE(1); //debug                       #DB
EXC_HANDLE(2); //non-maskable interrupt      #NMI
EXC_HANDLE(3); //breakpoint                  #BP
EXC_HANDLE(4); //overflow                    #OF
EXC_HANDLE(5); //bound-range error           #BR
DEATH_EXCEPTION(6); //invalid opcode         #UD
DEATH_EXCEPTION(7); //device not available   #NM
WARN_EXCEPTION(8); //double fault            #DF
EXC_HANDLE(9); //coprocessor segment overrun 
WARN_EXCEPTION(10); //invalid tss            #TS
WARN_EXCEPTION(11); //segment not present    #NP
WARN_EXCEPTION(12); //stack error            #SS
DEATH_EXCEPTION(13); //general protection    #GP
WARN_EXCEPTION(14); //page fault             #PF

//there are only seven of these, so just define table here
void *excptrs[] = {
  exr_0,
  exr_1,
  exr_2,
  exr_3,
  exr_4,
  exr_5,
  exr_6,
  exr_7,
  exr_8,
  exr_9,
  exr_10,
  exr_11,
  exr_12,
  exr_13,
  //exr_14
};

#define tot_excptrs 14 //((int)(sizeof(excptrs) / sizeof(void*)))

#define ISR_HANDLE(n) void _isr_handler##n() {\
}

//ISR_HANDLE(0);// <- timer
//ISR_HANDLE(1); <- keyboard
ISR_HANDLE(2);
ISR_HANDLE(3);
ISR_HANDLE(4);
ISR_HANDLE(5);
ISR_HANDLE(6); //floppy
ISR_HANDLE(7);
ISR_HANDLE(8);
ISR_HANDLE(9);
ISR_HANDLE(10);
ISR_HANDLE(11);
ISR_HANDLE(12);
ISR_HANDLE(13);
ISR_HANDLE(14); //primary ata hard disk
ISR_HANDLE(15); //secondary ata hard disk

int nop_interrupt_handler(unsigned int irq) {
  return 0;
}

extern void _setIRT();

extern void *idtptrs[];
extern int tot_idtptrs;

#define PIC_REMAP_OFFSET  32

void interrupts_initialize() {
  inside_irq = 0;
  
  asm("cli"); //disable interrupts
  
  PIC_remap(PIC_REMAP_OFFSET, PIC_REMAP_OFFSET);
  
  memset(idt_table, 0, sizeof(idt_table));
  
  for (int i=0; i<tot_idtptrs; i++) {
    unsigned short off1, off2;
    unsigned long off = (unsigned long)idtptrs[i];
    
    off1 = off & 0xFFFF;
    off2 = (off>>16) & 0xFFFF;
    
    int i2 = i + PIC_REMAP_OFFSET;
    
    //0x6 //16-bit interrupt
    //idt_table[i].type_attr = (1 << 15) | 0xE; //32-bit interrupt
    
    idt_table[i2].offset1 = off1;
    idt_table[i2].offset2 = off2;
    idt_table[i2].selector = 0x08;
    idt_table[i2].p = 1;
    idt_table[i2].is32 = 1;
    
    //interrupt gate : 0xE, 1
    //trap gate      : 0xF, 3
    
    idt_table[i2].gate_type = 3;
    idt_table[i2].should_be_set = 1;
  }
  
  //exception handlers
  //return;
  for (int i=0; i<tot_excptrs; i++) {
    unsigned short off1, off2;
    unsigned long off = (unsigned long)excptrs[i];
    
    off1 = off & 0xFFFF;
    off2 = (off>>16) & 0xFFFF;
    
    //0x6 //16-bit interrupt
    //idt_table[i].type_attr = (1 << 15) | 0xE; //32-bit interrupt
    
    idt_table[i].offset1 = off1;
    idt_table[i].offset2 = off2;
    idt_table[i].selector = 0x08;
    idt_table[i].p = 1;
    idt_table[i].is32 = 1;
    
    //interrupt gate : 0xE, 1
    //trap gate      : 0xF, 3
    
    idt_table[i].gate_type = 3;
    idt_table[i].should_be_set = 1;
  }

  
  _setIRT();
}

