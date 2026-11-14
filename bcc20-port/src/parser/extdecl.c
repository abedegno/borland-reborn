/* extdecl.c: from bcc20/src/parser/EXTDECL.C: the top level of the C++ front end's parse
   (which also compiles C when CPP_MODE is clear).  PARSE_EXTERNAL_DECLARATIONS is called
   once per compile: it initialises the parser and reads external declarations until the
   end of the input, handling extern "C" { ... } linkage blocks (C0LINKAGE and C0UNLINK
   keep a stack of CURRENT_LINKAGE), then processes deferred work and runs the end-of-file
   symbol checks.  C0DECL parses one declaration: specifiers, then each declarator,
   sending it to DECLARE_TYPEDEF, DECLARE_FUNCTION, COMPILE_FUNCTION_DEFINITION (FUNCDEF.C)
   when a body follows, or DECLARE_VARIABLE and PARSE_DECL_INITIALIZER.  The DECLARE_*
   functions serve local declarations too (STMTCPP.C).

   Storage classes are bits 3-7 of SYM_STORAGE_CLASS: 1 a global definition, 2 extern, 3
   file static (or inline function), 4 static in a block, 5 auto, 6 a function, 8 typedef,
   9 a constant whose value is known, 10 a predeclared intrinsic.  Storage-class tokens:
   82h none, 35h static, 36h extern, 37h typedef, 38h register, 39h auto, 6Bh inline, 6Eh
   overload.

   The declaration attributes (struct DeclarationAttributes: three signed bytes, storage,
   calling, qualifier) are passed by value as two words, the high word (qualifier and a
   pad byte) first (README, structure arguments).  The locals whose addresses are passed
   on live in the scratch area in the original frame's layout.  One original quirk is kept
   as far as it can be: DECLARE_VARIABLE's redeclaration path for a far array without an
   initializer passes an unset local (prepared) when automatic far data did not set it;
   here it is 0. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_POSITION D(TOKEN_POSITION_P)
#define FUNCTION_DEF_POSITION D(FUNCTION_DEF_POSITION_P)
#define OPTION_AUTO_FAR_DATA B(OPTION_AUTO_FAR_DATA_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define HEAD(n) NAME_W((n), 0)
#define LW(n) LINKSTK_W((n), 0)
#define STORAGE(r) (SYM_B((r), SYM_STORAGE_CLASS) >> 3)
#define SET_STORAGE(r, k) (SYM_B((r), SYM_STORAGE_CLASS) = (SYM_B((r), SYM_STORAGE_CLASS) & 7) | (((k) & 0x1F) << 3))

struct Attributes { i8 storage, calling, qualifier; };

static struct Attributes attributes_at(farptr p)
{
    struct Attributes a = { SB(p), SB(fp_add(p, 1)), SB(fp_add(p, 2)) };
    return a;
}

static void store_attributes(farptr p, struct Attributes a)
{
    SB(p) = a.storage;
    SB(fp_add(p, 1)) = a.calling;
    SB(fp_add(p, 2)) = a.qualifier;
}

static u16 attributes_low(struct Attributes a) { return (u8)a.storage | (u16)(u8)a.calling << 8; }

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return TOKEN_TYPE;
}

/* the hooks the back end sets */
static void set_segment(u16 prepared, u16 segment)
{
    CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(segment));
}

/* places the prepared symbol in its segment here and reserves its bytes (the size of type);
   record names it when the size is unknown, or is 0 for no report */
static void reserve_here(u16 prepared, u16 type, u16 record)
{
    u16 segment = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared));
    CALL_FAR(STREAM_HOOK, A16(segment));
    u16 alignment = (u16)CALL_FAR(TYPE_ALIGNMENT_HOOK, A16(type));
    CALL_FAR(ALIGN_OUTPUT_HOOK, A16(alignment));
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(prepared));
    u16 amount = (u16)TYPE_SIZE(type);
    if (record && amount == 0)
        REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, (i32)SYMBOL_NAME_TEXT(record), 0);
    else if (amount)
        CALL_FAR(RESERVE_BYTES_HOOK, A16(amount));
}

/* moves symbol input from the head list of its name into the current scope's name list,
   unless the current scope is the file scope; also sets its name-space kind to 1.  Used
   in C when a block-scope extern refers to a symbol found elsewhere */
void C0RELINK(u16 input)
{
    u16 record = input;
    SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 0xF8) | 1;
    if (SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES) != GLOBAL_SCOPE_NAMES) {
        u16 current = HEAD(SYM_W(record, SYM_NAME));
        u16 previous = 0;
        while (current != record) {
            previous = current;
            current = SYM_W(current, SYM_NEXT);
        }
        if (!previous)
            HEAD(SYM_W(record, SYM_NAME)) = SYM_W(record, SYM_NEXT);
        else
            SYM_W(previous, SYM_NEXT) = SYM_W(record, SYM_NEXT);
        SYM_W(record, SYM_NEXT) = SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES);
        SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES) = record;
    }
}

