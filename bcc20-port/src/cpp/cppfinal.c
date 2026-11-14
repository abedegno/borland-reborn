/* cppfinal.c: from bcc20/src/cpp/CPPFINAL.C: what the C++ compiler still has to emit when
   the source file has been read.  PROCESS_DEFERRED_DECLS is the driver, run once at the end
   of the file (only while code generation is on).  It
   - compiles the functions queued on PENDING_DEFINITION_LIST: out-of-line copies of inline
     functions and the bodies of compiler-declared special members (C13DECLARATIONS,
     C13INITIALIZE);
   - builds the static constructor function _STCON_ from the initializations queued on
     FILE_INIT_EXPR_QUEUE (C13PENDING) and the static destructor function _STDES_ from
     TEMP_DESTRUCTOR_LIST (C13VALUES), registered in the start-up and exit tables;
   - emits the virtual tables of the classes on VTABLE_CLASS_LIST (C13CLASSES), and repeats
     until no new function was queued (emitting a table can queue functions);
   - writes the initial data of temporaries left on PENDING_INIT_LIST
     (FLUSH_PENDING_INITIALIZERS, also called from elsewhere).
   Virtual tables: one table symbol per class (TAG_VTABLE_SYMBOL) holds the parts for the
   class and for each base subobject that needs its own pointer.  For each part
   C13INHERITED collects the virtual functions by slot (sorted 6-byte records key, symbol,
   offset in C13_ORDER_BANK, made by C13SLOT), C13OVERRIDE and C13PATH find the final
   overrider of each slot along the derivation path, and C13EMIT writes the entries: the
   function's address, a pure-virtual error function, or a this-adjusting thunk (C13BIND,
   emitted by C13BINDINGS) when the overrider lives at another offset.  Path records
   (BASE_PATH_POOL_SEG, 8 bytes: 0 parent, 2 child, 4 class type, 6 offset) form the chain
   from the complete class down to the subobject being filled.  A class with dynamically
   dispatched functions (class flag 800h, function flag 100h) gets a header first
   (C13SPECIAL).  VTABLE_MODE: 1 emits no tables, 2 every table, 3 puts tables, thunks and
   inline copies in segments of their own named after the mangled name.  The two banks are
   {segment, spare, used, limit} records at DS:649C (binds) and DS:64A4 (slots). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define CW(n, o) AT_W(BASE_PATH_POOL_SEG, (n) + (o))
#define QW(n, o) AT_W(PACKED_EXPR_POOL_SEG, (n) + (o))
#define DW(n, o) AT_W(CONS_CELL_POOL_SEG, (n) + (o))
#define FW(n, o) AT_W(INIT_RECORD_POOL_SEG, (n) + (o))
#define BANK_SEGMENT(bank) W(bank)
#define BANK_SPARE(bank) W(fp_add((bank), 2))
#define BANK_USED(bank) W(fp_add((bank), 4))
#define BANK_LIMIT(bank) W(fp_add((bank), 6))
#define SLOT_KEY(p) AT_W(BANK_SEGMENT(C13_ORDER_BANK_P), (u16)(p))
#define SLOT_SYMBOL(p) AT_W(BANK_SEGMENT(C13_ORDER_BANK_P), (u16)(p) + 2)
#define SLOT_OFFSET(p) AT_W(BANK_SEGMENT(C13_ORDER_BANK_P), (u16)(p) + 4)
#define SLOT_SIZE 6
#define BW(n, o) AT_W(BANK_SEGMENT(C13_BIND_BANK_P), (n) + (o))
#define TAG(type) TYPE_W((type), TYPE_TAG_BODY)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define FUNCTION_DEF_POSITION W(FUNCTION_DEF_POSITION_P)
#define NOWHERE W(fp_add(NO_SOURCE_LOCATION_P, 4)), W(fp_add(NO_SOURCE_LOCATION_P, 2)), W(NO_SOURCE_LOCATION_P)

/* declares a static function void name(void) (one of the start-up and exit functions),
   marks it defined and used, opens its body with no source position and returns its
   prepared storage record */
