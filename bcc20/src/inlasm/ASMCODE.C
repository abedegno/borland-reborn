/* target: ovr142_C84UNIT */
/* Role: code-byte emitter and inline-asm instruction encoder. Entry points: EMIT_CODE_BYTE,
   EMIT_CODE_WORD, DEFINE_ASM_LABEL, ADD_ASM_JUMP, EMIT_THIS_ADJUST_THUNK, OPEN_OUTPUT_FILE,
   EMIT_SWITCH_JUMP, EMIT_SWITCH_TABLE_LOAD (+5 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO054 record142: STOVR142..STOVR167 (inline assembler encoder). */
/* opts: -mm -G -O -Z -p -Y -B -TjNOSMART -Tm2 */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"

/* Overview: the machine-code side of instruction output, used when BCC writes an object
   file directly. The code generator (EMITINSN.C) and the inline assembler describe each
   instruction the same way: an opcode number (an index into OPCODE_DESCRIPTOR_TABLE)
   and two operand records, FIRST_ASM_OPERAND (LEFT) and SECOND_ASM_OPERAND (RIGHT). In
   object mode the output hook table points here and ENCODE_ASM_INSTRUCTION turns that
   description into bytes; in assembly mode the same calls reach ASMTEXT.C, which prints
   the instruction instead. Most functions here have such a text twin (EMIT_SWITCH_JUMP
   and EMIT_SWITCH_JUMP_ASM, OPEN_OUTPUT_FILE and CREATE_ASM_OUTPUT, ...).
   Code bytes go to the code buffer CODE_BYTE_POOL_SEG (EMIT_CODE_BYTE/WORD), which grows
   past OUTPUT_BUFFER_LIMIT through POOL_ALLOC, and the selected segment's size grows
   with them. Addresses not known yet become fixups (ADD_FIXUP, by kind: 1 offset of a
   symbol, 3 its segment, 5 offset of a code label or switch table, 6 near call
   (self-relative), 7 far address, 10 the data group's segment, 11 a named external,
   16 the location's own offset).
   Operand record: kind (1 register, 2 offset of a symbol, 3 segment of a symbol,
   4 immediate, 5 memory), index (segment override register), scale (index register),
   reg (register, or base register), offset (immediate or displacement), symbol.
   Register numbers 12..15 are ES, DS, CS, SS (see SEGMENT_PREFIX_OFFSET);
   REGISTER_ENCODING_TABLE maps a register number to its 3-bit machine encoding.
   x87 instructions (descriptor flag 2) under the emulator get an FWAIT (9Bh) and named
   fixups to FIDRQQ, FIERQQ, FIARQQ/FJARQQ and similar symbols in front, so that the
   emulator library can patch them at link time. */
struct Operand { unsigned int kind; signed char index,scale,reg; unsigned int offset,symbol; };
struct Descriptor { char near *name; unsigned char pad; long flags; unsigned char reserved7[6]; unsigned int prefix,opcode,mode; };
struct HookTable { unsigned char bytes[96]; };

extern unsigned int CODE_BYTE_POOL_SEG;
extern unsigned int STRING_POOL_SEG;
extern unsigned char OPTION_MEMORY_MODEL,OPTION_TARGET_CPU;
extern struct HookTable EMIT_DEPENDENCY_HOOK,OBJ_OUTPUT_DEFAULT_HOOKS;
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
extern struct Operand FIRST_ASM_OPERAND,SECOND_ASM_OPERAND;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);

extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern void far pascal DEFINE_LABEL(unsigned int);
extern void far pascal ADD_JUMP(unsigned int,unsigned int,unsigned int);
extern void far pascal ADD_FIXUP(unsigned int,unsigned int);
extern void far pascal EMIT_DATA_BYTE(unsigned char);
extern void far pascal ADD_RELOCATION(unsigned int,unsigned int);
extern void far pascal EMIT_WORD_RELOC(unsigned int,unsigned int);
extern void far pascal EMIT_DWORD_RELOC(unsigned int,unsigned int);
extern char far * far pascal STRING_COPY(char far *,char far *);
extern void far pascal STRING_APPEND(char far *,char far *);
extern int far pascal CREATE_OUTPUT_FILE(char far *);
extern void far cdecl REPORT_FATAL(unsigned int,char far *);
extern void far pascal OBJ_WRITE_MODULE_HEADER(char far *);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);

