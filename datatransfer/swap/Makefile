
all: example

example: example.o
	ld -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 -o example example.o -lc

example.o: example.s
	as -gstabs --32 -march=i386 -o example.o example.s

clean:
	rm example