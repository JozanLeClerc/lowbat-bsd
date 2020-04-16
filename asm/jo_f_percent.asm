;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                                      ;;
;;  File      : jo_f_percent.asm                                          /_________/   ;;
;;  Author    : Joe                                                             |       ;;
;;  Date      : 04/2020                                                         |       ;;
;;  Info      : gets batt remaining capacity                                    |       ;;
;;                                                                      /       |       ;;
;;                                                                      \       /       ;;
;;                                                                       \_____/        ;;
;;                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text
	extern system
	global jo_f_percent

jo_f_percent:
	mov		rdi, f_cmd
	call	system
	retq

err:
	mov		rax, 0xff
	retq


section .data
	f_cmd:	db "apm -l > /tmp/lowbat.percent", 0x0
	buff:	db 0x0, 0x0, 0x0, 0x0
