/* target: ovr161_C104UNIT */
/* Role: instruction emitters (EMIT_INSN_*). Entry points: EMIT_INSN_NO_OPERANDS,
   EMIT_INSN_STACK_REG, EMIT_INSN_REG_STACK, EMIT_INSN_REG, EMIT_INSN_NODE,
   EMIT_INSN_REG_REG, EMIT_INSN_REG_NODE, EMIT_INSN_REG_IMM (+5 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO065 (ovr_1d98_aa29) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the bottom of the code generator's emit path. Every instruction the back end
   produces goes through one of the EMIT_INSN_* builders here: each fills the two operand
   records FIRST_ASM_OPERAND and SECOND_ASM_OPERAND (the same records the inline assembler
   uses) and passes an instruction number to EMIT_INSN_OPTIMIZED, which applies a few
   last-moment rewrites and calls EMIT_INSTRUCTION_HOOK (object bytes or assembly text,
   chosen by the output layer). Callers: EMITBLK.C, EMITBIN.C, EMITHIST.C, EMITHELP.C,
   EMITFPU.C, FRAME.C, SAVEREGS.C and others.
   An operand record is 9 bytes: kind word (0 none, 1 register, 2 offset of a symbol plus
   displacement, 3 segment of a symbol (both immediates the output layer fixes up, probably;
   CGCALL.C pushes op 12 then op 13 for a far address), 4 immediate, 5 memory), segment
   override register (+2, FIRST_OPERAND_SEG_REG), index register (+3), base or plain
   register (+4, FIRST_OPERAND_REG), displacement or immediate (+5, FIRST_OPERAND_VALUE),
   symbol (+7); 0xFF means no register. The struct Operand names those bytes byte2..byte4.
   Register numbers, probably: 0 AX, 2 DX, 4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES,
   13 DS, 14 CS, 15 SS. Instruction numbers share the numbering of code ops
   (CODE_OP_INFO_TABLE); probable meanings are given where the code shows them.
   OPERAND_FROM_NODE turns a code op (with its assigned register, variable, frame offset
   or address arithmetic) into an operand record; ADD_NODE_TO_OPERAND folds address
   arithmetic (constants, variables, op 31 additions) into one record. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"

struct Operand {
    unsigned int kind;
    signed char byte2,byte3,byte4;
    int number;
    unsigned int symbol;
};
extern struct Operand FIRST_ASM_OPERAND,SECOND_ASM_OPERAND;



/* ---- EMIT_INSN_NO_OPERANDS (listing ovr_1d98_aa29:A290) ---- */
void far pascal EMIT_INSN_NO_OPERANDS(unsigned int value);
static void near pascal EMIT_INSN_OPTIMIZED(register int kind);

