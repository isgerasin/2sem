section .data
    dtype dq 'd'
    strform db "Bin %b, Oct %o, Dec %d, Hex %h", 10, "char %c, str %s, percent %%", 10, "AAAAAAAAAAAAAAAAAAAAAAAAAA%b", 10,"%%",10, ",and %c %s %h %d %%!!!", 0
    msg1 db "Hi, maxX)",  0
    love db "Love", 0
    putcharbuf db '1'
section .bss
    tmp resb 64
    printftmp resb 64
section .text
    global _start
_start:
    mov rax, 101h
    mov rcx, 102h
    mov rdx, 103h
    mov rbx, 104h
    ;mov rsp, 105h
    ;mov rbp, 106h
    mov rsi, 107h
    mov rdi, 108h
    mov r8, 109h
    mov r9, 110h
    mov r10, 111h
    mov r11, 112h
    mov r12, 113h
    mov r13, 114h
    mov r14, 115h
    mov r15, 116h
testrax:
    push 100d
    push 3802d
    push love
    push qword 'I'
    push 1000000000100010101b
    push msg1
    push '$'
    push 0AB32Fh
    push 9876d
    push 321q
    push 10001b
    push strform
    call printf_my 
    add rsp, 9*8

 ;   push qword 'd'
 ;   push tmp
 ;   push 99910001d
 ;   call writewrapper
 ;   pop r8
 ;   pop r8
 ;   pop r8

    mov rax, 60         ;
    mov rdi, 0          ; exit( 0 );
    syscall             ;

;-----------------------------------------------------------
;Function read number from stdin in bin
;Entry: rsi 
;Exit: rax
;Destroy: rdi, rbx, rdx, rcx, r8
;-----------------------------------------------------------
readnumbin:
    
    mov rax, 0              ;
    mov rdi, 2              ;
;    mov rsi, tmp            ; scanf( "%s", tmp );
    mov rdx, 64             ;
    syscall                 ;

    mov rcx, 64                     ;
??L:                                ;   for ( rcx = 64; i > 0; i-- )
    cmp byte [ rsi + rcx - 1], '0'  ;   {
    jb ??ContL                      ;       if ( !( tmp[rcx-1] < '0' || tmp[rcx-1] > '1') )
    cmp byte [ rsi + rcx - 1 ], '1' ;
    ja ??ContL                      ;
    sub byte [ rsi + rcx - 1 ], '0' ;           tmp[rcx-1] -= '0';
??ContL:                            ;
    cmp byte [ rsi + rcx - 1 ], 10  ;       if ( tmp[rcx-1] == '\n' )
    jne ??ContL2                    ;
    mov r8, rcx                     ;           r8 = rcx;
??ContL2:                           ;
    loop ??L                        ;   }



    sub r8, 1               ; r8 -= 1;
    mov rcx, 0              ; rcx = 0;
    mov rax, 0              ; rax = 0;
    mov rbx, 0              ; rbx = 0;
??L2:                         ; do {
    mov bl, [ rsi + rcx ]   ; bl = tmp[ rcx ];
    or rax, rbx             ; rax |= rbx;
    shl rax, 1              ; rax >> 1;
    inc rcx                 ;
    cmp rcx, r8             ; rcx++;
    jb ??L2                   ; }while ( rcx < r )
    shr rax, 1              ;
    ret                     ; return 



;-----------------------------------------------------------
;Function read number from stdin in hex
;Entry: rsi
;Exit: rax
;Destroy: rdi, rbx, rdx
;-----------------------------------------------------------
readnumhex:
    mov rax, 0              ;
    mov rdi, 2              ;
;   mov rsi, tmp            ; scanf( "%s", tmp );
    mov rdx, 16             ;
    syscall                 ;
    
    mov rcx, 0                  ; rcx = 0

tAL:

    cmp byte [ rsi + rcx], 10   ; while ( tmp[rcx] != '\n' )
    je ??Cont                   ; {
    cmp byte [ rsi + rcx], 'A'  ;   if ( tmp[rcx] >= 'A' )
    jae ??Letter                ;       tmp[rcx] -= 55;
    cmp byte [ rsi + rcx], '0'  ;   else if ( tmp[rcx] >= '0' )
    jae ??Num                   ;       tmp[rcx] -= '0';
    jmp ??Cont2                 ;
??Letter:                       ;
    sub byte [ rsi + rcx], 55   ;
    jmp ??Cont2                 ;
??Num:                          ;
    sub byte [ rsi + rcx], '0'  ; 
    jmp ??Cont2                 ; 
    ??Cont2:                    ; 
    inc rcx                     ; rcx++; 
    jmp tAL                     ; } 
    ??Cont: mov r8, rcx 
    ;testrax:                   ;
    ;sub r8, 1                   ; r8 -= 1; 
    mov rcx, 0                  ; rcx = 0;
    mov rax, 0                  ; rax = 0;
    mov rbx, 0                  ; rbx = 0; 
