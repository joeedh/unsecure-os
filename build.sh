#!/usr/bin/env bash

#ensure build folder exists
mkdir -p build

#ensure mount folder for tinyext2.fs exists
mkdir -p mnt

#remove old build files
rm *.o 2> /dev/null
rm build/crt.o 2> /dev/null
rm build/user*.o 2> /dev/null 
rm build/kernel.bin 2> /dev/null

./setup-userland.sh
./build-userland.sh

echo "assemble SudoBios. . ."
nasm kernel/SudoBios/SudoBios.asm -f bin -o install/lib/SudoBios.bin

./install-userland.sh
./package-tinyext2.sh

echo "assemble NASM code. . ."
./kernel/asm/build.sh

#nasm -felf32 kernel/asm/core_x86.nasm -o core_x86.o
nasm -felf32 kernel/drivers/vesa/*.nasm -o vesa_nasm.o

#-fno-asynchronous-unwind-tables
#symbol_table_gen.o

echo "build kernel. . ."

source ./cflags.sh
i686-elf-gcc $CFLAGS -std=gnu99 -c -O2 -D__KERNEL_BUILD__ \
                      _test_elfdata.c kernel/syscalls/*.c kernel/loader/*.c \
                      kernel/drivers/pci/*.c \
                      kernel/drivers/blockdevice/*.c kernel/drivers/ext2/*.c kernel/*.c \
                      kernel/drivers/framebuffer/*.c kernel/drivers/vesa/*.c kernel/drivers/fs/*.c \
                      kernel/libc/*.c kernel/task/*.c kernel/drivers/tty/*.c kernel/drivers/procfs/*.c \
                      kernel/drivers/keyboard/*.c kernel/sharedmem/*.c kernel/dmesg/*.c \
                      kernel/drivers/hdd/*.c

./link.sh

#i686-elf-gcc -fno-asynchronous-unwind-tables -funsigned-char -T linker.ld -o kernel.bin core_x86.o -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char 

