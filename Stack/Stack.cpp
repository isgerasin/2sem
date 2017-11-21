#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <assert.h>
#include "Stack.h"

#define CANARY 0XABBAFEEF
#define DBG

#ifdef DBG 
    #define OK_DUMP( smth ) \
        if ( ! (smth)->ok() ) \
            (smth)->dump();\
        if ( (smth)->data == NULL ) assert(0);
#else
    #define OK_DUMP( stk ) 
#endif

#define IS_NULL( pntr ) if ( !pntr ) return NULL

bool Stack::ok( ) const
{
    return this->data &&
           this->counter < this->lenght &&
           this->canaryA == CANARY &&
           this->canaryB == CANARY;

}

bool Stack::dump() const
{
    fprintf( stderr, "========================================\n" );
    fprintf( stderr, "Stack[%p] %s\n"
            "CanaryA = %x\n"
            "\tData[%p]\n", this, this->ok() ? "OK" : "ERROR!", this->canaryA, this->data  );
    
    if ( this->data != NULL )
        for ( size_t i = 0; i < this->lenght; i++ )
            fprintf( stderr, "\t%c[%lu] = %f\n",
                    (i < this->counter) ? '*' : ' ', i,
                     this->data[i] );
    else 
        fprintf( stderr, "Error! data is NULL" );
    fprintf( stderr, "Counter = %lu\n"
            "Lenght = %lu\n"
            "CanaryB = %x\n", this->counter, this->lenght, this->canaryB );
    fprintf( stderr, "========================================\n" );
    return 0;
}

Stack::Stack( ):
	data ( ( TypeStk* ) calloc( 10, sizeof( *this->data ) ) ),
	lenght ( 10 ),
	counter ( 0 ),
    canaryA ( CANARY ),
    canaryB ( CANARY )
{
    
    OK_DUMP( this );

}

Stack::~Stack()
{   
    OK_DUMP( this )
    this->counter = 1;
    this->lenght = 0;
    free( this->data );
}

TypeStk Stack::pop()
{
    OK_DUMP( this )
    TypeStk tmp = 0; 
    if ( this->counter > 0 )
    {
        if ( this->counter < this->lenght / 2 && this->lenght > 10 )
            this->realoc( 0.5 );
         tmp = this->data[--this->counter];
    }
    else 
        fprintf( stderr, "Error! Can\'t pop from stack !\n" );
    OK_DUMP( this )
    return tmp;
}

bool Stack::push( TypeStk data )
{
    OK_DUMP( this )
	
	bool check = 0;
    this->data[this->counter++] = data;
    if ( this->counter >= this->lenght - 1 ) 
        check = this->realoc( 2 );

    OK_DUMP( this )

    return check;
}

bool Stack::realoc( double x )
{
    OK_DUMP( this )
   
    this->data = ( TypeStk* ) realloc( this->data,( size_t ) ( x * this->lenght * sizeof( TypeStk ) ) );
    this->lenght= x * this->lenght;

    OK_DUMP( this )
    return this->data != NULL;
}
