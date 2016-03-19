#ifndef _STRING_H
#define _STRING_H

#include <stddef.h>
#include <stdint.h>
 
/* Check if the compiler thinks we are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

size_t strlen(const unsigned char* str);

static inline int memcmp(void *va, void *vb, size_t size) {
  unsigned char *a = va, *b = vb;
  
  for (size_t i=0; i<size; i++, a++, b++) {
    if (*a > *b)
      return 1;
    else if (*a < *b)
      return -1;
  }
  
  return 0;
}

//for sake of security, will never return greater than buflen-1
static inline size_t strnlen(const unsigned char* str, size_t buflen) {
  unsigned int i;
  
  for (i=0; i<buflen; i++) {
    if (!str[i])
      return i;
  }
  
  return buflen-1;
}

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
  
static inline int memset(volatile void *s1, unsigned char v, size_t n) {
  size_t i = n;
  volatile unsigned char *c1 = (volatile unsigned char*) s1;
  
  while (i > 0) {
    *c1 = v;
    
    c1++;
    i--;
  }
  
  return 0;
}

static inline int smemset(unsigned short *c1, unsigned short v, size_t n) {
  if (!n)
    return 0;

  size_t i = n;
  
  while (i > 0) {
    *c1 = v;
    
    c1++;
    i--;
  }
  
  return 0;
}

static inline int smemcpy(unsigned short *c1, unsigned short *c2, size_t n) {
  if (!n)
    return 0;
  
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
  if (!n)
    return 0;
  
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

//find first occurance of character
static size_t strcspn ( const char * str1, const char * str2 ) {
  if (!str1 || !str2) {
    return 0;
  }
  
  unsigned char *a = (unsigned char*)str1;
  size_t i = 0;
  
  while (*a) {
    unsigned char *b = (unsigned char*)str2;
    
    while (*b) {
      if (*b == *a) {
        return i;
      }
      
      b++;
    }
    
    i++, a++;
  }
  
  return i;
}

static size_t strspn ( const char * str1, const char * str2 ) {
  if (!str1 || !str2) {
    return 0;
  }
  
  unsigned char *a = (unsigned char*)str1;
  size_t i = 0;
  int ok = 0;
  
  while (*a) {
    unsigned char *b = (unsigned char*)str2;
    
    ok = 0;
    while (*b) {
      if (*b == *a) {
        ok = 1;
        break;
      }
      
      b++;
    }
    
    if (!ok) {
      break;
    }
    i++, a++;
  }
  
  return i;
}

static unsigned char *strcat(unsigned char *a, unsigned char *b) {
  int len = strlen(a);
  a += len;
  
  while (*b) {
    *a++ = *b++;
  }
  
  *a = 0;
  return a;
}

//non-starndard function
static inline int iswhitespace(int c);

static unsigned char *strtrim(const unsigned char *str) {
  char *c = (unsigned char*) str;
  
  while (*c && iswhitespace(*c)) {
    c++;
  }
  
  int end = strlen(c)-1;
  
  while (end >= 0 && iswhitespace(c[end])) {
    end--;
  }
  
  if (!iswhitespace(c[end])) {
    end++;
  }
  
  c[end] = 0;
  return c;
}

//find last occurance of character
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

static inline int iswhitespace(int c) {
  return c == ' ' || c == '\t' || c == '\n' || c == '\r' || c == '\v';
}

#endif /* _STRING_H */
