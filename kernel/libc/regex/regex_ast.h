#ifndef _REGEX_AST_H
#define _REGEX_AST_H

struct Node;
typedef struct Node {
  int type, value;
  int length, totalloc;

  struct Node *parent;
  struct Node **children;
} Node;

enum {
  NCHARACTER,
  NCLASS,
  NGROUP,
  NWORDBREAK,
  NNEGATE,
  NANY,
  KREPEAT0,
  KREPEAT1
};


#endif /* _REGEX_AST_H */