static void near pascal ADD_FIXUP_KIND(signed char kind,unsigned int node);
static signed char near pascal OPERAND_SEGMENT_OVERRIDE(struct Operand near *operand);
static int near pascal SEGMENT_PREFIX_OFFSET(signed char kind);
static int near pascal ENCODE_IMMEDIATE_FORM(int opcode,struct Descriptor far *desc);
static void near pascal EMIT_IMMEDIATE_OPERAND(int mode);
static void near pascal EMIT_MODRM(struct Operand near *operand,unsigned int format);

/* Appends one byte to the code buffer and grows the selected segment's size by 1. */
void far pascal EMIT_CODE_BYTE(unsigned char value)
{
    if(OUTPUT_BUFFER_POS>=OUTPUT_BUFFER_LIMIT)
        *(unsigned char far *)MK_FP(CODE_BYTE_POOL_SEG,POOL_ALLOC(&CODE_BYTE_POOL_SEG,1))=value;
    else {
        ((unsigned char far *)MK_FP(CODE_BYTE_POOL_SEG,0))[OUTPUT_BUFFER_POS]=value;
        ++OUTPUT_BUFFER_POS;
    }
    ++*(unsigned long far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE);
}

/* Appends a little-endian word to the code buffer; segment size grows by 2. */
void far pascal EMIT_CODE_WORD(unsigned int value)
{
    register unsigned int word=value;
    if((unsigned int)(OUTPUT_BUFFER_POS+1)>=OUTPUT_BUFFER_LIMIT) {
        *(unsigned int far *)MK_FP(CODE_BYTE_POOL_SEG,POOL_ALLOC(&CODE_BYTE_POOL_SEG,2))=word;
    } else {
        *(unsigned int far *)MK_FP(CODE_BYTE_POOL_SEG,OUTPUT_BUFFER_POS)=word;
        OUTPUT_BUFFER_POS+=2;
    }
    *(unsigned long far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE)+=2;
}

/* Machine encoding (0..7) of register number kind. */
static int near pascal REGISTER_ENCODING(signed char kind)
{
    return REGISTER_ENCODING_TABLE[kind];
}

/* Object-mode hook entries passing straight on to DEFINE_LABEL and ADD_JUMP; the small
   ADD_*_FIXUP helpers below just name the fixup kinds. */
void far pascal DEFINE_ASM_LABEL(unsigned int node)
{
    DEFINE_LABEL(node);
}

void far pascal ADD_ASM_JUMP(unsigned int kind,unsigned int node,unsigned int flag)
{
    ADD_JUMP(kind,node,flag);
}

static void near pascal ADD_OFFSET_FIXUP(unsigned int node)
{
    ADD_FIXUP_KIND(1,node);
}

static void near pascal ADD_FAR_CALL_FIXUP(unsigned int node)
{
    ADD_FIXUP_KIND(7,node);
}

static void near pascal ADD_NEAR_CALL_FIXUP(unsigned int node)
{
    ADD_FIXUP_KIND(6,node);
}

static void near pascal ADD_FIXUP_KIND_3(unsigned int node)
{
    ADD_FIXUP_KIND(3,node);
}

static void near pascal ADD_FIXUP_KIND(signed char kind,unsigned int node)
{
    ADD_FIXUP((int)kind,node);
}

/* Writes a C++ "this"-adjusting thunk as data bytes into the current segment:
     mov bx,sp / add word ptr ss:[bx+offset+2 or 4],addend / jmp near|far target
   using the short (83h, 8-bit) or long (81h) add and an 8- or 16-bit displacement as the
   values need. far_jump selects the far jump (EAh with a far address) and the 4-byte
   return address; the near jump (E9h) gets a self-relative fixup. Text twin:
   EMIT_THIS_ADJUST_THUNK_ASM. */
