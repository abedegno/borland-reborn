/* target: ovr085_C29UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ initialization: references, class objects through constructors, constant
   initializers, array element construction, queued initializer expressions. Entry points:
   QUEUE_INIT_EXPR, INIT_REFERENCE, PARSE_OBJECT_INIT, INIT_CLASS_OBJECT,
   DEFINE_SCALAR_INITIALIZER, PARSE_CONST_INITIALIZER, CONSTRUCT_ARRAY_ELEMENTS. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: initializers of C++ declarations, called by the declaration parser
   (parser/INITLIST.C and STMTCPP.C) once a declarator is known. A static object's
   initial value is written straight into its data segment when it is a constant
   (EMIT_CONST_INIT_VALUE after SELECT_SYMBOL_STREAM picks the symbol's segment);
   anything that needs code at run time (constructor calls, non-constant values) is
   reserved as zero bytes (EMIT_ZERO_BYTES, which emits that many zero
   bytes) and its initialization expression is queued by QUEUE_INIT_EXPR: on
   FILE_INIT_EXPR_QUEUE at file scope, from which CPPFINAL.C builds the static
   initialization function, or on LOCAL_INIT_EXPR_LIST inside a function, which
   STMTCPP.C turns into a comma expression at the declaration.
   Initializations are first analyzed with NO_ERRORS_YET forced to 0 (only to check
   them and to see if they are constant), then the flag is put back (and stays off if
   errors occurred). Objects with destructors at file scope get their destructor
   registered on TEMP_DESTRUCTOR_LIST (for the static destructor function).
   Raw offsets through local macros: E(n,0) EXPR_OP (2 constant, 3 real constant,
   0x12 EOP_ASSIGN), E(n,8) EXPR_TYPE, E(n,10)/EL EXPR_LEFT or constant value, E(n,12)
   EXPR_RIGHT; S(n,0) SYM_NEXT, S(n,2) SYM_NAME, S(n,4) SYM_TYPE, SB(n,6) SYM_FLAGS,
   SB(n,7) SYM_STORAGE_CLASS (5 auto), S/SL(n,8) SYM_CONST_VALUE; T(n,0) TYPE_KIND (0x11
   TK_ARRAY), TB(n,2) TYPE_ATTRS, T(n,5) TYPE_TAG_BODY, T(n,7) TYPE_TARGET, TL(n,9)
   TYPE_ARRAY_COUNT; LINK(n,24) TAG_CLASS_FLAGS (4 virtual bases, 0x80 probably
   abstract). Token 5 builds an initialization node (operator 0x47), 0x1D takes an
   address. */
#include <dos.h>
#include "CPPINIT.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define TL(n,o) AT_L(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SL(n,o) AT_L(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define EL(n,o) AT_L(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define LINK(n,o) AT_W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define LOCATION(n) (*(struct C29Location far *)MK_FP(EXPR_POOL_SEG,(unsigned int)(n)+20))

/* 0000: serialize, consume the original tree, and publish its independent record. */
/* QUEUE_INIT_EXPR: packs initialization expression (consumed) into a
   PACKED_EXPR_POOL_SEG record and links it (word 10 of the record) in front of
   FILE_INIT_EXPR_QUEUE outside functions or LOCAL_INIT_EXPR_LIST inside one
   (BCC_TREE_SPECIAL.root is the function being compiled). */
void far pascal QUEUE_INIT_EXPR(register unsigned int expression)
{
    register unsigned int record;
    expression=MAKE_LIST_NODE(expression,0);
    record=PACK_EXPR_TREE(expression);
    FREE_EXPR_TREE(expression);
    if(!BCC_TREE_SPECIAL.root) {
        AT_W(PACKED_EXPR_POOL_SEG,record+10)=FILE_INIT_EXPR_QUEUE;
        FILE_INIT_EXPR_QUEUE=record;
    } else {
        AT_W(PACKED_EXPR_POOL_SEG,record+10)=LOCAL_INIT_EXPR_LIST;
        LOCAL_INIT_EXPR_LIST=record;
    }
}
/* 004E: signed LONG ordering, but the real padding-count consumer is one WORD. */
/* PAD_TO_POSITION: emits zero bytes until the data position *cursor reaches end. */
static void near pascal PAD_TO_POSITION(long end,long far *cursor)
{
    if(*cursor<end) {
        EMIT_ZERO_BYTES((unsigned int)(end-*cursor));
        *cursor=end;
    }
}
/* 008C: reference initialization and exact temporary-scope cleanup. */
/* INIT_REFERENCE: parses "= expression" for reference symbol of reference type type
   and emits or queues the stored address. An lvalue of the referred type is bound
   directly. Otherwise a temporary object of the referred type is created (and linked
   into its name's symbol chain), initialized from the value (MSG_TEMPORARY_USED for a
   reference to non-const), and the reference is bound to it; the temporary's own
   initializer is emitted when constant, else queued. The reference itself is then
   emitted as a constant address or queued as symbol = &object. Array references with
   a different known size are an error. */
