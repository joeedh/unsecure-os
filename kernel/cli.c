#include <stdint.h>
#include "drivers/fs/fs_interface.h"
#include "drivers/fs/fs_file.h"
#include "drivers/fs/dirent.h"
#include "drivers/blockdevice/blockdevice.h"
#include "libc/stdio.h"
#include "drivers/fs/ioctl.h"
#include "drivers/tty/termios.h"
#include "libc/kmalloc.h"
#include "libc/path.h"
#include "loader/elfloader.h"
#include "interrupts.h"
#include "debug.h"

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"
#include "task/process.h"
#include "task/process_management.h"
#include "syscalls/syscalls.h"

#include "libc/stdlib.h"

int kcli_finish(int retval, int tid, int pid) {
  Process *p = process_from_pid(pid, 0);
  
  if (p) {
    process_close(p);
  }
  
  return 0;
}

int kcli_exec(char *name, int argc, char **argv, int (*main)(int argc, char **argv), int wait) 
{
  interrupts_enable();
  //uintptr_t addr = (uintptr_t)main;
  
  //return -1; //XXX
  
  Process *proc = spawn_process(name, argc, argv, main);
  Process *self = process_get_current(0);
  
  process_set_stdin(proc, process_get_stdin(self));
  process_set_stdout(proc, process_get_stdout(self));
  process_set_stderr(proc, process_get_stderr(self));
  
  //if (!wait) {
  process_set_finish(proc, kcli_finish);
  //}
  
  process_start(proc);
  
  if (wait) {
    //process_wait(proc);
    //process_close(proc);
  }
  
  return 0;
}

static int spawn_shell(FILE *stdout) {
  char buf2[256];
  char *argv[MAX_ARGV];
  char *envp[1] = {NULL};
  int pid;

  sprintf(buf2, "/bin/sh /");
  
  fprintf(stdout, "executing: %s\n\n", buf2);
  fflush(stdout);
  
  int argc = shlex((char*) buf2, argv);
  if (argc <= 0) {
    return -1;
  }

  if (posix_spawn(&pid, argv[0], NULL, NULL, argv, envp) != 0) {
    fprintf(stdout, "error executing /bin/sh!\n");
  }
  
  return 0;
}

/* map:
    1 = ctrl
    2 = shift
    3 = ctrl + shift
    4 = alt
    5 = alt + ctrl
    6 = shift + alt
    7 = ctrl + shift + alt
    8 = command
    9 = command + ctrl
   10 = command + shift
   11 = command + shift + ctrl
   12 = command + alt
   13 = command + alt + ctrl
   14 = command + alt + shift
   15 = command + alt + shift + ctrl
*/
//map bitmask (with left/right distinctions stripper out) to terminal codes
//   bitmask is calculated with equation: (!!(mod & KMOD_CTRL)) | (!!(mod & KMOD_SHIFT))<<1 | (!!(mod & KMOD_ALT))<<2 | (!!(mod & KMOD_COMMAND))<<3;
int simplified_modifier_map[] = {
  0, //0
  5, //1
  2, //2
  6, //3
  3, //4
  7, //5
  4, //6
  8, //7
  9, //8
 13, //9
 10, //10
 14, //11
 11, //12
 15, //13
 12, //14
 16, //15
};

int do_ctrl_chars(int ch) {
  switch (ch) {
    case 'd':
    case 'D':
      return 0x04;
    case 's':
    case 'S':
      return 0x13;
    case 'f':
    case 'F':
      return 0x06;
    default:
      return ch;
  }
}