AL2:                            ; do { 
    mov bl, [ rsi + rcx ]       ; bl = tmp[ rcx ]; 
    or rax, rbx                 ; rax |= rbx; 
    shl rax, 4                  ; rax >> 4; 
    inc rcx                     ; 
    cmp rcx, r8                 ; rcx++; 
    jb AL2                      ; }while ( rcx < r ) 
    shr rax, 4                  ;
    ret                         ; return 


;-----------------------------------------------------------
;Function read number from stdin in dec
;Entry: rsi
;Exit: rax
;Destroy: rdi, rbx, rdx
;-----------------------------------------------------------
readnumdec:
    mov rax, 0              ;
    mov rdi, 2              ;
;   mov rsi, tmp            ; scanf( "%s", tmp );
    mov rdx, 16             ;
    syscall                 ;
    
    mov rcx, 0                  ; rcx = 0
    mov rax, 0
.tAL:

    cmp byte [ rsi + rcx], 10   ; while ( tmp[rcx] != '\n' )
    je .Cont                    ; {
    sub byte [ rsi + rcx], '0'  ;   tmp[rcx] -= '0';
    mov rbx, 10                 ;   rax *= 10;
    mul rbx                     ;   rax += tmp[rcx];
    add al, byte [ rsi +rcx ]   ;
    inc rcx                     ; rcx++;
    jmp .tAL                    ; }
.Cont:
    ret                         ; return 

;-----------------------------------------------------------
;Function write number in bin in str
;Entry: rdi ( num ), rsi( str )
;Exit:
;Destroy: rcx, rbx
;-----------------------------------------------------------
writenumbin:                        ;rbx = rdi
    mov rbx, rdi                    ;while (rbx != 0 )
    xor rcx, rcx                    ;{
    jmp .cond                       ;   rbx >> 1;
.body:                              ;   rcx++;
    shr rbx, 1                      ;}
    inc rcx                         ;
.cond:                              ;
    cmp rbx, 0                      ;
    jne .body                       ;

    ;mov byte [ rsi + rcx ], 10      ; rsi[rcx] = '\n';
    mov rax, rcx

