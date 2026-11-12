/* target: ovr097_C39UNIT */
/* Role: C++ expressions: overload resolution: ranks argument conversions, picks the best
   candidate, finds and applies user conversion functions. Entry points:
   FIND_MATCHING_OVERLOAD, SELECT_OVERLOAD, FIND_USER_CONVERSION, APPLY_CONVERSION_FUNCTION.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: C++ overload resolution and user-defined conversions.
   - SELECT_OVERLOAD picks the function to call among the overloads in chain first
     (and a second chain, used for operators: the member operators and the global
     ones) for a call node whose argument list is already analyzed. It runs
     PICK_BEST_CANDIDATE twice: first allowing only standard conversions, then also
     user conversions and ellipsis matches. Called from CPPCALL.C.
   - Each argument/parameter pair gets a rank (RANK_CONVERSION): 7 exact match, 6
     exact apart from added const/volatile (or an overloaded function name matching a
     function pointer parameter), 5 promotion, 4 standard conversion, 3 standard
     conversion that needs a temporary for a reference, 2 user conversion, 1 matched
     by an ellipsis, 0 no match. A candidate's rank is its worst argument's;
     PREFER_CANDIDATE compares two candidates argument by argument (better on some
     and worse on none wins), using COMPARE_CONVERSIONS to break ties between pointer
     and reference conversions (cv-qualification, void *, derived over base).
   - FIND_USER_CONVERSION looks for a way to convert type to desired through a
     conversion function of type's class (FIND_CONVERSION_FUNCTION) or a constructor
     of desired's class (tried by a fake one-argument call), reporting ambiguities
     when a source position is given. APPLY_CONVERSION_FUNCTION applies one to a class
     value.
   - FIND_MATCHING_OVERLOAD picks the overload of an exact function type (for taking
     the address of an overloaded function).
   The mask arguments name the kind of built-in type wanted, as EXPR_FLAGS bits of the
   type kind (1 integral, 7 arithmetic or pointer, probably; 0x80 a pointer to member).
   Conversion functions are all members named TOKEN_NAMES[TOK_TYPEDEF] (they are told
   apart by result type) and constructors CTOR_NAME (TOKEN_NAMES[5]).
   F(t) is EXPR_FLAGS of type t's kind: 3 arithmetic, 0x14 pointer or reference (with
   TYPE_ATTRS 0x20 a reference), 0x40 class. Several searches use symbol record 0 as a
   sentinel. */
/* Overload candidate ranking and conversion selection. */
/* opts: -mm -G- -O -Z -p -Y -TjNOSMART -Tm2 */
#include <dos.h>
#include "OVERLOAD.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define F(t) EXPR_FLAGS[TYPE_W((t),TYPE_KIND)]
static unsigned int near pascal FIND_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned char far *);
/* IS_STANDARD_CONVERSION: 1 if a value of type right converts to type left by a
   standard conversion: arithmetic to arithmetic; to a reference of a compatible type
   or of a base class; a null constant (zero) to any pointer; a pointer to void * (or,
   in C, from void *) or to a pointer to a base class. With strict 0 the base class must
   also be unique and accessible (IS_BASE_CLASS strict mode). */
static unsigned char far pascal IS_STANDARD_CONVERSION(register unsigned int left,register unsigned int right,unsigned char zero,unsigned char strict)
{
    if((F(left)&3)&&(F(right)&3)) return 1;
    if((F(left)&0x14)&&(TYPE_B(left,TYPE_ATTRS)&0x20)) {
        if(C7_TYPE_COMPAT(TYPE_W(left,TYPE_TARGET),right,0)) return 1;
        if(F(right)&0x40) return IS_BASE_CLASS(TYPE_W(left,TYPE_TARGET),right,!strict);
        return 0;
    }
    if(zero&&(F(left)&0x14)) return 1;
    if((F(left)&0x14)&&(F(right)&0x14)) {
        if(((F(left)&0x14)&&TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_VOID)||
           ((F(right)&0x14)&&TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)==TK_VOID&&!CPP_MODE)) return 1;
        return IS_BASE_CLASS(TYPE_W(left,TYPE_TARGET),TYPE_W(right,TYPE_TARGET),!strict);
    }
    return 0;
}
/* IS_PROMOTION: 1 if right promotes to left: the same integral kind, int from char,
   unsigned char or short (kinds below 4), unsigned int from unsigned short, or a
   floating type to a larger one other than long double. An enum counts as its
   underlying type (TAG_ENUM_BASE, tag word 4). */
