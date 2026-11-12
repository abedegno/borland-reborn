/* target: ovr120_C201UNIT */
/* Role: C++ classes: parses class definitions: base-class lists, access specifiers, member,
   friend and virtual function declarations, pure specifiers, member type finishing. Entry
   points: PARSE_STATE_CHECK, BCC_TYPE_RESOLVE_NAME. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C++ part of parsing a class definition. CLSMEMB.C runs the loop over
   the member declarations of a class body; for C++ it calls into this file through
   far entry stubs whose names differ from the functions here. Matching the dispatch
   codes, the stubs are probably: TYPE_BASE_FAR TYPE_BASE (the base clause),
   TYPE_CLASSIFY_FAR TYPE_CLASSIFY (kind of member declaration), TYPE_SCOPE_FAR
   TYPE_SCOPE (public:/private:/protected:), TYPE_DECLARE_FAR TYPE_DECLARE (access
   declaration Base::m;), TYPE_RELINK_FAR TYPE_RELINK (anonymous union member),
   TYPE_FINALIZE_FAR TYPE_FINALIZE (friend), TYPE_ENUM_FAR TYPE_ENUM (constructor
   declaration), TYPE_DEFER_FAR TYPE_DEFER (end of the member list),
   BCC_TYPE_FINISH_FAR TYPE_DISPATCH (one declarator), and BCC_DECL_CASE0/2/3/4 for
   TYPE_APPLY (typedef), TYPE_ARRAY (friend with a declarator), TYPE_RECORD (member
   function) and TYPE_VIRTUAL (static data member); also TYPE_PATH_FAR,
   TYPE_OPERATOR_FAR, TYPE_OFFSET_FAR and TYPE_ATTACH_FAR. Several names (TYPE_ENUM,
   TYPE_ARRAY, TYPE_VIRTUAL, TYPE_RECORD) do not say what the function does.
   State: STRUCT_BODY_TYPE is the class, ACTIVE_LIST its tag symbol, CLASS_KEY_TOKEN
   its keyword (0x68 class, 0x43 union), SCOPE_STATE the current access (0 public, 1
   protected, 2 private, 4 for hidden members), CLASS_VTABLE_SIZE the bytes of virtual
   table entries so far. A member declaration is described by TYPE_EXPR,
   CURRENT_DECLARATOR_NAME, STORAGE_CLASS_TOKEN (0x82 none, 0x35 static, 0x6B inline,
   0x37 typedef), SPECIAL_MEMBER_KIND (0 plain, 1 operator, 2 conversion, 3
   constructor, 4 destructor), MEMBER_QUALIFIER_CLASS (the X of X::name),
   MEMBER_DECL_FRIEND, PARSE_FLAG2 (the virtual keyword), NO_THIS_PARAMETER (static
   member function, operator new/delete), RETURN_TYPE_OMITTED and, for dynamically
   dispatched (DDVT) functions declared "= [n]", DISPATCH_NUMBER and
   DISPATCH_NUMBER_GIVEN.
   Virtual functions get SYM_VIRTUAL_INDEX = their entry's byte offset in the table
   plus 1 (TYPE_OFFSET); a function overriding one in the base that shares the table
   pointer (BASE_USED) reuses its slot. Friend information is kept in two places: a
   friend class F of class A gets A on the list at word 0x0A of F's tag body, and a
   friend function gets A on its CACHE_HEAD entry (CACHE_ADD); IS_FRIEND in ACCESS.C
   reads both. Many functions use register pseudo-variables and raw offsets (tag body
   2 members, 6 tag symbol, 10 friend list, 12 bases, 16 vtable size, 24 class flags;
   word-indexed reads such as ((unsigned int far *)p)[2] are byte offset 4, SYM_TYPE
   for a symbol) as the original did; do-nothing statements such as _AX=_AX are kept
   for byte matching. */
/* Original CO03F (ovr_1cd3_883b) as one source. */
/* opts: -mm -G -O -Z -p -Y */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
extern unsigned long CURRENT_TOKEN_VALUE;



/* ---- PSTATE (listing ovr_1cd3_883b:83B0) ---- */
extern char far pascal BCC_PARSE_BEGIN(unsigned int);
extern void far pascal BCC_PARSE_PUSH(unsigned int);
extern char far pascal BCC_PARSE_QUERY(void);
extern void far pascal BCC_PARSE_POP(unsigned int);
/* PARSE_STATE_CHECK: after "X(" inside class X: a trial parse (BCC_PARSE_BEGIN ...
   BCC_PARSE_POP) that answers whether the parenthesis starts a constructor's
   parameter list (nonzero, probably) rather than a declarator of a member of type X. */
unsigned char far pascal PARSE_STATE_CHECK(void)
{
    char result=0;
    if(BCC_PARSE_BEGIN(1)) {
        BCC_PARSE_PUSH(1);
        if(CURRENT_TOKEN==TOK_LPAREN) result=BCC_PARSE_QUERY();
        BCC_PARSE_POP(1);
    }
    return result;
}

/* ---- TNAME (listing ovr_1cd3_883b:83EE) ---- */
extern unsigned int far pascal BCC_TYPE_PRIMARY(unsigned int);
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
#define POOL_WORD(r) (*(unsigned int far *)MK_FP(TYPE_POOL,(r)))
/* BCC_TYPE_RESOLVE_NAME: the class type named by the current identifier (CURRENT_TOKEN_VALUE),
   as used before '::': a tag or typedef (storage class 11 or 8) of a class type, else
   MSG_TYPE_QUALIFIER_MUST (or MSG_UNDEFINED_SYMBOL) and 0. Does not advance. */
unsigned int far pascal BCC_TYPE_RESOLVE_NAME(void)
{
    register unsigned int result=0;
    register unsigned int node;
    node=BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
    if (!node) node=LOOKUP_NAME(CURRENT_TOKEN_VALUE);
    if (!node) REPORT_CURRENT_TOKEN(MSG_UNDEFINED_SYMBOL);
    else {
        if ((SYM_B(node,SYM_STORAGE_CLASS)>>3)==11 || (SYM_B(node,SYM_STORAGE_CLASS)>>3)==8) {
            if (SYM_W(node,SYM_TYPE)) {
                if (EXPR_FLAGS[POOL_WORD(SYM_W(node,SYM_TYPE))]&0x40) {
                    result=SYM_W(node,SYM_TYPE);
                    goto done;
                }
            }
        }
        REPORT_NAME_DIAGNOSTIC(MSG_TYPE_QUALIFIER_MUST,SYM_W(node,SYM_NAME));
    }
done:
    return result;
}
#undef POOL_WORD

/* ---- TPATH (listing ovr_1cd3_883b:8482) ---- */
struct DeclarationFlags { unsigned char first,second,third; };
extern struct DeclarationFlags EXPR_TEMP2;
extern unsigned int TOKEN_TYPE;

extern void far pascal ADVANCE_TOKEN(void);
extern struct DeclarationFlags far pascal PARSE_TYPE_MODIFIERS(struct DeclarationFlags);
extern unsigned int far pascal PARSE_POINTER_DECLARATOR(unsigned int,struct DeclarationFlags);
extern unsigned int far pascal COPY_TYPE_RECORD(unsigned int);
extern void far pascal PEEK_TOKEN(void);
/* TYPE_PATH: the pointer part of a C++ declarator: any sequence of '*', '&' and
   X::*, with type modifiers, applied to type initial. X::* makes a pointer to member
   (the member class goes into a copy of the type, pointer mode 0x0B); a qualifier X::
   left over in front of the name is returned in *result (0 if none). mode 0 also
   accepts "X:" (reported as MSG_FOUND_INSTEAD). text and scratch receive the modifier
   sets. Returns the type built; _SI holds it and _DI the pending qualifier class. */
static unsigned int far pascal TYPE_PATH(unsigned int initial,unsigned int mode,unsigned int far *result,struct DeclarationFlags far *text,struct DeclarationFlags far *scratch)
{
    unsigned char changed;
    struct DeclarationFlags temp;
    _SI=initial;_DI=0;changed=0;
    *scratch=EXPR_TEMP2;
    *result=0;
    while(CURRENT_TOKEN==TOK_SCOPE) {REPORT_CURRENT_TOKEN(MSG_REQUIRES_PRECEEDING);ADVANCE_TOKEN();}
    *text=PARSE_TYPE_MODIFIERS(*text);
    temp=*text;
    goto loop_test;
loop_body:
    if(CURRENT_TOKEN==TOK_STAR && _DI!=0) {
        if(_SI!=0) {
            _SI=COPY_TYPE_RECORD(_SI);
            if(*(unsigned int far *)MK_FP(TYPE_POOL,_SI+TYPE_MEMBER_CLASS)==0) *(unsigned int far *)MK_FP(TYPE_POOL,_SI+TYPE_MEMBER_CLASS)=_DI;
            else REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
            _DI=0;
        }
        if(text->second!=0) REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        temp.second=0x0B;
    }
    if(CURRENT_TOKEN==TOK_STAR || CURRENT_TOKEN==TOK_AMPERSAND) {
        changed=1;
        *scratch=temp;
        _SI=PARSE_POINTER_DECLARATOR(_SI,temp);
        *(unsigned int far *)MK_FP(TYPE_POOL,_SI+TYPE_CALL_CONV)=_DI;
        _DI=0;
        temp=PARSE_TYPE_MODIFIERS(EXPR_TEMP2);
        if(*(unsigned int far *)MK_FP(TYPE_POOL,_SI+TYPE_CALL_CONV)!=0) *scratch=temp;
    } else {
        if(_DI!=0) REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
        _DI=BCC_TYPE_RESOLVE_NAME();
        changed=0;
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN==TOK_DOT) REPORT_CURRENT_TOKEN(MSG_OBSOLETE_SYNTAX_USE);
        else if(CURRENT_TOKEN==TOK_COLON) REPORT_CURRENT_TOKEN(MSG_FOUND_INSTEAD);
        ADVANCE_TOKEN();
    }
