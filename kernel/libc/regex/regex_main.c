#include "regex_ast.h"
#include "regex.h"

#include "reparse.h"

#include "stdio.h"
#include "stdlib.h"
#include "string.h"

int main(int argc, unsigned char **argv) {
  lexer lex;
  
  unsigned char re[] = "[a-zA-Z0-9]+[^a-zA-Z].*";
  unsigned char test[] = "0aasf3ewrewr";
  
  _re_init_lexer(&lex, re, strlen(re));
  
  Node *ast = yyparse(&lex);
  return 0;
}
