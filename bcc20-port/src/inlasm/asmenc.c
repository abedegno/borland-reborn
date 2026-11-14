/* asmenc.c: from bcc20/src/inlasm/ASMENC.C: front-end support for asm statements in C
   compiles (the C front end's symbol records in CSYM_POOL_SEG; asmenc2.c does the same
   three jobs for C++).  The asm statement scanner (parser/asmstmt.c) rebuilds each statement
   as text; for a C name it calls ENCODE_ASM_SYMBOL through ASM_IDENTIFIER_HOOK, and for a
   '.' PARSE_ASM_MEMBER_ALT through ASM_TOKEN_2F_HOOK.  Both work on the token text in
   TOKEN_TEXT_BUFFER and leave there what goes into the statement:
   - for object output a coded name the inline assembler resolves later (DECODE_ASM_SYMBOL
     in asmopnd.c): "@S" and 4 letters (a static or global symbol record) or "@V" and 4
     letters (a variable table entry of an auto or parameter), then a size letter; each
     letter is 'a' plus one hex digit;
   - for assembly output the name as the assembler must spell it, or for a local the byte
     1Ah and 4 letters of its variable entry, which EMIT_ASM_STATEMENT (blklayot.c) later
     replaces by the name, register or [bp+n];
   - an enum constant becomes its decimal value; a member selection ".name" becomes
     "+offset".
   PARSE_ASM_JUMP_LABEL_ALT handles a jump from asm code to a C label: it makes the label
   known and adds a jump block to the function's flow graph. */
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
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define LOOP_BLOCK_WEIGHT W(LOOP_BLOCK_WEIGHT_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define TEXT(i) B(fp_add(TOKEN_TEXT_BUFFER_P, (i)))

/* hex digit s/4 of n as a letter 'a'..'p' */
static u8 letter(u32 n, int s) { return (u8)((u8)(n >> s & 15) + 'a'); }

/* the four letters of n after the given start (as "@S"/"@V"/1Ah wants them) */
static void put_letters(i16 start, u32 n)
{
    TEXT(start) = letter(n, 12);
    TEXT(start + 1) = letter(n, 8);
    TEXT(start + 2) = letter(n, 4);
    TEXT(start + 3) = letter(n, 0);
}

/* the name text of a name pool entry */
static farptr name_text(u16 name)
{
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* replaces the identifier in TOKEN_TEXT_BUFFER by its coded form (see the top), if it names
   a symbol of the current C scopes.  The symbol is marked used and assigned (CSYM_FLAGS
   C0h) and, unless flag 8 is set, 100h (probably "address taken"); its variable entry gets
   one more use and VAR_FLAGS bit 2 ("in memory"), probably so the register allocator keeps
   it out of registers.  In assembly mode a public data symbol gets the data group prefix
   ("DGROUP:") and goes on as an external, written with the linker's spelling (upper case
   for pascal, '@' for flag 2000h, '_' under -u); statics, autos and parameters become the
   1Ah marker; any other class is "Improper use of a typedef symbol".  Nothing changes for
   an unknown name */
void ENCODE_ASM_SYMBOL(void)
{
    u16 symbol = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 0x31);
    u16 record = LOOKUP_SYMBOL(symbol, C_DECL_SCOPE, 0);
    if (!record)
        return;
    CSYM_W(record, CSYM_FLAGS) |= 0xC0;
    if (!(CSYM_W(record, CSYM_FLAGS) & 8))
        CSYM_W(record, CSYM_FLAGS) |= 0x100;
    TEXT(0) = 0;
    u16 entry = FIND_OR_ADD_VARIABLE(record, 0, CSYM_B(record, CSYM_FLAGS));
    ++VAR_W(entry, VAR_USE_COUNT);
    VAR_B(entry, VAR_FLAGS) |= 4;
    if (!COMPILER_MODE) {
        switch (CSYM_B(record, CSYM_CLASS)) {
        case 1:
        case 2:
        case 3:
        case 4:
            TEXT(0) = '@';
            TEXT(1) = 'S';
            put_letters(2, record);
            TEXT(6) = (u8)((u8)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(CSYM_W(record, CSYM_TYPE))) + 'a');
            TEXT(7) = 0;
            break;
        case 5:
        case 6:
            TEXT(0) = '@';
            TEXT(1) = 'V';
            put_letters(2, entry);
            TEXT(6) = (u8)((u8)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(CSYM_W(record, CSYM_TYPE))) + 'a');
            TEXT(7) = 0;
            break;
        case 9:
            RTL_ITOA10((i16)CSYM_W(record, CSYM_OFFSET), TOKEN_TEXT_BUFFER_P);
            break;
        }
        return;
    }
    switch (CSYM_B(record, CSYM_CLASS)) {
    case 1:
        if (TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_KIND) != 18 && DATA_GROUP_NAME) {
            STRING_COPY(TOKEN_TEXT_BUFFER_P, MK_FP(STRING_POOL_SEG, DATA_GROUP_NAME));
            STRING_APPEND(TOKEN_TEXT_BUFFER_P, STR_COLON_2_P);
        }
        /* fall through: then written as an external */
    case 2: {
        farptr dest = fp_add(TOKEN_TEXT_BUFFER_P, STRING_LENGTH(TOKEN_TEXT_BUFFER_P));
        farptr p = name_text(CSYM_W(record, CSYM_NAME));
        if (CSYM_W(record, CSYM_FLAGS) & 0x400) {
            while (SB(p)) {
                B(dest) = (u8)RTL_TOUPPER(SB(p));
                dest = fp_add(dest, 1);
                p = fp_add(p, 1);
            }
            B(dest) = 0;
        } else if (CSYM_W(record, CSYM_FLAGS) & 0x2000) {
            B(dest) = '@';
            dest = fp_add(dest, 1);
            STRING_COPY(dest, p);
            STRING_LENGTH(dest);   /* the original moves dest past the name, then stops */
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
    case 4:
    case 5:
    case 6:
        TEXT(0) = 0x1A;
        put_letters(1, entry);
        TEXT(5) = 0;
        break;
    case 9:
        RTL_ITOA10((i16)CSYM_W(record, CSYM_OFFSET), TOKEN_TEXT_BUFFER_P);
        break;
    default:
        REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
    }
}

