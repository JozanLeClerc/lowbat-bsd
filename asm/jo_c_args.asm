;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File      : jo_c_args.asm                                             /_________/   ;;
;;  Author    : Joe                                                             |       ;;
;;  Date      : 04/2020                                                         |       ;;
;;  Info      : Check args                                                      |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text
	extern strncmp
	global jo_c_args

jo_c_args:						; jo_c_args(argc: rdi, *argv[]: rdi)
	cmp		rdi, 0x2
	jle		no_args
	push	rdi
	mov		rdi, [rsi + 8 * 1]
	push	rsi
	mov		rsi, reference
	mov		rdx, len
	call	strncmp
	pop		rsi
	pop		rdi
	cmp		rax, 0x0
	jne		no_args
	mov		rax, [rsi + 8 * 2]
	retq

no_args:
	xor		rax, rax
	retq

section .data
	reference:	db "--say", 0x0
	len:		equ $ - reference ; reference len