loop_test:
    if(CURRENT_TOKEN==TOK_STAR || CURRENT_TOKEN==TOK_AMPERSAND) goto loop_body;
    if(CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();if(TOKEN_TYPE==0x67) goto loop_body;
        PEEK_TOKEN();if(TOKEN_TYPE==0x2F) goto loop_body;
        if(mode==0) {PEEK_TOKEN();if(TOKEN_TYPE==0x21) goto loop_body;}
    }
    if(!changed) *result=_DI;
    *text=temp;
    return _SI;
}

/* ---- TOPER (listing ovr_1cd3_883b:8697) ---- */
extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned int TOKEN_TYPE;
extern unsigned char far TOKEN_IS_TYPE_START(void far *value);
struct C16Spec { signed char first,second,third; };
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,unsigned char far *,unsigned int far *,struct C16Spec far *,unsigned char far *);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC();
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,unsigned int far *,unsigned int far *,unsigned int far *,struct C16Spec far *,struct C16Spec far *);

extern void far REQUIRE_TOKEN_ELSE_ERROR(int first, int second);

/* TYPE_OPERATOR: the name part "operator op", "operator type" or "~X" of a
   declarator. *name gets the member name (TOKEN_NAMES of the operator token, of 0x37
   for conversion functions, or the destructor name DTOR_NAME) and *kind 1
   operator, 2 conversion, 4 destructor. For a conversion function the declared type
   is returned (a written return type is MSG_BAD_RETURN_TYPE_TYPE inside a class),
   otherwise fallback. ~X must name class scope (or the class being defined). */
static unsigned int far pascal TYPE_OPERATOR(unsigned int fallback,
    unsigned int scope, unsigned int far *name, unsigned int far *kind)
{
    unsigned char first;
    unsigned char second;
    unsigned int code;
    unsigned int a;
    unsigned int b;
    unsigned int pair1[3];
    unsigned int pair2[2];
    unsigned char third;
    unsigned int value;
    register unsigned int token;
    register unsigned int node;

    token = 0x82;
    if (CURRENT_TOKEN == TOK_OPERATOR) {
        ADVANCE_TOKEN();
        token = CURRENT_TOKEN;
        if (CURRENT_TOKEN != TOK_TILDE && TOKEN_IS_TYPE_START((void far *)&CURRENT_TOKEN_RECORD) != 0) {
            PEEK_TOKEN();
            if (TOKEN_TYPE != 0x67) {
                token = 0x37;
                value = INT_TYPE;
                PARSE_DECL_SPECIFIERS(6, (void far *)&code, (void far *)&first,
                    (void far *)&second, (void far *)&value,
                    (void far *)&pair1[0], (void far *)&third);
                if (code != 0x82 || first != 0 || second != 0) {
                    REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,first ? (char far *)STR_FRIEND_4 :
                        second ? (char far *)STR_VIRTUAL_4 : NAME_TEXT_COPY(TOKEN_NAMES[code]),0L);
                }
                PARSE_DECLARATOR(value, 6, (void far *)&value, (void far *)&pair1[2],
                    (void far *)&a, (void far *)&b, (void far *)&pair1[0],
                    (void far *)&pair2[0]);
                if (BCC_TREE_FLAG != 0) {
                    if (!RETURN_TYPE_OMITTED)
                        REPORT_CURRENT_TOKEN(MSG_BAD_RETURN_TYPE_TYPE);
                }
                *kind = 2;
                *name = TOKEN_NAMES[token];
                return value;
            }
        }
        *kind = 1;
        *name = TOKEN_NAMES[token];
        if ((TYPE_FLAGS[CURRENT_TOKEN] & 0x400) == 0)
            REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
        ADVANCE_TOKEN();
        if (token == 1) {
            REQUIRE_TOKEN_ELSE_ERROR(2, 0xE9);
            return fallback;
        }
        if (token == 3) {
            if (CURRENT_TOKEN == TOK_RBRACKET)
                ADVANCE_TOKEN();
            else
                REPORT_DIAGNOSTIC(MSG_MISSING, (char far *)STR_OPERATOR_5, 0L);
        }
        return fallback;
    }
    if (CURRENT_TOKEN != TOK_TILDE)
        goto finish;
    ADVANCE_TOKEN();
    *name = DTOR_NAME;
    *kind = 4;
    if (CURRENT_TOKEN != TOK_IDENT)
        goto finish;
    if (scope == 0 && BCC_TREE_FLAG != 0)
        scope = STRUCT_BODY_TYPE;
    node = LOOKUP_NAME(CURRENT_TOKEN_VALUE);
    if (((int)((unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node))[7] >> 3) == 11) {
        if (*(unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_TYPE) != scope) {
            REPORT_CURRENT_TOKEN(MSG_DESTRUCTOR_NAME_MUST);
            _AX=_AX;
        }
    } else {
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    }
    ADVANCE_TOKEN();
finish:
    return fallback;
}

/* ---- LFIND (listing ovr_1cd3_883b:88B1) ---- */

/* LIST_FIND: searches list (a base list) and, recursively, the bases of its entries
   for another entry of the same class as base entry target where at least one of the
   two is non-virtual. Returns the entry found or 0. Used to warn about a base that is
   also reached through another base (MSG_INACCESSIBLE_BECAUSE). */
static int near pascal LIST_FIND(register unsigned int target,
                                 register unsigned int list)
{
    while (list != 0) {
        if (list != target &&
            *(unsigned int far *)MK_FP(TYPE_POOL,
                ((unsigned int far *)MK_FP(BASE_LIST_SEG, target))[1] + 5) ==
            *(unsigned int far *)MK_FP(TYPE_POOL,
                ((unsigned int far *)MK_FP(BASE_LIST_SEG, list))[1] + 5) &&
            (((unsigned char far *)MK_FP(BASE_LIST_SEG, target))[7] == 0 ||
             ((unsigned char far *)MK_FP(BASE_LIST_SEG, list))[7] == 0))
            break;
        if (LIST_FIND(target,
                *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                    *(unsigned int far *)MK_FP(TYPE_POOL,
                        ((unsigned int far *)MK_FP(BASE_LIST_SEG, list))[1] + 5) + 12)))
            break;
        list = ((unsigned int far *)MK_FP(BASE_LIST_SEG, list))[0];
    }
    return list;
}

/* ---- LPARSE (listing ovr_1cd3_883b:892B) ---- */
extern unsigned int far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern unsigned int far TYPE_LOOKUP_FAR(unsigned int name);
extern long far TYPE_SIZE(unsigned int node);
struct ParameterItem { unsigned int next,type,offset; unsigned char scope,qualifier,used; };
extern void far pascal ADD_UNIQUE_PARAM(unsigned int far *,struct ParameterItem,unsigned char far *);
extern char far * far pascal FORMAT_TYPE(unsigned int);


/* LIST_PARSE: parses the base-specifier list after ':' up to '{': each entry is
   [virtual] [public|private] Name (protected is not allowed, MSG_BASE_CLASS_CANNOT;
   the default access is public for struct, private for class). A base must be a
   complete class, not a union (MSG_MUST_PREVIOUSLY). Entries are collected with
   ADD_UNIQUE_PARAM (duplicates are MSG_BASE_CLASS_INCLUDED), put in declaration
   order, and checked with LIST_FIND. Returns the BASE list. */
static unsigned int near pascal LIST_PARSE(void)
{
    unsigned char qualifier;
    unsigned char scope;
    unsigned char seen;
    unsigned int head;
    struct ParameterItem item;
    unsigned int duplicate;
    unsigned char status;
    register unsigned int node;

    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_LBRACE)
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    scope = SCOPE_STATE == 0;
    seen = 0;
    head = 0;
    goto outer_test;

outer_body:
    qualifier = 0;
    goto qualifier_test;

qualifier_body:
    if (CURRENT_TOKEN == TOK_VIRTUAL) {
        if (qualifier != 0)
            REPORT_CURRENT_TOKEN(MSG_VIRTUAL_SPECIFIED_MORE);
        qualifier = 1;
    } else {
        if (seen != 0)
            REPORT_CURRENT_TOKEN(MSG_SPECIFIES_MULTIPLE);
        if (CURRENT_TOKEN == TOK_PROTECTED) {
            REPORT_CURRENT_TOKEN(MSG_BASE_CLASS_CANNOT);
        } else {
            scope = CURRENT_TOKEN == TOK_PUBLIC;
        }
        seen = 1;
    }
    ADVANCE_TOKEN();

qualifier_test:
    if (CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PRIVATE ||
        CURRENT_TOKEN == TOK_PROTECTED || CURRENT_TOKEN == TOK_VIRTUAL)
        goto qualifier_body;
    if (CURRENT_TOKEN != TOK_IDENT) {
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
        if (CURRENT_TOKEN == TOK_COMMA)
            ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_IDENT)
            goto item_done;
        SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
        goto item_done;
    }
    node = TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE);
    if (node == 0) {
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
        goto item_done;
    }
    _ES=TYPE_POOL;_BX=*(unsigned int far *)MK_FP(_ES,node);
    if(!((unsigned int)EXPR_FLAGS[_BX]&0x40)) goto invalid_item;
    if(*(unsigned int far *)MK_FP(_ES,node)==0x14) goto invalid_item;
    if (TYPE_SIZE(node) != 0)
        goto accepted_item;
invalid_item:
    REPORT_NAME_DIAGNOSTIC(MSG_MUST_PREVIOUSLY,
        ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG,
            ((unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                ((unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TAG_BODY))[0] + 6))[0] + 2))[0]);
    goto item_done;
accepted_item:
    {
        item.type=node;
        item.offset=0;
        item.scope=scope;
        item.qualifier=qualifier;
        item.used=0;
        ADD_UNIQUE_PARAM(&head,item,&status);
        if (status != 0)
            REPORT_NAME_DIAGNOSTIC(MSG_BASE_CLASS_INCLUDED,
                ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG,
                    ((unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                        ((unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TAG_BODY))[0] + 6))[0] + 2))[0]);
        qualifier = 0;
        scope = 0;
        seen = 0;
    }