static unsigned char near pascal IS_PROMOTION(unsigned int left,register unsigned int right)
{
    register int kind;
    int other;
    if(TYPE_W(right,TYPE_KIND)==TK_ENUM) right=AT_W(TAG_BODY_POOL_SEG,TYPE_W(right,TYPE_TAG_BODY)+4);
    kind=TYPE_W(left,TYPE_KIND); other=TYPE_W(right,TYPE_KIND);
    if(EXPR_FLAGS[kind]&1) {
        if(kind==other||(kind==5&&other<4)||(kind==6&&other==4)) return 1;
    } else if(EXPR_FLAGS[kind]&2) {
        if((EXPR_FLAGS[other]&2)&&kind!=0xB&&other<kind) return 1;
    }
    return 0;
}
/* MATCH_RANK: 7 when left and right are the same type (a reference on one side, or
   pointers on both, are compared by their targets), 6 when the targets differ only in
   const/volatile and left adds qualifiers (any difference with strict), else 0. */
static unsigned int near pascal MATCH_RANK(register unsigned int left,register unsigned int right,unsigned char strict)
{
    unsigned char adjusted=0;
    if((F(left)&0x14)&&(TYPE_B(left,TYPE_ATTRS)&0x20)&&!((F(right)&0x14)&&(TYPE_B(right,TYPE_ATTRS)&0x20))) {
        adjusted=1; left=TYPE_W(left,TYPE_TARGET);
    } else if((F(right)&0x14)&&(TYPE_B(right,TYPE_ATTRS)&0x20)&&!((F(left)&0x14)&&(TYPE_B(left,TYPE_ATTRS)&0x20))) {
        right=TYPE_W(right,TYPE_TARGET);
    } else if((F(left)&0x14)&&(F(right)&0x14)) {
        adjusted=1; left=TYPE_W(left,TYPE_TARGET); right=TYPE_W(right,TYPE_TARGET);
    }
    if(adjusted) {
        if(TYPES_COMPATIBLE(left,right,1)) {
            unsigned int a=TYPE_B(left,TYPE_ATTRS)&3,b=TYPE_B(right,TYPE_ATTRS)&3;
            if(a==b) return 7;
            if(strict||((a&~b)==a)) return 6;
            return 0;
        }
        return 0;
    }
    return TYPES_COMPATIBLE(left,right,1)?7:0;
}
/* NEEDS_REFERENCE_TEMP: 1 when desired is a reference that cannot be bound directly
   to expression: the value is not an object, would lose const or volatile, or is of a
   type that is neither the same nor a derived class. */
static unsigned char near pascal NEEDS_REFERENCE_TEMP(unsigned int expression,unsigned int desired)
{
    register unsigned int left,right;
    if(!((F(desired)&0x14)&&(TYPE_B(desired,TYPE_ATTRS)&0x20))||C7_TYPE_COMPAT(desired,EXPR_W(expression,EXPR_TYPE),0)) return 0;
    if(!(IS_LVALUE(expression)||IS_OBJECT_RVALUE(expression))) return 1;
    left=TYPE_W(desired,TYPE_TARGET); right=EXPR_W(expression,EXPR_TYPE);
    if((TYPE_B(left,TYPE_ATTRS)&1)<(TYPE_B(right,TYPE_ATTRS)&1)||(TYPE_B(left,TYPE_ATTRS)&2)<(TYPE_B(right,TYPE_ATTRS)&2)) return 1;
    if(TYPES_COMPATIBLE(left,right,1)) return 0;
    if((F(left)&0x40)&&(F(right)&0x40)) return !IS_BASE_CLASS(left,right,1);
    return 1;
}
/* FIND_MATCHING_OVERLOAD: the overload in chain head whose type is compatible with
   function type type (or with the target of a function pointer type), or 0. */
