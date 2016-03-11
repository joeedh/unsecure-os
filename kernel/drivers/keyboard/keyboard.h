#ifndef _KEYBOARD_H
#define _KEYBOARD_H

void keyboard_initialize();
void keyboard_post_irq_enable();

int keyboard_get_modflag();
short keyboard_poll();

unsigned char getchar();

typedef struct KeyEvent {
  short charcode;
  unsigned char  keycode, pressed;
  int modifiers;
} KeyEvent;

enum {
   KTOG_CAPS = (1<<4)|(1<<5),
   KTOG_SCROLL = (1<<1),
   KTOG_NUMLOCK = (1<<2)
};

enum {
  KMOD_RIGHT_CTRL = (1<<0),
  KMOD_LEFT_CTRL = (1<<1),
  KMOD_RIGHT_ALT = (1<<2),
  KMOD_LEFT_ALT = (1<<3),
  KMOD_RIGHT_SHIFT = (1<<4),
  KMOD_LEFT_SHIFT = (1<<5),
  KMOD_RIGHT_COMMAND = (1<<6),
  KMOD_LEFT_COMMAND = (1<<7),
  KMOD_RIGHT_MENU = (1<<8),
  KMOD_LEFT_MENU = (1<<9),
  
  KMOD_CTRL = (1<<0)|(1<<1),
  KMOD_ALT = (1<<2)|(1<<3),
  KMOD_SHIFT = (1<<4)|(1<<5),
  KMOD_COMMAND = (1<<6)|(1<<7),
  KMOD_MENU = (1<<8)|(1<<9),
};

#endif /* _KEYBOARD_H */