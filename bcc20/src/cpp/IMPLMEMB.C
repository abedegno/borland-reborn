/* target: ovr068_C12CHECK */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ classes: declares the implicit special members (default and copy constructor,
   assignment, destructor) at class end; checks const/reference members and pure functions.
   Entry points: DECLARE_IMPLICIT_MEMBERS. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: runs once when the closing brace of a class body has been read
   (DECLARE_IMPLICIT_MEMBERS, called from parser/DECLSPEC.C). STRUCT_BODY_TYPE is the
   class. It
   - works out the class's summary bits from its bases and members: TYPE_ATTRS 4 (needs
     a constructor), 8 (has a destructor), 0x10 (has operator=), and the class flags
     (TAG_CLASS_FLAGS: 1 and 0x40 not a plain C struct, probably; 2 no bases or one
     non-virtual base that has flag 2 itself, the layouts where old-style constructors
     may assign to this; 4 virtual bases; 0x80 has pure virtual functions; 8 far,
     0x100 huge and 0x10 near class, passed on from bases and members; 0x400 a virtual
     destructor or operator=; 0x800 dynamically dispatched functions);
   - sets the class size (TAG_SIZE with the virtual bases, TAG_OWN_SIZE without; an
     empty class without a vtable gets size 2);
   - declares the special members the programmer did not write: operator=, the
     default constructor, the copy constructor and the destructor (C12SPECIAL). They are
     inline kind 2: their bodies are made later by C13INITIALIZE in CPPFINAL.C when
     they are needed;
   - creates the virtual table symbol of a class that needs one (C12HIDDEN);
   - checks that pure virtual functions of abstract bases are overridden;
   - finally compiles (checks) the recorded inline member function bodies, now that
     the class is complete (C12FINISH).
   CLASS_VTABLE_SIZE and TYPE_SIZE_LOW are the vtable size and the data size collected
   while the class body was parsed (CLASSDEF.C, CLSMEMB.C). */
#include <dos.h>
#include "IMPLMEMB.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"

/* IMPLMEMB: for an implicit default constructor: a base (member 0) or data member of
   class type with constructors must have an accessible default constructor
   (MSG_CANNOT_FIND_INITIALIZE / _224, or message 0xB6, probably "not accessible").
   Returns 0 when not. Arrays are checked by their element type. The function carries
   the file's name. */
static unsigned char near pascal IMPLMEMB(register unsigned int type,
    unsigned int member)
{
    register unsigned int symbol;

    if(!(TYPE_B(type,TYPE_ATTRS)&4))
        return 1;
    while(TYPE_W(type,TYPE_KIND)==TK_ARRAY)
        type=TYPE_W(type,TYPE_TARGET);
    symbol=FIND_DEFAULT_CTOR(type,0);
    if(!symbol) {
        REPORT_DIAGNOSTIC(member==0?MSG_CANNOT_FIND_INITIALIZE:MSG_CANNOT_FIND_INITIALIZE_224,
                FORMAT_SPECIAL_MEMBER(5,0,type),MEMBER_NAME_TEXT(member));
        return 0;
    }
    if(!SYMBOL_ACCESSIBLE(symbol,STRUCT_BODY_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6,(long)FORMAT_SYMBOL(symbol),0L);
        return 0;
    }
    return 1;
}


/* C12SCAN: checks all bases and data members for an implicit default constructor
   (IMPLMEMB); reference and const data members cannot be default initialized
   (MSG_REFERENCE_MEMBER_NOT, MSG_CONSTANT_MEMBER_NOT). Returns 1 when all is well; the
   caller declares the constructor anyway. */
