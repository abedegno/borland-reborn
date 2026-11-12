/* target: ovr061_C5UNIT */
/* opts: -mm -G- -O -Z -p -B */
/* Role: expressions: function call analysis; checks call arguments against the prototype
   (count, types, void values, structures passed by value, const/volatile this). Entry
   points: REPORT_ARGUMENT_MISMATCH, CHECK_CALL_ARGUMENTS, ANALYZE_CALL. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: semantic analysis of a function call node (operator 0x36: EXPR_LEFT the
   callee, EXPR_RIGHT the argument list of MAKE_LIST_NODE cells, item in EXPR_RIGHT and
   next cell in EXPR_LEFT). ANALYZE_CALL is reached from the expression analyser
   (expr/EXPRDISP.C): it analyses the callee (in C++ PREPARE_CALL may pick an overload
   and give back extra code to run first, "selected"), checks that it is a function or
   a pointer to one, and lets CHECK_CALL_ARGUMENTS walk the arguments against the
   parameter list (FORMAL records of the function type). Each argument is converted to
   its parameter's type (C5ARG in C, CONVERT_ARGUMENT in C++); arguments beyond the
   prototype, or to a function without one, get the default promotions (C5WRAP). Wrong
   counts give "Too few / Extra parameter in call" (messages 45/46 and 96/97). In C++
   missing trailing arguments come from the default arguments (DEFAULT_ARGUMENT), calls
   to inline functions may be expanded in place (EXPAND_INLINE_CALL), and a function
   returning a class or a member function pointer gets a hidden return slot (C5VALUE).
   Storage class 0x0A, probably an intrinsic/built-in function, is exempt from the
   promotion and "no prototype" checks. */
/* Complete authentic seven-body original0000..0AFB context. */
#include <dos.h>
#include "EXPRW5.H"
#include "EXPRC5.H"
#include "EXPRV5.H"
#include "UNIT5.H"
#include "MSG.H"
#include "POOL.H"

/* C5WRAP: the default argument promotions for an argument with no parameter to match:
   analyse it, reject void and classes that need a constructor (TYPE_ATTRS bit 4), turn
   enums and small integers into int (or long for long kinds) and float into double. */
static unsigned int far pascal C5WRAP(unsigned int expression)
{
    register unsigned int node=expression;

    node=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(node,0,0)));
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_VOID)
        node=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    else if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x40) &&
            (TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&4))
        node=REPORT_EXPR_ERROR(MSG_ITEMS_TYPE_NEED,FORMAT_TYPE(EXPR_W(node,EXPR_TYPE)),0L,node);
    else if(EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&1)
        node=CONVERT_EXPR_TO_TYPE((int)TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)>TK_UINT?LONG_TYPE:INT_TYPE,node,0);
    else if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&2) &&
            (int)TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)<TK_LDOUBLE)
        node=CONVERT_EXPR_TO_TYPE(DOUBLE_TYPE,node,0);
    return node;
}

/* C5CHECK: preparation shared by CHECK_CALL_ARGUMENTS for call node input. Outputs:
   *symbol_out the called symbol when the callee is a plain name (else 0); *type_out the
   function type; *selected extra code from LOWER_VIRTUAL_CALL; *restricted 1 when the
   call should be expanded inline. In C++ it also warns about calling a non-const /
   non-volatile member function on a const / volatile object (the first argument is
   the object) and queues used inline functions whose body exists. A call through a
   function pointer gets the pointer dereferenced. Sets the call node's type to the
   function's return type. */
