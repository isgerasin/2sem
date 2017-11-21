#include <stdio.h>
#include "Array.h"

int main ( int argc, char* argv[] )
{
    my_vector v( 6 );
    my_vector v2( 7 );
    
    v[2] = 87909;
    v2[2] = -87900;
    my_vector v3( 5 );
    v3 = v + v2;
    v.dump("v");
    v2.dump( "v2" );
    v3.dump( "v333");
    
    v = v3;
    v3.dump("v3");
    v.dump("I");
    //
    printf( "%lg %lg", v[1], v3[6] );
    my_vector vsum;
    vsum = v - (v3);
    v.dump("v");
    v2.dump( "v2" );
    v3.dump( "v333");
    vsum.dump("er");
    //v.~my_vector();
    //v2.~my_vector();
    //v3.~my_vector();
    //v.dump("udywui");
}
