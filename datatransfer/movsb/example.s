.section .text

.global _start
_start:
	movl $mystr,%esi
	movl $mystr2,%edi
	cld
	movl $5,%ecx
	rep movsb

_exit:
	xorl %ebx,%ebx
	movl $1,%eax
	int $0x80

.section .bss

.section .data
mystr: 
	.asciz "Hello"
mystr2:
	.asciz "xxxxxx"
