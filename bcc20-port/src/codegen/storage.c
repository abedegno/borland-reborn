/* storage.c: from bcc20/src/codegen/STORAGE.C: small services the back end asks of the
   front end, outside the back-end overlays.  Most take a storage handle: the prepared
   storage record of a symbol (PREPARE_SYMBOL).  Records of autos and parameters live in
   STORAGE_POOL_SEG and the handle is the record offset with bit 0 set; all others live in
   CSYM_POOL_SEG and the handle is the plain offset.  The 10-byte record is {head, value,
   extra, symbol, flags}: value the segment id, extra the intrinsic number of an intrinsic
   function, symbol the front-end symbol, flags a flag word.  The rest are type queries,
   declaration of run-time helper symbols, the parameter count of a function type, an
   address-of node builder and a temporary allocator. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"

#define TYPE_PTR(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))

/* the word at offset of storage record storage, in whichever pool holds it */
static farptr storage_word(u16 storage, u16 offset)
{
    if (storage & 1)
        return MK_FP(STORAGE_POOL_SEG, (storage & 0xFFFE) + offset);
    return MK_FP(CSYM_POOL_SEG, storage + offset);
}

u16 STORAGE_INTRINSIC_NUMBER(u16 storage)
{
    return W(storage_word(storage, 4));
}

u16 STORAGE_SEGMENT(u16 storage)
{
    return W(storage_word(storage, 2));
}

/* the storage class of the record's symbol */
u16 SYMBOL_CATEGORY(u16 storage)
{
    return SYM_B(GET_PREPARED_SYMBOL(storage), SYM_STORAGE_CLASS) >> 3;
}

/* the kind the back end works with for type: the kind itself, the base kind for an enum,
   and 13h for a pointer to member function in C++ */
static u8 class_of(u16 type)
{
    if (CPP_MODE && TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(type, TYPE_PTR_MODE) == 0x0B
        && (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION)
        return 0x13;
    if (TYPE_W(type, TYPE_KIND) == TK_ENUM)
        return TYPE_B(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_ENUM_BASE), TYPE_KIND);
    return TYPE_B(type, TYPE_KIND);
}

u8 TYPE_CLASS_BYTE(u16 type)
{
    return class_of(type);
}

/* the same for the type TYPE_HOOK gives for storage, after stripping array levels */
u8 STORAGE_TYPE_CLASS(u16 storage)
{
    u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(storage));
    while (TYPE_W(type, TYPE_KIND) == TK_ARRAY)
        type = TYPE_W(type, TYPE_TARGET);
    return class_of(type);
}

u16 STORAGE_FIRST_WORD(u16 storage)
{
    return W(storage_word(storage, 0));
}

void SET_STORAGE_FLAG_20(u16 storage)
{
    W(storage_word(storage, 8)) |= 0x20;
}

void SET_STORAGE_ARG_COUNT(u16 storage, u16 value)
{
    W(storage_word(storage, 4)) = value;
}

void SET_STORAGE_SEGMENT(u16 storage, u16 segment)
{
    W(storage_word(storage, 2)) = segment;
}

void SET_STORAGE_SEGMENT_FLAG_8(u16 storage, u16 segment)
{
    W(storage_word(storage, 8)) |= 8;
    W(storage_word(storage, 2)) = segment;
}

void SET_STORAGE_FIRST_WORD(u16 storage, u16 value)
{
    W(storage_word(storage, 0)) = value;
}

/* true for a near pointer with a base */
i16 IS_BASED_NEAR_PTR(u16 type)
{
    return TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR && TYPE_W(type, TYPE_PTR_BASE) != 0;
}

/* the pointer mode byte of a near pointer, else 0 */
i16 NEAR_PTR_SUBKIND(u16 type)
{
    if (TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR)
        return TYPE_SC(type, TYPE_PTR_MODE);
    return 0;
}

i16 TYPE_ATTR_BYTE_0C(u16 type)
{
    return TYPE_B(type, TYPE_FUNC_FLAGS);
}

i16 TYPE_ATTR_BYTE_0B(u16 type)
{
    return TYPE_B(type, TYPE_CALL_CONV);
}

i32 STORAGE_TYPE_SIZE(u16 type)
{
    return TYPE_SIZE(type);
}

u16 BASIC_TYPE_FOR_KIND(u8 index)
{
    return TYPE_PTR(index);
}

/* the type of the record's symbol */
u16 SYMBOL_TYPE_OF_STORAGE(u16 storage)
{
    return SYM_W(GET_PREPARED_SYMBOL(storage), SYM_TYPE);
}

