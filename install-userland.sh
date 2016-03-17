#!/bin/sh

cp kernel/libc/*.h install/usr/include
rm install/usr/include/kmalloc.h  
cp build/crt0.o .

cp kernel/drivers/fs/dirent.h install/usr/include
cp build/libc.a install/usr/lib
cp -r install/usr apps/usr

#echo Regenerating tinyext2.fs. . .
#rm tinyext2.fs
#dd if=/dev/zero of=tinyext2.fs bs=1024 count=512
#mkfs.ext2 tinyext2.fs