u16 C13NEW(farptr name)
{
    u16 symbol = DECLARE_GLOBAL_SYMBOL(name, VOID_NOARG_FUNC_TYPE, 0, 0);
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x18;
    SYM_B(symbol, SYM_FLAGS) |= 5;
    SYM_W(symbol, SYM_FUNC_FLAGS) |= 8;
    CURRENT_TOKEN_FILE = 0;
    CURRENT_TOKEN_LINE = 0;
    CURRENT_SOURCE_FILE = 0;
    FUNCTION_DEF_LINE = 0;
    FUNC_START_CLEARED_WORD = 0;
    FUNCTION_DEF_POSITION = 0;
    BEGIN_FUNCTION_BODY(symbol, VOID_NOARG_FUNC_TYPE);
    return PREPARE_SYMBOL(symbol);
}

/* builds _STCON_, the function that runs the file's static initializations, from the
   packed-expression list head (newest first, so it is reversed into source order first).
   Registered as a start-up entry with priority 20h.  Nothing is made when the list is
   empty */
void C13PENDING(u16 head)
{
    u16 reversed = 0;
    while (head) {
        u16 node = head;
        head = QW(node, 10);
        QW(node, 10) = reversed;
        reversed = node;
    }
    STARTUP_BODY_ACTIVE = 1;
    if (reversed) {
        CODE_SEGMENT_ID = DEFAULT_CODE_SEGMENT_ID;
        ADD_STARTUP_ENTRY(C13NEW(STR__STCON__P), 0x20);
        while (reversed) {
            APPEND_ANALYZED_EXPRESSION(UNPACK_EXPR_TREE(QW(reversed, 12)));
            reversed = QW(reversed, 10);
        }
        END_FUNCTION_BODY();
        STARTUP_BODY_ACTIVE = 0;
    }
}

/* builds _STDES_, the exit function that destroys the file's static objects, from the
   temporary-destructor list node (newest first, so destruction runs in reverse order of
   construction) */
void C13VALUES(u16 node)
{
    if (!node)
        return;
    CODE_SEGMENT_ID = DEFAULT_CODE_SEGMENT_ID;
    STARTUP_BODY_ACTIVE = 1;
    ADD_EXIT_ENTRY(C13NEW(STR__STDES__P), 0x20);
    while (node) {
        APPEND_ANALYZED_EXPRESSION(UNPACK_EXPR_TREE(AT_W(TEMP_ENTRY_POOL_SEG, node + 4)));
        node = AT_W(TEMP_ENTRY_POOL_SEG, node);
    }
    END_FUNCTION_BODY();
    STARTUP_BODY_ACTIVE = 0;
}

/* compiles the body of a special member that the compiler declared for a class (default
   or copy constructor, assignment, destructor): the expression comes from
   BUILD_SPECIAL_MEMBER_BODY.  A function returning a value gets a return statement (node
   built with token 5Fh): a constructor returns this, an assignment returns *this.
   Warnings are suppressed */
void C13INITIALIZE(u16 symbol)
{
    ++SUPPRESS_WARNINGS_DEPTH;
    u8 member = SYM_W(symbol, SYM_FUNC_KIND) == 3;
    CURRENT_SOURCE_FILE = 0;
    FUNCTION_DEF_LINE = 0;
    FUNC_START_CLEARED_WORD = 0;
    FUNCTION_DEF_POSITION = 0;
    if (SYM_B(symbol, SYM_FLAGS) & 0x10)
        CURRENT_CLASS_TYPE = SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE);
    BEGIN_FUNCTION_BODY(symbol, SYM_W(symbol, SYM_TYPE));
    CTOR_THIS_SYMBOL = LOOKUP_NAME(THIS_NAME);
    u16 result_type = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_TARGET);
    u16 expression = BUILD_SPECIAL_MEMBER_BODY(symbol);
    if (result_type == VOID_TYPE)
        APPEND_ANALYZED_EXPRESSION(expression);
    else {
        if (member)
            expression = JOIN_COMMA_EXPR(expression, BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
        else
            expression = MAKE_UNARY_NODE(0x18, expression);
        expression = MAKE_BINARY_NODE(0x5F, 0, expression);
        E(expression, EXPR_TYPE) = result_type;
        expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression, VOID_TYPE), 0);
        APPEND_RETURN_JUMP_BLOCK(expression, NOWHERE);
    }
    END_FUNCTION_BODY();
    CURRENT_CLASS_TYPE = 0;
    --SUPPRESS_WARNINGS_DEPTH;
}

