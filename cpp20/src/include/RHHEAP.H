#ifndef RHHEAP_H
#define RHHEAP_H
/* Observed leading layout views, not complete historical allocation sizes.
   Near links and ACTIVE_HEAP use the caller-selected heap DS. This extern
   neither allocates storage nor identifies it with main-program DS offset0.
   Extended fields describe current-DS heap and shared descriptor-bank views;
   DS selection determines the bank. This is not a historical full-size claim. */
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
    HeapWordHook hook_22;   /* +22h: near pascal one-word hook (RH_HEAP_DISPATCH op 0; no caller seen) */
    HeapNodeHook hook_24;   /* +24h: near pascal hook taking a node (HPFREETG, RHAPI, RH_HEAP_DISPATCH op 1);
                               returns unsigned only because the dispatcher passes AX back, which
                               every caller ignores */
    HeapHook hook_26;   /* +26h: near pascal hook; HPDESC calls it with -1 */
    HeapMoveCallback hook_28;   /* +28h: near pascal (node, key) hook (RH_HEAP_DISPATCH op 2) */
    HeapMoveCallback hook_2a;   /* +2Ah: near pascal (node, key) hook, as move_node_2c */
    HeapMoveCallback move_node_2c,move_node_2e;
    unsigned int page_segment;
    unsigned int page_size;
    unsigned int field52,field54,tagged_size;
    HeapNode near *descriptor_block,*descriptor_head;
    unsigned int descriptor_count;
    unsigned int tracked_nodes,tracked_size;
};
extern struct HeapControl ACTIVE_HEAP;
/* Observed word at +14h beyond the common 20-byte node prefix: the node's
   handle in another bank (HPRELND, RHAPI). */
struct HeapReleaseNode { HeapNode prefix; unsigned int bank_handle; };
#endif
