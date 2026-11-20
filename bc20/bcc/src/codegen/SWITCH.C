/* target: ovr152_C209UNIT */
/* Role: switch lowering (compare tree, table scan, jump table). Entry points: LOWER_SWITCH,
   EMIT_SWITCH_TABLES. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO05C (ovr_1d6c_a3dc) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: switch statements. The parser leaves one switch block (kind 4, FLOWBLK.C
   NEW_SWITCH_BLOCK) per switch: the selector's ops (CNODE_SWITCH_LOW_OP, and
   CNODE_SWITCH_HIGH_OP for a long selector, CNODE_FLAGS 4), its case list
   (CNODE_CASE_LIST: CASE_ENTRY_POOL_SEG entries sorted by value, SWCASE_*), and the
   default target (CNODE_TARGET). LOWER_SWITCH (called for each one by LOWER_SWITCHES,
   CGDRIVER.C) replaces it by ordinary blocks in one of three shapes:
   - a compare tree (LOWER_SWITCH_COMPARES): a binary search on the case values, with
     short linear runs of compares at the leaves;
   - a jump table (LOWER_SWITCH_JUMP_TABLE), used inside the compare tree for a run of
     cases dense enough (span at most three times the count): subtract the first value,
     check the range, then jump through a table of labels indexed by BX;
   - a table scan (LOWER_SWITCH_TABLE_SCAN) for long selectors and for sparse switches
     with four or more cases when not optimising for speed: a loop compares the selector
     with a table of case values and jumps through the matching entry of a label table.
   The tables themselves are emitted after the function (EMIT_SWITCH_TABLES, called by
   GENERATE_FUNCTION_CODE after the epilogue) from table records: flow blocks reused as
   records (kind 1 value table, kind 2 jump table; CNODE_CASE_LIST the first case, offset
   0x14 (named CNODE_SCOPE_OWN_REGS) the number of cases) linked through word 6, which is
   CNODE_NEXT, on SWITCH_TABLE_LIST.
   Probable meanings: code op 0x81 CMP word, 0x28 SUB word, 0x1F ADD word, 0x4D OR word,
   0x99 a copy of the selector into a register, 0xB6 a load of its left operand into BX
   and its right operand into CX (the pair CGOPER.C uses for long helper calls), 0xB0
   and 0xAF the table address load and the jump
   through the table (emitted by output hooks), 0x16 an indirect word with a segment
   override (BX with CS, register 14), constant ops 10; jump kinds 1 always, 3 signed
   greater, 5 unsigned above, 0x0A equal, 0x0B not equal, 0x17 probably LOOP (count in
   CX). The _SI/_DI/_ES register code is a shape kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV06E (listing ovr_1d6c_a3dc:3DC0) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* LINK_NODE: pushes table record 'node' on SWITCH_TABLE_LIST (link in word 6). */
static void near pascal LINK_NODE(unsigned int node)
{
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[6] = SWITCH_TABLE_LIST;
    SWITCH_TABLE_LIST = node;
}

/* ---- STAOV06F (listing ovr_1d6c_a3dc:3DDD) ---- */
static void near pascal LOWER_SWITCH_TABLE_SCAN(register unsigned int node, int amount, unsigned int value);
static void near pascal LOWER_SWITCH_COMPARES(unsigned int node, int count, unsigned int item, unsigned int out);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char OPTION_OPTIMIZE_SPEED;
extern unsigned int far pascal NEW_BLOCK(void);
extern void far pascal SPLICE_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);

/* LOWER_SWITCH: lowers switch block 'node' (see the overview for the choice of shape).
   Without cases it just becomes a code block (selector evaluated, then the default jump
   stays). For a compare tree, the selector is copied into fresh ops in a new block,
   SWITCH_BIT_200_FLAG records an unsigned selector (CNODE_FLAGS 0x200) for the signed or
   unsigned comparisons, and the compare blocks are spliced in after 'node', which becomes
   a plain block without a jump. */
