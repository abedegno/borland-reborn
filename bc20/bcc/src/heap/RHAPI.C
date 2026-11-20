/* target: CODE_2_RHAPI */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: CODE_2 far-memory heap: nodes, banks (conventional, EMS, extended, swap file),
   overlay support. Entry points: SET_NODE_INFO, RH_HANDLE_TRY_FLAG40, ALLOC_BANK5_NODE,
   C31_SET_MEMORY_LIMIT, C31_MEMORY_LIMIT, SET_NODE_REQUEST_SIZE, LOCK_HEAP_NODE,
   UNLOCK_HEAP_NODE (+9 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the far entry points that the rest of BCC (pools, overlay
   manager, start-up) uses on heap blocks, and the bank-0 allocation and mode
   change machinery behind them.  See HEAPMAIN.C's overview for banks, nodes,
   handles and node flags.  A caller names a block by a far pointer to its
   handle word; the functions resolve it to a bank and node, select the bank
   in DS, and report through HEAP_STATUS (and, on failure, the status hook
   HEAP_HOOK_CALLSITE, which is BCC's OUT_OF_MEMORY_HANDLER).
   The central routine is CHANGE_HEAP_NODE_MODE: it allocates (mode 800h or
   4000h), frees (mode 4), brings a block back from another bank into bank 0,
   resizes it (mode 1000h, new size in size), changes its reclaim bits (20h,
   40h, 200h, 1, 2) and fixes or unfixes it at the low (8) or high (10h) end.
   It uses ALLOC_BANK0_NODE, which allocates in bank 0 (retrying while the
   status hook frees memory) and can take over a node from another bank,
   copying its contents in.  Other entries set node fields (callback index
   field18, request size field8, lock flag 8000h), read and set the paragraph
   reserve field54 (C31_*), and evict a block (RH_HANDLE_TRY_FLAG20/40).
   ADOPT_EXTERNAL_REGIONS runs once at start-up (INIT_MEMORY_MANAGER in
   MEMINIT.C).  Bank 0's record is told from the others by field5 & 4. */
/* CODE_2:1D7F..2BB0, the heap's handle API (no listing; the old linkgroup
   gap LG002).  Most entries are far pascal _loadds functions taking a
   handle pointer: they resolve the handle to a bank and node offset
   (BCC_POOL_RESOLVE_WORD), switch DS to that bank, act on the node, and
   report status in HEAP_STATUS (0, 1000h, 1002h).
   - SET_NODE_INFO/276D set a node's field18 from an info record; 276D also
     allocates the node in bank 5.
   - RH_HANDLE_TRY_FLAG40/295E try to reclaim a node (RH_TRY_FLAG40/RH_TRY_FLAG20).
   - SET_NODE_REQUEST_SIZE sets field8; 28F4/2929 set and clear flag 8000h; 29C1
     returns the flags.
   - C31_SET_MEMORY_LIMIT/C31_MEMORY_LIMIT set and read the paragraph limit
     (field54), reclaiming space first when needed.
   - ALLOC_BANK0_NODE allocates a node in bank 0 (retrying through the heap
     hook), optionally taking over a node from another bank.
   - CHANGE_HEAP_NODE_MODE changes a node's mode bits (size, tracking, fixed at the
     low or high end, release), moving the node when needed; CHANGE_TAG_NODES_MODE
     applies it to every node owned by a tag.
   - ADOPT_EXTERNAL_REGIONS brings a chain of external regions into the heap.
   - SPLIT_NODE_TAIL splits the tail off a node; MOVE_NODE_TO_RING_HEAD re-files a node
     as the newest entry of the handle ring (UNTAG_NODE, RH_CLEAR_TAG_ENTRY,
     RING_PUSH_NODE); CALL_SELF_FOREVER calls itself forever.

   Compiled through TASM (-B), as the neighbouring heap modules.  Inline asm
   is used for the CS-relative program-DS loads, saving DS around bank
   switches, the bank loops' segment loads, long shifts without the runtime
   helper (C31_* and 2883's free_size<<4), the byte shift by CL for field19
   (the C form (unsigned char)(bank<<3) was tried: BCC shifts by 1 three
   times), and 2883's region walk.
   Segment set-up is written as _DS=/_ES= assignments, as in HPALLOCH; DS goes
   back to DGROUP either as _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED) (as HPALLOCH) or, where
   the original's DGROUP load is asm, as asm.
   Documented exceptions:
   - pseudo-register reads: _AL after the field19 asm (21B4, 2AE9); _ES after
     2883's walk (2937).
   - register argument: __OvrPrepare (cdecl _OvrPrepare) takes the region segment in ES
     (_ES=block.words.segment, 2B43).
   - dummy statement: the empty arm in CHANGE_HEAP_NODE_MODE at 2461.
   - ADOPT_EXTERNAL_REGIONS adds free, a long local read before its first
     assignment (29D5), to size (28E2): the original's own bug.  The asm just before it computes
     free_size<<4 in DX:AX and leaves it unused; a missing store of DX:AX
     into free was probably intended.  It is kept as the bytes have it. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
#include "RHHOOK.H"
#include "DATA.H"
struct HeapItem;
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *offset);
extern unsigned char near pascal REGISTER_FAR_CALLBACK(void far *info);
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern unsigned int near pascal RH_TRY_FLAG20(HeapNode near *node);
extern unsigned int near pascal RH_TRY_FLAG40(HeapNode near *node);
extern HeapNode near * near pascal NEW_BANK5_NODE(unsigned int request);
extern HeapNode near * near pascal ALLOC_FIXED_LOW(unsigned int request);
extern HeapNode near * near pascal ALLOC_FIXED_HIGH(unsigned int request);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,HeapNode near *first,
    HeapNode near *restart,HeapNode near *stop);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern unsigned int near cdecl RH_HEAP_DISPATCH(unsigned int bank,unsigned int operation,...);
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern HeapNode near * near pascal RESIZE_NODE(HeapNode near *node,unsigned int size);
extern void near pascal SHRINK_NODE(HeapNode near *node,unsigned int request);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern void near pascal UNTAG_NODE(HeapNode near *node);
extern void near pascal RH_CLEAR_TAG_ENTRY(HeapNode near *node);
extern void near pascal RING_PUSH_NODE(HeapNode near *node,unsigned char force);
extern unsigned int near pascal UNFIX_LOW_NODE(HeapNode near *node);
extern unsigned int near pascal UNFIX_HIGH_NODE(HeapNode near *node);
extern void near pascal RHSWAP(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,unsigned int size,
    unsigned char mode);
extern unsigned int near pascal RH_GROW_DESCRIPTORS(unsigned int count);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
extern unsigned int near pascal OVR_READ_AT_OFFSET(unsigned int target,
    unsigned long key,unsigned long size);
extern void near cdecl _OvrPrepare(void);    /* takes the region segment in ES */
extern HeapNode near * near pascal RH_COPY_DESCRIPTOR(unsigned int source_bank,
    unsigned int target_bank,HeapNode near *source,HeapNode near *target);

/* Register info as a far callback (REGISTER_FAR_CALLBACK gives a one-byte
   index) and store the index in the node's field18; the heap then reports
   moves and evictions of that block through RH_DISPATCH_NODE.  Returns 0,
   or 1002h for a bad handle or when registration fails. */
unsigned int far pascal _loadds SET_NODE_INFO(unsigned int far *handle,void far *info)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    if(bank<6) {
        HEAP_STATUS=0;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if((((HeapNode near *)node_offset)->field18=REGISTER_FAR_CALLBACK(info))!=0)
            return 0;
    }
    HEAP_STATUS=0x1002;
    return 0x1002;
}

/* Discard a bank-0 block to bank 5 (RH_TRY_FLAG40), after making sure there
   are spare descriptors.  Returns 0, or 1000h when the block is not in bank 0
   or no descriptors could be made; RH_TRY_FLAG40's own result is ignored. */
unsigned int far pascal _loadds RH_HANDLE_TRY_FLAG40(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    if(bank==0 && RH_PREPARE_DESCRIPTORS()==0) {
        HEAP_STATUS=0;
        asm push ds;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        RH_TRY_FLAG40((HeapNode near *)node_offset);
        asm pop ds;
        return 0;
    }
    HEAP_STATUS=0x1000;
    return 0x1000;
}

/* Create a block of request bytes that has no memory yet: a node in bank 5
   with flags 761h (discardable, reclaimable, 400h, bank-5 copy), output as
   its handle word and info registered as its callback.  The handle gets the
   node's descriptor index.  Probably used for overlay code that the callback
   loads on first use.  Returns 0, or 1002h (no info or no descriptors). */
unsigned int far pascal _loadds ALLOC_BANK5_NODE(unsigned int far *output,
    unsigned int request,void far *info)
{
    HeapNode near *node;
    if(info && RH_PREPARE_DESCRIPTORS()==0) {
        HEAP_STATUS=0;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[5];
        node=NEW_BANK5_NODE(request);
        node->field8=request;
        node->flags=0x761;
        ((struct HeapOutputNodeView near *)node)->output=output;
        node->field18=REGISTER_FAR_CALLBACK(info);
        RH_UPDATE_NODE_ADDRESS(node,3);
        return 0;
    }
    HEAP_STATUS=0x1002;
    return 0x1002;
}

/* Set field54, the paragraph reserve kept for nodes flagged 400h (see
   RH_AVAILABLE_SPACE), to bytes rounded up to paragraphs.  If the reserve
   would exceed field52 plus the free space, blocks are reclaimed first; the
   reserve is then clipped to what is available.  Returns the new reserve in
   bytes.  PIN_SEGMENT raises it briefly. */
unsigned long far pascal _loadds C31_SET_MEMORY_LIMIT(unsigned long bytes)
{
    unsigned int available;
    unsigned int paragraphs;
    unsigned long result;
    asm mov ax,word ptr bytes;      /* (bytes+15)>>4 without the helper */
    asm mov dx,word ptr bytes+2;
    asm add ax,15;
    asm adc dx,0;
    asm shr dx,1;
    asm rcr ax,1;
    asm shr dx,1;
    asm rcr ax,1;
    asm shr dx,1;
    asm rcr ax,1;
    asm shr dx,1;
    asm rcr ax,1;
    asm mov paragraphs,ax;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(ACTIVE_HEAP.field52+ACTIVE_HEAP.free_size<paragraphs)
        RECLAIM_FOR_SPACE(paragraphs-ACTIVE_HEAP.field52,ACTIVE_HEAP.current,ACTIVE_HEAP.head,
            ACTIVE_HEAP.end);
    available=ACTIVE_HEAP.field52+ACTIVE_HEAP.free_size;
    ACTIVE_HEAP.field54=paragraphs<available?paragraphs:available;
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP.field54;  /* field54<<4 */
    asm xor dx,dx;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm mov word ptr result,ax;
    asm mov word ptr result+2,dx;
    return result;
}

/* Return field54 of bank 0, the reserve set by C31_SET_MEMORY_LIMIT, in
   bytes. */
unsigned long far pascal _loadds C31_MEMORY_LIMIT(void)
{
    unsigned long result;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP.field54;  /* field54<<4 */
    asm xor dx,dx;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm mov word ptr result,ax;
    asm mov word ptr result+2,dx;
    return result;
}

/* Set the byte size (field8) of a block that is in bank 5 (not loaded).
   Returns 0, or 1002h when the block is elsewhere. */
unsigned int far pascal _loadds SET_NODE_REQUEST_SIZE(unsigned int far *handle,unsigned int request)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    if(bank==5) {
        HEAP_STATUS=0;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[5];
        ((HeapNode near *)node_offset)->field8=request;
        return 0;
    }
    HEAP_STATUS=0x1002;
    return 0x1002;
}

