#include <stdio.h>

#include <dirent.h>
#include <string.h>
#include <stdint.h>

//int (*e9printf_)(char *fmt, ...) = 0x00109ae0;

int main(int argc, char **argv) {
  DIR *dir;
  struct dirent *entry;
  int i;
  
  //e9printf_("argc: %d, argv: %x\n", argc, argv);
  fprintf(stdout, "argc: %d, argv: %x\n", argc, argv);
  //*
  if (argc < 2) {
    fprintf(stdout, "missing argument\n");
    return -1;
  }
  
  for (i=0; i<argc; i++) {
    fprintf(stdout, "%s ", argv[i]);
  }
  fprintf(stdout, "\n");
  
  dir = opendir(argv[1]);
  while ((entry = readdir(dir))) {
    fprintf(stdout, "  %s\n", entry->d_name);
  }
  closedir(dir);
  //*/
  return -2;
}