void far pascal INIT_REFERENCE(unsigned int symbol,unsigned int type)
{
    unsigned int initial_type;
    unsigned int object;
    unsigned int saved_scope;
    unsigned int tree;
    unsigned char saved_parse;
    register unsigned int expression;
    saved_parse=NO_ERRORS_YET;
    ADVANCE_TOKEN();
    tree=PARSE_ASSIGNMENT_EXPR(8);
    NO_ERRORS_YET=0;
    expression=SIMPLIFY_EXPRESSION(ANALYZE_EXPRESSION(COPY_EXPR_TREE(tree),type,0),0);
    initial_type=E(expression,8);
    if(!C7_TYPE_COMPAT(type,initial_type,0)) {
        if(IS_BIT_FIELD_NODE(expression)==0 && IS_LVALUE(expression) &&
           TYPES_COMPATIBLE(T(type,7),initial_type,1))
            goto finish_tree;
        if(IS_LVALUE(expression) && !(TB(T(type,7),2)&1))
            REPORT_DIAGNOSTIC(MSG_TEMPORARY_USED,SYMBOL_NAME_TEXT(symbol),0L);
        object=CREATE_TEMP_SYMBOL(T(type,7),1);
        S(object,0)=AT_W(NAME_POOL_SEG,S(object,2));
        AT_W(NAME_POOL_SEG,S(object,2))=object;
        if((EXPR_FLAGS[T(T(type,7),0)]&0x40) &&
           (LINK(T(T(type,7),5),24)&0x80))
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE,(char far *)CLASS_NAME_OF_TYPE(T(type,7)),0L);
        expression=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(object),expression);
        expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression,0),0);
        NO_ERRORS_YET=saved_parse && !ERROR_COUNT;
        saved_scope=SELECT_SYMBOL_STREAM(object);
        if(E(expression,0)==0x12 && IS_CONSTANT_INITIALIZER(E(expression,12)))
            EMIT_CONST_INIT_VALUE(E(expression,12));
        else {
            EMIT_ZERO_BYTES((unsigned int)TYPE_SIZE(E(expression,8)));
            tree=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(object),tree);
            QUEUE_INIT_EXPR(tree);
            FREE_EXPR_TREE(expression);
        }
        SET_STREAM(saved_scope);
        tree=MAKE_SYMBOL_NODE(object);
finish_tree:
        tree=MAKE_UNARY_NODE(0x1D,tree);
        NO_ERRORS_YET=0;
        expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(COPY_EXPR_TREE(tree),0),0);
    }
    NO_ERRORS_YET=saved_parse && !ERROR_COUNT;
    saved_scope=SELECT_SYMBOL_STREAM(symbol);
    if(T(T(type,7),0)==0x11 && T(initial_type,0)==0x11 &&
       TL(T(type,7),9)!=0L && TL(T(type,7),9)!=TL(initial_type,9))
        REPORT_DIAGNOSTIC(MSG_CANNOT_INITIALIZE,(char far *)FORMAT_TYPE(type),FORMAT_TYPE(initial_type));
    if(!IS_CONSTANT_INITIALIZER(expression)) {
        tree=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(symbol),tree);
        EMIT_ZERO_BYTES((unsigned int)TYPE_SIZE(type));
        QUEUE_INIT_EXPR(tree);
        FREE_EXPR_TREE(expression);
    } else
        EMIT_CONST_INIT_VALUE(CONVERT_EXPR_TO_TYPE(MAKE_POINTER_TYPE(T(type,7),T(type,0),0),expression,0));
    SET_STREAM(saved_scope);
}
/* 03B1: retain the incoming source location before any scanner work. */
/* PARSE_OBJECT_INIT: parses the initializer of class object symbol: "= expression"
   (an initialization node), "(args)" (a constructor call through BUILD_INIT_CALL), or
   nothing (default construction; arrays element by element through
   INIT_VECTOR_ELEMENTS; arrays cannot take arguments, MSG_VECTORS_CLASSES_MUST).
   The result carries the position where the initializer started. */