item_done:
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_COMMA) {
        ADVANCE_TOKEN();
        goto outer_test;
    }
    if (CURRENT_TOKEN != TOK_LBRACE)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);

outer_test:
    if (CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PRIVATE ||
        CURRENT_TOKEN == TOK_PROTECTED || CURRENT_TOKEN == TOK_VIRTUAL ||
        CURRENT_TOKEN == TOK_IDENT)
        goto outer_body;
    if (CURRENT_TOKEN != TOK_LBRACE) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_216);
        SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
    }
    _SI=0;
    while(head!=0) {
        duplicate=head;
        _ES=BASE_LIST_SEG;_BX=duplicate;
        head=*(unsigned int far *)MK_FP(_ES,_BX);
        *(unsigned int far *)MK_FP(_ES,_BX)=_SI;
        _SI=duplicate;
    }
    head=_SI;
    _SI=head;
    while(_SI) {
        if((duplicate=LIST_FIND(_SI,head))!=0) {
            REPORT_DIAGNOSTIC(MSG_INACCESSIBLE_BECAUSE,FORMAT_TYPE(*(unsigned int far *)MK_FP(BASE_LIST_SEG,_SI+BASE_TYPE)),
                FORMAT_TYPE(*(unsigned int far *)MK_FP(BASE_LIST_SEG,duplicate+BASE_TYPE)));
        }
        _ES=BASE_LIST_SEG;_SI=*(unsigned int far *)MK_FP(_ES,_SI);
    }
    return head;
}

/* ---- LFIN (listing ovr_1cd3_883b:8BBE) ---- */
extern unsigned long TYPE_SIZE_LOW;
extern char far * far pascal FORMAT_TYPE(unsigned int);

/* LIST_FINISH: lays out the bases of STRUCT_BODY_TYPE: each non-virtual base at the
   next offset (TAG_OWN_SIZE of each), a virtual base taking only room for its virtual
   base pointer (the size of its TAG_THIS_TYPE). The first non-virtual base with a
   vtable at offset 0 shares its table pointer with the class (BASE_USED) and its
   vtable size is the start of CLASS_VTABLE_SIZE; a base with DDVT functions is always
   marked BASE_USED and passes on class flag 0x800. Each base gets class flag 1 (used as
   a base), 0x400 is passed on, and flag 4 is set when there are virtual bases. The
   class's memory model (8 far, 0x100 huge, 0x10 near) must agree with its bases'
   (messages 0xA4, 0xA5, 0x134..0x137); without any, OPTION_FLAG makes it huge,
   MODEL_FAR_DATA far, else near. Stores TAG_BASES and sets TYPE_SIZE_LOW to the bases'
   size. */
static void near pascal LIST_FINISH(unsigned int list)
{
    unsigned long total;
    unsigned int current;
    unsigned char size_flag,first,second,third;
    register unsigned int context;
    context=STRUCT_BODY_TYPE;
    first=(TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&8)!=0;
    second=(TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x10)!=0;
    third=(TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100)!=0;
    total=0;
    _SI=list;CLASS_VTABLE_SIZE=0;size_flag=0;
    while(_SI) {
        _ES=BASE_LIST_SEG;ES_W(_SI,BASE_OFFSET)=(unsigned int)total;current=ES_W(_SI,BASE_TYPE);
        TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=1;
        TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x400;
        if((TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x800)!=0) {
            TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=0x800;
            _ES=BASE_LIST_SEG;ES_B(_SI,BASE_USED)=1;
        }
        if((TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&8)!=0) {
            if(second!=0) {
                _AX=0xA5;
raise:
                REPORT_DIAGNOSTIC(_AX,FORMAT_TYPE(current),0L);goto flags_done;
            }
            if(third!=0) {_AX=0x134;goto raise;}
            first=1;goto flags_done;
        }
        if((TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100)!=0) {
            if(second!=0) {_AX=0x137;goto raise;}
            if(first!=0) {_AX=0x135;goto raise;}
            third=1;goto flags_done;
        }
        if(first!=0) {_AX=0xA4;goto raise;}
        if(third!=0) {_AX=0x136;goto raise;}
        second=1;
flags_done:
        _ES=BASE_LIST_SEG;
        if(ES_B(_SI,BASE_VIRTUAL)!=0) {
            total+=TYPE_SIZE(TAG_W(TYPE_W(ES_W(_SI,BASE_TYPE),TYPE_TAG_BODY),TAG_THIS_TYPE));
            size_flag=1;
        } else {
            size_flag=size_flag!=0 || (TAG_W(TYPE_W(BASE_W(_SI,BASE_TYPE),TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)!=0;
            if(CLASS_VTABLE_SIZE==0 && total==0L) {
                CLASS_VTABLE_SIZE=TAG_W(TYPE_W(BASE_W(_SI,BASE_TYPE),TYPE_TAG_BODY),TAG_VTABLE_SIZE);
                if(CLASS_VTABLE_SIZE!=0) {_ES=BASE_LIST_SEG;ES_B(_SI,BASE_USED)=1;}
            }
            total+=TAG_W(TYPE_W(BASE_W(_SI,BASE_TYPE),TYPE_TAG_BODY),TAG_OWN_SIZE);
        }
        _ES=BASE_LIST_SEG;_SI=ES_W(_SI,BASE_NEXT);
    }
    TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_BASES)=list;
    if(size_flag!=0) TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=4;
    if(!first && !second && !third) {
        if(OPTION_FLAG!=0) third=1;
        else first=MODEL_FAR_DATA;
    }
    TAG_W(TYPE_W(context,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=first!=0?8:third!=0?0x100:0x10;
    TYPE_SIZE_LOW=total;
}

/* ---- CADD (listing ovr_1cd3_883b:8EB0) ---- */
extern int far POOL_ALLOC(void far *pool, int size);
extern int far LIST_CONS(unsigned int cached, unsigned int value);

/* CACHE_ADD: adds class value to the friend list of function key in the CACHE_HEAD
   records (6 bytes: next, function, CONS list of classes), creating the record. */
static void near pascal CACHE_ADD(register unsigned int key, unsigned int value)
{
    register unsigned int node;

    node = CACHE_HEAD;
    while (node != 0) {
        if (((unsigned int far *)MK_FP(CACHE_POOL, node))[1] == key)
            break;
        node = ((unsigned int far *)MK_FP(CACHE_POOL, node))[0];
    }
    if (node == 0) {
        node = POOL_ALLOC(&CACHE_POOL, 6);
        ((unsigned int far *)MK_FP(CACHE_POOL, node))[0] = CACHE_HEAD;
        ((unsigned int far *)MK_FP(CACHE_POOL, node))[1] = key;
        ((unsigned int far *)MK_FP(CACHE_POOL, node))[2] = 0;
        CACHE_HEAD = node;
    }
    ((unsigned int far *)MK_FP(CACHE_POOL, node))[2] =
        LIST_CONS(((unsigned int far *)MK_FP(CACHE_POOL, node))[2], value);
}

/* ---- TFIN (listing ovr_1cd3_883b:8F1F) ---- */

extern unsigned int far DECLARE_TAG(unsigned int name);
extern void far ADD_HIDDEN_PARAMETER(unsigned int node, unsigned int kind);
extern unsigned int far MAKE_POINTER_TYPE(unsigned int type, unsigned int value,
                                 unsigned char kind);
extern unsigned int far TYPE_BUILD(unsigned int first, unsigned int second,
                                unsigned int third, unsigned int fourth);
extern void far DECLARE_FUNCTION(unsigned int first, unsigned int second,
                        unsigned int third, unsigned int fourth,
                        unsigned int far *result, unsigned char far *extra);
extern unsigned int far NEW_RECORD_TYPE(unsigned int first, unsigned int second);

/* TYPE_FINALIZE: a friend declaration in the class body. "friend class F;" adds the
   current class to F's friend list (tag word 10). A friend function is declared or
   found (X::f through TYPE_BUILD, others through DECLARE_FUNCTION; a constructor name
   becomes CTOR_NAME, operator new/delete are static) and gets the class on its
   CACHE_HEAD list. "friend F;" with F not yet declared declares a new class tag F
   (storage class 11) with the current class on its list. Friends that are data are
   MSG_FRIENDS_MUST_FUNCTIONS. Returns the function symbol, or 0. */
static int far pascal TYPE_FINALIZE(void)
{
    unsigned char extra;
    unsigned int result;
    register unsigned int node;

    if (PARSE_FLAG2 != 0 && MEMBER_QUALIFIER_CLASS == 0)
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (char far *)STR_VIRTUAL_4, 0L);
    if (EXPR_FLAGS[*(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR)] & 0x40) {
        if (CURRENT_DECLARATOR_NAME != 0)
            REPORT_CURRENT_TOKEN(MSG_FRIENDS_MUST_FUNCTIONS);
        *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            ((unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR + TYPE_TAG_BODY))[0] + 10) =
            LIST_CONS(*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                ((unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR + TYPE_TAG_BODY))[0] + 10),
                ACTIVE_LIST);
        goto return_zero;
    }
    if (*(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) != 0x12)
        goto check_other;
    if (SPECIAL_MEMBER_KIND == 0) {
        node = LOOKUP_NAME(CURRENT_DECLARATOR_NAME);
        if (node != 0 &&
            ((int)((unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node))[7] >> 3) == 11 &&
            ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2] == MEMBER_QUALIFIER_CLASS) {
            SPECIAL_MEMBER_KIND = 3;
            if (!RETURN_TYPE_OMITTED)
                REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, CURRENT_DECLARATOR_NAME);
            CURRENT_DECLARATOR_NAME = CTOR_NAME;
        }
    }
    if (SPECIAL_MEMBER_KIND == 1) {
        if (DECLARATOR_NAME_TOKEN != 0x6C && DECLARATOR_NAME_TOKEN != 0x69)
            goto build_result;
        if (STORAGE_CLASS_TOKEN != 0x6B && STORAGE_CLASS_TOKEN != 0x82)
            REPORT_NAME_DIAGNOSTIC(MSG_MEMBER_FUNCTIONS_CAN, CURRENT_DECLARATOR_NAME);
        NO_THIS_PARAMETER = 1;
        goto build_result;
    }
    if (SPECIAL_MEMBER_KIND == 3) {
        if ((*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            ((unsigned int far *)MK_FP(TYPE_POOL, MEMBER_QUALIFIER_CLASS + TYPE_TAG_BODY))[0] + 24) & 4) != 0)
            ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x73);
        *(unsigned int far *)MK_FP(TYPE_POOL,TYPE_EXPR+TYPE_TARGET)=MAKE_POINTER_TYPE(MEMBER_QUALIFIER_CLASS,0,0);
        goto build_result;
    }
    if (SPECIAL_MEMBER_KIND != 4)
        goto build_result;
    ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x69);
    *(unsigned int far *)MK_FP(TYPE_POOL,TYPE_EXPR+TYPE_TARGET)=VOID_TYPE;

