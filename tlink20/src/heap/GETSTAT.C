/* target: H_GETSTAT */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: returns HEAP_STATUS, the result of the last heap call. */
/* Overview: far entry that returns HEAP_STATUS, the result of the last heap
   call: 0, or 1000h (no memory), 1001h (no descriptors), 1002h (bad handle
   or argument), 1003h (a swap-file error in BCC's heap). */
extern unsigned int HEAP_STATUS;
unsigned int far pascal _loadds BCC_READ_STATUS(void)
{
    return HEAP_STATUS;
}