void far pascal EMIT_THIS_ADJUST_THUNK(register unsigned int target,int addend,register int far_jump,int offset)
{
    EMIT_DATA_BYTE(0x8B);
    EMIT_DATA_BYTE(0xDC);
    EMIT_DATA_BYTE(0x36);
    EMIT_DATA_BYTE(addend>127 || addend<-128 ? 0x81 : 0x83);
    offset+=far_jump ? 4 : 2;
    if(offset>127) {
        EMIT_DATA_BYTE(0x87);
        EMIT_DATA_BYTE((unsigned char)offset);
        EMIT_DATA_BYTE((unsigned char)(offset>>8));
    } else {
        EMIT_DATA_BYTE(0x47);
        EMIT_DATA_BYTE((unsigned char)offset);
    }
    if(addend>127 || addend<-128) {
        EMIT_DATA_BYTE((unsigned char)addend);
        EMIT_DATA_BYTE((unsigned char)(addend>>8));
    } else EMIT_DATA_BYTE((unsigned char)addend);
    if(far_jump) {
        EMIT_DATA_BYTE(0xEA);
        EMIT_DWORD_RELOC(target,0);
    } else {
        EMIT_DATA_BYTE(0xE9);
        ADD_RELOCATION(6,target);
        EMIT_DATA_BYTE(0);
        EMIT_DATA_BYTE(0);
    }
}

/* Installs the object-file hook table (OBJ_OUTPUT_DEFAULT_HOOKS over the live table at
   EMIT_DEPENDENCY_HOOK), creates <name>.obj (".obj" added unless CODE_OUTPUT_FLAGS bit 0
   is set), stores the final name back in ASM_OUTPUT_PATH and writes the module header
   (THEADR, translator name) for source filename. Failing to create it is fatal. */
void far pascal OPEN_OUTPUT_FILE(char far *filename)
{
    char path[80];
    STRING_COPY(path,(char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH));
    EMIT_DEPENDENCY_HOOK=OBJ_OUTPUT_DEFAULT_HOOKS;
    if(!(CODE_OUTPUT_FLAGS&1)) STRING_APPEND(path,(char near *)(STR_OBJ_3));
    if(CREATE_OUTPUT_FILE(path)==-1) REPORT_FATAL(MSG_UNABLE_CREATE_OUTPUT,path);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH),path);
    OBJ_WRITE_MODULE_HEADER(filename);
}

/* jmp word ptr cs:[bx+table] (2Eh FFh A7h disp16) through switch table node. */
void far pascal EMIT_SWITCH_JUMP(unsigned int node)
{
    EMIT_CODE_BYTE(0x2E);
    EMIT_CODE_BYTE(0xFF);
    EMIT_CODE_BYTE(0xA7);
    ADD_FIXUP_KIND(5,node);
    EMIT_CODE_WORD(0);
}

/* mov bx,offset table (BBh imm16) for switch table node. */
void far pascal EMIT_SWITCH_TABLE_LOAD(unsigned int node)
{
    EMIT_CODE_BYTE(0xBB);
    ADD_FIXUP_KIND(5,node);
    EMIT_CODE_WORD(0);
}

/* Loads the data segment's value into BP (kind 10) or AX: in the tiny model from the
   word DGROUP@ in the code segment (mov reg,cs:DGROUP@), else as an immediate fixed up
   to the data group (mov reg,seg DGROUP, fixup kind 10). */
void far pascal EMIT_LOAD_DATA_SEGMENT(unsigned char kind)
{
    if(OPTION_MEMORY_MODEL==0) {
        EMIT_CODE_BYTE(0x2e);
        EMIT_CODE_BYTE(0x8b);
        EMIT_CODE_BYTE((kind==10 ? 0x28 : 0)+6);
        ADD_OFFSET_FIXUP(DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_DGROUP_2),1));
    } else {
        EMIT_CODE_BYTE(kind==10 ? 0xbd : 0xb8);
        ADD_FIXUP_KIND(10,0);
    }
    EMIT_CODE_WORD(0);
}

/* Pushes the address just past the following jump as a return address: on an 8086
   "mov cx,offset $+6 / push cx", else "push offset $+5" (fixup kind 16 adds the
   location's own offset). */