/* Lock a block (flag 8000h): it is then never tagged or reclaimed (moved
   out of bank 0), though compaction may still move it within the bank.
   UNLOCK_HEAP_NODE clears the flag. */
void far pascal _loadds LOCK_HEAP_NODE(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    ((HeapNode near *)node_offset)->flags|=0x8000;
}

void far pascal _loadds UNLOCK_HEAP_NODE(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    ((HeapNode near *)node_offset)->flags&=0x7fff;
}

/* Move a bank-0 block out to another bank (RH_TRY_FLAG20) to free its
   conventional memory; a block with no bytes (field8 0) counts as done.
   Returns, and stores in HEAP_STATUS, 0 or 1000h. */
unsigned int far pascal _loadds RH_HANDLE_TRY_FLAG20(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank;
    unsigned int result;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    result=0x1000;
    if(bank==0 && RH_PREPARE_DESCRIPTORS()==0) {
        asm push ds;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if(((HeapNode near *)node_offset)->field8)
            result=RH_TRY_FLAG20((HeapNode near *)node_offset);
        else result=0;
        asm pop ds;
    }
    HEAP_STATUS=result;
    return result;
}

unsigned int far pascal _loadds GET_HEAP_NODE_FLAGS(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return ((HeapNode near *)node_offset)->flags;
}

