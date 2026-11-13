/* typesize.c: from bcc20/src/types/TYPESIZE.C: pointer types, compatibility and sizes of
   the C++-layout type records (TYPE_* fields of FIELDS.H, a different shape from the C
   layout of typerec.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"

#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)

/* the shared type "pointer to type".  kind is the pointer kind (13 near, 15 far...) or 0
   for the default: far for a far function (TYPE_FUNC_FLAGS bit 0), far for data in a
   far-data model, and in C++ also far for a class whose TAG_CLASS_FLAGS has 100h or 8 set;
   else near.  reference makes a C++ reference (TYPE_ATTRS bit 20h).  TYPE_PTR_MODE is 2
   (code) for function targets, 4 (data) otherwise. */
u16 MAKE_POINTER_TYPE(u16 type, u16 kind, u8 reference)
{
    if (!kind) {
        if (TYPE_W(type, TYPE_KIND) == TK_FUNCTION)
            kind = (TYPE_B(type, TYPE_FUNC_FLAGS) & 1) ? 15 : 13;
        else if (MODEL_FAR_DATA || (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) &&
                                    (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x108)))
            kind = 15;
        else
            kind = 13;
    }
    u16 result = CREATE_TYPE(kind);
    if (reference)
        TYPE_B(result, TYPE_ATTRS) |= 0x20;
    TYPE_W(result, TYPE_TARGET) = type;
    TYPE_B(result, TYPE_PTR_MODE) = TYPE_W(type, TYPE_KIND) == TK_FUNCTION ? 2 : 4;
    TYPE_W(result, TYPE_PARAMS) = 0;
    TYPE_W(result, TYPE_CALL_CONV) = 0;
    return FIND_EQUIVALENT_TYPE(result);
}

/* the default argument promotion: an enum becomes its underlying integer type first;
   integral kinds below int become int, float becomes double */
u16 C10PROMOTE(u16 type)
{
    if (TYPE_W(type, TYPE_KIND) == TK_ENUM)
        type = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_ENUM_BASE);
    if ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 1) && (i16)TYPE_W(type, TYPE_KIND) < TK_INT)
        return INT_TYPE;
    if ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 2) && (i16)TYPE_W(type, TYPE_KIND) < TK_DOUBLE)
        return DOUBLE_TYPE;
    return type;
}

/* 1 when the prototyped function type could agree with an unprototyped declaration: no
   ellipsis (flag 4) and every parameter already its own promoted type */
u8 C10DEFAULTS(u16 type)
{
    if (TYPE_B(type, TYPE_FUNC_FLAGS) & 4)
        return 0;
    for (u16 p = TYPE_W(type, TYPE_PARAMS); p; p = FORMAL_W(p, FORMAL_NEXT))
        if (C10PROMOTE(FORMAL_W(p, FORMAL_TYPE)) != FORMAL_W(p, FORMAL_TYPE))
            return 0;
    return 1;
}

/* an array parameter, or an unqualified pointer, compares by its element or target */
static int decays(u16 type)
{
    return TYPE_W(type, TYPE_KIND) == TK_ARRAY ||
           ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && TYPE_B(type, TYPE_ATTRS) == 0);
}

/* 1 when the types are compatible (a null type matches anything).  mode 0: const and
   volatile must match at every level; 1: the top level's are ignored; 2: they are ignored
   everywhere */
