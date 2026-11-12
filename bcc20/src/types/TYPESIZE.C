/* target: ovr066_C10TYPE */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: type size and compatibility. Entry points: MAKE_POINTER_TYPE, TYPES_COMPATIBLE,
   TYPE_ALIGNMENT, TYPE_SIZE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: basic questions about type records (TYPE_POOL, the C++ layout, fields
   TYPE_*), asked all over the front end: "make a pointer to T", "are these two types
   compatible", "how big is T", "how is T aligned". Types are shared records:
   MAKE_POINTER_TYPE builds a candidate and FIND_EQUIVALENT_TYPE (cpp/CPPSCOPE.C)
   returns the existing identical record if there is one, so identical types usually
   have the same record number and TYPES_COMPATIBLE can stop at first==second.
   Tables used: EXPR_FLAGS[kind] classes the kinds (1 integral, 2 floating, 0x14
   pointer kinds, 0x40 struct/union, as used here); KIND_SIZE_TABLE has a 4-byte row per
   kind whose first byte is the size of that kind (so it is indexed kind*4).
   BCC_PACK_FLAG is the word-alignment option;
   MODEL_FAR_DATA probably means "data pointers are far by default" (far data models);
   CPP_MODE is the C++ mode flag.
   C10PROMOTE and C10DEFAULTS implement the old-style (unprototyped) function rules of C:
   a call without a prototype promotes char/short to int and float to double. */
#include <dos.h>
#include "TYPESIZE.H"
#include "POOL.H"
#define ARRAY_ELEMENT(n) TYPE_W(n,TYPE_TARGET)
#define POINTER_TARGET(n) TYPE_W(n,TYPE_TARGET)

/* MAKE_POINTER_TYPE: returns the shared type "pointer to type". kind is the pointer kind
   (13 near, 15 far, ...) or 0 for the default: far for a far function (TYPE_FUNC_FLAGS
   bit 0), far for data in a far-data model, and in C++ also far for a class whose
   TAG_CLASS_FLAGS has 0x100 or 8 set (probably classes declared far/huge); else near.
   reference nonzero makes a C++ reference (TYPE_ATTRS bit 0x20) instead of a pointer.
   TYPE_PTR_MODE is set to 2 (code) for function targets and 4 (data) otherwise. */
/* 0000: construct and canonicalize a pointer/reference type. */
unsigned int far pascal MAKE_POINTER_TYPE(unsigned int type,
    unsigned int kind,unsigned char reference)
{
    register unsigned int result;

    if(!kind) {
        if(TYPE_W(type,TYPE_KIND)==TK_FUNCTION)
            kind=(TYPE_B(type,TYPE_FUNC_FLAGS)&1)?15:13;
        else if(MODEL_FAR_DATA || (CPP_MODE &&
            (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) &&
            (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x108)))
            kind=15;
        else
            kind=13;
    }
    result=CREATE_TYPE(kind);
    if(reference)
        TYPE_B(result,TYPE_ATTRS)|=0x20;
    TYPE_W(result,TYPE_TARGET)=type;
    TYPE_B(result,TYPE_PTR_MODE)=TYPE_W(type,TYPE_KIND)==TK_FUNCTION?2:4;
    TYPE_W(result,TYPE_PARAMS)=0;
    TYPE_W(result,TYPE_CALL_CONV)=0;
    return FIND_EQUIVALENT_TYPE(result);
}

/* C10PROMOTE: the default argument promotion of type: an enum is first replaced by its
   underlying integer type; integral kinds smaller than int become int (INT_TYPE is
   the int type); float becomes double; anything else is returned unchanged. */
/* 00B1 */
static unsigned int near pascal C10PROMOTE(register unsigned int type)
{
    if(TYPE_W(type,TYPE_KIND)==TK_ENUM)
        type=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE);
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&1) && (int)TYPE_W(type,TYPE_KIND)<TK_INT)
        return INT_TYPE;
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&2) && (int)TYPE_W(type,TYPE_KIND)<TK_DOUBLE)
        return DOUBLE_TYPE;
    return type;
}

/* C10DEFAULTS: returns 1 when the prototyped function type "type" could be compatible
   with an unprototyped declaration of the same function: it must have no ellipsis
   (TYPE_FUNC_FLAGS bit 4) and every parameter type must already be its own promoted
   type (no char, short or float parameters). */
/* 0109 */
static unsigned char near pascal C10DEFAULTS(register unsigned int type)
{
    register unsigned int parameter;

    if(TYPE_B(type,TYPE_FUNC_FLAGS)&4)
        return 0;
    parameter=TYPE_W(type,TYPE_PARAMS);
    while(parameter) {
        if(C10PROMOTE(FORMAL_W(parameter,FORMAL_TYPE))!=FORMAL_W(parameter,FORMAL_TYPE))
            return 0;
        parameter=FORMAL_W(parameter,FORMAL_NEXT);
    }
    return 1;
}