void far pascal EMIT_PUSH_RETURN_ADDRESS(void)
{
    if(OPTION_TARGET_CPU==0) {
        EMIT_CODE_BYTE(0xB9);
        ADD_FIXUP_KIND(16,0);
        EMIT_CODE_WORD(6);
        EMIT_INSN_REG(0x94,6);
    } else {
        EMIT_CODE_BYTE(0x68);
        ADD_FIXUP_KIND(16,0);
        EMIT_CODE_WORD(5);
    }
}

/* jmp word ptr cs:[bx+value], with an 8-bit displacement when value is below 80h. */
void far pascal EMIT_CS_JMP_BX_DISP(int value)
{
    EMIT_CODE_BYTE(0x2E);
    EMIT_CODE_BYTE(0xFF);
    if(value<0x80) {
        EMIT_CODE_BYTE(0x67);
        EMIT_CODE_BYTE((unsigned char)value);
    } else {
        EMIT_CODE_BYTE(0xA7);
        EMIT_CODE_WORD(value);
    }
}

/* Adds a fixup (kind 11) to the external called name, declaring it on first use
   (DECLARE_NAMED_GLOBAL_HOOK); used for the floating-point emulator symbols. */
void far pascal ADD_NAMED_FIXUP(char near *name)
{
    ADD_FIXUP_KIND(11,DECLARE_NAMED_GLOBAL_HOOK(name,1));
}

#define LEFT FIRST_ASM_OPERAND
#define RIGHT SECOND_ASM_OPERAND
#define OUT(n) EMIT_CODE_BYTE(n)
#define WORD(n) EMIT_CODE_WORD(n)
#define TEXT(n) ((char near *)(n))
#define COMMENT(n) ADD_NAMED_FIXUP(TEXT(n))
#define FORMAT(p,n) EMIT_MODRM((p),(n))
/* Encodes instruction number instruction with the operands LEFT and RIGHT into the code
   buffer. A memory operand's segment override becomes a prefix byte (26h + offset), and
   the descriptor's own prefix follows, except for x87 instructions, which handle their
   prefixes in their own case. The switch then has one case group per encoding pattern:
   for example 72h int (int 3 is CCh), 70h/71h in, 6Eh/6Fh out, 7Fh pop, 94h push,
   9Bh/9Ch mov byte/word, 32h imul, 77h near call, 78h call (far, or "push cs; call near"
   when the target is in the function's own code segment), A4h/A5h dw/dd with
   relocation, 7Ah a single data byte, and the long list of x87 instructions. COMMENT(n)
   adds an emulator fixup named by the string at DS offset n (FIDRQQ etc.). */
