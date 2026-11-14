/* debugrec.c: from bcc20/src/output/DEBUGREC.C: Turbo Debugger information (-v) for C++
   compiles; OBJSYMS.C does the same for C.  The records are OMF COMENT records (88h) built
   with the OMFWRITE.C helpers; in assembly mode they come out as "?debug C" lines.  Comment
   classes used (the word E300h etc. passed to OBJ_PUT_WORD is a 0 attribute byte followed
   by the class): E2h struct/class members, E3h a type, E4h enum members, E5h scope start,
   E6h a list of symbols, E7h scope end, EBh external with type, ECh public with type, EDh a
   class description (bases), F8h the class of the function being compiled.
   Types: EMIT_DEBUG_TYPE writes a type once, after the types it uses, giving it the next
   debug id (TYPE_DEBUG_ID_COUNTER, read and set through GET/SET_TYPE_DEBUG_ID).  Its mode
   argument is a scope's symbol list: a class declared in another scope is only marked (bit
   15 of TAG_DEBUG_CLASS_INDEX) and written when its own scope is reached; GLOBAL_SCOPE_TAGS
   (the global tag list) means file scope.  Type codes beyond C's: 2Dh member function, 2Eh
   class, 30h based pointer, 33h member pointer, 34h/35h near/far reference.
   Symbols: E6h lists hold name, type id and a storage byte (0 static + group, segment,
   offset; 2 auto + frame offset; 4 register + register code; 5 constant + long value; 6
   typedef; 7 tag; with 8 added for a parameter).
   Whole-module walks (BCC_SYMBOL_SWEEP at the end of the object, EMIT_DEBUG_GLOBALS) visit
   every name of the name hash table (1024 buckets, chains in HASH_CHAIN_LINK_SEG, symbols
   of a name linked by word 0), and for C++ functions also each overload (word 19).  Symbol
   offsets: 2 name, 4 type, 6 flags (2 defined, 4 used, 10h member, 20h not referenced), 7
   storage class in bits 3-7 (1 public, 2 extern, 3 defined here, 4 static, 5 auto, 6
   parameter, 8 typedef, 9 enum constant, 11 tag, 14 member alias, 15 skipped), 8 storage,
   10 function flags, 12 inline access, 15 function kind, 21 virtual index. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "kind.h"

#define NAME_HASH(i) W(fp_add(NAME_HASH_TABLE_P, (i) * 2))
#define TAG(n) (SYM_B((n), 7) >> 3)
#define SYMBOL_TYPE(n) SYM_W((n), 4)
/* a word of the body record of struct type t */
#define LINK(t, n) TAG_W(TYPE_W((t), 5), (n))

/* the text of name record name */
static farptr name_text(u16 name)
{
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* appends the name of symbol item (copied through BCC_DEBUG_NAME) */
static void put_symbol_name(u16 item)
{
    OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME_P, name_text(SYM_W(item, 2))));
}

/* in C++, the next overload of function symbol item (not of a typedef), or 0 */
static int next_overload(u16 *item)
{
    return CPP_MODE && TAG(*item) != 8 && TYPE_W(SYMBOL_TYPE(*item), 0) == 0x12 &&
           (*item = SYM_W(*item, 19)) != 0;
}

/* keeps a COMENT record under about 4000 bytes: when the body is longer, writes it and
   starts a new one with the same attribute/class word value */
void TYPE_MEMCHECK(u16 value)
{
    if (OBJ_RECORD_LENGTH() > 0x0FA0) {
        OBJ_WRITE_RECORD(0x88);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(value);
    }
}

/* the end-of-module debug information for a C++ compile (under -v): the class types, the
   types of defined symbols, member aliases and enum constants, then E6h lists of the
   module's statics, the types of inline member functions (function flag bit 2, not when
   VTABLE_MODE is 3), the typedefs and integral enum constants, and the tags.  opened tells
   whether an E6h record is pending.  The loops are passes of the same name-table walk */
