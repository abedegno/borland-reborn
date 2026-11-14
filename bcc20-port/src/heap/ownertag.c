/* ownertag.c: from bcc20/src/heap/OWNERTAG.C and HPDEFTAG.C: the owner tag the far heap
   gives new blocks (HEAP_DEFAULT_OWNER_TAG; see the heap's FREE_TAG_NODES, which frees
   every block of a tag).  Callers set a tag from ALLOCATE_OWNER_TAG before building pools
   and put the old one back afterwards. */
#include "port.h"
#include "data.h"
#include "protos.h"

void SET_DEFAULT_OWNER_TAG(u8 value)
{
    HEAP_DEFAULT_OWNER_TAG = value;
}

u8 GET_DEFAULT_OWNER_TAG(void)
{
    return HEAP_DEFAULT_OWNER_TAG;
}
