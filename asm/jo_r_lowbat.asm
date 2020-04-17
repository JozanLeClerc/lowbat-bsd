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

section .text
	extern sleep
	extern jo_n_speak
	global jo_r_lowbat

jo_r_lowbat:
	mov		rdi, 0x2
	call	sleep
	mov		rdi, msg
	call	jo_n_speak
	xor		rax, rax
	retq

section .data
	msg:	db "Welcome back, partner", 0x0
