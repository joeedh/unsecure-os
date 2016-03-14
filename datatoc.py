import sys

file = open(sys.argv[1], "rb")
buf = file.read()
file.close()

name = sys.argv[2]
outfile = sys.argv[3]

out = "const unsigned char " + name + "[] = {\n"
c = 0
for b in buf:
  out += hex(b) + ","
  if c > 15:
    c = 0
    out += "\n"
  c += 1
  
out += "};\n\n"

out += """
  unsigned int NAME_size = SIZE;
""".replace("NAME", name).replace("SIZE", str(len(buf)))

f = open(outfile, "w")
f.write(out)
f.close()
