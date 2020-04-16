;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File      : jo_f_status.asm                                           /_________/   ;;
;;  Author    : Joe                                                             |       ;;
;;  Date      : 04/2020                                                         |       ;;
;;  Info      : gets batt status                                                |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text
	extern system
	extern malloc
	extern printf
	global jo_f_status

jo_f_status:
	mov		rdi, f_cmd
	call	system
	mov		rdi, st_file
	mov		rsi, 0x0
	mov		rax, 0x5
	syscall
	jc		err
	push	rax
	mov		rdi, 0x5
	call	malloc
	cmp		rax, 0x0
	je		err
	mov		rsi, rax
	pop		rax
	mov		rdi, rax
	mov		rdx, 0x4
	push	rax
	mov		rax, 0x3
	syscall
	jc		err
	pop		rax
	mov		rdi, rax
	mov		rax, 0x6
	syscall
	mov		byte [rsi + 0x4], 0x0
	mov		rax, rsi
	retq

err:
	mov		rax, 0x0
	retq

section .data
	f_cmd:		db "apm | grep Status | awk -F ' ' '{print $3}' > /tmp/lowbat.status", 0x0
	st_file:	db "/tmp/lowbat.status", 0x0

	;; charging
	;; discharg
