/* ctorbody.c: from bcc20/src/cpp/CTORBODY.C: the bodies of constructors and destructors.
   FUNCDEF.C calls COMPILE_CONSTRUCTOR or COMPILE_DESTRUCTOR instead of the ordinary body
   parser when the function being defined is one; the current token is then the ':' of a
   mem-initializer list or the '{'.  Both wrap the user's statements (PARSE_STATEMENT_LIST)
   in the code the language requires, built by CPPCTOR.C.  Constructor, in order: if this
   is 0 allocate the object, and return 0 if that failed; then construct the virtual bases
   (only for the complete object, by the hidden flag parameter), the other bases, store the
   virtual table pointers, construct the members; then the body; destroy temporaries;
   return this.  Destructor: if this is 0 skip everything; store this class's virtual
   table pointers; the body; destroy temporaries; then BUILD_DESTRUCTOR_BODY.  Old-style
   constructors may assign to this, allowed for classes with class flag 2 ("hidden" here):
   for them the initialisation code is kept packed in PACKED_INIT_EXPR and
   CHECK_CPP_ASSIGNMENT inserts it after the assignment to this; if the body turns out not
   to assign to this, the normal sequence is spliced in at the start after all.  A source
   position is passed by value as its three words, the last first. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define NOWHERE W(fp_add(NO_SOURCE_LOCATION_P, 4)), W(fp_add(NO_SOURCE_LOCATION_P, 2)), W(NO_SOURCE_LOCATION_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)

/* skips a parenthesised argument list after an error: parsed with IN_ERROR_RECOVERY set
   and freed */
void C11FLUSH(void)
{
    u8 saved = IN_ERROR_RECOVERY;
    IN_ERROR_RECOVERY = 1;
    FREE_EXPR_TREE(PARSE_ARGUMENT_LIST(0));
    IN_ERROR_RECOVERY = saved;
}

/* the base-list entry for class target among the bases of owner: first the direct bases,
   then, recursively, deeper bases, but a deeper one only when it is a virtual base.  The
   BASE record or 0 */
u16 CTORBODY(u16 owner, u16 target)
{
    u16 parameter;
    for (parameter = TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_BASES); parameter; parameter = BASE_W(parameter, BASE_NEXT))
        if (TYPE_W(BASE_W(parameter, BASE_TYPE), TYPE_TAG_BODY) == TYPE_W(target, TYPE_TAG_BODY))
            return parameter;
    for (parameter = TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_BASES); parameter; parameter = BASE_W(parameter, BASE_NEXT)) {
        u16 found = CTORBODY(BASE_W(parameter, BASE_TYPE), target);
        if (found)
            return BASE_B(found, BASE_VIRTUAL) ? found : 0;
    }
    return 0;
}

/* one mem-initializer member(args): an entry with this->member initialised from the
   arguments (BUILD_INIT_CALL) in front of list.  A name that is not a data member, and a
   member initialised twice, are reported.  Returns the new list */
u16 C11MEMBER(u16 member, u16 list)
{
    if (MEMBER_B(member, MEMB_FLAGS) & 3)
        REPORT_NAME_DIAGNOSTIC(MSG_NOT_DATA_MEMBER_CAN_T, MEMBER_W(member, MEMB_NAME));
    for (u16 scan = list; scan; scan = MINIT_W(scan, MINIT_NEXT))
        if (MINIT_W(scan, MINIT_TARGET) == member) {
            REPORT_NAME_DIAGNOSTIC(MSG_MEMBER_INITIALIZED, MEMBER_W(member, MEMB_NAME));
            C11FLUSH();
            return list;
        }
    u16 object = MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
    u16 field = MAKE_FIELD_REF_NODE(member);
    u16 expression = MAKE_BINARY_NODE(0x2F, object, field);
    expression = BUILD_INIT_CALL(expression, MEMBER_W(member, MEMB_TYPE), PARSE_ARGUMENT_LIST(0), 0, 0);
    u16 entry = ALLOC_INIT_ENTRY(list);
    MINIT_W(entry, MINIT_TARGET) = member;
    MINIT_W(entry, MINIT_EXPR) = expression;
    return entry;
}

