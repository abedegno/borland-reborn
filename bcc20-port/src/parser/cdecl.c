/* cdecl.c: from bcc20/src/parser/CDECL.C: declarations in the C front end
   (COMPILE_C_SOURCE, for .c files).  BCC_STATEMENT_MAIN is the top of the C parse: it reads
   external declarations until the end of the input.  A declaration is specifiers
   (BCC_STMT_BUILD: storage class, type keywords, struct/union/enum bodies, typedef names,
   modifiers), then a list of declarators (BCC_STMT_PARSE_NEXT), each declared with
   DECLARE_SYMBOL and perhaps initialised (STINIT for static data written as bytes,
   BCC_STMT_FINISH_NEAR for locals initialised by code).  A function declarator followed by
   '{' is a definition (BCC_STMT_MEMBER_NEAR), whose body goes to PARSE_BLOCK_BODY
   (STMTC.C).  Local declarations at the start of a block come through
   BCC_STMT_DECL_PARSE.

   Tokens come straight from the lexer (next_token, one token of push-back); names and
   constant values are in TOKEN_CONST_VALUE.  Symbols are C symbol records (CSYM_*) in the
   scopes C_GLOBAL_SCOPE, C_FUNCTION_SCOPE and the block scope C_DECL_SCOPE.  C symbol
   classes: 1 global definition, 2 extern, 3 static, 4 static in a block, 5 auto, 6
   parameter, 7 pseudo-register, 8 typedef, 9 enumerator, 10 intrinsic, 11 tag, 13
   register.  Types use the C layout of the type pool (TYPE_C_* fields).

   The original keeps values in register pseudo-variables (SI the symbol, DI the type or the
   flag word passed to DECLARE_SYMBOL); here they are ordinary locals.  Kept on purpose: a
   bitfield of width 16 is stored as width 0, so its static initializer is masked to 0
   (BCC_STMT_BITFIELD_NEAR). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_CONST_VALUE SD(TOKEN_CONST_VALUE_P)
#define TOKEN_POSITION D(TOKEN_POSITION_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define UNSIGNED_CHAR B(UNSIGNED_CHAR_P)
#define BCC_PACK_FLAG SB(BCC_PACK_FLAG_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_ENUMS_AS_INT SB(OPTION_ENUMS_AS_INT_P)
#define BCC_ENUM_LIMIT_LO SD(BCC_ENUM_LIMIT_LO_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define OPTION_AUTO_FAR_DATA SB(OPTION_AUTO_FAR_DATA_P)
#define OPTION_WINDOWS_MODE SB(OPTION_WINDOWS_MODE_P)
#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define LOOP_BLOCK_WEIGHT W(LOOP_BLOCK_WEIGHT_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define RETURN_FORM_SEEN B(RETURN_FORM_SEEN_P)
#define PRAGMA_SAVEREGS_PENDING B(PRAGMA_SAVEREGS_PENDING_P)
#define PRAGMA_ARGSUSED_PENDING B(PRAGMA_ARGSUSED_PENDING_P)
#define MODS(i) B(fp_add(C_DECL_MODIFIERS_P, (i)))

/* the hooks */
static u16 mode_type(u16 kind) { return (u16)CALL_FAR(MODE_HOOK, A16(kind)); }
static u16 size_of(u16 type) { return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type)); }
static u16 alignment_of(u16 type) { return (u16)CALL_FAR(TYPE_ALIGNMENT_HOOK, A16(type)); }
static void stream(u16 segment) { CALL_FAR(STREAM_HOOK, A16(segment)); }
static void align_output(u16 alignment) { CALL_FAR(ALIGN_OUTPUT_HOOK, A16(alignment)); }
static void define_here(u16 symbol) { CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(symbol)); }
static void reserve(u16 bytes) { CALL_FAR(RESERVE_BYTES_HOOK, A16(bytes)); }
static void byte_out(u8 value) { CALL_FAR(BYTE_HOOK, A16(value)); }
static u16 symbol_node(u16 op, u16 type, u16 symbol, u16 fourth, u16 fifth)
{
    return (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(op), A16(type), A16(symbol), A16(fourth), A16(fifth));
}
static u16 expr_node(u16 op, u16 type, u16 left, u16 right)
{
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(op), A16(type), A16(left), A16(right));
}

/* the next token: the pushed-back one, or a new one from the lexer */
static u16 next_token(void)
{
    if (TOKEN_PUSHED_BACK) {
        TOKEN_PUSHED_BACK = 0;
        return TOKEN_TYPE;
    }
    return (u16)LEX_NEXT_TOKEN();
}

static void append(u16 block)
{
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL, block, LOOP_BLOCK_WEIGHT);
}

static farptr storage_class_name(u16 kind) { return DSPTR(STORAGE_CLASS_NAMES_AT(kind)); }

/* a whole C file: external declarations, file-level asm statements, stray '}' errors.  A
   declaration without storage class is a global definition (class 1); auto and register
   are not allowed here.  The expression pool is reset after each declaration.  The back
   end is started first, as functions are compiled as soon as they are parsed */
void BCC_STATEMENT_MAIN(void)
{
    u16 statement;
    C_CURRENT_FUNCTION_SYMBOL = 0;
    next_token();
    CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
    if (TOKEN_TYPE == 0 && LANGUAGE_MODE == 1)
        REPORT_ERROR(MSG_FILE_MUST_CONTAIN);
    for (;;) {
        NESTING_CHECK();
        if (TOKEN_TYPE == 0)
            break;
        LOGICAL_LINE = CURRENT_LINE;
        C_DECL_START_POSITION = TOKEN_POSITION;
        if (TOKEN_TYPE == 0x57)
            PARSE_ASM_STATEMENT();
        else if (TOKEN_TYPE == 6)
            REPORT_ERROR(MSG_UNEXPECTED);
        else {
            if (TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
                statement = BCC_STMT_BUILD();
                if (statement == 0)
                    goto next;
                if (C_DECL_STORAGE_CLASS == 0)
                    C_DECL_STORAGE_CLASS = 1;
                else if (C_DECL_STORAGE_CLASS == 5 || C_DECL_STORAGE_CLASS == 13) {
                    REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, storage_class_name(C_DECL_STORAGE_CLASS));
                    C_DECL_STORAGE_CLASS = 1;
                }
            } else {
                C_DECL_STORAGE_CLASS = 1;
                statement = 0;
            }
            if (TOKEN_TYPE != 7) {
                C_OLD_STYLE_PARAM_LIST = 0;
                BCC_STMT_PARSE_NEXT(C_DECL_STORAGE_CLASS, statement, 1);
            }
        }
        CALL_FAR0(RESET_EXPR_POOL_HOOK);
next:
        next_token();
    }
}

/* nonzero if token kind can start declaration specifiers: a keyword with flag 30h in
   TOKEN_START_FLAGS, or an identifier naming a typedef */
i16 TOKEN_STARTS_TYPE(u16 kind)
{
    if (TOKEN_START_FLAGS_AT(kind) & 0x30)
        return 1;
    if (kind == 0x31 && BCC_STMT_SPECIAL_CHECK((u16)TOKEN_CONST_VALUE))
        return 1;
    return 0;
}

/* declaration specifiers; the base type (0 after an error).  Leaves the storage class in
   C_DECL_STORAGE_CLASS (0 if none), const and volatile in C_DECL_SYMBOL_FLAGS and modifiers
   in C_DECL_MODIFIERS.  short, long, signed and unsigned are collected in c, d, b and a and
   combined with the base kind at the end (int 5 becomes short 3, unsigned 6, long 7 ...;
   plain char is unsigned with -K).  The basic types come from MODE_HOOK(kind).  The first
   token after the specifiers is left pushed back */
