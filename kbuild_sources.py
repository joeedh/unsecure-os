#EVIL!!

from glob import *
import os.path, os

kbuild_sources = glob("kernel/*.c")
kbuild_sources += glob("kernel/drivers/tty/*.c")
kbuild_sources += glob("kernel/drivers/pci/*.c")
kbuild_sources += glob("kernel/drivers/blockdevice/*.c")
kbuild_sources += glob("kernel/drivers/ext2/*.c")
kbuild_sources += glob("kernel/drivers/fs/*.c")
kbuild_sources += glob("kernel/drivers/keyboard/*.c")
kbuild_sources += glob("kernel/libc/*.c")
kbuild_sources += glob("kernel/task/*.c")
kbuild_sources += glob("kernel/process/*.c")

def shglob(path):
  out = " "
  for f in glob(path):
    out += " " + f
  
  return out
  
def linktargets(srcs):
  out = " "
  for f in srcs:
    f = os.path.split(f)[1]
    out += "build/" + f.replace(".c", ".o") + " "
  return out

CC = os.environ["TARGET"] + "-gcc"
LD = os.environ["TARGET"] + "-ld"
AR = os.environ["TARGET"] + "-ar"

LINK_FLAGS = "-fno-asynchronous-unwind-tables -funsigned-char -ffreestanding -O2 -nostdlib  -lgcc"
CFLAGS = "-fno-asynchronous-unwind-tables "
CFLAGS += "-ffreestanding -O2 -Wall -Wextra -std=gnu99 "
CFLAGS += "-funsigned-char  -Wno-pointer-sign -Wno-unused-function -Wno-unused-parameter "

class OrderedDict (object):
  def __init__(self, dict=None):
    self.d = {}
    self.l = []
    self.k = []
    self.loc = {}
    
    if type(dict) in [list, tuple]:
      for i in range(int(len(dict)/2)):
        k = dict[i*2]
        v = dict[i*2+1]
        self[k] = v
    elif dict != None:
      for k in dict:
        self[k] = dict[k]
  
  def __setitem__(self, k, v):
    if k not in self.loc:
      self.loc[k] = len(self.l)
      self.l.append(v)
      self.k.append(k)
      
    self.d[k] = v
    self.l[self.loc[k]] = v
    self.k[self.loc[k]] = k
  
  def __getitem__(self, k):
    return self.d[k]
  
  def __contains__(self, k):
    return k in self.d
  
  def __iter__(self):
    return iter(self.k)
  
  def keys(self):
    def iter():
      for k in self.k:
        yield k
    return iter()
    
  def values(self):
    def iter():
      for l in self.l:
        yield l
    return iter()
    
targets = OrderedDict([
  #ensure kernel gets blank copy of crt0.o
  "tinyfs1.custom", [
    "python datatoc.py tinyext2.fs _tinyext2_fs _tinyext2_fs.c"
  ],
  "tinyfs2.custom", [
    CC + " -c _tinyext2_fs.c -ffreestanding -lgcc"
  ],
  "crt01.custom", [
    CC + " " + CFLAGS +  " -D__KERNEL_BUILD__ -c kernel/libc/crt0.c -o build/crt0.o", 
  ],
  "core_x86.o"  ,  ["kernel/core_x86.nasm"],
  "main_sources" ,   kbuild_sources,
  "kernel.bin.custom", [
    CC + " " + LINK_FLAGS + " -T linker.ld -o build/kernel.bin build/core_x86.o " + linktargets(kbuild_sources)
  ],
  "crt0.custom", [
    CC + " " + CFLAGS +  " -c kernel/libc/crt0.c -o build/crt0.o", 
  ],
  "libc.custom", [
    CC + " " + CFLAGS +  " -c kernel/libc/libc.c -o build/user_libc.o", 
  ],
  "link_libc_a.custom", [
    AR + " cru build/libc.a build/user_libc.o"
    #CC + " -ffreestanding -fPIC -shared -o build/libc.so build/user_libc.o"
  ],
  "install-userland.custom", [
    "sh install-userland.sh"
  ],
  "appfiles.custom", [
    #CC + " -Iinstall/usr/include -c " + shglob("apps/*.c") + " -ffreestanding -funsigned-char -fPIC"
    CC + " -Iinstall/usr/include apps/ls.c -o build/ls -ffreestanding -funsigned-char -fPIC -lgcc -L install/usr/lib"
  ],
  "grub.iso.custom" , [
    "sh make-grub-iso.sh"
  ]
])

copy_targets = {
}

optional_copy_targets = {
}
