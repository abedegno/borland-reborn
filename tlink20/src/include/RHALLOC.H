#ifndef RHALLOC_H
#define RHALLOC_H
#include "RHHEAP.H"
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
