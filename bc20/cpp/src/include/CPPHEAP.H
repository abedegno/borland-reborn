#ifndef RHHEAP_H
#define RHHEAP_H
/* CPPHEAP.H: CPP.EXE's view of the far-memory heap records, used in place of
   src/include/RHHEAP.H (BCC's) by the CPP heap files.  It is RHHEAP.H with
   CPP.EXE's ACTIVE_HEAP layout.  CPP.EXE edit: BCC's HeapControl words
   field52, field54 and tagged_size (+34h..+39h) are not there, so
   descriptor_block is at +34h, descriptor_head +36h, descriptor_count +38h,
   tracked_nodes +3Ah (RH_GROW_DESCRIPTORS and RH_PREPARE_DESCRIPTORS at image
   0x551/0x616 use those offsets; bank_adjustment +20h, page_segment +30h and
   page_size +32h are where BCC has them).  The node descriptor is 20 bytes
   (RH_GROW_DESCRIPTORS steps by 14h), BCC's is 22.  The same guard as
   RHHEAP.H, so only one of the two can be included.  Keep this file's CRLF
   line ends (Turbo C 2.01 with -B fails on LF). */
typedef struct HeapNode HeapNode;
struct HeapNode {
    unsigned int key,size;
    HeapNode near *previous,*next;
    unsigned int field8,flags;
    unsigned char field12,field13;
    HeapNode near *previous_free,*next_free;
    unsigned char field18,field19;
};
typedef void (near pascal *HeapHook)(int request);
typedef unsigned int (near pascal *HeapNodeHook)(HeapNode near *node);
typedef unsigned int (near pascal *HeapWordHook)(unsigned int value);
typedef void (near pascal *HeapMoveCallback)(HeapNode near *node,unsigned int new_key);
struct HeapControl {
    unsigned int leading_fields[2];
    unsigned char field4,field5;
    unsigned int field6,field8,program_segment;
    HeapNode near *current;
    HeapNode near *chain_head,*chain_tail;  /* +0Eh/+10h: node chain sentinels */
    HeapNode near *free_head,*head,*end;
    unsigned int free_nodes,free_size;
    HeapNode near *free_cursor;
    unsigned int field30,bank_adjustment;
    HeapWordHook hook_22;   /* +22h */
    HeapNodeHook hook_24;   /* +24h */
    HeapHook hook_26;       /* +26h: called with -1 to compact a bank */
    HeapMoveCallback hook_28;   /* +28h */
    HeapMoveCallback hook_2a;   /* +2Ah */
    HeapMoveCallback move_node_2c,move_node_2e;
    unsigned int page_segment;  /* +30h */
    unsigned int page_size;     /* +32h */
    HeapNode near *descriptor_block,*descriptor_head;   /* +34h/+36h */
    unsigned int descriptor_count;  /* +38h */
    unsigned int tracked_nodes,tracked_size;    /* +3Ah/+3Ch */
};
extern struct HeapControl ACTIVE_HEAP;
/* Program data the heap files use (DATA.H has them too).  CPP.EXE's heap
   files were compiled by Turbo C 2.01 through TASM (-B), and Turbo C 2.01
   reads only CRLF sources there, so they include this CRLF header and not
   DATA.H (LF). */
extern unsigned char HEAP_DEFAULT_OWNER_TAG;
extern unsigned int HEAP_SAVED_TOP_KEY;
extern unsigned int HEAP_DESCRIPTOR_SEGMENTS[];

/* The heap call-site views of RHHOOK.H, RHOUT.H, RHALLOC.H and RHENTRY.H, copied here
   unchanged (with CRLF line ends) for the Turbo C 2.01 heap files. */
#ifndef HEAP_HOOK_CALLSITE_VIEW_PROPOSAL_H
#define HEAP_HOOK_CALLSITE_VIEW_PROPOSAL_H
/* Unowned invocation view of the heap's run-time hook slot.
   This describes the CALLER'S physical protocol, not the C declaration of
   the installed callback: push domain then status, no caller argument pop.
   A handler that returns normally must restore the pre-argument stack.
   The known installed CDECL handler instead terminates/unwinds nonlocally.
   Keep its actual CDECL declaration unchanged; no compatible ordinary
   returning function-pointer conversion is claimed by this target-C view. */
typedef void (far pascal *HeapHookCallsite)(unsigned int domain,
                                         unsigned int status);
/* Proposed neutral unowned identity only. A future control must infer
   the slot's address from the binary's operand and reconcile storage/installer views.
   No object is defined or initialized by this declaration. */
extern HeapHookCallsite HEAP_HOOK_CALLSITE;
#endif
#ifndef RH_OUTPUT_NODE_VIEW_H
#define RH_OUTPUT_NODE_VIEW_H
/* Unowned allocated-descriptor facet: an LES in the heap code
   reads a FAR pointer to a WORD from node+0E. No storage/full-node-size claim. */
struct HeapOutputNodeView {
    unsigned char preceding_observed_fields[0x0e];
    unsigned int far *output;
};
/* Existing program-status WORD; RHHOOK.H declares the caller view. */
extern unsigned int HEAP_STATUS;
#endif
#ifndef RHALLOC_H
#define RHALLOC_H
/* One physical slot, different documented manager-bank contracts.
   This facet allocates no storage and changes no shared HeapControl type.
   Only the allocator-capable selected banks use allocate; bank5's known
   notification target stays void and its dispatcher22 bypasses HPALLOC. */
typedef HeapNode near * (near pascal *HeapAllocateRequest)(unsigned int request);
typedef void (near pascal *HeapNotifyRequest)(unsigned int request);
union HeapRequestSlot {
    HeapAllocateRequest allocate;
    HeapNotifyRequest notify;
};
struct HeapRequestBankView {
    unsigned char preceding_observed_control[0x26];
    union HeapRequestSlot request26;
};
#define HEAP_REQUEST_BANK ((struct HeapRequestBankView near *)&ACTIVE_HEAP)
#endif
#ifndef RHENTRY_H
#define RHENTRY_H
/* Unowned two-slot view of the initializer's stores to offsets 22h/24h.
   No storage, common-layout rewrite or historical full-size assertion. */
typedef HeapNode near * (near pascal *HeapAllocateEntry)(unsigned int request);
typedef unsigned int (near pascal *HeapReleaseEntry)(HeapNode near *node);
struct HeapEntryBankView {
    unsigned char preceding_observed_control[0x22];
    HeapAllocateEntry allocate22;
    HeapReleaseEntry release24;
};
#define HEAP_ENTRY_BANK ((struct HeapEntryBankView near *)&ACTIVE_HEAP)
#endif
#endif