u16 BCC_STMT_BUILD(void)
{
    u16 node = 0, a = 0, b = 0, c = 0, d = 0, flags = 0, done;
    i16 kind = 0;
    MODS(0) = 0;
    MODS(1) = 0;
    MODS(2) = 0;
    C_DECL_STORAGE_CLASS = 0;
    do {
        done = 0;
        {
            u16 mark = scratch_mark();
            farptr returned = scratch_alloc(4);
            BCC_STMT_BEGIN(returned, MODS(2), W(C_DECL_MODIFIERS_P));
            for (int i = 0; i < 3; i++)
                MODS(i) = B(fp_add(returned, i));
            scratch_release(mark);
        }
        switch (TOKEN_TYPE) {
        case 53:
            if (C_DECL_STORAGE_CLASS)
                REPORT_ERROR(MSG_TOO_MANY_STORAGE);
            C_DECL_STORAGE_CLASS = 3;
            break;
        case 54:
            if (C_DECL_STORAGE_CLASS)
                REPORT_ERROR(MSG_TOO_MANY_STORAGE);
            C_DECL_STORAGE_CLASS = 2;
            break;
        case 55:
            if (C_DECL_STORAGE_CLASS)
                REPORT_ERROR(MSG_TOO_MANY_STORAGE);
            C_DECL_STORAGE_CLASS = 8;
            break;
        case 57:
            if (C_DECL_STORAGE_CLASS)
                REPORT_ERROR(MSG_TOO_MANY_STORAGE);
            C_DECL_STORAGE_CLASS = 5;
            break;
        case 56:
            if (C_DECL_STORAGE_CLASS)
                REPORT_ERROR(MSG_TOO_MANY_STORAGE);
            C_DECL_STORAGE_CLASS = 13;
            break;
        case 74:
            if (flags & 1)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags |= 1;
            break;
        case 75:
            if (flags & 2)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags |= 2;
            break;
        case 69:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            kind = 12;
            break;
        case 58:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            kind = 1;
            break;
        case 59: c = 1; break;
        case 63: d = 1; break;
        case 61: a = 1; break;
        case 62: b = 1; break;
        case 60:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            kind = 5;
            break;
        case 65:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            kind = 10;
            break;
        case 64:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            kind = 9;
            break;
        case 68:
            if (kind || c || a || d || b)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node = BCC_STMT_LOOKUP();
            if (!node)
                return 0;
            kind = 21;
            TOKEN_PUSHED_BACK = 1;
            break;
        case 66:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node = BCC_STMT_ALLOC(1);
            if (!node)
                return 0;
            kind = 19;
            TOKEN_PUSHED_BACK = 1;
            break;
        case 67:
            if (kind)
                REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node = BCC_STMT_ALLOC(2);
            if (!node)
                return 0;
            kind = 19;
            TOKEN_PUSHED_BACK = 1;
            break;
        case 49:
            if (kind)
                goto stop;
            node = BCC_STMT_SPECIAL_CHECK((u16)TOKEN_CONST_VALUE);
            if (node)
                kind = -1;
            else {
                TOKEN_PUSHED_BACK = 1;
                done = 1;
            }
            break;
        default:
stop:
            TOKEN_PUSHED_BACK = 1;
            done = 1;
        }
        next_token();
        LOGICAL_LINE = CURRENT_LINE;
    } while (!done);
    if ((d && c) || (b && a))
        REPORT_ERROR(MSG_TOO_MANY_TYPES);
    switch (kind) {
    case 1:
        if (a)
            kind = 2;
        else if (!b && UNSIGNED_CHAR)
            kind = 2;
        break;
    case 9:
        if (d)
            kind = 10;
        if (a || b)
            REPORT_ERROR(MSG_TOO_MANY_TYPES);
        break;
    case 10:
        if (d)
            kind = 11;
        if (a || b)
            REPORT_ERROR(MSG_TOO_MANY_TYPES);
        break;
    case 0:
    case 5:
        if (d && a)
            kind = 8;
        else if (d)
            kind = 7;
        else if (c && a)
            kind = 4;
        else if (c)
            kind = 3;
        else if (a)
            kind = 6;
        else
            kind = 5;
        break;
    }
    if (!node)
        node = mode_type((u16)kind);
    C_DECL_SYMBOL_FLAGS = flags;
    return node;
}

/* if name is a typedef in scope, its type (a typedef declared with far data, flag 10h,
   also sets the far modifier); else 0 */
u16 BCC_STMT_SPECIAL_CHECK(u16 name)
{
    u16 record = LOOKUP_SYMBOL(name, C_DECL_SCOPE, 0);
    if (record && CSYM_B(record, CSYM_CLASS) == 8) {
        if (CSYM_W(record, CSYM_FLAGS) & 0x10) {
            if (MODS(1))
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            MODS(1) = 9;
        }
        return CSYM_W(record, CSYM_TYPE);
    }
    return 0;
}

/* a bitfield unit's bytes when packing, else one byte */
static u32 unit_bytes(void) { return BCC_PACK_FLAG != 0 ? (u32)(i32)BITFIELD_UNIT_BYTES : 1; }

/* a struct (kind 1) or union (kind 2) specifier after its keyword; returns the type.
   "struct name" without a body refers to (or forward-declares) the tag; with a body the
   members are laid out: offsets, bitfields packed into 16-bit units (a width of 16 is
   stored as 0), word alignment when packing (BCC_PACK_FLAG), and the total size (an empty
   struct is an error and gets size 1; more than 64K is an error).  Unnamed bitfields only
   advance the bit position.  The tag symbol is class 11 in C_DECL_SCOPE */
u16 BCC_STMT_ALLOC(i16 kind)
{
    u16 base, result, declaration, symbol, field, name, saved_kind = C_DECL_STORAGE_CLASS;
    i16 width, bits;
    u32 size;
    i16 named = 0;
    u16 type, head;
    if (next_token() == 49) {
        name = (u16)TOKEN_CONST_VALUE;
        next_token();
    } else
        name = 0;
    if (TOKEN_TYPE != 5) {
        if (name) {
            symbol = TOKEN_TYPE == 7 ? BCC_STMT_FIND2(name, C_DECL_SCOPE, 2) : LOOKUP_SYMBOL(name, C_DECL_SCOPE, 2);
            if (!symbol) {
                result = NEW_STRUCT_TYPE((i8)kind);
                TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
                u16 tag = DECLARE_SYMBOL(name, C_DECL_SCOPE, 2, 11, result, 0, 0);
                TYPE_W(result, TYPE_C_TAG_SYMBOL) = tag;
            } else {
                result = CSYM_W(symbol, CSYM_TYPE);
                if (TYPE_SC(result, TYPE_C_BYTE9) != kind) {
                    DIAG_NAME_BUFFER = 0;
                    REPORT_ERROR(MSG_TYPE_MISMATCH, NAME_TEXT_COPY(name));
                }
            }
        } else {
            REPORT_AND_SKIP(216, 0);
            result = 0;
        }
        goto done;
    }
    size = 0;
    bits = 0;
    head = 0;
    if (name) {
        symbol = BCC_STMT_FIND2(name, C_DECL_SCOPE, 2);
        if (!symbol) {
            result = NEW_STRUCT_TYPE((i8)kind);
            u16 tag = DECLARE_SYMBOL(name, C_DECL_SCOPE, 2, 11, result, 0, 0);
            TYPE_W(result, TYPE_C_TAG_SYMBOL) = tag;
        } else {
            result = CSYM_W(symbol, CSYM_TYPE);
            if (TYPE_W(result, TYPE_C_MEMBERS))
                BCC_STMT_CHECK_NEAR(name);
            if (TYPE_SC(result, TYPE_C_BYTE9) != kind) {
                DIAG_NAME_BUFFER = 0;
                REPORT_ERROR(MSG_TYPE_MISMATCH, NAME_TEXT_COPY(name));
            }
        }
        named = 1;
    } else {
        result = NEW_STRUCT_TYPE((i8)kind);
        DECLARE_SYMBOL(0, C_DECL_SCOPE, 2, 11, result, 0, 0);
    }
    TYPE_W(result, TYPE_C_SIZE) = 1;
    while (next_token() != 6 && TOKEN_TYPE != 0) {
        if (LANGUAGE_MODE == 1 && !TOKEN_STARTS_TYPE(TOKEN_TYPE))
            REPORT_ERROR(MSG_TYPE_NAME_EXPECTED);
        base = BCC_STMT_BUILD();
        if (C_DECL_STORAGE_CLASS)
            REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, storage_class_name(C_DECL_STORAGE_CLASS));
        if (base) {
            for (;;) {
                if (TOKEN_TYPE == 33) {
                    next_token();
                    if (!PARSE_CONSTANT_EXPR(2))
                        continue;
                    width = (i16)TOKEN_CONST_VALUE;
                    if (width > 16) {
                        REPORT_ERROR(MSG_BIT_FIELD_TOO_LARGE);
                        width = 0;
                    }
                    if (width == 0) {
                        if (bits) {
                            size += unit_bytes();
                            bits = 0;
                        }
                    } else if (bits + width > 16) {
                        size += unit_bytes();
                        bits = 0;
                    }
                    bits += width;
                    if (!BCC_PACK_FLAG && bits > 8) {
                        size += (u16)bits >> 3;
                        bits = bits & 7;
                    }
                    if (TOKEN_TYPE != 8) {
                        if (TOKEN_TYPE != 7)
                            REPORT_AND_SKIP(31, 0);
                        break;
                    }
                    next_token();
                    continue;
                }
                declaration = BCC_STMT_DECL_NEW(0);
                if (!declaration)
                    break;
                name = C_DECLARATOR_NAME;
                type = BCC_STMT_BIND_TYPE(declaration, base);
                if (TOKEN_TYPE == 33) {
                    next_token();
                    if (!PARSE_CONSTANT_EXPR(2))
                        break;
                    width = (i16)TOKEN_CONST_VALUE;
                    if (width == 0)
                        REPORT_ERROR(MSG_BIT_FIELDS_MUST);
                    if (width == 16)
                        width = 0;
                    else if (width > 16) {
                        REPORT_ERROR(MSG_BIT_FIELD_TOO_LARGE);
                        width = 0;
                    }
                    if (bits + width > 16) {
                        size += unit_bytes();
                        bits = 0;
                    }
                    if (TYPE_B(type, TYPE_KIND) > 6) {
                        REPORT_ERROR(MSG_BIT_FIELDS_MUST_SIGNED);
                        type = mode_type(5);
                    }
                } else {
                    width = 0;
                    if (TYPE_B(type, TYPE_KIND) == 18)
                        REPORT_ERROR(MSG_FUNCTIONS_MAY_NOT_PART);
                }
                if (kind == 1) {
                    if (!width && bits) {
                        size += 1;
                        if (bits > 8)
                            size += 1;
                        bits = 0;
                    }
                    if (BCC_PACK_FLAG != 0)
                        size += (u16)((u16)size % alignment_of(type));
                    field = ADD_STRUCT_MEMBER(name, head, type, (u16)size, (u8)bits, (u8)width, (u8)C_DECL_SYMBOL_FLAGS);
                    if (!head)
                        head = field;
                    if (!width)
                        size += size_of(type);
                    else {
                        bits += width;
                        if (!BCC_PACK_FLAG && bits >= 8) {
                            size += (u16)bits >> 3;
                            bits = bits & 7;
                        }
                    }
                } else {
                    field = ADD_STRUCT_MEMBER(name, head, type, 0, 0, (u8)width, (u8)C_DECL_SYMBOL_FLAGS);
                    if (!head)
                        head = field;
                    if (!width) {
                        if (size_of(type) > size)
                            size = size_of(type);
                    } else {
                        if ((u32)(i32)BITFIELD_UNIT_BYTES > size)
                            size = (u32)(i32)BITFIELD_UNIT_BYTES;
                    }
                }
                if (TOKEN_TYPE != 8) {
                    if (TOKEN_TYPE != 7)
                        REPORT_AND_SKIP(31, 0);
                    break;
                }
                next_token();
            }
        }
        if (TOKEN_TYPE == 6)
            break;
    }
    if (bits)
        size += unit_bytes();
    else if (size == 0) {
        REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);
        size = 1;
    }
    if (BCC_PACK_FLAG != 0) {
        size += 1;
        size &= 0xFFFFFFFEUL;
    }
    if (size & 0xFFFF0000UL) {
        REPORT_ERROR(MSG_STRUCTURE_SIZE_TOO);
        size = 1;
    }
    TYPE_W(result, TYPE_C_SIZE) = (u16)size;
    TYPE_W(result, TYPE_C_MEMBERS) = head;
    next_token();
    if (named)
        TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
