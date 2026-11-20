/* target: ovr119_C103UNIT */
/* Role: C++ declarations: checks function and member declarations: storage classes,
   overloading and extern "C", main, operator new/delete signatures, constructor/destructor
   rules, global anonymous unions. Entry points: BCC_TYPE_RELATION,
   DEFINE_STATIC_DATA_MEMBER, BCC_TYPE_LINK, BCC_TYPE_COMPARE, BCC_TYPE_MATCH,
   BCC_TYPE_VALIDATE, TYPE_BUILD, BCC_TYPE_NORMALIZE. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: C++ checks on declarations, called by the external-declaration parser
   (parser/EXTDECL.C), the function-definition code (parser/FUNCDEF.C) and CLASSDEF.C.
   The function names (BCC_TYPE_*, TYPE_BUILD, from the original TREL, TMETHOD, TLINK,
   TCOMP, TMATCH, TVALID, TBIND, TNORM) do not say what they do:
   - BCC_TYPE_RELATION: a declaration with no declarator (a bare struct/union): an
     anonymous union's members become names in the current scope;
   - DEFINE_STATIC_DATA_MEMBER: the definition of a static data member X::m outside its class;
   - BCC_TYPE_MATCH / BCC_TYPE_COMPARE / BCC_TYPE_LINK: a function redeclared with a
     name already declared: same function (merge default arguments) or a new overload;
   - BCC_TYPE_VALIDATE: the rules for operator functions, operator new and delete, and
     constructors;
   - TYPE_BUILD: finds the member function X::f that an out-of-class definition defines;
   - BCC_TYPE_NORMALIZE: fixes up the type of a constructor or destructor being defined.
   Several functions read records through raw offsets and register pseudo-variables
   (_ES, _BX, _SI, _DI as in the original's register use, and do-nothing _AX=_AX or
   _DI=_DI statements kept for byte matching). Offsets: symbol 0 SYM_OWNER_CLASS, 2
   SYM_NAME, 4 SYM_TYPE, 6 SYM_FLAGS, 7 SYM_STORAGE_CLASS (11 a class name), 10
   SYM_FUNC_FLAGS, 15 SYM_FUNC_KIND, 17 SYM_LINKAGE, 19 SYM_NEXT_OVERLOAD; type 0 kind
   (0x11 array, 0x13 struct, 0x14 union), 2 attributes, 3 member class, 5 tag body, 7
   target, 9 parameters, 12 function flags; tag body 2 members, 6 tag symbol, 24 class
   flags; member 0 next, 2 name, 4 flags, 6 value. */
/* Original CO03E (ovr_1cce_8758) as one source. */
/* opts: -mm -G -O -Z -p -Y */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- TREL (listing ovr_1cce_8758:7580) ---- */
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int,unsigned char);
extern void far pascal DECLARE_MEMBER_ALIAS(unsigned int,unsigned int);
/* BCC_TYPE_RELATION: type is the type of a declaration that declares no name, op its
   storage class token. An unnamed union becomes an anonymous union: a temporary object
   is created and each data member is declared as an alias of its member
   (DECLARE_MEMBER_ALIAS); other members are not allowed (MSG_CANNOT_DECLARED); at file
   scope it must be static (op 0x35; MSG_GLOBAL_ANONYMOUS_UNION). A named struct may
   take only extern, static or no storage class (0x36, 0x35, 0x82); an unnamed struct or
   anything else is MSG_DECLARATION_DOES_NOT. */
void far pascal BCC_TYPE_RELATION(register unsigned int type,unsigned int op)
{
    unsigned int converted;
    unsigned int member;
    if(!type) return;
    if(AT_W(TYPE_POOL,type)==0x14) {
        if(AT_W(SYMBOL_POOL_SEG,AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,type+5)+6)+2)!=0) return;
        if(op!=0x35) REPORT_CURRENT_TOKEN(MSG_GLOBAL_ANONYMOUS_UNION);
        member=AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,type+5)+2);
        converted=CREATE_TEMP_SYMBOL(type,0);
        while(member) {
            if((AT_B(MEMBER_SEGMENT,member+4)&3)==0) DECLARE_MEMBER_ALIAS(member,converted);
            else REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED,AT_W(MEMBER_SEGMENT,member+2));
            member=AT_W(MEMBER_SEGMENT,member);
        }
    } else if(AT_W(TYPE_POOL,type)==0x13) {
        if(AT_W(SYMBOL_POOL_SEG,AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,type+5)+6)+2)==0) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
            return;
        }
        if(op!=0x36 && op!=0x35 && op!=0x82) REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,TOKEN_NAMES[op]);
    } else
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
}

