/* tlook.c: TYPE_LOOKUP, from bcc20/src/types/TLOOK.C: the type record a name record names
   when that identifier currently names a type (a typedef, in C++ also a class name or an
   unhidden tag), else 0. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define STORAGE(node) (B(MK_FP(SYMBOL_POOL_SEG, (node) + 7)) >> 3)
#define SYMBOL_TYPE(node) W(MK_FP(SYMBOL_POOL_SEG, (node) + 4))

i16 TYPE_LOOKUP(u16 type)
{
    u16 node = (u16)FIND_SYMBOL_IN_SCOPES(type);
    /* a member of the current class that is not a type hides the global names */
    if (!node && CURRENT_CLASS_TYPE && FIND_MEMBER_QUIET(type, CURRENT_CLASS_TYPE))
        return 0;
    if (!node)
        node = FIND_NAME_IN_LIST(type, GLOBAL_SCOPE_NAMES);
    if (node) {
        if (STORAGE(node) == 8)                           /* a typedef */
            return SYMBOL_TYPE(node);
        if (CPP_MODE && STORAGE(node) == 11)              /* C++: probably a class name */
            return SYMBOL_TYPE(node);
    }
    /* C++ only: an unhidden struct, union or enum tag names its type too */
    if (!CPP_MODE || node)
        return 0;
    node = FIND_NAME_IN_LIST(type, GLOBAL_SCOPE_TAGS);
    return node ? SYMBOL_TYPE(node) : 0;
}
