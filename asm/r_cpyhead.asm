/****************************************************************************************/
/*                                                                                      */
/*  File     : r_cpyhead.asm                                              /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Formats and returns notification head title                      |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

section .text
	extern memset
	extern sprintf
	global jo_r_cpyhead

jo_r_cpyhead:					; jo_r_cpyhead(percent: rdi)
	push	rdi
	mov		rdi, buff
	mov		rsi, 0x0
	mov		rdx, 0x11
	call	memset				; memset 0 notification head
	lea		rsi, [rel n_head]
	pop		rdi
	mov		rdx, rdi
	mov		rdi, rax
	xor		rax, rax
	mov		al, 0x1
	push	rdi
	call	sprintf
	pop		rdi
	mov		rax, rdi
	retq

section .data
	n_head:	db "Low battery: %d%%", 0x0

section .bss
	buff:	resb 0x11