/* empties PENDING_DEFINITION_LIST in the order the functions were queued, compiling each:
   a recorded inline body (inline kind 1) with COMPILE_INLINE_BODY, otherwise a special
   member with C13INITIALIZE */
void C13DECLARATIONS(void)
{
    u16 reversed = 0;
    while (PENDING_DEFINITION_LIST) {
        u16 node = PENDING_DEFINITION_LIST;
        PENDING_DEFINITION_LIST = DW(PENDING_DEFINITION_LIST, 0);
        DW(node, 0) = reversed;
        reversed = node;
    }
    ++SUPPRESS_WARNINGS_DEPTH;
    while (reversed) {
        if (NO_ERRORS_YET) {
            if ((SYM_B(DW(reversed, 2), SYM_INLINE_ACCESS) & 3) == 1)
                COMPILE_INLINE_BODY(DW(reversed, 2), 1);
            else
                C13INITIALIZE(DW(reversed, 2));
        }
        u16 node = reversed;
        reversed = DW(reversed, 0);
        LIST_CELL_FREE(node);
    }
    --SUPPRESS_WARNINGS_DEPTH;
}

/* writes the initial data of each temporary on PENDING_INIT_LIST into its symbol's segment
   and removes it from the list.  With partial set only symbols of storage class 4 are
   done; the others stay queued */
void FLUSH_PENDING_INITIALIZERS(u8 partial)
{
    u16 previous = 0;
    for (u16 node = PENDING_INIT_LIST; node; node = FW(node, 0)) {
        if (partial && (SYM_B(FW(node, 2), SYM_STORAGE_CLASS) >> 3) != 4) {
            previous = node;
            continue;
        }
        u16 saved = SELECT_SYMBOL_STREAM(FW(node, 2));
        for (u16 expression = FW(node, 4); expression; expression = QW(expression, 10))
            EMIT_CONST_INIT_VALUE(UNPACK_EXPR_TREE(QW(expression, 12)));
        SET_STREAM(saved);
        if (!previous)
            PENDING_INIT_LIST = FW(node, 0);
        else
            FW(previous, 0) = FW(node, 0);
    }
}

/* makes the thunk symbol for a virtual table entry that must adjust this by offset before
   jumping to function symbol: a temporary symbol (far when the function is far), recorded
   with offset and function in a 6-byte entry of the bind bank for C13BINDINGS.  The
   function is queued since its address is now needed */
u16 C13BIND(u16 offset, u16 symbol)
{
    u16 binding = CREATE_TEMP_SYMBOL(INT_TYPE, 1);
    u16 prepared = PREPARE_SYMBOL(binding);
    CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(0xFFFF));
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_FUNC_FLAGS) & 1) {
        SYM_B(binding, SYM_FLAGS) |= 0x80;
        CLEAR_PREPARED_FLAGS(prepared, 4);
        SET_PREPARED_FLAGS(prepared, 0x10);
    }
    u16 entry = POOL_ALLOC(C13_BIND_BANK_P, 6);
    BW(entry, 0) = offset;
    BW(entry, 2) = symbol;
    QUEUE_DEFERRED_SYMBOL(symbol);
    BW(entry, 4) = binding;
    return binding;
}

