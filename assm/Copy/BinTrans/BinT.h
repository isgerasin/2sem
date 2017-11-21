#include <string.h>

#define IN_POS 0x2c0
#define OUT_POS 0x2cb
#define TMP_ADR 0x601039 

#define IS_NULL( pntr ) \
	if ( (pntr) == NULL ) return NULL;

#define DEF_CMD( name, num, cntr ) \
		name = num,
enum My_Comands_t
{
	#include "Commands.h"
	ZER0 = 0
};
#undef DEF_CMD

typedef struct
{
	double* data;
	size_t datalen;
} My_Ins;

typedef struct
{
	unsigned char* data;
	size_t datalen;
	size_t _start;
} x86_Ins;

int My_Ins_ok( My_Ins* this );

int My_Ins_dump( My_Ins* this );

My_Ins* My_Ins_ctor( double* data, size_t len );

My_Ins* My_Ins_new( size_t len );

int My_Ins_dtor( My_Ins* this );

My_Ins* My_Ins_Load( const char* fname );

int x86_Ins_ok( x86_Ins* this );

int x86_Ins_dump( x86_Ins* this );

int x86_Ins_dump_File( x86_Ins* this, const char* fname );

x86_Ins* x86_Ins_ctor( unsigned char* data, size_t len );

int x86_Ins_dtor( x86_Ins* this );

x86_Ins* x86_Ins_Load( const char* fname );

int Translate( My_Ins* tmp, x86_Ins* run );

int x86_Ins_Write( x86_Ins* run, const char* fname );