void far pascal ENCODE_ASM_INSTRUCTION(register int instruction)
{
    unsigned int symbol;
    int value,bits;
    signed char segment;
    register struct Descriptor near *description;
    description=&OPCODE_DESCRIPTOR_TABLE[instruction];
    segment=OPERAND_SEGMENT_OVERRIDE(&LEFT);
    if(segment==-1) segment=OPERAND_SEGMENT_OVERRIDE(&RIGHT);
    if(!(description->flags&2L)) {
        if(segment!=-1) OUT(SEGMENT_PREFIX_OFFSET(segment)+0x26);
        if(description->prefix) OUT(description->prefix);
    }
    /* Descriptor fields: prefix, opcode and mode are opcode bytes or ModRM /digit values,
       used differently per case. */
    switch(instruction) {
    case 0x0:
        OUT(0x90);
        break;
    case 0x7b:case 0x7c:
        EMIT_IMMEDIATE_OPERAND(1);
        break;
    case 0xa4:
        EMIT_WORD_RELOC(LEFT.symbol,LEFT.offset);
        break;
    case 0xa5:
        EMIT_DWORD_RELOC(LEFT.symbol,LEFT.offset);
        break;
    case 0x7a:
        OUT(LEFT.offset);
        break;
    case 0x72:
        if(LEFT.offset==3) OUT(0xcc);
        else { OUT(0xcd);OUT(LEFT.offset); }
        break;
    case 0x70:case 0x71:
        if(RIGHT.kind==4) {
            OUT(instruction==0x70 ? 0xe4 : 0xe5);
            OUT(RIGHT.offset);
        } else OUT(instruction==0x70 ? 0xec : 0xed);
        break;
    case 0x6e:case 0x6f:
        if(LEFT.kind!=1) {
            OUT(instruction==0x6e ? 0xe6 : 0xe7);
            OUT(LEFT.offset);
        } else OUT(instruction==0x6e ? 0xee : 0xef);
        break;
    case 0x20:case 0x21:case 0x22:case 0x29:case 0x2a:case 0x2b:case 0x2c:case 0x2d:case 0x2e:case 0x33:case 0x34:case 0x35:case 0x38:case 0x39:case 0x3a:case 0x3b:case 0x3c:case 0x3d:case 0x52:case 0x5c:case 0x5d:case 0x5e:case 0x5f:case 0x60:case 0x61:case 0x62:case 0x63:case 0x64:case 0x65:case 0x66:case 0x67:case 0x68:case 0x69:case 0x6a:case 0x6b:case 0x6c:case 0x82:case 0x83:case 0x84:case 0x87:case 0x88:case 0x89:case 0x8a:case 0x8b:case 0x8c:case 0x8d:case 0x8e:case 0x8f:case 0x90:case 0x91:case 0xd5:
        /* match: the COMMENT numbers are the emulator fixup names FIARQQ..FIWRQQ (DS:54E7..
           551F), but they stay numbers: with names (fixups) BC no longer merges these arms'
           common tails.  The modding build keeps them right only while the data before
           5526h keeps its size. */
        switch(segment) {
        case 13:
            COMMENT(0x54e7);OUT(0x9b);COMMENT(0x54ee);OUT(0x3e);break;
        case 12:
            COMMENT(0x54f5);OUT(0x9b);OUT(0x26);break;
        case 15:
            COMMENT(0x54fc);OUT(0x9b);COMMENT(0x5503);OUT(0x36);break;
        case 14:
            COMMENT(0x550a);OUT(0x9b);COMMENT(0x5511);OUT(0x2e);break;
        default:COMMENT(0x5518);OUT(0x9b);break;
        }
        if(LEFT.kind==0) WORD(description->prefix);
        else if(LEFT.kind==1) {
            if(RIGHT.kind==1) WORD(description->prefix-0x100+(LEFT.reg<<8));
            else WORD(description->opcode+(LEFT.reg<<8));
        } else {
            OUT(description->mode);
            FORMAT(&LEFT,description->mode>>8);
        }
        break;
    case 0x57:
        COMMENT(0x551f);WORD(0x9b90);
        break;
    case 0x92:
        WORD(RIGHT.offset);OUT(0);
        break;
    case 0x5a:
        OUT(0xfe);FORMAT(&LEFT,8);
        break;
    case 0x5b:
        if(LEFT.kind==1) OUT(REGISTER_ENCODING(LEFT.reg)+0x48);
        else { OUT(0xff);FORMAT(&LEFT,8); }
        break;
    case 0x58:
        OUT(0xfe);FORMAT(&LEFT,0);
        break;
    case 0x59:
        if(LEFT.kind==1) OUT(REGISTER_ENCODING(LEFT.reg)+0x40);
        else { OUT(0xff);FORMAT(&LEFT,0); }
        break;
    case 0x7f:
        if(LEFT.kind==1) {
            if(LEFT.reg>=12 && LEFT.reg<=15) OUT(SEGMENT_PREFIX_OFFSET(LEFT.reg)+7);
            else OUT(REGISTER_ENCODING(LEFT.reg)+0x58);
        } else { OUT(0x8f);FORMAT(&LEFT,0); }
        break;
    case 0x94:
        if(LEFT.kind==1) {
            if(LEFT.reg>=12 && LEFT.reg<=15) OUT(SEGMENT_PREFIX_OFFSET(LEFT.reg)+6);
            else OUT(REGISTER_ENCODING(LEFT.reg)+0x50);
        } else if(LEFT.kind==4) {
            value=LEFT.offset;
            if(value<=127 && value>=-128) { OUT(0x6a);OUT(value&0xff); }
            else { OUT(0x68);WORD(value); }
        } else if(LEFT.kind==2 || LEFT.kind==3) {
            OUT(0x68);RIGHT=LEFT;EMIT_IMMEDIATE_OPERAND(0);
        } else { OUT(0xff);FORMAT(&LEFT,0x30); }
        break;
    case 0x50:case 0x51:case 0x53:case 0x54:
        FORMAT(&LEFT,description->opcode);
        break;
    case 0x31:case 0x36:case 0x37:case 0x3e:case 0x3f:case 0x40:case 0x41:case 0x42:case 0x43:
        FORMAT(&RIGHT,description->opcode);
        break;
    case 0x32:
        if(LEFT.kind==4) {
            value=LEFT.offset;
            if(value<=127 && value>=-128) { OUT(0x6b);OUT(0xc0);OUT(value&0xff); }
            else { OUT(0x69);OUT(0xc0);WORD(value); }
        } else { OUT(0xf7);FORMAT(&RIGHT,description->opcode); }
        break;
    case 0x9b:
        if(RIGHT.kind==4) {
            if(LEFT.kind==1) OUT(REGISTER_ENCODING(LEFT.reg)+0xb0);
            else { OUT(0xc6);FORMAT(&LEFT,0); }
            EMIT_IMMEDIATE_OPERAND(0);
        } else {
            value=0x88;
            if(LEFT.kind==1) {
                if(RIGHT.kind==1 && RIGHT.reg>=12 && RIGHT.reg<=15) {
                    OUT(0x8c);FORMAT(&LEFT,SEGMENT_PREFIX_OFFSET(RIGHT.reg));break;
                }
                if(LEFT.reg==0 && RIGHT.kind!=1 && RIGHT.reg==-1 && RIGHT.scale==-1) {
                    FORMAT(&RIGHT,0x9a);break;
                }
                value+=2;
                bits=REGISTER_ENCODING(LEFT.reg)<<3;
            } else {
                if(RIGHT.reg==0 && LEFT.reg==-1 && LEFT.scale==-1) {
                    FORMAT(&LEFT,0x9c);break;
                }
                bits=REGISTER_ENCODING(RIGHT.reg)<<3;
                RIGHT=LEFT;
            }
            OUT(value);FORMAT(&RIGHT,bits);
        }
        break;
    case 0x9c:
        if(RIGHT.kind==4 || RIGHT.kind==2 || RIGHT.kind==3) {
            if(LEFT.kind==1) { value=REGISTER_ENCODING(LEFT.reg)+0xb8;OUT(value); }
            else { OUT(0xc7);FORMAT(&LEFT,0); }
            EMIT_IMMEDIATE_OPERAND(1);
        } else {
            value=0x89;
            if(LEFT.kind==1) {
                if(LEFT.reg>=12 && LEFT.reg<=15) {
                    OUT(0x8e);FORMAT(&RIGHT,SEGMENT_PREFIX_OFFSET(LEFT.reg));break;
                }
                if(RIGHT.kind==1 && RIGHT.reg>=12 && RIGHT.reg<=15) {
                    OUT(0x8c);FORMAT(&LEFT,SEGMENT_PREFIX_OFFSET(RIGHT.reg));break;
                }
                if(LEFT.reg==0 && RIGHT.kind!=1 && RIGHT.reg==-1 && RIGHT.scale==-1) {
                    FORMAT(&RIGHT,0x9b);break;
                }
                value+=2;
                bits=REGISTER_ENCODING(LEFT.reg)<<3;
            } else {
                if(RIGHT.reg>=12 && RIGHT.reg<=15) {
                    OUT(0x8c);FORMAT(&LEFT,SEGMENT_PREFIX_OFFSET(RIGHT.reg));break;
                }
                if(RIGHT.reg==0 && LEFT.reg==-1 && LEFT.scale==-1) {
                    FORMAT(&LEFT,0x9d);break;
                }
                bits=REGISTER_ENCODING(RIGHT.reg)<<3;
                RIGHT=LEFT;
            }
            OUT(value);FORMAT(&RIGHT,bits);
        }
        break;
    case 0x85:case 0x86:
        if(ENCODE_IMMEDIATE_FORM(instruction,description)) break;
        OUT(description->opcode);
        if(LEFT.kind==1) FORMAT(&RIGHT,REGISTER_ENCODING(LEFT.reg)<<3);
        else FORMAT(&LEFT,REGISTER_ENCODING(RIGHT.reg)<<3);
        break;
    case 0x1c:case 0x1d:case 0x1e:case 0x1f:case 0x23:case 0x24:case 0x25:case 0x26:case 0x27:case 0x28:case 0x2f:case 0x30:case 0x4a:case 0x4b:case 0x4c:case 0x4d:case 0x4e:case 0x4f:case 0x80:case 0x81:case 0x9a:
        if(ENCODE_IMMEDIATE_FORM(instruction,description)) break;
        value=description->opcode;
        if(LEFT.kind==1) {
            OUT(value+2);FORMAT(&RIGHT,REGISTER_ENCODING(LEFT.reg)<<3);
        } else {
            OUT(value);FORMAT(&LEFT,REGISTER_ENCODING(RIGHT.reg)<<3);
        }
        break;
    case 0x95:case 0x96:
        FORMAT(&RIGHT,REGISTER_ENCODING(LEFT.reg)<<3);
        break;
    case 0x44:case 0x45:case 0x46:case 0x47:case 0x48:case 0x49:case 0x55:case 0x56:case 0xd3:case 0xd4:
        if(RIGHT.kind==4 && RIGHT.offset!=1) value=0xc0;
        else {
            value=0xd0;
            if(RIGHT.kind!=4) value+=2;
        }
        OUT(value+description->opcode);
        FORMAT(&LEFT,description->mode);
        if(RIGHT.kind==4 && RIGHT.offset!=1) OUT(RIGHT.offset&0xff);
        break;
    case 0xa1:case 0xa2:
        if(RIGHT.kind!=0) { OUT(description->opcode);WORD(RIGHT.offset); }
        else OUT(description->mode);
        break;
    case 0x75:case 0x76:
        if(LEFT.kind==1) OUT(REGISTER_ENCODING(LEFT.reg)+0xd0);
        else FORMAT(&LEFT,description->opcode);
        break;
    case 0x77:
        symbol=LEFT.symbol;OUT(0xe8);ADD_NEAR_CALL_FIXUP(symbol);WORD(0);
        break;
    case 0x78:
        symbol=LEFT.symbol;
        if(OPTION_MEMORY_MODEL && (!symbol || GET_SYMBOL_KIND_HOOK(symbol)==2 || GET_SYMBOL_SEGMENT_HOOK(symbol)!=FUNCTION_CODE_SEGMENT)) {
            OUT(0x9a);ADD_FAR_CALL_FIXUP(symbol);WORD(0);WORD(0);
        } else {
            OUT(0x0e);OUT(0xe8);ADD_NEAR_CALL_FIXUP(symbol);WORD(0);
        }
        break;
    }
}

