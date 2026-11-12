/* target: ovr136_C111UNIT */
/* Role: types: builds array, function, pointer and struct type records, type sizes,
   alignment, flags and compatibility, and reserves array storage. Entry points:
   KIND_TIMES_10, NEW_ARRAY_TYPE, MAKE_ENUM_TYPE, NEW_FUNCTION_TYPE, NEW_POINTER_TYPE,
   NEW_STRUCT_TYPE, SIZE_OF_TYPE_CHECKED, TYPE_RECORDS_COMPATIBLE (+12 more). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: the C-mode type records and the storage of huge arrays. In C mode (not C++)
   types are 10-byte TYPE_POOL records in the "C layout" (FIELDS.H fields TYPE_C_*), a
   different shape from the C++ records that types/TYPESIZE.C works on (see
   docs/FINDINGS.md, "Two record layouts for types"). Byte 0 is always the kind (TK_*).
   By kind the other words mean:
     array (0x11):   +3 element count (long), +7 element type (TYPE_TARGET), +9 huge flag;
     pointer (0x0D-0x10): +3 pointed-to type, +5 based-pointer base name (0 if none),
                     +7 qualifier byte, +8 near-pointer segment mode;
     function (0x12): +3 return type, +5 parameter list (C_PARAM_POOL_SEG records,
                     CPARM_*), +7 calling convention, +8 flags (1 far, 8 no prototype);
     struct/union (0x13/0x14): +3 size in bytes, +5 members, +7 tag symbol, +9 kind byte;
     enum (0x15):    +3 size (2), +5 a word set by the caller (0 when created).
   Several stores use a field name that belongs to another kind at the same offset (for
   example NEW_POINTER_TYPE writes the target through TYPE_C_SIZE); the comments below
   say what each offset means for the kind at hand.
   The constructors are called by the C declaration parser (parser/CDECL.C, CDECLR.C) and
   the expression parser (string literal arrays). The rest of the file sizes types
   (SIZE_OF_TYPE_CHECKED, reached through SIZE_OF_TYPE_CHECKED_HOOK), compares them
   (TYPE_RECORDS_COMPATIBLE), and reserves storage for arrays larger than 64K, which must
   be split over several far segments (ARRAY_DATA_LENGTH and the RESERVE_* functions,
   which emit through the back-end hooks STREAM_HOOK, RESERVE_BYTES_HOOK and
   DEFINE_SYMBOL_HERE_HOOK). KIND_INFO_TABLE (DS:3928) has a 4-byte row per kind: byte 2
   is the alignment, byte 3 the size (the same byte TYPESIZE.C reads as KIND_SIZE_TABLE,
   DS:392B). BCC_INTEGER_COERCE is a copy of CODE_MASK in expr/TRUNCVAL.C. */
/* Original CO04F (ovr_1d22_9b84) as one source. */
/* opts: -mm -G -O -Z -p -Y */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* KIND_TIMES_10: probably the byte offset of a kind's 10-byte entry in some per-kind
   table; it has no other logic. */
/* ---- STOVR98 (listing ovr_1d22_9b84:B840) ---- */
int far pascal KIND_TIMES_10(unsigned char kind)
{
    return kind*10;
}

/* NEW_ARRAY_TYPE: makes a new (unshared) C array type of "extent" elements of "type".
   flag nonzero marks a huge array (byte 9), which may be up to 16M bytes; others must
   fit in 64K, else MSG_ARRAY_SIZE_TOO_LARGE is reported (the type is still built). */
/* ---- STOVR99 (listing ovr_1d22_9b84:B851) ---- */
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
unsigned int far pascal NEW_ARRAY_TYPE(long extent,unsigned int type,unsigned int flag)
{
    long size;
    register unsigned int node;
    register unsigned int child=type;
    size=SIZE_OF_TYPE_CHECKED_HOOK(child);
    if(flag) {
        if(size*extent>0xFFFFFFL) { REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE); child=child; }
    } else {
        if(size*extent>0xFFFFL) REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE);
    }
    node=POOL_ALLOC_REUSE(&TYPE_POOL,10);
    RTL_MEMSET(MK_FP(TYPE_POOL,node),0,10);
    _ES=TYPE_POOL;
    ES_B(node,TYPE_KIND)=0x11;
    ES_W(node,TYPE_TARGET)=child;
    ES_L(node,TYPE_C_SIZE)=extent;
    ES_B(node,TYPE_C_BYTE9)=(unsigned char)flag;
    return node;
}

