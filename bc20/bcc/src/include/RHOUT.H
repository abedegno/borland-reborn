#ifndef RH_OUTPUT_NODE_VIEW_H
#define RH_OUTPUT_NODE_VIEW_H
#include "RHHEAP.H"
/* Unowned allocated-descriptor facet: actual LES in2E80 reads
   a FAR pointer to a WORD from node+0E. No storage/full-node-size claim. */
struct HeapOutputNodeView {
    unsigned char preceding_observed_fields[0x0e];
    unsigned int far *output;
};
/* Existing program-status WORD; RHHOOK.H declares the caller view. */
extern unsigned int HEAP_STATUS;
#endif
