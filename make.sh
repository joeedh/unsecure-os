#!/bin/sh

./build.sh

cp tinyext2.fs isodir/boot
cp kernel.bin isodir/boot
cp grub.cfg isodir/boot/grub
grub-mkrescue -o grub.iso isodir
