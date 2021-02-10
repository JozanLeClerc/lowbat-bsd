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
 * lowbat: asm/c_args.S
 * Wed Feb 10 18:23:00 CET 2021
 * Joe
 */

/*
 * c_args(argc: rdi, *argv[]: rsi)
 * -------------------------------
 * returns 0 if args are invalid
 * returns 1 if args are valid
 */

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
