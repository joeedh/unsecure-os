#ifndef _KEYBOARD_H
#define _KEYBOARD_H

void keyboard_initialize();
void keyboard_post_irq_enable();

short keyboard_handle_case(short c);

int keyboard_isprint(int chr);
int keyboard_toascii(int chr);

int keyboard_get_modflag();

short keyboard_poll();
short get_raw_keycode(short code);

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

enum {
  KEY_LEFT = 0x6e,
  KEY_RIGHT = 0x70,
  KEY_UP = 0x6b,
  KEY_DOWN = 0x73,
  KEY_RIGHT_SHIFT = 0x2a,
  KEY_LEFT_SHIFT = 0x3a,
  KEY_CTRL = 0x1d,
  KEY_ALT = 0x3e,
  KEY_ENTER = 0xa,
  KEY_DELETE = 0x76,
  KEY_BACKSPACE = 0xe,
  KEY_TAB = 0xf,
  KEY_SPACE = 0x20,
  KEY_CAPSLOCK = 0x3f,
  KEY_NUMLOCK = 0x68
};

#endif /* _KEYBOARD_H */