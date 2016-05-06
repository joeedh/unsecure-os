#!/bin/sh

echo "generate _tinyext2_fs.c. . ."

python datatoc.py tinyext2.fs _tinyext2_fs _tinyext2_fs.c
i686-elf-gcc -c _tinyext2_fs.c

#_tinyext2_fs is included by linker.ld

echo "link kernel. . ."
i686-elf-gcc -DINIT_SECTION_ASM_OP=.init -fno-omit-frame-pointer -funsigned-char -T linker.ld -o build/kernel.bin core_x86.o timer.o gdt.o kernel_main.o bootinfo.o \
                                             interrupt_pointers.o interrupts.o fpu.o libk.o list.o task.o process.o\
                                             SudoBios.o framebuffer.o vesa.o framebuffer_tty.o shm.o shm_file.o\
                                             kmalloc.o printf.o tty.o keyboard.o memblock.o memory_file.o\
                                             mempipe.o fs_procfs.o fs_vfstable.o ioctl.o termios.o \
                                             ext2.o blockdevice.o libc.o syscalls.o sprintf.o string.o dmesg.o \
                                             fprintf.o stdio.o cli.o vfprintf.o \
                                             pci.o e9printf.o path.o elfloader.o process_management.o \
                                             tty_file.o vesa_nasm.o fs_file.o symbol_table_gen.o debug.o hdd.o \
                                             -ffreestanding -O2 -nostdlib  \
                                             -lgcc -funsigned-char 

#dumb way of getting symbols
#refactor to get elf image from GRUB instead
echo "reading symbols..."

python gen_symtable.py
readelf --debug-dump=decodedline build/kernel.bin > decoded_line_data.debuginfo

