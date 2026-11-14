/* asmenc2.c: from bcc20/src/inlasm/ASMENC2.C: the C++ front end's twin of asmenc.c: the hooks
   the asm statement scanner (parser/asmstmt.c) calls for C names (ENCODE_ASM_SYMBOL_ALT,
   through ASM_IDENTIFIER_HOOK) and for '.' member selections (PARSE_ASM_MEMBER, through
   ASM_TOKEN_2F_HOOK), and the jump to a C label from asm code (PARSE_ASM_JUMP_LABEL).  They
   read the C++ symbol records (SYMBOL_POOL_SEG, scopes from CURRENT_SCOPE) and leave the
   replacement text in TOKEN_TEXT_BUFFER: "@S"/"@V" coded names for object output (decoded
   by DECODE_ASM_SYMBOL in asmopnd.c), real spellings or the 1Ah marker for assembly output,
   decimal values for enum constants, "+offset" for members.  The _ALT suffixes are the
   other way round from asmenc.c: here the encoder is the _ALT one. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define COMPILER_MODE SB(COMPILER_MODE_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_CONST_VALUE_LOW W(TOKEN_CONST_VALUE_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define NAME_HASH_TABLE_AT(i) W(fp_add(NAME_HASH_TABLE_P, 2 * (i)))
#define TEXT(i) B(fp_add(TOKEN_TEXT_BUFFER_P, (i)))

static u8 letter(u32 n, int s) { return (u8)((u8)(n >> s & 15) + 'a'); }

static farptr name_text(u16 name)
{
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* finds a data member called name for ".name" without a type: first in the struct tags of
   every scope from CURRENT_SCOPE out to (not including) the global scope, then in the type
   of every symbol of the whole name table whose name-space kind is 2 (tags) and which is
   not an enum.  Returns the member record or 0 */
u16 FIND_ASM_MEMBER(u16 name)
{
    for (u16 scope = CURRENT_SCOPE; scope != GLOBAL_SCOPE; scope = SCOPE_W(scope, SCOPE_PARENT))
        for (u16 entry = SCOPE_W(scope, SCOPE_TAGS); entry; entry = SYM_W(entry, SYM_NEXT)) {
            u16 result = FIND_MEMBER_BY_NAME(name, SYM_W(entry, SYM_TYPE));
            if (result)
                return result;
        }
    for (i16 bucket = 0; bucket < 0x400; bucket++)
        for (u16 chain = NAME_HASH_TABLE_AT(bucket); chain; chain = HLINK_W(chain, HLINK_NEXT))
            for (u16 entry = NAME_W(chain, NAME_SYMBOLS); entry; entry = SYM_W(entry, SYM_NEXT))
                if ((SYM_B(entry, SYM_STORAGE_CLASS) & 7) == 2 && TYPE_W(SYM_W(entry, SYM_TYPE), TYPE_KIND) != 0x15) {
                    u16 result = FIND_MEMBER_BY_NAME(name, SYM_W(entry, SYM_TYPE));
                    if (result)
                        return result;
                }
    return 0;
}

/* the variable entry of an auto, parameter or static for the asm statement: one more use
   and VAR_FLAGS bit 2 ("in memory") */
static u16 asm_variable(u16 node)
{
    u16 prepared = PREPARE_SYMBOL(node);    /* pascal: arguments left to right */
    u8 flags = (u8)GET_PREPARED_FLAGS(PREPARE_SYMBOL(node));
    u16 entry = FIND_OR_ADD_VARIABLE(prepared, 0, flags);
    ++VAR_W(entry, VAR_USE_COUNT);
    VAR_B(entry, VAR_FLAGS) |= 4;
    return entry;
}

/* replaces the identifier in TOKEN_TEXT_BUFFER by its coded form if it names a visible
   symbol (LOOKUP_NAME).  The symbol is marked used (SYM_FLAGS 4) and, if not a function,
   defined (2).  Object mode: "@S" and the prepared storage record for classes 1-4, "@V"
   and the variable entry for autos and parameters (5, 6), then a size letter; enum
   constants (9) give their value.  Assembly mode: publics (data with the data group
   prefix "DGROUP:") go on as externals with the linker spelling; class 3 data gets the
   group prefix too and goes on as classes 4-6, which become the 1Ah marker and the variable
   entry; other classes are "Improper use of a typedef symbol" */
