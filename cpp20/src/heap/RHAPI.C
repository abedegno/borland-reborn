/* target: RHAPI */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHAPI (image 0x1974..0x1F21, 0054:1434..0054:19E1, 0x5AD bytes): from
   the BCC.EXE reconstruction (bcc20/src/heap/RHAPI.C), with CPP.EXE's
   edits marked "CPP.EXE edit"; compiled by Turbo C 2.01 through TASM (-B), not by
   BC 2.0: every frame is reserved with sub sp,N (e.g. the entries at image 1974, 1A1E, 1AAC, 1B6D), and
   SET_NODE_INFO..GET_HEAP_NODE_FLAGS have Turbo C's huge prologue (push ds; mov
   ax,DGROUP; mov ds,ax after the frame) in place of BCC's _loadds.
   CPP.EXE has six of BCC's seventeen functions, in BCC's order: SET_NODE_INFO,
   RH_HANDLE_TRY_FLAG40, RH_HANDLE_TRY_FLAG20, GET_HEAP_NODE_FLAGS, ALLOC_BANK0_NODE,
   CHANGE_HEAP_NODE_MODE.  Left out: ALLOC_BANK5_NODE, C31_SET_MEMORY_LIMIT,
   C31_MEMORY_LIMIT, SET_NODE_REQUEST_SIZE, LOCK_HEAP_NODE, UNLOCK_HEAP_NODE,
   CHANGE_TAG_NODES_MODE, SPLIT_NODE_TAIL, ADOPT_EXTERNAL_REGIONS,
   MOVE_NODE_TO_RING_HEAD; CALL_SELF_FOREVER's stub is its own module in CPP.EXE
   (HPSTUBAP.C, image 0x1F21, BC 2.0).
   ALLOC_BANK0_NODE and CHANGE_HEAP_NODE_MODE are an older, simpler form of BCC's
   (no allocation retry, no handle ring or tag bookkeeping, no tracked totals, no
   kept bank copies (flag 2000h), five banks).  Each difference is marked
   "CPP.EXE edit" below with the image address that shows it.
   Register variables: ALLOC_BANK0_NODE keeps node and source in SI and DI and
   CHANGE_HEAP_NODE_MODE keeps other in SI, so the file is built with register
   variables on (BCC's -r- dropped: with -r- Turbo C 2.01 ignores `register').
   With -r on, Turbo C 2.01 also puts any int or unsigned local or parameter
   whose address is not taken into a free SI/DI by itself, but never a short
   (tested: an unsigned short, an enum or a volatile parameter stays in memory).
   The words CPP.EXE keeps on the stack where a register was free (bank and
   result in the four entry points, CHANGE_HEAP_NODE_MODE's mode, mask, size,
   delta, bank and result) are therefore declared short / unsigned short; with
   int they land in SI/DI.  The "image" addresses below are CPP.EXE image
   offsets. */
/* Role: far-memory heap: the far entry points on heap blocks (node info, eviction,
   flags, mode changes) and bank-0 allocation. */
/* Overview: the far entry points used on heap blocks, and the bank-0
   allocation and mode change machinery behind them.  In CPP.EXE only
   CHANGE_HEAP_NODE_MODE has callers outside this file (OVREXMEM.ASM);
   SET_NODE_INFO, RH_HANDLE_TRY_FLAG40, RH_HANDLE_TRY_FLAG20 and
   GET_HEAP_NODE_FLAGS have none in CPP.EXE's sources.  See HEAPMAIN.C's
   overview for banks, nodes, handles and node flags.  A caller names a block
   by a far pointer to its handle word; the functions resolve it to a bank
   and node, select the bank in DS, and report through HEAP_STATUS (and, on
   failure, the status hook HEAP_HOOK_CALLSITE, which is
   OUT_OF_MEMORY_HANDLER in OOMHAND.C).
   The central routine is CHANGE_HEAP_NODE_MODE: it allocates (mode 800h or
   4000h), frees (mode 4), brings a block back from another bank into bank 0,
   resizes it (mode 1000h, new size in size), changes its reclaim bits (20h,
   40h, 200h, 1, 2) and fixes or unfixes it at the low (8) or high (10h) end.
   It uses ALLOC_BANK0_NODE, which allocates in bank 0 and can take over a
   node from another bank, copying its contents in.  Bank 0's record is told
   from the others by field5 & 4. */