unsigned int far pascal PARSE_OBJECT_INIT(unsigned int symbol,register unsigned int type)
{
    unsigned int initial;
    struct C29Location location;
    register unsigned int expression;
    location.file=CURRENT_TOKEN_RECORD.location.file;
    location.line=CURRENT_TOKEN_RECORD.location.line;
    location.column=CURRENT_TOKEN_RECORD.location.column;
    if(CURRENT_TOKEN==TOK_ASSIGN) {
        ADVANCE_TOKEN();
        expression=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(symbol),PARSE_ASSIGNMENT_EXPR(8));
    } else {
        initial=CURRENT_TOKEN==TOK_LPAREN ? PARSE_ARGUMENT_LIST(0) : 0;
        if(T(type,0)==0x11) {
            if(initial)
                expression=REPORT_EXPR_ERROR_PLAIN(MSG_VECTORS_CLASSES_MUST,0);
            else
                expression=INIT_VECTOR_ELEMENTS(MAKE_SYMBOL_NODE(symbol),type);
        } else
            expression=BUILD_INIT_CALL(MAKE_SYMBOL_NODE(symbol),type,initial,0,0);
    }
    LOCATION(expression)=location;
    return expression;
}
/* 0478: direct class setup or expression emission, then the original outer-chain update. */
/* INIT_CLASS_OBJECT: initializes class object symbol. "= {" is an aggregate list
   (INIT_DECLARATOR); anything else goes through PARSE_OBJECT_INIT, is checked and
   queued, and a static object's storage is reserved as zeros. At file scope the
   object's destructor is registered for the end of the program. */
void far pascal INIT_CLASS_OBJECT(register unsigned int symbol,register unsigned int type)
{
    long cursor;
    unsigned int saved_scope;
    unsigned int expression;
    unsigned char saved_parse;
    saved_parse=NO_ERRORS_YET;
    if(CURRENT_TOKEN==TOK_ASSIGN && (PEEK_TOKEN(),TOKEN_TYPE.kind)==5) {
        ADVANCE_TOKEN();
        INIT_DECLARATOR(symbol,type);
    } else {
        expression=PARSE_OBJECT_INIT(symbol,type);
        NO_ERRORS_YET=0;
        ANALYZE_AND_DECAY(COPY_EXPR_TREE(expression),VOID_TYPE);
        NO_ERRORS_YET=saved_parse && !ERROR_COUNT;
        QUEUE_INIT_EXPR(expression);
        if((SB(symbol,7)>>3)!=5) {
            saved_scope=SELECT_SYMBOL_STREAM(symbol);
            cursor=0L;
            PAD_TO_POSITION(TYPE_SIZE(type),&cursor);
            SET_STREAM(saved_scope);
        }
    }
    if(!BCC_TREE_SPECIAL.root)
        TEMP_DESTRUCTOR_LIST=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(symbol),type,TEMP_DESTRUCTOR_LIST);
}
/* 054E: initialize symbol category and pass the genuine LONG cursor output. */
/* DEFINE_SCALAR_INITIALIZER: turns symbol into a real variable of type initialized
   by the (non-constant) expression initial: at file scope a static (storage class 3)
   with storage in its data segment, inside a function an auto variable (class 5)
   registered with REGISTER_SYMBOL_VARIABLE; INIT_SCALAR does the initialization. */
void far pascal DEFINE_SCALAR_INITIALIZER(register unsigned int symbol,register unsigned int type,unsigned int initial)
{
    long cursor;
    unsigned int saved_scope;
    cursor=0L;
    saved_scope=0;
    S(symbol,8)=0;
    SB(symbol,6)|=3;
    S(symbol,4)=type;
    if(!BCC_TREE_SPECIAL.root) {
        SB(symbol,7)=(SB(symbol,7)&7)|0x18;
        PREPARE_SYMBOL(symbol);
        saved_scope=SELECT_SYMBOL_STREAM(symbol);
    } else {
        SB(symbol,7)=(SB(symbol,7)&7)|0x28;
        REGISTER_SYMBOL_VARIABLE(symbol);
    }
    INIT_SCALAR(symbol,type,&cursor,initial);
    if(!BCC_TREE_SPECIAL.root)
        SET_STREAM(saved_scope);
}
/* 05DE: scalar constant publication or the existing full initializer path. */
/* PARSE_CONST_INITIALIZER: initializer of a const scalar. A value known at compile
   time is stored in the symbol itself (SYM_CONST_VALUE: a long, or the 10-byte real)
   so uses fold to the constant (RESOLVE_SYMBOL_NODE in CPPCAST.C does that for storage
   class 9, probably set by the caller); otherwise the symbol
   becomes an ordinary initialized variable (DEFINE_SCALAR_INITIALIZER). An
   incompatible or non-arithmetic constant is reported and the symbol's type cleared. */
