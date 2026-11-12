/* target: ovr074_C18UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ expressions: function calls: overloaded call resolution, virtual calls through
   the vtable, operator function calls, member-pointer calls, argument conversion and
   defaults. Entry points: RESOLVE_OVERLOADED_CALL, VIRTUAL_TABLE_ENTRY, LOWER_VIRTUAL_CALL,
   TRY_UNARY_OPERATOR_CALL, TRY_BINARY_OPERATOR_CALL, PREPARE_CALL, CONVERT_ARGUMENT,
   DEFAULT_ARGUMENT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C++ side of function calls, used by expression analysis
   (expr/CALLCHK.C and the operator checks). A call node has the callee in EXPR_LEFT
   and a chain of list nodes in EXPR_RIGHT (each list node: EXPR_LEFT next, EXPR_RIGHT
   the argument). For a member function the object becomes the first argument, and
   node flag 0x40 on the first list node marks that.
   - PREPARE_CALL runs first on every call: it applies operator() to class objects,
     rewrites obj.f(...) and obj.*pf(...) into calls with the object as first argument
     (REWRITE_MEMBER_CALL, LOWER_MEMBER_POINTER_CALL), resolves overloaded names
     (RESOLVE_OVERLOADED_CALL) and converts the object to the function's own class
     (ADJUST_THIS_ARGUMENT).
   - LOWER_VIRTUAL_CALL turns a call of a virtual function through an object that is
     not exactly known into an indirect call through the virtual table
     (VIRTUAL_TABLE_ENTRY).
   - TRY_UNARY_OPERATOR_CALL and TRY_BINARY_OPERATOR_CALL replace an operator applied
     to class operands by a call of the chosen operator function.
   - CONVERT_ARGUMENT converts each argument to its parameter type (classes with
     constructors by address, references bound to objects or to temporaries) and
     DEFAULT_ARGUMENT supplies default arguments.
   The code uses raw offsets through local macros: E(n,0) EXPR_OP, E(n,6) the node flag
   byte, E(n,8) EXPR_TYPE, E(n,10) EXPR_LEFT, E(n,12) EXPR_RIGHT, E(n,14)
   EXPR_SCOPE_CLASS (the X of X::f), LOCATION the source position at byte 20;
   S(n,0) SYM_OWNER_CLASS, S(n,2) SYM_NAME, S(n,4) SYM_TYPE, SB(n,6) SYM_FLAGS (0x10
   member), S(n,10) SYM_FUNC_FLAGS (0x40 static member, 0x100 dynamically dispatched),
   S(n,15) SYM_FUNC_KIND (2 conversion, 3 constructor, 4 destructor), S(n,19)
   SYM_NEXT_OVERLOAD, S(n,21) SYM_VIRTUAL_INDEX; T(n,0) TYPE_KIND (0x12 TK_FUNCTION,
   0x0F TK_FAR_PTR), TB(n,2) TYPE_ATTRS, T(n,3) TYPE_MEMBER_CLASS, T(n,7) TYPE_TARGET,
   TB(n,12) TYPE_FUNC_FLAGS; CL(type,24) TAG_CLASS_FLAGS (4 virtual bases, 0x100 huge
   class, whose virtual table entries are far); M(n,6) MEMB_VALUE; A(n,2) FORMAL_TYPE, A(n,8) FORMAL_DEFAULT_ARG;
   N(scope,16) SCOPE_TEMPS. Nodes are built with token codes (0x16 '+', 0x17 '-', 0x18
   unary '*', 0x1D unary address-of, 0x2F '.', 0x30 probably '->', 5 initialization
   (operator 0x47); see CPPCTOR.C); expression operators 0x3B and 0x3C are '.' and '.*'. */
#include <dos.h>
#include "CPPCALL.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define C(n,o) AT_W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define CL(n,o) C(T(n,5),(o))
#define M(n,o) AT_W(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define A(n,o) AT_W(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define EB(n,o) AT_B(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define N(n,o) AT_W(SCOPE_POOL_SEG,(unsigned int)(n)+(o))
#define LOCATION(n) (*(struct C18Location far *)MK_FP(EXPR_POOL_SEG,(unsigned int)(n)+20))