/* the storage record for the run-time helper named text (a near string), declaring it as
   a global function the first time.  The symbol gets SYM_FLAGS 4; on first declaration flag
   40h follows mark, and in C++ the linkage is 2 */
u16 DECLARE_RUNTIME_SYMBOL(u16 text, u16 mark)
{
    u16 name = BCC_SYMBOL_CREATE(DSPTR(text), 0);
    u16 symbol = FIND_NAME_IN_LIST(name, GLOBAL_SCOPE_NAMES);
    if (symbol)
        SYM_B(symbol, SYM_FLAGS) |= 4;
    else {
        symbol = DECLARE_GLOBAL_SYMBOL(DSPTR(text), RUNTIME_HELPER_FUNC_TYPE, 0, 0);
        SYM_B(symbol, SYM_FLAGS) |= 4;
        if (mark)
            SYM_B(symbol, SYM_FLAGS) |= 0x40;
        else
            SYM_B(symbol, SYM_FLAGS) &= 0xBF;
        if (CPP_MODE)
            SYM_W(symbol, SYM_LINKAGE) = 2;
        C0MARK(0);
    }
    return PREPARE_SYMBOL(symbol);
}

i16 IS_STRING_LITERAL_STORAGE(u16 storage)
{
    return PREPARE_SYMBOL(STRING_LITERAL_SYMBOL) == storage;
}

u16 STRING_LITERAL_STORAGE(void)
{
    return PREPARE_SYMBOL(STRING_LITERAL_SYMBOL);
}

/* the number of parameters of function type type (or of the function a pointer points to);
   7FFFh without a prototype.  One more for the hidden parameter of a function returning a
   struct not returned in registers (size above 4 or exactly 3, or a class with a
   constructor) */
u16 PARAMETER_COUNT(u16 type)
{
    if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14)
        type = TYPE_W(type, TYPE_TARGET);
    if (TYPE_B(type, TYPE_FUNC_FLAGS) & 8)
        return 0x7FFF;
    u16 count = 0;
    for (u16 parameter = TYPE_W(type, TYPE_PARAMS); parameter; parameter = FORMAL_W(parameter, FORMAL_NEXT))
        ++count;
    u16 result_type = TYPE_W(type, TYPE_TARGET);
    u16 size = (u16)TYPE_SIZE(result_type);
    if ((EXPR_FLAGS_AT(TYPE_W(result_type, TYPE_KIND)) & 0x40) && (size > 4 || size == 3 || (TYPE_B(result_type, TYPE_ATTRS) & 4)))
        ++count;
    return count;
}

/* &expression (token 1Bh) whose type is a pointer to type: pointer mode 10h with force,
   0Fh when the expression is a symbol whose storage flags have 10h, else 0.  The address
   of an auto, parameter or register variable (ops 4, 5, 7) when DS is not SS gives pointer
   mode 3, an SS-relative pointer */
u16 MAKE_ADDRESS_OF_TYPED(u16 type, u16 expression, u16 force)
{
    u16 mode = 0;
    u16 node = MAKE_UNARY_NODE(0x1B, expression);
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    if (EXPR_W(expression, EXPR_OP) == 1 && (GET_PREPARED_FLAGS(EXPR_W(expression, EXPR_LEFT)) & 0x10))
        mode = 0x0F;
    u16 pointer = MAKE_POINTER_TYPE(type, force ? 0x10 : mode, 0);
    EXPR_W(node, EXPR_TYPE) = pointer;
    if ((EXPR_W(expression, EXPR_OP) == 5 || EXPR_W(expression, EXPR_OP) == 4 || EXPR_W(expression, EXPR_OP) == 7)
        && MODEL_FAR_DATA == 0 && OPTION_DS_NOT_SS)
        TYPE_B(EXPR_W(node, EXPR_TYPE), TYPE_PTR_MODE) = 3;
    u16 kind = (u16)CALL_FAR(GET_TYPE_KIND_HOOK, A16(EXPR_W(node, EXPR_TYPE)));
    EXPR_W(node, EXPR_KIND) = kind;
    return node;
}

/* creates a local temporary of type and returns its storage record */
u16 TEMP_STORAGE_FOR_TYPE(u16 type)
{
    return PREPARE_SYMBOL(CREATE_LOCAL_TEMP(type));
}

u16 STORAGE_IDENTITY(u16 value)
{
    return value;
}
