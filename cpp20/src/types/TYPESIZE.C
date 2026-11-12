/* target: TYPESIZE */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module TYPESIZE (image 0x4BA8..0x4DA1, frame 04BAh): source taken from the
   BCC.EXE reconstruction (bcc20/src/types/TYPESIZE.C), with CPP.EXE's
   edits marked "CPP.EXE edit". CPP.EXE has only some of its functions, in the same
   order; left out here: MAKE_POINTER_TYPE. */
/* Role: type size and compatibility. Entry points: TYPES_COMPATIBLE, TYPE_ALIGNMENT,
   TYPE_SIZE. */
/* Overview: basic questions about type records (TYPE_POOL, fields TYPE_*), asked by the
   expression code of #if: "are these two types compatible", "how big is T", "how is T
   aligned". Types are shared records, so identical types usually have the same record
   number and TYPES_COMPATIBLE can stop at first==second. CPP.EXE's TYPES_COMPATIBLE
   compares only scalar kinds; BCC's also compared enums, structs, arrays, pointers and
   functions, and BCC also had MAKE_POINTER_TYPE here.
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


/* C10PROMOTE: the default argument promotion of type: an enum is first replaced by its
   underlying integer type; integral kinds smaller than int become int (INT_TYPE is
   the int type); float becomes double; anything else is returned unchanged. */
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
   are ignored at every level (used by expr/EXPRCHK.C). In CPP.EXE only the scalar
   test is left (see the CPP.EXE edit below). */
unsigned char far pascal TYPES_COMPATIBLE(register unsigned int first,
    register unsigned int second,unsigned int mode)
{
    int firstkind;
    int secondkind;
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
    /* CPP.EXE edit: everything after this test is gone (the mode reduction and the
       switch over enum, struct/union, array, pointer and function kinds); CPP.EXE's code
       (image 0x4C49..0x4CE4) ends here with "return 0", and its frame holds only these three
       locals (sub sp,6). */
    return 0;
}

/* TYPE_ALIGNMENT: returns 2 when word alignment is on and the type is bigger than one
   byte, else 1 (bytes). */
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
/* Its switch table is in the code segment, right after the function's code. */
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
    /* CPP.EXE edit: no TK_NEAR_PTR case (member pointers); CPP.EXE's switch table
       (CPP image 0x4D97, kinds 0x11..0x15) sends only TK_FUNCTION to the default, and a
       near pointer goes to the default from the range check. */
    case TK_ENUM:
        return TYPE_SIZE(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE));
    }
    return KIND_SIZE_TABLE[TYPE_W(type,TYPE_KIND)*4];
}
