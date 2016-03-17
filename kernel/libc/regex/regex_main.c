#include "regex_ast.h"
#include "regex.h"

#include "reparse.h"

#include "stdio.h"
#include "stdlib.h"
#include "string.h"

typedef struct params {
  int lexpos;
  int lexsize;
  unsigned char *lexdata;
  struct State *states;
  int totstate, totalloc;
} params;

typedef struct State {
  short link[255];
  int id, type, advance;
  char *name;
} State;

void smemset(short *sbuf, short s, int len) {
  int i;
  
  for (i=0; i<len; i++) {
    *sbuf++ = s;
  }
}

static State *state_push(params *p) {
  //printf("p->totstate, p->totalloc: %d %d\n", p->totstate, p->totalloc);
  
  if (p->totstate >= p->totalloc) {
    p->totalloc = (p->totalloc+1) * 2;
    //printf("%d %p\n", sizeof(void*)*p->totalloc, p->states);
    
    p->states = !p->states ? malloc(sizeof(State)*p->totalloc) : realloc(p->states, sizeof(State)*p->totalloc);
  }
  
  State *state = p->states + p->totstate;
  memset(state, 0, sizeof(*state));
  smemset(state->link, -1, 255);
  
  state->name = p->totstate == 0 ? "exit_state" : "(unnamed)";
  
  //we purposefully start state id's at 1
  state->id = p->totstate;
  p->totstate++;
  
  return state;
}

Node *n_next(Node *node) {
  Node *n;
  int i, j;
  
  if (!node->parent)
    return NULL;
  
  n = node->parent;
  
  for (i=0; i<n->length; i++) {
    if (n->children[i] == node) {
      break;
    }
  }
  
  if (i == n->length) {
    fprintf(stderr, "corruption in n_next! %x %x\n", node, n);
    return NULL;
  }
  
  
  if (i < n->length-1) {
    n = n->children[i+1];
  } else {
    n = n->parent;
  }
  
  if (n && n->type == NLIST) {
    return n->length > 0 ? n->children[0] : NULL;
  } else {
    return n;
  }
}

static int get_advance(int type) {
  switch (type) {
    case NREPEAT0:
    case NREPEAT1:
      return 0;
    default:
      return 1;
  }
}

State *n_get_state(Node *node, params *p) {
  if (node->stateid == 0) {
    State *s = state_push(p);
    
    s->name = nodetype_to_str(node->type);
    s->type = node->type;
    s->advance = get_advance(node->type);
    
    node->stateid = s->id;
  }
  
  return p->states + node->stateid;
}

static int n_get_id(Node *node, params *p) {
  if (!node)
    return 0; //exit state
  return n_get_state(node, p)->id;
}

int execnode(Node *node, params *p) {
  State *state, *s2;
  Node *next = n_next(node);
  int i, j, k;
  
  switch (node->type) {
    case NCLASS:
      state = n_get_state(node, p);
      
      printf("c: %d\n", n_get_id(next, p));
      
      for (i=0; i<node->length; i++) {
        unsigned char code = node->children[i]->value;
        state->link[code] = n_get_id(next, p);
      }
      break;
    case NREPEAT0: {
      state = n_get_state(node, p);
      s2 = n_get_state(node->children[0], p);

      printf("d: %d %d %d\n", s2->id, state->id, n_get_id(next, p));
      
      for (i=0; i<255; i++) {
        state->link[i] = s2->id;
      }
      //smemset(state->link, s2->id, 255);
      
      execnode(node->children[0], p);
      int nextid2 = n_get_id(n_next(node->children[0]), p);
      
      for (i=0; i<255; i++) {
        if (s2->link[i] < 0) {
          s2->link[i] = n_get_id(next, p);
        } else {
          s2->link[i] = state->id;
        }
      }
      
      //node->stateid = node->children[0]->stateid;
      
      break;
    }
    case NANY:
      state = n_get_state(node, p);
      //printf("e\n");
      smemset(state->link, n_get_id(next, p), 255);
      break;
    case NLIST:
      printf("flist: %d\n", node->length);
      
      for (i=0; i<node->length; i++) {
        execnode(node->children[i], p);
      }
      break;
  }
  
  //printf("g<-\n");
}

int execre(Node *node, unsigned char *buf, int buflen, int *cur) {
  params *p = malloc(sizeof(params));
  memset(p, 0, sizeof(params));
  
  p->lexdata = buf;
  p->lexpos = cur ? *cur : 0;
  p->lexsize = buflen;
  
  //push exit state
  State *st = state_push(p);
  execnode(node, p);
  
  unsigned char prev=0;
  unsigned char c=0;
  int i, j, state = 1;
  
  if (p->totstate == 0) {
    fprintf(stderr, "empty regexp");
    return 0;
  }
  
  for (i=0; i<p->totstate; i++) {
    for (j=0; j<255; j++) {
      if (p->states[i].link[j] < 0) {
        p->states[i].link[j] = 0;
      }
    }
  }
  
  Node *n = node;
  for (i=cur ? *cur : 0; i<buflen; ) {
    prev = c, c = buf[i];
    
    if (state == 0 || p->states[state].advance) {
      printf("%c %d %d %s\n", c, p->states[state].link[c], state, p->states[state].name);
      i++;
    }
    
    state = p->states[state].link[c];
    
    if (state == 0) {
      return 0; 
      /*
      if (i != buflen) {
        fprintf(stderr, "no match.  %d %d\n", i, buflen);
        
        if (*cur)
          *cur = i;
        return 0;
      } else {
        fprintf(stdout, "it's a match!\n");
        
        if (*cur)
          *cur = i;
        return 1;
      }
      //*/
    }
  }
  
  if (state == p->totstate-1)
    return 1;
  
  if (state == 0)
    return 0;
  
  switch (p->states[state].type) {
    case NREPEAT0:
    case NREPEAT1:
      return 1;
  }
  return 0;
}

//[asdf]+\b
int main(int argc, unsigned char **argv) {
  lexer lex;
  
  if (argc < 2) {
    fprintf(stderr, "error: expected one argument.\n");
    return -1;
  }
  
  unsigned char re[] = "[ffff]*d"; //[a-zA-Z0-9]+[^a-zA-Z].*";
  unsigned char *test = argv[1];
  int token, val=0;
  
  _re_init_lexer(&lex, re, strlen(re));
  
  while (token = regex_yylex(&val, &lex)) {
    fprintf(stdout, "token: %s, value: %c\n", token_to_str(token), val);
    val = 0;
  }

  _re_init_lexer(&lex, re, strlen(re));

  if (yyparse(&lex)) {
    fprintf(stderr, "Parse error!\n");
  //  return -1;
  }
  
  Node *ast = lex.result;
  
  fprintf(stdout, "result: %x\n", ast);
  if (ast) {
    int cur = 0;
    
    print_node(ast, 0);
    printf("match: %d\n", execre(ast, test, strlen(test), &cur));
  }
  
  printf("test string: %s\n", test);
  
  return 0;
}
