#ifndef EXPRNOD2_H
#define EXPRNOD2_H
#include <dos.h>
#include "OVL.H"
typedef unsigned int C58Word;
typedef unsigned char C58Byte;
/* Existing canonical eight-byte bank layout. */
struct C31Bank { unsigned int segment,capacity,used,extra; };
/* The allocator/copy protocol observes the entire twenty-byte record. */
struct C58Record { unsigned char bytes[20]; };
extern struct C31Bank EXPR_POOL_SEG;
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(signed char,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(signed char,unsigned int,unsigned int,unsigned int,signed char);
extern unsigned int (far pascal *NEW_BITFIELD_NODE_HOOK)(unsigned int,unsigned int,unsigned char,unsigned char);
extern unsigned int (far pascal *NEW_TEMPORARY_HOOK)(unsigned int);
extern int (far pascal *TREE_HAS_SIDE_EFFECTS_HOOK)(unsigned int);
/* Actual callers transport whole WORD slots through these two BYTE-consuming APIs. */
typedef unsigned int (far pascal *C58BinaryWordTransport)(unsigned int,unsigned int,unsigned int,unsigned int);
typedef unsigned int (far pascal *C58ModeWordTransport)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
static int near pascal BCC_NODE_TEST2(unsigned int);
static unsigned int near pascal BCC_NODE_REBUILD(unsigned int);
static unsigned int near pascal BCC_NODE_CLONE(unsigned int);
static unsigned int near pascal BCC_NODE_COPY_NEAR(unsigned int);
static unsigned int near pascal BCC_NODE_NORMALIZE(unsigned int);
#endif
