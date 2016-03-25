#!/bin/sh

cd kernel/asm
m4 --prefix-builtins core_x86.nasm > build.nasm
nasm build.nasm -felf32 -o ../../core_x86.o

cd ../..