done:
    C_DECL_STORAGE_CLASS = saved_kind;
    return result;
}

/* an enum specifier after its keyword; returns the type.  Each enumerator becomes a class
   9 symbol holding its value; values count up from the previous one unless given.  An enum
   whose values fit in a signed char is marked byte-sized (TYPE_MEMBER_CLASS 1) unless -b.
   With debug information the enumerators are also kept as a field list (TYPE_TAG_BODY) */
u16 BCC_STMT_LOOKUP(void)
{
    u16 type, record, head = 0, field, name;
    i16 minimum, maximum, value;
    if (next_token() == 49) {
        name = (u16)TOKEN_CONST_VALUE;
        next_token();
    } else
        name = 0;
    if (TOKEN_TYPE == 5) {
        if (name) {
            record = BCC_STMT_FIND2(name, C_DECL_SCOPE, 2);
            if (!record) {
                type = MAKE_ENUM_TYPE(0);
                DECLARE_SYMBOL(name, C_DECL_SCOPE, 2, 11, type, 0, 0);
            } else {
                type = CSYM_W(record, CSYM_TYPE);
                if (TYPE_W(type, TYPE_TAG_BODY))
                    BCC_STMT_CHECK_NEAR(name);
            }
        } else
            type = MAKE_ENUM_TYPE(0);
        value = -1;
        minimum = 0;
        maximum = 0;
        while (next_token() != 6) {
            if (TOKEN_TYPE != 49)
                break;
            name = (u16)TOKEN_CONST_VALUE;
            next_token();
            if (TOKEN_TYPE == 11) {
                next_token();
                PARSE_CONSTANT_EXPR(4);
                value = (i16)TOKEN_CONST_VALUE;
            } else {
                if (value == BCC_ENUM_LIMIT_LO)
                    REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value++;
            }
            record = DECLARE_SYMBOL(name, C_DECL_SCOPE, 0, 9, type, 0, 0);
            if (OPTION_SOURCE_DEBUG) {
                field = ADD_STRUCT_MEMBER(name, head, PLAIN_INT_TYPE, (u16)value, 0, 0, 0);
                if (!head)
                    head = field;
            }
            if (value < minimum)
                minimum = value;
            if (value > maximum)
                maximum = value;
            CSYM_W(record, CSYM_OFFSET) = (u16)value;
            if (TOKEN_TYPE != 8)
                break;
        }
        if (TOKEN_TYPE != 6) {
            REPORT_AND_SKIP(40, 0);
            return 0;
        }
        next_token();
        if (OPTION_ENUMS_AS_INT == 0 && minimum >= -128 && maximum <= 127)
            TYPE_W(type, TYPE_MEMBER_CLASS) = 1;
        TYPE_W(type, TYPE_TAG_BODY) = head;
    } else {
        if (name) {
            record = LOOKUP_SYMBOL(name, C_DECL_SCOPE, 2);
            if (!record) {
                if (!OPTION_ENUMS_AS_INT)
                    REPORT_ERROR(MSG_MUST_PREVIOUSLY_206);
                type = MAKE_ENUM_TYPE(0);
                DECLARE_SYMBOL(name, C_DECL_SCOPE, 2, 11, type, 0, 0);
            } else
                type = CSYM_W(record, CSYM_TYPE);
        } else {
            REPORT_AND_SKIP(40, 0);
            return 0;
        }
    }
    TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
    return type;
}

/* reports error (with text) and recovers: skips tokens up to ';' or a '}' (left pushed
   back), stepping over whole brace groups and draining the characters of string literals.
   In MACRO_MODE (inside #if) it skips to the end of the line instead */
void REPORT_AND_SKIP(u16 error, farptr text)
{
    i16 token, depth;
    LOGICAL_LINE = CURRENT_LINE;
    token = TOKEN_TYPE;
    REPORT_ERROR((i16)error, text);
    if (MACRO_MODE) {
        while (token && token != 10)
            token = next_token();
    } else {
        if (token == 6)
            TOKEN_PUSHED_BACK = 1;
        else {
            while (token && token != 7 && token != 6) {
                if (token == 5) {
                    depth = 1;
                    for (;;) {
                        token = next_token();
                        LOGICAL_LINE = CURRENT_LINE;
                        if (!token)
                            return;
                        if (token == 6) {
                            depth--;
                            if (depth <= 0)
                                break;
                        } else if (token == 5)
                            depth++;
                        else if (token == 52)
                            BCC_LEX_RESTORE(0);
                    }
                } else if (token == 52)
                    BCC_LEX_RESTORE(0);
                token = next_token();
                LOGICAL_LINE = CURRENT_LINE;
            }
            if (token == 6)
                TOKEN_PUSHED_BACK = 1;
        }
    }
}

/* one local declaration (no storage class means auto) */
void BCC_STMT_DECL_PARSE(void)
{
    u16 node = BCC_STMT_BUILD();
    if (node) {
        if (C_DECL_STORAGE_CLASS == 0)
            C_DECL_STORAGE_CLASS = 5;
        if (TOKEN_TYPE != 7)
            BCC_STMT_PARSE_NEXT(C_DECL_STORAGE_CLASS, node, 0);
    }
}

