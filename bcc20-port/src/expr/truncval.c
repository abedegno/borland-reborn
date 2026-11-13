/* truncval.c: CODE_MASK, from bcc20/src/expr/TRUNCVAL.C: a constant truncated to a
   width: 1 signed int, 2 unsigned int, 3 signed char, 4 unsigned char, 5 signed long, 6
   unsigned long; any other mode leaves it unchanged */
#include "port.h"
#include "data.h"
#include "protos.h"

#define MASK_C SD(MASK_C_P)

i32 CODE_MASK(i32 value, u8 mode)
{
    switch (mode) {
    case 1:
        value &= INT_LIMIT;
        if (value & ((INT_LIMIT + 1) >> 1))
            value |= ~INT_LIMIT;
        break;
    case 2:
        value &= INT_LIMIT;
        break;
    case 3:
        value &= MASK_B;
        if (value & ((MASK_B + 1) >> 1))
            value |= ~MASK_B;
        break;
    case 4:
        value &= MASK_B;
        break;
    case 5:
        value &= MASK_C;
        if (value & (i32)((u32)(MASK_C + 1) >> 1))
            value |= ~MASK_C;
        break;
    case 6:
        value &= MASK_C;
        break;
    }
    return value;
}
