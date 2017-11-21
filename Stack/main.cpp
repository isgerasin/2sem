#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"


int main( int argc, char* argv[] )
{
    Stack* stk = new Stack;
  // *((double*) stk) = 0;

//   *((double*) stk + 1) = 0x12820a;
  // stk->push (10);

// (*((double*) stk))[1] = 0;
    while ( 1 )
    {
        int comand = 0;
        printf( "push 1\n"
                "pop  2\n"
                "comand: ");
        scanf( "%d", &comand );

        if ( comand == 1 )
        {
            double pushdata = 0;
            scanf( "%lg", &pushdata );
            stk->push( pushdata );
        }
        else if ( comand == 2 )
        {
            double popdata = stk->pop();
            printf( "%f\n", popdata );
        }
        stk->dump();
    }
    return 0;
}
