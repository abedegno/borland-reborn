/* target: ovr063_C7UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: expressions: conversions; dereference, address-of, array/function decay, rvalue,
   casts, enum to int, usual arithmetic conversions, with pointer-conversion warnings. Entry
   points: MAKE_DEREF_NODE, MAKE_DEREFERENCE, MAKE_ADDRESS_OF, CONVERT_EXPR_TO_TYPE,
   DECAY_TO_POINTER, CONVERT_TO_RVALUE, ENUM_UNDERLYING_TYPE, NODE_ENUM_TO_INT (+6 more).
   Map of all sources: docs/SOURCE-MAP.md. */
/* Complete authentic original0000..109E: fourteen exports and five private bodies. */
/* Overview: the conversions of the C++-mode front end, used by every checker: building
   * and & nodes, decaying arrays and functions to pointers, reading a value out of a
   reference (CONVERT_TO_RVALUE), the implicit conversion of a value to a target type
   with its portability warnings (CONVERT_EXPR_TO_TYPE), the check of an explicit cast
   (CHECK_CAST), and bringing the two operands of a binary operator to a common type
   (USUAL_ARITHMETIC_CONVERSIONS, BALANCE_BINARY_OPERANDS). Conversions are expressed
   by cast nodes (MAKE_CAST_NODE, operator 0x35) that ANALYZE_EXPRESSION then checks;
   where a conversion changes nothing the operand is simply retyped.
   MAKE_UNARY_NODE takes token codes: 0x18 is TOK_STAR (dereference), 0x1B TOK_AMPERSAND
   (address-of), 0x16 TOK_PLUS; 0x1D is another unary token used for plain functions.
   EXPR_FLAGS bits: 1 integral, 2 floating, 0x14 pointer kinds, 0x40 struct/union, 0x20
   unsigned (as used here). RANK(k) is byte 0 of the kind's KIND_SIZE_TABLE row, which
   is its size in bytes. INT_TYPE is the int type. A pointer type with TYPE_ATTRS
   bit 0x20 is a C++ reference. The node payload at offset 20 (PAYLOAD) is the source
   position, copied to nodes made here. */
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

/* MAKE_DEREF_NODE: builds an analysed *node whose type is node's pointer target. */
unsigned int far pascal MAKE_DEREF_NODE(unsigned int node)
{
    register unsigned int result;

    result=MAKE_UNARY_NODE(0x18,node);
    PAYLOAD(result)=PAYLOAD(node);
    EXPR_W(result,EXPR_TYPE)=TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET);
    EXPR_B(result,EXPR_NODE_FLAGS)|=1;
    return result;
}

/* MAKE_DEREFERENCE: *node, but *&x folds back to x when the types agree. */
unsigned int far pascal MAKE_DEREFERENCE(register unsigned int node)
{
    unsigned int result;

    if(EXPR_W(node,EXPR_OP)==EOP_ADDR &&
            TYPES_COMPATIBLE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),0)) {
        result=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(node);
    } else
        result=MAKE_DEREF_NODE(node);
    return result;
}

/* C7CHAIN: builds the analysed &expression with pointed-to type "type". For a comma
   chain the & goes onto the last operand and every comma takes the pointer type. The
   pointer kind and TYPE_PTR_MODE follow the object: a *p keeps p's kind and mode (a
   _seg pointer gives far), a far variable gives a far pointer, an automatic variable
   gets mode 3 (probably SS-relative) when DS may differ from SS, a far array (TYPE_ATTRS
   0x40) gives a huge pointer; otherwise mode 2 (code) or 4 (data). */