void BCC_SYMBOL_SWEEP(void)
{
    i16 opened = 0;
    if (CPP_MODE)
        for (i16 bucket = 0; bucket < 0x400; ++bucket)
            for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
                for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                    u16 item = root;
                    do {
                        if (TAG(item) == 11 && GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item)))
                            EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                    } while (next_overload(&item));
                }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                u16 item = root;
                do {
                    u16 kind = TAG(item);
                    if (kind == 3 || kind == 14 || kind == 9)
                        EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                } while (next_overload(&item));
            }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                u16 item = root;
                do {
                    u16 kind = SYMBOL_TYPE(item);
                    if (!SYM_W(item, 2))
                        continue;
                    if (CPP_MODE && TAG(item) == 11 && (EXPR_FLAGS_AT(TYPE_W(kind, 0)) & 0x40) && (LINK(kind, 24) & 1)) {
                        for (u16 member = LINK(kind, 2); member; member = MEMBER_W(member, 0)) {
                            if ((MEMBER_B(member, 4) & 3) != 3)
                                continue;
                            for (u16 nested = MEMBER_W(member, 6); nested; nested = SYM_W(nested, 19))
                                if (TAG(nested) == 3 && !(SYM_B(nested, 6) & 0x20) && (SYM_W(nested, 10) & 2) &&
                                    VTABLE_MODE != 3) {
                                    if (opened) {
                                        OBJ_WRITE_RECORD(0x88);
                                        opened = 0;
                                    }
                                    EMIT_DEBUG_METHOD_TYPE(nested, GLOBAL_SCOPE_TAGS);
                                    OBJ_RESET_RECORD();
                                    OBJ_PUT_WORD(0xE600);
                                    BCC_TYPE_EMIT_SPECIAL(nested);
                                    opened = 1;
                                }
                        }
                    } else if (TAG(item) == 14) {
                        if (!(MEMBER_B(SYM_W(item, 8), 4) & 0x40)) {
                            BCC_TYPE_EMIT_SPECIAL(item);
                            opened = 1;
                        }
                    } else if (TAG(item) == 3) {
                        if (TYPE_W(SYMBOL_TYPE(item), 0) == 0x12 && (SYM_B(item, 12) & 3) == 1) {
                            if ((SYM_W(item, 10) & 2) && VTABLE_MODE != 3) {
                                if (opened) {
                                    OBJ_WRITE_RECORD(0x88);
                                    opened = 0;
                                }
                                EMIT_DEBUG_METHOD_TYPE(item, GLOBAL_SCOPE_TAGS);
                                OBJ_RESET_RECORD();
                                OBJ_PUT_WORD(0xE600);
                                BCC_TYPE_EMIT_SPECIAL(item);
                                opened = 1;
                            }
                        } else if (item != STRING_LITERAL_SYMBOL && (SYM_B(item, 6) & 2)) {
                            BCC_TYPE_EMIT_SPECIAL(item);
                            opened = 1;
                        }
                    }
                } while (next_overload(&item));
            }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 item = NAME_W(chain, 0); item; item = SYM_W(item, 0)) {
                u16 kind = TAG(item);
                u16 id = GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item));
                if ((kind != 8 && kind != 9) || !SYM_W(item, 2) || !id)
                    continue;
                if (kind == 9 && !(EXPR_FLAGS_AT(TYPE_W(SYMBOL_TYPE(item), 0)) & 1))
                    continue;
                TYPE_MEMCHECK(0xE600);
                opened = 1;
                put_symbol_name(item);
                OBJ_PUT_INDEX(id);
                if (kind == 8)
                    OBJ_PUT_BYTE(6);
                else {
                    OBJ_PUT_BYTE(5);
                    OBJ_PUT_WORD((u16)SYM_L(item, SYM_STORAGE));
                    OBJ_PUT_WORD((u16)((u32)SYM_L(item, SYM_STORAGE) >> 16));
                }
            }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 item = NAME_W(chain, 0); item; item = SYM_W(item, 0)) {
                u16 kind = SYMBOL_TYPE(item);
                u16 id = GET_TYPE_DEBUG_ID(kind);
                if (TAG(item) == 11 && SYM_W(item, 2) && kind && id) {
                    TYPE_MEMCHECK(0xE600);
                    opened = 1;
                    put_symbol_name(item);
                    OBJ_PUT_INDEX(id);
                    OBJ_PUT_BYTE(7);
                }
            }
    if (opened)
        OBJ_WRITE_RECORD(0x88);
}

/* the calling-convention and far bits of a function type's debug record */
static u8 call_bits(u16 type)
{
    u16 flags = (TYPE_B(type, 11) - 1) & 3;
    if (TYPE_B(type, 12) & 1)
        flags |= 4;
    return (u8)flags;
}

/* writes the E3h record of C++ type node if it has no debug id yet (see the overview):
   index, name ("" or the tag name), size, type code and its operands.  A class with
   virtual functions or bases (tag flags 21h) gets a class index, its base classes first,
   the member list and the class code 2Eh with a description (EMIT_DEBUG_CLASS).  A struct
   without body takes void's id.  Pointers to members and based pointers take two ids.
   Scalars have fixed ids and are not written.  A class only marked in another scope
   (class index bit 15) is written now when this is its scope: the original jumps into the
   class case past the class index assignment, and so does the port */