/* Allocate a node in bank 0 for request bytes, with handle word output.
   mode 8 fixes it at the low end, 10h at the high end, otherwise it goes in
   the movable area; mode 400h lets the allocation use the 400h reserve
   (field5 & 1 while allocating).  When no space is found the status hook
   is called with (1, 100h); if it sets HEAP_STATUS back to 0 (it freed
   something) the allocation is retried.  When source is given (a node in
   bank `bank'), the new node takes it over: the descriptor data is copied
   (RH_COPY_DESCRIPTOR), the contents are read in through that bank's
   hook_2a, and the source is either kept as a valid copy (source flagged
   200h, banks 1 to 4: flag 2000h, field19 = bank<<3, word +14h = source) or
   released in its bank (hook_24).  Returns the node, or 0. */
HeapNode near * near pascal ALLOC_BANK0_NODE(unsigned int mode,unsigned int far *output,
    unsigned int request,int bank,HeapNode near *source)
{
    HeapNode near *node;
    unsigned int key;
    _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
retry:
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(mode&0x400) ACTIVE_HEAP.field5=ACTIVE_HEAP.field5|1;
    if(mode&8) node=ALLOC_FIXED_LOW(request);
    else if(mode&0x10) node=ALLOC_FIXED_HIGH(request);
    else node=HEAP_ALLOC_NODE(request);
    ACTIVE_HEAP.field5=ACTIVE_HEAP.field5&~1;
    if(!node) {
        asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
        HEAP_HOOK_CALLSITE(1,0x100);
        if(HEAP_STATUS==0) goto retry;     /* shape goto: the hook freed memory */
    }
    if(node) {
        ((struct HeapOutputNodeView near *)node)->output=output;
        node->flags|=mode&0x600;
        if(source) {
            key=node->key;
            asm push ds;
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
            if(source->field8>request) source->field8=request;
            RH_COPY_DESCRIPTOR(bank,0,source,node);
            ACTIVE_HEAP.hook_2a(source,key);
            if((source->flags&0x200) && bank>=1 && bank<5) {
                asm pop ds;
                node->flags|=0x2000;
                asm mov al,byte ptr bank;
                asm mov cl,3;
                asm shl al,cl;
                asm or al,byte ptr DGROUP:ACTIVE_HEAP.field4;
                node->field19=_AL;
                ((struct HeapReleaseNode near *)node)->bank_handle=(unsigned int)source;
            } else {
                ACTIVE_HEAP.hook_24(source);
                asm pop ds;
                node->flags&=~0x2000;
                node->field19=0;
            }
            if(node->flags&0x400) ACTIVE_HEAP.field52+=node->size;
            node->flags&=0xfe7f;
            RH_UPDATE_NODE_ADDRESS(node,1);
            if(node->flags&0x60) {
                ++ACTIVE_HEAP.tracked_nodes;
                ACTIVE_HEAP.tracked_size+=node->size;
            }
        } else RH_UPDATE_NODE_ADDRESS(node,1);
        node->flags|=mode&0x18;
    }
    return node;
}

