/* bytepool.c: from bcc20/src/codegen/BYTEPOOL.C: the data byte pool, a far pool
   (DATA_BYTE_POOL_SEG, its length in DATA_BYTE_POOL_LENGTH) that collects data bytes one at
   a time.  EMIT_VALUE appends a byte; after a byte string has been appended,
   MERGE_DUPLICATE_BYTES looks for an identical earlier copy in the pool and, if there is
   one, drops the new copy and returns the old offset, so identical strings are stored once
   (string literals with -d).  The search is inline assembly in the original (repne scasb for
   the first byte, repe cmpsb for the rest); the port spells it in C. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define DATA_BYTE_POOL_SEG W(DATA_BYTE_POOL_SEG_P)
#define POOL_BYTE(i) B(MK_FP(DATA_BYTE_POOL_SEG, (i)))

/* the number of bytes in the data byte pool, which is also the offset the next byte will
   get */
u16 BYTE_POOL_LENGTH(void)
{
    return DATA_BYTE_POOL_LENGTH;
}

/* appends one byte to the data byte pool */
void EMIT_VALUE(i8 value)
{
    u16 position = POOL_ALLOC(DATA_BYTE_POOL_SEG_P, 1);
    POOL_BYTE(position) = (u8)value;
}

/* the byte string at offset value (it ends at DATA_BYTE_POOL_LENGTH) looked up among the
   bytes before it.  If an earlier copy exists, the pool is cut back to value and the copy's
   offset is returned; otherwise value */
u16 MERGE_DUPLICATE_BYTES(u16 value)
{
    u16 remaining = (u16)(DATA_BYTE_POOL_LENGTH - value);
    if (value < remaining || remaining == 0)
        return value;
    --remaining;
    u16 starts = (u16)(value - remaining);
    u8 first = POOL_BYTE(value);
    u16 position = 0;
    for (;;) {
        if (starts == 0)
            return value;
        u8 equal;
        do {                                    /* repne scasb */
            equal = POOL_BYTE(position) == first;
            ++position;
            --starts;
        } while (!equal && starts != 0);
        if (!equal)
            return value;
        u16 i = 0;
        while (i < remaining && POOL_BYTE(value + 1 + i) == POOL_BYTE(position + i))
            ++i;                                /* repe cmpsb */
        if (i == remaining)
            break;
    }
    DATA_BYTE_POOL_WORD6 = 0;
    DATA_BYTE_POOL_LENGTH = value;
    return (u16)(position - 1);
}
