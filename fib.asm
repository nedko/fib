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
_loop:
	mov	eax, ebx
	add	eax, edx
	mov	ebx, edx
	dec	ecx
	mov	edx, eax
	jnz	_loop
	
	mov	ebx, 0		;the exit code
 	mov	eax, 1		;system call number (exit)
 	int	0x80		;call kernel

section	.data
pri	dd	90
