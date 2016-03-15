#ifndef _CTYPE_H
#define _CTYPE_H

#ifndef __KERNEL_BUILD__

int toupper(int c);
int tolower(int c);
int isupper(int c);
int islower(int c);
int isprint(int c);

#endif

#endif /* _CTYPE_H */