void EMIT_DEBUG_TYPE(u16 node, u16 mode)
{
#define LINK8(n) LINK(node, (n))
    u16 count = 0, emitted = 0, name = 0;
    if (node == 0)
        return;
    if (GET_TYPE_DEBUG_ID(node)) {
        if (CPP_MODE != 0 && (EXPR_FLAGS_AT(TYPE_W(node, 0)) & 0x40) != 0 && (LINK8(8) & 0x8000) != 0)
            goto parameters;
        return;
    }
    SET_TYPE_DEBUG_ID(node, TYPE_DEBUG_ID_COUNTER++);
    switch (TYPE_W(node, 0)) {
    case 21:
        ++TYPE_DEBUG_ID_COUNTER;
        if (LINK8(6))
            name = SYM_W(LINK8(6), 2);
        EMIT_DEBUG_ENUM_MEMBERS(node);
        break;
    case 19:
    case 20:
        if (LINK8(4) == 0) {
            SET_TYPE_DEBUG_ID(node, GET_TYPE_DEBUG_ID(VOID_TYPE));
            --TYPE_DEBUG_ID_COUNTER;
            return;
        }
        if (CPP_MODE && (LINK8(24) & 0x21)) {
            LINK8(8) = DEBUG_CLASS_INDEX_NEXT++;
        parameters:
            if (mode != GLOBAL_SCOPE_TAGS) {
                u16 scope = mode;
                while (scope && LINK8(6) != scope)
                    scope = SYM_W(scope, 0);
                if (scope == 0) {
                    LINK8(8) |= 0x8000;
                    return;
                }
            }
            name = 0;
            LINK8(8) &= 0x7FFF;
            count = 0;
            for (u16 param = LINK8(12); param != 0; param = BASE_W(param, BASE_NEXT)) {
                ++count;
                EMIT_DEBUG_TYPE(BASE_W(param, BASE_TYPE), mode);
            }
        }
        if (LINK8(6))
            name = SYM_W(LINK8(6), 2);
        emitted = EMIT_DEBUG_STRUCT_MEMBERS(node, mode);
        break;
    case 17:
        EMIT_DEBUG_TYPE(TYPE_W(node, 7), mode);
        break;
    case 13:
        if (CPP_MODE && TYPE_B(node, 13) == 11) {
            ++TYPE_DEBUG_ID_COUNTER;
            EMIT_DEBUG_MEMBER_PTR_TYPE(TYPE_W(node, 7), mode);
        } else {
            if (TYPE_W(node, 9))
                ++TYPE_DEBUG_ID_COUNTER;
            EMIT_DEBUG_TYPE(TYPE_W(node, 7), mode);
        }
        break;
    case 14: case 15: case 16: case 18:
        EMIT_DEBUG_TYPE(TYPE_W(node, 7), mode);
        break;
    default:
        --TYPE_DEBUG_ID_COUNTER;
        return;
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(node));
    OBJ_PUT_NAME(name ? STRING_COPY(BCC_DEBUG_NAME_P, name_text(name)) : BCC_DEBUG_EMPTY_P);
    OBJ_PUT_WORD((u16)TYPE_SIZE(node));
    u16 target_id;
    switch (TYPE_W(node, 0)) {
    case 21:
        OBJ_PUT_BYTE(0x22);
        OBJ_PUT_BYTE(0);
        OBJ_PUT_WORD(0x8000);
        OBJ_PUT_WORD(0x7FFF);
        break;
    case 19:
    case 20:
        if (CPP_MODE && (LINK8(24) & 0x21))
            EMIT_DEBUG_CLASS(node, emitted, count);
        else
            OBJ_PUT_BYTE(TYPE_W(node, 0) == 19 ? 0x1E : 0x1F);
        break;
    case 17:
        OBJ_PUT_BYTE(0x1A);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, 7)));
        break;
    case 13: {
        u8 flags = 0x15;
        if (TYPE_W(node, 9))
            flags = 0x30;
        else if (CPP_MODE) {
            if (TYPE_B(node, 2) & 0x20)
                flags = 0x34;
            else if (TYPE_B(node, 13) == 11)
                flags = 0x33;
        }
        OBJ_PUT_BYTE(flags);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, 7)));
        if (flags == 0x30)
            OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(POOL_HASH, TYPE_W(node, TYPE_PARAMS))));
        else if (flags == 0x33)
            OBJ_PUT_INDEX(TAG_W(TYPE_W(TYPE_W(TYPE_W(node, 7), 3), 5), 8) & 0x7FFF);
        else
            OBJ_PUT_BYTE(TYPE_B(node, 13));
        break;
    }
    case 14:
        OBJ_PUT_BYTE(0x17);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, 7)));
        OBJ_PUT_BYTE(0);
        break;
    case 15:
        OBJ_PUT_BYTE(CPP_MODE && (TYPE_B(node, 2) & 0x20) ? 0x35 : 0x16);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, 7)));
        OBJ_PUT_BYTE(0);
        break;
    case 16:
        OBJ_PUT_BYTE(0x16);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, 7)));
        OBJ_PUT_BYTE(1);
        break;
    case 18:
        target_id = GET_TYPE_DEBUG_ID(TYPE_W(node, 7));
        OBJ_PUT_BYTE(0x23);
        OBJ_PUT_INDEX(target_id);
        OBJ_PUT_BYTE(call_bits(node));
        OBJ_PUT_BYTE((TYPE_B(node, 12) & 4) ? 1 : 0);
        break;
    }
    OBJ_WRITE_RECORD(0x88);
#undef LINK8
}

/* for a pointer to member function: writes the class and the function type node as a 2Dh
   member-function record (result type, calling convention, far bit, flags 9, class id, no
   virtual index); node takes two ids */
void EMIT_DEBUG_MEMBER_PTR_TYPE(u16 node, u16 mode)
{
    EMIT_DEBUG_TYPE(TYPE_W(node, TYPE_MEMBER_CLASS), mode);
    if (GET_TYPE_DEBUG_ID(node) != 0)
        return;
    EMIT_DEBUG_TYPE(TYPE_W(node, TYPE_TARGET), mode);
    SET_TYPE_DEBUG_ID(node, TYPE_DEBUG_ID_COUNTER);
    TYPE_DEBUG_ID_COUNTER += 2;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(node));
    OBJ_PUT_NAME(BCC_DEBUG_EMPTY_P);
    OBJ_PUT_WORD((u16)TYPE_SIZE(node));
    OBJ_PUT_BYTE(0x2D);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, TYPE_TARGET)));
    u16 flags = (TYPE_B(node, TYPE_CALL_CONV) - 1) & 3;
    if (TYPE_B(node, TYPE_FUNC_FLAGS) & 1)
        flags |= 4;
    OBJ_PUT_BYTE((u8)flags);
    OBJ_PUT_BYTE(9);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(node, TYPE_MEMBER_CLASS)));
    OBJ_PUT_INDEX(0);
    OBJ_WRITE_RECORD(0x88);
}

