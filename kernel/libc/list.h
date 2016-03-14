#ifndef _LIST_H
#define _LIST_H

typedef struct Link {
  struct Link *next, *prev;
} Link;

typedef struct LinkNode {
  struct LinkNode *next, *prev;
  volatile void *data;
} LinkNode;

typedef volatile struct List {
  void *first, *last;
} List;

void klist_append(List *list, void *vitem);
void klist_prepend(List *list, void *vitem);
void klist_remove(List *list, void *vitem);
void *klist_pophead(List *list);
void *klist_pop(List *list);
  
//vitem is put *before* vprev
void klist_insert(List *list, void *vitem, void *vprev);
void klist_freelist(List *list);

#endif /* _LIST_H */
