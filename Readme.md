Unsecure is a research project on what happens
if you write a totally unsecured OS, with no
support for virtual memory, and with everything
running in ring 0.

The name is not a joke.  Unsecure is not meant to
be used in production environments, ever.  The goal
is to probe the trade-off between performance and
security on modern hardware.

# Compiling

##Requirements:
* NASM
* Grub2
* GNU m4
* Linux (you can run it inside a VM if necassary, e.g. VirtualBox)

## Set up environment
If you have a /usr/local/cross folder already, open cross.tar.xz
and make sure nothing conflicts with what's already there.

Extract cross.tar.xz to /usr/local, it should extract itself into
/usr/local/cross.

From a console, do:
```source /usr/local/cross/build.sh```

Then from the repository checkout directory, do:
`./build.sh`

It should do a bunch of steps, and finally spit out
a cdrom iso, grub.iso, that you can boot with (from a VM!).

## Setting up Bochs
If you use Bochs, you can turn on the so-called "port E9 hack"
in it's "other" settings.  This enables direct debug printing
from the kernel to the Bochs console.
