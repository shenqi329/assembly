global main 

extern printf

section .data
	align 4
	a:	dd 1
	b:	dd 2
	c:	dd 3
	fmtStr:	db "Result: %d", 0x0A, 0

section .bss
	align 4

section .text
				
;
; int func( int a, int b, int c )
; {
;	return a + b + c ;
; }
;
func:
	push	ebp		; Save ebp on the stack 
	mov	ebp, esp	; Replace ebp with esp since we will be using
				; ebp as the base ponter for the functions
				; stack.
				;
				; The arguments start at ebp+8 since calling the
				; the function places eip on the stack and the
				; function places ebp on the stack as part of
				; the preamble.
				;

	mov	eax, [ebp+8]	; mov a int eax
	mov	edx, [ebp+12]	; add b to eax
	lea	eax, [eax+edx]	; Using lea for arithmetic adding a + b into eax
	add	eax, [ebp+16]	; add c to eax
	
	mov esp,ebp
	pop	ebp		; restore ebp
	ret			; Returning, eax contains result

	;
	; Using main since we are using gcc to link
	;
	main:

	;
	; Set up for call to func(int a, int b, int c)
	;
	; Push variables in right to left order 
	;
	push	dword [c]
	push	dword [b]
	push	dword [a]
	call	func
	add	esp, 12		; Pop stack 3 times 4 bytes
	push	eax
	push	dword fmtStr
	call	printf
	add	esp, 8		; Pop stack 2 times 4 bytes

	;
	; Alternative to using push for function call setup, this is the method
	; used by gcc
	;
	sub	esp, 12		; Create space on stack for three 4 byte variables
	mov	ecx, [b]
	mov	eax, [a]
	mov	[esp+8], dword 4 
	mov	[esp+4], ecx
	mov	[esp],	 eax
	call	func
	add esp, 12

	;push	eax
	;push	dword fmtStr
	
	sub esp, 8
	mov	[esp+4], eax
	lea	eax, [fmtStr]
	mov	[esp], eax 
	call	printf
	add esp, 8

				;
				; Call exit(3) syscall
				;	void exit(int status)
				;
	mov	ebx, 0		; Arg one: the status
	mov	eax, 1		; Syscall number:
	int 	0x80