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
	extern puts
	extern jo_n_speak
	global jo_r_loop

jo_r_loop:
	push	rcx
	push	rbx
	mov		rbx, rsi
	mov		rcx, rdi

speak1:
	cmp		rcx, 0x1
	jne		speak1
	mov		rdi, [rbx + 8 * 2]
	call	jo_n_speak
	pop		rcx
	push	rdi
	mov		rdi, message
	call	puts
	pop		rdi
	jmp		speak1

return:
	xor		rax, rax
	retq

section .data
	message:	db "qwe", 0x0