/* EMIT_INSN_NO_OPERANDS: emits instruction 'value' with no operands. */
void far pascal EMIT_INSN_NO_OPERANDS(unsigned int value)
{
    FIRST_ASM_OPERAND.kind = 0;
    SECOND_ASM_OPERAND.kind = 0;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_STACK_REG (listing ovr_1d98_aa29:A2A9) ---- */
void far pascal EMIT_INSN_STACK_REG(unsigned int value1, unsigned int value2, unsigned char value3);

/* EMIT_INSN_STACK_REG: emits instruction 'value1' with operands [BP+value2] (register 10
   as base, no index, no segment override) and register 'value3'. */
void far pascal EMIT_INSN_STACK_REG(unsigned int value1, unsigned int value2, unsigned char value3)
{
    RTL_MEMSET(&FIRST_ASM_OPERAND, 0, 9);
    FIRST_OPERAND_INDEX_REG = 0xFF;
    FIRST_OPERAND_SEG_REG = 0xFF;
    FIRST_ASM_OPERAND.kind = 5;
    FIRST_OPERAND_REG = 10;
    FIRST_OPERAND_VALUE = value2;
    SECOND_ASM_OPERAND.kind = 1;
    SECOND_OPERAND_REG = value3;
    EMIT_INSN_OPTIMIZED(value1);
}

/* ---- EMIT_INSN_REG_STACK (listing ovr_1d98_aa29:A2EE) ---- */
void far pascal EMIT_INSN_REG_STACK(unsigned int value1, unsigned char value2, unsigned int value3);


/* EMIT_INSN_REG_STACK: the reverse order: register 'value2', then [BP+value3]. */
void far pascal EMIT_INSN_REG_STACK(unsigned int value1, unsigned char value2, unsigned int value3)
{
    RTL_MEMSET(&SECOND_ASM_OPERAND, 0, 9);
    SECOND_OPERAND_INDEX_REG = 0xFF;
    SECOND_OPERAND_SEG_REG = 0xFF;
    SECOND_ASM_OPERAND.kind = 5;
    SECOND_OPERAND_REG = 10;
    SECOND_OPERAND_VALUE = value3;
    FIRST_ASM_OPERAND.kind = 1;
    FIRST_OPERAND_REG = value2;
    EMIT_INSN_OPTIMIZED(value1);
}

/* ---- EMIT_INSN_REG (listing ovr_1d98_aa29:A333) ---- */
void far pascal EMIT_INSN_REG(unsigned int value, unsigned char mode);

/* EMIT_INSN_REG: emits instruction 'value' with the single register operand 'mode'. */
void far pascal EMIT_INSN_REG(unsigned int value, unsigned char mode)
{
    FIRST_ASM_OPERAND.kind = 1;
    FIRST_OPERAND_REG = mode;
    SECOND_ASM_OPERAND.kind = 0;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_NODE (listing ovr_1d98_aa29:A352) ---- */
void far pascal EMIT_INSN_NODE(unsigned int first, unsigned int second);
static void near pascal OPERAND_FROM_NODE(char near *output,unsigned int node);

/* EMIT_INSN_NODE: emits instruction 'first' whose one operand is code op 'second' (an op
   number), converted by OPERAND_FROM_NODE. */
void far pascal EMIT_INSN_NODE(unsigned int first, unsigned int second)
{
    OPERAND_FROM_NODE((char near *)&FIRST_ASM_OPERAND, second);
    SECOND_ASM_OPERAND.kind = 0;
    EMIT_INSN_OPTIMIZED(first);
}

/* ---- EMIT_INSN_REG_REG (listing ovr_1d98_aa29:A36F) ---- */
void far pascal EMIT_INSN_REG_REG(unsigned int value, signed char second, signed char third);

/* EMIT_INSN_REG_REG: emits 'value' with register operands 'second' (destination) and
   'third'. When both are segment registers (12 and up) there is no such move on the x86,
   so it becomes PUSH third / POP second (0x94 / 0x7F), or nothing if they are the same. */
void far pascal EMIT_INSN_REG_REG(unsigned int value, signed char second, signed char third)
{
    if (second >= 12 && third >= 12) {
        if (second != third) {
            EMIT_INSN_REG(0x94,(unsigned char)third);
            EMIT_INSN_REG(0x7F,(unsigned char)second);
        }
        return;
    }
    FIRST_ASM_OPERAND.kind = 1;
    FIRST_OPERAND_REG = second;
    SECOND_ASM_OPERAND.kind = 1;
    SECOND_OPERAND_REG = third;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_REG_NODE (listing ovr_1d98_aa29:A3C2) ---- */
void far pascal EMIT_INSN_REG_NODE(unsigned int value,unsigned char mode,unsigned int flags);
/* EMIT_INSN_REG_NODE: emits 'value' with register 'mode' and code op 'flags' (an op
   number, despite the name). When the op turns out to sit in a register it goes through
   EMIT_INSN_REG_REG so segment-register moves are handled. */
void far pascal EMIT_INSN_REG_NODE(unsigned int value,unsigned char mode,unsigned int flags)
{
    register unsigned int saved=value;
    FIRST_ASM_OPERAND.kind=1;
    FIRST_OPERAND_REG=mode;
    OPERAND_FROM_NODE((char near *)&SECOND_ASM_OPERAND,flags);
    if(SECOND_ASM_OPERAND.kind==1) EMIT_INSN_REG_REG(saved,FIRST_OPERAND_REG,SECOND_OPERAND_REG);
    else EMIT_INSN_OPTIMIZED(saved);
}

/* ---- EMIT_INSN_REG_IMM (listing ovr_1d98_aa29:A3FE) ---- */
void far pascal EMIT_INSN_REG_IMM(unsigned int value, unsigned char mode, unsigned int detail);

/* EMIT_INSN_REG_IMM: emits 'value' with register 'mode' and immediate 'detail'. */
void far pascal EMIT_INSN_REG_IMM(unsigned int value, unsigned char mode, unsigned int detail)
{
    FIRST_ASM_OPERAND.kind = 1;
    FIRST_OPERAND_REG = mode;
    SECOND_ASM_OPERAND.kind = 4;
    SECOND_OPERAND_VALUE = detail;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_NODE_REG (listing ovr_1d98_aa29:A423) ---- */
void far pascal EMIT_INSN_NODE_REG(unsigned int value, unsigned int index, unsigned char mode);

/* EMIT_INSN_NODE_REG: emits 'value' with code op 'index' then register 'mode'. */
void far pascal EMIT_INSN_NODE_REG(unsigned int value, unsigned int index, unsigned char mode)
{
    OPERAND_FROM_NODE((char near *)&FIRST_ASM_OPERAND, index);
    SECOND_ASM_OPERAND.kind = 1;
    SECOND_OPERAND_REG = mode;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_NODE_NODE (listing ovr_1d98_aa29:A446) ---- */
void far pascal EMIT_INSN_NODE_NODE(unsigned int third, unsigned int second, unsigned int first);

/* EMIT_INSN_NODE_NODE: emits instruction 'third' with code ops 'second' (first operand)
   and 'first' (second operand); the parameter names count from the right. */
void far pascal EMIT_INSN_NODE_NODE(unsigned int third, unsigned int second, unsigned int first)
{
    OPERAND_FROM_NODE((char near *)&FIRST_ASM_OPERAND, second);
    OPERAND_FROM_NODE((char near *)&SECOND_ASM_OPERAND, first);
    EMIT_INSN_OPTIMIZED(third);
}

/* ---- EMIT_INSN_NODE_IMM (listing ovr_1d98_aa29:A467) ---- */
void far pascal EMIT_INSN_NODE_IMM(unsigned int value, unsigned int index, unsigned int detail);

/* EMIT_INSN_NODE_IMM: emits 'value' with code op 'index' and immediate 'detail'. */
void far pascal EMIT_INSN_NODE_IMM(unsigned int value, unsigned int index, unsigned int detail)
{
    OPERAND_FROM_NODE((char near *)&FIRST_ASM_OPERAND, index);
    SECOND_ASM_OPERAND.kind = 4;
    SECOND_OPERAND_VALUE = detail;
    EMIT_INSN_OPTIMIZED(value);
}

/* ---- EMIT_INSN_LOCAL (listing ovr_1d98_aa29:A48A) ---- */
void far pascal EMIT_INSN_LOCAL(unsigned int value1, unsigned int value2);
extern unsigned int VARIABLE_TABLE_SEG;


/* EMIT_INSN_LOCAL: emits 'value1' with one operand, the frame slot [BP+offset] of
   variable-table entry 'value2' (VAR_FRAME_OFFSET). Used for 8087 spill temporaries
   (EMITHIST.C). */
void far pascal EMIT_INSN_LOCAL(unsigned int value1, register unsigned int value2)
{
    RTL_MEMSET(&FIRST_ASM_OPERAND, 0, 9);
    FIRST_ASM_OPERAND.kind = 5;
    FIRST_OPERAND_REG = 10;
    FIRST_OPERAND_INDEX_REG = 0xFF;
    FIRST_OPERAND_SEG_REG = 0xFF;
    FIRST_OPERAND_VALUE = *((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG, value2 + VAR_FRAME_OFFSET));
    SECOND_ASM_OPERAND.kind = 0;
    EMIT_INSN_OPTIMIZED(value1);
}

/* ---- EMIT_INSN_OPTIMIZED (listing ovr_1d98_aa29:A4D3) ---- */
static void near pascal FLUSH_PENDING_MARKER(register unsigned int kind);
extern struct Operand  INSN_9C_DEFERRED_OPERAND;
extern signed char INSN_57_PENDING,INSN_9C_DEFERRED;
extern void (far pascal *EMIT_INSTRUCTION_HOOK)(unsigned int);

/* EMIT_INSN_OPTIMIZED: last-moment rewrites of instruction 'kind' with the operands
   already in FIRST_ASM_OPERAND/SECOND_ASM_OPERAND, then the output hook. Two
   instructions are held back instead of emitted at once:
   - a 'MOV ES,memory' (0x98/0x99/0x9C with register 12 and a memory operand) is kept in
     INSN_9C_DEFERRED_OPERAND; if the next instruction is MOV word reg,[same address-2]
     the pair becomes LES reg,[address] (0x96), otherwise the held move is emitted first
     (the current operands are saved around it);
   - FWAIT (0x57) is only noted in INSN_57_PENDING and emitted by FLUSH_PENDING_MARKER
     before the next instruction that needs it.
   The other rewrites are size optimisations: compare with 0 becomes 0x4C/0x4D (probably
   OR or TEST of the register with itself), MOV reg,0 becomes 0x4F (probably XOR), a move
   of a register to itself is dropped, ADD/SUB by 1, -1 (and 2 for word registers) become
   INC/DEC instructions, and 0xAE/0xB1 emit nothing. */
static void near pascal EMIT_INSN_OPTIMIZED(register int kind)
{
    unsigned char saved[27];
    if(INSN_9C_DEFERRED) {
        if(kind==0x9C && INSN_9C_DEFERRED_OPERAND.byte4==SECOND_ASM_OPERAND.byte4 &&
           INSN_9C_DEFERRED_OPERAND.byte3==SECOND_ASM_OPERAND.byte3 && INSN_9C_DEFERRED_OPERAND.byte2==SECOND_ASM_OPERAND.byte2 &&
           INSN_9C_DEFERRED_OPERAND.symbol==SECOND_ASM_OPERAND.symbol && SECOND_ASM_OPERAND.number+2==INSN_9C_DEFERRED_OPERAND.number)
            kind=0x96;
        else {
            RTL_MEMMOVE(saved,&FIRST_ASM_OPERAND,27);
            FIRST_ASM_OPERAND.kind=1;
            FIRST_OPERAND_REG=12;
            SECOND_ASM_OPERAND=INSN_9C_DEFERRED_OPERAND;
            EMIT_INSTRUCTION_HOOK(0x9C);
            RTL_MEMMOVE(&FIRST_ASM_OPERAND,saved,27);
        }
        INSN_9C_DEFERRED=0;
    }
    switch(kind) {
    case 0x57:
        INSN_57_PENDING=1;
        return;
    case 0x80: case 0x81:
        if(FIRST_ASM_OPERAND.kind==1 && SECOND_ASM_OPERAND.kind==4 && SECOND_ASM_OPERAND.number==0) {
            kind+=-0x34;
            SECOND_ASM_OPERAND.kind=1;
            SECOND_ASM_OPERAND.byte4=FIRST_OPERAND_REG;
        }
        break;
    case 0x93:
        kind=0x94;
        break;
    case 0x98: case 0x99: case 0x9C:
        if(FIRST_ASM_OPERAND.kind==1 && FIRST_OPERAND_REG==12 && SECOND_ASM_OPERAND.kind==5) {
            INSN_9C_DEFERRED_OPERAND=SECOND_ASM_OPERAND;
            INSN_9C_DEFERRED=1;
            return;
        }
        if(FIRST_ASM_OPERAND.kind==1 && SECOND_ASM_OPERAND.kind==4 && SECOND_ASM_OPERAND.number==0) {
            kind=0x4F;
            SECOND_ASM_OPERAND.kind=1;
            SECOND_ASM_OPERAND.byte4=FIRST_OPERAND_REG;
            break;
        }
    case 0x97: case 0x9B:
        /* MOV between registers: drop a move to the same register; a byte move whose source is
           register 8 or above (no byte form) is made a word MOV (0x9C). The self-assignment of
           FIRST_OPERAND_REG is a shape kept for byte matching. */
        if(FIRST_ASM_OPERAND.kind==1 && SECOND_ASM_OPERAND.kind==1) {
            if((signed char)FIRST_OPERAND_REG==SECOND_ASM_OPERAND.byte4) return;
            if(kind!=0x9C && kind!=0x98 && SECOND_ASM_OPERAND.byte4>7) {
                kind=0x9C;
                FIRST_OPERAND_REG=FIRST_OPERAND_REG;
            }
        }
        break;
    /* ADD byte/word (0x1E/0x1F) by 1 -> INC (0x58/0x59); word register by 2 -> two INCs (one
       emitted by the recursive call, one by the normal path); by -1 -> DEC (0x5A/0x5B). */
    case 0x1E: case 0x1F:
        if(SECOND_ASM_OPERAND.kind==4) {
            if(SECOND_ASM_OPERAND.number==1) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x3A;
            } else if(SECOND_ASM_OPERAND.number==2 && FIRST_ASM_OPERAND.kind==1 && kind==0x1F) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x3A;
                EMIT_INSN_OPTIMIZED(kind);
            } else if(SECOND_ASM_OPERAND.number==-1) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x3C;
            }
        }
        break;
    /* SUB byte/word (0x27/0x28): the same with INC and DEC exchanged. */
    case 0x27: case 0x28:
        if(SECOND_ASM_OPERAND.kind==4) {
            if(SECOND_ASM_OPERAND.number==1) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x33;
            } else if(SECOND_ASM_OPERAND.number==2 && FIRST_ASM_OPERAND.kind==1 && kind==0x28) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x33;
                EMIT_INSN_OPTIMIZED(kind);
            } else if(SECOND_ASM_OPERAND.number==-1) {
                SECOND_ASM_OPERAND.kind=0;
                kind+=0x31;
            }
        }
        break;
    case 0xAE: case 0xB1:
        return;
    }
    FLUSH_PENDING_MARKER(kind);
    EMIT_INSTRUCTION_HOOK(kind);
}