build_result:
    if (MEMBER_QUALIFIER_CLASS != 0) {
        result = TYPE_BUILD(MEMBER_QUALIFIER_CLASS, TYPE_EXPR, CURRENT_DECLARATOR_NAME, SPECIAL_MEMBER_KIND);
    } else {
        DECLARE_FUNCTION(TYPE_EXPR, CURRENT_DECLARATOR_NAME, SPECIAL_MEMBER_KIND, 0x82,
                (unsigned int far *)&result, (unsigned char far *)&extra);
    }
    CACHE_ADD(result, ACTIVE_LIST);
    return result;

check_other:
    if (TYPE_EXPR != INT_TYPE)
        goto other_error;
    if (CURRENT_DECLARATOR_NAME == 0)
        goto other_error;
    if (MEMBER_QUALIFIER_CLASS != 0) {
other_scope_error:
        _AX=0x114;
        goto other_raise;
    }
    result = LOOKUP_NAME(CURRENT_DECLARATOR_NAME);
    if(result!=0) {_AX=_AX;goto other_scope_error;}
other_check_new:
    if (MEMBER_QUALIFIER_CLASS != 0 || SPECIAL_MEMBER_KIND != 0)
        goto other_invalid;
    node = DECLARE_TAG(CURRENT_DECLARATOR_NAME);
    ((unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node))[7] =
        (((unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node))[7] & 7) | 0x58;
    ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2] = NEW_RECORD_TYPE(TOK_STRUCT, 0x82);
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL,
            ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2] + 5))[0] + 6) = node;
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL,
            ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2] + 5))[0] + 10) =
        LIST_CONS(0, ACTIVE_LIST);
    goto return_zero;

other_invalid:
    REPORT_CURRENT_TOKEN(MSG_FRIENDS_MUST_FUNCTIONS);
    _AX=_AX;
    goto return_zero;

other_error:
    _AX=0xD2;
other_raise:
    REPORT_CURRENT_TOKEN(_AX);

return_zero:
    return 0;
}

/* ---- TDECL (listing ovr_1cd3_883b:91C3) ---- */

extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern char far * far pascal FORMAT_TYPE(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned int far pascal FIND_MEMBER_REPORT(unsigned int,unsigned int);
extern unsigned int far pascal LIST_CONS_ALT(unsigned int,unsigned int);
/* TYPE_DECLARE: an access declaration "Base::name;" (or Base::operator op): Base must
   be a direct base (MSG_NOT_BASE_CLASS); not allowed in a private section; the member's
   access (and, for functions, every overload's) must equal the current section
   (MSG_ACCESS_DECLARATIONS, 0x69). The member is added to TAG_ACCESS_DECLS, which
   ACCESS_MODE_VIA_BASES consults. */
static void far pascal TYPE_DECLARE(void)
{
    unsigned int result,name,kind,inherit;
    result=TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE);
    if(SCOPE_STATE==2) {
        _AX=0x104;
raise_initial:
        REPORT_CURRENT_TOKEN(_AX);goto after_initial;
    }
    if(result==0) {_AX=0xF7;goto raise_initial;}
    _BX=STRUCT_BODY_TYPE;_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TAG_BODY);_ES=TAG_BODY_POOL_SEG;_SI=ES_W(_BX,TAG_BASES);
    _ES=BASE_LIST_SEG;ES_W(0,BASE_TYPE)=result;
    while(TYPE_W(BASE_W(_SI,BASE_TYPE),TYPE_TAG_BODY)!=TYPE_W(result,TYPE_TAG_BODY)) {_ES=BASE_LIST_SEG;_SI=ES_W(_SI,BASE_NEXT);}
    if(_SI==0) {
        REPORT_DIAGNOSTIC(MSG_NOT_BASE_CLASS,NAME_TEXT_COPY(SYM_W(TAG_W(TYPE_W(result,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)),FORMAT_TYPE(STRUCT_BODY_TYPE));
    }
after_initial:
    ADVANCE_TOKEN();ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_OPERATOR) {
        TYPE_OPERATOR(0,0,&name,&kind);
        if(kind==2) {
            _AX=0x9F;
raise_operator:
            REPORT_CURRENT_TOKEN(_AX);SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);return;
        }
    } else if(CURRENT_TOKEN==TOK_IDENT) {name=CURRENT_TOKEN_VALUE;kind=0;ADVANCE_TOKEN();}
    else {_AX=0xD4;goto raise_operator;}
    if(result==0) return;
    _DI=FIND_MEMBER_REPORT(name,result);
    if(_DI==0) {
        _AX=0xD0;
raise_member:
        REPORT_CURRENT_TOKEN(_AX);goto after_member;
    }
    _ES=MEMBER_SEGMENT;
    if(((ES_B(_DI,MEMB_FLAGS)>>2)&7)!=SCOPE_STATE) {_AX=0x69;goto raise_member;}
    _ES=MEMBER_SEGMENT;
    if((ES_B(_DI,MEMB_FLAGS)&3)==3) {
        inherit=ES_W(_DI,MEMB_VALUE);
        while(inherit!=0) {
            _BX=inherit;_ES=SYMBOL_POOL_SEG;
            if((ES_B(_BX,SYM_INLINE_ACCESS)>>2)!=SCOPE_STATE) {REPORT_CURRENT_TOKEN(MSG_ACCESS_DECLARATIONS);_DI=0;goto after_member;}
            _BX=inherit;_ES=SYMBOL_POOL_SEG;inherit=ES_W(_BX,SYM_NEXT_OVERLOAD);
        }
    }
after_member:
    if(_DI!=0) {
        TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_ACCESS_DECLS)=LIST_CONS_ALT(TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_ACCESS_DECLS),_DI);
    }
}

/* ---- TCOMMIT (listing ovr_1cd3_883b:938E) ---- */
extern void far ADD_HIDDEN_PARAMETER(unsigned int node, unsigned int kind);
extern unsigned int far MAKE_POINTER_TYPE(unsigned int type, unsigned int value,
                                 unsigned char kind);
extern void far ADD_THIS_PARAMETER(unsigned int context, unsigned int expr);

/* TYPE_COMMIT: completes a member function's type before it is declared: operator new
   and delete are static (NO_THIS_PARAMETER; only inline allowed as storage); a
   constructor gets the hidden virtual-base flag (0x73) when the class has virtual bases
   and returns X *; a destructor gets the hidden flags parameter (0x69) and returns
   void; non-static functions get the this parameter. */
static void near pascal TYPE_COMMIT(void)
{
    if (SPECIAL_MEMBER_KIND == 1) {
        if (DECLARATOR_NAME_TOKEN != 0x6C && DECLARATOR_NAME_TOKEN != 0x69)
            goto finish;
        if (STORAGE_CLASS_TOKEN != 0x6B && STORAGE_CLASS_TOKEN != 0x82)
            REPORT_NAME_DIAGNOSTIC(MSG_MEMBER_FUNCTIONS_CAN, CURRENT_DECLARATOR_NAME);
        NO_THIS_PARAMETER = 1;
        goto finish;
    }
    if (SPECIAL_MEMBER_KIND == 3) {
        if ((*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            ((unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY))[0] + 24) & 4) != 0)
            ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x73);
        *(unsigned int far *)MK_FP(TYPE_POOL,TYPE_EXPR+TYPE_TARGET)=MAKE_POINTER_TYPE(STRUCT_BODY_TYPE,0,0);
        goto finish;
    }
    if (SPECIAL_MEMBER_KIND != 4)
        goto finish;
    ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x69);
    *(unsigned int far *)MK_FP(TYPE_POOL,TYPE_EXPR+TYPE_TARGET)=VOID_TYPE;

finish:
    if (!NO_THIS_PARAMETER)
        ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, TYPE_EXPR);
}

/* ---- TRESOLV (listing ovr_1cd3_883b:944E) ---- */
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal SAME_SIGNATURE(unsigned int,unsigned int);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
/* TYPE_RESOLVE: looks in class expr and its bases (only the bases sharing the table
   pointer, BASE_USED, when flag is set) for a virtual or DDVT function that function
   symbol type would override: same name and signature (a conversion function: same
   result type). Warns MSG_VIRTUAL_FUNCTION when the result types differ. Returns the
   function found or 0; symbol record 0 is the search sentinel. */