/* The segment-override register of a memory operand, or -1. */
static signed char near pascal OPERAND_SEGMENT_OVERRIDE(register struct Operand near *operand)
{
    if(operand->kind==5) return operand->index;
    return -1;
}

/* Offset of segment register kind in the segment-register opcode pattern: ES 0, CS 8,
   SS 16, DS 24. Added to 26h it gives the override prefix, to 06h/07h push/pop, and as a
   ModRM reg field it selects the register in mov to/from segment registers. */
static int near pascal SEGMENT_PREFIX_OFFSET(signed char kind)
{
    switch(kind) {
    case 12:return 0;
    case 15:return 16;
    case 13:return 24;
    case 14:return 8;
    default:
        return 8;
    }
}

/* If RIGHT is an immediate (or a symbol's offset or segment), encodes an arithmetic
   instruction in its immediate form and returns 1; else returns 0. With AL/AX as LEFT
   the short accumulator form (desc->mode) is used; otherwise 80h/81h/83h (83h, a
   sign-extended byte, when the descriptor allows it, flag 8000h, and the value fits),
   or F6h/F7h for opcodes 85h and up (test). */
static int near pascal ENCODE_IMMEDIATE_FORM(int opcode,struct Descriptor far *desc)
{
    int mode;
    switch(SECOND_ASM_OPERAND.kind) {
    case 2: case 3: case 4:
        /* The original tests reg==0 twice (cmp/je then cmp/jne at 0ECC/0ED3). */
        if(FIRST_ASM_OPERAND.kind==1 && (FIRST_ASM_OPERAND.reg==0 || FIRST_ASM_OPERAND.reg==0)) {
            EMIT_CODE_BYTE(desc->mode);
            mode=desc->opcode&1;
        } else {
            mode=SECOND_ASM_OPERAND.offset&0xFF80;
            if(SECOND_ASM_OPERAND.kind==4 && (desc->flags&0x8000L)!=0L && (mode==0 || mode==-128))
                mode=2;
            else mode=0;
            mode=mode+(desc->opcode&1);
            if(opcode>=0x85) {
                EMIT_CODE_BYTE((unsigned char)mode+0xF6);
                EMIT_MODRM(&FIRST_ASM_OPERAND,0);
            } else {
                EMIT_CODE_BYTE((unsigned char)mode+0x80);
                EMIT_MODRM(&FIRST_ASM_OPERAND,desc->opcode&0xFFFE);
            }
        }
        EMIT_IMMEDIATE_OPERAND(mode);
        return 1;
    }
    return 0;
}

