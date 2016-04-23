#!/bin/sh

#dd if=/dev/zero of=tinyext2.fs bs=1024 count=450
#mkfs.ext2 tinyext2.fs

mount -t ext2 ./tinyext2.fs mnt
cp -r install/* mnt
umount mnt
