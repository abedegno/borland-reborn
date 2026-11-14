/* implmemb.c: from bcc20/src/cpp/IMPLMEMB.C: runs once when the closing brace of a class
   body has been read (DECLARE_IMPLICIT_MEMBERS, called from DECLSPEC.C); STRUCT_BODY_TYPE
   is the class.  It works out the class's summary bits from its bases and members
   (TYPE_ATTRS 4 needs a constructor, 8 has a destructor, 10h has operator=; class flags 1
   and 40h not a plain C struct, 2 the layouts where old-style constructors may assign to
   this, 4 virtual bases, 80h pure virtual functions, 8/100h/10h far, huge, near class, 400h
   a virtual destructor or operator=, 800h dynamically dispatched functions); sets the
   class size (TAG_SIZE with the virtual bases, TAG_OWN_SIZE without; an empty class without
   a vtable gets size 2); declares the special members the programmer did not write
   (operator=, the default and copy constructors, the destructor; inline kind 2, their
   bodies made later by CPPFINAL.C); creates the virtual table symbol of a class that needs
   one; checks that pure virtual functions of abstract bases are overridden; and finally
   checks the recorded inline member function bodies, now that the class is complete. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define TYPE_SIZE_LOW W(TYPE_SIZE_LOW_P)

/* for an implicit default constructor: a base (member 0) or data member of class type with
   constructors must have an accessible default constructor.  0 when not.  Arrays are
   checked by their element type */
u8 IMPLMEMB(u16 type, u16 member)
{
    if (!(TYPE_B(type, TYPE_ATTRS) & 4))
        return 1;
    while (TYPE_W(type, TYPE_KIND) == TK_ARRAY)
        type = TYPE_W(type, TYPE_TARGET);
    u16 symbol = FIND_DEFAULT_CTOR(type, 0);
    if (!symbol) {
        i32 constructor = FORMAT_SPECIAL_MEMBER(5, 0, type);   /* pascal: left to right */
        farptr name = MEMBER_NAME_TEXT(member);
        REPORT_DIAGNOSTIC(member == 0 ? MSG_CANNOT_FIND_INITIALIZE : MSG_CANNOT_FIND_INITIALIZE_224, constructor, (i32)name);
        return 0;
    }
    if (!SYMBOL_ACCESSIBLE(symbol, STRUCT_BODY_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6, (i32)FORMAT_SYMBOL(symbol), 0);
        return 0;
    }
    return 1;
}

/* all bases and data members checked for an implicit default constructor; reference and
   const data members cannot be default initialised.  1 when all is well */
u8 C12SCAN(void)
{
    u8 valid = 1;
    for (u16 parameter = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_BASES); parameter; parameter = BASE_W(parameter, BASE_NEXT))
        valid = valid & IMPLMEMB(BASE_W(parameter, BASE_TYPE), 0);
    for (u16 member = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0) {
            valid = valid & IMPLMEMB(MEMBER_W(member, MEMB_TYPE), member);
            if ((EXPR_FLAGS_AT(TYPE_W(MEMBER_W(member, MEMB_TYPE), TYPE_KIND)) & 0x14) && (TYPE_B(MEMBER_W(member, MEMB_TYPE), TYPE_ATTRS) & 0x20)) {
                REPORT_NAME_DIAGNOSTIC(MSG_REFERENCE_MEMBER_NOT, MEMBER_W(member, MEMB_NAME));
                valid = 0;
            }
            if (TYPE_B(MEMBER_W(member, MEMB_TYPE), TYPE_ATTRS) & 1) {
                REPORT_NAME_DIAGNOSTIC(MSG_CONSTANT_MEMBER_NOT, MEMBER_W(member, MEMB_NAME));
                valid = 0;
            }
        }
    }
    return valid;
}

/* for an implicit destructor: the destructor of a base or member of class type with a
   destructor must be accessible.  0 when not */