/* Change the mode of the block behind handle: the bits of mode selected by
   mask become its new flags, other bits are kept.  See the overview for the
   mode bits.  size is the new byte size for 1000h and for an allocation.
   The block is first brought back into bank 0 when it is elsewhere.  After
   "mode^=node->flags" mode holds the bits that change, so the tests of 8 and
   10h below toggle the fixed state.  Returns 0, 1000h (no memory), 1001h (no
   descriptors) or 1002h (bad handle), also in HEAP_STATUS; any error is
   passed to the status hook. */
unsigned int far pascal _loadds CHANGE_HEAP_NODE_MODE(unsigned int mode,unsigned int mask,
    unsigned int far *handle,unsigned int size)
{
    HeapNode near *node;
    HeapNode near *other;
    int bank;
    unsigned int result;
    int delta;
    result=0;
    HEAP_STATUS=0;
    if((result=RH_PREPARE_DESCRIPTORS())!=0 && (mode&0x7818)) {
        if(mode!=0x2000) goto out;
        bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node);
        asm push ds;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if(node->flags&0x400) {
            asm pop ds;
        } else {
            asm pop ds;
            goto out;
        }
    }
    result=0;
    if(mode&0x4800) {
        bank=0;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
        node=0;
        /* Allocation: there is no existing node; ALLOC_BANK0_NODE makes it
           below. */
        mode&=mask;
    } else {
        bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node);
        if(bank>=6) {
            result=0x1002;
            goto out;
        }
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        /* Existing block: merge mode with its flags (the transient bits
           800h, 1000h, 2000h and 4000h are not carried over).  A tagged
           block is touched: untagged and put in the newest ring slot. */
        mode=mode&mask|node->flags&~mask&0x87ff;
        if(node->flags&0x800) {
            UNTAG_NODE(node);
            RH_CLEAR_TAG_ENTRY(node);
            RING_PUSH_NODE(node,0);
        }
    }
    /* Free: drop the handle (a heap item is freed, a plain word cleared)
       and release the node in its bank. */
    if(mode&4) {
        if(node->flags&0x4000) HEAP_FREE_ITEM((struct HeapItem far *)handle);
        else *handle=0;
        ACTIVE_HEAP.hook_24(node);
        goto out;
    }
    if(mode&0x4800) {
        if(!(node=ALLOC_BANK0_NODE(mode,handle,size,0,0))) {
            result=0x1000;
            goto out;
        }
    }
    /* Not in bank 0: bring the block in (at the new size for a resize),
       then tell its callback: operation 2 when it came from bank 5 (it was
       discarded and must be rebuilt), 5 when it came from another bank. */
    if(!(ACTIVE_HEAP.field5&4)) {
        if(mode&0x1000) {
            delta=size;
            mode&=0xefff;
        } else delta=node->field8;
        if(node->flags&0x400) mode|=0x400;
        if(!(node=ALLOC_BANK0_NODE(mode,handle,delta,bank,node))) {
            result=0x1000;
            goto out;
        }
        if(node->field18) {
            if(bank==5) RH_DISPATCH_NODE(node,2,handle,*handle);
            else RH_DISPATCH_NODE(node,5,handle,*handle);
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
        }
    }
    if(mode&0x1000) {
        /* Resize: a copy in another bank is now stale and is released;
           then shrink, grow (locked while RESIZE_NODE may move it) or, for
           the same number of units, only record the new byte size. */
        delta=RH_ROUND_REQUEST(size)-node->size;
        if(node->flags&0x2000) {
            RH_HEAP_DISPATCH(node->field19>>3,1,
                ((struct HeapReleaseNode near *)node)->bank_handle);
            node->flags&=~0x2000;
        }
        if(delta<0) SHRINK_NODE(node,size);
        else if(delta>0) {
            node->flags|=0x8000;
            /* Documented exception (dummy statement): the empty arm gives
               the original's reload of other at 2463 before node=other. */
            if(!(other=RESIZE_NODE(node,size))) ;
            else node=other;
            node->flags&=0x7fff;
            if(!other) {
                result=0x1000;
                goto out;
            }
        } else node->field8=size;
    }
    if(node->flags&0x60) {
        if(!(mode&0x60)) {
            --ACTIVE_HEAP.tracked_nodes;
            ACTIVE_HEAP.tracked_size-=node->size;
        }
    } else if(mode&0x60) {
        ++ACTIVE_HEAP.tracked_nodes;
        ACTIVE_HEAP.tracked_size+=node->size;
    }
    /* Above: count the block into or out of the tracked (reclaimable)
       totals.  Now mode becomes the set of changing bits and the flags take
       their new values of 1, 2, 20h, 40h and 200h; when 200h is cleared, the
       copy kept in another bank is released. */
    mode^=node->flags;
    node->flags^=mode&0x263;
    if((mode&0x200) && !(node->flags&0x200) && (node->flags&0x2000)) {
        RH_HEAP_DISPATCH(node->field19>>3,1,
            ((struct HeapReleaseNode near *)node)->bank_handle);
        node->flags&=~0x2000;
    }
    /* Keep the handle ring in step: a block no longer reclaimable leaves its
       slot; a reclaimable, unfixed block is pushed in as the newest. */
    if((node->flags&0x1060)==0x1000) RH_CLEAR_TAG_ENTRY(node);
    if((node->flags&0x60) && !(node->flags&0x1018)) RING_PUSH_NODE(node,1);
    /* Fixed-low state changes.  To fix: when the free node just below is
       the first movable one (head), slide the block down into it.  If the
       block is still above head it is copied into a new fixed-low node; if
       that fails the block is moved out to another bank and the call made
       again, which brings it back fixed.  A block at head only gets flag 8,
       and head and current move past it. */
    if(mode&8) {
        if(node->flags&8) UNFIX_LOW_NODE(node);
        else {
            if(node->flags&0x1000) RH_CLEAR_TAG_ENTRY(node);
            other=node->previous;
            if((other->flags&4) && other==ACTIVE_HEAP.head) {
                ACTIVE_HEAP.move_node_2c(node,other->key);
                RHSWAP(other);
                RH_COALESCE_FREE(other);
            }
            if(node->key>ACTIVE_HEAP.head->key) {
                other=node;
                node->flags|=0x8000;
                if(!(node=ALLOC_BANK0_NODE(node->flags|8,handle,node->field8,bank,node))) {
                    other->flags&=0x7fff;
                    if(!RH_TRY_FLAG20(other)) {
                        result=CHANGE_HEAP_NODE_MODE(8,8,handle,0);
                        goto out;
                    }
                    result=0x1000;
                    goto out;
                }
                node->flags&=0x7fff;
            } else {
                node->flags|=8;
                if(ACTIVE_HEAP.head==node) ACTIVE_HEAP.head=node->next;
                if(ACTIVE_HEAP.current==node) ACTIVE_HEAP.current=node->next;
            }
        }
    }
    /* Fixed-high state: the same at the high end, with end and
       move_node_2e. */
    if(mode&0x10) {
        if(node->flags&0x10) UNFIX_HIGH_NODE(node);
        else {
            if(node->flags&0x1000) RH_CLEAR_TAG_ENTRY(node);
            other=node->next;
            if((other->flags&4) && other->next==ACTIVE_HEAP.end) {
                delta=node->key;
                ACTIVE_HEAP.move_node_2e(node,node->key+other->size);
                node->key=delta;
                RHSWAP(node);
                if(ACTIVE_HEAP.head==node) ACTIVE_HEAP.head=other;
                else RH_COALESCE_FREE(other);
            }
            if(node->key+node->size<ACTIVE_HEAP.end->key) {
                other=node;
                node->flags|=0x8000;
                if(!(node=ALLOC_BANK0_NODE(node->flags|0x10,handle,node->field8,bank,node))) {
                    other->flags&=0x7fff;
                    if(!RH_TRY_FLAG20(other)) {
                        result=CHANGE_HEAP_NODE_MODE(0x10,0x10,handle,0);
                        goto out;
                    }
                    result=0x1000;
                    goto out;
                }
                node->flags&=0x7fff;
            } else {
                node->flags|=0x10;
                if(node->next==ACTIVE_HEAP.end) ACTIVE_HEAP.end=node;
                if(ACTIVE_HEAP.current==node) ACTIVE_HEAP.current=node->previous;
            }
        }
    }
