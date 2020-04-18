;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File      : jo_r_loop.asm                                             /_________/   ;;
;;  Author    : Joe                                                             |       ;;
;;  Date      : 04/2020                                                         |       ;;
;;  Info      : The main loop                                                   |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; jo_r_loop(speak (0-1), *argv[])
;; -------------------------------

section .text
	extern jo_n_speak
	extern jo_n_notify
	global jo_r_loop

jo_r_loop:
	push	rbp
	push	rbx
	mov		rbx, rsi
	mov		ebp, edi

speak1:
	cmp		ebp, 1
	jne		speak1
	mov		rdi, [rbx + 8 * 2]
	call	jo_n_speak
	jmp		speak1

return:
	xor		rax, rax
	retq

section .data
	msg:	db "qwe", 0x0