/* finds or creates the symbol for a declaration of name in the current scope.  token is
   the storage-class token, declaration the kind declared (6 a function, 5 a variable, 3
   or 4 a constant).  An existing symbol is reused when the redeclaration is legal, with
   the "previously declared" diagnostics; otherwise a new one is made with the storage
   class from token, declaration and scope.  *selected gets the symbol, *created 1 if new */
void C0SELECT(u16 name, u16 token, u16 declaration, farptr selected, farptr created)
{
    u16 context = SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES);
    u16 record;
    if (CPP_MODE) {
        record = FIND_NAME_IN_LIST(name, SCOPE_W(CURRENT_SCOPE, SCOPE_TAGS));
        if (record && (EXPR_FLAGS_AT(TYPE_W(SYM_W(record, SYM_TYPE), TYPE_KIND)) & 0x40) &&
            (TYPE_B(SYM_W(record, SYM_TYPE), TYPE_ATTRS) & 4) && declaration == 0)
            REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
    }
    record = FIND_NAME_IN_LIST(name, context);
    if (!CPP_MODE && !record && (declaration == 6 || token == 0x36 || (context == GLOBAL_SCOPE_NAMES && token == 0x82))) {
        record = C0FIND(name, 1);
        if (!record) {
            record = C0FIND(name, 0);
            if (record)
                C0RELINK(record);
        }
    }
    if (record) {
        i16 kind = STORAGE(record);
        if (token == 0x35) {
            if (!CPP_MODE && kind != 3 && SYM_W(record, SYM_TYPE) != 0) {
                if (NOT_ANSI_FLAG)
                    SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 0x18;
                else
                    REPORT_NAME_DIAGNOSTIC(MSG_WAS_PREVIOUSLY_138, name);
            }
        } else if ((context == GLOBAL_SCOPE_NAMES && (kind == 1 || kind == 2)) || declaration == 6 || token == 0x36) {
            if (declaration == 4 || declaration == 3) {
                declaration = 5;
                token = kind == 1 ? 0x82 : 0x36;
            }
            if (token == 0x35 && (kind == 1 || kind == 2) &&
                (CPP_MODE == 0 || (TYPE_B(SYM_W(record, SYM_TYPE), TYPE_ATTRS) & 1) == 0)) {
                REPORT_NAME_DIAGNOSTIC(MSG_DECLARED_BOTH_EXTERNAL, name);
                SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 0x18;
            }
        } else if (token != 0x39 || kind != 5 || SYM_W(record, SYM_STORAGE) != 0)
            record = 0;
    }
    if (!record) {
        B(created) = 1;
        record = BCC_TYPE_CREATE(name, declaration);
        u16 new_kind = 5;
        if (declaration == 3 || declaration == 4)
            new_kind = 9;
        else if (token == 0x35 && declaration != 6 && context != GLOBAL_SCOPE_NAMES)
            new_kind = 4;
        else if (token == 0x35 || token == 0x6B)
            new_kind = 3;
        else if (token == 0x36 || declaration == 6)
            new_kind = 2;
        else if (context == GLOBAL_SCOPE_NAMES)
            new_kind = 1;
        if (new_kind < 5)
            C0MARK(1);
        SET_STORAGE(record, new_kind);
    } else
        B(created) = 0;
    W(selected) = record;
}

/* gives function symbol record its type and storage class (3 static or inline, else 2
   extern), its pascal (flag 40h) and far (flag 80h) bits, and in C++ its inline kind,
   linkage and function kind (scope).  main gets linkage 2 and must return int (relaxed
   checks allow void) */
void SET_FUNCTION_SYMBOL_TYPE(u16 record, u16 scope, u16 type, u16 token)
{
    SYM_W(record, SYM_TYPE) = type;
    SET_STORAGE(record, (token == 0x35 || token == 0x6B) ? 3 : 2);
    if (TYPE_B(type, TYPE_CALL_CONV) == 2)
        SYM_B(record, SYM_FLAGS) |= 0x40;
    if (TYPE_B(type, TYPE_FUNC_FLAGS) & 1)
        SYM_B(record, SYM_FLAGS) |= 0x80;
    if (CPP_MODE) {
        SYM_W(record, SYM_VIRTUAL_INDEX) = 0;
        SYM_B(record, SYM_INLINE_ACCESS) = (SYM_B(record, SYM_INLINE_ACCESS) & 0xFC) | ((token == 0x6B) ? 1 : 0);
        SYM_W(record, SYM_LINKAGE) = (CURRENT_LINKAGE == 0) ? 1 : CURRENT_LINKAGE;
        SYM_W(record, SYM_FUNC_KIND) = scope;
    }
    if (SYM_W(record, SYM_NAME) == MAIN_SYMBOL && CURRENT_CLASS_TYPE == 0) {
        if (CPP_MODE)
            SYM_W(record, SYM_LINKAGE) = 2;
        if (NOT_ANSI_FLAG == 0 || TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) != TK_VOID) {
            if (!TYPES_COMPATIBLE(TYPE_W(type, TYPE_TARGET), INT_TYPE, 1))
                REPORT_CURRENT_TOKEN(MSG_MAIN_MUST_HAVE_RETURN);
        }
    }
}

