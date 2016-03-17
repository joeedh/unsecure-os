#ifndef _REGEX_H
#define _REGEX_H

typedef struct lexer {
  unsigned char *lexdata;
  int lexpos;
  int lexsize;
  int state;
  int prev;
  
  int surragate[16]; //utf8 surragate string
  int surragate_i;
  int prevstate;
} lexer;

void _re_init_lexer(lexer *lex, unsigned char *buf, int size);

#endif /* _REGEX_H */
