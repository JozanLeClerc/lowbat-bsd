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
	extern memset
	extern sprintf
	extern dprintf
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
	cmp		rax, 0xfe			; in case we couldn't read
	je		err
	cmp		rax, 0x3
	je		sleepalot
	call	jo_f_percent
	cmp		rax, 0xfe			; in case we couldn't read
	je		err
	;; cmp		rax, 0xf			; 15%
	cmp		rax, 60; 15%
	jge		sleepalot
	mov		rdi, buff
	mov		rsi, 0x0
	mov		rdx, 17
	call	memset
	lea		rsi, [rel n_head]
	mov		rdx, rax
	call	sprintf				; get notification head via sprintf
	mov		rsi, rdi
	mov		rdi, 0x1
	call	dprintf
	mov		rsi, n_body			; notification body
	mov		rdx, 0x3			; ciritcal notification
	mov		rcx, 0x3a98			; 15000ms notification timeout
	call	jo_n_notify			; jo_n_notify(rdi, rsi, rdx, rcx)

speak:
	cmp		ebp, 0x1
	jne		sleepabit
	mov		rdi, [rbx + 0x8 * 0x2]
	call	jo_n_speak

sleepabit:
	mov		rdi, 0x14			; 20s
	call	sleep
	jmp		bigloop

sleepalot:
	;; mov		rdi, 0xf0			; 240s
	mov		rdi, 40			; 240s
	call	sleep
	jmp		bigloop

return:
	xor		rax, rax
	retq

err:
	mov		rdi, 0x2			; stderr
	lea		rsi, [rel errmsg]
	call	dprintf
	mov		rax, 0x1
	retq

section .data
	n_head:	db "Low battery: %d%%", 0x0
	n_body:	db "Please plug in computer", 0x0
	errmsg:	db "Failed to read battery informations", 0xa, 0x0

section .bss
	buff:	resb 17