void far pascal PARSE_CONST_INITIALIZER(register unsigned int symbol,unsigned int type)
{
    register unsigned int expression;
    expression=ANALYZE_AND_DECAY(PARSE_ASSIGNMENT_EXPR(8),type);
    if(!IS_LINK_TIME_CONSTANT(expression))
        DEFINE_SCALAR_INITIALIZER(symbol,type,expression);
    else {
        expression=NULL_CONSTANT_TO_POINTER(type,expression);
        if(C7_TYPE_COMPAT(type,E(expression,8),NOT_ANSI_FLAG))
            expression=SIMPLIFY_EXPRESSION(CONVERT_EXPR_TO_TYPE(type,expression,0),0);
        else
            expression=REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE,(char far *)FORMAT_TYPE(E(expression,8)),FORMAT_TYPE(type),expression);
        if(E(expression,0)==2) {
            SL(symbol,8)=EL(expression,10);
store_type:
            S(symbol,4)=type;
        } else if(E(expression,0)==3) {
            RTL_MEMMOVE(MK_FP(SYMBOL_POOL_SEG,symbol+SYM_STORAGE),MK_FP(EXPR_POOL_SEG,expression+EXPR_LEFT),10);
            goto store_type;
        } else {
            expression=REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_INITIALIZATION,expression);
            S(symbol,4)=0;
            SL(symbol,8)=0L;
        }
        FREE_EXPR_TREE(expression);
    }
}
/* 06F3: aggregate construction; the final BYTE is a genuine unused incoming formal. */
/* CONSTRUCT_ARRAY_ELEMENTS: inside an aggregate initializer, the remaining count
   elements of class type (from position *cursor of array symbol) are default
   constructed: queues a call of VECTOR_NEW_SYMBOL (VECTOR_VNEW_SYMBOL with virtual
   bases) with the address, element size, element count, mode and the default
   constructor, and pads a static array's storage up to the end. forbidden reports
   MSG_ARRAY_SIZE_TOO_LARGE instead. */
void far pascal CONSTRUCT_ARRAY_ELEMENTS(long count,register unsigned int symbol,register unsigned int type,
    long far *cursor,unsigned char forbidden,unsigned char unused)
{
    unsigned int constructor;
    unsigned int target;
    unsigned int expression;
    unsigned int owner_type;
    if(forbidden) {
        REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        return;
    }
    while(T(type,0)==0x11) {
        count*=TL(type,9);
        type=T(type,7);
    }
    constructor=FIND_DEFAULT_CTOR(type,1);
    if(!constructor) {
        REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE_225,(char far *)FORMAT_SPECIAL_MEMBER(5,0,type),0L);
        return;
    }
    target=MAKE_SYMBOL_NODE(symbol);
    E(target,12)+=(unsigned int)*cursor;
    owner_type=(LINK(T(type,5),24)&4)?VECTOR_VNEW_SYMBOL:VECTOR_NEW_SYMBOL;
    expression=MAKE_CALL_NODE(
        MAKE_SYMBOL_NODE(owner_type),
        MAKE_CAST_NODE(FAR_VOID_PTR_TYPE,MAKE_UNARY_NODE(0x1D,target)),
        MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type)),
        MAKE_INT_CONSTANT(INT_TYPE,count),
        MAKE_INT_CONSTANT(INT_TYPE,(long)(int)DESTRUCTOR_CALL_FLAGS(type,constructor)),
        MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(constructor)));
    QUEUE_INIT_EXPR(expression);
    if((SB(symbol,7)>>3)!=5)
        PAD_TO_POSITION(*cursor+count*TYPE_SIZE(type),cursor);
}
