/* target: H_HEAPMAIN */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* HEAPMAIN.C: the main heap set-up (INIT_MAIN_HEAP), bank 0's hooks (CONV_FIND_FREE_NODE
   and the block moves), HANDLE_ITEM_POINTER and RH_ROUND_REQUEST.  BCC's version of this
   file also has the swap-file bank and segment pinning; TLINK's has neither.

   The heap model, used by every file in src/heap:
   - Banks.  TLINK's heap has five banks: 0 conventional memory, 2 EMS (EMSBANK.C),
     3 extended memory (EXTBANK.C) and 4 an empty bank that only keeps the
     descriptors of discarded blocks; bank 1 is never set up (it is BCC's swap file).
     Each bank has a 40h-byte control record (struct HeapControl, always reached as
     ACTIVE_HEAP at DS:0).  The five records sit one after another at the start of
     bank 0's descriptor segment, so HEAP_DESCRIPTOR_SEGMENTS[bank] (in DGROUP) is that
     segment plus 4 paragraphs per bank, or 0 when the bank is not set up.  Code
     selects a bank by loading DS with that word; HEAP_PROGRAM_DS (a word in CODE2,
     OVREXMEM.ASM) gets DGROUP back.  Each bank has hooks in its record: +22h
     allocate, +24h release, +26h find or make free space, +28h write a block into the
     bank, +2Ah read a block out of it, +2Ch/+2Eh move a block within it.
   - Nodes (descriptors).  Every block, used or free, is described by a 20-byte
     HeapNode.  All nodes live in one table, from offset 140h in bank 0's descriptor
     segment (the descriptor block, itself a heap block); bank n sees the same table
     n*40h bytes lower (ACTIVE_HEAP.bank_adjustment).  key is where the block starts
     (a paragraph in bank 0, a unit number in the other banks), size its length in
     units, previous/next link the bank's nodes in address order between chain_head
     and chain_tail, field8 is the size asked for in bytes, field12 the owner tag,
     field18 a registered callback index, field19 the bank.  Free nodes (flag 4) are
     also on the free list (previous_free/next_free); in a used node those two words
     are instead the far "output" pointer at +0Eh.
   - Handles.  The owner of a block keeps one word, the handle, which the output
     pointer addresses.  The heap rewrites it whenever the block moves
     (RH_UPDATE_NODE_ADDRESS): it holds the block's segment (1000h or more) while the
     block is in conventional memory, else the node's index in the descriptor table.
     BCC_POOL_RESOLVE_WORD (HPDISP.C) turns a handle back into a bank and node.  For a
     segment handle the node's offset is kept in the last word (+0Eh) of the
     paragraph just below the block.
   - Flags (HeapNode.flags): 4 free, 8 fixed at the low end, 10h fixed at the high
     end, 20h may be moved out to another bank, 40h may be discarded (to bank 4), 80h
     a copy held in another bank, 100h a discarded copy in bank 4, 200h and 400h kept
     from the request (BCC's heap uses them for overlay code), 4000h the handle is a
     heap item (HPGETITM.C), 8000h locked: never reclaimed (compaction may still move
     it).  BCC's flags 800h and 1000h (tagging and the handle ring) are not used here.
   - Owner tags: see HPTAGS.C.

   A bank's region holds, in address order: blocks fixed at the low end (before
   ACTIVE_HEAP.head), the movable area (head up to ACTIVE_HEAP.end, the only part that
   compaction moves and the free list covers), and blocks fixed at the high end (from
   end on).  In bank 0 the descriptor table is the first block made, locked but in the
   movable area.  The move routines here are bank 0's move hooks; they copy with
   rep movsw (patched to movsd on a 386) and then rewrite the handle. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *offset);
/* The output pointer at +0Eh as two words (INIT_MAIN_HEAP sets them apart). */
struct HeapOutputWords {
    unsigned char preceding_observed_fields[0x0e];
    unsigned int offset,segment;
};
/* Far call vector in CODE_2 at 445D (RH_DISPATCH_NODE's), whose segment
   word is filled with CS at start-up. */
