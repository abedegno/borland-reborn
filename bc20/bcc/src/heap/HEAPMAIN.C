/* target: CODE_2_RG2BTAIL */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: main heap set-up (INIT_MAIN_HEAP), conventional bank, swap-file
   bank, handle pointers, segment pinning and block moves. Entry points:
   HANDLE_ITEM_POINTER, PIN_SEGMENT, UNPIN_SEGMENT, CONV_FIND_FREE_NODE, RH_ROUND_REQUEST,
   RH_SELF_CALL_BEFORE_MOVES, RH_MOVE_BLOCK_UP, RH_MOVE_BLOCK_DOWN (+11 more). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: this file sets up the far-memory heap that holds all of BCC's
   large data (record pools, buffers, overlay code), and holds the code of two of
   its banks: bank 0 (conventional memory) and the swap-file banks 1 and 2.
   It runs at start-up (INIT_HEAP in RHINIT.C calls INIT_MAIN_HEAP and, with a
   swap path, INIT_SWAP_BANK) and then whenever a block must be moved.

   The heap model, used by every file in src/heap:
   - Banks.  Memory is split into six banks: 0 conventional memory, 1 and 2 swap
     files, 3 EMS, 4 extended memory, 5 an empty bank that only keeps the
     descriptors of discarded blocks.  Each bank has a 50h-byte control record
     (struct HeapControl, always reached as ACTIVE_HEAP at DS:0).  The six
     records sit one after another at the start of bank 0's descriptor segment,
     so HEAP_DESCRIPTOR_SEGMENTS[bank] (in the program's DS) is that segment plus
     5 paragraphs per bank, or 0 when the bank is not set up.  Code selects a
     bank by loading DS with that word; HEAP_PROGRAM_DS (a word in CODE_2) gets
     the program's DS back.  Each bank has hooks in its record: +22h allocate,
     +24h release, +26h find or make free space, +28h write a block into the
     bank, +2Ah read a block out of it, +2Ch/+2Eh move a block within it.
   - Nodes (descriptors).  Every block, used or free, is described by a 22-byte
     HeapNode.  All nodes live in one table, from offset 1E0h in bank 0's
     descriptor segment (the descriptor block, itself a heap block); a bank n
     sees the same table n*50h bytes lower (ACTIVE_HEAP.bank_adjustment).
     key is where the block starts (a paragraph in bank 0, a unit number in the
     other banks), size its length in units, previous/next link the bank's
     nodes in address order between chain_head and chain_tail, field8 is the
     size asked for in bytes, field12 the owner tag, field13 the handle-ring
     slot, field18 a registered callback index, field19 the bank.  Free nodes
     (flag 4) are also on the free list (previous_free/next_free); in a used
     node those two words are instead the far "output" pointer at +0Eh.
   - Handles.  The owner of a block keeps one word, the handle, which the
     output pointer addresses.  The heap rewrites it whenever the block moves
     (RH_UPDATE_NODE_ADDRESS): it holds the block's segment (1000h or more)
     while the block is in conventional memory, else the node's index in the
     descriptor table.  BCC_POOL_RESOLVE_WORD (HPDISP.C) turns a handle back
     into a bank and node.  For a segment handle the node's offset is kept in
     the last word (+0Eh) of the paragraph just below the block.
   - Flags (HeapNode.flags): 4 free, 8 fixed at the low end, 10h fixed at the
     high end, 20h may be moved out to another bank, 40h may be discarded (to
     bank 5), 80h a copy held in another bank, 100h a discarded copy in bank 5,
     200h keep the other bank's copy when the block comes back, 400h counted
     in field52 (probably overlay code), 800h tagged, 1000h in the handle ring,
     2000h has a copy in another bank (bank in field19>>3, node at +14h),
     4000h the handle is a heap item (HPGETITM.C), 8000h locked: never
     reclaimed or tagged (compaction may still move it).
   - Owner tags: see HPOWNTAG.C.  Handle ring and tagging: see HPRING.C.

   A bank's region holds, in address order: blocks fixed at the low end
   (before ACTIVE_HEAP.head), the movable area (head up to ACTIVE_HEAP.end,
   the only part that compaction moves and the free list covers), and blocks
   fixed at the high end (from end on).  In bank 0 the descriptor table is
   the first block made, locked but in the movable area.
   The move routines here are bank 0's move hooks; they copy with rep movsw
   (patched to movsd on a 386) and then rewrite the handle.  The swap-file
   hooks page blocks through the file in 512-byte units. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *offset);
