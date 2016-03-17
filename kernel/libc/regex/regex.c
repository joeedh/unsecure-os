#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "regex.h"
#include "regex_ast.h"
#include "reparse.h"

/*
#ifndef REGEX_INTERN
enum {
  ASCII,
  ACTUALLY_ZERO,
  WORD_BREAK,
  LINE_BREAK,
  WHITE_SPACE,
  CLASS_NEGATE,
  UNICODE_BYTE
};

#define YYSTYPE int
#define YYLTYPE int

#endif
*/

unsigned char *token_to_str(int token) {
  #define _(n) case n: return #n;
  switch (token) {
    _(ASCII)
    _(ACTUALLY_ZERO)
    _(WORD_BREAK)
    _(LINE_BREAK)
    _(WHITE_SPACE)
    _(CLASS_NEGATE)
    _(UNICODE_BYTE)
    default:
      return token > 0 && token <= 127 ? (unsigned char*)&token : (unsigned char*)"(bad token!)";
  }
}

unsigned char *nodetype_to_str(int token) {
  #define _(n) case n: return #n;
  switch (token) {
    _(NCHARACTER)
    _(NCLASS)
    _(NGROUP)
    _(NWORDBREAK)
    _(NNEGATE)
    _(NANY)
    _(NREPEAT0)
    _(NREPEAT1)
    _(NLIST)
    default:
      return (unsigned char*)"(bad node type!)";
  }
}

enum {
  MAIN_STATE,
  ESCAPE_STATE,
  SURRAGATE_STATE
};

int my_ishex(unsigned int c) {
  int ret = c >= '0' && c <= '1';
  ret = ret || (c >= 'a' && c <= 'f');
  ret = ret || (c >= 'A' && c <= 'F');
  
  return ret;
}

int ch2hex(unsigned char c) {
  if (c >= '0' && c <= '9') {
    return c - '0';
  } else if (c >= 'A' && c <= 'F') {
    return 9 + c - 'A';
  } else if (c >= 'a' && c <= 'a') {
    return 9 + c - 'a';
  } else {
    return -1;
  }
}

int regex_state_surragate(YYSTYPE *lvalp, lexer *l) {
  if (l->surragate_i == 0) {
    l->state = l->prevstate;
    return regex_yylex(lvalp, l);
  }
  
  *lvalp = l->surragate[--l->surragate_i];
  return UNICODE_BYTE;
}

int regex_state_backslash(YYSTYPE *lvalp, lexer *l) {
  unsigned char c = l->lexdata[l->lexpos++];
  unsigned char prev = l->prev;
  l->prev = c;

  if (!c)
    return 0;
  
  switch (c) {
    case ' ':
    case '\n':
    case '\r':
    case '\t':
      l->state = MAIN_STATE;
      return regex_yylex(lvalp, l);
    case 'n':
      l->state = MAIN_STATE;
      return '\n';
    case 'r':
      l->state = MAIN_STATE;
      return '\r';
    case 't':
      l->state = MAIN_STATE;
      return '\t';
    case 'v':
      l->state = MAIN_STATE;
      return '\v';
    case '0':
      *lvalp = 0;
      l->state = MAIN_STATE;
      return ACTUALLY_ZERO;
    case 'b':
      l->state = MAIN_STATE;
      return WORD_BREAK;
    case 'u':
    case 'U': {
      int val = 0, i, j;
      
      l->prevstate = MAIN_STATE;
      l->state = SURRAGATE_STATE;
      
      for (i=0; i<4; i++) {
        c = l->lexdata[l->lexpos++];
        l->prev = c;
        
        if (!my_ishex(c)) {
          break;
        }
        
        int h = ch2hex(c);
        for (j=0; j<i; j++) {
          h *= 16;
        }
        
        val += h;
      }
      
      i=0;
      while (val > 0) {
        unsigned char d = val & 127;
        if (d != val) {
          d |= 128;
        }
        
        val >>= 7;
        l->surragate[i++] = d;
        l->surragate_i++;
      }
      
      return regex_yylex(lvalp, l);
    }
    
    default:
      l->state = MAIN_STATE;
      *lvalp = c;
      return ASCII;
  }
}

