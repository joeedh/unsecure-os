#ifndef _PCI_TABLES_H
#define _PCI_TABLES_H

#include <stddef.h>
#include <stdint.h>

#include "../../io.h"

//helper macro to make bitfields clearer
#define bit unsigned int

enum { //register types
  REG_R_DEVICE_ID=0,
  REG_R_STATUS_COMMAND=0x04,
  REG_R_CLASSINFO=0x08,
  REG_R_HEADER_BIST_LAT=0x0C
};

enum { //device classes
  CLASS_UNKNOWN,
  CLASS_MASS_STORAGE,
  CLASS_NETWORK,
  CLASS_DISPLAY,
  CLASS_MULTIMEDIA,
  CLASS_MEMORY,
  CLASS_BRIDGE,
  CLASS_SIMPLE_COMM,
  CLASS_BASE_SYSTEM_PERIPH,
  CLASS_INPUT,
  CLASS_DOCKING,
  CLASS_PROCESSORS,
  CLASS_SERIAL_BUS,
  CLASS_WIRELESS,
  CLASS_INTELLI_IO,
  CLASS_SATELLITE_COMM,
  CLASS_ENCRYPTION,
  CLASS_DASPC, //data acquisition and signal processing controllers
  CLASS_SPAWN_OF_DEATH=0xff
};

//makes packed subclass integer
#define SC(cls, subclass, progif) ((cls) | ((subclass)<<8) | ((progif)<<16))

enum {
  NOT_VGA = SC(0x00, 0x00, 0x00),
  IS_VGA = SC(0x00, 0x01, 0x00),
  
  //storage
  SCSI_BUS = SC(0x01, 0x00, 0x00),
  IDE_CTRL = SC(0x01, 0x01, 0x01), //profif is. .. undefined for ide_ctrl?
  FLOPPY = SC(0x01, 0x02, 0x00),
  RAID = SC(0x01, 0x04, 0x00),
  ATA_SINGLE = SC(0x01, 0x05, 0x20),
  ATA_CHAINED = SC(0x01, 0x05, 0x30),
  ATA_NONSTANDARD = SC(0x01, 0x06, 0x00),
  ATA_STANDARD = SC(0x01, 0x06, 0x01),
  SAS_SCSI = SC(0x01, 0x07, 0x00),
  MASS_STORAGE_OTHER = SC(0x01, 0x80, 0x00),
  
  //networking
  ETHERNET = SC(0x02, 0x00, 0x00),
  TOKENRING = SC(0x02, 0x01, 0x00),
  FDDI = SC(0x02, 0x02, 0x00),
  ATM = SC(0x02, 0x03, 0x00),
  ISDN = SC(0x02, 0x04, 0x00),
  WorldFip = SC(0x02, 0x05, 0x00),
  PICMG214 = SC(0x02, 0x06, 0x00),
  NETWORK_OTHER = SC(0x02, 0x80, 0x00),

  VGA_COMPAT = SC(0x03, 0x00, 0x00),
  V8512_COMPAT = SC(0x03, 0x00, 0x01),
  XGA = SC(0x03, 0x01, 0x00),
  VCTRL3D = SC(0x03, 0x02, 0x00), //3d controller (not vga compatible)
  DISPLAY_OTHER = SC(0x03, 0x80, 0x00)
};

typedef struct MemoryBAR {
  bit always_zero:1;
  bit type:2;
  bit prefetchable:1;
  bit byte16_base_addr:28; //16-byte aligned base address
} MemoryBAR;

typedef struct IoBAR {
  bit always_zero:1;
  bit reserved:1;
  bit byte4_base_addr:30; //4-byte aligned base address
} IoBAR;

#pragma GCC diagnostic ignored "-Wpadded"
typedef struct PCICommandRegister {
  bit space_io:1;
  bit space_memory:1;
  bit master_bus:1;
  bit special_cycles:1;
  bit enable_mem_write_and_invalidate:1;
  bit vga_palette:1;
  bit parity_error_response:1;
  bit reserved:1;
  bit SERR_enable:1;
  bit fast_back2back_enable:1;
  bit interrupt_disable:1;
  bit reserved2:5;
} PCICommandRegister;

#pragma GCC diagnostic ignored "-Wpadded"
typedef struct PCIStatusRegister {
  bit reserved:3;
  bit interruprt:1;
  
  bit capabilities_list:1;
  bit mhz66_capable:1;
  bit reserved2:1;
  bit fast_back2back_complete:1;
  
  bit master_data_parity_error:1;
  bit devsel_timing:2;
  bit signaled_target_abort:1;
  
  bit received_target_abort:1;
  bit received_master_abort:1;
  bit signaled_system_error:1;
  bit detected_parity_error:1;
} PCIStatusRegister;

