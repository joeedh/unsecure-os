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
./install-userland.sh
./package-tinyext2.sh

echo "generate _tinyext2_fs.c. . ."

python datatoc.py tinyext2.fs _tinyext2_fs _tinyext2_fs.c
python datatoc.py install/bin/ls _test_elfdata _test_elfdata.c

echo "assemble NASM code. . ."
./kernel/asm/build.sh
#nasm -felf32 kernel/asm/core_x86.nasm -o core_x86.o

#-fno-asynchronous-unwind-tables
#symbol_table_gen.o

echo "build kernel. . ."

source ./cflags.sh
i686-elf-gcc $CFLAGS _test_elfdata.c _tinyext2_fs.c kernel/syscalls/*.c kernel/loader/*.c kernel/drivers/pci/*.c kernel/drivers/blockdevice/*.c \
              kernel/drivers/ext2/*.c kernel/*.c kernel/drivers/fs/*.c kernel/libc/*.c kernel/task/*.c \
              kernel/drivers/tty/*.c kernel/drivers/keyboard/*.c -std=gnu99
             

echo "link kernel. . ."
i686-elf-gcc -DINIT_SECTION_ASM_OP=.init -fno-omit-frame-pointer -funsigned-char -T linker.ld -o build/kernel.bin core_x86.o timer.o gdt.o kernel_main.o bootinfo.o \
                                             interrupt_pointers.o interrupts.o libk.o list.o task.o process.o\
                                             kmalloc.o printf.o tty.o keyboard.o memblock.o memory_file.o mempipe.o \
                                             ext2.o blockdevice.o libc.o syscalls.o sprintf.o \
                                             fprintf.o stdio.o cli.o _test_elfdata.o vfprintf.o \
                                             pci.o e9printf.o path.o elfloader.o process_management.o \
                                             tty_file.o fs_file.o symbol_table_gen.o debug.o -ffreestanding -O2 -nostdlib  \
                                             -lgcc -funsigned-char 

#objcopy --only-keep-debug kernel.bin kernel.sym
#objcopy --strip-debug kernel.bin

echo "reading symbols..."

python gen_symtable.py
readelf --debug-dump=decodedline build/kernel.bin > decoded_line_data.debuginfo

#i686-elf-gcc -fno-asynchronous-unwind-tables -funsigned-char -T linker.ld -o kernel.bin core_x86.o -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char 