static unsigned int near pascal TYPE_RESOLVE(unsigned int expr,unsigned int type,unsigned char flag)
{
    unsigned int member,result,base;
    _BX=expr;_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TAG_BODY);_ES=TAG_BODY_POOL_SEG;_SI=ES_W(_BX,TAG_BASES);
    _BX=type;_ES=SYMBOL_POOL_SEG;base=ES_W(_BX,SYM_TYPE);
    member=FIND_MEMBER_BY_NAME(ES_W(_BX,SYM_NAME),expr);
    _BX=member;_ES=MEMBER_SEGMENT;
    if((ES_B(_BX,MEMB_FLAGS)&3)==3) {
        _DI=ES_W(_BX,MEMB_VALUE);
        _ES=SYMBOL_POOL_SEG;ES_W(0,SYM_TYPE)=base;
        if(ES_W(_DI,SYM_FUNC_KIND)==2) {
            while(!TYPES_COMPATIBLE(TYPE_W(SYM_W(_DI,SYM_TYPE),TYPE_TARGET),TYPE_W(base,TYPE_TARGET),0)) _DI=SYM_W(_DI,SYM_NEXT_OVERLOAD);
        } else {
            while(!SAME_SIGNATURE(SYM_W(_DI,SYM_TYPE),base)) _DI=SYM_W(_DI,SYM_NEXT_OVERLOAD);
        }
        if(_DI==0) {_DI=_DI;goto next_param;}
        _ES=SYMBOL_POOL_SEG;
        if(ES_W(_DI,SYM_VIRTUAL_INDEX)==0 && (ES_W(_DI,SYM_FUNC_FLAGS)&0x100)==0) goto next_param;
        if(!TYPES_COMPATIBLE(TYPE_W(SYM_W(_DI,SYM_TYPE),TYPE_TARGET),TYPE_W(base,TYPE_TARGET),0)) REPORT_DIAGNOSTIC(MSG_VIRTUAL_FUNCTION,FORMAT_SYMBOL(type),FORMAT_SYMBOL(_DI));
        return _DI;
    }
next_param:
    while(_SI) {
        _ES=BASE_LIST_SEG;
        if(ES_B(_SI,BASE_USED)!=0 || !flag) {
            result=TYPE_RESOLVE(BASE_W(_SI,BASE_TYPE),type,flag);
            if(result!=0) return result;
        }
        _ES=BASE_LIST_SEG;_SI=ES_W(_SI,BASE_NEXT);
    }
    return 0;
}

/* ---- TOFFSET (listing ovr_1cd3_883b:95A9) ---- */
/* TYPE_OFFSET: the SYM_VIRTUAL_INDEX for member function node: the slot of the
   function it overrides in the table-sharing base chain; else, when it is declared
   virtual (flag) or overrides a virtual function of some other base, a new slot at the
   end of the class's table (CLASS_VTABLE_SIZE grows by a near or far function pointer)
   and the result is the old size plus 1; else 0 (not virtual). Also used by IMPLMEMB.C
   (TYPE_OFFSET_FAR) for implicit destructors and operator=. */
static unsigned int far pascal TYPE_OFFSET(unsigned char flag,unsigned int node)
{
    unsigned int previous;
    register unsigned int result;
    register unsigned int current=node;
    current=current;
    result=TYPE_RESOLVE(STRUCT_BODY_TYPE,current,1);
    if(result!=0 && *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,result+SYM_VIRTUAL_INDEX)>0)
        return *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,result+SYM_VIRTUAL_INDEX);
    if(!flag && TYPE_RESOLVE(STRUCT_BODY_TYPE,current,0)==0) return 0;
    previous=CLASS_VTABLE_SIZE;
    CLASS_VTABLE_SIZE+=(unsigned int)TYPE_SIZE((*(unsigned char far *)MK_FP(TYPE_POOL,*(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,current+SYM_TYPE)+TYPE_FUNC_FLAGS)&1)?INT_FAR_FUNC_PTR_TYPE:INT_NEAR_FUNC_PTR_TYPE);
    return previous+1;
}

/* ---- TSETUP (listing ovr_1cd3_883b:9628) ---- */
#pragma option -G-   /* TSETUP was compiled without -G (its cdecl cleanup is pop cx) */
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int,long far *);

/* TYPE_SETUP: parses "= [ n ]" after a member function declarator, Borland's dynamic
   dispatch number: the class becomes a DDVT class (flag 0x800; warning
   MSG_CANNOT_USE_MULTIPLE when the base chain has multiple inheritance) and
   DISPATCH_NUMBER = n is given. The virtual keyword is then not needed (PARSE_FLAG2
   cleared). */
static void far pascal TYPE_SETUP(void)
{
    long value;
    register unsigned int current;
    if((TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x800)==0) {
        current=STRUCT_BODY_TYPE;
        for(;;) {
            if(TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_BASES)==0) break;
            if(BASE_W(TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_BASES),BASE_NEXT)!=0) {REPORT_WARNING(MSG_CANNOT_USE_MULTIPLE);break;}
            current=BASE_W(TAG_W(TYPE_W(current,TYPE_TAG_BODY),TAG_BASES),BASE_TYPE);
        }
        TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=0x800;
    }
    ADVANCE_TOKEN();ADVANCE_TOKEN();
    PARSE_CONSTANT_EXPR_VALUE(4,&value);
    DISPATCH_NUMBER=(unsigned int)value;
    DISPATCH_NUMBER_GIVEN=1;PARSE_FLAG2=0;
    if(CURRENT_TOKEN==TOK_RBRACKET) {ADVANCE_TOKEN();return;}
    REPORT_DIAGNOSTIC(MSG_MISSING,(char far *)STR_DYNAMIC_DISPATCH_CONSTAN,0L);
}

#pragma option -G
/* ---- TINHER (listing ovr_1cd3_883b:9703) ---- */
extern char far * far pascal FORMAT_SYMBOL(unsigned int);

/* TYPE_INHERIT: in a DDVT class, makes member function node dynamically dispatched
   when it overrides a DDVT function (inheriting its id; a different given number is
   MSG_MATCHING_BASE_CLASS) or when a dispatch number was given (overriding an ordinary
   virtual function then is MSG_MATCHING_BASE_CLASS_319). Such functions are far, get
   SYM_FUNC_FLAGS 0x100 and the id in SYM_VIRTUAL_INDEX, and are counted in TAG_DDVT_COUNT.
   Otherwise the function gets an ordinary slot (TYPE_OFFSET). */
static void far pascal TYPE_INHERIT(unsigned int node)
{
    register unsigned int current=node;
    register unsigned int resolved;
    resolved=TYPE_RESOLVE(STRUCT_BODY_TYPE,current,0);
    if(resolved==0) {resolved=resolved;goto unresolved;}
    _ES=SYMBOL_POOL_SEG;
    if((ES_W(resolved,SYM_FUNC_FLAGS)&0x100)==0) goto unresolved;
    ES_W(current,SYM_FUNC_FLAGS)|=0x100;
    ES_W(current,SYM_VIRTUAL_INDEX)=ES_W(resolved,SYM_VIRTUAL_INDEX);
    ++TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_DDVT_COUNT);
    _ES=SYMBOL_POOL_SEG;_BX=ES_W(current,SYM_TYPE);_ES=TYPE_POOL;ES_B(_BX,TYPE_FUNC_FLAGS)&=0xBF;
    _ES=SYMBOL_POOL_SEG;_BX=ES_W(current,SYM_TYPE);_ES=TYPE_POOL;ES_B(_BX,TYPE_FUNC_FLAGS)|=1;
    _ES=SYMBOL_POOL_SEG;ES_B(current,SYM_FLAGS)|=0x80;
    if(DISPATCH_NUMBER_GIVEN==0) return;
    if(ES_W(current,SYM_VIRTUAL_INDEX)==DISPATCH_NUMBER) return;
    REPORT_DIAGNOSTIC(MSG_MATCHING_BASE_CLASS,FORMAT_SYMBOL(current),0L);
    return;
unresolved:
    if(DISPATCH_NUMBER_GIVEN!=0) {
        _ES=SYMBOL_POOL_SEG;ES_W(current,SYM_FUNC_FLAGS)|=0x100;ES_W(current,SYM_VIRTUAL_INDEX)=DISPATCH_NUMBER;
        ++TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_DDVT_COUNT);
        _ES=SYMBOL_POOL_SEG;_BX=ES_W(current,SYM_TYPE);_ES=TYPE_POOL;ES_B(_BX,TYPE_FUNC_FLAGS)&=0xBF;
        _ES=SYMBOL_POOL_SEG;_BX=ES_W(current,SYM_TYPE);_ES=TYPE_POOL;ES_B(_BX,TYPE_FUNC_FLAGS)|=1;
        _ES=SYMBOL_POOL_SEG;ES_B(current,SYM_FLAGS)|=0x80;
        if(resolved!=0 && ES_W(resolved,SYM_VIRTUAL_INDEX)!=0) REPORT_DIAGNOSTIC(MSG_MATCHING_BASE_CLASS_319,FORMAT_SYMBOL(current),0L);
    } else {
        SYM_W(current,SYM_VIRTUAL_INDEX)=TYPE_OFFSET(PARSE_FLAG2,current);
    }
}

/* ---- TDEFINE (listing ovr_1cd3_883b:983B) ---- */
extern unsigned int TOKEN_TYPE;


extern void far pascal PEEK_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal SKIP_BRACE_GROUP(void);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern void far pascal MERGE_FUNCTION_DECLARATION(unsigned int,unsigned int,unsigned int far *,unsigned int,unsigned int,unsigned char far *);
extern unsigned int far pascal DECLARE_MEMBER(unsigned int,unsigned int);
/* TYPE_DEFINE: declares member function CURRENT_DECLARATOR_NAME of type TYPE_EXPR in
   the class: checks storage (only inline) and misplaced virtual (constructor, static),
   reads a dispatch number, completes the type (TYPE_COMMIT), rejects a second
   declaration with the same type, creates the symbol (member, owner ACTIVE_LIST,
   access, SYM_FUNC_FLAGS 0x10 for constructors, 0x40 for static members), merges it
   with an earlier declaration (MERGE_FUNCTION_DECLARATION), assigns its virtual slot
   or DDVT id, links it into the member's overload chain and handles a pure specifier
   "= 0" (token 0x32 with value 0: SYM_FUNC_FLAGS 0x20 and class flag 0x80; only for
   virtual functions, MSG_NON_VIRTUAL_FUNCTION). A virtual pascal function is
   MSG_CONFLICTING_TYPE. Returns the symbol. */