extern unsigned int far CALLBACK_TABLE_PTR_SEG;
typedef struct HeapDescriptor HeapDescriptor;
struct HeapDescriptor {     /* as in HPDESC.C: 20-byte descriptor-bank entry */
    unsigned char leading_fields[0x10];
    HeapDescriptor near *next_free;
    unsigned char trailing_fields[2];
};
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern unsigned int near pascal RH_NEWPAGE(void);
#include "RHHOOK.H"
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);

/* Return the output pointer of the node behind handle: the far address of
   the word where the heap keeps that block's handle (the owner's handle word
   or a heap item).  DS is switched to the node's bank only for the lookup;
   _loadds restores it. */
unsigned int far * far pascal _loadds HANDLE_ITEM_POINTER(unsigned int handle)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return ((struct HeapOutputNodeView near *)node_offset)->output;
}

/* Bank 0's hook_26: find a free node of at least size paragraphs.  No free
   node gives 0; a single free node is returned when big enough; otherwise
   the movable blocks are compacted to gather the free space at the high end
   (GATHER_FREE_AT_HIGH_END from end back to head), which returns the gathered
   node or 0. */
HeapNode near * near pascal CONV_FIND_FREE_NODE(unsigned int size)
{
    HeapNode near *node;
    if((node=ACTIVE_HEAP.free_head->next_free)==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) return node;
        return 0;
    }
    return GATHER_FREE_AT_HIGH_END(size,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
}

/* Convert a byte count to the active bank's units: (request + field6) /
   field8, with the add done in 32 bits so a request near FFFFh does not
   wrap.  Bank 0 uses (request + 13h) / 10h, paragraphs with room to spare
   (probably for the node back-pointer word kept below each block); the other
   banks use field8 = their unit and field6 = unit - 1.  The quotient is left
   in AX by the div (fall-off-end, as the original). */
unsigned int near pascal RH_ROUND_REQUEST(unsigned int request)
{
    asm mov ax,request;
    asm xor dx,dx;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.field6;
    asm adc dx,0;
    asm div word ptr DGROUP:ACTIVE_HEAP.field8;
}

/* Calls itself forever; nothing is known to call it (one of several such
   stubs in CODE_2, probably placeholders kept from Borland's source). */
void near pascal RH_SELF_CALL_BEFORE_MOVES(void)
{
    RH_SELF_CALL_BEFORE_MOVES();
}

/* Block moves installed as the heap's move hooks (INIT_MAIN_HEAP): copy the
   node's field8 bytes, rounded up to words, from its segment (key) to
   target.  On a 386 INIT_MAIN_HEAP patches the jmp at move_up_386 (and
   move_down_386, copy_386) to two nops, so the copy runs in dwords.
   RH_MOVE_BLOCK_UP copies upwards and RH_MOVE_BLOCK_DOWN backwards (for an
   overlapping move to a higher address).  Both then relocate: when the
   block was the current DS (a descriptor bank), the bank table in the
   program DS is rebuilt from the new segment and DS is left there; the
   paragraph below the block gets the node offset at +0Eh, the node's
   output gets the new segment unless it is flagged 800h, and the new key
   is reported through RH_DISPATCH_NODE (operation 3) when field18 is set.
   RH_COPY_BLOCK copies only (to target) and reports. */
