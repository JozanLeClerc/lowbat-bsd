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
	global jo_r_loop

jo_r_loop:
	cmp		rdi, 0x1
	je		speak1

next:
	loop	jo_r_loop
	mov		rax, 25
	retq

speak1:
	mov		rdi, [rsi + 8 * 2]
	call	jo_n_speak
	jmp		next
