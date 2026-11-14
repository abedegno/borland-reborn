/* cdeclr.c: from bcc20/src/parser/CDECLR.C: declarators in the C front end
   (COMPILE_C_SOURCE).  A declarator is parsed in two steps.  PARSE_DECLARATOR_TREE reads
   it into a small tree of DCLR nodes in DECLARATOR_NODE_POOL_SEG (kind 0 the name, 0Dh
   pointer, 11h array, 12h function), the outermost operator at the root, with the
   modifiers found next to each part (near, far, huge, _cs ... _seg, cdecl, pascal,
   interrupt, _loadds, _saveregs, _export, read by BCC_STMT_BEGIN).  BCC_STMT_BIND_TYPE
   then walks the tree from the root, applying each operator to the base type ("int *a[3]":
   array of 3, of pointer, to int), and frees the nodes.  The entry points differ in the
   name rule: BCC_STMT_DECL_NEW needs a name (level 1), PARSE_PARAM_DECLARATOR allows none
   (level 0), PARSE_ABSTRACT_DECLARATOR forbids one (level -1: type names).  The declared
   name is left in DECLARATOR_NAME with its line and file.

   The modifier triple (struct Flags: three signed bytes, calling convention, distance,
   mask) is passed by value as two words, its high word (third and a pad byte) first, as a
   pascal call pushes it (README, structure arguments); BCC_STMT_BEGIN returns it through a
   buffer whose address the caller passes, in the scratch area.  PARSE_DECLARATOR_TREE's
   "out of memory" stack check is STACK_CHECK (native/stack.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"
#include "stack.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_CONST_VALUE SD(TOKEN_CONST_VALUE_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define OPTION_CALLING_CONVENTION SB(OPTION_CALLING_CONVENTION_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define MODS(i) SB(fp_add(C_DECL_MODIFIERS_P, (i)))

struct Flags { i8 first, second, third; };

static u16 flags_low(struct Flags f) { return (u8)f.first | (u16)(u8)f.second << 8; }

/* the next token: the pushed-back one, or a new one from the lexer */
static u16 next_token(void)
{
    if (TOKEN_PUSHED_BACK) {
        TOKEN_PUSHED_BACK = 0;
        return TOKEN_TYPE;
    }
    return (u16)LEX_NEXT_TOKEN();
}

/* a declarator that must have a name; its DCLR tree, 0 after an error.  input permits an
   old-style identifier list "f(a, b)".  The name and its position go to C_DECLARATOR_NAME
   and C_DECL_SOURCE_* */
u16 BCC_STMT_DECL_NEW(u16 input)
{
    u16 result = PARSE_DECLARATOR_TREE(input, 1);
    if (!result)
        return 0;
    C_DECLARATOR_NAME = DECLARATOR_NAME;
    C_DECL_SOURCE_LINE = DECLARATOR_NAME_LINE;
    C_DECL_SOURCE_FILE = DECLARATOR_NAME_FILE;
    return result;
}

/* a parameter's declarator (name optional, left in PARAM_NAME) */
u16 PARSE_PARAM_DECLARATOR(void)
{
    u16 result = PARSE_DECLARATOR_TREE(0, 0);
    if (result == 0)
        return 0;
    PARAM_NAME = DECLARATOR_NAME;
    return result;
}

/* an abstract declarator (no name), for type names */
u16 PARSE_ABSTRACT_DECLARATOR(void)
{
    return PARSE_DECLARATOR_TREE(0, -1);
}

/* any run of modifier keywords, added to the triple, which is stored at result.  first is
   the calling convention (cdecl 1, pascal 2, 49h 3, interrupt 4), second the distance or
   segment (_es 1, _cs 2, _ss 3, _ds 4, _seg 7, near 8, far 9, huge 10), third a mask
   (_loadds 2, _saveregs 10h, _export 80h).  Repeats and contradictions are "conflicting
   type modifiers" errors.  Returns result's offset, as the original does */
