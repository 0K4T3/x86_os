all:
	nasm -o boot.o boot.s

start:
	qemu-system-i386 -boot a -fda boot.o
