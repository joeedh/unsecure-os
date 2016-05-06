#!/bin/sh

export CFLAGS="-fno-omit-frame-pointer -fPIC -Wpadded -Wredundant-decls"
export CFLAGS="$CFLAGS -fno-strict-aliasing -c -funsigned-char"
export CFLAGS="$CFLAGS -ffreestanding -O2 -Wall -Wextra -std=gnu99 -funsigned-char  -Wno-pointer-sign "
export CFLAGS="$CFLAGS -Wno-unused-function -Wno-unused-parameter"

export CC="i686-elf-gcc $CFLAGS -c "

echo "compiling userland. . ."

rm install/usr/lib/libc.a 2> /dev/null
rm install/bin/ls 2> /dev/null
rm install/bin/sh 2> /dev/null
rm install/bin/env 2> /dev/null
rm install/bin/stty 2> /dev/null
rm install/bin/ps 2> /dev/null
rm install/bin/cat 2> /dev/null
rm install/bin/echo 2> /dev/null
rm install/bin/t 2> /dev/null
rm install/bin/vi 2> /dev/null
rm build/crt0.o 2> /dev/null

cp kernel/userinclude/* install/usr/include

cp kernel/drivers/fs/ioctl.h install/usr/include/stropts.h

cp kernel/libc/string.h install/usr/include
cp kernel/libc/stdio.h install/usr/include
cp kernel/libc/stdlib.h install/usr/include
cp kernel/libc/vsprintf.h install/usr/include
cp kernel/drivers/fs/stat.h install/usr/include/sys
cp kernel/drivers/tty/termios.h install/usr/include

$CC kernel/libc/crt0.c -o build/crt0.o
$CC kernel/libc/libc.c -o build/user_libc.o
$CC kernel/libc/vfprintf.c -o build/user_vfprintf.o
$CC kernel/libc/fprintf.c -o build/user_fprintf.o
$CC kernel/libc/stdio.c -o build/user_stdio.o
$CC kernel/libc/stdenv.c -o build/user_stdenv.o
$CC kernel/libc/dynstr.c -o build/user_dynstr.o
$CC kernel/libc/string.c -o build/user_string.o
$CC kernel/libc/sprintf.c -o build/user_sprintf.o
$CC kernel/libc/system.c -o build/user_system.o
$CC kernel/libc/path.c -o build/user_path.o

#make dummy libg.a

echo "" > bleh.c
$CC ./bleh.c -o bleh.o
rm libg.a 2> /dev/null
ar cru libg.a bleh.o

echo "building libc (such that it is)"
rm build/libc.a 2> /dev/null
ar cru build/libc.a build/user_*.o

cp build/libc.a install/usr/lib
cp build/crt0.o .

echo "compiling apps (such that they are)"
i686-elf-gcc -O1 -Iinstall/usr/include apps/ls.c -fPIC -std=c99 -o install/bin/ls -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/sh.c -fPIC -std=c99 -o install/bin/sh -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/env.c -fPIC -std=c99 -o install/bin/env -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/echo.c -fPIC -std=c99 -o install/bin/echo -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/t.c -fPIC -std=c99 -o install/bin/t -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/cat.c -fPIC -std=c99 -o install/bin/cat -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/ps.c -fPIC -std=c99 -o install/bin/ps -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/stty.c -fPIC -std=c99 -o install/bin/stty -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
i686-elf-gcc -O1 -Iinstall/usr/include apps/vi.c -fPIC -std=c99 -o install/bin/vi -ffreestanding \
             -funsigned-char -lgcc -L install/usr/lib -L .
