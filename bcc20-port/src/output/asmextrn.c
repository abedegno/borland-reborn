/* asmextrn.c: from bcc20/src/output/ASMEXTRN.C (overlay CO06D): pieces of the
   assembly-text writer used when BCC writes a .asm file (-S, or -B where TASM assembles
   it), reached through the back end's hook table.  ASMSYMS.C does the same work on the C++
   symbol records; this file reads the C front end's records (CSYM_POOL_SEG).  Text goes out
   through PUT_CODE_STRING/PUT_CODE_CHAR.
   - EMIT_HEX_BYTE_LIST writes a debug record as "?debug C xx,xx,..." lines, the TASM
     directive that copies bytes into an object COMENT record.
   - EMIT_ASM_EXTERNALS walks the module's symbol records (the C_GLOBAL_SCOPE list) at the
     end of the file and writes extrn, COMM, public, publicdll and equ lines, then the
     per-function ?debug lines when -v is on.
   - EMIT_ASM_SYMBOL_NAME writes how a symbol is spelled in the assembly text.
   CSYM_CLASS values as this file uses them: 1 public, 2 external, 3 defined here and
   written under its plain name, 4 static data addressed from the d@ / b@ base labels.
   CSYM_FLAGS bits used: 80h/40h used or assigned, 400h pascal name (upper case), 800h
   communal (COMM), 2000h name written with a leading '@' (probably a C++ mangled name). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define DEBUG_STATE W(DEBUG_STATE_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_UNDERSCORES SB(OPTION_UNDERSCORES_P)
#define OPTION_MEMORY_MODEL SB(OPTION_MEMORY_MODEL_P)
/* far pointers to the type words (byte, word, dword, near, far ...) by element kind */
#define ASM_TYPE_NAME(kind) D(fp_add(ASM_TYPE_NAME_TABLE_P, (kind) * 4))

static void name_of(u16 symbol) { CALL_FAR(NAME_HOOK, A16(symbol)); }
static u8 element_kind(u16 symbol) { return (u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(symbol)); }

/* the text of symbol record symbol's name */
static farptr name_text(u16 symbol)
{
    u16 name = CSYM_W(symbol, CSYM_NAME);
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* writes the bytes of the current object record buffer (skipping its first byte, the
   COMENT attribute) as hex values after "\t?debug\tC ", 20 per line, continued with
   "+\r\n\t?debug\tC ", ending with "\r\n"; count is the record length, so count - 1 bytes
   are written (at least one).  Unless the first byte written (the comment class) is E6h,
   DEBUG_STATE is FFFFh while the bytes are written, and restored after */
void EMIT_HEX_BYTE_LIST(i16 count)
{
    u16 saved = DEBUG_STATE;
    u16 byte = OBJ_RECORD_BUFFER() + 1;
    if (B(DSPTR(byte)) != 0xE6)
        DEBUG_STATE = 0xFFFF;
    PUT_CODE_STRING(STR_DEBUG_C_P);
    i16 out_count = 0;
    for (;;) {
        EMIT_HEX_BYTE((u16)(i16)SB(DSPTR(byte)));
        out_count++;
        byte++;
        count--;
        if (count <= 1)
            break;
        if (out_count >= 20) {
            PUT_CODE_STRING(STR_DEBUG_C_2_P);
            out_count = 0;
        }
    }
    PUT_CODE_STRING(STR_CR_NL_P);
    DEBUG_STATE = saved;
}

/* the end-of-module declarations for every used or assigned symbol (flags C0h): external
   (class 2): "\textrn\tname:type" with the type word from ASM_TYPE_NAME_TABLE ("near" for
   a function placed in a segment), or a COMM declaration for a communal variable, with the
   element size and count of an array; public (class 1): "\tpublic\tname" or
   "\tpublicdll\tname" for an exported function (type flag 80h), then on purpose the
   class-3 case.  Class 3 at segment 0: "name\tequ\ts@+n", a name inside the string-literal
   block s@.  Last, a class-3 symbol whose public assembly spelling differs from its plain
   name (a pascal name with lower-case letters, or any name under -u) gets
   "public-spelling\tequ\tname"; the class byte is changed to 1 and back to 3 so NAME_HOOK
   writes both spellings */
void EMIT_ASM_EXTERNALS(void)
{
    u16 first = SCOPE_W(C_GLOBAL_SCOPE, SCOPE_TAGS);
    for (u16 symbol = first; symbol; symbol = CSYM_W(symbol, CSYM_NEXT)) {
        if (!(CSYM_W(symbol, CSYM_FLAGS) & 0xC0))
            continue;
        switch (CSYM_B(symbol, CSYM_CLASS)) {
        case 2:
            if (CSYM_W(symbol, CSYM_FLAGS) & 0x800) {
                u16 type = CSYM_W(symbol, CSYM_TYPE);
                i32 product = 1;
                while (TYPE_B(type, TYPE_KIND) == 17) {
                    product *= TYPE_L(type, TYPE_MEMBER_CLASS);
                    type = TYPE_W(type, TYPE_TARGET);
                }
                u16 far_data = CSYM_W(symbol, CSYM_SEGMENT) != BSS_SEGMENT_ID;
                u16 size = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type));
                EMIT_COMM_DECLARATION(symbol, far_data, size, (u32)product);
            } else {
                PUT_CODE_STRING(STR_EXTRN_P);
                name_of(symbol);
                PUT_CODE_CHAR(':');
                u16 number = element_kind(symbol);
                if (number == 18 && CSYM_W(symbol, CSYM_SEGMENT) != 0xFFFF)
                    PUT_CODE_STRING(STR_NEAR_3_P);
                else
                    PUT_CODE_STRING(ASM_TYPE_NAME(number));
            }
            PUT_CODE_STRING(STR_CR_NL_P);
            break;
        case 1:
            if (TYPE_B(CSYM_W(symbol, CSYM_TYPE), TYPE_KIND) == 18 &&
                (TYPE_B(CSYM_W(symbol, CSYM_TYPE), TYPE_C_FUNC_FLAGS) & 0x80))
                PUT_CODE_STRING(STR_PUBLICDLL_P);
            else
                PUT_CODE_STRING(STR_PUBLIC_2_P);
            name_of(symbol);
            PUT_CODE_STRING(STR_CR_NL_P);
            /* fall through */
        case 3:
            if (CSYM_W(symbol, CSYM_SEGMENT) == 0 && TYPE_B(CSYM_W(symbol, CSYM_TYPE), TYPE_KIND) != 18) {
                name_of(symbol);
                PUT_CODE_STRING(STR_EQU_S_P);
                EMIT_SIGNED_DECIMAL((i16)CSYM_W(symbol, CSYM_OFFSET));
                PUT_CODE_STRING(STR_CR_NL_P);
            }
            break;
        }
        if (CSYM_B(symbol, CSYM_CLASS) != 3 || CSYM_W(symbol, CSYM_SEGMENT) == 0)
            continue;
        if (CSYM_W(symbol, CSYM_FLAGS) & 0x400) {
            farptr p = name_text(symbol);
            while (SB(p) && !(CTYPE_BY_CHAR_AT(SB(p)) & 8))
                p = fp_add(p, 1);
            if (SB(p) == 0)
                continue;
        } else if (OPTION_UNDERSCORES == 0)
            continue;
        CSYM_B(symbol, CSYM_CLASS) = 1;
        name_of(symbol);
        PUT_CODE_STRING(STR_EQU_P);
        CSYM_B(symbol, CSYM_CLASS) = 3;
        name_of(symbol);
        PUT_CODE_STRING(STR_CR_NL_P);
    }
    if (OPTION_SOURCE_DEBUG)
        EMIT_ASM_FUNCTION_DEBUG(first);
}

