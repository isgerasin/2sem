	.file	"HashTbl.c"
	.intel_syntax noprefix
	.globl	FuncCount
	.bss
	.align 4
	.type	FuncCount, @object
	.size	FuncCount, 4
FuncCount:
	.zero	4
	.globl	HashPrev
	.align 4
	.type	HashPrev, @object
	.size	HashPrev, 4
HashPrev:
	.zero	4
	.section	.rodata
.LC0:
	.string	"HashTbl.c"
.LC1:
	.string	"fl1"
	.text
	.globl	File_Len
	.type	File_Len, @function
File_Len:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	cmp	QWORD PTR [rbp-24], 0
	jne	.L2
	mov	ecx, OFFSET FLAT:__PRETTY_FUNCTION__.3266
	mov	edx, 13
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC1
	call	__assert_fail
.L2:
	mov	rax, QWORD PTR [rbp-24]
	mov	edx, 2
	mov	esi, 0
	mov	rdi, rax
	call	fseek
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	ftell
	mov	DWORD PTR [rbp-8], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	edx, 0
	mov	esi, 0
	mov	rdi, rax
	call	fseek
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	ftell
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-8]
	sub	eax, DWORD PTR [rbp-4]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	File_Len, .-File_Len
	.globl	HashTble_ok
	.type	HashTble_ok, @function
HashTble_ok:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	cmp	QWORD PTR [rbp-24], 0
	je	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	eax, -1413829702
	jne	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+20]
	cmp	eax, -1413829702
	jne	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	test	eax, eax
	js	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	test	rax, rax
	je	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	sub	rax, 64
	mov	rdi, rax
	call	List_ok
	test	eax, eax
	je	.L5
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	cdqe
	sal	rax, 6
	add	rax, rdx
	mov	rdi, rax
	call	List_ok
	test	eax, eax
	jne	.L6
.L5:
	mov	eax, 0
	jmp	.L7
.L6:
	mov	DWORD PTR [rbp-4], 0
	jmp	.L8
.L10:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-4]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	rdi, rax
	call	List_ok
	test	eax, eax
	jne	.L9
	mov	eax, 0
	jmp	.L7
.L9:
	add	DWORD PTR [rbp-4], 1
.L8:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	cmp	eax, DWORD PTR [rbp-4]
	jg	.L10
	mov	eax, 1
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	HashTble_ok, .-HashTble_ok
	.section	.rodata
.LC2:
	.string	"htbl"
.LC3:
	.string	"ABBAABBA"
.LC4:
	.string	"List_ctor( tmp, \"ABBAABBA\" )"
	.align 8
.LC5:
	.string	"List_ctor( tmp + len , \"ABBAABBA\" )"
.LC6:
	.string	"%d"
.LC7:
	.string	"Hash%d"
	.text
	.globl	HashTble_ctor
	.type	HashTble_ctor, @function
HashTble_ctor:
.LFB4:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 2112
	mov	QWORD PTR [rbp-2104], rdi
	mov	DWORD PTR [rbp-2108], esi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rbp-8], rax
	xor	eax, eax
	cmp	QWORD PTR [rbp-2104], 0
	jne	.L12
	mov	ecx, OFFSET FLAT:__PRETTY_FUNCTION__.3280
	mov	edx, 51
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC2
	call	__assert_fail
.L12:
	add	DWORD PTR [rbp-2108], 1
	mov	rax, QWORD PTR [rbp-2104]
	mov	DWORD PTR [rax], -1413829702
	mov	rax, QWORD PTR [rbp-2104]
	mov	DWORD PTR [rax+20], -1413829702
	mov	eax, DWORD PTR [rbp-2108]
	add	eax, 2
	cdqe
	mov	esi, 64
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-2088], rax
	cmp	QWORD PTR [rbp-2088], 0
	jne	.L13
	mov	eax, 0
	jmp	.L19
.L13:
	mov	rax, QWORD PTR [rbp-2104]
	mov	edx, DWORD PTR [rbp-2108]
	mov	DWORD PTR [rax+16], edx
	mov	rax, QWORD PTR [rbp-2088]
	mov	esi, OFFSET FLAT:.LC3
	mov	rdi, rax
	call	List_ctor
	test	eax, eax
	jne	.L15
	mov	ecx, OFFSET FLAT:__PRETTY_FUNCTION__.3280
	mov	edx, 59
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC4
	call	__assert_fail
