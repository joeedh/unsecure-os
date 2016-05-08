#include <stdio.h>

extern void task_yield();

int interactive() {
  while (1) {
    int ch = fgetc(stdin);
    
    if (ch < 0) //no data
      continue;
      
    if (ch == 0x04) { //ctrl-d
      break;
    }
    
    task_yield();
  }
  
  return 0;
}

int main(int argc, char **argv) {
  int i;
  
  if (argc < 2) {
    return interactive();
  }
  
  for (i=1; i<argc; i++) {
    FILE *file = fopen(argv[i], "rb");
    
    if (!file) {
      fprintf(stderr, "Failed to open file %s\n", argv[i]);
      return -1;
    }
    
    int ch, i=0;
    while ((ch = fgetc(file)) != EOF) {
      if (ch != '\r') {
        fputc(ch, stdout);
      }
      
      i++;
      if (i > 512) {
        task_yield();
        i = 0;
      }
    }
    
    fclose(file);
  }
  
  return 0;
}
