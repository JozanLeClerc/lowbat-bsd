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

.text
.extern sprintf
.globl r_cpyhead

r_cpyhead:
	movq	$buff, %rdi
	movq	$n_head, %rsi
	xorq	%rax, %rax
	callq	sprintf
	movq	$buff, %rax
	retq

.data
	n_head:	.asciz	"Low battery: %d%%"

.bss
	buff:	.zero 0x11
