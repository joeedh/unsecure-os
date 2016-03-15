#ifndef _STRING_H
#define _STRING_H

#include <stddef.h>
#include <stdint.h>
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

size_t strlen(const unsigned char* str);

static inline int strcmp(const unsigned char *a, const unsigned char *b) {
  unsigned char *c = (unsigned char*)a;
  unsigned char *d = (unsigned char*)b;
  
  while (*c && *d) {
    int delta = ((int)(*c)) - ((int)(*d));
    if (delta != 0) {
      return delta;
    }
    
    c++;
    d++;
  }
  
  return *c || *d ? (*c ? -1 : 1) : 0;
}
  
static inline int memset(void *s1, unsigned char v, size_t n) {
  size_t i = n;
  unsigned char *c1 = (unsigned char*) s1;
  
  while (i > 0) {
    *c1 = v;
    
    c1++;
    i--;
  }
  
  return 0;
}

static inline int smemset(unsigned short *c1, unsigned short v, size_t n) {
  size_t i = n;
  
  while (i > 0) {
    *c1 = v;
    
    c1++;
    i--;
  }
  
  return 0;
}

static inline int smemcpy(unsigned short *c1, unsigned short *c2, size_t n) {
  size_t i = n;
  
  while (i > 0) {
    *c1 = *c2;
    
    c1++, c2++;
    i--;
  }
  
  return 0;
}

static inline int strcpy(const unsigned char *a, const unsigned char *b) {
  unsigned char *c = (unsigned char*)a;
  unsigned char *d = (unsigned char*)b;
  
  *c = 0;
  while (*d) {
    *c++ = *d++;
  }
  *c = 0;
  
  return (unsigned int)(c - a) + 1;
}


static inline int strncpy(const unsigned char *a, const unsigned char *b, size_t b_size) {
  unsigned char *c = (unsigned char*)a;
  unsigned char *d = (unsigned char*)b;
  unsigned int i=0;
  
  *c = 0;
  while (*d && i < b_size) {
    *c++ = *d++;
  }
  *c = 0;
  
  return i;
}

static inline int memcpy(void *s1, void *s2, size_t n) {
  size_t i = n;
  unsigned char *c1 = (unsigned char*) s1;
  unsigned char *c2 = (unsigned char*) s2;
  
  while (i > 0) {
    *c1 = *c2;
    
    c1++, c2++;
    i--;
  }
  
  return 0;
}

//find last occurance of character
static size_t strcspn ( const char * str1, const char * str2 ) {
  if (!str1 || !str2) {
    return 0;
  }
  
  char *a = (char*)str1;
  size_t i = 0;
  
  while (*a) {
    char *b = (char*)str2;
    
    while (*b) {
      if (*b == *a) {
        return i;
      }
      b++;
    }
    
    i++;
    a++;
  }
  
  return i;
}

static unsigned char *strrchr(const unsigned char *str, unsigned int character) {
  unsigned char *c = (char*) str;
  unsigned char *last = c;
  
  while (*c) {
    if (*c == character) {
      last = c;
    }
    
    c++;
  }
  
  //not found?
  if (last == str) {
    return NULL;
  }
  
  return last;
}

int toupper(int c);
int tolower(int c);
int isupper(int c);
int islower(int c);
int isprint(int c);

#endif /* _STRING_H */