out:
    _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
    HEAP_STATUS=result;
    if(result) HEAP_HOOK_CALLSITE(1,result);
    return result;
}

/* Apply CHANGE_HEAP_NODE_MODE(mode, mask) to every used node, in every bank
   that is set up, whose owner tag (field12) is tag, or the default owner
   tag when tag is 0.  Stops at and returns the first error, else 0. */
unsigned int far pascal _loadds CHANGE_TAG_NODES_MODE(unsigned int mode,unsigned int mask,
    unsigned int tag)
{
    HeapNode near *node;
    int bank;
    unsigned int result;
    if(tag==0) tag=HEAP_DEFAULT_OWNER_TAG;
    for(bank=0;bank<6;bank++) {
        asm mov bx,bank;
        asm shl bx,1;
        asm mov cx,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS[bx];
        asm jcxz next;
        asm mov ds,cx;
        for(node=ACTIVE_HEAP.chain_head->next;node!=ACTIVE_HEAP.chain_tail;) {
            if(!(node->flags&4) && node->field12==tag) {
                if((result=CHANGE_HEAP_NODE_MODE(mode,mask,
                        ((struct HeapOutputNodeView near *)node)->output,0))!=0)
                    return result;
            }
            /* A node released by the call has previous 0 (RRETNDES clears
               it) but keeps its next link: follow next to a live node. */
            if(!node->previous) {
                while(!node->previous) node=node->next;
            } else node=node->next;
        }
        asm mov ax,DGROUP;
        asm mov ds,ax;
    next: ;
    }
    return 0;
}

