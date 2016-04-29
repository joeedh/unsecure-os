#ifndef _GDT_H
#define _GDT_H

#include <stdint.h>

//keep up to date with GDT_ENTRIES in definitions.nasm!
#define GDT_SIZE 32

enum {
  GDT_NULL,
  GDT_CODE,
  GDT_DATA,
  GDT_MAIN_TSS,
  GDT_INTERRUPTS
};

typedef struct GDTEntry {
  unsigned int limit1:16;
  unsigned int base1:16;
  unsigned int base2:8;
  unsigned int type:4;
  unsigned int s:1;
  unsigned int dpl:2;
  unsigned int p:1;
  unsigned int limit2:4;
  unsigned int avl:1;
  unsigned int l:1;
  unsigned int db:1;
  unsigned int g:1;
  unsigned int base3:8;
}  __attribute__((packed)) GDTEntry;

int gdt_alloc16(int base, int limit, int type);

#define GSEL_CODE   0x08
#define GSEL_DATA   0x10
#define GSEL_CODE16 0x28
#define GSEL_DATA16 0x30

typedef unsigned int GDTPtrInt;

typedef struct GDT {
  GDTPtrInt base;
  unsigned int limit, type;
} GDT;

void gdt_encode(uint8_t *target, struct GDT *source);
void gdt_decode(uint8_t *target, struct GDT *source);

void gdt_initialize();

typedef volatile struct TSS {
    unsigned short   link;
    unsigned short   link_h;

    unsigned long   esp0;
    unsigned short   ss0;
    unsigned short   ss0_h;

    unsigned long   esp1;
    unsigned short   ss1;
    unsigned short   ss1_h;

    unsigned long   esp2;
    unsigned short   ss2;
    unsigned short   ss2_h;

    unsigned long   cr3;
    unsigned long   eip;
    unsigned long   eflags;

    unsigned long   eax;
    unsigned long   ecx;
    unsigned long   edx;
    unsigned long    ebx;

    unsigned long   esp;
    unsigned long   ebp;

    unsigned long   esi;
    unsigned long   edi;

    unsigned short   es;
    unsigned short   es_h;

    unsigned short   cs;
    unsigned short   cs_h;

    unsigned short   ss;
    unsigned short   ss_h;

    unsigned short   ds;
    unsigned short   ds_h;

    unsigned short   fs;
    unsigned short   fs_h;

    unsigned short   gs;
    unsigned short   gs_h;

    unsigned short   ldt;
    unsigned short   ldt_h;

    unsigned short   trap;
    unsigned short   iomap;
} TSS;

#endif /* _GDT_H */