.L15:
	add	QWORD PTR [rbp-2088], 64
	mov	eax, DWORD PTR [rbp-2108]
	cdqe
	sal	rax, 6
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-2088]
	add	rax, rdx
	mov	esi, OFFSET FLAT:.LC3
	mov	rdi, rax
	call	List_ctor
	test	eax, eax
	jne	.L16
	mov	ecx, OFFSET FLAT:__PRETTY_FUNCTION__.3280
	mov	edx, 61
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC5
	call	__assert_fail
.L16:
	mov	rax, QWORD PTR [rbp-2104]
	mov	rdx, QWORD PTR [rbp-2088]
	mov	QWORD PTR [rax+8], rdx
	lea	rdx, [rbp-2064]
	mov	eax, 0
	mov	ecx, 256
	mov	rdi, rdx
	rep stosq
	mov	rdx, rdi
	mov	BYTE PTR [rdx], al
	add	rdx, 1
	lea	rax, [rbp-2064]
	mov	edx, 2049
	mov	esi, OFFSET FLAT:.LC6
	mov	rdi, rax
	mov	eax, 0
	call	sprintf
	cdqe
	mov	QWORD PTR [rbp-2080], rax
	mov	DWORD PTR [rbp-2092], 0
	jmp	.L17
.L18:
	mov	rax, QWORD PTR [rbp-2080]
	add	rax, 5
	mov	esi, 1
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-2072], rax
	mov	edx, DWORD PTR [rbp-2092]
	mov	rax, QWORD PTR [rbp-2072]
	mov	esi, OFFSET FLAT:.LC7
	mov	rdi, rax
	mov	eax, 0
	call	sprintf
	mov	rax, QWORD PTR [rbp-2104]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-2092]
	movsx	rdx, edx
	sal	rdx, 6
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-2072]
	mov	rsi, rax
	mov	rdi, rdx
	call	List_ctor
	add	DWORD PTR [rbp-2092], 1
.L17:
	mov	eax, DWORD PTR [rbp-2092]
	cmp	eax, DWORD PTR [rbp-2108]
	jl	.L18
	mov	rax, QWORD PTR [rbp-2104]
	mov	rdi, rax
	call	HashTble_ok
.L19:
	mov	rcx, QWORD PTR [rbp-8]
	xor	rcx, QWORD PTR fs:40
	je	.L20
	call	__stack_chk_fail
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	HashTble_ctor, .-HashTble_ctor
	.globl	HashTble_dump
	.type	HashTble_dump, @function
HashTble_dump:
.LFB5:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-4], 0
	jmp	.L22
.L23:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-4]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	rdi, rax
	call	List_out
	add	DWORD PTR [rbp-4], 1
.L22:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	cmp	eax, DWORD PTR [rbp-4]
	jg	.L23
	mov	eax, 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	HashTble_dump, .-HashTble_dump
	.globl	HashTble_dtor
	.type	HashTble_dtor, @function
HashTble_dtor:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-4], 0
	jmp	.L26
.L27:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-4]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	rdi, rax
	call	List_dtor
	add	DWORD PTR [rbp-4], 1
.L26:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	cmp	eax, DWORD PTR [rbp-4]
	jg	.L27
	mov	eax, 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	HashTble_dtor, .-HashTble_dtor
	.section	.rodata
.LC8:
	.string	"w"
.LC9:
	.string	"graph_HTble.gv"
	.align 8
.LC10:
	.string	"digraph Tabe\n{\n\tedge[dir=both]\n\t"
	.align 8
.LC11:
	.string	"{node[shape = polygon]; rank = same;\n"
.LC12:
	.string	"\t\t\"%s=%d\";\n"
.LC13:
	.string	"\t}\n"
.LC14:
	.string	"\t\"%s=%d\"->\"%s=%d\";\n"
.LC15:
	.string	"i"
.LC16:
	.string	"}\n"
	.align 8
.LC17:
	.string	"\"C:/Program Files (x86)/Graphviz2.38/bin/dot.exe\" -Tsvg -O graph_HTble.gv"
