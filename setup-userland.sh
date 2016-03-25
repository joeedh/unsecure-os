#!/bin/sh

#set up install directory and headers and stuff

#XXX why doesn't -p work on this first mkdir?
mkdir -p install/usr/include/sys 2> /dev/null
mkdir -p install/usr/bin
mkdir -p install/usr/lib
mkdir -p install/bin
mkdir -p install/lib
mkdir -p install/tmp
mkdir -p install/etc
mkdir -p install/var/log

cp kernel/syscalls/syscalls.h install/usr/include/sys
cp kernel/drivers/fs/dirent.h install/usr/include
cp kernel/libc/*.h install/usr/include
cp -r kernel/userinclude/* install/usr/include
cp kernel/drivers/fs/dirent.h install/usr/include/sys
cp build/libc.a install/usr/lib
cp -r install/usr apps/usr
