/* target: CODE_2_R1A1A */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: SHRINK_HEAP_FULLY shrinks the heap as far as it will go and
   returns the new top. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry: SHRINK_HEAP_TO(FFFFh), shrink bank 0 as far as it
   goes; returns the new top paragraph. */
extern unsigned int far pascal SHRINK_HEAP_TO(unsigned int);
static unsigned int far pascal _loadds SHRINK_HEAP_FULLY(void)
{
    return SHRINK_HEAP_TO(0xffffU);
}
