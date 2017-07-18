
all: cdecl

cdecl: cdecl.o
	gcc -m32 -o cdecl cdecl.o

cdecl.o: cdecl.asm
	nasm -felf32 -g cdecl.asm

clean:
	rm cdecl