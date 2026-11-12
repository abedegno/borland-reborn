/* target: CONVERT */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE edit: compiled by BC 2.0 directly, not through TASM as BCC's copy was
   (-B -TjNOSMART -Tm2 dropped): CPP.EXE's relocations for this module come in
   descending order, which BC's own objects give (TASM objects give ascending). */
/* CPP.EXE module CONVERT (image 0x4314..0x4754, frame 0431h): source taken from the
   BCC.EXE reconstruction (bcc20/src/expr/CONVERT.C), with CPP.EXE's
   edits marked "CPP.EXE edit". CPP.EXE has only some of its functions, in the same
   order; left out here: MAKE_DEREF_NODE, MAKE_DEREFERENCE, C7CHAIN, MAKE_ADDRESS_OF,
   DECAY_TO_POINTER, C7CONST, IS_MODIFIABLE_NODE, IS_BIT_FIELD_NODE, C7COMPAT, C7RANK,
   BALANCE_BINARY_OPERANDS, APPLY_BASED_POINTER. */
/* Role: expressions: conversions for #if expressions: implicit conversion to a type,
   casts, enum to int, usual arithmetic conversions. Entry points: CONVERT_EXPR_TO_TYPE,
   CONVERT_TO_RVALUE, ENUM_UNDERLYING_TYPE, NODE_ENUM_TO_INT, CHECK_CAST,
   USUAL_ARITHMETIC_CONVERSIONS. */
/* Overview: the conversions used by the expression checkers: the implicit conversion
   of a value to a target type (CONVERT_EXPR_TO_TYPE), the check of an explicit cast
   (CHECK_CAST), and bringing the two operands of a binary operator to a common type
   (USUAL_ARITHMETIC_CONVERSIONS). Conversions are expressed by cast nodes
   (MAKE_CAST_NODE, operator 0x35) that ANALYZE_EXPRESSION then checks; where a
   conversion changes nothing the operand is simply retyped. BCC's version also built
   * and & nodes, decayed arrays and functions and read references; CPP.EXE's #if
   expressions need none of that.
   EXPR_FLAGS bits: 1 integral, 2 floating, 0x14 pointer kinds, 0x40 struct/union, 0x20
   unsigned (as used here). RANK(k) is byte 0 of the kind's KIND_SIZE_TABLE row, which
   is its size in bytes. INT_TYPE is the int type. The node payload at offset 20
   (PAYLOAD) is the source position. */
#include <dos.h>
#include "EXPRN7.H"
#include "EXPRC7.H"
#include "UNIT7.H"
#include "MSG.H"
#include "POOL.H"
#define VALUE(n) (*(long far *)MK_FP(EXPR_POOL_SEG,(n)+10))
#define RANK(k) KIND_SIZE_TABLE[(k)*4]
#define PAYLOAD(n) (*(struct NodePayload far *)MK_FP(EXPR_POOL_SEG,(n)+20))
#define TOKEN_WORD (*(unsigned int near *)&CURRENT_TOKEN_RECORD)





/* CONVERT_EXPR_TO_TYPE: implicit conversion of expression to "target" (mode is passed
   to ANALYZE_EXPRESSION as context). If the types are compatible ignoring qualifiers the
   node is just retyped; otherwise a cast node is built and analysed. (BCC's version also
   gave the pointer and "may lose significant digits" warnings and applied C++
   conversion functions; see the CPP.EXE edit below.) */
unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int target,unsigned int expression,unsigned int mode)
{
    unsigned int source_type; /* CPP.EXE edit: not register (CPP.EXE has expression in SI,
                                 source_type in DI, from the compiler's own choice) */

    /* The code reads the arena at expression+8 before checking its handle. */
    source_type=EXPR_W(expression,EXPR_TYPE);
    if(expression==0) return 0;
    if(TYPE_W(source_type,TYPE_KIND)==TK_ENUM)
        source_type=TAG_W(TYPE_W(source_type,TYPE_TAG_BODY),TAG_ENUM_BASE);
    if(TYPES_COMPATIBLE(target,source_type,2)) {
        EXPR_W(expression,EXPR_TYPE)=target;
        return expression;
    }
    /* CPP.EXE edit: no portability warnings and no C++ conversion function; CPP.EXE
       (CPP image 0x4366) goes from TYPES_COMPATIBLE straight to the cast node. BCC's register
       copy "destination" of target is absent too: CPP.EXE reads target from the stack. */
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(target,expression),0,mode);
}


