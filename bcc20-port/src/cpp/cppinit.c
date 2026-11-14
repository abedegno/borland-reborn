/* cppinit.c: from bcc20/src/cpp/CPPINIT.C: initializers of C++ declarations, called by the
   declaration parser (INITLIST.C and STMTCPP.C) once a declarator is known.  A static
   object's initial value is written straight into its data segment when it is a constant
   (EMIT_CONST_INIT_VALUE after SELECT_SYMBOL_STREAM picks the symbol's segment); anything
   needing code at run time (constructor calls, non-constant values) is reserved as zero
   bytes and its initialisation expression is queued by QUEUE_INIT_EXPR: on
   FILE_INIT_EXPR_QUEUE at file scope (CPPFINAL.C builds the static initialisation function
   from it), or on LOCAL_INIT_EXPR_LIST inside a function (STMTCPP.C turns it into a comma
   expression at the declaration).  Initialisations are first analysed with NO_ERRORS_YET
   forced to 0, then the flag is put back (and stays off if errors occurred).  Objects with
   destructors at file scope get their destructor registered on TEMP_DESTRUCTOR_LIST.  The
   long data positions passed by address live in the scratch area. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define TL(n, o) TYPE_L((n), (o))
#define S(n, o) SYM_W((n), (o))
#define SB_(n, o) SYM_B((n), (o))
#define SL(n, o) SYM_L((n), (o))
#define E(n, o) EXPR_W((n), (o))
#define EL(n, o) EXPR_L((n), (o))
#define LINK(n, o) TAG_W((n), (o))
#define FUNCTION_ROOT W(BCC_TREE_SPECIAL_P)            /* the function being compiled */
#define ERROR_COUNT W(ERROR_COUNT_P)
#define TOKEN_KIND W(TOKEN_TYPE_P)                     /* the look-ahead token's kind */

static int is_local(u16 symbol) { return (SB_(symbol, 7) >> 3) == 5; }

/* packs initialisation expression (consumed) into a PACKED_EXPR_POOL_SEG record and links
   it (word 10 of the record) in front of FILE_INIT_EXPR_QUEUE outside functions or
   LOCAL_INIT_EXPR_LIST inside one */
void QUEUE_INIT_EXPR(u16 expression)
{
    expression = MAKE_LIST_NODE(expression, 0);
    u16 record = PACK_EXPR_TREE(expression);
    FREE_EXPR_TREE(expression);
    if (!FUNCTION_ROOT) {
        W(MK_FP(PACKED_EXPR_POOL_SEG, record + 10)) = FILE_INIT_EXPR_QUEUE;
        FILE_INIT_EXPR_QUEUE = record;
    } else {
        W(MK_FP(PACKED_EXPR_POOL_SEG, record + 10)) = LOCAL_INIT_EXPR_LIST;
        LOCAL_INIT_EXPR_LIST = record;
    }
}

/* zero bytes until the data position *cursor reaches end */
void PAD_TO_POSITION(i32 end, farptr cursor)
{
    if (SD(cursor) < end) {
        EMIT_ZERO_BYTES((u16)(end - SD(cursor)));
        SD(cursor) = end;
    }
}

/* "symbol = value" */
static u16 assign(u16 symbol, u16 value)
{
    u16 left = MAKE_SYMBOL_NODE(symbol);
    return MAKE_BINARY_NODE(5, left, value);
}

/* "= expression" for reference symbol of reference type type: the stored address is
   emitted or queued.  An lvalue of the referred type is bound directly.  Otherwise a
   temporary object of the referred type is created (and linked into its name's symbol
   chain), initialised from the value ("temporary used" for a reference to non-const), and
   the reference bound to it; the temporary's own initializer is emitted when constant,
   else queued.  The reference itself is then emitted as a constant address or queued as
   symbol = &object.  Array references with a different known size are an error */
