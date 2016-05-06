#ifndef _HDD_H
#define _HDD_H

#include <stddef.h>
#include <stdint.h>

typedef struct HDD {
  int addrcom, addrdata;
  int channel;
  int cylinders, tracks;
  int sectorsize;
} HDD;

void hdd_initialize();

#endif /* _HDD_H */
