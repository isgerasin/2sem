	.file	"main.c"
	.intel_syntax noprefix
	.globl	s
	.data
	.align 8
	.type	s, @object
	.size	s, 8
s:
	.long	3367254360
	.long	1072938614
	.section	.rodata
.LC0:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	rax, QWORD PTR s[rip]
	mov	QWORD PTR [rbp-8], rax
	movsd	xmm0, QWORD PTR [rbp-8]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 1
	call	printf
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