static unsigned char near pascal C12SCAN(void)
{
    unsigned char valid=1;
    register unsigned int parameter;
    register unsigned int member;

    parameter=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_BASES);
    while(parameter) {
        valid=valid&IMPLMEMB(BASE_W(parameter,BASE_TYPE),0);
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    member=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if((MEMBER_B(member,MEMB_FLAGS)&3)==0) {
            valid=valid&IMPLMEMB(MEMBER_W(member,MEMB_TYPE),member);
            if((EXPR_FLAGS[TYPE_W(MEMBER_W(member,MEMB_TYPE),TYPE_KIND)]&0x14) &&
                    (TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&0x20)) {
                REPORT_NAME_DIAGNOSTIC(MSG_REFERENCE_MEMBER_NOT,MEMBER_W(member,MEMB_NAME));
                valid=0;
            }
            if(TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&1) {
                REPORT_NAME_DIAGNOSTIC(MSG_CONSTANT_MEMBER_NOT,MEMBER_W(member,MEMB_NAME));
                valid=0;
            }
        }
        member=MEMBER_W(member,MEMB_NEXT);
    }
    return valid;
}

/* C12CHECK8: for an implicit destructor: the destructor of a base or member of class
   type with a destructor (TYPE_ATTRS 8) must be accessible. Returns 0 when not. */
static unsigned char near pascal C12CHECK8(register unsigned int type)
{
    register unsigned int member;

    if(!(TYPE_B(type,TYPE_ATTRS)&8))
        return 1;
    while(TYPE_W(type,TYPE_KIND)==TK_ARRAY)
        type=TYPE_W(type,TYPE_TARGET);
    member=FIND_MEMBER_BY_NAME(DTOR_NAME,type);
    if(!member)
        return 1;
    if(!MEMBER_ACCESSIBLE(member,STRUCT_BODY_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6,(long)FORMAT_SYMBOL(MEMBER_W(member,MEMB_VALUE)),0L);
        return 0;
    }
    return 1;
}

/* C12SCAN8: C12CHECK8 over all bases and data members; 1 when the implicit
   destructor can be declared. */
static unsigned char near pascal C12SCAN8(void)
{
    unsigned char valid=1;
    register unsigned int parameter;
    register unsigned int member;

    parameter=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_BASES);
    while(parameter) {
        valid=valid&C12CHECK8(BASE_W(parameter,BASE_TYPE));
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    member=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if((MEMBER_B(member,MEMB_FLAGS)&3)==0)
            valid=valid&C12CHECK8(MEMBER_W(member,MEMB_TYPE));
        member=MEMBER_W(member,MEMB_NEXT);
    }
    return valid;
}


/* 028A: create and link an implicit special member. */
/* C12SPECIAL: declares an implicit special member: a function named TOKEN_NAMES[kind]
   (5 constructor, 6 destructor, 11 operator=) returning result with parameter list
   argument, public, inline kind 2, with SYM_SPECIAL_KIND mode (0 assignment, 1 copy
   constructor, 2 default constructor, 3 destructor) and owned by ACTIVE_LIST (the class
   tag symbol). It is put in front of the member's overload chain (the member record is
   created if needed). Returns the symbol. */
static unsigned int near pascal C12SPECIAL(unsigned int kind,
    unsigned int mode,unsigned int result,unsigned int argument)
{
    unsigned int type;
    register unsigned int symbol;
    register unsigned int member;

    type=CREATE_TYPE(0x12);
    TYPE_W(type,TYPE_TARGET)=result;
    TYPE_W(type,TYPE_PARAMS)=argument;
    TYPE_B(type,TYPE_FUNC_FLAGS)=MODEL_FAR_CODE?1:0x40;
    TYPE_B(type,TYPE_CALL_CONV)=1;
    symbol=ALLOC_SYMBOL_ENTRY(TOKEN_NAMES[kind],6);
    SET_FUNCTION_SYMBOL_TYPE(symbol,0,type,0x35);
    if(kind==6)
        SYM_W(symbol,SYM_FUNC_KIND)=4;
    else if(kind==5)
        SYM_W(symbol,SYM_FUNC_KIND)=3;
    else
        SYM_W(symbol,SYM_FUNC_KIND)=1;
    SYM_W(symbol,SYM_NEXT_OVERLOAD)=0;
    SYM_B(symbol,SYM_INLINE_ACCESS)=SYM_B(symbol,SYM_INLINE_ACCESS)&0xE3;
    SYM_B(symbol,SYM_INLINE_ACCESS)=(SYM_B(symbol,SYM_INLINE_ACCESS)&0xFC)|2;
    SYM_B(symbol,SYM_FLAGS)|=0x33;
    SYM_W(symbol,SYM_FUNC_FLAGS)=5;
    SYM_W(symbol,SYM_OWNER_CLASS)=ACTIVE_LIST;
    SYM_W(symbol,SYM_SPECIAL_KIND)=mode;
    SYM_W(symbol,SYM_VIRTUAL_INDEX)=0;
    member=FIND_MEMBER_BY_NAME(TOKEN_NAMES[kind],STRUCT_BODY_TYPE);
    if(!member)
        member=DECLARE_MEMBER(TOKEN_NAMES[kind],3);
    else
        SYM_W(MEMBER_W(member,MEMB_VALUE),SYM_FUNC_FLAGS)|=1;
    SYM_W(symbol,SYM_NEXT_OVERLOAD)=MEMBER_W(member,MEMB_VALUE);
    MEMBER_W(member,MEMB_VALUE)=symbol;
    return symbol;
}

