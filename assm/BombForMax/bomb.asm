section .data 
	login db "Login:" 
	loglen equ $ - login 
	password db "Password:" 
	passlen equ $ - password 
	canary db "CANARY" 
	superuser db "You are the best of the best!!!", 10d 
	superlen equ $ - superuser 
	hash dq 3D3943434F3D49h 
	hashps dq 3143433D2F2F2Fh

section .bss 
	msg1 resb 10

	section .text
    global _start
_start:
	mov rax, 1
    mov rdi, 1
    mov rsi, login
    mov rdx, loglen
    syscall

    mov rbx, msg1
    call getlog
    mov r9, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, password
    mov rdx, passlen
    syscall

	call getpswd
	mov r9, 1
	and r9, rbx
    cmp r9, 1
    je .super
    mov rax, 60d
    mov rdi, 0
    syscall
.super:
    mov rax, 1
    mov rdi, 1
    mov rsi, superuser
    mov rdx, superlen
    syscall
    mov rax, 60d
    mov rdi, 0
    syscall

;-------------------------------------------------
;gets()
;Input: rbx( str )
;Exit: rax
;Destroy: rbx, rax
;-------------------------------------------------
getlog:
	push rbp
	mov rbp, rsp
	push rcx

	mov rax, 0
	mov rdi, 0
	mov rcx, rbp
	sub rcx, 18
	mov rsi, msg1
	mov rdx, 10 
	syscall
	mov rax, 0
	mov r14, hash
	mov r15, msg1
	call check
	pop rcx
	pop rbp
	ret
	

;-------------------------------------------------
;get & check password
;Input:
;Exit: rbx( 1 - ok, 0 - worse )
;Destroy:
;-------------------------------------------------
getpswd:
    push rbp
	mov rbp, rsp
	
	push canary
	mov rax, 0
	mov rdi, 0
	mov rcx, rbp
	sub rcx, 16d
	mov rsi, rcx
	mov rdx, 32d
	syscall
    xor rbx, rbx
	cmp qword [ rsp ], canary
	je .end
    mov rax, 60d
    mov rdi, 1
    syscall
	
.end:
	pop rbx
	;mov rbx, 1
	mov r15, rsi; msg
	mov r14, hashps;hash
	call check
	mov rbx, rax
	pop rbp
    ret


;-------------------------------------------------
;check login
;Input:
;Exit:  rax ( 1 true, 0 false )
;Destroy: sdi rcx
;-------------------------------------------------
check:
    xor rdx, rdx
	xor rax, rax
	mov rcx, 7
.loop:
	mov r8, 7
	sub r8, rcx
	mov dl, byte [ r15 + r8 ] ;msg1 
	shl rax, 8
	or rax, rdx
	sub rax, 10h
	LOOP .loop
	cmp rax, qword [r14] ; hash
	je .good
	mov rax, 0
	jmp .end
.good:
	mov rax, 1
.end:
    ret