void far pascal LOWER_SWITCH(unsigned int node)
{
    unsigned int count,high_expr,low_expr,compare_block,first_case;
    _SI=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    first_case=ES_W(_SI,CNODE_CASE_LIST);
    if (first_case==0) {
        ES_W(_SI,CNODE_KIND)=0;
        return;
    }
    for (count=1,_DI=first_case; (_ES=CASE_ENTRY_POOL_SEG, ES_W(_DI,SWCASE_NEXT));
         ++count,_ES=CASE_ENTRY_POOL_SEG,_DI=ES_W(_DI,SWCASE_NEXT)) ;
    _ES=FLOW_BLOCK_POOL_SEG;
    if (ES_W(_SI,CNODE_FLAGS)&4) goto simple;
    _ES=CASE_ENTRY_POOL_SEG;
    _AX=ES_W(_DI,SWCASE_VALUE);
    _BX=first_case;
    if (_AX-ES_W(_BX,SWCASE_VALUE)>count*3 && OPTION_OPTIMIZE_SPEED==0 && count>=4) goto simple;
    compare_block=NEW_BLOCK();
    _ES=FLOW_BLOCK_POOL_SEG;
    _AX=ES_W(_SI,CNODE_SWITCH_HIGH_OP);
    _DX=ES_W(_SI,CNODE_SWITCH_LOW_OP);
    high_expr=_AX;
    low_expr=_DX;
    low_expr=NEW_CODE_NODE(0x99,0,low_expr,0);
    if (high_expr) high_expr=NEW_CODE_NODE(0x99,0,high_expr,0);
    _BX=compare_block;
    _ES=FLOW_BLOCK_POOL_SEG;
    ES_W(_BX,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-ES_W(_BX,CNODE_FIRST_OP);
    _AX=high_expr;
    _DX=low_expr;
    ES_W(_SI,CNODE_SWITCH_HIGH_OP)=_AX;
    ES_W(_SI,CNODE_SWITCH_LOW_OP)=_DX;
    SWITCH_BIT_200_FLAG=ES_W(_SI,CNODE_FLAGS)&0x200;
    LOWER_SWITCH_COMPARES(_SI,count,first_case,compare_block);
    _ES=FLOW_BLOCK_POOL_SEG;
    ES_W(_SI,CNODE_KIND)=0;
    ES_W(_SI,CNODE_JUMP_KIND)=0;
    ES_W(_SI,CNODE_TARGET)=0;
    SPLICE_BLOCK_CHAIN(_SI,compare_block,ES_W(_SI,CNODE_LOOP_WEIGHT));
    return;
simple:
    LOWER_SWITCH_TABLE_SCAN(_SI,count,first_case);
}

/* ---- STAOV070 (listing ovr_1d6c_a3dc:3F12) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal NEW_BLOCK(void);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int, unsigned char, unsigned char);
extern unsigned int far pascal NEW_PLAIN_CODE_NODE(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int, long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
extern void far pascal JOIN_BLOCK_CHAINS(unsigned int, unsigned int);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern void far pascal SPLICE_BLOCK_CHAIN(unsigned int, unsigned int, unsigned int);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])

/* LOWER_SWITCH_TABLE_SCAN: table-scan lowering of switch block 'node' with 'amount' cases
   starting at case entry 'value'. Builds a value-table record, stores the selector in a
   new temporary (int, or long with two stores), and makes: a setup block (op 0xB6 with
   the case count into CX, and the table address 0xB0 into BX); a loop block
   comparing the selector with CS:[BX] (for a long selector the high word is compared with
   CS:[BX+amount*2] as well) and jumping to the dispatch block on a match; a step block
   (ADD BX,2, then jump kind 0x17 back to the loop); a jump to the default label, given
   kind 4 and the case list, probably so later passes still see the case targets as
   used; and the dispatch block, one op 0xAF that jumps through the label part of the
   table (offset amount*2, or amount*4 for longs, from BX). */
static void near pascal LOWER_SWITCH_TABLE_SCAN(register unsigned int node, int amount, unsigned int value)
{
    unsigned int setup_block,jump_block,table_block,step_block,default_label,temp_expr,high_offset;
    unsigned long bounds;
    unsigned int index_var;
    int table_node;
    register unsigned int cur;
    table_node = NEW_BLOCK();
    CNODE_W(table_node,CNODE_KIND) = 1;
    CNODE_W(table_node,CNODE_CASE_LIST) = value;
    CNODE_W(table_node,CNODE_FLAGS) = CNODE_W(node,CNODE_FLAGS);
    CNODE_W(table_node,CNODE_CASE_COUNT) = amount;
    LINK_NODE(table_node);
    bounds = *((unsigned long far *)MK_FP(FLOW_BLOCK_POOL_SEG,node+CNODE_SWITCH_LOW_OP));
    index_var = FIND_OR_ADD_VARIABLE(0,(CNODE_W(node,CNODE_FLAGS)&4) ? 8 : 6,0);
    setup_block = NEW_BLOCK();
    temp_expr = NEW_PLAIN_CODE_NODE(0x10,index_var,0);
    NEW_CODE_NODE(0x9C,2,temp_expr,LOW(bounds));
    if (CNODE_W(node,CNODE_FLAGS)&4) {
        temp_expr = NEW_PLAIN_CODE_NODE(0x10,index_var,2);
        NEW_CODE_NODE(0x9C,2,temp_expr,HIGH(bounds));
    }
    NEW_CODE_NODE(0xB6,0,0,NEW_CONSTANT_NODE(10,(long)amount));
    NEW_CONSTANT_NODE(0xB0,(long)table_node);
    CNODE_W(setup_block,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(setup_block,CNODE_FIRST_OP);
    CNODE_W(setup_block,CNODE_KIND) = 0;
    CNODE_W(setup_block,CNODE_JUMP_KIND) = 1;
    CNODE_W(setup_block,CNODE_TARGET) = 0;
    CNODE_W(node,CNODE_JUMP_KIND) = 0;
    default_label = CNODE_W(node,CNODE_TARGET);
    CNODE_W(node,CNODE_TARGET) = 0;
    CNODE_W(node,CNODE_KIND) = 0;
    cur = NEW_BLOCK();
    table_block = NEW_BLOCK();
    temp_expr = NEW_CODE_NODE(0x16,0,NEW_CODE_NODE(8,0,4,0),NEW_CODE_NODE(8,0,14,0));
    NEW_CODE_NODE(0x81,0,temp_expr,NEW_PLAIN_CODE_NODE(0x10,index_var,0));
    CNODE_W(cur,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(cur,CNODE_FIRST_OP);
    if ((CNODE_W(node,CNODE_FLAGS)&4)==0) {
        CNODE_W(cur,CNODE_JUMP_KIND) = 10;
        CNODE_W(cur,CNODE_TARGET) = table_block;
        step_block = NEW_BLOCK();
    } else {
        CNODE_W(cur,CNODE_JUMP_KIND) = 11;
        jump_block = NEW_BLOCK();
        high_offset = NEW_CODE_NODE(0x1F,0,NEW_CODE_NODE(8,0,4,0),NEW_CONSTANT_NODE(10,(long)(amount*2)));
        temp_expr = NEW_CODE_NODE(0x16,0,high_offset,NEW_CODE_NODE(8,0,14,0));
        NEW_CODE_NODE(0x81,0,temp_expr,NEW_PLAIN_CODE_NODE(0x10,index_var,2));
        CNODE_W(jump_block,CNODE_JUMP_KIND) = 10;
        CNODE_W(jump_block,CNODE_TARGET) = table_block;
        CNODE_W(jump_block,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(jump_block,CNODE_FIRST_OP);
        JOIN_BLOCK_CHAINS(cur,jump_block);
        step_block = NEW_BLOCK();
        CNODE_W(cur,CNODE_TARGET) = step_block;
    }
    temp_expr = NEW_CODE_NODE(8,0,4,0);
    NEW_CODE_NODE(0x1F,2,temp_expr,NEW_CONSTANT_NODE(10,2L));
    CNODE_W(step_block,CNODE_JUMP_KIND) = 0x17;
    CNODE_W(step_block,CNODE_TARGET) = cur;
    CNODE_W(step_block,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(step_block,CNODE_FIRST_OP);
    JOIN_BLOCK_CHAINS(cur,step_block);
    jump_block = NEW_JUMP_BLOCK(default_label,0,0,0,0);
    CNODE_W(jump_block,CNODE_KIND) = 4;
    CNODE_W(jump_block,CNODE_CASE_LIST) = value;
    JOIN_BLOCK_CHAINS(cur,jump_block);
    CNODE_W(table_block,CNODE_FIRST_OP) = CODE_OP_NEXT_INDEX;
    NEW_CONSTANT_NODE(0xAF,(long)((CNODE_W(node,CNODE_FLAGS)&4) ? amount*4 : amount*2));
    CNODE_W(table_block,CNODE_OP_COUNT) = 1;
    JOIN_BLOCK_CHAINS(cur,table_block);
    JOIN_BLOCK_CHAINS(setup_block,cur);
    SPLICE_BLOCK_CHAIN(node,setup_block,CNODE_W(node,CNODE_LOOP_WEIGHT));
    CNODE_W(setup_block,CNODE_JUMP_KIND) = 0;
}
#undef LOW
#undef HIGH

/* ---- STAOV071 (listing ovr_1d6c_a3dc:429A) ---- */
static unsigned int near pascal LOWER_SWITCH_JUMP_TABLE(unsigned int node, unsigned int value, unsigned int start, unsigned int end);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal NEW_BLOCK(void);
extern void far pascal JOIN_BLOCK_CHAINS(unsigned int, unsigned int);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int, long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);

/* LOWER_SWITCH_COMPARES: appends to block chain 'out' the compares for 'count' cases of
   switch block 'node' starting at case entry 'item' (_DI walks the cases). Up to three
   cases: compare and jump-if-equal for each (a long selector first skips on a different
   high word), then jump to the default. More cases: find the middle case and the span of
   values; if dense enough, hand the run to LOWER_SWITCH_JUMP_TABLE (with fresh copies of
   the selector ops, put back afterwards); otherwise test the middle value (jump if equal
   to its target), jump to the upper half when greater (kind 3, or 5 when unsigned), do
   the lower half recursively, and loop on the upper half. */
static void near pascal LOWER_SWITCH_COMPARES(unsigned int node, int count, unsigned int item, unsigned int out)
{
    unsigned int high_expr,low_expr,last_case,mid_case,span,lower_count,high_copy,low_copy,default_block,branch_block,skip_block;
    _DI = item;
    _BX = node;
    _ES = FLOW_BLOCK_POOL_SEG;
    _AX = ES_W(_BX,CNODE_SWITCH_HIGH_OP);
    _DX = ES_W(_BX,CNODE_SWITCH_LOW_OP);
    high_expr = _AX;
    low_expr = _DX;
    for (;;) {
        if (count <= 3) {
            for (lower_count=0; (int)lower_count < count;) {
                if (high_expr) {
                    skip_block = NEW_BLOCK();
                    _SI = NEW_BLOCK();
                    NEW_CODE_NODE(0x81,0,high_expr,NEW_CONSTANT_NODE(10,(long)(int)*((unsigned int far *)MK_FP(CASE_ENTRY_POOL_SEG,_DI+SWCASE_VALUE_HIGH))));
                    _ES = FLOW_BLOCK_POOL_SEG;
                    ES_W(_SI,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX-ES_W(_SI,CNODE_FIRST_OP);
                    ES_W(_SI,CNODE_JUMP_KIND) = 11;
                    ES_W(_SI,CNODE_TARGET) = skip_block;
                    JOIN_BLOCK_CHAINS(out,_SI);
                }
                _SI = NEW_BLOCK();
                NEW_CODE_NODE(0x81,0,low_expr,NEW_CONSTANT_NODE(10,*((long far *)MK_FP(CASE_ENTRY_POOL_SEG,_DI+SWCASE_VALUE))));
                _ES = FLOW_BLOCK_POOL_SEG;
                ES_W(_SI,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX-ES_W(_SI,CNODE_FIRST_OP);
                ES_W(_SI,CNODE_JUMP_KIND) = 10;
                _ES = CASE_ENTRY_POOL_SEG;
                _AX = ES_W(_DI,SWCASE_TARGET);
                _ES = FLOW_BLOCK_POOL_SEG;
                ES_W(_SI,CNODE_TARGET) = _AX;
                JOIN_BLOCK_CHAINS(out,_SI);
                if (high_expr) JOIN_BLOCK_CHAINS(out,skip_block);
                ++lower_count;
                _ES = CASE_ENTRY_POOL_SEG;
                _DI = ES_W(_DI,SWCASE_NEXT);
            }
            _BX = node;
            _ES = FLOW_BLOCK_POOL_SEG;
            default_block = NEW_JUMP_BLOCK(ES_W(_BX,CNODE_TARGET),0,0,0,0);
            JOIN_BLOCK_CHAINS(out,default_block);
            break;
        }
        lower_count = (unsigned int)count >> 1;
        last_case = _DI;
        for (span=1; span<(unsigned int)count;) {
            if (span-1 == lower_count) mid_case = last_case;
            ++span;
            _ES = CASE_ENTRY_POOL_SEG;
            _BX = last_case;
            last_case = ES_W(_BX,SWCASE_NEXT);
        }
        _BX = last_case;
        _ES = CASE_ENTRY_POOL_SEG;
        span = ES_W(_BX,SWCASE_VALUE)-ES_W(_DI,SWCASE_VALUE);
        if ((unsigned int)(count*3) >= span) {
            _SI = NEW_BLOCK();
            low_copy = NEW_CODE_NODE(0x99,0,low_expr,0);
            if (high_expr) high_copy = NEW_CODE_NODE(0x99,0,high_expr,0);
            else high_copy = 0;
            _BX = node;
            _ES = FLOW_BLOCK_POOL_SEG;
            _AX = high_copy;
            _DX = low_copy;
            ES_W(_BX,CNODE_SWITCH_HIGH_OP) = _AX;
            ES_W(_BX,CNODE_SWITCH_LOW_OP) = _DX;
            ES_W(_SI,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX-ES_W(_SI,CNODE_FIRST_OP);
            JOIN_BLOCK_CHAINS(out,_SI);
            _SI = LOWER_SWITCH_JUMP_TABLE(node,count,_DI,last_case);
            _BX = node;
            _ES = FLOW_BLOCK_POOL_SEG;
            _AX = high_expr;
            _DX = low_expr;
            ES_W(_BX,CNODE_SWITCH_HIGH_OP) = _AX;
            ES_W(_BX,CNODE_SWITCH_LOW_OP) = _DX;
            JOIN_BLOCK_CHAINS(out,_SI);
            break;
        }
        _SI = NEW_BLOCK();
        NEW_CODE_NODE(0x81,0,low_expr,NEW_CONSTANT_NODE(10,*((long far *)MK_FP(CASE_ENTRY_POOL_SEG,mid_case+SWCASE_VALUE))));
        _ES = FLOW_BLOCK_POOL_SEG;
        ES_W(_SI,CNODE_JUMP_KIND) = 10;
        _BX = mid_case;
        _ES = CASE_ENTRY_POOL_SEG;
        _AX = ES_W(_BX,SWCASE_TARGET);
        _ES = FLOW_BLOCK_POOL_SEG;
        ES_W(_SI,CNODE_TARGET) = _AX;
        ES_W(_SI,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX-ES_W(_SI,CNODE_FIRST_OP);
        branch_block = NEW_BLOCK();
        skip_block = NEW_BLOCK();
        if (SWITCH_BIT_200_FLAG) {
            _BX = branch_block;
            _ES = FLOW_BLOCK_POOL_SEG;
            ES_W(_BX,CNODE_JUMP_KIND) = 5;
        } else {
            _BX = branch_block;
            _ES = FLOW_BLOCK_POOL_SEG;
            ES_W(_BX,CNODE_JUMP_KIND) = 3;
        }
        _BX = branch_block;
        _ES = FLOW_BLOCK_POOL_SEG;
        ES_W(_BX,CNODE_TARGET) = skip_block;
        JOIN_BLOCK_CHAINS(_SI,branch_block);
        JOIN_BLOCK_CHAINS(out,_SI);
        LOWER_SWITCH_COMPARES(node,lower_count,_DI,out);
        JOIN_BLOCK_CHAINS(out,skip_block);
        count -= (int)(lower_count+1);
        _ES = CASE_ENTRY_POOL_SEG;
        _BX = mid_case;
        _DI = ES_W(_BX,SWCASE_NEXT);
    }
}

/* ---- STAOV072 (listing ovr_1d6c_a3dc:45A2) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal NEW_BLOCK(void);
extern void far pascal JOIN_BLOCK_CHAINS(unsigned int, unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int, long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])

/* LOWER_SWITCH_JUMP_TABLE: jump-table lowering of the 'value' cases from case entry
   'start' to 'end' of switch block 'node'; returns the first block made. The selector
   minus the first case value is checked (for a long selector the high word must become
   0, else jump to the default), loaded into BX and compared with end-start (jump to the
   default when above). The dispatch block is a switch block with CNODE_FLAGS 2, whose
   code EMIT_FUNCTION_BODY makes (SHL BX,1 and the jump through the table record kept at
   its offset 0x14), with the default as its jump for the flow passes. The case list is
   cut after 'end' (SWCASE_NEXT set to 0). */
static unsigned int near pascal LOWER_SWITCH_JUMP_TABLE(unsigned int node, unsigned int value,
                                     unsigned int start, unsigned int end)
{
    unsigned int operand_node,low_constant,table_node,head_block;
    unsigned long bounds;
    register unsigned int cur;
    head_block = NEW_BLOCK();
    bounds = *((unsigned long far *)MK_FP(FLOW_BLOCK_POOL_SEG,node+CNODE_SWITCH_LOW_OP));
    if (CNODE_W(node,CNODE_FLAGS)&4) {
        if (SWCASE_L(start,SWCASE_VALUE)) {
            operand_node = NEW_CONSTANT_NODE(10,(long)(int)SWCASE_W(start,SWCASE_VALUE_HIGH));
            low_constant = NEW_CONSTANT_NODE(10,SWCASE_L(start,SWCASE_VALUE));
            HIGH(bounds) = NEW_CODE_NODE(0x28,0,HIGH(bounds),operand_node);
            LOW(bounds) = NEW_CODE_NODE(0x30,0,LOW(bounds),low_constant);
        }
        operand_node = HIGH(bounds);
        NEW_CODE_NODE(0x4D,0,operand_node,operand_node);
        CNODE_W(head_block,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(head_block,CNODE_FIRST_OP);
        CNODE_W(head_block,CNODE_JUMP_KIND) = 0x0B;
        CNODE_W(head_block,CNODE_TARGET) = CNODE_W(node,CNODE_TARGET);
        cur = NEW_BLOCK();
    } else {
        if (SWCASE_L(start,SWCASE_VALUE)) {
            operand_node = NEW_CONSTANT_NODE(10,SWCASE_L(start,SWCASE_VALUE));
            LOW(bounds) = NEW_CODE_NODE(0x28,0,LOW(bounds),operand_node);
        }
        cur = head_block;
    }
    NEW_CODE_NODE(0xB6,0,LOW(bounds),0);
    LOW(bounds) = NEW_CODE_NODE(8,0,4,0);
    operand_node = NEW_CONSTANT_NODE(10,SWCASE_L(end,SWCASE_VALUE)-SWCASE_L(start,SWCASE_VALUE));
    NEW_CODE_NODE(0x81,0,LOW(bounds),operand_node);
    CNODE_W(cur,CNODE_JUMP_KIND) = 5;
    CNODE_W(cur,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(cur,CNODE_FIRST_OP);
    CNODE_W(cur,CNODE_TARGET) = CNODE_W(node,CNODE_TARGET);
    if (cur != head_block) JOIN_BLOCK_CHAINS(head_block,cur);
    cur = NEW_BLOCK();
    CNODE_W(cur,CNODE_KIND) = 4;
    CNODE_W(cur,CNODE_CASE_LIST) = start;
    SWCASE_W(end,SWCASE_NEXT) = 0;
    CNODE_W(cur,CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(cur,CNODE_FIRST_OP);
    CNODE_W(cur,CNODE_FLAGS) = 2;
    CNODE_W(cur,CNODE_JUMP_KIND) = 1;
    CNODE_W(cur,CNODE_TARGET) = CNODE_W(node,CNODE_TARGET);
    JOIN_BLOCK_CHAINS(head_block,cur);
    table_node = NEW_BLOCK();
    CNODE_W(table_node,CNODE_KIND) = 2;
    CNODE_W(table_node,CNODE_CASE_LIST) = start;
    CNODE_W(table_node,CNODE_CASE_COUNT) = value;
    CNODE_W(table_node,CNODE_TARGET) = CNODE_W(node,CNODE_TARGET);
    LINK_NODE(table_node);
    CNODE_W(cur,CNODE_SWITCH_TABLE) = table_node;
    return head_block;
}
#undef LOW
#undef HIGH

/* ---- STAOV073 (listing ovr_1d6c_a3dc:47E0) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char BCC_PACK_FLAG;
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_NODE_LABEL_HOOK)(unsigned int);
extern void (far pascal *EMIT_LABEL_WORD_HOOK)(unsigned int);
extern void (far pascal *BYTE_HOOK)(unsigned char);
#define VALUE_AT(r) (*((unsigned long far *)MK_FP(CASE_ENTRY_POOL_SEG, (r)+2)))

/* EMIT_SWITCH_VALUE_TABLE: emits the value table of a table-scan switch at the current
   position: word-aligned when BCC_PACK_FLAG is set, labelled with the record, then the
   low words of all case values, the high words for a long switch, then one label word
   per case target. */
static void near pascal EMIT_SWITCH_VALUE_TABLE(unsigned int node)
{
    unsigned long value;
    unsigned int head;
    int count;
    register unsigned int item;
    register int index;

    head = CNODE_W(node, CNODE_CASE_LIST);
    count = CNODE_W(node, CNODE_CASE_COUNT);
    if (BCC_PACK_FLAG)
        ALIGN_OUTPUT_HOOK(2);
    DEFINE_NODE_LABEL_HOOK(node);
    index = 0;
    item = head;
    while (index < count) {
        value = VALUE_AT(item);
        BYTE_HOOK((unsigned char)value);
        BYTE_HOOK(value >> 8);
        index++;
        item = SWCASE_W(item, SWCASE_NEXT);
    }
    if (CNODE_W(node, CNODE_FLAGS) & 4) {
        index = 0;
        item = head;
        while (index < count) {
            value = VALUE_AT(item);
            BYTE_HOOK(value >> 16);
            BYTE_HOOK(value >> 24);
            index++;
            item = SWCASE_W(item, SWCASE_NEXT);
        }
    }
    index = 0;
    item = head;
    while (index < count) {
        EMIT_LABEL_WORD_HOOK(SWCASE_W(item, SWCASE_TARGET));
        index++;
        item = SWCASE_W(item, SWCASE_NEXT);
    }
}
#undef VALUE_AT

/* ---- STAOV074 (listing ovr_1d6c_a3dc:48CC) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char BCC_PACK_FLAG;
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_NODE_LABEL_HOOK)(unsigned int);
extern void (far pascal *EMIT_LABEL_WORD_HOOK)(unsigned int);

/* EMIT_SWITCH_JUMP_TABLE: emits a jump table: one label word for every value from the
   first case to the last, the default target filling the gaps. */
static void near pascal EMIT_SWITCH_JUMP_TABLE(register unsigned int node)
{
    long position;
    long emitted;
    int count;
    register unsigned int item;

    item = CNODE_W(node, CNODE_CASE_LIST);
    count = CNODE_W(node, CNODE_CASE_COUNT);
    if (BCC_PACK_FLAG)
        ALIGN_OUTPUT_HOOK(2);
    DEFINE_NODE_LABEL_HOOK(node);
    emitted = 0L;
    position = SWCASE_L(item, SWCASE_VALUE);
    while (emitted < count) {
        while (SWCASE_L(item, SWCASE_VALUE) > position) {
            position++;
            EMIT_LABEL_WORD_HOOK(CNODE_W(node, CNODE_TARGET));
        }
        EMIT_LABEL_WORD_HOOK(SWCASE_W(item, SWCASE_TARGET));
        position++;
        emitted++;
        item = SWCASE_W(item, SWCASE_NEXT);
    }
}

/* ---- STAOV075 (listing ovr_1d6c_a3dc:4981) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* EMIT_SWITCH_TABLES: emits every table record on SWITCH_TABLE_LIST (kind 1 value table,
   otherwise jump table). */
void far pascal EMIT_SWITCH_TABLES(void)
{
    register unsigned int node;

    node = SWITCH_TABLE_LIST;
    while (node != 0) {
        if (*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node) == 1)
            EMIT_SWITCH_VALUE_TABLE(node);
        else
            EMIT_SWITCH_JUMP_TABLE(node);
        node = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[6];
    }
}