/* the declarators of one declaration with storage class kind and base type base.  allowed
   is nonzero at file level (function definitions and old-style parameter lists allowed).
   For each declarator: a function is declared (class 2 or 3; a definition goes to
   BCC_STMT_MEMBER_NEAR); an object gets its class, its segment (linkage: BSS, data, a far
   segment, or FFFFh for a communal variable with -Fc) and its flag word (di: 4 near data,
   10h far data, 20h initialised or local, 400h pascal naming, 8 register), possibly moved
   to far data by automatic far data.  Then the initializer: a static object is written as
   data by STINIT (char arrays of strings with -d go to the merged string pool), an auto or
   register object is initialised by code (BCC_STMT_FINISH_NEAR); a block static without
   initializer reserves its storage at once.  1 if the declaration ended with ';' */
i16 BCC_STMT_PARSE_NEXT(u16 kind, u16 base, u16 allowed)
{
    u16 type, mode, decl, saved, flags, linkage = 0, result, temporary, output, buffer = 0, di, si;
    int linkage_unset = 1;          /* the original's linkage local is unset until assigned */
    if (kind == 13) {
        flags = 8;
        kind = 5;
    } else
        flags = 0;
    saved = C_DECL_SYMBOL_FLAGS;
again:
    C_DECL_SYMBOL_FLAGS = saved;
    decl = BCC_STMT_DECL_NEW(allowed);
    di = 0;
    if (decl == 0)
        return 0;
    if ((TOKEN_TYPE == 7 || TOKEN_TYPE == 8 || TOKEN_TYPE == 11) && base == 0 && IS_BARE_DECLARATOR(decl))
        REPORT_ERROR(MSG_TYPE_NAME_EXPECTED);
    if (base == 0)
        base = PLAIN_INT_TYPE;
    type = BCC_STMT_BIND_TYPE(decl, base);
    mode = kind;
    if (kind == 8) {
        if (C_DECL_DISTANCE == 9 && TYPE_B(type, TYPE_KIND) != 0x12)
            di = 0x10;
        goto define;        /* linkage stays as it was: unset for a typedef's first declarator */
    }
    if (TYPE_B(type, TYPE_KIND) == 0x12) {
        if (C_DECL_SCOPE == C_GLOBAL_SCOPE && allowed != 0 && TOKEN_TYPE == 5)
            BCC_STMT_FUNCTION_NEAR();
        di = (TYPE_B(type, TYPE_C_FUNC_FLAGS) & 1) ? 0x10 : 4;
        if (TYPE_B(type, TYPE_C_CALL_CONV) == 2)
            flags |= 0x400;
        else if (TYPE_B(type, TYPE_C_CALL_CONV) == 3)
            flags |= 0x2000;
        if (C_DECL_SCOPE != C_GLOBAL_SCOPE && allowed != 0) {
            if (LANGUAGE_MODE == 1 && base == type)
                REPORT_ERROR(MSG_FUNCTION_DEFINITION);
            return BCC_STMT_MEMBER_NEAR(kind, type, flags);
        }
        if (kind == 3) {
            if (allowed == 0) {
                REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, STR_STATIC_P);
                mode = 2;
            }
        } else
            mode = 2;
        si = DECLARE_SYMBOL(C_DECLARATOR_NAME, C_DECL_SCOPE, 0, mode, type, 0, flags | di);
        if (TOKEN_TYPE == 8) {
            next_token();
            goto again;
        }
        if (TOKEN_TYPE != 7) {
            DIAG_NAME_BUFFER = 0;
            REPORT_AND_SKIP(MSG_DECLARATION_SYNTAX, NAME_TEXT_COPY(CSYM_W(si, CSYM_NAME)));
            return 0;
        }
        return 1;
    }
    linkage = BSS_SEGMENT_ID;
    linkage_unset = 0;
    if (TYPE_B(type, TYPE_KIND) == 0x13)
        flags &= 0xFFF7;
    switch (mode) {
    case 2:
        if (TOKEN_TYPE != 11) {
            if (C_DECL_CALL_CONVENTION == 2 || (C_DECL_CALL_CONVENTION == 0 && OPTION_CALLING_CONVENTION == 1))
                di |= 0x400;
            if (C_DECL_DISTANCE == 8)
                di |= 4;
            else if (C_DECL_DISTANCE == 9 || OPTION_MEMORY_MODEL == 5 || DATA_BSS_GROUPS_DIFFER != 0) {
                di |= 0x10;
                linkage = 0xFFFF;
            } else
                di |= 4;
            break;
        }
        if (allowed == 0) {
            REPORT_AND_SKIP(MSG_EXTERN_VARIABLE_CANNOT, 0);
            return 0;
        }
        mode = 1;
        /* fall through */
    case 1:
        if (C_DECL_CALL_CONVENTION == 2 || (C_DECL_CALL_CONVENTION == 0 && OPTION_CALLING_CONVENTION == 1))
            di |= 0x400;
        /* fall through */
    case 3:
        if (C_DECL_SCOPE != C_GLOBAL_SCOPE) {
            di |= 0x20;
            mode = 4;
        }
        if (C_DECL_DISTANCE == 9) {
            if (OPTION_COMDEFS != 0 && mode == 1 && TOKEN_TYPE != 11)
                linkage = 0xFFFF;
            else if (TYPE_B(type, TYPE_KIND) == 0x11 && TYPE_B(type, TYPE_C_BYTE9) != 0)
                linkage = ALLOC_ARRAY_SEGMENTS(type);
            else
                linkage = DEFINE_FAR_SEGMENT();
            di |= 0x10;
        } else if (DATA_BSS_GROUPS_DIFFER != 0 && TOKEN_TYPE != 11)
            di |= 0x10;
        else {
            di |= 4;
            if (TOKEN_TYPE == 11)
                linkage = DATA_SEGMENT_ID;
        }
        if (TOKEN_TYPE == 11)
            di |= 0x20;
        break;
    case 5:
        if (C_DECL_DISTANCE != 0)
            REPORT_ERROR(MSG_CONFLICTING_TYPE);
        if (TOKEN_TYPE == 11)
            di |= 0x24;
        else if (!size_of(type)) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_SIZE_UNKNOWN_ZERO, NAME_TEXT_COPY(C_DECLARATOR_NAME));
        }
        break;
    }
define:
    if (OPTION_AUTO_FAR_DATA != 0 && MODEL_FAR_DATA != 0 && C_DECL_DISTANCE != 8 && !(di & 0x10)) {
        if (mode == 2)
            goto external;
        if (TOKEN_TYPE == 11 || (!OPTION_COMDEFS && mode == 1)) {
            if (size_of(type) >= FAR_DATA_THRESHOLD) {
                linkage = DEFINE_FAR_SEGMENT();
                linkage_unset = 0;
                di &= 0xFFFB;
                di |= 0x10;
            }
        } else if (mode == 1 && OPTION_COMDEFS != 0) {
external:
            linkage = 0xFFFF;
            linkage_unset = 0;
            di &= 0xFFFB;
            di |= 0x10;
        }
    }
    if (linkage_unset)
        UNSET_ARGS(1u << 5);
    si = DECLARE_SYMBOL(C_DECLARATOR_NAME, C_DECL_SCOPE, 0, mode, type, linkage_unset ? 0 : linkage,
                        flags | di | C_DECL_SYMBOL_FLAGS);
    if (linkage_unset)
        UNSET_RESULT(MK_FP(CSYM_POOL_SEG, si + CSYM_SEGMENT), 2);  /* where DECLARE_SYMBOL keeps it */
    if (mode == 5 || mode == 6) {
        u16 entry = FIND_OR_ADD_VARIABLE(si, TYPE_B(type, TYPE_KIND), CSYM_B(si, CSYM_FLAGS));
        CSYM_W(si, CSYM_VAR_ENTRY) = entry;
    }
    if (TOKEN_TYPE == 11) {
        next_token();
        if (mode == 1 || mode == 4 || mode == 3) {
            CSYM_W(si, CSYM_FLAGS) &= 0xF7FF;
            if (!(CSYM_W(si, CSYM_FLAGS) & 1) || OPTION_MERGE_STRINGS == 0 || mode == 4 ||
                TYPE_B(CSYM_W(si, CSYM_TYPE), TYPE_KIND) != 0x11 ||
                TYPE_B(TYPE_W(CSYM_W(si, CSYM_TYPE), TYPE_TARGET), TYPE_KIND) > 2) {
                output = 1;
                stream(CSYM_W(si, CSYM_SEGMENT));
                if (BCC_PACK_FLAG)
                    align_output(alignment_of(CSYM_W(si, CSYM_TYPE)));
                define_here(si);
                temporary = 0;
            } else {
                temporary = 1;
                buffer = BYTE_POOL_LENGTH();
                output = 2;
                CSYM_W(si, CSYM_SEGMENT) = 0;
            }
            result = STINIT(CSYM_W(si, CSYM_TYPE), 1, output);
            if (temporary) {
                u16 offset = MERGE_DUPLICATE_BYTES(buffer);
                CSYM_W(si, CSYM_OFFSET) = offset;
            }
            if (result) {
                CSYM_W(si, CSYM_TYPE) = result;
                if (OPTION_AUTO_FAR_DATA != 0 && MODEL_FAR_DATA != 0 && C_DECL_DISTANCE != 8 && !(di & 0x10) &&
                    size_of(result) >= FAR_DATA_THRESHOLD) {
                    DIAG_NAME_BUFFER = 0;
                    REPORT_WARNING(MSG_ARRAY_VARIABLE_NEAR, NAME_TEXT_COPY(CSYM_W(si, CSYM_NAME)));
                }
            }
            CSYM_W(si, CSYM_FLAGS) |= 0x240;
        } else if (mode == 5 || mode == 13)
            BCC_STMT_FINISH_NEAR(si);
    } else if (mode == 4) {
        stream(CSYM_W(si, CSYM_SEGMENT));
        if (BCC_PACK_FLAG)
            align_output(alignment_of(CSYM_W(si, CSYM_TYPE)));
        define_here(si);
        result = size_of(CSYM_W(si, CSYM_TYPE));
        if (result == 0) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_SIZE_UNKNOWN_ZERO, NAME_TEXT_COPY(CSYM_W(si, CSYM_NAME)));
        } else
            reserve(result);
    } else if (OPTION_COMDEFS != 0 && mode == 1) {
        CSYM_B(si, CSYM_CLASS) = 2;
        CSYM_W(si, CSYM_FLAGS) |= 0x800;
    }
    if (TOKEN_TYPE == 8) {
        next_token();
        goto again;
    }
    if (TOKEN_TYPE != 7) {
        DIAG_NAME_BUFFER = 0;
        REPORT_AND_SKIP(mode == 8 ? MSG_EXPECTED_202 : MSG_DECLARATION_SYNTAX, NAME_TEXT_COPY(CSYM_W(si, CSYM_NAME)));
        return 0;
    }
    return 1;
}

