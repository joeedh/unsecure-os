//t -- for testing thing

#include <stdio.h>
#include <stdlib.h>

#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>

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

int main(int argc, char **argv) {
  int ret;
  
  //printf("yay, test!\n");
  //ret = ktesterfunc(11);
  //printf("ktesterfunc ret: %d\n", ret);
  
  test_console();
  
  return 0;
}
