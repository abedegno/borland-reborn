/* target: HPRELCB */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPRELCB (0054:1127, image 0x1667): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPRELCB.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: BCC_RESIDENT_RELEASE_CALLBACK, a release callback that unlinks a
   pool node and returns 0. Entry points: BCC_RESIDENT_RELEASE_CALLBACK (the name is
   BCC's). */
/* Overview: the null bank's release hook (hook_24, installed by
   INIT_NULL_BANK; bank 4 in CPP.EXE, BCC's bank 5): a node there has no
   memory, so releasing it only takes it out of the chain and returns its
   descriptor (UNLINK_HEAP_NODE, RRETNDES.C). */
struct PoolNode;
extern void near pascal UNLINK_HEAP_NODE(struct PoolNode near *);
unsigned int near pascal BCC_RESIDENT_RELEASE_CALLBACK(struct PoolNode near *node)
{
    UNLINK_HEAP_NODE(node);
    return 0;
}
