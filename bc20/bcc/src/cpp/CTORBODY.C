/* target: ovr067_C11FIND */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ classes: parses constructor member-initializer lists and compiles constructor
   and destructor bodies with base, virtual-base, member and vptr setup. Entry points:
   PARSE_MEMBER_INITIALIZERS, COMPILE_CONSTRUCTOR, COMPILE_DESTRUCTOR. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: compiles the bodies of constructors and destructors. parser/FUNCDEF.C
   calls COMPILE_CONSTRUCTOR or COMPILE_DESTRUCTOR instead of the ordinary body parser
   when the function being defined is one; the current token is then the ':' of a
   mem-initializer list or the '{'. Both wrap the user's statements
   (PARSE_STATEMENT_LIST) in the code the language requires, built by CPPCTOR.C.
   Constructor, in order: if this is 0 allocate the object (this = operator new), and
   return 0 if that failed; then construct the virtual bases (only for the complete
   object, by the hidden flag parameter), the other bases, store the virtual table
   pointers, construct the members; then the body; destroy temporaries; return this.
   Destructor: if this is 0 skip everything; store this class's virtual table pointers
   (so virtual calls in the body see this class); the body; destroy temporaries; then
   BUILD_DESTRUCTOR_BODY (members, bases, virtual bases, operator delete, by the hidden
   flags parameter).
   Old-style constructors may assign to this. That is allowed for classes with class
   flag 2 (no bases, or one non-virtual base that has the flag; set by
   DECLARE_IMPLICIT_MEMBERS), called "hidden" here: for them the initialization code is kept packed in PACKED_INIT_EXPR and
   CHECK_CPP_ASSIGNMENT inserts it after the assignment to this; if the body turns out
   not to assign to this, the normal sequence is spliced in at the start after all.
   The hidden parameters are found by name: THIS_NAME (TOKEN_NAMES[0x72]) is this,
   VTABLE_PTR_NAME (TOKEN_NAMES[0x73]) the constructor's virtual-base flag and
   OPERATOR_DELETE_NAME (TOKEN_NAMES[0x69]) the destructor's flags; see CPPCTOR.C.
   BCC_TREE_LINK is the function's outermost scope and BCC_TREE_SPECIAL the function
   symbol. */
#include <dos.h>
#include "CTORBODY.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"


/* 0000..002A: discard a parsed tree while suppressing ordinary call handling. */
/* C11FLUSH: skips a parenthesized argument list after an error: parses it with
   IN_ERROR_RECOVERY set (so no calls are processed, probably) and frees it. */
static void near pascal C11FLUSH(void)
{
    unsigned char saved;

    saved=IN_ERROR_RECOVERY;
    IN_ERROR_RECOVERY=1;
    FREE_EXPR_TREE(PARSE_ARGUMENT_LIST(0));
    IN_ERROR_RECOVERY=saved;
}

/* 002A..00C2: direct bases precede recursive searches through their bases. */
/* CTORBODY: finds the base-list entry for class target among the bases of owner:
   first the direct bases, then, recursively, deeper bases, but a deeper one is only
   accepted when it is a virtual base (only virtual bases may be initialized by a more
   derived class). Returns the BASE record or 0. The name is the file's, not the
   function's job. */