/* writes the count+1 entries of the slot table (the order bank from offset 0) as constant
   data into the current stream; *size gets the bytes written */
void C13EMIT(i16 count, farptr size)
{
    W(size) = 0;
    for (i16 index = 0; index <= count; ++index) {
        u16 position = (u16)(index * SLOT_SIZE);
        u16 symbol = SLOT_SYMBOL(position);
        if (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x20)
            symbol = (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_FUNC_FLAGS) & 1) ? FAR_PURE_ERROR_SYMBOL : NEAR_PURE_ERROR_SYMBOL;
        else if (SLOT_OFFSET(position))
            symbol = C13BIND(SLOT_OFFSET(position), symbol);
        u16 expression = BUILD_SYMBOL_EXPR(symbol);
        W(size) += (u16)TYPE_SIZE(E(expression, EXPR_TYPE));
        EMIT_CONST_INIT_VALUE(expression);
    }
}

/* finds or inserts the slot record with virtual index key in the sorted table (binary
   search over *count+1 records, *count being the last index); a new record is cleared and
   *count grows.  Returns the record's offset */
u16 C13SLOT(u16 key, farptr count)
{
    i16 high = SW(count), low = 0, middle;
    u16 position;
    while (low <= high) {
        middle = (i16)((low + high) / 2);
        position = (u16)(middle * SLOT_SIZE);
        if (SLOT_KEY(position) == key)
            return position;
        if (SLOT_KEY(position) > key)
            high = (i16)(middle - 1);
        else
            low = (i16)(middle + 1);
    }
    position = (u16)(high * SLOT_SIZE + SLOT_SIZE);
    ++SW(count);
    u16 end = POOL_ALLOC(C13_ORDER_BANK_P, SLOT_SIZE);
    while (end > position) {
        SLOT_KEY(end) = SLOT_KEY(end - SLOT_SIZE);
        SLOT_SYMBOL(end) = SLOT_SYMBOL(end - SLOT_SIZE);
        SLOT_OFFSET(end) = SLOT_OFFSET(end - SLOT_SIZE);
        end -= SLOT_SIZE;
    }
    SLOT_KEY(position) = key;
    SLOT_SYMBOL(position) = 0;
    SLOT_OFFSET(position) = 0;
    return position;
}

/* enters every virtual function of class type (not the dynamically dispatched ones) into
   its slot, unless the slot already has a function: classes are visited most derived
   first, so the overriding function wins */
void C13COLLECT(u16 type, farptr count)
{
    for (u16 member = TAG_W(TAG(type), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) != 3)
            continue;
        for (u16 symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD)) {
            if (SYM_W(symbol, SYM_VIRTUAL_INDEX) > 0 && !(SYM_W(symbol, SYM_FUNC_FLAGS) & 0x100)) {
                u16 slot = C13SLOT(SYM_W(symbol, SYM_VIRTUAL_INDEX), count);
                if (!SLOT_SYMBOL(slot)) {
                    SLOT_SYMBOL(slot) = symbol;
                    SLOT_OFFSET(slot) = 0;
                }
            }
        }
    }
}

/* fills the slot table for class type and the chain of bases that share its table pointer
   (BASE_USED); *count is the last slot index, -1 when the class has no virtual table */
void C13INHERITED(u16 type, farptr count)
{
    SW(count) = -1;
    if (TAG_W(TAG(type), TAG_VTABLE_SIZE) > 0) {
        while (type) {
            C13COLLECT(type, count);
            u16 base = TAG_W(TAG(type), TAG_BASES);
            type = 0;
            while (base) {
                if (BASE_B(base, BASE_USED))
                    type = BASE_W(base, BASE_TYPE);
                base = BASE_W(base, BASE_NEXT);
            }
        }
    }
}