unsigned int far pascal FIND_MATCHING_OVERLOAD(register unsigned int head,register unsigned int type)
{
    if(F(type)&0x14) type=TYPE_W(type,TYPE_TARGET);
    SYM_W(0,SYM_TYPE)=type;
    while(!TYPES_COMPATIBLE(SYM_W(head,SYM_TYPE),type,2)) head=SYM_W(head,SYM_NEXT_OVERLOAD);
    return head;
}
/* RANK_CONVERSION: the rank (see the overview) of passing expression to a parameter
   of type desired. User conversions are only considered when user is set; strict is
   passed on to the base class checks. */
static unsigned int near pascal RANK_CONVERSION(register unsigned int desired,register unsigned int expression,unsigned char user,unsigned char strict)
{
    unsigned int type=EXPR_W(expression,EXPR_TYPE),rank,adjusted;
    rank=MATCH_RANK(desired,type,strict);
    if(rank) return rank;
    if((F(desired)&0x14)&&TYPE_W(TYPE_W(desired,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) {
        adjusted=EXPR_W(expression,EXPR_OP)==EOP_ADDR?EXPR_W(expression,EXPR_LEFT):expression;
        if(EXPR_W(adjusted,EXPR_OP)==1&&TYPE_W(EXPR_W(adjusted,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION&&FIND_MATCHING_OVERLOAD(EXPR_W(adjusted,EXPR_LEFT),desired)) return 6;
    }
    if(IS_PROMOTION(desired,type)) return 5;
    if(IS_STANDARD_CONVERSION(desired,type,EXPR_W(expression,EXPR_OP)==EOP_CONST&&AT_L(EXPR_POOL_SEG,expression+10)==0L,strict))
        return NEEDS_REFERENCE_TEMP(expression,desired)?3:4;
    if(!user) return 0;
    if((F(desired)&0x14)&&(TYPE_B(desired,TYPE_ATTRS)&0x20)) desired=TYPE_W(desired,TYPE_TARGET);
    if(FIND_USER_CONVERSION(desired,type,0,0,0)) return 2;
    return 0;
}
/* COMPARE_CONVERSIONS: which parameter type, left or right, is the better target for
   argument expression: 1 left, 2 right, 0 neither. Different ranks decide first; for
   two pointer or reference targets the one with the qualification closest to the
   argument's, a non-void target over void * (unless the argument is a null constant),
   and a pointer to a derived class over one to its base win. */
static unsigned int near pascal COMPARE_CONVERSIONS(register unsigned int left,register unsigned int right,unsigned int expression,unsigned char user)
{
    int a,b;
    unsigned char zero;
    unsigned int type;
    a=RANK_CONVERSION(left,expression,user,1);
    b=RANK_CONVERSION(right,expression,user,1);
    if(a!=b) return a>b?1:2;
    if(!((F(left)&0x14)&&(F(right)&0x14))) return 0;
    left=TYPE_W(left,TYPE_TARGET); right=TYPE_W(right,TYPE_TARGET);
    zero=EXPR_W(expression,EXPR_OP)==EOP_CONST&&AT_L(EXPR_POOL_SEG,expression+10)==0L;
    type=EXPR_W(expression,EXPR_TYPE);
    if(F(type)&0x14) type=TYPE_W(type,TYPE_TARGET);
    if(TYPES_COMPATIBLE(left,right,0)) return 0;
    if(TYPES_COMPATIBLE(left,right,1)) {
        unsigned int ac,bc,ec,av,bv,ev;
        ac=(TYPE_B(left,TYPE_ATTRS)&1)!=0; bc=(TYPE_B(right,TYPE_ATTRS)&1)!=0; ec=(TYPE_B(type,TYPE_ATTRS)&1)!=0;
        av=(TYPE_B(left,TYPE_ATTRS)&2)!=0; bv=(TYPE_B(right,TYPE_ATTRS)&2)!=0; ev=(TYPE_B(type,TYPE_ATTRS)&2)!=0;
        if(ec==ev) {
            ac+=av; bc+=bv;
            if(ac==bc) return 0;
            return ((ac>bc)==ec)?1:2;
        }
        if(ec) {
            if(ac&&!bc) return 1;
            if(bc&&!ac) return 2;
            return av?2:1;
        } else {
            if(av&&!bv) return 1;
            if(bv&&!av) return 2;
            return ac?2:1;
        }
    }
    if(TYPE_W(left,TYPE_KIND)==TK_VOID) return zero?0:2;
    if(TYPE_W(right,TYPE_KIND)==TK_VOID) return zero?0:1;
    if(IS_BASE_CLASS(left,right,1)) return 2;
    if(IS_BASE_CLASS(right,left,1)) return 1;
    return 0;
}
/* PREFER_CANDIDATE: compares candidates left and right for argument list arguments:
   returns the better one, or 0 when neither is better on every argument. When one is
   a static member function and the call has an object argument (list flag 0x40), the
   object is compared only against the other's this parameter. A candidate whose
   parameters run out first (it takes the remaining arguments through its ellipsis)
   loses the tie. In the
   preference code 1 means left, 2 right, 3 conflicting. */
static unsigned int near pascal PREFER_CANDIDATE(unsigned int arguments,unsigned char user,unsigned int left,unsigned int right)
{
    register unsigned int preference=0;
    unsigned int a=TYPE_W(SYM_W(left,SYM_TYPE),TYPE_PARAMS),b=TYPE_W(SYM_W(right,SYM_TYPE),TYPE_PARAMS),next;
    if(arguments&&((SYM_W(left,SYM_FUNC_FLAGS)|SYM_W(right,SYM_FUNC_FLAGS))&0x40)&&(EXPR_B(arguments,EXPR_NODE_FLAGS)&0x40)) {
        if(SYM_W(left,SYM_FUNC_FLAGS)&0x40) {
            if(!(SYM_W(right,SYM_FUNC_FLAGS)&0x40)) {
                if(RANK_CONVERSION(FORMAL_W(b,FORMAL_TYPE),EXPR_W(arguments,EXPR_RIGHT),user,1)!=7) preference=1;
                b=FORMAL_W(b,FORMAL_NEXT);
            }
        } else {
            if(RANK_CONVERSION(FORMAL_W(a,FORMAL_TYPE),EXPR_W(arguments,EXPR_RIGHT),user,1)!=7) preference=2;
            a=FORMAL_W(a,FORMAL_NEXT);
        }
        arguments=EXPR_W(arguments,EXPR_LEFT);
    }
    while(arguments&&a&&b&&preference!=3) {
        next=COMPARE_CONVERSIONS(FORMAL_W(a,FORMAL_TYPE),FORMAL_W(b,FORMAL_TYPE),EXPR_W(arguments,EXPR_RIGHT),user);
        if(!preference) preference=next;
        else if(next&&preference!=next) preference=3;
        arguments=EXPR_W(arguments,EXPR_LEFT); a=FORMAL_W(a,FORMAL_NEXT); b=FORMAL_W(b,FORMAL_NEXT);
    }
    if(arguments&&preference!=3&&a!=b) {
        if(!a) {
            if(preference==1) preference=3;
            else preference=2;
        } else {
            if(preference==2) preference=3;
            else preference=1;
        }
    }
    switch(preference) {
    case 1: return left;
    case 2: return right;
    default: return 0;
    }
}
/* ARGS_CONVERT_FOR_CANDIDATE: for a non-member operator function found only through
   user conversions: 1 if every argument that needed a user conversion could also be
   converted to the built-in kind mask (directly or by a conversion function); then the
   built-in operator would do as well and the call is ambiguous. Member functions
   always give 0. */
static unsigned char near pascal ARGS_CONVERT_FOR_CANDIDATE(register unsigned int arguments,unsigned int symbol,unsigned int mask)
{
    register unsigned int parameter;
    unsigned int desired,actual;
    unsigned char acceptable,reported;
    if(SYM_B(symbol,SYM_FLAGS)&0x10) return 0;
    parameter=TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_PARAMS);
    acceptable=1;
    while(arguments&&acceptable) {
        desired=FORMAL_W(parameter,FORMAL_TYPE); actual=EXPR_W(EXPR_W(arguments,EXPR_RIGHT),EXPR_TYPE);
        if((int)RANK_CONVERSION(desired,EXPR_W(arguments,EXPR_RIGHT),1,0)<=2) {
            acceptable=(EXPR_FLAGS[TYPE_W(actual,TYPE_KIND)]&mask)||FIND_CONVERSION_FUNCTION(0,actual,0,mask,0,0,&reported);
            arguments=EXPR_W(arguments,EXPR_LEFT); parameter=FORMAL_W(parameter,FORMAL_NEXT);
        } else acceptable=0;
    }
    return acceptable;
}
/* PICK_BEST_CANDIDATE: ranks every candidate in chain first, then in chain second,
   against the call node expression and returns the best (0 if none matches). Reports
   MSG_AMBIGUITY_BETWEEN (when the node has a source line) when two candidates are
   equally good, or when a single operator candidate competes with the built-in
   operator (mask, see ARGS_CONVERT_FOR_CANDIDATE). The local names are misleading:
   "variadic" is set for a member function (SYM_FLAGS 0x10) and "has_defaults" for a
   function with an ellipsis (TYPE_FUNC_FLAGS 4); "object" means the call's first
   argument is the object for a member function. A non-static member function without
   an object argument cannot be chosen, and a static one skips the object. */
static unsigned int near pascal PICK_BEST_CANDIDATE(unsigned int expression,unsigned int first,unsigned int second,unsigned int mask,unsigned char user)
{
    register unsigned int symbol,arguments;
    unsigned char variadic;
    unsigned int parameter,best,other,selected,type;
    int current,rank;
    unsigned char has_defaults,object;
    unsigned int count;
    best=0;count=0;variadic=0;
    if(!first) {first=second;second=0;}
    symbol=first;
    while(symbol) {
        rank=7; type=SYM_W(symbol,SYM_TYPE);
        variadic=(SYM_B(symbol,SYM_FLAGS)&0x10)!=0;
        has_defaults=(TYPE_B(type,TYPE_FUNC_FLAGS)&4)!=0;
        parameter=TYPE_W(type,TYPE_PARAMS); arguments=EXPR_W(expression,EXPR_RIGHT);
        object=variadic&&(EXPR_B(arguments,EXPR_NODE_FLAGS)&0x40);
        if(object&&(SYM_W(symbol,SYM_FUNC_FLAGS)&0x40)) {
            arguments=EXPR_W(arguments,EXPR_LEFT); object=0;
        }
        if(variadic&&!object&&!(SYM_W(symbol,SYM_FUNC_FLAGS)&0x40)) rank=0;
        else {
            /* The candidate's rank is the worst rank of its arguments; extra arguments
               need an ellipsis (rank 1, only in the second pass). */
            while(rank>1&&arguments) {
                if(!parameter) rank=has_defaults&&user?1:0;
                else {
                    current=RANK_CONVERSION(FORMAL_W(parameter,FORMAL_TYPE),EXPR_W(arguments,EXPR_RIGHT),user,object);
                    if(current<rank) rank=current;
                    parameter=FORMAL_W(parameter,FORMAL_NEXT);
                }
                arguments=EXPR_W(arguments,EXPR_LEFT); object=0;
            }
            if(parameter&&!FORMAL_W(parameter,FORMAL_DEFAULT_ARG)) rank=0;
        }
        if(rank>0) {
            ++count;
            if(!best) best=symbol;
            else {
                selected=PREFER_CANDIDATE(EXPR_W(expression,EXPR_RIGHT),user,symbol,best);
                if(!selected) other=symbol;
                else {best=selected;count=1;}
            }
        }
        symbol=SYM_W(symbol,SYM_NEXT_OVERLOAD);
        if(!symbol) {symbol=second;second=0;}
    }
    /* Two equally good candidates, or one operator function that the built-in
       operator could replace: ambiguous. */
    if(EXPR_W(expression,EXPR_SRC_LINE)&&(count>1||(count==1&&mask&&user&&ARGS_CONVERT_FOR_CANDIDATE(EXPR_W(expression,EXPR_RIGHT),best,mask)))) {
        REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN,(long)(count==1?NAME_TEXT_COPY(SYM_W(best,SYM_NAME)):FORMAT_SYMBOL(other)),
                (long)FORMAT_SYMBOL(best),EXPR_W(expression,EXPR_SRC_LINE),EXPR_W(expression,EXPR_SRC_WORD3));
    }
    return best;
}
/* SELECT_OVERLOAD: the best overload for call node expression among chains first and
   second (see the overview); mask is the built-in operator kind for operator calls,
   0 for ordinary calls. */
unsigned int far pascal SELECT_OVERLOAD(register unsigned int expression,register unsigned int first,unsigned int second,unsigned int mask)
{
    unsigned int found=PICK_BEST_CANDIDATE(expression,first,second,0,0);
    if(found) return found;
    return PICK_BEST_CANDIDATE(expression,first,second,mask,1);
}
/* FIND_CONVERSION_FUNCTION: a conversion function of class type (or, when the class
   has none that fits, of its bases) to use for a value wanted as desired. With exact
   the result type must be compatible with desired; with mask it must be of the
   built-in kind mask (an exact match wins at once); otherwise an exact match wins and
   standard conversions of the result count. Two eligible functions, or one when a
   standard conversion to a base reference would also do, is an ambiguity: reported
   once (*reported) when line is given, else the result is 0. The expression
   (EXPR_FLAGS+1)[kind-1] is EXPR_FLAGS[kind] written as in the original. */
static unsigned int near pascal FIND_CONVERSION_FUNCTION(unsigned int desired,unsigned int type,unsigned char exact,unsigned int mask,unsigned int line,unsigned int column,unsigned char far *reported)
{
    register unsigned int symbol,returned;
    unsigned int second,first,member,count;
    unsigned char eligible;
    unsigned int base;
    unsigned char exact_found;
    unsigned int rank;
    *reported=0;
    count=0;exact_found=0;first=0;second=0;
    member=FIND_MEMBER_BY_NAME(TOKEN_NAMES[TOK_TYPEDEF],type);
    symbol=member==0?0:AT_W(MEMBER_SEGMENT,member+6);
    while(symbol) {
        returned=TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_TARGET);
        if(exact) eligible=TYPES_COMPATIBLE(desired,returned,2);
        else if(mask) {
            if(desired&&TYPES_COMPATIBLE(desired,returned,2)) {
                count=1;exact_found=1;first=symbol;break;
            }
            if(mask==0x80)
                eligible=TYPE_W(((F(returned)&0x14)&&(TYPE_B(returned,TYPE_ATTRS)&0x20))?TYPE_W(returned,TYPE_TARGET):returned,TYPE_KIND)==0xD&&
                         TYPE_B(((F(returned)&0x14)&&(TYPE_B(returned,TYPE_ATTRS)&0x20))?TYPE_W(returned,TYPE_TARGET):returned,TYPE_PTR_MODE)==0xB;
            else
                eligible=(EXPR_FLAGS+1)[((F(returned)&0x14)&&(TYPE_B(returned,TYPE_ATTRS)&0x20))?TYPE_W(TYPE_W(returned,TYPE_TARGET),TYPE_KIND):TYPE_W(returned,TYPE_KIND)-1]&(unsigned char)mask;
            eligible=eligible&&(!desired||C7_TYPE_COMPAT(desired,returned,0));
        } else {
            rank=MATCH_RANK(desired,returned,0);
            if(!rank) eligible=IS_STANDARD_CONVERSION(desired,returned,0,1);
            else {count=1;exact_found=1;first=symbol;break;}
        }
        if(eligible) {
            ++count;
            if(count==1) first=symbol;
            else second=symbol;
        }
        symbol=SYM_W(symbol,SYM_NEXT_OVERLOAD);
    }
    if(!count) {
        base=AT_W(TAG_BODY_POOL_SEG,TYPE_W(type,TYPE_TAG_BODY)+12);
        while(base) {
            symbol=FIND_CONVERSION_FUNCTION(desired,AT_W(BASE_LIST_SEG,base+2),exact,mask,line,column,reported);
            if(symbol&&symbol!=first) {
                ++count;
                if(MATCH_RANK(desired,TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_TARGET),0)) {
                    if(!exact_found) count=1;
                    exact_found=1;
                }
                if(count==1) first=symbol;
                else second=symbol;
            }
            base=AT_W(BASE_LIST_SEG,base);
        }
    }
    if(!(count>1||(count==1&&(F(desired)&0x14)&&(TYPE_B(desired,TYPE_ATTRS)&0x20)&&IS_BASE_CLASS(TYPE_W(desired,TYPE_TARGET),type,1)))) goto return_result;
    if(!line) first=0;
    else if(!*reported)
        REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN,(long)FORMAT_SYMBOL(first),(long)(count>1?FORMAT_SYMBOL(second):(char far *)STR_A_STANDARD_CONVERSION),line,column);
    *reported=1;