/* Cut a free node to size units and put the rest in a new free node right
   after it, which also becomes the free cursor.  free_size is lowered by the
   tail first because ADD_FREE_NODE adds the tail back; the caller then takes
   node off the free list (RHSLICE).  Returns the tail.  Used by
   ADOPT_EXTERNAL_REGIONS. */
HeapNode near * near pascal SPLIT_NODE_TAIL(HeapNode near *node,unsigned int size)
{
    HeapNode near *rest;
    rest=RNEWNODE();
    rest->size=node->size-size;
    node->size=size;
    ACTIVE_HEAP.free_size-=rest->size;
    rest->key=node->key+size;
    RHLINK(node,rest);
    rest->flags=4;
    ADD_FREE_NODE(rest);
    ACTIVE_HEAP.free_cursor=rest;
    return rest;
}

struct RegionHeader {
    unsigned char leading_fields[4];
    unsigned long size;
    unsigned int request;
    unsigned char field0a[4];
    unsigned int handle;
    unsigned char field10[2];
    unsigned int chain;         /* +12h: read only by the asm walk (es:[12h]) */
    unsigned char field14[8];
    unsigned int next;
};
union RegionAddress {
    struct RegionHeader far *header;
    struct { unsigned int offset,segment; } words;
};

/* Bring a chain of external regions into the heap as bank-0 nodes; called
   once at start-up with the segments of INIT_REGION_START_MARK and
   INIT_END_C_START_MARK.  Each region starts with a RegionHeader: byte size
   at +4, request at +8, its heap handle at +0Eh, links at +12h and +1Ch.
   The fields' meaning is known only from this code; the regions are
   probably overlay code already in memory.  Steps: work out how much of
   target's chain fits (below source's size and the free space), get
   descriptors, gather that much free space at the high end, fill it
   (OVR_READ_AT_OFFSET), then walk the regions: each one that does not
   already live in bank 0 gets a node carved from the gathered space, takes
   over its old descriptor (kept as a copy in banks 1 to 4, else released),
   joins the handle ring, and is prepared by the overlay manager
   (_OvrPrepare with ES = the region).  See the header for the bug in free. */
