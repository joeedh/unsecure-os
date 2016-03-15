#ifndef _PCI_H
#define _PCI_H

#include <stddef.h>
#include <stdint.h>

#include "../../io.h"

#define bit unsigned int
typedef struct PCIConfigAddress {
  bit unused:2;
  bit pregister:6;
  bit function:3;
  bit device:5;
  bit bus:8;
  bit reserved:7;
  bit enabled:1;
} PCIConfigAddress;
#undef bit

#define PCI_CONFIG_ADDR 0xCF8
#define PCI_CONFIG_DATA 0xCFC
void pci_initialize();

//don't call on PCI_ReadConfig directly
//e.g. PCI_PARSE(int32, VendorRegister, vendor_id) extracts the vendor id
#define PCI_PARSE(int_var, type, member) (((type*)(&int_var))->member)
  
static inline uint32_t PCI_ReadConfig(PCIConfigAddress *p) {
  unsigned int *i = (unsigned int*)p;
  
  outl(PCI_CONFIG_ADDR, *i);
  uint32_t response  = inl(PCI_CONFIG_DATA);
  
  //(offset & 2) * 8) = 0
  //response = (response >> ((offset & 2) * 8)) & 0xffff;
  return response;
};

#if 0
uint16_t pciConfigReadWord (uint8_t bus, uint8_t slot,
                             uint8_t func, uint8_t offset)
 {
    uint32_t address;
    uint32_t lbus  = (uint32_t)bus;
    uint32_t lslot = (uint32_t)slot;
    uint32_t lfunc = (uint32_t)func;
    uint16_t tmp = 0;
 
    /* create configuration address as per Figure 1 */
    address = (uint32_t)((lbus << 16) | (lslot << 11) |
              (lfunc << 8) | (offset & 0xfc) | ((uint32_t)0x80000000));
 
    /* write out the address */
    sysOutLong (0xCF8, address);
    /* read in the data */
    /* (offset & 2) * 8) = 0 will choose the first word of the 32 bits register */
    tmp = (uint16_t)((sysInLong (0xCFC) >> ((offset & 2) * 8)) & 0xffff);
    return (tmp);
 }
#endif

#endif /* _PCI_H */
