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

#include "hdd.h"

void hdd_initialize() {
  e9printf("Initializing HDDs. . .\n");
}
