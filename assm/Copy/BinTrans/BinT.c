#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <malloc.h>
#include <stdint.h>
#include <elf.h>
#include "BinT.h"

#define THIS_ADR (run->data + x86_pos)

Elf32_Ehdr hdr = {};

int My_Ins_ok( My_Ins* this )
{
	return this && this->data != NULL;
}

int My_Ins_dump( My_Ins* this )
{

	fprintf( stderr, "==========================\n" );
	if ( this == NULL )
		fprintf( stderr, "My_Inst [NULL]\n" );
	else 
		fprintf( stderr, "My_Inst [%p]\n"
						 "data = %p\n"
						 "datalen = %lu\n",
						 this, this->data, this->datalen);
		if ( this->data != NULL )
			for ( size_t i = 0; i < this->datalen ; i++ )
					fprintf( stderr, "\tdata[%5lu] = %lg\n",
							i, this->data[i]);

	fprintf( stderr, "==========================\n" );
	
}

My_Ins* My_Ins_ctor( double* data, size_t len )
{
	IS_NULL( data )
	
	My_Ins* new = ( My_Ins*) calloc( 1, sizeof( *new ) );
	IS_NULL( new );

	new->data = data;
	size_t i = 0;
	
	new->datalen = len;

	return new;

}

My_Ins* My_Ins_new( size_t len )
{
	double* data = ( double* ) calloc( len, sizeof( *data ));
	IS_NULL( data )
	return My_Ins_ctor( data, len );
}

int My_Ins_dtor( My_Ins* this )
{
	free( this->data );
	this->data = NULL;
	free( this );		
}

size_t File_len( FILE* fl )
{
	assert( fl );

	fseek( fl, 0, SEEK_END );
	size_t len = ftell( fl );
	fseek( fl, 0, SEEK_SET );

	return len;
}

My_Ins* My_Ins_Load( const char* fname )
{
	IS_NULL( fname )

	FILE* input = fopen( fname, "rb" );
	IS_NULL( input )
	
	size_t len = File_len( input );
	len = len / sizeof( double) + 1 ;

	double* data = ( double* ) calloc( len, sizeof( *data ));

	fread( data, sizeof(*data ), len, input );
	fclose( input );

	return My_Ins_ctor( data, len );
}

int x86_Ins_ok( x86_Ins* this )
{
	return this && this->data != NULL;
}

int x86_Ins_dump( x86_Ins* this )
{
	fprintf( stderr, "==========================\n" );
	if ( this == NULL )
		fprintf( stderr, "My_Inst [NULL]\n" );
	else 
		fprintf( stderr, "My_Inst [%p]\n"
						 "data = %p\n"
						 "datalen = %lu\n",
						 this, this->data, this->datalen);
		if ( this->data != NULL )
			for ( size_t i = 0; i < this->datalen ; i++ )
					fprintf( stderr, "\tdata[%5x] = %02x\n",
							i, ( int ) this->data[i]);
	fprintf( stderr, "==========================\n" );
	return 0;
}

int x86_Ins_dump_File( x86_Ins* this, const char* fname )
{
	FILE* output = fopen( fname, "w" );
	IS_NULL( output )
	fprintf( output, "==========================\n" );
	if ( this == NULL )
		fprintf( output, "My_Inst [NULL]\n" );
	else 
		fprintf( output, "My_Inst [%p]\n"
						 "data = %p\n"
						 "datalen = %lu\n",
						 this, this->data, this->datalen);
		if ( this->data != NULL )
			for ( size_t i = 0; i < this->datalen ; i++ )
					fprintf( output, "\tdata[%5x] = %02x %s\n",
							i, ( int ) this->data[i], i == this->_start ? "<---start--": " " );
	fprintf( output, "==========================\n" );
	return 0;
}


x86_Ins* x86_Ins_ctor( unsigned char* data, size_t len )
{
	IS_NULL( data )
	
	x86_Ins* new = ( x86_Ins*) calloc( 1, sizeof( *new ) );
	IS_NULL( new );

	new->data = data;
	size_t i = 0;
	
	new->datalen = len;

	return new;
}

int x86_Ins_dtor( x86_Ins* this )
{
	free( this->data );
	this->data = NULL;
	free( this );		
}

