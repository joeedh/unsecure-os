#include <stdint.h>

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"

int kcli_main(int argc, char **argv) {
  kprintf("> ");
  terminal_flush();
  
  while (1) {
    short ch = getchar_nowait();
    
    if (ch > 0) {
      terminal_putchar(((unsigned char)ch) & 127);
      
      if (ch == '\n') {
        kprintf("> ");
      }
      terminal_flush();
    }
    
    
    //task_sleep(5);
  }
}
