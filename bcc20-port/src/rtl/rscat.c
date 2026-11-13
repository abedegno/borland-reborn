/* rscat.c: STRING_APPEND, from bcc20/src/rtl/RSCAT.C: strcat on far strings.
   STRING_APPEND_N (strncat) is left out: nothing in BCC calls it. */
#include "port.h"
#include "protos.h"

farptr STRING_APPEND(farptr destination, farptr source)
{
    RTL_MEMMOVE(fp_add(destination, STRING_LENGTH(destination)), source,
                STRING_LENGTH(source) + 1);
    return destination;
}

