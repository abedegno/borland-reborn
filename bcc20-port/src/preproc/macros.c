/* macros.c: from bcc20/src/preproc/MACROS.C: the macro table.

   A macro is attached to its name: the name's record in HASH_CHAIN_LINK_SEG has a field
   HLINK_MACRO holding the offset of the definition, 0 when the name is not a macro.  A
   definition is stored in POOL_E, or in POOL_F once POOL_E would pass 64K; POOL_E offsets
   are even and POOL_F offsets odd, so the offset says which pool (input.c, BCC_INPUT_BYTE).
   Layout: the parameter count byte (FFh for an object-like macro), the body text with its
   marker bytes, zero-terminated, and in strict ANSI mode only the parameter names (kept so
   a redefinition can be checked for identical spelling).  Definitions are never freed. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"

#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define NAME_LIMIT SB(NAME_LIMIT_P)
#define TOKEN_TEXT DSPTR(TOKEN_PTR)

/* the size of the parameter name list at offset in POOL_A, its final empty string
   included; 0 when not in strict ANSI mode (the names are then not stored) */
u16 BCC_PACKED_LIST_LENGTH(u16 offset)
{
    if (LANGUAGE_MODE != 1)
        return 0;
    u16 cursor = offset, total = 1;
    while (AT_B(POOL_A, cursor) != 0) {
        u16 length = STRING_LENGTH(MK_FP(POOL_A, cursor)) + 1;
        total += length;
        cursor += length;
    }
    return total;
}

/* nonzero if the count bytes at offset in POOL_A equal those at text */
i16 BCC_COUNTED_COMPARE(u16 offset, farptr text, u16 count)
{
    while (count) {
        if (AT_B(POOL_A, offset) != B(text))
            return 0;
        --count;
        ++offset;
        text = fp_add(text, 1);
    }
    return 1;
}

/* define name with body replacement; flag is the parameter count (-1 object-like), list
   the POOL_A offset of the parameter names.  An identical redefinition keeps the old
   definition; a different one warns "redefinition not identical" and replaces it.
   Returns the offset of the definition. */
u16 MACRO_DEFINE(farptr name, farptr replacement, i8 flag, u16 list)
{
    u16 node = BCC_SYMBOL_CREATE(name, 0);
    u16 token = HLINK_W(node, HLINK_MACRO);
    u16 length = flag != 0 && flag != -1 ? BCC_PACKED_LIST_LENGTH(list) : 0;
    farptr record;
    if (token) {
        record = MK_FP((token & 1) ? POOL_F : POOL_E, token);
        farptr arguments = fp_add(record, STRING_LENGTH(fp_add(record, 1)) + 2);
        if (SB(record) != flag || COMPARE_NAME(replacement, fp_add(record, 1)) ||
            !BCC_COUNTED_COMPARE(list, arguments, length)) {
            REPORT_WARNING(MSG_REDEFINITION_NOT, name);
            HLINK_W(node, HLINK_MACRO) = 0;
        } else
            return token;
    }
    u16 size = STRING_LENGTH(replacement) + length + 2;
    size += size & 1;
    /* the original compares the unit with the size taken as an int */
    if ((i32)POOL_E_UNIT + (i16)size > 65535) {
        token = POOL_ALLOC(POOL_F_P, size);
        record = MK_FP(POOL_F, token);
    } else {
        token = POOL_ALLOC(POOL_E_P, size);
        record = MK_FP(POOL_E, token);
    }
    B(record) = (u8)flag;
    STRING_COPY(fp_add(record, 1), replacement);
    record = fp_add(record, STRING_LENGTH(replacement) + 2);
    RTL_MEMMOVE(record, MK_FP(POOL_A, list), length);
    HLINK_W(node, HLINK_MACRO) = token;
    return token;
}

/* undefine the macro named text */
void MACRO_REMOVE(farptr text)
{
    u16 node = BCC_SYMBOL_CREATE(text, 0);
    HLINK_W(node, HLINK_MACRO) = 0;
}

/* nonzero if text names a macro, the predefined names included.  Names beginning "__" or
   "_W" first start the back end, probably because the predefined memory-model and Windows
   macros are only defined then. */
i16 MACRO_DEFINED(farptr text)
{
    if (NAME_VALIDATE(text))
        return 1;
    if (SB(text) == '_' && (SB(fp_add(text, 1)) == '_' || SB(fp_add(text, 1)) == 'W'))
        ((void (*)(void))code_function(BEGIN_BACKEND_OUTPUT_HOOK))();
    if (HLINK_W(BCC_SYMBOL_CREATE(text, 0), HLINK_MACRO))
        return 1;
    return 0;
}

/* look up the name just scanned (in the token buffer), leave its name record in
   CURRENT_SYMBOL, and say whether it is a macro */
i16 BCC_SYMBOL_CURRENT_TEST(void)
{
    CURRENT_SYMBOL = BCC_SYMBOL_CREATE(TOKEN_TEXT, 0);
    return HLINK_W(CURRENT_SYMBOL, HLINK_MACRO) != 0;
}

/* the 1-based position of the name in the token buffer in the parameter name list at
   offset in POOL_A, or 0 if it is not a parameter (or offset is 0, no list) */
u16 MACRO_LOOKUP(u16 offset)
{
    if (offset == 0)
        return 0;
    u16 ordinal = 1;
    while (AT_B(POOL_A, offset) != 0) {
        if (BCC_SYMBOL_MATCH(MK_FP(POOL_A, offset), TOKEN_TEXT))
            return ordinal;
        ++ordinal;
        offset += STRING_LENGTH(MK_FP(POOL_A, offset)) + 1;
    }
    return 0;
}

/* compare two names over their first NAME_LIMIT significant characters */
i16 BCC_SYMBOL_MATCH(farptr first, farptr second)
{
    for (i16 count = 0; count < NAME_LIMIT; ++count) {
        if (B(first) != B(second))
            return 0;
        if (B(first) == 0)
            break;
        first = fp_add(first, 1);
        second = fp_add(second, 1);
    }
    return 1;
}