/* checks a function declaration against an earlier one (previous, 0 if none).  First the
   return type (no arrays or functions, no abstract class in C++).  With no earlier
   declaration it only checks that default arguments are all at the end.  In C++ an
   earlier function goes to BCC_TYPE_MATCH, which decides between redeclaration and a new
   overload (*changed).  In C the newer prototype replaces an old-style declaration and the
   types must be compatible.  A non-function of the same name is a multiple declaration */
void MERGE_FUNCTION_DECLARATION(u16 scope, u16 type, farptr selected, u16 previous, u16 token, farptr changed)
{
    u16 old_record = previous;
    u16 marked_count = 0;
    u16 parameter = TYPE_W(type, TYPE_PARAMS);
    u8 special = (TYPE_B(type, TYPE_FUNC_FLAGS) & 8) != 0;
    u16 target_type = TYPE_W(type, TYPE_TARGET);
    if (TYPE_W(target_type, TYPE_KIND) == TK_ARRAY || TYPE_W(target_type, TYPE_KIND) == TK_FUNCTION)
        REPORT_CURRENT_TOKEN(MSG_FUNCTIONS_CANNOT);
    else if (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(target_type, TYPE_KIND)) & 0x40) &&
             (TAG_W(TYPE_W(target_type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x80))
        REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE, CLASS_NAME_OF_TYPE(target_type), 0);

    if (old_record &&
        ((SYM_W(W(selected), SYM_TYPE) != 0 && TYPE_W(SYM_W(W(selected), SYM_TYPE), TYPE_KIND) != TK_FUNCTION) ||
         STORAGE(W(selected)) == 8)) {
        u16 entry = ALLOC_SYMBOL_ENTRY(SYM_W(W(selected), SYM_NAME), 6);
        W(selected) = entry;
    }
    if (W(selected) != old_record)
        SET_FUNCTION_SYMBOL_TYPE(W(selected), scope, type, token);
    if (CPP_MODE && SYM_W(W(selected), SYM_FUNC_KIND) != 0)
        BCC_TYPE_VALIDATE(W(selected), type);

    if (old_record == 0) {
        B(changed) = 0;
        while (parameter != 0) {
            if (FORMAL_W(parameter, FORMAL_DEFAULT_ARG) != 0)
                ++marked_count;
            else if (marked_count != 0) {
                REPORT_CURRENT_TOKEN(MSG_DEFAULT_VALUE_MISSING);
                return;
            }
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        }
        return;
    }
    u16 previous_type = SYM_W(old_record, SYM_TYPE);
    if (old_record == EMIT_INTRINSIC_SYMBOL) {
        B(changed) = 0;
        return;
    }
    if (previous_type == 0 && STORAGE(old_record) == 0x0A) {
        SYM_W(old_record, SYM_TYPE) = type;
        B(changed) = 0;
        return;
    }
    if (TYPE_W(previous_type, TYPE_KIND) == TK_FUNCTION) {
        if (CPP_MODE) {
            BCC_TYPE_MATCH(old_record, type, CURRENT_LINKAGE, selected, changed);
            return;
        }
        B(changed) = 0;
        if (!special && !(SYM_B(old_record, SYM_FLAGS) & 2) && CURRENT_SCOPE == GLOBAL_SCOPE)
            SYM_W(old_record, SYM_TYPE) = type;
        if (!TYPES_COMPATIBLE(type, previous_type, 0))
            REPORT_NAME_DIAGNOSTIC(MSG_TYPE_MISMATCH, SYM_W(old_record, SYM_NAME));
        return;
    }
    REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, SYM_W(old_record, SYM_NAME));
}

/* declares function name with type (no body).  The storage class must be extern, static
   or inline (none and overload mean extern).  In C++ a declaration with another signature
   becomes a new overload chained through SYM_NEXT_OVERLOAD.  *result gets the symbol,
   *created 1 if it is new */
void DECLARE_FUNCTION(u16 type, u16 name, u16 scope, u16 token, farptr result, farptr created)
{
    /* the original frame from BP-6: record, changed at 3 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr record = v, changed = fp_add(v, 3);
    UNSET_BYTES(changed, 1);    /* BCC_TYPE_MATCH may read it before anything sets it */
    if (token == 0x82 || token == 0x6E)
        token = 0x36;
    if (token != 0x36 && token != 0x35 && token != 0x6B)
        REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_131, TOKEN_NAMES_AT(token));
    C0SELECT(name, token, 6, record, created);
    u16 previous = B(created) ? 0 : W(record);
    MERGE_FUNCTION_DECLARATION(scope, type, record, previous, token, changed);
    if (CPP_MODE) {
        if (SYM_W(W(record), SYM_TYPE) == 0) {
            SET_FUNCTION_SYMBOL_TYPE(W(record), scope, type, token);
            B(changed) = 1;
        } else if (B(changed)) {
            W(record) = ALLOC_SYMBOL_ENTRY(name, 6);
            SET_FUNCTION_SYMBOL_TYPE(W(record), scope, type, token);
            SYM_W(W(record), SYM_NEXT_OVERLOAD) = SYM_W(previous, SYM_NEXT_OVERLOAD);
            SYM_W(previous, SYM_NEXT_OVERLOAD) = W(record);
        }
    }
    SYM_W(W(record), SYM_FUNC_FLAGS) |= 0x80;
    W(result) = W(record);
    scratch_release(mark);
}

