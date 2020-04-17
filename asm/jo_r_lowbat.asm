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
	extern jo_c_args
	extern jo_r_loop
	global jo_r_lowbat

jo_r_lowbat:
	call	jo_c_args
	mov		rdi, rax
	call	jo_r_loop			; jo_r_loop(speak: 0-1, *argv[])
	retq