return_result:
    return first;
}
/* FIND_USER_CONVERSION: the function that converts a value of type to desired: a
   conversion function of type's class, or a constructor of desired's class callable
   with one argument of type (found by ranking a fake call desired(type value), with
   the hidden virtual-base flag when the class has virtual bases). The constructor is
   preferred; if both fit exactly it is an ambiguity, reported when line is given,
   else 0 is returned. The result's SYM_FUNC_KIND tells which (3 constructor, 2
   conversion function). */
unsigned int far pascal FIND_USER_CONVERSION(register unsigned int desired,unsigned int type,unsigned char exact,unsigned int line,unsigned int column)
{
    register unsigned int expression;
    unsigned int found;
    unsigned char reported;
    unsigned int member,candidates,constructor;
    if(!desired||!type) return 0;
    found=0;reported=0;
    if(F(type)&0x40) found=FIND_CONVERSION_FUNCTION(desired,type,exact,0,line,column,&reported);
    if(!reported&&(F(desired)&0x40)) {
        expression=MAKE_LIST_NODE(MAKE_INT_CONSTANT(type,1L),0);
        if(AT_W(TAG_BODY_POOL_SEG,TYPE_W(desired,TYPE_TAG_BODY)+24)&4)
            expression=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,0L),expression);
        expression=MAKE_LIST_NODE(MAKE_INT_CONSTANT(desired,1L),expression);
        EXPR_B(expression,EXPR_NODE_FLAGS)|=0x40;
        expression=MAKE_BINARY_NODE(1,0,expression);
        EXPR_W(expression,EXPR_SRC_LINE)=line; EXPR_W(expression,EXPR_SRC_WORD3)=column;
        member=FIND_MEMBER_BY_NAME(CTOR_NAME,desired);
        candidates=member==0?0:AT_W(MEMBER_SEGMENT,member+6);
        constructor=PICK_BEST_CANDIDATE(expression,candidates,0,0,0);
        FREE_EXPR_TREE(expression);
        if(constructor) {
            if(found&&MATCH_RANK(desired,TYPE_W(SYM_W(found,SYM_TYPE),TYPE_TARGET),0)) {
                if(!line) constructor=0;
                else REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN,(long)FORMAT_SYMBOL(found),(long)FORMAT_SYMBOL(constructor),line,column);
            }
            found=constructor;
        }
    }
    return found;
}
/* APPLY_CONVERSION_FUNCTION: if expression is a class value and a conversion function
   to desired (or to a type of kind mask) exists, returns the analyzed call
   expression.operator T(); otherwise expression unchanged. */
unsigned int far pascal APPLY_CONVERSION_FUNCTION(register unsigned int expression,unsigned int mask,unsigned int desired)
{
    register unsigned int symbol;
    unsigned int callee;
    unsigned char reported;
    if(!(F(EXPR_W(expression,EXPR_TYPE))&0x40)||(!desired&&!mask)) return expression;
    {
        symbol=FIND_CONVERSION_FUNCTION(desired,EXPR_W(expression,EXPR_TYPE),0,mask,EXPR_W(expression,EXPR_SRC_LINE),EXPR_W(expression,EXPR_SRC_WORD3),&reported);
        if(symbol) {
            callee=MAKE_SYMBOL_NODE(symbol);
            if(SYM_W(symbol,SYM_FUNC_KIND)!=2) EXPR_W(callee,EXPR_SCOPE_CLASS)=SYM_W(SYM_W(symbol,SYM_OWNER_CLASS),SYM_TYPE);
            expression=MAKE_CALL_NODE(MAKE_BINARY_NODE(0x2F,expression,callee),0,0,0,0,0);
            expression=ANALYZE_EXPRESSION(expression,0,0);
        }
    }
    return expression;
}