u16 BCC_STMT_BEGIN(farptr result, u8 third, u16 low)
{
    struct Flags flags = { (i8)low, (i8)(low >> 8), (i8)third };
    for (;;) {
        i16 mask = 0, first = 0, second = 0;
        switch (TOKEN_TYPE) {
        case 0x48: first = 1; break;
        case 0x47: first = 2; break;
        case 0x46: first = 4; break;
        case 0x49: first = 3; break;
        case 0x4C: mask = 2; break;
        case 0x4E: mask = 0x80; break;
        case 0x4D: mask = 0x10; break;
        case 0x51: second = 2; break;
        case 0x52: second = 4; break;
        case 0x53: second = 1; break;
        case 0x54: second = 3; break;
        case 0x55: second = 7; break;
        case 0x4F: second = 8; break;
        case 0x50: second = 9; break;
        case 0x56: second = 10; break;
        default:
            if (flags.first != 0 && flags.second <= 3 && flags.second >= 2) {
                flags.second = 0;
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            }
            SB(result) = flags.first;
            SB(fp_add(result, 1)) = flags.second;
            SB(fp_add(result, 2)) = flags.third;
            return FP_OFF(result);
        }
        if (mask & flags.third)
            REPORT_ERROR(MSG_CONFLICTING_TYPE);
        flags.third |= mask;
        if (first != 0) {
            if (flags.first != 0)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags.first = first;
        }
        if (second != 0) {
            if (flags.second != 0)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags.second = second;
        }
        if (flags.second == 8 && flags.first == 4) {
            REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags.second = 0;
        }
        next_token();
        LOGICAL_LINE = CURRENT_LINE;
    }
}

static u16 new_node(u16 kind, i32 value, u16 first, u16 second, u8 flags, struct Flags local)
{
    return NEW_DECLARATOR_NODE(kind, value, first, second, flags, (u8)local.third, flags_low(local));
}

/* one declarator into a DCLR tree, recursively for '*' and parentheses, then any number of
   () and [] suffixes; level is the name rule.  A pointer may be followed by const or
   volatile and by a string literal naming its base (FLUSH_PENDING_POOL).  Array sizes must
   be positive constants */
u16 PARSE_DECLARATOR_TREE(u16 input, i16 level)
{
    STACK_CHECK(PARSE_DECLARATOR_TREE);     /* if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY): native/stack.c */
    struct Flags local;
    u16 node;
    {
        u16 mark = scratch_mark();
        farptr returned = scratch_alloc(4);
        BCC_STMT_BEGIN(returned, (u8)MODS(2), W(C_DECL_MODIFIERS_P));
        local.first = SB(returned);
        local.second = SB(fp_add(returned, 1));
        local.third = SB(fp_add(returned, 2));
        scratch_release(mark);
    }
    MODS(1) = 0;
    MODS(0) = 0;
    MODS(2) = 0;
    if (TOKEN_TYPE == 0x18) {
        next_token();
        i16 flags = PARSE_CV_QUALIFIERS();
        u16 second;
        if (TOKEN_TYPE == 0x34) {
            second = FLUSH_PENDING_POOL();
            next_token();
        } else
            second = 0;
        node = PARSE_DECLARATOR_TREE(input, level);
        if (!node)
            return 0;
        return new_node(0xD, 0, node, second, (u8)flags, local);
    }
    DECLARATOR_NAME = 0;
    if (TOKEN_TYPE == 1) {
        next_token();
        if (TOKEN_TYPE != 2) {
            node = PARSE_DECLARATOR_TREE(input, level);
            if (!node)
                return 0;
        } else if (level <= 0) {
            node = new_node(0x12, 0, 0, 0, 0, local);
            local.first = 0;
            local.second = 0;
        } else {
            REPORT_AND_SKIP(MSG_NEED_IDENTIFIER, 0);
            return 0;
        }
        next_token();
    } else {
        if (TOKEN_TYPE == 0x31 && level >= 0) {
            DECLARATOR_NAME = (u16)TOKEN_CONST_VALUE;
            DECLARATOR_NAME_LINE = TOKEN_LINE;
            DECLARATOR_NAME_FILE = TOKEN_FILE_NODE;
            next_token();
        } else if (level > 0) {
            REPORT_AND_SKIP(MSG_NEED_IDENTIFIER, 0);
            return 0;
        }
        node = new_node(0, 0, 0, 0, 0, local);
    }
    LOGICAL_LINE = CURRENT_LINE;
    if (TOKEN_TYPE != 1 && TOKEN_TYPE != 3 && local.second != 0 && local.second != 8 && local.second != 10 && local.second != 9)
        REPORT_ERROR(MSG_CONFLICTING_TYPE);
    i16 array = 0;
    while (TOKEN_TYPE == 1 || TOKEN_TYPE == 3) {
        if (TOKEN_TYPE != 3) {
            next_token();
            u16 size = DECLARATOR_NAME, scope = DECLARATOR_NAME_LINE, line = DECLARATOR_NAME_FILE;
            u16 params = PARSE_PARAMETER_LIST(input);
            DECLARATOR_NAME = size;
            DECLARATOR_NAME_LINE = scope;
            DECLARATOR_NAME_FILE = line;
            if (PARAM_LIST_KIND == 0)
                return 0;
            i16 flags = 0;
            if (PARAM_LIST_KIND == 2) {
                input = 0;
                params = 0;
                flags = 8;
            } else if (PARAM_LIST_KIND == 3) {
                if (local.first != 1 && local.first != 0)
                    REPORT_ERROR(MSG_CONFLICTING_TYPE);
                flags = 4;
            }
            node = new_node(0x12, 0, node, params, (u8)flags, local);
        } else {
            if (local.second == 10) {
                local.second = 9;
                array = 1;
            } else if (local.second != 0 && local.second != 8 && local.second != 9)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            next_token();
            if (TOKEN_TYPE != 4) {
                u16 size = DECLARATOR_NAME;
                if (!PARSE_CONSTANT_EXPR(1))
                    return 0;
                DECLARATOR_NAME = size;
                if (TOKEN_CONST_VALUE <= 0) {
                    REPORT_ERROR(MSG_ARRAY_MUST_HAVE_LEAST);
                    TOKEN_CONST_VALUE = 1;
                }
                node = new_node(0x11, TOKEN_CONST_VALUE, node, 0, (u8)array, local);
                TOKEN_PUSHED_BACK = 1;
            } else
                node = new_node(0x11, 0, node, 0, (u8)array, local);
        }
        next_token();
        LOGICAL_LINE = CURRENT_LINE;
    }
    return node;
}