/* 03C3 */
/* C12COPY: declares X& operator=(X&) (the parameter const and/or volatile by valid,
   from COPY_PARAM_QUALIFIERS of the bases and members); TYPE_OFFSET_FAR gives it a
   virtual slot when a base's operator= is virtual (probably). */
static void near pascal C12COPY(unsigned int valid)
{
    unsigned int argument;
    register unsigned int symbol;

    argument=CREATE_PARAM_RECORD(STRUCT_BODY_TYPE,valid,0x68);
    symbol=C12SPECIAL(11,0,MAKE_POINTER_TYPE(STRUCT_BODY_TYPE,0,1),argument);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE,SYM_W(symbol,SYM_TYPE));
    SYM_W(symbol,SYM_VIRTUAL_INDEX)=TYPE_OFFSET_FAR(0,symbol);
}

/* 0424 */
/* C12CONSTRUCT: declares the copy constructor X(X&) (qualified by valid), with the
   hidden virtual-base flag when the class has virtual bases (inherited). Constructors
   return X *. */
static void near pascal C12CONSTRUCT(unsigned char inherited,unsigned int valid)
{
    unsigned int argument;
    register unsigned int symbol;

    argument=CREATE_PARAM_RECORD(STRUCT_BODY_TYPE,valid,0x68);
    symbol=C12SPECIAL(5,1,MAKE_POINTER_TYPE(STRUCT_BODY_TYPE,0,0),argument);
    if(inherited)
        ADD_HIDDEN_PARAMETER(SYM_W(symbol,SYM_TYPE),0x73);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE,SYM_W(symbol,SYM_TYPE));
}

/* 048E */
/* C12DEFAULT: declares the default constructor X(), with the hidden virtual-base flag
   when the class has virtual bases. */
static void near pascal C12DEFAULT(unsigned char inherited)
{
    register unsigned int symbol;

    symbol=C12SPECIAL(5,2,MAKE_POINTER_TYPE(STRUCT_BODY_TYPE,0,0),0);
    if(inherited)
        ADD_HIDDEN_PARAMETER(SYM_W(symbol,SYM_TYPE),0x73);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE,SYM_W(symbol,SYM_TYPE));
}

/* 04E1 */
/* C12DESTROY: declares the destructor ~X() with its hidden flags parameter; it may get
   a virtual slot (TYPE_OFFSET_FAR), and the class's TAG_VTABLE_SIZE is updated from
   CLASS_VTABLE_SIZE in case that added one. */
static void near pascal C12DESTROY(void)
{
    register unsigned int symbol;

    symbol=C12SPECIAL(6,3,VOID_TYPE,0);
    ADD_HIDDEN_PARAMETER(SYM_W(symbol,SYM_TYPE),0x69);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE,SYM_W(symbol,SYM_TYPE));
    SYM_W(symbol,SYM_VIRTUAL_INDEX)=TYPE_OFFSET_FAR(0,symbol);
    TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_VTABLE_SIZE)=CLASS_VTABLE_SIZE;
}

