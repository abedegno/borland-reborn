/* target: ovr062_C6BUILD */
/* opts: -mm -G- -O -Z -p -Y */
/* Role: unary-operator expression builders. Entry points: BUILD_DEREF, BUILD_ADDRESS_OF,
   BUILD_INCDEC, BUILD_UNARY_ARITH, BUILD_COMPLEMENT, BUILD_LOGICAL_NOT. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: semantic analysis of the unary operators in the C++-mode front end: *p, &x,
   ++/--, unary + and -, ~ and !. The expression analyser (expr/EXPRDISP.C) calls the
   BUILD_* function for a node whose operand has not been analysed yet; each one
   analyses the operand, checks it, sets the node's result type and marks it analysed
   (EXPR_NODE_FLAGS bit 1), or replaces the node by an error node through
   REPORT_EXPR_ERROR_PLAIN (message 0 when the operand already carried an error).
   C6PRE is the common first step. Its "operation" argument is an EXPR_FLAGS mask of
   the operand types the operator accepts (0x14 pointers, 3 arithmetic, 1 integral, 7
   scalar, 0 for ++/--), handed on to the C++ user-defined conversion search; "hint" is
   the type the result is wanted in, if known.
   In C++ mode (CPP_MODE) an operand of class type may select an overloaded
   operator (TRY_UNARY_OPERATOR_CALL) or a conversion function, and references are
   looked through. BUILD_ADDRESS_OF is the long one: besides &object it handles
   &function, &Class::member (a member pointer constant, stored as offset + 1 so that 0
   can be the null member pointer) and the near-pointer mode of addresses of stack
   variables when DS may differ from SS. INT_TYPE is the int type. */
/* Complete authentic context original0000..0902, including two accepted bodies. */
#include <dos.h>
#include "BUILD6.H"
#include "MSG.H"
#include "POOL.H"

/* C6PRE: analyses and converts to an rvalue the operand of the unary node *output
   (hint: wanted type, VOID_TYPE treated as none), rejects error and void operands, tries
   a user-defined operator or conversion in C++, and turns an enum operand into int.
   Returns 1 when *output has been replaced (error node or operator call) and the caller
   must return it as it is; 0 to continue. */
static unsigned char near pascal C6PRE(unsigned int far *output,
    unsigned int context,register unsigned int hint,unsigned int operation)
{
    register unsigned int node=*output;

    if(hint==VOID_TYPE)
        hint=0;
    EXPR_W(node,EXPR_LEFT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),hint,0));
    if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0) {
        *output=REPORT_EXPR_ERROR_PLAIN(0,*output);
        return 1;
    }
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_VOID) {
        *output=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,*output);
        return 1;
    }
    if(CPP_MODE) {
        if(TRY_UNARY_OPERATOR_CALL(output,operation,context))
            return 1;
        if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)
            EXPR_W(node,EXPR_LEFT)=APPLY_CONVERSION_FUNCTION(EXPR_W(node,EXPR_LEFT),operation,hint);
    }
    EXPR_W(node,EXPR_LEFT)=NODE_ENUM_TO_INT(EXPR_W(*output,EXPR_LEFT));
    return 0;
}

/* BUILD_DEREF: analyses *p. A based near pointer is first made a normal pointer
   (APPLY_BASED_POINTER). *f for a function pointer f gives f itself unless keep is set
   (keep is used when the & of &*f will follow). Errors: not a pointer, pointer to
   void, pointer to an object of unknown size. The result type is the target type. */
unsigned int far pascal BUILD_DEREF(unsigned int expression,unsigned int context,
    unsigned char keep)
{
    register unsigned int node;
    register unsigned int kind;

    node=ANALYZE_EXPRESSION(EXPR_W(expression,EXPR_LEFT),0,0);
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR && TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_PTR_BASE)!=0)
        node=APPLY_BASED_POINTER(node);
    EXPR_W(expression,EXPR_LEFT)=node;
    if(C6PRE(&expression,context,0,0x14))
        return expression;
    node=EXPR_W(expression,EXPR_LEFT);
    kind=TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND);
    if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14) &&
            TYPE_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) {
        if(!keep) {
            FREE_EXPR_NODE(expression);
            return node;
        }
    } else if(!(EXPR_FLAGS[kind]&0x14))
        return REPORT_EXPR_ERROR_PLAIN(!kind?0:MSG_INVALID_INDIRECTION,expression);
    if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14) &&
            TYPE_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,expression);
    if(TYPE_SIZE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET))==0L &&
            !((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14) &&
              TYPE_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) &&
            TYPE_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)!=TK_ARRAY)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,expression);
    EXPR_W(expression,EXPR_TYPE)=TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET);
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    return expression;
}

