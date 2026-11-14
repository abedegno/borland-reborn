/* asmdata.c: from bcc20/src/output/ASMDATA.C (overlay CO077): small writers of the
   assembly-text output (BCC's .asm file under -S or -B), reached mostly through the back
   end's hook table.  They keep the segment records (SEGDEF_POOL_SEG) up to date while
   writing, so the assembly path tracks segment sizes the same way the object path does.
   - EMIT_PROC_BEGIN switches the text to another segment: "name ends" for the open one
     (EMIT_SEGMENT_END), then "name\tsegment byte|word|para public 'class'".  A virtual
     segment (SEGDEF_PARENT_ID set) is opened inside its parent code segment as
     "name\tsegment\tvirtual".
   - RESERVE_DATA_BYTES, EMIT_DB_DATA, EMIT_DW_ADDRESS, EMIT_DD_ADDRESS write db/dw/dd data
     and grow the segment's size, with the fatal "Too much global data defined in file"
     past 64 KB.  SEGDEF_FIRST_BLOCK is used here only as a "has initialized data" mark:
     reserved space is written as "dup (0)" after real data, "dup (?)" before.
   - EMIT_PROC_OR_LABEL writes the label line of a public or static symbol: for a function
     "assume cs:group" and "name\tproc\tfar|near", else "name\tlabel\ttype".
   - EMIT_LOCAL_LABEL writes a jump label "@<function serial>@C<n>\tlabel\tword",
     EMIT_ASM_LINE_MARK a source-line marker.
   - EMIT_DECIMAL and EMIT_SIGNED_DECIMAL print numbers.
   Segment and class names are passed to PUT_FAR_STRING as offsets in the string pool with
   the address of the string-pool segment word. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define DEBUG_STATE SW(DEBUG_STATE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define ASM_TYPE_NAME(kind) D(fp_add(ASM_TYPE_NAME_TABLE_P, (kind) * 4))

static void put_pool_string(u16 offset) { PUT_FAR_STRING(offset, FP_OFF(STRING_POOL_SEG_P)); }
static void name_of(u16 symbol) { CALL_FAR(NAME_HOOK, A16(symbol)); }

/* makes segment id value the one the text is written into, writing the segment header
   first (and the file header on first use, ASM_OUTPUT_FLAGS bit 0).  value 0 only closes
   the open segment.  DEBUG_STATE is -1 during the switch and then holds the new segment's
   index.  Returns the id selected (by SELECT_SEGMENT), or the previous id when value is 0 */
u16 EMIT_PROC_BEGIN(u16 value)
{
    if (!(ASM_OUTPUT_FLAGS & 1))
        EMIT_ASM_HEADER();
    if (SELECTED_SEGMENT_ID == value)
        return value;
    DEBUG_STATE = -1;
    EMIT_SEGMENT_END();
    u16 old = SELECTED_SEGMENT_ID;
    if (value == 0) {
        SELECTED_SEGMENT_ID = 0;
        return old;
    }
    value = SELECT_SEGMENT(value);
    u16 entry = SELECTED_SEGDEF_ENTRY;
    u16 outer = SEGDEF_W(entry, SEGDEF_PARENT_ID) & 0x7FFF;
    if (outer)
        entry = FIND_SEGMENT(outer);
    put_pool_string(SEGDEF_W(entry, SEGDEF_NAME));
    PUT_CODE_STRING(STR_SEGMENT_P);
    if (SEGDEF_B(entry, SEGDEF_ALIGN) == 16)
        PUT_CODE_STRING(STR_PARA_P);
    else if (SEGDEF_SC(entry, SEGDEF_ALIGN) > 1)
        PUT_CODE_STRING(STR_WORD_P);
    else
        PUT_CODE_STRING(fp_add(STR_BYTE_P, 1));
    PUT_CODE_STRING(STR_PUBLIC_P);
    if (B(MK_FP(STRING_POOL_SEG, SEGDEF_W(entry, SEGDEF_CLASS_NAME)))) {
        PUT_CODE_CHAR('\'');
        put_pool_string(SEGDEF_W(entry, SEGDEF_CLASS_NAME));
        PUT_CODE_CHAR('\'');
    }
    PUT_CODE_STRING(STR_CRLF_3_P);
    DEBUG_STATE = (i16)SEGDEF_W(entry, SEGDEF_INDEX);
    if (outer) {
        put_pool_string(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_NAME));
        PUT_CODE_STRING(STR_SEGMENT_VIRTUAL_P);
    }
    return value;
}

