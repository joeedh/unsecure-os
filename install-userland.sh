#!/bin/sh

cp kernel/libc/*.h install/usr/include
rm install/usr/include/kmalloc.h  
cp -r install/usr apps/usr
cp build/crt0.o .

cp kernel/drivers/fs/dirent.h install/usr/include

cp build/libc.a install/usr/lib

mount -t ext2 ./tinyext2.fs mnt
cp -r install/* mnt
umount mnt