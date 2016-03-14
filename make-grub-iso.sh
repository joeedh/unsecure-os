#!/bin/sh

cp build/kernel.bin isodir/boot
cp grub.cfg isodir/boot/grub
grub-mkrescue -o grub.iso isodir
