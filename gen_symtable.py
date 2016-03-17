#!/usr/bin/env python

import subprocess;

file = open("kernel.bin.symbols", "w")

ret = subprocess.call(["nm", "-v", "-t", "d", "-e", "build/kernel.bin"], stdout=file)
file.close()

file = open("kernel.bin.symbols", "r")
buf = file.read()
file.close()

lines = [l.strip() for l in buf.split("\n")]

out = """#include <stddef.h>
#include <stdint.h>

#pragma GCC diagnostic ignored "-Wpadded"
struct {
  uint32_t addr; 
  char name[45];
} _kernel_symbols[] = {
"""

tot = 0
for line in lines:
  l = line.split(" ");
  
  if l[0] == "U":
    #undefined symbol
    continue;
  
  if l[0].strip() == "":
    continue
    
  addr = int(l[0])
  name = l[2]
  out += "  {" + str(addr) + ", \"" + name + "\"},\n";
  tot += 1
  
out += "};\n\n";
out += "unsigned int _kernel_symbols_count = %i;\n\n" % tot

file = open("kernel/symbol_table_gen.c", "w");
file.write(out)
file.close()