extern unsigned long far pascal C31_MEMORY_LIMIT(void);
extern unsigned long far pascal C31_SET_MEMORY_LIMIT(unsigned long bytes);
extern unsigned int far pascal CHANGE_HEAP_NODE_MODE(unsigned int mode,unsigned int mask,
    unsigned int far *handle,unsigned int size);
extern void far pascal OVR_PRELOAD_SEGMENT(unsigned int segment);
/* The output pointer at +0Eh as two words (INIT_MAIN_HEAP sets them apart). */
struct HeapOutputWords {
    unsigned char preceding_observed_fields[0x0e];
    unsigned int offset,segment;
};
/* Far call vector in CODE_2 at 445D (RH_DISPATCH_NODE's), whose segment
   word is filled with CS at start-up. */
extern unsigned int far CALLBACK_TABLE_PTR_SEG;
typedef struct HeapDescriptor HeapDescriptor;
struct HeapDescriptor {     /* as in HPDESC.C: 22-byte descriptor-bank entry */
    unsigned char leading_fields[0x10];
    HeapDescriptor near *next_free;
    unsigned char trailing_fields[4];
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
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
extern unsigned char far SWAP_EXCHANGE_ALLOWED;
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern void near pascal DISCARD_SWAP_BANK(unsigned int bank);
extern HeapNode near * near pascal EXTEND_HEAP(unsigned int amount);
extern unsigned int near pascal RH_DOS_DUP(int handle);
extern void near pascal RH_DOS_CLOSE(int handle);
extern int near pascal RH_DOS_CREATE(char far *path,unsigned int unused);
extern unsigned int near pascal RH_DOS_WRITE(int handle,void far *buffer,
    unsigned int count);
extern unsigned int near pascal RH_DOS_READ(int handle,void far *buffer,
    unsigned int count);
extern unsigned long near pascal RH_DOS_SEEK(int handle,unsigned long offset,
    int whence);
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

/* Pin a block given by its segment so it stays in conventional memory at
   the low end of the heap.  The block's own word at segment:0Eh holds its
   handle (probably the header of an overlay code segment).  When the node is
   not already fixed (flags 8 or 10h): preload it through the overlay manager
   (OVR_PRELOAD_SEGMENT, with the program's DS), look the node up again since
   loading may have moved it, take it out of the reclaimable accounting
   (field52, tracked_nodes, tracked_size) and clear its flags 20h, 40h and
   400h, then fix it low with CHANGE_HEAP_NODE_MODE(8, 8).  The memory limit
   (C31_SET_MEMORY_LIMIT) is raised by the block's size for the change and
   put back after.  Returns 0, 1000h when the limit cannot be raised, or the
   result of CHANGE_HEAP_NODE_MODE.  UNPIN_SEGMENT undoes it. */
unsigned int far pascal _loadds PIN_SEGMENT(unsigned int segment)
{
    unsigned int far *header;
    HeapNode near *node;
    unsigned long limit;
    unsigned long bytes;
    unsigned int size;
    header=(unsigned int far *)(((unsigned long)segment<<16)|0x0e);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[BCC_POOL_RESOLVE_WORD(*header,
        (unsigned int far *)&node)];
    if(!(node->flags&0x18)) {
        asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
        OVR_PRELOAD_SEGMENT(segment);
        _DS=HEAP_DESCRIPTOR_SEGMENTS[BCC_POOL_RESOLVE_WORD(*header,
            (unsigned int far *)&node)];
        limit=C31_MEMORY_LIMIT();
        /* bytes = size << 4, a paragraph count in bytes, without the
           runtime's long-shift helper */
        size=node->size;
        asm mov ax,size;
        asm xor dx,dx;
        asm shl ax,1;
        asm rcl dx,1;
        asm shl ax,1;
        asm rcl dx,1;
        asm shl ax,1;
        asm rcl dx,1;
        asm shl ax,1;
        asm rcl dx,1;
        asm mov word ptr bytes,ax;
        asm mov word ptr bytes+2,dx;
        if(C31_SET_MEMORY_LIMIT(limit+bytes)!=limit+bytes) return 0x1000;
        if(node->flags&0x400) ACTIVE_HEAP.field52-=node->size;
        --ACTIVE_HEAP.tracked_nodes;
        ACTIVE_HEAP.tracked_size-=node->size;
        node->flags&=0xfb9f;
        C31_SET_MEMORY_LIMIT(limit);
        return CHANGE_HEAP_NODE_MODE(8,8,header,0);
    }
    return 0;
}

/* Undo PIN_SEGMENT: when the block is fixed low (flag 8), release the fix
   (CHANGE_HEAP_NODE_MODE(0, 8)), make it reclaimable again (flags 460h) and
   count it back into field52, tracked_nodes and tracked_size.  When it has a
   copy in another bank (flag 2000h), that copy is flagged 400h too. */
void far pascal _loadds UNPIN_SEGMENT(unsigned int segment)
{
    unsigned int far *header;
    HeapNode near *node;
    int bank;
    header=(unsigned int far *)(((unsigned long)segment<<16)|0x0e);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[BCC_POOL_RESOLVE_WORD(*header,
        (unsigned int far *)&node)];
    if(node->flags&8) {
        CHANGE_HEAP_NODE_MODE(0,8,header,0);
        node->flags|=0x460;
        if(node->flags&0x400) ACTIVE_HEAP.field52+=node->size;
        ++ACTIVE_HEAP.tracked_nodes;
        ACTIVE_HEAP.tracked_size+=node->size;
        if(node->flags&0x2000) {
            bank=node->field19>>3;
            node=(HeapNode near *)((struct HeapReleaseNode near *)node)->bank_handle;
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
            node->flags|=0x400;
        }
    }
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
       entry from the new segment (5 paragraphs per bank). */
    asm jne up_ds;
    asm mov di,offset DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
    asm mov es,word ptr cs:HEAP_PROGRAM_DS;
    asm mov cx,6;
    asm mov ax,si;
up_bank:
    asm cmp word ptr es:[di],0;
    asm je up_next;
    asm mov es:[di],ax;
up_next:
    asm add ax,5;
    asm add di,2;
    asm loop up_bank;
    asm mov ax,si;
up_ds:
    asm mov ds,ax;
    asm dec si;
    asm mov es,si;
    asm mov ax,node;
    asm mov es:[0Eh],ax;
    if(!(node->flags&0x800)) *((struct HeapOutputNodeView near *)node)->output=target;
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
    asm mov cx,6;
    asm mov ax,si;
down_bank:
    asm cmp word ptr es:[di],0;
    asm je down_next;
    asm mov es:[di],ax;
down_next:
    asm add ax,5;
    asm add di,2;
    asm loop down_bank;
    asm mov ax,si;
down_ds:
    asm mov ds,ax;
    asm dec si;
    asm mov es,si;
    asm mov ax,node;
    asm mov es:[0Eh],ax;
    if(!(node->flags&0x800)) *((struct HeapOutputNodeView near *)node)->output=target;
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
   (descriptors entries from 1E0h) in the first paragraphs, the node chain
   (INIT_BANK), the descriptor block node, the move hooks and the first page. */
unsigned int near pascal INIT_MAIN_HEAP(unsigned int start_seg,unsigned int end_seg,
    int descriptors,unsigned int count)
{
    HeapDescriptor near *entry;
    HeapDescriptor near *end;
    end=(HeapDescriptor near *)(descriptors*sizeof(HeapDescriptor)+0x1e0);
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
    /* The rep stosw above cleared the six bank records and the descriptor
       entries; chain all entries into the free-descriptor list. */
    ACTIVE_HEAP.descriptor_head=(HeapNode near *)(entry=(HeapDescriptor near *)0x1e0);
    for(;entry<end;entry++) entry->next_free=entry+1;
    entry--;
    entry->next_free=0;
    ACTIVE_HEAP.descriptor_count=descriptors;
    /* Bank 0 covers the whole region, the descriptor segment included; the
       first allocation below lands at its start and becomes the descriptor
       block, locked (8000h), whose handle word is HEAP_DESCRIPTOR_SEGMENTS[0]
       itself, so moving the block updates the bank table. */
    INIT_BANK(start_seg,end_seg-start_seg,0,0x13,0x10);
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

/* Swap-file bank (set up by INIT_SWAP_BANK): ACTIVE_HEAP.page_segment holds
   the file handle and page_size the bank's single big node. */

unsigned int near pascal SWAP_EXTEND_FILE(unsigned long size);
HeapNode near * near pascal SWAP_MAKE_ROOM(unsigned int size);

/* Called at the start of every swap-bank operation.  The first time (the
   program-DS counter SWAP_FILE_PREPARED, shared by banks 1 and 2) it grows the
   swap file by 128K.  When that fails the bank is closed and deleted
   (DISCARD_SWAP_BANK) and its HEAP_DESCRIPTOR_SEGMENTS entry cleared, and
   1003h is returned; otherwise 0.  The push/pop ds pairs keep the caller's
   bank DS while the counter is read through the program's DS. */
unsigned int near pascal SWAP_PREPARE_FILE(void)
{
    unsigned int bank;
    bank=ACTIVE_HEAP.field4;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    if(SWAP_FILE_PREPARED==0) {
        ++SWAP_FILE_PREPARED;
        asm pop ds;
        asm push ds;
        if(SWAP_EXTEND_FILE(0x20000UL)) {
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            DISCARD_SWAP_BANK(bank);
            HEAP_DESCRIPTOR_SEGMENTS[bank]=0;
            asm pop ds;
            return 0x1003;
        }
    }
    asm pop ds;
    return 0;
}

/* Grow the active swap bank's file by size bytes: seek to its end and write
   size bytes in pieces of at most 32K taken from whatever memory is at
   4000:0000 (the contents do not matter, only the length).  Then duplicate
   and close the handle, which makes DOS record the new length.  Returns 0,
   or 1003h on any error.  The code after "ok:" can never run; it is in the
   original. */
unsigned int near pascal SWAP_EXTEND_FILE(unsigned long size)
{
    unsigned int buffer;
    unsigned int chunk;
    SWAP_PREPARE_FILE();
    buffer=0x4000;
    if(RH_DOS_SEEK(ACTIVE_HEAP.page_segment,0UL,2)!=0xFFFFFFFFUL) {
        while(size) {
            if(size>0x8000) chunk=0x8000;
            else chunk=(unsigned int)size;
            if(RH_DOS_WRITE(ACTIVE_HEAP.page_segment,(void far *)((unsigned long)buffer<<16),chunk)!=chunk)
                return 0x1003;
            size-=chunk;
        }
        if(RH_DOS_DUP(ACTIVE_HEAP.page_segment)>0) { RH_DOS_CLOSE(_AX); goto ok; }
    } else return 0x1003;
    return 0x1003;      /* separate returns, as the original: tail-merged */
ok:
    return 0;
    asm pop ds;
    return 0x1003;
}

/* Page a node in from (34FB) or out to (3574) the swap file: seek to the
   node's key times the unit (field8), then read or write the node's field8
   bytes at segment target, in two pieces when they exceed FFF0h.  An I/O
   error is reported through the status hook (1, E000h/E001h). */
#define SWAP_TRANSFER(io,code) \
    RH_DOS_SEEK(ACTIVE_HEAP.page_segment,(unsigned long)node->key*ACTIVE_HEAP.field8,0); \
    asm mov ax,target; \
    asm push word ptr DGROUP:ACTIVE_HEAP.page_segment; \
    asm push ax; \
    asm mov bx,node; \
    asm mov cx,[bx+8]; \
    asm cmp cx,-16; \
    asm jbe one_piece; \
    asm mov dx,0FFF0h; \
    asm push dx; \
    asm sub cx,dx; \
    asm push cx; \
    asm push word ptr DGROUP:ACTIVE_HEAP.page_segment; \
    asm push ax; \
    asm xor cx,cx; \
    asm push cx; \
    asm push dx; \
    asm call io; \
    asm jae second_piece; \
    asm add sp,8; \
    asm jmp short io_error; \
one_piece: \
    asm xor ax,ax; \
    asm push ax; \
    asm push cx; \
second_piece: \
    asm call io; \
    asm jae done; \
io_error: \
    asm push ds; \
    asm mov ax,1; \
    asm push ax; \
    asm mov ax,code; \
    asm push ax; \
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS; \
    asm call dword ptr DGROUP:HEAP_HOOK_CALLSITE; \
    asm pop ds; \
done: ;

/* Swap bank's hook_2a: read a node's field8 bytes from the swap file into
   the paragraph target. */
void near pascal SWAP_READ_NODE(HeapNode near *node,unsigned int target)
{
    SWAP_PREPARE_FILE();
    if(node->field8) {
        SWAP_TRANSFER(RH_DOS_READ,0E000h)
    }
}

/* Swap bank's hook_28: write a node's field8 bytes from the paragraph
   target to its place in the swap file. */
void near pascal SWAP_WRITE_NODE(HeapNode near *node,unsigned int target)
{
    SWAP_PREPARE_FILE();
    if(node->field8) {
        SWAP_TRANSFER(RH_DOS_WRITE,0E001h)
    }
}

/* Swap bank's move hook (move_node_2c): page the node out at its old key
   and back in at the new one, through the bank-0 base segment. */
void near pascal SWAP_MOVE_NODE(HeapNode near *node,unsigned int key)
{
    unsigned int base;
    SWAP_PREPARE_FILE();
    _ES=ACTIVE_HEAP.program_segment;
    asm mov es,es:[offset DGROUP:HEAP_DESCRIPTOR_SEGMENTS];
    asm mov ax,es:[0];
    asm mov base,ax;
    /* Read the block from its old place in the file into memory at base,
       then write it out at the new key.  base is the word at offset 0 of
       bank 0's record, leading_fields[0]: the first paragraph of the
       conventional heap.  The moves seen come from SWAP_MAKE_ROOM's
       compaction, which first saves that area (see there); so "page out and
       back in" above means read from the old key, write to the new one. */
    SWAP_READ_NODE(node,base);
    node->key=key;
    SWAP_WRITE_NODE(node,base);
}

/* Swap bank's reclaim hook (hook_26): free room in the swap bank for
   size units, growing the file when SWAP_GROW_FILE_ALLOWED allows, else (SWAP_EXCHANGE_ALLOWED)
   by exchanging the descriptor block with the memory above it while the
   bank is paged out and in again.  Returns the free node, or 0. */
HeapNode near * near pascal SWAP_MAKE_ROOM(unsigned int size)
{
    HeapNode near *node;
    unsigned int base;
    unsigned int count;
    unsigned int delta;
    unsigned int bank;
    count=0;
    delta=0;
    bank=ACTIVE_HEAP.field4;
    SWAP_PREPARE_FILE();
    /* First choice: grow the file by 64K and add those 80h units to the
       bank (EXTEND_HEAP). */
    if(SWAP_GROW_FILE_ALLOWED && !SWAP_EXTEND_FILE(0x10000UL)) {
        node=EXTEND_HEAP(0x80);
        if(node->size>=size) goto done;
    }
    if(SWAP_EXCHANGE_ALLOWED==0) return 0;
    if((node=ACTIVE_HEAP.free_head->next_free)==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) goto done;
        return 0;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    /* Compaction needs a 64K bounce buffer at base, the start of the
       conventional heap, where the descriptor block lives.  When the
       descriptor block starts within 64K of base, exchange its contents with
       the same number of bytes at the top of the conventional heap and
       shift HEAP_DESCRIPTOR_SEGMENTS[0] and [bank] by delta paragraphs, so the
       descriptors stay usable while base is overwritten.  Fails when the
       heap is too small for that.  DS is bank 0 here, so ACTIVE_HEAP is
       bank 0's record. */
    node=ACTIVE_HEAP.descriptor_block;
    base=ACTIVE_HEAP.leading_fields[0];
    if(node->key-ACTIVE_HEAP.leading_fields[0]<0x1000) {
        if(node->size+0x1000>ACTIVE_HEAP.leading_fields[1]) {
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
            return 0;
        }
        _ES=ACTIVE_HEAP.leading_fields[0]+ACTIVE_HEAP.leading_fields[1]-node->size;
        delta=_ES-_DS;
        count=node->field8;
        _CX=_AX;        /* C rather than asm: keeps the jae over this block short */
        asm mov bx,cx;
        asm dec bx;
        asm dec bx;
        _CX>>=1;
    swap_up:
        asm mov ax,[bx];
        asm xchg es:[bx],ax;
        asm mov [bx],ax;
        asm dec bx;
        asm dec bx;
        asm loop swap_up;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    HEAP_DESCRIPTOR_SEGMENTS[bank]+=delta;
    HEAP_DESCRIPTOR_SEGMENTS[0]+=delta;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    /* Save the 64K at base into the swap bank's reserved node (page_size,
       see INIT_SWAP_BANK), compact the bank through SWAP_MOVE_NODE, then put
       the 64K back. */
    SWAP_WRITE_NODE((HeapNode near *)ACTIVE_HEAP.page_size,base);
    node=GATHER_FREE_AT_HIGH_END(0xffff,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
    SWAP_READ_NODE((HeapNode near *)ACTIVE_HEAP.page_size,base);
    asm mov cx,count;
    /* When the descriptor block was exchanged, swap it back and undo the
       segment shift. */
    asm jcxz done;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    asm mov ax,ds;
    asm sub ax,delta;
    asm mov es,ax;
    asm xor bx,bx;
    asm shr cx,1;
swap_back:
    asm mov ax,[bx];
    asm xchg es:[bx],ax;
    asm mov [bx],ax;
    asm inc bx;
    asm inc bx;
    asm loop swap_back;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    HEAP_DESCRIPTOR_SEGMENTS[bank]-=delta;
    HEAP_DESCRIPTOR_SEGMENTS[0]-=delta;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
done:
    return node;
}

/* Swap bank set-up: create the swap file at path, make bank `bank' (at the
   bank-0 segment plus 5 paragraphs per bank) describe it in 512-byte units,
   and install the swap hooks.  Does nothing below 128K (20000h). */
/* The swap bank keeps its file's name where other banks keep field52/54. */
struct SwapControl {
    unsigned char preceding_fields[0x34];
    unsigned long path;
};

unsigned int near pascal INIT_SWAP_BANK(int bank,unsigned long size,unsigned long path)
{
    HeapNode near *node;
    int handle;
    if(size<0x20000UL) return 0;
    /* The path is built in DX:AX before the push (as the original does). */
    _AX=(unsigned int)path;
    _DX=(unsigned int)(path>>16);
    handle=RH_DOS_CREATE((char far *)MK_FP(_DX,_AX),0);
    if(handle==-1) return 0x1002;
    asm push ds;
    HEAP_DESCRIPTOR_SEGMENTS[bank]=HEAP_DESCRIPTOR_SEGMENTS[0]+bank*5;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    ACTIVE_HEAP.page_segment=handle;
    ((struct SwapControl near *)&ACTIVE_HEAP)->path=path;
    asm pop ds;
    asm push ds;
    /* Units of 512 bytes from key 0.  The first node, FFFFh bytes (80h
       units) at key 0, is fixed low and locked (8008h) with no handle: it
       reserves room in the file for SWAP_MAKE_ROOM's 64K save area, and its
       node offset is kept in page_size (page_segment holds the file handle). */
    INIT_BANK(0,(unsigned int)(size>>9),bank,0x1ff,0x200);
    ACTIVE_HEAP.page_size=(unsigned int)(node=HEAP_ALLOC_NODE(0xffff));
    node->flags|=0x8008;
    ((struct HeapOutputNodeView near *)node)->output=0;
    ACTIVE_HEAP.head=ACTIVE_HEAP.current=node->next;
    ACTIVE_HEAP.field5=ACTIVE_HEAP.field5|0x80;
    ACTIVE_HEAP.hook_28=SWAP_WRITE_NODE;
    ACTIVE_HEAP.hook_2a=SWAP_READ_NODE;
    ACTIVE_HEAP.move_node_2c=SWAP_MOVE_NODE;
    ACTIVE_HEAP.hook_26=(HeapHook)SWAP_MAKE_ROOM;
    asm pop ds;
    return 0;
}

/* Far entry: set up swap bank 2 as a 128K file at path, after making sure
   there are spare descriptors.  Returns 0, 1002h when the file cannot be
   created, or 1000h. */
unsigned int far pascal _loadds START_SWAP_BANK(char far *path)
{
    if(RH_PREPARE_DESCRIPTORS()==0) return INIT_SWAP_BANK(2,0x20000UL,(unsigned long)path);
    return 0x1000;
}
