.data

value:
	.long 2

.text 
	.global _start

_start:
	mov $6 ,%eax

	movw %ax,value

	movl $0,%ebx

	movb %al,%bl

	movl value,%ebx

	movl $value,%esi

	xorl %ebx, %ebx

	movw value(,%ebx,1),%bx

	movl $1,%eax
	xorl %ebx, %ebx
	add $1,%ebx
	int $0x80
