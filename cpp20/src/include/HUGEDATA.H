#ifndef HUGEDATA_H
#define HUGEDATA_H
#include "DATA.H"
#include "OVL.H"

extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern unsigned int (far pascal *STREAM_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);


static long far pascal C17MEASURE(register unsigned int type,
    unsigned int far *adjustment);

#endif