void near pascal RH_MOVE_BLOCK_UP(HeapNode near *node,unsigned int target)
{
    asm push ds;
    asm mov di,node;
    asm mov cx,[di+8];
    asm add cx,1;
    asm rcr cx,1;
    asm mov ds,[di];
    asm mov es,target;
    asm xor si,si;
    asm xor di,di;
    asm cld;
    asm move_up_386 label near;
    asm jmp short up_words;
    asm shr cx,1;
    asm .386;
    asm rep movsd;
    asm .8086;
    asm rcl cx,1;
up_words:
    asm rep movsw;
    asm pop ax;
    asm mov bx,ds;
    asm mov si,es;
    asm cmp ax,bx;
    /* AX = the caller's DS, BX = the old segment: if the block was the
       descriptor segment in DS, rewrite every nonzero HEAP_DESCRIPTOR_SEGMENTS
       entry from the new segment (4 paragraphs per bank). */
    asm jne up_ds;
    asm mov di,offset DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
    asm mov es,word ptr cs:HEAP_PROGRAM_DS;
    asm mov cx,5;
    asm mov ax,si;
up_bank:
    asm cmp word ptr es:[di],0;
    asm je up_next;
    asm mov es:[di],ax;
up_next:
    asm add ax,4;
    asm add di,2;
    asm loop up_bank;
    asm mov ax,si;
up_ds:
    asm mov ds,ax;
    asm dec si;
    asm mov es,si;
    asm mov ax,node;
    asm mov es:[0Eh],ax;
    *((struct HeapOutputNodeView near *)node)->output=target;
    node->key=target;
    if(node->field18)
        RH_DISPATCH_NODE(node,3,((struct HeapOutputNodeView near *)node)->output,node->key);
}

/* Bank 0's move_node_2e: as RH_MOVE_BLOCK_UP, copying from the last word
   down (std), for a move to a higher address that may overlap. */
void near pascal RH_MOVE_BLOCK_DOWN(HeapNode near *node,unsigned int target)
{
    asm push ds;
    asm mov di,node;
    asm mov cx,[di+8];
    asm add cx,1;
    asm rcr cx,1;
    asm mov ds,[di];
    asm mov es,target;
    asm mov si,cx;
    asm dec si;
    asm shl si,1;
    asm std;
    asm move_down_386 label near;
    asm jmp short down_words;
    asm shr cx,1;
    asm jae down_even;
    asm mov di,si;
    asm movsw;
down_even:
    asm dec si;
    asm dec si;
    asm mov di,si;
    asm .386;
    asm rep movsd;
    asm .8086;
    asm jmp short down_done;
down_words:
    asm mov di,si;
    asm rep movsw;
down_done:
    asm cld;
    asm pop ax;
    asm mov bx,ds;
    asm mov si,es;
    asm cmp ax,bx;
    /* As in RH_MOVE_BLOCK_UP: rebuild the bank table if the block was the
       descriptor segment. */
    asm jne down_ds;
    asm mov di,offset DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
    asm mov es,word ptr cs:HEAP_PROGRAM_DS;
    asm mov cx,5;
    asm mov ax,si;
down_bank:
    asm cmp word ptr es:[di],0;
    asm je down_next;
    asm mov es:[di],ax;
down_next:
    asm add ax,4;
    asm add di,2;
    asm loop down_bank;
    asm mov ax,si;
down_ds:
    asm mov ds,ax;
    asm dec si;
    asm mov es,si;
    asm mov ax,node;
    asm mov es:[0Eh],ax;
    *((struct HeapOutputNodeView near *)node)->output=target;
    node->key=target;
    if(node->field18)
        RH_DISPATCH_NODE(node,3,((struct HeapOutputNodeView near *)node)->output,node->key);
}

/* Bank 0's hook_2a: copy the block to target without relocating it (see
   above). */
void near pascal RH_COPY_BLOCK(HeapNode near *node,unsigned int target)
{
    asm push ds;
    asm push si;
    asm push di;
    asm mov di,node;
    asm mov cx,[di+8];
    asm add cx,1;
    asm rcr cx,1;
    asm mov ds,[di];
    asm mov es,target;
    asm xor si,si;
    asm xor di,di;
    asm cld;
    asm copy_386 label near;
    asm jmp short copy_words;
    asm shr cx,1;
    asm .386;
    asm rep movsd;
    asm .8086;
    asm rcl cx,1;
copy_words:
    asm rep movsw;
    asm pop di;
    asm pop si;
    asm pop ds;
    if(node->field18)
        RH_DISPATCH_NODE(node,3,((struct HeapOutputNodeView near *)node)->output,target);
}

/* Heap set-up in the paragraphs start_seg..end_seg: the descriptor bank
   (descriptor entries from 140h) in the first paragraphs, the node chain
   (INIT_BANK), the descriptor block node, the move hooks and the first page. */