x86_Ins* x86_Ins_Load( const char* fname )
{
	IS_NULL( fname )

	FILE* input = fopen( fname, "rb" );
	IS_NULL( input )
	
	size_t len = File_len( input );

	unsigned char* data = ( unsigned char* ) calloc( len, sizeof( *data ));

	fread( data, sizeof(*data ), len, input );
	fseek( input, 0, SEEK_SET );
	
	fread( &hdr, sizeof( hdr ), 1, input );
	printf( "%x\n", hdr.e_entry & 1048575 );
	//printf( "%x\n", hdr.e_phnum );

	printf( "shnum %x\n", hdr.e_shnum );
	//printf( "%x\n", hdr.e_phnum );
	//printf( "%x\n", hdr.e_phnum );

	fclose( input );

	x86_Ins* this = x86_Ins_ctor( data, len );
	this->_start = hdr.e_entry & 1048575;
	return this;
}

size_t  Write_x86_Start( void* adr, unsigned char Val_cntr )
{
	//Val_cntr += 2;
		memmove( adr, //"\x55"             //push rbp
				  "\x48\x83\xec\x00" // sub rsp, b
				  "\x55"             //push rbp
				  "\x48\x89\xe5"
				  "\x55",			 //push rbp
				  //"\x48\x89\xe5",    //mov rbp, rsp
					9 );
	memmove( adr + 3/*8*/, &Val_cntr, 1 );
	return 9;
}

int Write_Double( double num, void* adr )
{
	memmove( adr, &num, sizeof( num ) );
	return 0;
}

int Write_Int( int num, void* adr )
{
	memmove( adr, &num, sizeof( num ) );
	return 0;
}

size_t Label_Manager_Set( size_t My_pos, size_t x86_pos, My_Ins* LabelMap )
{
	return LabelMap->data[My_pos] = x86_pos;
}

size_t Label_Manager_Processing( My_Ins* LabelMap,My_Ins* my,  x86_Ins* run )
{
	for ( size_t i = 1; i < my->datalen ; i++ )
	{	
		if ( JMP <= my->data[i] && my->data[i] <= CALL )
		{
			size_t from = 0;
			if ( my->data[i] == JMP )
				 from = LabelMap->data[i] + 5; 
			else if ( JE <= my->data[i] && my->data[i] <= JBE ) 
				from = LabelMap->data[i] + 16;
			else if ( my->data[i] == CALL )
				from = LabelMap->data[i] + 13;
			size_t to = LabelMap->data[ (int) my->data[i+1]]; 
			int offset = to - from;
			Write_Int( offset, run->data + from - 4 );
		}
	}	
}

int Translate( My_Ins* my, x86_Ins* run )
{
	size_t x86_pos = run->_start;
	size_t In_pos = IN_POS;
	size_t Out_pos = OUT_POS;
	size_t Tmp_adr = TMP_ADR;
	size_t My_pos = 0;
	size_t Push_Pop_cntr = 0;
	size_t Next_FPU_pos = 0x672 - 108;
	unsigned char Val_cntr = (unsigned char) my->data[0];
	if ( (Val_cntr % 2) == 1 )
		Val_cntr += 1;
	Val_cntr *= 8;
	Val_cntr -= 16;

	unsigned  int stFrame = Val_cntr ; //- 2; //+ 8;
	My_Ins* Label_Map = My_Ins_new( my->datalen );
	x86_pos += Write_x86_Start( THIS_ADR, Val_cntr );
	for ( My_pos = 1; My_pos < my->datalen ;)
	{
	if ( my->data[My_pos] == PUSH || my->data[My_pos] == PUSHR )
		Push_Pop_cntr++;
	else if ( my->data[My_pos] == POP || my->data[My_pos] == POPR )
		Push_Pop_cntr--;
	Label_Manager_Set( My_pos, x86_pos, Label_Map );
	//printf("%lu\n", My_pos );
	#define COMMA ,
	#define DEF_CMD( com, num, len, CCode, code, codelen ) \
		if ( my->data[My_pos] == com ) {\
			memmove( run->data + x86_pos, code, codelen); \
		CCode \
		x86_pos += codelen;\
		My_pos += len; \
		} \
		else
			
	#include "Code.h"
			break;	
	#undef DEF_CMD
	#undef COMMA
//	if ( Push_Pop_cntr % 7 == 0 && Push_Pop_cntr != 0 )
//		memmove( THIS_ADR, 

			
	}

	My_Ins_dump( Label_Map );
	Label_Manager_Processing( Label_Map, my, run );
	return 0;
}

int x86_Ins_Write( x86_Ins* run, const char* fname )
{
	IS_NULL( run )
	FILE* output = fopen( fname, "wb" );
	IS_NULL( output )


	int check = fwrite( run->data, run->datalen, sizeof( run->data[0] ), output );

	return check == run->datalen;

}
