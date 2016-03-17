%define api.pure full
%param {struct lexer *lex}

%{
struct lexer;
struct Node;
#define YYSTYPE int

#include "regex_ast.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define REGEX_INTERN
#define yylex regex_yylex

extern int regex_yylex(int*, void*);
extern void node_append(struct Node *node, struct Node *child);
extern struct Node *node(int type, int value, unsigned char *fmt, ...);
%}

%token ASCII
%token ACTUALLY_ZERO
%token WORD_BREAK
%token LINE_BREAK
%token WHITE_SPACE
%token CLASS_NEGATE
%token UNICODE_BYTE

%start exp
%defines "reparse.h"

%% /* Grammar rules and actions follow */

/*codepoint*/
cp : ASCII        {$$ = node(NCHARACTER, $1, "");}
   | UNICODE_BYTE {$$ = node(NCHARACTER, $1, "");}

csetlist   : cp        {$$ = node(NCLASS, "n", $1);}
           | cset cp   {$$ = $1; node_append($1, $2);}
           
cset       : '[' csetlist ']'     {$$ = $1;}
           | '[' '^' csetlist ']' {$$ = node(NNEGATE, 0, "n", $1);}

exp:    cp         { $$ = $1;                    }
        | '*'      { $$ = node(KREPEAT0, 0, ""); }
        | '+'      { $$ = node(KREPEAT1, 0, ""); }
        | '.'      { $$ = node(KANY, 0, "");     }
        |  cset    { $$ = $1;                    }
        
%%