void INIT_REFERENCE(u16 symbol, u16 type)
{
    u8 saved_parse = NO_ERRORS_YET;
    u16 saved_scope;
    ADVANCE_TOKEN();
    u16 tree = PARSE_ASSIGNMENT_EXPR(8);
    NO_ERRORS_YET = 0;
    u16 expression = SIMPLIFY_EXPRESSION(ANALYZE_EXPRESSION(COPY_EXPR_TREE(tree), type, 0), 0);
    u16 initial_type = E(expression, 8);
    if (!C7_TYPE_COMPAT(type, initial_type, 0)) {
        if (IS_BIT_FIELD_NODE(expression) == 0 && IS_LVALUE(expression) && TYPES_COMPATIBLE(T(type, 7), initial_type, 1))
            goto finish_tree;
        if (IS_LVALUE(expression) && !(TB(T(type, 7), 2) & 1))
            REPORT_DIAGNOSTIC(MSG_TEMPORARY_USED, (i32)SYMBOL_NAME_TEXT(symbol), 0);
        u16 object = CREATE_TEMP_SYMBOL(T(type, 7), 1);
        S(object, 0) = NAME_W(S(object, 2), 0);
        NAME_W(S(object, 2), 0) = object;
        if ((EXPR_FLAGS_AT(T(T(type, 7), 0)) & 0x40) && (LINK(T(T(type, 7), 5), 24) & 0x80))
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE, CLASS_NAME_OF_TYPE(T(type, 7)), 0);
        expression = assign(object, expression);
        expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression, 0), 0);
        NO_ERRORS_YET = saved_parse && !ERROR_COUNT;
        saved_scope = SELECT_SYMBOL_STREAM(object);
        if (E(expression, 0) == 0x12 && IS_CONSTANT_INITIALIZER(E(expression, 12)))
            EMIT_CONST_INIT_VALUE(E(expression, 12));
        else {
            EMIT_ZERO_BYTES((u16)TYPE_SIZE(E(expression, 8)));
            tree = assign(object, tree);
            QUEUE_INIT_EXPR(tree);
            FREE_EXPR_TREE(expression);
        }
        SET_STREAM(saved_scope);
        tree = MAKE_SYMBOL_NODE(object);
finish_tree:
        tree = MAKE_UNARY_NODE(0x1D, tree);
        NO_ERRORS_YET = 0;
        expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(COPY_EXPR_TREE(tree), 0), 0);
    }
    NO_ERRORS_YET = saved_parse && !ERROR_COUNT;
    saved_scope = SELECT_SYMBOL_STREAM(symbol);
    if (T(T(type, 7), 0) == 0x11 && T(initial_type, 0) == 0x11 && TL(T(type, 7), 9) != 0 &&
        TL(T(type, 7), 9) != TL(initial_type, 9)) {
        i32 to = FORMAT_TYPE(type);                 /* pascal: left to right */
        i32 from = FORMAT_TYPE(initial_type);
        REPORT_DIAGNOSTIC(MSG_CANNOT_INITIALIZE, to, from);
    }
    if (!IS_CONSTANT_INITIALIZER(expression)) {
        tree = assign(symbol, tree);
        EMIT_ZERO_BYTES((u16)TYPE_SIZE(type));
        QUEUE_INIT_EXPR(tree);
        FREE_EXPR_TREE(expression);
    } else {
        u16 pointer = MAKE_POINTER_TYPE(T(type, 7), T(type, 0), 0);
        EMIT_CONST_INIT_VALUE(CONVERT_EXPR_TO_TYPE(pointer, expression, 0));
    }
    SET_STREAM(saved_scope);
}

/* the initializer of class object symbol: "= expression" (an initialisation node),
   "(args)" (a constructor call through BUILD_INIT_CALL), or nothing (default
   construction; arrays element by element through INIT_VECTOR_ELEMENTS; arrays cannot take
   arguments).  The result carries the position where the initializer started */
