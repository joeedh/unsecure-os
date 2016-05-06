#include <stddef.h>
#include <stdint.h>

#include "../../libc/string.h"
#include "../../libc/libk.h"
#include "../../libc/stdio.h"
#include "../../libc/stdlib.h"
#include "../../libc/list.h"
#include "../../libc/kmalloc.h"
#include "../../io.h"
#include "../../interrupts.h"

#include "pci.h"
#include "pci_tables.h"

List pci_devices = {NULL, NULL};

static void print_info00(PCIFieldsH00 *pci) {
  e9printf("vendor_id: %d, device_id: %d\n", pci->id.vendor_id, pci->id.device_id);
  e9printf("class_code: %d, subclass: %d, progif: %d, revisionid: %d\n", pci->classinfo.class_code,
           pci->classinfo.subclass, pci->classinfo.progif, pci->classinfo.revisionid);
}

static void read_pci(int bus, int device, int function) {
  uint32_t header = PCI_getHeaderType(bus, device, function);
  
  e9printf("header: %d\n", header);
  
  //read entire config space
  uint32_t *config = kmalloc(256), *conf=config;
  memset(config, 0, sizeof(config));
  
  PCIConfigAddress dev;
  memset(&dev, 0, sizeof(dev));
  
  for (int i=0; i<64; i++, conf++) {
    dev.bus = bus;
    dev.device = device;
    dev.function = function;
    dev.enabled = 1;
    dev.pregister = i;
    
    *conf = PCI_ReadConfig(&dev);
    io_wait();
    //e9printf("%d: %d\n", i, *conf);
  }
  
  PCIFieldsH00 *pci = (PCIFieldsH00*)config;
  print_info00(pci);
  
  LinkNode *node = kmalloc(sizeof(LinkNode));
  node->data = config;
  
  klist_append(&pci_devices, node);
}

void pci_initialize() {
  e9printf("\nInitializing PCI. . .\n");
  
  for (int i=0; i<256; i++) {
    for (int j=0; j<32; j++) {
      uint32_t vendorID = PCI_getVendorID(i, j, 0);

      if(vendorID == 0xFFFF) continue; // Device doesn't exist

      uint32_t headerType = PCI_getHeaderType(i, j, 0);

      if(headerType & 0x80) {
         /* It is a multi-function device, so check remaining functions */
        
        for (int k=0; k<8; k++) {
          if(PCI_getVendorID(i, j, k) != 0xFFFF) {
            e9printf("\n  Found device! bus: %d, device: %d, function: %d\n", i, j, k);
            read_pci(i, j, k);
          }
        }
      } else {
        e9printf("\n  Found device! bus: %d, device: %d, function: %d\n", i, j, 0);
        read_pci(i, j, 0);
      }
    }
  }
  
  e9printf("\n");
}

uint16_t PCI_getDeviceClass(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
  //probe behind pci-to-pci bridges
  //dev.unused = 1;

  dev.bus = bus;
  dev.device = device;
  dev.function = function;
  dev.enabled = 1;
  dev.pregister = REG_R_DEVICE_ID;
  
  uint32_t n = PCI_ReadConfig(&dev);
  
  return PCI_PARSE(n, ClassInfoRegister, class_code);
}

uint16_t PCI_getVendorID(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
  //probe behind pci-to-pci bridges
  //dev.unused = 1;
  
  dev.bus = bus;
  dev.device = device;
  dev.function = function;
  dev.enabled = 1;
  dev.pregister = REG_R_DEVICE_ID;
  
  uint32_t n = PCI_ReadConfig(&dev);
  
  return n & 65535;  //PCI_PARSE(n, VendorRegister, vendor_id);
}

uint16_t PCI_getHeaderType(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
  //probe behind pci-to-pci bridges
  //dev.unused = 1;

  dev.bus = bus;
  dev.device = device;
  dev.function = function;
  dev.enabled = 1;
  dev.pregister = REG_R_HEADER_BIST_LAT;
  
  uint32_t n = PCI_ReadConfig(&dev);
  
  return PCI_PARSE(n, HeaderRegister, header_type);
}

void PCI_checkFunction(uint8_t bus, uint8_t device, uint8_t function) {
}

void PCI_checkDevice(uint8_t bus, uint8_t device) {
   uint8_t function = 0;

   uint32_t vendorID = PCI_getVendorID(bus, device, function);
   if(vendorID == 0xFFFF) return; // Device doesn't exist
   
   PCI_checkFunction(bus, device, function);
   uint32_t headerType = PCI_getHeaderType(bus, device, function);
   
   if( (headerType & 0x80) != 0) {
       /* It is a multi-function device, so check remaining functions */
       for(function = 1; function < 8; function++) {
           if(PCI_getVendorID(bus, device, function) != 0xFFFF) {
               PCI_checkFunction(bus, device, function);
           }
       }
   }
}