/* MAKE_ENUM_TYPE: makes a new enum type record (kind 0x15, size 2) with
   "value" in the word at +5; parser/CDECL.C calls it with 0 for each new enum tag. */
/* ---- STOVR100 (listing ovr_1d22_9b84:B90D) ---- */
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
struct Cell10 { unsigned char kind,reserved1[2]; unsigned int flags,value; unsigned char reserved7[3]; };
unsigned int far pascal MAKE_ENUM_TYPE(unsigned int value)
{
    register unsigned int node;
    node=POOL_ALLOC_REUSE(&TYPE_POOL,sizeof(struct Cell10));
    RTL_MEMSET(MK_FP(TYPE_POOL,node),0,sizeof(struct Cell10));
    ((struct Cell10 far *)MK_FP(TYPE_POOL,node))->kind=0x15;
    ((struct Cell10 far *)MK_FP(TYPE_POOL,node))->value=value;
    ((struct Cell10 far *)MK_FP(TYPE_POOL,node))->flags=2;
    return node;
}

/* NEW_FUNCTION_TYPE: makes a C function type: first = return type (+3), second =
   parameter list (+5), third = calling convention (+7), fourth = flags (+8). */
/* ---- STOVR101 (listing ovr_1d22_9b84:B94E) ---- */
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
struct Cell10_STOVR101 { unsigned char kind,reserved1[2]; unsigned int first,second; unsigned char third,fourth,reserved9; };
unsigned int far pascal NEW_FUNCTION_TYPE(unsigned int first,unsigned int second,unsigned char third,int fourth)
{
    register unsigned int node;
    node=POOL_ALLOC_REUSE(&TYPE_POOL,sizeof(struct Cell10_STOVR101));
    RTL_MEMSET(MK_FP(TYPE_POOL,node),0,sizeof(struct Cell10_STOVR101));
    ((struct Cell10_STOVR101 far *)MK_FP(TYPE_POOL,node))->kind=0x12;
    ((struct Cell10_STOVR101 far *)MK_FP(TYPE_POOL,node))->first=first;
    ((struct Cell10_STOVR101 far *)MK_FP(TYPE_POOL,node))->second=second;
    ((struct Cell10_STOVR101 far *)MK_FP(TYPE_POOL,node))->fourth=fourth;
    ((struct Cell10_STOVR101 far *)MK_FP(TYPE_POOL,node))->third=third;
    return node;
}

/* NEW_POINTER_TYPE: makes a C pointer type. owner = pointed-to type (stored at +3,
   through the name TYPE_C_SIZE), kind = TK_NEAR_PTR..TK_HUGE_PTR, qualifier = const and
   volatile bits (+7), value = based-pointer base name (+5, through the name
   TYPE_C_PARAMS), flags = near-pointer segment mode (+8). Called by
   PTR_TYPE_FOR_MODIFIER (types/PTRMOD.C). */
/* ---- STOVR102 (listing ovr_1d22_9b84:B99E) ---- */
unsigned int far pascal NEW_POINTER_TYPE(unsigned int owner,unsigned char kind,
                                  int qualifier,unsigned int value,int flags)
{
    register unsigned int node=POOL_ALLOC_REUSE((char far *)&TYPE_POOL,10);
    RTL_MEMSET(MK_FP(TYPE_POOL,node),0,10);
    *(unsigned char far *)MK_FP(TYPE_POOL,node)=kind;
    *(unsigned char far *)MK_FP(TYPE_POOL,node+TYPE_C_PTR_QUALS)=(unsigned char)qualifier;
    *(unsigned int far *)MK_FP(TYPE_POOL,node+TYPE_C_PTR_BASE)=value;
    *(unsigned char far *)MK_FP(TYPE_POOL,node+TYPE_C_FUNC_FLAGS)=(unsigned char)flags;
    *(unsigned int far *)MK_FP(TYPE_POOL,node+TYPE_C_TARGET)=owner;
    return node;
}

