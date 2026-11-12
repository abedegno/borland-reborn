/* target: CODE_2_RT2F09 */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: far wrapper that resolves a heap handle word to its bank and node.
   Entry points: RESOLVE_HANDLE_FAR. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far wrapper of BCC_POOL_RESOLVE_WORD (HPDISP.C) for code outside
   CODE_2: resolves a heap handle word to its bank (returned) and node offset
   (stored through offset). */
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset);
unsigned int far pascal _loadds RESOLVE_HANDLE_FAR(unsigned int handle,unsigned int far *offset)
{
    return BCC_POOL_RESOLVE_WORD(handle,offset);
}