/* ---- TMETHOD (listing ovr_1cce_8758:7671) ---- */
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern char far * far pascal FORMAT_MEMBER_NAME(unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC();
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal CLEAR_PREPARED_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
extern unsigned int far pascal DEFINE_HUGE_DATA_SEGMENTS(unsigned int);
extern void far pascal EMIT_HUGE_DATA(unsigned int);
extern unsigned int far pascal SELECT_SYMBOL_STREAM(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal EMIT_ZERO_BYTES(unsigned int);
extern void far pascal SET_STREAM(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
/* DEFINE_STATIC_DATA_MEMBER: defines the static data member name of class context, declared
   type base (token is the storage class; any is an error). The class must have a
   static member of that name and type, else MSG_NOT_MEMBER or MSG_MULTIPLE_DECLARATION
   (and 0 is returned). The member symbol becomes a defined static (storage class 1)
   and gets storage: with flag (an initializer follows) in the data segment or a far
   segment; a far array in huge data segments (EMIT_HUGE_DATA); otherwise zero bytes in
   the data segment. Returns the member symbol. */
unsigned int far pascal DEFINE_STATIC_DATA_MEMBER(unsigned int base,unsigned int context,unsigned int name,unsigned int token,unsigned char flag)
{
    register unsigned int method;
    unsigned int prepared;
    unsigned char special;
    unsigned int saved;
    unsigned int member;
    if (token != 0x82) REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,TOKEN_NAMES[token]);
    member = FIND_MEMBER_BY_NAME(name,context);
    if (!member)
        REPORT_DIAGNOSTIC(MSG_NOT_MEMBER,NAME_TEXT_COPY(name),FORMAT_TYPE(context));
    else if ((AT_B(MEMBER_SEGMENT,member+4) & 3) != 2 ||
             !TYPES_COMPATIBLE(base,AT_W(SYMBOL_POOL_SEG,AT_W(MEMBER_SEGMENT,member+6)+4),1)) {
        REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,FORMAT_MEMBER_NAME(name,0,base,context),0L);
        member = 0;
    }
    if (member) {
    method = AT_W(MEMBER_SEGMENT,member+6);
    special = AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,method+4)) == 0x11 &&
              (AT_B(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,method+4)+2) & 0x40);
    AT_B(SYMBOL_POOL_SEG,method+7) = (AT_B(SYMBOL_POOL_SEG,method+7) & 7) | 8;
    AT_B(SYMBOL_POOL_SEG,method+6) |= 1;
    prepared = PREPARE_SYMBOL(method);
    CLEAR_PREPARED_FLAGS(prepared,0x80);
    if (flag) {
        SET_SYMBOL_SEGMENT_HOOK(prepared,(special || (AT_B(SYMBOL_POOL_SEG,method+6) & 0x80)) ? DEFINE_FAR_SEGMENT() : DATA_SEGMENT_ID);
    } else if (special) {
        SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_HUGE_DATA_SEGMENTS(AT_W(SYMBOL_POOL_SEG,method+4)));
        EMIT_HUGE_DATA(method);
    } else {
        SET_SYMBOL_SEGMENT_HOOK(prepared,DATA_SEGMENT_ID);
        saved = SELECT_SYMBOL_STREAM(method);
        EMIT_ZERO_BYTES(TYPE_SIZE(base));
        SET_STREAM(saved);
    }
    return method;
    }
    return 0;
}