/* ---- FLUSH_PENDING_MARKER (listing ovr_1d98_aa29:A775) ---- */
extern signed char INSN_57_PENDING;
extern void (far pascal *EMIT_INSTRUCTION_HOOK)(unsigned int);

/* FLUSH_PENDING_MARKER: if an FWAIT is pending, decides before instruction 'kind' whether
   it must be emitted now: when 'kind' touches memory (an operand of kind 5), is one of
   0x7E, 0x7F (POP), 0xA1, 0xA2, 0xA3, or uses register 11 (SP). The FWAIT itself is
   skipped when 'kind' has table flag 2 (probably an 8087 instruction, which waits by
   itself); either way the pending mark is then cleared. */
static void near pascal FLUSH_PENDING_MARKER(register unsigned int kind)
{
    unsigned int first,second;
    register unsigned char near *description;
    if(!INSN_57_PENDING) return;
    description=CODE_OP_INFO_TABLE-3+kind*19;
    if(FIRST_ASM_OPERAND.kind==5 || SECOND_ASM_OPERAND.kind==5 || kind==0x7E || kind==0x7F ||
       kind==0xA3 || kind==0xA2 || kind==0xA1 ||
       (FIRST_ASM_OPERAND.kind==1 && FIRST_OPERAND_REG==11)) {
        if((*((unsigned long near *)(description+3))&2L)==0L) {
            first=FIRST_ASM_OPERAND.kind;
            second=SECOND_ASM_OPERAND.kind;
            FIRST_ASM_OPERAND.kind=0;
            SECOND_ASM_OPERAND.kind=0;
            EMIT_INSTRUCTION_HOOK(0x57);
            FIRST_ASM_OPERAND.kind=first;
            SECOND_ASM_OPERAND.kind=second;
        }
        INSN_57_PENDING=0;
    }
}