u8 C12CHECK8(u16 type)
{
    if (!(TYPE_B(type, TYPE_ATTRS) & 8))
        return 1;
    while (TYPE_W(type, TYPE_KIND) == TK_ARRAY)
        type = TYPE_W(type, TYPE_TARGET);
    u16 member = FIND_MEMBER_BY_NAME(DTOR_NAME, type);
    if (!member)
        return 1;
    if (!MEMBER_ACCESSIBLE(member, STRUCT_BODY_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6, (i32)FORMAT_SYMBOL(MEMBER_W(member, MEMB_VALUE)), 0);
        return 0;
    }
    return 1;
}

/* C12CHECK8 over all bases and data members; 1 when the implicit destructor can be
   declared */
u8 C12SCAN8(void)
{
    u8 valid = 1;
    for (u16 parameter = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_BASES); parameter; parameter = BASE_W(parameter, BASE_NEXT))
        valid = valid & C12CHECK8(BASE_W(parameter, BASE_TYPE));
    for (u16 member = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT))
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0)
            valid = valid & C12CHECK8(MEMBER_W(member, MEMB_TYPE));
    return valid;
}

/* declares an implicit special member: a function named TOKEN_NAMES[kind] (5 constructor,
   6 destructor, 11 operator=) returning result with parameter list argument, public,
   inline kind 2, with SYM_SPECIAL_KIND mode (0 assignment, 1 copy constructor, 2 default
   constructor, 3 destructor) and owned by ACTIVE_LIST.  It goes in front of the member's
   overload chain (the member record is created if needed).  Returns the symbol */
u16 C12SPECIAL(u16 kind, u16 mode, u16 result, u16 argument)
{
    u16 type = CREATE_TYPE(0x12);
    TYPE_W(type, TYPE_TARGET) = result;
    TYPE_W(type, TYPE_PARAMS) = argument;
    TYPE_B(type, TYPE_FUNC_FLAGS) = MODEL_FAR_CODE ? 1 : 0x40;
    TYPE_B(type, TYPE_CALL_CONV) = 1;
    u16 symbol = ALLOC_SYMBOL_ENTRY(TOKEN_NAMES_AT(kind), 6);
    SET_FUNCTION_SYMBOL_TYPE(symbol, 0, type, 0x35);
    if (kind == 6)
        SYM_W(symbol, SYM_FUNC_KIND) = 4;
    else if (kind == 5)
        SYM_W(symbol, SYM_FUNC_KIND) = 3;
    else
        SYM_W(symbol, SYM_FUNC_KIND) = 1;
    SYM_W(symbol, SYM_NEXT_OVERLOAD) = 0;
    SYM_B(symbol, SYM_INLINE_ACCESS) = SYM_B(symbol, SYM_INLINE_ACCESS) & 0xE3;
    SYM_B(symbol, SYM_INLINE_ACCESS) = (SYM_B(symbol, SYM_INLINE_ACCESS) & 0xFC) | 2;
    SYM_B(symbol, SYM_FLAGS) |= 0x33;
    SYM_W(symbol, SYM_FUNC_FLAGS) = 5;
    SYM_W(symbol, SYM_OWNER_CLASS) = ACTIVE_LIST;
    SYM_W(symbol, SYM_SPECIAL_KIND) = mode;
    SYM_W(symbol, SYM_VIRTUAL_INDEX) = 0;
    u16 member = FIND_MEMBER_BY_NAME(TOKEN_NAMES_AT(kind), STRUCT_BODY_TYPE);
    if (!member)
        member = DECLARE_MEMBER(TOKEN_NAMES_AT(kind), 3);
    else
        SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_FUNC_FLAGS) |= 1;
    SYM_W(symbol, SYM_NEXT_OVERLOAD) = MEMBER_W(member, MEMB_VALUE);
    MEMBER_W(member, MEMB_VALUE) = symbol;
    return symbol;
}

/* X& operator=(X&) (the parameter qualified by valid); TYPE_OFFSET gives it a virtual slot
   when a base's operator= is virtual */