/* 0000 */
/* ADJUST_THIS_ARGUMENT: for a call of a member function with the object as first
   argument, checks that the function is accessible through the object's class
   (message 0xB6, probably "not accessible"), converts the object to the class that
   declares the function when it is a derived class (via its address and
   CONVERT_DERIVED_TO_BASE), and drops the object argument for a static member
   function. type is the object's class (0 or a non-class means no object). Calls
   without an object (direct) are only access-checked against CURRENT_CLASS_TYPE. */
static unsigned int near pascal ADJUST_THIS_ARGUMENT(register unsigned int expression,unsigned int type)
{
    unsigned int target;
    unsigned int temporary;
    unsigned char direct;
    unsigned int context;
    register unsigned int callee;
    callee=E(expression,10);
    direct=!(EXPR_FLAGS[T(type,0)]&0x40) || E(callee,0)!=1 ||
        T(E(callee,8),0)!=0x12 ||
        ((S(E(callee,10),10)&0x40) && !(EB(E(expression,12),6)&0x40)) ||
        !(SB(E(callee,10),6)&0x10);
    context=direct?CURRENT_CLASS_TYPE:E(E(E(expression,12),12),8);
    if(E(callee,0)==1 && T(E(callee,8),0)==0x12 &&
       (SB(E(callee,10),6)&0x10) && !SYMBOL_ACCESSIBLE(E(callee,10),context))
        return REPORT_EXPR_ERROR(0xB6,FORMAT_SYMBOL(E(callee,10)),0L,expression);
    if(direct==0) {
        target=S(S(E(callee,10),0),4);
        if(!TYPES_COMPATIBLE(context,target,1)) {
            temporary=MAKE_ADDRESS_OF(E(E(expression,12),12));
            temporary=CONVERT_DERIVED_TO_BASE(temporary,type,E(callee,14),target,0,0);
            E(E(expression,12),12)=MAKE_DEREFERENCE(temporary);
        }
        if((S(E(callee,10),10)&0x40) && (EB(E(expression,12),6)&0x40)) {
            temporary=E(expression,12);
            E(expression,12)=E(temporary,10);
            E(temporary,10)=0;
            FREE_EXPR_TREE(temporary);
        }
    }
    return expression;
}
/* 01D1 */
/* RESOLVE_OVERLOADED_CALL: when the callee names an overloaded function (it has a
   SYM_NEXT_OVERLOAD and is not a conversion function), analyzes every argument and
   picks the overload with SELECT_OVERLOAD; none fitting is MSG_COULD_NOT_FIND_MATCH.
   The argument positions are saved around the analysis so messages still point at
   the source. type is the object's class for member calls. */
unsigned int far pascal RESOLVE_OVERLOADED_CALL(register unsigned int expression,unsigned int type)
{
    unsigned int argument;
    unsigned int selected;
    struct C18Location saved;
    unsigned char flag;
    register unsigned int callee;
    callee=E(expression,10);
    if(E(callee,0)!=1 || T(E(callee,8),0)!=0x12 ||
       S(E(callee,10),19)==0 || S(E(callee,10),15)==2)
        return expression;
    for(argument=E(expression,12);argument;argument=E(argument,10)) {
        saved=LOCATION(E(argument,12));
        E(argument,12)=CHECK_NULL_CONSTANT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(E(argument,12),0,0)),&flag);
        LOCATION(E(argument,12))=saved;
    }
    selected=SELECT_OVERLOAD(expression,E(callee,10),0,0);
    if(!selected)
        return REPORT_EXPR_ERROR(MSG_COULD_NOT_FIND_MATCH,FORMAT_CALL_SIGNATURE(expression,type),0L,expression);
    E(callee,10)=selected;
    EB(callee,6)&=0xFE;
    E(expression,10)=RESOLVE_SYMBOL_REFERENCE(callee,0);
    return expression;
}
/* 030B */
/* VIRTUAL_TABLE_ENTRY: *(entry *)(expression->vptr + index), the virtual table entry
   number index of class type, where expression points to the object and vptr is the
   hidden member found by BCC_MEMBER_LOOKUP; the entry type is far for a huge class
   (class flag 0x100), else near. */
