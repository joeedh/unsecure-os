#ifndef _GDT_H
#define _GDT_H

#include <stdint.h>

#define GDT_SIZE 5

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

typedef unsigned int GDTPtrInt;

typedef struct GDT {
  GDTPtrInt base;
  unsigned int limit, type;
} GDT;

void gdt_encode(uint8_t *target, struct GDT *source);
void gdt_decode(uint8_t *target, struct GDT *source);

void gdt_initialize();

#endif /* _GDT_H */
