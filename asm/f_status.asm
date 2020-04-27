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

.text
.extern system
.globl f_status

f_status:
	movq	$f_cmd, %rdi
	callq	system
	movq	$st_file, %rdi
	xorq	%rsi, %rsi
	xorq	%rax, %rax
	movb	$0x5, %al				/* sys_open */
	syscall
	jc		err
	movq	%rax, %rdi
	movq	$buff, %rsi
	xorq	%rdx, %rdx
	xorq	%rax, %rax
	movb	$0x1, %dl
	movb	$0x3, %al				/* sys_read */
	syscall
	jc		err
	xorq	%rax, %rax
	movb	$0x6, %al				/* sys_close */
	syscall
	xorq	%rax, %rax
	movb	(%rsi), %al
	subb	$0x30, %al
	retq

err:
	xorq	%rax, %rax
	movb	$0xfe, %al
	retq

.data
	f_cmd:		.asciz	"apm -b >/tmp/lowbat.status"
	st_file:	.asciz	"/tmp/lowbat.status"
	buff:		.byte	0x0, 0x0