/* writes "\tdb\t<amount> dup (0)" (or "dup (?)" if the segment has no initialized data
   yet) and grows the segment.  More than 64 KB in a segment is fatal */
void RESERVE_DATA_BYTES(u16 amount)
{
    u16 record = SELECTED_SEGDEF_ENTRY;
    i32 total = SEGDEF_L(record, SEGDEF_SIZE) + amount;
    if (total > 0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, SEGDEF_W(record, SEGDEF_NAME));
    SEGDEF_L(record, SEGDEF_SIZE) = total;
    PUT_CODE_STRING(STR_DB_2_P);
    EMIT_DECIMAL(amount);
    PUT_CODE_STRING(SEGDEF_W(record, SEGDEF_FIRST_BLOCK) != 0 ? STR_DUP_0_P : STR_DUP_P);
}

/* for an alignment of 2 or more, adds one byte when the segment size is odd */
void ALIGN_ASM_DATA_EVEN(i16 value)
{
    if (value >= 2 && (SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) & 1))
        RESERVE_DATA_BYTES(1);
}

/* writes "\tdb\t<value>" for one data byte and marks the segment as holding data */
void EMIT_DB_DATA(u8 value)
{
    u16 node = SELECTED_SEGDEF_ENTRY;
    if (SEGDEF_L(node, SEGDEF_SIZE) >= 0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, SEGDEF_W(node, SEGDEF_NAME));
    SEGDEF_L(node, SEGDEF_SIZE) += 1;
    SEGDEF_W(node, SEGDEF_FIRST_BLOCK) = 1;
    PUT_CODE_STRING(STR_DB_2_P);
    EMIT_SIGNED_DECIMAL(value);
    PUT_CODE_STRING(STR_CRLF_3_P);
}

/* places symbol value at the current position and, for kinds 1 and 3 (public or defined
   here), writes its label: a function (element kind 18) gets "\tassume\tcs:<group or code
   segment>" and "name\tproc\tfar" or "near" (FLAG_HOOK bit 0 = far); data gets
   "name\tlabel\t<type>" */
void EMIT_PROC_OR_LABEL(u16 value)
{
    SET_SYMBOL_AT_CURRENT_POS(value);
    u16 kind = (u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(value));
    if (kind != 1 && (u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(value)) != 3)
        return;
    if ((u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(value)) == 18) {
        PUT_CODE_STRING(STR_ASSUME_CS_P);
        u16 segment = FIND_SEGMENT(CODE_SEGMENT_ID);
        if ((i16)SEGDEF_W(segment, SEGDEF_PARENT_ID) > 0)
            segment = FIND_SEGMENT(SEGDEF_W(segment, SEGDEF_PARENT_ID));
        u16 name;
        if (SEGDEF_W(segment, SEGDEF_GROUP))
            name = SEGDEF_W(SEGDEF_W(segment, SEGDEF_GROUP), SEGGRP_NAME);
        else
            name = SEGDEF_W(segment, SEGDEF_NAME);
        put_pool_string(name);
        PUT_CODE_STRING(STR_CRLF_3_P);
        name_of(value);
        PUT_CODE_STRING(STR_PROC_P);
        u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(value));
        if ((u16)CALL_FAR(FLAG_HOOK, A16(type)) & 1)
            PUT_CODE_STRING(STR_FAR_2_P);
        else
            PUT_CODE_STRING(STR_NEAR_2_P);
    } else {
        name_of(value);
        PUT_CODE_STRING(STR_LABEL_P);
        PUT_CODE_STRING(ASM_TYPE_NAME((u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(value))));
    }
    PUT_CODE_STRING(STR_CRLF_3_P);
}

/* writes "name endp" for the function being generated */
void EMIT_PROC_ENDP(void)
{
    name_of(CODEGEN_FUNCTION_SYMBOL);
    PUT_CODE_STRING(STR_ENDP_P);
}

