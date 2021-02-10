/*
 * ========================
 * =====    ===============
 * ======  ================
 * ======  ================
 * ======  ====   ====   ==
 * ======  ===     ==  =  =
 * ======  ===  =  ==     =
 * =  ===  ===  =  ==  ====
 * =  ===  ===  =  ==  =  =
 * ==     =====   ====   ==
 * ========================
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2020-2021 Joe
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the organization nor the
 *    names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY JOE ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL JOE BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * lowbat: asm/r_loop.S
 * Wed Feb 10 18:27:08 CET 2021
 * Joe
 */

/*
 * jo_r_loop(speak (0-1), *argv[])
 */

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