/* NEW_STRUCT_TYPE: makes an empty struct record (kind 0x13, size 0 until the body is
   declared); value, the kind the caller in parser/CDECL.C passes (probably struct or
   union), is kept in byte 9. */
/* ---- STOVR103 (listing ovr_1d22_9b84:B9F0) ---- */
/* -Z: ES is kept across far stores into the same segment (user-accepted, batch290-admission/policy-Z-extension.json). */
unsigned int far pascal NEW_STRUCT_TYPE(signed char value)
{
    register unsigned int node=POOL_ALLOC_REUSE((char far *)&TYPE_POOL,10);
    RTL_MEMSET(MK_FP(TYPE_POOL,node),0,10);
    *(unsigned char far *)MK_FP(TYPE_POOL,node)=0x13;
    *(unsigned char far *)MK_FP(TYPE_POOL,node+TYPE_C_BYTE9)=value;
    return node;
}

/* SIZE_OF_TYPE_CHECKED: size in bytes of a C type (1 for a null type). Arrays multiply
   their counts down to the element type. A struct/union whose size is still 0 has not
   been defined: MSG_UNDEFINED_STRUCTURE is reported with its tag name and the size is set
   to 1 so the error is given only once. Enums use their own size word; other kinds take
   the size from KIND_INFO_TABLE. */
/* ---- STOVR104 (listing ovr_1d22_9b84:BA2B) ---- */
extern unsigned int DIAG_NAME_BUFFER;
extern signed char KIND_INFO_TABLE[];
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
long far pascal SIZE_OF_TYPE_CHECKED(unsigned int node)
{
    long length;
    register unsigned int current=node;
    register unsigned int factor;
    if (!current) return 1L;
    length=1L;
    while(TYPE_B(current,TYPE_KIND)==0x11) {
        length*=TYPE_L(current,TYPE_C_SIZE);
        current=TYPE_W(current,TYPE_TARGET);
    }
    switch((unsigned int)TYPE_B(current,TYPE_KIND)) {
    case 0x13: case 0x14:
        factor=TYPE_W(current,TYPE_C_SIZE);
        if (!factor) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_UNDEFINED_STRUCTURE,NAME_TEXT_COPY(CSYM_W(TYPE_W(current,TYPE_C_TAG_SYMBOL),CSYM_NAME)));
            TYPE_W(current,TYPE_C_SIZE)=1;
        }
        break;
    case 0x15:
        factor=TYPE_W(current,TYPE_C_SIZE);
        break;
    default:
        factor=KIND_INFO_TABLE[(unsigned int)TYPE_B(current,TYPE_KIND)*4+3];
    }
    return length*factor;
}

/* PARAMS_UNCHANGED_BY_PROMOTE: returns 1 when every parameter of the C function type
   node keeps its type under the default argument promotions, so a declaration without
   a prototype can agree with it. float parameters always fail; char and short ones
   (kind < TK_INT) fail only when LANGUAGE_MODE is 1 (probably strict ANSI mode, -A). */
/* ---- STOVR105 (listing ovr_1d22_9b84:BB07) ---- */
extern unsigned char LANGUAGE_MODE;
#define KIND(n) (*(unsigned char far *)MK_FP(TYPE_POOL,FAR_W(C_PARAM_POOL_SEG,(n),CPARM_TYPE)))
static int near pascal PARAMS_UNCHANGED_BY_PROMOTE(unsigned int node)
{
    register unsigned int item;
    _BX=node;
    item=TYPE_W(_BX,TYPE_C_PARAMS);
    while(item) {
        if(KIND(item)<5) {
            if(LANGUAGE_MODE==1)
                return 0;
        } else {
            if(KIND(item)==9)
                return 0;
        }
        item=CPARM_W(item,CPARM_NEXT);
    }
    return 1;
}
#undef KIND