unsigned int far pascal VIRTUAL_TABLE_ENTRY(unsigned int index,register unsigned int type,unsigned int expression)
{
    unsigned int member;
    register unsigned int result;
    member=BCC_MEMBER_LOOKUP(type);
    result=MAKE_BINARY_NODE(0x30,expression,MAKE_FIELD_REF_NODE(member));
    result=MAKE_CAST_NODE((CL(type,24)&0x100)?FAR_VTABLE_ENTRY_PTR_TYPE:VTABLE_ENTRY_PTR_TYPE,
        MAKE_BINARY_NODE(0x16,result,index));
    result=MAKE_UNARY_NODE(0x18,result);
    result=ANALYZE_EXPRESSION(result,0,0);
    return result;
}
/* 0387 */
/* LOWER_VIRTUAL_CALL: if the callee of call node expression is a virtual function
   (SYM_VIRTUAL_INDEX > 0) and the call is not qualified (no X:: and not on an object
   of exactly known class, see REWRITE_MEMBER_CALL), rewrites it as an indirect call:
   the object's address is saved in a temporary (returned through *type), the callee
   becomes the func part of the table entry at index - 1 (SYM_VIRTUAL_INDEX is the
   entry's byte offset plus 1, see TYPE_OFFSET in CLASSDEF.C; near or far member by the
   function's model) and the first argument becomes *temporary. A dynamically
   dispatched (DDVT) function, flag 0x100, cannot be called this way (MSG_CANNOT_CALL);
   its SYM_VIRTUAL_INDEX is a dispatch id, not a table slot. */
void far pascal LOWER_VIRTUAL_CALL(unsigned int expression,unsigned int far *type)
{
    unsigned int index;
    unsigned int result;
    unsigned int pointer_type;
    unsigned int context;
    unsigned int temporary;
    unsigned int member_expression;
    unsigned char far_model;
    register unsigned int callee;
    callee=E(expression,10);
    index=0;
    if(!E(callee,14) && T(S(E(callee,10),4),0)==0x12) {
        if(S(E(callee,10),10)&0x100)
            REPORT_DIAGNOSTIC(MSG_CANNOT_CALL,FORMAT_SYMBOL(E(callee,10)),0L);
        else
            index=S(E(callee,10),21);
    }
    if(index>0) {
        pointer_type=E(callee,8);
        if(!(EXPR_FLAGS[T(pointer_type,0)]&0x14)) {
            far_model=(TB(pointer_type,12)&1)!=0;
            pointer_type=MAKE_POINTER_TYPE(pointer_type,0,0);
        } else
            far_model=T(pointer_type,0)==0x0F;
        E(E(expression,12),12)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(E(E(expression,12),12),0,0));
        context=E(E(E(expression,12),12),8);
        FREE_EXPR_NODE(callee);
        temporary=MAKE_ADDRESS_OF(E(E(expression,12),12));
        SAVE_EXPR_IN_TEMP(&temporary,type);
        temporary=ANALYZE_EXPRESSION(temporary,0,0);
        result=VIRTUAL_TABLE_ENTRY(MAKE_INT_CONSTANT(INT_TYPE,(long)(index-1)),context,
            COPY_EXPR_TREE(temporary));
        member_expression=MAKE_BINARY_NODE(0x2F,result,
            MAKE_FIELD_REF_NODE(far_model?VTABLE_FAR_FUNC_MEMBER:VTABLE_NEAR_FUNC_MEMBER));
        member_expression=MAKE_UNARY_NODE(0x18,MAKE_CAST_NODE(pointer_type,member_expression));
        E(E(expression,12),12)=MAKE_DEREFERENCE(ANALYZE_EXPRESSION(temporary,0,0));
        E(expression,10)=DECAY_TO_POINTER(ANALYZE_EXPRESSION(member_expression,pointer_type,0));
    }
}
/* 057C */
/* CHECK_CONST_THIS: calling member function symbol on a const object expression:
   unless the function is const (or a constructor or destructor) warns
   MSG_NON_CONST_FUNCTION; the object's type then loses its cv qualifiers so the call
   can go on. */
