section .data
    userMsg db "Enter you number: "
    lenUserMsg equ $ - userMsg
    dispMsg db "You have entered: "
    lenDispMsg equ $ - dispMsg

section .bss 
    num resb 5

section .text
    global _start

_start:
    mov eax, 4              ;
    mov ebx, 1              ;
    mov ecx, userMsg        ; printf("%s", userMsg );
    mov edx, lenUserMsg     ;
    int 80h                 ;

    mov eax, 3              ;
    mov ebx, 2              ;scanf( "%s", num );
    mov ecx, num            ;
    mov edx, 5              ;
    int 80h                 ;
gdbtest:
    mov eax, 4              ;
    mov ebx, 1              ;
    mov ecx, dispMsg        ;   printf( "%s %s", dispMsg, num ); 

    mov edx, lenDispMsg + 5 ;
    int 80h

   ; mov eax, 4              ;
   ; mov ebx, 1              ;
   ; mov ecx, num            ; printf( "%s", num );
   ; mov edx, 5              ;
   ; int 80h
	;mov rax, 0
	mov al, [num+1]
testrax:
    mov eax, 1              ;
    mov edx, 0              ; exit(0);
    int 80h                 ;
