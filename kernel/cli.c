#include <stdint.h>

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"

int kcli_main(int argc, char **argv) {
  //int *nullptr = 0x1;
  //*nullptr = 0x0; 
  //kprintf(":%d\n", *nullptr);
  
  kprintf("> ");
  terminal_flush();
  
  while (1) {
    continue;
    
    short code = keyboard_poll(); //getchar_nowait();
    
    if (code > 0 && (code&128) == 0) {
      //kprintf(" %x             %x\n", code & 127, get_raw_keycode(code) & 127); 
      //terminal_flush();
    }
    
    if (code > 0 && !(code & 128)) {
      char ch = code & 127;
      
      if (keyboard_isprint(ch) || ch == '\n' || ch == '\r' || ch == '\t') {
        ch = keyboard_handle_case(ch);
        
        terminal_putchar(((unsigned char)ch) & 127);
        if (ch == '\n') {
          kprintf("> ");
        }
        
        terminal_flush();
      } else {
        switch (ch) {
          case KEY_LEFT:
            terminal_move_cursor(-1);
            break;
          case KEY_RIGHT:
            terminal_move_cursor(1);
            break;
          case KEY_ENTER:
            break;
          case KEY_DELETE:
          case KEY_BACKSPACE:
            break;
        }
      }
      
      //int ret = inb(0x3CC);
      //kprintf("%d %x %d %d", ret, ret, ret & 1, ret & 128);
      
      terminal_reset_cursor();
    }
    
    
    //task_sleep(5);
  }
}
