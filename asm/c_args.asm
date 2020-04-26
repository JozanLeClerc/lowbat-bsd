/* ************************************************************************************ */
/*                                                                                      */
/*  File     : c_args.asm                                                 /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Check args                                                       |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/* ************************************************************************************ */

;; jo_c_args(argc: rdi, *argv[]: rsi)
;; ----------------------------------
;; returns 0 if args are invalid
;; returns 1 if args are valid

section .text
	extern strncmp
	global jo_c_args

jo_c_args:
	cmp		rdi, 0x2
	jle		no_args
	mov		rax, [rsi + 0x8 * 0x2]
	cmp		byte [rax + 0x0], 0x0
	je		no_args
	push	rdi
	mov		rdi, [rsi + 0x8 * 0x1]
	push	rsi
	mov		rsi, reference
	mov		rdx, reflen
	call	strncmp
	pop		rsi
	pop		rdi
	cmp		rax, 0x0
	jne		no_args
	mov		rax, 0x1
	retq

no_args:
	xor		rax, rax
	retq

section .data
	reference:	db "--say", 0x0
	reflen:		equ $ - reference
