#include <stdint.h>
#include "drivers/fs/fs_interface.h"
#include "drivers/fs/fs_file.h"
#include "drivers/fs/dirent.h"
#include "drivers/blockdevice/blockdevice.h"
#include "libc/stdio.h"
#include "libc/kmalloc.h"
#include "libc/path.h"
#include "interrupts.h"
#include "debug.h"

#include "drivers/tty/tty.h"
#include "io.h"
#include "task/task.h"
#include "libc/libk.h"
#include "libc/string.h"
#include "drivers/keyboard/keyboard.h"
#include "task/process.h"

enum {
  STATE_RUNNING = 0,
  STATE_WAITING = 1
};

static int CLI_state = 0;

int cat_test_command(int argc, char **argv) {
  Process *self = process_get_current();
  int fd = process_get_stdout(self);
  FILE _file = {fd}, *stdout = &_file;
  
  if (argc < 2) {
    fprintf(stdout, "Error: need a file path\n");
    return -1;
  }
  
  FILE *file = fopen(argv[1], "rb");
  fprintf(stdout, "file: %x\n", file);
  
  if (!file) {
    fprintf(stdout, "Error: failed to open file\n");
    return -1;
  }
  
  char buf[256];
  int read = fread(buf, sizeof(buf)-1, 1, file);
  
  fprintf(stdout, "\nread: %d\n", read);
  
  if (read > 0) {
    buf[read] = 0;
  } else {
    buf[0] = 0;
  }
  buf[sizeof(buf)-1] = 0;
  
  fprintf(stdout, "buf: %s\n", buf);
  fprintf(stdout, "\nread: %d\n", read);
  
  return !file ? -1 : 0;
}

int ls_test_command(int argc, char **argv) {
  Process *self = process_get_current();
  int fd = process_get_stdout(self);
  FILE _file = {fd}, *stdout = &_file;
  
  fprintf(stdout, "argc: %d, argv: %x\n", argc, argv);
  
  if (argc < 2) {
    fprintf(stdout, "missing argument\n");
    return -1;
  }//*/
  
  normpath(argv[1], strlen(argv[1])+1);
  
  for (int i=0; i<argc; i++) {
    fprintf(stdout, "%s ", argv[i]);
  }
  fprintf(stdout, "\n");
  
  DIR *dir = opendir(argv[1]);
  struct dirent *entry;
  
  while ((entry = readdir(dir))) {
    //kprintf("  2%s\n", entry->d_name);
    fprintf(stdout, "  %s\n", entry->d_name);
  }
  
  closedir(dir);
  
  return 0;
}

int fs_test_command(int argc, char **argv) {
  Process *self = process_get_current();
  int fd = process_get_stdout(self);
  FILE _file = {fd}, *stdout = &_file;
  
  fprintf(stdout, "\next2 test!\n\n");
  
  extern FSInterface *rootfs;
  extern BlockDeviceIF *rootdevice;
  
  fprintf(stdout, "rootfs: %x, rootdevice: %x\n", rootfs, rootdevice);
  //return 0;
  
  struct stat mstat;
  int totentries;
  
  //unsigned int state = safe_entry();
  
  rootfs->dir_entrycount(rootfs, rootdevice, 2);
  
  //safe_exit(state);
  fprintf(stdout, "fs test done!\n");
  
  totentries = rootfs->stat(rootfs, rootdevice, 2, &mstat, NULL);
  
  fprintf(stdout, "stat size: %d\n", mstat.st_msize);
  fprintf(stdout, "totentries: %d\n", totentries);

  return 0;
}

int kcli_finish(int retval, int tid, int pid) {
  //kprintf("pid: %d\n", pid);
  
  Process *p = process_from_pid(pid);
  CLI_state--;
  
  if (CLI_state < 0)
    CLI_state = 0;
  
  if (p) {
    process_close(p);
  }
  
  return 0;
}

