.data

value:
	.long 2

output:
	.asciz "Hello World\n"
output1:
	.asciz "Hello World1\n"

.text
	.global _start

_start:
	pushl $output
	pushl $_xxx
	jmp  printf

_test:
	pushl $output1
	call printf
	add $4,%esp

_xxx:
	add $4,%esp
	movl $54,%ebx
	xorl %eax,%eax

	xchgl value,%ebx
	xchgw %ax,value

_exit:
	xorl %ebx,%ebx
	movl $1,%eax
	int $0x80