u16 PARSE_OBJECT_INIT(u16 symbol, u16 type)
{
    u16 file = W(fp_add(CURRENT_TOKEN_RECORD_P, 3)), line = W(fp_add(CURRENT_TOKEN_RECORD_P, 5));
    u16 column = W(fp_add(CURRENT_TOKEN_RECORD_P, 7));
    u16 expression;
    if (CURRENT_TOKEN == TOK_ASSIGN) {
        ADVANCE_TOKEN();
        u16 left = MAKE_SYMBOL_NODE(symbol);
        u16 right = PARSE_ASSIGNMENT_EXPR(8);
        expression = MAKE_BINARY_NODE(5, left, right);
    } else {
        u16 initial = CURRENT_TOKEN == TOK_LPAREN ? PARSE_ARGUMENT_LIST(0) : 0;
        if (T(type, 0) == 0x11) {
            if (initial)
                expression = REPORT_EXPR_ERROR_PLAIN(MSG_VECTORS_CLASSES_MUST, 0);
            else
                expression = INIT_VECTOR_ELEMENTS(MAKE_SYMBOL_NODE(symbol), type);
        } else
            expression = BUILD_INIT_CALL(MAKE_SYMBOL_NODE(symbol), type, initial, 0, 0);
    }
    E(expression, 20) = file;
    E(expression, 22) = line;
    E(expression, 24) = column;
    return expression;
}

/* initialises class object symbol.  "= {" is an aggregate list (INIT_DECLARATOR); anything
   else goes through PARSE_OBJECT_INIT, is checked and queued, and a static object's
   storage is reserved as zeros.  At file scope the object's destructor is registered for
   the end of the program */
void INIT_CLASS_OBJECT(u16 symbol, u16 type)
{
    u8 saved_parse = NO_ERRORS_YET;
    if (CURRENT_TOKEN == TOK_ASSIGN && (PEEK_TOKEN(), TOKEN_KIND) == 5) {
        ADVANCE_TOKEN();
        INIT_DECLARATOR(symbol, type);
    } else {
        u16 expression = PARSE_OBJECT_INIT(symbol, type);
        NO_ERRORS_YET = 0;
        ANALYZE_AND_DECAY(COPY_EXPR_TREE(expression), VOID_TYPE);
        NO_ERRORS_YET = saved_parse && !ERROR_COUNT;
        QUEUE_INIT_EXPR(expression);
        if (!is_local(symbol)) {
            u16 saved_scope = SELECT_SYMBOL_STREAM(symbol);
            u16 mark = scratch_mark();
            farptr cursor = scratch_alloc(4);
            SD(cursor) = 0;
            PAD_TO_POSITION(TYPE_SIZE(type), cursor);
            scratch_release(mark);
            SET_STREAM(saved_scope);
        }
    }
    if (!FUNCTION_ROOT) {
        u16 node = MAKE_SYMBOL_NODE(symbol);
        TEMP_DESTRUCTOR_LIST = REGISTER_TEMP_DESTRUCTOR(node, type, TEMP_DESTRUCTOR_LIST);
    }
}

/* turns symbol into a real variable of type initialised by the (non-constant) expression
   initial: at file scope a static (storage class 3) with storage in its data segment,
   inside a function an auto variable (class 5) registered with REGISTER_SYMBOL_VARIABLE;
   INIT_SCALAR does the initialisation */
void DEFINE_SCALAR_INITIALIZER(u16 symbol, u16 type, u16 initial)
{
    u16 mark = scratch_mark();
    farptr cursor = scratch_alloc(4);
    SD(cursor) = 0;
    u16 saved_scope = 0;
    S(symbol, 8) = 0;
    SB_(symbol, 6) |= 3;
    S(symbol, 4) = type;
    if (!FUNCTION_ROOT) {
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x18;
        PREPARE_SYMBOL(symbol);
        saved_scope = SELECT_SYMBOL_STREAM(symbol);
    } else {
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x28;
        REGISTER_SYMBOL_VARIABLE(symbol);
    }
    INIT_SCALAR(symbol, type, cursor, initial);
    if (!FUNCTION_ROOT)
        SET_STREAM(saved_scope);
    scratch_release(mark);
}

