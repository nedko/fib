section	.text
global _start			;must be declared for linker (ld)
_start:				;tell linker entry point
	mov	edx, pri
	mov	ecx, 1		;SCHED_FIFO
	mov	ebx, 0		;this process
	mov	eax, 156	;system call number (sched_setscheduler)
 	int	0x80		;call kernel

	mov	ecx, 0xFFFFFFFF
	mov	ebx, 0
	mov	edx, 1

	;; call _test_printhex

_loop:
	mov	eax, ebx
	add	eax, edx
	mov	ebx, edx
	dec	ecx
	mov	edx, eax
	jnz	_loop

_done:
	;; call	_printhex

_exit:
	mov	ebx, 0		;the exit code
 	mov	eax, 1		;system call number (exit)
 	int	0x80		;call kernel

_test_printhex:
	mov	eax, 0xDEADBEEF
	call	_printhex
	jmp	_exit

_printhex:
	mov	edi, res
	mov	[edi], eax

	mov	eax, '0'
	call	_putc

	mov	eax, 'x'
	call	_putc

	mov	ecx, 4
_printhex_loop:
	mov	esi, res
	xor	eax, eax
	mov	al, [esi + ecx - 1]
	call	_print_byte
	dec	ecx
	jnz	_printhex_loop

	mov	eax, 0x0A
	call	_putc
	ret

_print_byte:
	push	ebx
	push	eax
	and	eax, 0xF0
	shr	eax, 4
	mov	eax, [hex + eax]
	call	_putc
	pop	eax
	push	eax
	and	eax, 0x0F
	mov	al, [hex + eax]
	call	_putc
	pop	eax
	pop	ebx
	ret

_putc:
	push	eax
	push	ebx
	push	ecx
	push	edx
	mov	edx, 1		;message length
	mov	ecx, char	;message to write
	and	eax, 0xFF
	mov	[ecx], eax
	mov	ebx, 1		;file descriptor (stdout)
	mov	eax, 4		;system call number (write)
	int	0x80		;call kernel
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret

section	.data
pri	dd	90
res	dd	0
hex	db	'0123456789ABCDEF'
char	db	0
