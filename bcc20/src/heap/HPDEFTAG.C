/* target: CODE_2_R3504 */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: returns the default owner tag for new heap nodes. Entry points:
   GET_DEFAULT_OWNER_TAG. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: returns HEAP_DEFAULT_OWNER_TAG, the owner tag (see HPOWNTAG.C)
   that new heap blocks are given at the moment. */
#include "DATA.H"
unsigned char far pascal _loadds GET_DEFAULT_OWNER_TAG(void)
{
    return HEAP_DEFAULT_OWNER_TAG;
}