static unsigned int near pascal CTORBODY(register unsigned int owner,
    unsigned int target)
{
    unsigned int found;
    register unsigned int parameter;

    parameter=TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_BASES);
    while(parameter) {
        if(TYPE_W(BASE_W(parameter,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(target,TYPE_TAG_BODY))
            return parameter;
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    parameter=TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_BASES);
    while(parameter) {
        found=CTORBODY(BASE_W(parameter,BASE_TYPE),target);
        if(found)
            return BASE_B(found,BASE_VIRTUAL)?found:0;
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    return 0;
}


/* 00C2 */
/* C11MEMBER: one mem-initializer member(args): parses the arguments and adds an entry
   with this->member initialized from them (BUILD_INIT_CALL) in front of list. Reports a
   name that is not a data member (MSG_NOT_DATA_MEMBER_CAN_T) and a member initialized
   twice (MSG_MEMBER_INITIALIZED; the arguments are skipped). Returns the new list. */
static unsigned int near pascal C11MEMBER(register unsigned int member,
    unsigned int list)
{
    unsigned int expression;
    unsigned int entry;
    register unsigned int scan;

    if(MEMBER_B(member,MEMB_FLAGS)&3)
        REPORT_NAME_DIAGNOSTIC(MSG_NOT_DATA_MEMBER_CAN_T,MEMBER_W(member,MEMB_NAME));
    scan=list;
    while(scan) {
        if(MINIT_W(scan,MINIT_TARGET)==member) {
            REPORT_NAME_DIAGNOSTIC(MSG_MEMBER_INITIALIZED,MEMBER_W(member,MEMB_NAME));
            C11FLUSH();
            return list;
        }
        scan=MINIT_W(scan,MINIT_NEXT);
    }
    expression=MAKE_BINARY_NODE(0x2F,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),
        MAKE_FIELD_REF_NODE(member));
    expression=BUILD_INIT_CALL(expression,MEMBER_W(member,MEMB_TYPE),PARSE_ARGUMENT_LIST(0),0,0);
    entry=ALLOC_INIT_ENTRY(list);
    MINIT_W(entry,MINIT_TARGET)=member;
    MINIT_W(entry,MINIT_EXPR)=expression;
    return entry;
}

/* 017F */
/* C11BASE: one mem-initializer Base(args) for base entry parameter: parses the
   arguments and adds an entry for the base class to list. A base with constructors is
   initialized by a base-constructor call on this; one without is assigned at its
   subobject address (virtual bases through the virtual base pointer). When the class
   may assign to this (hidden) the result is stored back into this, marked with node
   flag 0x10 so CHECK_CPP_ASSIGNMENT does not warn. A base initialized twice is
   MSG_BASE_CLASS_INITIALIZED. */
static unsigned int near pascal C11BASE(unsigned int parameter,
    unsigned char hidden,unsigned int list)
{
    unsigned int scan;
    unsigned int entry;
    register unsigned int expression;
    register unsigned int type;

    type=BASE_W(parameter,BASE_TYPE);
    for(scan=list;scan;scan=MINIT_W(scan,MINIT_NEXT)) {
        if(MINIT_W(scan,MINIT_TARGET)==type) {
            REPORT_NAME_DIAGNOSTIC(MSG_BASE_CLASS_INITIALIZED,SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME));
            C11FLUSH();
            return list;
        }
    }
    expression=MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
    if(!((unsigned int)TYPE_B(type,TYPE_ATTRS)&4)) {
        if(BASE_B(parameter,BASE_VIRTUAL))
            expression=BUILD_VBASE_ADDRESS(expression,BASE_W(parameter,BASE_OFFSET),type);
        else
            expression=BUILD_BASE_ADDRESS(expression,BASE_W(parameter,BASE_OFFSET),type);
    }
    expression=BUILD_INIT_CALL(expression,type,PARSE_ARGUMENT_LIST(0),0,1);
    if(hidden && (TYPE_B(type,TYPE_ATTRS)&4)) {
        expression=MAKE_CAST_NODE(MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE,0,0),expression);
        expression=MAKE_BINARY_NODE(11,BUILD_THIS_NODE(CTOR_THIS_SYMBOL),expression);
        EXPR_B(expression,EXPR_NODE_FLAGS)|=0x10;
    }
    entry=ALLOC_INIT_ENTRY(list);
    MINIT_W(entry,MINIT_TARGET)=type;
    MINIT_W(entry,MINIT_EXPR)=expression;
    return entry;
}

/* 02AE */
/* C11UNNAMED: an old-style mem-initializer with no name, (args), which initializes the
   first base class; reports MSG_MULTIPLE_BASE_CLASSES when the class has more than one
   base, else MSG_BASE_INITIALIZATION (probably an anachronism warning). */
static unsigned int near pascal C11UNNAMED(unsigned char hidden,
    unsigned int list)
{
    unsigned int result;

    result=C11BASE(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_BASES),hidden,list);
    REPORT_CURRENT_TOKEN(BASE_W(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_BASES),BASE_NEXT)?MSG_MULTIPLE_BASE_CLASSES:MSG_BASE_INITIALIZATION);
    return result;
}

/* 030B: first genuine overlay export. */
/* PARSE_MEMBER_INITIALIZERS: parses an optional ": init, init ..." list of the
   constructor of CURRENT_CLASS_TYPE, sorting the entries into members, ordinary bases
   and virtual bases, and returns the whole initialization expression: virtual bases
   (guarded by the flag parameter symbol initial), bases, vptr stores, members.
   hidden is the class's assigns-to-this flag. Called here and from INLINEXP.C. */
