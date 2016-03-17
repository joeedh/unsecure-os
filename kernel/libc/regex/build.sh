#!/usr/bin/env sh

rm *.o 2> _null_err
rm test.exe 2> _null_err
rm _null_err

CFLAGS="-Wno-pmf-conversions -Wno-int-conversion -Wno-incompatible-pointer-types -Wno-pointer-sign "
CFLAGS="$CFLAGS -Wno-pointer-to-int-cast -DREGEX_INTERN "

bison regex.y
gcc $CFLAGS -c -g regex_main.c regex.c regex.tab.c 2> err
cat err
gcc regex_main.o -O0 regex.o regex.tab.o -o test.exe