/* ---- TLINK (listing ovr_1cce_8758:7804) ---- */
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
/* BCC_TYPE_LINK: merges the default arguments of a redeclaration: left is the new
   function type, right the old one. A parameter defaulted in both is an error (0xA1),
   a parameter without default after one with a default is MSG_DEFAULT_VALUE_MISSING
   (0x7A); the default found is stored in the new type. Type flag 0x80 is carried over
   from the old type. Written with register pseudo-variables: _DI walks the old
   parameters, _SI the new ones. */
void far pascal BCC_TYPE_LINK(unsigned int left,unsigned int right)
{
    unsigned int seen;
    seen=0;
    _BX=right;_ES=TYPE_POOL;_DI=ES_W(_BX,TYPE_PARAMS);
    _BX=left;_SI=ES_W(_BX,TYPE_PARAMS);
    while(_DI) {
        _ES=FORMAL_POOL_SEG;
        if(ES_W(_DI,FORMAL_DEFAULT_ARG)!=0 && ES_W(_SI,FORMAL_DEFAULT_ARG)!=0) {
            _AX=0xA1;
raise:
            REPORT_CURRENT_TOKEN(_AX);
        }
        else {
            if(seen!=0) {
                _ES=FORMAL_POOL_SEG;
                if(ES_W(_DI,FORMAL_DEFAULT_ARG)==0 && ES_W(_SI,FORMAL_DEFAULT_ARG)==0) {_AX=0x7A;goto raise;}
            }
            _ES=FORMAL_POOL_SEG;
            if(ES_W(_DI,FORMAL_DEFAULT_ARG)!=0 || ES_W(_SI,FORMAL_DEFAULT_ARG)!=0) {
                _ES=FORMAL_POOL_SEG;
                if(ES_W(_SI,FORMAL_DEFAULT_ARG)!=0) ++seen;
                _ES=FORMAL_POOL_SEG;
                if(ES_W(_DI,FORMAL_DEFAULT_ARG)==0) _AX=ES_W(_SI,FORMAL_DEFAULT_ARG);
                else {_ES=FORMAL_POOL_SEG;_AX=ES_W(_DI,FORMAL_DEFAULT_ARG);}
                _ES=FORMAL_POOL_SEG;ES_W(_SI,FORMAL_DEFAULT_ARG)=_AX;
            }
        }
next:
        _ES=FORMAL_POOL_SEG;_DI=ES_W(_DI,FORMAL_NEXT);_SI=ES_W(_SI,FORMAL_NEXT);
    }
    _BX=right;_ES=TYPE_POOL;
    _AL=0x80 & ES_B(_BX,TYPE_FUNC_FLAGS);
    _BX=left;ES_B(_BX,TYPE_FUNC_FLAGS)|=_AL;
}

/* ---- TCOMP (listing ovr_1cce_8758:78CD) ---- */
extern unsigned char far pascal BCC_TYPE_PRED(unsigned int, unsigned int);
/* BCC_TYPE_COMPARE: 1 if two function types differ in their parameters, so the
   functions can be overloaded. When only one is a member function its this parameter
   is skipped. Parameters match when compatible (BCC_TYPE_PRED) or when one is an
   arithmetic type and the other a reference to it. The ellipsis flag must agree too. */
