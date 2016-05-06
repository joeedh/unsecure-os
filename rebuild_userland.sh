#!/bin/sh

./build-userland.sh
./package-tinyext2.sh
./link.sh
./make-grub-iso.sh