/* TYPE_RECORDS_COMPATIBLE: the C-mode type compatibility test, a loop that walks both
   types downwards (array element, function return type, pointer target) and recurses
   only for function parameters. Returns 1 if compatible.
   mode 0: pointer qualifier bytes must be equal at every level.
   mode 1: the left side may not have a const or volatile bit the right side lacks
           (probably the assignment rule "may add qualifiers, not drop them").
   mode 2: like 1 but the first level is not checked (it becomes 1 after one step).
   mode 3: qualifiers must be equal, but void * matches char * / unsigned char *; passed
           on to parameters as well.
   Struct, union and enum records are only compatible when they are the same record. */
/* ---- STOVR106 (listing ovr_1d22_9b84:BB61) ---- */
#define K(n) (*(unsigned char far *)MK_FP(TYPE_POOL,n))
#define L(n) (*(long far *)MK_FP(TYPE_POOL,(n)+3))
int far pascal TYPE_RECORDS_COMPATIBLE(register unsigned int left,register unsigned int right,signed char mode)
{
 signed char a,b;
 unsigned int p,q;
 int nested;
 do {
  if(left==right) return 1;
  if(K(left)!=K(right)) return 0;
  switch(K(left)) {
  case 17:
   if(L(left)!=L(right) && L(left) && L(right)) return 0;
   left=TYPE_W(left,TYPE_TARGET);
   right=TYPE_W(right,TYPE_TARGET);
   break;
  case 19:case 20:case 21:
   return 0;
  case 18:
   if(TYPE_SC(left,TYPE_C_CALL_CONV)!=TYPE_SC(right,TYPE_C_CALL_CONV)) return 0;
   a=TYPE_SC(left,TYPE_C_FUNC_FLAGS); b=TYPE_SC(right,TYPE_C_FUNC_FLAGS);
   /* left has no prototype: other flags must agree, and an unprototyped right side or
      promotion-safe parameters make it compatible (the mirror case follows) */
   if(a&8) {
    if((a&~8)!=(b&~8)) return 0;
    if((b&8) || PARAMS_UNCHANGED_BY_PROMOTE(right)) goto parameters_done;
    return 0;
   } else if(b&8) {
    if((b&~8)!=(a&~8)) return 0;
    if((a&8) || PARAMS_UNCHANGED_BY_PROMOTE(left)) goto parameters_done;
    return 0;
   } else {
    if(a!=b) return 0;
    /* both prototyped: compare parameters in step (mode 3 is passed on, others become 0) */
    nested=mode;
    if(mode!=3) nested=0;
    for(p=TYPE_W(left,TYPE_C_PARAMS),q=TYPE_W(right,TYPE_C_PARAMS);p&&q;p=CPARM_W(p,CPARM_NEXT),q=CPARM_W(q,CPARM_NEXT))
     if(!TYPE_RECORDS_COMPATIBLE(CPARM_W(p,CPARM_TYPE),CPARM_W(q,CPARM_TYPE),(signed char)nested)) return 0;
    if(p!=q) return 0;
   }
parameters_done:
   _AX=_AX;
   goto children;
  /* near pointer: based pointers must have the same base name, then fall through */
  case 13:
   if(!TYPE_W(left,TYPE_C_PARAMS)) {
    if(TYPE_W(right,TYPE_C_PARAMS)) return 0;
   } else {
    if(!TYPE_W(right,TYPE_C_PARAMS)) return 0;
    _ES=TYPE_POOL;
    if(COMPARE_NAME(MK_FP(POOL_HASH,ES_W(left,TYPE_C_PARAMS)),MK_FP(POOL_HASH,ES_W(right,TYPE_C_PARAMS)))) return 0;
   }
  case 14:case 15:case 16:
   if(TYPE_SC(left,TYPE_C_FUNC_FLAGS)!=TYPE_SC(right,TYPE_C_FUNC_FLAGS)) return 0;
   if(mode==0 && TYPE_SC(left,TYPE_C_PTR_QUALS)!=TYPE_SC(right,TYPE_C_PTR_QUALS)) return 0;
   if(mode==3) {
    if(TYPE_SC(left,TYPE_C_PTR_QUALS)!=TYPE_SC(right,TYPE_C_PTR_QUALS)) return 0;
    if((K(TYPE_W(left,TYPE_C_SIZE))==12 && K(TYPE_W(right,TYPE_C_SIZE))<=2) ||
       (K(TYPE_W(left,TYPE_C_SIZE))<=2 && K(TYPE_W(right,TYPE_C_SIZE))==12)) return 1;
   } else if(mode==1) {
    if((TYPE_SC(left,TYPE_C_PTR_QUALS)&1)>(TYPE_SC(right,TYPE_C_PTR_QUALS)&1) || (TYPE_SC(left,TYPE_C_PTR_QUALS)&2)>(TYPE_SC(right,TYPE_C_PTR_QUALS)&2)) return 0;
   }
/* step down to the target / return type (offset +3, named TYPE_C_SIZE) */
children:
   left=TYPE_W(left,TYPE_C_SIZE);
   right=TYPE_W(right,TYPE_C_SIZE);
  }
  if(mode==2) mode=1;
 } while(left && right);
 return left==right;
}
#undef K
#undef L

