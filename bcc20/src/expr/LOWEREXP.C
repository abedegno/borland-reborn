/* target: ovr098_C40UNIT */
/* Role: expressions: lowers expression trees before code generation, probably turning
   member-pointer constants into initialized temporaries. Entry points: LOWER_EXPRESSION.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the last step of the C++-mode front end before code generation. The back end is
   shared with the C compiler and understands the C-mode tree shapes, so
   LOWER_EXPRESSION rewrites a fully analysed C++ tree into that form. It is called by
   codegen/STMTBLK.C for each expression it puts into a flow block. Changes made, in
   place where possible:
   - enum types become their underlying integer type; member function pointers become
     the struct MEMBER_PTR_CLASS_TYPE;
   - operator 0x42 (probably dereferencing a reference) becomes EOP_DEREF;
   - "." with a bitfield member becomes a bitfield node (0x33);
   - symbol leaves become the back end's leaf kinds (5 for automatic and register
     variables, 4 with a segment for storage class 7) and point at the symbol's prepared
     storage record (PREPARE_SYMBOL);
   - ++ / -- become x++ / x-- (EOP_POSTINC/EOP_POSTDEC) or x += step / x -= step;
   - pointer minus pointer gets its own operator 0x2C;
   - assignment of arrays is marked as a struct copy;
   - call argument lists are reversed (see the comment in LOWER_EXPR_TREE);
   - a member pointer constant (operator 0x48) becomes a static temporary of type
     MEMBER_PTR_CLASS_TYPE whose initialiser is queued on PENDING_INIT_LIST (emitted
     later by cpp/CPPFINAL.C).
   Finally every node gets EXPR_KIND set from its type and its flag bytes cleared. */
/* Lower expression forms and their saved symbol argument streams. */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
#include <dos.h>
#include "LOWEREXP.H"
#include "MSG.H"
#include "POOL.H"
/* LOWER_OP48_TO_TEMP_SYMBOL: replaces the member pointer constant "expression" by a new
   static temporary (CREATE_TEMP_SYMBOL, storage class set to 4) and queues an
   initialiser record {next, symbol, packed value list} on PENDING_INIT_LIST. The value
   list (built back to front with MAKE_LIST_NODE) holds the member offset (EXPR_LEFT),
   the virtual function index and then either the vtable slot data (virtual) or the
   function's address (with a 0 for a flag 0x40 function type); a null member pointer
   (no symbol) is two long zeros. */
static void far pascal LOWER_OP48_TO_TEMP_SYMBOL(unsigned int expression)
{
    unsigned int record,symbol,type;
    register unsigned int arguments;
    record=POOL_ALLOC_REUSE(&INIT_RECORD_POOL_SEG,6);
    AT_W(INIT_RECORD_POOL_SEG,record)=PENDING_INIT_LIST;
    PENDING_INIT_LIST=record;
    AT_W(INIT_RECORD_POOL_SEG,record+2)=CREATE_TEMP_SYMBOL(MEMBER_PTR_CLASS_TYPE,1);
    SYM_B(AT_W(INIT_RECORD_POOL_SEG,record+2),SYM_STORAGE_CLASS)=(SYM_B(AT_W(INIT_RECORD_POOL_SEG,record+2),SYM_STORAGE_CLASS)&7)|0x20;
    arguments=0;
    symbol=EXPR_W(expression,EXPR_SCOPE_CLASS);
    type=SYM_W(symbol,SYM_TYPE);
    if(!symbol) {
        arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(LONG_TYPE,0L),arguments);
        EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
        arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(LONG_TYPE,0L),arguments);
        EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
    } else {
        if(SYM_W(symbol,SYM_VIRTUAL_INDEX)) {
            arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,0L),arguments);
            EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
            arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,(long)(int)EXPR_W(expression,EXPR_RIGHT)),arguments);
        } else {
            if(TYPE_B(type,TYPE_FUNC_FLAGS)&0x40) {
                arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,0L),arguments);
                EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
            }
            arguments=MAKE_LIST_NODE(BUILD_SYMBOL_EXPR(symbol),arguments);
        }
        EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
        arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,(long)SYM_W(symbol,SYM_VIRTUAL_INDEX)),arguments);
        EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
        arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,(long)(int)EXPR_W(expression,EXPR_LEFT)),arguments);
        EXPR_B(arguments,EXPR_NODE_FLAGS)|=1;
    }
    EXPR_W(expression,EXPR_OP)=1;
    EXPR_W(expression,EXPR_LEFT)=AT_W(INIT_RECORD_POOL_SEG,record+2);
    EXPR_W(expression,EXPR_SCOPE_CLASS)=0;
    EXPR_W(expression,EXPR_RIGHT)=0;
    EXPR_W(expression,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
    AT_W(INIT_RECORD_POOL_SEG,record+4)=PACK_EXPR_TREE(arguments);
    C0MARK(1);
}
/* MAKE_STEP_CONSTANT: the amount ++ and -- add for a value of type: 1.0 for floating
   types, the size of the target for pointers (as long for huge pointers), 1 otherwise. */
