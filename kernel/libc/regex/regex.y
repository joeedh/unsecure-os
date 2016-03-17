%define api.pure full
%param {struct lexer *lex}

%{
struct lexer;
struct Node;
#define YYSTYPE void*

#include "regex_ast.h"
#include "regex.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define REGEX_INTERN
#define yylex regex_yylex

//extern int regex_yylex(int*, void*);
extern void *_re_node_append(struct Node *node, struct Node *child);
extern struct Node *_re_make_node(int type, int value, unsigned char *fmt, ...);

#define node_append _re_node_append
#define node _re_make_node 
%}

%token ASCII
%token ACTUALLY_ZERO
%token WORD_BREAK
%token LINE_BREAK
%token WHITE_SPACE
%token CLASS_NEGATE
%token UNICODE_BYTE

%start start
%defines "reparse.h"

%% /* Grammar rules and actions follow */

/*codepoint*/
cp : ASCII        {$$ = node(NCHARACTER, $1, "");}
   | UNICODE_BYTE {$$ = node(NCHARACTER, $1, "");}

csetlist   : cp           {$$ = node(NCLASS, "nnn", $1, $1, $1);}
           | csetlist cp  {$$ = $1; node_append($1, $2);}
           
cset       : '[' csetlist ']'     {$$ = $2;}
           | '[' '^' csetlist ']' {$$ = node(NNEGATE, 0, "n", $3);}

exp_base: cp           { $$ = $1;                      }
         | '.'        { $$ = node(NANY, 0, "");       }
         | WORD_BREAK { $$ = node(NWORDBREAK, 0, ""); }
         | cset       { $$ = $1;}

exp  : exp_base     {$$ = $1;}
     | exp_base '*' {$$ = node(NREPEAT0, 0, "n", $1);}
     | exp_base '+' {$$ = node(NREPEAT1, 0, "n", $1);}
     | exp exp_base { if (((Node*)$1)->type == NLIST) $$ = node_append($1, $2);
                      else $$ = node(NLIST, 0, "nn", $1, $2);
                    }
start : exp {lex->result = $1; $$ = $1;}
%%