/* declares typedef name for type in the current scope (storage class 8).  An unnamed
   struct takes the typedef name as its own in C++.  A typedef repeating an identical
   earlier one is accepted.  The declaration attributes are kept in the symbol's storage
   word, except for pointer types */
void DECLARE_TYPEDEF(u16 type, u8 qualifier, u16 low, u16 name)
{
    struct Attributes attributes = { (i8)low, (i8)(low >> 8), (i8)qualifier };
    u16 record = FIND_NAME_IN_LIST(name, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    if (CPP_MODE && record == 0)
        record = FIND_NAME_IN_LIST(name, SCOPE_W(CURRENT_SCOPE, SCOPE_TAGS));
    if (record == 0) {
        record = BCC_TYPE_CREATE(name, 1);
        SYM_W(record, SYM_TYPE) = type;
        SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 0x40;
        if (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) &&
            SYM_W(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0)
            SYM_W(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) = name;
    } else if ((STORAGE(record) != 8 && (STORAGE(record) != 11 || !CPP_MODE)) ||
               !TYPES_COMPATIBLE(SYM_W(record, SYM_TYPE), type, 0))
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
    store_attributes(MK_FP(SYMBOL_POOL_SEG, record + SYM_STORAGE),
                     (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) ? attributes_at(EXPR_TEMP2_P) : attributes);
}

/* turns a tentative definition into an extern-like symbol whose storage is placed later
   (storage class 2, prepared flag 80h), with far data flags for a far array.
   DECLARE_VARIABLE uses it for Windows programs */
void C0FINAL(u16 input)
{
    u16 record = input;
    SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 0x10;
    u16 prepared = PREPARE_SYMBOL(record);
    SET_PREPARED_FLAGS(prepared, 0x80);
    if (TYPE_W(SYM_W(record, SYM_TYPE), TYPE_KIND) == TK_ARRAY && (TYPE_B(SYM_W(record, SYM_TYPE), TYPE_ATTRS) & 0x40)) {
        SET_PREPARED_FLAGS(prepared, 0x10);
        CLEAR_PREPARED_FLAGS(prepared, 4);
        SYM_B(record, SYM_FLAGS) |= 0x80;
    }
}

/* a far array's huge data segments */
static void huge_segments(u16 record, u16 type)
{
    u16 prepared = PREPARE_SYMBOL(record);
    u16 segment = DEFINE_HUGE_DATA_SEGMENTS(type);
    set_segment(prepared, segment);
}

static u16 far_segment_of(u16 record)
{
    u16 prepared = PREPARE_SYMBOL(record);
    u16 segment = DEFINE_FAR_SEGMENT();
    set_segment(prepared, segment);
    return prepared;
}

/* declares variable name of type input.  token is the storage-class token, defining
   nonzero when an initializer follows, the attributes the declaration modifiers.  Returns
   the symbol.  A C++ const object without storage class becomes static (and, when
   initialised, a constant symbol of class 9); incomplete types are reported; C0SELECT
   finds or creates the symbol; a new symbol gets its flags (register, defined, far data
   when far is asked for, the data and BSS groups differ, or the object is large and
   automatic far data is on); in C++ a global declared without initializer reserves its
   storage at once (statics inside functions likewise); a redeclaration must have a
   compatible type and may move the object between near and far data */
u16 DECLARE_VARIABLE(u16 input, u16 name, u16 token, u8 defining, u8 qualifier, u16 low)
{
    struct Attributes attributes = { (i8)low, (i8)(low >> 8), (i8)qualifier };
    /* the original frame from BP-6: record, created at 5 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr record_p = v, created = fp_add(v, 5);
    u16 type = input;
    u16 requested_kind = 5;
    u16 prepared = 0, temporary, amount, record;
    (void)amount;
    if (CPP_MODE && (TYPE_B(type, TYPE_ATTRS) & 1) && (token == 0x82 || token == 0x35)) {
        token = 0x35;
        if (defining) {
            if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 1)
                requested_kind = 3;
            else if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 2)
                requested_kind = 4;
        } else
            REPORT_CURRENT_TOKEN(MSG_OBJECT_MUST);
    }
    if (TYPE_SIZE(type) == 0) {
        temporary = TYPE_W(type, TYPE_KIND) == TK_ARRAY ? TYPE_W(type, TYPE_TARGET) : type;
        if (TYPE_SIZE(temporary) == 0) {
            while (TYPE_W(temporary, TYPE_KIND) == TK_ARRAY)
                temporary = TYPE_W(temporary, TYPE_TARGET);
            if ((EXPR_FLAGS_AT(TYPE_W(temporary, TYPE_KIND)) & 0x40) && TYPE_SIZE(temporary) == 0) {
                if (token != 0x36)
                    REPORT_NAME_DIAGNOSTIC(MSG_UNDEFINED_STRUCTURE, SYM_W(TAG_W(TYPE_W(temporary, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME));
            } else
                REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, name);
        }
    }
    if (CPP_MODE && (TYPE_B(type, TYPE_ATTRS) & 4)) {
        temporary = type;
        while (TYPE_W(temporary, TYPE_KIND) == TK_ARRAY)
            temporary = TYPE_W(temporary, TYPE_TARGET);
        if (TAG_W(TYPE_W(temporary, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x80)
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE, FORMAT_TYPE(temporary), 0);
    }
    C0SELECT(name, token, requested_kind, record_p, created);
    record = W(record_p);
    if (requested_kind != 5 && STORAGE(record) == 9) {
        if (!B(created))
            REPORT_NAME_DIAGNOSTIC(MSG_VARIABLE_INITIALIZED, name);
        scratch_release(mark);
        return record;
    }
    u16 kind = STORAGE(record);
    if (B(created) != 0) {
        SYM_W(record, SYM_TYPE) = type;
        if ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20) && !defining && kind != 2)
            REPORT_CURRENT_TOKEN(MSG_OBJECT_MUST);
        if (defining && kind == 2 && CURRENT_SCOPE == GLOBAL_SCOPE) {
            SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 8;
            kind = 1;
        }
        if (token == 0x38)
            SYM_B(record, SYM_FLAGS) |= 8;
        if (kind == 3 || kind == 1)
            SYM_B(record, SYM_FLAGS) |= 2;
        if (defining)
            SYM_B(record, SYM_FLAGS) |= 3;
        if ((attributes.storage == 2 || (attributes.storage == 0 && OPTION_CALLING_CONVENTION == 1)) && (kind == 1 || kind == 2))
            SYM_B(record, SYM_FLAGS) |= 0x40;
        if (attributes.calling == 8)
            SYM_B(record, SYM_FLAGS) |= 8;
        else if (attributes.calling == 9 || DATA_BSS_GROUPS_DIFFER != 0 ||
                 ((kind == 2 || (kind == 1 && TYPE_SIZE(type) >= (i32)FAR_DATA_THRESHOLD)) &&
                  ((MODEL_FAR_DATA && OPTION_AUTO_FAR_DATA) || OPTION_MEMORY_MODEL == 5))) {
            if (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) &&
                (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x108) == 0)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            SYM_B(record, SYM_FLAGS) |= 0x80;
        }
        if (!defining && CPP_MODE && token == 0x82) {
            if (TYPE_W(type, TYPE_KIND) == TK_ARRAY && TYPE_SIZE(type) == 0)
                REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, name);
            if (OPTION_WINDOWS_MODE)
                C0FINAL(record);
            else if (TYPE_W(type, TYPE_KIND) == TK_ARRAY && (TYPE_B(type, TYPE_ATTRS) & 0x40)) {
                SYM_B(record, SYM_FLAGS) |= 0x80;
                huge_segments(record, type);
                EMIT_HUGE_DATA(record);
            } else
                reserve_here(PREPARE_SYMBOL(record), type, 0);
            SYM_B(record, SYM_FLAGS) |= 3;
        }
        if (kind == 5) {
            if (attributes.storage | attributes.calling | attributes.qualifier)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            u16 previous_type = SYM_W(record, SYM_TYPE);
            /* a dead computation in the original: previous_type is never used */
            if (CPP_MODE &&
                !((EXPR_FLAGS_AT(TYPE_W(previous_type, TYPE_KIND)) & 0x14) && TYPE_W(TYPE_W(previous_type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) &&
                TYPE_W(previous_type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(previous_type, TYPE_PTR_MODE) == 0x0B)
                previous_type = MEMBER_PTR_CLASS_TYPE;
            (void)previous_type;
            if (TYPE_SIZE(type) != 0)
                REGISTER_SYMBOL_VARIABLE(record);
        } else if (kind == 2 || kind == 1) {
        } else if (kind == 3 || kind == 4) {
            if (TYPE_W(type, TYPE_KIND) == TK_ARRAY && (TYPE_B(type, TYPE_ATTRS) & 0x40)) {
                SYM_B(record, SYM_FLAGS) |= 0x80;
                huge_segments(record, type);
                if (CURRENT_SCOPE != GLOBAL_SCOPE && !defining)
                    EMIT_HUGE_DATA(record);
            } else {
                if (attributes.calling == 9 ||
                    ((OPTION_MEMORY_MODEL == 5 || DATA_BSS_GROUPS_DIFFER != 0) && !defining && attributes.calling != 8))
                    SYM_B(record, SYM_FLAGS) |= 0x80;
                prepared = PREPARE_SYMBOL(record);
                if (attributes.calling == 9)
                    set_segment(prepared, DEFINE_FAR_SEGMENT());
                if (CURRENT_SCOPE != GLOBAL_SCOPE && !defining)
                    reserve_here(prepared, type, record);
            }
        }
    } else {
        if (!TYPES_COMPATIBLE(SYM_W(record, SYM_TYPE), type, 0))
            REPORT_NAME_DIAGNOSTIC(MSG_TYPE_MISMATCH, name);
        if (defining || token == 0x82) {
            SYM_B(record, SYM_FLAGS) |= 6;
            if (kind == 2)
                SYM_B(record, SYM_STORAGE_CLASS) = (SYM_B(record, SYM_STORAGE_CLASS) & 7) | 8;
            if (OPTION_AUTO_FAR_DATA) {
                if (TYPE_SIZE(type) >= (i32)FAR_DATA_THRESHOLD) {
                    if (!(SYM_B(record, SYM_FLAGS) & 0x88)) {
                        SYM_B(record, SYM_FLAGS) |= 0x80;
                        if (SYM_W(record, SYM_STORAGE) != 0) {
                            prepared = far_segment_of(record);
                            CLEAR_PREPARED_FLAGS(prepared, 4);
                            SET_PREPARED_FLAGS(prepared, 0x10);
                        }
                    }
                } else if (SYM_B(record, SYM_FLAGS) & 0x80) {
                    SYM_B(record, SYM_FLAGS) &= 0x7F;
                    if (SYM_W(record, SYM_STORAGE) != 0) {
                        prepared = PREPARE_SYMBOL(record);
                        set_segment(prepared, DATA_SEGMENT_ID);
                        CLEAR_PREPARED_FLAGS(prepared, 0x10);
                        SET_PREPARED_FLAGS(prepared, 4);
                    }
                }
            }
            if (defining || CPP_MODE) {
                if ((SYM_B(record, SYM_FLAGS) & 1) && kind != 5 && kind != 4)
                    REPORT_NAME_DIAGNOSTIC(MSG_VARIABLE_INITIALIZED, name);
                if (!defining) {
                    if (OPTION_WINDOWS_MODE)
                        C0FINAL(record);
                    else if (TYPE_W(type, TYPE_KIND) == TK_ARRAY && (TYPE_B(type, TYPE_ATTRS) & 0x40)) {
                        SYM_B(record, SYM_FLAGS) |= 0x80;
                        set_segment(prepared, DEFINE_HUGE_DATA_SEGMENTS(type));
                        EMIT_HUGE_DATA(record);
                    } else {
                        prepared = PREPARE_SYMBOL(record);
                        set_segment(prepared, (SYM_B(record, SYM_FLAGS) & 0x80) ? DEFINE_FAR_SEGMENT() : BSS_SEGMENT_ID);
                        reserve_here(prepared, type, record);
                    }
                } else if (SYM_B(record, SYM_FLAGS) & 0x80)
                    far_segment_of(record);
                else if (kind != 5) {
                    u16 p = PREPARE_SYMBOL(record);
                    set_segment(p, DATA_SEGMENT_ID);
                }
                SYM_B(record, SYM_FLAGS) |= 1;
            }
        }
        if (TYPE_SIZE(SYM_W(record, SYM_TYPE)) == 0)
            SYM_W(record, SYM_TYPE) = type;
    }
    scratch_release(mark);
    return record;
}

/* the initializer of variable record of type: a constant (class 9) through
   PARSE_CONST_INITIALIZER, a reference through INIT_REFERENCE, a class object needing
   construction (defining) through INIT_CLASS_OBJECT, a scalar written "x(value)" or "=
   value" through PARSE_SCALAR_INITIALIZER, aggregates through INIT_DECLARATOR */
void PARSE_DECL_INITIALIZER(u8 defining, u16 type, u16 record)
{
    u16 current_type = type, current_record = record;
    if (STORAGE(current_record) == 9) {
        REQUIRE_TOKEN_BODY(0x0B, 0xC5);
        PARSE_CONST_INITIALIZER(current_record, current_type);
    } else if ((EXPR_FLAGS_AT(TYPE_W(current_type, TYPE_KIND)) & 0x14) && (TYPE_B(current_type, TYPE_ATTRS) & 0x20))
        INIT_REFERENCE(current_record, current_type);
    else if (defining)
        INIT_CLASS_OBJECT(current_record, current_type);
    else {
        if (CURRENT_TOKEN == TOK_LPAREN && (EXPR_FLAGS_AT(TYPE_W(current_type, TYPE_KIND)) & 7)) {
            PARSE_SCALAR_INITIALIZER(current_record, current_type);
            return;
        }
        REQUIRE_TOKEN_BODY(0x0B, 0xC5);
        if ((EXPR_FLAGS_AT(TYPE_W(current_type, TYPE_KIND)) & 7) ||
            (CPP_MODE && TYPE_W(current_type, TYPE_KIND) != TK_ARRAY && CURRENT_TOKEN != TOK_LBRACE))
            PARSE_SCALAR_INITIALIZER(current_record, current_type);
        else {
            u8 incomplete = TYPE_W(current_type, TYPE_KIND) == TK_ARRAY && TYPE_SIZE(current_type) == 0 &&
                !(SYM_B(current_record, SYM_FLAGS) & 0x88);
            INIT_DECLARATOR(current_record, current_type);
            if (incomplete != 0 && OPTION_AUTO_FAR_DATA && TYPE_SIZE(current_type) >= (i32)FAR_DATA_THRESHOLD)
                REPORT_DIAGNOSTIC(MSG_ARRAY_VARIABLE_NEAR, (i32)FORMAT_SYMBOL(current_record), 0);
        }
    }
}

/* one external declaration (or an asm statement at file level).  A declaration without
   declarators ("struct S { ... };") goes to BCC_TYPE_RELATION in C++, and in C must at
   least name a tag.  The position of each declarator is saved first, because a function
   definition needs the line where it started.  Errors set IN_ERROR_RECOVERY and skip to a
   synchronising token */
void C0DECL(void)
{
    /* the original frame from BP-28h (offsets in the block are 28h less the BP offset) */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x28);
    farptr virtual_flag = fp_add(v, 0x08), friend_flag = fp_add(v, 0x09), extra = fp_add(v, 0x0A);
    farptr current = fp_add(v, 0x0E), attributes = fp_add(v, 0x12), created = fp_add(v, 0x16);
    farptr specified = fp_add(v, 0x19), record = fp_add(v, 0x1A), context = fp_add(v, 0x1C);
    farptr scope = fp_add(v, 0x1E), name = fp_add(v, 0x20), base = fp_add(v, 0x22);
    farptr type = fp_add(v, 0x24), token = fp_add(v, 0x26);
    u16 saved_context = CURRENT_CLASS_TYPE;
    if (CURRENT_TOKEN == TOK_ASM) {
        PARSE_ASM_STATEMENT();
        TOKEN_TYPE = 0x82;
        ADVANCE_TOKEN();
        goto done;
    }
    if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x18)) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        IN_ERROR_RECOVERY = 1;
        ADVANCE_TOKEN();
        SKIP_TO_SYNC_TOKEN(TOK_EXTERN);
        goto done;
    }
    IN_ERROR_RECOVERY = 0;
    W(token) = 0x82;
    W(type) = 0;
    store_attributes(attributes, attributes_at(EXPR_TEMP2_P));
    if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P)) {
        if (CURRENT_TOKEN != TOK_IDENT || peek_kind() != 0x67) {
            PARSE_DECL_SPECIFIERS(0, token, friend_flag, virtual_flag, type, attributes, specified);
            if (B(friend_flag) || B(virtual_flag) || W(token) == 0x39 || W(token) == 0x38)
                /* DS:0702 and DS:0709 are the strings "friend" and "virtual" */
                REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,
                                  (i32)(B(friend_flag) ? DSPTR(0x702) : B(virtual_flag) ? DSPTR(0x709) : NAME_TEXT_COPY(TOKEN_NAMES_AT(W(token)))), 0);
        }
    }
    u8 implicit = W(type) == 0;
    if (implicit)
        W(type) = INT_TYPE;
    if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) && TYPE_W(W(type), TYPE_KIND) != TK_ENUM) {
        if (CPP_MODE)
            BCC_TYPE_RELATION(W(type), W(token));
        else if (EXPR_FLAGS_AT(TYPE_W(W(type), TYPE_KIND)) & 0x40) {
            if (SYM_W(TAG_W(TYPE_W(W(type), TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0)
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT_352);
        } else
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
        REQUIRE_TOKEN_BODY(7, 0x1F);
    } else {
        u16 count = 0;
        while (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) {
            store_attributes(current, attributes_at(attributes));
            u16 saved_token_line = CURRENT_TOKEN_LINE;
            u16 saved_token_file = CURRENT_TOKEN_FILE;
            u32 position = TOKEN_POSITION;
            ++count;
            PARSE_DECLARATOR(W(type), 0, base, name, scope, context, current, extra);
            if (W(name) == 0) {
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                goto next;
            }
            if (W(token) == 0x37) {
                if (implicit)
                    REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
                if (W(context))
                    REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE, W(name));
                if (W(scope)) {
                    REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                    goto next;
                }
                struct Attributes a = attributes_at(current);
                DECLARE_TYPEDEF(W(base), (u8)a.qualifier, attributes_low(a), W(name));
                goto next;
            }
            if (TYPE_W(W(base), TYPE_KIND) == TK_FUNCTION) {
                if (CURRENT_TOKEN == TOK_COMMA || CURRENT_TOKEN == TOK_SEMICOLON) {
                    if (TYPE_B(W(base), TYPE_ATTRS) & 0x40) {
                        REPORT_CURRENT_TOKEN(MSG_PARAMETER_NAMES_ARE);
                        goto next;
                    }
                    if (W(context)) {
                        REPORT_NAME_DIAGNOSTIC(MSG_CLASS_MEMBER_DECLARED, W(name));
                        goto next;
                    }
                    DECLARE_FUNCTION(W(base), W(name), W(scope), W(token), record, created);
                    goto next;
                }
                if (W(type) == W(base) && B(specified))
                    REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_FUNCTION_DEFINITION : MSG_FUNCTION_DEFINITION_387);
                if (count > 1 && !NOT_ANSI_FLAG)
                    REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
                FUNCTION_DEF_POSITION = position;
                FUNCTION_DEF_LINE = saved_token_line;
                CURRENT_SOURCE_FILE = saved_token_file;
                COMPILE_FUNCTION_DEFINITION(W(base), W(context), W(name), W(scope), W(token), implicit, 0);
                while (CURRENT_TOKEN == TOK_SEMICOLON) {
                    if (!NOT_ANSI_FLAG)
                        REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
                    ADVANCE_TOKEN();
                }
                goto done;
            }
            if (W(token) == 0x6E)
                goto next;
            if (implicit && W(token) == 0x82) {
                REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
                IN_ERROR_RECOVERY = 1;
            }
            u8 defining = CURRENT_TOKEN == TOK_ASSIGN || CURRENT_TOKEN == TOK_LPAREN;
            u8 member = (TYPE_B(W(base), TYPE_ATTRS) & 4) && (W(token) != 0x36 || (defining && (TYPE_B(W(base), TYPE_ATTRS) & 1)));
            defining |= member;
            if (W(context)) {
                W(record) = DEFINE_STATIC_DATA_MEMBER(W(base), W(context), W(name), W(token), defining);
                CURRENT_CLASS_TYPE = W(context);
                W(base) = SYM_W(W(record), SYM_TYPE);
            } else {
                struct Attributes a = attributes_at(current);
                W(record) = DECLARE_VARIABLE(W(base), W(name), W(token), defining, (u8)a.qualifier, attributes_low(a));
            }
            if (defining)
                PARSE_DECL_INITIALIZER(member, W(base), W(record));
            else if (CPP_MODE && W(token) != 0x36 && W(record)) {
                u16 node = MAKE_SYMBOL_NODE(W(record));
                TEMP_DESTRUCTOR_LIST = REGISTER_TEMP_DESTRUCTOR(node, W(base), TEMP_DESTRUCTOR_LIST);
            }
            CURRENT_CLASS_TYPE = saved_context;
next:
            TREE_ASSERT(7);
        }
        REQUIRE_TOKEN_BODY(7, 0x1F);
    }