#include <dos.h>
#include "CPPHEAP.H"
struct HeapItem;
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *offset);
extern unsigned char near pascal REGISTER_FAR_CALLBACK(void far *info);
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern unsigned int near pascal RH_TRY_FLAG20(HeapNode near *node);
extern unsigned int near pascal RH_TRY_FLAG40(HeapNode near *node);
extern HeapNode near * near pascal ALLOC_FIXED_LOW(unsigned int request);
extern HeapNode near * near pascal ALLOC_FIXED_HIGH(unsigned int request);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern HeapNode near * near pascal RESIZE_NODE(HeapNode near *node,unsigned int size);
extern void near pascal SHRINK_NODE(HeapNode near *node,unsigned int request);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern unsigned int near pascal UNFIX_LOW_NODE(HeapNode near *node);
extern unsigned int near pascal UNFIX_HIGH_NODE(HeapNode near *node);
extern void near pascal RHSWAP(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern HeapNode near * near pascal RH_COPY_DESCRIPTOR(unsigned int source_bank,
    unsigned int target_bank,HeapNode near *source,HeapNode near *target);

/* Register info as a far callback (REGISTER_FAR_CALLBACK gives a one-byte
   index) and store the index in the node's field18; the heap then reports
   moves and evictions of that block through RH_DISPATCH_NODE.  Returns 0,
   or 1002h for a bad handle or when registration fails. */
/* CPP.EXE edit: huge for BCC's _loadds (Turbo C 2.01), here and in the next three. */
unsigned int huge pascal SET_NODE_INFO(unsigned int far *handle,void far *info)
{
    unsigned int node_offset;
    short bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    if(bank<5) {    /* CPP.EXE edit: five banks (image 1991: cmp ax,5) */
        HEAP_STATUS=0;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if((((HeapNode near *)node_offset)->field18=REGISTER_FAR_CALLBACK(info))!=0)
            return 0;
    }
    HEAP_STATUS=0x1002;
    return 0x1002;
}

/* Discard a bank-0 block to the null bank 4 (RH_TRY_FLAG40), after making
   sure there are spare descriptors.  Returns 0, or 1000h when the block is
   not in bank 0 or no descriptors could be made; RH_TRY_FLAG40's own result
   is ignored. */
unsigned int huge pascal RH_HANDLE_TRY_FLAG40(unsigned int far *handle)
{
    unsigned int node_offset;
    short bank;
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

/* Move a bank-0 block out to another bank (RH_TRY_FLAG20) to free its
   conventional memory; a block with no bytes (field8 0) counts as done.
   Returns, and stores in HEAP_STATUS, 0 or 1000h. */
unsigned int huge pascal RH_HANDLE_TRY_FLAG20(unsigned int far *handle)
{
    unsigned int node_offset;
    short bank;
    unsigned short result;
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

unsigned int huge pascal GET_HEAP_NODE_FLAGS(unsigned int far *handle)
{
    unsigned int node_offset;
    short bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return ((HeapNode near *)node_offset)->flags;
}

/* Allocate a node in bank 0 for request bytes, with handle word output.
   mode 8 fixes it at the low end, 10h at the high end, otherwise it goes in
   the movable area.  When source is given (a node in bank `bank'), the new
   node takes it over: the descriptor data is copied (RH_COPY_DESCRIPTOR),
   the contents are read in through that bank's hook_2a, and the source is
   released in its bank (hook_24).  Returns the node, or 0.
   CPP.EXE edit: BCC's version also retries through the status hook when no
   space is found, uses the 400h reserve (field5 & 1) and can keep the source
   as a valid copy (flag 2000h); CPP.EXE's (image 1AAC..1B6D) does none of
   these and calls RH_UPDATE_NODE_ADDRESS once for both paths. */
HeapNode near * near pascal ALLOC_BANK0_NODE(unsigned int mode,unsigned int far *output,
    unsigned int request,int bank,register HeapNode near *source)
{
    register HeapNode near *node;
    unsigned int key;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(mode&8) node=ALLOC_FIXED_LOW(request);
    else if(mode&0x10) node=ALLOC_FIXED_HIGH(request);
    else node=HEAP_ALLOC_NODE(request);
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
            ACTIVE_HEAP.hook_24(source);
            asm pop ds;
            node->flags&=~0x2000;
            node->field19=0;
            node->flags&=0xfe7f;
        }
        RH_UPDATE_NODE_ADDRESS(node,1);
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
   passed to the status hook.
   CPP.EXE edit (image 1B6D..1F21): no handle ring or tag bookkeeping, no
   tracked totals, no kept bank copies (flag 2000h), five banks (discard bank
   4); the descriptor check gives up on any mode that needs a node; the status
   hook is called with no arguments.  (Turbo C merges the identical
   "result=0x1000; goto out" tails into one at image 1ECC.) */
unsigned int huge pascal CHANGE_HEAP_NODE_MODE(unsigned short mode,unsigned short mask,
    unsigned int far *handle,unsigned short size)
{
    short delta;
    HeapNode near *node;
    short bank;
    unsigned short result;
    register HeapNode near *other;
    result=0;
    HEAP_STATUS=0;
    if((result=RH_PREPARE_DESCRIPTORS())!=0 && (mode&0x7818)) goto out;
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
        if(bank>=5) {   /* CPP.EXE edit: five banks (image 1BCC: cmp ax,5) */
            result=0x1002;
            goto out;
        }
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        /* Existing block: merge mode with its flags (the transient bits
           800h, 1000h, 2000h and 4000h are not carried over). */
        mode=mode&mask|node->flags&~mask&0x87ff;
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
       then tell its callback: operation 2 when it came from the discard
       bank 4 (it was discarded and must be rebuilt), 5 when it came from
       another bank. */
    if(!(ACTIVE_HEAP.field5&4)) {
        if(mode&0x1000) {
            delta=size;
            mode&=0xefff;
        } else delta=node->field8;
        if(!(node=ALLOC_BANK0_NODE(mode,handle,delta,bank,node))) {
            result=0x1000;
            goto out;
        }
        if(node->field18) {
            /* CPP.EXE edit: the discard bank is 4 (image 1C9E: cmp [bp-4],4) */
            if(bank==4) RH_DISPATCH_NODE(node,2,handle,*handle);
            else RH_DISPATCH_NODE(node,5,handle,*handle);
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
        }
    }
    if(mode&0x1000) {
        /* Resize: shrink, grow (locked while RESIZE_NODE may move it) or,
           for the same number of units, only record the new byte size. */
        delta=RH_ROUND_REQUEST(size)-node->size;
        if(delta<0) SHRINK_NODE(node,size);
        else if(delta>0) {
            node->flags|=0x8000;
            /* CPP.EXE edit: a plain test; BCC's copy needs a dummy arm. */
            if((other=RESIZE_NODE(node,size))!=0) node=other;
            node->flags&=0x7fff;
            if(!other) {
                result=0x1000;
                goto out;
            }
        } else node->field8=size;
    }
    /* Now mode becomes the set of changing bits and the flags take their
       new values of 1, 2, 20h, 40h and 200h. */
    mode^=node->flags;
    node->flags^=mode&0x263;
    /* Fixed-low state changes.  To fix: when the free node just below is
       the first movable one (head), slide the block down into it.  If the
       block is still above head it is copied into a new fixed-low node; if
       that fails the block is moved out to another bank and the call made
       again, which brings it back fixed.  A block at head only gets flag 8,
       and head and current move past it. */
    if(mode&8) {
        if(node->flags&8) UNFIX_LOW_NODE(node);
        else {
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
    asm mov ax,DGROUP;
    asm mov ds,ax;
    HEAP_STATUS=result;
    /* CPP.EXE edit: the hook is called with no arguments (image 1F12: call
       dword ptr only); BCC pushes 1 and the status. */
    if(result) ((void (far *)(void))HEAP_HOOK_CALLSITE)();
    return result;
}
