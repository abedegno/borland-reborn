/* target: RNOOPS */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RNOOPS (image 0x253B..0x2585, 0054:1FFB..0054:2045): the null bank,
   from the BCC.EXE reconstruction's bcc20/src/heap/RNOOPS.C (the two
   hooks) and INIT_NULL_BANK from its heap/EMSBANK.C, in BCC's order, with CPP.EXE's
   edits marked "CPP.EXE edit".  One file here: the empty stubs that CPP.EXE has at
   0x2536 (HPSTUBSW.C) and 0x2585 (HPSTUBEB.C) are files of their own, so INIT_NULL_BANK
   cannot be in the same file as the EMS bank code after 0x258A.  Compiled by Borland
   C++ 2.0 through TASM (-B), not Turbo C 2.01 like HEAPMAIN.C: Turbo C 2.01 leaves out
   the push bp / mov bp,sp frame of a function without parameters or locals, and
   INIT_NULL_BANK has it (image 2549).  CRLF line ends, for CPPHEAP.H's sake. */
/* Role: far-memory heap: the null bank and its do-nothing hooks. Entry points:
   BANK5_NOOP_NODE_HOOK, BANK5_NOOP_REQUEST_HOOK, INIT_NULL_BANK. */
/* Overview: the null bank's empty hooks (installed by INIT_NULL_BANK, which
   INIT_HEAP calls): that bank has no memory and only keeps the descriptors
   of discarded blocks, so writing a block into it, reading it out, moving it
   and finding free space there do nothing.  Its allocate hook
   (NEW_BANK5_NODE) makes a bare node.  (CPP.EXE edit: CPP.EXE's null bank
   is bank 4, BCC.EXE's bank 5; the BANK5_ names are BCC's.  CPP.EXE has no
   swap-file bank.) */
#include "CPPHEAP.H"
/* The node hooks (+28h, +2Ah, +2Ch) take a near node and a word; the
   request hook (+26h) takes one word.  No caller uses a result. */
void near pascal BANK5_NOOP_NODE_HOOK(struct HeapNode near *node,unsigned int value)
{
}
void near pascal BANK5_NOOP_REQUEST_HOOK(unsigned int request)
{
}

/* From heap/EMSBANK.C: */
extern void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8);
extern HeapNode near * near pascal NEW_BANK5_NODE(unsigned int request);
extern unsigned int near pascal BCC_RESIDENT_RELEASE_CALLBACK(HeapNode near *node);

/* The null bank: an empty range (INIT_BANK with size 0) and no-op move hooks.
   CPP.EXE edit: the null bank is bank 4 (0054:2011: mov ax,4), BCC's bank 5. */
unsigned int near pascal INIT_NULL_BANK(void)
{
    asm push ds;
    INIT_BANK(0,0,4,0,0);
    ACTIVE_HEAP.hook_22=(HeapWordHook)NEW_BANK5_NODE;
    ACTIVE_HEAP.hook_24=BCC_RESIDENT_RELEASE_CALLBACK;
    ACTIVE_HEAP.hook_28=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.hook_2a=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.move_node_2c=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.hook_26=(HeapHook)BANK5_NOOP_REQUEST_HOOK;
    asm pop ds;
    return 0;
}