done:
    scratch_release(mark);
}

/* extern "C" (or the other language name at DS:0715): pushes CURRENT_LINKAGE and sets it
   from the string literal just read (1 or 2; any other name is an error and gives 0) */
void C0LINKAGE(void)
{
    u16 mark = scratch_mark();
    farptr text = scratch_alloc(10);
    u16 index = 0;
    u16 entry = POOL_ALLOC_REUSE(LINKAGE_STACK_POOL_SEG_P, 4);
    LW(entry) = CURRENT_LINKAGE;
    LW(entry + 2) = LINKAGE_STACK;
    LINKAGE_STACK = entry;
    farptr p = text;
    i16 c;
    while ((c = NEXT_LITERAL_CHAR(index++)) != -1)
        if (FP_OFF(p) < FP_OFF(text) + 9) {
            B(p) = (u8)c;
            p = fp_add(p, 1);
        }
    B(p) = 0;
    if (!COMPARE_NAME(text, STR_C_7_P))
        CURRENT_LINKAGE = 1;
    else if (!COMPARE_NAME(text, STR_C_8_P))
        CURRENT_LINKAGE = 2;
    else {
        CURRENT_LINKAGE = 0;
        REPORT_CURRENT_TOKEN(MSG_UNKNOWN_LANGUAGE_MUST);
    }
    ADVANCE_TOKEN();
    scratch_release(mark);
}