/* CONVERT_TO_RVALUE: in BCC reads a reference (C++) and decays arrays and functions,
   the usual step before a value is used; in CPP.EXE it returns its argument. */
unsigned int far pascal CONVERT_TO_RVALUE(unsigned int node)
{
    /* CPP.EXE edit: returns node unchanged (CPP image 0x4381: mov ax,[bp+6]); BCC dereferences
       references in C++ and decays arrays and functions (DECAY_TO_POINTER, absent in
       CPP.EXE). */
    return node;
}

/* ENUM_UNDERLYING_TYPE: an enum type's integer type; other types unchanged. */
unsigned int far pascal ENUM_UNDERLYING_TYPE(register unsigned int type)
{
    if(TYPE_W(type,TYPE_KIND)==TK_ENUM)
        return TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE);
    return type;
}

/* NODE_ENUM_TO_INT: gives an enum-typed node its integer type in place. */
unsigned int far pascal NODE_ENUM_TO_INT(register unsigned int node)
{
    if(!node)
        return node;
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_ENUM)
        EXPR_W(node,EXPR_TYPE)=TAG_W(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TAG_BODY),TAG_ENUM_BASE);
    return node;
}






/* CHECK_CAST: validates the analysed cast node expression and simplifies it. An integer
   cast to a far pointer is first made long. The cast disappears when the types are
   compatible. (BCC's version also handled based pointers, reinterpreted lvalues in
   place (C7RANK) and reported impossible casts; see the CPP.EXE edits below.) */
unsigned int far pascal CHECK_CAST(unsigned int expression)
{
    unsigned int result;
    unsigned int source_type;
    register unsigned int node=expression;
    unsigned int type; /* CPP.EXE edit: not register (CPP.EXE keeps it at [bp-4] and
                          source_type in DI) */

    source_type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    type=EXPR_W(node,EXPR_TYPE);
    result=node;
    if(TYPE_W(type,TYPE_KIND)==TK_FAR_PTR) {
        if(TYPE_W(source_type,TYPE_KIND)==TK_NEAR_PTR && TYPE_W(source_type,TYPE_PTR_BASE)!=0) {
            /* CPP.EXE edit: no APPLY_BASED_POINTER; the operand's type is read again */
            source_type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
        } else if(EXPR_FLAGS[TYPE_W(source_type,TYPE_KIND)]&1)
            EXPR_W(node,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(LONG_TYPE,EXPR_W(node,EXPR_LEFT),0);
    }
    if(TYPE_W(source_type,TYPE_KIND)==TK_VOID && TYPE_W(type,TYPE_KIND)!=TK_VOID)
        result=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    else if(TYPES_COMPATIBLE(type,source_type,1)) {
        EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE)=type;
        result=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(node);
    }
    /* CPP.EXE edit: the C7COMPAT ("cannot cast") and C7RANK (lvalue reinterpretation)
       branches are absent (CPP image 0x44A4 follows the TYPES_COMPATIBLE branch). */
    EXPR_B(result,EXPR_NODE_FLAGS)|=1;
    return result;
}

/* C7RANGE: a constant node that fits in char / unsigned char (kind 1 or 2 of type) is
   given that type, so that arithmetic with a char operand can stay in bytes. */
static void near pascal C7RANGE(register unsigned int node,unsigned int type)
{
    register unsigned int kind=TYPE_W(type,TYPE_KIND);
    long value;

    if(kind==1 || kind==2) {
        value=VALUE(node);
        if(TYPE_RANGE_TABLE[kind].minimum<=value && TYPE_RANGE_TABLE[kind].maximum>=value)
            EXPR_W(node,EXPR_TYPE)=type;
    }
}