int regex_state0(YYSTYPE *lvalp, lexer *l) {
  unsigned char c = l->lexdata[l->lexpos++];
  unsigned char prev = l->prev;
  l->prev = c;
  
  //encode superascii value
  if (c > 127) {
    l->surragate[0] = (c & 127) | 128;
    l->surragate[1] = c>>7;
    l->surragate_i = 2;
    
    l->state = SURRAGATE_STATE;
    l->prevstate = MAIN_STATE;
    
    return regex_yylex(lvalp, l);
  }
  
  if (!c)
    return 0;
  
  switch (c) {
    case '^':
      if (prev != '[') {
        *lvalp = c;
        return ASCII;
      }
    case '[':
    case ']':
    case '*':
    case '.':
    case '+':
    case '(':
    case ')':
    case '-':
      *lvalp = c;
      return c;
    case '\\':
      l->state = ESCAPE_STATE;
      return regex_yylex(lvalp, l);
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      *lvalp = c;
      return ASCII;
    default:
      *lvalp = c;
      return ASCII;
  }
}

int regex_yylex(YYSTYPE *lvalp, lexer *l) {
    if (l->lexpos >= l->lexsize) {
      return 0;
    }
    
    if (!l->lexdata[l->lexpos])
      return 0;
    
    switch (l->state) {
      case 0:
        return regex_state0(lvalp, l);
      case 1:
        return regex_state_backslash(lvalp, l);
      case 2:
        return regex_state_surragate(lvalp, l);
      default:
        return 0;
    }
}

void yyerror(lexer *lex, char *msg) {
  fprintf(stdout, "Error at %d: %s\n", lex->lexpos+1, msg);
}

void *_re_node_append(Node *node, Node *child) {
  if (node->length >= node->totalloc) {
    node->totalloc = (node->totalloc + 1) * 2;
    node->children = realloc(node->children,  node->totalloc*sizeof(void*));
  }
  
  node->children[node->length] = child;
  node->length++;

  child->parent = node;
  return node;
}

Node *_re_make_node(int type, int value, unsigned char *fmt, ...) {
  Node *node = malloc(sizeof(*node));
  va_list vl;
  
  memset(node, 0, sizeof(*node));
  
  node->type = type;
  node->value = value;
  
  va_start(vl, fmt);
  unsigned char *c = fmt;
  
  for (; *c; c++) {
    switch(*c) {
      case 'n':
        _re_node_append(node, va_arg(vl, void*));
        break;
      case 'c': {
        Node *node2 = malloc(sizeof(*node2));
        memset(node2, 0, sizeof(*node2));

        node2->type = NCHARACTER;
        node2->value = va_arg(vl, int);
        _re_node_append(node, node2);
        break;
      }
      case 'b': {
        Node *node2 = malloc(sizeof(*node2));
        memset(node2, 0, sizeof(*node2));

        node2->type = NWORDBREAK;
        node2->value = va_arg(vl, int);
        _re_node_append(node, node2);
        break;
      }
      case '.': {
        Node *node2 = malloc(sizeof(*node2));
        memset(node2, 0, sizeof(*node2));

        node2->type = NANY;
        node2->value = va_arg(vl, int);
        _re_node_append(node, node2);
        break;
      }
      default:
        fprintf(stderr, "parse error in _re_make_node: %c\n", *c);
        break;
    }
  }
  
  va_end(vl);
  
  return node;
}

void print_node(Node *node, int tab) {
  int i;
  for (i=0; i<tab; i++) {
    fprintf(stdout, "  ");
  }
  
  fprintf(stdout, "%s: %c(%d) {\n", nodetype_to_str(node->type), node->value, node->value);
  
  for (i=0; i<node->length; i++) {
    print_node(node->children[i], tab + 1);
  }
  
  for (i=0; i<tab; i++) {
    fprintf(stdout, "  ");
  }
  
  fprintf(stdout, "}\n");
}

void _re_init_lexer(lexer *lex, unsigned char *buf, int size) {
  memset(lex, 0, sizeof(*lex));
  
  lex->lexdata = buf;
  lex->lexsize = size;
}

#ifndef REGEX_INTERN
int main(int argc, unsigned char **argv) {
  unsigned char re[] = "[a-zA-Z0-9]+[^a-zA-Z].*";
  unsigned char test[] = "0aasf3ewrewr";
  int token;
  
  lexer l = {
      re,
      0,
      strlen(re),
      0,
      0,
      0
  };
  
  int val=0, stack=0;
  while (token = regex_yylex(&val, &stack, &l)) {
    fprintf(stdout, "token: %s, value: %c\n", token_to_str(token), val);
    val = 0;
  }
  //value = yyparse((void*) &l);
  
  return 0;
}
#endif