/* TYPES_COMPATIBLE: returns 1 when first and second are compatible types (a null type
   is compatible with anything). mode 0: const/volatile must match at every level; mode
   1: the top-level qualifiers are ignored but inner levels must match; mode 2: qualifiers
   are ignored at every level (used by expr/EXPRCHK.C). Called from about 90 places. */
/* 0156, with its genuine CS switch table at0535..0547. */
unsigned char far pascal TYPES_COMPATIBLE(register unsigned int first,
    register unsigned int second,unsigned int mode)
{
    int firstkind;
    int secondkind;
    unsigned int firstparameter;
    unsigned int secondparameter;
    unsigned int firsttype;
    unsigned int secondtype;
    unsigned char qualified;

    if(!first || !second || first==second)
        return 1;
    firstkind=TYPE_W(first,TYPE_KIND);
    secondkind=TYPE_W(second,TYPE_KIND);
    qualified=mode || ((TYPE_B(first,TYPE_ATTRS)&3)==(TYPE_B(second,TYPE_ATTRS)&3));
    if(firstkind!=secondkind || !(int)qualified)
        return 0;
    /* arithmetic and void kinds: equal kinds are enough (C++ also compares the
       TYPE_MEMBER_CLASS word, ignoring qualifiers there) */
    if(firstkind<=12 && (!CPP_MODE ||
        TYPES_COMPATIBLE(TYPE_W(first,TYPE_MEMBER_CLASS),TYPE_W(second,TYPE_MEMBER_CLASS),1)))
        return 1;
    /* below the top level only mode 2 survives: mode 1 becomes 0 */
    if(mode!=2)
        mode=0;
    switch(TYPE_W(first,TYPE_KIND)) {
    case TK_ENUM:
        return TYPE_W(first,TYPE_TAG_BODY)==TYPE_W(second,TYPE_TAG_BODY);
    case TK_STRUCT:
    case TK_UNION:
        return TYPE_W(first,TYPE_TAG_BODY)==TYPE_W(second,TYPE_TAG_BODY);
    case TK_ARRAY:
        return (TYPE_L(first,TYPE_ARRAY_COUNT)==TYPE_L(second,TYPE_ARRAY_COUNT) || TYPE_L(first,TYPE_ARRAY_COUNT)==0 ||
                TYPE_L(second,TYPE_ARRAY_COUNT)==0) &&
            TYPES_COMPATIBLE(TYPE_W(first,TYPE_TARGET),TYPE_W(second,TYPE_TARGET),mode);
    /* near pointers must also agree on their segment mode and on the base name of a
       based pointer (POOL_HASH strings), then fall through to the common pointer test */
    case TK_NEAR_PTR:
        if(TYPE_B(first,TYPE_PTR_MODE)!=TYPE_B(second,TYPE_PTR_MODE))
            return 0;
        if(TYPE_W(first,TYPE_PTR_BASE) || TYPE_W(second,TYPE_PTR_BASE)) {
            if(!TYPE_W(first,TYPE_PTR_BASE) || !TYPE_W(second,TYPE_PTR_BASE) ||
                COMPARE_NAME(MK_FP(POOL_HASH,TYPE_W(first,TYPE_PTR_BASE)),
                    MK_FP(POOL_HASH,TYPE_W(second,TYPE_PTR_BASE)))!=0)
                return 0;
        }
    case TK_SEG_PTR:
    case TK_FAR_PTR:
    case TK_HUGE_PTR:
        /* references to arrays need equal element counts; pointer and reference must not
           be mixed; then the targets must be compatible */
        if((TYPE_B(first,TYPE_ATTRS)&0x20) && TYPE_W(TYPE_W(first,TYPE_TARGET),TYPE_KIND)==TK_ARRAY &&
            TYPE_W(TYPE_W(second,TYPE_TARGET),TYPE_KIND)==TK_ARRAY &&
            TYPE_L(TYPE_W(first,TYPE_TARGET),TYPE_ARRAY_COUNT)!=TYPE_L(TYPE_W(second,TYPE_TARGET),TYPE_ARRAY_COUNT))
            return 0;
        return (TYPE_B(first,TYPE_ATTRS)&0x20)==(TYPE_B(second,TYPE_ATTRS)&0x20) &&
            TYPES_COMPATIBLE(TYPE_W(first,TYPE_TARGET),TYPE_W(second,TYPE_TARGET),mode);
    case TK_FUNCTION:
        if(!TYPES_COMPATIBLE(TYPE_W(first,TYPE_TARGET),TYPE_W(second,TYPE_TARGET),mode))
            return 0;
        /* far/near (flags 0x41) and the calling convention must agree; in C++ so must the
           class of a member function */
        if((TYPE_B(first,TYPE_FUNC_FLAGS)&0x41)!=(TYPE_B(second,TYPE_FUNC_FLAGS)&0x41) ||
            TYPE_B(first,TYPE_CALL_CONV)!=TYPE_B(second,TYPE_CALL_CONV))
            return 0;
        if(CPP_MODE && TYPE_W(first,TYPE_MEMBER_CLASS)!=TYPE_W(second,TYPE_MEMBER_CLASS))
            return 0;
        /* one side has no prototype (flag 8): C accepts it when the other side's
           parameters survive default promotion; C++ always accepts it */
        if(TYPE_B(first,TYPE_FUNC_FLAGS)&8)
            return CPP_MODE || C10DEFAULTS(second);
        if(TYPE_B(second,TYPE_FUNC_FLAGS)&8)
            return CPP_MODE || C10DEFAULTS(first);
        if((TYPE_B(first,TYPE_FUNC_FLAGS)&4)!=(TYPE_B(second,TYPE_FUNC_FLAGS)&4))
            return 0;
        firstparameter=TYPE_W(first,TYPE_PARAMS);
        secondparameter=TYPE_W(second,TYPE_PARAMS);
        /* walk both parameter lists in step. An array parameter, or an unqualified pointer,
           is compared by its element / target type, so int a[] matches int *a. */
        while(firstparameter && secondparameter) {
            firsttype=FORMAL_W(firstparameter,FORMAL_TYPE);
            secondtype=FORMAL_W(secondparameter,FORMAL_TYPE);
            if((TYPE_W(firsttype,TYPE_KIND)==TK_ARRAY ||
                    ((EXPR_FLAGS[TYPE_W(firsttype,TYPE_KIND)]&0x14) && TYPE_B(firsttype,TYPE_ATTRS)==0)) &&
                (TYPE_W(secondtype,TYPE_KIND)==TK_ARRAY ||
                    ((EXPR_FLAGS[TYPE_W(secondtype,TYPE_KIND)]&0x14) && TYPE_B(secondtype,TYPE_ATTRS)==0))) {
                if(TYPE_W(firsttype,TYPE_KIND)==TK_ARRAY)
                    firsttype=ARRAY_ELEMENT(firsttype);
                else
                    firsttype=POINTER_TARGET(firsttype);
                if(TYPE_W(secondtype,TYPE_KIND)==TK_ARRAY)
                    secondtype=ARRAY_ELEMENT(secondtype);
                else
                    secondtype=POINTER_TARGET(secondtype);
            }
            if(TYPE_B(first,TYPE_FUNC_FLAGS)&8)
                secondtype=C10PROMOTE(secondtype);
            else if(TYPE_B(second,TYPE_FUNC_FLAGS)&8)
                firsttype=C10PROMOTE(firsttype);
            if(!TYPES_COMPATIBLE(firsttype,secondtype,mode))
                return 0;
            firstparameter=FORMAL_W(firstparameter,FORMAL_NEXT);
            secondparameter=FORMAL_W(secondparameter,FORMAL_NEXT);
        }
        /* both lists must end together */
        return firstparameter==secondparameter;
    default:
        return 0;
    }
}

