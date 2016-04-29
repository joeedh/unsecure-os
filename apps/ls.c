#include <stdio.h>
#include <stdlib.h>

#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>

#include "spawn.h"
#include "sys/stat.h"

//int (*e9printf_)(char *fmt, ...) = 0x00109ae0;

int main(int argc, char **argv) {
  DIR *dir;
  struct dirent *entry;
  char path[256];
  int i;
  
  //e9printf("started ls proc\n");
  
  //e9printf("ls-argc: %d, argv: %x\n", argc, argv);
  fprintf(stdout, "argc: %d, argv: %x\n", argc, argv);
  //*
  
  if (argc < 2) {
    getcwd(path, sizeof(path));
    path[sizeof(path)-1] = 0;
  } else {
    strcpy(path, argv[1]);
  }
  
  //for (i=0; i<argc; i++) {
  //  fprintf(stdout, "%d: %s\n", i, argv[i]);
  //}
  fprintf(stdout, "\n");
  
  dir = opendir(path);
  //e9printf("dir: %x\n", dir);
  
  struct stat st;
  
  char path2[512];
  
  while ((entry = readdir(dir))) {
    int isdir = 0;
    
    strlcpy(path2, path, sizeof(path2));
    
    if (path[strlen(path)-1] != '/') {
      strlcat(path2, "/", sizeof(path2));
    }
    strlcat(path2, entry->d_name, sizeof(path2));
    
    if (stat(path2, &st) == 0 && ST_ISDIR(st.st_mode)) {
      isdir = 1;
    }

    if (isdir) {
      fprintf(stdout, "\033[34m");
    }
    
    fprintf(stdout, "  %s", entry->d_name);
    
    if (isdir) {
      fprintf(stdout, "\033[39m");
    }
    
    fprintf(stdout, "\n");
  }
  closedir(dir);
  //*/
  
  //e9printf("finished ls proc, -1\n");
  
  return -2;
}
