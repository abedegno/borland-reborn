/* HEAP.H: functions of the heap sources shared with other files: one
   prototype each, written as its definition is (the defining source on each line).
   Generated during the readability pass. */
#ifndef HEAP_H
#define HEAP_H
#include "RHHEAP.H"
void far pascal _loadds FREE_TAG_NODES(unsigned char owner);             /* HPFREETG.C */
void far pascal _loadds SET_DEFAULT_OWNER_TAG(unsigned char value);               /* OWNERTAG.C */
unsigned char far pascal _loadds GET_DEFAULT_OWNER_TAG(void);                   /* HPDEFTAG.C */
unsigned char far pascal _loadds ALLOCATE_OWNER_TAG(void);                   /* HPOWNTAG.C */
void far pascal _loadds FREE_OWNER_TAG(unsigned char tag);               /* HPOWNTAG.C */
long far pascal _loadds HEAP_SPACE_BELOW_LIMIT(void);                            /* HPSPACE.C */
long far pascal _loadds INIT_EMS_BANK(unsigned int handle,unsigned int first, unsigned int pages); /* EMSBANK.C */
long far pascal _loadds INIT_EXT_BANK(unsigned long base,unsigned long size); /* EXTBANK.C */
void far pascal _loadds ADOPT_EXTERNAL_REGIONS(unsigned int target,unsigned int source); /* RHAPI.C */
unsigned long far pascal _loadds C31_MEMORY_LIMIT(void);               /* RHAPI.C */
unsigned long far pascal _loadds C31_SET_MEMORY_LIMIT(unsigned long bytes); /* RHAPI.C */
#endif