/* 0548 */
/* C12HIDDEN: creates the class's virtual table symbol: an unnamed static member of
   type char[] (its size is filled in when the table is emitted), far when OPTION_FLAG
   is set or the class is huge (class flag 0x100), with storage class 1 or 2 by the virtual table mode
   (CPU_IS_286, CPU_LEVEL_1_FLAG; see CPPFINAL.C). Stored as TAG_VTABLE_SYMBOL, given a
   segment, and the class is queued on VTABLE_CLASS_LIST for CPPFINAL.C. */
static void near pascal C12HIDDEN(void)
{
    unsigned int type;
    unsigned int expression;
    register unsigned int symbol;
    register unsigned int member;

    type=CREATE_TYPE(0x11);
    TYPE_W(type,TYPE_TARGET)=CHAR_TYPE;
    TYPE_W(type,TYPE_CALL_CONV)=0;
    TYPE_W(type,TYPE_PARAMS)=1;
    symbol=CREATE_TEMP_SYMBOL(type,0);
    SYM_W(symbol,SYM_NAME)=BCC_SYMBOL_CREATE((char far *)STR_EMPTY_2,0);
    SYM_W(symbol,SYM_OWNER_CLASS)=ACTIVE_LIST;
    SYM_B(symbol,SYM_FLAGS)|=0x10;
    if(OPTION_FLAG || (TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100))
        SYM_B(symbol,SYM_FLAGS)|=0x80;
    if(CPU_IS_286)
        SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|8;
    else if(CPU_LEVEL_1_FLAG)
        SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x10;
    member=DECLARE_MEMBER(0,2);
    MEMBER_W(member,MEMB_VALUE)=symbol;
    MEMBER_B(member,MEMB_FLAGS)|=0x80;
    TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_VTABLE_SYMBOL)=symbol;
    expression=PREPARE_SYMBOL(symbol);
    if(VTABLE_MODE==3) {
        SET_PREPARED_FLAGS(expression,0x100);
        SET_SYMBOL_SEGMENT_HOOK(expression,0xFFFF);
    } else
        SET_SYMBOL_SEGMENT_HOOK(expression,(SYM_B(symbol,SYM_FLAGS)&0x80)?CODE_SEGMENT_ID:DATA_SEGMENT_ID);
    VTABLE_CLASS_LIST=LIST_CONS(VTABLE_CLASS_LIST,ACTIVE_LIST);
}

/* 0681 */
/* C12FINISH: compiles, without generating code, every member function of the class
   whose body was recorded (inline kind 1), then the bodies waiting on
   INLINE_BODY_QUEUE. */
static void near pascal C12FINISH(void)
{
    unsigned int old;
    register unsigned int member;
    register unsigned int symbol;

    member=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if((MEMBER_B(member,MEMB_FLAGS)&3)==3) {
            symbol=MEMBER_W(member,MEMB_VALUE);
            while(symbol) {
                if((SYM_B(symbol,SYM_INLINE_ACCESS)&3)==1)
                    COMPILE_INLINE_BODY(symbol,0);
                symbol=SYM_W(symbol,SYM_NEXT_OVERLOAD);
            }
        }
        member=MEMBER_W(member,MEMB_NEXT);
    }
    while(INLINE_BODY_QUEUE) {
        COMPILE_INLINE_BODY(CONS_W(INLINE_BODY_QUEUE,CONS_VALUE),0);
        old=INLINE_BODY_QUEUE;
        INLINE_BODY_QUEUE=CONS_W(INLINE_BODY_QUEUE,CONS_NEXT);
        LIST_CELL_FREE(old);
    }
}

/* 0729: the zero entry supplies the terminating signature sentinel. */
/* C12INHERITED: base type is abstract (class flag 0x80): each of its pure virtual
   functions (SYM_FUNC_FLAGS 0x20) must have a function of the same name and signature
   in STRUCT_BODY_TYPE, else MSG_PURE_FUNCTION_NOT. */