/* with -v: writes "\t?debug\tC EA01mm" (a Turbo Debugger header comment: class EAh,
   version 01, memory model with the -u flag in bit 3), calls DEBUG_HEADER_DONE_HOOK, then
   one "\t?debug\tF name typeindex flags" line per function of class 3 in the list records.
   flags is 18h or 98h (type pointer qualifier 4) for symbols with CSYM_FLAGS bit 20h, else
   0 */
void EMIT_ASM_FUNCTION_DEBUG(u16 records)
{
    PUT_CODE_STRING(STR_DEBUG_C_P);
    EMIT_HEX_BYTE(0xEA);
    PUT_CODE_STRING(STR_01_P);
    EMIT_HEX_BYTE((u16)(OPTION_MEMORY_MODEL | (OPTION_UNDERSCORES << 3)));
    PUT_CODE_STRING(STR_CR_NL_P);
    CALL_FAR0(DEBUG_HEADER_DONE_HOOK);
    for (u16 record = records; record != 0; record = CSYM_W(record, CSYM_NEXT)) {
        if (CSYM_B(record, CSYM_CLASS) != 3)
            continue;
        u16 type = CSYM_W(record, CSYM_TYPE);
        if (TYPE_B(type, TYPE_KIND) != 0x12)
            continue;
        u8 flag = 0;
        if (CSYM_W(record, CSYM_FLAGS) & 0x20)
            flag |= TYPE_B(type, TYPE_C_PTR_QUALS) == 4 ? 0x98 : 0x18;
        PUT_CODE_STRING(STR_DEBUG_F_P);
        PUT_CODE_STRING(NAME_TEXT_COPY(CSYM_W(record, CSYM_NAME)));
        PUT_CODE_CHAR(' ');
        EMIT_DECIMAL(TYPE_W(CSYM_W(record, CSYM_TYPE), TYPE_C_DEBUG_INDEX));
        PUT_CODE_CHAR(' ');
        EMIT_DECIMAL(flag);
        PUT_CODE_STRING(STR_CR_NL_P);
    }
}

/* writes the assembly spelling of symbol record node.  Class 4: "d@+n" (in the data
   segment) or "b@+n" (BSS), with "w" before the "+" when SYMBOL_ELEMENT_KIND_HOOK gives a
   kind above 2.  Other classes: the name is copied to BCC_DEBUG_NAME; class 3 as it is; a
   pascal name (400h) in upper case; else with a leading '@' (flag 2000h) or '_' (under
   -u) */
void EMIT_ASM_SYMBOL_NAME(u16 node)
{
    if (CSYM_B(node, CSYM_CLASS) == 4) {
        if (CSYM_W(node, CSYM_SEGMENT) == DATA_SEGMENT_ID)
            PUT_CODE_STRING(STR_D_P);
        else
            PUT_CODE_STRING(STR_B_P);
        if (element_kind(node) > 2)
            PUT_CODE_CHAR('w');
        PUT_CODE_CHAR('+');
        EMIT_DECIMAL(CSYM_W(node, CSYM_OFFSET));
        return;
    }
    farptr p = STRING_COPY(BCC_DEBUG_NAME_P, name_text(node));
    if (CSYM_B(node, CSYM_CLASS) == 3)
        PUT_CODE_STRING(p);
    else if (CSYM_W(node, CSYM_FLAGS) & 0x400) {
        for (; SB(p); p = fp_add(p, 1))
            PUT_CODE_CHAR((i16)RTL_TOUPPER(SB(p)));
    } else {
        if (CSYM_W(node, CSYM_FLAGS) & 0x2000)
            PUT_CODE_CHAR('@');
        else if (OPTION_UNDERSCORES)
            PUT_CODE_CHAR('_');
        PUT_CODE_STRING(p);
    }
}
