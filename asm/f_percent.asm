/* ************************************************************************************ */
/*                                                                                      */
/*  File     : f_percent.asm                                              /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Gets batt remaining capacity                                     |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/* ************************************************************************************ */

.text
	.extern printf
.extern system
.extern atoi
.globl f_percent
.globl main

f_percent:
	movq	$f_cmd, %rdi
	callq	system
	movq	$pr_file, %rdi
	xorq	%rsi, %rsi
	xorq	%rax, %rax
	movb	$0x5, %al				/* sys_open */
	syscall
	jc		err
	movq	%rax, %rdi
	movq	$buff, %rsi
	xorq	%rdx, %rdx
	xorq	%rax, %rax
	movb	$0x3, %dl
	movb	$0x3, %al				/* sys_read */
	syscall
	jc		err
	xorq	%rax, %rax
	movb	$0x6, %al				/* sys_close */
	syscall
	xorq	%rax, %rax
	movq	%rsi, %rdi
	callq	atoi
	retq

err:
	movq	$0xfe, %rax
	retq

.data
	f_cmd:		.asciz "apm -l >/tmp/lowbat.percent"
	pr_file:	.asciz "/tmp/lowbat.percent"
	buff:		.byte 0x0, 0x0, 0x0, 0x0