/* TYPE_ALIGNMENT: returns 2 when word alignment is on and the type is bigger than one
   byte, else 1 (bytes). */
/* 0547: natural alignment is capped at two bytes when enabled. */
unsigned int far pascal TYPE_ALIGNMENT(unsigned int type)
{
    return BCC_PACK_FLAG && TYPE_SIZE(type)>1L?2:1;
}

/* TYPE_SIZE: size of type in bytes (0 for a null type). Arrays multiply the element size
   by the count (0 for an array of unknown size); struct/union read their size from the
   tag body (offset 4, the same word FIELDS.H names TAG_SIZE; the code here uses the enum
   name TAG_ENUM_BASE for it); an enum has the size of its underlying type; a data member
   pointer (near pointer, mode 0x0B, to a non-function) is as big as an unsigned int (row 6
   of KIND_SIZE_TABLE), a member function pointer as big as MEMBER_PTR_CLASS_TYPE. All
   other kinds come from KIND_SIZE_TABLE. */
/* 0570, with its genuine CS switch table at061B..062D. */
long far pascal TYPE_SIZE(register unsigned int type)
{
    if(!type)
        return 0L;
    switch(TYPE_W(type,TYPE_KIND)) {
    case TK_ARRAY:
        return TYPE_SIZE(TYPE_W(type,TYPE_TARGET))*TYPE_L(type,TYPE_ARRAY_COUNT);
    case TK_STRUCT:
    case TK_UNION:
        return (long)TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SIZE);
    case TK_NEAR_PTR:
        if(TYPE_B(type,TYPE_PTR_MODE)==0x0B) {
            if(TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION)
                return KIND_SIZE_TABLE[24];
            return TYPE_SIZE(MEMBER_PTR_CLASS_TYPE);
        }
        break;
    case TK_ENUM:
        return TYPE_SIZE(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE));
    }
    return KIND_SIZE_TABLE[TYPE_W(type,TYPE_KIND)*4];
}
