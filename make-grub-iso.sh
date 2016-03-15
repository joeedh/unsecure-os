#!/bin/sh

cp tinyext2.fs isodir/boot
cp build/kernel.bin isodir/boot
cp grub.cfg isodir/boot/grub

grub-mkrescue -o grub.iso isodir
