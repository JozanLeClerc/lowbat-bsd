;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File      : jo_r_lowbat.asm                                           /_________/   ;;
;;  Author    : Joe                                                             |       ;;
;;  Date      : 04/2020                                                         |       ;;
;;  Info      : The main program                                                |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Files prefixes
;; --------------
;; f: fetch
;; n: notify
;; r: run
;; c: check

section .text
	extern puts
	extern jo_n_speak
	extern jo_c_args
	global jo_r_lowbat

jo_r_lowbat:
	call	jo_c_args
	cmp		rax, 0x0
	jne		joprint
	push	rdi
	mov		rdi, msg
	call	jo_n_speak
	pop		rdi
	xor		rax, rax
	mov		rax, rdi
	retq

joprint:
	push	rdi
	push	rsi
	;; mov		rdi, fmt
	mov		rdi, rax
	call	puts
	pop		rsi
	pop		rdi
	retq

section .data
	msg:	db "Welcome back, partner!", 0x0
	;; fmt:	db	"argv[2]: %s\n", 0x0