/* '.' in an asm operand: ".member" or "(type).member" (token 1 is the '('; the type must
   be a struct or union).  If the name after the dot is a member (of the given type, or in
   the C scopes), TOKEN_TEXT_BUFFER becomes "+offset" (a C member record keeps the offset in
   MEMB_FLAGS).  Otherwise the '.' goes on as an ordinary character (BCC_LEX_SPECIAL).
   Returns 1 when done, 0 at the end of the line or ';' (tokens 7Ch and 7), 2 after a syntax
   error.  Token numbers are the asm scanner's (31h a name, 74h..81h keyword classes) */
i16 PARSE_ASM_MEMBER_ALT(void)
{
    u16 node = 0;
    i16 token = SCAN_ASM_TOKEN();
    if (token == 1) {
        u16 next;
        if (TOKEN_PUSHED_BACK != 0) {
            TOKEN_PUSHED_BACK = 0;
            next = TOKEN_TYPE;
        } else
            next = (u16)LEX_NEXT_TOKEN();
        if (!TOKEN_STARTS_TYPE(next)) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            return 2;
        }
        node = PARSE_TYPE_NAME_PAREN();
        if (!node)
            return 0;
        if (TYPE_B(node, TYPE_KIND) != 19 && TYPE_B(node, TYPE_KIND) != 20) {
            REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
            node = 0;
        }
        if (TOKEN_TYPE != 49) {
            REPORT_ERROR(MSG_INVALID_USE_DOT);
            return 2;
        }
        STRING_COPY(TOKEN_TEXT_BUFFER_P, name_text(TOKEN_CONST_VALUE_LOW));
        token = 49;
    }
    switch (token) {
    case 49:
    case 116:
    case 118:
    case 119:
    case 120:
    case 121:
    case 122:
    case 123:
    case 124:
    case 125:
    case 126:
    case 127:
    case 128:
    case 129: {
        u16 first = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 49);
        u16 second = LOOKUP_MEMBER(first, C_DECL_SCOPE, node);
        if (second != 0) {
            TEXT(0) = '+';
            RTL_ITOA10((i16)MEMBER_W(second, MEMB_FLAGS), fp_add(TOKEN_TEXT_BUFFER_P, 1));
        } else
            BCC_LEX_SPECIAL('.');
        break;
    }
    default:
        BCC_LEX_SPECIAL('.');
        if (token == 124)
            return 0;
        if (token == 7)
            return 0;
    }
    return 1;
}

/* a jump in asm code to the C label named in TOKEN_TEXT_BUFFER: appends '@' to the
   statement text, finds or declares the label in the function scope (with a new code
   label), marks it used, and adds a jump block of jump kind kind (flag 100h) at the
   current line to the function's block chain */
void PARSE_ASM_JUMP_LABEL_ALT(u16 kind)
{
    BCC_LEX_SPECIAL(0x40);
    u16 name = BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER_P, 0x31);
    u16 symbol = LOOKUP_SYMBOL(name, C_FUNCTION_SCOPE, 1);
    if (symbol == 0) {
        symbol = DECLARE_SYMBOL(name, C_FUNCTION_SCOPE, 1, 3, 0, 0, 0);
        u16 label = NEW_LABEL();        /* NEW_LABEL may grow a pool: called first */
        CSYM_W(symbol, CSYM_LABEL) = label;
    }
    CSYM_W(symbol, CSYM_FLAGS) |= 0x80;
    u16 node = NEW_JUMP_BLOCK(CSYM_W(symbol, CSYM_LABEL), TOKEN_FILE_NODE, TOKEN_LINE, TOKEN_FILE_NODE, TOKEN_LINE);
    CNODE_W(node, CNODE_JUMP_KIND) = kind;
    CNODE_W(node, CNODE_FLAGS) |= 0x100;
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL, node, LOOP_BLOCK_WEIGHT);
}