static unsigned int near pascal C7CHAIN(unsigned int expression,unsigned int type)
{
    unsigned int kind;
    int attribute;
    unsigned int last;
    unsigned int first;
    register unsigned int result;
    unsigned int node=expression;

    if(EXPR_W(node,EXPR_OP)==EOP_COMMA) {
        first=node;
        while(EXPR_W(node,EXPR_OP)==EOP_COMMA) {
            last=node;
            node=EXPR_W(node,EXPR_RIGHT);
        }
    } else
        last=0;
    result=MAKE_UNARY_NODE(0x1B,node);
    PAYLOAD(result)=PAYLOAD(node);
    while(EXPR_W(node,EXPR_OP)==EOP_DOT)
        node=EXPR_W(node,EXPR_LEFT);
    kind=0;
    attribute=TYPE_W(type,TYPE_KIND)==TK_FUNCTION?2:4;
    if(EXPR_W(node,EXPR_OP)==EOP_DEREF) {
        attribute=TYPE_SC(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_PTR_MODE);
        if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_SEG_PTR)
            kind=0x0F;
        else
            kind=TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND);
    } else if(EXPR_W(node,EXPR_OP)==1) {
        if(SYM_B(EXPR_W(node,EXPR_LEFT),SYM_FLAGS)&0x80) {
            kind=0x0F;
            attribute=0;
        } else if((SYM_B(EXPR_W(node,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==5 &&
                  (OPTION_DS_NOT_SS || ((int)(signed char)MODEL_FAR_DATA &
                                  !(int)(signed char)OPTION_SS_EQUALS_DS)))
            attribute=3;
    }
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_ARRAY && (TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&0x40)) {
        kind=0x10;
        attribute=0;
    }
    EXPR_W(result,EXPR_TYPE)=MAKE_POINTER_TYPE(type,kind,0);
    TYPE_B(EXPR_W(result,EXPR_TYPE),TYPE_PTR_MODE)=(unsigned char)attribute;
    EXPR_B(result,EXPR_NODE_FLAGS)|=1;
    if(!last)
        return result;
    EXPR_W(last,EXPR_RIGHT)=result;
    node=first;
    while(EXPR_W(node,EXPR_OP)==EOP_COMMA) {
        EXPR_W(node,EXPR_TYPE)=EXPR_W(result,EXPR_TYPE);
        node=EXPR_W(node,EXPR_RIGHT);
    }
    return first;
}

/* MAKE_ADDRESS_OF: &node with node's own type as target (see C7CHAIN). */
unsigned int far pascal MAKE_ADDRESS_OF(register unsigned int node)
{
    return C7CHAIN(node,EXPR_W(node,EXPR_TYPE));
}

/* CONVERT_EXPR_TO_TYPE: implicit conversion of expression to "target" (mode is passed
   to ANALYZE_EXPRESSION as context). If the types are compatible ignoring qualifiers the
   node is just retyped. Otherwise warns at the current token: integer to pointer or back
   ("nonportable pointer conversion", a separate message when the sizes are equal; a
   null pointer constant is fine), incompatible pointers ("suspicious pointer
   conversion", or "mixing pointers to signed and unsigned char"), long to a shorter
   integer ("conversion may lose significant digits"). In C++ a class value is first
   converted with its conversion function. Then a cast node is built and analysed. */
unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int target,unsigned int expression,unsigned int mode)
{
    unsigned char derived;
    register unsigned int source_type;
    register unsigned int destination=target;

    /* Original reads the arena at expression+8 before checking its handle. */
    source_type=EXPR_W(expression,EXPR_TYPE);
    if(expression==0) return 0;
    if(TYPE_W(source_type,TYPE_KIND)==TK_ENUM)
        source_type=TAG_W(TYPE_W(source_type,TYPE_TAG_BODY),TAG_ENUM_BASE);
    if(TYPES_COMPATIBLE(destination,source_type,2)) {
        EXPR_W(expression,EXPR_TYPE)=destination;
        return expression;
    }
    if(EXPR_FLAGS[TYPE_W(destination,TYPE_KIND)]&0x14) {
        expression=CHECK_NULL_CONSTANT(expression,&derived);
        if(!derived && (EXPR_FLAGS[TYPE_W(source_type,TYPE_KIND)]&1)) {
            if(TYPE_SIZE(destination)==TYPE_SIZE(source_type)) {
warn_equal_size:
                REPORT_CURRENT_TOKEN(MSG_NONPORTABLE_POINTER_375);
            } else
                REPORT_CURRENT_TOKEN(MSG_NONPORTABLE_POINTER);
        } else if(EXPR_FLAGS[TYPE_W(source_type,TYPE_KIND)]&0x14) {
            if(!C7_TYPE_COMPAT(destination,source_type,0)) {
                if(TYPE_W(destination,TYPE_KIND)==TYPE_W(source_type,TYPE_KIND) &&
                    TYPE_B(destination,TYPE_PTR_MODE)==TYPE_B(source_type,TYPE_PTR_MODE) &&
                    TYPE_W(destination,TYPE_PTR_BASE)==TYPE_W(source_type,TYPE_PTR_BASE) &&
                    (TYPE_W(TYPE_W(source_type,TYPE_TARGET),TYPE_KIND)==TK_CHAR || TYPE_W(TYPE_W(source_type,TYPE_TARGET),TYPE_KIND)==TK_UCHAR) &&
                    (TYPE_W(TYPE_W(destination,TYPE_TARGET),TYPE_KIND)==TK_CHAR || TYPE_W(TYPE_W(destination,TYPE_TARGET),TYPE_KIND)==TK_UCHAR))
                    REPORT_CURRENT_TOKEN(MSG_MIXING_POINTERS_SIGNED);
                else
                    REPORT_CURRENT_TOKEN(MSG_SUSPICIOUS_POINTER);
            }
        }
    } else if((EXPR_FLAGS[TYPE_W(destination,TYPE_KIND)]&1) && (EXPR_FLAGS[TYPE_W(source_type,TYPE_KIND)]&0x14)) {
        if(TYPE_SIZE(destination)==TYPE_SIZE(source_type))
            goto warn_equal_size;
        else
            REPORT_CURRENT_TOKEN(MSG_NONPORTABLE_POINTER);
    }
    if((TYPE_W(source_type,TYPE_KIND)==TK_ULONG || TYPE_W(source_type,TYPE_KIND)==TK_LONG) &&
        (int)TYPE_W(destination,TYPE_KIND)<=TK_UINT && (int)TYPE_W(destination,TYPE_KIND)>=TK_SHORT)
        REPORT_CURRENT_TOKEN(MSG_CONVERSION_MAY_LOSE);
    if(CPP_MODE && (EXPR_FLAGS[TYPE_W(source_type,TYPE_KIND)]&0x40)) {
        if(EXPR_FLAGS[TYPE_W(destination,TYPE_KIND)]&3)
            expression=APPLY_CONVERSION_FUNCTION(expression,3,destination);
        else if(EXPR_FLAGS[TYPE_W(destination,TYPE_KIND)]&0x14)
            expression=APPLY_CONVERSION_FUNCTION(expression,0x14,destination);
    }
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(destination,expression),0,mode);
}