/* C6PRED: 1 when node (looking through ".") is a register variable, whose address cannot
   be taken: in C++ storage class 7; in C an automatic or parameter (class 5 or 6) with
   SYM_FLAGS bit 8. */
static unsigned char near pascal C6PRED(register unsigned int node)
{
    while(node && EXPR_W(node,EXPR_OP)==EOP_DOT)
        node=EXPR_W(node,EXPR_LEFT);
    if(node && EXPR_W(node,EXPR_OP)==1) {
        if(CPP_MODE)
            return (SYM_B(EXPR_W(node,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==7;
        return ((SYM_B(EXPR_W(node,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==5 ||
                (SYM_B(EXPR_W(node,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==6) &&
            (SYM_B(EXPR_W(node,EXPR_LEFT),SYM_FLAGS)&8);
    }
    return 0;
}

/* C6KIND: pointer kind for the address of node: TK_FAR_PTR (0x0F) for a far variable
   (SYM_FLAGS 0x80) or *p with p a _seg pointer, the kind of p for other *p, else 0 to
   let MAKE_POINTER_TYPE choose the default. */
static unsigned int far pascal C6KIND(register unsigned int node)
{
    while(EXPR_W(node,EXPR_OP)==EOP_DOT)
        node=EXPR_W(node,EXPR_LEFT);
    if(EXPR_W(node,EXPR_OP)==1) {
        if(SYM_B(EXPR_W(node,EXPR_LEFT),SYM_FLAGS)&0x80)
            return 0x0F;
    } else if(EXPR_W(node,EXPR_OP)==EOP_DEREF) {
        if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_SEG_PTR)
            return 0x0F;
        return TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND);
    }
    return 0;
}

/* BUILD_ADDRESS_OF: analyses &x. fresh is 0 when the node was already an EOP_ADDR node
   (an explicit & as opposed to an implied one, probably), which matters for the
   "superfluous & with function" warning and for operator& overloading; policy is passed
   on when resolving an overloaded function name. Returns the analysed node, a member
   pointer constant, or an error node. */
unsigned int far pascal BUILD_ADDRESS_OF(unsigned int expression,unsigned int context,
    unsigned int policy)
{
    unsigned char needs_check;
    unsigned char fresh;
    unsigned char special;
    unsigned int record;
    unsigned int new_type;
    register unsigned int type;
    register unsigned int symbol;

    fresh=EXPR_W(expression,EXPR_OP)!=EOP_ADDR;
    EXPR_W(expression,EXPR_OP)=EOP_ADDR;
    special=0;
    /* C++: a symbol of storage class 9 (probably a named constant) needs an initialised temporary to have an address */
    if(CPP_MODE && EXPR_W(expression,EXPR_LEFT)!=0 &&
            EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1)
        special=(SYM_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==9;
    if(!(EXPR_B(EXPR_W(expression,EXPR_LEFT),EXPR_NODE_FLAGS)&1)) {
        if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==EOP_DEREF)
            EXPR_W(expression,EXPR_LEFT)=BUILD_DEREF(EXPR_W(expression,EXPR_LEFT),0,1);
        else if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==EOP_DOT)
            EXPR_W(expression,EXPR_LEFT)=CHECK_DOT_MEMBER(EXPR_W(expression,EXPR_LEFT),1);
        else
            EXPR_W(expression,EXPR_LEFT)=ANALYZE_EXPRESSION(EXPR_W(expression,EXPR_LEFT),0,0);
    }
    if(CPP_MODE &&
            (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14) &&
            (TYPE_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_ATTRS)&0x20))
        EXPR_W(expression,EXPR_LEFT)=DEREF_REFERENCE_EXPR(EXPR_W(expression,EXPR_LEFT));
    if(TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) {
        if(CPP_MODE && EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1) {
            EXPR_B(EXPR_W(expression,EXPR_LEFT),EXPR_NODE_FLAGS)&=0xFE;
            EXPR_W(expression,EXPR_LEFT)=RESOLVE_SYMBOL_REFERENCE(EXPR_W(expression,EXPR_LEFT),policy);
        }
        if(!CPP_MODE && !fresh)
            REPORT_CURRENT_TOKEN(MSG_SUPERFLUOUS_FUNCTION);
    } else if(TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)!=TK_ARRAY &&
            EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)!=0x4A)
        EXPR_W(expression,EXPR_LEFT)=DECAY_TO_POINTER(EXPR_W(expression,EXPR_LEFT));
    if(CPP_MODE)
        EXPR_W(expression,EXPR_LEFT)=REWRITE_FOR_REFERENCE_BIND(EXPR_W(expression,EXPR_LEFT));
    needs_check=IS_LVALUE(EXPR_W(expression,EXPR_LEFT));
    type=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
    if(TYPE_W(type,TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,expression);
    if(CPP_MODE && !fresh) {
        if(TRY_UNARY_OPERATOR_CALL(&expression,0,context))
            return expression;
    }
    /* the result is a pointer to the operand's type */
    EXPR_W(expression,EXPR_TYPE)=MAKE_POINTER_TYPE(type,C6KIND(EXPR_W(expression,EXPR_LEFT)),0);
    if(special) {
        EXPR_W(expression,EXPR_LEFT)=MAKE_INITIALIZED_TEMP(EXPR_W(expression,EXPR_LEFT));
        needs_check=1;
    }
    if(!needs_check)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED,expression);
    if(C6PRED(EXPR_W(expression,EXPR_LEFT)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_MUST_TAKE_ADDRESS,expression);
    /* address of a named variable: automatics and parameters get pointer mode 3 (probably
       SS-relative) when DS may differ from SS; a function is marked "address taken" */
    if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1) {
        symbol=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT);
        if(((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==5 || (SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==6) &&
                (OPTION_DS_NOT_SS ||
                 ((signed char)MODEL_FAR_DATA & !(signed char)OPTION_SS_EQUALS_DS)))
            TYPE_B(EXPR_W(expression,EXPR_TYPE),TYPE_PTR_MODE)=3;
        if(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_FUNCTION) {
            SYM_W(symbol,SYM_FUNC_FLAGS)|=8;
            return CPP_MODE?MAKE_MEMBER_POINTER(expression,fresh):expression;
        }
        if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)<=6)
            return expression;
        return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED,expression);
    }
    /* &Class::member (operator 0x4A): a member pointer constant, offset + 1 */
    if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==0x4A) {
        record=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT);
        new_type=MAKE_POINTER_TYPE(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),0x0D,0);
        if(!MEMBER_ACCESSIBLE(record,CURRENT_CLASS_TYPE))
            return REPORT_EXPR_ERROR(0xB6,FORMAT_MEMBER(record),0L,expression);
        if(MEMBER_B(record,MEMB_FLAGS)&0x40)
            return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_TAKE_ADDRESS,expression);
        if(TYPE_W(type,TYPE_MEMBER_CLASS)==0) {
            type=COPY_TYPE_RECORD(type);
            TYPE_W(type,TYPE_MEMBER_CLASS)=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_RIGHT);
            TYPE_W(new_type,TYPE_TARGET)=type;
        }
        TYPE_B(new_type,TYPE_PTR_MODE)=0x0B;
        FREE_EXPR_TREE(expression);
        return MAKE_INT_CONSTANT(new_type,(long)MEMBER_W(record,MEMB_VALUE)+1L);
    }
    /* &object.member: bitfields have no address; for member functions only the qualified
       form (node flag 2) gives a member pointer */
    if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==EOP_DOT) {
        if(TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) {
            record=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT);
            if(EXPR_B(EXPR_W(expression,EXPR_LEFT),EXPR_NODE_FLAGS)&2) {
                FREE_EXPR_NODE(record);
                record=EXPR_W(expression,EXPR_LEFT);
                EXPR_W(expression,EXPR_LEFT)=EXPR_W(record,EXPR_RIGHT);
                FREE_EXPR_NODE(record);
                SYM_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT),SYM_FUNC_FLAGS)|=8;
                return MAKE_MEMBER_POINTER(expression,fresh);
            }
            return REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS,expression);
        }
        if(EXPR_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_RIGHT),EXPR_NODE_FLAGS)&4)
            return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_TAKE_ADDRESS,expression);
    }
    return expression;
}