static void far pascal C5CHECK(unsigned int input,unsigned int far *selected,
    unsigned char far *restricted,unsigned int far *symbol_out,unsigned int far *type_out)
{
    unsigned int argument;
    unsigned int callee;
    unsigned int argument_qualifiers;
    unsigned int function_qualifiers;
    register unsigned int symbol;
    unsigned int node;

    node=input;

    *selected=0;
    *restricted=0;
    callee=EXPR_W(node,EXPR_LEFT);
    symbol=EXPR_W(callee,EXPR_OP)==1?EXPR_W(callee,EXPR_LEFT):0;
    *symbol_out=symbol;
    if(CPP_MODE && TYPE_W(EXPR_W(callee,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) {
        argument=EXPR_W(node,EXPR_RIGHT)?EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT):0;
        if(TYPE_W(EXPR_W(callee,EXPR_TYPE),TYPE_MEMBER_CLASS)!=0 && argument) {
            argument_qualifiers=TYPE_B(EXPR_W(argument,EXPR_TYPE),TYPE_ATTRS);
            function_qualifiers=TYPE_B(EXPR_W(callee,EXPR_TYPE),TYPE_ATTRS);
            if((argument_qualifiers&1) && !(function_qualifiers&1))
                REPORT_DIAGNOSTIC_AT(MSG_NON_CONST_FUNCTION,symbol==0?(char far *)POINTER_TEXT:FORMAT_SYMBOL(symbol),
                    0L,EXPR_W(argument,EXPR_SRC_LINE),EXPR_W(argument,EXPR_SRC_WORD3));
            if((argument_qualifiers&2) && !(function_qualifiers&2))
                REPORT_DIAGNOSTIC_AT(MSG_NON_VOLATILE_FUNCTION,symbol==0?(char far *)POINTER_TEXT:FORMAT_SYMBOL(symbol),
                    0L,EXPR_W(argument,EXPR_SRC_LINE),EXPR_W(argument,EXPR_SRC_WORD3));
            EXPR_W(argument,EXPR_TYPE)=STRIP_CV_QUALIFIERS(EXPR_W(argument,EXPR_TYPE));
        }
        if(symbol) LOWER_VIRTUAL_CALL(node,selected);
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==1 && (SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=0x0A &&
            ((SYM_B(symbol,SYM_INLINE_ACCESS)&3)==1 || (SYM_B(symbol,SYM_INLINE_ACCESS)&3)==2)) {
            *restricted=(SYM_W(symbol,SYM_FUNC_FLAGS)&4) && NO_ERRORS_YET &&
                (EXPAND_INLINES_FLAG || (SYM_B(symbol,SYM_INLINE_ACCESS)&3)==2);
            if(!(SYM_B(symbol,SYM_FLAGS)&2)) {
                REPORT_DIAGNOSTIC_AT(MSG_NO_BODY_DEFINED_THIS,FORMAT_SYMBOL(symbol),0L,EXPR_W(node,EXPR_SRC_LINE),0);
                *restricted=0;
            } else if(!*restricted)
                QUEUE_DEFERRED_SYMBOL(symbol);
        }
    }
    if((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14) &&
        TYPE_W(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==0x12)
        EXPR_W(node,EXPR_LEFT)=MAKE_DEREFERENCE(EXPR_W(node,EXPR_LEFT));
    *type_out=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    EXPR_W(node,EXPR_TYPE)=TYPE_W(*type_out,TYPE_KIND)==TK_FUNCTION?TYPE_W(*type_out,TYPE_TARGET):0;
}

/* REPORT_ARGUMENT_MISMATCH: reports a bad argument at its source line. error is the base
   message (77, MSG_TYPE_MISMATCH_77): one is added when the parameter has a name (then
   printed instead of the position), two when the called symbol is unknown, which picks
   among messages 77..80. */
void far pascal REPORT_ARGUMENT_MISMATCH(unsigned int expression,register unsigned int formal,
    unsigned int symbol,int position,register unsigned int error)
{
    long first;
    long second;

    if(FORMAL_W(formal,FORMAL_NAME)==0)
        first=(long)position;
    else {
        first=(long)NAME_TEXT_COPY(FORMAL_W(formal,FORMAL_NAME));
        ++error;
    }
    if(symbol)
        second=(long)(CPP_MODE?FORMAT_SYMBOL(symbol):SYMBOL_NAME_TEXT(symbol));
    else {
        second=0L;
        error+=2;
    }
    /* Existing diagnostic first-argument facet carries all original32 bits,
       including the signed numeric alternative; no dereference is implied. */
    REPORT_DIAGNOSTIC_AT(error,(char far *)first,second,EXPR_W(expression,EXPR_SRC_LINE),0);
}

/* C5ARG: (C mode) analyses one argument with its parameter's type as the wanted type and
   converts it to that type; void values and incompatible types are errors. */
static unsigned int far pascal C5ARG(unsigned int expression,unsigned int formal,
    unsigned int symbol,int position)
{
    register unsigned int node=expression;
    register unsigned int type=FORMAL_W(formal,FORMAL_TYPE);

    node=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(node,type,0));
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    node=NULL_CONSTANT_TO_POINTER(type,node);
    if(C7_TYPE_COMPAT(type,EXPR_W(node,EXPR_TYPE),1))
        return CONVERT_EXPR_TO_TYPE(type,NODE_ENUM_TO_INT(node),0);
    REPORT_ARGUMENT_MISMATCH(node,formal,symbol,position,0x4D);
    return REPORT_EXPR_ERROR_PLAIN(0,node);
}

/* C5VALUE: for a call node returning a struct/class (other than a plain 1, 2 or 4 byte
   one) or a member function pointer, passes the address of a place for the result as
   a hidden extra argument and rewrites the call into *(call, &place). The place is
   "other" (a copy of it) when the caller already has a compatible destination, else a
   new local temporary, destroyed at the end of the full expression in C++. The cast
   uses a far pointer (kind 0x0F); token 0x18 (TOK_STAR) makes the dereference. */
static unsigned int far pascal C5VALUE(register unsigned int node,register unsigned int other)
{
    unsigned int first;
    unsigned int second;
    unsigned int size;
    unsigned int record;

    /* Original deliberately retains only AX of the DX:AX size result. */
    size=(unsigned int)TYPE_SIZE(EXPR_W(node,EXPR_TYPE));
    if(!(TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&4) && (size==1 || size==2 || size==4)) return node;
    if(other && !TYPES_COMPATIBLE(EXPR_W(other,EXPR_TYPE),EXPR_W(node,EXPR_TYPE),1)) other=0;
    if(!other) {
        record=CREATE_LOCAL_TEMP(EXPR_W(node,EXPR_TYPE));
        first=ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(record),0,0);
        if(CPP_MODE)
            SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(record),EXPR_W(node,EXPR_TYPE),SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS));
    } else
        first=COPY_EXPR_TREE(other);
    second=ANALYZE_EXPRESSION(MAKE_CAST_NODE(MAKE_POINTER_TYPE(EXPR_W(node,EXPR_TYPE),0x0F,0),MAKE_ADDRESS_OF(first)),0,0);
    EXPR_W(node,EXPR_RIGHT)=MAKE_LIST_NODE(COPY_EXPR_TREE(second),EXPR_W(node,EXPR_RIGHT));
    EXPR_B(EXPR_W(node,EXPR_RIGHT),EXPR_NODE_FLAGS)|=1;
    node=ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18,JOIN_COMMA_EXPR(node,second)),0,0);
    return node;
}