/* path is the chain of classes from the complete object down to the subobject whose table
   is being filled, which lies at offset.  For each slot it searches the classes from the
   top (most derived) down for a function with the same name and signature; the first found
   replaces the slot's function, and the slot's offset becomes the difference between that
   class's offset and the subobject's, the this adjustment a thunk must make */
void C13OVERRIDE(u16 path, u16 offset, i16 count)
{
    if (!path)
        return;
    for (i16 index = 0; index <= count; ++index) {
        u16 position = (u16)(index * SLOT_SIZE);
        u16 name = SYM_W(SLOT_SYMBOL(position), SYM_NAME);
        u16 type = SYM_W(SLOT_SYMBOL(position), SYM_TYPE);
        u16 node = path;
        while (CW(node, 0))
            node = CW(node, 0);
        while (node) {
            u16 member = FIND_MEMBER_BY_NAME(name, CW(node, 4)), symbol;
            for (symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD)) {
                if (SAME_SIGNATURE(SYM_W(symbol, SYM_TYPE), type)) {
                    SLOT_SYMBOL(position) = symbol;
                    SLOT_OFFSET(position) = (u16)(CW(node, 6) - offset);
                    break;
                }
            }
            if (symbol)
                break;
            node = CW(node, 2);
        }
    }
}

/* the offset of virtual base type in the COLLECT_VBASES list path, or 0 */
u16 C13BASE(u16 path, u16 type)
{
    while (path) {
        if (TAG(BASE_W(path, BASE_TYPE)) == TAG(type))
            return BASE_W(path, BASE_OFFSET);
        path = BASE_W(path, BASE_NEXT);
    }
    return 0;
}

/* a path record for type at offset under parent, linked both ways */
static u16 open_path(u16 parent, u16 type, u16 offset)
{
    u16 path = POOL_ALLOC_REUSE(BASE_PATH_POOL_SEG_P, 8);
    CW(path, 0) = parent;
    CW(path, 2) = 0;
    CW(path, 6) = offset;
    CW(path, 4) = type;
    if (parent)
        CW(parent, 2) = path;
    return path;
}

static void close_path(u16 parent, u16 path)
{
    POOL_FREE_ITEM(BASE_PATH_POOL_SEG_P, path);
    if (parent)
        CW(parent, 2) = 0;
}

/* for a virtual base target, walks every derivation path from class type (at offset) down
   to it, extending the path chain, and runs C13OVERRIDE for each path that reaches target,
   so overriders declared in any branch that derives from the shared virtual base are
   found.  Virtual bases on the way are placed with C13BASE */
void C13PATH(u16 type, u16 offset, u16 target, u16 bases, u16 parent, i16 count)
{
    u16 path = open_path(parent, type, offset);
    for (u16 base = TAG_W(TAG(type), TAG_BASES); base; base = BASE_W(base, BASE_NEXT)) {
        u16 displacement;
        if (BASE_B(base, BASE_VIRTUAL))
            displacement = C13BASE(bases, BASE_W(base, BASE_TYPE));
        else
            displacement = (u16)(BASE_W(base, BASE_OFFSET) + offset);
        if (TAG(BASE_W(base, BASE_TYPE)) == TAG(target))
            C13OVERRIDE(path, displacement, count);
        else
            C13PATH(BASE_W(base, BASE_TYPE), displacement, target, bases, path, count);
    }
    close_path(parent, path);
}

/* emits the table parts of class type (at offset in the complete class root) and
   recursively of its non-virtual bases.  A base that shares its derived class's table
   pointer (indirect) emits nothing itself.  bases is the virtual base list when the part
   belongs to a virtual base subobject.  *size adds up the bytes emitted */