/* writes the type of function symbol node as a 2Dh member-function record: result type,
   calling convention and far bit, then flags (1 member, 8 inline, 4 when the function
   kind is 1), and for a member its class id, its virtual slot ((virtual index - 1) / 2)
   and, when not inline, its linker name.  The type takes two ids */
void EMIT_DEBUG_METHOD_TYPE(u16 node, u16 mode)
{
    u16 type = SYM_W(node, 4);
    if (GET_TYPE_DEBUG_ID(type) != 0)
        return;
    EMIT_DEBUG_TYPE(TYPE_W(type, 7), mode);
    SET_TYPE_DEBUG_ID(type, TYPE_DEBUG_ID_COUNTER);
    TYPE_DEBUG_ID_COUNTER += 2;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(type));
    OBJ_PUT_NAME(BCC_DEBUG_EMPTY_P);
    OBJ_PUT_WORD((u16)TYPE_SIZE(type));
    OBJ_PUT_BYTE(0x2D);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(TYPE_W(type, 7)));
    OBJ_PUT_BYTE(call_bits(type));
    u16 flags = 0;
    if (SYM_B(node, 6) & 0x10)
        flags |= 1;
    if ((SYM_B(node, 12) & 3) == 1 && (VTABLE_MODE != 3 || !(SYM_W(node, 10) & 2)))
        flags |= 8;
    if (SYM_W(node, 15) == 1)
        flags |= 4;
    OBJ_PUT_BYTE((u8)flags);
    if (SYM_B(node, 6) & 0x10) {
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYM_W(SYM_W(node, 0), 4)));
        u16 extra = SYM_W(node, 21) ? (u16)((SYM_W(node, 21) - 1) >> 1) : 0;
        OBJ_PUT_INDEX(extra);
        if (!(flags & 8))
            OBJ_PUT_SYMBOL_NAME(node, 0);
    }
    OBJ_WRITE_RECORD(0x88);
}

/* writes the E4h member list of enum type: name and value per enumerator, 80h on the
   last.  With TYPE_ATTRS 40h the members are member records (mangled names, the last one
   marked by MEMB_FLAGS 20h); otherwise enumerator symbols chained through word 10, with
   the value in SYM_STORAGE */
void EMIT_DEBUG_ENUM_MEMBERS(u16 type)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE400);
    u16 first = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
    if (TYPE_B(type, TYPE_ATTRS) & 0x40)
        for (u16 m = first; m; m = (MEMBER_B(m, MEMB_FLAGS) & 0x20) ? 0 : MEMBER_W(m, MEMB_NEXT)) {
            TYPE_MEMCHECK(0xE400);
            OBJ_PUT_BYTE((MEMBER_B(m, MEMB_FLAGS) & 0x20) ? 0x80 : 0);
            OBJ_PUT_NAME(MANGLE_MEMBER_NAME(m));
            OBJ_PUT_WORD(MEMBER_W(m, MEMB_VALUE));
        }
    else
        for (u16 m = first; m; m = SYM_W(m, SYM_FUNC_FLAGS)) {
            TYPE_MEMCHECK(0xE400);
            OBJ_PUT_BYTE(SYM_W(m, SYM_FUNC_FLAGS) == 0 ? 0x80 : 0);
            put_symbol_name(m);
            OBJ_PUT_WORD(SYM_W(m, SYM_STORAGE));
        }
    OBJ_WRITE_RECORD(0x88);
}

/* MEMB_VALUE of the member BCC_MEMBER_LOOKUP finds for class type value, or 0; probably
   the offset of the virtual table pointer */
u16 BCC_TYPE_PARAM0(u16 value)
{
    u16 member = BCC_MEMBER_LOOKUP(value);
    if (!member)
        return 0;
    return MEMBER_W(member, MEMB_VALUE);
}

/* ends the E3h record of a class with code 2Eh and its class index, then starts an EDh
   class description: class index, BCC_TYPE_PARAM0, flags (1 unless tag flag 20h, 2 for
   far virtual tables: huge model, OPTION_FLAG or tag flag 100h), the number of base classes
   and one word per base (its class index, bit 15 for a virtual base).  The caller writes
   the record.  The second parameter is not read */
void EMIT_DEBUG_CLASS(u16 type, u16 unused, u16 count)
{
    (void)unused;
    u16 body = TYPE_W(type, TYPE_TAG_BODY);
    OBJ_PUT_BYTE(0x2E);
    OBJ_PUT_INDEX(TAG_W(body, TAG_DEBUG_CLASS_INDEX) & 0x7FFF);
    OBJ_WRITE_RECORD(0x88);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xED00);
    OBJ_PUT_BYTE(0);
    OBJ_PUT_INDEX(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_DEBUG_CLASS_INDEX) & 0x7FFF);
    OBJ_PUT_WORD(BCC_TYPE_PARAM0(type));
    u16 flags = (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x20) ? 0 : 1;
    if (B(OPTION_MEMORY_MODEL_P) == 5 || OPTION_FLAG != 0 || (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x100) != 0)
        flags |= 2;
    OBJ_PUT_BYTE((u8)flags);
    OBJ_PUT_INDEX(count);
    for (u16 param = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        flags = TAG_W(TYPE_W(BASE_W(param, BASE_TYPE), TYPE_TAG_BODY), TAG_DEBUG_CLASS_INDEX) & 0x7FFF;
        if (BASE_B(param, BASE_VIRTUAL) != 0)
            flags |= 0x8000;
        OBJ_PUT_WORD(flags);
    }
}

