#include <stdio.h>

int main(int argc, char **argv) {
  int i;
  
  for (i=1; i<argc; i++) {
    if (i > 0) {
      printf(" ");
    }
    
    printf("%s", argv[i]);
  }
  
  printf("\n");
  
  return 0;
}
