#ifndef _REGEX_AST_H
#define _REGEX_AST_H

struct Node;
typedef struct Node {
  int type, value;
  int length, totalloc;

  struct Node *parent;
  struct Node **children;
  int cur, stateid, index;
} Node;

enum {
  NCHARACTER,
  NCLASS,
  NGROUP,
  NWORDBREAK,
  NNEGATE,
  NANY,
  NREPEAT0,
  NREPEAT1,
  NLIST
};


#endif /* _REGEX_AST_H */