.LC18:
	.string	"firefox graph_HTble.gv.svg"
	.text
	.globl	HashTble_dump_dot
	.type	HashTble_dump_dot, @function
HashTble_dump_dot:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	esi, OFFSET FLAT:.LC8
	mov	edi, OFFSET FLAT:.LC9
	call	fopen
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	jne	.L30
	mov	eax, 0
	jmp	.L31
.L30:
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, rax
	mov	edx, 32
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC10
	call	fwrite
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, rax
	mov	edx, 37
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC11
	call	fwrite
	mov	DWORD PTR [rbp-32], 0
	jmp	.L32
.L33:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-32]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	ecx, DWORD PTR [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-32]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC12
	mov	rdi, rax
	mov	eax, 0
	call	fprintf
	add	DWORD PTR [rbp-32], 1
.L32:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+16]
	cmp	eax, DWORD PTR [rbp-32]
	jg	.L33
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, rax
	mov	edx, 3
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC13
	call	fwrite
	mov	DWORD PTR [rbp-28], 0
	jmp	.L34
.L39:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-28]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	rax, QWORD PTR [rax+32]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-28]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	add	rax, 8
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	edi, DWORD PTR [rax+40]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	rsi, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	ecx, DWORD PTR [rax+40]
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	r9d, edi
	mov	r8, rsi
	mov	esi, OFFSET FLAT:.LC14
	mov	rdi, rax
	mov	eax, 0
	call	fprintf
	jmp	.L35
.L38:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-24], rax
	cmp	QWORD PTR [rbp-24], 0
	jne	.L36
	mov	ecx, OFFSET FLAT:__PRETTY_FUNCTION__.3314
	mov	edx, 127
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC15
	call	__assert_fail
.L36:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	edi, DWORD PTR [rax+40]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	rsi, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	ecx, DWORD PTR [rax+40]
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	r9d, edi
	mov	r8, rsi
	mov	esi, OFFSET FLAT:.LC14
	mov	rdi, rax
	mov	eax, 0
	call	fprintf
.L35:
	mov	rax, QWORD PTR [rbp-24]
	cmp	rax, QWORD PTR [rbp-8]
	je	.L37
	cmp	QWORD PTR [rbp-24], 0
	jne	.L38
.L37:
	add	DWORD PTR [rbp-28], 1
.L34:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+16]
	cmp	eax, DWORD PTR [rbp-28]
	jg	.L39
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, rax
	mov	edx, 2
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC16
	call	fwrite
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	fclose
	mov	edi, OFFSET FLAT:.LC17
	call	system
	mov	edi, OFFSET FLAT:.LC18
	call	system
	mov	eax, 1
.L31:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	HashTble_dump_dot, .-HashTble_dump_dot
	.section	.rodata
.LC19:
	.string	" .,\n[]\"!?';:"
	.text
	.globl	HashTble_DoTest
	.type	HashTble_DoTest, @function
HashTble_DoTest:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	QWORD PTR [rbp-56], rdx
	mov	eax, DWORD PTR FuncCount[rip]
	add	eax, 1
	mov	DWORD PTR FuncCount[rip], eax
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, OFFSET FLAT:.LC19
	mov	rdi, rax
	call	strtok
	mov	QWORD PTR [rbp-24], rax
	mov	DWORD PTR [rbp-32], 1
	jmp	.L41
.L48:
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-56]
	mov	rdi, rdx
	call	rax
	mov	DWORD PTR [rbp-28], eax
	call	__ctype_b_loc
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rax
	add	rax, rdx
	movzx	eax, WORD PTR [rax]
	movzx	eax, ax
	and	eax, 1024
	test	eax, eax
	je	.L42
	call	__ctype_b_loc
.L42:
	mov	edx, DWORD PTR [rbp-28]
	mov	rcx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, rcx
	mov	rdi, rax
	call	HashTble_Found
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	jne	.L43
	mov	esi, 48
	mov	edi, 1
	call	calloc
	mov	QWORD PTR [rbp-8], rax
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	ListElem_ctor
	test	eax, eax
	jne	.L44
	mov	eax, 0
	jmp	.L45
.L44:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-28]
	sal	rdx, 6
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rax
	mov	rdi, rdx
	call	ListElem_add_end
	test	eax, eax
	jne	.L46
	mov	eax, 0
	jmp	.L45