/* Complete authentic remaining original0902..0CC6. Earlier PRE is real context. */
#include "TAIL6.H"

/* BUILD_INCDEC: analyses ++x / --x / x++ / x--: the operand must be a modifiable lvalue
   of scalar type, and a pointer must point to a type of known size. */
unsigned int far pascal BUILD_INCDEC(unsigned int expression,unsigned int context)
{
    if(C6PRE(&expression,context,0,0))
        return expression;
    if(CPP_MODE)
        EXPR_W(expression,EXPR_LEFT)=REWRITE_FOR_REFERENCE_BIND(EXPR_W(expression,EXPR_LEFT));
    if(!IS_LVALUE(EXPR_W(expression,EXPR_LEFT)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED,expression);
    if(!IS_MODIFIABLE_NODE(EXPR_W(expression,EXPR_LEFT)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST,expression);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&7))
        return REPORT_EXPR_ERROR_PLAIN((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)?MSG_ILLEGAL_STRUCTURE:MSG_EXPRESSION_SCALAR_TYPE,expression);
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
    if((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14) &&
            TYPE_SIZE(TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_TARGET))==0L)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,expression);
    return expression;
}

/* BUILD_UNARY_ARITH: analyses unary + and -: the operand must be arithmetic. A small
   integer operand is promoted to int unless the wanted type (hint) is itself smaller
   than int and the operand is signed, probably so char arithmetic can stay narrow. */