/* what follows '(' in a function declarator, up to ')'.  Returns the parameter list
   (C_PARAM_POOL_SEG records) or 0, and sets PARAM_LIST_KIND: 0 error, 1 prototype, 2 no
   prototype ("()" or an old-style identifier list, kept in C_OLD_STYLE_PARAM_LIST and
   allowed only when input is nonzero), 3 prototype ending in "...".  A list that is just
   "void" becomes empty.  In strict ANSI mode the parameters get their own scope while
   being parsed */
u16 PARSE_PARAMETER_LIST(u16 input)
{
    u16 newscope = 0, oldscope = 0;
#define RESTORE_SCOPE() if (LANGUAGE_MODE == 1) { C_DECL_SCOPE = oldscope; PARAM_SCOPE_MARK_AUX = 0; PARAM_SCOPE_MARK = newscope; }
    u16 saved = C_DECL_SYMBOL_FLAGS;
    u16 list;
    if (TOKEN_TYPE == 2)
        goto empty;
    if (TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
        if (LANGUAGE_MODE == 1) {
            oldscope = C_DECL_SCOPE;
            newscope = CREATE_SCOPE(C_DECL_SCOPE);
            C_DECL_SCOPE = newscope;
        }
        list = 0;
        for (;;) {
            u16 type = BCC_STMT_BUILD();
            if (!type) {
                RESTORE_SCOPE();
                PARAM_LIST_KIND = 0;
                return 0;
            }
            if (C_DECL_STORAGE_CLASS == 0)
                C_DECL_STORAGE_CLASS = 6;
            else if (C_DECL_STORAGE_CLASS != 13) {
                REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, DSPTR(STORAGE_CLASS_NAMES_AT(C_DECL_STORAGE_CLASS)));
                C_DECL_STORAGE_CLASS = 6;
            }
            if (TOKEN_TYPE != 8 && TOKEN_TYPE != 2) {
                u16 decl = PARSE_PARAM_DECLARATOR();
                if (decl == 0) {
                    C_DECL_SYMBOL_FLAGS = saved;
                    RESTORE_SCOPE();
                    PARAM_LIST_KIND = 0;
                    return 0;
                }
                type = BCC_STMT_BIND_TYPE(decl, type);
            } else
                PARAM_NAME = 0;
            C_DECL_SYMBOL_FLAGS = saved;
            list = BCC_STMT_ADD_FIELD(list, PARAM_NAME, type, C_DECL_STORAGE_CLASS);
            if (TOKEN_TYPE != 8) {
                PARAM_LIST_KIND = 1;
                break;
            }
            next_token();
            if (TOKEN_TYPE == 9) {
                next_token();
                PARAM_LIST_KIND = 3;
                break;
            }
            if (TOKEN_STARTS_TYPE(TOKEN_TYPE))
                continue;
            REPORT_AND_SKIP(TOKEN_TYPE == 2 ? MSG_DECLARATION_WAS : MSG_EXPECTED_233, 0);
            RESTORE_SCOPE();
            PARAM_LIST_KIND = 0;
            return 0;
        }
        RESTORE_SCOPE();
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_EXPECTED_233, 0);
            PARAM_LIST_KIND = 0;
            return 0;
        }
        if (list && TYPE_B(CPARM_W(list, CPARM_TYPE), TYPE_KIND) == 12 && CPARM_W(list, CPARM_NEXT) == 0 && CPARM_W(list, CPARM_NAME) == 0)
            list = 0;
        return list;
    }
