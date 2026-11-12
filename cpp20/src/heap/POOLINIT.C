/* target: POOLINIT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module POOLINIT (0054:1251, image 0x1791): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/POOLINIT.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: POOL_INIT allocates a pool's bank-0 block and keeps its segment in
   the pool's handle word. */
/* Overview: far entry that allocates a bank-0 block of request bytes for a
   pool whose handle word is *output (for example &MALLOC_POOL_SEG): the
   block's segment is written there and kept up to date by the heap when the
   block moves.  It does not fill in a pool record's
   capacity, used or free-list words; POOLS.C does that.  It first makes sure
   there are spare descriptors.  When there is no room HEAP_STATUS is set to
   1000h, the status hook is called and 1000h returned (CPP.EXE edit: no
   retry, see below).  Returns 0 on success.  The segment loads are explicit
   (inline asm and _DS). */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;

extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);

/* CPP.EXE edit: Turbo C 2.01 has no _loadds; the DGROUP load after the SI
   save and the DS restore before the shared epilogue are inline asm.  There
   is no retry: when the allocation fails, POOL_INIT reports 1000h at once and
   calls the hook with no arguments (BCC calls HEAP_HOOK_CALLSITE(1,100h) and
   retries while it clears HEAP_STATUS). */
/* link: POOL_INIT is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int far pascal POOL_INIT(unsigned int far *output,
    unsigned int request)
{
    register HeapNode near *node;
    asm push ds;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    if(RH_PREPARE_DESCRIPTORS())
        goto failed;
    HEAP_STATUS=0;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if((node=HEAP_ALLOC_NODE(request))) {
        ((struct HeapOutputNodeView near *)node)->output=output;
        RH_UPDATE_NODE_ADDRESS(node,1);
        _AX=0;
        goto done;
    }
failed:
    asm mov ax,DGROUP;
    asm mov ds,ax;
    HEAP_STATUS=0x1000;
    ((void (far *)(void))HEAP_HOOK_CALLSITE)();
    _AX=0x1000;
done:
    asm pop ds;
    return _AX;
}
