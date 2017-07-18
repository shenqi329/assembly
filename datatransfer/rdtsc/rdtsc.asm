global main 

extern printf

section .data
	align 4
	a:	dd 10.0
	b:	dd 5.0
	c:	dd 2.0
	fmtStr:	db "edx:eax = %llu edx = %d eax = %d", 0x0A, 0

section .bss
	align 4
	cycleLow:	resd 1
	cycleHigh:	resd 1
	result:		resd 1

section .text
	main:			; Using main since we are using gcc to link

;
;	op	dst,  src
;
	xor	eax, eax
	cpuid
	rdtsc
	mov	[cycleLow], eax
	mov	[cycleHigh], edx 

				;
				; Do some work before measurements 
				;
	fld	dword [a]
	fld	dword [c]
	fmulp	st1
	fmulp	st1
	fld	dword [b]
	fld	dword [b]
	fmulp	st1
	faddp	st1
	fsqrt
	fstp	dword [result]
				;
				; Done work
				;

	cpuid
	rdtsc
				;
				; break points so we can examine the values
				; before we alter the data in edx:eax and
				; before we print out the results.
				;
break1:
	sub	eax, [cycleLow]
	sbb	edx, [cycleHigh]
break2:
	push	eax
	push	edx
	push 	edx
	push	eax
	push	dword fmtStr
	call	printf
	add	esp, 20		; Pop stack 5 times 4 bytes


				;
				; Call exit(3) syscall
				;	void exit(int status)
				;
	mov	ebx, 0		; Arg one: the status
	mov	eax, 1		; Syscall number:
	int 	0x80