unsigned int far pascal PARSE_MEMBER_INITIALIZERS(unsigned char hidden,unsigned int initial)
{
    unsigned int name;
    unsigned int member;
    unsigned int type;
    unsigned int parameters;
    unsigned int found;
    unsigned int ordinary;
    unsigned int inherited;
    unsigned int members;
    register unsigned int result;
    register unsigned int symbol;

    members=ordinary=inherited=0;
    parameters=TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_BASES);
    result=0;
    if(CURRENT_TOKEN==TOK_COLON) {
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN!=TOK_IDENT && CURRENT_TOKEN!=TOK_LPAREN)
            REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
        while(CURRENT_TOKEN==TOK_IDENT || CURRENT_TOKEN==TOK_LPAREN) {
            if(CURRENT_TOKEN==TOK_IDENT) {
                name=CURRENT_TOKEN_VALUE;
                ADVANCE_TOKEN();
                if((member=FIND_MEMBER_BY_NAME(name,CURRENT_CLASS_TYPE)))
                    members=C11MEMBER(member,members);
                else {
                    if(!(symbol=LOOKUP_NAME(name))) {
                        REPORT_NAME_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL,name);
                        goto discard;
                    }
                    type=SYM_W(symbol,SYM_TYPE);
                    if(((int)SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=11 &&
                        ((int)SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=8) {
                        REPORT_DIAGNOSTIC(MSG_NOT_MEMBER,(long)NAME_TEXT_COPY(name),
                            (long)FORMAT_TYPE(CURRENT_CLASS_TYPE));
                        goto discard;
                    }
                    found=CTORBODY(CURRENT_CLASS_TYPE,type);
                    if(!found) {
                        REPORT_DIAGNOSTIC(MSG_NOT_BASE_CLASS,(long)NAME_TEXT_COPY(name),
                            (long)FORMAT_TYPE(CURRENT_CLASS_TYPE));
                        goto discard;
                    }
                    if(BASE_B(found,BASE_VIRTUAL))
                        inherited=C11BASE(found,hidden,inherited);
                    else
                        ordinary=C11BASE(found,hidden,ordinary);
                }
            } else if(!parameters) {
                REPORT_CURRENT_TOKEN(MSG_NO_BASE_CLASS);
            discard:
                C11FLUSH();
            } else
                ordinary=C11UNNAMED(hidden,ordinary);
            C11_EXPECT(5);
        }
    }
    result=BUILD_VBASE_INITS(initial,inherited);
    result=JOIN_COMMA_EXPR(result,BUILD_BASE_INITS(hidden,ordinary));
    result=JOIN_COMMA_EXPR(result,BUILD_VPTR_INITS(CTOR_THIS_SYMBOL,CURRENT_CLASS_TYPE));
    result=JOIN_COMMA_EXPR(result,BUILD_MEMBER_INITS(members));
    return result;
}

/* 04E0 */
/* COMPILE_CONSTRUCTOR: compiles a constructor body (see the overview for the shape).
   The pieces are built as statement blocks first (first: allocate if this is 0;
   second: jump to begin if this is not 0; third: return this; finish: the
   initializations) and appended in that order, or, for a class that may assign to
   this, held back and spliced in at insertion only if the body did not assign to
   this. SYM_FUNC_FLAGS bit 0x10 of the constructor (assigns to this) is cleared when it
   does not. CTOR_DTOR_MODE is 1 while compiling. */
