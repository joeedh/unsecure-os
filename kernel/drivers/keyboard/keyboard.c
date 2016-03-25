#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif
 
#include "../../libc/string.h"
#include "keyboard.h"
#include "../../io.h"
#include "../../interrupts.h"
#include "../../libc/libk.h"
#include "../../libc/ctype.h"
#include "../../drivers/tty/tty.h"
#include "../../task/lock.h"
#include "../../task/task.h"
#include "../../task/process.h"

/*
typematic command byte:

0-5: Repeat rate (00000b = 30 Hz, ..., 11111b = 2 Hz)
5-7: Delay before keys repeat (00b = 250 ms, 01b = 500 ms, 10b = 750 ms, 11b = 1000 ms)
7-8: Must be zero
*/

enum {
  CMD_SET_TYPEMATIC_RATE = 0xF3,
  CMD_ENABLE_SCANNING  = 0xF4,
  CMD_RESTORE_DEFAULTS = 0xF6,
  CMD_MAKE_RELEASE = 0xF9
};

static Lock keyboard_lock = LOCK_INIT;

static int keyboard_handle_toggles(int c);
static int keyboard_handle_mods(int c);

enum {
  KCTRL_ERROR=0,
  KCTRL_BAT=0xaa,
  KCTRL_ECHO=0xee,
  KCTRL_REPLY=0xf1,
  KCTRL_NOPASS=0xa4,
  KCTRL_ACK=0xfa,
  KCTRL_BATERROR=0xfc,
  KCTRL_INTERN_ERROR=0xfd,
  KCTRL_RESEND=0xfe,
  KCTRL_KEYBOARD_ERROR=0xff
};

static unsigned char scancode_set2[255];
static unsigned char asciimap[255];
static unsigned char rev_scancode_set2[255];

volatile unsigned char keypress[255];
volatile unsigned int kb_modflag;
volatile unsigned int kb_toggles;

#define QUEUESIZE 1024
static volatile unsigned char kb_queue[QUEUESIZE];
volatile unsigned int kb_queue_a, kb_queue_b;

static volatile unsigned int last_command = 0;

#define KEYB_PORT 0x60

short get_raw_keycode(short code) {
  if (code < 0)
    return code;
  
  return rev_scancode_set2[code & 127] | (code & 127);
}

void keyboard_send_command(int command) {
  last_command = command;
  outb(KEYB_PORT, command);
}

volatile unsigned char _last_tty_debug_chr = 0;

volatile int _keydriver_isr0_flag = 0;

void _isr_handler1() {
  volatile unsigned int state = safe_entry();
  //interrupts_disable();
  
  volatile unsigned char code=0, lastcode=0;
  
  do {
    code = inb(KEYB_PORT);
    
    if (code == KCTRL_ACK) {
      continue;
    } else if (code == KCTRL_RESEND) {
      outb(KEYB_PORT, last_command);
      break;
    } else if (code == 0x7f) {
      //heh?
      continue;
    }
    
    keyboard_handle_mods(code);
    keyboard_handle_toggles(code);
    
    volatile unsigned char ch = code & 127;
    
    //convert code to more ascii-like codepage
    ch = scancode_set2[ch];
    
    if (code & 128) {
      code = ch | 128;
    } else {
      code = ch;
    }
    
    if (code != _last_tty_debug_chr) {
      //terminal_set_debug(DEBUG_KEY, code, COLOR_LIGHT_BLUE);
      terminal_set_idebug(DEBUG_KEY, 5, code, COLOR_LIGHT_BLUE);
      e9printf("got a key! %d\n", code);
      
      _keydriver_isr0_flag = 1;
      /*
      Task *nexttask = k_curtaskp;
      
      e9printf("nexttask: %x\n", nexttask);
      e9printf("nexttask->head: %x\n", nexttask->head);
      e9printf("stack:\n");

      unsigned int *stack = (unsigned int*) nexttask->head;
      for (int i=0; i<17; i++) {
        e9printf("%d:  %x\n", i, stack[i]);
      }
      
      //*/      
      
      _last_tty_debug_chr = code;
    }
    
    keypress[ch] = ch != code;
    
    kb_queue[kb_queue_b] = code;
    kb_queue_b = (kb_queue_b+1) & (QUEUESIZE-1);
    lastcode = code;
  } while (code != lastcode && kb_queue_b < QUEUESIZE-1);
  
  //interrupts_enable();
  safe_exit(state);
}

static int keyboard_handle_mods(int c) {
  volatile unsigned char c2 = c & 127;
  volatile int flag = 0;
  
  switch (c2) {
    case 29:
      flag = KMOD_LEFT_CTRL;
      break;
    case 91:
      flag = KMOD_LEFT_COMMAND;
      break;
    case 56:
      flag = KMOD_LEFT_ALT;
      break;
    case 42:
      flag = KMOD_LEFT_SHIFT;
      break;
    case 54:
      flag = KMOD_RIGHT_SHIFT;
      break;
  }
  
  if (flag == 0) {
    return 0;
  }
  
  if (c & 128) {
    kb_modflag &= ~flag;
  } else {
    kb_modflag |= flag;
  }
  
  return 1;
}


