export CFLAGS="-g -DINIT_SECTION_ASM_OP=.init -fno-omit-frame-pointer -Wpadded -Wredundant-decls"
export CFLAGS="$CFLAGS -fno-strict-aliasing -D__KERNEL_BUILD__  -c -funsigned-char"
export CFLAGS="$CFLAGS -ffreestanding -O2 -Wall -Wextra -std=gnu99 -funsigned-char  -Wno-pointer-sign "
export CFLAGS="$CFLAGS -Wno-unused-function -Wno-unused-parameter"