/* writes the types the members of class node use, then its E2h member list, and returns
   the DEBUG_MEMBER_COUNTER value before the list.  Data members: a byte 0 (or the bit width
   for a bit field), name and type id; for a struct, gaps are written as 40h entries (new
   offset) and bit gaps as padding entries.  Member functions: 48h ordinary, 49h destructor
   (kind 4), 4Ah constructor (3), 4Bh conversion (2), 50h static, 4 added if virtual; then
   the name (mangled unless simple) and type id.  Static data: 60h, mangled name, type id.
   The list ends with C0h and the class size.  Members with MEMB_FLAGS 80h are skipped.
   The original clears bit 80h of member record 0's flags, not of a member's.  For a union
   the original reads gap without setting it (a stack word left from earlier); the port
   starts it at 0 */
u16 EMIT_DEBUG_STRUCT_MEMBERS(u16 node, u16 mode)
{
    u16 first = TAG_W(TYPE_W(node, 5), 2);
    for (u16 member = first; member; member = MEMBER_W(member, 0)) {
        if (MEMBER_B(member, 4) & 0x80)
            continue;
        switch (MEMBER_B(member, 4) & 3) {
        case 3:
            for (u16 function = MEMBER_W(member, 6); function != 0; function = SYM_W(function, 19))
                if (!(SYM_B(function, 6) & 0x20))
                    EMIT_DEBUG_METHOD_TYPE(function, mode);
            break;
        case 2:
            EMIT_DEBUG_TYPE(SYM_W(MEMBER_W(member, 6), 4), mode);
            break;
        case 0:
        case 1:
            EMIT_DEBUG_TYPE(MEMBER_W(member, 8), mode);
            break;
        }
    }
    u16 saved = DEBUG_MEMBER_COUNTER;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE200);
    MEMBER_B(0, MEMB_FLAGS) &= 0x7F;
    i16 bits = 0, gap = 0;
    u16 cursor = 0, distance = 0;
    for (u16 member = TAG_W(TYPE_W(node, 5), 2); member; member = MEMBER_W(member, 0)) {
        if (MEMBER_B(member, 4) & 0x80)
            continue;
        ++DEBUG_MEMBER_COUNTER;
        switch (MEMBER_B(member, 4) & 3) {
        case 0:
            if (TYPE_W(node, 0) == 0x13) {
                distance = MEMBER_W(member, 6) - cursor;
                gap = 0;
                if ((MEMBER_B(member, 4) & 0x40) && (MEMBER_B(member, 5) & 7) > bits) {
                    gap = (MEMBER_B(member, 5) & 7) - bits;
                    if (bits + gap >= 8) {
                        bits += gap;
                        gap = 0;
                        do {
                            ++distance;
                            bits -= 8;
                        } while (bits >= 8);
                    }
                }
                if (distance) {
                    if (distance > 1 || bits == 0) {
                        u16 offset = MEMBER_W(member, 6) - (bits > 0 ? 1 : 0);
                        OBJ_PUT_BYTE(0x40);
                        OBJ_PUT_BYTE((u8)(offset & 0xFF));
                        OBJ_PUT_BYTE((u8)(offset >> 8));
                        OBJ_PUT_BYTE(0);
                        OBJ_PUT_BYTE(0);
                        distance = 1;
                    }
                    if (bits > 0) {
                        OBJ_PUT_BYTE((u8)((distance << 3) - bits));
                        OBJ_PUT_BYTE(0);
                        OBJ_PUT_BYTE(0);
                        bits = 0;
                    }
                    cursor = MEMBER_W(member, 6);
                }
            }
            TYPE_MEMCHECK(0xE200);
            if (MEMBER_B(member, 4) & 0x40) {
                if (gap > 0) {
                    OBJ_PUT_BYTE((u8)gap);
                    OBJ_PUT_BYTE(0);
                    OBJ_PUT_BYTE(0);
                    bits += gap;
                }
                i16 width = MEMBER_B(member, 5) >> 3;
                bits += width;
                OBJ_PUT_BYTE((u8)width);
                while (bits >= 8) {
                    ++cursor;
                    bits -= 8;
                }
            } else {
                OBJ_PUT_BYTE(0);
                cursor += (u16)TYPE_SIZE(MEMBER_W(member, 8));
                bits = 0;
            }
            OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME_P, name_text(MEMBER_W(member, 2))));
            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(MEMBER_W(member, 8)));
            break;
        case 3:
            for (u16 function = MEMBER_W(member, 6); function; function = SYM_W(function, 19)) {
                u16 code = 0;
                u8 simple = !(SYM_W(function, 10) & 6);
                u16 queried = GET_TYPE_DEBUG_ID(SYM_W(function, 4));
                if (SYM_B(function, 6) & 0x20)
                    continue;
                if (SYM_W(function, 10) & 0x40)
                    code |= 0x50;
                else {
                    switch (SYM_W(function, 15)) {
                    case 2: code |= 0x4B; break;
                    case 3: code |= 0x4A; break;
                    case 4: code |= 0x49; break;
                    default: code |= 0x48; break;
                    }
                    if (SYM_W(function, 21))
                        code |= 4;
                }
                OBJ_PUT_BYTE((u8)code);
                if (simple)
                    OBJ_PUT_SYMBOL_NAME(function, 0);
                else
                    OBJ_PUT_NAME(MANGLE_SYMBOL_NAME(function));
                OBJ_PUT_INDEX(queried);
                TYPE_MEMCHECK(0xE200);
            }
            break;
        case 2:
            OBJ_PUT_BYTE(0x60);
            OBJ_PUT_NAME(MANGLE_SYMBOL_NAME(MEMBER_W(member, 6)));
            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYM_W(MEMBER_W(member, 6), 4)));
            break;
        }
    }
    u16 size = (u16)TYPE_SIZE(node);
    OBJ_PUT_BYTE(0xC0);
    OBJ_PUT_BYTE((u8)(size & 0xFF));
    OBJ_PUT_BYTE((u8)(size >> 8));
    OBJ_PUT_BYTE(0);
    OBJ_PUT_BYTE(0);
    OBJ_WRITE_RECORD(0x88);
    return saved;
}