static void near pascal CHECK_CONST_THIS(register unsigned int symbol,register unsigned int expression)
{
    if((TB(E(expression,8),2)&1) && !(TB(S(symbol,4),2)&1)) {
        if(S(symbol,15)!=3 && S(symbol,15)!=4)
            REPORT_DIAGNOSTIC_AT(MSG_NON_CONST_FUNCTION,FORMAT_SYMBOL(symbol),0L,E(expression,22),E(expression,24));
        E(expression,8)=STRIP_CV_QUALIFIERS(E(expression,8));
    }
}
/* 0603 */
/* TRY_UNARY_OPERATOR_CALL: *output is a unary operator node (node flag 0x20 set by
   MAKE_UNARY_NODE) whose operand is a class object. Looks for operatorX both as a
   member of the class and as a global function (the operator's name comes from
   C18_OPERATOR_TOKENS and TOKEN_NAMES) and lets SELECT_OVERLOAD choose. On success
   replaces *output with the checked call and returns 1; returns 0 to let the caller
   apply the built-in operator. operation and context are passed on to
   SELECT_OVERLOAD and CHECK_CALL_ARGUMENTS. */
unsigned char far pascal TRY_UNARY_OPERATOR_CALL(unsigned int far *output,unsigned int operation,unsigned int context)
{
    unsigned int wrapper;
    unsigned int symbol;
    unsigned int name;
    unsigned char flag;
    unsigned int type;
    unsigned int member;
    unsigned int candidate;
    register unsigned int original;
    register unsigned int result;
    original=*output;
    type=E(E(original,10),8);
    if(!(EB(original,6)&0x20) || !(EXPR_FLAGS[T(type,0)]&0x40))
        return 0;
    E(original,10)=CHECK_NULL_CONSTANT(E(original,10),&flag);
    wrapper=MAKE_LIST_NODE(E(original,10),0);
    EB(wrapper,6)|=0x40;
    LOCATION(wrapper)=LOCATION(original);
    name=TOKEN_NAMES[C18_OPERATOR_TOKENS[E(original,0)]];
    member=type==0?0:FIND_MEMBER_REPORT(name,type);
    candidate=member==0?0:M(member,6);
    result=MAKE_BINARY_NODE(1,0,wrapper);
    LOCATION(result)=LOCATION(original);
    symbol=SELECT_OVERLOAD(result,LOOKUP_NAME(name),candidate,operation);
    if(!symbol) {
        FREE_EXPR_NODE(wrapper);
        FREE_EXPR_NODE(result);
        return 0;
    }
    E(result,10)=RESOLVE_SYMBOL_REFERENCE(MAKE_SYMBOL_NODE(symbol),0);
    LOCATION(E(result,10))=LOCATION(original);
    if(SB(symbol,6)&0x10)
        CHECK_CONST_THIS(symbol,E(wrapper,12));
    result=ADJUST_THIS_ARGUMENT(result,type);
    FREE_EXPR_NODE(original);
    *output=CHECK_CALL_ARGUMENTS(result,context);
    return 1;
}
/* 07B4 */
/* TRY_BINARY_OPERATOR_CALL: the same for a binary operator where either operand is a
   class object. Operator 0x47 is initialization (T x = y; CHECK_INITIALIZATION in
   EXPRDISP.C) and is used by CHECK_CPP_INITIALIZATION to get a constructor call; for a
   class with virtual bases the hidden 0 argument is then inserted after the object,
   as BUILD_CONSTRUCTOR_CALL does. On failure all the list nodes built are freed. */
unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *output,unsigned int operation,unsigned int context)
{
    unsigned int type;
    unsigned int symbol;
    unsigned char flag;
    unsigned char assignment;
    unsigned int result;
    unsigned int name;
    unsigned int member;
    unsigned int candidate;
    unsigned int previous;
    register unsigned int original;
    register unsigned int arguments;
    original=*output;
    type=E(E(original,10),8);
    if(!(EB(original,6)&0x20) ||
       (!(EXPR_FLAGS[T(type,0)]&0x40) &&
        !(EXPR_FLAGS[T(E(E(original,12),8),0)]&0x40)))
        return 0;
    E(original,10)=CHECK_NULL_CONSTANT(E(original,10),&flag);
    E(original,12)=CHECK_NULL_CONSTANT(E(original,12),&flag);
    arguments=MAKE_LIST_NODE(E(original,12),0);
    assignment=0;
    if(E(original,0)==0x47 && (EXPR_FLAGS[T(type,0)]&0x40))
        assignment=(CL(type,24)&4)!=0;
    if(!(EXPR_FLAGS[T(type,0)]&0x40))
        type=0;
    if(assignment)
        arguments=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,0L),arguments);
    arguments=MAKE_LIST_NODE(E(original,10),arguments);
    EB(arguments,6)|=0x40;
    name=TOKEN_NAMES[C18_OPERATOR_TOKENS[E(original,0)]];
    member=type==0?0:FIND_MEMBER_REPORT(name,type);
    candidate=member==0?0:M(member,6);
    result=MAKE_BINARY_NODE(1,0,arguments);
    LOCATION(result)=LOCATION(original);
    symbol=SELECT_OVERLOAD(result,LOOKUP_NAME(name),candidate,operation);
    if(!symbol) {
        if(assignment)
            FREE_EXPR_NODE(E(E(arguments,10),12));
        while(arguments) {
            previous=arguments;
            arguments=E(arguments,10);
            FREE_EXPR_NODE(previous);
        }
        FREE_EXPR_NODE(result);
        return 0;
    }
    E(result,10)=RESOLVE_SYMBOL_REFERENCE(MAKE_SYMBOL_NODE(symbol),0);
    LOCATION(E(result,10))=LOCATION(original);
    if(SB(symbol,6)&0x10)
        CHECK_CONST_THIS(symbol,E(arguments,12));
    result=ADJUST_THIS_ARGUMENT(result,type);
    FREE_EXPR_NODE(original);
    *output=CHECK_CALL_ARGUMENTS(result,context);
    return 1;
}
/* 0A26 */
/* LOWER_MEMBER_POINTER_CALL: (object.*pmf)(args). *left is the member pointer value,
   *right the object, *sequence collects side effects to run first. The member pointer
   is kept in a temporary; with p = (char *)&object + pmf.delta the function is
   pmf.vindex ? (*(vtable **)(p + pmf.offset))[pmf.vindex - 1] : pmf.func
   (near or far parts by the function's model and by class flag 0x100, huge class),
   and the object becomes *(class *)p. */
