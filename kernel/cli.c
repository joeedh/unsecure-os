#include <stdint.h>
#include "libc/stdio.h"
#include "libc/kmalloc.h"

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"
#include "task/process.h"

int ls_test_command(int argc, char **argv) {
  Process *self = process_get_current();
  int fd = process_get_stdout(self);
  FILE _file = {fd}, *stdout = &_file;
  
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  fprintf(stdout, "Yay! Test!\nLs!\n");
  
  return 0;
}

int kcli_finish(int retval, int tid, int pid) {
  kprintf("pid: %d\n", pid);
  Process *p = process_from_pid(pid);
  if (p) {
    process_close(p);
  }
  
  return 0;
}

int kcli_exec(char *name, int argc, char **argv, int (*main)(int argc, char **argv), int wait) 
{
  Process *proc = spawn_process(name, argc, argv, main);
  Process *self = process_get_current();
  
  process_set_stdin(proc, process_get_stdin(self));
  process_set_stdout(proc, process_get_stdout(self));
  process_set_stderr(proc, process_get_stderr(self));
  
  if (!wait) {
    process_set_finish(proc, kcli_finish);
  }
  
  process_start(proc);
  
  if (wait) {
    process_wait(proc);
    process_close(proc);
  }
  
  return 0;
}

#define MAX_OUT 2048

//modifies/splits line
int shlex_parse(char *line, char *outbuf[MAX_OUT]) {
  int n=0, argc=0;
  
  while ((n = strcspn(line, " \t\n\r\""))) {
    outbuf[argc++] = line;
    
    line[n] = 0;
    line += n+1;
  }
  
  if (*line)
    *line = 0;
  
  return argc;
}

int kcli_main(int argc, char **argv) {
  //int *nullptr = 0x1;
  //*nullptr = 0x0; 
  //kprintf(":%d\n", *nullptr);
  
  unsigned char commandbuf[2048];
  int commandlen = 0;
  
  kprintf(" argc: %x, argv: %x\n", (unsigned int)argc, (unsigned int)argv);
  //kprintf(" stdout: %d\n\n", process_get_stdout());
  Process *proc = process_get_current();
  kprintf("  proc: %x\n", proc);
  kprintf("stdout: %x\n", process_get_stdout(proc));
  
  FILE _file = {proc->stdout};
  FILE *stdout = &_file;
  
  kprintf("> ");
  fprintf(stdout, "YAY!\n");
  unsigned char buf[32];
  
  int count = fread(buf, sizeof(buf), 1, stdout);
  kprintf("count: %d\n",  count);
  buf[count] = 0;
  kprintf("buf: '%s'\n", buf);

  count = fread(buf, sizeof(buf), 1, stdout);
  kprintf("count: %d\n",  count);
  buf[count] = 0;
  kprintf("buf: '%s'\n", buf);
  
  terminal_flush();
  
  while (1) {
    int printcode;
    int hadcode = 0;
    
    while ((printcode = fgetc(stdout)) > EOF) {
      if (printcode != EOF) {
        terminal_putchar(printcode);
        hadcode = 1;
      }
    }
    
    if (hadcode) {
      terminal_flush();
    }
    
    short code = keyboard_poll(); //getchar_nowait();
    
    if (code > 0 && (code&128) == 0) {
      //kprintf(" %x             %x\n", code & 127, get_raw_keycode(code) & 127); 
      //terminal_flush();
    }
    
    if (code > 0 && !(code & 128)) {
      char ch = code & 127;
      
      if (keyboard_isprint(ch) || ch == '\n' || ch == '\r' || ch == '\t') {
        ch = keyboard_handle_case(ch);
        
        fputc(ch, stdout);
        //terminal_putchar(((unsigned char)ch) & 127);
        if (ch == '\n') {
          fprintf(stdout, "> ");
          //kprintf("> ");
        }
        
        if (ch == '\n' || ch == '\r') {
          commandbuf[commandlen] = 0;
          
          if (commandlen > 0 && !strcmp(commandbuf, "ls")) {
            char **argv = kmalloc(sizeof(char*)*MAX_OUT);
            int argc = shlex_parse(commandbuf, argv);
            fprintf(stdout, "\n");
            kcli_exec(commandbuf, argc, argv, ls_test_command, 1);
            fprintf(stdout, "> ");
          }
          
          commandlen = 0;
        } else {
          commandbuf[commandlen++] = ch;
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
