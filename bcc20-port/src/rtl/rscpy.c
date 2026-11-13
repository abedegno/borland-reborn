/* rscpy.c: STRING_COPY and RTL_STRNCPY, from bcc20/src/rtl/RSCPY.C: strcpy and strncpy on
   far strings, built on STRING_LENGTH, RTL_MEMMOVE and RTL_MEMSET as in the original. */
#include "port.h"
#include "protos.h"

farptr STRING_COPY(farptr destination, farptr source)
{
    RTL_MEMMOVE(destination, source, STRING_LENGTH(source) + 1);
    return destination;
}

farptr RTL_STRNCPY(farptr destination, farptr source, u16 n)
{
    u16 length = STRING_LENGTH(source);
    if (length > n)
        length = n;
    RTL_MEMMOVE(destination, source, length);
    if (length < n)
        RTL_MEMSET(fp_add(destination, length), 0, n - length);
    return destination;
}
