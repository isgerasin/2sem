section .data
	frmt db "wdw%d!!fej%x %s", 10, 0
	stri db "rt!!!!!!", 0

section .text
	extern printf 
	global _start
_start:
	mov rcx, stri
	mov rdx, 56h
	mov rsi, 34d
	mov rdi, frmt
	mov rax, 0
	call printf

	mov rax, 60         
    mov rdi, 0  
	syscall