void C12COPY(u16 valid)
{
    u16 argument = CREATE_PARAM_RECORD(STRUCT_BODY_TYPE, valid, 0x68);
    u16 symbol = C12SPECIAL(11, 0, MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 1), argument);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, SYM_W(symbol, SYM_TYPE));
    u16 index = TYPE_OFFSET(0, symbol);
    SYM_W(symbol, SYM_VIRTUAL_INDEX) = index;
}

/* the copy constructor X(X&) (qualified by valid), with the hidden virtual-base flag when
   the class has virtual bases (inherited).  Constructors return X * */
void C12CONSTRUCT(u8 inherited, u16 valid)
{
    u16 argument = CREATE_PARAM_RECORD(STRUCT_BODY_TYPE, valid, 0x68);
    u16 symbol = C12SPECIAL(5, 1, MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 0), argument);
    if (inherited)
        ADD_HIDDEN_PARAMETER(SYM_W(symbol, SYM_TYPE), 0x73);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, SYM_W(symbol, SYM_TYPE));
}

/* the default constructor X(), with the hidden virtual-base flag when the class has
   virtual bases */
void C12DEFAULT(u8 inherited)
{
    u16 symbol = C12SPECIAL(5, 2, MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 0), 0);
    if (inherited)
        ADD_HIDDEN_PARAMETER(SYM_W(symbol, SYM_TYPE), 0x73);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, SYM_W(symbol, SYM_TYPE));
}

/* the destructor ~X() with its hidden flags parameter; it may get a virtual slot, and the
   class's TAG_VTABLE_SIZE follows CLASS_VTABLE_SIZE in case that added one */
void C12DESTROY(void)
{
    u16 symbol = C12SPECIAL(6, 3, VOID_TYPE, 0);
    ADD_HIDDEN_PARAMETER(SYM_W(symbol, SYM_TYPE), 0x69);
    ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, SYM_W(symbol, SYM_TYPE));
    u16 index = TYPE_OFFSET(0, symbol);
    SYM_W(symbol, SYM_VIRTUAL_INDEX) = index;
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_VTABLE_SIZE) = CLASS_VTABLE_SIZE;
}

/* the class's virtual table symbol: an unnamed static member of type char[] (its size
   filled in when the table is emitted), far when OPTION_FLAG is set or the class is huge,
   with storage class 1 or 2 by the virtual table mode.  Stored as TAG_VTABLE_SYMBOL, given
   a segment, and the class queued on VTABLE_CLASS_LIST for CPPFINAL.C */
void C12HIDDEN(void)
{
    u16 type = CREATE_TYPE(0x11);
    TYPE_W(type, TYPE_TARGET) = CHAR_TYPE;
    TYPE_W(type, TYPE_CALL_CONV) = 0;
    TYPE_W(type, TYPE_PARAMS) = 1;
    u16 symbol = CREATE_TEMP_SYMBOL(type, 0);
    u16 name = BCC_SYMBOL_CREATE(STR_EMPTY_2_P, 0);
    SYM_W(symbol, SYM_NAME) = name;
    SYM_W(symbol, SYM_OWNER_CLASS) = ACTIVE_LIST;
    SYM_B(symbol, SYM_FLAGS) |= 0x10;
    if (OPTION_FLAG || (TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x100))
        SYM_B(symbol, SYM_FLAGS) |= 0x80;
    if (CPU_IS_286)
        SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 8;
    else if (CPU_LEVEL_1_FLAG)
        SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x10;
    u16 member = DECLARE_MEMBER(0, 2);
    MEMBER_W(member, MEMB_VALUE) = symbol;
    MEMBER_B(member, MEMB_FLAGS) |= 0x80;
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_VTABLE_SYMBOL) = symbol;
    u16 expression = PREPARE_SYMBOL(symbol);
    if (VTABLE_MODE == 3) {
        SET_PREPARED_FLAGS(expression, 0x100);
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(expression), A16(0xFFFF));
    } else
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(expression), A16((SYM_B(symbol, SYM_FLAGS) & 0x80) ? CODE_SEGMENT_ID : DATA_SEGMENT_ID));
    VTABLE_CLASS_LIST = LIST_CONS(VTABLE_CLASS_LIST, ACTIVE_LIST);
}

