#!/bin/sh

#recopy headers, and also libc

cp kernel/syscalls/syscalls.h install/usr/include/sys
cp kernel/drivers/fs/dirent.h install/usr/include
cp kernel/drivers/fs/unistd.h install/usr/include

cp kernel/libc/*.h install/usr/include

rm install/usr/include/kmalloc.h 2> /dev/null
cp build/crt0.o .

cp -r kernel/userinclude/* install/usr/include

cp kernel/drivers/fs/dirent.h install/usr/include/sys
cp build/libc.a install/usr/lib
cp -r install/usr apps/usr

#echo Regenerating tinyext2.fs. . .
#rm tinyext2.fs
#dd if=/dev/zero of=tinyext2.fs bs=1024 count=512
#mkfs.ext2 tinyext2.fs
