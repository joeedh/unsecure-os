#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
  DIR *dir;
  struct dirent *entry;
  char path[288];
  
  printf("===Running processes===\n");
  
  dir = opendir("/proc");
  
  if (!dir) {
    fprintf(stderr, "Failed to open /proc\n");
    return -1;
  }
  
  while (entry = readdir(dir)) {
    sprintf(path, "/proc/%s/name", entry->d_name);
    FILE *file = fopen(path, "rb");
    
    if (!file) {
      fprintf(stderr, "Error opening %s\n", path);
      continue;
    }
    
    printf("\t");
    
    int ch;
    while ((ch = fgetc(file)) != EOF) {
      printf("%c", ch);
    }
    fclose(file);
    
    printf("\n");
  }
  
  return 0;
}