/* ---- OPERAND_FROM_NODE (listing ovr_1d98_aa29:A815) ---- */
static void near pascal ASSIGN_NODE_REGISTER(unsigned int value);
static void near pascal ADD_NODE_TO_OPERAND(register struct Operand near *output,unsigned int node);
static void near pascal SET_SEGMENT_OVERRIDE(register unsigned int node, unsigned char value);
extern unsigned int VARIABLE_TABLE_SEG;
#define OW(n) (*((unsigned int near *)(output+(n))))
#define OB(n) (*((signed char near *)(output+(n))))

/* OPERAND_FROM_NODE: fills the 9-byte operand record at 'output' (OW/OB read and write its
   words and bytes) for code op 'node' (an op number). An op with an assigned register is
   a register operand. Otherwise by opcode: register ops 7/8; 0xB2 a stack slot relative
   to the frame; 13/0x7C the address of a variable (its BP-relative frame slot for autos
   and parameters, which EMITBLK.C turns into LEA, else the symbol's offset); 12/0x7B the
   segment of a symbol; 15-20 and calls 0x77/0x78 a variable
   with offset, or the register of a register variable (VAR_FLAGS 2), whose number is
   adjusted by the op's register class for byte or 8087 forms; 14 the parameter area;
   21-27 an indirect operand built from the address op, with the right operand's register
   as segment override (27 reads the word at +2); 9-11 an immediate. */
