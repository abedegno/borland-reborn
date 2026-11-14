/* asmsyms.c: from bcc20/src/output/ASMSYMS.C: the C++ front end's twin of ASMEXTRN.C.  When
   BCC writes assembly text (-S, or -B for TASM), these write the end-of-module declarations
   and the symbol spellings, reading the C++ symbol records (SYMBOL_POOL_SEG).
   - DEBUG_NUMBERS writes a debug record as "?debug C xx,xx,..." lines (the same code as
     EMIT_HEX_BYTE_LIST).
   - DUMP_ALL walks every prepared storage record (GET_PREPARED_SYMBOL, 10 bytes apart) and
     DUMP_ONE writes extrn, COMM, public, publicdll and equ lines for it; with -v
     DUMP_FINISH then writes the Turbo Debugger header and one "?debug F" line per
     function.
   - C56_EMIT_NAME writes the assembly spelling of a symbol: the mangled name for C++ names,
     the upper-case name for pascal ones, "_name" under -u, "d@+n"/"b@+n" for static data
     addressed from the data or BSS base labels.
   The storage class is byte 7 >> 3 of a symbol; as used here: 1 public, 2 external, 3
   defined here, 4 static data at d@/b@, 11 a struct/class tag.  Prepared-symbol flags: 16
   initialized data (passed to the COMM writer), 64 pascal name, 128 communal (COMM), 256
   written with a leading '@'.  Symbol offsets: 0 next, 2 name, 4 type, 6 flags, 7 storage
   class, 8 storage, 10 function flags, 12 inline access, 17 linkage, 19 next overload.
   C56_STACK_EQU is "\tequ\ts@+" (an offset in the string-literal block s@, not the
   stack). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define DEBUG_STATE SW(DEBUG_STATE_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define ASM_TYPE_NAME(kind) D(fp_add(ASM_TYPE_NAME_TABLE_P, (kind) * 4))
#define NAME_HASH(i) W(fp_add(NAME_HASH_TABLE_P, (i) * 2))
#define STORAGE_CLASS(node) (SYM_B((node), 7) >> 3)

static void name_of(u16 name) { CALL_FAR(NAME_HOOK, A16(name)); }
static i16 symbol_segment(u16 name) { return (i16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(name)); }
static u16 symbol_index(u16 name) { return (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(name)); }
static u8 element_kind(u16 name) { return (u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(name)); }

/* the text of name record name */
static farptr name_text(u16 name)
{
    return MK_FP(W(DSPTR(NAME_W(name, 4))), NAME_W(name, 2));
}

/* nonzero when symbol node gets a C++ mangled name: in C++ mode, a class member (flag 16)
   or a function with C++ linkage (offset 17 equal to 1) */
i16 NEEDS_CPP_MANGLING(u16 node)
{
    return CPP_MODE &&
           ((SYM_B(node, 6) & 16) || (TYPE_W(SYM_W(node, 4), 0) == 18 && SYM_W(node, 17) == 1));
}

/* writes the current object record buffer (skipping its first byte, the COMENT attribute)
   as hex values after "\t?debug\tC ", 20 per line, continuing with "+\r\n\t?debug\tC ";
   count is the record length, so count - 1 bytes are written (at least one).  DEBUG_STATE
   is -1 while writing unless the comment class is E6h */
void DEBUG_NUMBERS(i16 count)
{
    i16 saved = DEBUG_STATE;
    u16 p = OBJ_RECORD_BUFFER() + 1;
    if (SB(DSPTR(p)) != (i8)0xE6)
        DEBUG_STATE = -1;
    PUT_CODE_STRING(DEBUG_PREFIX_P);
    i16 printed = 0;
    for (;;) {
        EMIT_HEX_BYTE((u16)(i16)SB(DSPTR(p)));
        ++printed;
        ++p;
        --count;
        if (count <= 1)
            break;
        if (printed >= 20) {
            PUT_CODE_STRING(DEBUG_MORE_P);
            printed = 0;
        }
    }
    PUT_CODE_STRING(DEBUG_SUFFIX_P);
    DEBUG_STATE = saved;
}

/* the declarations for one symbol of class 1, 2 or 3 that has storage and is used (flag
   bits 2/4) or communal: "extrn name:type" (or a COMM line with element size and count for
   arrays) for externals; "public name" or "publicdll name" (export flag 512) for publics,
   which then fall into the class-3 case; "name equ s@+n" for a non-function in segment 0;
   and, for a defined symbol whose public spelling differs from its plain name (pascal name
   with lower case, or -u on a non-mangled name), "public-spelling equ name".  The class
   byte is set to 1 and back to 3 so NAME_HOOK writes the two spellings */
