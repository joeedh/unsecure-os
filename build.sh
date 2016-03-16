#!/usr/bin/env bash

nasm kernel/core_x86.nasm -felf32 -o core_x86.o
#-fno-asynchronous-unwind-tables
#symbol_table_gen.o

source ./cflags.sh
i686-elf-gcc $CFLAGS _tinyext2_fs.c kernel/drivers/pci/*.c kernel/drivers/blockdevice/*.c \
              kernel/drivers/ext2/*.c kernel/*.c kernel/drivers/fs/*.c kernel/libc/*.c kernel/task/*.c \
              kernel/drivers/tty/*.c kernel/drivers/keyboard/*.c -std=gnu99
             

i686-elf-gcc -g -DINIT_SECTION_ASM_OP=.init -fno-omit-frame-pointer -funsigned-char -T linker.ld -o kernel.bin core_x86.o timer.o gdt.o kernel_main.o bootinfo.o \
                                             interrupt_pointers.o interrupts.o libk.o list.o task.o process.o\
                                             kmalloc.o printf.o tty.o keyboard.o memblock.o memory_file.o mempipe.o \
                                             ext2.o blockdevice.o \
                                             fprintf.o stdio.o cli.o \
                                             pci.o e9printf.o path.o \
                                             tty_file.o fs_file.o symbol_table_gen.o debug.o -ffreestanding -O2 -nostdlib  \
                                             -lgcc -funsigned-char 

#objcopy --only-keep-debug kernel.bin kernel.sym
#objcopy --strip-debug kernel.bin

python gen_symtable.py
readelf --debug-dump=decodedline kernel.bin > decoded_line_data.debuginfo

#i686-elf-gcc -fno-asynchronous-unwind-tables -funsigned-char -T linker.ld -o kernel.bin core_x86.o -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char 

