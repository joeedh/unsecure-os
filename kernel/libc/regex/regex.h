#ifndef _REGEX_H
#define _REGEX_H

struct lexer;

#include "reparse.h"

struct Node;
typedef struct lexer {
  unsigned char *lexdata;
  int lexpos;
  int lexsize;
  int state;
  int prev;
  
  int surragate[16]; //utf8 surragate string
  int surragate_i;
  int prevstate;
  
  struct Node *result;
} lexer;

void _re_init_lexer(lexer *lex, unsigned char *buf, int size);
int regex_yylex(YYSTYPE *lvalp, lexer *l);

unsigned char *token_to_str(int token);
unsigned char *nodetype_to_str(int token);
void print_node(struct Node *node, int tab);

#endif /* _REGEX_H */