/* USUAL_ARITHMETIC_CONVERSIONS: converts both operands of the binary node expression to
   a common arithmetic type and sets the node's type. requested is the wanted result
   type (0 = int). Floating: the larger floating kind (or the wanted one if larger).
   Integers: the larger size, unsigned winning at equal size; then, unless a type
   smaller than int is wanted, char and short become int and unsigned short unsigned
   int. So with a char wanted type, char op char stays char. */
unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int requested,unsigned int expression)
{
    unsigned int left_type;
    unsigned int right_type;
    int left_kind;
    int right_kind;
    int requested_kind;
    unsigned int selected_type;
    int selected_kind;
    unsigned int left_rank;
    unsigned int right_rank;
    register unsigned int left=EXPR_W(expression,EXPR_LEFT);
    register unsigned int right=EXPR_W(expression,EXPR_RIGHT);

    if(EXPR_W(left,EXPR_OP)==0 || EXPR_W(right,EXPR_OP)==0)
        return expression;
    requested_kind=requested==0?5:TYPE_W(requested,TYPE_KIND);
    if(requested_kind==1 || requested_kind==2) {
        if(EXPR_W(left,EXPR_OP)==EOP_CONST)
            C7RANGE(left,EXPR_W(right,EXPR_TYPE));
        if(EXPR_W(right,EXPR_OP)==EOP_CONST)
            C7RANGE(right,EXPR_W(left,EXPR_TYPE));
    }
    EXPR_W(left,EXPR_TYPE)=ENUM_UNDERLYING_TYPE(EXPR_W(left,EXPR_TYPE));
    left_type=EXPR_W(left,EXPR_TYPE);
    left_kind=TYPE_W(left_type,TYPE_KIND);
    EXPR_W(right,EXPR_TYPE)=ENUM_UNDERLYING_TYPE(EXPR_W(right,EXPR_TYPE));
    right_type=EXPR_W(right,EXPR_TYPE);
    right_kind=TYPE_W(right_type,TYPE_KIND);
    selected_kind=0;
    if((EXPR_FLAGS[left_kind]&2) || (EXPR_FLAGS[right_kind]&2)) {
        if(EXPR_FLAGS[left_kind]&2) {
            selected_type=left_type;
            selected_kind=left_kind;
        }
        if((EXPR_FLAGS[right_kind]&2) && right_kind>selected_kind) {
            selected_type=right_type;
            selected_kind=right_kind;
        }
        if(requested && (EXPR_FLAGS[TYPE_W(requested,TYPE_KIND)]&2) &&
                (int)TYPE_W(requested,TYPE_KIND)>selected_kind)
            selected_type=requested;
    } else {
        left_rank=RANK(left_kind);
        right_rank=RANK(right_kind);
        if(left_rank>right_rank ||
                (left_rank==right_rank && (EXPR_FLAGS[left_kind]&0x20) &&
                 !(EXPR_FLAGS[right_kind]&0x20))) {
            selected_type=left_type;
            selected_kind=left_kind;
        } else {
            selected_type=right_type;
            selected_kind=right_kind;
        }
        requested_kind=requested?TYPE_W(requested,TYPE_KIND):selected_kind;
        if(requested_kind>=5) {
            if(selected_kind<4)
                selected_type=INT_TYPE;
            else if(selected_kind==4)
                selected_type=UNSIGNED_INT_TYPE;
        }
        (void)0; /* match: CPP.EXE was compiled by BC 2.0 directly (no -B). Without
                    this empty statement the direct backend cross-jumps the float arm's
                    "selected_type=requested" store (image 0x4681: mov [bp-0Ch],ax; jmp)
                    into the UNSIGNED_INT_TYPE store at the end of this block; the
                    statement keeps that store from sitting at the join label. */
    }
    EXPR_W(expression,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(selected_type,right,0);
    EXPR_W(expression,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(selected_type,left,0);
    EXPR_W(expression,EXPR_TYPE)=selected_type;
    return expression;
}