int kcli_main(int argc, char **argv) {
  e9printf("Started kcli_main\n");
  
  //kprintf(" stdout: %d\n\n", process_get_stdout());
  Process *proc = process_get_current(0);
  e9printf("proc: %p\n", proc);
  
  terminal_set_userstdin(proc->stdin);
  terminal_set_userstdout(proc->stdout);
  
  //make libc wrapper of stdout/stderr
  FILE _file = {proc->stdout};
  FILE _errfile = {proc->stderr};
  FILE _stdinfile = {proc->stdin};
  
  FILE *stdout = &_file;
  FILE *stderr = &_errfile;
  FILE *stdin = &_stdinfile;
 
  debug_check_interrupts();
  
  fprintf(stdout, "stdout: %x\n", proc->stdout);
  fprintf(stderr, "stderr: %x\n", proc->stderr);
  fprintf(stdin, "stdin : %x\n\n", proc->stdin);
  
  int bufmode = BUFM_LINE, lmode = 0;
  
  ioctl(stdin->fd, TCSET_BUFM, BUFM_LINE);
  ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&lmode);
  
  //spawn shell
  spawn_shell(stdout);
  
  while (1) {
    task_yield();
    
    int printcode;
    int hadcode = 0;
    int _i=0;
    
    //flush stdout/err
    while (_i++ < 100) {
      printcode = fgetc(stderr);
      if (printcode == EOF)
        printcode = fgetc(stdout);
      
      if (printcode != EOF) {
        terminal_putchar(printcode);
        hadcode = 1;
      } else {
        break;
      }
    }
    
    //feed stdin
    _i = 0;
    short code = -1;
    
    do {
      code = keyboard_poll();
      int kmod = keyboard_get_modflag();
      
      if (code < 0)
        break;
      
      if (!(code & 128)) {
        unsigned char ch = code & 127;
        
        if (keyboard_isprint(ch) || ch == '\r' || ch == '\n' || ch == '\t') {
          ch = keyboard_handle_case(ch);
          
          e9printf("feed! ESC\n");
          if (kmod & KMOD_ALT) {
            fputc(27, stdin);
          }
          
          //handle control characters
          if (kmod && (kmod & KMOD_CTRL) == kmod) {
            char ch2 = do_ctrl_chars(ch);
            
            fputc(ch2, stdin);

            //if (isprint(ch) && (lmode & ECHO)) {
              fprintf(stdout, "^%c", ch);
            //}
          } else {
            e9printf("feed! %x\n", (int)ch);
            fputc(ch, stdin);
            
            if (lmode & ECHO) {
              fputc(ch, stdout);
            }
          }
        } else {
          char modbuf[16]={0};
          
          //calc modifier bitmask without left/right distinction
          e9printf("kmod: %d\n", kmod);
          
          int mod = (!!(kmod & KMOD_CTRL)) | ((!!(kmod & KMOD_SHIFT))<<1) | (!!(kmod & KMOD_ALT))<<2 | (!!(kmod & KMOD_COMMAND))<<3;
          mod = simplified_modifier_map[mod];
          
          if (mod == 0)
            modbuf[0] = 0;
          else
            sprintf(modbuf, "1;%d", mod);
          
          switch (ch) {
            case KEY_UP:
              fprintf(stdin, "\33[%sA", modbuf);
              break;
            case KEY_DOWN:
              fprintf(stdin, "\33[%sB", modbuf);
              break;
            case KEY_LEFT:
              fprintf(stdin, "\33[%sD", modbuf);
              break;
            case KEY_RIGHT:
              fprintf(stdin, "\33[%sC", modbuf);
              break;
            case KEY_PAGEUP:
              fprintf(stdin, "\33[5~");
              break;
            case KEY_PAGEDOWN:
              fprintf(stdin, "\33[6~");
              break;
            case KEY_BACKSPACE:
              if (mod == 0) {
                fprintf(stdin, "\x7F");
              }
              if (mod & 1) {
                fprintf(stdin, "\b");
              }
              if (mod & 4) {
                fprintf(stdin, "\33");
              }
              break;
            case KEY_DELETE:
              fprintf(stdin, "\33[%sC\b", modbuf);
              break;
          }
        }
      }
    } while (code > 0 && _i++ < 100);
    
    if (hadcode) {
      ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&bufmode);
      ioctl(stdin->fd, TCGET_LOCALFLAG, (intptr_t)&lmode);
      terminal_flush();
    }
  }
}
