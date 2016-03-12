#ifndef _K_IO_H
#define _K_IO_H

#define MAX_TASKS 512 //keep up-to-date with nasm code

#define MEM_STACK_BASE (1024*1024*12)
#define MEM_STACK_INDV_SIZE (1024*512)
#define MEM_STACK_END (MEM_STACK_BASE + MEM_STACK_INDV_SIZE*MAX_TASKS)
#define MEM_STACK_SIZE (MEM_STACK_END - MEM_STACK_BASE)

#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

extern volatile unsigned int _cpu_exception_flag;
extern unsigned int read_eflags();

//disables interrupts and returns state used to reenable later (if they were already enabled)
static inline unsigned int safe_entry() {
  unsigned int eflags = read_eflags();
  asm("cli");
  return eflags;
}

//pair of safe_entry
static inline void safe_exit(unsigned int eflags) {
  //restore interrupt flags (by restoring eflags)
  asm( "push %0\n\t"
       "popf\n\t"
        ::"r"(eflags) );
}

/*Write a 8/16/32-bit value to a segment:offset address too. Note that much like in farpeek, this version of farpoke saves and restore the segment register used for the access.*/
static inline void farpokeb(uint16_t sel, void* off, uint8_t v)
{
    asm ( "push %%fs\n\t"
          "mov  %0, %%fs\n\t"
          "movb %2, %%fs:(%1)\n\t"
          "pop %%fs"
          : : "g"(sel), "r"(off), "r"(v) );
    /* TODO: Should "memory" be in the clobber list here? */
}

/*
Read a 8/16/32-bit value at a given memory location using another segment than the default C data segment. Unfortunately there is no constraint for manipulating segment registers directly, so issuing the mov <reg>, <segmentreg> manually is required.
*/
static inline uint32_t farpeekl(uint16_t sel, void* off)
{
    uint32_t ret;
    asm ( "push %%fs\n\t"
          "mov  %1, %%fs\n\t"
          "mov  %%fs:(%2), %0\n\t"
          "pop  %%fs"
          : "=r"(ret) : "g"(sel), "r"(off) );
    return ret;
}

/*Read the value in a control register.*/
static inline unsigned long read_cr0(void)
{
    unsigned long val;
    asm volatile ( "mov %%cr0, %0" : "=r"(val) );
    return val;
}

static inline unsigned int read_eax(void)
{
    unsigned int val;
    asm volatile ( "mov %%eax, %0" : "=r"(val) );
    return val;
}

static inline unsigned short read_ax(void)
{
    unsigned short val;
    asm volatile ( "mov %%AX, %0" : "=r"(val) );
    return val;
}

static inline unsigned short read_cs(void)
{
    unsigned short val;
    asm volatile ( "mov %%CS, %0" : "=r"(val) );
    return val;
}

static inline unsigned short read_ss(void)
{
    unsigned short val;
    asm volatile ( "mov %%SS, %0" : "=r"(val) );
    return val;
}

static inline unsigned short read_ds(void)
{
    unsigned short val;
    asm volatile ( "mov %%DS, %0" : "=r"(val) );
    return val;
}

typedef struct gdtrptr {
  short a;
  short b;
  short c;
  short pad;
} gdtrptr;

/*
static inline gdtrptr read_gdtr(void)
{
    gdtrptr ret;
    
    asm volatile ( "sgdt %0" : "=r"(ret) );
    
    return ret;
}*/

/*
Read the current value of the CPU's time-stamp counter and store into EDX:EAX. The time-stamp counter contains the amount of clock ticks that have elapsed since the last CPU reset. The value is stored in a 64-bit MSR and is incremented after each clock cycle.
*/
static inline uint64_t rdtsc()
{
    uint64_t ret;
    asm volatile ( "rdtsc" : "=A"(ret) );
    return ret;
}
 
static inline uint8_t inb(uint16_t port)
{
    uint8_t ret;
    asm volatile ( "inb %[port], %0"
                   : [result] "=a"(ret)   // using symbolic operand names as an example, mainly because they're not used in order
                   : [port] "Nd" (port) );
    return ret;
}

static inline void outb(uint16_t port, uint8_t val)
{
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
    /* There's an outb %al, $imm8  encoding, for compile-time constant port numbers that fit in 8b.  (N constraint).
     * Wider immediate constants would be truncated at assemble-time (e.g. "i" constraint).
     * The  outb  %al, %dx  encoding is the only option for all other cases.
     * %1 expands to %dx because  port  is a uint16_t.  %w1 could be used if we had the port number a wider C type */
}

static inline void outs(uint16_t port, uint16_t val)
{
    asm volatile ( "out %0, %1" : : "a"(val), "Nd"(port) );
    /* There's an outb %al, $imm8  encoding, for compile-time constant port numbers that fit in 8b.  (N constraint).
     * Wider immediate constants would be truncated at assemble-time (e.g. "i" constraint).
     * The  outb  %al, %dx  encoding is the only option for all other cases.
     * %1 expands to %dx because  port  is a uint16_t.  %w1 could be used if we had the port number a wider C type */
}

static inline void io_wait(void)
{
    /* Port 0x80 is used for 'checkpoints' during POST. */
    /* The Linux kernel seems to think it is free for use :-/ */
    asm volatile ( "outb %%al, $0x80" : : "a"(0) );
    /* %%al instead of %0 makes no difference.  TODO: does the register need to be zeroed? */
}

#endif /* _K_IO_H */