/* DECAY_TO_POINTER: the value of an array is a pointer to its first element and the
   value of a function a pointer to it. A member (operator 0x4A) cannot be used here
   (MSG_FIELD_CANNOT_USED). object.function is only allowed in C++ for a qualified
   member function. A function's symbol is marked "address taken" (SYM_FUNC_FLAGS 8)
   and the & is token 0x1D for ordinary functions, TOK_AMPERSAND for member functions. */
unsigned int far pascal DECAY_TO_POINTER(register unsigned int node)
{
    unsigned int saved;

    if(!node)
        return node;
    if(EXPR_W(node,EXPR_OP)==0x4A)
        return REPORT_EXPR_ERROR(MSG_FIELD_CANNOT_USED,(long)NAME_TEXT_COPY(MEMBER_W(EXPR_W(node,EXPR_LEFT),MEMB_NAME)),0L,node);
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_ARRAY)
        return C7CHAIN(node,TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET));
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) {
        if(EXPR_W(node,EXPR_OP)==EOP_DOT) {
            if(CPP_MODE && EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_OP)==1 &&
                    EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_SCOPE_CLASS)!=0) {
                saved=node;
                node=EXPR_W(node,EXPR_RIGHT);
                EXPR_W(saved,EXPR_RIGHT)=0;
                FREE_EXPR_TREE(saved);
            } else
                node=REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS,node);
        }
        if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) {
            if(EXPR_W(node,EXPR_OP)==1)
                (*(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,EXPR_W(node,EXPR_LEFT)+SYM_FUNC_FLAGS))|=8;
            node=MAKE_UNARY_NODE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_MEMBER_CLASS)==0?0x1D:0x1B,node);
            node=ANALYZE_EXPRESSION(node,0,0);
        }
    }
    return node;
}

