#include <stdio.h>

int main(int argc, char **argv) {
  int i;
  
  for (i=1; i<argc; i++) {
    FILE *file = fopen(argv[i], "rb");
    
    if (!file) {
      fprintf(stderr, "Failed to open file %s\n", argv[i]);
      return -1;
    }
    
    int ch;
    while ((ch = fgetc(file)) != EOF) {
      fputc(ch, stdout);
    }
    
    fclose(file);
  }
  
  return 0;
}