void far pascal _loadds ADOPT_EXTERNAL_REGIONS(unsigned int target,unsigned int source)
{
    union RegionAddress block;
    unsigned long free;
    unsigned long limit;
    unsigned int key;
    int count;
    HeapNode near *node;
    HeapNode near *rest;
    unsigned int node_offset;
    int bank;
    limit=0xFFFFFFFFUL;
    count=0;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    block.words.offset=0;
    if(source) {
        block.words.segment=source;
        limit=block.header->size;
    }
    block.words.segment=target;
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP.free_size;  /* result unused, see header */
    asm xor dx,dx;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    asm shl ax,1;
    asm rcl dx,1;
    if(free+block.header->size<limit) limit=free+block.header->size;
    /* Count the leading regions of target's chain until the first whose size
       is not below limit (signed test, jns). */
    asm mov cx,target;
    asm mov es,cx;
walk:
    asm mov cx,es:[12h];
    asm jcxz walked;
    asm mov es,cx;
    asm mov ax,es:[4];
    asm mov dx,es:[6];
    asm sub ax,word ptr limit;
    asm sbb dx,word ptr limit+2;
    asm jns walked;
    count++;
    asm jmp short walk;
walked:
    if(_ES==target) return;     /* pseudo-register read: the walk's last segment */
    if(RH_GROW_DESCRIPTORS(count*3)) return;
    limit-=block.header->size;
    limit>>=4;
    if((unsigned long)ACTIVE_HEAP.free_size<limit) limit=ACTIVE_HEAP.free_size;
    if(!(node=GATHER_FREE_AT_HIGH_END((unsigned int)limit,ACTIVE_HEAP.head,ACTIVE_HEAP.end))) return;
    if(OVR_READ_AT_OFFSET(target,(unsigned long)node->key,limit)) return;
    free=block.header->size;
    key=node->key;
    while(block.words.segment) {
        asm push ds;
        _DS=ACTIVE_HEAP.program_segment;
        bank=BCC_POOL_RESOLVE_WORD(block.header->handle,(unsigned int far *)&node_offset);
        asm pop ds;
        /* Already in bank 0.  The test reads node (the gathered space), not
           the resolved node_offset; probably an oversight in the original,
           kept as the bytes have it. */
        if(bank==0) {
            if(node->flags&0x800) {
                UNTAG_NODE(node);
                RH_CLEAR_TAG_ENTRY(node);
                RING_PUSH_NODE(node,0);
            }
        } else {
            limit=block.header->size-free;
            limit>>=4;
            limit+=key;
            if(limit-node->key>0) node=SPLIT_NODE_TAIL(node,(unsigned int)limit-node->key);
            rest=RHSLICE(node,RH_ROUND_REQUEST(block.header->request),0);
            node->field8=block.header->request;
            asm push ds;
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
            RH_COPY_DESCRIPTOR(bank,0,(HeapNode near *)node_offset,node);
            if(bank>=1 && bank<5) {
                asm pop ds;
                node->flags|=0x2000;
                asm mov al,byte ptr bank;
                asm mov cl,3;
                asm shl al,cl;
                asm or al,byte ptr DGROUP:ACTIVE_HEAP.field4;
                node->field19=_AL;
                ((struct HeapReleaseNode near *)node)->bank_handle=node_offset;
            } else {
                ACTIVE_HEAP.hook_24((HeapNode near *)node_offset);
                asm pop ds;
                node->field19=0;
            }
            ACTIVE_HEAP.field52+=node->size;
            node->flags&=0xfe7f;
            RH_UPDATE_NODE_ADDRESS(node,1);
            if(node->flags&0x60) {
                ++ACTIVE_HEAP.tracked_nodes;
                ACTIVE_HEAP.tracked_size+=node->size;
            }
            if(!(node->flags&0x1000)) RING_PUSH_NODE(node,1);
            _ES=block.words.segment;
            _OvrPrepare();
            node=rest;
        }
        block.words.segment=block.header->next;
    }
}

/* Mark the block behind handle as just used: untag it, clear its old ring
   slot and store it in the newest slot (RING_PUSH_NODE without force).
   Keeps the caller's DS. */
void near pascal MOVE_NODE_TO_RING_HEAD(unsigned int handle)
{
    unsigned int node_offset;
    int bank;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    bank=BCC_POOL_RESOLVE_WORD(handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    UNTAG_NODE((HeapNode near *)node_offset);
    RH_CLEAR_TAG_ENTRY((HeapNode near *)node_offset);
    RING_PUSH_NODE((HeapNode near *)node_offset,0);
    asm pop ds;
}

/* Calls itself until the stack overflows.  No other near call in CODE_2
   reaches it. */
void near pascal CALL_SELF_FOREVER(void)
{
    CALL_SELF_FOREVER();
}