static void near pascal OPERAND_FROM_NODE(char near *output,unsigned int node)
{
    unsigned int child,symbol;
    unsigned int cell;
    RTL_MEMSET(output,0,9);
    OB(2)=-1;
    OB(4)=-1;
    OB(3)=-1;
    cell=node*4;
    if (COP_B(cell,COP_REGISTER)!=0xFF) {
        OW(0)=1;
        OB(4)=COP_B(cell,COP_REGISTER);
        return;
    }
    switch (COP_B(cell,COP_OPCODE)) {
    case 7: case 8:
        OW(0)=1;
        OB(4)=OPND_B(cell,OPND_LEFT);
        return;
    case 0xB2:
        OW(5)=OPND_W(cell,OPND_LEFT)-FRAME_LOCALS_SIZE-FRAME_PUSHED_REG_BYTES;
        OB(4)=10;
        break;
    case 13: case 0x7C:
        OW(0)=2;
        OW(5)=OPND_W(cell,OPND_RIGHT);
        if (VAR_B(OPND_W(cell,OPND_LEFT),VAR_SYMBOL_KIND)==5 ||
            VAR_B(OPND_W(cell,OPND_LEFT),VAR_SYMBOL_KIND)==6) {
            OB(4)=10;
            OW(5)=OW(5)+VAR_W(OPND_W(cell,OPND_LEFT),VAR_FRAME_OFFSET);
            break;
        }
        OW(7)=VAR_W(OPND_W(cell,OPND_LEFT),VAR_SYMBOL);
        return;
    case 12: case 0x7B:
        OW(0)=3;
        OW(7)=VAR_W(OPND_W(cell,OPND_LEFT),VAR_SYMBOL);
        return;
    case 15: case 16: case 17: case 18: case 19: case 20: case 0x77: case 0x78:
        symbol=OPND_W(cell,OPND_LEFT);
        if (VAR_B(symbol,VAR_SYMBOL_KIND)==5 || VAR_B(symbol,VAR_SYMBOL_KIND)==6) {
            if (VAR_B(symbol,VAR_FLAGS)&2) {
                OB(4)=VAR_B(symbol,VAR_REGISTER);
                OW(0)=1;
                if ((*((unsigned long near *)(CODE_OP_INFO_TABLE+COP_B(cell,COP_OPCODE)*19))&2L) || OB(4)>=16)
                    OB(4)=(COP_B(cell,COP_REG_CLASS)&0x3F)+OB(4)+0xF0;
                return;
            }
            OW(5)=OPND_W(cell,OPND_RIGHT)+VAR_W(symbol,VAR_FRAME_OFFSET);
            OB(4)=10;
            break;
        }
        OW(7)=VAR_W(OPND_W(cell,OPND_LEFT),VAR_SYMBOL);
        OW(5)=OPND_W(cell,OPND_RIGHT);
        break;
    case 14:
        OW(5)=CODEGEN_PARAMS_SIZE+PARAM_FRAME_BASE;
        OB(4)=10;
        break;
    case 21: case 22: case 23: case 24: case 25: case 26: case 27:
        ADD_NODE_TO_OPERAND((struct Operand near *)output,OPND_W(cell,OPND_LEFT));
        if (COP_B(cell,COP_OPCODE)==27) OW(5)+=2;
        if (OPND_W(cell,OPND_RIGHT)) {
            child=OPND_W(cell,OPND_RIGHT)*4;
            ASSIGN_NODE_REGISTER(child);
            SET_SEGMENT_OVERRIDE((unsigned int)output,COP_B(child,COP_REGISTER));
        }
        /* Drop a segment override that equals the default: DS (13) unless the base is BP, SS
           (15) when the base is BP. */
        if (OB(2)==13) {
            if (OB(4)!=10) OB(2)=-1;
        } else if (OB(2)==15 && OB(4)==10) OB(2)=-1;
        break;
    case 9: case 10: case 11:
        OW(0)=4;
        OW(5)=OPND_W(cell,OPND_LEFT);
        return;
    }
    OW(0)=5;
}
#undef OW
#undef OB

