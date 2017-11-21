#include "bool.hpp"

#define MAXLEN 1000

template<size_t len>
bool Eratosthenes( my_Arraybool<len>& seive );

int main( int argc, char* argv[] )
{
    my_Arraybool<MAXLEN> ar;
    /*
    for ( size_t i = 0; i < MAXLEN; i++ )
    {
        printf( "%d ", (data_type) ar[i] );
        ar[i] = 1;
        ar.dump("main");
        printf( "%d\n", (data_type) ar[i] );
    }
    ar[1] = 0;
    ar[7] = 0;
    //unittest!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111
    ar.dump("00");
    ar[1] = 1;
    ar[7] = 0;
    ar.dump("10"); 
    ar[1] = 0;
    ar[7] = 1;
    ar.dump("01"); 
    ar[1] = 1;
    ar[7] = 1;
    ar.dump("11");
    */
    Eratosthenes(ar );
    ar.dump("2222222222");
    return 0;
}

template<size_t len> 
bool Eratosthenes( my_Arraybool<len>& seive )
{
    //ASSERT_OK( this )
    //my_Arraybool<len>& seive = *this;
    for ( size_t i = 2; i < seive.getlen(); i++ )
        seive[i] = 1;
    seive[0] = 0;
    seive[1] = 0;
    for ( size_t i = 2; i <seive.getlen(); i++)
    {
        if ( (data_type) seive[i] ==  1)
            for ( size_t j = 2*i; j < seive.getlen(); j += i )
               seive[j] = 0;
    }
    //ASSERT_OK( this )

    return true;
}
