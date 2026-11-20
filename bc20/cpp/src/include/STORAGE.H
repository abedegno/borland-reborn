#ifndef STORAGE_H
#define STORAGE_H
#include "DATA.H"
#include "OVL.H"
/* These scalar reads view the segment member of existing eight-byte banks. */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far *BCC_TYPE_PTR;

typedef unsigned char (far pascal *C76ClassHook)(unsigned int);
typedef unsigned int (far pascal *C76TypeHook)(unsigned int);
extern C76ClassHook GET_TYPE_KIND_HOOK;
extern C76TypeHook TYPE_HOOK;

#endif