u8 TYPES_COMPATIBLE(u16 first, u16 second, u16 mode)
{
    if (!first || !second || first == second)
        return 1;
    i16 firstkind = (i16)TYPE_W(first, TYPE_KIND), secondkind = (i16)TYPE_W(second, TYPE_KIND);
    u8 qualified = mode || ((TYPE_B(first, TYPE_ATTRS) & 3) == (TYPE_B(second, TYPE_ATTRS) & 3));
    if (firstkind != secondkind || !qualified)
        return 0;
    if (firstkind <= 12 &&
        (!CPP_MODE || TYPES_COMPATIBLE(TYPE_W(first, TYPE_MEMBER_CLASS), TYPE_W(second, TYPE_MEMBER_CLASS), 1)))
        return 1;
    if (mode != 2)
        mode = 0;
    switch (TYPE_W(first, TYPE_KIND)) {
    case TK_ENUM:
    case TK_STRUCT:
    case TK_UNION:
        return TYPE_W(first, TYPE_TAG_BODY) == TYPE_W(second, TYPE_TAG_BODY);
    case TK_ARRAY:
        return (TYPE_L(first, TYPE_ARRAY_COUNT) == TYPE_L(second, TYPE_ARRAY_COUNT) ||
                TYPE_L(first, TYPE_ARRAY_COUNT) == 0 || TYPE_L(second, TYPE_ARRAY_COUNT) == 0) &&
               TYPES_COMPATIBLE(TYPE_W(first, TYPE_TARGET), TYPE_W(second, TYPE_TARGET), mode);
    case TK_NEAR_PTR:
        if (TYPE_B(first, TYPE_PTR_MODE) != TYPE_B(second, TYPE_PTR_MODE))
            return 0;
        if (TYPE_W(first, TYPE_PTR_BASE) || TYPE_W(second, TYPE_PTR_BASE)) {
            if (!TYPE_W(first, TYPE_PTR_BASE) || !TYPE_W(second, TYPE_PTR_BASE) ||
                COMPARE_NAME(MK_FP(POOL_HASH, TYPE_W(first, TYPE_PTR_BASE)),
                             MK_FP(POOL_HASH, TYPE_W(second, TYPE_PTR_BASE))) != 0)
                return 0;
        }
        /* fall through */
    case TK_SEG_PTR:
    case TK_FAR_PTR:
    case TK_HUGE_PTR: {
        u16 ft = TYPE_W(first, TYPE_TARGET), st = TYPE_W(second, TYPE_TARGET);
        if ((TYPE_B(first, TYPE_ATTRS) & 0x20) && TYPE_W(ft, TYPE_KIND) == TK_ARRAY &&
            TYPE_W(st, TYPE_KIND) == TK_ARRAY && TYPE_L(ft, TYPE_ARRAY_COUNT) != TYPE_L(st, TYPE_ARRAY_COUNT))
            return 0;
        return (TYPE_B(first, TYPE_ATTRS) & 0x20) == (TYPE_B(second, TYPE_ATTRS) & 0x20) &&
               TYPES_COMPATIBLE(ft, st, mode);
    }
    case TK_FUNCTION: {
        if (!TYPES_COMPATIBLE(TYPE_W(first, TYPE_TARGET), TYPE_W(second, TYPE_TARGET), mode))
            return 0;
        if ((TYPE_B(first, TYPE_FUNC_FLAGS) & 0x41) != (TYPE_B(second, TYPE_FUNC_FLAGS) & 0x41) ||
            TYPE_B(first, TYPE_CALL_CONV) != TYPE_B(second, TYPE_CALL_CONV))
            return 0;
        if (CPP_MODE && TYPE_W(first, TYPE_MEMBER_CLASS) != TYPE_W(second, TYPE_MEMBER_CLASS))
            return 0;
        if (TYPE_B(first, TYPE_FUNC_FLAGS) & 8)
            return CPP_MODE || C10DEFAULTS(second);
        if (TYPE_B(second, TYPE_FUNC_FLAGS) & 8)
            return CPP_MODE || C10DEFAULTS(first);
        if ((TYPE_B(first, TYPE_FUNC_FLAGS) & 4) != (TYPE_B(second, TYPE_FUNC_FLAGS) & 4))
            return 0;
        u16 fp = TYPE_W(first, TYPE_PARAMS), sp = TYPE_W(second, TYPE_PARAMS);
        while (fp && sp) {
            u16 ft = FORMAL_W(fp, FORMAL_TYPE), st = FORMAL_W(sp, FORMAL_TYPE);
            if (decays(ft) && decays(st)) {
                ft = TYPE_W(ft, TYPE_TARGET);
                st = TYPE_W(st, TYPE_TARGET);
            }
            if (TYPE_B(first, TYPE_FUNC_FLAGS) & 8)
                st = C10PROMOTE(st);
            else if (TYPE_B(second, TYPE_FUNC_FLAGS) & 8)
                ft = C10PROMOTE(ft);
            if (!TYPES_COMPATIBLE(ft, st, mode))
                return 0;
            fp = FORMAL_W(fp, FORMAL_NEXT);
            sp = FORMAL_W(sp, FORMAL_NEXT);
        }
        return fp == sp;
    }
    default:
        return 0;
    }
}

/* 2 when word alignment is on and the type is bigger than a byte, else 1 */
u16 TYPE_ALIGNMENT(u16 type)
{
    return BCC_PACK_FLAG && TYPE_SIZE(type) > 1 ? 2 : 1;
}

/* the size of a type (0 for a null type): arrays the element size times the count (0 for
   an unknown size); struct and union from the tag body; an enum its underlying type's; a
   data member pointer (near, mode 0Bh, to a non-function) as big as an unsigned int, a
   member function pointer as MEMBER_PTR_CLASS_TYPE; others from KIND_SIZE_TABLE */
i32 TYPE_SIZE(u16 type)
{
    if (!type)
        return 0;
    switch (TYPE_W(type, TYPE_KIND)) {
    case TK_ARRAY:
        return (i32)((u32)TYPE_SIZE(TYPE_W(type, TYPE_TARGET)) * (u32)TYPE_L(type, TYPE_ARRAY_COUNT));
    case TK_STRUCT:
    case TK_UNION:
        return (i32)TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SIZE);
    case TK_NEAR_PTR:
        if (TYPE_B(type, TYPE_PTR_MODE) == 0x0B) {
            if (TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) != TK_FUNCTION)
                return KIND_SIZE_TABLE_AT(24);
            return TYPE_SIZE(MEMBER_PTR_CLASS_TYPE);
        }
        break;
    case TK_ENUM:
        return TYPE_SIZE(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_ENUM_BASE));
    }
    return KIND_SIZE_TABLE_AT(TYPE_W(type, TYPE_KIND) * 4);
}