void DUMP_ONE(u16 node)
{
    u8 state = STORAGE_CLASS(node);
    if (state != 2 && state != 1 && state != 3)
        return;
    if (SYM_W(node, 8) == 0)
        return;
    u16 name = PREPARE_SYMBOL(node);
    u16 flags = GET_PREPARED_FLAGS(name);
    if ((SYM_B(node, 6) & 6) == 0 && !(flags & 128))
        return;
    switch (STORAGE_CLASS(node)) {
    case 2: {
        u16 type = SYM_W(node, 4);
        if (flags & 128) {
            i32 count = 1;
            while (TYPE_W(type, 0) == 17) {
                count *= TYPE_L(type, TYPE_PARAMS);
                type = TYPE_W(type, 7);
            }
            u16 size = (u16)TYPE_SIZE(type);
            EMIT_COMM_DECLARATION(name, flags & 16, size, (u32)count);
        } else {
            PUT_CODE_STRING(C56_EXTERN_P);
            name_of(name);
            PUT_CODE_CHAR(':');
            i16 kind = element_kind(name);
            if (kind == 18 && symbol_segment(name) != -1)
                PUT_CODE_STRING(C56_NEAR_P);
            else
                PUT_CODE_STRING(ASM_TYPE_NAME(kind));
        }
        PUT_CODE_STRING(DEBUG_SUFFIX_P);
        break;
    }
    case 1:
        if (CSYM_W(name, 8) & 512)
            PUT_CODE_STRING(C56_PUBLIC_DLL_P);
        else
            PUT_CODE_STRING(C56_PUBLIC_P);
        name_of(name);
        PUT_CODE_STRING(DEBUG_SUFFIX_P);
        /* fall through */
    case 3:
        if (symbol_segment(name) != 0 || TYPE_W(SYM_W(node, 4), 0) == 18 ||
            ((SYM_B(node, 6) & 32) != 0 && !(SYM_B(node, 6) & 4)))
            break;
        name_of(name);
        PUT_CODE_STRING(C56_STACK_EQU_P);
        EMIT_SIGNED_DECIMAL((i16)symbol_index(name));
        PUT_CODE_STRING(DEBUG_SUFFIX_P);
        break;
    }
    if (STORAGE_CLASS(node) != 3 || symbol_segment(name) == 0)
        return;
    if (flags & 64) {
        farptr text = name_text(SYM_W(node, 2));
        while (SB(text) && !(CTYPE(SB(text)) & 8))
            text = fp_add(text, 1);
        if (SB(text) == 0)
            return;
    } else if (OPTION_UNDERSCORES == 0 || NEEDS_CPP_MANGLING(node))
        return;
    SYM_B(node, 7) = (SYM_B(node, 7) & 7) | 8;
    name_of(name);
    PUT_CODE_STRING(C56_EQU_P);
    SYM_B(node, 7) = (SYM_B(node, 7) & 7) | 24;
    name_of(name);
    PUT_CODE_STRING(DEBUG_SUFFIX_P);
}

/* end of module: declarations for every prepared symbol (10 bytes each, from 10 up to
   NODE_COUNT), then the -v debug lines */
void DUMP_ALL(void)
{
    for (u16 node = 10; node < NODE_COUNT; node += 10)
        DUMP_ONE(GET_PREPARED_SYMBOL(node));
    if (OPTION_SOURCE_DEBUG)
        DUMP_FINISH();
}

/* writes "\t?debug\tF name typeindex flags" for function symbol node, unless its prepared
   flags have 100h.  flags is 18h, or 98h when the function type's calling convention byte
   (offset 11) is 4, for symbols with prepared flag 20h; else 0 */
void DUMP_NODE(u16 node)
{
    u16 name = PREPARE_SYMBOL(node);
    u16 flags = GET_PREPARED_FLAGS(name);
    if (flags & 0x100)
        return;
    u8 kind = 0;
    if (flags & 0x20)
        kind = TYPE_B(SYM_W(node, 4), 11) == 4 ? 0x98 : 0x18;
    PUT_CODE_STRING(DEBUG_NODE_PREFIX_P);
    name_of(name);
    PUT_CODE_CHAR(' ');
    EMIT_DECIMAL(GET_TYPE_DEBUG_ID(SYM_W(node, 4)));
    PUT_CODE_CHAR(' ');
    EMIT_DECIMAL(kind);
    PUT_CODE_STRING(DEBUG_SUFFIX_P);
}