/* a function definition; binding is the function type, kind its storage class, flags its
   symbol flags.  Declares the function in the global scope, sets up the per-function state
   (INIT_FUNCTION_STATE, BCC_TREE_SPECIAL), reads old-style parameter declarations and
   checks them against an earlier prototype, declares the parameters, makes main with
   parameters pull in _setargv (and _setenvp for three), parses the body, reports undefined
   labels and a missing return value, and finishes the function's block chain.  #pragma
   saveregs applies here */
i16 BCC_STMT_MEMBER_NEAR(u16 kind, u16 binding, u16 flags)
{
    u16 type, parameters, access;
    i16 count;
    u16 di = binding;
    if (kind == 2)
        kind = 1;
    u16 si = DECLARE_SYMBOL(C_DECLARATOR_NAME, C_GLOBAL_SCOPE, 0, kind, di, CODE_SEGMENT_ID, flags | 0x24);
    CURRENT_FUNCTION_TYPE = TYPE_W(di, TYPE_C_TARGET);
    C_FUNC_DEF_SET_ONLY_FLAG = 1;
    DIAG_NAME_BUFFER = 0;
    FUNCTION_NAME_TEXT = STRING_COPY(C_FUNCTION_NAME_BUFFER_P, NAME_TEXT_COPY(CSYM_W(si, CSYM_NAME)));
    access = 0;
    if (PRAGMA_SAVEREGS_PENDING)
        access = 0x20;
    PRAGMA_SAVEREGS_PENDING = 0;
    POOL_TRIM(CONTEXT_SEG_P, 100);
    BCC_TREE_SPECIAL = INIT_FUNCTION_STATE(si, CURRENT_FUNCTION_TYPE, TYPE_W(di, TYPE_C_PARAMS), TYPE_B(di, TYPE_C_CALL_CONV),
                                           TYPE_B(di, TYPE_C_FUNC_FLAGS) | (u8)access, CODE_SEGMENT_ID, C_DECL_SOURCE_FILE,
                                           C_DECL_SOURCE_LINE, C_DECL_START_POSITION_HIGH, W(C_DECL_START_POSITION_P));
    if (TYPE_W(di, TYPE_C_PARAMS) == 0 && C_OLD_STYLE_PARAM_LIST != 0) {
        while (TOKEN_TYPE && TOKEN_TYPE != 5) {
            if (TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
                type = BCC_STMT_BUILD();
                if (type == 0)
                    continue;
                if (C_DECL_STORAGE_CLASS == 0)
                    C_DECL_STORAGE_CLASS = 6;
                else if (C_DECL_STORAGE_CLASS != 13 && C_DECL_STORAGE_CLASS != 8) {
                    REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, storage_class_name(C_DECL_STORAGE_CLASS));
                    C_DECL_STORAGE_CLASS = 6;
                }
                if (TOKEN_TYPE != 7 && !BCC_STMT_CHECK_TYPE_NEAR(C_DECL_STORAGE_CLASS, type)) {
                    C_DECL_SCOPE = C_GLOBAL_SCOPE;
                    CURRENT_SCOPE = GLOBAL_SCOPE;
                    return 0;
                }
            } else {
                REPORT_AND_SKIP(MSG_DECLARATION_WAS, 0);
                if (TOKEN_TYPE == 6) {
                    TOKEN_PUSHED_BACK = 1;
                    break;
                }
            }
            next_token();
        }
        parameters = C_OLD_STYLE_PARAM_LIST;
        STBEGIN(parameters);
        if ((TYPE_B(CSYM_W(si, CSYM_TYPE), TYPE_C_FUNC_FLAGS) & 8) == 0)
            BCC_STMT_END_NEAR(si, TYPE_W(CSYM_W(si, CSYM_TYPE), TYPE_C_PARAMS), parameters);
    } else
        parameters = TYPE_W(di, TYPE_C_PARAMS);
    {
        u16 chain = BCC_TREE_SPECIAL;                   /* pascal: read before the call */
        STMT_SCOPE_BLOCK = NEW_SCOPE_ENTER_BLOCK(C_FUNCTION_SCOPE, 0);
        APPEND_BLOCK_CHAIN(chain, STMT_SCOPE_BLOCK, LOOP_BLOCK_WEIGHT);
    }
    count = (i16)BCC_STMT_COUNT_NEAR(parameters);
    if (CSYM_W(si, CSYM_NAME) == MAIN_SYMBOL && !OPTION_WINDOWS_MODE && count > 0) {
        CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(OPTION_UNDERSCORES ? STR_SETARGV_P : STR_SETARGV_2_P)), A16(0));
        if (count >= 3)
            CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(OPTION_UNDERSCORES ? STR_SETENVP_P : STR_SETENVP_2_P)), A16(0));
    }
    C_CURRENT_FUNCTION_SYMBOL = si;
    count = PARSE_BLOCK_BODY(1, 1);
    C_CURRENT_FUNCTION_SYMBOL = 0;
    C_DECL_SCOPE = C_GLOBAL_SCOPE;
    CURRENT_SCOPE = GLOBAL_SCOPE;
    BCC_STMT_FLUSH_NEAR();
    if (count) {
        if (TYPE_B(CURRENT_FUNCTION_TYPE, TYPE_KIND) != 12)
            REPORT_WARNING(MSG_FUNCTION_SHOULD_RETURN_367);
        else if (RETURN_FORM_SEEN == 2)
            REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
    }
    {
        u16 chain = BCC_TREE_SPECIAL;
        u16 block = NEW_SCOPE_EXIT_BLOCK(STMT_SCOPE_BLOCK);
        APPEND_BLOCK_CHAIN(chain, block, LOOP_BLOCK_WEIGHT);
    }
    LOGICAL_LINE = CURRENT_LINE;
    FINISH_FUNCTION_BLOCKS(BCC_TREE_SPECIAL, TOKEN_FILE_NODE, TOKEN_LINE);
    FUNCTION_NAME_TEXT = 0;
    C_FUNC_DEF_SET_ONLY_FLAG = 1;
    PRAGMA_ARGSUSED_PENDING = 0;
    return 1;
}

/* checks old-style parameter types left (after the default promotions: float to double,
   small integers by INTEGRAL_PROMOTION_KIND) against the prototype parameter list right of
   function record, then the counts: with function flag 4 (the prototype ends in "...")
   only leftover prototype parameters are an error, otherwise any difference is */
