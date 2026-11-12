/* target: HPNEWB5 */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPNEWB5 (0054:1101, image 0x1641): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPNEWB5.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: NEW_BANK5_NODE allocates a node in the null bank (bank 4 in
   CPP.EXE; the name is BCC's, whose null bank is bank 5). Entry points: NEW_BANK5_NODE. */
/* Overview: the null bank's allocate hook (hook_22, installed by
   INIT_NULL_BANK): that bank has no memory, so a "block" there is just a
   descriptor that remembers a discarded block.  NEW_BANK5_NODE links a new
   node after chain_head with field8 = request, bank 4 in field19 and owner
   tag 0.  Used by RH_TRY_FLAG40 (through RH_HEAP_DISPATCH). */
#include "CPPHEAP.H"
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);

HeapNode near * near pascal NEW_BANK5_NODE(unsigned int request)
{
    HeapNode near *node=RNEWNODE();
    RHLINK(ACTIVE_HEAP.chain_head,node);
    node->field8=request;
    node->field19=4;    /* CPP.EXE edit: bank 4, CPP's last bank (BCC: 5) */
    node->field12=0;
    return node;
}