/* compiles, without generating code, every member function of the class whose body was
   recorded (inline kind 1), then the bodies waiting on INLINE_BODY_QUEUE */
void C12FINISH(void)
{
    for (u16 member = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT))
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3)
            for (u16 symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD))
                if ((SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 1)
                    COMPILE_INLINE_BODY(symbol, 0);
    while (INLINE_BODY_QUEUE) {
        COMPILE_INLINE_BODY(CONS_W(INLINE_BODY_QUEUE, CONS_VALUE), 0);
        u16 old = INLINE_BODY_QUEUE;
        INLINE_BODY_QUEUE = CONS_W(INLINE_BODY_QUEUE, CONS_NEXT);
        LIST_CELL_FREE(old);
    }
}

/* base type is abstract (class flag 80h): each of its pure virtual functions (SYM_FUNC_FLAGS
   20h) must have a function of the same name and signature in STRUCT_BODY_TYPE.  The
   symbol record 0 ends the overload search */
void C12INHERITED(u16 type)
{
    for (u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        u16 peer = 0;
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) != 3)
            continue;
        for (u16 symbol = MEMBER_W(member, MEMB_VALUE); symbol; symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD)) {
            u16 signature = SYM_W(symbol, SYM_TYPE);
            if (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x20) {
                if (!peer)
                    peer = FIND_MEMBER_BY_NAME(MEMBER_W(member, MEMB_NAME), STRUCT_BODY_TYPE);
                SYM_W(0, SYM_TYPE) = signature;
                u16 found;
                for (found = MEMBER_W(peer, MEMB_VALUE); !SAME_SIGNATURE(signature, SYM_W(found, SYM_TYPE)); found = SYM_W(found, SYM_NEXT_OVERLOAD))
                    ;
                if (!found) {
                    farptr name = FORMAT_SYMBOL(symbol);    /* pascal: left to right */
                    i32 class_name = FORMAT_TYPE(STRUCT_BODY_TYPE);
                    REPORT_DIAGNOSTIC(MSG_PURE_FUNCTION_NOT, (i32)name, class_name);
                }
            }
        }
    }
}

/* the end-of-class processing (see the file comment).  hidden means the class needs a
   virtual table; valid and valid8 collect the cv qualifiers the implicit copy constructor
   and operator= may take their argument by */
