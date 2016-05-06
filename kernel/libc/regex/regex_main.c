#include "regex_ast.h"
#include "regex.h"

#include "reparse.h"

#include "stdio.h"
#include "stdlib.h"
#include "string.h"

static FILE *table_out = NULL;

typedef struct params {
  int lexpos;
  int lexsize;
  unsigned char *lexdata;
  struct State *states;
  int totstate, totalloc;
} params;

typedef struct State {
  short link[255];
  char advance[255];
  int id, type, index;
  Node *node;
  char *name;
} State;

void print_table(State *state, FILE *file) {
  if (!print_table) {
    fprintf(stderr, "state was null!\n");
    fflush(file);
    return;
  }
  
  fprintf(file, "\n=== %d: %s ===\n\t", state->index, state->name);
  fflush(file);
  
  for (int i=0; i<127; i++) {
    if (i != 0 && (i % 25)==0) {
      fprintf(file, "\n\t");
    }
    
    fprintf(file, "%d ", (int)state->link[i]);
    fflush(file);
  }
  
  fprintf(file, "\n");
  fflush(file);
}

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
  state->index = p->totstate;
  
  //we purposefully start state id's at 1
  state->id = p->totstate;
  p->totstate++;
  
  return state;
}

Node *n_next(Node *node) {
  Node *n;
  int i, j;
  
  if (!node)
    return NULL;
  
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
    return n_next(n);
  }
  
  return n;
  /*if (n && n->type == NLIST) {
    return n->length > 0 ? n->children[0] : NULL;
  } else {
    return n;
  }*/
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
    
    s->node = node;
    s->name = nodetype_to_str(node->type);
    s->type = node->type;
    int advance = get_advance(node->type);
    
    memset(s->advance, advance, 255);
    node->stateid = s->id;
  }
  
  return p->states + node->stateid;
}

static int n_get_id(Node *node, params *p) {
  if (!node)
    return 0; //exit state
  
  return n_get_state(node, p)->id;
}

static int n_next_id(Node *node, params *p) {
  Node *next = n_next(node);
  
  if (!next) {
    return 1; //end of tree
  }
  
  return n_get_id(next, p);
}

int execnode(Node *node, params *p) {
  State *state, *s2;
  Node *next = n_next(node);
  int i, j, k;
  
  switch (node->type) {
    case NCHARACTER:
      state = n_get_state(node, p);
      
      printf("ch: %d\n", n_next_id(node, p));
      state->link[node->value] = n_next_id(node, p);
      
      break;
    case NCLASS:
      state = n_get_state(node, p);
      
      printf("c: %d\n", n_get_id(next, p));
      
      for (i=0; i<255; i++) {
        state->link[i] = -1;
      }
      
      for (i=0; i<node->length; i++) {
        unsigned char code = node->children[i]->value;
        
        printf("%d: CODE: %c 0x%x\n", i, code, code);
        
        if (code == '-' && i > 0 && i < node->length-1) {
          int j, a, b, id;
          
          a = node->children[i-1]->value, b = node->children[i+1]->value;
          id = n_next_id(node, p);
          
          if (a > b) {
            int t = a; a = b; b = t;
          }
          
          for (j=a; j<=b; j++) {
            state->link[j] = id;
          }
        } else {
          state->link[code] = n_next_id(node, p);
        }
      }
      break;
    case NREPEAT0: {
      state = n_get_state(node, p);
      s2 = n_get_state(node->children[0], p);

      printf("d: %d %d %d\n", s2->id, state->id, n_next_id(node, p));
      
      for (i=0; i<255; i++) {
        state->link[i] = s2->id;
      }
      
      execnode(node->children[0], p);
      int nextid2 = n_next_id(node->children[0], p);
      
      for (i=0; i<255; i++) {
        if (s2->link[i] < 0) {
          s2->link[i] = n_next_id(node, p);
          s2->advance[i] = 0;
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
      smemset(state->link, n_next_id(node, p), 255);
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
  
  //push error state
  state_push(p);
  //push successful exit state
  state_push(p);
  
  execnode(node, p);
  
  //resolve conflicts between with repeaters
#if 0
  for (int i=2; i<p->totstate; i++) {
    State *st = p->states + i, *st2, *st3=NULL;
    int id2;
    
    if (st->type != NREPEAT0 && st->type != NREPEAT1) {
      continue;
    }
    
    id2 = n_next_id(st->node, p);
    if (id2 < 2)
      continue;
    
    st = p->states + id2 - 1;
    st2 = p->states + id2;
    
    printf("====>: %s %s\n", st->name, st2->name);
    
    for (int j=0; j<255; j++) {
      int a = st->link[j] > 0;
      int b = st2->link[j] > 0;
      int k;
      
      if (a && b) {
        //*
        if (!st3) {
          int id3;
          
          st3 = state_push(p);
          id3 = st3->id;
          
          *st3 = *st2;
          st3->id = st3->index = id3;
          
          for (k=0; k<255; k++) {
            //redirect error to repeat
            if (st3->link[k] <= 0) {
              st3->link[k] = st->id;
              st3->advance[k] = 1;
            }
          }
        }//*/
        
        printf("conflict!\n");
        st->link[j] = st3->id; //st2->link[j];
        st->advance[j] = 1;
      }
    }
  }
#endif

  unsigned char prev=0;
  unsigned char c=0;
  int i, j, state = 2;
  
  if (p->totstate == 0) {
    fprintf(stderr, "empty regexp");
    return 0;
  }
  
  printf("===========\n\n\n");
  
  for (i=0; i<p->totstate; i++) {
    printf("%s\n", p->states[i].name);
    
    for (j=0; j<255; j++) {
      if (p->states[i].link[j] < 0) {
        p->states[i].link[j] = 0;
      }
    }
    
    print_table(p->states+i, table_out);
  }
  
  printf("===========\n\n\n");
  
  Node *n = node;
  for (i=cur ? *cur : 0; i<buflen; ) {
    prev = c, c = buf[i];
    
    printf("%c next: %d, state: %d %s\n", c, p->states[state].link[c], state, p->states[state].name);
    
    if (p->states[state].advance[c]) {
      i++;
    }
    
    state = p->states[state].link[c];
    
    if (state < 2) {
      break;
    }
  }
  
  /*
  if (state > 2) {
    while (state < p->totstate) {
      printf("%c next: %d, state: %d %s\n", c, p->states[state].link[c], state, p->states[state].name);
      
      if (p->states[state].link[c] < 2) {
        state = p->states[state].link[c];
        break;
      }
      
      state++;
    }
  }
  //*/
  
  printf("TOTSTATE: %d, STATE: %d\n", p->totstate, state);
  
  /*
  switch (p->states[state].type) {
    case NREPEAT0:
    case NREPEAT1:
      return 1;
  }
  //*/
  
  if (cur) {
    *cur = i;
  }
  
  return state == 1;
}

//[asdf]+\b
int main(int argc, unsigned char **argv) {
  lexer lex;
  
  table_out = fopen("tables.txt", "w");
  
  if (argc < 2) {
    fprintf(stderr, "error: expected one argument.\n");
    return -1;
  }
  
  unsigned char re[] = "[a-x]*d1"; //[a-zA-Z0-9]+[^a-zA-Z].*";
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
    int match = execre(ast, test, strlen(test), &cur);
    printf("match: %d %d %d %d\n", match && cur == strlen(test), match, cur, strlen(test));
  }
  
  printf("test string: %s\n", test);
  fclose(table_out);
  
  return 0;
}
