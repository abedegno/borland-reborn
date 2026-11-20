/* target: CODE_2_RNOOPS */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: the empty bank's do-nothing hooks. Entry points:
   BANK5_NOOP_NODE_HOOK, BANK5_NOOP_REQUEST_HOOK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: bank 5's empty hooks (installed by INIT_NULL_BANK): bank 5 has
   no memory, so writing a block into it, reading it out, moving it and
   finding free space there do nothing. */
/* Bank5 callbacks: slot28h/2Ah/2Ch use a near node plus a WORD;
   slot26h uses one WORD. The bank5 paths do not consume an AX result. */
struct HeapNode;
void near pascal BANK5_NOOP_NODE_HOOK(struct HeapNode near *node,unsigned int value)
{
}
void near pascal BANK5_NOOP_REQUEST_HOOK(unsigned int request)
{
}
