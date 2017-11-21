	.file	"prinntf.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"fcdvc"
.LC1:
	.string	"wwdgcyw%d wduyw%x %s"
	.text
	.globl	go
	.type	go, @function
go:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	ecx, OFFSET FLAT:.LC0
	mov	edx, 23
	mov	esi, 67
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	go, .-go
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
