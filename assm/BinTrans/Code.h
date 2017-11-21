
DEF_CMD( PUSH, 10, 2,
	{Write_Double( my->data[My_pos+1] COMMA THIS_ADR + 2);
	Write_Int( Tmp_adr COMMA THIS_ADR + 14);
	Write_Int( Tmp_adr COMMA THIS_ADR + 21); },
	"\x48\xb8\x00\x00\x00\x00\x00\x00\x00\x00" //movabs rax, <number>
	"\x48\x89\x04\x25\x00\x00\x00\x00"         //mov [tmp], rax
	"\xdd\x04\x25\x00\x00\x00\x00",			   //fld qword [tmp] 
	25 )

DEF_CMD( PUSHR, 11, 2,
	{Write_Int( 8*('a' - my->data[My_pos+1]) +/*-*/   Val_cntr  COMMA THIS_ADR + 2); },
	"\xdd\x85\x00\x00\x00\x00", // fld qword [rbp + RegID]
	6 )

DEF_CMD( POPR, 12, 2,
	{Write_Int( 8*('a' - my->data[My_pos+1]) +/*-*/   Val_cntr  COMMA THIS_ADR + 2); },
	"\xdd\x9d\x00\x00\x00\x00", // fstp qword [rbp + RegID]
	6 )

DEF_CMD( JMP, 13, 2,
	{;},
	"\xe9\x00\x00\x00\x00", //jmp adr
	5 )

DEF_CMD( JE, 14, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x84\x00\x00\x00\x00", // je
	16 )

DEF_CMD( JNE, 15, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x85\x00\x00\x00\x00", // jne
	16 )

DEF_CMD( JA, 16, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x87\x00\x00\x00\x00", // ja
	16 )

DEF_CMD( JB, 17, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x82\x00\x00\x00\x00", // jb
	16 )

DEF_CMD( JAE, 18, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x83\x00\x00\x00\x00", // jae
	16 )

DEF_CMD( JBE, 19, 2,
	{;},	
	"\xd9\xc9"				 	// fxch
	"\xd8\xd1"					// fcom
	"\x9b"      				// wait
	"\xdf\xe0"					// fnstsw ax
	"\x9e"     					// sahf
	"\xd9\xc9"					// fxch
	"\x0f\x86\x00\x00\x00\x00", // jbe
	16 )

DEF_CMD( CALL, 20, 2,
	{memmove(THIS_ADR + 3 COMMA &stFrame, 1);
	memmove(THIS_ADR + 17 COMMA &stFrame, 1);},

	"\x48\x83\xec\x00"		//sub rsp, Val_cntr
	"\x55"					//push rbp
	"\x48\x89\xe5"			//mov rbp, rsp
	"\xe8\x00\x00\x00\x00"	//call 
	"\x5d"					//pop rbp
	"\x48\x83\xc4\x00",		//add rsp, Val_cntr
	18 )

DEF_CMD( POP, 100, 1,
	{Write_Int( Tmp_adr COMMA THIS_ADR + 3); },
	"\xdd\x1c\x25\x00\x00\x00\x00", // fstp [tmp]
	7 )

DEF_CMD( ADD, 101, 1,
	{;},
	"\xde\xc1", // fadd
	2 )

DEF_CMD( SUB, 102, 1,
	{;},
	"\xde\xe9", // fsub
	2 )

DEF_CMD( MUL, 103, 1,
	{;},
	"\xde\xc9", // fmul 
	2 )

DEF_CMD( DIV, 104, 1,
	{;},
	"\xde\xf9", // fdiv
	2 )

DEF_CMD( IN, 105,  1, 
	{Write_Int(  (In_pos - x86_pos - 5) COMMA THIS_ADR + 1 ); },
	"\xe8\x00\x00\x00\x00", //call in
	5 )

DEF_CMD( OUT, 106, 1, 
	{Write_Int( (Out_pos - x86_pos - 5) COMMA THIS_ADR + 1 ); },
	"\xe8\x00\x00\x00\x00", //call out 
	5 )

DEF_CMD( NOP, 107, 1,
	{;},
	"\x90", // nop
	1 )

DEF_CMD( SQRT, 108, 1,
	{;},
	"\xd9\xfa", // fsqrt
	2 )

DEF_CMD( SIN, 109, 1,
	{;},
	"\xd9\xfe", // fsin
	2 )

DEF_CMD( COS, 110, 1,
	{;},
	"\xd9\xff", // fscos
	2 )

DEF_CMD( COS, 110, 1,
	{;},
	"\xd9\xff", // fscos
	2 )

DEF_CMD( END, 112, 1,
	{;},
	"\xb8\x3c\x00\x00\x00" // mov eax, 3ch
	"\xbf\x00\x00\x00\x00" // mov edi, 0
	"\x0f\x05",			   // syscall
	12 )

DEF_CMD( RET, 111, 1,
	{;},
	"\xc3",
	1)

DEF_CMD( E, 113, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b" //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x74\x04" // je true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

DEF_CMD( A, 115, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b" //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x77\x04" // ja true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

DEF_CMD( B, 116, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b" //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x72\x04" // jb true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

DEF_CMD( AE, 117, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b" //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x73\x04" // jae true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

DEF_CMD( BE, 113, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b" //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x76\x04" // jbe true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

DEF_CMD( NE, 119, 1,
	{;},
	"\xd9\xc9" // fxch
	"\xde\xd9" // fcompp
	"\x9b"     //wait
	"\xdf\xe0" // fnstsw ax
	"\x9e"     // sahf
	"\x75\x04" // jne true
	"\xd9\xee" // fldz
	"\xeb\x02" // jmp cont
	"\xd9\xe8" // true: fld1 cont:
	"",
	16 )

