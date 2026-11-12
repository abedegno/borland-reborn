/* target: ovr079_C23UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ expressions: builds pointer-to-member values (&X::m) and initialized temporary
   objects. Entry points: MAKE_MEMBER_POINTER, MAKE_INITIALIZED_TEMP. Map of all sources:
   docs/SOURCE-MAP.md. */
#include <dos.h>
#include "MEMBPTR.H"
#include "MSG.H"
#include "POOL.H"
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define EB(n,o) AT_B(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define M(n,o) AT_W(MEMBER_SEGMENT,(unsigned int)(n)+(o))

/* Overview: two small helpers of the unary & operator (expr/UNARYOP.C).
   MAKE_MEMBER_POINTER turns &X::f, the address of a member function, into a
   pointer-to-member constant: an expression node with operator 0x48 whose type is a
   pointer with mode 0x0B (member pointer), whose EXPR_LEFT is the offset of the base
   class X inside the function's own class, whose EXPR_RIGHT is, for a virtual
   function, the offset of the class's virtual table pointer member (found by
   BCC_MEMBER_LOOKUP) and 0 otherwise, and whose word 0x0E is the function symbol.
   MAKE_INITIALIZED_TEMP handles & applied to a value that must first be put in a
   temporary object: it creates the temporary symbol and, when code is still being
   generated or the temporary is at file scope, queues its initializer on
   PENDING_INIT_LIST (6-byte records in INIT_RECORD_POOL_SEG: next, symbol, packed
   initializer tree), whose values FLUSH_PENDING_INITIALIZERS in CPPFINAL.C writes
   out as the temporaries' initial data.
   The code still uses raw offsets through the local E/T/S/M macros: E(n,8) is
   EXPR_TYPE, E(n,10) EXPR_LEFT, S(n,0)/S(n,4) SYM_OWNER_CLASS/SYM_TYPE, S(n,21)
   SYM_VIRTUAL_INDEX, T(n,3) TYPE_MEMBER_CLASS, TB(n,13) TYPE_PTR_MODE, M(n,6)
   MEMB_VALUE. CPP_MODE is set from OPTION_FLAGS bit 0 in INIT_PARSER and is
   tested wherever C++-only rules apply, so it probably means "compiling C++". */

/* MAKE_MEMBER_POINTER: expression is an & node over a symbol node of a function.
   When the function belongs to a class (its type has a member class) and fresh is 0,
   checks access from CURRENT_CLASS_TYPE (message 0xB6, probably "not accessible") and
   that the name was qualified (EXPR_SCOPE_CLASS at word 14 of the symbol node; else
   MSG_USE_TAKE_ADDRESS), then frees both nodes and returns a new 0x48 member-pointer
   constant. In C mode, for a non-member function, or with fresh set, it returns the
   & node unchanged. In C++ the function symbol is always passed to
   QUEUE_DEFERRED_SYMBOL, which queues an inline function for an out-of-line copy
   at the end of the file, since its address is now taken. EXPR_LEFT of the result
   comes from GET_BASE_OFFSET(qualifying class, function's class). */
/* 0000: preserve both early-return ownership and the two separate releases. */
unsigned int far pascal MAKE_MEMBER_POINTER(unsigned int expression,unsigned char fresh)
{
    unsigned int member;
    unsigned int symbol;
    unsigned int type;
    register unsigned int result;
    register unsigned int child;
    if(!CPP_MODE)
        return expression;
    child=E(expression,10);
    symbol=E(child,10);
    if(CPP_MODE)
        QUEUE_DEFERRED_SYMBOL(symbol);
    if(fresh || !T(E(child,8),3))
        return expression;
    if(!SYMBOL_ACCESSIBLE(symbol,CURRENT_CLASS_TYPE))
        return REPORT_EXPR_ERROR(0xB6,FORMAT_SYMBOL(symbol),0L,expression);
    if(!E(child,14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS,expression);
    result=ALLOC_EXPR_NODE();
    E(result,0)=0x48;
    E(result,8)=MAKE_POINTER_TYPE(E(child,8),0x0D,0);
    TB(E(result,8),13)=0x0B;
    E(result,14)=symbol;
    type=S(S(symbol,0),4);
    E(result,10)=GET_BASE_OFFSET(E(child,14),type);
    if(S(symbol,21)) {
        member=BCC_MEMBER_LOOKUP(type);
        E(result,12)=M(member,6);
    } else
        E(result,12)=0;
    EB(result,6)|=1;
    FREE_EXPR_NODE(expression);
    FREE_EXPR_NODE(child);
    return result;
}

/* MAKE_INITIALIZED_TEMP: creates a temporary symbol of the expression's type and
   returns an analyzed symbol node for it, consuming the expression. When code
   generation is still on (NO_ERRORS_YET, cleared after errors) or we are at global
   scope, the expression is first wrapped in a list node, packed and queued with the
   symbol on PENDING_INIT_LIST as the temporary's initializer. */
/* 0160: optional six-byte registry record, then consume and rebuild expression. */
unsigned int far pascal MAKE_INITIALIZED_TEMP(register unsigned int expression)
{
    unsigned int symbol;
    unsigned int record;
    symbol=CREATE_TEMP_SYMBOL(E(expression,8),1);
    if(NO_ERRORS_YET || CURRENT_SCOPE==GLOBAL_SCOPE) {
        record=POOL_ALLOC_REUSE(&INIT_RECORD_POOL_SEG,6);
        AT_W(INIT_RECORD_POOL_SEG,record)=PENDING_INIT_LIST;
        PENDING_INIT_LIST=record;
        AT_W(INIT_RECORD_POOL_SEG,record+2)=symbol;
        expression=MAKE_LIST_NODE(expression,0);
        AT_W(INIT_RECORD_POOL_SEG,record+4)=PACK_EXPR_TREE(expression);
    }
    FREE_EXPR_TREE(expression);
    return ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(symbol),0,0);
}
