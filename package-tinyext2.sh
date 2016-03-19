#!/bin/sh

mount -t ext2 ./tinyext2.fs mnt
cp -r install/* mnt
umount mnt