void BCC_STMT_END_NEAR(u16 record, u16 right, u16 left)
{
    while (left && right) {
        u16 type = CPARM_W(left, CPARM_TYPE), size;
        if (TYPE_B(type, TYPE_KIND) == 9)
            size = 10;
        else
            size = INTEGRAL_PROMOTION_KIND_AT(TYPE_B(type, TYPE_KIND));
        if (size) {
            u16 expected = mode_type(size);
            if (!TYPE_RECORDS_COMPATIBLE(expected, CPARM_W(right, CPARM_TYPE), 0)) {
                if (LANGUAGE_MODE == 1 || TYPE_B(type, TYPE_KIND) == 9) {
                    DIAG_NAME_BUFFER = 0;
                    REPORT_ERROR(MSG_TYPE_MISMATCH_80, NAME_TEXT_COPY(CPARM_W(left, CPARM_NAME)));
                }
            }
        } else if (!TYPE_RECORDS_COMPATIBLE(type, CPARM_W(right, CPARM_TYPE), 0)) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_TYPE_MISMATCH_80, NAME_TEXT_COPY(CPARM_W(left, CPARM_NAME)));
        }
        left = CPARM_W(left, CPARM_NEXT);
        right = CPARM_W(right, CPARM_NEXT);
    }
    if (TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_C_FUNC_FLAGS) & 4) {
        if (right) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_TYPE_MISMATCH, NAME_TEXT_COPY(CSYM_W(record, CSYM_NAME)));
        }
    } else if (left || right) {
        DIAG_NAME_BUFFER = 0;
        REPORT_ERROR(MSG_TYPE_MISMATCH, NAME_TEXT_COPY(CSYM_W(record, CSYM_NAME)));
    }
}

/* the declarators of one old-style parameter declaration ("int a, *b;"), giving each named
   parameter its type (functions become pointers); a typedef here (kind 8) is declared
   globally instead.  0 after a syntax error */
u16 BCC_STMT_CHECK_TYPE_NEAR(u16 kind, u16 type)
{
    u16 saved = C_DECL_SYMBOL_FLAGS;
    for (;;) {
        C_DECL_SYMBOL_FLAGS = saved;
        u16 declaration = BCC_STMT_DECL_NEW(0);
        if (!declaration)
            return 0;
        u16 bound = BCC_STMT_BIND_TYPE(declaration, type);
        if (TYPE_B(bound, TYPE_KIND) == 18)
            bound = PTR_TYPE_FOR_MODIFIER(bound, 0, 0, 0);
        if (kind == 8)
            DECLARE_SYMBOL(C_DECLARATOR_NAME, C_GLOBAL_SCOPE, 0, kind, bound, 0, 0);
        else
            BCC_STMT_BIND_FIELD(C_OLD_STYLE_PARAM_LIST, C_DECLARATOR_NAME, kind, bound);
        if (TOKEN_TYPE == 8)
            next_token();
        else
            break;
    }
    if (TOKEN_TYPE != 7) {
        REPORT_AND_SKIP(MSG_EXPECTED_202, 0);
        return 0;
    }
    return 1;
}

/* begins a function's parameter scope: clears the per-function state and makes
   C_FUNCTION_SCOPE (emptied) the current scope.  An old-style parameter list inside a block
   is an error */
void BCC_STMT_FUNCTION_NEAR(void)
{
    if (C_DECL_SCOPE != C_GLOBAL_SCOPE)
        REPORT_ERROR(MSG_PARAMETER_NAMES_ARE);
    else {
        RTL_MEMSET(BCC_TREE_SPECIAL_P, 0, 9);
        C_FUNC_START_CLEARED_WORD = 0;
        C_DECL_SCOPE = C_FUNCTION_SCOPE;
        CURRENT_SCOPE = C_FUNCTION_SCOPE;
        RTL_MEMSET(MK_FP(SCOPE_POOL_SEG, C_FUNCTION_SCOPE), 0, 8);
        C_OLD_STYLE_PARAM_LIST = 0;
    }
}

/* sets the type of parameter name in the old-style list field (arrays and functions become
   pointers; flag 8, register, marks it FEh).  A name not in the list, or declared twice, is
   an error */
void BCC_STMT_BIND_FIELD(u16 field, u16 name, u16 flags, u16 type)
{
    u16 di = type, si = field;
    while (si) {
        if (CPARM_W(si, CPARM_NAME) == name) {
            if (CPARM_W(si, CPARM_TYPE)) {
                BCC_STMT_CHECK_NEAR(name);
                return;
            }
            if (di) {
                if (TYPE_B(di, TYPE_KIND) == 0x11)
                    di = PTR_TYPE_FOR_MODIFIER(TYPE_W(di, TYPE_TARGET), 0, 0, 0);
                else if (TYPE_B(di, TYPE_KIND) == 0x12)
                    di = PTR_TYPE_FOR_MODIFIER(di, 0, 0, 0);
            }
            CPARM_W(si, CPARM_TYPE) = di;
            if (flags & 8)
                CPARM_B(si, CPARM_REG_MARK) = 0xFE;
            return;
        }
        si = CPARM_W(si, CPARM_NEXT);
    }
    DIAG_NAME_BUFFER = 0;
    REPORT_ERROR(MSG_NOT_PARAMETER, NAME_TEXT_COPY(name));
}

/* gives every old-style parameter that was never declared the type int */
void STBEGIN(u16 node)
{
    while (node != 0) {
        if (CPARM_W(node, CPARM_TYPE) == 0)
            CPARM_W(node, CPARM_TYPE) = PLAIN_INT_TYPE;
        node = CPARM_W(node, CPARM_NEXT);
    }
}

/* appends a parameter (name, type adjusted as for BCC_STMT_BIND_FIELD, register mark FEh
   if flags has 8, else FFh) to the C_PARAM_POOL_SEG list head and returns the list.  A
   repeated name is reported */
u16 BCC_STMT_ADD_FIELD(u16 head, u16 name, u16 type, u16 flags)
{
    u16 si;
    if (name) {
        for (si = head; si; si = CPARM_W(si, CPARM_NEXT))
            if (CPARM_W(si, CPARM_NAME) == name) {
                BCC_STMT_CHECK_NEAR(name);
                return si;
            }
    }
    si = POOL_ALLOC_REUSE(C_PARAM_POOL_SEG_P, 8);
    if (head) {
        u16 di = head;
        while (CPARM_W(di, CPARM_NEXT))
            di = CPARM_W(di, CPARM_NEXT);
        CPARM_W(di, CPARM_NEXT) = si;
    } else
        head = si;
    CPARM_B(si, CPARM_REG_MARK) = (flags & 8) ? 0xFE : 0xFF;
    CPARM_B(si, CPARM_BYTE1) = 0xFF;
    CPARM_W(si, CPARM_NEXT) = 0;
    CPARM_W(si, CPARM_NAME) = name;
    if (type) {
        if (TYPE_B(type, TYPE_KIND) == 0x11)
            type = PTR_TYPE_FOR_MODIFIER(TYPE_W(type, TYPE_TARGET), 0, 0, 0);
        else if (TYPE_B(type, TYPE_KIND) == 0x12)
            type = PTR_TYPE_FOR_MODIFIER(type, 0, 0, 0);
    }
    CPARM_W(si, CPARM_TYPE) = type;
    return head;
}

/* declares the parameters in list item as class 6 symbols of the current function (flag
   64, plus 8 for register) with their variable entries, and returns their count.  A
   function returning a struct not of size 1, 2 or 4 first gets the hidden parameter
   STRUCT_RETURN_PARAM, a far pointer to the result.  A parameter without a name is an
   error */
u16 BCC_STMT_COUNT_NEAR(u16 item)
{
    i16 count;
    if (TYPE_B(CURRENT_FUNCTION_TYPE, TYPE_KIND) == 19) {
        count = (i16)TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_MEMBER_CLASS);
        if (count != 1 && count != 2 && count != 4) {
            u16 type = NEW_POINTER_TYPE(CURRENT_FUNCTION_TYPE, 15, 0, 0, 0);
            STRUCT_RETURN_PARAM = DECLARE_SYMBOL(0, C_DECL_SCOPE, 0, 6, type, 0, 64);
            u16 entry = FIND_OR_ADD_VARIABLE(STRUCT_RETURN_PARAM, 15, 0);
            CSYM_W(STRUCT_RETURN_PARAM, CSYM_VAR_ENTRY) = entry;
        }
    }
    count = 1;
    while (item) {
        if (!CPARM_W(item, CPARM_NAME))
            REPORT_ERROR(MSG_PARAMETER_D_MISSING, (long)count);
        u16 record = DECLARE_SYMBOL(CPARM_W(item, CPARM_NAME), C_DECL_SCOPE, 0, 6, CPARM_W(item, CPARM_TYPE), 0,
                                    CPARM_B(item, CPARM_REG_MARK) == 254 ? 72 : 64);
        u16 entry = FIND_OR_ADD_VARIABLE(record, TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_KIND), CSYM_B(record, CSYM_FLAGS));
        CSYM_W(record, CSYM_VAR_ENTRY) = entry;
        item = CPARM_W(item, CPARM_NEXT);
        count++;
    }
    return (u16)(count - 1);
}