static void near pascal C12INHERITED(unsigned int type)
{
    unsigned int peer;
    unsigned int signature;
    unsigned int found;
    register unsigned int member;
    register unsigned int symbol;

    for(member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);member;member=MEMBER_W(member,MEMB_NEXT)) {
        peer=0;
        if((MEMBER_B(member,MEMB_FLAGS)&3)!=3) continue;
        symbol=MEMBER_W(member,MEMB_VALUE);
        while(symbol) {
            signature=SYM_W(symbol,SYM_TYPE);
            if(SYM_W(symbol,SYM_FUNC_FLAGS)&0x20) {
                if(!peer)
                    peer=FIND_MEMBER_BY_NAME(MEMBER_W(member,MEMB_NAME),STRUCT_BODY_TYPE);
                SYM_W(0,SYM_TYPE)=signature;
                for(found=MEMBER_W(peer,MEMB_VALUE);
                    !SAME_SIGNATURE(signature,SYM_W(found,SYM_TYPE));
                    found=SYM_W(found,SYM_NEXT_OVERLOAD))
                    ;
                if(!found)
                    REPORT_DIAGNOSTIC(MSG_PURE_FUNCTION_NOT,(long)FORMAT_SYMBOL(symbol),
                        FORMAT_TYPE(STRUCT_BODY_TYPE));
            }
            symbol=SYM_W(symbol,SYM_NEXT_OVERLOAD);
        }
    }
}

/* 0821: the segment's sole overlay export. */
/* DECLARE_IMPLICIT_MEMBERS: the end-of-class processing described in the overview.
   The local "hidden" means the class needs a virtual table; valid and valid8 collect
   the cv qualifiers the implicit copy constructor and operator= may take their
   argument by. Calls C0MARK, probably so the records made for the class survive the
   closing of any enclosing block scope. */