/* CONVERT_TO_RVALUE: reads a reference (C++) and decays arrays and functions: the usual
   step before a value is used. */
unsigned int far pascal CONVERT_TO_RVALUE(register unsigned int node)
{
    return DECAY_TO_POINTER(CPP_MODE?DEREF_REFERENCE_EXPR(node):node);
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

/* C7CONST: 1 when an object of type cannot be modified: the type is const, or it is a
   struct/union with a const data member (MEMB_FLAGS & 3 == 0, probably ordinary data
   members) or, in C++, a const base class. */
static unsigned char far pascal C7CONST(register unsigned int type)
{
    unsigned int parameter;
    register unsigned int member;

    if(!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) || (TYPE_B(type,TYPE_ATTRS)&1))
        return TYPE_B(type,TYPE_ATTRS)&1;
    member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if(((MEMBER_B(member,MEMB_FLAGS)&3)==0) && C7CONST(MEMBER_W(member,MEMB_TYPE)))
            return 1;
        member=MEMBER_W(member,MEMB_NEXT);
    }
    if(!CPP_MODE)
        return 0;
    parameter=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);
    while(parameter) {
        if(C7CONST(BASE_W(parameter,BASE_TYPE)))
            return 1;
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    return 0;
}

/* IS_MODIFIABLE_NODE: 1 when the lvalue node may be assigned (error nodes count as
   modifiable so no second message appears). */
unsigned char far pascal IS_MODIFIABLE_NODE(register unsigned int node)
{
    if(EXPR_W(node,EXPR_OP)==0)
        return 1;
    if(C7CONST(EXPR_W(node,EXPR_TYPE)))
        return 0;
    return (TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&1)==0;
}

/* IS_BIT_FIELD_NODE: 1 for object.member where the member is a bitfield (flag 4). */
unsigned char far pascal IS_BIT_FIELD_NODE(register unsigned int node)
{
    if(EXPR_W(node,EXPR_OP)!=EOP_DOT)
        return 0;
    node=EXPR_W(node,EXPR_RIGHT);
    return (EXPR_B(node,EXPR_NODE_FLAGS)&4)!=0;
}

/* C7COMPAT: 1 when an explicit cast from type second to type first is allowed at all:
   anything to void; from void only to void (when NOT_ANSI_FLAG); to a
   reference only from a reference; otherwise between scalars (integers and pointers)
   or between arithmetic types. Structs cannot be cast. */
static unsigned char far pascal C7COMPAT(register unsigned int first,
    register unsigned int second)
{
    if(TYPE_W(second,TYPE_KIND)==TK_VOID) {
        if(NOT_ANSI_FLAG && TYPE_W(first,TYPE_KIND)==TK_VOID)
            return 1;
        return 0;
    }
    if(first==second || TYPE_W(first,TYPE_KIND)==TK_VOID)
        return 1;
    if((EXPR_FLAGS[TYPE_W(first,TYPE_KIND)]&0x14) && (TYPE_B(first,TYPE_ATTRS)&0x20) &&
            (((EXPR_FLAGS[TYPE_W(second,TYPE_KIND)]&0x14)==0) || ((TYPE_B(second,TYPE_ATTRS)&0x20)==0)))
        return 0;
    return ((EXPR_FLAGS[TYPE_W(second,TYPE_KIND)]&0x15) &&
            (EXPR_FLAGS[TYPE_W(first,TYPE_KIND)]&0x15)) ||
           ((EXPR_FLAGS[TYPE_W(second,TYPE_KIND)]&3) &&
            (EXPR_FLAGS[TYPE_W(first,TYPE_KIND)]&3));
}