/* "multiple declaration" of name */
void BCC_STMT_CHECK_NEAR(u16 name)
{
    DIAG_NAME_BUFFER = 0;
    REPORT_ERROR(MSG_MULTIPLE_DECLARATION, NAME_TEXT_COPY(name));
}

/* at the end of a function: every label used by goto but never defined (labels are
   name-space 1 in C_FUNCTION_SCOPE; flag 40h = defined) */
void BCC_STMT_FLUSH_NEAR(void)
{
    for (u16 record = SCOPE_W(C_FUNCTION_SCOPE, SCOPE_C_SYMBOLS); record; record = CSYM_W(record, CSYM_NEXT))
        if (CSYM_B(record, CSYM_NAMESPACE) == 1 && !(CSYM_W(record, CSYM_FLAGS) & 0x40)) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_UNDEFINED_LABEL, NAME_TEXT_COPY(CSYM_W(record, CSYM_NAME)));
        }
}

#define FAIL(n) do { REPORT_AND_SKIP((n), 0); return 0; } while (0)

/* writes a byte of a char array's string initializer or zero fill */
static void emit_byte(u16 mode, u8 value)
{
    if (mode == 1)
        byte_out(value);
    else
        EMIT_VALUE((i8)value);
}

/* writes the bytes of the pending bitfield unit up to (or past) a member's offset */
static void flush_bitfields(u16 *si)
{
    BCC_STMT_OUTPUT_NEAR((u8)BITFIELD_INIT_BITS);
    BITFIELD_INIT_BITS >>= 8;
    ++BITFIELD_INIT_OFFSET;
    ++*si;
}

/* a static initializer for an object of type, written as data bytes.  fixed is nonzero at
   the top level (an unsized array may get its size from the initializer; the new array type
   is returned); mode is the output: 1 the current segment through BYTE_HOOK, 2 the data
   byte pool (merged strings).  Arrays: from string literals (char arrays) or from elements,
   braces optional for inner levels; the rest of a sized array is reserved.  Structs and
   unions: members in order, bitfields collected in BITFIELD_INIT_BITS and written byte by
   byte, alignment padding when packing; a union takes its first member.  Scalars: an
   expression folded and written by EMIT_INITIALIZER_VALUE_FAR.  Returns the type, or 0
   after an error (already reported and skipped) */
u16 STINIT(u16 type, u16 fixed, u16 mode)
{
    u16 braces, limit, initialized = 0, si = 0, di;
    i16 alignment;
    if (TOKEN_TYPE == 5) {
        braces = 1;
        initialized = 0;
        next_token();
    } else
        braces = 0;
    TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
    switch (TYPE_B(type, TYPE_KIND)) {
    case 0x11:
        if (TYPE_L(type, TYPE_C_SIZE) == 0)
            limit = 0xFFFF;
        else
            limit = TYPE_W(type, TYPE_C_SIZE);
        if (TYPE_B(TYPE_W(type, TYPE_TARGET), TYPE_KIND) <= 2 && TOKEN_TYPE == 0x34) {
            si = 0;
            do {
                BCC_LEX_RESTORE((i16)mode);
                si += (u16)TOKEN_CONST_VALUE;
            } while (next_token() == 0x34);
            initialized = 1;
            if (TYPE_L(type, TYPE_C_SIZE) == 0) {
                emit_byte(mode, 0);
                ++si;
            } else if (mode == 2) {
                while ((i32)si < TYPE_L(type, TYPE_MEMBER_CLASS)) {
                    ++si;
                    EMIT_VALUE(0);
                }
            }
            if (si > limit) {
                REPORT_ERROR(MSG_TOO_MANY_INITIALIZERS);
                limit = 0xFFFF;
            }
            if (braces) {
                if (TOKEN_TYPE != 6)
                    FAIL(0xE6);
                next_token();
            }
            goto array_done;
        }
        if (braces == 0) {
            if (fixed)
                FAIL(0xD8);
            initialized = 1;
            si = 0;
            while (si < limit) {
                if (!STINIT(TYPE_W(type, TYPE_TARGET), 0, mode))
                    return 0;
                if (TOKEN_TYPE != 8 && TOKEN_TYPE != 7 && TOKEN_TYPE != 6)
                    FAIL(0xCA);
                ++si;
                if (TYPE_B(type, TYPE_C_BYTE9))
                    ADVANCE_IF_SEGMENT_FULL();
                if (TOKEN_TYPE == 8 && si < limit)
                    next_token();
                if (TOKEN_TYPE == 6 || TOKEN_TYPE == 7)
                    goto array_done;
            }
            goto array_done;
        }
        si = 0;
        while (TOKEN_TYPE != 6) {
            if (si >= limit) {
                REPORT_ERROR(MSG_TOO_MANY_INITIALIZERS);
                limit = 0xFFFF;
            }
            initialized = 1;
            if (!STINIT(TYPE_W(type, TYPE_TARGET), 0, mode))
                return 0;
            if (TOKEN_TYPE != 8 && TOKEN_TYPE != 6)
                FAIL(0xCA);
            if (TYPE_B(type, TYPE_C_BYTE9))
                ADVANCE_IF_SEGMENT_FULL();
            if (TOKEN_TYPE == 8)
                next_token();
            ++si;
        }
        next_token();
array_done:
        if (initialized == 0)
            REPORT_ERROR(MSG_EXPRESSION_EXPECTED);
        if (TYPE_L(type, TYPE_C_SIZE) == 0) {
            if (fixed == 0)
                REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);
            else
                type = NEW_ARRAY_TYPE((i32)(u32)si, TYPE_W(type, TYPE_TARGET), 0);
            TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
            break;
        }
        if (TYPE_L(type, TYPE_C_SIZE) > (i32)si) {
            if (TYPE_B(type, TYPE_C_BYTE9))
                RESERVE_ARRAY_REMAINDER(type, si);
            else {
                u32 element = size_of(TYPE_W(type, TYPE_TARGET));
                reserve((u16)((u32)(TYPE_L(type, TYPE_MEMBER_CLASS) - (i32)si) * element));
            }
        }
        break;
    case 0x13:
        di = TYPE_W(type, TYPE_C_MEMBERS);
        BITFIELD_INIT_BITS = 0;
        BITFIELD_INIT_PENDING = 0;
        if (TYPE_B(type, TYPE_C_BYTE9) == 2) {
            if (MEMBER_B(di, MEMB_C_BIT_WIDTH)) {
                if (!BCC_STMT_BITFIELD_NEAR(di))
                    return 0;
            } else if (!STINIT(MEMBER_W(di, MEMB_C_TYPE), 0, mode))
                return 0;
            initialized = 1;
            if (TOKEN_TYPE != 8 && TOKEN_TYPE != 7 && TOKEN_TYPE != 6)
                FAIL(0xCA);
            si = size_of(MEMBER_W(di, MEMB_C_TYPE));
            if (braces) {
                if (TOKEN_TYPE != 6)
                    FAIL(0xE6);
                next_token();
            }
            goto struct_done;
        }
        if (braces == 0) {
            if (fixed)
                FAIL(0xD8);
            initialized = 1;
            si = 0;
            while (di) {
                if (BITFIELD_INIT_PENDING) {
                    while (MEMBER_W(di, MEMB_FLAGS) != BITFIELD_INIT_OFFSET)
                        flush_bitfields(&si);
                    if (BITFIELD_INIT_BITS == 0)
                        BITFIELD_INIT_PENDING = 0;
                }
                alignment = (i16)alignment_of(MEMBER_W(di, MEMB_C_TYPE));
                if (BCC_PACK_FLAG && alignment > 1 && si % (u16)alignment) {
                    align_output((u16)alignment);
                    si += alignment - si % (u16)alignment;
                }
                if (MEMBER_B(di, MEMB_C_BIT_WIDTH)) {
                    if (!BCC_STMT_BITFIELD_NEAR(di))
                        return 0;
                } else if (!STINIT(MEMBER_W(di, MEMB_C_TYPE), 0, mode))
                    return 0;
                if (TOKEN_TYPE != 8 && TOKEN_TYPE != 7 && TOKEN_TYPE != 6)
                    FAIL(0xCA);
                if (BITFIELD_INIT_PENDING == 0)
                    si += size_of(MEMBER_W(di, MEMB_C_TYPE));
                if (TOKEN_TYPE == 8 && MEMBER_W(di, MEMB_NEXT))
                    next_token();
                if (TOKEN_TYPE == 7 || TOKEN_TYPE == 6)
                    goto struct_done;
                di = MEMBER_W(di, MEMB_NEXT);
            }
            goto struct_done;
        }
        si = 0;
        while (TOKEN_TYPE != 6 && di) {
            initialized = 1;
            if (BITFIELD_INIT_PENDING) {
                while (MEMBER_W(di, MEMB_FLAGS) > BITFIELD_INIT_OFFSET)
                    flush_bitfields(&si);
                if (BITFIELD_INIT_BITS == 0)
                    BITFIELD_INIT_PENDING = 0;
            }
            alignment = (i16)alignment_of(MEMBER_W(di, MEMB_C_TYPE));
            if (BCC_PACK_FLAG && alignment > 1 && si % (u16)alignment) {
                align_output((u16)alignment);
                si += alignment - si % (u16)alignment;
            }
            if (MEMBER_B(di, MEMB_C_BIT_WIDTH)) {
                if (!BCC_STMT_BITFIELD_NEAR(di))
                    return 0;
            } else if (!STINIT(MEMBER_W(di, MEMB_C_TYPE), 0, mode))
                return 0;
            if (TOKEN_TYPE != 8 && TOKEN_TYPE != 6)
                FAIL(0xCA);
            if (TOKEN_TYPE == 8)
                next_token();
            if (BITFIELD_INIT_PENDING == 0)
                si += size_of(MEMBER_W(di, MEMB_C_TYPE));
            di = MEMBER_W(di, MEMB_NEXT);
        }
        if (TOKEN_TYPE != 6)
            FAIL(0x46);
        next_token();
struct_done:
        if (initialized == 0)
            REPORT_ERROR(MSG_EXPRESSION_EXPECTED);
        if (BITFIELD_INIT_PENDING) {
            while (BITFIELD_INIT_BITS) {
                BCC_STMT_OUTPUT_NEAR((u8)BITFIELD_INIT_BITS);
                BITFIELD_INIT_BITS >>= 8;
                ++si;
            }
            BITFIELD_INIT_PENDING = 0;
        }
        if (TYPE_W(type, TYPE_C_SIZE) > si)
            reserve(TYPE_W(type, TYPE_C_SIZE) - si);
        break;
    case 0x0C:
    case 0x12:
        REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
        break;
    default: {
        u16 node = PARSE_EXPRESSION(0, 2);
        if (node == 0)
            return 0;
        node = STASSIGN(node, type);
        MARK_SYMBOLS_REFERENCED(node);
        node = FOLD_EXPRESSION(node);
        EMIT_INITIALIZER_VALUE(node, mode & 2);
        TYPE_POOL_WORD6 = 0;
        TYPE_POOL_LENGTH = TYPE_POOL_LENGTH_MARK;
        if (braces) {
            if (TOKEN_TYPE != 6)
                FAIL(0xE6);
            next_token();
        }
        break;
    }
    }
    return type;
}