/* ---- ASSIGN_NODE_REGISTER (listing ovr_1d98_aa29:AAD7) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* ASSIGN_NODE_REGISTER: for op record 'value' (offset, not number) with no register yet,
   copies in the register of a register op (8) or of a register variable named by a leaf
   op 0x10/0x11 (VAR_FLAGS 2, register at VAR_REGISTER). Written with _SI/_AL to match the
   original code. */
static void near pascal ASSIGN_NODE_REGISTER(unsigned int value)
{
    _SI = value;
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + COP_REGISTER)) != 0xFF)
        return;
    if (*((unsigned char far *)MK_FP(_ES, _SI)) == 8) {
        _AL = *((unsigned char far *)MK_FP(CODE_OPERAND_POOL_SEG, _SI));
    } else {
        _ES = CODE_OP_POOL_SEG;
        if (*((unsigned char far *)MK_FP(_ES, _SI)) != 0x10 &&
            *((unsigned char far *)MK_FP(_ES, _SI)) != 0x11)
            return;
        if ((*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, _SI)) + 0x0E)) & 2) == 0)
            return;
        _AL = *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, _SI)) + 7));
    }
    *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, _SI + COP_REGISTER)) = _AL;
}

/* ---- ADD_NODE_TO_OPERAND (listing ovr_1d98_aa29:AB38) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* ADD_NODE_TO_OPERAND: adds address op 'node' (an op number) into operand record
   'output': a register op gives the base (BP 10 or BX 4) or index (SI 8 or DI 9); a
   constant adds to the displacement; a variable address (13) adds its frame offset with BP
   as base, or sets the symbol; op 31 (probably address addition) adds both sides
   recursively. */
