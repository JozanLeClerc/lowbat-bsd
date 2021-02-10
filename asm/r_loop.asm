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

/***********************************/
/* jo_r_loop(speak (0-1), *argv[]) */
/* ------------------------------- */
/***********************************/

.text
.extern sleep
.extern f_percent
.extern f_status
.extern n_speak
.extern n_notify
.extern r_cpyhead
.globl r_loop

r_loop:
	pushq	%rbp
	pushq	%rbx
	movq	%rsi, %rbx
	movl	%edi, %ebp
	jmp		bigloop

bigloop:
	callq	f_status				/* check the status */
	cmp		$0xfe, %rax				/* if sys_open/sys_read failed */
	je		err
	cmp		$0x3, %rax
	je		sleepalot
	callq	f_percent				/* check the capacity */
	cmp		$0xfe, %rax				/* if sys_open/sys_read failed */
	je		err
	cmp		$0xf, %rax
	jge		sleepalot
	movq	%rax, %rdi
	callq	r_cpyhead				/* notification head */
	movq	%rax, %rdi
	movq	$n_body, %rsi			/* notification body */
	movq	$0x3, %rdx				/* critical notification */
	movq	$0x3a98, %rcx			/* 15000ms notification timeout */
	callq	n_notify				/* n_notify(head: rdi, body: rsi,      */
									/*          urgency: rdx, timeout: rcx */

speak:
	cmp		$0x1, %ebp
	jne		sleepabit
	pushq	%rcx
	movq	$0x8, %rcx
	movq	(%rbx,%rcx,0x2), %rdi
	popq	%rcx
	callq	n_speak

sleepabit:
	movq	$0x14, %rdi
	callq	sleep				/* sleep 20 seconds before next check/notification */
	jmp		bigloop

sleepalot:
	movq	$0xf0, %rdi
	callq	sleep				/* sleep 240s (4m) if it's fine */
	jmp		bigloop

return:
	xorq	%rax, %rax
	retq

err:
	movq	$0x2, %rdi			/* stderr */
	movq	$errmsg, %rsi
	movq	$0x25, %rdx
	movq	$0x4, %rax
	syscall						/* write error message on stderr */
	xorq	%rax, %rax
	retq

.data
	n_body:	.asciz	"Please plug in computer"
	errmsg:	.asciz	"Failed to read battery informations\n"
