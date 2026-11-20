/* target: CODE_2_GETSTAT */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: returns HEAP_STATUS, the result of the last heap call. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that returns HEAP_STATUS, the result of the last heap
   call: 0, or 1000h (no memory), 1001h (no descriptors), 1002h (bad handle
   or argument), 1003h (swap-file error). */
extern unsigned int HEAP_STATUS;
static unsigned int far pascal _loadds BCC_READ_STATUS(void)
{
    return HEAP_STATUS;
}