/* CHECK_CALL_ARGUMENTS: checks and converts the arguments of the call node expression
   (see the overview); "other" is a destination for a returned structure, or 0. Returns
   the analysed call, possibly expanded inline or wrapped as described in C5VALUE. */
unsigned int far pascal CHECK_CALL_ARGUMENTS(unsigned int expression,unsigned int other)
{
    unsigned int type;
    unsigned int parameters;
    unsigned char warned;
    unsigned char restricted;
    unsigned int selected;
    int position;
    unsigned int symbol;
    long text;
    unsigned int error;
    register unsigned int node=expression;
    unsigned int argument;

    if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0)
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    C5CHECK(node,&selected,&restricted,&symbol,&type);
    if(!CPP_MODE && (TYPE_B(type,TYPE_FUNC_FLAGS)&8)) {
        if(symbol) {
            if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=0x0A)
                REPORT_DIAGNOSTIC(MSG_CALL_FUNCTION_NO,SYMBOL_NAME_TEXT(symbol),0L);
        } else
            REPORT_CURRENT_TOKEN(MSG_CALL_FUNCTION_NO_360);
    }
    warned=(TYPE_B(type,TYPE_FUNC_FLAGS)&4) || (TYPE_B(type,TYPE_FUNC_FLAGS)&8);
    parameters=(TYPE_B(type,TYPE_FUNC_FLAGS)&8)?0:TYPE_W(type,TYPE_PARAMS);
    argument=EXPR_W(node,EXPR_RIGHT);
    if(TYPE_SIZE(EXPR_W(node,EXPR_TYPE))==0L && EXPR_W(node,EXPR_TYPE)!=VOID_TYPE &&
            TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)!=TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,node);
    if(CPP_MODE && !argument) {
        argument=DEFAULT_ARGUMENT(parameters);
        EXPR_W(node,EXPR_RIGHT)=argument;
    }
    /* position counts arguments for messages; a member function's first argument is the
       object, so counting starts at 0 (or -1 for a constructor of a class with virtual
       bases, which gets one more hidden argument, probably) */
    position=1;
    if(CPP_MODE && TYPE_W(type,TYPE_MEMBER_CLASS)!=0) {
        position=0;
        if(symbol && SYM_W(symbol,SYM_FUNC_KIND)==3 &&
                (TAG_W(TYPE_W(TYPE_W(type,TYPE_MEMBER_CLASS),TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4))
            position=-1;
    }
    while(argument) {
        EXPR_B(argument,EXPR_NODE_FLAGS)|=1;
        if(!parameters) {
            if(!warned) {
                text=0L;
                error=0x60;
                if(symbol) {
                    error=0x61;
                    text=(long)(CPP_MODE?FORMAT_SYMBOL(symbol):SYMBOL_NAME_TEXT(symbol));
                }
                REPORT_DIAGNOSTIC_AT(error,(char far *)text,0L,EXPR_W(EXPR_W(argument,EXPR_RIGHT),EXPR_SRC_LINE),0);
                warned=1;
            }
            if(!symbol || (SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=0x0A)
                EXPR_W(argument,EXPR_RIGHT)=C5WRAP(EXPR_W(argument,EXPR_RIGHT));
        } else
            EXPR_W(argument,EXPR_RIGHT)=CPP_MODE?
                CONVERT_ARGUMENT(EXPR_W(argument,EXPR_RIGHT),parameters,symbol,position):
                C5ARG(EXPR_W(argument,EXPR_RIGHT),parameters,symbol,position);
        if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(argument,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x40)
            REPORT_DIAGNOSTIC_AT(MSG_STRUCTURE_PASSED_VALUE,(char far *)0,0L,EXPR_W(EXPR_W(argument,EXPR_RIGHT),EXPR_SRC_LINE),0);
        if(parameters)
            parameters=FORMAL_W(parameters,FORMAL_NEXT);
        if(CPP_MODE && EXPR_W(argument,EXPR_LEFT)==0)
            EXPR_W(argument,EXPR_LEFT)=DEFAULT_ARGUMENT(parameters);
        argument=EXPR_W(argument,EXPR_LEFT);
        ++position;
    }
    /* parameters left over: too few arguments */
    if(parameters) {
        text=0L;
        error=0x2D;
        if(symbol) {
            error=0x2E;
            text=(long)(CPP_MODE?FORMAT_SYMBOL(symbol):SYMBOL_NAME_TEXT(symbol));
        }
        node=REPORT_EXPR_ERROR(error,text,0L,node);
    }
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    if(restricted && EXPR_W(node,EXPR_OP)==0x36 && NO_ERRORS_YET) {
        ++SUPPRESS_WARNINGS_DEPTH;
        node=EXPAND_INLINE_CALL(node);
        --SUPPRESS_WARNINGS_DEPTH;
    } else if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x40) ||
            (((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14) &&
              TYPE_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) &
             (TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR && TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_PTR_MODE)==0x0B)))
        node=C5VALUE(node,other);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(selected,node),0,0);
}

/* ANALYZE_CALL: entry point for a call node; "other" as in CHECK_CALL_ARGUMENTS. */
unsigned int far pascal ANALYZE_CALL(unsigned int expression,unsigned int other)
{
    unsigned int selected;
    register unsigned int node=expression;
    register unsigned int type;

    EXPR_W(node,EXPR_LEFT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0);
    selected=0;
    if(CPP_MODE)
        node=PREPARE_CALL(node,&selected);
    type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    if(TYPE_W(type,TYPE_KIND)!=TK_FUNCTION &&
            !((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) &&
            TYPE_W(type,TYPE_KIND)!=TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(MSG_CALL_NONFUNCTION,node);
    if(EXPR_W(node,EXPR_OP)==0x36)
        node=CHECK_CALL_ARGUMENTS(node,other);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(selected,node),0,0);
}
