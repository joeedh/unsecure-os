#!/usr/bin/env bash

nasm kernel/multiboot.nasm -felf32 -o multiboot.o
#-fno-asynchronous-unwind-tables
#symbol_table_gen.o

i686-elf-gcc -fPIC -D__KERNEL_BUILD__  -c -funsigned-char _tinyext2_fs.c kernel/drivers/blockdevice/*.c kernel/drivers/ext2/*.c kernel/*.c kernel/drivers/fs/*.c kernel/libc/*.c kernel/task/*.c kernel/drivers/tty/*.c kernel/drivers/keyboard/*.c -ffreestanding -O2 -Wall -Wextra -std=gnu99 -funsigned-char  -Wno-pointer-sign -Wno-unused-function -Wno-unused-parameter

i686-elf-gcc -fPIC -funsigned-char -T linker.ld -o kernel.bin multiboot.o timer.o gdt.o kernel_main.o interrupt_pointers.o \
                                             interrupts.o libk.o list.o task.o process.o\
                                             kmalloc.o printf.o tty.o keyboard.o memblock.o memory_file.o mempipe.o \
                                             ext2.o blockdevice.o \
                                             fprintf.o stdio.o cli.o \
                                             tty_file.o fs_file.o symbol_table_gen.o debug.o -ffreestanding -O2 -nostdlib  \
                                             -lgcc -funsigned-char 

#objcopy --only-keep-debug kernel.bin kernel.sym
#objcopy --strip-debug kernel.bin

python gen_symtable.py


#i686-elf-gcc -fno-asynchronous-unwind-tables -funsigned-char -T linker.ld -o kernel.bin multiboot.o -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char 

