
all: rdtsc

rdtsc: rdtsc.o
	gcc -m32 -o rdtsc rdtsc.o

rdtsc.o: rdtsc.asm
	nasm -felf -g rdtsc.asm -l rdtsc.lst

clean:
	rm rdtsc