void ENCODE_ASM_SYMBOL_ALT(void)
{
    u16 symbol = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 0x31);
    u16 node = LOOKUP_NAME(symbol);
    if (node == 0)
        return;
    SYM_B(node, SYM_FLAGS) |= 4;
    if (TYPE_W(SYM_W(node, SYM_TYPE), TYPE_KIND) != 0x12)
        SYM_B(node, SYM_FLAGS) |= 2;
    TEXT(0) = 0;
    farptr dest = TOKEN_TEXT_BUFFER_P;
    if (!COMPILER_MODE) {
        switch (SYM_B(node, SYM_STORAGE_CLASS) >> 3) {
        case 1:
        case 2:
        case 3:
        case 4:
            TEXT(0) = '@';
            TEXT(1) = 'S';
            TEXT(2) = letter(PREPARE_SYMBOL(node), 12);
            TEXT(3) = letter(PREPARE_SYMBOL(node), 8);
            TEXT(4) = letter(PREPARE_SYMBOL(node), 4);
            TEXT(5) = letter(PREPARE_SYMBOL(node), 0);
            TEXT(6) = (u8)((u8)TYPE_SIZE(SYM_W(node, SYM_TYPE)) + 'a');
            TEXT(7) = 0;
            break;
        case 5:
        case 6: {
            u16 entry = asm_variable(node);
            TEXT(0) = '@';
            TEXT(1) = 'V';
            TEXT(2) = letter(entry, 12);
            TEXT(3) = letter(entry, 8);
            TEXT(4) = letter(entry, 4);
            TEXT(5) = letter(entry, 0);
            TEXT(6) = (u8)((u8)TYPE_SIZE(SYM_W(node, SYM_TYPE)) + 'a');
            TEXT(7) = 0;
            break;
        }
        case 9:
            RTL_ITOA10((i16)SYM_W(node, SYM_STORAGE), TOKEN_TEXT_BUFFER_P);
            break;
        }
        return;
    }
    switch (SYM_B(node, SYM_STORAGE_CLASS) >> 3) {
    case 1:
        if (TYPE_W(SYM_W(node, SYM_TYPE), TYPE_KIND) != 0x12 && DATA_GROUP_NAME) {
            STRING_COPY(TOKEN_TEXT_BUFFER_P, MK_FP(STRING_POOL_SEG, DATA_GROUP_NAME));
            STRING_APPEND(TOKEN_TEXT_BUFFER_P, STR_COLON_P);
        }
        /* fall through: then written as an external */
    case 2: {
        dest = fp_add(TOKEN_TEXT_BUFFER_P, STRING_LENGTH(TOKEN_TEXT_BUFFER_P));
        farptr p = name_text(SYM_W(node, SYM_NAME));
        if (SYM_B(node, SYM_FLAGS) & 0x40) {
            while (SB(p)) {
                B(dest) = (u8)RTL_TOUPPER(SB(p));
                dest = fp_add(dest, 1);
                p = fp_add(p, 1);
            }
            B(dest) = 0;
        } else {
            if (OPTION_UNDERSCORES) {
                B(dest) = '_';
                dest = fp_add(dest, 1);
            }
            STRING_COPY(dest, p);
        }
        break;
    }
    case 3:
        if (TYPE_W(SYM_W(node, SYM_TYPE), TYPE_KIND) != 0x12 && DATA_GROUP_NAME) {
            STRING_COPY(dest, MK_FP(STRING_POOL_SEG, DATA_GROUP_NAME));
            STRING_APPEND(dest, STR_COLON_P);
            dest = fp_add(dest, STRING_LENGTH(dest));
        }
        /* fall through: then the marker after the prefix */
    case 4:
    case 5:
    case 6: {
        u16 entry = asm_variable(node);
        B(dest) = 0x1A;
        B(fp_add(dest, 1)) = letter(entry, 12);
        B(fp_add(dest, 2)) = letter(entry, 8);
        B(fp_add(dest, 3)) = letter(entry, 4);
        B(fp_add(dest, 4)) = letter(entry, 0);
        B(fp_add(dest, 5)) = 0;
        break;
    }
    case 9:
        RTL_ITOA10((i16)SYM_W(node, SYM_STORAGE), TOKEN_TEXT_BUFFER_P);
        break;
    default:
        REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
    }
}

