/* ************************************************************************************ */
/*                                                                                      */
/*  File     : c_args.asm                                                 /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Check args                                                       |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/* ************************************************************************************ */

/* ******************************* */
/* c_args(argc: rdi, *argv[]: rsi) */
/* ------------------------------- */
/* returns 0 if args are invalid   */
/* returns 1 if args are valid     */
/* ******************************* */

.text
.extern strncmp
.globl c_args

c_args:
	cmp		$0x2, %rdi
	jle		no_args
	xorq	%rax, %rax
	pushq	%rcx
	xorq	%rcx, %rcx
	movb	$0x8, %cl
	movq	(%rsi, %rcx, 2), %rax
	cmpb	$0x0, (%rax)
	je		no_args
	pushq	%rdi
	movq	(%rsi, %rcx, 1), %rdi
	pushq	%rsi
	movq	$reference, %rsi
	pushq	%rdx
	xorq	%rdx, %rdx
	movb	$0x6, %dl
	callq	strncmp
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%rcx
	cmp		$0x0, %rax
	jne		no_args
	xorq	%rax, %rax
	movb	$0x1, %al
	jmp		return

no_args:
	xorq	%rax, %rax

return:
	retq

.data
	reference:	.asciz "--say"