static u16 symbol_segment(u16 handle) { return (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(handle)); }
static u16 symbol_index(u16 handle) { return (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(handle)); }

/* the group (or 0) and segment index of segment id segment */
static void put_group_and_segment(u16 segment)
{
    u16 record = FIND_SEGMENT(segment);
    OBJ_PUT_INDEX(SEGDEF_W(record, SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(record, SEGDEF_GROUP), SEGDEF_GROUP) : 0);
    OBJ_PUT_INDEX(SEGDEF_W(record, SEGDEF_INDEX));
}

/* appends one static symbol to the pending E6h list: name (without '_' prefix), type id,
   flag byte (18h/98h for functions with prepared flag 20h), group, segment, offset.
   Functions are skipped in assembly mode */
void BCC_TYPE_EMIT_SPECIAL(u16 node)
{
    u16 handle = PREPARE_SYMBOL(node);
    TYPE_MEMCHECK(0xE600);
    u8 flags = 0;
    if (TYPE_W(SYM_W(node, SYM_TYPE), TYPE_KIND) == 0x12) {
        if (SB(COMPILER_MODE_P))
            return;
        if (CSYM_W(handle, CSYM_PREP_FLAGS) & 0x20)
            flags |= TYPE_B(SYM_W(node, SYM_TYPE), TYPE_CALL_CONV) == 4 ? 0x98 : 0x18;
    }
    OBJ_PUT_SYMBOL_NAME(node, 1);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYM_W(node, SYM_TYPE)));
    OBJ_PUT_BYTE(flags);
    put_group_and_segment(symbol_segment(handle));
    OBJ_PUT_WORD(symbol_index(handle));
}

/* COMENT E5h: a scope begins at offset value of the code segment */
void EMIT_DEBUG_BEGIN_SCOPE(u16 value)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE500);
    OBJ_PUT_INDEX(W(CODE_SEGMENT_ID_P));
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* the frame offset or register of a local whose prepared symbol is handle: storage
   4 + base (a register) or 2 + base (a frame offset) */
static void put_local_storage(u16 handle, u8 base)
{
    if (GET_PREPARED_FLAGS(handle) & 8) {
        OBJ_PUT_BYTE(base | 4);
        OBJ_PUT_BYTE((u8)BCC_TOKEN_FLAG((i8)symbol_segment(handle)));
    } else {
        OBJ_PUT_BYTE(base | 2);
        OBJ_PUT_WORD(symbol_index(handle));
    }
}

/* writes the symbols of C++ scope frame as an E6h list and closes the scope with E7h (not
   in assembly mode).  frame FFFEh only closes.  Skipped: externals, defined symbols, class
   15, unused autos, bit-field aliases, non-integral constants.  For "this" in a scope with
   byte 14h set, the symbol's type is replaced by a plain pointer to the class
   (MAKE_POINTER_TYPE).  Parameters get storage 10/12 except "this" (2/4) */
void EMIT_DEBUG_SCOPE_SYMBOLS(u16 frame)
{
    if (frame == 0xFFFE) {
        if (!SB(COMPILER_MODE_P))
            EMIT_DEBUG_END_SCOPE();
        return;
    }
    for (u16 current = SCOPE_W(frame, 6); current; current = SYM_W(current, 0))
        EMIT_DEBUG_TYPE(SYM_W(current, 4), SCOPE_W(frame, 6));
    for (u16 current = SCOPE_W(frame, 4); current; current = SYM_W(current, 0)) {
        u16 type = SYM_W(current, 4);
        i16 kind = SYM_B(current, 7) >> 3;
        if (kind == 2 || kind == 3 || kind == 15)
            continue;
        if (kind == 5 && !(SYM_B(current, 6) & 7))
            continue;
        if (type == 0)
            continue;
        if (CPP_MODE && SCOPE_B(frame, 0x14) && SYM_W(current, 2) == THIS_NAME) {
            type = MAKE_POINTER_TYPE(TYPE_W(type, 7), TYPE_W(type, 0), 0);
            SYM_W(current, 4) = type;
        }
        EMIT_DEBUG_TYPE(type, SCOPE_W(frame, 6));
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    i16 count = 1;
    for (u16 current = SCOPE_W(frame, 4); current; current = SYM_W(current, 0)) {
        if (SYM_W(current, 4) == 0 || (SYM_B(current, 6) & 0x20))
            continue;
        i16 kind = SYM_B(current, 7) >> 3;
        if (kind == 2 || kind == 3 || kind == 15)
            continue;
        if (kind == 5 && !(SYM_B(current, 6) & 7))
            continue;
        if (kind == 14 && (MEMBER_B(SYM_W(current, 8), 4) & 0x40))
            continue;
        if (kind == 9 && !(EXPR_FLAGS_AT(TYPE_W(SYM_W(current, 4), 0)) & 1))
            continue;
        if (OBJ_RECORD_LENGTH() > 4000)
            count = 1;
        TYPE_MEMCHECK(0xE600);
        ++count;
        OBJ_PUT_NAME(SYM_W(current, 2) ? STRING_COPY(BCC_DEBUG_NAME_P, name_text(SYM_W(current, 2))) : BCC_DEBUG_EMPTY_P);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYM_W(current, 4)));
        switch (SYM_B(current, 7) >> 3) {
        case 4: {
            OBJ_PUT_BYTE(0);
            u16 handle = PREPARE_SYMBOL(current);
            put_group_and_segment(symbol_segment(handle));
            OBJ_PUT_WORD(symbol_index(handle));
            break;
        }
        case 9:
            OBJ_PUT_BYTE(5);
            OBJ_PUT_WORD((u16)SYM_L(current, 8));
            OBJ_PUT_WORD((u16)((u32)SYM_L(current, 8) >> 16));
            break;
        case 5:
        case 14:
            put_local_storage(PREPARE_SYMBOL(current), 0);
            break;
        case 6: {
            u16 handle = PREPARE_SYMBOL(current);
            u8 flags = (!CPP_MODE || SYM_W(current, 2) != THIS_NAME) ? 8 : 0;
            put_local_storage(handle, flags);
            break;
        }
        case 8:
            OBJ_PUT_BYTE(6);
            break;
        case 11:
            OBJ_PUT_BYTE(7);
            break;
        }
    }
    if (count > 1)
        OBJ_WRITE_RECORD(0x88);
    if (!SB(COMPILER_MODE_P))
        EMIT_DEBUG_END_SCOPE();
}