void far pascal COMPILE_CONSTRUCTOR(void)
{
    unsigned int first;
    unsigned int second;
    unsigned int third;
    unsigned int begin;
    unsigned int initial;
    unsigned int finish;
    unsigned char hidden;
    unsigned int checkpoint;
    register unsigned int expression;
    register unsigned int insertion;

    CTOR_DTOR_MODE=1;
    CTOR_THIS_SYMBOL=FIND_NAME_IN_LIST(THIS_NAME,SCOPE_W(BCC_TREE_LINK,SCOPE_NAMES));
    CTOR_CHECK_THIS_ASSIGN=0;
    hidden=(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&2)!=0;
    CPP_BODY_END_LABEL=NEW_LABEL_IF_ENABLED();
    initial=FIND_NAME_IN_LIST(VTABLE_PTR_NAME,SCOPE_W(BCC_TREE_LINK,SCOPE_NAMES));
    expression=PARSE_MEMBER_INITIALIZERS(hidden,initial);
    CTOR_THIS_ASSIGNED=0;
    REQUIRE_TOKEN_ELSE_ERROR(5,0xD8);
    ++BLOCK_NEST_LEVEL;
    expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression,VOID_TYPE),1);
    begin=NEW_LABEL_IF_ENABLED();
    /* Class may assign to this: keep the initializations packed for
       CHECK_CPP_ASSIGNMENT and mark where the normal sequence would go. */
    if(hidden) {
        checkpoint=EXPR_BANK_MARK();
        PACKED_INIT_EXPR=PACK_EXPR_TREE(expression);
        insertion=NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(insertion);
        APPEND_BLOCK_IF_NONZERO(begin);
    }
    finish=MAKE_EXPRESSION_BLOCK(hidden?UNPACK_EXPR_TREE(PACKED_INIT_EXPR):expression,NO_SOURCE_LOCATION);
    expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(BUILD_THIS_ALLOC_IF_NULL(CTOR_THIS_SYMBOL,CURRENT_CLASS_TYPE),VOID_TYPE),1);
    first=MAKE_EXPRESSION_BLOCK(expression,NO_SOURCE_LOCATION);
    expression=CONVERT_CLASS_TO_SCALAR(BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
    second=MAKE_JUMP_IF_TRUE_BLOCK(SIMPLIFY_EXPRESSION(expression,0),begin,NO_SOURCE_LOCATION);
    third=MAKE_RETURN_JUMP_BLOCK(BUILD_THIS_NODE(CTOR_THIS_SYMBOL),NO_SOURCE_LOCATION);
    if(hidden)
        CTOR_CHECK_THIS_ASSIGN=1;
    else {
        APPEND_BLOCK_IF_NONZERO(first);
        APPEND_BLOCK_IF_NONZERO(second);
        APPEND_BLOCK_IF_NONZERO(third);
        APPEND_BLOCK_IF_NONZERO(begin);
        SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_FLAGS)&=0xFFEF;
        APPEND_BLOCK_IF_NONZERO(finish);
    }
    /* The constructor's own statements, then temporaries' destructors, return this. */
    PARSE_STATEMENT_LIST();
    APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS)));
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    APPEND_RETURN_JUMP_BLOCK(BUILD_THIS_NODE(CTOR_THIS_SYMBOL),NO_SOURCE_LOCATION);
    /* No assignment to this was found: put the normal start sequence back in. */
    if(hidden) {
        if(!(int)CTOR_THIS_ASSIGNED) {
            SPLICE_STATEMENT_CHAIN(third,insertion);
            SPLICE_STATEMENT_CHAIN(second,insertion);
            SPLICE_STATEMENT_CHAIN(first,insertion);
            SPLICE_STATEMENT_CHAIN(finish,begin);
            SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_FLAGS)&=0xFFEF;
        }
        EXPR_BANK_RESET(checkpoint);
    }
    CTOR_THIS_SYMBOL=0;
    CTOR_CHECK_THIS_ASSIGN=0;
    CODE_UNREACHABLE=1;
    CHECK_UNDEFINED_LABELS();
    CTOR_DTOR_MODE=0;
}

/* 0764 */
/* COMPILE_DESTRUCTOR: compiles a destructor body (see the overview). CTOR_DTOR_MODE is
   2 while compiling. CTOR_THIS_ASSIGNED, set if the body assigned to this, is passed
   to BUILD_DESTRUCTOR_BODY so the whole tail is then guarded by this != 0. */
void far pascal COMPILE_DESTRUCTOR(void)
{
    unsigned int expression;
    unsigned int member;
    register unsigned int begin;

    REQUIRE_TOKEN_ELSE_ERROR(5,0xD8);
    ++BLOCK_NEST_LEVEL;
    CTOR_DTOR_MODE=2;
    CPP_BODY_END_LABEL=NEW_LABEL_IF_ENABLED();
    begin=NEW_LABEL_IF_ENABLED();
    CTOR_CHECK_THIS_ASSIGN=(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&2)!=0;
    PACKED_INIT_EXPR=0;
    CTOR_THIS_ASSIGNED=0;
    CTOR_THIS_SYMBOL=LOOKUP_NAME(THIS_NAME);
    member=LOOKUP_NAME(OPERATOR_DELETE_NAME);
    expression=CONVERT_CLASS_TO_SCALAR(BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
    APPEND_JUMP_IF_FALSE_BLOCK(SIMPLIFY_EXPRESSION(expression,0),begin,NO_SOURCE_LOCATION);
    APPEND_ANALYZED_EXPRESSION(BUILD_VPTR_INITS(CTOR_THIS_SYMBOL,CURRENT_CLASS_TYPE));
    PARSE_STATEMENT_LIST();
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS)));
    APPEND_ANALYZED_EXPRESSION(BUILD_DESTRUCTOR_BODY(CURRENT_CLASS_TYPE,CTOR_THIS_SYMBOL,CTOR_THIS_ASSIGNED,member));
    APPEND_BLOCK_IF_NONZERO(begin);
    CHECK_UNDEFINED_LABELS();
    CTOR_DTOR_MODE=0;
}