/* the initializer of a const scalar.  A value known at compile time is stored in the
   symbol itself (SYM_CONST_VALUE: a long, or the 10-byte real) so uses fold to the
   constant; otherwise the symbol becomes an ordinary initialised variable.  An
   incompatible or non-arithmetic constant is reported and the symbol's type cleared */
void PARSE_CONST_INITIALIZER(u16 symbol, u16 type)
{
    u16 expression = ANALYZE_AND_DECAY(PARSE_ASSIGNMENT_EXPR(8), type);
    if (!IS_LINK_TIME_CONSTANT(expression)) {
        DEFINE_SCALAR_INITIALIZER(symbol, type, expression);
        return;
    }
    expression = NULL_CONSTANT_TO_POINTER(type, expression);
    if (C7_TYPE_COMPAT(type, E(expression, 8), NOT_ANSI_FLAG))
        expression = SIMPLIFY_EXPRESSION(CONVERT_EXPR_TO_TYPE(type, expression, 0), 0);
    else {
        i32 from = FORMAT_TYPE(E(expression, 8));       /* pascal: left to right */
        i32 to = FORMAT_TYPE(type);
        expression = REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE, (farptr)from, to, expression);
    }
    if (E(expression, 0) == 2) {
        SL(symbol, 8) = EL(expression, 10);
        S(symbol, 4) = type;
    } else if (E(expression, 0) == 3) {
        RTL_MEMMOVE(MK_FP(SYMBOL_POOL_SEG, symbol + SYM_STORAGE), MK_FP(EXPR_POOL_SEG, expression + EXPR_LEFT), 10);
        S(symbol, 4) = type;
    } else {
        expression = REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_INITIALIZATION, expression);
        S(symbol, 4) = 0;
        SL(symbol, 8) = 0;
    }
    FREE_EXPR_TREE(expression);
}

/* inside an aggregate initializer, the remaining count elements of class type (from
   position *cursor of array symbol) are default constructed: a call of VECTOR_NEW_SYMBOL
   (VECTOR_VNEW_SYMBOL with virtual bases) with the address, element size, element count,
   mode and the default constructor is queued, and a static array's storage padded up to
   the end.  forbidden reports "array size too large" instead.  The last parameter is
   unused */
void CONSTRUCT_ARRAY_ELEMENTS(i32 count, u16 symbol, u16 type, farptr cursor, u8 forbidden, u8 unused)
{
    (void)unused;
    if (forbidden) {
        REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        return;
    }
    while (T(type, 0) == 0x11) {
        count = (i32)((u32)count * (u32)TL(type, 9));   /* wraps, as the 16-bit long multiply does */
        type = T(type, 7);
    }
    u16 constructor = FIND_DEFAULT_CTOR(type, 1);
    if (!constructor) {
        REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE_225, FORMAT_SPECIAL_MEMBER(5, 0, type), 0);
        return;
    }
    u16 target = MAKE_SYMBOL_NODE(symbol);
    E(target, 12) += (u16)SD(cursor);
    u16 owner_type = (LINK(T(type, 5), 24) & 4) ? VECTOR_VNEW_SYMBOL : VECTOR_NEW_SYMBOL;
    /* pascal: the arguments are built left to right */
    u16 function = MAKE_SYMBOL_NODE(owner_type);
    u16 address = MAKE_CAST_NODE(FAR_VOID_PTR_TYPE, MAKE_UNARY_NODE(0x1D, target));
    u16 size = MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type));
    u16 number = MAKE_INT_CONSTANT(INT_TYPE, count);
    u16 mode = MAKE_INT_CONSTANT(INT_TYPE, (i32)DESTRUCTOR_CALL_FLAGS(type, constructor));
    u16 code = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(constructor));
    u16 expression = MAKE_CALL_NODE(function, address, size, number, mode, code);
    QUEUE_INIT_EXPR(expression);
    if (!is_local(symbol))
        PAD_TO_POSITION((i32)((u32)SD(cursor) + (u32)count * (u32)TYPE_SIZE(type)), cursor);
}