void C13WALK(u16 type, u16 root, u16 bases, u16 offset, u16 parent, u8 indirect, farptr size)
{
    if (!indirect) {
        /* the original frame from BP-4: emitted, count at 2 */
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(4);
        farptr emitted = v, count = fp_add(v, 2);
        C13INHERITED(type, count);
        C13OVERRIDE(parent, offset, SW(count));
        if (bases)
            C13PATH(root, 0, type, bases, 0, SW(count));
        C13EMIT(SW(count), emitted);
        W(size) += W(emitted);
        scratch_release(mark);
    }
    u16 base = TAG_W(TAG(type), TAG_BASES);
    if (base) {
        u16 path = open_path(parent, type, offset);
        while (base) {
            if (!BASE_B(base, BASE_VIRTUAL))
                C13WALK(BASE_W(base, BASE_TYPE), root, bases, (u16)(BASE_W(base, BASE_OFFSET) + offset), path, BASE_B(base, BASE_USED), size);
            base = BASE_W(base, BASE_NEXT);
        }
        close_path(parent, path);
    }
}

/* emits the table parts of each virtual base of type, at its offset in the complete
   object */
void C13VIRTUAL(u16 type, farptr size)
{
    u16 bases = COLLECT_VBASES(type);
    for (u16 node = bases; node; node = BASE_W(node, BASE_NEXT))
        C13WALK(BASE_W(node, BASE_TYPE), type, bases, BASE_W(node, BASE_OFFSET), 0, 0, size);
    while (bases) {
        u16 node = bases;
        bases = BASE_W(bases, BASE_NEXT);
        POOL_FREE_ITEM(BASE_LIST_SEG_P, node);
    }
}

/* the code segment for the class's thunks: with VTABLE_MODE 3 a new segment named after the
   mangled table symbol plus "@VSF" (far thunks, special set) or "@VSN" (near), otherwise
   the current CODE_SEGMENT_ID */
u16 C13LABEL(u16 type, u8 special)
{
    u16 segment = DEFAULT_CODE_SEGMENT_ID;
    if (VTABLE_MODE != 3)
        return CODE_SEGMENT_ID;
    if (special)
        segment |= 0x8000;
    farptr name = MANGLE_SYMBOL_NAME(TAG_W(TAG(type), TAG_VTABLE_SYMBOL));
    name = STRING_APPEND(name, special ? STR_VSF_P : STR_VSN_P);
    u16 id = (u16)(OBJ_EXTERN_INDEX++ + 0x4000);                   /* pascal: left to right */
    return DEFINE_SEGMENT_FIXED_ID(id, segment, 2, BCC_INTERN_STRING(name));
}

/* extra stack distance to this for a thunk of function type type: when the function
   returns a class through a hidden pointer (a class with constructors, or one whose size
   is not 1, 2 or 4), KIND_SIZE_TABLE[60], else 0 */
i16 C13WIDTH(u16 type)
{
    u16 result_type = TYPE_W(type, TYPE_TARGET);
    u16 width = (u16)TYPE_SIZE(result_type);
    if ((EXPR_FLAGS_AT(TYPE_W(result_type, TYPE_KIND)) & 0x40)
        && ((TYPE_B(result_type, TYPE_ATTRS) & 4) || (width != 1 && width != 2 && width != 4)))
        return KIND_SIZE_TABLE_AT(60);
    return 0;
}

/* emits each thunk recorded by C13BIND: puts the thunk symbol in a near or far thunk
   segment (C13LABEL, made on first use) and lets EMIT_THIS_ADJUST_THUNK_HOOK write code
   that adds the offset to this and jumps to the function */
void C13BINDINGS(u16 type)
{
    u16 normal_label = 0, special_label = 0, label;
    u16 end = BANK_USED(C13_BIND_BANK_P);
    for (u16 position = 0; position < end; position += 6) {
        u16 special = (SYM_B(BW(position, 4), SYM_FLAGS) & 0x80) != 0;
        if (special) {
            if (!special_label)
                special_label = C13LABEL(type, 1);
            label = special_label;
        } else {
            if (!normal_label)
                normal_label = C13LABEL(type, 0);
            label = normal_label;
        }
        u16 prepared = PREPARE_SYMBOL(BW(position, 4));
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(label));
        u16 saved = SELECT_SYMBOL_STREAM(BW(position, 4));
        prepared = PREPARE_SYMBOL(BW(position, 2));                 /* pascal: left to right */
        u16 offset = BW(position, 0);
        i16 width = C13WIDTH(SYM_W(BW(position, 2), SYM_TYPE));
        CALL_FAR(EMIT_THIS_ADJUST_THUNK_HOOK, A16(prepared), A16(offset), A16(special), A16(width));
        SET_STREAM(saved);
    }
}