unsigned int far pascal BUILD_UNARY_ARITH(unsigned int expression,unsigned int context,
    register unsigned int hint)
{
    register unsigned int node;

    if(C6PRE(&expression,context,hint,3))
        return expression;
    node=EXPR_W(expression,EXPR_LEFT);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&3))
        return REPORT_EXPR_ERROR_PLAIN((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x40)?MSG_ILLEGAL_STRUCTURE:MSG_EXPRESSION_ARITHMETIC,expression);
    if(TYPE_SIZE(EXPR_W(node,EXPR_TYPE))<(long)INT_TYPE_SIZE &&
            ((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x20) ||
             !hint || TYPE_SIZE(hint)>=(long)INT_TYPE_SIZE)) {
        EXPR_W(expression,EXPR_LEFT)=node=CONVERT_EXPR_TO_TYPE(INT_TYPE,node,0);
    }
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
    return expression;
}

/* BUILD_COMPLEMENT: analyses ~x: the operand must be integral; it is widened to the
   wanted integer type (hint, default int) when that is larger. */
unsigned int far pascal BUILD_COMPLEMENT(unsigned int expression,unsigned int context,
    register unsigned int hint)
{
    if(!hint || !(EXPR_FLAGS[TYPE_W(hint,TYPE_KIND)]&1))
        hint=INT_TYPE;
    if(C6PRE(&expression,context,hint,1))
        return expression;
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1))
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_INTEGRAL,expression);
    if(TYPE_SIZE(hint)>TYPE_SIZE(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE)))
        EXPR_W(expression,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(hint,EXPR_W(expression,EXPR_LEFT),0);
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
    return expression;
}

/* BUILD_LOGICAL_NOT: analyses !x: the operand must be scalar (in C++ a class may
   convert to one); operands smaller than int get a cast to int, and the result is int. */
unsigned int far pascal BUILD_LOGICAL_NOT(unsigned int expression,unsigned int context)
{
    if(C6PRE(&expression,context,CHAR_TYPE,7))
        return expression;
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&7))
        return REPORT_EXPR_ERROR_PLAIN((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)?MSG_ILLEGAL_STRUCTURE:MSG_EXPRESSION_SCALAR_TYPE,expression);
    if(CPP_MODE)
        EXPR_W(expression,EXPR_LEFT)=CONVERT_CLASS_TO_SCALAR(EXPR_W(expression,EXPR_LEFT));
    if((int)TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)<TK_INT &&
            TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)!=TK_UNDEFINED) {
        EXPR_W(expression,EXPR_LEFT)=MAKE_CAST_NODE(INT_TYPE,EXPR_W(expression,EXPR_LEFT));
        EXPR_B(EXPR_W(expression,EXPR_LEFT),EXPR_NODE_FLAGS)|=1;
    }
    EXPR_W(expression,EXPR_TYPE)=INT_TYPE;
    return expression;
}