#pragma GCC diagnostic ignored "-Wpadded"
typedef struct BIST {
  bit code_complete:4;
  bit reserved:2;
  bit startBIST:1;
  bit BISTcapable:1;
} BIST;

typedef struct VendorRegister {
  bit vendor_id:16;
  bit device_id:16;
} VendorRegister;

typedef struct CommandStatusRegister {
  bit command:16;
  bit status:16;
} CommandStatusRegister;

typedef struct ClassInfoRegister {
  bit revisionid:8;
  bit progif:8;
  bit subclass:8;
  bit class_code:8;
} ClassInfoRegister;

//has header type!
typedef struct HeaderRegister {
  bit cache_line_size:8;
  bit latency_timer:8;
  bit header_type:8;
  bit BIST:8;
} HeaderRegister;

typedef struct PCIFieldsH02 { //cardbus-to-pci bridge
  VendorRegister id;
  CommandStatusRegister command;
  ClassInfoRegister classinfo;
  HeaderRegister header;

  uint32_t cardbus_socket;
  
  struct {
    bit capabilities_offset:8;
    bit reserved:8;
    bit secondardy_status:16;
  } capabilities;
  
  struct {
    bit pci_bus_number:8;
    bit cardbus_bus_number:8;
    bit subordinate_bus_number:8;
    bit cardbus_latency_number:8;
  } cardbus;
  
  uint32_t bar0;
  uint32_t memory_limit0;
  uint32_t bar1;
  uint32_t memory_limit1;
  uint32_t iobase0;
  uint32_t iolimit0;
  uint32_t iobase1;
  uint32_t iolimit1;
  
  struct {
    bit irq_line:8;
    bit irq_pin:8;
    bit bridge_control:16;
  } irq;
  
  struct {
    bit subsys_id:16;
    bit subsys_vendor_id:16;
  } subsystemid;
  
  uint32_t pccard16_legacy_base_address;
} PCIFieldsH02;

typedef struct PCIFieldsH01 { //pci-to-pci bridge
  VendorRegister id;
  CommandStatusRegister command;
  ClassInfoRegister classinfo;
  HeaderRegister header;
  
  uint32_t bar0; //base address 0
  uint32_t bar1;
  
  struct {
    bit primary_bus_number:8;
    bit secondary_bus_number:8;
    bit subordinate_bus_number:8;
    bit secondary_latency_timer:8;
  } businfo;
  
  struct {
    bit io_base:8;
    bit io_limit:8;
    bit secondary_status:16;
  } io;
  
  struct {
    bit membase:16;
    bit memlimit:16;
  } memory;
  
  struct {
    bit membase:16;
    bit memlimit:16;
  } prefetch_memory;
  
  uint32_t prefetch_base_upper32;
  uint32_t prefetch_limit_upper32;
  
  struct {
    bit io_base_upper16:16;
    bit io_limit_upper16:16;
  } io_upper;
  
  struct {
    bit pointer:8;
    bit reserved:24;
  } capabilities;
  
  uint32_t expanded_rom_base_address;
  struct {
    bit irq_line:8;
    bit irq_pin:8;
    bit bridge_control:16;
  } irq;
} PCIFieldsH01;

typedef struct PCIFieldsH00 {
  struct {
    bit vendor_id:16;
    bit device_id:16;
  } id;
  struct {
    bit command:16;
    bit status:16;
  } command;
  struct {
    bit revisionid:8;
    bit progif:8;
    bit subclass:8;
    bit class_code:8;
  } classinfo;
  struct {
    bit cache_line_size:8;
    bit latency_timer:8;
    bit header_type:8;
    bit BIST:8;
  } bist;
  
  uint32_t bar0; //base address 0
  uint32_t bar1;
  uint32_t bar2;
  uint32_t bar3;
  uint32_t bar4;
  uint32_t bar5;
  uint32_t cardbus_csis_pointer;
  
  struct {
    bit subsys_id:16;
    bit subsys_vendor_id:16;
  } subsystemid;
  
  uint32_t expansion_rom_base; //base address

  // Points to a linked list of new capabilities implemented by the device. Used if bit 
   //4 of the status register (Capabilities List bit) is set to 1. 
   //The bottom two bits are reserved and should be masked 
   //before the Pointer is used to access the Configuration Space.
  struct {
    bit reserved:24;
    bit pointer:8;
  } capabilities;
  
  uint32_t reserved;
  struct {
    bit irq_line:8;
    bit irq_pin:8;
    bit min_grant:8;
    bit max_latency:8;
  } lgpl;
} PCIFieldsH00;

#endif /* _PCI_TABLES_H */
