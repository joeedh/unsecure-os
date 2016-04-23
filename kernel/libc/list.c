#include "string.h"
#include "list.h"

#ifdef __KERNEL_BUILD__
#include "kmalloc.h"
#endif

void klist_append(List *list, void *vitem) {
  Link *item = vitem;
  
  item->next = item->prev = NULL;
  
  if (!list->first) {
    list->first = list->last = item;
  } else {
    ((Link*)list->last)->next = item;
    item->prev = list->last;
    list->last = item;
  }
}

void klist_prepend(List *list, void *vitem) {
  Link *item = vitem;
  
  item->next = item->prev = NULL;
  
  if (!list->first) {
    list->first = list->last = item;
  } else {
    ((Link*)list->first)->prev = item;
    item->next = list->first;
    list->first = item;
  }
}

void klist_remove(List *list, void *vitem) {
  Link *item = vitem;
  
  if (item->next)
    item->next->prev = item->prev;
  if (item->prev) 
    item->prev->next = item->next;
  if (item == list->first)
    list->first = item->next;
  if (item == list->last)
    list->last = item->prev;
}

void *klist_pophead(List *list) {
  if (list->first == NULL) {
    return NULL;
  }
  
  Link *link = list->first;
  
  list->first = ((Link*)list->first)->next;
  ((Link*)list->first)->prev = NULL;
  
  return link;
}

void *klist_pop(List *list) {
  if (list->last == NULL) {
    return NULL;
  }
  
  Link *link = list->last;
  
  list->last = ((Link*)list->last)->prev;
  ((Link*)list->last)->next = NULL;
  
  return link;
}

//vitem is put *before* vprev
void klist_insert(List *list, void *vitem, void *vprev) {
  Link *item = vitem, *prev = vprev;
  
  item->next = item->prev = NULL;
  
  if (prev->prev) {
    prev->prev->next = item;
  } else {
    list->first = item;
  }
  
  item->next = prev;
  prev->prev = item;
}

void klist_freelist(List *list) {
  Link *node, *node2;
  
  for (node=list->first; node; node=node2) {
    node2 = node->next;
    
    kfree(node);
  }
  
  list->first = list->last = NULL;
}
