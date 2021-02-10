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
 * lowbat: asm/f_percent.S
 * Wed Feb 10 18:23:30 CET 2021
 * Joe
 */

.text
.extern system
.extern atoi
.globl f_percent

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
	f_cmd:		.asciz	"apm -l >/tmp/lowbat.percent"
	pr_file:	.asciz	"/tmp/lowbat.percent"
	buff:		.byte	0x0, 0x0, 0x0, 0x0