unsigned char far pascal BCC_TYPE_COMPARE(unsigned int left, unsigned int right)
{
    register unsigned int a;
    register unsigned int b;
    unsigned int first, second;
    a = AT_W(TYPE_POOL,left+9);
    b = AT_W(TYPE_POOL,right+9);
    if (AT_W(TYPE_POOL,left+3) != AT_W(TYPE_POOL,right+3)) {
        if (!AT_W(TYPE_POOL,left+3)) b = AT_W(FORMAL_POOL_SEG,b);
        if (!AT_W(TYPE_POOL,right+3)) a = AT_W(FORMAL_POOL_SEG,a);
    }
    while (a && b) {
        first = AT_W(FORMAL_POOL_SEG,a+2);
        second = AT_W(FORMAL_POOL_SEG,b+2);
        if (!BCC_TYPE_PRED(first,second)) {
            if ((EXPR_FLAGS[AT_W(TYPE_POOL,first)] & 3) &&
                (EXPR_FLAGS[AT_W(TYPE_POOL,second)] & 0x14) &&
                (AT_B(TYPE_POOL,second+2) & 0x20)) {
                if (!BCC_TYPE_PRED(first,AT_W(TYPE_POOL,second+7))) {
                    different: return 1;
                }
            } else if ((EXPR_FLAGS[AT_W(TYPE_POOL,second)] & 3) &&
                       (EXPR_FLAGS[AT_W(TYPE_POOL,first)] & 0x14) &&
                       (AT_B(TYPE_POOL,first+2) & 0x20)) {
                _AX = BCC_TYPE_PRED(second,AT_W(TYPE_POOL,first+7));
                if (_AX) goto next;
                _AX = _AX;
                goto different;
            } else { _AX = _AX; goto different; }
        }
next:
        a = AT_W(FORMAL_POOL_SEG,a);
        b = AT_W(FORMAL_POOL_SEG,b);
    }
    return a != b || (AT_B(TYPE_POOL,left+12) & 4) != (AT_B(TYPE_POOL,right+12) & 4);
}

/* ---- TMATCH (listing ovr_1cce_8758:7A0F) ---- */
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern long far pascal SPELL_SYMBOL_WITH_TYPE(unsigned int,unsigned int);
extern long far pascal FORMAT_SYMBOL(unsigned int);
extern long far pascal LINKAGE_NAME(unsigned int);
/* BCC_TYPE_MATCH: a function named like the existing overload chain node is declared
   with type value and linkage mode. Walks the chain: a compatible type means a
   redeclaration (*selected gets it, default arguments are merged, the linkage must
   agree: MSG_WAS_PREVIOUSLY); a type that cannot be told apart from an existing one is
   MSG_CANNOT_DISTINGUISHED; two overloads with "C" linkage (mode 2) are
   MSG_ONLY_ONE_SET. Conversion functions (kind 2) are never reported as
   indistinguishable, and redeclaring one is MSG_MULTIPLE_DECLARATION. main cannot be
   overloaded. *result is 1 when a new
   overload must be added, 0 when an existing function was matched (or on error). */
void far pascal BCC_TYPE_MATCH(unsigned int node,register unsigned int value,unsigned int mode,unsigned int far *selected,unsigned char far *result)
{
    register unsigned int cursor;
    unsigned int type;
    unsigned char found, special, active;
    active = value != 0;
    found = 0;
    cursor = node;
    special = AT_W(SYMBOL_POOL_SEG,cursor+15) == 2;
    if (AT_W(SYMBOL_POOL_SEG,node+2) == MAIN_SYMBOL && !(AT_B(SYMBOL_POOL_SEG,node+6) & 0x10)) {
        *result = 0;
        REPORT_CURRENT_TOKEN(MSG_CANNOT_OVERLOAD_MAIN);
        return;
    }
    while (active && cursor) {
        type = AT_W(SYMBOL_POOL_SEG,cursor+4);
        if (TYPES_COMPATIBLE(type,value,0)) {
            found = 1;
            *selected = cursor;
            active = 1;
        } else {
            if (mode == 2 && AT_W(SYMBOL_POOL_SEG,cursor+17) == 2)
                REPORT_CURRENT_TOKEN(MSG_ONLY_ONE_SET);
            if (!special)
                active = BCC_TYPE_COMPARE(type,value);
            if (!active)
                REPORT_DIAGNOSTIC(MSG_CANNOT_DISTINGUISHED,SPELL_SYMBOL_WITH_TYPE(cursor,value),FORMAT_SYMBOL(cursor));
        }
        cursor = AT_W(SYMBOL_POOL_SEG,cursor+19);
    }
    if (active && found) {
        type = AT_W(SYMBOL_POOL_SEG,*selected+4);
        if (mode && AT_W(SYMBOL_POOL_SEG,*selected+17) != mode)
            REPORT_DIAGNOSTIC(MSG_WAS_PREVIOUSLY,FORMAT_SYMBOL(*selected),LINKAGE_NAME(AT_W(SYMBOL_POOL_SEG,*selected+17)));
        if (special)
            REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,FORMAT_SYMBOL(*selected),0L);
        if (!(AT_B(SYMBOL_POOL_SEG,*selected+6) & 2) && CURRENT_SCOPE == GLOBAL_SCOPE)
            AT_W(SYMBOL_POOL_SEG,*selected+4) = value;
        if (value != type)
            BCC_TYPE_LINK(value,type);
        active = 0;
    }
    *result = active;
}

