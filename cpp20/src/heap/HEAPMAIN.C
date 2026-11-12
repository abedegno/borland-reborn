/* target: HEAPMAIN */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HEAPMAIN (0054:1D73..0054:1FF6, image 0x22B3..0x2536): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/HEAPMAIN.C). CPP.EXE
   has only some of its functions, in the same order; left out
   here: HANDLE_ITEM_POINTER, PIN_SEGMENT, UNPIN_SEGMENT, CONV_FIND_FREE_NODE,
   RH_ROUND_REQUEST, RH_SELF_CALL_BEFORE_SWAP, SWAP_PREPARE_FILE, SWAP_EXTEND_FILE,
   SWAP_READ_NODE, SWAP_WRITE_NODE, SWAP_MOVE_NODE, SWAP_MAKE_ROOM, INIT_SWAP_BANK,
   START_SWAP_BANK; RH_SELF_CALL_BEFORE_MOVES, in front of these functions (image 0x22AE),
   is a file of its own here (HPSTUBMV.C), and HANDLE_ITEM_POINTER, CONV_FIND_FREE_NODE
   and RH_ROUND_REQUEST are in HPMAINHD.C, in front of that stub.  CPP.EXE's heap files
   were compiled by Turbo C 2.01 through TASM (-B; see CPPHEAP.H), so this file uses
   CPPHEAP.H in place of RHHEAP.H, RHOUT.H, RHHOOK.H and DATA.H, and has CRLF line ends.
   Edits for CPP.EXE are marked "CPP.EXE edit"; 0054:xxxx is a CPP.EXE address in the
   heap frame.  Declarations and a macro for BCC's swap-file bank are still in the file
   (they generate no code). */
/* Role: far-memory heap: main heap set-up (INIT_MAIN_HEAP) and bank 0's block moves.
   Entry points: RH_MOVE_BLOCK_UP, RH_MOVE_BLOCK_DOWN, RH_COPY_BLOCK, INIT_MAIN_HEAP. */
/* Overview: this file sets up the far-memory heap that holds CPP's large
   data (record pools and buffers), and holds bank 0's (conventional memory)
   block moves.  It runs at start-up (INIT_HEAP in RHINIT.C calls
   INIT_MAIN_HEAP) and then whenever a block must be moved.

   The heap model, used by every file in src/heap (CPP.EXE's; BCC.EXE's heap
   has six banks, 50h-byte records and 22-byte nodes):
   - Banks.  Memory is split into five banks: 0 conventional memory, 2 EMS,
     3 extended memory, 4 an empty bank that only keeps the descriptors of
     discarded blocks.  No CPP.EXE code sets up bank 1 (BCC.EXE's banks 1 and
     2 are swap files; CPP.EXE has none).  Each bank has a 40h-byte control
     record (struct HeapControl, always reached as ACTIVE_HEAP at DS:0).  The
     five records sit one after another at the start of bank 0's descriptor
     segment, so HEAP_DESCRIPTOR_SEGMENTS[bank] (DS:0378 in the program's DS)
     is that segment plus 4 paragraphs per bank, or 0 when the bank is not set
     up.  Code selects a bank by loading DS with that word; HEAP_PROGRAM_DS (a
     word in the heap's code segment, 0054:25C0, OVREXMEM.ASM) gets the
     program's DS back.  Each bank has hooks in its record: +22h allocate,
     +24h release, +26h find or make free space, +28h write a block into the
     bank, +2Ah read a block out of it, +2Ch/+2Eh move a block within it.
   - Nodes (descriptors).  Every block, used or free, is described by a 20-byte
     HeapNode.  All nodes live in one table, from offset 140h in bank 0's
     descriptor segment (the descriptor block, itself a heap block); a bank n
     sees the same table n*40h bytes lower (ACTIVE_HEAP.bank_adjustment).
     key is where the block starts (a paragraph in bank 0, a unit number in the
     other banks), size its length in units, previous/next link the bank's
     nodes in address order between chain_head and chain_tail, field8 is the
     size asked for in bytes, field12 the owner tag, field13 (BCC.EXE: the
     handle-ring slot; CPP.EXE has no ring), field18 a registered callback
     index, field19 the bank.  Free nodes
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
     bank 4), 80h a copy held in another bank, 100h a discarded copy in bank 4,
     4000h the handle is a heap item (HPGETITM.C), 8000h locked: never
     reclaimed (compaction may still move it).  In BCC.EXE 200h, 400h, 800h,
     1000h and 2000h belong to its overlay reserve, handle ring, tagging and
     kept bank copies, which CPP.EXE does not have; CPP.EXE's code still
     carries some of those bits through its masks (RHAPI.C).
   - Owner tags: see HPTAGS.C and HPHSIZE.C.

   A bank's region holds, in address order: blocks fixed at the low end
   (before ACTIVE_HEAP.head), the movable area (head up to ACTIVE_HEAP.end,
   the only part that compaction moves and the free list covers), and blocks
   fixed at the high end (from end on).  In bank 0 the descriptor table is
   the first block made, locked but in the movable area.
   The move routines here are bank 0's move hooks; they copy with rep movsw
   (patched to movsd on a 386) and then rewrite the handle. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned char HEAP_CPU_TYPE;     /* DATA.H's (LF, not readable by Turbo C 2.01 -B) */
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
/* Far call vector in the heap's code segment at 0054:2A95 (OVREXMEM.ASM,
   RH_DISPATCH_NODE's), whose segment word CALLBACK_TABLE_PTR_SEG (0054:2A97)
   is filled with CS at start-up. */
