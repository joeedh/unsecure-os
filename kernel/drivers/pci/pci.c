#include "../../libc/string.h"

#include "pci.h"
#include "pci_tables.h"

void pci_initialize() {
}

uint16_t PCI_getVendorID(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
  dev.bus = bus;
  dev.device = device;
  dev.function = function;
  dev.enabled = 1;
  dev.pregister = REG_R_DEVICE_ID;
  
  uint32_t n = PCI_ReadConfig(&dev);
  
  return PCI_PARSE(n, VendorRegister, vendor_id);
}

uint16_t PCI_getDeviceID(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
  dev.bus = bus;
  dev.device = device;
  dev.function = function;
  dev.enabled = 1;
  dev.pregister = REG_R_DEVICE_ID;
  
  uint32_t n = PCI_ReadConfig(&dev);
  
  return PCI_PARSE(n, VendorRegister, device_id);
}

uint16_t PCI_getHeaderType(uint8_t bus, uint8_t device, uint8_t function) {
  PCIConfigAddress dev;
  
  memset(&dev, 0, sizeof(dev));
  
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