void far pascal DECLARE_IMPLICIT_MEMBERS(void)
{
    unsigned int saved;
    unsigned int member;
    unsigned int parameter;
    unsigned int oldparameter;
    unsigned int bases;
    unsigned int type;
    unsigned int size;
    unsigned int ownsize;
    unsigned char hidden;
    unsigned char simple;
    unsigned int attributes;
    unsigned int valid;
    unsigned int valid8;
    unsigned int fieldtype;
    register unsigned int flags;
    register unsigned int owner;

    owner=STRUCT_BODY_TYPE;
    flags=TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_CLASS_FLAGS);
    attributes=TYPE_B(owner,TYPE_ATTRS);
    hidden=CLASS_VTABLE_SIZE>0 || (flags&0xC00);
    valid=1;
    valid8=1;
    if(hidden) {
        attributes|=0x14;
        flags|=0x41;
    }
    size=ownsize=TYPE_SIZE_LOW;
    /* Virtual bases are laid out after the class's own part. */
    bases=COLLECT_VBASES(owner);
    if(bases) {
        attributes|=0x14;
        flags|=0x45;
    }
    while(bases) {
        size=size+TAG_W(TYPE_W(BASE_W(bases,BASE_TYPE),TYPE_TAG_BODY),TAG_OWN_SIZE);
        if(TAG_W(TYPE_W(BASE_W(bases,BASE_TYPE),TYPE_TAG_BODY),TAG_VTABLE_SIZE)>0)
            hidden=1;
        oldparameter=bases;
        bases=BASE_W(bases,BASE_NEXT);
        FREE_PARAM_ITEM(oldparameter);
    }
    if(!(int)hidden && size==0) {
        size=2;
        ownsize=size;
    }
    /* Direct bases: inherit attributes and model flags; copy qualifiers needed. */
    parameter=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_BASES);
    simple=BASE_W(parameter,BASE_NEXT)==0 && !(flags&4);
    while(parameter) {
        type=BASE_W(parameter,BASE_TYPE);
        if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x80)
            C12INHERITED(type);
        attributes|=TYPE_B(type,TYPE_ATTRS)&0x1C;
        flags|=0x41|(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x118);
        simple=simple && (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&2);
        if(TYPE_B(type,TYPE_ATTRS)&4)
            valid&=COPY_PARAM_QUALIFIERS(5,type);
        if(TYPE_B(type,TYPE_ATTRS)&0x10)
            valid8&=COPY_PARAM_QUALIFIERS(11,type);
        parameter=BASE_W(parameter,BASE_NEXT);
    }
    /* Members: access other than public, statics and functions make it a C++ class;
     user constructors, destructors and operator= set the attribute bits. */
    for(member=TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_MEMBERS);member;member=MEMBER_W(member,MEMB_NEXT)) {
        if(((int)MEMBER_B(member,MEMB_FLAGS)>>2)&7)
            flags|=0x41;
        if((MEMBER_B(member,MEMB_FLAGS)&3)==2)
            flags|=1;
        if((MEMBER_B(member,MEMB_FLAGS)&3)==3) {
            unsigned int symbol;
            symbol=MEMBER_W(member,MEMB_VALUE);
            flags|=1;
            switch(SYM_W(symbol,SYM_FUNC_KIND)) {
            case 3:
                attributes|=4;
                break;
            case 4:
                attributes|=8;
                if(SYM_W(symbol,SYM_VIRTUAL_INDEX)>0)
                    flags|=0x400;
                break;
            case 1:
                if(MEMBER_W(member,MEMB_NAME)==TOKEN_NAMES[TOK_ASSIGN]) {
                    attributes|=0x10;
                    if(SYM_W(symbol,SYM_VIRTUAL_INDEX)>0)
                        flags|=0x400;
                }
                break;
            }
        } else if((MEMBER_B(member,MEMB_FLAGS)&3)==0 && MEMBER_W(member,MEMB_TYPE)!=0) {
            fieldtype=MEMBER_W(member,MEMB_TYPE);
            attributes|=TYPE_B(fieldtype,TYPE_ATTRS)&0x1C;
            if(((EXPR_FLAGS[TYPE_W(fieldtype,TYPE_KIND)]&0x14) &&
                (TYPE_B(fieldtype,TYPE_ATTRS)&0x20)) ||
                ((flags&1) && (TYPE_B(fieldtype,TYPE_ATTRS)&1))) {
                attributes|=4;
                flags|=0x41;
            }
            if(EXPR_FLAGS[TYPE_W(fieldtype,TYPE_KIND)]&0x40)
                flags|=TAG_W(TYPE_W(fieldtype,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x159;
            if(TYPE_B(fieldtype,TYPE_ATTRS)&4)
                valid&=COPY_PARAM_QUALIFIERS(5,fieldtype);
            if(TYPE_B(fieldtype,TYPE_ATTRS)&0x10)
                valid8&=COPY_PARAM_QUALIFIERS(11,fieldtype);
        }
    }
    /* Declare whatever special members the class needs but does not have. */
    SCOPE_STATE=0;
    saved=CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE=owner;
    if(hidden)
        C12HIDDEN();
    if((attributes&0x10) && !FIND_MEMBER_BY_NAME(TOKEN_NAMES[TOK_ASSIGN],owner))
        C12COPY(valid8);
    if(attributes&4) {
        if(!FIND_MEMBER_BY_NAME(CTOR_NAME,owner)) {
            C12SCAN();
            C12DEFAULT((flags&4)!=0);
        }
        if(!FIND_COPY_CTOR(owner,0))
            C12CONSTRUCT((flags&4)!=0,valid);
    }
    if((attributes&8) && !FIND_MEMBER_BY_NAME(DTOR_NAME,owner)) {
        if(C12SCAN8())
            C12DESTROY();
    }
    if(simple)
        flags|=2;
    TYPE_B(owner,TYPE_ATTRS)=attributes;
    TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_CLASS_FLAGS)=flags;
    TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_OWN_SIZE)=ownsize;
    TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_SIZE)=size;
    C0MARK(1);
    CURRENT_CLASS_TYPE=saved;
    C12FINISH();
}