/* the size of a dynamic dispatch header of a class with count functions */
static u16 header_size(u16 result_type, u16 count)
{
    u16 size = (u16)TYPE_SIZE(SHORT_TYPE);
    size = (u16)(size + (u16)TYPE_SIZE(result_type));
    u16 entry = (u16)TYPE_SIZE(FAR_VOID_PTR_TYPE);
    entry = (u16)(entry + (u16)TYPE_SIZE(SHORT_TYPE));
    return (u16)(size + entry * count);
}

/* the header in front of the table of a class with dynamically dispatched functions: the
   addresses of all of them, their dispatch ids (SYM_VIRTUAL_INDEX) as shorts, their count
   (TAG_DDVT_COUNT), then a pointer into the first base's table symbol, just past that
   base's header, when that base also has such functions, else 0.  *size adds the header
   size */
void C13SPECIAL(u16 type, farptr size)
{
    u16 result_type = MEMBER_W(BCC_MEMBER_LOOKUP(type), MEMB_TYPE);
    for (u16 member = TAG_W(TAG(type), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT))
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3)
            for (u16 symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD))
                if (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x100)
                    EMIT_CONST_INIT_VALUE(BUILD_SYMBOL_EXPR(symbol));
    for (u16 member = TAG_W(TAG(type), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT))
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3)
            for (u16 symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD))
                if (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x100)
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(SHORT_TYPE, (i32)(i16)SYM_W(symbol, SYM_VIRTUAL_INDEX)));
    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(SHORT_TYPE, (i32)(i16)TAG_W(TAG(type), TAG_DDVT_COUNT)));
    W(size) += header_size(result_type, TAG_W(TAG(type), TAG_DDVT_COUNT));
    type = TAG_W(TAG(type), TAG_BASES) == 0 ? 0 : BASE_W(TAG_W(TAG(type), TAG_BASES), BASE_TYPE);
    if (!type || !(TAG_W(TAG(type), TAG_CLASS_FLAGS) & 0x800))
        EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(result_type, 0));
    else {
        u16 displacement = header_size(result_type, TAG_W(TAG(type), TAG_DDVT_COUNT));
        u16 table = BUILD_SYMBOL_EXPR(TAG_W(TAG(type), TAG_VTABLE_SYMBOL));   /* pascal: left to right */
        u16 expression = MAKE_BINARY_NODE(0x16, table, MAKE_INT_CONSTANT(INT_TYPE, (i32)displacement));
        expression = MAKE_CAST_NODE(result_type, expression);
        EMIT_CONST_INIT_VALUE(SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression, 0), 0));
    }
}

/* emits the whole virtual table of class type: picks the table symbol's segment (its own
   named segment in mode 3, the code segment for a far table, flag 80h), selects that stream
   and writes the dispatch header, the parts of the class and its non-virtual bases, then
   those of the virtual bases, and finally the thunks.  *size gets the table size */