int kcli_exec(char *name, int argc, char **argv, int (*main)(int argc, char **argv), int wait) 
{
  //uintptr_t addr = (uintptr_t)main;
  
  //return -1; //XXX
  
  Process *proc = spawn_process(name, argc, argv, main);
  Process *self = process_get_current();
  
  process_set_stdin(proc, process_get_stdin(self));
  process_set_stdout(proc, process_get_stdout(self));
  process_set_stderr(proc, process_get_stderr(self));
  
  //if (!wait) {
  process_set_finish(proc, kcli_finish);
  //}
  
  CLI_state++;
  process_start(proc);
  
  if (wait) {
    //process_wait(proc);
    //process_close(proc);
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
  
  outbuf[argc++] = 0;
  
  return argc;
}

int kcli_main(int argc, char **argv) {
  //int *nullptr = 0x1;
  //*nullptr = 0x0; 
  //kprintf(":%d\n", *nullptr);
  
  kprintf("Started kcli_main\n");
  terminal_flush();
  
  unsigned char commandbuf[2048];
  int commandlen = 0;
  
  unsigned char curworkingdir[MAX_PATH];
  curworkingdir[0] = '/';
  curworkingdir[1] = 0;
  
  //kprintf(" stdout: %d\n\n", process_get_stdout());
  Process *proc = process_get_current();
  
  FILE _file = {proc->stdout};
  FILE *stdout = &_file;
  
  kprintf("%s> ", curworkingdir);
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
  
  debug_check_interrupts();
  int laststate = CLI_state;
  
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
    
    if (CLI_state != laststate && !CLI_state) {
      fprintf(stdout, "%s> ", curworkingdir);
    }
    
    laststate = CLI_state;
    //if (CLI_state) {
    //XXX  continue;
    //}
    
    short code = keyboard_poll(); //getchar_nowait();
    
    if (code > 0 && (code&128) == 0) {
      //kprintf(" %x             %x\n", code & 127, get_raw_keycode(code) & 127); 
      //terminal_flush();
    }
    
    if (code < 0 || (code & 128)) {
      continue;
    }

    unsigned char ch = code & 127;
    
    if (keyboard_isprint(ch) || ch == '\n' || ch == '\r' || ch == '\t') {
      ch = keyboard_handle_case(ch);
      
      fputc(ch, stdout);
      //terminal_putchar(((unsigned char)ch) & 127);
      if (ch == '\n') {
        fprintf(stdout, "%s> ", curworkingdir);
        //kprintf("> ");
      }
      
      if (ch == '\n') {
        commandbuf[commandlen] = 0;
        
        if (!strcmp(commandbuf, "top")) {
          print_procs(stdout);
        } else if (!strcmp(commandbuf, "t")) {
          //*
          char **argv = kmalloc(sizeof(char*)*MAX_OUT);
          
          fprintf(stdout, "|%s|\n", commandbuf);

          argv[0] = "cat";
          argv[1] = "Readme";
          int argc = 2;
          
          kcli_exec(commandbuf, argc, argv, cat_test_command, 1);
          fprintf(stdout, "%s> ", curworkingdir);
          //*/
        } else if (commandlen > 2 && commandbuf[0] == 'c' && 
            commandbuf[1] == 'a' && commandbuf[2] == 't' && (commandbuf[3]==' '||commandbuf[3]=='\t'))
        {
          //*
          char **argv = kmalloc(sizeof(char*)*MAX_OUT);
          
          fprintf(stdout, "|%s|\n", commandbuf);

          int argc = shlex_parse(commandbuf, argv);
          
          kcli_exec(commandbuf, argc, argv, cat_test_command, 1);
          fprintf(stdout, "%s> ", curworkingdir);
          //*/
        } else if (commandlen > 2 && commandbuf[0] == 'c' && 
            commandbuf[1] == 'd' && (commandbuf[2] == ' ' || commandbuf[2] == '\t'))
        {
          char *dir = commandbuf + strcspn(commandbuf, " \t") + 1;
          dir = strtrim(dir);
          int dlen = strlen(dir)-1;
          if (dir[dlen-1] == '/') {
            dir[dlen-1] = 0;
          }
          
          fprintf(stdout, "dir argument: %d'%s'\n", strlen(dir), dir);
          
          char buf2[255];
          
          strcpy(buf2, *curworkingdir == '/' ? curworkingdir+1 : curworkingdir);
          if (buf2[strlen(buf)-1] != '/') {
            strcat(buf2, "/");
          }
          strcat(buf2, dir);
          normpath(buf2, sizeof(buf2));
          fprintf(stdout, "buf2: %s\n", buf2);
          
          DIR *dir1 = opendir(buf2);
          fprintf(stdout, "opendir ret: %x\n", dir1);
          
          if (dir1) {
            closedir(dir1);
            
            if (!strcmp(dir, "..")) {
              fprintf(stdout, "  descending\n");
              
              int len = strlen(curworkingdir);
              
              while (len >= 1 && curworkingdir[len-1] != '/') {
                curworkingdir[len-1] = 0;
                len--;
              }
              
              if (len > 0 && curworkingdir[len-1] == '/') {
                curworkingdir[len-1] = 0;
              }
              
            } else {
              if (curworkingdir[strlen(curworkingdir)-1] != '/') {
                strcat(curworkingdir, "/");
              }
              strcat(curworkingdir, dir);
            }
          } else {
            fprintf(stdout, "Error: Unknown directory %s\n", dir);
          }
          
          commandlen = 0;
          commandbuf[commandlen] = 0;
        } else if (commandlen > 0 && (!strcmp(commandbuf, "p") || !strcmp(commandbuf, "path"))) {
          unsigned char buf3[256] = "  /path/a  /b/d /";
          strcpy(buf3, "  /path/a  /b/d /");
          
          fprintf(stdout, "normpath orig  : '%s'\n", buf3);
          normpath(buf3, sizeof(buf3));
          fprintf(stdout, "normpath result: '%s'\n", buf3);
          
        } else if (commandlen > 0 && !strcmp(commandbuf, "ls")) {
          //*
          char **argv = kmalloc(sizeof(char*)*MAX_OUT);
          strcpy(commandbuf+3, curworkingdir);
          commandbuf[2] = ' ';
          
          fprintf(stdout, "|%s|\n", commandbuf);

          int argc = shlex_parse(commandbuf, argv);
          
          kcli_exec(commandbuf, argc, argv, ls_test_command, 1);
          fprintf(stdout, "%s> ", curworkingdir);
          //*/
        } else if (commandlen > 0 && !strcmp(commandbuf, "fs")) {
          char **argv = kmalloc(sizeof(char*)*MAX_OUT);
          int argc = shlex_parse(commandbuf, argv);
          
          fprintf(stdout, "\n");
          kcli_exec(commandbuf, argc, argv, fs_test_command, 1);
          fprintf(stdout, "%s> ", curworkingdir);
        } else if (!strcmp(commandbuf, "heap") || !strcmp(commandbuf, "h")) {
          test_kmalloc();
        } else if (!strcmp(commandbuf, "heap") || !strcmp(commandbuf, "c")) {
          return 0;
        } else if (!strcmp(commandbuf, "s") || !strcmp(commandbuf, "bt")) {
          stacktrace(kprintf);
          kprintf(" %x\n", get_eip());
        }
        
        commandlen = 0;
      } else {
        commandbuf[commandlen++] = ch;
      }
      
      terminal_flush();
    } else {
      //fprintf(stdout, "nonprintable key: %x\n", ch);
      
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
          break;
        case KEY_BACKSPACE:
          if (commandlen > 0) {
            commandlen--;
            commandbuf[commandlen] = 0;
            fputc(7, stdout);
          }
          break;
      }
    }
      
    terminal_reset_cursor();
    //task_sleep(5);
  }
}