void DECLARE_IMPLICIT_MEMBERS(void)
{
    u16 owner = STRUCT_BODY_TYPE;
    u16 flags = TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_CLASS_FLAGS);
    u16 attributes = TYPE_B(owner, TYPE_ATTRS);
    u8 hidden = (i16)CLASS_VTABLE_SIZE > 0 || (flags & 0xC00);
    u16 valid = 1, valid8 = 1;
    if (hidden) {
        attributes |= 0x14;
        flags |= 0x41;
    }
    u16 size = TYPE_SIZE_LOW, ownsize = size;
    /* virtual bases are laid out after the class's own part */
    u16 bases = COLLECT_VBASES(owner);
    if (bases) {
        attributes |= 0x14;
        flags |= 0x45;
    }
    while (bases) {
        size = size + TAG_W(TYPE_W(BASE_W(bases, BASE_TYPE), TYPE_TAG_BODY), TAG_OWN_SIZE);
        if ((i16)TAG_W(TYPE_W(BASE_W(bases, BASE_TYPE), TYPE_TAG_BODY), TAG_VTABLE_SIZE) > 0)
            hidden = 1;
        u16 oldparameter = bases;
        bases = BASE_W(bases, BASE_NEXT);
        FREE_PARAM_ITEM(oldparameter);
    }
    if (!hidden && size == 0) {
        size = 2;
        ownsize = size;
    }
    /* direct bases: attributes and model flags inherited; copy qualifiers needed */
    u16 parameter = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_BASES);
    u8 simple = BASE_W(parameter, BASE_NEXT) == 0 && !(flags & 4);
    for (; parameter; parameter = BASE_W(parameter, BASE_NEXT)) {
        u16 type = BASE_W(parameter, BASE_TYPE);
        if (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x80)
            C12INHERITED(type);
        attributes |= TYPE_B(type, TYPE_ATTRS) & 0x1C;
        flags |= 0x41 | (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x118);
        simple = simple && (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 2);
        if (TYPE_B(type, TYPE_ATTRS) & 4)
            valid &= COPY_PARAM_QUALIFIERS(5, type);
        if (TYPE_B(type, TYPE_ATTRS) & 0x10)
            valid8 &= COPY_PARAM_QUALIFIERS(11, type);
    }
    /* members: access other than public, statics and functions make it a C++ class; user
       constructors, destructors and operator= set the attribute bits */
    for (u16 member = TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) >> 2) & 7)
            flags |= 0x41;
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 2)
            flags |= 1;
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3) {
            u16 symbol = MEMBER_W(member, MEMB_VALUE);
            flags |= 1;
            switch (SYM_W(symbol, SYM_FUNC_KIND)) {
            case 3:
                attributes |= 4;
                break;
            case 4:
                attributes |= 8;
                if ((i16)SYM_W(symbol, SYM_VIRTUAL_INDEX) > 0)
                    flags |= 0x400;
                break;
            case 1:
                if (MEMBER_W(member, MEMB_NAME) == TOKEN_NAMES_AT(TOK_ASSIGN)) {
                    attributes |= 0x10;
                    if ((i16)SYM_W(symbol, SYM_VIRTUAL_INDEX) > 0)
                        flags |= 0x400;
                }
                break;
            }
        } else if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0 && MEMBER_W(member, MEMB_TYPE) != 0) {
            u16 fieldtype = MEMBER_W(member, MEMB_TYPE);
            attributes |= TYPE_B(fieldtype, TYPE_ATTRS) & 0x1C;
            if (((EXPR_FLAGS_AT(TYPE_W(fieldtype, TYPE_KIND)) & 0x14) && (TYPE_B(fieldtype, TYPE_ATTRS) & 0x20)) ||
                ((flags & 1) && (TYPE_B(fieldtype, TYPE_ATTRS) & 1))) {
                attributes |= 4;
                flags |= 0x41;
            }
            if (EXPR_FLAGS_AT(TYPE_W(fieldtype, TYPE_KIND)) & 0x40)
                flags |= TAG_W(TYPE_W(fieldtype, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x159;
            if (TYPE_B(fieldtype, TYPE_ATTRS) & 4)
                valid &= COPY_PARAM_QUALIFIERS(5, fieldtype);
            if (TYPE_B(fieldtype, TYPE_ATTRS) & 0x10)
                valid8 &= COPY_PARAM_QUALIFIERS(11, fieldtype);
        }
    }
    /* whatever special members the class needs but does not have */
    SCOPE_STATE = 0;
    u16 saved = CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE = owner;
    if (hidden)
        C12HIDDEN();
    if ((attributes & 0x10) && !FIND_MEMBER_BY_NAME(TOKEN_NAMES_AT(TOK_ASSIGN), owner))
        C12COPY(valid8);
    if (attributes & 4) {
        if (!FIND_MEMBER_BY_NAME(CTOR_NAME, owner)) {
            C12SCAN();
            C12DEFAULT((flags & 4) != 0);
        }
        if (!FIND_COPY_CTOR(owner, 0))
            C12CONSTRUCT((flags & 4) != 0, valid);
    }
    if ((attributes & 8) && !FIND_MEMBER_BY_NAME(DTOR_NAME, owner)) {
        if (C12SCAN8())
            C12DESTROY();
    }
    if (simple)
        flags |= 2;
    TYPE_B(owner, TYPE_ATTRS) = (u8)attributes;
    TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_CLASS_FLAGS) = flags;
    TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_OWN_SIZE) = ownsize;
    TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_SIZE) = size;
    C0MARK(1);
    CURRENT_CLASS_TYPE = saved;
    C12FINISH();
}