static unsigned int far pascal MAKE_STEP_CONSTANT(register unsigned int type)
{
    if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&2) return MAKE_REAL_CONSTANT(type,&REAL_ONE);
    if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14)
        return MAKE_INT_CONSTANT(TYPE_W(type,TYPE_KIND)==TK_HUGE_PTR?LONG_TYPE:INT_TYPE,TYPE_SIZE(TYPE_W(type,TYPE_TARGET)));
    return MAKE_INT_CONSTANT(type,1L);
}
/* LOWER_EXPR_TREE: lowers one tree recursively (see the overview) and returns it. The
   stack check guards against very deep trees: below SP 0x8F0C it gives up with
   MSG_OUT_MEMORY. Operands are normally lowered right before left. */
static unsigned int far pascal LOWER_EXPR_TREE(unsigned int expression)
{
    register unsigned int result=expression;
    unsigned int node,previous,next;
    /* The native routine observes the architectural stack pointer here. */
    if(_SP<0x8f0c) REPORT_FATAL(MSG_OUT_MEMORY);
    if(!result) return result;
    EXPR_W(result,EXPR_QUAL_FLAGS)=0;
    if(TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_KIND)==TK_ENUM) EXPR_W(result,EXPR_TYPE)=AT_W(TAG_BODY_POOL_SEG,TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_TAG_BODY)+4);
    else if(TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR && TYPE_B(EXPR_W(result,EXPR_TYPE),TYPE_PTR_MODE)==0xB && TYPE_W(TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)
        EXPR_W(result,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
    switch(EXPR_W(result,EXPR_OP)) {
    case 0:case EOP_CONST:case 3:case 5:case 7:case 0x33:case 0x39:
        break;
    case 0x42:
        EXPR_W(result,EXPR_OP)=EOP_DEREF;
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        break;
    case EOP_DOT: {
        unsigned char high,low;
        unsigned int child;
        child=EXPR_W(expression,EXPR_RIGHT);
        low=EXPR_B(child,EXPR_MEMB_BIT_SHIFT);high=EXPR_B(child,EXPR_MEMB_BIT_WIDTH);
        FREE_EXPR_NODE(child);
        EXPR_W(result,EXPR_OP)=0x33;
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPRESSION(EXPR_W(expression,EXPR_LEFT));
        EXPR_B(result,EXPR_BIT_WIDTH)=high;EXPR_B(result,EXPR_BIT_SHIFT)=low;
        break;
    }
    case 0x48:
        LOWER_OP48_TO_TEMP_SYMBOL(expression);
        /* The original kind48 lowers to the same symbol operations as kind1. */
    case 1:
        switch(SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_STORAGE_CLASS)>>3) {
        case 5:case 6:
            EXPR_W(result,EXPR_OP)=5;
            break;
        case 1:case 2:case 3:
            SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_FLAGS)|=4;
            break;
        case 7:
            EXPR_W(result,EXPR_OP)=4;
            EXPR_W(result,EXPR_RIGHT)=GET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(EXPR_W(expression,EXPR_LEFT)));
            break;
        }
        EXPR_W(result,EXPR_LEFT)=PREPARE_SYMBOL(EXPR_W(expression,EXPR_LEFT));
        EXPR_W(result,EXPR_QUAL_FLAGS)=GET_PREPARED_FLAGS(EXPR_W(result,EXPR_LEFT));
        break;
    /* call: lower callee and argument list, then reverse the list of cells (linked
       through EXPR_LEFT, item in EXPR_RIGHT); the first cell is dropped and its item
       itself ends the reversed chain, probably the shape the back end expects */
    case 0x36:
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        EXPR_W(result,EXPR_RIGHT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_RIGHT));
        if(!EXPR_W(result,EXPR_RIGHT)) break;
        node=EXPR_W(result,EXPR_RIGHT);previous=EXPR_W(node,EXPR_LEFT);
        if(!previous) EXPR_W(result,EXPR_RIGHT)=EXPR_W(node,EXPR_RIGHT);
        else {
            next=EXPR_W(previous,EXPR_LEFT);
            EXPR_W(previous,EXPR_LEFT)=EXPR_W(node,EXPR_RIGHT);node=previous;
            while(next) {
                previous=next;next=EXPR_W(previous,EXPR_LEFT);
                EXPR_W(previous,EXPR_LEFT)=node;node=previous;
            }
            EXPR_W(result,EXPR_RIGHT)=node;
        }
        break;
    /* an assignment of an array type is a block copy: mark it as a struct assignment */
    case EOP_ASSIGN:
        EXPR_W(result,EXPR_RIGHT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_RIGHT));
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        if(TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_KIND)==TK_ARRAY) {
            EXPR_W(result,EXPR_KIND)=TK_STRUCT;
            EXPR_W(EXPR_W(result,EXPR_RIGHT),EXPR_KIND)=TK_STRUCT;
            EXPR_W(EXPR_W(result,EXPR_LEFT),EXPR_KIND)=TK_STRUCT;
            EXPR_B(result,EXPR_NODE_FLAGS)=0;EXPR_B(result,EXPR_NODE_FLAGS2)=0;
            return result;
        }
        break;
    /* flag 2 marks the postfix form */
    case EOP_INC:
        EXPR_W(result,EXPR_OP)=(EXPR_B(expression,EXPR_NODE_FLAGS)&2)?0x23:0x13;
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        EXPR_W(result,EXPR_RIGHT)=LOWER_EXPR_TREE(MAKE_STEP_CONSTANT(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE)));
        break;
    case EOP_DEC:
        EXPR_W(result,EXPR_OP)=(EXPR_B(expression,EXPR_NODE_FLAGS)&2)?0x24:0x14;
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        EXPR_W(result,EXPR_RIGHT)=LOWER_EXPR_TREE(MAKE_STEP_CONSTANT(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE)));
        break;
    case 0x35:
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        break;
    /* pointer - pointer: operator 0x2C (probably divided by the element size later) */
    case EOP_SUB:
        if((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14)&&
           (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x14)) EXPR_W(result,EXPR_OP)=0x2C;
        /* Both outcomes enter the original common right-before-left recursion. */
    default:
        EXPR_W(result,EXPR_RIGHT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_RIGHT));
        EXPR_W(result,EXPR_LEFT)=LOWER_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        break;
    }
    EXPR_B(result,EXPR_NODE_FLAGS)=0;EXPR_B(result,EXPR_NODE_FLAGS2)=0;
    if(EXPR_W(result,EXPR_OP)) EXPR_W(result,EXPR_KIND)=TYPE_W(EXPR_W(result,EXPR_TYPE),TYPE_KIND);
    return result;
}
/* LOWER_EXPRESSION: entry point; lowers expression for the back end. */
unsigned int far pascal LOWER_EXPRESSION(unsigned int expression)
{
    unsigned int result=LOWER_EXPR_TREE(expression);
    return result;
}
