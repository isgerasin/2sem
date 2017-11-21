#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>
//#include <conio.h>
#include "Header_List.h"

#define REQUESTS 10000000


int EmulatorReq( HashTble_t* htbl, char* data, size_t len, unsigned int ( *HashFunc )( const char* ) )
{
	size_t counter = 0;
	for (size_t i = 0; i < REQUESTS; i++)
	{
		HashTble_Found( htbl, data + counter, ( *HashFunc )( data + counter ));
		counter = ( ( counter + strlen(data + counter) )% (len / 2)) + 1;
	}
}

int main( int argc, char* argv[] )
{
	//assert(0);
	ListElem_t lel, lela, lelb, lelc, leld;
	List_t list;
	HashTble_t tbl;
	//printf("%x\n", Hash_Func_6("abwdwdwagrop-[olgo24") );
	//printf("%x\n", Hash_Func_6_asm("abwdwdwagrop-[olgo24") );

	assert( HashTble_ctor( &tbl, MAXHASH ) );
	
	
	FILE* sh = fopen( "Sheakspeare.txt", "r" );
	int len = 2*File_Len( sh );
	char* sheak = ( char* ) calloc( len, sizeof( *sheak ) );
	fread( sheak, sizeof( *sheak ), len, sh );
	fclose( sh );
	
	assert( ListElem_ctor( &lel, "first") ); 
	//ListElem_dump( &lel );
	//printf("efe\n");
	
	
	HashTble_DoTest( &tbl, sheak, Hash_Func_6_asm );
	EmulatorReq( &tbl, sheak, len, Hash_Func_6_asm );
	
	//printf("efe\n");
	//List_out( tbl.data );
	//HashTble_dump( &tbl );
	//HashTble_dump_dot( &tbl );
	
	//assert( ListElem_dtor( &lel ) );
	//assert( HashTble_dtor( &tbl ) );
	//assert( List_dtor( &list ) );
	
	

}