/* Writes RIGHT as an immediate: a byte, or a word when mode is 1; a symbol's offset
   (fixup kind 1); a memory operand's address; or a symbol's segment (fixup kind 3). */
static void near pascal EMIT_IMMEDIATE_OPERAND(int mode)
{
    switch(SECOND_ASM_OPERAND.kind) {
    case 4:
        EMIT_CODE_BYTE(SECOND_ASM_OPERAND.offset&0xFF);
        if(mode==1) EMIT_CODE_BYTE((int)SECOND_ASM_OPERAND.offset>>8);
        break;
    case 2:
        ADD_OFFSET_FIXUP(SECOND_ASM_OPERAND.symbol);
        EMIT_CODE_WORD(SECOND_ASM_OPERAND.offset);
        break;
    case 5:
        if(SECOND_ASM_OPERAND.symbol) ADD_OFFSET_FIXUP(SECOND_ASM_OPERAND.symbol);
        EMIT_CODE_WORD(SECOND_ASM_OPERAND.offset);
        break;
    default:
        ADD_FIXUP_KIND_3(SECOND_ASM_OPERAND.symbol);
        EMIT_CODE_WORD(0);
        break;
    }
}

/* Writes the ModRM byte for operand, with format already holding the reg field (or the
   /digit), and any displacement. A register gives mod 11. A direct address gives r/m 110
   with a 16-bit displacement (and a fixup if it names a symbol). Otherwise mod is 10
   (16-bit displacement: a symbol or a large value), 01 (8-bit, also for a plain [bp]) or
   00, and r/m is built from the base (reg: BX 4, BP 10) and index (scale: SI, DI 9)
   registers: [bx+si] 0, [bx+di] 1, [bp+si] 2, [bp+di] 3, [si] 4, [di] 5, [bp] 6, [bx] 7. */
static void near pascal EMIT_MODRM(struct Operand near *operand,unsigned int format)
{
    register struct Operand near *current=operand;
    register unsigned int mode;
    if(current->kind==1) {
        EMIT_CODE_BYTE(REGISTER_ENCODING(current->reg)+format+0xC0);
    } else {
        if(current->reg==-1 && current->scale==-1) {
            format+=6;
            mode=0x80;
        } else {
            if(current->symbol || (int)current->offset>127 || (int)current->offset<-128)
                mode=0x80;
            else if(current->offset) mode=0x40;
            else if(current->reg==10 && current->scale==-1) mode=0x40;
            else mode=0;
            format|=mode;
            if(current->scale==9) format|=1;
            if(current->reg==10) format|=2;
            if(current->scale==-1 || current->reg==-1) {
                format|=4;
                if(current->reg==4) format|=3;
            }
        }
        EMIT_CODE_BYTE(format);
        if(mode==0x80) {
            if(current->symbol) ADD_OFFSET_FIXUP(current->symbol);
            EMIT_CODE_WORD(current->offset);
        } else if(mode==0x40) EMIT_CODE_BYTE(current->offset);
    }
}