/* one mem-initializer Base(args) for base entry parameter: an entry for the base class in
   front of list.  A base with constructors is initialised by a base-constructor call on
   this; one without is assigned at its subobject address.  When the class may assign to
   this (hidden) the result is stored back into this, marked with node flag 10h.  A base
   initialised twice is reported */
u16 C11BASE(u16 parameter, u8 hidden, u16 list)
{
    u16 type = BASE_W(parameter, BASE_TYPE);
    for (u16 scan = list; scan; scan = MINIT_W(scan, MINIT_NEXT))
        if (MINIT_W(scan, MINIT_TARGET) == type) {
            REPORT_NAME_DIAGNOSTIC(MSG_BASE_CLASS_INITIALIZED, SYM_W(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME));
            C11FLUSH();
            return list;
        }
    u16 expression = MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
    if (!(TYPE_B(type, TYPE_ATTRS) & 4)) {
        if (BASE_B(parameter, BASE_VIRTUAL))
            expression = BUILD_VBASE_ADDRESS(expression, BASE_W(parameter, BASE_OFFSET), type);
        else
            expression = BUILD_BASE_ADDRESS(expression, BASE_W(parameter, BASE_OFFSET), type);
    }
    expression = BUILD_INIT_CALL(expression, type, PARSE_ARGUMENT_LIST(0), 0, 1);
    if (hidden && (TYPE_B(type, TYPE_ATTRS) & 4)) {
        expression = MAKE_CAST_NODE(MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE, 0, 0), expression);
        u16 self = BUILD_THIS_NODE(CTOR_THIS_SYMBOL);
        expression = MAKE_BINARY_NODE(11, self, expression);
        EXPR_B(expression, EXPR_NODE_FLAGS) |= 0x10;
    }
    u16 entry = ALLOC_INIT_ENTRY(list);
    MINIT_W(entry, MINIT_TARGET) = type;
    MINIT_W(entry, MINIT_EXPR) = expression;
    return entry;
}

/* an old-style mem-initializer with no name, (args), which initialises the first base
   class; reported as an error with several bases, else as an anachronism */
u16 C11UNNAMED(u8 hidden, u16 list)
{
    u16 result = C11BASE(TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_BASES), hidden, list);
    REPORT_CURRENT_TOKEN(BASE_W(TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_BASES), BASE_NEXT)
                             ? MSG_MULTIPLE_BASE_CLASSES : MSG_BASE_INITIALIZATION);
    return result;
}

/* name text and the current class for "not a member" style reports */
static void report_name_in_class(i16 message, u16 name)
{
    farptr text = NAME_TEXT_COPY(name);                 /* pascal: left to right */
    i32 type = FORMAT_TYPE(CURRENT_CLASS_TYPE);
    REPORT_DIAGNOSTIC(message, (i32)text, type);
}

/* an optional ": init, init ..." list of the constructor of CURRENT_CLASS_TYPE, sorted
   into members, ordinary bases and virtual bases; returns the whole initialisation
   expression: virtual bases (guarded by the flag parameter symbol initial), bases, vptr
   stores, members.  hidden is the class's assigns-to-this flag */