static void near pascal LOWER_MEMBER_POINTER_CALL(unsigned int far *left,unsigned int far *right,unsigned int far *sequence)
{
    unsigned int original_type;
    unsigned int saved;
    unsigned int left_pointer;
    unsigned int right_pointer;
    unsigned int offset;
    unsigned int dispatch;
    unsigned char far_model;
    unsigned char wide;
    register unsigned int work;
    register unsigned int address;
    original_type=E(*left,8);
    far_model=(TB(T(original_type,7),12)&1)!=0;
    wide=(CL(E(*right,8),24)&0x100)!=0;
    E(*left,8)=MEMBER_PTR_CLASS_TYPE;
    EB(*left,6)|=1;
    SAVE_EXPR_IN_TEMP(left,&saved);
    *sequence=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(*sequence,saved),0,0);
    left_pointer=MAKE_CAST_NODE(CHAR_POINTER_TYPE,MAKE_UNARY_NODE(0x1D,*right));
    work=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(*left),MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER));
    left_pointer=MAKE_BINARY_NODE(0x16,left_pointer,work);
    offset=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(*left),MAKE_FIELD_REF_NODE(MEMBER_PTR_VINDEX_MEMBER));
    work=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(*left),MAKE_FIELD_REF_NODE(MEMBER_PTR_OFFSET_MEMBER));
    right_pointer=MAKE_BINARY_NODE(0x16,COPY_EXPR_TREE(left_pointer),work);
    right_pointer=MAKE_CAST_NODE(MAKE_POINTER_TYPE(wide?FAR_CHAR_POINTER_TYPE:TYPE_LOCAL,0,0),right_pointer);
    address=MAKE_UNARY_NODE(0x18,right_pointer);
    work=MAKE_BINARY_NODE(0x17,COPY_EXPR_TREE(offset),MAKE_INT_CONSTANT(INT_TYPE,1L));
    address=MAKE_BINARY_NODE(0x16,address,work);
    address=MAKE_CAST_NODE(MAKE_POINTER_TYPE(far_model?INT_FAR_FUNC_PTR_TYPE:INT_NEAR_FUNC_PTR_TYPE,wide?0x0F:0x0D,0),address);
    address=MAKE_UNARY_NODE(0x18,address);
    dispatch=MAKE_BINARY_NODE(0x2F,*left,MAKE_FIELD_REF_NODE(far_model?MEMBER_PTR_FAR_FUNC_MEMBER:MEMBER_PTR_NEAR_FUNC_MEMBER));
    *left=MAKE_CAST_NODE(MAKE_POINTER_TYPE(T(original_type,7),0,0),
        MAKE_CONDITIONAL_NODE(0x20,offset,address,dispatch));
    *left=ANALYZE_EXPRESSION(*left,0,0);
    work=MAKE_CAST_NODE(MAKE_POINTER_TYPE(E(*right,8),0,0),left_pointer);
    work=MAKE_UNARY_NODE(0x18,work);
    *right=ANALYZE_EXPRESSION(work,0,0);
}
/* 0CD2 */
/* REWRITE_MEMBER_CALL: the callee of call node expression is object.f or
   object.*pmf. Makes f the callee and puts the object in front of the argument list
   (flag 0x40). When the object is a variable of exactly the function's class, the
   callee is marked qualified (EXPR_SCOPE_CLASS), so the call is not made virtual. An
   explicit destructor call with no arguments gets the flags argument 2. *type gets
   the object's type, *sequence any side effects to evaluate first. */
static void near pascal REWRITE_MEMBER_CALL(register unsigned int expression,unsigned int far *sequence,unsigned int far *type)
{
    unsigned int callee;
    unsigned int target;
    unsigned char special;
    *sequence=0;
    callee=ANALYZE_EXPRESSION(E(E(expression,10),10),0,0);
    special=E(E(expression,10),0)==0x3C;
    target=E(E(expression,10),12);
    if(!special && E(target,0)==1) {
        if(E(callee,0)==1 && !E(target,14) &&
           S(E(callee,10),4)==S(S(E(target,10),0),4))
            E(target,14)=S(E(callee,10),4);
        if(S(E(target,10),15)==3 || S(E(target,10),15)==4)
            E(callee,8)=STRIP_CV_QUALIFIERS(E(callee,8));
    }
    *type=E(callee,8);
    FREE_EXPR_NODE(E(expression,10));
    if(special)
        LOWER_MEMBER_POINTER_CALL(&target,&callee,sequence);
    else if(S(E(target,10),15)==4 && !E(expression,12))
        E(expression,12)=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,2L),0);
    E(expression,10)=ANALYZE_EXPRESSION(target,0,0);
    E(expression,12)=MAKE_LIST_NODE(callee,E(expression,12));
    EB(E(expression,12),6)|=0x40;
}
/* 0E8F */
/* FIND_CALL_OPERATOR: object(args) on a class object: if the class has operator()
   (named TOKEN_NAMES[TOK_LPAREN]), the callee becomes object.operator(). */
static unsigned int near pascal FIND_CALL_OPERATOR(register unsigned int expression)
{
    register unsigned int member;
    member=FIND_MEMBER_REPORT(TOKEN_NAMES[TOK_LPAREN],E(expression,8));
    if(member) {
        expression=ANALYZE_EXPRESSION(MAKE_BINARY_NODE(0x2F,expression,MAKE_FIELD_REF_NODE(member)),0,0);
        LOCATION(expression)=LOCATION(E(expression,10));
    }
    return expression;
}
/* 0EF5 */
/* PREPARE_CALL: first step of analyzing call node expression (see the overview).
   Reports calls of main (MSG_CANNOT_CALL_MAIN_FROM) and of a member function without
   an object (MSG_USE_CALL). *sequence gets side effects that must run before the call
   (from member pointer calls), or 0. Returns the call node. */