/* writes "<directive>[group:]name[+value]" for an address of size bytes and grows the
   segment by that */
static void emit_address(u16 name, u16 value, u16 size, farptr directive)
{
    SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) += size;
    if (SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) > 0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_NAME));
    SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_FIRST_BLOCK) = 1;
    PUT_CODE_STRING(directive);
    EMIT_GROUP_PREFIX(name);
    name_of(name);
    if (value) {
        PUT_CODE_CHAR('+');
        EMIT_DECIMAL(value);
    }
    PUT_CODE_STRING(STR_CRLF_3_P);
}

/* "\tdw\t[group:]name[+value]", a near address */
void EMIT_DW_ADDRESS(u16 name, u16 value)
{
    emit_address(name, value, 2, STR_DW_2_P);
}

/* "\tdd\t[group:]name[+value]", a far address */
void EMIT_DD_ADDRESS(u16 name, u16 value)
{
    emit_address(name, value, 4, STR_DD_P);
}

/* the definition of local jump label value of the current function:
   "@<FUNCTION_SERIAL>@C<value>\tlabel\tword" */
void EMIT_LOCAL_LABEL(u16 value)
{
    PUT_CODE_CHAR('@');
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING(STR_C_5_P);
    EMIT_DECIMAL(value);
    PUT_CODE_STRING(STR_LABEL_WORD_P);
}

/* adds a jump (kind 18h) to flow block value, passing the block's flag 100h, and starts a
   new code fragment */
void ADD_JUMP_18_NEXT_FRAGMENT(u16 value)
{
    ADD_JUMP(0x18, value, CNODE_W(value, CNODE_FLAGS) & 0x100);
    START_NEXT_FRAGMENT();
}

/* marks source line value of file record node (a SRCSEGS.C serial) in the code text: a
   7-byte marker FFh, 01h, the line as four letters 'a'..'p' (one per hex digit) and '1' if
   node is the function's own file, else '0'.  With -v a file-name record is written first
   when the file changes */
void EMIT_ASM_LINE_MARK(u16 node, u16 value)
{
    u16 found = FIND_NODE_BY_SERIAL(node);
    if (!found)
        return;
    if (OPTION_SOURCE_DEBUG && LINE_MARK_LAST_FILE != found) {
        OBJ_WRITE_FILE_ENTRY(found);
        LINE_MARK_LAST_FILE = found;
    }
    PUT_CODE_CHAR(0xFF);
    PUT_CODE_CHAR(1);
    PUT_CODE_CHAR(((value >> 12) & 15) + 'a');
    PUT_CODE_CHAR(((value >> 8) & 15) + 'a');
    PUT_CODE_CHAR(((value >> 4) & 15) + 'a');
    PUT_CODE_CHAR((value & 15) + 'a');
    PUT_CODE_CHAR((node == FUNCTION_SOURCE_FILE) + '0');
}

/* closes the open segment: "name ends", and "parent ends" for a virtual segment */
void EMIT_SEGMENT_END(void)
{
    if (SELECTED_SEGDEF_ENTRY == 0)
        return;
    put_pool_string(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_NAME));
    PUT_CODE_STRING(STR_ENDS_P);
    if (SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_PARENT_ID) != 0) {
        u16 selected = FIND_SEGMENT(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_PARENT_ID) & 0x7FFF);
        put_pool_string(SEGDEF_W(selected, SEGDEF_NAME));
        PUT_CODE_STRING(STR_ENDS_P);
    }
    SELECTED_SEGDEF_ENTRY = 0;
    DEBUG_STATE = 0;
}

/* value in decimal with a '-' when negative */
void EMIT_SIGNED_DECIMAL(i16 value)
{
    if (value < 0) {
        PUT_CODE_CHAR('-');
        value = (i16)-value;
    }
    EMIT_DECIMAL((u16)value);
}

/* value in decimal (recursive, most significant digit first) */
void EMIT_DECIMAL(u16 value)
{
    if (value / 10)
        EMIT_DECIMAL(value / 10);
    PUT_CODE_CHAR(value % 10 + '0');
}
