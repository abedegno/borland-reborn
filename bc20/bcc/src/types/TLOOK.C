/* target: ovr118_TLOOK */
/* opts: -mm -G- -O -Z -p */
/* Role: types: looks up an identifier as a type name (typedef or, with CPP_MODE, a class)
   in scopes and the current class. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the test "is this identifier a type name?". The parser calls
   TYPE_LOOKUP (through parser/TYPSTART.C, which shares this overlay) when it must decide
   whether a declaration or a cast starts, so it runs for every identifier at such a point.
   The search order is: the open scopes (FIND_SYMBOL_IN_SCOPES); then, inside a member
   function, the members of CURRENT_CLASS_TYPE, where a member of that name hides any
   outer type so the answer is "not a type"; then the global ordinary-name list
   GLOBAL_SCOPE_NAMES. A symbol counts as a type when its storage class (SYM_STORAGE_CLASS
   bits 3-7) is 8, probably typedef, or, in C++ mode, 11, probably a class/struct tag.
   Last, in C++ mode only, a struct/union/enum tag name alone also names a type, so the
   global tag list GLOBAL_SCOPE_TAGS is tried.
   Things to trip over: CPP_MODE is the C++ flag (set from OPTION_FLAGS bit 0 by
   INIT_PARSER: -P or a .CPP file); GLOBAL_SCOPE_NAMES and GLOBAL_SCOPE_TAGS are not types but the
   heads of the global scope's name list and tag list (set in driver/INITTYPE.C C9BANKS).
   The parameter called "type" is really a name record (NAME_POOL). Symbol fields are read
   with raw offsets: byte 7 is SYM_STORAGE_CLASS, word [2] (offset 4) is SYM_TYPE. */

#include <dos.h>
#include "DATA.H"

extern int far FIND_SYMBOL_IN_SCOPES(unsigned int type);
extern int far FIND_NAME_IN_LIST(unsigned int type, unsigned int context);
extern int far FIND_MEMBER_QUIET(unsigned int type, unsigned int context);

/* TYPE_LOOKUP: returns the type record named by the name record "type" when that
   identifier currently names a type, else 0. The odd shapes (_AX=_AX, node=node, the
   goto chain, the _ES reread of the symbol segment) are kept for byte matching. */
static int far pascal TYPE_LOOKUP(register unsigned int type)
{
    register unsigned int node;

    node = FIND_SYMBOL_IN_SCOPES(type);
    if (node != 0)
        goto have_type;
    if (CURRENT_CLASS_TYPE == 0)
        goto have_type;
    if (FIND_MEMBER_QUIET(type, CURRENT_CLASS_TYPE) != 0) {
        _AX=_AX;goto return_zero;
    }
have_type:
    /* nothing in the open scopes: try the global name list */
    if (node != 0)
        goto found;
    node = FIND_NAME_IN_LIST(type, GLOBAL_SCOPE_NAMES);
found:
    if (node == 0)
        goto fallback_check;
    /* storage class 8: probably a typedef; its SYM_TYPE is the answer */
    if ((int)((unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node))[7] >> 3 == 8)
        goto load_value;
    if (CPP_MODE == 0)
        goto fallback_check;
    /* C++ only: storage class 11, probably a class name, also names a type */
    if (((int)*(unsigned char far *)MK_FP(_ES,node+7) >> 3) != 11)
        goto fallback_check;
load_value:
    return ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2];
fallback_check:
    /* C++ only: an unhidden struct/union/enum tag name names its type too */
    if (CPP_MODE == 0)
        goto return_zero;
    if (node != 0)
        goto return_zero;
    node = FIND_NAME_IN_LIST(type, GLOBAL_SCOPE_TAGS);
    if (node != 0) {node=node;goto load_value;}
return_zero:
    return 0;
}
