#include "gdt.h"
#include "io.h"
#include "interrupts.h"

#include "libc/string.h"
#include "libc/libk.h"

typedef uint8_t GDTRecord[8];

extern GDTRecord __k_gdt[GDT_SIZE];
//int __k_gdt_size = sizeof(GDTRecord) / 8;

//void create_descriptor(uint32_t base, uint32_t limit, uint16_t flag)
void gdt_encode2(uint8_t *target, struct GDT *source)
{
    uint64_t descriptor;
 
    // Create the high 32 bit segment
    descriptor  =  source->limit       & 0x000F0000;         // set limit bits 19:16
    descriptor |= (source->type <<  8) & 0x00F0FF00;         // set type, p, dpl, s, g, d/b, l and avl fields
    descriptor |= (source->base >> 16) & 0x000000FF;         // set base bits 23:16
    descriptor |=  source->base        & 0xFF000000;         // set base bits 31:24
 
    // Shift by 32 to allow for low part of segment
    descriptor <<= 32;
 
    // Create the low 32 bit segment
    descriptor |= source->base  << 16;                       // set base bits 15:0
    descriptor |= source->limit  & 0x0000FFFF;               // set limit bits 15:0
    
    unsigned char *c = (unsigned char *)&descriptor;
    
    for (int i=0; i<8; i++) {
      target[i] = c[i];
    }
}

/**
 * \param target A pointer to the 8-byte GDT entry
 * \param source An arbitrary structure describing the GDT entry
 */
void gdt_encode(uint8_t *target, struct GDT *source)
{
    // Check the limit to make sure that it can be encoded
    if ((source->limit > 65536) && (source->limit & 0xFFF) != 0xFFF) {
        kerror(0, "You can't do that!");
    }
    
    if (source->limit > 65535) {
        // Adjust granularity if required
        source->limit = source->limit >> 12;
        target[6] = 0xC0;
    } else {
        target[6] = 0x40;
    }
 
    // Encode the limit
    target[0] = source->limit & 0xFF;
    target[1] = (source->limit >> 8) & 0xFF;
    target[6] |= (source->limit >> 16) & 0xF;
 
    // Encode the base 
    target[2] = source->base & 0xFF;
    target[3] = (source->base >> 8) & 0xFF;
    target[4] = (source->base >> 16) & 0xFF;
    target[7] = (source->base >> 24) & 0xFF;
 
    // And... Type
    target[5] = source->type;
}

/**
 * \param target A pointer to the 8-byte GDT entry
 * \param source An arbitrary structure describing the GDT entry
 */
void gdt_decode(uint8_t *target, struct GDT *source)
{
    // Check the limit to make sure that it can be encoded
    //if ((source->limit > 65536) && (source->limit & 0xFFF) != 0xFFF) {
        //kerror("You can't do that!");
    //}
    
    int limit = target[0] | (target[1]<<8);
    
    if (target[6] & 128) {
      limit = (limit<<12) | 0xFFF;
    }
    
    source->limit = limit;
    
    int base = target[2] | (target[3]<<8) | (target[4]<<16) | (target[7]<<24);
    source->base = base;
    source->type = target[5];
    
    return;
    /*
    // Encode the limit
    target[0] = source->limit & 0xFF;
    target[1] = (source->limit >> 8) & 0xFF;
    target[6] |= (source->limit >> 16) & 0xF;
 
    // Encode the base 
    target[2] = source->base & 0xFF;
    target[3] = (source->base >> 8) & 0xFF;
    target[4] = (source->base >> 16) & 0xFF;
    target[7] = (source->base >> 24) & 0xFF;
 
    // And... Type
    target[5] = source->type;
    */
}

#define GDT_INIT(base1, limit1, type1)\
  gdt.base = base1; gdt.limit = limit1; gdt.type = type1;\
  gdt_encode(__k_gdt[i++], &gdt);
  

unsigned char myTss[0x64];

extern void _setGDT_prot2();
extern struct IDTEntry idt_table[256];
extern void isr_1();
extern void isr_2();
extern void isr_3();
extern void isr_4();
extern void isr_end();

void gdt_initialize() {
#if 1
  GDT gdt;
  int i=0;
  
  memset(myTss, 0, sizeof(myTss));
  memset(__k_gdt, 0, sizeof(__k_gdt));
  
  //unsigned long isr_len = (unsigned long)isr_end - (unsigned long)isr_1;
  
  GDT_INIT(0, 0, 0);// Selector 0x00 cannot be used
  GDT_INIT(0, 0xffffffff, 0x9A);// Selector 0x08 will be our code
  GDT_INIT(0, 0xffffffff, 0x92);// Selector 0x10 will be our data
  GDT_INIT((GDTPtrInt)&myTss, sizeof(myTss), 0x89);// You can use LTR(0x18)
  GDT_INIT(0, 0xffffffff, 0x89);
#endif
  
  GDTEntry *e = ((GDTEntry*)__k_gdt) + 4;
  
  e->s = 1;
  e->dpl = 0;
  e->db = 1; //32 bit segment
  e->type = 14;
  
  _setGDT_prot2();
}
