;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File     : jo_f_percent.asm                                           /_________/   ;;
;;  Author   : Joe                                                              |       ;;
;;  Date     : 04/2020                                                          |       ;;
;;  Info     : Gets batt remaining capacity                                     |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text
	extern system
	extern atoi
	global jo_f_percent

jo_f_percent:
	mov		rdi, f_cmd
	call	system
	mov		rdi, pr_file
	mov		rsi, 0x0
	mov		rax, 0x5
	syscall
	jc		err
	mov		rdi, rax
	mov		rsi, buff
	mov		rdx, 0x3
	mov		rax, 0x3
	syscall
	jc		err
	mov		rax, 0x6
	syscall
	xor		rax, rax
	mov		rdi, rsi
	call	atoi
	retq

err:
	mov		rax, 0xfe
	retq


section .data
	f_cmd:		db "apm -l > /tmp/lowbat.percent", 0x0
	pr_file:	db "/tmp/lowbat.percent", 0x0
	buff:		db 0x0, 0x0, 0x0, 0x0