unsigned int near pascal INIT_MAIN_HEAP(unsigned int start_seg,unsigned int end_seg,
    int descriptors,unsigned int count)
{
    HeapDescriptor near *entry;
    HeapDescriptor near *end;
    end=(HeapDescriptor near *)(descriptors*sizeof(HeapDescriptor)+0x140);
    if(HEAP_CPU_TYPE==3) {
        asm mov ax,9090h;           /* nop nop over the three word-copy jmps */
        asm mov word ptr cs:move_up_386,ax;
        asm mov word ptr cs:move_down_386,ax;
        asm mov word ptr cs:copy_386,ax;
    }
    if(end_seg-start_seg<0x400) return 0x1000;
    /* fill in the segment of the callback vector RH_DISPATCH_NODE calls
       through, then work with DS = the new descriptor segment */
    asm mov word ptr cs:CALLBACK_TABLE_PTR_SEG,cs;
    asm push ds;
    ++start_seg;
    HEAP_DESCRIPTOR_SEGMENTS[0]=start_seg;
    asm mov ax,start_seg;
    asm mov ds,ax;
    asm mov es,ax;
    asm xor di,di;
    asm mov ax,di;
    asm mov cx,end;
    asm shr cx,1;
    asm cld;
    asm rep stosw;
    /* The rep stosw above cleared the five bank records and the descriptor
       entries; chain all entries into the free-descriptor list. */
    ACTIVE_HEAP.descriptor_head=(HeapNode near *)(entry=(HeapDescriptor near *)0x140);
    for(;entry<end;entry++) entry->next_free=entry+1;
    entry--;
    entry->next_free=0;
    ACTIVE_HEAP.descriptor_count=descriptors;
    /* Bank 0 covers the whole region, the descriptor segment included; the
       first allocation below lands at its start and becomes the descriptor
       block, locked (8000h), whose handle word is HEAP_DESCRIPTOR_SEGMENTS[0]
       itself, so moving the block updates the bank table. */
    INIT_BANK(start_seg,end_seg-start_seg,0,0x11,0x10);
    ACTIVE_HEAP.field5=ACTIVE_HEAP.field5|6;
    ACTIVE_HEAP.descriptor_block=(HeapNode near *)(entry=(HeapDescriptor near *)
        HEAP_ALLOC_NODE((unsigned int)end));
    /* The block's output points at the bank table in the program's DS:
       offset in C, segment (DGROUP) in asm through the BX the C store left
       loaded with entry, as the original does at 33B2/33B7. */
    ((struct HeapOutputWords near *)entry)->offset=FP_OFF(HEAP_DESCRIPTOR_SEGMENTS);
    asm mov word ptr [bx+10h],DGROUP;
    ((HeapNode near *)entry)->flags|=0x8000;
    RH_UPDATE_NODE_ADDRESS((HeapNode near *)entry,0);
    /* Bank 0's hooks; hook_22 and hook_24 were set by INIT_BANK.  Then the
       first page of handle items (RH_NEWPAGE, page size at least 20h bytes). */
    ACTIVE_HEAP.hook_28=RH_MOVE_BLOCK_UP;
    ACTIVE_HEAP.hook_2a=RH_COPY_BLOCK;
    ACTIVE_HEAP.move_node_2c=RH_MOVE_BLOCK_UP;
    ACTIVE_HEAP.move_node_2e=RH_MOVE_BLOCK_DOWN;
    ACTIVE_HEAP.hook_26=(HeapHook)CONV_FIND_FREE_NODE;
    ACTIVE_HEAP.page_size=count<0x20?0x20:count&0xfffc;
    ACTIVE_HEAP.page_segment=RH_NEWPAGE();
    asm pop ds;
    return 0;
}

/* Calls itself forever; another uncalled stub like RH_SELF_CALL_BEFORE_MOVES. */
void near pascal RH_SELF_CALL_BEFORE_SWAP(void)
{
    RH_SELF_CALL_BEFORE_SWAP();
}
