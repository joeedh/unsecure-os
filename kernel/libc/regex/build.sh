#!/usr/bin/env sh

rm *.o

bison regex.y
gcc -c regex_main.c regex.c regex.tab.c 2> err; head err -n 25;
