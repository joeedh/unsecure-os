#include <stddef.h>
#include <stdint.h>
#include "libc/string.h"

#include "SudoBios.h"
#include "drivers/fs/fs_file.h"
#include "libc/libk.h"

int have_sbios = 0;

void SBIOS_init() {
  int file = open("/lib/SudoBios.bin", O_RDONLY);
  
  if (file < 0) {
    kprintf("Failed to load /lib/SudoBios.bin!\n");
    return;
  }  
  
  struct stat st = {0,};
  
  if (fstat(file, &st) < 0) {
    kprintf("Stat error on /lib/SudoBios.bin\n");
    return;
  }
  
  unsigned int size = st.st_size;
  unsigned char *buf = (unsigned  char*)0x2000;
  
  if (read(file, buf, size) <= 0) {
    kprintf("Error reading SBIOS\n");
    close(file);
    return;
  }
  
  close(file);
  
  have_sbios = 1;
}

//int SBIOS_CallBios(int func) {  
//}