#undef RESTORE_SCOPE
    if (!input) {
        REPORT_AND_SKIP(MSG_PARAMETER_NAMES_ARE, 0);
        PARAM_LIST_KIND = 0;
        return 0;
    }
    newscope = C_DECL_SCOPE;
    BCC_STMT_FUNCTION_NEAR();
    list = 0;
    for (;;) {
        if (TOKEN_TYPE != 0x31) {
            REPORT_AND_SKIP(MSG_EXPECTED_233, 0);
            C_DECL_SCOPE = newscope;
            PARAM_LIST_KIND = 0;
            return 0;
        }
        list = BCC_STMT_ADD_FIELD(list, (u16)TOKEN_CONST_VALUE, 0, 0);
        next_token();
        if (TOKEN_TYPE == 2)
            break;
        if (TOKEN_TYPE != 8) {
            REPORT_AND_SKIP(MSG_EXPECTED_202, 0);
            C_DECL_SCOPE = newscope;
            PARAM_LIST_KIND = 0;
            return 0;
        }
        next_token();
    }
    C_OLD_STYLE_PARAM_LIST = list;
empty:
    PARAM_LIST_KIND = 2;
    return 0;
}

/* const (1) and volatile (2) after a '*'; returns the flags */
u16 PARSE_CV_QUALIFIERS(void)
{
    u16 flags = 0;
    for (;;) {
        switch (TOKEN_TYPE) {
        case 0x4A:
            if (flags & 1)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags |= 1;
            break;
        case 0x4B:
            if (flags & 2)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags |= 2;
            break;
        default:
            return flags;
        }
        next_token();
    }
}

/* a 13-byte DCLR node: kind, array size value, inner node first, parameter list or
   pointer base second, flags (cv-qualifiers, function flags, or the huge-array mark) and
   the modifier triple (third, then first and second, as two words) */
u16 NEW_DECLARATOR_NODE(u16 kind, i32 value, u16 first, u16 second, u8 flags, u8 third, u16 low)
{
    u16 node = POOL_ALLOC_REUSE(DECLARATOR_NODE_POOL_SEG_P, 13);
    DCLR_B(node, DCLR_KIND) = (u8)kind;
    DCLR_W(node, DCLR_PARAMS) = second;
    DCLR_L(node, DCLR_ARRAY_SIZE) = value;
    DCLR_B(node, DCLR_FLAGS) = flags;
    DCLR_W(node, DCLR_CHILD) = first;
    DCLR_W(node, DCLR_CALL_CONV) = low;
    DCLR_B(node, DCLR_EXTRA_MODS) = third;
    return node;
}

/* "not an allowed type" (an array of functions, a function returning an array ...) */
void REPORT_TYPE_NOT_ALLOWED(void)
{
    REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
}

/* applies the DCLR tree input to the base type and returns the result, freeing the nodes.
   Modifiers written before a function's name ("int far f()") move from the inner node to
   the function.  The name node's modifiers are left in C_DECL_CALL_CONVENTION and
   C_DECL_DISTANCE for the declared object.  C_DECL_SYMBOL_FLAGS carries cv-qualifiers from
   one pointer level to the type built at the next */