/* BCC_INTEGER_COERCE: truncates a constant to an integer width; same body and mode
   numbers as CODE_MASK in expr/TRUNCVAL.C (1/2 signed/unsigned int, 3/4 char,
   5/6 long). */
/* ---- STOVR108 (listing ovr_1d22_9b84:BE4F) ---- */
extern long MASK_C;

long far pascal BCC_INTEGER_COERCE(long value, unsigned char mode)
{
    switch (mode) {
    case 1:
        value &= INT_LIMIT;
        if (value & ((INT_LIMIT + 1) >> 1)) {
            value |= ~INT_LIMIT;
        }
        break;
    case 2:
        value &= INT_LIMIT;
        break;
    case 3:
        value &= MASK_B;
        if (value & ((MASK_B + 1) >> 1)) {
            value |= ~MASK_B;
        }
        break;
    case 4:
        value &= MASK_B;
        break;
    case 5:
        value &= MASK_C;
        if (value & ((MASK_C + 1) >> 1)) {
            value |= ~MASK_C;
        }
        break;
    case 6:
        value &= MASK_C;
        break;
    }
    return value;
}

/* ARRAY_DATA_LENGTH: total bytes of the array type node (all dimensions times the
   element size). Arrays over 64K are huge arrays split into 64K segments: when the
   element size is not a power of two (LOG2_POWER_OF_TWO returns < 0), an element would
   straddle a segment boundary, so 0x10000 % element-size padding bytes are put in front
   and returned in *adjustment (0 otherwise); more than 128K with padding is reported as
   too large. */
/* ---- STOVR110 (listing ovr_1d22_9b84:BF4B) ---- */
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern int far pascal LOG2_POWER_OF_TWO(unsigned long);
static long far pascal ARRAY_DATA_LENGTH(unsigned int node,unsigned int far *adjustment)
{
    unsigned int alignment;
    long length;
    register unsigned int current=node;
    register int padding;
    length=1L;
    while(TYPE_B(current,TYPE_KIND)==TK_ARRAY) {
        length*=TYPE_L(current,TYPE_C_SIZE);
        current=TYPE_W(current,TYPE_TARGET);
    }
    alignment=SIZE_OF_TYPE_CHECKED_HOOK(current);
    length*=alignment;
    *adjustment=0;
    if(length<=0x10000L) return length;
    padding=LOG2_POWER_OF_TWO((unsigned long)alignment);
    if(padding<0) {
        padding=(int)(0x10000L%(long)alignment);
        if(length+padding>0x20000L) REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE);
        length+=padding;
        *adjustment=padding;
    }
    return length;
}

