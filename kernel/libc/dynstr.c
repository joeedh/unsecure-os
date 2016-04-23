#include "dynstr.h"
#include "string.h"

#ifndef __KERNEL_BUILD__
  #include "stdlib.h"
#else
  #include "kmalloc.h"

  #define malloc kmalloc
  #define free kfree
#endif

typedef struct DynStr {
  int size, used;
  int magic, pad;
} DynStr;

#define DYNSTR_MAGIC 34352354

static char *s_isvalid(char *a) {
  DynStr *str = (DynStr*) a;
  
  if (!a) return NULL;
  str--;
  
  return str->magic == DYNSTR_MAGIC ? a : NULL;
}

//sets dynstr->used to size
char *_s_realloc(char *a, int size, int set_used) {
  DynStr *str, *oldstr;
  
  if (size == 0) {
    size = 1;
  }
  
  if (!a) {
    str = malloc(sizeof(DynStr) + size);
    str->magic = DYNSTR_MAGIC;
    str->size = size;
    str->used = set_used ? size : 0;
    return (char*)(str + 1);
  } else if (!s_isvalid(a)) {
    return NULL;
  }
  
  oldstr = (DynStr*) a;
  oldstr--;
  
  if (oldstr->size <= size) {
    oldstr->used = set_used ? size : oldstr->used;
    return a;
  }
  
  str = malloc(sizeof(DynStr) + size);

  str->size = size*2; //double buffering
  str->used = set_used ? size : oldstr->used;
  str->magic = DYNSTR_MAGIC;
  
  memcpy(str+1, oldstr+1, oldstr->used);
  free(oldstr);
  
  return (char*)(str+1);
}

char *_s_concat(char *a, const char *b) {
  int alen = a ? _s_len(a) : 0;
  int blen = strlen(b);
  
  int len = alen + blen + 1;
  char *ret = _s_realloc(a, len, 1);
  
  //this should overrite a's null
  memcpy(ret+alen, (char*)b, blen);
  ret[alen+blen] = 0; //right?
  
  return ret;
}

char *_s_putchar(char *a, char b) {
  int alen = a ? _s_len(a) : 0;
  
  a = _s_realloc(a, alen+2, 1);
  a[alen] = b;
  a[alen+1] = 0;
  
  return a;
}

int _s_len(char *a) {
  if (!s_isvalid(a))
    return 0;
  
  DynStr *str = (DynStr*)a;
  str--;
  
  return str->used-1;
}

char *_s_reset(char *a) {
  if (!s_isvalid(a))
    return NULL;
  
  DynStr *str = (DynStr*)a;
  str--;
  
  str->used = 0;
  a[0] = 0;
  
  return a;
}

char *_s_reserve(char *a, int size) {
  return _s_realloc(a, size, 0);  
}

void _s_free(char *a) {
  if (!s_isvalid(a))
    return;
  
  DynStr *str = (DynStr*)a;
  str--;
  
  free(str);  
  return;
}

char *_s_cpy(char *a, const char *b) {
  int len = strlen(b);
  
  a = _s_realloc(a, len+1, 1);
  memcpy(a, (char*)b, len);
  a[len] = 0;
  
  return a;
}

char *_s_dup(const char *a) {
  int len = strlen(a);
  char *ret = _s_realloc(NULL, len+1, 1);
  
  memcpy(ret, (char*)a, len);
  ret[len] = 0;
  
  return ret;
}