.lbody:
    mov rbx, 1                      ;   for ( rcx; rcx != 0; rcx--)
    and rbx, rdi                    ;   {   rbx = 1;
    add bl, '0'                     ;       rbx &= rdi;
    mov byte [ rsi + rcx - 1 ], bl  ;       rbx += '0';
    shr rdi, 1                      ;       rsi[rcx-1] = rbx;
    loop .lbody                     ;       

    ret


;-----------------------------------------------------------
;Function write number in dec in str
;Entry: rdi ( num ), rsi( str )
;Exit:
;Destroy: rax, rcx, rbx, rdx
;-----------------------------------------------------------
writenumdec:                        ;rbx = rdi
    mov rax, rdi                    ;while (rax != 0 )
    xor rcx, rcx
    mov rbx, 10                     ;{
    jmp .cond                       ;   rax /= 10;
.body:                              ;   rcx++;
    xor rdx, rdx
    div ebx                         ;}
    inc rcx                         ;
.cond:                              ;
    cmp rax, 0                      ;
    jne .body                       ;

    ;mov byte [ rsi + rcx ], 10          ; rsi[rcx] = '\n';
    mov r8, rcx
    mov rax, rdi
.lbody:
    xor rdx, rdx                    ;   for ( rcx; rcx != 0; rcx--)
    div ebx                         ;   {   
    add dl, '0'                     ;      rsi[rcx] = arx % 10 + '0'; 
    mov byte [ rsi + rcx - 1 ], dl  ;       arx /= 10;
    loop .lbody                     ;       
    mov rax, r8
    ret

;-----------------------------------------------------------
;Function write number in hex in str
;Entry: rdi ( num ), rsi( str )
;Exit:
;Destroy: rcx, rbx
;-----------------------------------------------------------
writenumhex:                        ;rbx = rdi
    mov rbx, rdi                    ;while (rbx != 0 )
    xor rcx, rcx                    ;{
    jmp .cond                       ;   rbx >> 4
.body:                              ;   rcx++;
    shr rbx, 4                      ;}
    inc rcx                         ;
.cond:                              ;
    cmp rbx, 0                      ;
    jne .body                       ;

    ;mov byte [ rsi + rcx ], 10      ; rsi[rcx] = '\n';
    mov rax, rcx
.lbody:
    mov rbx, 1111b                  ;   for ( rcx; rcx != 0; rcx--)
    and rbx, rdi                    ;   {   rbx = 1111b;
    cmp rbx, 9                      ;       rbx &= rdi;
    jbe .num                        ;       if ( rbx >=9 )
    add bl, 55                      ;           rbx += 'A' - 10;
    jmp .cont                       ;       else 
.num:                               ;           rbx += '0';
    add bl, '0'                     ;
.cont:                              ;
    mov byte [ rsi + rcx - 1 ], bl  ;
    shr rdi, 4                      ;       rsi[rcx-1] = rbx;
    loop .lbody                     ;}
;wwqdwd    

    ;mov rax, 1              ;
    ;mov rdi, 1              ;
   ; mov rsi, rsi            ; printf( "%s", tmp );
    ;mov rdx, r8             ;
    ;syscall  


    ret

;-----------------------------------------------------------
;Function write number in oct in str
;Entry: rdi ( num ), rsi( str )
;Exit:
;Destroy: rcx, rbx
;-----------------------------------------------------------
writenumoct:                        ;rbx = rdi
    mov rbx, rdi                    ;while (rbx != 0 )
    xor rcx, rcx                    ;{
    jmp .cond                       ;   rbx >> 4
.body:                              ;   rcx++;
    shr rbx, 3                      ;}
    inc rcx                         ;
.cond:                              ;
    cmp rbx, 0                      ;
    jne .body                       ;

    ;mov byte [ rsi + rcx ], 10      ; rsi[rcx] = '\n';
    mov rax, rcx
.lbody:
    mov rbx, 111b                  ;   for ( rcx; rcx != 0; rcx--)
    and rbx, rdi                    ;   {   rbx = 1111b;
    add bl, '0'                     ;
.cont:                              ;
    mov byte [ rsi + rcx - 1 ], bl  ;
    shr rdi, 3                      ;       rsi[rcx-1] = rbx;
    loop .lbody                     ;}
;wwqdwd    

    ;mov rax, 1              ;
    ;mov rdi, 1              ;
   ; mov rsi, rsi            ; printf( "%s", tmp );
    ;mov rdx, r8             ;
    ;syscall  


    ret


;-----------------------------------------------------------
;Wrapper for read bin (type = 2), dec (type = 10) and hex (type = 16)
;Entry: byte bp+2*8 ( type ), ptr bp+3*8 ( str )
;Exit: rax
;Destroy:
;-----------------------------------------------------------
readwrapper:
    push rbp
    mov rbp, rsp
    push rsi
    push rdi
    push rbx
    push rdx
    push rcx
    push r8
    mov rsi, [rbp+3*8]      ; rsi = str;
    mov rax, [rbp+2*8]      ; rax = type;
    cmp qword [ rax ], 'b'   ;
    je .Bin                 ;if ( type == 'b' )
    cmp qword [ rax ], 'd'   ;   readnumbin( str );
    je .Dec                 ;else if ( type == 'd' )
    cmp qword [ rax ], 'h'   ;   readnumdec( str );
    je .Hex                 ;else if ( type ==  )
    jmp .Cont               ;   readnumhex( str );
.Bin:                       ;
    call readnumbin         ;return
    jmp .Cont               ;
.Dec:                       ;
    call readnumdec         ;
    jmp .Cont               ;
.Hex:                       ;
    call readnumhex         ;
.Cont:
    
    pop r8
    pop rcx
    pop rdx
    pop rbx
    pop rdi
    pop rsi
    pop rbp
    ret

;-----------------------------------------------------------
;Function sum numbers from stack while number is'n zero
;Entry: Numbers from stack
;Exit: rax
;Destroy: rcx
;-----------------------------------------------------------
sumator2000:
    push rbp
    mov rbp, rsp
    xor rax, rax
    mov rcx, 2*8
jmp .cond
.body:
    add rax, [rbp+rcx]
    add rcx, 8
.cond:
    cmp qword [rbp+rcx], 0
    jne .body
    pop rbp
    ret
;-----------------------------------------------------------
;Wrapper for read bin (type = 'b'), dec (type = 'd') and hex (type = 'h')
;Entry: byte bp+2*8 ( num ), ptr bp+3*8 ( str ), bp+4*8, type
;Exit: rax
;Destroy:
;-----------------------------------------------------------
writewrapper:
    push rbp
    mov rbp, rsp
    push rsi
    push rdi
    push rbx
    push rdx
    push rcx
    push r8
    mov rax, [rbp+4*8]
    mov rsi, [rbp+3*8]      ; rsi = str;
    mov rdi, [rbp+2*8]      ; rax = type;
    cmp rax , 'b'   ;
    je .Bin                 ;if ( type == 'b' )
    cmp rax , 'd'   ;   readnumbin( str );
    je .Dec                 ;else if ( type == 'd' )
    cmp rax , 'h'   ;   readnumdec( str );
    je .Hex                 ;else if ( type == 'h' )readnumhex( str );
    cmp rax, 'c'
    je .Char
    cmp rax, 's'
    je .String
    cmp rax, 'o'
    je .Octo
    jmp .Cont ;
.String:
    mov rax, [rbp+2*8]
    call writestr
    jmp .Cont
.Octo:
    call writenumoct
    jmp .print
.Char:
    mov rbx, [ rbp+2*8]
    call putchar
    jmp .Cont
.Bin:                       ;
    call writenumbin         ;return
    jmp .print               ;
.Dec:                       ;
    call writenumdec         ;
    jmp .print               ;
.Hex:                       ;
    call writenumhex         ;
.print:
;wdwadaw
    mov r8, rax
    mov rax, 1              ;
    mov rdi, 1              ;
    mov rsi, [rbp+3*8]            ; printf( "%s", tmp );
    mov rdx, r8             ;
    syscall 
.Cont:
    pop r8
    pop rcx
    pop rdx
    pop rbx
    pop rdi
    pop rsi
    pop rbp
    ret

;-----------------------------------------------------------
;Write String
;Entry: rax
;Exit: 
;Dextroy:
;-----------------------------------------------------------
writestr:
    push rbp
    mov rbp, rsp

    xor rcx, rcx
    jmp .Cond
.Body:
    inc rcx
.Cond:
    cmp byte [ rax + rcx], 0
    jne .Body

    mov rdi, 1              ;
    mov rsi, rax            ; printf( "%s", tmp );
    mov rdx, rcx           ;
    mov rax, 1              ;
    syscall 
 

    pop rbp
    ret

;-----------------------------------------------------------
;putchar
;Entry: rbx
;Exit: 
;Dextroy:
;-----------------------------------------------------------
putchar:
    
    push rax
    push rdi
    push rsi
    push rdx
    push rcx
    mov rax, 1              ;
    mov rdi, 1              ;
    mov [putcharbuf], bl
    mov rsi, putcharbuf     ;
    mov rdx, 1              ;
    syscall 
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret



;-----------------------------------------------------------
;printf
;Entry: bp+2*8 (str) ... arguments
;Exit: rax
;Destroy: rcx, 
;-----------------------------------------------------------
printf_my:
    push rbp
    mov rbp, rsp
    push rax
    push r11
    push rcx
    push r8
    push r15
    push rbx
    xor rcx, rcx
    mov r8, 8d
    mov r15, [  rbp+2*8 ]
    jmp .cond
.body:
    cmp byte [ r15 +rcx] , '%'  ;
    je .wrap                    ;
    mov bl, [ r15 + rcx ]       ;
    call putchar                ;
    jmp .cont                   ;
.wrap:                          ;
    inc rcx                     ;
    xor rbx, rbx                ;
    cmp byte [ r15+rcx], '%'    ;
    jne .Notperc                ;
    mov bl, '%'                 ;
    call putchar                ;
    jmp .cont                   ;
.Notperc:                       ;
    mov bl, [ r15 +rcx]         ;
    push rbx                    ;
    push printftmp              ;
    push qword [ rbp+2*8 + r8 ] ;
    call writewrapper           ;
    ;pop r14                    ;
    add rsp, 3*8                ;
    ;pop r14                    ;
    ;pop r14                    ;
                                ;
    add r8, 8d                  ;
.cont:                          ;
    inc rcx                     ;
.cond:                          ;
    cmp byte [ r15 + rcx ], 0d  ;
    jne .body
    pop rbx
    pop r15
    pop r8
    pop rcx
    pop r11
    pop rax
    pop rbp
    ret

