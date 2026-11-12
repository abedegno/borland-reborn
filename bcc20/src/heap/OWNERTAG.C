/* target: CODE_2_R34F0 */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: SET_DEFAULT_OWNER_TAG stores the owner tag the heap gives new
   nodes. Entry points: SET_DEFAULT_OWNER_TAG. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: one resident helper. SET_DEFAULT_OWNER_TAG
   does not set a compiler option: it stores its argument in HEAP_DEFAULT_OWNER_TAG, the
   owner tag the far heap gives to new nodes when the caller passes no tag. Callers pass
   a tag from ALLOCATE_OWNER_TAG before building pools (INIT_BACKEND, INIT_POOLS_AND_KEYWORDS)
   and restore the old tag afterwards (COMPILE_ONE_FILE). A later "free all nodes with tag
   T" (FREE_TAG_NODES) then releases everything allocated in between. _loadds makes the
   function load DS itself, since it is called from overlays. */
#include "DATA.H"
void far pascal _loadds SET_DEFAULT_OWNER_TAG(unsigned char value)
{
    HEAP_DEFAULT_OWNER_TAG=value;
}