static unsigned int far pascal TYPE_DEFINE(void)
{
    unsigned int result,search;
    unsigned char flag;
    if(STORAGE_CLASS_TOKEN!=0x6B && STORAGE_CLASS_TOKEN!=0x82) REPORT_CURRENT_TOKEN(MSG_MEMBER_FUNCTIONS_CAN);
    if(PARSE_FLAG2!=0 && (SPECIAL_MEMBER_KIND==3 || NO_THIS_PARAMETER!=0)) REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,(char far *)STR_VIRTUAL_4,0L);
    if(CURRENT_TOKEN==TOK_ASSIGN) {PEEK_TOKEN();if(TOKEN_TYPE==3) TYPE_SETUP();}
    TYPE_COMMIT();
    _SI=FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME,STRUCT_BODY_TYPE);
    if(_SI!=0) {
        _ES=MEMBER_SEGMENT;
        if((ES_B(_SI,MEMB_FLAGS)&3)==3) {_DI=ES_W(_SI,MEMB_VALUE);goto member_done;}
    }
    if(_SI!=0) REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,CURRENT_DECLARATOR_NAME);
    _SI=0;_DI=0;
member_done:
    search=0;
    if(_DI!=0) {
        _ES=SYMBOL_POOL_SEG;
        if(ES_W(_DI,SYM_FUNC_KIND)!=2) ES_W(_DI,SYM_FUNC_FLAGS)|=1;
        search=_DI;
        _ES=SYMBOL_POOL_SEG;ES_W(0,SYM_TYPE)=TYPE_EXPR;
        while(!TYPES_COMPATIBLE(SYM_W(search,SYM_TYPE),TYPE_EXPR,0)) {
            _BX=search;_ES=SYMBOL_POOL_SEG;search=ES_W(_BX,SYM_NEXT_OVERLOAD);
        }
    }
    if(search!=0) {
        _BX=search;_ES=SYMBOL_POOL_SEG;
        if(ES_W(_BX,SYM_FUNC_KIND)!=2) goto duplicate;
        _BX=TYPE_EXPR;_ES=TYPE_POOL;
        if(ES_W(_BX,TYPE_TARGET)!=0) {
duplicate:
            REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,FORMAT_SYMBOL(search),0L);return 0;
        }
    }
    result=ALLOC_SYMBOL_ENTRY(CURRENT_DECLARATOR_NAME,6);
    _BX=result;_ES=SYMBOL_POOL_SEG;ES_W(_BX,SYM_FUNC_KIND)=SPECIAL_MEMBER_KIND;
    ES_B(_BX,SYM_FLAGS)|=0x10;
    ES_W(_BX,SYM_NEXT)=ACTIVE_LIST;
    MERGE_FUNCTION_DECLARATION(SPECIAL_MEMBER_KIND,TYPE_EXPR,&result,_DI,STORAGE_CLASS_TOKEN,&flag);
    _BX=result;_ES=SYMBOL_POOL_SEG;
    ES_B(_BX,SYM_INLINE_ACCESS)=(ES_B(_BX,SYM_INLINE_ACCESS)&0xE3)|(((unsigned char)SCOPE_STATE&7)<<2);
    if(_DI!=0 && SPECIAL_MEMBER_KIND!=2) ES_W(_BX,SYM_FUNC_FLAGS)|=1;
    if(SPECIAL_MEMBER_KIND==3) {_BX=result;_ES=SYMBOL_POOL_SEG;ES_W(_BX,SYM_FUNC_FLAGS)|=0x10;}
    if(NO_THIS_PARAMETER!=0) {_BX=result;_ES=SYMBOL_POOL_SEG;ES_W(_BX,SYM_FUNC_FLAGS)|=0x40;}
    if(MEMBER_FLAG_200_SWITCH!=0) {_BX=TYPE_EXPR;_ES=TYPE_POOL;ES_B(_BX,TYPE_FUNC_FLAGS)|=0x80;}
    _BX=STRUCT_BODY_TYPE;_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TAG_BODY);_ES=TAG_BODY_POOL_SEG;
    if(ES_W(_BX,TAG_CLASS_FLAGS)&0x800) TYPE_INHERIT(result);
    else {
        SYM_W(result,SYM_VIRTUAL_INDEX)=TYPE_OFFSET(PARSE_FLAG2,result);
    }
    _BX=result;_ES=SYMBOL_POOL_SEG;ES_W(_BX,SYM_LINKAGE)=1;
    _BX=TYPE_EXPR;_ES=TYPE_POOL;
    if(ES_B(_BX,TYPE_CALL_CONV)==2) {_BX=result;_ES=SYMBOL_POOL_SEG;if(ES_W(_BX,SYM_VIRTUAL_INDEX)!=0) REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);}
    if(_SI==0) _SI=DECLARE_MEMBER(CURRENT_DECLARATOR_NAME,3);
    if(flag!=0 || _DI==0) {
        SYM_W(result,SYM_NEXT_OVERLOAD)=MEMBER_W(_SI,MEMB_VALUE);
        _ES=MEMBER_SEGMENT;ES_W(_SI,MEMB_VALUE)=result;
    }
    if(CURRENT_TOKEN==TOK_ASSIGN) {
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN==0x32 && CURRENT_TOKEN_VALUE==0L) {
            _BX=result;_ES=SYMBOL_POOL_SEG;
            if(ES_W(_BX,SYM_VIRTUAL_INDEX)==0) REPORT_DIAGNOSTIC(MSG_NON_VIRTUAL_FUNCTION,FORMAT_SYMBOL(result),0L);
            else {
                _BX=result;_ES=SYMBOL_POOL_SEG;ES_W(_BX,SYM_FUNC_FLAGS)|=0x20;
                _BX=STRUCT_BODY_TYPE;_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TAG_BODY);_ES=TAG_BODY_POOL_SEG;ES_W(_BX,TAG_CLASS_FLAGS)|=0x80;
            }
            ADVANCE_TOKEN();
        } else {REPORT_CURRENT_TOKEN(MSG_BAD_SYNTAX_PURE);SKIP_BRACE_GROUP();}
    }
    return result;
}

/* ---- TVIRT (listing ovr_1cd3_883b:9B4F) ---- */
extern int FUNCTION_BODY_DEPTH;

extern unsigned int far pascal DECLARE_MEMBER(unsigned int,unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal SET_PREPARED_FLAGS(unsigned int,unsigned int);
/* TYPE_VIRTUAL: despite its name, declares a static data member: a member of kind 2
   whose value is an extern (storage class 2) member symbol, far when the class is far
   or huge (unless declared near, PARSE_CLASS 8), when declared far (PARSE_CLASS 9), or
   for a far array. Its definition comes later outside the class (DEFINE_STATIC_DATA_MEMBER in
   FUNCDECL.C). Not allowed in a local class. */
static void far pascal TYPE_VIRTUAL(void)
{
    unsigned int result;
    unsigned char special;
    register unsigned int member;
    register unsigned int node;
    if(FUNCTION_BODY_DEPTH>0) REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL,(char far *)STR_STATIC_MEMBER,0L);
    special=((TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x108)!=0 && PARSE_CLASS!=8) ||
        PARSE_CLASS==9 || (TYPE_W(TYPE_EXPR,TYPE_KIND)==0x11 && (TYPE_B(TYPE_EXPR,TYPE_ATTRS)&0x40));
    member=DECLARE_MEMBER(CURRENT_DECLARATOR_NAME,2);
    MEMBER_W(member,MEMB_VALUE)=node=ALLOC_SYMBOL_ENTRY(CURRENT_DECLARATOR_NAME,5);
    SYM_W(node,SYM_TYPE)=TYPE_EXPR;
    SYM_W(node,SYM_NEXT)=ACTIVE_LIST;
    SYM_B(node,SYM_STORAGE_CLASS)=(SYM_B(node,SYM_STORAGE_CLASS)&7)|0x10;
    SYM_B(node,SYM_FLAGS)|=0x12 | (special?0x80:0);
    SYM_W(node,SYM_STORAGE)=0;
    result=PREPARE_SYMBOL(node);
    SET_PREPARED_FLAGS(result,special?0x10:4);
    if(MEMBER_FLAG_200_SWITCH) SET_PREPARED_FLAGS(result,0x200);
}

/* ---- TRELINK (listing ovr_1cd3_883b:9C51) ---- */

extern void far pascal ADD_DATA_MEMBER(void);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned int far pascal COPY_MEMBER_RECORD(unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal CACHE_MEMBER_LOOKUP(unsigned int,unsigned int,unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
/* TYPE_RELINK: an anonymous union inside a class: declares a hidden data member of
   the union type (named EXPR_CURRENT2, flags 0xA0) and copies each of the union's
   data members into the class as a member at the union's offset (flag 0x20), so they
   can be named directly. Other members are not allowed (MSG_CANNOT_DECLARED). */
static void far pascal TYPE_RELINK(void)
{
    unsigned int inherited;
    register unsigned int member;
    register unsigned int created;
    if(TYPE_SIZE(TYPE_EXPR)==0L) REPORT_CURRENT_TOKEN(MSG_SIZE_TYPE_UNKNOWN_ZERO);
    CURRENT_DECLARATOR_NAME=EXPR_CURRENT2;
    ADD_DATA_MEMBER();
    member=FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME,STRUCT_BODY_TYPE);
    MEMBER_B(member,MEMB_FLAGS)|=0xA0;
    inherited=MEMBER_W(member,MEMB_VALUE);
    member=TAG_W(TYPE_W(TYPE_EXPR,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if((MEMBER_B(member,MEMB_FLAGS)&3)==0) {
            created=COPY_MEMBER_RECORD(member,inherited,TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS),SCOPE_STATE);
            TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS)=created;
            CACHE_MEMBER_LOOKUP(MEMBER_W(created,MEMB_NAME),STRUCT_BODY_TYPE,created);
            MEMBER_W(created,MEMB_CLASS)=STRUCT_BODY_TYPE;
            MEMBER_B(created,MEMB_FLAGS)|=0x20;
        } else REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED,MEMBER_W(member,MEMB_NAME));
        member=MEMBER_W(member,MEMB_NEXT);
    }
}

/* ---- TBASE (listing ovr_1cd3_883b:9D39) ---- */

extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
/* TYPE_BASE: start of a class body: sets the default access (private for class),
   resets CLASS_VTABLE_SIZE, parses an optional base clause (not allowed for a union),
   lays out the bases (LIST_FINISH) and makes TAG_THIS_TYPE, the type of this
   parameters, with MAKE_POINTER_TYPE(class, 0, 1) (the reference form; uses of this
   get a plain pointer type from BUILD_THIS_NODE). */
static void far pascal TYPE_BASE(void)
{
    register unsigned int list=0;
    SCOPE_STATE=CLASS_KEY_TOKEN==0x68?2:0;
    CLASS_VTABLE_SIZE=0;
    EXPR_OFFSET2=0;
    if(CURRENT_TOKEN==TOK_COLON) {
        if(CLASS_KEY_TOKEN==0x43) REPORT_CURRENT_TOKEN(MSG_UNION_CANNOT_HAVE_BASE);
        list=LIST_PARSE();
        if(CURRENT_TOKEN!=TOK_LBRACE) REPORT_CURRENT_TOKEN(MSG_CANNOT_SPECIFY_BASE);
    }
    LIST_FINISH(list);
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,*(unsigned int far *)MK_FP(TYPE_POOL,STRUCT_BODY_TYPE+TYPE_TAG_BODY)+TAG_THIS_TYPE)=MAKE_POINTER_TYPE(STRUCT_BODY_TYPE,0,1);
}

/* ---- TSCOPE (listing ovr_1cd3_883b:9DB2) ---- */
extern unsigned int TOKEN_TYPE;

/* TYPE_SCOPE: an access specifier followed by ':' sets SCOPE_STATE (not allowed in a
   union). */
static void far pascal TYPE_SCOPE(void)
{
    if (CLASS_KEY_TOKEN == 0x43)
        REPORT_CURRENT_TOKEN(MSG_ACCESS_SPECIFIER_FOUND);
    if (CURRENT_TOKEN == TOK_PRIVATE)
        SCOPE_STATE = 2;
    else if (CURRENT_TOKEN == TOK_PROTECTED)
        SCOPE_STATE = 1;
    else
        SCOPE_STATE = 0;
    PEEK_TOKEN();
    if (TOKEN_TYPE != 0x21)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_AFTER);
    else
        ADVANCE_TOKEN();
    ADVANCE_TOKEN();
}

/* ---- TENUM (listing ovr_1cd3_883b:9E0C) ---- */

extern struct DeclarationFlags MEMBER_DECL_ATTRIBUTES;
extern unsigned int TOKEN_TYPE;
extern int FUNCTION_BODY_DEPTH;
extern unsigned int far MAKE_POINTER_TYPE(unsigned int type, unsigned int value,
                                 unsigned char kind);
extern unsigned int far pascal PARSE_FUNCTION_DECLARATOR(unsigned int,struct DeclarationFlags);
extern void far RECORD_INLINE_BODY(unsigned int value);

/* TYPE_ENUM: despite its name, a constructor declaration "X(...)" inside class X:
   parses the parameter list (result type X *), makes it inline when a body or
   mem-initializer list follows, declares it (TYPE_DEFINE) and records the body
   (RECORD_INLINE_BODY). Returns 1 when a body was recorded (no ';' expected). */
static unsigned char far pascal TYPE_ENUM(void)
{
    unsigned int result;

    TYPE_EXPR = PARSE_FUNCTION_DECLARATOR(MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 0),MEMBER_DECL_ATTRIBUTES);
    if (STORAGE_CLASS_TOKEN == 0x82 &&
        (CURRENT_TOKEN == TOK_LBRACE || CURRENT_TOKEN == TOK_COLON))
        STORAGE_CLASS_TOKEN = 0x6B;
    SPECIAL_MEMBER_KIND = 3;
    CURRENT_DECLARATOR_NAME = CTOR_NAME;
    result = TYPE_DEFINE();
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 5) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
            ADVANCE_TOKEN();
        }
    }
    if (CURRENT_TOKEN == TOK_LBRACE || CURRENT_TOKEN == TOK_COLON) {
        RECORD_INLINE_BODY(result);
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (char far *)STR_NON_INLINE_FUNCTION, 0L);
    return 0;
}

/* ---- TDEFER (listing ovr_1cd3_883b:9ECD) ---- */

/* TYPE_DEFER: at the end of the member list of a class that has virtual functions
   (or class flags 0xC00): stores TAG_VTABLE_SIZE and, unless a base already provides
   the table pointer (some base has BASE_USED; record 0 is made a sentinel), adds the
   hidden table pointer member named VTABLE_PTR_NAME (a far char pointer for a huge class,
   else TYPE_LOCAL), access 4, member flag 0x80. */
static void far pascal TYPE_DEFER(void)
{
    register unsigned int cursor;
    register unsigned int member;

    if (CLASS_VTABLE_SIZE == 0 &&
        ((*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            ((unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY))[0] + 24)
            & 0xC00) == 0))
        return;
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY))[0] + 16) =
        CLASS_VTABLE_SIZE;
    cursor = *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY))[0] + 12);
    *(unsigned char far *)MK_FP(BASE_LIST_SEG, 8) = 1;
    while (!*(unsigned char far *)MK_FP(BASE_LIST_SEG, cursor + BASE_USED))
        cursor = *(unsigned int far *)MK_FP(BASE_LIST_SEG, cursor);
    if (cursor != 0)
        return;
    CURRENT_DECLARATOR_NAME = VTABLE_PTR_NAME;
    if ((*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY))[0] + 24)
        & 0x100) != 0)
        TYPE_EXPR = FAR_CHAR_POINTER_TYPE;
    else
        TYPE_EXPR = TYPE_LOCAL;
    SCOPE_STATE = 4;
    ADD_DATA_MEMBER();
    member = FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME, STRUCT_BODY_TYPE);
    *(unsigned char far *)MK_FP(MEMBER_SEGMENT, member + MEMB_FLAGS) |= 0x80;
}

/* ---- TASSIGN (listing ovr_1cd3_883b:9F94) ---- */

extern struct DeclarationFlags MEMBER_DECL_ATTRIBUTES;
extern void far pascal DECLARE_TYPEDEF(unsigned int,struct DeclarationFlags,unsigned int);

/* TYPE_APPLY: a typedef inside the class body (DECLARE_TYPEDEF); special names are
   MSG_NEED_IDENTIFIER. */
static void far pascal TYPE_APPLY(void)
{
    if (SPECIAL_MEMBER_KIND != 0) {
        REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
        return;
    }
    DECLARE_TYPEDEF(TYPE_EXPR,MEMBER_DECL_ATTRIBUTES,CURRENT_DECLARATOR_NAME);
}

/* ---- TARRAY (listing ovr_1cd3_883b:9FC5) ---- */
extern unsigned int TOKEN_TYPE;
extern int FUNCTION_BODY_DEPTH;
extern void far RECORD_INLINE_BODY(unsigned int value);

/* TYPE_ARRAY: despite its name, a friend declaration with a declarator: declares it
   with TYPE_FINALIZE and, when a function body follows, records it as an inline
   function (storage class 3) queued on INLINE_BODY_QUEUE, to be compiled when the
   class is complete. depth > 1 (not the first declarator) cannot have a body. Returns 1
   when a body was recorded. */
static unsigned char far pascal TYPE_ARRAY(unsigned int depth)
{
    register unsigned int node;

    node = TYPE_FINALIZE();
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 5) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
            ADVANCE_TOKEN();
        }
    }
    if (CURRENT_TOKEN == TOK_LBRACE &&
        *(unsigned int far *)MK_FP(TYPE_POOL,
            *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_TYPE)) == 0x12) {
        if (depth > 1)
            REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
        RECORD_INLINE_BODY(node);
        INLINE_BODY_QUEUE = LIST_CONS(INLINE_BODY_QUEUE, node);
        *(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_STORAGE_CLASS) =
            (*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_STORAGE_CLASS) & 7) | 0x18;
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (char far *)STR_NON_INLINE_FUNCTION, 0L);
    return 0;
}

/* ---- TRECORD (listing ovr_1cd3_883b:A06D) ---- */
extern unsigned int TOKEN_TYPE;
extern int FUNCTION_BODY_DEPTH;
extern unsigned int far TOKEN_FROM_NAME(unsigned int name);
extern long far FORMAT_MEMBER_NAME();
extern void far RECORD_INLINE_BODY(unsigned int value);

/* TYPE_RECORD: a member function declaration (depth is the declarator's position):
   recognizes a constructor by its name, notes the operator token
   (DECLARATOR_NAME_TOKEN), makes a function with a body inline and a static one
   static (constructors and the like cannot be static, MSG_FUNCTION_CANNOT_STATIC),
   declares it (TYPE_DEFINE) and records an inline body. Returns 1 when a body was
   recorded. */
static unsigned char far pascal TYPE_RECORD(unsigned int depth)
{
    unsigned int result;
    register unsigned int node;

    if (SPECIAL_MEMBER_KIND == 0) {
        node = LOOKUP_NAME(CURRENT_DECLARATOR_NAME);
        if (node != 0 &&
            ((int)*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_STORAGE_CLASS) >> 3) == 0x0B &&
            *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node + SYM_TYPE) == STRUCT_BODY_TYPE) {
            SPECIAL_MEMBER_KIND = 3;
            _AX = RETURN_TYPE_OMITTED;
            if (_AX == 0)
                REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, CURRENT_DECLARATOR_NAME);
            CURRENT_DECLARATOR_NAME = CTOR_NAME;
        }
    }
    DECLARATOR_NAME_TOKEN = TOKEN_FROM_NAME(CURRENT_DECLARATOR_NAME);
    NO_THIS_PARAMETER = 0;
    if (MEMBER_QUALIFIER_CLASS != 0 && MEMBER_QUALIFIER_CLASS != STRUCT_BODY_TYPE)
        REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE, CURRENT_DECLARATOR_NAME);
    if (STORAGE_CLASS_TOKEN == 0x82 &&
        (CURRENT_TOKEN == TOK_LBRACE || (CURRENT_TOKEN == TOK_COLON && SPECIAL_MEMBER_KIND == 3)))
        STORAGE_CLASS_TOKEN = 0x6B;
    if (STORAGE_CLASS_TOKEN == 0x35) {
        if (SPECIAL_MEMBER_KIND != 0 && DECLARATOR_NAME_TOKEN != 0x6C && DECLARATOR_NAME_TOKEN != 0x69)
            REPORT_DIAGNOSTIC(MSG_FUNCTION_CANNOT_STATIC, CURRENT_DECLARATOR_NAME,
                FORMAT_MEMBER_NAME(SPECIAL_MEMBER_KIND, TYPE_EXPR, STRUCT_BODY_TYPE), 0L);
        else
            NO_THIS_PARAMETER = 1;
        STORAGE_CLASS_TOKEN = 0x82;
    }
    result = TYPE_DEFINE();
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 5) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
            ADVANCE_TOKEN();
        }
    }
    if ((CURRENT_TOKEN == TOK_LBRACE || (CURRENT_TOKEN == TOK_COLON && SPECIAL_MEMBER_KIND == 3))) {
        if (depth > 1)
            REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
        RECORD_INLINE_BODY(result);
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (char far *)STR_NON_INLINE_FUNCTION, 0L);
    return 0;
}

