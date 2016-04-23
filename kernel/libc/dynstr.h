#ifndef _DYNSTR_H
#define _DYNSTR_H

#define s_concat(a, b) (a = _s_concat(a, b))
#define s_putchar(a, chr) (a = _s_putchar(a, chr))

#define s_new() NULL
#define s_len _s_len
#define s_free _s_free
#define s_cpy(a, b) (a = _s_cpy(a, b))
#define s_dup(a) (_s_dup(a))
#define s_reset(a) (a = _s_reset(a))
#define s_reserve(a, size) (a = _s_reserve(a, size))

char *_s_concat(char *a, const char *b);
char *_s_putchar(char *a, char b);
int _s_len(char *a);
void _s_free(char *a);
char *_s_cpy(char *a, const char *b);
char *_s_dup(const char *a);
char *_s_reset(char *a);
char *_s_reserve(char *a, int size);

#endif /* _DYNSTR_H */
