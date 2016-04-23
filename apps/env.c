#include <stddef.h>
#include "stdlib.h"
#include "stdio.h"
#include "string.h"
#include "unistd.h"
#include "dirent.h"

int main(int argc, char **argv) {
  extern char **environ;
  int i=0;
  
  while (environ[i]) {
    printf("%s\n", environ[i]);
    i++;
  }
  
  return 0;
}
