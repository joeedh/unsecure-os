#include "process.h"
#include "task.h"

#include "../io.h"
#include "../interrupts.h"
#include "../libc/libk.h"
#include "../libc/string.h"
#include "../libc/kmalloc.h"
#include "../drivers/keyboard/keyboard.h"
#include "../drivers/tty/tty.h"

volatile unsigned int pidgen;

void process_initialize() {
  pidgen = 0;
}

//returns. . .pid?
int spawn_process(int argc, char **argv) {
  return 0;
}