u16 PARSE_MEMBER_INITIALIZERS(u8 hidden, u16 initial)
{
    u16 members = 0, ordinary = 0, inherited = 0;
    u16 parameters = TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_BASES);
    if (CURRENT_TOKEN == TOK_COLON) {
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN != TOK_IDENT && CURRENT_TOKEN != TOK_LPAREN)
            REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
        while (CURRENT_TOKEN == TOK_IDENT || CURRENT_TOKEN == TOK_LPAREN) {
            if (CURRENT_TOKEN == TOK_IDENT) {
                u16 name = CURRENT_TOKEN_VALUE, member, symbol;
                ADVANCE_TOKEN();
                if ((member = FIND_MEMBER_BY_NAME(name, CURRENT_CLASS_TYPE)))
                    members = C11MEMBER(member, members);
                else if (!(symbol = LOOKUP_NAME(name))) {
                    REPORT_NAME_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL, name);
                    C11FLUSH();
                } else {
                    u16 type = SYM_W(symbol, SYM_TYPE);
                    if ((SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) != 11 && (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) != 8) {
                        report_name_in_class(MSG_NOT_MEMBER, name);
                        C11FLUSH();
                    } else {
                        u16 found = CTORBODY(CURRENT_CLASS_TYPE, type);
                        if (!found) {
                            report_name_in_class(MSG_NOT_BASE_CLASS, name);
                            C11FLUSH();
                        } else if (BASE_B(found, BASE_VIRTUAL))
                            inherited = C11BASE(found, hidden, inherited);
                        else
                            ordinary = C11BASE(found, hidden, ordinary);
                    }
                }
            } else if (!parameters) {
                REPORT_CURRENT_TOKEN(MSG_NO_BASE_CLASS);
                C11FLUSH();
            } else
                ordinary = C11UNNAMED(hidden, ordinary);
            TREE_ASSERT(5);
        }
    }
    u16 result = BUILD_VBASE_INITS(initial, inherited);
    result = JOIN_COMMA_EXPR(result, BUILD_BASE_INITS(hidden, ordinary));
    result = JOIN_COMMA_EXPR(result, BUILD_VPTR_INITS(CTOR_THIS_SYMBOL, CURRENT_CLASS_TYPE));
    result = JOIN_COMMA_EXPR(result, BUILD_MEMBER_INITS(members));
    return result;
}

/* a constructor body.  The pieces are built as statement blocks first (first: allocate if
   this is 0; second: jump to begin if this is not 0; third: return this; finish: the
   initialisations) and appended in that order, or, for a class that may assign to this,
   held back and spliced in at insertion only if the body did not assign to this.
   SYM_FUNC_FLAGS bit 10h of the constructor (assigns to this) is cleared when it does not.
   CTOR_DTOR_MODE is 1 while compiling */