unsigned int far pascal PREPARE_CALL(register unsigned int expression,unsigned int far *sequence)
{
    unsigned int type;
    unsigned int callee;
    *sequence=0;
    type=0;
    E(expression,10)=DEREF_REFERENCE_EXPR(E(expression,10));
    if(EXPR_FLAGS[T(E(E(expression,10),8),0)]&0x40)
        E(expression,10)=FIND_CALL_OPERATOR(E(expression,10));
    callee=E(expression,10);
    if(E(callee,0)==1 && S(E(callee,10),2)==MAIN_SYMBOL)
        REPORT_CURRENT_TOKEN(MSG_CANNOT_CALL_MAIN_FROM);
    if((E(callee,0)==0x3B || E(callee,0)==0x3C) &&
       (T(E(E(callee,12),8),0)==0x12 ||
        ((EXPR_FLAGS[T(E(E(callee,12),8),0)]&0x14) &&
         T(T(E(E(callee,12),8),7),0)==0x12)) && E(E(callee,12),0)!=0x39)
        REWRITE_MEMBER_CALL(expression,sequence,&type);
    else if(T(E(callee,8),0)==0x12 && T(E(callee,8),3))
        return REPORT_EXPR_ERROR(MSG_USE_CALL,(E(callee,0)==1?
            FORMAT_CALL_SIGNATURE(expression,T(E(callee,8),3)):(char far *)STR_A_MEMBER_FUNCTION),0L,expression);
    expression=RESOLVE_OVERLOADED_CALL(expression,type);
    expression=ADJUST_THIS_ARGUMENT(expression,type);
    return expression;
}
/* 1063 */
/* CONVERT_ARGUMENT: converts argument expression for parameter formal of function
   symbol (position counts from 1, for messages). Cases:
   - pointer-to-function parameter and a function name or address: used as is;
   - class with constructors by value: the object is passed by address; a named
     object (or an lvalue for a const parameter) is passed itself, anything else is
     copied into a local temporary whose destructor is registered on the scope;
   - reference parameter: bound to the object when the types fit, else a temporary of
     the referred type is initialized and bound (MSG_TEMPORARY_USED when the reference
     is not to const); a type that cannot be converted is an argument mismatch;
   - anything else: an ordinary conversion, with a warning when an enum parameter
     gets another type (MSG_ASSIGNING). */