/* appends the parameters from formal list node to the E6h list, in declaration order (the
   recursion goes to the end of the list first), and returns count plus their number.  A
   float parameter without prototype gets type id 15 (probably double); "this" gets storage
   2, others 10; the frame offset comes from the parameter's symbol in the function's scope
   (BCC_TREE_LINK) */
i16 EMIT_DEBUG_PARAM_LIST(u16 node, i16 count)
{
    if (!node)
        return count;
    count = EMIT_DEBUG_PARAM_LIST(FORMAL_W(node, FORMAL_NEXT), count);
    OBJ_PUT_NAME(FORMAL_W(node, FORMAL_NAME) ? STRING_COPY(BCC_DEBUG_NAME_P, name_text(FORMAL_W(node, FORMAL_NAME)))
                                             : BCC_DEBUG_EMPTY_P);
    if (TYPE_W(FORMAL_W(node, FORMAL_TYPE), TYPE_KIND) == 9 && (TYPE_B(FORMAL_W(node, FORMAL_TYPE), TYPE_FUNC_FLAGS) & 8))
        OBJ_PUT_BYTE(15);
    else
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(FORMAL_W(node, FORMAL_TYPE)));
    OBJ_PUT_BYTE(CPP_MODE && FORMAL_W(node, FORMAL_NAME) == THIS_NAME ? 2 : 10);
    u16 handle = FIND_NAME_IN_LIST(FORMAL_W(node, FORMAL_NAME), SCOPE_W(BCC_TREE_LINK, SCOPE_NAMES));
    OBJ_PUT_WORD(symbol_index(PREPARE_SYMBOL(handle)));
    return count + 1;
}

/* debug information for the parameters of the function being compiled: an F8h record with
   the function's name when it is a member of a class (CURRENT_CLASS_TYPE), the parameter
   types, then their E6h list */
void EMIT_DEBUG_TREE_LOCALS(void)
{
    if (CURRENT_CLASS_TYPE != 0) {
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xF800);
        OBJ_PUT_SYMBOL_NAME(W(BCC_TREE_SPECIAL_P), 0);
        OBJ_WRITE_RECORD(0x88);
    }
    for (u16 formal = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_PARAMS); formal != 0; formal = FORMAL_W(formal, FORMAL_NEXT))
        EMIT_DEBUG_TYPE(FORMAL_W(formal, FORMAL_TYPE), 0);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    u16 formal = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_PARAMS);
    if (formal != 0 && EMIT_DEBUG_PARAM_LIST(formal, 1) > 1)
        OBJ_WRITE_RECORD(0x88);
}

/* COMENT E7h with the selected segment's current size: the scope ends here */
void EMIT_DEBUG_END_SCOPE(void)
{
    u16 value = SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE700);
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* the debug flag byte of function symbol item: 18h, or 98h for calling convention 4, with
   prepared flag 20h; 0 otherwise or for data */
static u8 function_flag(u16 item, u16 type)
{
    return (TYPE_W(type, 0) == 0x12 && (GET_PREPARED_FLAGS(PREPARE_SYMBOL(item)) & 0x20))
               ? (TYPE_B(type, 11) == 4 ? 0x98 : 0x18) : 0;
}

/* module-level debug records without EXTDEF/PUBDEF, probably for assembly output (TASM
   writes those): class types, EBh for used externals, ECh for publics and for defined
   symbols with prepared flag 100h, member-function types and E6h entries of statics, ECh
   records for defined static member functions, then typedefs and tags */
