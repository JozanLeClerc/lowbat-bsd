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
	extern sleep
	extern sprintf
	extern jo_f_percent
	extern jo_f_status
	extern jo_n_speak
	extern jo_n_notify
	global jo_r_loop

jo_r_loop:
	push	rbp
	push	rbx
	mov		rbx, rsi
	mov		ebp, edi
	jmp		bigloop
	

bigloop:
	call	jo_f_status
	cmp		rax, 0x3
	je		sleepalot
	call	jo_f_percent
	cmp		rax, 0xf			; 15%
	jge		sleepalot
	xor		rdi, rdi
	mov		rsi, n_head
	mov		rdx, rax
	call	sprintf
	mov		rdi, rsi			; notification head sprintfed
	mov		rsi, n_body			; notification body
	mov		rdx, 0x3			; ciritcal notification
	mov		rcx, 0x3a98			; 15000ms notification timeout
	call	jo_n_notify			; jo_n_notify(rdi, rsi, rdx, rcx)

speak1:
	cmp		ebp, 1
	jne		sleepabit
	mov		rdi, [rbx + 0x8 * 0x2]
	call	jo_n_speak

sleepabit:
	mov		rdi, 0x14			; 20s
	call	sleep
	jmp		bigloop

sleepalot:
	mov		rdi, 0xf0			; 240s
	call	sleep
	jmp		bigloop

return:
	xor		rax, rax
	retq

section .data
	n_head:	db "Low battery: %d", 0x0
	n_body:	db "Please plug in computer", 0x0
