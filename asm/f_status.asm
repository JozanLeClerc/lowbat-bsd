/****************************************************************************************/
/*                                                                                      */
/*  File     : f_status.asm                                               /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Gets batt status                                                 |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

/***************/
/* apm status  */
/* ----------  */
/* 0: high     */
/* 1: low      */
/* 2: critical */
/* 3: charging */
/***************/

section .text
	extern system
	global jo_f_status

jo_f_status:
	mov		rdi, f_cmd
	call	system
	mov		rdi, st_file
	mov		rsi, 0x0
	mov		rax, 0x5
	syscall
	jc		err
	mov		rdi, rax
	mov		rsi, buff
	mov		rdx, 0x1
	mov		rax, 0x3
	syscall
	jc		err
	mov		rax, 0x6
	syscall
	movsx	rax, byte [rsi + 0x0]
	sub		rax, 0x30
	retq

err:
	mov		rax, 0xfe
	retq

section .data
	f_cmd:		db	"apm -b > /tmp/lowbat.status", 0x0
	st_file:	db	"/tmp/lowbat.status", 0x0
	buff:		db	0x0, 0x0