void EMIT_DEBUG_GLOBALS(void)
{
    if (CPP_MODE)
        for (i16 bucket = 0; bucket < 0x400; ++bucket)
            for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
                for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                    u16 item = root;
                    do {
                        if (TAG(item) == 11 && GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item)))
                            EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                    } while (next_overload(&item));
                }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                u16 item = root;
                do {
                    switch (TAG(item)) {
                    case 2:
                        if (SYM_B(item, 6) & 4) {
                            EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                            OBJ_RESET_RECORD();
                            OBJ_PUT_WORD(0xEB00);
                            OBJ_PUT_SYMBOL_NAME(item, 0);
                            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item)));
                            OBJ_WRITE_RECORD(0x88);
                        }
                        break;
                    case 3:
                        /* a defined symbol without prepared flag 100h gets only its type;
                           with the flag it falls into case 1 and gets an ECh record */
                        if (SYM_W(item, 8) == 0 || (GET_PREPARED_FLAGS(PREPARE_SYMBOL(item)) & 0x100) == 0) {
                            EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                            break;
                        }
                        /* fall through */
                    case 1:
                        EMIT_DEBUG_TYPE(SYMBOL_TYPE(item), GLOBAL_SCOPE_TAGS);
                        OBJ_RESET_RECORD();
                        OBJ_PUT_WORD(0xEC00);
                        OBJ_PUT_SYMBOL_NAME(item, 0);
                        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item)));
                        OBJ_PUT_BYTE(function_flag(item, SYMBOL_TYPE(item)));
                        OBJ_WRITE_RECORD(0x88);
                        break;
                    }
                } while (next_overload(&item));
            }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    i16 opened = 0;
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 root = NAME_W(chain, 0); root; root = SYM_W(root, 0)) {
                u16 item = root;
                do {
                    if (TAG(item) == 3) {
                        if (TYPE_W(SYMBOL_TYPE(item), 0) == 0x12 && (SYM_B(item, 12) & 3) == 1) {
                            if (SYM_W(item, 10) & 2) {
                                if (opened) {
                                    OBJ_WRITE_RECORD(0x88);
                                    opened = 0;
                                }
                                EMIT_DEBUG_METHOD_TYPE(item, GLOBAL_SCOPE_TAGS);
                                OBJ_RESET_RECORD();
                                OBJ_PUT_WORD(0xE600);
                            }
                        } else if (item != STRING_LITERAL_SYMBOL && (SYM_B(item, 6) & 2)) {
                            BCC_TYPE_EMIT_SPECIAL(item);
                            opened = 1;
                        }
                    } else if (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(SYMBOL_TYPE(item), 0)) & 0x40) &&
                               (LINK(SYMBOL_TYPE(item), 24) & 1)) {
                        for (u16 member = LINK(SYMBOL_TYPE(item), 2); member; member = MEMBER_W(member, 0)) {
                            if ((MEMBER_B(member, 4) & 3) != 3)
                                continue;
                            for (u16 nested = MEMBER_W(member, 6); nested; nested = SYM_W(nested, 19)) {
                                if (SYM_B(nested, 6) & 0x20)
                                    continue;
                                if ((SYM_B(nested, 12) & 3) == 1 && (SYM_W(nested, 10) & 2)) {
                                    if (opened) {
                                        OBJ_WRITE_RECORD(0x88);
                                        opened = 0;
                                    }
                                    EMIT_DEBUG_METHOD_TYPE(nested, GLOBAL_SCOPE_TAGS);
                                    OBJ_RESET_RECORD();
                                    OBJ_PUT_WORD(0xE600);
                                } else if ((SYM_B(nested, 12) & 3) == 0 && (SYM_B(nested, 6) & 2)) {
                                    u16 type = SYM_W(nested, 4);
                                    if (opened) {
                                        OBJ_WRITE_RECORD(0x88);
                                        opened = 0;
                                    }
                                    EMIT_DEBUG_TYPE(type, GLOBAL_SCOPE_TAGS);
                                    OBJ_RESET_RECORD();
                                    OBJ_PUT_WORD(0xEC00);
                                    OBJ_PUT_SYMBOL_NAME(nested, 0);
                                    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(type));
                                    OBJ_PUT_BYTE((GET_PREPARED_FLAGS(PREPARE_SYMBOL(nested)) & 0x20)
                                                     ? (TYPE_B(type, 11) == 4 ? 0x98 : 0x18) : 0);
                                    OBJ_WRITE_RECORD(0x88);
                                }
                            }
                        }
                    }
                } while (next_overload(&item));
            }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 item = NAME_W(chain, 0); item; item = SYM_W(item, 0)) {
                u16 id = GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item));
                if (TAG(item) == 8 && SYM_W(item, 2) && id) {
                    TYPE_MEMCHECK(0xE600);
                    opened = 1;
                    put_symbol_name(item);
                    OBJ_PUT_INDEX(id);
                    OBJ_PUT_BYTE(6);
                }
            }
    for (i16 bucket = 0; bucket < 0x400; ++bucket)
        for (u16 chain = NAME_HASH(bucket); chain; chain = HLINK_W(chain, 0))
            for (u16 item = NAME_W(chain, 0); item; item = SYM_W(item, 0)) {
                u16 id = GET_TYPE_DEBUG_ID(SYMBOL_TYPE(item));
                if (TAG(item) == 11 && SYMBOL_TYPE(item) && id && SYM_W(item, 2)) {
                    TYPE_MEMCHECK(0xE600);
                    opened = 1;
                    put_symbol_name(item);
                    OBJ_PUT_INDEX(id);
                    OBJ_PUT_BYTE(7);
                }
            }
    if (opened)
        OBJ_WRITE_RECORD(0x88);
}