/* the end of a linkage specification: pops CURRENT_LINKAGE */
void C0UNLINK(void)
{
    if (LINKAGE_STACK == 0)
        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED);
    else {
        u16 entry = LINKAGE_STACK;
        LINKAGE_STACK = LW(entry + 2);
        CURRENT_LINKAGE = LW(entry);
        POOL_FREE_ITEM(LINKAGE_STACK_POOL_SEG_P, entry);
    }
}

/* the whole compilation unit.  An empty file is an error unless checks are relaxed; stray
   semicolons are skipped */
void PARSE_EXTERNAL_DECLARATIONS(void)
{
    INIT_PARSER();
    if (CURRENT_TOKEN == 0 && !NOT_ANSI_FLAG)
        REPORT_CURRENT_TOKEN(MSG_FILE_MUST_CONTAIN);
    while (CURRENT_TOKEN != 0) {
        while ((NOT_ANSI_FLAG || CPP_MODE) && CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        if (CURRENT_TOKEN == 0)
            break;
        if (CURRENT_TOKEN == TOK_EXTERN && peek_kind() == 0x34) {
            ADVANCE_TOKEN();
            C0LINKAGE();
            if (CURRENT_TOKEN == TOK_LBRACE)
                ADVANCE_TOKEN();
            else {
                if (CURRENT_TOKEN != TOK_LBRACE && CURRENT_TOKEN != 0)
                    C0DECL();
                C0UNLINK();
            }
        } else if (CURRENT_TOKEN == TOK_RBRACE) {
            C0UNLINK();
            ADVANCE_TOKEN();
        } else if (CURRENT_TOKEN != TOK_LBRACE && CURRENT_TOKEN != 0)
            C0DECL();
        else {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            IN_ERROR_RECOVERY = 1;
            ADVANCE_TOKEN();
            SKIP_TO_SYNC_TOKEN(TOK_EXTERN);
        }
    }
    if (CPP_MODE)
        PROCESS_DEFERRED_DECLS();
    CHECK_FILE_SYMBOLS();
}