u16 BCC_STMT_BIND_TYPE(u16 input, u16 type)
{
    u16 node = input;
    C_DECL_CALL_CONVENTION = 0;
    C_DECL_DISTANCE = 0;
    while (node) {
        u16 child = DCLR_W(node, DCLR_CHILD);
        if (DCLR_SC(node, DCLR_KIND) == 17) {
            if (TYPE_B(type, TYPE_KIND) == TK_FUNCTION || TYPE_B(type, TYPE_KIND) == TK_VOID)
                REPORT_TYPE_NOT_ALLOWED();
            if (TYPE_B(type, TYPE_KIND) == TK_ARRAY && TYPE_B(type, TYPE_C_BYTE9) != 0)
                DCLR_SC(node, DCLR_FLAGS) = 1;
            type = NEW_ARRAY_TYPE(DCLR_L(node, DCLR_ARRAY_SIZE), type, (u16)(i16)DCLR_SC(node, DCLR_FLAGS));
        } else if (DCLR_SC(node, DCLR_KIND) == 18) {
            i16 second = DCLR_SC(node, DCLR_DISTANCE);
            i16 first = DCLR_SC(node, DCLR_CALL_CONV);
            if (child) {
                if (second == 0)
                    second = DCLR_SC(child, DCLR_DISTANCE);
                if (DCLR_SC(node, DCLR_EXTRA_MODS) == 0) {
                    DCLR_SC(node, DCLR_EXTRA_MODS) = DCLR_SC(child, DCLR_EXTRA_MODS);
                    DCLR_SC(child, DCLR_EXTRA_MODS) = 0;
                }
                if (DCLR_SC(child, DCLR_KIND) == 13) {
                    if (DCLR_SC(child, DCLR_DISTANCE) == 0)
                        DCLR_SC(child, DCLR_DISTANCE) = (i8)second;
                } else {
                    if (DCLR_SC(child, DCLR_DISTANCE) != second)
                        REPORT_ERROR(MSG_CONFLICTING_TYPE);
                    DCLR_SC(child, DCLR_DISTANCE) = 0;
                }
                if (first == 0)
                    first = DCLR_SC(child, DCLR_CALL_CONV);
                DCLR_SC(child, DCLR_CALL_CONV) = 0;
            }
            i16 flags = (i8)(DCLR_SC(node, DCLR_FLAGS) | DCLR_SC(node, DCLR_EXTRA_MODS));
            switch (second) {
            case 8: flags |= 0x40; break;
            case 9: flags |= 1; break;
            case 10: flags |= 3; break;
            }
            type = BUILD_FUNCTION_TYPE(type, DCLR_W(node, DCLR_PARAMS), (u8)first, (i8)flags);
            C_DECL_SYMBOL_FLAGS = 0;
        } else if (DCLR_SC(node, DCLR_KIND) == 13) {
            if (child && DCLR_SC(child, DCLR_KIND) == 0 && DCLR_SC(child, DCLR_CALL_CONV) == 0) {
                DCLR_SC(child, DCLR_CALL_CONV) = DCLR_SC(node, DCLR_CALL_CONV);
                DCLR_SC(node, DCLR_CALL_CONV) = 0;
            }
            if (DCLR_SC(node, DCLR_CALL_CONV) != 0 || DCLR_SC(node, DCLR_EXTRA_MODS) != 0)
                REPORT_ERROR(MSG_CONFLICTING_TYPE);
            i16 second = DCLR_SC(node, DCLR_FLAGS);
            i16 saved = C_DECL_SYMBOL_FLAGS;
            type = PTR_TYPE_FOR_MODIFIER(type, (i8)saved, DCLR_W(node, DCLR_PTR_BASE), DCLR_SC(node, DCLR_DISTANCE));
            C_DECL_SYMBOL_FLAGS = second;
        } else {
            C_DECL_CALL_CONVENTION = (i16)DCLR_SC(node, DCLR_CALL_CONV);
            if (DCLR_SC(node, DCLR_DISTANCE) == 9 || DCLR_SC(node, DCLR_DISTANCE) == 10)
                C_DECL_DISTANCE = 9;
            else if (DCLR_SC(node, DCLR_DISTANCE) == 8)
                C_DECL_DISTANCE = 8;
        }
        POOL_FREE_ITEM(DECLARATOR_NODE_POOL_SEG_P, node);
        node = child;
    }
    return type;
}

/* nonzero if the DCLR tree is just a name (kind 0) */
i16 IS_BARE_DECLARATOR(u16 node)
{
    return DCLR_B(node, DCLR_KIND) == 0;
}

/* the type "function returning node" with parameter list value.  mode is the calling
   convention (0: the default from -p, OPTION_CALLING_CONVENTION); an interrupt function
   (4) is always far (flags 3).  Without an explicit distance (flags 40h near, 1 far, 3
   huge) the memory model decides.  A function may not return an array or a function */
u16 BUILD_FUNCTION_TYPE(u16 node, u16 value, u8 mode, i8 flags)
{
    if (mode == 4)
        flags |= 3;
    else {
        if (mode == 0) {
            switch (OPTION_CALLING_CONVENTION) {
            case 0: mode = 1; break;
            case 1: mode = 2; break;
            case 2: mode = 3; break;
            }
        }
        if ((u8)(flags & 0x43) == 0) {
            if (OPTION_MEMORY_MODEL == 5)
                flags |= 3;
            else if (MODEL_FAR_CODE)
                flags |= 1;
            else
                flags |= 0x40;
        }
    }
    switch (TYPE_B(node, TYPE_KIND)) {
    case 0x11:
    case 0x12:
        REPORT_TYPE_NOT_ALLOWED();
        break;
    }
    return NEW_FUNCTION_TYPE(node, value, mode, flags);
}