/* ---- TVALID (listing ovr_1cce_8758:7BE1) ---- */
extern unsigned int far pascal TOKEN_FROM_NAME(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
/* BCC_TYPE_VALIDATE: checks function record of type type when it is declared. Marks
   it (SYM_FUNC_FLAGS 1) unless it is a conversion function. By the token its name
   stands for (TOKEN_FROM_NAME):
   - operator new (0x6C): must return void * and take a size_t first;
   - operator delete (0x69): must return void and take void * and optionally size_t;
   - operator() and operator[] (1, 3), operator= (11), operator-> (0x30, must return a
     class or pointer), destructors (6) and conversion functions (0x37) must be
     members; a constructor (5) that takes its own class by value is not allowed
     (MSG_CONSTRUCTOR_NOT) and the parameter is made a reference;
   - other operators must have one (mode 1: unary) or two (mode 2: binary) operands
     counting this; + - * & and token 42 may have either.
   Wrong operand counts report 0x90..0x92. has_result means "is a member function"
   (TYPE_MEMBER_CLASS set); a non-member operator needs a class (or reference to
   class) operand (MSG_MUST_MEMBER_FUNCTION). count includes this and, for a
   destructor, not its hidden flags parameter. */
void far pascal BCC_TYPE_VALIDATE(unsigned int record,unsigned int type)
{
    int count,mode;
    unsigned int argument;
    unsigned char has_result,requires_result;
    _DI=type;mode=0;requires_result=0;
    _BX=record;_ES=SYMBOL_POOL_SEG;
    if(ES_W(_BX,SYM_FUNC_KIND)!=2) ES_W(_BX,SYM_FUNC_FLAGS)|=1;
    count=0;
    _ES=TYPE_POOL;_SI=ES_W(_DI,TYPE_PARAMS);
    while(_SI) {++count;_ES=FORMAL_POOL_SEG;_SI=ES_W(_SI,FORMAL_NEXT);}
    _BX=record;_ES=SYMBOL_POOL_SEG;
    if(ES_W(_BX,SYM_FUNC_KIND)==4) --count;
    _ES=TYPE_POOL;has_result=ES_W(_DI,TYPE_MEMBER_CLASS)!=0;
    switch(TOKEN_FROM_NAME((_BX=record,_ES=SYMBOL_POOL_SEG,ES_W(_BX,SYM_NAME)))) {
    case 108:
        _ES=TYPE_POOL;_BX=ES_W(_DI,TYPE_TARGET);_BX=ES_W(_BX,TYPE_KIND);
        if((EXPR_FLAGS[_BX]&0x14)==0) goto first_bad;
        _BX=ES_W(_DI,TYPE_TARGET);_BX=ES_W(_BX,TYPE_TARGET);
        if(ES_W(_BX,TYPE_KIND)!=0xC) {
first_bad:
            REPORT_CURRENT_TOKEN(MSG_OPERATOR_NEW_MUST);
        }
        if(count==0) {REPORT_DIAGNOSTIC(MSG_MUST_DECLARED_ONE,(char far *)STR_OPERATOR_NEW,0L);return;}
        _ES=TYPE_POOL;_SI=ES_W(_DI,TYPE_PARAMS);_ES=FORMAL_POOL_SEG;
        if(!TYPES_COMPATIBLE(ES_W(_SI,FORMAL_TYPE),SIZE_T_TYPE,1)) {REPORT_CURRENT_TOKEN(MSG_OPERATOR_NEW_MUST_HAVE);return;}
        return;
    case 105:
        _ES=TYPE_POOL;
        if(ES_W(_DI,TYPE_TARGET)!=VOID_TYPE) REPORT_CURRENT_TOKEN(MSG_OPERATOR_DELETE_MUST);
        if(count==0 || count>2) {REPORT_DIAGNOSTIC(MSG_MUST_DECLARED_ONE,(char far *)STR_OPERATOR_DELETE,0L);return;}
        _ES=TYPE_POOL;_SI=ES_W(_DI,TYPE_PARAMS);
        _ES=FORMAL_POOL_SEG;_BX=ES_W(_SI,FORMAL_TYPE);_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_KIND);
        if((EXPR_FLAGS[_BX]&0x14)==0) goto second_failed;
        _ES=FORMAL_POOL_SEG;_BX=ES_W(_SI,FORMAL_TYPE);_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TARGET);
        if(ES_W(_BX,TYPE_KIND)!=0xC) goto second_failed;
        if(count!=2) return;
        _ES=FORMAL_POOL_SEG;_BX=ES_W(_SI,FORMAL_NEXT);
        if(!TYPES_COMPATIBLE(ES_W(_BX,FORMAL_TYPE),SIZE_T_TYPE,1)) goto second_failed;
        return;
second_failed:
        REPORT_CURRENT_TOKEN(MSG_DECLARE_OPERATOR);return;
    case 1:case 3:
        requires_result=1;break;
    case 5:
        requires_result=1;
        _ES=TYPE_POOL;_BX=ES_W(_DI,TYPE_PARAMS);_ES=FORMAL_POOL_SEG;_SI=ES_W(_BX,FORMAL_NEXT);
        _ES=TYPE_POOL;_BX=ES_W(_DI,TYPE_MEMBER_CLASS);_BX=ES_W(_BX,TYPE_TAG_BODY);_ES=TAG_BODY_POOL_SEG;
        if(ES_W(_BX,TAG_CLASS_FLAGS)&4) {_ES=FORMAL_POOL_SEG;_SI=ES_W(_SI,FORMAL_NEXT);}
        if(!_SI) break;
        _ES=FORMAL_POOL_SEG;
        if(ES_W(_SI,FORMAL_NEXT)!=0) {_BX=ES_W(_SI,FORMAL_NEXT);if(ES_W(_BX,FORMAL_DEFAULT_ARG)==0) break;}
        _ES=FORMAL_POOL_SEG;
        if(TYPES_COMPATIBLE(ES_W(_SI,FORMAL_TYPE),(_ES=TYPE_POOL,ES_W(_DI,TYPE_MEMBER_CLASS)),1)) {
        REPORT_DIAGNOSTIC(MSG_CONSTRUCTOR_NOT,FORMAT_SYMBOL(record),0L);
        _ES=FORMAL_POOL_SEG;_AX=MAKE_POINTER_TYPE(ES_W(_SI,FORMAL_TYPE),0,1);
        _ES=FORMAL_POOL_SEG;ES_W(_SI,FORMAL_TYPE)=_AX;
        }
        break;
    case 48:
        _ES=TYPE_POOL;_BX=ES_W(_DI,TYPE_TARGET);_BX=ES_W(_BX,TYPE_KIND);
        if(!((unsigned int)EXPR_FLAGS[_BX]&0x40)) {
            _BX=ES_W(_DI,TYPE_TARGET);_BX=ES_W(_BX,TYPE_KIND);
            if(!((unsigned int)EXPR_FLAGS[_BX]&0x14)) REPORT_CURRENT_TOKEN(MSG_OPERATOR_MUST_RETURN);
        }
qualify:
        requires_result=1;goto mode_one;
    case 6:case 55:
        _DI=_DI;goto qualify;
    case 11:
        requires_result=1;goto mode_two;
    case 43:case 45:case 46:
mode_one:
        mode=1;break;
    case 8:case 12:case 13:case 14:case 15:case 16:case 17:case 18:case 19:case 20:case 21:case 25:case 26:case 28:case 29:case 30:case 31:case 34:case 35:case 36:case 37:case 38:case 39:case 40:case 41:case 102:
mode_two:
        mode=2;_DI=_DI;break;
    case 22:case 23:case 24:case 27:case 42:
        if((has_result!=0 && count==0) || count==1 || (!has_result && count==2)) mode=count;
        else mode=2;
        break;
    }
    if(requires_result!=0 && !has_result) REPORT_DIAGNOSTIC(MSG_MUST_MEMBER_FUNCTION_192,FORMAT_SYMBOL(record),0L);
    if(mode!=0 && (mode!=count || mode>2)) {
        if(mode==1 && has_result!=0) _AX=0x90;
        else if(mode==1 || (has_result!=0 && mode==2)) _AX=0x91;
        else _AX=0x92;
        REPORT_DIAGNOSTIC(_AX,FORMAT_SYMBOL(record),0L);
    }
    if(count>0) {
        _ES=TYPE_POOL;_SI=ES_W(_DI,TYPE_PARAMS);_ES=FORMAL_POOL_SEG;argument=ES_W(_SI,FORMAL_TYPE);
        _ES=TYPE_POOL;_BX=argument;_BX=ES_W(_BX,TYPE_KIND);
        if(EXPR_FLAGS[_BX]&0x14) {_BX=argument;argument=ES_W(_BX,TYPE_TARGET);}
        _ES=TYPE_POOL;_BX=argument;_BX=ES_W(_BX,TYPE_KIND);
        if(!((unsigned int)EXPR_FLAGS[_BX]&0x40) && count>1) {
            _ES=FORMAL_POOL_SEG;_SI=ES_W(_SI,FORMAL_NEXT);argument=ES_W(_SI,FORMAL_TYPE);
            _ES=TYPE_POOL;_BX=argument;_BX=ES_W(_BX,TYPE_KIND);
            if(EXPR_FLAGS[_BX]&0x14) {_BX=argument;argument=ES_W(_BX,TYPE_TARGET);}
        }
        _ES=TYPE_POOL;_BX=argument;_BX=ES_W(_BX,TYPE_KIND);
        if(!((unsigned int)EXPR_FLAGS[_BX]&0x40)) REPORT_DIAGNOSTIC(MSG_MUST_MEMBER_FUNCTION,FORMAT_SYMBOL(record),0L);
    }
}