.L46:
	add	DWORD PTR [rbp-32], 1
	jmp	.L47
.L43:
	mov	rax, QWORD PTR [rbp-16]
	mov	eax, DWORD PTR [rax+40]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax+40], edx
.L47:
	mov	esi, OFFSET FLAT:.LC19
	mov	edi, 0
	call	strtok
	mov	QWORD PTR [rbp-24], rax
.L41:
	cmp	QWORD PTR [rbp-24], 0
	jne	.L48
	mov	eax, 1
.L45:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	HashTble_DoTest, .-HashTble_DoTest
	.section	.rodata
.LC20:
	.string	"wer"
	.text
	.globl	HashTble_Found
	.type	HashTble_Found, @function
HashTble_Found:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 72
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-56], rdi
	mov	QWORD PTR [rbp-64], rsi
	mov	DWORD PTR [rbp-68], edx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-68]
	movsx	rdx, edx
	sal	rdx, 6
	add	rax, rdx
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-40]
	add	rax, 8
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
	mov	edi, OFFSET FLAT:.LC20
	call	puts
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rbp-64]
	mov	rdi, QWORD PTR [rbp-32]
#APP
# 222 "HashTbl.c" 1
	mov rcx, rdi
	.Body:
	cmp rax, rcx
	je .Body.End
	mov rcx, [rcx + 24]
	mov rdx, rsi
	mov rbx, rcx
	add rbx, 8
	call my_strcmp
	cmp rax, 0
	jne .Body
	mov rax, rcx
	ret
	.Body.End:
	mov rax, 0
	pop rbp
	ret
	my_strcmp:
	mov rax, 1
.Cycle:
	mov cl, [rdx]
	cmp cl, [rbx]
	jne .End
	cmp cl, 0
	inc rdx
	inc rbx
	jne .Cycle
	mov rax, 0
.End:
	ret

# 0 "" 2
#NO_APP
	mov	edi, OFFSET FLAT:.LC20
	call	puts
	nop
	add	rsp, 72
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	HashTble_Found, .-HashTble_Found
	.globl	Hash_Func_1
	.type	Hash_Func_1, @function
Hash_Func_1:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, 0
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	Hash_Func_1, .-Hash_Func_1
	.globl	Hash_Func_2
	.type	Hash_Func_2, @function
Hash_Func_2:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	movsx	ecx, al
	movsx	rsi, ecx
	mov	rdx, rsi
	mov	rax, rdx
	sal	rax, 11
	mov	rdx, rax
	mov	rax, rdx
	sal	rax, 11
	sub	rax, rdx
	add	rax, rsi
	shr	rax, 32
	mov	edx, eax
	sar	edx
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 11
	add	edx, eax
	mov	eax, ecx
	sub	eax, edx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	Hash_Func_2, .-Hash_Func_2
	.globl	Hash_Func_3
	.type	Hash_Func_3, @function
Hash_Func_3:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	strlen
	mov	rcx, rax
	movabs	rdx, -9002803354665471
	mov	rax, rcx
	mul	rdx
	mov	rax, rdx
	shr	rax, 11
	mov	rdx, rax
	sal	rdx, 11
	add	rdx, rax
	mov	rax, rcx
	sub	rax, rdx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	Hash_Func_3, .-Hash_Func_3
	.globl	Hash_Func_4
	.type	Hash_Func_4, @function
Hash_Func_4:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-8], 0
	mov	DWORD PTR [rbp-4], 0
	jmp	.L57
.L58:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	add	DWORD PTR [rbp-8], eax
	add	DWORD PTR [rbp-4], 1
.L57:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L58
	mov	ecx, DWORD PTR [rbp-8]
	movsx	rsi, ecx
	mov	rdx, rsi
	mov	rax, rdx
	sal	rax, 11
	mov	rdx, rax
	mov	rax, rdx
	sal	rax, 11
	sub	rax, rdx
	add	rax, rsi
	shr	rax, 32
	mov	edx, eax
	sar	edx
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 11
	add	edx, eax
	mov	eax, ecx
	sub	eax, edx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	Hash_Func_4, .-Hash_Func_4
	.globl	Hash_Func_5
	.type	Hash_Func_5, @function