unsigned int far pascal CONVERT_ARGUMENT(unsigned int expression,unsigned int formal,unsigned int symbol,int position)
{
    unsigned int pointer_type;
    unsigned int temporary;
    unsigned char constant;
    struct C18Location saved;
    register unsigned int type;
    type=A(formal,2);
    saved=LOCATION(expression);
    if((EXPR_FLAGS[T(type,0)]&0x14) && T(T(type,7),0)==0x12 &&
       (E(expression,0)==1 || E(expression,0)==0x32)) {
        EB(expression,6)&=0xFE;
        goto converted;
    }
    if((EXPR_FLAGS[T(type,0)]&0x40) && (TB(type,2)&4)) {
        expression=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression,type,0));
        LOCATION(expression)=saved;
        if(TB(type,2)&1)
            expression=REWRITE_FOR_REFERENCE_BIND(expression);
        if(TYPES_COMPATIBLE(E(expression,8),type,2) &&
           (IS_NAMED_OBJECT_EXPR(expression) || (IS_LVALUE(expression) && (TB(type,2)&1))))
            expression=MAKE_ADDRESS_OF(expression);
        else {
            temporary=CREATE_LOCAL_TEMP(type);
            N(CURRENT_SCOPE,16)=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(temporary),type,N(CURRENT_SCOPE,16));
            expression=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(temporary),expression);
            LOCATION(expression)=LOCATION(E(expression,12));
            expression=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(expression,
                MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(temporary))),type,0);
        }
        type=MAKE_POINTER_TYPE(type,0,0);
        goto converted;
    }
    if((EXPR_FLAGS[T(type,0)]&0x14) && (TB(type,2)&0x20)) {
        expression=DEREF_REFERENCE_EXPR(ANALYZE_EXPRESSION(expression,type,0));
        if(FIND_USER_CONVERSION(type,E(expression,8),1,0,0))
            expression=CONVERT_EXPR_TO_TYPE(type,expression,0);
        LOCATION(expression)=saved;
        expression=REWRITE_FOR_REFERENCE_BIND(expression);
        if(!C7_TYPE_COMPAT(type,E(expression,8),0)) {
            expression=DEREF_REFERENCE_EXPR(expression);
            constant=IS_LVALUE(expression);
            pointer_type=MAKE_POINTER_TYPE(E(expression,8),0,1);
            if((constant || IS_NAMED_OBJECT_EXPR(expression)) && !IS_BIT_FIELD_NODE(expression) &&
               C7_TYPE_COMPAT(type,pointer_type,0)) {
                expression=MAKE_ADDRESS_OF(expression);
                E(expression,8)=pointer_type;
                goto converted;
            }
            if(constant && !IS_LINK_TIME_CONSTANT(expression) && !(TB(T(type,7),2)&1)) {
                REPORT_DIAGNOSTIC(MSG_TEMPORARY_USED,(char far *)FORMAT_TYPE(type),0L);
                E(expression,8)=STRIP_CV_QUALIFIERS(E(expression,8));
            }
            if(CANNOT_CONVERT_TYPES(T(type,7),E(expression,8)) ||
               (T(E(expression,8),0)==0x11 && T(T(type,7),0)==0x11 &&
                !C7_TYPE_COMPAT(type,pointer_type,0))) {
                REPORT_ARGUMENT_MISMATCH(expression,formal,symbol,position,0x4D);
                return REPORT_EXPR_ERROR_PLAIN(0,expression);
            }
            if(IS_BASE_CLASS(T(type,7),E(expression,8),1)) {
                temporary=CREATE_LOCAL_TEMP(E(expression,8));
                E(expression,8)=STRIP_CV_QUALIFIERS(E(expression,8));
            } else
                temporary=CREATE_LOCAL_TEMP(T(type,7));
            N(CURRENT_SCOPE,16)=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(temporary),S(temporary,4),N(CURRENT_SCOPE,16));
            expression=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(temporary),expression);
            LOCATION(expression)=LOCATION(E(expression,12));
            expression=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(expression,
                MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(temporary))),type,0);
            E(expression,8)=type;
        }
    }
converted:
    if(!((EXPR_FLAGS[T(type,0)]&0x14) && (TB(type,2)&0x20))) {
        expression=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression,type,0));
        LOCATION(expression)=saved;
    }
    if(T(E(expression,8),0)==0x0C)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,expression);
    expression=NULL_CONSTANT_TO_POINTER(type,expression);
    if(!((EXPR_FLAGS[T(type,0)]&0x40) ||
       (EXPR_FLAGS[T(E(expression,8),0)]&0x40) ||
       C7_TYPE_COMPAT(type,E(expression,8),0)))
        goto bad_argument;
    if(T(type,0)==0x15 && !TYPES_COMPATIBLE(type,E(expression,8),1))
        REPORT_DIAGNOSTIC_AT(MSG_ASSIGNING,(char far *)FORMAT_TYPE(E(expression,8)),FORMAT_TYPE(type),E(expression,22),0);
    return CONVERT_EXPR_TO_TYPE(type,NODE_ENUM_TO_INT(expression),0);
bad_argument:
    REPORT_ARGUMENT_MISMATCH(expression,formal,symbol,position,0x4D);
    return REPORT_EXPR_ERROR_PLAIN(0,expression);
}
/* 1580 */
/* DEFAULT_ARGUMENT: a list node holding a fresh copy of formal's default argument,
   or 0 when it has none. */
unsigned int far pascal DEFAULT_ARGUMENT(register unsigned int formal)
{
    if(formal && A(formal,8))
        return MAKE_LIST_NODE(UNPACK_EXPR_TREE(A(formal,8)),0);
    return 0;
}
