#include "drivers/fs/fs_file.h"
#include "drivers/fs/fs_interface.h"
#include "drivers/blockdevice/blockdevice.h"
#include "drivers/fs/memfile.h"
#include "drivers/ext2/ext2.h"
#include "drivers/blockdevice/memblock.h"
#include "drivers/tty/tty.h"
#include "drivers/keyboard/keyboard.h"
#include "drivers/tty/tty_file.h"
#include "io.h"
#include "interrupts.h"
#include "gdt.h"

#include "drivers/fs/dirent.h"

#include "libc/string.h"
#include "libc/libk.h"
#include "libc/kmalloc.h"

#include "task/task.h"
#include "task/process.h"

typedef struct FboInfo {
  unsigned int _type; //short type, flags;
  unsigned int _size;
  
  uint64_t addr;
  uint32_t pitch, width, height;
  
  uint8_t bpp, type, reserved;
} FboInfo;

void *_bootinfo;

typedef struct infotag {
  //unsigned short type, flags;
  unsigned int type;
  unsigned int size;
} infotag;

typedef struct MemoryMap {
  unsigned int type; //short type, flags;
  unsigned int size;
  unsigned int entry_size;
  unsigned int entry_version;
} MemoryMap;

typedef struct MapEntry {
  uint64_t base_addr;
  uint64_t length;
  uint32_t type;
  uint32_t reserved;
} MapEntry;

unsigned char *maptype2str(int type) {
  switch (type) {
    case 1:
      return "RAM";
    case 3:
      return "ACPI";
    case 4:
      return "SAVE_WHEN_HIBERNATING";
    default:
      return "RESERVED/UNKNOWN";
  }
}

//loads e.g. memory map
void parse_bootinfo(void *bootinfo1) {
  //kprintf("bootinfo1: %x, bootinfo2: %x\n", ((unsigned int)bootinfo1)/1024/1024, ((unsigned int)bootinfo2)/1024/1024);
  e9printf("bootinfo1: %x\n", (unsigned int)bootinfo1);
  unsigned char *c = bootinfo1;
  unsigned int *ic = (unsigned int*)c;
  
  e9printf("total_size: %d, reserved: %x\n", *ic, *(ic + 1));
  
  c += 8;
  
  for (int i=0; i<15; i++) {
    infotag *info = (infotag*) c;
    
    e9printf("type: %d, size: %d\n", info->type, info->size);
    
    unsigned int len = info->size;
    if (len & 7)
      len += 8 - (len & 7);
    
    //parse_bootinfo
    if (info->type == 5) { //boot device info
      e9printf("Boot device info found!\n");
      ic = ((unsigned int*)(c + 8));
      
      e9printf("biosdev: %d, partition: %d, sub_partition: %d\n", ic[0], ic[1], ic[2]);
    } else if (info->type == 8) { //framebuffer info
      FboInfo *fbo = (FboInfo*) c;
      
      e9printf("fboinfo: %d %d %d %d %x\n", fbo->width, fbo->height, fbo->bpp, fbo->type, fbo->addr);
      
      extern uintptr_t vesa_origin, vesa_width, vesa_height, vesa_bpp, vesa_type;
      
      vesa_origin = (uintptr_t) fbo->addr;
      vesa_width = fbo->width;
      vesa_height = fbo->height;
      vesa_bpp = fbo->bpp;
      vesa_type = fbo->type;
      
    } else if (info->type == 6) { //memory map! yay!
      MemoryMap *map = (MemoryMap*) c;
      
      e9printf("Memory map found!! %x %x\n", map->entry_size, map->entry_version);
      
      unsigned char *d = c + 16; //sizeof(map);
      while (d-c < (int)len) {
        MapEntry *entry = (MapEntry*)d;
        e9printf("%s: base: %x, length: %x\n", maptype2str(entry->type), (unsigned int)entry->base_addr, (unsigned int)entry->length);
        
        //ignore RAM chunks of course
        if (entry->type != 1) {
          kmalloc_add_hole((unsigned int)entry->base_addr, (unsigned int)entry->length, maptype2str(entry->type));
        }
        
        d += map->entry_size;
      }
    }
    
    c += len;
  }
}