void C13BUILD(u16 type, farptr size)
{
    u16 symbol = TAG_W(TAG(type), TAG_VTABLE_SYMBOL);
    BANK_LIMIT(C13_ORDER_BANK_P) = 0;
    BANK_USED(C13_ORDER_BANK_P) = 0;
    BANK_LIMIT(C13_BIND_BANK_P) = 0;
    BANK_USED(C13_BIND_BANK_P) = 0;
    if (VTABLE_MODE == 3) {
        u16 prepared = PREPARE_SYMBOL(symbol);
        if ((u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared)) == 0xFFFF) {
            u16 id = (u16)(OBJ_EXTERN_INDEX + 0x4000);               /* pascal: left to right */
            u16 segment = (SYM_B(symbol, SYM_FLAGS) & 0x80) ? DEFAULT_CODE_SEGMENT_ID : DATA_SEGMENT_ID;
            u16 label = DEFINE_SEGMENT_FIXED_ID(id, segment, 2, BCC_INTERN_STRING(MANGLE_SYMBOL_NAME(symbol)));
            CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(label));
            CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(prepared), A16(OBJ_EXTERN_INDEX++));
            SET_PREPARED_FLAGS(prepared, 0x100);
        }
    } else if (SYM_B(symbol, SYM_FLAGS) & 0x80) {
        u16 prepared = PREPARE_SYMBOL(TAG_W(TAG(type), TAG_VTABLE_SYMBOL));
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(CODE_SEGMENT_ID));
    }
    u16 saved = SELECT_SYMBOL_STREAM(TAG_W(TAG(type), TAG_VTABLE_SYMBOL));
    W(size) = 0;
    if (TAG_W(TAG(type), TAG_CLASS_FLAGS) & 0x800)
        C13SPECIAL(type, size);
    C13WALK(type, type, 0, 0, 0, 0, size);
    C13VIRTUAL(type, size);
    SET_STREAM(saved);
    C13BINDINGS(type);
}

/* emits the virtual table of each class on VTABLE_CLASS_LIST whose table symbol is used
   (SYM_FLAGS 4) or always in mode 2, once (SYM_FLAGS 1 marks it done), and stores the size
   in the table symbol's array type */
void C13CLASSES(void)
{
    for (u16 node = VTABLE_CLASS_LIST; node; node = DW(node, 0)) {
        u16 type = SYM_W(DW(node, 2), SYM_TYPE);
        u16 symbol = TAG_W(TAG(type), TAG_VTABLE_SYMBOL);
        if (((SYM_B(symbol, SYM_FLAGS) & 4) || CPU_IS_286) && !(SYM_B(symbol, SYM_FLAGS) & 1)) {
            SYM_B(symbol, SYM_FLAGS) |= 1;
            /* the original frame from BP-4: size */
            u16 mark = scratch_mark();
            farptr size = scratch_alloc(4);
            C13BUILD(type, size);
            TYPE_UL(SYM_W(symbol, SYM_TYPE), TYPE_ARRAY_COUNT) = W(size);
            scratch_release(mark);
        }
    }
}

/* the end-of-file driver (see the top).  Sets up the two banks first */
void PROCESS_DEFERRED_DECLS(void)
{
    LEX_FILE_SERIAL_NODE = 0xFFFF;
    if (!NO_ERRORS_YET)
        return;
    BANK_USED(C13_ORDER_BANK_P) = BANK_SPARE(C13_ORDER_BANK_P) = 0;
    BANK_LIMIT(C13_ORDER_BANK_P) = 0;
    POOL_INIT(C13_ORDER_BANK_P, 0);
    BANK_USED(C13_BIND_BANK_P) = BANK_SPARE(C13_BIND_BANK_P) = 0;
    BANK_LIMIT(C13_BIND_BANK_P) = 0;
    POOL_INIT(C13_BIND_BANK_P, 0);
    ++SUPPRESS_WARNINGS_DEPTH;
    C13DECLARATIONS();
    C13PENDING(FILE_INIT_EXPR_QUEUE);
    C13VALUES(TEMP_DESTRUCTOR_LIST);
    do {
        C13DECLARATIONS();
        if (!CPU_LEVEL_1_FLAG)
            C13CLASSES();
        FLUSH_PENDING_INITIALIZERS(0);
    } while (PENDING_DEFINITION_LIST);
    --SUPPRESS_WARNINGS_DEPTH;
}
