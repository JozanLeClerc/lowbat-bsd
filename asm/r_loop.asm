/****************************************************************************************/
/*                                                                                      */
/*  File     : r_loop.asm                                                 /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : The main loop                                                    |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

;; jo_r_loop(speak (0-1), *argv[])
;; -------------------------------

section .text
	extern sleep
	extern jo_f_percent
	extern jo_f_status
	extern jo_n_speak
	extern jo_n_notify
	extern jo_r_cpyhead
	global jo_r_loop

jo_r_loop:
	push	rbp
	push	rbx
	mov		rbx, rsi
	mov		ebp, edi
	jmp		bigloop

bigloop:
	call	jo_f_status			; check the status
	cmp		rax, 0xfe			; in case we couldn't read
	je		err
	cmp		rax, 0x3
	je		sleepalot
	call	jo_f_percent		; check the capacity
	cmp		rax, 0xfe			; in case we couldn't read
	je		err
	cmp		rax, 0xf
	jge		sleepalot
	mov		rdi, rax
	call	jo_r_cpyhead
	mov		rdi, rax
	mov		rsi, n_body			; notification body
	mov		rdx, 0x3			; ciritcal notification
	mov		rcx, 0x3a98			; 15000ms notification timeout
	call	jo_n_notify			; jo_n_notify(head: rdi, body: rsi,
								;             urgency: rdx, timeout: rcx)

speak:
	cmp		ebp, 0x1
	jne		sleepabit
	mov		rdi, [rbx + 0x8 * 0x2]
	call	jo_n_speak

sleepabit:
	mov		rdi, 0x14
	call	sleep				; sleep 20 seconds before next check/notification
	jmp		bigloop

sleepalot:
	mov		rdi, 0xf0
	call	sleep				; sleep 240s (4m) if it's fine
	jmp		bigloop

return:
	xor		rax, rax
	retq

err:
	mov		rdi, 0x2			; stderr
	lea		rsi, [rel errmsg]
	mov		rdx, errlen
	mov		rax, 0x4
	syscall						; write error message on stderr
	xor		rax, rax
	retq

section .data
	n_body:	db "Please plug in computer", 0x0
	fmt:	db "%s", 0xa, 0x0
	errmsg:	db "Failed to read battery informations", 0xa, 0x0
	errlen:	equ $ - errmsg
