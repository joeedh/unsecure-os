//t -- for testing thing

#include <stdio.h>
#include <stdlib.h>

#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>

#include <time.h>

#include "sys/stat.h"
#include "spawn.h"

extern int ktesterfunc(int arg);

int test_console() {
  //save screen
  fputc(27, stdout);
  fputc('[', stdout);
  fputc('?', stdout);
  fputc('4', stdout);
  fputc('7', stdout);
  fputc('h', stdout);
  
  //clear screen
  fputc(27, stdout);
  fputc('[', stdout);
  fputc(2, stdout);
  fputc('J', stdout);
  fflush(stdout);
  
  //restore screen
  fputc(27, stdout);
  fputc('[', stdout);
  fputc('?', stdout);
  fputc('4', stdout);
  fputc('7', stdout);
  fputc('l', stdout);
  
  return 0;
}

static inline unsigned int read_esp(void)
{
    unsigned int val;
    __asm__ volatile ( "mov %%esp, %0" : "=r"(val) );
    return val;
}

int main(int argc, char **argv) {
  int ret;
  
  volatile int i = 1;
  
  uint32_t stack = read_esp();
  e9printf("pre-div-by-zero stack: %x\n", stack);
  
  //test divide by zero
  i /= 0;
  printf("div by zero result: %d", i);
  
  /*
  if (argc > 1) {
    printf("%s\n", argv[1]);
    printf("%d\n", atoi(argv[1]));
  } else {
    printf("%d\n", clock());
  }*/
  
  //printf("yay, test!\n");
  //ret = ktesterfunc(11);
  //printf("ktesterfunc ret: %d\n", ret);
  
  //test_console();
  
  return 0;
}