extern unsigned int far CALLBACK_TABLE_PTR_SEG;
typedef struct HeapDescriptor HeapDescriptor;
struct HeapDescriptor {     /* as in HPDESC.C: descriptor-bank entry */
    unsigned char leading_fields[0x10];
    HeapDescriptor near *next_free;
    unsigned char trailing_fields[2];   /* CPP.EXE edit: 20-byte entry (INIT_MAIN_HEAP
                                           steps by 14h), BCC's is 22 */
};
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern unsigned int near pascal RH_NEWPAGE(void);
extern HeapNode near * near pascal CONV_FIND_FREE_NODE(unsigned int size);
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

/* HANDLE_ITEM_POINTER, CONV_FIND_FREE_NODE and RH_ROUND_REQUEST, which come
   here in BCC's file, are in HPMAINHD.C in CPP.EXE. */





/* Block moves installed as the heap's move hooks (INIT_MAIN_HEAP): copy the
   node's field8 bytes, rounded up to words, from its segment (key) to
   target.  On a 386 INIT_MAIN_HEAP patches the jmp at move_up_386 (and
   move_down_386, copy_386) to two nops, so the copy runs in dwords.
   RH_MOVE_BLOCK_UP copies upwards and RH_MOVE_BLOCK_DOWN backwards (for an
   overlapping move to a higher address).  Both then relocate: when the
   block was the current DS (a descriptor bank), the bank table in the
   program DS is rebuilt from the new segment and DS is left there; the
   paragraph below the block gets the node offset at +0Eh, the node's
   output gets the new segment (BCC.EXE: unless it is flagged 800h), and the new key
   is reported through RH_DISPATCH_NODE (operation 3) when field18 is set.
   RH_COPY_BLOCK copies only (to target) and reports.
   RH_MOVE_BLOCK_UP is bank 0's hook_28 and move_node_2c. */
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
    /* CPP.EXE edit: five banks of 4 paragraphs (0054:1DAA: mov cx,5; 1DB8: add ax,4),
       BCC six of 5. */
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
    /* CPP.EXE edit: no test of flag 800h; the output is always rewritten (0054:1DCE). */
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
    /* CPP.EXE edit: .386 already here, so TASM sizes the forward jae for a near
       jump and pads the short one with two nops (0054:1E1B: jae; nop; nop). */
    asm .386;
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
    /* CPP.EXE edit: five banks of 4 paragraphs, as in RH_MOVE_BLOCK_UP. */
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
    /* CPP.EXE edit: no test of flag 800h, as in RH_MOVE_BLOCK_UP. */
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
   (descriptors entries from 140h) in the first paragraphs, the node chain
   (INIT_BANK), the descriptor block node, the move hooks and the first page. */
unsigned int near pascal INIT_MAIN_HEAP(unsigned int start_seg,unsigned int end_seg,
    int descriptors,unsigned int count)
{
    HeapDescriptor near *entry;
    HeapDescriptor near *end;
    /* CPP.EXE edit: the entries start at 140h, after five 40h-byte bank records
       (BCC 1E0h, six of 50h); 0054:1EE5..1EF0. */
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
    /* CPP.EXE edit: AX is taken from the C store (0054:1F20..1F29 has no second
       load of start_seg). */
    HEAP_DESCRIPTOR_SEGMENTS[0]=++start_seg;
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
    INIT_BANK(start_seg,end_seg-start_seg,0,0x11,0x10);    /* CPP.EXE edit: 11h (BCC 13h) */
    ACTIVE_HEAP.field5|=6;     /* CPP.EXE edit: or byte ptr ds:[5],6 (0054:1F86) */
    ACTIVE_HEAP.descriptor_block=(HeapNode near *)(entry=(HeapDescriptor near *)
        HEAP_ALLOC_NODE((unsigned int)end));
    /* The block's output points at the bank table in the program's DS. */
    /* CPP.EXE edit: both words stored in asm (0054:1F97..1F9F: mov bx,entry, then
       two immediate stores; Turbo C would have gone through AX for the offset). */
    asm mov bx,entry;
    asm mov word ptr [bx+0Eh],offset DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
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


/* BCC's swap-file bank (set up by INIT_SWAP_BANK, not in CPP.EXE): there
   ACTIVE_HEAP.page_segment holds the file handle and page_size the bank's
   single big node.  The declarations and the macro below are kept from
   BCC's source; CPP.EXE uses none of them. */

unsigned int near pascal SWAP_EXTEND_FILE(unsigned long size);
HeapNode near * near pascal SWAP_MAKE_ROOM(unsigned int size);



/* BCC: page a node in from or out to the swap file (SWAP_READ_NODE,
   SWAP_WRITE_NODE): seek to the node's key times the unit (field8), then
   read or write the node's field8
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





/* BCC: swap bank set-up (INIT_SWAP_BANK): create the swap file at path,
   make bank `bank' (at the bank-0 segment plus 5 paragraphs per bank)
   describe it in 512-byte units, and install the swap hooks.  Does nothing
   below 128K (20000h). */
/* BCC's swap bank keeps its file's name where its other banks keep
   field52/54.  Unused in CPP.EXE. */
struct SwapControl {
    unsigned char preceding_fields[0x34];
    unsigned long path;
};