Hash_Func_5:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	Hash_Func_4
	mov	ebx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	strlen
	mov	rsi, rax
	mov	rax, rbx
	mov	edx, 0
	div	rsi
	mov	rcx, rax
	movabs	rdx, -9002803354665471
	mov	rax, rcx
	mul	rdx
	mov	rax, rdx
	shr	rax, 11
	mov	rdx, rax
	sal	rdx, 11
	add	rdx, rax
	mov	rax, rcx
	sub	rax, rdx
	add	rsp, 24
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	Hash_Func_5, .-Hash_Func_5
	.globl	rol
	.type	rol, @function
rol:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR [rbp-4], edi
	mov	eax, DWORD PTR [rbp-4]
	and	eax, 1
	test	eax, eax
	je	.L63
	shr	DWORD PTR [rbp-4]
	or	DWORD PTR [rbp-4], -2147483648
	jmp	.L64
.L63:
	shr	DWORD PTR [rbp-4]
.L64:
	mov	eax, DWORD PTR [rbp-4]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	rol, .-rol
	.globl	Hash_Func_6_asm
	.type	Hash_Func_6_asm, @function
Hash_Func_6_asm:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 40
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-40], rdi
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	strlen
	mov	DWORD PTR [rbp-24], eax
	mov	DWORD PTR [rbp-20], 0
	mov	rsi, QWORD PTR [rbp-40]
	mov	edi, DWORD PTR [rbp-24]
#APP
# 325 "HashTbl.c" 1
	.intel_syntax noprefix
	mov ecx, edi
	mov rdx, rsi
	mov ebx, 0
.LOOP_MY:
	ror ebx, 1
	mov al, [rdx]
	inc rdx
	xor ebx, eax
	loop .LOOP_MY
	mov esi, ebx
	
# 0 "" 2
#NO_APP
	mov	DWORD PTR [rbp-20], esi
	mov	ecx, DWORD PTR [rbp-20]
	mov	esi, ecx
	mov	rdx, rsi
	mov	rax, rdx
	sal	rax, 11
	mov	rdx, rax
	mov	rax, rdx
	sal	rax, 11
	sub	rax, rdx
	add	rax, rsi
	shr	rax, 32
	shr	eax
	mov	edx, eax
	sal	edx, 11
	add	edx, eax
	mov	eax, ecx
	sub	eax, edx
	add	rsp, 40
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	Hash_Func_6_asm, .-Hash_Func_6_asm
	.globl	Hash_Func_6
	.type	Hash_Func_6, @function
Hash_Func_6:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	strlen
	mov	DWORD PTR [rbp-12], eax
	mov	DWORD PTR [rbp-16], 0
	mov	QWORD PTR [rbp-8], 0
	jmp	.L69
.L70:
	mov	eax, DWORD PTR [rbp-16]
	mov	edi, eax
	call	rol
	mov	ecx, eax
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-8]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	xor	eax, ecx
	mov	DWORD PTR [rbp-16], eax
	add	QWORD PTR [rbp-8], 1
.L69:
	mov	eax, DWORD PTR [rbp-12]
	cmp	rax, QWORD PTR [rbp-8]
	ja	.L70
	mov	ecx, DWORD PTR [rbp-16]
	mov	esi, ecx
	mov	rdx, rsi
	mov	rax, rdx
	sal	rax, 11
	mov	rdx, rax
	mov	rax, rdx
	sal	rax, 11
	sub	rax, rdx
	add	rax, rsi
	shr	rax, 32
	shr	eax
	mov	edx, eax
	sal	edx, 11
	add	edx, eax
	mov	eax, ecx
	sub	eax, edx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	Hash_Func_6, .-Hash_Func_6
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3266, @object
	.size	__PRETTY_FUNCTION__.3266, 9
__PRETTY_FUNCTION__.3266:
	.string	"File_Len"
	.align 8
	.type	__PRETTY_FUNCTION__.3280, @object
	.size	__PRETTY_FUNCTION__.3280, 14
__PRETTY_FUNCTION__.3280:
	.string	"HashTble_ctor"
	.align 16
	.type	__PRETTY_FUNCTION__.3314, @object
	.size	__PRETTY_FUNCTION__.3314, 18
__PRETTY_FUNCTION__.3314:
	.string	"HashTble_dump_dot"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
