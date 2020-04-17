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
	;; extern stoa
	extern jo_c_args
	extern jo_r_loop
	global jo_r_lowbat

jo_r_lowbat:
	;; call	stoa
	push	rdi
	mov		rdi, rax
	call	puts
	pop		rdi
	retq

;; 	call	jo_c_args
;; 	mov		bl, byte [rax + 0x0]
;; 	cmp		bl, 0x0
;; 	jne		joprint
;; 	call	jo_r_loop			; jo_r_loop(speak: 0-1, *argv[])
;; 	xor		rax, rax
;; 	retq

;; joprint:
;; 	push	rdi
;; 	mov		rdi, rax
;; 	call	puts
;; 	pop		rdi
