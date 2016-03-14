#ifndef _K_EXT2_H
#define _K_EXT2_H

#include <stddef.h>
#include <stdint.h>
#include "../fs/fs_interface.h"
#include "../fs/fs_file.h"

FSInterface *kext2fs_create(BlockDeviceIF *device);

#endif /* #ifndef _K_EXT2_H */