/* writes "\t?debug\tC EA" + version ("05" in C++, "01" in C) + memory model with the -u
   flag in bit 3, calls DEBUG_HEADER_DONE_HOOK, then walks every name of the name hash
   table (1024 buckets, chains in HASH_CHAIN_LINK_SEG, symbols of each name) and writes a
   ?debug F line for each function (class 3) and, in C++, each overload of it.  For a class
   tag (class 11) with tag flag 1, member functions (member kind 3, not flag 80h) are walked
   too and their overloads with inline kind 1 and function flag 2 are written */
void DUMP_FINISH(void)
{
    PUT_CODE_STRING(DEBUG_PREFIX_P);
    EMIT_HEX_BYTE(234);
    PUT_CODE_STRING(CPP_MODE ? C56_VERSION_EXTENDED_P : C56_VERSION_BASE_P);
    EMIT_HEX_BYTE((u16)((i16)(i8)OPTION_MEMORY_MODEL | ((i16)(i8)OPTION_UNDERSCORES << 3)));
    PUT_CODE_STRING(DEBUG_SUFFIX_P);
    CALL_FAR0(DEBUG_HEADER_DONE_HOOK);
    for (i16 bucket = 0; bucket < 1024; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 head = NAME_W(chain, 0); head; head = SYM_W(head, 0)) {
                u16 node = head;
                do {
                    switch (STORAGE_CLASS(node)) {
                    case 3:
                        if (TYPE_W(SYM_W(node, 4), 0) == 18)
                            DUMP_NODE(node);
                        break;
                    case 11: {
                        u16 type = SYM_W(node, 4);
                        if (!CPP_MODE || !(EXPR_FLAGS_AT(TYPE_W(type, 0)) & 64) ||
                            !(TAG_W(TYPE_W(type, 5), 24) & 1))
                            break;
                        for (u16 member = TAG_W(TYPE_W(type, 5), 2); member; member = MEMBER_W(member, 0)) {
                            if ((MEMBER_B(member, 4) & 3) != 3 || (MEMBER_B(member, 4) & 128) != 0)
                                continue;
                            for (u16 associated = MEMBER_W(member, 6); associated;
                                 associated = SYM_W(associated, 19))
                                if ((SYM_B(associated, 12) & 3) == 1 && (SYM_W(associated, 10) & 2))
                                    DUMP_NODE(associated);
                        }
                        break;
                    }
                    }
                } while (CPP_MODE && TYPE_W(SYM_W(node, 4), 0) == 18 && (node = SYM_W(node, 19)) != 0);
            }
}

/* writes the assembly spelling of prepared symbol name (see the overview).  Class 3 is
   written as is (after an optional '@'); class 4 as "d@+n", "b@+n", or with "w+" for kinds
   above 2; a pascal name (C56_NAME_FLAGS 64) in upper case; else '_' is added under -u
   unless the name is mangled */
void C56_EMIT_NAME(u16 name)
{
    u16 node = GET_PREPARED_SYMBOL(name);
    i16 special = NEEDS_CPP_MANGLING(node);
    farptr text = special ? MANGLE_SYMBOL_NAME(node) : STRING_COPY(BCC_DEBUG_NAME_P, name_text(SYM_W(node, 2)));
    if (GET_PREPARED_FLAGS(name) & 256)
        PUT_CODE_CHAR('@');
    if (STORAGE_CLASS(node) == 3) {
        PUT_CODE_STRING(text);
        return;
    }
    if (STORAGE_CLASS(node) == 4) {
        if (symbol_segment(name) == (i16)DATA_SEGMENT_ID)
            PUT_CODE_STRING(C56_DATA_MARK_P);
        else
            PUT_CODE_STRING(STR_BSS_BASE_LABEL_P);
        if (element_kind(name) <= 2)
            PUT_CODE_STRING(C56_PLUS_P);
        else
            PUT_CODE_STRING(C56_WORD_MARK_P);
        EMIT_DECIMAL(symbol_index(name));
        return;
    }
    if (C56_NAME_FLAGS(name) & 64) {
        for (; SB(text); text = fp_add(text, 1))
            PUT_CODE_CHAR((i16)RTL_TOUPPER(SB(text)));
        return;
    }
    if (!special && OPTION_UNDERSCORES)
        PUT_CODE_CHAR('_');
    PUT_CODE_STRING(text);
}