/* the constant value of bitfield member, masked to its width and shifted to its bit
   position, added into BITFIELD_INIT_BITS (its byte offset goes to BITFIELD_INIT_OFFSET).
   A width of 16 is stored as 0, so such a field's value is masked to 0 (kept) */
u16 BCC_STMT_BITFIELD_NEAR(u16 member)
{
    u16 si = member, braces;
    if (TOKEN_TYPE == 5) {
        braces = 1;
        next_token();
    } else
        braces = 0;
    u16 di = PARSE_EXPRESSION(0, 2);
    if (di == 0)
        return 0;
    di = FOLD_EXPRESSION(STASSIGN(di, MEMBER_W(si, MEMB_C_TYPE)));
    if (BITFIELD_INIT_PENDING == 0)
        BITFIELD_INIT_BITS = 0;
    BITFIELD_INIT_PENDING = 1;
    if (EXPR_W(di, EXPR_OP) != 2)
        REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
    u16 value = (u16)((1u << (MEMBER_B(si, MEMB_C_BIT_WIDTH) & 31)) - 1) & EXPR_W(di, EXPR_LEFT);
    BITFIELD_INIT_BITS += (u16)(value << (MEMBER_B(si, MEMB_VALUE) & 31));
    BITFIELD_INIT_OFFSET = MEMBER_W(si, MEMB_FLAGS);
    if (braces) {
        if (TOKEN_TYPE != 6) {
            REPORT_AND_SKIP(MSG_EXPECTED_230, 0);
            return 0;
        }
        next_token();
    }
    return 1;
}

/* one byte of initialised data to the data segment */
void BCC_STMT_OUTPUT_NEAR(u8 value)
{
    stream(DATA_SEGMENT_ID);
    byte_out(value);
}

/* initialises the local (auto or register) variable record.  An array or struct with a
   brace or string initializer is built as an unnamed static copy in the data segment and
   copied in at run time ("record = copy", with a size for arrays); anything else becomes
   the assignment "record = value".  Either way an expression block is appended */
void BCC_STMT_FINISH_NEAR(u16 record)
{
    u16 node, result, di;
    TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
    u16 si = CSYM_W(record, CSYM_TYPE);
    u16 oldlow = TOKEN_FILE_NODE, oldhigh = TOKEN_LINE;
    if ((TOKEN_TYPE == 5 || TOKEN_TYPE == 0x34) && (TYPE_B(si, TYPE_KIND) == 0x11 || TYPE_B(si, TYPE_KIND) == 0x13)) {
        stream(DATA_SEGMENT_ID);
        if (BCC_PACK_FLAG)
            align_output(alignment_of(si));
        u16 temporary = DECLARE_SYMBOL(0, C_FUNCTION_SCOPE, 0, 4, si, 0, 0);
        define_here(temporary);
        si = STINIT(si, 1, 1);
        if (si)
            CSYM_W(record, CSYM_TYPE) = si;
        else
            si = CSYM_W(record, CSYM_TYPE);
        CSYM_W(record, CSYM_FLAGS) |= 0x260;
        di = symbol_node(1, si, temporary, 0, 0);
        node = symbol_node(5, si, record, 0, 0);
        di = expr_node(0x12, si, node, di);
        if (TYPE_B(si, TYPE_KIND) == 0x11) {
            u16 size = size_of(si);
            node = (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(PLAIN_INT_TYPE), A32((u32)size));
            di = expr_node(0x34, si, di, node);
        }
        result = NEW_EXPRESSION_BLOCK(di, 0, 0, 0, 0);
    } else {
        if (TOKEN_TYPE == 5) {
            next_token();
            di = PARSE_EXPRESSION(0, 2);
            if (TOKEN_TYPE != 6)
                REPORT_AND_SKIP(MSG_EXPECTED_230, 0);
            else
                next_token();
        } else
            di = PARSE_EXPRESSION(0, 2);
        if (TYPE_B(si, TYPE_KIND) == 0x15)
            si = TYPE_W(si, TYPE_C_SIZE) == 1 ? mode_type(1) : PLAIN_INT_TYPE;
        node = symbol_node(5, si, record, 0, CSYM_W(record, CSYM_FLAGS));
        di = FOLD_EXPRESSION(di);
        di = BCC_STMT_CONVERT_NEAR(node, di);
        MARK_SYMBOLS_REFERENCED(di);
        result = NEW_EXPRESSION_BLOCK(di, oldlow, oldhigh, TOKEN_FILE_NODE, TOKEN_LINE);
    }
    append(result);
    TYPE_POOL_WORD6 = 0;
    TYPE_POOL_LENGTH = TYPE_POOL_LENGTH_MARK;
}

/* the assignment node "left = right" for an initialisation, converting right to left's
   type (STASSIGN); struct values must have compatible types.  Error nodes (kind
   TK_UNDEFINED) pass through */
u16 BCC_STMT_CONVERT_NEAR(u16 left, u16 right)
{
    if (EXPR_W(left, EXPR_KIND) == TK_UNDEFINED)
        return left;
    if (right && EXPR_W(right, EXPR_KIND) == TK_UNDEFINED)
        return right;
    if (EXPR_W(left, EXPR_KIND) == TK_STRUCT || EXPR_W(right, EXPR_KIND) == TK_STRUCT) {
        if (!TYPE_RECORDS_COMPATIBLE(EXPR_W(left, EXPR_TYPE), EXPR_W(right, EXPR_TYPE), 2)) {
            REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
            return STCVT8();
        }
        return expr_node(0x12, EXPR_W(left, EXPR_TYPE), left, right);
    }
    right = STASSIGN(right, EXPR_W(left, EXPR_TYPE));
    return expr_node(0x12, EXPR_W(left, EXPR_TYPE), left, right);
}
