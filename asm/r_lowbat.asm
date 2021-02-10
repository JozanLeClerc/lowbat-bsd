/****************************************************************************************/
/*                                                                                      */
/*  File     : r_lowbat.asm                                               /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : The main program                                                 |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

.text
.extern c_args
.extern r_loop
.globl main

main:
	callq	c_args
	movq	%rax, %rdi
	callq	r_loop			/* jo_r_loop(speak: 0-1, *argv[]) */

	xorq	%rax, %rax
	xorq	%rdi, %rdi
	mov		$0x1, %rax
	syscall
