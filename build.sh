#!/usr/bin/env bash

nasm kernel/multiboot.nasm -felf32 -o multiboot.o
#-fno-asynchronous-unwind-tables
i686-elf-gcc -fno-asynchronous-unwind-tables -c -funsigned-char kernel/*.c kernel/drivers/fs/*.c kernel/libc/*.c kernel/task/*.c kernel/drivers/tty/*.c kernel/drivers/keyboard/*.c -ffreestanding -O2 -Wall -Wextra -std=gnu99 -funsigned-char  -Wno-pointer-sign -Wno-unused-function -Wno-unused-parameter
i686-elf-gcc -fno-asynchronous-unwind-tables -funsigned-char -T linker.ld -o kernel.bin multiboot.o timer.o gdt.o kernel_main.o memory_file.o mempipe.o task.o master_irq_table.o interrupt_pointers.o interrupts.o libk.o list.o kmalloc.o printf.o tty.o keyboard.o fprintf.o stdio.o cli.o tty_file.o fs_file.o process.o -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char 
