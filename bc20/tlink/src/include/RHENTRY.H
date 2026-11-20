#ifndef RHENTRY_H
#define RHENTRY_H
#include "RHHEAP.H"
/* Unowned two-slot view of actual initializer stores at22/24.
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
