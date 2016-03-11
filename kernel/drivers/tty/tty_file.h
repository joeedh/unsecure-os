#ifndef _TTY_FILE_H
#define _TTY_FILE_H

struct FSFile;

void tty_file_initialize();
 
struct FSFile *tty_file_open();
void tty_file_close(struct FSFile *file);

#endif /* _TTY_FILE_H */