/* C7RANK: 1 when a cast between kinds first and second can be done by reinterpreting
   an lvalue in place: integer and pointer kinds where the target is not wider, or
   pointer kinds of equal kind or no wider and neither a _seg pointer. */
static unsigned char far pascal C7RANK(register unsigned int first,
    register unsigned int second)
{
    if(((EXPR_FLAGS[first]&1) && (EXPR_FLAGS[second]&0x15)) ||
            ((EXPR_FLAGS[first]&0x15) && (EXPR_FLAGS[second]&1)))
        return RANK(first)<=RANK(second);
    if((EXPR_FLAGS[first]&0x14) && (EXPR_FLAGS[second]&0x14)) {
        return first==second ||
               (first!=0x0E && second!=0x0E && RANK(first)<=RANK(second));
    }
    return 0;
}

/* CHECK_CAST: validates the analysed cast node expression and simplifies it. A based
   near pointer cast to far is first made a normal pointer; an integer cast to a far
   pointer is first made long. The cast disappears when the types are compatible, or
   when an lvalue (not a bitfield) can be reinterpreted in place (C7RANK); impossible
   casts give MSG_CANNOT_CAST_FROM. */
unsigned int far pascal CHECK_CAST(unsigned int expression)
{
    unsigned int result;
    unsigned int source_type;
    register unsigned int node=expression;
    register unsigned int type;

    source_type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    type=EXPR_W(node,EXPR_TYPE);
    result=node;
    if(TYPE_W(type,TYPE_KIND)==TK_FAR_PTR) {
        if(TYPE_W(source_type,TYPE_KIND)==TK_NEAR_PTR && TYPE_W(source_type,TYPE_PTR_BASE)!=0) {
            EXPR_W(node,EXPR_LEFT)=ANALYZE_EXPRESSION(APPLY_BASED_POINTER(EXPR_W(node,EXPR_LEFT)),type,0);
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
    } else if(!C7COMPAT(type,source_type))
        result=REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM,FORMAT_TYPE(source_type),FORMAT_TYPE(type),node);
    else if((!CPP_MODE || ((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14)==0) ||
             TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION) &&
            C7RANK(TYPE_W(type,TYPE_KIND),TYPE_W(source_type,TYPE_KIND)) &&
            IS_LVALUE(EXPR_W(node,EXPR_LEFT)) &&
            (EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)!=EOP_DOT || ((EXPR_B(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_RIGHT),EXPR_NODE_FLAGS)&4)==0))) {
        EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE)=type;
        result=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(node);
    }
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
    }
    EXPR_W(expression,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(selected_type,right,0);
    EXPR_W(expression,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(selected_type,left,0);
    EXPR_W(expression,EXPR_TYPE)=selected_type;
    return expression;
}

/* BALANCE_BINARY_OPERANDS: brings the operands of the binary node expression to a
   common type: arithmetic operands (or one arithmetic and one class, for C++
   conversions) go to USUAL_ARITHMETIC_CONVERSIONS. For two pointers: null constants take
   the other pointer's type, both become the larger pointer kind (_seg mixed with
   another kind gives far), enum targets their integer type, a void pointer side wins,
   in C++ a pointer to a derived class converts to the base class pointer, and a based
   pointer converts to the plain one. The node takes the right operand's type. */
unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int requested,unsigned int expression)
{
    unsigned int left_type;
    unsigned int right_type;
    unsigned char arithmetic;
    int right_kind;
    int left_kind;
    int kind;
    register unsigned int right;
    register unsigned int left;

    left=EXPR_W(expression,EXPR_LEFT);
    right=EXPR_W(expression,EXPR_RIGHT);
    arithmetic=0;
    if(EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&3)
        arithmetic=(EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&3) ||
                   (EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x40);
    else if(EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&3)
        arithmetic=EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&0x40;
    if(arithmetic)
        return USUAL_ARITHMETIC_CONVERSIONS(requested,expression);
    EXPR_W(left,EXPR_TYPE)=ENUM_UNDERLYING_TYPE(EXPR_W(left,EXPR_TYPE));
    EXPR_W(right,EXPR_TYPE)=ENUM_UNDERLYING_TYPE(EXPR_W(right,EXPR_TYPE));
    right=NULL_CONSTANT_TO_POINTER(EXPR_W(left,EXPR_TYPE),right);
    left=NULL_CONSTANT_TO_POINTER(EXPR_W(right,EXPR_TYPE),left);
    if((EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x14) &&
            (EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&0x14)) {
        right_kind=TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND);
        left_kind=TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND);
        kind=right_kind>left_kind?right_kind:left_kind;
        if(kind==0x0E && right_kind!=left_kind)
            kind=0x0F;
        right_type=ENUM_UNDERLYING_TYPE(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_TARGET));
        if(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_TARGET)!=right_type || kind!=right_kind)
            right=ANALYZE_EXPRESSION(MAKE_CAST_NODE(MAKE_POINTER_TYPE(right_type,kind,0),right),0,0);
        left_type=ENUM_UNDERLYING_TYPE(TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_TARGET));
        if(TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_TARGET)!=left_type || kind!=left_kind)
            left=ANALYZE_EXPRESSION(MAKE_CAST_NODE(MAKE_POINTER_TYPE(left_type,kind,0),left),0,0);
        if((EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&0x14) &&
                TYPE_W(TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_VOID)
            right=CONVERT_EXPR_TO_TYPE(EXPR_W(left,EXPR_TYPE),right,0);
        else if((EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x14) &&
                TYPE_W(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_VOID)
            left=CONVERT_EXPR_TO_TYPE(EXPR_W(right,EXPR_TYPE),left,0);
        else if(CPP_MODE && !TYPES_COMPATIBLE(right_type,left_type,1)) {
            if(IS_BASE_CLASS(right_type,left_type,1))
                left=CONVERT_EXPR_TO_TYPE(EXPR_W(right,EXPR_TYPE),left,0);
            else if(IS_BASE_CLASS(left_type,right_type,1))
                right=CONVERT_EXPR_TO_TYPE(EXPR_W(left,EXPR_TYPE),right,0);
        }
        if(TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_PTR_BASE)!=0 && TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_PTR_BASE)==0)
            left=CONVERT_EXPR_TO_TYPE(EXPR_W(right,EXPR_TYPE),left,0);
        else if(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_PTR_BASE)!=0 && TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_PTR_BASE)==0)
            right=CONVERT_EXPR_TO_TYPE(EXPR_W(left,EXPR_TYPE),right,0);
    }
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(right,EXPR_TYPE);
    EXPR_W(expression,EXPR_LEFT)=left;
    EXPR_W(expression,EXPR_RIGHT)=right;
    return expression;
}

/* APPLY_BASED_POINTER: turns a value of based pointer type (TYPE_PTR_BASE names the base
   expression as text in POOL_HASH) into base + pointer: the base text is pushed as
   input, parsed as an expression, and the lexer state is restored afterwards. Returns
   node unchanged when the base does not parse. */
unsigned int far pascal APPLY_BASED_POINTER(register unsigned int node)
{
    struct C7Token saved;
    register unsigned int result;

    saved=CURRENT_TOKEN_RECORD;
    BCC_INPUT_STRING_PTR((unsigned int)&POOL_HASH,TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_PTR_BASE));
    ADVANCE_TOKEN();
    result=PARSE_ASSIGNMENT_EXPR(7);
    POP_INPUT_CONTEXT(1);
    CURRENT_TOKEN_RECORD=saved;
    CURRENT_TOKEN=TOKEN_WORD;
    if(!result)
        return node;
    return MAKE_BINARY_NODE(0x16,result,node);
}