static int keyboard_handle_toggles(int c) {
  volatile char c2 = c & 127;
  volatile int flag = 0;
  
  switch (c2) {
    case 58:
      flag = KTOG_CAPS;
      break;
    case 69:
      flag = KTOG_NUMLOCK;
      break;
  }
  
  if (flag == 0) {
    return 0;
  }
  
  if (c & 128) {
    kb_toggles ^= flag;
  }
  
  return 1;
}

int keyboard_poll() {
  klock_lock(&keyboard_lock);
  //volatile unsigned int state = safe_entry();
  
  if (kb_queue_a != kb_queue_b) {
    volatile short ret = kb_queue[kb_queue_a];
    
    kb_queue_a = (kb_queue_a+1) & (QUEUESIZE-1);
    
    //safe_exit(state);
    klock_unlock(&keyboard_lock);
    return ret;
  }
  
  //safe_exit(state);
  
  klock_unlock(&keyboard_lock);
  return -1;
}

int keyboard_get_modflag() {
  return kb_modflag ^ (kb_toggles & ((1<<4)|(1<<5)));
}

int kb_my_isprint(int c) {
  return isprint(c) || c == '\r' || c == '\n' || c == '\t' || c == ' ';
}

int keyboard_handle_case(short c) {
  if (c < 0)
    return c;
  
  c = tolower(c & 127) | (c & 128);
  
  if ((keyboard_get_modflag() & KMOD_SHIFT)) {
    c = toupper(c & 127) | (c & 128);
  }
  
  return c;
}

short getchar_nowait() {
  volatile short c = keyboard_poll();
  
  if (c < 0 || !(c & 128) || !(kb_my_isprint(c & 127))) {
    return -1;
  }
  
  c = c & 127;
  
  if (!(keyboard_get_modflag() & KMOD_SHIFT)) {
    c = tolower(c);
  }
  
  return c;
}

unsigned char getchar() {
  volatile short c = keyboard_poll();
  
  while (c < 0 || !(c & 128) || !(kb_my_isprint(c & 127))) {
    c = keyboard_poll();
  }
  
  c = c & 127;
  
  if (!(keyboard_get_modflag() & KMOD_SHIFT)) {
    c = tolower(c);
  }
  
  return c;
}

int irq_kb(unsigned int n) {
  //kprintf("evil?\n");
  return 0;
}

void keyboard_initialize() {
  //initialize more ascii-friendly codepage

  klock_init(&keyboard_lock);
  
  kb_queue_a = kb_queue_b = 0;
  memset((void*)keypress, 0, 255);
  kb_modflag = kb_toggles = 0;
  
  for (int i=0; i<255; i++) {
    scancode_set2[i] = 0;
  }
  
#define O 5

  //flag lower-case letters as used
  //for (int i='a'; i<='z'; i++) {
  //  scancode_set2[i] = 1;
  //}
  
  scancode_set2[43] = '\\';
  
  const char *line1 = "QWERTYUIOP[]";
  for (int i=16; i<28; i++) {
    scancode_set2[i] = line1[i-16];
  }
  
  const char *line2 = "ASDFGHJKL;'";
  for (int i=30; i<41; i++) {
    scancode_set2[i] = line2[i-30];
  }
  
  const char *line3 = "ZXCVBNM,./";
  for (int i=44; i<54; i++) {
    scancode_set2[i] = line3[i-44];
  }
  
  const char *line4 = "1234567890-=";
  for (int i=2; i<14; i++) {
    scancode_set2[i] = line4[i-2];
  }
  
  scancode_set2[41] = '`';
  
  scancode_set2[15] = '\t';
  scancode_set2[28] = '\n';
  scancode_set2[57] = ' ';
  
  //return;
  
  for (int i=0; i<255; i++) {
    if (scancode_set2[i])
      asciimap[scancode_set2[i]] = 1;
  }
  
  unsigned char bitmap[255];
  memset(bitmap, 0, 255);
  
  for (int i=0; i<255; i++) {
    //a reverse map
    if (scancode_set2[i]) {
      bitmap[scancode_set2[i]] = 1;
    }
  }
  
  //re-map overwritten codes
  for (int i=0; i<127; i++) {
    if (!scancode_set2[i]) {
      
      for (int j = 0; j<127; j++) {
        int j2 = (i + j) % 127;
        
        if (bitmap[j2] == 0) {
            scancode_set2[i] = j2;
            bitmap[j2] = 1;
            break;
        }
      }
    }
  }
  
  for (int i=1; i<127; i++) {
    rev_scancode_set2[scancode_set2[i]] = i;
  }
}

void keyboard_post_irq_enable() {
  //clear any keyboard irq backlogs
  unsigned short lastcode = 0;
  unsigned int count = 0;
  unsigned short code;
  
  keyboard_send_command(CMD_RESTORE_DEFAULTS);
  io_wait();
  
  for (int i=0; i<50; i++) {
    code = inb(0x60);
    
    if (code == lastcode && code == 0xFA) {//ack
      break;
    }
    
    if (code != lastcode && i > 0) {
      e9printf("KBIRQPOST:  %d: got code: %x\n", count, code);
      lastcode = code;
      count = 0;
    }
    
    count++;
  }
  
  e9printf("KBIRQPOST2: %d: got code: %x\n", count, code);
  lastcode = code;
  count = 0;
}

int keyboard_isprint(int chr) {
  if (chr < 0) return 0;
  
  chr = chr & 127;
  return asciimap[chr] && (chr < 'a' || chr > 'z');
}

int keyboard_toascii(int chr) {
  return scancode_set2[chr];
}