void COMPILE_CONSTRUCTOR(void)
{
    u16 checkpoint = 0, insertion = 0;
    CTOR_DTOR_MODE = 1;
    CTOR_THIS_SYMBOL = FIND_NAME_IN_LIST(THIS_NAME, SCOPE_W(BCC_TREE_LINK, SCOPE_NAMES));
    CTOR_CHECK_THIS_ASSIGN = 0;
    u8 hidden = (TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 2) != 0;
    CPP_BODY_END_LABEL = NEW_LABEL_IF_ENABLED();
    u16 initial = FIND_NAME_IN_LIST(VTABLE_PTR_NAME, SCOPE_W(BCC_TREE_LINK, SCOPE_NAMES));
    u16 expression = PARSE_MEMBER_INITIALIZERS(hidden, initial);
    CTOR_THIS_ASSIGNED = 0;
    REQUIRE_TOKEN_BODY(5, 0xD8);
    ++BLOCK_NEST_LEVEL;
    expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression, VOID_TYPE), 1);
    u16 begin = NEW_LABEL_IF_ENABLED();
    /* the class may assign to this: the initialisations are kept packed for
       CHECK_CPP_ASSIGNMENT, and insertion marks where the normal sequence would go */
    if (hidden) {
        checkpoint = EXPR_BANK_MARK();
        PACKED_INIT_EXPR = PACK_EXPR_TREE(expression);
        insertion = NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(insertion);
        APPEND_BLOCK_IF_NONZERO(begin);
    }
    u16 finish = MAKE_EXPRESSION_BLOCK(hidden ? UNPACK_EXPR_TREE(PACKED_INIT_EXPR) : expression, NOWHERE);
    expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(BUILD_THIS_ALLOC_IF_NULL(CTOR_THIS_SYMBOL, CURRENT_CLASS_TYPE), VOID_TYPE), 1);
    u16 first = MAKE_EXPRESSION_BLOCK(expression, NOWHERE);
    expression = CONVERT_CLASS_TO_SCALAR(BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
    u16 second = MAKE_JUMP_IF_TRUE_BLOCK(SIMPLIFY_EXPRESSION(expression, 0), begin, NOWHERE);
    u16 third = MAKE_RETURN_JUMP_BLOCK(BUILD_THIS_NODE(CTOR_THIS_SYMBOL), NOWHERE);
    if (hidden)
        CTOR_CHECK_THIS_ASSIGN = 1;
    else {
        APPEND_BLOCK_IF_NONZERO(first);
        APPEND_BLOCK_IF_NONZERO(second);
        APPEND_BLOCK_IF_NONZERO(third);
        APPEND_BLOCK_IF_NONZERO(begin);
        SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_FLAGS) &= 0xFFEF;
        APPEND_BLOCK_IF_NONZERO(finish);
    }
    /* the constructor's own statements, then the temporaries' destructors, return this */
    PARSE_STATEMENT_LIST();
    APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS)));
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    APPEND_RETURN_JUMP_BLOCK(BUILD_THIS_NODE(CTOR_THIS_SYMBOL), NOWHERE);
    /* no assignment to this was found: the normal start sequence goes back in */
    if (hidden) {
        if (!CTOR_THIS_ASSIGNED) {
            SPLICE_STATEMENT_CHAIN(third, insertion);
            SPLICE_STATEMENT_CHAIN(second, insertion);
            SPLICE_STATEMENT_CHAIN(first, insertion);
            SPLICE_STATEMENT_CHAIN(finish, begin);
            SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_FLAGS) &= 0xFFEF;
        }
        EXPR_BANK_RESET(checkpoint);
    }
    CTOR_THIS_SYMBOL = 0;
    CTOR_CHECK_THIS_ASSIGN = 0;
    CODE_UNREACHABLE = 1;
    CHECK_UNDEFINED_LABELS();
    CTOR_DTOR_MODE = 0;
}

/* a destructor body.  CTOR_DTOR_MODE is 2 while compiling.  CTOR_THIS_ASSIGNED, set if the
   body assigned to this, is passed to BUILD_DESTRUCTOR_BODY so the whole tail is then
   guarded by this != 0 */
void COMPILE_DESTRUCTOR(void)
{
    REQUIRE_TOKEN_BODY(5, 0xD8);
    ++BLOCK_NEST_LEVEL;
    CTOR_DTOR_MODE = 2;
    CPP_BODY_END_LABEL = NEW_LABEL_IF_ENABLED();
    u16 begin = NEW_LABEL_IF_ENABLED();
    CTOR_CHECK_THIS_ASSIGN = (TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 2) != 0;
    PACKED_INIT_EXPR = 0;
    CTOR_THIS_ASSIGNED = 0;
    CTOR_THIS_SYMBOL = LOOKUP_NAME(THIS_NAME);
    u16 member = LOOKUP_NAME(OPERATOR_DELETE_NAME);
    u16 expression = CONVERT_CLASS_TO_SCALAR(BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
    APPEND_JUMP_IF_FALSE_BLOCK(SIMPLIFY_EXPRESSION(expression, 0), begin, NOWHERE);
    APPEND_ANALYZED_EXPRESSION(BUILD_VPTR_INITS(CTOR_THIS_SYMBOL, CURRENT_CLASS_TYPE));
    PARSE_STATEMENT_LIST();
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS)));
    APPEND_ANALYZED_EXPRESSION(BUILD_DESTRUCTOR_BODY(CURRENT_CLASS_TYPE, CTOR_THIS_SYMBOL, CTOR_THIS_ASSIGNED, member));
    APPEND_BLOCK_IF_NONZERO(begin);
    CHECK_UNDEFINED_LABELS();
    CTOR_DTOR_MODE = 0;
}