static void near pascal ADD_NODE_TO_OPERAND(register struct Operand near *output,unsigned int node)
{
    register unsigned int cursor;
    cursor=node*4;
    ASSIGN_NODE_REGISTER(cursor);
    if(COP_B(cursor,COP_REGISTER)!=0xFF) {
        if(COP_B(cursor,COP_REGISTER)==10) output->byte4=COP_B(cursor,COP_REGISTER);
        else if(COP_B(cursor,COP_REGISTER)==4) output->byte4=COP_B(cursor,COP_REGISTER);
        else if(COP_B(cursor,COP_REGISTER)==8) output->byte3=COP_B(cursor,COP_REGISTER);
        else if(COP_B(cursor,COP_REGISTER)==9) output->byte3=COP_B(cursor,COP_REGISTER);
        return;
    }
    switch((int)COP_B(cursor,COP_OPCODE)) {
    case 9: case 10: case 11:
        output->number+=OPND_W(cursor,OPND_LEFT);
        break;
    case 13:
        output->number+=OPND_W(cursor,OPND_RIGHT);
        if(VAR_B(OPND_W(cursor,OPND_LEFT),VAR_SYMBOL_KIND)==5 || VAR_B(OPND_W(cursor,OPND_LEFT),VAR_SYMBOL_KIND)==6) {
            output->byte4=10;
            output->number+=VAR_W(OPND_W(cursor,OPND_LEFT),VAR_FRAME_OFFSET);
        } else
            output->symbol=VAR_W(OPND_W(cursor,OPND_LEFT),VAR_SYMBOL);
        break;
    case 31:
        ADD_NODE_TO_OPERAND(output,*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,cursor)));
        ADD_NODE_TO_OPERAND(output,*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,cursor+OPND_RIGHT)));
        break;
    }
}

/* ---- SET_SEGMENT_OVERRIDE (listing ovr_1d98_aa29:AC5F) ---- */
/* SET_SEGMENT_OVERRIDE: stores 'value' at byte 2 of the operand record at 'node'. Byte 2 is
   the segment override register (FIRST_OPERAND_SEG_REG sits at operand+2), so this
   sets the segment override, not the index register. */
static void near pascal SET_SEGMENT_OVERRIDE(register unsigned int node, unsigned char value)
{
    *((unsigned char near *)(node + 2)) = value;
}

/* ---- INVERT_JUMP_KIND (listing ovr_1d98_aa29:AC73) ---- */
unsigned int far pascal INVERT_JUMP_KIND(unsigned int index);

/* INVERT_JUMP_KIND: returns the jump kind with the opposite condition, from the table
   INVERTED_JUMP_KIND. */
unsigned int far pascal INVERT_JUMP_KIND(unsigned int index)
{
    return INVERTED_JUMP_KIND[index];
}