/* ALLOC_ARRAY_SEGMENTS: defines one far segment for each started 64K of the array type
   node and returns the first one. *result is used only as scratch for the padding. */
/* ---- STOVR111 (listing ovr_1d22_9b84:C02A) ---- */
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
unsigned int far pascal ALLOC_ARRAY_SEGMENTS(unsigned int node)
{
    long length;
    unsigned int result;
    length=ARRAY_DATA_LENGTH(node,&result);
    result=DEFINE_FAR_SEGMENT();
    while(length>0x10000L) {
        DEFINE_FAR_SEGMENT();
        length-=0x10000L;
    }
    return result;
}

/* RESERVE_ARRAY_STORAGE: emits uninitialised storage for the huge array variable
   "node" (a C symbol, CSYM): the padding first, then the symbol's label, then the bytes
   in 64K pieces, selecting the next segment (STREAM_HOOK) for each piece starting from
   the symbol's CSYM_SEGMENT. A full 64K piece is reserved as two 0x8000 calls because
   the hook takes a 16-bit count. */
/* ---- STOVR112 (listing ovr_1d22_9b84:C070) ---- */
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern int (far pascal *STREAM_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
void far pascal RESERVE_ARRAY_STORAGE(unsigned int node)
{
    long remaining;
    unsigned int adjustment;
    long chunk;
    register unsigned int item;
    register unsigned int record=node;
    remaining=ARRAY_DATA_LENGTH(CSYM_W(record,CSYM_TYPE),&adjustment);
    if(adjustment) {
        RESERVE_BYTES_HOOK(adjustment);
        chunk=0x10000L-adjustment;
        remaining-=adjustment;
    } else chunk=0x10000L;
    DEFINE_SYMBOL_HERE_HOOK(record);
    item=CSYM_W(record,CSYM_SEGMENT);
    while(remaining) {
        STREAM_HOOK(item);
        if(chunk>remaining) chunk=remaining;
        if(chunk==0x10000L) {
            RESERVE_BYTES_HOOK(0x8000);
            RESERVE_BYTES_HOOK(0x8000);
        } else RESERVE_BYTES_HOOK((unsigned int)chunk);
        remaining-=chunk;
        chunk=0x10000L;
        item++;
    }
}

/* ADVANCE_IF_SEGMENT_FULL: when the current output segment holds exactly 64K, switches
   output to the next segment (STREAM_HOOK(0) probably returns the current one). */
/* ---- STOVR113 (listing ovr_1d22_9b84:C140) ---- */
extern long far pascal CURRENT_SEGMENT_SIZE(void);
void far pascal ADVANCE_IF_SEGMENT_FULL(void)
{
    int stream;
    if (CURRENT_SEGMENT_SIZE()==0x10000L) {
        stream=STREAM_HOOK(0);
        STREAM_HOOK(stream+1);
    }
}

/* RESERVE_ARRAY_REMAINDER: after an initializer has filled the first "offset" elements
   of the huge array type node, reserves the space of the remaining elements, filling the
   current segment first and moving on segment by segment. */
/* ---- STOVR114 (listing ovr_1d22_9b84:C167) ---- */
extern long far pascal CURRENT_SEGMENT_SIZE(void);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
void far pascal RESERVE_ARRAY_REMAINDER(unsigned int node,unsigned int offset)
{
    long chunk;
    long remaining;
    unsigned int adjustment;
    register unsigned int current=node;
    remaining=ARRAY_DATA_LENGTH(TYPE_W(current,TYPE_TARGET),&adjustment);
    remaining-=adjustment;
    remaining*=TYPE_L(current,TYPE_C_SIZE)-offset;
    chunk=0x10000L-CURRENT_SEGMENT_SIZE();
    for(;;) {
        if(chunk>remaining) chunk=remaining;
        if(chunk==0x10000L) {
            RESERVE_BYTES_HOOK(0x8000);
            RESERVE_BYTES_HOOK(0x8000);
        } else RESERVE_BYTES_HOOK((unsigned int)chunk);
        remaining-=chunk;
        if(!remaining) break;
        chunk=0x10000L;
        ADVANCE_IF_SEGMENT_FULL();
    }
}

/* TYPE_ALIGNMENT_OR_HUGE_PAD: for a huge array returns its padding byte count
   (see ARRAY_DATA_LENGTH); otherwise the alignment of the innermost element kind from
   KIND_INFO_TABLE. */
/* ---- STOVR115 (listing ovr_1d22_9b84:C233) ---- */
extern signed char KIND_INFO_TABLE[];
int far pascal TYPE_ALIGNMENT_OR_HUGE_PAD(register unsigned int node)
{
    unsigned int result;
    if(TYPE_B(node,TYPE_KIND)==TK_ARRAY && TYPE_B(node,TYPE_C_BYTE9)!=0) {
        ARRAY_DATA_LENGTH(node,&result);
        return result;
    }
    while(TYPE_B(node,TYPE_KIND)==TK_ARRAY) node=TYPE_W(node,TYPE_TARGET);
    return KIND_INFO_TABLE[(unsigned int)TYPE_B(node,TYPE_KIND)*4+2];
}

/* GET_TYPE_FLAGS, GET_TYPE_FLAGS_ALT (identical), IS_BASED_POINTER, GET_TYPE_QUALIFIERS,
   GET_TYPE_KIND: small accessors of the C layout, probably for code that cannot use the
   field macros; the _BX loads are kept for byte matching. */
/* ---- STOVR116 (listing ovr_1d22_9b84:C285) ---- */
int far pascal GET_TYPE_FLAGS(unsigned int node)
{
    _BX=node;
    return *(signed char far *)MK_FP(TYPE_POOL,_BX+TYPE_C_FUNC_FLAGS);
}

/* ---- STOVR117 (listing ovr_1d22_9b84:C298) ---- */
int far pascal IS_BASED_POINTER(register unsigned int node)
{
    return *(unsigned char far *)MK_FP(TYPE_POOL,node)==0x0D && *(unsigned int far *)MK_FP(TYPE_POOL,node+TYPE_C_PARAMS)!=0;
}

/* ---- STOVR118 (listing ovr_1d22_9b84:C2BC) ---- */
int far pascal GET_TYPE_QUALIFIERS(unsigned int node)
{
    _BX=node;
    return *(signed char far *)MK_FP(TYPE_POOL,_BX+TYPE_C_PTR_QUALS);
}

/* ---- STOVR119 (listing ovr_1d22_9b84:C2CF) ---- */
int far pascal GET_TYPE_FLAGS_ALT(unsigned int node)
{
    _BX=node;
    return *(signed char far *)MK_FP(TYPE_POOL,_BX+TYPE_C_FUNC_FLAGS);
}

/* ---- STOVR120 (listing ovr_1d22_9b84:C2E2) ---- */
unsigned char far pascal GET_TYPE_KIND(register unsigned int node)
{
    return *(unsigned char far *)MK_FP(TYPE_POOL,node);
}

/* COUNT_PARAMETERS: number of parameters of the C function type input, or 0x7FFF for a
   function without a prototype (any count accepted). One is added for the hidden
   return-slot pointer when the function returns a struct that is not 1, 2 or 4 bytes. */
/* ---- STOVR121 (listing ovr_1d22_9b84:C2F5) ---- */
int far pascal COUNT_PARAMETERS(unsigned int input)
{
    register unsigned int node=input;
    register unsigned int item;
    int count;
    if(TYPE_B(node,TYPE_C_FUNC_FLAGS)&8) return 0x7FFF;
    count=0;
    item=TYPE_W(node,TYPE_C_PARAMS);
    while(item) {
        item=item;
        item=*(unsigned int far *)MK_FP(C_PARAM_POOL_SEG,item+CPARM_NEXT);
        count++;
    }
    node=TYPE_W(node,TYPE_C_TARGET);
    if(TYPE_B(node,TYPE_KIND)==TK_STRUCT && (TYPE_W(node,TYPE_C_SIZE)>4 || TYPE_W(node,TYPE_C_SIZE)==3)) count++;
    return count;
}
