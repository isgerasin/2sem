#include <malloc.h>
#include <algorithm>
#include <assert.h>
#include <stdio.h>
#include "Array.h"

#define CANARY 0xFACCFACC
#define LEN 10
#define WORSENULL ((void*) 0x7)

#define MIN( a, b ) ((a) < (b) ? (a) : (b))
#define MAX( a, b ) ((a) > (b) ? (a) : (b))
#ifndef NDBG
#define ASSERT_OK( smth, msg ) \
        if ( ! ( (smth)->ok() ) ) \
        { \
             (smth)->dump( msg ); \
             assert( (smth)->data_ != NULL ); \
        }
#endif 


bool my_vector::ok() const
{
    return  data_ != NULL &&
            canaryA_ == CANARY &&
            canaryB_ == CANARY; // &&
            //checksum_ == this->checkcalc();
}

bool my_vector::dump( const char* msg ) const
{
    fprintf( stderr,"----------------------------------\n" );
    fprintf( stderr,"my_vector[%p] %s (%s)\n" 
                    "canaryA_ = %X (%s)\n"
                    "length_  = %lu\n"
                    "data_    = [%p]\n"
                    "checksum_= %lu (%s)\n"
                    "canaryB_ = %X (%s)\n",
            this, msg, this->ok() ? "ok" : "ERROR!!!!", canaryA_, canaryA_ == CANARY ? "ok" : "ERROR",
            length_, data_, checksum_, checksum_ == this->checkcalc() ? "ok" : "ERROR!!!",
            canaryB_, canaryB_ == CANARY ? "ok" : "ERROR!!!" );
    if ( data_ != NULL )
    {
        for ( size_t i = 0; i < length_; i++ )
            fprintf( stderr, "\tdata_[%lu] = %lg [%p]\n",
                    i, data_[i], data_ + i );
    }


    fprintf( stderr, "----------------------------------\n" );
}

size_t my_vector::checkcalc() const
{
    if ( data_ == NULL || data_ == WORSENULL )
        return 0;
    size_t sum = 0;
    sum += canaryA_ % 100;
    sum += canaryB_ % 10;
    sum += length_ % 13;;
    for ( size_t i = 0; i < length_; i++ )
        sum += (( unsigned int ) data_[i]) % 10;

    return sum + 1;
}

my_vector::my_vector():
    canaryA_ ( CANARY ),
    length_ ( LEN ),
    data_ ( ( vctr_type* ) calloc( LEN, sizeof( *data_ ) ) ),
    canaryB_ ( CANARY )
{
    checksum_ = this->checkcalc();
    ASSERT_OK( this , "Ctor" )
}

my_vector::my_vector( const my_vector& that ):
    canaryA_ ( that.canaryA_ ),
    length_ ( that.length_ ),
    data_ ( new vctr_type[that.length_] ),
    checksum_ ( that.checksum_ ),
    canaryB_ ( that.canaryB_ )
{
    ASSERT_OK( this, "Ctor" )
    std::copy( that.data_, that.data_ + that.length_, data_ );
    ASSERT_OK( this, "Ctor" )
}

my_vector::~my_vector()
{
    ASSERT_OK( this , "Dtor" )

    canaryA_ = 0;
    length_ = 0;
    free( data_ );
    data_ = ( vctr_type* ) WORSENULL;
    checksum_ = -1;
    canaryB_ = 0;

}

my_vector::my_vector ( size_t length ):
    canaryA_ ( CANARY ),
    length_ ( length ),
    data_ ( ( vctr_type* ) calloc( length, sizeof( *data_ ) ) ),
    canaryB_ ( CANARY )
{
    checksum_ = this->checkcalc();
    ASSERT_OK( this , "Ctor" )
}

my_vector operator+( const my_vector& va, const my_vector& vb )
{
    ASSERT_OK( &va, "op+ va" )
    ASSERT_OK( &vb, "op+ vb" )

    my_vector res(MAX( va.length_, vb.length_ ));
    for ( size_t i = 0; i < MIN( va.length_, vb.length_ ); i++ )
    {
        res[i] = va[i] + vb[i];
    }
    res.checksum_ = res.checkcalc();
    ASSERT_OK( &res, "op+ res" )

    return res;
}

my_vector operator-( const my_vector& va, const my_vector& vb )
{
    ASSERT_OK( &va, "op- va" )
    ASSERT_OK( &vb, "op- vb" )

    my_vector res(MAX( va.length_, vb.length_ ));
    for ( size_t i = 0; i < MIN( va.length_, vb.length_ ); i++ )
    {
        res[i] = va[i] - vb[i];
    }
    res.checksum_ = res.checkcalc();
    ASSERT_OK( &res, "op- res" )

    return res;
}

const my_vector::vctr_type& my_vector::operator[]( size_t num ) const
{
    ASSERT_OK( this, "op[] begin" )

    if ( num < length_ )
        return data_[num];
    else
        fprintf( stderr, "array overflow at op []\n" );

    ASSERT_OK( this, "op[] end")
}

my_vector::vctr_type& my_vector::operator[]( size_t num )
{
    ASSERT_OK( this, "op[] begin" )
    //vctr_type& tmp;

    if ( num < length_ )
        return data_[num];
    else
        fprintf( stderr, "array overflow at op []\n" );

    ASSERT_OK( this, "op[] end")
}


const my_vector& my_vector::operator=( const my_vector& that ) 
{
    ASSERT_OK( this, "op= beg this" )
    ASSERT_OK( &that, "op= beg that" )

    if ( this == &that ) return that;

    my_vector victim( that );
    std::swap( length_, victim.length_ );
    std::swap( data_, victim.data_ );
    std::swap( checksum_, victim.checksum_ );

    return that;
}

my_vector& my_vector::operator=( my_vector& that ) 
{
    ASSERT_OK( this, "op= beg this" )
    ASSERT_OK( &that, "op= beg that" )

    if ( this == &that ) return that;

    my_vector victim( that );
    std::swap( length_, victim.length_ );
    std::swap( data_, victim.data_ );
    std::swap( checksum_, victim.checksum_ );

    return that;
}