/* ---- TCLASS (listing ovr_1cd3_883b:A1F2) ---- */
extern unsigned int TOKEN_TYPE;

extern struct DeclarationFlags MEMBER_DECL_ATTRIBUTES,EXPR_TEMP2;
extern unsigned int far TYPE_LOOKUP_FAR(unsigned int name);
extern unsigned char far TOKEN_IS_TYPE_START(void far *value);

/* TYPE_CLASSIFY: reads the start of a member declaration and returns its kind for
   TYPE_CLOSE: 2 access specifier, 3 access declaration (Base::...), 6 constructor
   declaration (X followed by '(' that PARSE_STATE_CHECK accepts), 1 declarators follow,
   5 friend without declarator, 4 anonymous union, 0 a type alone (it must name a tag
   or be an enum). Reads the declaration specifiers (storage only none, static, inline
   or typedef). The table at DS:09CA read through a near pointer is EXPR_FLAGS. */
static unsigned int far pascal TYPE_CLASSIFY(void)
{
    if (CURRENT_TOKEN == TOK_PRIVATE || CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PROTECTED)
        return 2;
    if (CURRENT_TOKEN == TOK_IDENT) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 0x67 && TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE) != STRUCT_BODY_TYPE)
            return 3;
    }
    STORAGE_CLASS_TOKEN = 0x82;
    _AL = 0;
    PARSE_FLAG2 = _AL;
    MEMBER_DECL_FRIEND = _AL;
    TYPE_EXPR = 0;
    MEMBER_DECL_TYPE_NAMED = 0;
    CURRENT_DECLARATOR_NAME = 0;
    NO_THIS_PARAMETER = 0;
    MEMBER_DECL_ATTRIBUTES = EXPR_TEMP2;
    MEMBER_QUALIFIER_CLASS = 0;
    DISPATCH_NUMBER_GIVEN = 0;
    if (TOKEN_IS_TYPE_START((void far *)&CURRENT_TOKEN_RECORD) != 0) {
        if (CURRENT_TOKEN == TOK_INLINE) {
            ADVANCE_TOKEN();
            STORAGE_CLASS_TOKEN = 0x6B;
        }
        PARSE_DECL_SPECIFIERS(2, (void far *)&STORAGE_CLASS_TOKEN, (void far *)&MEMBER_DECL_FRIEND,
            (void far *)&PARSE_FLAG2, (void far *)&TYPE_EXPR,
            (void far *)&MEMBER_DECL_ATTRIBUTES, (void far *)&MEMBER_DECL_TYPE_NAMED);
        if (STORAGE_CLASS_TOKEN != 0x82 && STORAGE_CLASS_TOKEN != 0x35 &&
            STORAGE_CLASS_TOKEN != 0x6B && STORAGE_CLASS_TOKEN != 0x37) {
            REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES[STORAGE_CLASS_TOKEN]);
            STORAGE_CLASS_TOKEN = 0x82;
        }
    }
    if (TYPE_EXPR == STRUCT_BODY_TYPE && CURRENT_TOKEN == TOK_LPAREN) {
        if (PARSE_STATE_CHECK() != 0)
            return 6;
    }
    if ((TYPE_FLAGS[CURRENT_TOKEN] & 0x10) != 0 ||
        CURRENT_TOKEN == TOK_COLON || CURRENT_TOKEN == TOK_TILDE)
        return 1;
    if (MEMBER_DECL_FRIEND != 0)
        return 5;
    if (TYPE_EXPR != 0 &&
        *(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) == 0x14 &&
        *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,
            *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                ((unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR + TYPE_TAG_BODY))[0] + 6) + 2) == 0)
        return 4;
    if (*(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) != 0x15) {
        _AX = *(unsigned char near *)(*(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) +
            0x9CA);
        if ((_AX & 0x40) == 0 ||
            *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,
                *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                    ((unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR + TYPE_TAG_BODY))[0] + 6) + 2) == 0)
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    }
    return 0;
}

/* ---- TDISPAT (listing ovr_1cd3_883b:A3B7) ---- */
extern unsigned int CURRENT_TOKEN_RECORD;

/* TYPE_DISPATCH: parses one member declarator and returns its kind for TYPE_LOOP_FAR:
   4 typedef, 5 friend, 6 member function, 7 static data member, 2 bit field (':'), 3
   data member. A missing type means int (void for a destructor) and is only accepted
   for functions; storage classes and special names that do not fit are reported. */
static unsigned int far pascal TYPE_DISPATCH(void)
{
    unsigned int parsed[2];
    register unsigned int previous;

    previous = TYPE_EXPR;
    RETURN_TYPE_OMITTED = 0;
    MEMBER_QUALIFIER_CLASS = 0;
    if (previous == 0) {
        if (CURRENT_TOKEN == TOK_TILDE)
            TYPE_EXPR = VOID_TYPE;
        else
            TYPE_EXPR = INT_TYPE;
        RETURN_TYPE_OMITTED = 1;
    } else if (CURRENT_TOKEN == TOK_TILDE)
        REPORT_CURRENT_TOKEN(MSG_DESTRUCTOR_CANNOT_HAVE);
    PARSE_DECLARATOR(TYPE_EXPR, 2, (void far *)&TYPE_EXPR, (void far *)&CURRENT_DECLARATOR_NAME,
        (void far *)&SPECIAL_MEMBER_KIND, (void far *)&MEMBER_QUALIFIER_CLASS,
        (void far *)&MEMBER_DECL_ATTRIBUTES, (void far *)parsed);
    if (CURRENT_DECLARATOR_NAME == 0) {
        if (CURRENT_TOKEN == TOK_COLON) {
return_two:
            return 2;
        }
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
        CURRENT_DECLARATOR_NAME = TOKEN_NAMES[CURRENT_TOKEN_RECORD];
        goto classify;
    }
    if (RETURN_TYPE_OMITTED != 0 &&
        *(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) != 0x12) {
        if (!MEMBER_DECL_FRIEND) {
            if ((*(unsigned char near *)(*(unsigned int far *)MK_FP(TYPE_POOL,
                    TYPE_EXPR) + 0x9CA) & 0x14) == 0 ||
                *(unsigned int far *)MK_FP(TYPE_POOL,
                    *(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR + TYPE_TARGET)) != 0x12) {
                if (STORAGE_CLASS_TOKEN == 0x82)
                    REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
            }
        }
    }
classify:
    if (STORAGE_CLASS_TOKEN == 0x37)
        return 4;
    if (MEMBER_DECL_FRIEND != 0)
        return 5;
    if (*(unsigned int far *)MK_FP(TYPE_POOL, TYPE_EXPR) == 0x12) {
        if (previous == TYPE_EXPR && MEMBER_DECL_TYPE_NAMED != 0)
            REPORT_CURRENT_TOKEN(MSG_FUNCTION_DEFINITION);
        return 6;
    }
    if (STORAGE_CLASS_TOKEN == 0x35) {
        if (CURRENT_TOKEN == TOK_COLON) {
            REPORT_CURRENT_TOKEN(MSG_BIT_FIELD_CANNOT);
            goto finish;
        }
        if (CLASS_KEY_TOKEN != 0x43)
            goto return_seven;
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, (char far *)STR_STATIC_2, 0L);
        goto finish;
    }
    goto finish;
return_seven:
    return 7;
finish:
    if (STORAGE_CLASS_TOKEN != 0x82)
        REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES[STORAGE_CLASS_TOKEN]);
    if (SPECIAL_MEMBER_KIND != 0)
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    if (CURRENT_TOKEN == TOK_COLON)
        goto return_two;
    return 3;
}

/* ---- TATTACH (listing ovr_1cd3_883b:A553) ---- */

/* TYPE_ATTACH: an enumerator of enum source declared inside a class becomes a member
   of kind 1 named type with value value (the long value is passed as two words:
   context is its high word, unused). The first one is also stored as the enum's
   TAG_MEMBERS. DECLARE_MEMBER's result is taken from _AX. */
static void far pascal TYPE_ATTACH(unsigned int source, unsigned int type,
    unsigned int context, unsigned int value)
{
    _SI = source;
    DECLARE_MEMBER(type, 1);
    _DI = _AX;
    *(unsigned int far *)MK_FP(MEMBER_SEGMENT, _DI + MEMB_TYPE) = _SI;
    *(unsigned int far *)MK_FP(MEMBER_SEGMENT, _DI + MEMB_VALUE) = value;
    *(unsigned int far *)MK_FP(MEMBER_SEGMENT, _DI + MEMB_CLASS) = STRUCT_BODY_TYPE;
    if (*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        ((unsigned int far *)MK_FP(TYPE_POOL, _SI + TYPE_TAG_BODY))[0] + 2) == 0)
        *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            ((unsigned int far *)MK_FP(TYPE_POOL, _SI + TYPE_TAG_BODY))[0] + 2) = _DI;
}
