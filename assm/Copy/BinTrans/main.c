#include <stdio.h>
#include "BinT.h"


int main( int argc, char* argv[])
{
	My_Ins* tmp = My_Ins_Load( "assm_go.txt" ); 
	My_Ins_dump( tmp );
	IS_NULL( tmp )
	x86_Ins* run = x86_Ins_Load( "run_template" );
//	x86_Ins_dump( run );
	IS_NULL( run )
	
	int check = Translate( tmp, run );
	printf("!%d!\n", check );
	x86_Ins_dump_File( run, "Dump.d" );
	printf( "!" ); 
	x86_Ins_Write( run, "AlreadyRun" );
	printf( "!" ); 

}	