/* ---- TBIND (listing ovr_1cce_8758:80A0) ---- */
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern char far * far pascal FORMAT_MEMBER_NAME(unsigned int,unsigned int,unsigned int,unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern void far pascal ADD_THIS_PARAMETER(unsigned int,unsigned int);
extern void far pascal DECLARE_FUNCTION(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int far *,unsigned char far *);
/* TYPE_BUILD: finds the member function of class scope that the out-of-class
   definition X::name with function type type defines; kind is the special kind (3
   constructor when name is the class name, which is then replaced by the constructor
   name CTOR_NAME). Looks for an overload with a compatible type, then again
   after adding the this parameter, then (for a DDVT class, function flag 0x40 changed
   to 1) for a dynamically dispatched one. The member's type is replaced by the new one
   (merging defaults). When none matches, MSG_NOT_MEMBER is reported and a new member
   function symbol is declared anyway (DECLARE_FUNCTION), so parsing can go on. Uses
   symbol record 0's type word as the search sentinel. */
unsigned int far pascal TYPE_BUILD(unsigned int scope,unsigned int type,unsigned int name,unsigned int kind)
{
    unsigned int previous, result, member;
    unsigned char flag;
    _DI = scope;
    _SI = type;
    result = LOOKUP_NAME(name);
    if (result && (AT_B(SYMBOL_POOL_SEG,result+7) >> 3) == 11 && AT_W(SYMBOL_POOL_SEG,result+4) == _DI) {
        kind = 3;
        name = CTOR_NAME;
    }
    member = FIND_MEMBER_BY_NAME(name,_DI);
    result = 0;
    if (!member) {
missing:
        REPORT_DIAGNOSTIC(MSG_NOT_MEMBER,FORMAT_MEMBER_NAME(name,kind,_SI,_DI),FORMAT_TYPE(_DI));
        goto finish;
    }
    if ((AT_B(MEMBER_SEGMENT,member+4) & 3) == 3) {
        result = AT_W(MEMBER_SEGMENT,member+6);
        AT_W(SYMBOL_POOL_SEG,SYM_TYPE) = _SI;
        while (!TYPES_COMPATIBLE(_SI,AT_W(SYMBOL_POOL_SEG,result+4),1))
            result = AT_W(SYMBOL_POOL_SEG,result+19);
        if (!result) {
            ADD_THIS_PARAMETER(_DI,_SI);
            result = AT_W(MEMBER_SEGMENT,member+6);
            AT_W(SYMBOL_POOL_SEG,SYM_TYPE) = _SI;
            while (!TYPES_COMPATIBLE(_SI,AT_W(SYMBOL_POOL_SEG,result+4),1))
                result = AT_W(SYMBOL_POOL_SEG,result+19);
        }
        if (!result && (AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,_DI+5)+24) & 0x800) &&
                       (AT_B(TYPE_POOL,_SI+12) & 0x40)) {
            AT_B(TYPE_POOL,_SI+12) &= 0xBF;
            AT_B(TYPE_POOL,_SI+12) |= 1;
            result = AT_W(MEMBER_SEGMENT,member+6);
            AT_W(SYMBOL_POOL_SEG,SYM_TYPE) = _SI;
            while (!TYPES_COMPATIBLE(_SI,AT_W(SYMBOL_POOL_SEG,result+4),1))
                result = AT_W(SYMBOL_POOL_SEG,result+19);
            if (result && !(AT_W(SYMBOL_POOL_SEG,result+10) & 0x100)) { result = 0; _AX = _AX; }
        }
    } else result = 0;
    if (!result) goto missing;
    if (AT_W(SYMBOL_POOL_SEG,result+4) != _SI) {
        previous = AT_W(SYMBOL_POOL_SEG,result+4);
        AT_W(SYMBOL_POOL_SEG,result+4) = _SI;
        BCC_TYPE_LINK(_SI,previous);
    }