/* '.' in an asm operand: ".member" or "(type).member" (the type must be a struct).  A data
   member (MEMB_FLAGS kind 0) found in the type, or by FIND_ASM_MEMBER, turns
   TOKEN_TEXT_BUFFER into "+offset" (MEMB_VALUE); otherwise the '.' goes on as an ordinary
   character.  Returns 1 when done, 0 at the end of the line or ';', 2 after an error */
i16 PARSE_ASM_MEMBER(void)
{
    u16 node = 0;
    i16 token = SCAN_ASM_TOKEN();
    if (token == 1) {
        ADVANCE_TOKEN();
        if (!TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P)) {
            REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
            return 2;
        }
        node = PARSE_TYPE_NAME(3);
        LEX_NEXT_TOKEN();
        if (!node)
            return 0;
        if (TYPE_W(node, TYPE_KIND) != 0x13) {
            REPORT_CURRENT_TOKEN(MSG_NOT_ALLOWED_TYPE);
            node = 0;
        }
        if (TOKEN_TYPE != 0x31) {
            REPORT_CURRENT_TOKEN(MSG_INVALID_USE_DOT);
            return 2;
        }
        STRING_COPY(TOKEN_TEXT_BUFFER_P, name_text(TOKEN_CONST_VALUE_LOW));
        token = 0x31;
    }
    switch (token) {
    case 0x31:
    case 0x74:
    case 0x76:
    case 0x77:
    case 0x78:
    case 0x79:
    case 0x7A:
    case 0x7B:
    case 0x7C:
    case 0x7D:
    case 0x7E:
    case 0x7F:
    case 0x80:
    case 0x81: {
        u16 name = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 0x31);
        u16 member = node == 0 ? FIND_ASM_MEMBER(name) : FIND_MEMBER_BY_NAME(name, node);
        if (member && (MEMBER_B(member, MEMB_FLAGS) & 3) == 0) {
            TEXT(0) = '+';
            RTL_ITOA10((i16)MEMBER_W(member, MEMB_VALUE), fp_add(TOKEN_TEXT_BUFFER_P, 1));
        } else
            BCC_LEX_SPECIAL('.');
        break;
    }
    default:
        BCC_LEX_SPECIAL('.');
        if (token == 0x7C)
            return 0;
        if (token == 7)
            return 0;
    }
    return 1;
}

/* a jump in asm code to the C label named in TOKEN_TEXT_BUFFER: appends '@' to the
   statement text, finds the label in LABEL_LIST_HEAD (record 0's name is set to the name
   first, as a sentinel, so the search always stops; stopping at 0 means not found) or
   creates it, and while code is being generated (NO_ERRORS_YET) adds a jump block of jump
   kind kind (flag 100h) to the function's block chain (BCC_PARSE_BUFFER) */
void PARSE_ASM_JUMP_LABEL(u16 kind)
{
    BCC_LEX_SPECIAL(0x40);
    u16 name = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 0x31);
    LABEL_W(0, LABEL_NAME) = name;
    u16 label = LABEL_LIST_HEAD;
    while (LABEL_W(label, LABEL_NAME) != name)
        label = LABEL_W(label, LABEL_NEXT);
    if (!label) {
        label = ALLOC_LABEL_RECORD();
        LABEL_W(label, LABEL_NAME) = name;
        LABEL_W(label, LABEL_BLOCK) = NEW_LABEL_IF_ENABLED();
        LABEL_W(label, LABEL_TEMPS) = 0;
        LABEL_W(label, LABEL_SERIAL_LOW) = 0;
        LABEL_W(label, LABEL_SERIAL_HIGH) = 0x7FFF;
    }
    if (NO_ERRORS_YET) {
        u16 node = NEW_JUMP_BLOCK(LABEL_W(label, LABEL_BLOCK), TOKEN_FILE_NODE, TOKEN_LINE, TOKEN_FILE_NODE, TOKEN_LINE);
        CNODE_W(node, CNODE_JUMP_KIND) = kind;
        CNODE_W(node, CNODE_FLAGS) |= 0x100;
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER, node, LOOP_NEST_FACTOR);
    }
}
