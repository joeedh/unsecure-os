#ifndef _KEYBOARD_H
#define _KEYBOARD_H

int keyboard_isprint(int chr);
int keyboard_handle_case(short c);
int keyboard_poll();

#endif /* _KEYBOARD_H */