finish:
    if (!result) {
        DECLARE_FUNCTION(_SI,name,kind,0x36,&result,&flag);
        AT_W(SYMBOL_POOL_SEG,result) = AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,_DI+5)+6);
        AT_B(SYMBOL_POOL_SEG,result+6) |= 0x10;
        AT_W(SYMBOL_POOL_SEG,result+10) |= 1;
    }
    return result;
}

/* ---- TNORM (listing ovr_1cce_8758:82D2) ---- */
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern void far pascal ADD_HIDDEN_PARAMETER(unsigned int, unsigned int);

/* BCC_TYPE_NORMALIZE: prepares the type node of member function owner of class
   current before its definition: sets CURRENT_CLASS_TYPE, recognizes a constructor (a
   name equal to the class name; *kind becomes 3), gives constructors a result type of
   pointer to the class (they return this) and the hidden virtual-base flag (0x73) when
   the class has virtual bases, and destructors a void result and the hidden flags
   parameter (0x69). flag 0 (probably: a return type was written) is an error for
   both. */
void far pascal BCC_TYPE_NORMALIZE(unsigned int current, unsigned int node, unsigned int owner, unsigned int far *kind, unsigned char flag)
{
    register unsigned int outer;
    CURRENT_CLASS_TYPE = current;
    if (*kind == 0) {
      outer = LOOKUP_NAME(owner);
      if (outer != 0 &&
        (*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, outer + SYM_STORAGE_CLASS) >> 3) == 11 &&
        *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG, outer + SYM_TYPE) == CURRENT_CLASS_TYPE)
        *kind = 3;
    }
    if (*kind == 3) {
        if (*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
             *(unsigned int far *)MK_FP(TYPE_POOL, current + TYPE_TAG_BODY) + 24) & 4)
            ADD_HIDDEN_PARAMETER(node, 0x73);
        if (!flag)
            REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, owner);
        *(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TARGET) = MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE, 0, 0);
    } else if (*kind == 4) {
        if (!flag)
            REPORT_NAME_DIAGNOSTIC(MSG_DESTRUCTOR_CANNOT_HAVE, owner);
        *(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TARGET) = VOID_TYPE;
        ADD_HIDDEN_PARAMETER(node, 0x69);
    }
}
