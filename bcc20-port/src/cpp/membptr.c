/* membptr.c: from bcc20/src/cpp/MEMBPTR.C: two small helpers of the unary & operator
   (expr/UNARYOP.C).  MAKE_MEMBER_POINTER turns &X::f, the address of a member function,
   into a pointer-to-member constant: a node with operator 48h whose type is a pointer with
   mode 0Bh (member pointer), whose EXPR_LEFT is the offset of the base class X inside the
   function's own class, whose EXPR_RIGHT is, for a virtual function, the offset of the
   class's virtual table pointer member and 0 otherwise, and whose word 0Eh is the function
   symbol.  MAKE_INITIALIZED_TEMP handles & applied to a value that must first be put in a
   temporary object: it creates the temporary symbol and, when code is still being
   generated or the temporary is at file scope, queues its initializer on
   PENDING_INIT_LIST (6-byte records in INIT_RECORD_POOL_SEG: next, symbol, packed
   initializer tree), which CPPFINAL.C writes out as the temporaries' initial data. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define EB(n, o) EXPR_B((n), (o))
#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define S(n, o) SYM_W((n), (o))
#define M(n, o) MEMBER_W((n), (o))

/* expression is an & node over a symbol node of a function.  When the function belongs to
   a class and fresh is 0, checks access from CURRENT_CLASS_TYPE and that the name was
   qualified, then frees both nodes and returns a new member-pointer constant.  In C, for a
   non-member function, or with fresh set, the & node comes back unchanged.  In C++ the
   function symbol always goes to QUEUE_DEFERRED_SYMBOL, since its address is now taken */
u16 MAKE_MEMBER_POINTER(u16 expression, u8 fresh)
{
    if (!CPP_MODE)
        return expression;
    u16 child = E(expression, 10);
    u16 symbol = E(child, 10);
    if (CPP_MODE)
        QUEUE_DEFERRED_SYMBOL(symbol);
    if (fresh || !T(E(child, 8), 3))
        return expression;
    if (!SYMBOL_ACCESSIBLE(symbol, CURRENT_CLASS_TYPE))
        return REPORT_EXPR_ERROR(0xB6, FORMAT_SYMBOL(symbol), 0, expression);
    if (!E(child, 14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS, expression);
    u16 result = ALLOC_EXPR_NODE();
    E(result, 0) = 0x48;
    u16 type = MAKE_POINTER_TYPE(E(child, 8), 0x0D, 0);
    E(result, 8) = type;
    TB(E(result, 8), 13) = 0x0B;
    E(result, 14) = symbol;
    type = S(S(symbol, 0), 4);
    u16 offset = GET_BASE_OFFSET(E(child, 14), type);
    E(result, 10) = offset;
    if (S(symbol, 21)) {
        u16 member = BCC_MEMBER_LOOKUP(type);
        E(result, 12) = M(member, 6);
    } else
        E(result, 12) = 0;
    EB(result, 6) |= 1;
    FREE_EXPR_NODE(expression);
    FREE_EXPR_NODE(child);
    return result;
}

/* a temporary symbol of the expression's type; returns an analyzed symbol node for it,
   consuming the expression.  When code generation is still on, or at global scope, the
   expression is first wrapped in a list node, packed and queued with the symbol on
   PENDING_INIT_LIST as the temporary's initializer */
u16 MAKE_INITIALIZED_TEMP(u16 expression)
{
    u16 symbol = CREATE_TEMP_SYMBOL(E(expression, 8), 1);
    if (NO_ERRORS_YET || CURRENT_SCOPE == GLOBAL_SCOPE) {
        u16 record = POOL_ALLOC_REUSE(INIT_RECORD_POOL_SEG_P, 6);
        MINIT_W(record, 0) = PENDING_INIT_LIST;
        PENDING_INIT_LIST = record;
        MINIT_W(record, 2) = symbol;
        expression = MAKE_LIST_NODE(expression, 0);
        u16 packed = PACK_EXPR_TREE(expression);
        MINIT_W(record, 4) = packed;
    }
    FREE_EXPR_TREE(expression);
    return ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(symbol), 0, 0);
}
