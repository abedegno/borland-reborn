; /* _DATA: the initialized data segment of BCC.EXE (DGROUP:0000..5C8F) */
;
; One segment for the data of every module: TLINK concatenated each
; object's _DATA contribution, and the module boundaries are not marked in
; the image.  The C and assembler sources name these items through
; absolute DS equates (symbols.tsv, ORDERC); the labels below repeat those
; names so each item can be found, and the comment lists the sources that
; use it.  Text is quoted; other values stay as bytes because their types
; are not known.  dw seg fixups are far pointers or segment words.

; Direct-segment relocation references
		extrn	BCC_FAR_970B:far
		extrn	X001_00:far
		extrn	X00A_02:far
		extrn	X018_00:far
		extrn	X01F_00:far
		extrn	X020_00:far
		extrn	X02A_00:far
		extrn	X030_04:far
		extrn	X038_00:far
		extrn	X039_00:far
		extrn	X03A_00:far
		extrn	X03B_00:far
		extrn	X03C_00:far
		extrn	X041_00:far
		extrn	X045_00:far
		extrn	X047_00:far
		extrn	X048_00:far
		extrn	X04A_00:far
		extrn	X04C_02:far
		extrn	X04F_03:far
		extrn	X050_00:far
		extrn	X054_02:far
		extrn	X055_00:far
		extrn	X056_01:far
		extrn	X05D_05:far
		extrn	X06D_00:far
		extrn	X06E_00:far
		extrn	X076_00:far
		extrn	X077_00:far
		public	BCC_SEG_180
; BEGIN LG05A (gap _DATA:0000)
_DATA	segment para public 'DATA'
BCC_SEG_180	label far
		assume	cs:_DATA

; DS:0000  used by R25FF.C, R36F7.C, RG2A.C, RG2A1.C, RG2A2.C, RG2A7.C, 36 more
ACTIVE_HEAP	label	byte
		db	00h,00h,00h,00h

; DS:0004  used by C5INIT.C, RMAIN13C.C
HEAP_START_SEG	label	byte
		db	00h,00h,00h,00h

; DS:0008  used by RMAIN13C.C
HEAP_END_SEG	label	byte
		db	12 dup (0)

; DS:0014  used by C53UNIT.C, C53UNIT.H, RDRV388.C, RGETENV.C
ENVIRONMENT_SEG	label	byte
		db	00h,00h,00h,00h,4Eh,8Ch

; DS:001A  used by C5INIT.C, RVECGET.C, RVECSET.C
DOS_HOST_MODE	label	byte
		db	00h

; DS:001B  used by C5INIT.C
EXTENDER_HEAP_TOP	label	byte
		db	00h,00h,00h,00h,00h

; DS:0020  used by RMAIN13C.C
STR_BORLAND_C_VERSION_2_0	label	byte
		db	'Borland C++  Version 2.0 Copyright (c) 1991 Borland Internationa','l'
		db	0Dh,0Ah,0

; DS:0064  used by RMAIN13C.C
STR_AVAILABLE_MEMORY	label	byte
		db	0Dh,0Ah,09h,'Available memory %ld',0Dh,0Ah,0

; DS:007E  used by PRINT_USAGE_AND_EXIT.C
STR_SYNTAX_IS_BCC_OPTIONS	label	byte
		db	'Syntax is: BCC [ options ] file[s]     * = default; -x- = turn s'
		db	'witch x off',0Dh,0Ah
		db	'  -1      80186/286 Instructions    -2      80286 Protected Mode'
		db	' Inst.',0Dh,0Ah
		db	'  -Ax     Disable extensions        -B      Compile via assembly',0Dh
		db	0Ah,'  -C      Allow nested comments     -Dxxx   Define macro',0Dh,0Ah
		db	'  -Exxx   Alternate Assembler name  -G      Generate for speed',0Dh,0Ah
		db	'  -Hxxx   Use pre-compiled headers  -Ixxx   Include files direct','ory'
		db	0Dh,0Ah,'  -K      Default char is unsigned  -Lxxx   Libraries directory'
		db	0Dh,0Ah
		db	'  -M      Generate link map         -N      Check stack overflow',0Dh
		db	0Ah,'  -O      Optimize jumps            -P      Force C++ compile',0Dh
		db	0Ah,'  -Qxxx   Memory usage control      -S      Produce assembly out'
		db	'put',0Dh,0Ah
		db	'  -Txxx   Set assembler option      -Uxxx   Undefine macro',0Dh,0Ah
		db	'  -Vx     Virtual table control     -Wxxx   Create Windows appli'
		db	'cation',0Dh,0Ah
		db	'  -X      Suppress autodep. output  -Yx     Overlay control',0Dh,0Ah
		db	'  -Z      Optimize register usage   -a      Generate word alignm','ent'
		db	0Dh,0Ah,'  -b    * Treat enums as integers   -c      Compile only',0Dh
		db	0Ah,'  -d      Merge duplicate strings   -exxx   Executable file name'
		db	0Dh,0Ah
		db	'  -fxx    Floating point options    -gN     Stop after N warning','s'
		db	0Dh,0Ah,'  -iN     Max. identifier length    -jN     Stop after N errors'
		db	0Dh,0Ah,'  -k      Standard stack frame      -lx     Set linker option'
		db	0Dh,0Ah
		db	'  -mx     Set Memory Model          -nxxx   Output file director','y'
		db	0Dh,0Ah,'  -oxxx   Object file name          -p      Pascal calls',0Dh
		db	0Ah,'  -r    * Register variables        -u    * Underscores on exter'
		db	'ns',0Dh,0Ah
		db	'  -v      Source level debugging    -wxxx   Warning control',0Dh,0Ah
		db	'  -y      Produce line number info  -zxxx   Set segment names',0

; DS:069C  used by RMAIN13C.C
STR_ASM	label	byte
		db	'.asm',0

; DS:06A1  used by RMAIN13C.C
STR_OBJ	label	byte
		db	'.obj',0
		db	10 dup (0)
		db	24h,2Ah,24h,2Ah,24h,2Ah,00h,01h,00h,06h
		db	'YOM',0
		db	00h,00h

; DS:06C0  used by R25FF.C, R34F0.C, R3504.C, RG2A1.C, RHAPI.C, RHINIT.C
HEAP_DEFAULT_OWNER_TAG	label	byte
		db	00h,00h

; DS:06C2  used by GETSTAT.C, RH1B1C.C, RH1B9A.C, RH1C4F.C, RHAPI.C, RHINIT.C, 1 more
HEAP_STATUS	label	byte
		db	00h,00h

; DS:06C4  used by RH1A2F.C, RH1AE0.C
HEAP_SAVED_TOP_KEY	label	byte
		db	00h,00h

; DS:06C6  used by RG2A.C, RG2A7.C, RG2A8.C
HANDLE_RING_NEWEST	label	byte
		db	00h

; DS:06C7  used by RG2A7.C, RG2A8.C
HANDLE_RING_TAG_CURSOR	label	byte
		db	50h

; DS:06C8  used by RG2A8.C
HANDLE_RING_UNTAG_CURSOR	label	byte
		db	0BFh,00h

; DS:06CA  used by R25FF.C, R36F7.C, RG2A.C, RG2A4.C, RG2B.ASM, RG2BEND.C, 16 more
HEAP_DESCRIPTOR_SEGMENTS	label	byte
		db	16 dup (0)

; DS:06DA  used by R3513.ASM, R355B.ASM
OWNER_TAG_BITMAP	label	byte
		db	01h
		db	31 dup (0)

; DS:06FA  used by RHINIT.C
HEAP_CPU_TYPE	label	byte
		db	00h,01h,00h,00h,00h,00h,00h,00h
		db	'friend',0
		db	'virtual',0
		db	'C++',0
		db	43h,00h,00h

; DS:0718  used by C11FIND.C, C11FIND.H, C121UNIT.C, C13UNIT.C, C13UNIT.H
NO_SOURCE_LOCATION	label	byte
		db	00h,00h,00h,00h,00h,00h

; DS:071E  used by C5UNIT.C, EXPRC5.H
POINTER_TEXT	label	byte
		db	'pointer',0

; DS:0726  used by C121UNIT.C
STR_STATIC_VARIABLES	label	byte
		db	'static variables',0

; DS:0737  used by C121UNIT.C
STR_FRIEND	label	byte
		db	'friend',0

; DS:073E  used by C121UNIT.C
STR_VIRTUAL	label	byte
		db	'virtual',0

; DS:0746  used by C121UNIT.C
STR_GOTO	label	byte
		db	'Goto',0

; DS:074B  used by C121UNIT.C
STR_IF	label	byte
		db	49h,66h,00h

; DS:074E  used by C121UNIT.C
STR_SWITCH	label	byte
		db	'Switch',0

; DS:0755  used by C121UNIT.C
STR_WHILE	label	byte
		db	'While',0

; DS:075B  used by C121UNIT.C
STR_DO_WHILE	label	byte
		db	'Do-while',0

; DS:0764  used by C121UNIT.C
STR_FOR	label	byte
		db	'For',0

; DS:0768  used by C233UNIT.C, C234UNIT.C, C239UNIT.C
EXPR_OP_FLAGS	label	byte
		db	04h,04h,04h,04h,04h,04h,04h,04h,02h,00h,02h,00h,00h,00h,00h,02h
		db	02h,02h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,08h,08h,08h
		db	08h,08h,08h,00h,00h,00h,00h,08h,08h,00h,00h,00h,00h,00h,00h,00h
		db	08h,00h,00h,04h,00h,00h,01h,00h,04h,04h,00h,00h,00h,00h,00h,01h
		db	01h,01h,00h,01h,00h,00h,01h,01h,05h,00h,04h

; DS:07B3  used by C121UNIT.C, C131UNIT.C, C16UNIT.C, C16UNIT.H, C201UNIT.C, C228UNIT.C, 15 more
TYPE_FLAGS	label	byte
		db	00h,02h,50h,1Dh,00h,18h,10h,1Ch,00h,18h,00h,07h,00h,02h,00h,03h
		db	00h,14h,40h,19h,00h,00h,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch
		db	00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,40h,1Dh,40h,1Dh
		db	50h,1Dh,00h,1Ch,00h,1Ch,50h,1Dh,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch
		db	00h,18h,00h,1Bh,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch,00h,1Ch
		db	00h,1Ch,00h,1Ch,40h,1Dh,60h,1Dh,40h,19h,40h,1Dh,40h,1Dh,00h,18h
		db	00h,1Ch,58h,19h,40h,19h,40h,19h,40h,19h,09h,12h,09h,12h,09h,12h
		db	09h,12h,09h,12h,0Eh,1Ah,0Eh,1Ah,0Eh,1Ah,0Eh,1Ah,0Eh,1Ah,0Eh,1Ah
		db	0Eh,1Ah,0Eh,1Ah,0Ah,1Ah,0Ah,1Ah,0Ah,1Ah,0Eh,1Ah,10h,30h,10h,30h
		db	10h,30h,00h,30h,0Ah,1Ah,0Ah,1Ah,10h,30h,10h,30h,10h,30h,10h,30h
		db	10h,30h,10h,30h,10h,30h,10h,30h,10h,30h,10h,30h,10h,30h,80h,03h
		db	80h,03h,00h,03h,00h,03h,80h,03h,80h,03h,80h,03h,80h,03h,00h,07h
		db	00h,03h,00h,03h,00h,03h,00h,01h,00h,00h,40h,19h,00h,04h,40h,19h
		db	0Ah,1Ah,40h,1Dh,09h,12h,09h,12h,40h,1Dh,50h,19h,09h,12h,20h,00h
		db	20h,00h,20h,00h,40h,19h,09h,12h
		db	30 dup (0)

; DS:08B9  used by C128UNIT.C, C130UNIT.C, C238UNIT.C
WARNING_SWITCH_TABLE	label	byte
		db	61h,74h,74h,01h
		db	'bbf',0
		db	62h,64h,66h,01h,62h,65h,69h,01h,73h,63h,70h,01h,6Ch,69h,6Eh,01h
		db	6Ch,76h,63h,01h,6Ch,76h,63h,01h,6Ch,76h,63h,01h,6Ch,76h,63h,01h
		db	72h,65h,74h,01h,6Eh,63h,69h,01h,69h,6Eh,6Ch,01h,6Fh,62h,69h,01h
		db	6Fh,66h,70h,01h,6Fh,76h,6Ch,01h
		db	'pin',0
		db	6Fh,6Dh,66h,01h
		db	'pad',0
		db	64h,63h,6Ch,01h
		db	'amb',0
		db	'amp',0
		db	70h,61h,72h,01h,61h,73h,63h,01h
		db	'asm',0
		db	62h,67h,74h,01h
		db	'pro',0
		db	'pro',0
		db	'cln',0
		db	63h,70h,74h,01h
		db	'def',0
		db	72h,6Eh,67h,01h,64h,75h,70h,01h,70h,69h,61h,01h,72h,76h,6Ch,01h
		db	'sig',0
		db	'nod',0
		db	65h,66h,66h,01h,61h,75h,73h,01h,69h,6Ch,6Ch,01h,73h,75h,73h,01h
		db	72h,63h,68h,01h,72h,70h,74h,01h
		db	'stv',0
		db	76h,72h,74h,01h,62h,69h,67h,01h
		db	'ucp',0
		db	'use',0
		db	7Ah,64h,69h,01h,62h,63h,73h,01h,73h,74h,75h,01h,65h,78h,74h,01h
		db	62h,66h,73h,01h,64h,70h,75h,01h,66h,64h,74h,01h,65h,61h,73h,01h
		db	68h,69h,64h,01h,6Eh,63h,66h,01h,6Eh,63h,66h,01h,69h,61h,73h,01h
		db	00h,00h,00h,00h

; DS:09AD  used by C239UNIT.C
REAL_ZERO	label	byte
		db	10 dup (0)

; DS:09B7  used by C239UNIT.C, C40UNIT.C, C40UNIT.H
REAL_ONE	label	byte
		db	00h,00h,00h,00h,00h,00h,00h,80h,0FFh,3Fh

; DS:09C1  used by C239UNIT.C
REAL_MINUS_ONE	label	byte
		db	00h,00h,00h,00h,00h,00h,00h,80h,0FFh

; DS:09CA  used by C103UNIT.C, C107UNIT.C, C10TYPE.C, C10TYPE.H, C116UNIT.C, C119UNIT.C, 64 more
EXPR_FLAGS	label	byte
		db	0BFh,01h,21h,01h,21h,01h,21h,01h,21h,02h,02h,02h,00h,0Ch,18h,0Ch
		db	0Ch,00h,00h,40h,40h,01h

; DS:09E0  used by C235UNIT.C, C9INIT.C, C9INIT.H
C9_TOKEN_NAMES	label	byte
		db	00h,00h,82h,00h,00h,00h,01h,00h,00h,00h,02h,00h,00h,00h,03h,00h
		db	00h,00h,04h,00h,00h,00h,05h,00h,00h,00h,06h,00h,00h,00h,07h,00h
		db	00h,00h,08h,00h,00h,00h,09h,00h,00h,00h,0Bh,00h,00h,00h,0Ch,00h
		db	00h,00h,0Dh,00h,00h,00h,0Eh,00h,00h,00h,0Fh,00h,00h,00h,10h,00h
		db	00h,00h,11h,00h,00h,00h,12h,00h,00h,00h,13h,00h,00h,00h,14h,00h
		db	00h,00h,15h,00h,00h,00h,16h,00h,00h,00h,17h,00h,00h,00h,18h,00h
		db	00h,00h,19h,00h,00h,00h,1Ah,00h,00h,00h,1Bh,00h,00h,00h,1Ch,00h
		db	00h,00h,1Dh,00h,00h,00h,1Eh,00h,00h,00h,1Fh,00h,00h,00h,20h,00h
		db	00h,00h,21h,00h,00h,00h,22h,00h,00h,00h,23h,00h,00h,00h,24h,00h
		db	00h,00h,25h,00h,00h,00h,26h,00h,00h,00h,27h,00h,00h,00h,28h,00h
		db	00h,00h,29h,00h,00h,00h,2Ah,00h,00h,00h,2Bh,00h,00h,00h,2Ch,00h
		db	00h,00h,2Dh,00h,00h,00h,2Eh,00h,00h,00h,2Fh,00h,00h,00h,30h,00h
		db	00h,00h,35h,00h,00h,00h,36h,00h,00h,00h,37h,00h,00h,00h,38h,00h
		db	00h,00h,39h,00h,00h,00h,3Ah,00h,00h,00h,3Bh,00h,00h,00h,3Ch,00h
		db	00h,00h,3Dh,00h,00h,00h,3Eh,00h,00h,00h,3Fh,00h,00h,00h,40h,00h
		db	00h,00h,41h,00h,00h,00h,42h,00h,00h,00h,43h,00h,00h,00h,44h,00h
		db	00h,00h,45h,00h,00h,00h,46h,00h,00h,00h,47h,00h,00h,00h,48h,00h
		db	00h,00h,49h,00h,00h,00h,4Ah,00h,00h,00h,4Bh,00h,00h,00h,4Ch,00h
		db	00h,00h,4Dh,00h,00h,00h,4Eh,00h,00h,00h,4Fh,00h,00h,00h,50h,00h
		db	00h,00h,51h,00h,00h,00h,52h,00h,00h,00h,53h,00h,00h,00h,54h,00h
		db	00h,00h,55h,00h,00h,00h,56h,00h,00h,00h,58h,00h,00h,00h,59h,00h
		db	00h,00h,5Ah,00h,00h,00h,5Bh,00h,00h,00h,5Ch,00h,00h,00h,5Dh,00h
		db	00h,00h,5Eh,00h,00h,00h,5Fh,00h,00h,00h,60h,00h,00h,00h,61h,00h
		db	00h,00h,62h,00h,00h,00h,63h,00h,00h,00h,64h,00h,00h,00h,65h,00h
		db	00h,00h,66h,00h,00h,00h,67h,00h,00h,00h,68h,00h,00h,00h,69h,00h
		db	00h,00h,6Ah,00h,00h,00h,6Bh,00h,00h,00h,6Ch,00h,00h,00h,6Dh,00h
		db	00h,00h,6Eh,00h,00h,00h,6Fh,00h,00h,00h,70h,00h,00h,00h,71h,00h
		db	00h,00h,72h,00h,00h,00h,73h,00h

; DS:0B98  used by C235UNIT.C, C9INIT.C, C9INIT.H
C9_TOKEN_END	label	byte
		db	94h,0Bh
		dw	seg BCC_SEG_180

; DS:0B9C  used by C9INIT.C, C9INIT.H
C9_TYPE_SIZES	label	byte
		db	00h,02h,08h,04h,0Ah,04h,0Ah,06h,0Ch,0Eh,0Fh,10h,01h

; DS:0BA9  used by C33UNIT.C, C33UNIT.H
C33_TYPE_NAMES	label	byte
		db	1Fh,0Ch,29h,0Ch,2Eh,0Ch,3Ch,0Ch,42h,0Ch,51h,0Ch,55h,0Ch,62h,0Ch
		db	67h,0Ch,75h,0Ch,7Bh,0Ch,82h,0Ch,8Eh,0Ch,93h,0Ch,98h,0Ch,9Dh,0Ch
		db	0A1h,0Ch,0A6h,0Ch,0AEh,0Ch,0C2h,0Ch,0CAh,0Ch,0D1h,0Ch

; DS:0BD5  used by C18UNIT.C, C18UNIT.H, C232UNIT.C
C18_OPERATOR_TOKENS	label	byte
		db	82h,31h,32h,33h,31h,31h,31h,09h,16h,17h,18h,19h,1Ah,1Eh,1Fh,1Bh
		db	1Ch,1Dh,0Bh,0Ch,0Dh,0Eh,0Fh,10h,14h,15h,11h,12h,13h,24h,25h,27h
		db	26h,29h,28h,82h,82h,20h,21h,23h,22h,82h,08h,82h,82h,82h,17h,2Bh
		db	2Ah,18h,1Bh,82h,82h,82h,82h,82h,82h,82h,03h,2Fh,64h,30h,66h,2Dh
		db	2Eh,6Ch,1Bh,69h,2Ch,6Bh,82h,05h,82h,16h
		db	'undefined',0
		db	'char',0
		db	'unsigned char',0
		db	'short',0
		db	'unsigned short',0
		db	'int',0
		db	'unsigned int',0
		db	'long',0
		db	'unsigned long',0
		db	'float',0
		db	'double',0
		db	'long double',0
		db	'void',0
		db	'near',0
		db	'_seg',0
		db	'far',0
		db	'huge',0
		db	'array [',0
		db	'function returning',09h,0
		db	'struct ',0
		db	'union ',0
		db	'enum ',0

; DS:0CD7  used by C9INIT.C, C9INIT.H
STR___EMIT__	label	byte
		db	'__emit__',0

; DS:0CE0  used by C9INIT.C, C9INIT.H
STR_S_2	label	byte
		db	73h,40h,00h

; DS:0CE3  used by C9INIT.C, C9INIT.H
STR_MAIN_2	label	byte
		db	'main',0

; DS:0CE8  used by C9INIT.H
STR__SETARGV__	label	byte
		db	'_setargv__',0

; DS:0CF3  used by C9INIT.C, C9INIT.H
STR___SETARGV__	label	byte
		db	'__setargv__',0

; DS:0CFF  used by C9INIT.H
STR__SETENVP__	label	byte
		db	'_setenvp__',0

; DS:0D0A  used by C9INIT.C, C9INIT.H
STR___SETENVP__	label	byte
		db	'__setenvp__',0

; DS:0D16  used by C9INIT.C, C9INIT.H
STR_NEW	label	byte
		db	'new',0

; DS:0D1A  used by C9INIT.C, C9INIT.H
STR__VECTOR_NEW_	label	byte
		db	'_vector_new_',0

; DS:0D27  used by C9INIT.C, C9INIT.H
STR__VECTOR_VNEW_	label	byte
		db	'_vector_vnew_',0

; DS:0D35  used by C9INIT.C, C9INIT.H
STR_DELETE	label	byte
		db	'delete',0

; DS:0D3C  used by C9INIT.C, C9INIT.H
STR__VECTOR_DELETE_	label	byte
		db	'_vector_delete_',0

; DS:0D4C  used by C9INIT.C, C9INIT.H
STR__VECTOR_APPLY_	label	byte
		db	'_vector_apply_',0

; DS:0D5B  used by C9INIT.C, C9INIT.H
STR__VECTOR_VAPPLY_	label	byte
		db	'_vector_vapply_',0

; DS:0D6B  used by C9INIT.C, C9INIT.H
STR__FPURE_ERROR_	label	byte
		db	'_fpure_error_',0

; DS:0D79  used by C9INIT.C, C9INIT.H
STR__NPURE_ERROR_	label	byte
		db	'_npure_error_',0

; DS:0D87  used by C9INIT.C, C9INIT.H
STR_FAR_FUNC	label	byte
		db	'far_func',0

; DS:0D90  used by C9INIT.C, C9INIT.H
STR_NEAR_FUNC	label	byte
		db	'near_func',0

; DS:0D9A  used by C9INIT.C, C9INIT.H
STR_DELTA	label	byte
		db	'delta',0

; DS:0DA0  used by C9INIT.C, C9INIT.H
STR_VINDEX	label	byte
		db	'vindex',0

; DS:0DA7  used by C9INIT.C, C9INIT.H
STR_OFFSET	label	byte
		db	'offset',0

; DS:0DAE  used by C9INIT.C, C9INIT.H
STR_PAD	label	byte
		db	'pad',0

; DS:0DB2  used by C12CHECK.C, C12CHECK.H
STR_EMPTY_2	label	byte
		db	00h,00h

; DS:0DB4  used by C13UNIT.C, C13UNIT.H
STR__STCON_	label	byte
		db	'_STCON_',0

; DS:0DBC  used by C13UNIT.C, C13UNIT.H
STR__STDES_	label	byte
		db	'_STDES_',0

; DS:0DC4  used by C13UNIT.H
STR_VSF	label	byte
		db	'$vsf',0

; DS:0DC9  used by C13UNIT.C, C13UNIT.H
STR_VSN	label	byte
		db	'$vsn',0

; DS:0DCE  used by C14UNIT.C, C14UNIT.H
C14_TYPE_ENCODINGS	label	byte
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	2Ch,0Eh
		dw	seg BCC_SEG_180
		db	2Fh,0Eh
		dw	seg BCC_SEG_180
		db	32h,0Eh
		dw	seg BCC_SEG_180
		db	34h,0Eh
		dw	seg BCC_SEG_180
		db	37h,0Eh
		dw	seg BCC_SEG_180
		db	39h,0Eh
		dw	seg BCC_SEG_180
		db	3Ch,0Eh
		dw	seg BCC_SEG_180
		db	3Eh,0Eh
		dw	seg BCC_SEG_180
		db	41h,0Eh
		dw	seg BCC_SEG_180
		db	43h,0Eh
		dw	seg BCC_SEG_180
		db	45h,0Eh
		dw	seg BCC_SEG_180
		db	47h,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	49h,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	4Ch,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180
		db	2Ah,0Eh
		dw	seg BCC_SEG_180

; DS:0E26  used by C14UNIT.C, C14UNIT.H
C14_ARGUMENT_CODES	label	byte
		db	4Fh,0Eh
		dw	seg BCC_SEG_180

; DS:0E2A  used by C14UNIT.C, C14UNIT.H
STR_QUEST	label	byte
		db	3Fh,00h,7Ah,63h,00h,75h,63h,00h,73h,00h,75h,73h,00h,69h,00h,75h
		db	69h,00h,6Ch,00h,75h,6Ch,00h,66h,00h,64h,00h,67h,00h,76h,00h,75h
		db	72h,00h,75h,70h,00h
		db	'0123456789abcdefghijklmnopqrstuvwxyz',0

; DS:0E74  used by C14UNIT.C, C14UNIT.H
STR_ADD	label	byte
		db	'add',0

; DS:0E78  used by C14UNIT.C, C14UNIT.H
STR_SUB	label	byte
		db	'sub',0

; DS:0E7C  used by C14UNIT.C, C14UNIT.H
STR_MUL	label	byte
		db	'mul',0

; DS:0E80  used by C14UNIT.C, C14UNIT.H
STR_DIV	label	byte
		db	'div',0

; DS:0E84  used by C14UNIT.C, C14UNIT.H
STR_MOD	label	byte
		db	'mod',0

; DS:0E88  used by C14UNIT.C, C14UNIT.H
STR_X	label	byte
		db	78h

; DS:0E89  used by C14UNIT.C, C14UNIT.H
STR_OR	label	byte
		db	6Fh,72h,00h

; DS:0E8C  used by C14UNIT.C, C14UNIT.H
STR_AND	label	byte
		db	'and',0

; DS:0E90  used by C14UNIT.C, C14UNIT.H
STR_CMP	label	byte
		db	'cmp',0

; DS:0E94  used by C14UNIT.C, C14UNIT.H
STR_ASG	label	byte
		db	'asg',0

; DS:0E98  used by C14UNIT.C, C14UNIT.H
STR_LSS	label	byte
		db	'lss',0

; DS:0E9C  used by C14UNIT.C, C14UNIT.H
STR_GTR	label	byte
		db	'gtr',0

; DS:0EA0  used by C14UNIT.C, C14UNIT.H
STR_RPLU	label	byte
		db	'rplu',0

; DS:0EA5  used by C14UNIT.C, C14UNIT.H
STR_RMIN	label	byte
		db	'rmin',0

; DS:0EAA  used by C14UNIT.C, C14UNIT.H
STR_RMUL	label	byte
		db	'rmul',0

; DS:0EAF  used by C14UNIT.C, C14UNIT.H
STR_RDIV	label	byte
		db	'rdiv',0

; DS:0EB4  used by C14UNIT.C, C14UNIT.H
STR_RMOD	label	byte
		db	'rmod',0

; DS:0EB9  used by C14UNIT.C, C14UNIT.H
STR_RXOR	label	byte
		db	'rxor',0

; DS:0EBE  used by C14UNIT.C, C14UNIT.H
STR_RAND	label	byte
		db	'rand',0

; DS:0EC3  used by C14UNIT.C, C14UNIT.H
STR_ROR	label	byte
		db	'ror',0

; DS:0EC7  used by C14UNIT.C, C14UNIT.H
STR_LSH	label	byte
		db	'lsh',0

; DS:0ECB  used by C14UNIT.C, C14UNIT.H
STR_RSH	label	byte
		db	'rsh',0

; DS:0ECF  used by C14UNIT.C, C14UNIT.H
STR_RLSH	label	byte
		db	'rlsh',0

; DS:0ED4  used by C14UNIT.C, C14UNIT.H
STR_RRSH	label	byte
		db	'rrsh',0

; DS:0ED9  used by C14UNIT.C, C14UNIT.H
STR_EQL	label	byte
		db	'eql',0

; DS:0EDD  used by C14UNIT.C, C14UNIT.H
STR_NEQ	label	byte
		db	'neq',0

; DS:0EE1  used by C14UNIT.C, C14UNIT.H
STR_LEQ	label	byte
		db	'leq',0

; DS:0EE5  used by C14UNIT.C, C14UNIT.H
STR_GEQ	label	byte
		db	'geq',0

; DS:0EE9  used by C14UNIT.C, C14UNIT.H
STR_LAND	label	byte
		db	'land',0

; DS:0EEE  used by C14UNIT.C, C14UNIT.H
STR_LOR	label	byte
		db	'lor',0

; DS:0EF2  used by C14UNIT.C, C14UNIT.H
STR_CALL	label	byte
		db	'call',0

; DS:0EF7  used by C14UNIT.C, C14UNIT.H
STR_SUBS	label	byte
		db	'subs',0

; DS:0EFC  used by C14UNIT.C, C14UNIT.H
STR_NEW_2	label	byte
		db	'new',0

; DS:0F00  used by C14UNIT.C, C14UNIT.H
STR_DELE	label	byte
		db	'dele',0

; DS:0F05  used by C14UNIT.C, C14UNIT.H
STR_AROW	label	byte
		db	'arow',0

; DS:0F0A  used by C14UNIT.C, C14UNIT.H
STR_COMA	label	byte
		db	'coma',0

; DS:0F0F  used by C14UNIT.C, C14UNIT.H
STR_ARWM	label	byte
		db	'arwm',0

; DS:0F14  used by C14UNIT.C, C14UNIT.H
STR_IND	label	byte
		db	'ind',0

; DS:0F18  used by C14UNIT.C, C14UNIT.H
STR_ADR	label	byte
		db	'adr',0

; DS:0F1C  used by C14UNIT.C, C14UNIT.H
STR_NOT	label	byte
		db	'not',0

; DS:0F20  used by C14UNIT.C, C14UNIT.H
STR_INC	label	byte
		db	'inc',0

; DS:0F24  used by C14UNIT.C, C14UNIT.H
STR_DEC	label	byte
		db	'dec',0

; DS:0F28  used by C14UNIT.C, C14UNIT.H
STR_CTR	label	byte
		db	'ctr',0

; DS:0F2C  used by C14UNIT.C, C14UNIT.H
STR_DTR	label	byte
		db	'dtr',0

; DS:0F30  used by C14UNIT.C, C14UNIT.H
STR_ZYXWVUTSRQPONMLKJIHGFEDC	label	byte
		db	'zyxwvutsrqponmlkjihgfedcba0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_',0

; DS:0F70  used by C236UNIT.C
STR_LOCAL_DESTRUCTORS	label	byte
		db	'local destructors',0

; DS:0F82  used by C16UNIT.C, C16UNIT.H
STR_ARRAY_BOUNDS	label	byte
		db	'Array bounds',0
		db	00h

; DS:0F90  used by C18UNIT.C, C18UNIT.H
STR_A_MEMBER_FUNCTION	label	byte
		db	'a member function',0

; DS:0FA2  used by C228UNIT.C
STR_FRIEND_2	label	byte
		db	'friend',0

; DS:0FA9  used by C228UNIT.C
STR_VIRTUAL_2	label	byte
		db	'virtual',0

; DS:0FB1  used by C228UNIT.C
STR_OPERATOR	label	byte
		db	'Operator []',0

; DS:0FBD  used by C228UNIT.C
STR_OPERATOR_2	label	byte
		db	'Operator',09h,'[]',0
		db	00h

; DS:0FCA  used by C230UNIT.C
STR_REFERENCE	label	byte
		db	'reference',0

; DS:0FD4  used by C25UNIT.C, C25UNIT.H
C25_EMPTY_NAME	label	byte
		db	00h,00h

; DS:0FD6  used by C27UNIT.C, C27UNIT.H
C27_STATIC_TEXT	label	byte
		db	'static',0
		db	00h

; DS:0FDE  used by C31UNIT.C, C31UNIT.H
C31_DEFAULT_DISPATCH	label	byte
		db	20h,00h
		dw	seg X039_00
		db	20h,00h
		dw	seg X03B_00
		db	43h,00h
		dw	seg X03B_00
		db	34h,00h
		dw	seg X03B_00
		db	25h,00h
		dw	seg X03B_00
		db	25h,00h
		dw	seg X039_00
		db	48h,00h
		dw	seg X001_00
		db	3Eh,00h
		dw	seg X03B_00
		db	2Fh,00h
		dw	seg X020_00
		db	75h,00h
		dw	seg X001_00
		db	70h,00h
		dw	seg X001_00
		db	3Eh,00h
		dw	seg X041_00
		db	2Ah,00h
		dw	seg X01F_00
		db	2Ah,00h
		dw	seg X00A_02
		db	20h,00h
		dw	seg X018_00
		db	2Ah,00h
		dw	seg X03B_00
		db	25h,00h
		dw	seg X018_00
		db	20h,00h
		dw	seg X038_00
		db	20h,00h
		dw	seg X001_00
		db	7Ah,00h
		dw	seg X001_00
		db	61h,00h
		dw	seg X001_00
		db	25h,00h
		dw	seg X01F_00
		db	6Bh,00h
		dw	seg X001_00
		db	43h,00h
		dw	seg X001_00
		db	2Ah,00h
		dw	seg X041_00
		db	25h,00h
		dw	seg X041_00
		db	20h,00h
		dw	seg X041_00
		db	2Ah,00h
		dw	seg X001_00
		db	2Ah,00h
		dw	seg X039_00
		db	20h,00h
		dw	seg X03A_00
		db	20h,00h
		dw	seg X020_00
		db	25h,00h
		dw	seg X020_00
		db	39h,00h
		dw	seg X03B_00
		db	2Fh,00h
		dw	seg X03B_00
		db	34h,00h
		dw	seg X001_00
		db	52h,00h
		dw	seg X001_00
		db	66h,00h
		dw	seg X001_00
		db	7Fh,00h
		dw	seg X001_00
		db	2Fh,00h
		dw	seg X001_00
		db	84h,00h
		dw	seg X001_00
		db	3Eh,00h
		dw	seg X001_00
		db	89h,00h
		dw	seg X001_00
		db	25h,00h
		dw	seg X001_00
		db	98h,00h
		dw	seg X001_00
		db	57h,00h
		dw	seg X001_00
		db	39h,00h
		dw	seg X001_00
		db	93h,00h
		dw	seg X001_00
		db	8Eh,00h
		dw	seg X001_00
		db	5Ch,00h
		dw	seg X001_00

; DS:10A2  used by C227UNIT.C
STR_COLON	label	byte
		db	3Ah,00h

; DS:10A4  used by C51UNIT.C, C51UNIT.H
STR_ERRORS_IN_COMPILE	label	byte
		db	'*** %d errors in Compile ***',0Ah,0

; DS:10C2  used by R5B44.C
STR_FATAL	label	byte
		db	'Fatal',0

; DS:10C8  used by RG4A.C
STR_IN_FUNCTION	label	byte
		db	' in function %s',0

; DS:10D8  used by R5BED.C
STR_WARNING	label	byte
		db	'Warning',0

; DS:10E0  used by R5B44.C, R5B8B.C, R5BED.C
STR_ERROR	label	byte
		db	'Error',0

; DS:10E6  used by C240UNIT.C, C31UNIT.C, C31UNIT.H, R5B44.C, R5B8B.C, R5BED.C
DIAGNOSTIC_COUNT	label	byte
		db	00h,00h

; DS:10E8  used by RG4A.C
STR_FMT_SPACE_STRING	label	byte
		db	' %s',0

; DS:10EC  used by RG4A.C
STR_FMT_SPACE_LONG	label	byte
		db	' %ld',0

; DS:10F1  used by RG4A.C
STR_COLON_SPACE	label	byte
		db	3Ah,20h,00h

; DS:10F4  used by RG4A.C
STR_DIAG_NEWLINE	label	byte
		db	0Ah,00h

; DS:10F6  used by C33UNIT.C, C33UNIT.H
C33_POINTER_QUALIFIERS	label	byte
		db	00h,00h,00h,00h,0Ah,11h
		dw	seg BCC_SEG_180
		db	10h,11h
		dw	seg BCC_SEG_180
		db	16h,11h
		dw	seg BCC_SEG_180
		db	1Ch,11h
		dw	seg BCC_SEG_180
		db	' _es ',0
		db	' _cs ',0
		db	' _ss ',0
		db	' _ds ',0

; DS:1122  used by C33UNIT.C, C33UNIT.H
STR_VOID	label	byte
		db	'void',0

; DS:1127  used by C33UNIT.C, C33UNIT.H
STR_DOT_DOT_DOT	label	byte
		db	2Eh,2Eh,2Eh,00h

; DS:112B  used by C33UNIT.C, C33UNIT.H
STR_CONST	label	byte
		db	'const ',0

; DS:1132  used by C33UNIT.C, C33UNIT.H
STR_VOLATILE	label	byte
		db	'volatile ',0

; DS:113C  used by C33UNIT.C, C33UNIT.H
STR_ENUM	label	byte
		db	'enum ',0

; DS:1142  used by C33UNIT.C, C33UNIT.H
STR_ENUM_2	label	byte
		db	'enum',0

; DS:1147  used by C33UNIT.H
STR_FAR	label	byte
		db	' far ',0

; DS:114D  used by C33UNIT.C, C33UNIT.H
STR_NEAR	label	byte
		db	' near ',0

; DS:1154  used by C33UNIT.C, C33UNIT.H
STR_COLON_COLON	label	byte
		db	3Ah,3Ah,00h

; DS:1157  used by C33UNIT.C, C33UNIT.H
STR_PASCAL	label	byte
		db	' pascal',0

; DS:115F  used by C33UNIT.C, C33UNIT.H
STR_STAR_RPAREN	label	byte
		db	2Ah,29h,00h

; DS:1162  used by C33UNIT.C, C33UNIT.H
STR_CONST_2	label	byte
		db	' const ',0

; DS:116A  used by C33UNIT.C, C33UNIT.H
STR_VOLATILE_2	label	byte
		db	' volatile ',0

; DS:1175  used by C33UNIT.H
STR_STRUCT	label	byte
		db	'struct',0

; DS:117C  used by C33UNIT.C, C33UNIT.H
STR_UNION	label	byte
		db	'union',0

; DS:1182  used by C33UNIT.C, C33UNIT.H
STR_OPERATOR_3	label	byte
		db	'operator ',0

; DS:118C  used by C33UNIT.C, C33UNIT.H
STR_LPAREN_RPAREN	label	byte
		db	28h,29h,00h

; DS:118F  used by C33UNIT.C, C33UNIT.H
STR_CONST_3	label	byte
		db	' const',0

; DS:1196  used by C33UNIT.C, C33UNIT.H
STR_VOLATILE_3	label	byte
		db	' volatile',0

; DS:11A0  used by C33UNIT.C, C33UNIT.H
STR_OPERATOR_4	label	byte
		db	'operator=',0

; DS:11AA  used by C33UNIT.C, C33UNIT.H
STR_AN_INTEGRAL_TYPE	label	byte
		db	'an integral type',0

; DS:11BB  used by C33UNIT.C, C33UNIT.H
STR_A_POINTER_TYPE	label	byte
		db	'a pointer type',0

; DS:11CA  used by C33UNIT.C, C33UNIT.H
STR_A_SCALAR_TYPE	label	byte
		db	'a scalar type',0

; DS:11D8  used by C33UNIT.C, C33UNIT.H
STR_AN_ARITHMETIC_TYPE	label	byte
		db	'an arithmetic type',0

; DS:11EB  used by C33UNIT.C, C33UNIT.H
STR_A_SIMPLE_TYPE	label	byte
		db	'a simple type',0

; DS:11F9  used by C33UNIT.C, C33UNIT.H
STR_C_3	label	byte
		db	'C++',0

; DS:11FD  used by C33UNIT.C, C33UNIT.H
STR_C_4	label	byte
		db	43h,00h

; DS:11FF  used by C33UNIT.C, C33UNIT.H
STR_PASCAL_2	label	byte
		db	'Pascal',0

; DS:1206  used by C33UNIT.C, C33UNIT.H
STR_TYPE_CONVERSION	label	byte
		db	'type conversion',0

; DS:1216  used by C232UNIT.C
BINARY_PRECEDENCE_BY_TOKEN	label	byte
		db	7Eh,04h,78h,06h,78h,7Eh,7Eh,7Eh,28h,7Eh,7Eh,26h,26h,26h,26h,26h
		db	26h,26h,26h,26h,26h,26h,12h,12h,10h,10h,10h,1Ah,1Eh,1Ch,14h,14h
		db	24h,2Ah,22h,20h,18h,18h,16h,16h,16h,16h,7Eh,7Eh,0Ah,0Ah,0Ah,06h
		db	06h,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,0Ah,0Eh,7Eh,0Eh,7Eh,7Eh,0Ah,7Eh,7Eh,0Ah,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh

; DS:1299  used by C232UNIT.C
STACK_PRECEDENCE_BY_OP	label	byte
		db	7Fh,7Ch,01h,7Ah,01h,7Fh,7Fh,7Fh,28h,7Fh,7Fh,27h,27h,27h,27h,27h
		db	27h,27h,27h,27h,27h,27h,12h,12h,10h,10h,10h,1Ah,1Eh,1Ch,14h,14h
		db	2Bh,2Ah,22h,20h,18h,18h,16h,16h,16h,16h,0Bh,0Bh,0Bh,0Bh,0Bh,06h
		db	06h,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh
		db	7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh
		db	7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,05h,05h,0Bh,0Bh,0Bh,0Bh,01h
		db	7Ah,0Bh,7Fh,0Bh,0Eh,7Fh,0Eh,7Fh,7Fh,0Bh,7Fh,7Fh,0Ah,7Fh,7Fh,7Fh
		db	7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Fh,7Eh,7Eh
		db	7Eh,7Eh,7Fh

; DS:131C  used by C232UNIT.C
PREFIX_PRECEDENCE_BY_TOKEN	label	byte
		db	7Eh,7Ch,7Ch,7Ch,7Ch,7Eh,7Eh,7Eh,7Ch,7Eh,7Eh,7Ch,7Ch,7Ch,7Ch,7Ch
		db	7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,0Ah,0Ah,0Ah,7Ch,7Ch,0Ah,7Ch,7Ch,7Ch,7Ch
		db	7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,7Ch,0Ah,0Ah,0Ah,0Ah,0Ah,7Ch
		db	7Ch,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Ch,7Ch,0Ah,0Ah,0Ah,0Ah,7Ch
		db	7Ch,7Ch,7Eh,7Eh,7Ch,7Eh,7Ch,7Eh,7Eh,0Ah,7Eh,7Eh,0Ah,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh,7Eh
		db	7Eh,7Eh,7Eh

; DS:139F  used by C232UNIT.C
STR_SUBSCRIPTING	label	byte
		db	'Subscripting',0

; DS:13AC  used by C232UNIT.C
STR_FRIEND_3	label	byte
		db	'friend',0

; DS:13B3  used by C232UNIT.C
STR_VIRTUAL_3	label	byte
		db	'virtual',0
		db	00h

; DS:13BC  used by C234UNIT.C
TOKEN_OPERATOR_CODE	label	byte
		db	00h,36h,00h,3Ah,00h,47h,00h,00h,2Ah,07h,00h,12h,13h,14h,15h,16h
		db	17h,1Ah,1Bh,1Ch,18h,19h,08h,09h,0Ah,0Bh,0Ch,0Fh,10h,11h,0Dh,0Eh
		db	25h,26h,28h,27h,1Dh,1Eh,20h,1Fh,22h,21h,30h,2Fh,44h,3Fh,40h,3Bh
		db	3Dh,01h,02h,03h
		db	43 dup (0)
		db	46h,00h,00h,00h,00h

; DS:1420  used by C239UNIT.C
COMPARE_NEGATION_TABLE	label	byte
		db	3Ch,00h,3Eh,00h,00h,43h,00h,45h,41h
		db	23 dup (0)

; DS:1440  used by C233UNIT.C
STR_IF_2	label	byte
		db	49h,66h,00h,00h

; DS:1444  used by C39UNIT.C, C39UNIT.H
STR_A_STANDARD_CONVERSION	label	byte
		db	'a standard conversion',0

; DS:145A  used by C239UNIT.C
COMPARE_NEGATE_TABLE	label	byte
		db	1Eh,00h,1Dh,00h,22h,00h,21h,00h,20h,00h,1Fh,00h

; DS:1466  used by C239UNIT.C
FOLD_ADD_SIGNED_FN	label	byte
		db	2Ah,00h
		dw	seg X02A_00

; DS:146A  used by C239UNIT.C
FOLD_ADD_UNSIGNED_FN	label	byte
		db	20h,00h
		dw	seg X02A_00

; DS:146E  used by C239UNIT.C
FOLD_SUB_SIGNED_FN	label	byte
		db	66h,00h
		dw	seg X02A_00

; DS:1472  used by C239UNIT.C
FOLD_SUB_UNSIGNED_FN	label	byte
		db	3Eh,00h
		dw	seg X02A_00

; DS:1476  used by C239UNIT.C
FOLD_MUL_SIGNED_FN	label	byte
		db	6Bh,00h
		dw	seg X02A_00

; DS:147A  used by C239UNIT.C
FOLD_MUL_UNSIGNED_FN	label	byte
		db	43h,00h
		dw	seg X02A_00

; DS:147E  used by C239UNIT.C
FOLD_DIV_SIGNED_FN	label	byte
		db	5Ch,00h
		dw	seg X02A_00

; DS:1482  used by C239UNIT.C
FOLD_DIV_UNSIGNED_FN	label	byte
		db	39h,00h
		dw	seg X02A_00

; DS:1486  used by C239UNIT.C
FOLD_MOD_SIGNED_FN	label	byte
		db	70h,00h
		dw	seg X02A_00

; DS:148A  used by C239UNIT.C
FOLD_MOD_UNSIGNED_FN	label	byte
		db	48h,00h
		dw	seg X02A_00

; DS:148E  used by C239UNIT.C
FOLD_AND_LONG_FN	label	byte
		db	2Fh,00h
		dw	seg X02A_00

; DS:1492  used by C239UNIT.C
FOLD_OR_LONG_FN	label	byte
		db	25h,00h
		dw	seg X02A_00

; DS:1496  used by C239UNIT.C
FOLD_XOR_LONG_FN	label	byte
		db	34h,00h
		dw	seg X02A_00

; DS:149A  used by C239UNIT.C
FOLD_SHIFT_SIGNED_FN	label	byte
		db	57h,00h
		dw	seg X02A_00

; DS:149E  used by C239UNIT.C
FOLD_SHIFT_UNSIGNED_FN	label	byte
		db	4Dh,00h
		dw	seg X02A_00

; DS:14A2  used by C239UNIT.C
REAL_MUL_FN	label	byte
		db	63h,02h
		dw	seg BCC_FAR_970B

; DS:14A6  used by C239UNIT.C
REAL_DIV_FN	label	byte
		db	4Eh,04h
		dw	seg BCC_FAR_970B

; DS:14AA  used by C239UNIT.C
REAL_ADD_FN	label	byte
		db	2Fh,02h
		dw	seg BCC_FAR_970B

; DS:14AE  used by C239UNIT.C
REAL_SUB_FN	label	byte
		db	49h,02h
		dw	seg BCC_FAR_970B

; DS:14B2  used by C239UNIT.C
NO_REAL_FOLD_FN	label	byte
		db	52h,00h
		dw	seg X02A_00

; DS:14B6  used by C235UNIT.C
TYPE_RECORD_SIZE	label	byte
		db	0Fh,08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,0Eh,0Eh,0Eh
		db	0Eh,10h,0Eh,08h,08h,08h

; DS:14CC  used by C235UNIT.C
MEMBER_RECORD_SIZE	label	byte
		db	0Ch,0Ch,08h,08h

; DS:14D0  used by C235UNIT.C, C9INIT.C, C9INIT.H
DUPLICATE_TYPE_FREE_LIST	label	byte
		db	00h,00h

; DS:14D2  used by C235UNIT.C
SYMBOL_RECORD_SIZE	label	byte
		db	17h,17h,0Ch,0Ch,0Ch,0Ch,0Ch,0Ch,12h,12h,0Ah,0Ah,0Eh,18h,10h,18h
		db	0Ch,0Ch

; DS:14E4  used by C238UNIT.C, C240UNIT.C, C31UNIT.C, C31UNIT.H, C5CB.C
SESSION_PHASE	label	byte
		db	00h,00h,24h,2Ah,24h,2Ah,24h,2Ah,0Ch,88h,0Ah,03h
		db	'BORLANDC',0

; DS:14F9  used by C238UNIT.C, C51UNIT.C, C51UNIT.H
DEFAULT_SOURCE_EXT	label	byte
		db	'.cpp',0
		db	01h,00h,0FEh,1Ch,02h,00h,0FFh,1Ch,03h,00h,01h,1Dh,04h,00h,02h,1Dh
		db	05h,00h,04h,1Dh,06h,00h,06h,1Dh,07h,00h,08h,1Dh,08h,00h,0Ah,1Dh
		db	09h,00h,0Ch,1Dh,0Bh,00h,10h,1Dh,0Ch,00h,12h,1Dh,0Dh,00h,15h,1Dh
		db	0Eh,00h,18h,1Dh,0Fh,00h,1Bh,1Dh,10h,00h,1Eh,1Dh,11h,00h,21h,1Dh
		db	12h,00h,24h,1Dh,13h,00h,27h,1Dh,14h,00h,2Ah,1Dh,15h,00h,2Eh,1Dh
		db	16h,00h,32h,1Dh,17h,00h,34h,1Dh,18h,00h,36h,1Dh,19h,00h,38h,1Dh
		db	1Ah,00h,3Ah,1Dh,1Bh,00h,3Ch,1Dh,1Ch,00h,3Eh,1Dh,1Dh,00h,40h,1Dh
		db	1Eh,00h,42h,1Dh,1Fh,00h,45h,1Dh,20h,00h,48h,1Dh,21h,00h,4Ah,1Dh
		db	22h,00h,4Ch,1Dh,23h,00h,4Fh,1Dh,24h,00h,52h,1Dh,25h,00h,55h,1Dh
		db	26h,00h,43h,1Dh,27h,00h,46h,1Dh,28h,00h,2Bh,1Dh,29h,00h,2Fh,1Dh
		db	2Ah,00h,58h,1Dh,2Bh,00h,5Ah,1Dh,2Dh,00h,5Ch,1Dh,2Eh,00h,5Fh,1Dh
		db	2Fh,00h,0Eh,1Dh,30h,00h,62h,1Dh,64h,00h,65h,1Dh,66h,00h,68h,1Dh
		db	67h,00h,6Ch,1Dh,68h,00h,6Fh,1Dh,69h,00h,75h,1Dh,6Ah,00h,7Ch,1Dh
		db	6Bh,00h,83h,1Dh,6Ch,00h,8Ah,1Dh,6Dh,00h,8Eh,1Dh,6Eh,00h,97h,1Dh
		db	6Fh,00h,0A0h,1Dh,70h,00h,0A8h,1Dh,71h,00h,0B2h,1Dh,72h,00h,0B9h,1Dh
		db	73h,00h,0BEh,1Dh,51h,00h,0C6h,1Dh,52h,00h,0CAh,1Dh,53h,00h,0CEh,1Dh
		db	55h,00h,0D2h,1Dh,54h,00h,0D7h,1Dh,57h,00h,0DBh,1Dh,57h,00h,0DFh,1Dh
		db	48h,00h,0E4h,1Dh,48h,00h,0EAh,1Dh,4Eh,00h,0F1h,1Dh,50h,00h,0F9h,1Dh
		db	50h,00h,0FDh,1Dh,56h,00h,02h,1Eh,56h,00h,07h,1Eh,46h,00h,0Dh,1Eh
		db	46h,00h,17h,1Eh,4Ch,00h,22h,1Eh,4Fh,00h,2Ah,1Eh,4Fh,00h,2Fh,1Eh
		db	47h,00h,35h,1Eh,47h,00h,3Ch,1Eh,4Dh,00h,44h,1Eh,4Ah,00h,4Eh,1Eh
		db	3Eh,00h,54h,1Eh,4Bh,00h,5Bh,1Eh,44h,00h,64h,1Eh,45h,00h,69h,1Eh
		db	39h,00h,6Eh,1Eh,60h,00h,73h,1Eh,63h,00h,79h,1Eh,3Ah,00h,7Eh,1Eh
		db	61h,00h,83h,1Eh,62h,00h,8Ch,1Eh,5Dh,00h,94h,1Eh,41h,00h,97h,1Eh
		db	5Ah,00h,9Eh,1Eh,36h,00h,0A3h,1Eh,40h,00h,0AAh,1Eh,5Bh,00h,0B0h,1Eh
		db	58h,00h,0B4h,1Eh,59h,00h,0B9h,1Eh,3Ch,00h,0BCh,1Eh,3Fh,00h,0C0h,1Eh
		db	38h,00h,0C5h,1Eh,5Fh,00h,0CEh,1Eh,3Bh,00h,0D5h,1Eh,2Ch,00h,0DBh,1Eh
		db	35h,00h,0E2h,1Eh,42h,00h,0E9h,1Eh,5Eh,00h,0F0h,1Eh,37h,00h,0F7h,1Eh
		db	43h,00h,0FFh,1Eh,3Dh,00h,05h,1Fh,5Ch,00h,0Eh,1Fh

; DS:16CA  used by C240UNIT.C, C31UNIT.C, C31UNIT.H
C31_KEYWORD_GROUPS	label	byte
		db	0F2h,15h
		dw	seg BCC_SEG_180
		db	16h,00h,4Ah,16h
		dw	seg BCC_SEG_180
		db	03h,00h,56h,16h
		dw	seg BCC_SEG_180
		db	02h,00h,5Eh,16h
		dw	seg BCC_SEG_180
		db	1Bh,00h,0FEh,14h
		dw	seg BCC_SEG_180
		db	31h,00h,0C2h,15h
		dw	seg BCC_SEG_180
		db	0Ch,00h

; DS:16EE  used by C238UNIT.C, C9INIT.C, C9INIT.H
OPTION_BLOCK	label	byte
		db	00h

; DS:16EF  used by C107UNIT.C, C117UNIT.C, C125UNIT.C, C127UNIT.C, C16UNIT.C, C16UNIT.H, 17 more
OPTION_MEMORY_MODEL	label	byte
		db	01h

; DS:16F0  used by C107UNIT.C, C114UNIT.C, C205UNIT.C, C207UNIT.C, C84UNIT.C, EMITMAIN.H, 2 more
OPTION_TARGET_CPU	label	byte
		db	00h

; DS:16F1  used by C124UNIT.C, C240UNIT.C, C9INIT.H, STAOV0F5.C
NEAR_HELPER_CALLS	label	byte
		db	00h

; DS:16F2  used by C100UNIT.C, C109UNIT.C, C10TYPE.C, C10TYPE.H, C131UNIT.C, C202UNIT.C, 5 more
BCC_PACK_FLAG	label	byte
		db	00h

; DS:16F3  used by C107UNIT.C, C109UNIT.C, C51UNIT.C, C51UNIT.H
OPTION_FLOAT_MODE	label	byte
		db	01h

; DS:16F4  used by EMIT7.H, R7HELP.C, STAOV0F7.C
OPTION_FAST_FLOAT	label	byte
		db	01h

; DS:16F5  used by C111UNIT.C, C119UNIT.C, C125UNIT.C, C130UNIT.C, C137UNIT.C, C139UNIT.C, 12 more
LANGUAGE_MODE	label	byte
		db	00h

; DS:16F6  used by C202UNIT.C, C226UNIT.C, C240UNIT.C, C9INIT.H
UNSIGNED_CHAR	label	byte
		db	00h

; DS:16F7  used by C138UNIT.C
COMMENT_NESTED	label	byte
		db	00h,01h

; DS:16F9  used by C51UNIT.C, C51UNIT.H, C53UNIT.C, C53UNIT.H, C5CB.C, R5B8B.C, 1 more
OPTION_ERROR_LIMIT	label	byte
		db	19h

; DS:16FA  used by C51UNIT.C, C51UNIT.H, R5BED.C, RDRV388.C
OPTION_WARNING_LIMIT	label	byte
		db	64h

; DS:16FB  used by C129UNIT.C, C130UNIT.C, C226UNIT.C, C49UNIT.C, C49UNIT.H
NAME_LIMIT	label	byte
		db	20h

; DS:16FC  used by C51UNIT.C, C51UNIT.H, C53UNIT.C, C53UNIT.H
C51_SKIP_LINK	label	byte
		db	00h,00h

; DS:16FE  used by C107UNIT.C, C117UNIT.C
OPTION_NO_AUTODEPEND	label	byte
		db	00h

; DS:16FF  used by C203UNIT.C, C207UNIT.C
OPTION_STACK_CHECK	label	byte
		db	00h

; DS:1700  used by C100UNIT.C, C102UNIT.C, C113UNIT.C, C114UNIT.C, C202UNIT.C, C207UNIT.C, 8 more
OPTION_SOURCE_DEBUG	label	byte
		db	00h

; DS:1701  used by C113UNIT.C, C114UNIT.C, C207UNIT.C
OPTION_LINE_NUMBERS	label	byte
		db	00h

; DS:1702  used by C106UNIT.C, C122UNIT.C, C207UNIT.C, C209UNIT.C, STAOV0F4.C
OPTION_OPTIMIZE_SPEED	label	byte
		db	00h

; DS:1703  used by C220UNIT.C
OPTIMIZE_ENABLED	label	byte
		db	00h

; DS:1704  used by C101UNIT.C
OPTION_SUPPRESS_RELOADS	label	byte
		db	00h

; DS:1705  used by C119UNIT.C, C125UNIT.C, C202UNIT.C, C51UNIT.C, C51UNIT.H, C52UNIT.C, 5 more
OPTION_CALLING_CONVENTION	label	byte
		db	00h

; DS:1706  used by C207UNIT.C
OPTION_STANDARD_FRAME	label	byte
		db	01h

; DS:1707  used by C212UNIT.C, C220UNIT.C
OPTION_REGISTER_VARS	label	byte
		db	01h

; DS:1708  used by C119UNIT.C, C202UNIT.C, EARGS.C
OPTION_MERGE_STRINGS	label	byte
		db	00h

; DS:1709  used by C100UNIT.C, C117UNIT.C, C205UNIT.C, C207UNIT.C, C231UNIT.C, C51UNIT.C, 6 more
OPTION_OVERLAY_CODE	label	byte
		db	00h

; DS:170A  used by C52UNIT.C, C52UNIT.H
C52_OS2_OPTION	label	byte
		db	00h

; DS:170B  used by C52UNIT.C, C52UNIT.H
C52_MULTITHREAD_OPTION	label	byte
		db	00h

; DS:170C  used by C52UNIT.C, C52UNIT.H
C52_DLL_OPTION	label	byte
		db	00h,00h,00h,00h,00h,00h

; DS:1712  used by C203UNIT.C, C238UNIT.C, EMIT045.H, EMITMAIN.H, R7MAIN.C
HUGE_PTR_AHSHIFT_MODE	label	byte
		db	00h

; DS:1713  used by BUILD6.H, C119UNIT.C, C203UNIT.C, C234UNIT.C, C6BUILD.C, C76UNIT.C, 3 more
OPTION_DS_NOT_SS	label	byte
		db	00h

; DS:1714  used by C100UNIT.C, C113UNIT.C, C114UNIT.C, C117UNIT.C, C127UNIT.C, C128UNIT.C, 11 more
COMPILER_MODE	label	byte
		db	00h

; DS:1715  used by C114UNIT.C, C238UNIT.C, C52UNIT.C, C52UNIT.H, C53UNIT.C, C53UNIT.H, 2 more
OPTION_COMPILE_VIA_ASM	label	byte
		db	00h

; DS:1716  used by C100UNIT.C, C117UNIT.C, C202UNIT.C, C218UNIT.C, C222UNIT.C, C227UNIT.C, 4 more
OPTION_UNDERSCORES	label	byte
		db	01h,00h,00h,00h

; DS:171A  used by C52UNIT.C, C52UNIT.H
C52_CODE_NAME_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:171E  used by C52UNIT.C, C52UNIT.H
C52_CODE_GROUP_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1722  used by C52UNIT.C, C52UNIT.H
C52_CODE_CLASS_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1726  used by C52UNIT.C, C52UNIT.H
C52_DATA_NAME_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:172A  used by C52UNIT.C, C52UNIT.H
C52_DATA_GROUP_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:172E  used by C52UNIT.C, C52UNIT.H
C52_DATA_CLASS_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1732  used by C52UNIT.C, C52UNIT.H
C52_BSS_NAME_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1736  used by C52UNIT.C, C52UNIT.H
C52_BSS_GROUP_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:173A  used by C52UNIT.C, C52UNIT.H
C52_BSS_CLASS_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:173E  used by C52UNIT.C, C52UNIT.H
C52_FAR_NAME_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1742  used by C52UNIT.C, C52UNIT.H
C52_FAR_GROUP_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:1746  used by C52UNIT.C, C52UNIT.H
C52_FAR_CLASS_OPTION	label	byte
		db	36h,1Dh
		dw	seg BCC_SEG_180

; DS:174A  used by C51UNIT.C, C51UNIT.H, C52UNIT.C, C52UNIT.H
OPTION_OUTPUT_DIR	label	byte
		db	00h,1Dh
		dw	seg BCC_SEG_180

; DS:174E  used by C51UNIT.C, C51UNIT.H, C52UNIT.C, C52UNIT.H, RMAIN13C.C, STOVR141.C
OPTION_OBJECT_NAME	label	byte
		db	00h,00h,00h,00h,00h,1Dh
		dw	seg BCC_SEG_180

; DS:1756  used by C128UNIT.C, C130UNIT.C, C238UNIT.C
INCLUDE_OPTION_TEXT_PTR	label	byte
		db	00h,1Dh
		dw	seg BCC_SEG_180
		db	00h,00h,00h,00h

; DS:175E  used by C51UNIT.C, C51UNIT.H
LINK_OUTPUT_NAME	label	byte
		db	00h,00h,00h,00h

; DS:1762  used by C117UNIT.C, C226UNIT.C, C238UNIT.C, C31UNIT.C, C31UNIT.H, C51UNIT.C, 5 more
OPTION_FLAGS	label	byte
		db	00h

; DS:1763  used by C127UNIT.C, C12CHECK.C, C12CHECK.H, C13UNIT.C, C13UNIT.H, C236UNIT.C, 6 more
VTABLE_MODE	label	byte
		db	03h

; DS:1764  used by C202UNIT.C, C9INIT.C, C9INIT.H
OPTION_ENUMS_AS_INT	label	byte
		db	01h

; DS:1765  used by C128UNIT.C
PCH_OPTION_MODE	label	byte
		db	00h

; DS:1766  used by C128UNIT.C, C53UNIT.C, C53UNIT.H
PCH_FILE_NAME	label	byte
		db	00h,00h,00h,00h

; DS:176A  used by C238UNIT.C, R5CLEAN.C
EMS_PAGE_LIMIT	label	byte
		db	00h,00h

; DS:176C  used by C238UNIT.C, R5CLEAN.C
EXT_MEMORY_BASE	label	byte
		db	0FFh,0FFh,0FFh,0FFh

; DS:1770  used by C238UNIT.C, R5CLEAN.C
EXT_MEMORY_BANK_SIZE	label	byte
		db	00h,00h,00h,00h

; DS:1774  used by C51UNIT.C, C51UNIT.H, RMAIN13C.C
OPTION_LINK_OVERLAY	label	byte
		db	00h

; DS:1775  used by C9INIT.C, C9INIT.H
OPTION_EXPAND_INLINES	label	byte
		db	01h

; DS:1776  used by C100UNIT.C, C117UNIT.C, C119UNIT.C, C130UNIT.C, C202UNIT.C, C203UNIT.C, 14 more
OPTION_WINDOWS_MODE	label	byte
		db	00h

; DS:1777  used by C238UNIT.C, C31UNIT.C, C31UNIT.H
C31_MEMORY_OPTION	label	byte
		db	01h

; DS:1778  used by C127UNIT.C, C12CHECK.C, C12CHECK.H, C14UNIT.C, C14UNIT.H, C201UNIT.C, 2 more
OPTION_FLAG	label	byte
		db	00h

; DS:1779  used by C202UNIT.C
OPTION_COMDEFS	label	byte
		db	00h

; DS:177A  used by BUILD6.H, C123UNIT.C, C234UNIT.C, C51UNIT.C, C51UNIT.H, C6BUILD.C, 2 more
OPTION_SS_EQUALS_DS	label	byte
		db	00h

; DS:177B  used by C202UNIT.C, C83UNIT.C, C83UNIT.H
OPTION_AUTO_FAR_DATA	label	byte
		db	00h

; DS:177C  used by C202UNIT.C, C83UNIT.C, C83UNIT.H
FAR_DATA_THRESHOLD	label	byte
		db	0FFh,7Fh

; DS:177E  used by C238UNIT.C
COMMAND_OPTION_TABLE	label	byte
		db	41h,02h,67h,05h,76h,1Ah,00h,00h,66h,02h,67h,05h,0B6h,1Ah,00h,00h
		db	6Dh,01h,67h,05h,2Eh,1Bh,00h,00h,72h,02h,67h,05h,96h,1Bh,00h,00h
		db	7Ah,02h,67h,05h,0C6h,1Bh,00h,00h,31h,02h,9Ch,03h,0F0h,16h,00h,00h
		db	32h,02h,81h,05h,0F0h,16h,02h,00h,43h,02h,9Ch,03h,0F7h,16h,00h,00h
		db	47h,02h,9Ch,03h,02h,17h,00h,00h,4Bh,02h,9Ch,03h,0F6h,16h,00h,00h
		db	4Eh,02h,9Ch,03h,0FFh,16h,00h,00h,4Fh,02h,67h,05h,0F6h,1Ah,00h,00h
		db	5Ah,02h,9Ch,03h,04h,17h,00h,00h,61h,02h,9Ch,03h,0F2h,16h,00h,00h
		db	62h,02h,9Ch,03h,64h,17h,00h,00h,64h,02h,9Ch,03h,08h,17h,00h,00h
		db	6Bh,02h,9Ch,03h,06h,17h,00h,00h,70h,02h,67h,05h,2Eh,1Ah,00h,00h
		db	75h,01h,9Ch,03h,16h,17h,00h,00h,76h,02h,67h,05h,5Eh,1Ch,00h,00h
		db	79h,02h,9Ch,03h,01h,17h,00h,00h,6Eh,01h,0A6h,05h,4Ah,17h,00h,00h
		db	6Fh,01h,0A6h,05h,4Eh,17h,00h,00h,67h,02h,0F3h,05h,0FAh,16h,0FFh,00h
		db	69h,01h,0F3h,05h,0FBh,16h,20h,00h,6Ah,02h,0F3h,05h,0F9h,16h,0FFh,00h
		db	77h,02h,51h,04h,00h,00h,00h,00h,59h,01h,81h,05h,0D4h,82h,00h,00h
		db	59h,01h,81h,05h,76h,17h,00h,00h,59h,01h,67h,05h,46h,1Ah,00h,00h
		db	42h,00h,9Ch,03h,15h,17h,00h,00h,53h,00h,9Ch,03h,14h,17h,00h,00h
		db	79h,00h,9Ch,03h,0CFh,24h,00h,00h,45h,00h,0A6h,05h,0BCh,24h,00h,00h
		db	4Dh,00h,9Ch,03h,0FDh,16h,01h,00h,4Dh,00h,9Ch,03h,0D0h,24h,00h,00h
		db	4Dh,00h,15h,04h,0DBh,24h,00h,00h,63h,00h,9Ch,03h,0FCh,16h,00h,00h
		db	65h,00h,0A6h,05h,5Eh,17h,00h,00h,44h,00h,29h,09h,00h,00h,00h,00h
		db	49h,00h,0FDh,09h,00h,00h,00h,00h,4Ch,00h,21h,0Ah,00h,00h,00h,00h
		db	55h,00h,0E6h,09h,00h,00h,00h,00h,6Ch,00h,0C4h,07h,00h,00h,00h,00h
		db	54h,00h,9Bh,06h,00h,00h,00h,00h,68h,02h,9Ch,03h,12h,17h,00h,00h
		db	50h,00h,3Dh,07h,00h,00h,00h,00h,58h,00h,9Ch,03h,0FEh,16h,00h,00h
		db	56h,00h,67h,05h,2Eh,1Ch,00h,00h,48h,00h,67h,05h,0AEh,1Ch,00h,00h
		db	51h,00h,67h,05h,0DEh,1Ch,00h,00h,57h,01h,81h,05h,09h,17h,00h,00h
		db	57h,01h,81h,05h,0D4h,82h,01h,00h,57h,01h,67h,05h,0F6h,19h,00h,00h
		db	46h,00h,67h,05h,96h,19h
		db	10 dup (0)
		db	2Dh,00h,81h,05h,7Bh,17h,00h,00h,00h,00h,81h,05h,7Bh,17h,01h,00h
		db	3Dh,00h,47h,06h,7Ch,17h,0FFh,0FFh
		db	8 dup (0)
		db	2Dh,00h,81h,05h,79h,17h,00h,00h,2Dh,00h,81h,05h,7Ah,17h,00h,00h
		db	2Dh,00h,81h,05h,7Bh,17h,00h,00h,00h,00h,81h,05h,79h,17h,01h,00h
		db	00h,00h,81h,05h,7Ah,17h,01h,00h,00h,00h,81h,05h,7Bh,17h,01h
		db	9 dup (0)
		db	63h,00h,9Ch,03h,79h,17h,00h,00h,73h,00h,9Ch,03h,7Ah,17h,00h,00h
		db	66h,00h,81h,05h,7Bh,17h,01h,00h,66h,00h,67h,05h,3Eh,19h,00h,00h
		db	6Dh,00h,67h,05h,5Eh,19h
		db	11 dup (0)
		db	02h,81h,05h,76h,17h,02h,00h,45h,02h,81h,05h,76h,17h,05h
		db	10 dup (0)
		db	02h,81h,05h,76h,17h,03h,00h,44h,02h,81h,05h,76h,17h,05h
		db	10 dup (0)
		db	02h,81h,05h,76h,17h,01h,00h,2Dh,02h,81h,05h,76h,17h,00h,00h,2Dh
		db	02h,81h,05h,0D4h,82h,00h,00h,53h,02h,81h,05h,76h,17h,04h,00h,44h
		db	02h,67h,05h,0C6h,19h,00h,00h,45h,02h,67h,05h,0DEh,19h
		db	11 dup (0)
		db	02h,81h,05h,05h,17h,01h,00h,2Dh,02h,81h,05h,05h,17h
		db	11 dup (0)
		db	01h,81h,05h,09h,17h,01h,00h,2Dh,01h,81h,05h,09h,17h,00h,00h,66h
		db	01h,81h,05h,09h,17h,01h,00h,6Eh,01h,81h,05h,09h,17h,02h,00h,6Fh
		db	01h,9Ch,03h,74h,17h
		db	11 dup (0)
		db	02h,81h,05h,0F5h,16h,01h,00h,2Bh,02h,81h,05h,0F5h,16h,01h,00h,4Bh
		db	02h,81h,05h,0F5h,16h,03h,00h,54h,02h,81h,05h,0F5h,16h,00h,00h,55h
		db	02h,81h,05h,0F5h,16h,02h,00h,2Dh,02h,81h,05h,0F5h,16h,00h,00h,2Eh
		db	02h,38h,05h,0F5h,16h
		db	11 dup (0)
		db	01h,81h,05h,0F3h,16h,01h,00h,2Bh,01h,81h,05h,0F3h,16h,01h,00h,32h
		db	01h,81h,05h,0F3h,16h,03h,00h,38h,01h,81h,05h,0F3h,16h,02h,00h,2Dh
		db	01h,81h,05h,0F3h,16h,00h,00h,2Eh,01h,38h,05h,0F3h,16h,00h,00h,66h
		db	02h,9Ch,03h,0F4h,16h
		db	11 dup (0)
		db	02h,81h,05h,03h,17h,01h,00h,30h,02h,81h,05h,03h,17h,00h,00h,31h
		db	02h,81h,05h,03h,17h,01h,00h,32h,02h,81h,05h,03h,17h,02h,00h,2Dh
		db	02h,81h,05h,03h,17h,00h,00h,2Eh,02h,38h,05h,03h,17h
		db	10 dup (0)
		db	63h,01h,81h,05h,0EFh,16h,03h,00h,68h,01h,81h,05h,0EFh,16h,05h,00h
		db	6Ch,01h,81h,05h,0EFh,16h,04h,00h,6Dh,01h,81h,05h,0EFh,16h,02h,00h
		db	73h,01h,81h,05h,0EFh,16h,01h,00h,74h,01h,81h,05h,0EFh,16h,00h,00h
		db	6Dh,01h,67h,05h,7Eh,1Bh,00h,00h,73h,01h,67h,05h,7Eh,1Bh,00h,00h
		db	74h,01h,67h,05h,7Eh,1Bh
		db	11 dup (0)
		db	01h,9Ah,05h,00h,00h,00h,00h,21h,01h,9Ch,03h,13h,17h
		db	10 dup (0)
		db	64h,02h,81h,05h,07h,17h,02h,00h,2Dh,02h,81h,05h,07h,17h,00h,00h
		db	2Bh,02h,81h,05h,07h,17h,01h,00h,00h,02h,81h,05h,07h,17h,01h,00h
		db	2Eh,02h,38h,05h,07h,17h
		db	10 dup (0)
		db	44h,01h,0A6h,05h,32h,17h,00h,00h,47h,01h,0A6h,05h,36h,17h,00h,00h
		db	42h,01h,0A6h,05h,3Ah,17h,00h,00h,43h,01h,0A6h,05h,1Ah,17h,00h,00h
		db	50h,01h,0A6h,05h,1Eh,17h,00h,00h,41h,01h,0A6h,05h,22h,17h,00h,00h
		db	52h,01h,0A6h,05h,26h,17h,00h,00h,53h,01h,0A6h,05h,2Ah,17h,00h,00h
		db	54h,01h,0A6h,05h,2Eh,17h,00h,00h,45h,02h,0A6h,05h,3Eh,17h,00h,00h
		db	48h,02h,0A6h,05h,42h,17h,00h,00h,46h,02h,0A6h,05h,46h,17h
		db	12 dup (0)
		db	81h,05h,63h,17h,03h,00h,30h,00h,81h,05h,63h,17h,01h,00h,31h,00h
		db	81h,05h,63h,17h,02h,00h,73h,00h,81h,05h,63h,17h,00h,00h,66h,00h
		db	9Ch,03h,78h,17h
		db	11 dup (0)
		db	02h,81h,05h,00h,17h,01h,00h,2Dh,02h,81h,05h,00h,17h,00h,00h,2Eh
		db	02h,38h,05h,00h,17h,00h,00h,00h,02h,81h,05h,75h,17h,00h,00h,2Dh
		db	02h,81h,05h,75h,17h,01h,00h,2Eh,02h,38h,05h,75h,17h,00h,00h,69h
		db	02h,9Ch,03h,75h,17h,00h,00h,2Dh,00h,81h,05h,0D9h,24h,00h,00h,00h
		db	00h,81h,05h,0D9h,24h,01h
		db	9 dup (0)
		db	2Dh,00h,81h,05h,65h,17h,00h,00h,75h,00h,81h,05h,65h,17h,04h,00h
		db	3Dh,00h,81h,05h,65h,17h,02h,00h,3Dh,00h,0A6h,05h,66h,17h,00h,00h
		db	00h,00h,81h,05h,65h,17h,02h
		db	9 dup (0)
		db	65h,00h,11h,0Fh,00h,00h,00h,00h,78h,00h,9Fh,0Fh,00h,00h,00h,00h
		db	73h,00h,9Ch,03h,77h,17h
		db	10 dup (0)
		db	28h,29h

; DS:1D00  used by C238UNIT.C
STR_EMPTY_MACRO_VALUE	label	byte
		db	00h,5Bh,5Dh,00h,7Bh,00h,7Dh,00h,3Bh,00h,2Ch,00h,2Eh,2Eh,2Eh,00h
		db	3Dh,00h,2Bh,3Dh,00h,2Dh,3Dh,00h,2Ah,3Dh,00h,2Fh,3Dh,00h,25h,3Dh
		db	00h,26h,3Dh,00h,7Ch,3Dh,00h,5Eh,3Dh,00h,3Ch,3Ch,3Dh,00h,3Eh,3Eh
		db	3Dh,00h,2Bh,00h,2Dh,00h,2Ah,00h,2Fh,00h,25h,00h,26h,00h,7Ch,00h
		db	5Eh,00h,3Ch,3Ch,00h,3Eh,3Eh,00h,3Fh,00h,3Ah,00h,7Ch,7Ch,00h,26h
		db	26h,00h,3Dh,3Dh,00h,21h,3Dh,00h,21h,00h,7Eh,00h,2Bh,2Bh,00h,2Dh
		db	2Dh,00h,2Dh,3Eh,00h,2Eh,2Ah,00h,2Dh,3Eh,2Ah,00h,3Ah,3Ah,00h
		db	'class',0
		db	'delete',0
		db	'friend',0
		db	'inline',0
		db	'new',0
		db	'operator',0
		db	'overload',0
		db	'private',0
		db	'protected',0
		db	'public',0
		db	'this',0
		db	'virtual',0
		db	'_cs',0
		db	'_ds',0
		db	'_es',0
		db	5Fh,73h,65h

; DS:1DD5  used by C238UNIT.C
STR_INCLUDE_GIVEN_MARK	label	byte
		db	67h,00h
		db	'_ss',0
		db	'asm',0
		db	'_asm',0
		db	'cdecl',0
		db	'_cdecl',0
		db	'_export',0
		db	'far',0
		db	'_far',0
		db	'huge',0
		db	'_huge',0
		db	'interrupt',0
		db	'_interrupt',0
		db	'_loadds',0
		db	'near',0
		db	'_near',0
		db	'pascal',0
		db	'_pascal',0
		db	'_saveregs',0
		db	'const',0
		db	'signed',0
		db	'volatile',0
		db	'enum',0
		db	'void',0
		db	'auto',0
		db	'break',0
		db	'case',0
		db	'char',0
		db	'continue',0
		db	'default',0
		db	64h,6Fh,00h
		db	'double',0
		db	'else',0
		db	'extern',0
		db	'float',0
		db	'for',0
		db	'goto',0
		db	69h,66h,00h
		db	'int',0
		db	'long',0
		db	'register',0
		db	'return',0
		db	'short',0
		db	'sizeof',0
		db	'static',0
		db	'struct',0
		db	'switch',0
		db	'typedef',0
		db	'union',0
		db	'unsigned',0
		db	'while',0

; DS:1F14  used by C238UNIT.C
STR_CPP	label	byte
		db	'.cpp',0

; DS:1F19  used by C238UNIT.C
STR_BACKSLASH	label	byte
		db	5Ch,00h,00h

; DS:1F1C  used by C139UNIT.C
DISCARD_CHAR_EMIT_FN	label	byte
		db	34h,00h
		dw	seg X030_04

; DS:1F20  used by C130UNIT.C
DIRECTIVE_TABLE	label	byte
		db	84h,1Fh,0Bh,54h,06h,8Bh,1Fh,0Ch,0BBh,06h,91h,1Fh,01h,9Ah,07h,99h
		db	1Fh,02h,7Ah,09h,0A0h,1Fh,03h,0D1h,0Bh,0A6h,1Fh,07h,60h,0Ch,0A9h,1Fh
		db	04h,2Ah,0Dh,0AFh,1Fh,05h,3Dh,0Dh,0B6h,1Fh,08h,4Fh,0Dh,0BBh,1Fh,0Ah
		db	0A1h,0Dh,0C0h,1Fh,06h,04h,0Eh,0C6h,1Fh,09h,37h,0Eh

; DS:1F5C  used by C130UNIT.C
PRAGMA_TABLE	label	byte
		db	3Ah,01h,0F8h,1Fh,14h,02h,0FDh,1Fh,62h,03h,04h,20h,73h,03h,0Dh,20h
		db	3Dh,03h,14h,20h,4Fh,03h,1Ch,20h,43h,04h,21h,20h,54h,04h,2Ah,20h
		db	0B0h,04h,33h,20h,00h,00h,00h,00h

; DS:1F84  used by C130UNIT.C
STR_PRAGMA	label	byte
		db	'pragma',0
		db	'error',0
		db	'include',0

; DS:1F99  used by C130UNIT.C
STR_DEFINE	label	byte
		db	'define',0
		db	'undef',0
		db	69h,66h,00h
		db	'ifdef',0
		db	'ifndef',0
		db	'else',0
		db	'elif',0
		db	'endif',0

; DS:1FC6  used by C130UNIT.C
STR_LINE	label	byte
		db	'line',0

; DS:1FCB  used by C130UNIT.C
STR_MISSING_FUNCTION	label	byte
		db	'missing function identifier',0

; DS:1FE7  used by C130UNIT.C
STR_PRAGMA_DIRECTIVE	label	byte
		db	'pragma directive',0
		db	'warn',0
		db	'inline',0
		db	'saveregs',0
		db	'option',0
		db	'startup',0
		db	'exit',0
		db	'argsused',0
		db	'noretval',0
		db	'codeseg',0
		db	00h

; DS:203C  used by C226UNIT.C
LITERAL_CHAR_EMIT_PTR	label	byte
		db	52h,00h
		dw	seg X030_04

; DS:2040  used by C226UNIT.C
MONTH_ABBREVIATIONS	label	byte
		db	4Ah,61h,6Eh,46h,65h,62h,4Dh,61h,72h,41h,70h,72h,4Dh,61h,79h,4Ah
		db	75h,6Eh,4Ah,75h,6Ch,41h,75h,67h,53h,65h,70h,4Fh,63h,74h,4Eh,6Fh
		db	76h,44h,65h,63h

; DS:2064  used by C202UNIT.C
TOKEN_START_FLAGS	label	byte
		db	01h,01h,01h,01h,01h,01h,01h,01h,03h,01h,01h,02h,02h,02h,02h,02h
		db	02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h
		db	02h,03h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h
		db	02h,04h,04h,04h,04h,10h,10h,10h,10h,10h,20h,20h,20h,20h,20h,20h
		db	20h,20h,20h,20h,20h,20h,40h,40h,40h,40h,0A0h,0A0h,80h,80h,80h,0C0h
		db	0C0h,80h,80h,80h,80h,80h,0C0h,08h,08h,08h,08h,08h,08h,08h,08h,08h
		db	08h,08h,08h,08h,02h,04h,02h,03h,20h,02h,10h,10h,02h,20h,10h,10h
		db	10h,10h,04h,10h
		db	14 dup (0)

; DS:20E6  used by C226UNIT.C
SINGLE_CHAR_TOKEN_TABLE	label	byte
		db	2Ah,1Ah,1Bh,18h,16h,19h,1Dh,1Ch,0Bh

; DS:20EF  used by C226UNIT.C
OP_ASSIGN_TOKEN_TABLE	label	byte
		db	25h,10h,11h,0Eh,0Ch,0Fh,13h,12h,24h

; DS:20F8  used by C226UNIT.C
DOUBLED_CHAR_TOKEN_TABLE	label	byte
		db	00h,00h,23h,00h,2Dh,00h,00h,22h

; DS:2100  used by C128UNIT.C, C130UNIT.C, C226UNIT.C
CHAR_CLASS	label	byte
		db	24h,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0F7h,0ECh,0F7h,0F7h,0ECh
		db	0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0E7h,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0F7h,00h,0F4h,0EEh,0EEh,0FFh,0FEh,0F2h,01h,02h,0FDh,0FCh,08h,0F1h
		db	0F0h
		db	0FBh,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0DEh,07h,0EFh,0F8h
		db	0EDh
		db	20h,0EEh,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,03h,0EAh,04h
		db	0FAh
		db	0F6h,0EEh,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,05h,0F9h,06h
		db	2Bh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0F7h,0EEh
		db	0EEh,0EEh

; DS:2200  used by C226UNIT.C
LEX_READ_MODE0_CLASSES	label	byte
		db	0EEh,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0DFh,0ECh,0DFh,0DFh
		db	0ECh,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E7h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0DFh,0E6h,0E1h,0E3h,0E6h,0E6h,0E6h,0E1h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E2h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E4h
		db	0E6h,0E6h
		db	0F6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h

; DS:2300  used by C226UNIT.C
LEX_READ_MODE1_CLASSES	label	byte
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0ECh,0E6h,0E6h
		db	0ECh,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,08h,0E6h,0E6h,0E6h
		db	0E6h
		db	0E6h,0E6h,0E6h,0E5h,0E6h,0E6h,0E6h,0E6h,0E5h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E2h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0F6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0F7h,0E6h
		db	0E6h,0E6h
		db	0E6h

; DS:2401  used by C226UNIT.C
PREDEFINED_1	label	byte
		db	00h,00h,00h,00h,00h,00h,00h,80h,0FFh,7Fh

; DS:240B  used by C226UNIT.C
PRED_NAME_1	label	byte
		db	'STDC__',0

; DS:2412  used by C226UNIT.C
PRED_NAME_2	label	byte
		db	'cplusplus',0

; DS:241C  used by C226UNIT.C
PRED_NAME_3	label	byte
		db	'FILE__',0

; DS:2423  used by C226UNIT.C
PRED_NAME_4	label	byte
		db	'LINE__',0

; DS:242A  used by C226UNIT.C
PRED_NAME_5	label	byte
		db	'DATE__',0

; DS:2431  used by C226UNIT.C
PRED_NAME_6	label	byte
		db	'TIME__',0

; DS:2438  used by C226UNIT.C
STR_DEFINED	label	byte
		db	'defined',0

; DS:2440  used by C133UNIT.C
EOF_BUFFER_TEXT	label	byte
		db	0Ah,1Ah

; DS:2442  used by C133UNIT.C
STR_NEWLINE_INPUT	label	byte
		db	0Ah,00h

; DS:2444  used by C133UNIT.C
STR_DOUBLE_QUOTE	label	byte
		db	22h,00h

; DS:2446  used by C133UNIT.C
STR_BLANK_COMMENT_LINE	label	byte
		db	20h,20h,20h,3Bh,09h

; DS:244B  used by C133UNIT.C
STR_CRLF_ECHO	label	byte
		db	0Dh,0Ah,00h

; DS:244E  used by C133UNIT.C
STR_COMMENT_INDENT	label	byte
		db	20h,20h,20h,3Bh,09h,00h

; DS:2454  used by C238UNIT.C, C51UNIT.C, C51UNIT.H
ARGUMENT_LIST	label	byte
		db	00h,00h,00h,00h

; DS:2458  used by C238UNIT.C
ARGUMENT_LIST_TAIL	label	byte
		db	00h,00h,00h,00h

; DS:245C  used by C51UNIT.C, C51UNIT.H
C51_DOS_LIBRARIES	label	byte
		db	16h,25h,1Eh,25h,25h,25h,2Fh,25h,1Eh,25h,25h,25h,37h,25h,3Fh,25h
		db	46h,25h,50h,25h,58h,25h,5Fh,25h,69h,25h,71h,25h,78h,25h,82h,25h
		db	8Ah,25h,91h,25h

; DS:2480  used by C51UNIT.C, C51UNIT.H
STARTUP_SS_DS_NAMES	label	byte
		db	9Bh,25h,0A4h,25h,0ADh,25h,0B6h,25h,0BFh,25h,0C8h,25h

; DS:248C  used by C51UNIT.C, C51UNIT.H
C51_WINDOWS_LIBRARIES	label	byte
		db	0D1h,25h,1Eh,25h,25h,25h,0DAh,25h,1Eh,25h,25h,25h,0E3h,25h,3Fh,25h
		db	46h,25h,0ECh,25h,58h,25h,5Fh,25h,0F5h,25h,71h,25h,78h,25h,0FEh,25h
		db	8Ah,25h,91h,25h

; DS:24B0  used by C51UNIT.C, C51UNIT.H
C51_WINDOWS_RUNTIME	label	byte
		db	07h,26h,07h,26h,11h,26h,1Bh,26h,25h,26h,2Fh,26h

; DS:24BC  used by C51UNIT.C, C51UNIT.H
TASM_PROGRAM_NAME	label	byte
		db	39h,26h
		dw	seg BCC_SEG_180

; DS:24C0  used by C53UNIT.C, C53UNIT.H
C53_OPTION_PATH	label	byte
		db	42h,26h
		dw	seg BCC_SEG_180

; DS:24C4  used by C238UNIT.C, C51UNIT.C, C51UNIT.H
LINKER_SWITCH_FLAGS	label	byte
		db	00h,00h,01h
		db	20 dup (0)
		db	01h,00h,00h

; DS:24DE  used by C51UNIT.C, C51UNIT.H
C51_UPPER_LINK_OPTIONS	label	byte
		db	26 dup (0)

; DS:24F8  used by C51UNIT.C, C51UNIT.H
C51_DIGIT_LINK_OPTIONS	label	byte
		db	10 dup (0)
		db	'``````TC2.0',0

; DS:250E  used by C51UNIT.C, C51UNIT.H
LINK_LIBRARY_ARG_SEEN	label	byte
		db	00h,00h

; DS:2510  used by C51UNIT.C, C51UNIT.H
C51_DLL_MODEL	label	byte
		db	03h,03h,04h,03h,04h,05h,63h,30h,74h

; DS:2519  used by C51UNIT.C, C51UNIT.H
STR_OBJ_2	label	byte
		db	'.obj',0
		db	63h,73h

; DS:2520  used by C51UNIT.C, C51UNIT.H
SPECIAL_NAME	label	byte
		db	'.lib',0
		db	'maths.lib',0
		db	'c0s.obj',0
		db	'c0m.obj',0
		db	'cm.lib',0
		db	'mathm.lib',0
		db	'c0c.obj',0
		db	'cc.lib',0
		db	'mathc.lib',0
		db	'c0l.obj',0
		db	'cl.lib',0
		db	'mathl.lib',0
		db	'c0h.obj',0
		db	'ch.lib',0
		db	'mathh.lib',0
		db	'c0ft.obj',0
		db	'c0fs.obj',0
		db	'c0fm.obj',0
		db	'c0fc.obj',0
		db	'c0fl.obj',0
		db	'c0fh.obj',0
		db	'c0@t.obj',0
		db	'c0@s.obj',0
		db	'c0@m.obj',0
		db	'c0@c.obj',0
		db	'c0@l.obj',0
		db	'c0@h.obj',0
		db	'cwins.lib',0
		db	'cwinm.lib',0
		db	'cwinc.lib',0
		db	'cwinl.lib',0
		db	'cwinh.lib',0
		db	'tasm.exe',0
		db	'turboc.cfg',0

; DS:264D  used by C51UNIT.C, C51UNIT.H
STR_COLON_CRLF	label	byte
		db	3Ah,0Dh,0Ah,00h

; DS:2651  used by C51UNIT.C, C51UNIT.H
STR_ASM_EXT	label	byte
		db	'.asm',0

; DS:2656  used by C51UNIT.C, C51UNIT.H
STR_CPP_EXT	label	byte
		db	'.cpp',0

; DS:265B  used by C51UNIT.C, C51UNIT.H
STR_O	label	byte
		db	2Fh,6Fh,00h

; DS:265E  used by C51UNIT.C, C51UNIT.H
STR_D_TINY	label	byte
		db	'/D__TINY__ ',0

; DS:266A  used by C51UNIT.C, C51UNIT.H
STR_D_SMALL	label	byte
		db	'/D__SMALL__ ',0

; DS:2677  used by C51UNIT.C, C51UNIT.H
STR_D_MEDIUM	label	byte
		db	'/D__MEDIUM__ ',0

; DS:2685  used by C51UNIT.C, C51UNIT.H
STR_D_COMPACT	label	byte
		db	'/D__COMPACT__ ',0

; DS:2694  used by C51UNIT.C, C51UNIT.H
STR_D_LARGE	label	byte
		db	'/D__LARGE__ ',0

; DS:26A1  used by C51UNIT.C, C51UNIT.H
STR_D_HUGE	label	byte
		db	'/D__HUGE__ ',0

; DS:26AD  used by C51UNIT.C, C51UNIT.H
STR_D_PASCAL	label	byte
		db	'/D__PASCAL__ ',0

; DS:26BB  used by C51UNIT.C, C51UNIT.H
STR_D_FASTCALL	label	byte
		db	'/D__FASTCALL__ ',0

; DS:26CB  used by C51UNIT.C, C51UNIT.H
STR_D_CDECL	label	byte
		db	'/D__CDECL__ ',0

; DS:26D8  used by C51UNIT.C, C51UNIT.H
STR_E	label	byte
		db	2Fh,65h,00h

; DS:26DB  used by C51UNIT.C, C51UNIT.H
STR_R	label	byte
		db	2Fh,72h,00h

; DS:26DE  used by C51UNIT.C, C51UNIT.H
STR_ZI	label	byte
		db	'/zi',0

; DS:26E2  used by C51UNIT.C, C51UNIT.H
STR_ML	label	byte
		db	'/ml',0

; DS:26E6  used by C51UNIT.C, C51UNIT.H
STR_SPACE_SLASH	label	byte
		db	20h,2Fh,00h

; DS:26E9  used by C51UNIT.C, C51UNIT.H
STR_SPACE_COMMA	label	byte
		db	20h,2Ch,00h

; DS:26EC  used by C51UNIT.C, C51UNIT.H
STR_SPACE_SPACE_SEMI	label	byte
		db	20h,20h,3Bh,00h

; DS:26F0  used by C51UNIT.C, C51UNIT.H
STR_PLUS_CRLF	label	byte
		db	2Bh,0Dh,0Ah,00h

; DS:26F4  used by C51UNIT.C, C51UNIT.H
STR_TURBOC_LN	label	byte
		db	'turboc.$ln',0

; DS:26FF  used by C51UNIT.C, C51UNIT.H
STR_O_2	label	byte
		db	'/o-',0

; DS:2703  used by C51UNIT.C, C51UNIT.H
STR_V	label	byte
		db	'/v+',0

; DS:2707  used by C51UNIT.C, C51UNIT.H
STR_V_2	label	byte
		db	'/v-',0

; DS:270B  used by C51UNIT.C, C51UNIT.H
STR_DLL	label	byte
		db	'.dll',0

; DS:2710  used by C51UNIT.C, C51UNIT.H
STR_Y	label	byte
		db	2Fh,79h,00h

; DS:2713  used by C51UNIT.C, C51UNIT.H
STR_TWD	label	byte
		db	'/Twd',0

; DS:2718  used by C51UNIT.C, C51UNIT.H
STR_T	label	byte
		db	2Fh,54h,00h

; DS:271B  used by C51UNIT.C, C51UNIT.H
STR_O_3	label	byte
		db	'/o-+',0Dh,0Ah,0

; DS:2722  used by C51UNIT.C, C51UNIT.H
STR_OVERLAY_LIB	label	byte
		db	'OVERLAY.LIB',0

; DS:272E  used by C51UNIT.C, C51UNIT.H
STR_IMPORT_LIB	label	byte
		db	'IMPORT.LIB',0

; DS:2739  used by C51UNIT.C, C51UNIT.H
STR_EMU_LIB	label	byte
		db	'EMU.LIB',0

; DS:2741  used by C51UNIT.C, C51UNIT.H
STR_FP87_LIB	label	byte
		db	'FP87.LIB',0

; DS:274A  used by C51UNIT.C, C51UNIT.H
STR_DEF	label	byte
		db	'.def',0

; DS:274F  used by C51UNIT.C, C51UNIT.H
STR_TLINK_EXE	label	byte
		db	'tlink.exe',0

; DS:2759  used by C51UNIT.C, C51UNIT.H
STR_TURBOC_LN_2	label	byte
		db	' @turboc.$ln',0

; DS:2766  used by C119UNIT.C, C202UNIT.C
INTEGRAL_PROMOTION_KIND	label	byte
		db	00h,00h,05h,00h,05h,00h,05h,00h,06h
		db	15 dup (0)
		db	05h
		db	19 dup (0)

; DS:2792  used by C129UNIT.C
ASM_STATEMENT_FLAG	label	byte
		db	00h,00h

; DS:2794  used by C52UNIT.C, C52UNIT.H
C52_MODEL_INFO	label	byte
		db	52h,28h
		dw	seg BCC_SEG_180
		db	00h,00h,5Bh,28h
		dw	seg BCC_SEG_180
		db	00h,00h,65h,28h
		dw	seg BCC_SEG_180
		db	00h,01h,70h,28h
		dw	seg BCC_SEG_180
		db	01h,00h,7Ch,28h
		dw	seg BCC_SEG_180
		db	01h,01h,86h,28h
		dw	seg BCC_SEG_180
		db	01h,01h

; DS:27B8  used by C129UNIT.C, C240UNIT.C, C52UNIT.C, C52UNIT.H, C9INIT.C, C9INIT.H
PSEUDO_REGISTER_TABLE	label	byte
		db	8Fh,28h,00h,00h,06h,00h,00h,93h,28h,02h,00h,06h,02h,06h,97h,28h
		db	04h,00h,06h,03h,02h,9Bh,28h,06h,00h,06h,01h,04h,9Fh,28h,08h,00h
		db	06h,06h,0Ah,0A3h,28h,09h,00h,06h,07h,0Ch,0A7h,28h,0Ah,00h,06h,05h
		db	08h,0ABh,28h,0Bh,00h,06h,04h,18h,0AFh,28h,0Ch,00h,06h,10h,10h,0B3h
		db	28h,0Dh,00h,06h,13h,0Eh,0B7h,28h,0Eh,00h,06h,11h,14h,0BBh,28h,0Fh
		db	00h,06h,12h,1Ah,0BFh,28h,00h,00h,02h,08h,00h,0C3h,28h,04h,00h,02h
		db	0Bh,02h,0C7h,28h,06h,00h,02h,09h,04h,0CBh,28h,02h,00h,02h,0Ah,06h
		db	0CFh,28h,01h,00h,02h,0Ch,01h,0D3h,28h,05h,00h,02h,0Fh,03h,0D7h,28h
		db	07h,00h,02h,0Dh,05h,0DBh,28h,03h,00h,02h,0Eh,07h,0DFh,28h,0FFh,0FFh
		db	06h,00h,16h,00h,00h,00h,00h,00h,00h,00h,5Fh,5Fh,54h,49h,4Eh,59h
		db	5Fh,5Fh

; DS:285A  used by C52UNIT.C, C52UNIT.H
STR_EMPTY_3	label	byte
		db	00h
		db	'__SMALL__',0
		db	'__MEDIUM__',0
		db	'__COMPACT__',0
		db	'__LARGE__',0
		db	'__HUGE__',0
		db	'_AX',0
		db	'_DX',0
		db	'_BX',0
		db	'_CX',0
		db	'_SI',0
		db	'_DI',0
		db	'_BP',0
		db	'_SP',0
		db	'_ES',0
		db	'_DS',0
		db	'_CS',0
		db	'_SS',0
		db	'_AL',0
		db	'_BL',0
		db	'_CL',0
		db	'_DL',0
		db	'_AH',0
		db	'_BH',0
		db	'_CH',0
		db	'_DH',0
		db	'_FLAGS',0

; DS:28E6  used by C52UNIT.C, C52UNIT.H
STR__TEXT	label	byte
		db	'_TEXT',0

; DS:28EC  used by C52UNIT.C, C52UNIT.H
STR_CODE	label	byte
		db	'CODE',0

; DS:28F1  used by C52UNIT.C, C52UNIT.H
STR__	label	byte
		db	5Fh

; DS:28F2  used by C52UNIT.C, C52UNIT.H
STR_DATA	label	byte
		db	'data',0

; DS:28F7  used by C52UNIT.C, C52UNIT.H
STR_DGROUP	label	byte
		db	'dgroup',0

; DS:28FE  used by C52UNIT.C, C52UNIT.H
STR_X5F_2	label	byte
		db	5Fh

; DS:28FF  used by C52UNIT.C, C52UNIT.H
STR_BSS	label	byte
		db	'bss',0

; DS:2903  used by C52UNIT.C, C52UNIT.H
STR_FAR_DATA	label	byte
		db	'FAR_DATA',0

; DS:290C  used by C52UNIT.C, C52UNIT.H
STR_TEXT_2	label	byte
		db	'_text',0

; DS:2912  used by C52UNIT.C, C52UNIT.H
STR_1	label	byte
		db	31h

; DS:2913  used by C52UNIT.C, C52UNIT.H
STR_XFB	label	byte
		db	0FBh,00h

; DS:2915  used by C52UNIT.C, C52UNIT.H
STR___MULTI_THREAD__	label	byte
		db	'__MULTI_THREAD__',0

; DS:2926  used by C52UNIT.C, C52UNIT.H
STR___SINGLE_THREAD__	label	byte
		db	'__SINGLE_THREAD__',0

; DS:2938  used by C52UNIT.C, C52UNIT.H
STR___DLL__	label	byte
		db	'__DLL__',0

; DS:2940  used by C52UNIT.C, C52UNIT.H
STR___OS2__	label	byte
		db	'__OS2__',0

; DS:2948  used by C52UNIT.C, C52UNIT.H
STR___MSDOS__	label	byte
		db	'__MSDOS__',0

; DS:2952  used by C52UNIT.C, C52UNIT.H
STR__WINDOWS	label	byte
		db	'_Windows',0

; DS:295B  used by C52UNIT.C, C52UNIT.H
STR___TURBOC__	label	byte
		db	'__TURBOC__',0

; DS:2966  used by C52UNIT.C, C52UNIT.H
STR_0X0297	label	byte
		db	30h,78h,30h,32h,39h,37h,0FBh,00h

; DS:296E  used by C52UNIT.C, C52UNIT.H
STR___BORLANDC__	label	byte
		db	'__BORLANDC__',0

; DS:297B  used by C52UNIT.C, C52UNIT.H
STR_0X0200	label	byte
		db	30h,78h,30h,32h,30h,30h,0FBh,00h

; DS:2983  used by C52UNIT.C, C52UNIT.H
STR___TCPLUSPLUS__	label	byte
		db	'__TCPLUSPLUS__',0

; DS:2992  used by C52UNIT.C, C52UNIT.H
STR___BCPLUSPLUS__	label	byte
		db	'__BCPLUSPLUS__',0

; DS:29A1  used by C52UNIT.C, C52UNIT.H
STR___OVERLAY__	label	byte
		db	'__OVERLAY__',0

; DS:29AD  used by C52UNIT.C, C52UNIT.H
STR___PASCAL__	label	byte
		db	'__PASCAL__',0

; DS:29B8  used by C52UNIT.C, C52UNIT.H
STR___FASTCALL__	label	byte
		db	'__FASTCALL__',0

; DS:29C5  used by C52UNIT.C, C52UNIT.H
STR___CDECL__	label	byte
		db	'__CDECL__',0

; DS:29CF  used by C52UNIT.C, C52UNIT.H
STR__FAR	label	byte
		db	'_FAR',0

; DS:29D4  used by C52UNIT.C, C52UNIT.H
NAME_A1	label	byte
		db	'_INIT_',0

; DS:29DB  used by C52UNIT.C, C52UNIT.H
NAME_A2	label	byte
		db	'INITDATA',0

; DS:29E4  used by C52UNIT.C, C52UNIT.H
NAME_B1	label	byte
		db	'_EXIT_',0

; DS:29EB  used by C52UNIT.C, C52UNIT.H
NAME_B2	label	byte
		db	'EXITDATA',0

; DS:29F4  used by C113UNIT.C, C240UNIT.C, C31UNIT.C, C31UNIT.H, RMAIN13C.C
MIN_FREE_HEAP	label	byte
		db	0FFh,0FFh,0Fh,00h

; DS:29F8  used by C53UNIT.C, C53UNIT.H
C53_DEFAULT_FILE	label	byte
		db	'TCDEF.SYM',0

; DS:2A02  used by C53UNIT.C, C53UNIT.H
C53_COMMAND_LINE	label	byte
		db	'command line',0

; DS:2A0F  used by C53UNIT.C, C53UNIT.H
C53_CONFIG_FILE	label	byte
		db	'configuration file',0

; DS:2A22  used by C53UNIT.C, C53UNIT.H
OPT_TEXT_YO	label	byte
		db	59h,6Fh,00h

; DS:2A25  used by C53UNIT.C, C53UNIT.H
C53_YO_OFF	label	byte
		db	'Yo-',0

; DS:2A29  used by C53UNIT.C, C53UNIT.H
OPT_TEXT_V	label	byte
		db	76h,00h

; DS:2A2B  used by C53UNIT.C, C53UNIT.H
C53_V_OFF	label	byte
		db	76h,2Dh,00h

; DS:2A2E  used by C53UNIT.C, C53UNIT.H
OPT_TEXT_VI	label	byte
		db	76h,69h,00h

; DS:2A31  used by C53UNIT.C, C53UNIT.H
C53_VI_OFF	label	byte
		db	'vi-',0
		db	00h

; DS:2A36  used by C56UNIT.C, C56UNIT.H
DEBUG_PREFIX	label	byte
		db	09h,'?debug',09h,'C ',0

; DS:2A41  used by C56UNIT.C, C56UNIT.H
DEBUG_MORE	label	byte
		db	'+',0Dh,0Ah,09h,'?debug',09h,'C ',0

; DS:2A4F  used by C56UNIT.C, C56UNIT.H
DEBUG_SUFFIX	label	byte
		db	0Dh,0Ah,00h

; DS:2A52  used by C56UNIT.C, C56UNIT.H
C56_EXTERN	label	byte
		db	09h,'extrn',09h,0

; DS:2A5A  used by C56UNIT.C, C56UNIT.H
C56_NEAR	label	byte
		db	'near',0

; DS:2A5F  used by C56UNIT.C, C56UNIT.H
C56_PUBLIC_DLL	label	byte
		db	09h,'publicdll',09h,0

; DS:2A6B  used by C56UNIT.C, C56UNIT.H
C56_PUBLIC	label	byte
		db	09h,'public',09h,0

; DS:2A74  used by C56UNIT.C, C56UNIT.H
C56_STACK_EQU	label	byte
		db	09h,65h,71h,75h,09h,73h,40h

; DS:2A7B  used by C56UNIT.C, C56UNIT.H
C56_PLUS	label	byte
		db	2Bh,00h

; DS:2A7D  used by C56UNIT.C, C56UNIT.H
C56_EQU	label	byte
		db	09h,'equ',09h,0

; DS:2A83  used by C56UNIT.C, C56UNIT.H
DEBUG_NODE_PREFIX	label	byte
		db	09h,'?debug',09h,'F ',0

; DS:2A8E  used by C56UNIT.H
C56_VERSION_EXTENDED	label	byte
		db	30h,35h,00h

; DS:2A91  used by C56UNIT.C, C56UNIT.H
C56_VERSION_BASE	label	byte
		db	30h,31h,00h

; DS:2A94  used by C56UNIT.C, C56UNIT.H
C56_DATA_MARK	label	byte
		db	64h,40h,00h

; DS:2A97  used by C56UNIT.C, C56UNIT.H
STR_BSS_BASE_LABEL	label	byte
		db	62h,40h,00h

; DS:2A9A  used by C56UNIT.C, C56UNIT.H
C56_WORD_MARK	label	byte
		db	77h,2Bh,00h,00h

; DS:2A9E  used by C13UNIT.C, C13UNIT.H, C231UNIT.C, C236UNIT.C, C31UNIT.C, C31UNIT.H
OBJ_EXTERN_INDEX	label	byte
		db	00h,00h

; DS:2AA0  used by C231UNIT.C
STR_TURBOFLOAT	label	byte
		db	'__turboFloat',0
		db	00h

; DS:2AAE  used by C129UNIT.C
ASM_KEYWORD_TABLE	label	byte
		db	86h,2Eh,7Ah,00h,88h,2Eh,74h,00h,8Ch,2Eh,74h,00h,90h,2Eh,74h,00h
		db	94h,2Eh,74h,00h,98h,2Eh,74h,00h,9Ch,2Eh,74h,00h,0A0h,2Eh,7Ah,00h
		db	0A3h,2Eh,7Ah,00h,0A6h,2Eh,74h,00h,0AAh,2Eh,74h,00h,0AFh,2Eh,7Ah,00h
		db	0B2h,2Eh,7Ah,00h,0B5h,2Eh,7Ah,00h,0B8h,2Eh,74h,00h,0BEh,2Eh,7Ah,00h
		db	0C1h,2Eh,7Ah,00h,0C4h,2Eh,75h,00h,0C9h,2Eh,74h,00h,0CDh,2Eh,7Ah,00h
		db	0D0h,2Eh,7Ah,00h,0D3h,2Eh,74h,00h,0D7h,2Eh,74h,00h,0DBh,2Eh,74h,00h
		db	0DFh,2Eh,74h,00h,0E3h,2Eh,74h,00h,0E7h,2Eh,77h,00h,0ECh,2Eh,77h,00h
		db	0F2h,2Eh,77h,00h,0F8h,2Eh,7Ah,00h,0FBh,2Eh,74h,00h,0FFh,2Eh,7Ah,00h
		db	02h,2Fh,74h,00h,06h,2Fh,74h,00h
		db	0Ah,'/t',0
		db	9Dh,2Eh,74h,00h
		db	0Dh,'/t',0
		db	11h,2Fh,7Ah,00h,14h,2Fh,7Ah,00h,17h,2Fh,74h,00h,1Bh,2Fh,7Ah,00h
		db	1Eh,2Fh,7Ah,00h
		db	'!/t',0
		db	'$/y',0
		db	'*/z',0
		db	'-/t',0
		db	'3/z',0
		db	'6/t',0
		db	'</t',0
		db	'B/t',0
		db	'G/t',0
		db	'L/t',0
		db	'R/~',0
		db	'V/t',0
		db	'[/t',0
		db	'a/t',0
		db	'f/t',0
		db	'l/t',0
		db	'q/t',0
		db	'w/t',0
		db	'~/t',0
		db	86h,2Fh,74h,00h,8Ch,2Fh,74h,00h,91h,2Fh,74h,00h,97h,2Fh,74h,00h
		db	9Dh,2Fh,74h,00h,0A4h,2Fh,74h,00h,0A9h,2Fh,74h,00h,0AFh,2Fh,74h,00h
		db	0B5h,2Fh,74h,00h,0BBh,2Fh,74h,00h,0C2h,2Fh,74h,00h,0C8h,2Fh,74h,00h
		db	0CFh,2Fh,74h,00h,0D4h,2Fh,74h,00h,0DAh,2Fh,74h,00h,0E2h,2Fh,74h,00h
		db	0E8h,2Fh,74h,00h,0EDh,2Fh,74h,00h,0F3h,2Fh,74h,00h,0F9h,2Fh,74h,00h
		db	00h,30h,74h,00h,04h,30h,74h,00h
		db	09h,'0t',0
		db	0Fh,30h,74h,00h,16h,30h,74h,00h,1Dh,30h,74h,00h
		db	'$0t',0
		db	'+0t',0
		db	'20t',0
		db	'80t',0
		db	'=0t',0
		db	'B0t',0
		db	'H0t',0
		db	'O0t',0
		db	'V0t',0
		db	'\0t',0
		db	'c0t',0
		db	'h0t',0
		db	'o0t',0
		db	'v0t',0
		db	'~0t',0
		db	85h,30h,74h,00h,8Ch,30h,74h,00h,92h,30h,74h,00h,98h,30h,74h,00h
		db	0A0h,30h,74h,00h,0A7h,30h,74h,00h,0ADh,30h,74h,00h,0B4h,30h,74h,00h
		db	0BAh,30h,74h,00h,0BEh,30h,74h,00h,0C4h,30h,74h,00h,0CBh,30h,74h,00h
		db	0D0h,30h,74h,00h,0D6h,30h,74h,00h,0DBh,30h,74h,00h,0E1h,30h,74h,00h
		db	0E7h,30h,74h,00h,0EEh,30h,74h,00h,0F3h,30h,74h,00h,0F9h,30h,74h,00h
		db	0FEh,30h,74h,00h,03h,31h,74h,00h,0Bh,31h,74h,00h,11h,31h,74h,00h
		db	19h,31h,74h,00h,0C3h,2Fh,74h,00h,0D5h,2Fh,74h,00h,1Dh,31h,74h,00h
		db	' 1t',0
		db	'$1w',0
		db	'(1w',0
		db	'-1w',0
		db	9Ch,30h,74h,00h
		db	'21t',0
		db	'71t',0
		db	3Ch,31h,78h,05h,3Fh,31h,78h,09h,43h,31h,78h,04h,46h,31h,78h,08h
		db	4Ah,31h,78h,0Ch,4Dh,31h,78h,16h,52h,31h,78h,0Ah,55h,31h,78h,03h
		db	58h,31h,78h,07h,5Ch,31h,78h,02h,5Fh,31h,78h,06h,63h,31h,78h,01h
		db	67h,31h,78h,08h,6Bh,31h,78h,04h,70h,31h,78h,09h,74h,31h,78h,05h
		db	79h,31h,78h,0Dh,7Dh,31h,78h,0Bh,81h,31h,78h,06h,85h,31h,78h,02h
		db	8Ah,31h,78h,07h,8Eh,31h,78h,03h,93h,31h,78h,0Fh,97h,31h,78h,13h
		db	9Bh,31h,78h,11h,9Fh,31h,78h,0Bh,0A3h,31h,78h,0Eh,0A6h,31h,78h,12h
		db	0A9h,31h,78h,12h,0ADh,31h,78h,13h,0B1h,31h,78h,10h,0B4h,31h,78h,0Ah
		db	0B7h,31h,74h,00h,0BCh,31h,74h,00h,0C0h,31h,74h,00h,0C4h,31h,74h,00h
		db	0C8h,31h,74h,00h,0CEh,31h,74h,00h,0D2h,31h,7Dh,00h,0D7h,31h,77h,00h
		db	0DCh,31h,77h,00h,0E2h,31h,77h,00h,0E8h,31h,78h,17h,0EDh,31h,78h,14h
		db	0F3h,31h,78h,15h,0FAh,31h,78h,15h,01h,32h,78h,14h,07h,32h,74h,00h
		db	0Bh,32h,74h,00h,0Fh,32h,77h,00h,14h,32h,77h,00h,1Ah,32h,77h,00h
		db	0D6h,2Fh,74h,00h,20h,32h,7Fh,00h
		db	'%2t',0
		db	'd0t',0
		db	')2t',0
		db	0A4h,30h,74h,00h
		db	'-2t',0
		db	'12w',0
		db	'62w',0
		db	'<2w',0
		db	'B2t',0
		db	'F2t',0
		db	'K2t',0
		db	50h,32h,81h,00h
		db	'T2t',0
		db	'Y2t',0
		db	'_2t',0
		db	'e2t',0
		db	'i2t',0
		db	'm2v',0
		db	'q2v',0
		db	'v2v',0
		db	'|2v',0
		db	82h,32h,76h,00h
		db	'81t',0
		db	87h,32h,74h,00h,8Bh,32h,74h,00h,8Fh,32h,74h,00h,94h,32h,74h,00h
		db	98h,32h,74h,00h,9Ch,32h,74h,00h,0A0h,32h,77h,00h,0A5h,32h,77h,00h
		db	0ABh,32h,77h,00h,0B1h,32h,74h,00h,0B5h,32h,80h,00h,0BBh,32h,74h,00h
		db	89h,2Fh,7Ah,00h,0BFh,32h,74h,00h,0C4h,32h,7Ah,00h,0C7h,32h,7Ah,00h
		db	0CAh,32h,74h,00h,0CEh,32h,74h,00h,0D2h,32h,74h,00h,0D6h,32h,77h,00h
		db	0DBh,32h,77h,00h,0E1h,32h,77h,00h,0F5h,2Fh,74h,00h,0E7h,32h,74h,00h
		db	0ECh,32h,74h,00h,0F1h,32h,74h,00h,0F4h,30h,74h,00h
		db	'%/y',0
		db	0F6h,32h,74h,00h,0FBh,32h,74h,00h,00h,33h,74h,00h

; DS:2E82  used by C129UNIT.C
ASM_KEYWORD_COMPARE_FUNC	label	byte
		db	20h,00h
		dw	seg X03C_00
		db	24h,00h
		db	'aaa',0
		db	'aad',0
		db	'aam',0
		db	'aas',0
		db	'adc',0
		db	'add',0
		db	61h,68h,00h,61h,6Ch,00h
		db	'and',0
		db	'arpl',0
		db	61h,78h,00h,62h,68h,00h,62h,6Ch,00h
		db	'bound',0
		db	62h,70h,00h,62h,78h,00h
		db	'call',0
		db	'cbw',0
		db	63h,68h,00h,63h,6Ch,00h
		db	'clc',0
		db	'cld',0
		db	'cli',0
		db	'cmc',0
		db	'cmp',0
		db	'cmps',0
		db	'cmpsb',0
		db	'cmpsw',0
		db	63h,73h,00h
		db	'cwd',0
		db	63h,78h,00h
		db	'daa',0
		db	'das',0
		db	64h,62h,00h
		db	'dec',0
		db	64h,68h,00h,64h,69h,00h
		db	'div',0
		db	64h,6Ch,00h,64h,73h,00h,64h,77h,00h
		db	'dword',0
		db	64h,78h,00h
		db	'enter',0
		db	65h,73h,00h
		db	'extrn',0
		db	'f2xm1',0
		db	'fabs',0
		db	'fadd',0
		db	'faddp',0
		db	'far',0
		db	'fbld',0
		db	'fbstp',0
		db	'fchs',0
		db	'fclex',0
		db	'fcom',0
		db	'fcomp',0
		db	'fcompp',0
		db	'fdecstp',0
		db	'fdisi',0
		db	'fdiv',0
		db	'fdivp',0
		db	'fdivr',0
		db	'fdivrp',0
		db	'feni',0
		db	'ffree',0
		db	'fiadd',0
		db	'ficom',0
		db	'ficomp',0
		db	'fidiv',0
		db	'fidivr',0
		db	'fild',0
		db	'fimul',0
		db	'fincstp',0
		db	'finit',0
		db	'fist',0
		db	'fistp',0
		db	'fisub',0
		db	'fisubr',0
		db	'fld',0
		db	'fld1',0
		db	'fldcw',0
		db	'fldenv',0
		db	'fldl2e',0
		db	'fldl2t',0
		db	'fldlg2',0
		db	'fldln2',0
		db	'fldpi',0
		db	'fldz',0
		db	'fmul',0
		db	'fmulp',0
		db	'fnclex',0
		db	'fndisi',0
		db	'fneni',0
		db	'fninit',0
		db	'fnop',0
		db	'fnsave',0
		db	'fnstcw',0
		db	'fnstenv',0
		db	'fnstsw',0
		db	'fpatan',0
		db	'fprem',0
		db	'fptan',0
		db	'frndint',0
		db	'frstor',0
		db	'fsave',0
		db	'fscale',0
		db	'fsqrt',0
		db	'fst',0
		db	'fstcw',0
		db	'fstenv',0
		db	'fstp',0
		db	'fstsw',0
		db	'fsub',0
		db	'fsubp',0
		db	'fsubr',0
		db	'fsubrp',0
		db	'ftst',0
		db	'fwait',0
		db	'fxam',0
		db	'fxch',0
		db	'fxtract',0
		db	'fyl2x',0
		db	'fyl2xp1',0
		db	'hlt',0
		db	69h,6Eh,00h
		db	'inc',0
		db	'ins',0
		db	'insb',0
		db	'insw',0
		db	'into',0
		db	'iret',0
		db	6Ah,61h,00h
		db	'jae',0
		db	6Ah,62h,00h
		db	'jbe',0
		db	6Ah,63h,00h
		db	'jcxz',0
		db	6Ah,65h,00h,6Ah,67h,00h
		db	'jge',0
		db	6Ah,6Ch,00h
		db	'jle',0
		db	'jmp',0
		db	'jna',0
		db	'jnae',0
		db	'jnb',0
		db	'jnbe',0
		db	'jnc',0
		db	'jne',0
		db	'jng',0
		db	'jnge',0
		db	'jnl',0
		db	'jnle',0
		db	'jno',0
		db	'jnp',0
		db	'jns',0
		db	'jnz',0
		db	6Ah,6Fh,00h,6Ah,70h,00h
		db	'jpe',0
		db	'jpo',0
		db	6Ah,73h,00h,6Ah,7Ah,00h
		db	'lahf',0
		db	'lar',0
		db	'lds',0
		db	'lea',0
		db	'leave',0
		db	'les',0
		db	'lock',0
		db	'lods',0
		db	'lodsb',0
		db	'lodsw',0
		db	'loop',0
		db	'loope',0
		db	'loopne',0
		db	'loopnz',0
		db	'loopz',0
		db	'lsl',0
		db	'mov',0
		db	'movs',0
		db	'movsb',0
		db	'movsw',0
		db	'near',0
		db	'neg',0
		db	'not',0
		db	'out',0
		db	'outs',0
		db	'outsb',0
		db	'outsw',0
		db	'pop',0
		db	'popa',0
		db	'popf',0
		db	'ptr',0
		db	'push',0
		db	'pusha',0
		db	'pushf',0
		db	'rcl',0
		db	'rcr',0
		db	'rep',0
		db	'repe',0
		db	'repne',0
		db	'repnz',0
		db	'repz',0
		db	'rol',0
		db	'ror',0
		db	'sahf',0
		db	'sal',0
		db	'sar',0
		db	'sbb',0
		db	'scas',0
		db	'scasb',0
		db	'scasw',0
		db	'shl',0
		db	'short',0
		db	'shr',0
		db	'smsw',0
		db	73h,70h,00h,73h,73h,00h
		db	'stc',0
		db	'std',0
		db	'sti',0
		db	'stos',0
		db	'stosb',0
		db	'stosw',0
		db	'test',0
		db	'verr',0
		db	'verw',0
		db	'xchg',0
		db	'xlat',0
		db	'xor',0

; DS:3304  used by C129UNIT.C
STR_CRLF_2	label	byte
		db	0Dh,0Ah,00h,00h

; DS:3308  used by C103UNIT.C
STR_OPERATOR_NEW	label	byte
		db	'operator new',0

; DS:3315  used by C103UNIT.C
STR_OPERATOR_DELETE	label	byte
		db	'operator delete',0
		db	00h

; DS:3326  used by C201UNIT.C
STR_FRIEND_4	label	byte
		db	'friend',0

; DS:332D  used by C201UNIT.C
STR_VIRTUAL_4	label	byte
		db	'virtual',0

; DS:3335  used by C201UNIT.C
STR_OPERATOR_5	label	byte
		db	'Operator',09h,'[]',0

; DS:3341  used by C201UNIT.C
STR_DYNAMIC_DISPATCH_CONSTAN	label	byte
		db	'Dynamic dispatch constant',0

; DS:335B  used by C201UNIT.C
STR_STATIC_MEMBER	label	byte
		db	'static member',0

; DS:3369  used by C201UNIT.C
STR_NON_INLINE_FUNCTION	label	byte
		db	'non-inline function',0

; DS:337D  used by C201UNIT.C
STR_STATIC_2	label	byte
		db	'static',0

; DS:3384  used by C127UNIT.C
BCC_DEBUG_EMPTY	label	byte
		db	00h,00h

; DS:3386  used by C128UNIT.C
POOL_BANK_TABLE	label	byte
		db	32h,78h,3Ah,78h,10h,64h,8Ah,62h,0C2h,63h,90h,86h,0A8h,86h,9Ah,63h
		db	3Eh,5Fh,0A4h,78h,0E2h,63h,2Ah,78h,9Ch,78h,08h,64h,0EAh,63h,0B2h,63h
		db	28h,64h,96h,81h,30h,64h,0D2h,5Eh,0A6h,62h,0A6h,63h,90h,64h,0B4h,62h
		db	46h,5Fh,0B0h,86h,8Eh,81h,46h,82h,4Eh,78h,56h,78h,5Eh,78h,66h,78h
		db	6Eh,78h,76h,78h,7Eh,78h,86h,78h,0E4h,85h

; DS:33D0  used by C128UNIT.C
PCH_OPTION_FLAG_PTRS	label	byte
		db	0EFh,16h,13h,17h,16h,17h,0FBh,16h,76h,17h,0F2h,16h,05h,17h,64h,17h
		db	0F6h,16h,63h,17h,0A0h,62h

; DS:33E6  used by C128UNIT.C
PREAMBLE_DIRECTIVE_TABLE	label	byte
		db	60h,34h,4Fh,0Eh,67h,34h,17h,10h,6Fh,34h,05h,12h,76h,34h,64h,12h
		db	79h,34h,77h,12h,7Fh,34h,8Ah,12h,86h,34h,6Dh,11h,8Bh,34h,6Dh,11h
		db	90h,34h,9Dh,12h

; DS:340A  used by C128UNIT.C
STR_LOADED_PRE_COMPILED	label	byte
		db	4Ch,6Fh,61h,64h,65h,64h,20h,70h,72h,65h,2Dh,63h,6Fh,6Dh,70h,69h
		db	6Ch,65h,64h,20h,68h,65h,61h,64h,65h,72h,73h,2Eh

; DS:3426  used by C128UNIT.C
STR_NEWLINE	label	byte
		db	0Ah

; DS:3427  used by C128UNIT.C
STR_EMPTY	label	byte
		db	00h

; DS:3428  used by C128UNIT.C
STR_HASH	label	byte
		db	23h,00h

; DS:342A  used by C128UNIT.C
STR_SPACE	label	byte
		db	20h,00h

; DS:342C  used by C128UNIT.C
STR_HDRFILE	label	byte
		db	'hdrfile',0

; DS:3434  used by C128UNIT.C
STR_HDRSTOP	label	byte
		db	'hdrstop',0

; DS:343C  used by C128UNIT.C
STR_PRAGMA_2	label	byte
		db	'pragma ',0

; DS:3444  used by C128UNIT.C
STR_EXTERN	label	byte
		db	'extern',0

; DS:344B  used by C128UNIT.C
STR_EXTERN_2	label	byte
		db	'extern ',0

; DS:3453  used by C128UNIT.C
STR_EXTERN_3	label	byte
		db	65h,78h,74h,65h,72h,6Eh,20h

; DS:345A  used by C128UNIT.C
STR_QUOTE	label	byte
		db	22h,00h

; DS:345C  used by C128UNIT.C
STR_QUOTE_CRLF	label	byte
		db	22h

; DS:345D  used by C128UNIT.C
STR_CRLF	label	byte
		db	0Dh,0Ah,00h
		db	'pragma',0
		db	'include',0
		db	'define',0
		db	69h,66h,00h
		db	'ifdef',0
		db	'ifndef',0
		db	'else',0
		db	'elif',0
		db	'endif',0

; DS:3496  used by C128UNIT.C
STR_INCLUDE	label	byte
		db	'#include <',0

; DS:34A1  used by C128UNIT.C
STR_GREATER	label	byte
		db	3Eh,00h

; DS:34A3  used by C128UNIT.C
STR_INCLUDE_2	label	byte
		db	'#include "',0

; DS:34AE  used by C128UNIT.C
STR_DEFINE_2	label	byte
		db	23h

; DS:34AF  used by C128UNIT.C
STR_DEFINE_3	label	byte
		db	'define ',0

; DS:34B7  used by C128UNIT.C
STR_IF_3	label	byte
		db	'#if ',0

; DS:34BC  used by C128UNIT.C
STR_IFDEF	label	byte
		db	'#ifdef ',0

; DS:34C4  used by C128UNIT.C
STR_IFNDEF	label	byte
		db	'#ifndef ',0

; DS:34CD  used by C128UNIT.C
STR_ENDIF	label	byte
		db	'#endif ',0

; DS:34D5  used by C128UNIT.C
STR_QUOTE_OPEN_BRACE	label	byte
		db	22h,20h,7Bh,00h

; DS:34D9  used by C128UNIT.C
STR_CLOSE_BRACE	label	byte
		db	7Dh,00h

; DS:34DB  used by C128UNIT.C
STR_C	label	byte
		db	'C++',0

; DS:34DF  used by C128UNIT.C
STR_C_2	label	byte
		db	43h,00h,00h

; DS:34E2  used by C119UNIT.C
BINARY_PRIORITY_BY_TOKEN	label	byte
		db	8 dup (0)
		db	01h,00h,00h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,0Dh,0Dh
		db	0Eh,0Eh,0Eh,09h,07h,08h,0Ch,0Ch

; DS:3502  used by C119UNIT.C
TERNARY_ELSE_LEVEL	label	byte
		db	03h,00h,05h,06h,0Ah,0Ah,0Bh,0Bh,0Bh,0Bh

; DS:350C  used by C119UNIT.C
OPERATOR_BY_TOKEN	label	byte
		db	8 dup (0)
		db	2Ah,00h,00h,12h,13h,14h,15h,16h,17h,1Ah,1Bh,1Ch,18h,19h,08h,09h
		db	0Ah,0Bh,0Ch,0Fh,10h,11h,0Dh,0Eh,25h,26h,28h,27h,1Dh,1Eh,20h,1Fh
		db	22h

; DS:3535  used by C119UNIT.C
TYPECHECK_OP_FLAGS	label	byte
		db	21h

; DS:3536  used by C119UNIT.C
LEVEL_ASSOCIATIVITY	label	byte
		db	00h,01h,02h,02h,02h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,90h
		db	21h,90h,20h,10h,20h,10h,20h,00h,20h,06h,20h,06h,20h,00h,00h,00h
		db	00h,00h,00h,0D1h,81h,91h,80h,91h,80h,11h,80h,11h,80h,01h,80h,03h
		db	80h,03h,80h,01h,80h,01h,80h,01h,80h,98h,01h,98h,01h,98h,01h,98h
		db	01h,98h,01h,98h,01h,90h,80h,90h,80h,0F0h,01h,0F0h,01h,90h,01h,90h
		db	01h
		db	10 dup (0)
		db	10h,20h,00h

; DS:3594  used by C119UNIT.C
OPERAND_KIND_MASK	label	byte
		db	20h,90h,01h,80h

; DS:3598  used by C119UNIT.C
OPERAND_KIND_MESSAGE	label	byte
		db	01h,0D0h,01h,00h,00h,10h,10h,10h,20h,80h,00h,80h,80h,80h,80h,40h
		db	40h,00h,2Fh,00h,2Fh,00h,2Fh,00h,14h,00h,13h,00h,13h,00h,13h,00h
		db	13h

; DS:35B9  used by C123UNIT.C
POST_TO_ASSIGN_OP	label	byte
		db	00h,13h,00h,13h,00h,54h,00h,54h,00h

; DS:35C2  used by C119UNIT.C
STR_SUBSCRIPTING_2	label	byte
		db	'Subscripting',0
		db	'Array bounds',0
		db	13h,14h

; DS:35DE  used by C124UNIT.C
STR_STKLEN	label	byte
		db	'_stklen',0

; DS:35E6  used by C122UNIT.C
EXPR_OP_HAS_EFFECT	label	byte
		db	01h
		db	17 dup (0)
		db	01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,00h,00h,00h,00h,00h
		db	00h,01h,01h,01h,00h,01h,01h,01h,01h
		db	9 dup (0)
		db	01h,00h,01h

; DS:361D  used by C122UNIT.C
STR_IF_4	label	byte
		db	49h,66h,00h

; DS:3620  used by C122UNIT.C
STR_FOR_2	label	byte
		db	'For',0

; DS:3624  used by C122UNIT.C
STR_DO_WHILE_2	label	byte
		db	'Do-while',0

; DS:362D  used by C122UNIT.C
STR_WHILE_2	label	byte
		db	'While',0

; DS:3633  used by C122UNIT.C
STR_SWITCH_2	label	byte
		db	'Switch',0

; DS:363A  used by C122UNIT.C
STR_BREAK	label	byte
		db	'Break',0

; DS:3640  used by C122UNIT.C
STR_CONTINUE	label	byte
		db	'Continue',0

; DS:3649  used by C122UNIT.C
STR_RETURN	label	byte
		db	'Return',0

; DS:3650  used by C122UNIT.C
STR_GOTO_2	label	byte
		db	'Goto',0
		db	00h

; DS:3656  used by C240UNIT.C
C_FRONTEND_HOOK_TABLE	label	byte
		db	25h,00h
		dw	seg X06D_00
		db	52h,00h
		dw	seg X04C_02
		db	4Dh,00h
		dw	seg X04C_02
		db	2Ah,00h
		dw	seg X04C_02
		db	57h,00h
		dw	seg X04C_02
		db	2Ah,00h
		dw	seg X06D_00
		db	8Eh,00h
		dw	seg X04A_00
		db	48h,00h
		dw	seg X04C_02
		db	20h,00h
		dw	seg X06E_00
		db	57h,00h
		dw	seg X04F_03
		db	4Dh,00h
		dw	seg X04F_03
		db	25h,00h
		dw	seg X050_00
		db	25h,00h
		dw	seg X045_00
		db	48h,00h
		dw	seg X04F_03
		db	25h,00h
		dw	seg X048_00
		db	5Ch,00h
		dw	seg X04C_02
		db	20h,00h
		dw	seg X048_00
		db	6Bh,00h
		dw	seg X04F_03
		db	61h,00h
		dw	seg X04F_03
		db	34h,00h
		dw	seg X047_00
		db	43h,00h
		dw	seg X04F_03
		db	2Ah,00h
		dw	seg X045_00
		db	52h,00h
		dw	seg X04F_03
		db	7Ah,00h
		dw	seg X04F_03
		db	39h,00h
		dw	seg X050_00
		db	34h,00h
		dw	seg X050_00
		db	2Fh,00h
		dw	seg X050_00
		db	5Ch,00h
		dw	seg X04A_00
		db	20h,00h
		dw	seg X06D_00
		db	20h,00h
		dw	seg X050_00
		db	25h,00h
		dw	seg X06E_00
		db	2Ah,00h
		dw	seg X06E_00
		db	2Fh,00h
		dw	seg X04C_02
		db	66h,00h
		dw	seg X04C_02
		db	75h,00h
		dw	seg X04A_00
		db	20h,00h
		dw	seg X04A_00
		db	39h,00h
		dw	seg X04A_00
		db	43h,00h
		dw	seg X04A_00
		db	61h,00h
		dw	seg X04A_00
		db	48h,00h
		dw	seg X04A_00
		db	6Bh,00h
		dw	seg X04A_00
		db	4Dh,00h
		dw	seg X04A_00
		db	57h,00h
		dw	seg X04A_00
		db	43h,00h
		dw	seg X047_00
		db	34h,00h
		dw	seg X04F_03
		db	70h,00h
		dw	seg X04A_00
		db	5Ch,00h
		dw	seg X04F_03
		db	52h,00h
		dw	seg X04A_00
		db	2Fh,00h
		dw	seg X04A_00

; DS:371A  used by C240UNIT.C
INITIAL_TYPE_POOL_IMAGE	label	byte
		db	10 dup (0)
		db	01h,02h
		db	8 dup (0)
		db	02h,08h
		db	8 dup (0)
		db	03h,04h
		db	8 dup (0)
		db	04h,0Ah
		db	8 dup (0)
		db	05h,04h
		db	8 dup (0)
		db	06h,0Ah
		db	8 dup (0)
		db	07h,06h
		db	8 dup (0)
		db	08h,0Ch
		db	8 dup (0)
		db	09h,0Eh
		db	8 dup (0)
		db	0Ah,0Fh
		db	8 dup (0)
		db	0Bh,10h
		db	8 dup (0)
		db	0Ch,01h
		db	8 dup (0)

; DS:379C  used by C240UNIT.C
STR_S	label	byte
		db	73h,40h,00h

; DS:379F  used by C240UNIT.C
STR_MAIN	label	byte
		db	'main',0

; DS:37A4  used by C202UNIT.C
STR_STATIC	label	byte
		db	'static',0

; DS:37AB  used by C202UNIT.C
STR_SETARGV	label	byte
		db	'_setargv__',0

; DS:37B6  used by C202UNIT.C
STR_SETARGV_2	label	byte
		db	'__setargv__',0

; DS:37C2  used by C202UNIT.C
STR_SETENVP	label	byte
		db	'_setenvp__',0

; DS:37CD  used by C202UNIT.C
STR_SETENVP_2	label	byte
		db	'__setenvp__',0
		db	00h

; DS:37DA  used by C119UNIT.C, C125UNIT.C, C202UNIT.C
STORAGE_CLASS_NAMES	label	byte
		db	00h,00h,00h,00h,0F6h,37h,0FDh,37h,0FDh,37h,04h,38h,00h,00h,00h,00h
		db	09h,38h
		db	8 dup (0)
		db	11h
		db	'8extern',0
		db	'static',0
		db	'auto',0
		db	'typedef',0
		db	'register',0

; DS:381A  used by C218UNIT.C
STR_DEBUG_C	label	byte
		db	09h,'?debug',09h,'C ',0
		db	'+',0Dh,0Ah,09h,'?debug',09h,'C ',0

; DS:3833  used by C218UNIT.C
STR_CR_NL	label	byte
		db	0Dh,0Ah,00h
		db	09h,'extrn',09h,0
		db	'near',0
		db	09h,'publicdll',09h,0
		db	09h,'public',09h,0
		db	09h,'equ',09h,'s@+',0
		db	09h,'equ',09h,0

; DS:3867  used by C218UNIT.C
STR_01	label	byte
		db	30h,31h,00h

; DS:386A  used by C218UNIT.C
STR_DEBUG_F	label	byte
		db	09h,'?debug',09h,'F ',0
		db	64h,40h,00h,62h,40h,00h,00h
		db	'__turboFloat',0
		db	00h

; DS:388A  used by C85UNIT.C
EXPR_RETYPE_SHAPE	label	byte
		db	00h,01h,03h,00h,01h,01h,01h,01h,30h,30h,00h,00h,00h,10h,00h,30h
		db	30h,30h
		db	19 dup (0)
		db	20h,30h,00h,00h,10h,20h,00h,00h,00h,30h,30h,00h,00h,00h,00h,00h
		db	02h,00h

; DS:38C1  used by C85UNIT.C
EXPR_NARROW_SHAPE	label	byte
		db	00h

; DS:38C2  used by C113UNIT.C
INVERT_COMPARE_TABLE	label	byte
		db	00h,03h
		db	10 dup (0)

; DS:38CE  used by C113UNIT.C
MIRROR_COMPARE_TABLE	label	byte
		db	00h,40h,0C0h,0C0h,0C0h
		db	19 dup (0)
		db	80h,0C0h,00h,00h,40h,80h,00h,00h,00h,0C0h,0C0h,00h,00h,00h,00h,00h
		db	02h,00h,3Ah,00h

; DS:38FA  used by RFILEIO.C
OUTPUT_FILE_HANDLE	label	byte
		db	0FFh,0FFh,1Eh,00h,1Dh,00h,22h,00h,21h,00h,20h,00h,1Fh,00h,1Dh,00h
		db	1Eh,00h,20h,00h,1Fh,00h,22h,00h,21h,00h

; DS:3914  used by C105UNIT.C
JUMP_CONDITION_INVERSE_TABLE	label	byte
		db	01h,00h,07h,06h,09h,08h,03h,02h,05h,04h,0Bh,0Ah,0Dh,0Ch,0Fh,0Eh
		db	11h,10h,13h,12h

; DS:3928  used by C111UNIT.C, C119UNIT.C, C214UNIT.C, C85UNIT.C
KIND_INFO_TABLE	label	byte
		db	00h,00h,00h

; DS:392B  used by C10TYPE.C, C10TYPE.H, C13UNIT.C, C13UNIT.H, C207UNIT.C, C7UNIT.C, 1 more
KIND_SIZE_TABLE	label	byte
		db	00h,01h,01h,01h,01h,02h,01h,01h,01h,03h,03h,02h

; DS:3937  used by C202UNIT.C
BITFIELD_UNIT_BYTES	label	byte
		db	02h,04h,03h,02h,02h,03h,03h,02h,02h,04h,03h,02h,02h,07h,07h,02h
		db	04h,08h,07h,02h,04h,09h,09h,02h,04h,0Ah,0Ah,02h,08h,0Bh,0Bh,02h
		db	0Ah,0Ch,0Ch,01h,00h,0Dh,03h,02h,02h,0Eh,03h,02h,02h,0Fh,07h,02h
		db	04h,10h,07h,02h,04h,11h,11h,01h,00h,12h,12h,01h,00h,13h,13h,02h
		db	00h

; DS:3978  used by C119UNIT.C, C121UNIT.C, C239UNIT.C, C7UNIT.C, C85UNIT.C, UNIT7.H
TYPE_RANGE_TABLE	label	byte
		db	14h,14h,02h,00h,15h,03h,02h,02h

; DS:3980  used by C131UNIT.C
BCC_ENUM_MIN_LO	label	byte
		db	80h,0FFh,0FFh,0FFh

; DS:3984  used by C131UNIT.C
BCC_ENUM_MAX_LO	label	byte
		db	7Fh,00h,00h,00h,00h,00h,00h,00h

; DS:398C  used by C111UNIT.C, C131UNIT.C, C226UNIT.C, CODEMASK.C
INT_LIMIT	label	byte
		db	0FFh,00h,00h,00h,00h,80h,0FFh,0FFh,0FFh,7Fh,00h,00h,00h,00h,00h,00h

; DS:399C  used by C111UNIT.C, CODEMASK.C
MASK_B	label	byte
		db	0FFh,0FFh,00h,00h,00h,80h,0FFh,0FFh

; DS:39A4  used by C131UNIT.C, C202UNIT.C, C226UNIT.C
BCC_ENUM_LIMIT_LO	label	byte
		db	0FFh,7Fh,00h,00h,00h,00h,00h,00h

; DS:39AC  used by C111UNIT.C, C226UNIT.C, CODEMASK.C
MASK_C	label	byte
		db	0FFh,0FFh,00h,00h,01h,00h,00h,80h

; DS:39B4  used by C226UNIT.C
LONG_MAX_VALUE	label	byte
		db	0FFh,0FFh,0FFh,7Fh

; DS:39B8  used by EMITMAIN.H, R7MAIN.C
OPERATOR_RULES	label	byte
		db	22 dup (0)
		db	02h,02h,02h,02h,02h,02h,03h,03h,02h,02h,02h,33h,02h,02h,03h,03h
		db	02h,02h,05h,05h,00h,06h,06h,06h,06h,06h,06h,07h,07h,33h,33h,33h
		db	33h,06h,06h,07h,07h,33h,33h,33h,33h,00h,33h,33h,33h,33h,33h,33h
		db	33h,33h,08h,08h,08h,33h,33h,33h,33h,33h,33h,33h,33h,33h,04h,04h
		db	04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h
		db	04h,04h,04h,00h,02h,02h,02h,02h,02h,02h,03h,03h,02h,02h,02h,33h
		db	02h,02h,03h,03h,02h,33h,09h,09h,00h,02h,02h,02h,02h,02h,02h,03h
		db	03h,02h,02h,02h,33h,02h,02h,03h,03h,33h,33h,09h,09h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,00h,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Bh,0Bh,0Ch,0Ch,0Ch,33h,0Ah
		db	33h,0Eh,0Fh,33h,33h,33h,33h,00h,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,10h,10h
		db	0Ch,0Ch,0Ch,33h,0Ah,33h,0Eh,0Fh,33h,33h,33h,33h,00h,33h,33h,11h
		db	11h,11h,11h,12h,12h,0Ch,0Ch,0Ch,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,00h,33h,33h,13h,14h,13h,14h,33h,33h,0Ch,0Ch,0Ch,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,00h,33h,33h,13h,15h,13h,15h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,0Ah,0Ah,0Ah,0Ah
		db	0Ah,0Ah,16h,16h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	00h,17h,0Ah,17h,0Ah,17h,0Ah,16h,16h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,00h,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,18h,18h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,0Ah,0Ah,0Ah,0Ah,0Ah
		db	0Ah,18h,18h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h
		db	0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,18h,18h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,00h,19h,19h,19h,19h,19h,19h,1Ah,1Ah,1Bh,1Bh,1Bh
		db	33h,19h,19h,1Ah,1Ah,33h,33h,33h,33h,00h,19h,19h,19h,19h,19h,19h
		db	1Ch,1Ch,0Dh,0Dh,0Dh,33h,19h,33h,1Eh,1Fh,33h,33h,33h,33h,00h,19h
		db	19h,19h,19h,19h,19h,20h,20h,0Dh,0Dh,0Dh,33h,19h,33h,1Eh,1Fh,33h
		db	33h,33h,33h,00h,21h,21h,22h,22h,22h,22h,33h,33h,0Dh,0Dh,0Dh,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,00h,23h,25h,33h,33h,33h,33h,33h
		db	33h,0Dh,0Dh,0Dh,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,24h,26h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,00h,19h,19h,19h,19h,19h,19h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,00h,27h,19h,27h,19h,27h,19h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,19h,19h,19h
		db	19h,19h,19h,1Dh,1Dh,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,00h,19h,19h,19h,19h,19h,19h,1Dh,1Dh,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,00h,19h,19h,19h,19h,19h,19h,1Dh,1Dh,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,28h,28h,28h,28h,28h,28h,28h,28h,28h
		db	28h,28h,28h,28h,28h,28h,28h,28h,28h,28h,28h,28h,29h,29h,29h,29h
		db	29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h,29h
		db	29h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,00h,33h,33h,2Ah,33h,2Ah,33h,2Bh,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,2Ch,33h,33h,33h,33h,33h
		db	00h,2Dh,2Dh,2Dh,2Dh,2Dh,2Dh,2Eh,2Eh,2Fh,2Fh,2Fh,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,00h,2Dh,2Dh,2Dh,2Dh,2Dh,2Dh,30h,30h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,31h,31h,31h,31h,31h
		db	31h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,00h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,32h
		db	33h,33h,33h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h
		db	01h,01h,01h,01h,01h,01h,01h,01h,33h,33h,33h,33h,33h,33h,33h,33h
		db	33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h,33h

; DS:3E3B  used by EMIT7.H, R7HELP.C
CONVERSION_RULES	label	byte
		db	18 dup (0)
		db	01h,01h,03h,03h,03h,03h,04h,04h,05h,05h,05h,01h,03h,03h,04h,04h
		db	00h,01h,01h,06h,06h,06h,06h,07h,07h,08h,08h,08h,01h,06h,06h,07h
		db	07h,00h,01h,01h,01h,01h,01h,01h,0Ah,0Ah,0Bh,0Bh,0Bh,01h,01h,01h
		db	0Ah,0Ah,00h,01h,01h,01h,01h,01h,01h,0Dh,0Dh,0Eh,0Eh,0Eh,01h,01h
		db	01h,0Dh,0Dh,00h,01h,01h,01h,01h,01h,01h,0Ah,0Ah,0Bh,0Bh,0Bh,01h
		db	01h,01h,0Ah,0Ah,00h,01h,01h,01h,01h,01h,01h,0Dh,0Dh,0Eh,0Eh,0Eh
		db	01h,01h,01h,0Dh,0Dh,00h,0Fh,0Fh,09h,09h,09h,09h,01h,01h,11h,11h
		db	11h,01h,09h,10h,01h,01h,00h,0Fh,0Fh,09h,09h,09h,09h,01h,01h,12h
		db	12h,12h,01h,09h,10h,01h,01h,00h,16h,16h,16h,16h,16h,16h,18h,18h
		db	01h,01h,01h,01h,16h,17h,18h,18h,00h,16h,16h,16h,16h,16h,16h,18h
		db	18h,02h,01h,01h,01h,16h,17h,18h,18h,00h,16h,16h,16h,16h,16h,16h
		db	18h,18h,02h,02h,01h,01h,16h,17h,18h,18h,19h,19h,19h,19h,19h,19h
		db	19h,19h,19h,19h,19h,19h,19h,19h,19h,19h,19h,00h,01h,01h,01h,01h
		db	01h,01h,13h,13h,14h,14h,14h,01h,01h,01h,13h,13h,00h,01h,01h,01h
		db	01h,01h,01h,15h,15h,0Ch,0Ch,0Ch,01h,01h,01h,15h,15h,00h,0Fh,0Fh
		db	09h,09h,09h,09h,01h,01h,12h,12h,12h,01h,09h,10h,01h,01h,00h,0Fh
		db	0Fh,09h,09h,09h,09h,01h,01h,12h,12h,12h,01h,09h,10h,01h,01h
		db	'__AHSHIFT',0
		db	'padd@',0
		db	'psub@',0
		db	'psba@',0
		db	'pada@',0
		db	'psbh@',0
		db	'psbp@',0
		db	'scopy@',0
		db	'ftol@',0
		db	00h

; DS:3F98  used by C101UNIT.C, C105UNIT.C, C106UNIT.C, C107UNIT.C, C84UNIT.C, STAG001.C
OPCODE_DESCRIPTOR_TABLE	label	byte
		db	4Ch,50h,01h

; DS:3F9B  used by C104UNIT.C, C106UNIT.C, C107UNIT.C, C109UNIT.C, C204UNIT.C, C205UNIT.C, 5 more
CODE_OP_INFO_TABLE	label	byte
		db	00h,20h,00h,00h,00h

; DS:3FA0  used by C107UNIT.C
OPCODE_DESC_BYTE8	label	byte
		db	34 dup (0)
		db	01h,04h,00h,00h,00h,10h,00h,10h
		db	11 dup (0)
		db	01h,04h,00h,00h,00h,10h,00h,10h
		db	10 dup (0)
		db	08h,00h,03h,00h,02h,00h,00h,00h,10h
		db	10 dup (0)
		db	08h,00h,04h
		db	16 dup (0)
		db	08h,00h,04h
		db	16 dup (0)
		db	20h,00h,04h,00h,01h,00h,00h,00h,0Ch
		db	10 dup (0)
		db	20h,00h,04h,00h,02h,00h,00h,00h,10h
		db	10 dup (0)
		db	08h,00h,00h,00h,01h,00h,00h,00h,0Ch
		db	10 dup (0)
		db	08h,00h,00h,00h,02h,00h,00h,00h,0Ah
		db	10 dup (0)
		db	08h,00h,00h,00h,03h,00h,00h,00h,0Ah
		db	10 dup (0)
		db	09h,00h,00h,00h,02h,00h,00h,00h,0Ah
		db	10 dup (0)
		db	09h,00h,00h,00h,02h,00h,00h,00h,0Ah
		db	10 dup (0)
		db	08h,00h,00h,00h,02h,00h,00h,00h,10h
		db	10 dup (0)
		db	01h,00h,00h,00h,01h,00h,00h,00h,0Ch
		db	10 dup (0)
		db	01h,00h,00h,00h,02h,00h,00h,00h,10h
		db	10 dup (0)
		db	01h,00h,00h,00h,02h,00h,00h,00h,10h
		db	10 dup (0)
		db	03h,00h,00h,00h,04h
		db	14 dup (0)
		db	03h,00h,00h,00h,05h
		db	14 dup (0)
		db	03h,00h,00h,00h,06h
		db	16 dup (0)
		db	03h,00h,01h,02h,0Eh,15h,0Ch
		db	12 dup (0)
		db	03h,00h,02h,02h,0Eh,15h,10h
		db	12 dup (0)
		db	03h,00h,02h,02h,0Eh,15h,10h
		db	10 dup (0)
		db	02h,00h,03h,00h,04h,02h,0Eh,15h
		db	11 dup (0)
		db	02h,00h,03h,00h,05h,02h,0Eh,15h
		db	11 dup (0)
		db	02h,00h,03h,00h,06h,02h,0Eh,15h
		db	13 dup (0)
		db	03h,00h,02h,02h,0Eh,15h,10h,00h,00h,00h,00h,00h,00h,00h,50h,50h
		db	0FEh,00h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch,00h,00h,00h,00h,00h,04h
		db	00h,50h,50h,0FEh,00h,0C1h,03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h
		db	01h,00h,05h,00h,50h,50h,0FEh,10h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch
		db	00h,00h,00h,00h,00h,04h,00h,50h,50h,0FEh,10h,0C1h,03h,00h,02h,02h
		db	0Ah,0Ah,0Ah,00h,00h,00h,01h,00h,05h,00h,54h,50h,03h,12h,00h,03h
		db	00h,04h,04h,00h,00h,00h,00h,0DEh,0C1h,0D8h,0C0h,0D8h,00h,54h,50h,03h
		db	12h,00h,03h,00h,05h,05h,00h,00h,00h,00h,0DEh,0C1h,0D8h,0C0h,0DCh,00h
		db	54h,50h,03h,12h,00h,03h,00h,06h,06h,00h,00h,00h,00h,0DEh,0C1h,0D8h
		db	0C0h,0DCh,00h,59h,50h,0FEh,10h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch,00h
		db	00h,00h,10h,00h,14h,00h,59h,50h,0FEh,10h,0C1h,03h,00h,02h,02h,0Ah
		db	0Ah,0Ah,00h,00h,00h,11h,00h,15h,00h,5Dh,50h,0FEh,00h,41h,03h,00h
		db	01h,01h,0Ch,0Ch,0Ch,00h,00h,00h,28h,00h,2Ch,00h,5Dh,50h,0FEh,00h
		db	0C1h,03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h,29h,00h,2Dh,00h,5Dh
		db	50h,0FEh,00h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch,00h,00h,00h,28h,00h
		db	2Ch,00h,5Dh,50h,0FEh,00h,0C1h,03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h
		db	00h,29h,00h,2Dh,00h,61h,50h,03h,02h,00h,03h,00h,04h,04h,00h,00h
		db	00h,00h,0DEh,0E9h,0D8h,0E0h,0D8h,20h,61h,50h,03h,02h,00h,03h,00h,05h
		db	05h,00h,00h,00h,00h,0DEh,0E9h,0D8h,0E0h,0DCh,20h,61h,50h,03h,02h,00h
		db	03h,00h,06h,06h,00h,00h,00h,00h,0DEh,0E9h,0D8h,0E0h,0DCh,20h,66h,50h
		db	03h,02h,00h,03h,00h,04h,04h,00h,00h,00h,00h,0DEh,0E1h,0D8h,0E8h,0D8h
		db	28h,66h,50h,03h,02h,00h,03h,00h,05h,05h,00h,00h,00h,00h,0DEh,0E1h
		db	0D8h,0E8h,0DCh,28h,66h,50h,03h,02h,00h,03h,00h,06h,06h,00h,00h,00h
		db	00h,0DEh,0E1h,0D8h,0E8h,0DCh,28h,6Ch,50h,0FEh,00h,41h,03h,00h,01h,01h
		db	0Ch,0Ch,0Ch,00h,00h,00h,18h,00h,1Ch,00h,6Ch,50h,0FEh,00h,0C1h,03h
		db	00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h,19h,00h,1Dh,00h,70h,50h,02h
		db	10h,00h,03h,00h,01h,01h,01h,1Bh,01h,00h,0F6h,00h,28h,00h,00h,00h
		db	70h,50h,02h,10h,00h,03h,00h,02h,02h,09h,19h,09h,01h,00h,00h,28h
		db	00h,00h,00h,75h,50h,03h,12h,00h,03h,00h,04h,04h,00h,00h,00h,00h
		db	0DEh,0C9h,0D8h,0C8h,0D8h,08h,75h,50h,03h,12h,00h,03h,00h,05h,05h,00h
		db	00h,00h,00h,0DEh,0C9h,0D8h,0C8h,0DCh,08h,75h,50h,03h,12h,00h,03h,00h
		db	06h,06h,00h,00h,00h,00h,0DEh,0C9h,0D8h,0C8h,0DCh,08h,7Ah,50h,02h,00h
		db	00h,03h,00h,01h,01h,09h,1Ch,01h,00h,0F6h,00h,38h,00h,00h,00h,7Ah
		db	50h,02h,00h,00h,03h,00h,02h,02h,09h,1Ah,09h,01h,0F7h,00h,38h,00h
		db	00h,00h,7Fh,50h,03h,02h,00h,03h,00h,04h,04h,00h,00h,00h,00h,0DEh
		db	0F9h,0D8h,0F0h,0D8h,30h,7Fh,50h,03h,02h,00h,03h,00h,05h,05h,00h,00h
		db	00h,00h,0DEh,0F9h,0D8h,0F0h,0DCh,30h,7Fh,50h,03h,02h,00h,03h,00h,06h
		db	06h,00h,00h,00h,00h,0DEh,0F9h,0D8h,0F0h,0DCh,30h,84h,50h,03h,02h,00h
		db	03h,00h,04h,04h,00h,00h,00h,00h,0DEh,0F1h,0D8h,0F8h,0D8h,38h,84h,50h
		db	03h,02h,00h,03h,00h,05h,05h,00h,00h,00h,00h,0DEh,0F1h,0D8h,0F8h,0DCh
		db	38h,84h,50h,03h,02h,00h,03h,00h,06h,06h,00h,00h,00h,00h,0DEh,0F1h
		db	0D8h,0F8h,0DCh,38h,7Bh,50h,02h,00h,00h,03h,00h,01h,01h,09h,1Ch,09h
		db	01h,0F6h,00h,30h,00h,00h,00h,7Bh,50h,02h,00h,00h,03h,00h,02h,02h
		db	09h,1Ah,09h,01h,0F7h,00h,30h,00h,00h,00h,7Bh,50h,02h,00h,00h,03h
		db	00h,01h,01h,09h,1Ch,01h,01h,0F6h,00h,30h,00h,00h,00h,7Bh,50h,02h
		db	00h,00h,03h,00h,02h,02h,09h,1Ah,0Bh,02h,0F7h,00h,30h,00h,00h,00h
		db	7Ah,50h,02h,00h,00h,03h,00h,01h,01h,09h,1Ch,01h,00h,0F6h,00h,38h
		db	00h,00h,00h,7Ah,50h,02h,00h,00h,03h,00h,02h,02h,09h,1Ah,0Bh,02h
		db	0F7h,00h,38h,00h,00h,00h,8Ah,50h,0FEh,00h,01h,03h,00h,01h,01h,1Eh
		db	07h,0Ch,00h,00h,00h,00h,00h,20h,00h,8Ah,50h,0FEh,00h,01h,03h,00h
		db	02h,02h,1Dh,07h,0Ah,00h,00h,00h,01h,00h,20h,00h,8Eh,50h,0FEh,00h
		db	01h,03h,00h,01h,01h,1Eh,07h,0Ch,00h,00h,00h,00h,00h,28h,00h,8Eh
		db	50h,0FEh,00h,01h,03h,00h,02h,02h,1Dh,07h,0Ah,00h,00h,00h,01h,00h
		db	28h,00h,92h,50h,0FEh,00h,01h,03h,00h,01h,01h,1Eh,07h,0Ch,00h,00h
		db	00h,00h,00h,38h,00h,92h,50h,0FEh,00h,01h,03h,00h,02h,02h,1Dh,07h
		db	0Ah,00h,00h,00h,01h,00h,38h,00h,96h,50h,0FEh,10h,41h,03h,00h,01h
		db	01h,0Ch,0Ch,0Ch,00h,00h,00h,20h,00h,24h,00h,96h,50h,0FEh,10h,41h
		db	03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h,21h,00h,25h,00h,9Ah,50h
		db	0FEh,10h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch,00h,00h,00h,08h,00h,0Ch
		db	00h,9Ah,50h,0FEh,10h,41h,03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h
		db	09h,00h,0Dh,00h,9Dh,50h,0FEh,10h,41h,03h,00h,01h,01h,0Ch,0Ch,0Ch
		db	00h,00h,00h,30h,00h,34h,00h,9Dh,50h,0FEh,10h,41h,03h,00h,02h,02h
		db	0Ah,0Ah,0Ah,00h,00h,00h,31h,00h,35h,00h,0A1h,50h,02h,00h,01h,03h
		db	00h,01h,01h,0Ch,00h,0Ch,00h,0F6h,00h,18h,00h,00h,00h,0A1h,50h,02h
		db	00h,01h,03h,00h,02h,02h,0Ah,00h,0Ah,00h,0F7h,00h,18h,00h,00h,00h
		db	0A5h,50h,03h,02h,00h,03h,00h,06h,06h,00h,00h,00h,00h,0D9h,0E0h,00h
		db	00h,00h,00h,0AAh,50h,0FEh,00h,01h,03h,00h,01h,01h,0Ch,00h,0Ch,00h
		db	0F6h,00h,10h,00h,00h,00h,0AAh,50h,0FEh,00h,01h,03h,00h,02h,02h,0Ah
		db	00h,0Ah,00h,0F7h,00h,10h,00h,00h,00h,0AEh,50h,0FEh,00h,01h,03h,00h
		db	02h,02h,1Dh,07h,0Ah,00h,00h,00h,01h,00h,18h,00h,0B2h,50h,0FEh,00h
		db	01h,03h,00h,02h,02h,1Dh,07h,0Ah,00h,00h,00h,01h,00h,10h,00h,0B6h
		db	50h,02h
		db	16 dup (0)
		db	0BCh,50h,0FFh,00h,01h,03h,00h,01h,01h,0Ch,00h,0Ch,00h,00h,00h,00h
		db	00h,00h,00h,0BCh,50h,0FFh,00h,01h,03h,00h,02h,02h,0Ah,00h,0Ah,00h
		db	00h,00h,00h,00h,00h,00h,0C0h,50h,0FFh,00h,01h,03h,00h,01h,01h,0Ch
		db	00h,0Ch,00h,00h,00h,00h,00h,00h,00h,0C0h,50h,0FFh,00h,01h,03h,00h
		db	02h,02h,0Ah,00h,0Ah,00h,00h,00h,00h,00h,00h,00h,0C4h,50h,03h,02h
		db	00h,03h,00h,04h,02h
		db	8 dup (0)
		db	0DFh,00h,0C4h,50h,03h,02h,00h,03h,00h,05h,02h
		db	8 dup (0)
		db	0DBh,00h,0C4h,50h,03h,02h,00h,03h,00h,06h,05h
		db	8 dup (0)
		db	0DFh,28h,0C9h,50h,03h,06h,00h,03h,00h,02h,04h
		db	8 dup (0)
		db	0DFh,18h,0C9h,50h,03h,06h,00h,03h,00h,03h,05h
		db	8 dup (0)
		db	0DBh,18h,0C9h,50h,03h,06h,00h,03h,00h,05h,06h
		db	8 dup (0)
		db	0DFh,38h,0CFh,50h,03h,06h,00h,03h,00h,02h,02h
		db	8 dup (0)
		db	0DFh,10h,0CFh,50h,03h,06h,00h,03h,00h,03h,03h
		db	8 dup (0)
		db	0DBh,18h,0CFh,50h,03h,06h,00h,03h,00h,05h,05h
		db	10 dup (0)
		db	0D4h,50h,03h,02h,00h,00h,00h,04h,04h,00h,00h,00h,00h,00h,00h,0D9h
		db	0C0h,0D9h,00h,0D4h,50h,03h,02h,00h,00h,00h,05h,05h,00h,00h,00h,00h
		db	00h,00h,0D9h,0C0h,0DDh,00h,0D4h,50h,03h,02h,00h,00h,00h,06h,06h,00h
		db	00h,00h,00h,00h,00h,0D9h,0C0h,0DBh,28h,0D8h,50h,03h,06h,00h,03h,00h
		db	04h,04h,00h,00h,00h,00h,00h,00h,0DDh,0D0h,0D9h,10h,0D8h,50h,03h,06h
		db	00h,03h,00h,05h,05h,00h,00h,00h,00h,00h,00h,0DDh,0D0h,0DDh,10h,0DCh
		db	50h,03h,06h,00h,03h,00h,04h,04h,00h,00h,00h,00h,00h,00h,0DDh,0D8h
		db	0D9h,18h,0DCh,50h,03h,06h,00h,03h,00h,05h,05h,00h,00h,00h,00h,00h
		db	00h,0DDh,0D8h,0DDh,18h,0DCh,50h,03h,06h,00h,03h,00h,06h,06h,00h,00h
		db	00h,00h,00h,00h,0DDh,0D8h,0DBh,38h,00h,00h,00h,00h,00h,03h,00h,00h
		db	00h,09h,00h,09h,01h,00h,00h,00h,00h,00h,00h,0E1h,50h,02h,00h,40h
		db	00h,00h,02h,02h,0Bh,01h
		db	8 dup (0)
		db	0E1h,50h,02h,00h,40h,00h,00h,02h,02h,0Bh,09h
		db	8 dup (0)
		db	0E5h,50h,02h,00h,40h,00h,00h,02h,02h,01h,0Bh,01h,00h,00h,00h,00h
		db	00h,00h,00h,0E5h,50h,02h,00h,40h,00h,00h,02h,02h,09h,0Bh,09h,00h
		db	00h,00h,00h,00h,00h,00h,0E8h,50h,02h,08h
		db	15 dup (0)
		db	0ECh,50h,01h
		db	8 dup (0)
		db	0Ah,00h,9Ch,00h,00h,00h,00h,00h,0F2h,50h,01h
		db	8 dup (0)
		db	0Ah,00h,9Dh,00h,00h,00h,00h,00h,0F7h,50h,02h,00h,04h,04h,00h,02h
		db	02h,0Ah,00h,09h,00h,0FFh,00h,10h,00h,00h,00h,0F7h,50h,02h,00h,04h
		db	04h,00h,02h,02h,10h,10h,09h,00h,0FFh,00h,18h,00h,00h,00h,0F7h,50h
		db	01h,09h,04h,04h,00h,02h,00h,00h,00h,09h,00h,00h,00h,00h,00h,00h
		db	00h,0F7h,50h,03h,09h,04h,04h,00h,02h,00h,00h,00h,09h,00h,00h,00h
		db	00h,00h,00h,00h,0FCh,50h,02h,08h
		db	15 dup (0)
		db	0FFh,50h,01h,08h
		db	15 dup (0)
		db	0FCh,50h,02h,09h
		db	15 dup (0)
		db	0FCh,50h,02h,09h
		db	20 dup (0)
		db	03h
		db	13 dup (0)
		db	02h,51h,01h
		db	10 dup (0)
		db	0C9h,00h,00h,00h,00h,00h,08h,51h,0FFh,00h,00h,00h,00h,02h,02h,00h
		db	00h,10h,00h,00h,00h,00h,00h,00h,00h,0Ch,51h,0FEh,40h,40h,04h,00h
		db	01h,01h,0Ch,0Ch,00h,00h,00h,00h,38h,00h,3Ch,00h,0Ch,51h,0FEh,40h
		db	0C0h,04h,00h,02h,02h,0Ah,0Ah,00h,00h,00h,00h,39h,00h,3Dh,00h,10h
		db	51h,03h,02h,00h,04h,00h,04h,04h,00h,00h,00h,00h,0DEh,0D9h,0D8h,0D8h
		db	0D8h,18h,10h,51h,03h,02h,00h,04h,00h,05h,05h,00h,00h,00h,00h,0DEh
		db	0D9h,0D8h,0D8h,0DCh,18h,10h,51h,03h,02h,00h,04h,00h,06h,06h,00h,00h
		db	00h,00h,0DEh,0D9h,0D8h,0D8h,0DCh,18h,16h,51h,0FEh,40h,40h,04h,00h,01h
		db	01h,0Ch,0Ch,00h,00h,00h,00h,84h,00h,0A8h,00h,16h,51h,0FEh,40h,40h
		db	04h,00h,02h,02h,0Ah,0Ah,00h,00h,00h,00h,85h,00h,0A9h,00h,1Bh,51h
		db	03h,02h,00h,04h,00h,04h,04h,00h,00h,00h,00h,0D9h,0E4h,00h,00h,00h
		db	00h,1Bh,51h,03h,02h,00h,04h,00h,05h,05h,00h,00h,00h,00h,0D9h,0E4h
		db	00h,00h,00h,00h,1Bh,51h,03h,02h,00h,04h,00h,06h,06h,00h,00h,00h
		db	00h,0D9h,0E4h,00h,00h,00h,00h,20h,51h,03h,02h,00h,00h,00h,04h,00h
		db	00h,00h,00h,00h,0D9h,0EEh,00h,00h,00h,00h,25h,51h,03h,02h,00h,00h
		db	00h,04h,00h,00h,00h,00h,00h,0D9h,0E8h,00h,00h,00h,00h,0D4h,50h,03h
		db	02h,00h,00h,00h,06h,06h,00h,00h,00h,00h,00h,00h,0D9h,0C0h,00h,00h
		db	2Ah,51h,03h,02h,00h,00h,00h,06h,06h,00h,00h,00h,00h,0DDh,0C0h,00h
		db	00h,00h,00h,30h,51h,03h,02h,00h,00h,00h,06h,06h,00h,00h,00h,00h
		db	0D9h,0F6h,00h,00h,00h,00h,37h,51h,03h,02h,00h,03h,00h,02h,02h,00h
		db	00h,00h,00h,00h,00h,0DFh,0E0h,0DDh,38h,3Dh,51h,02h,02h,00h,03h,00h
		db	00h,00h,00h,00h,00h,00h,0DDh,0D8h,00h,00h,00h,00h,4Bh,51h,02h,02h
		db	00h,03h,00h,00h,00h,00h,00h,00h,00h,0D9h,0C9h,00h,00h,00h,00h,59h
		db	51h,04h
		db	10 dup (0)
		db	0C8h,00h,00h,00h,00h,00h,5Fh,51h,0FFh,40h,40h,00h,00h,00h,01h,0Ch
		db	9 dup (0)
		db	5Fh,51h,0FFh,40h,40h,00h,00h,00h,02h,0Ah
		db	9 dup (0)
		db	64h,51h,02h,00h,00h,03h,00h,02h,02h,00h,00h,0Ah,00h,8Dh,00h,00h
		db	00h,00h,00h,68h,51h,02h,00h,00h,00h,00h,02h,03h,00h,00h,00h,00h
		db	0C4h,00h,00h,00h,00h,00h,6Ch,51h,0FEh,00h,40h,03h,00h,01h,01h,0Ch
		db	0Ch,0Ch,00h,00h,00h,00h,00h,00h,00h,6Ch,51h,0FEh,00h,40h,03h,00h
		db	02h,02h,0Ah,0Ah,10h,00h,00h,00h,00h,00h,00h,00h,6Ch,51h,0FEh,00h
		db	41h,03h,00h,02h,02h,10h,10h,10h,00h,00h,00h,00h,00h,00h,00h,70h
		db	51h,0FEh,00h,00h,03h,00h,02h,02h,0Ah,0Ah,0Ah,00h,00h,00h,85h,00h
		db	00h,00h,6Ch,51h,0FEh,04h,40h,03h,00h,01h,01h,0Ch,0Ch,0Ch,00h,00h
		db	00h,00h,00h,00h,00h,6Ch,51h,0FEh,04h,40h,03h,00h,02h,02h,10h,10h
		db	10h,00h,00h,00h,00h,00h,00h,00h,6Ch,51h,0FEh,04h,40h,03h,00h,03h
		db	03h
		db	10 dup (0)
		db	6Ch,51h,0FEh,04h,00h,03h,00h,04h,04h
		db	10 dup (0)
		db	6Ch,51h,0FEh,04h,00h,03h,00h,05h,05h
		db	10 dup (0)
		db	6Ch,51h,0FEh,04h,00h,03h,00h,06h,06h
		db	10 dup (0)
		db	75h,51h,01h
		db	12 dup (0)
		db	0CAh,00h,0CBh,00h,75h,51h,01h
		db	12 dup (0)
		db	0C2h,00h,0C3h,00h,79h,51h,01h
		db	10 dup (0)
		db	0CFh,00h,00h,00h,00h,00h,0FCh,50h,02h
		db	16 dup (0)
		db	51h,50h,04h
		db	16 dup (0)
		db	7Eh,51h,01h
		db	10 dup (0)
		db	0FAh,00h,00h,00h,00h,00h,82h,51h,01h
		db	10 dup (0)
		db	0FBh,00h,00h,00h,00h,00h,86h,51h,01h
		db	8 dup (0)
		db	09h,00h,9Fh,00h,00h,00h,00h,00h,8Bh,51h,01h,00h,00h,00h,00h,00h
		db	00h,02h,00h,09h,00h,9Eh,00h,00h,00h,00h,00h,6Ch,51h,01h,00h,01h
		db	03h,00h,02h,01h,0Ch,00h,1Fh,00h,98h,00h,00h,00h,00h,00h,90h,51h
		db	01h,00h,01h,03h,00h,02h,01h,01h,00h,09h,00h,98h,00h,00h,00h,00h
		db	00h,94h,51h,01h,00h,01h,03h,00h,03h,02h,09h,00h,09h,01h,99h
		db	8 dup (0)
		db	08h,00h,04h
		db	16 dup (0)
		db	08h,00h,04h
		db	16 dup (0)
		db	08h
		db	18 dup (0)
		db	08h
		db	8 dup (0)
		db	05h
		db	9 dup (0)
		db	08h,20h,04h
		db	16 dup (0)
		db	08h
		db	18 dup (0)
		db	02h,00h,00h,00h,06h,06h
		db	13 dup (0)
		db	02h,00h,04h,00h,06h,06h
		db	14 dup (0)
		db	20h,04h,00h,00h,02h,09h,0Bh
		db	12 dup (0)
		db	20h,04h,00h,00h,02h,0Dh,0Fh
		db	12 dup (0)
		db	20h,04h,00h,00h,02h,09h
		db	13 dup (0)
		db	20h,04h,00h,00h,02h,0Bh
		db	13 dup (0)
		db	20h,04h,00h,00h,02h,0Fh
		db	13 dup (0)
		db	20h,04h,00h,00h,01h,01h
		db	13 dup (0)
		db	20h,04h,00h,00h,01h,03h
		db	13 dup (0)
		db	20h,04h,00h,00h,01h,05h
		db	13 dup (0)
		db	20h,04h,00h,00h,01h,07h
		db	13 dup (0)
		db	20h,04h,00h,00h,02h,0Dh,15h
		db	12 dup (0)
		db	20h,04h,00h,00h,02h,11h,15h
		db	12 dup (0)
		db	20h,04h,00h,00h,02h,12h,15h
		db	12 dup (0)
		db	20h,04h,00h,00h,02h,12h
		db	13 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,09h
		db	11 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,0Bh
		db	11 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,0Fh
		db	11 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,0Dh
		db	11 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,12h
		db	11 dup (0)
		db	20h,04h,00h,02h,00h,00h,00h,15h,00h,00h,00h,00h,00h,00h,00h,98h
		db	51h
		db	11 dup (0)
		db	0F3h,00h,00h,00h,00h,00h,9Ch,51h
		db	11 dup (0)
		db	0F3h,00h,00h,00h,00h,00h,0A1h,51h
		db	11 dup (0)
		db	0F2h,00h,00h,00h,00h,00h,0A7h,51h
		db	11 dup (0)
		db	0AEh,00h,00h,00h,00h,00h,0ADh,51h
		db	11 dup (0)
		db	0A4h,00h,00h,00h,00h,00h,0B3h,51h
		db	11 dup (0)
		db	0A5h,00h,00h,00h,00h,00h,0B9h,51h
		db	11 dup (0)
		db	0A6h,00h,00h,00h,00h,00h,0BFh,51h
		db	11 dup (0)
		db	0AAh,00h,00h,00h,00h,00h,0C5h,51h
		db	11 dup (0)
		db	0ABh,00h,00h,00h,00h,00h,0CBh,51h
		db	11 dup (0)
		db	0FDh,00h,00h,00h,00h,00h,0CFh,51h
		db	11 dup (0)
		db	0FCh,00h,00h,00h,00h,00h,0D3h,51h,0FEh,00h,01h,03h,00h,02h,02h,1Dh
		db	07h,0Ah,00h,00h,00h,01h,00h,00h,00h,0D7h,51h,0FEh,00h,01h,03h,00h
		db	02h,02h,1Dh,07h,0Ah,00h,00h,00h,01h,00h,08h,00h,0DBh,51h,03h,02h
		db	00h,03h,00h,06h,06h,00h,00h,00h,00h,0D9h,0E1h,00h,00h,00h,00h

; DS:4F7A  used by C101UNIT.C, C204UNIT.C
REG_CLASS_MASK_TABLE	label	byte
		db	00h,00h,01h,00h,02h,00h,04h,00h,08h,00h,10h,00h,20h,00h,40h,00h
		db	80h,00h,01h,00h,55h,07h,04h,00h,0FFh,00h,10h,00h,10h,03h,40h,00h
		db	55h,0FFh,00h,01h,00h,02h,00h,04h,00h,08h,00h,10h,00h,20h,00h,40h
		db	00h,80h,54h,07h,50h,07h,0FCh,00h,0F0h,00h,15h,07h,3Fh,00h,55h,00h
		db	00h,03h

; DS:4FBC  used by C204UNIT.C
REG_CLASS_IS_WORD	label	byte
		db	9 dup (0)
		db	01h,01h,01h,00h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h
		db	01h,01h,00h,00h,01h,00h,01h,01h

; DS:4FDD  used by C101UNIT.C, C204UNIT.C
REGISTER_MASK_TABLE	label	byte
		db	00h,00h,04h,00h,01h,00h,55h,10h,01h,00h,10h,00h

; DS:4FE9  used by C223UNIT.C
OPERAND_BASE_BY_KIND	label	byte
		db	00h,0Fh,09h,00h,00h,0Fh,0Fh,0Fh,1Eh,27h,31h,36h,42h,44h,46h,4Ah
		db	4Ch,4Eh,9Bh,1Eh
		db	27h,'16BDFJLN',0
		db	00h,00h,00h,00h,00h,1Eh,27h,00h,00h,00h,00h,00h,00h,00h,27h,1Eh
		db	50h,53h,00h,15h,00h,00h,00h,00h,00h

; DS:5020  used by C109UNIT.C, C223UNIT.C, EMITMAIN.H, R7MAIN.C
LEAF_OPCODE_KIND_OFFSET	label	byte
		db	00h,00h,00h,01h,01h,01h,01h,02h,02h,03h,04h,05h,01h,01h,01h,02h
		db	02h,00h,01h,01h,01h,01h

; DS:5036  used by C203UNIT.C, C223UNIT.C, EMITMAIN.H, R7MAIN.C
OPER_OPCODE_KIND_OFFSET	label	byte
		db	00h,00h,00h,01h,01h,01h,01h,01h,01h,02h,03h,04h,01h,01h,01h,01h
		db	01h,00h,01h,01h,01h,01h
		db	'nop',0
		db	'add',0
		db	'fadd',0
		db	'adc',0
		db	'sub',0
		db	'fsub',0
		db	'fsubr',0
		db	'sbb',0
		db	'imul',0
		db	'fmul',0
		db	'idiv',0
		db	'fdiv',0
		db	'fdivr',0
		db	'shl',0
		db	'shr',0
		db	'sar',0
		db	'and',0
		db	6Fh,72h,00h
		db	'xor',0
		db	'neg',0
		db	'fchs',0
		db	'not',0
		db	'rcr',0
		db	'rcl',0
		db	'fwait',0
		db	'inc',0
		db	'dec',0
		db	'fild',0
		db	'fistp',0
		db	'fist',0
		db	'fld',0
		db	'fst',0
		db	'fstp',0
		db	'out',0
		db	69h,6Eh,00h
		db	'int',0
		db	'pushf',0
		db	'popf',0
		db	'call',0
		db	64h,77h,00h,64h,62h,00h
		db	'leave',0
		db	'pop',0
		db	'cmp',0
		db	'fcomp',0
		db	'test',0
		db	'ftst',0
		db	'fldz',0
		db	'fld1',0
		db	'ffree',0
		db	'fdecsp',0
		db	'fstsw',0
		db	'fstp    st(0)',0
		db	'fxch    st(1)',0
		db	'enter',0
		db	'push',0
		db	'lea',0
		db	'les',0
		db	'mov',0
		db	'xchg',0
		db	'ret',0
		db	'iret',0
		db	'cli',0
		db	'sti',0
		db	'lahf',0
		db	'sahf',0
		db	'cbw',0
		db	'cwd',0
		db	'rep',0
		db	'repz',0
		db	'repnz',0
		db	'scasb',0
		db	'movsb',0
		db	'movsw',0
		db	'cmpsb',0
		db	'stosb',0
		db	'stosw',0
		db	'std',0
		db	'cld',0
		db	'rol',0
		db	'ror',0
		db	'fabs',0
		db	21 dup (0)
		db	01h,01h,01h,01h,01h,01h,02h,02h,01h,01h,01h,01h,01h,01h,02h,02h
		db	02h,01h,01h,01h,01h,01h,01h,02h,02h,02h,02h,05h,05h,01h,01h,01h
		db	01h,02h,02h,05h,05h,02h,01h,01h,01h,02h,05h,05h,05h,05h,05h,05h
		db	05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,05h,00h

; DS:5235  used by C203UNIT.C
OPERATOR_HELPER_NAME_TABLE	label	byte
		db	00h,00h,00h,00h,00h,00h,00h,01h,01h,02h,02h,02h,02h,02h,01h,01h
		db	01h,01h,01h,01h,02h,02h,02h,02h,02h,01h,01h,01h,01h,01h,01h,01h
		db	01h,01h,01h,01h,00h,01h,01h,01h,01h,00h,00h,01h,01h,01h,01h,01h
		db	01h,01h,01h,01h,01h,03h,8Bh,52h,8Bh,52h,92h,52h,98h,52h,9Fh,52h
		db	0A5h,52h,0ACh,52h,0ACh,52h,0B3h,52h,0BAh,52h,0Ah,0Bh,05h,04h,09h,08h
		db	0Ah,0Bh,03h,02h,07h,06h
		db	'lxmul@',0
		db	'ldiv@',0
		db	'ludiv@',0
		db	'lmod@',0
		db	'lumod@',0
		db	'lxlsh@',0
		db	'lxrsh@',0
		db	'lxursh@',0

; DS:52C2  used by C203UNIT.C
STR_PCMP	label	byte
		db	'pcmp@',0
		db	'_TEXT',0
		db	'_stklen',0
		db	'__brklvl',0

; DS:52DF  used by C203UNIT.C
STR_OVERFLOW	label	byte
		db	'overflow@',0

; DS:52E9  used by C203UNIT.C
STR_SPUSH	label	byte
		db	'spush@',0

; DS:52F0  used by C203UNIT.C
STR_SCOPY	label	byte
		db	'scopy@',0
		db	4Eh,5Fh,00h,46h,5Fh,00h
		db	'__AHSHIFT',0

; DS:5307  used by C203UNIT.C
STR_PDEA	label	byte
		db	'pdea@',0

; DS:530D  used by C203UNIT.C
STR_PINA	label	byte
		db	'pina@',0
		db	00h

; DS:5314  used by C109UNIT.C
EVAL_STACK_TOP	label	byte
		db	0FFh,0FFh

; DS:5316  used by C109UNIT.C
EVAL_STACK_MAX	label	byte
		db	0FFh,0FFh

; DS:5318  used by C109UNIT.C
EVAL_STACK_SPILLED	label	byte
		db	0FFh,0FFh

; DS:531A  used by C109UNIT.C
POOLED_NODE_TOP	label	byte
		db	0FFh,0FFh

; DS:531C  used by C109UNIT.C
SCRATCH_TEMP_VARIABLE	label	byte
		db	00h,00h

; DS:531E  used by C109UNIT.C
JUMP_KIND_REMAP_TABLE	label	byte
		db	00h,0FFh,0FFh,0FFh,05h,04h,0FFh,0FFh,09h,08h,0Ah,0Bh,0FFh,0FFh,0FFh,0FFh
		db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,00h
		db	':Slxmul@',0
		db	00h
		db	'N_CHKSTK@',0
		db	'F_CHKSTK@',0

; DS:5356  used by C212UNIT.C, STAOV087.C
REG_MASK_ES	label	byte
		db	00h,10h

; DS:5358  used by C212UNIT.C
REG_MASK_BX_SI_DI	label	byte
		db	10h,03h

; DS:535A  used by STAOV087.C
REG_MASK_SI_DI	label	byte
		db	00h,03h

; DS:535C  used by C212UNIT.C
REG_MASK_CX	label	byte
		db	40h,00h

; DS:535E  used by C204UNIT.C
REG_MASK_HIGH_BYTES	label	byte
		db	0AAh,00h

; DS:5360  used by C204UNIT.C
REG_MASK_LOW_BYTES	label	byte
		db	55h,00h

; DS:5362  used by C209UNIT.C
SWITCH_BIT_200_FLAG	label	byte
		db	00h,00h

; DS:5364  used by C114UNIT.C
LOCAL_LABEL_SERIAL	label	byte
		db	00h,00h

; DS:5366  used by C114UNIT.C
LAST_LINE_MARK_ID	label	byte
		db	0FFh,0FFh

; DS:5368  used by C114UNIT.C
JUMP_MNEMONIC_TEXT	label	byte
		db	00h,00h,0B0h,53h,0B4h,53h,0B7h,53h,0BAh,53h,0BDh,53h,0C0h,53h,0C4h,53h
		db	0C8h,53h,0CCh,53h,0D0h,53h,0D3h,53h,0D7h,53h,0DAh,53h,0DEh,53h,0E1h,53h
		db	0E5h,53h,0E8h,53h,0ECh,53h,0EFh,53h,0F3h,53h,0F9h,53h,00h,54h,05h,54h

; DS:5398  used by C114UNIT.C
JUMP_OPCODE_BYTE	label	byte
		db	00h,0EBh,7Ch,7Fh,72h,77h,7Eh,7Dh,76h,73h,74h,75h,72h,73h,70h,71h
		db	78h,79h,7Ah,7Bh,0E1h,0E0h,0E3h,0E2h
		db	'jmp',0
		db	6Ah,6Ch,00h,6Ah,67h,00h,6Ah,62h,00h,6Ah,61h,00h
		db	'jle',0
		db	'jge',0
		db	'jbe',0
		db	'jae',0
		db	6Ah,65h,00h
		db	'jne',0
		db	6Ah,63h,00h
		db	'jnc',0
		db	6Ah,6Fh,00h
		db	'jno',0
		db	6Ah,73h,00h
		db	'jns',0
		db	6Ah,70h,00h
		db	'jnp',0
		db	'loopz',0
		db	'loopnz',0
		db	'jcxz',0
		db	'loop',0
		db	3Ah

; DS:540B  used by C114UNIT.C
STR_ASM_STATEMENT_CRLF	label	byte
		db	0Dh,0Ah,00h
		db	09h,'?debug',09h,'L ',0
		db	'dw',09h,0
		db	'short ',0
		db	'near ptr ',0
		db	'far ptr ',0
		db	09h,40h,40h,00h
		db	09h,'jmp',09h,0

; DS:5441  used by C114UNIT.C
STR_BP	label	byte
		db	'[bp',0
		db	00h

; DS:5446  used by C104UNIT.C
INVERTED_JUMP_KIND	label	byte
		db	01h,00h,00h,00h,07h,00h,06h,00h,09h,00h,08h,00h,03h,00h,02h,00h
		db	05h,00h,04h,00h,0Bh,00h,0Ah,00h,0Dh,00h,0Ch,00h,0Fh,00h,0Eh,00h
		db	11h,00h,10h,00h,13h,00h,12h,00h

; DS:546E  used by C84UNIT.C
OBJ_OUTPUT_DEFAULT_HOOKS	label	byte
		db	43h,00h
		dw	seg X055_00
		db	34h,00h
		dw	seg X056_01
		db	2Ah,00h
		dw	seg X056_01
		db	39h,00h
		dw	seg X056_01
		db	48h,00h
		dw	seg X056_01
		db	2Fh,00h
		dw	seg X056_01
		db	43h,00h
		dw	seg X056_01
		db	4Dh,00h
		dw	seg X056_01
		db	20h,00h
		dw	seg X055_00
		db	52h,00h
		dw	seg X056_01
		db	57h,00h
		dw	seg X054_02
		db	39h,00h
		dw	seg X05D_05
		db	34h,00h
		dw	seg X05D_05
		db	52h,00h
		dw	seg X054_02
		db	57h,00h
		dw	seg X055_00
		db	2Fh,00h
		dw	seg X054_02
		db	34h,00h
		dw	seg X054_02
		db	3Eh,00h
		dw	seg X056_01
		db	48h,00h
		dw	seg X05D_05
		db	2Ah,00h
		dw	seg X054_02
		db	4Dh,00h
		dw	seg X054_02
		db	39h,00h
		dw	seg X054_02
		db	3Eh,00h
		dw	seg X054_02
		db	43h,00h
		dw	seg X054_02

; DS:54CE  used by C84UNIT.C
REGISTER_ENCODING_TABLE	label	byte
		db	00h,04h,02h,06h,03h,07h,01h,05h,06h,07h,05h,04h
		db	'.obj',0
		db	'DGROUP@',0
		db	'FIARQQ',0
		db	'FJARQQ',0
		db	'FIERQQ',0
		db	'FISRQQ',0
		db	'FJSRQQ',0
		db	'FICRQQ',0
		db	'FJCRQQ',0
		db	'FIDRQQ',0
		db	'FIWRQQ',0

; DS:5526  used by C117UNIT.C
FIXUP_CODE_TABLE	label	byte
		db	0C4h,0C4h,00h,0C8h,00h,0C4h,84h,0CCh,0CCh,0C8h,0C8h,0C4h,00h,00h,00h,00h
		db	0C4h
		db	'TC86 Borland Turbo C++ 2.0',0

; DS:5552  used by C107UNIT.C
ASM_TEXT_DEFAULT_HOOKS	label	byte
		db	7Fh,00h
		dw	seg X076_00
		db	39h,00h
		dw	seg X077_00
		db	2Ah,00h
		dw	seg X077_00
		db	3Eh,00h
		dw	seg X077_00
		db	52h,00h
		dw	seg X077_00
		db	2Fh,00h
		dw	seg X077_00
		db	4Dh,00h
		dw	seg X077_00
		db	57h,00h
		dw	seg X077_00
		db	48h,00h
		dw	seg X076_00
		db	5Ch,00h
		dw	seg X077_00
		db	2Ah,00h
		dw	seg X076_00
		db	57h,00h
		dw	seg X076_00
		db	52h,00h
		dw	seg X076_00
		db	25h,00h
		dw	seg X076_00
		db	20h,00h
		dw	seg X077_00
		db	66h,00h
		dw	seg X076_00
		db	61h,00h
		dw	seg X076_00
		db	48h,00h
		dw	seg X077_00
		db	43h,00h
		dw	seg X077_00
		db	5Ch,00h
		dw	seg X076_00
		db	20h,00h
		dw	seg X076_00
		db	6Bh,00h
		dw	seg X076_00
		db	75h,00h
		dw	seg X076_00
		db	7Ah,00h
		dw	seg X076_00

; DS:55B2  used by C107UNIT.C
ASM_OPERAND_FORMAT_MAP	label	byte
		db	00h,01h,05h,07h,09h,0Ah,0Bh

; DS:55B9  used by C107UNIT.C
STR_DEBUG_B	label	byte
		db	09h,3Fh,64h,65h,62h,75h,67h,09h,42h

; DS:55C2  used by C107UNIT.C
STR_DB_LINE_CRLF	label	byte
		db	0Dh,0Ah,00h

; DS:55C5  used by C107UNIT.C
STR_DEBUG_E	label	byte
		db	09h,'?debug',09h,'E',0Dh,0Ah,0
		db	09h,'mov',09h,'bx,sp',0Dh,0Ah,0
		db	09h,'add',09h,'ss:[bx+',0
		db	5Dh,2Ch,00h
		db	0Dh,0Ah,09h,'jmp',09h,'far ptr ',0
		db	0Dh,0Ah,09h,'jmp',09h,'near ptr ',0
		db	'.asm',0
		db	09h,2Eh,32h,38h,36h,0Dh,0Ah,00h,09h,2Eh,32h,38h,37h,0Dh,0Ah,00h
		db	09h,'.286p',0Dh,0Ah,0
		db	09h,'ifndef',09h,'??version',0Dh,0Ah,'?debug',09h,'macro',0Dh,0Ah,09h
		db	'endm',0Dh,0Ah,'publicdll macro',09h,'name',0Dh,0Ah,09h,'public',09h
		db	'name',0Dh,0Ah,09h,'endm',0Dh,0Ah,'$comm',09h,'macro',09h
		db	'name,dist,size,count',0Dh,0Ah,09h,'comm',09h,'dist name:BYTE:count*size'
		db	0Dh,0Ah,09h,'endm',0Dh,0Ah,09h,'else',0Dh,0Ah,'$comm',09h,'macro',09h
		db	'name,dist,size,count',0Dh,0Ah,09h,'comm',09h
		db	'dist name[size]:BYTE:count',0Dh,0Ah,09h,'endm',0Dh,0Ah,09h,'endif',0Dh
		db	0Ah,09h,'?debug',09h,'S "',0
		db	22h,0Dh,0Ah,00h
		db	09h,'group',09h,0
		db	09h,'assume',09h,'cs:',0
		db	',ds:',0
		db	'd@',09h,'label',09h,'byte',0Dh,0Ah,'d@w',09h,'label',09h,'word',0Dh,0Ah
		db	0
		db	'b@',09h,'label',09h,'byte',0Dh,0Ah,'b@w',09h,'label',09h,'word',0Dh,0Ah
		db	0
		db	09h,'?debug',09h,'C E9',0Dh,0Ah,0
		db	's@',09h,'label',09h,'byte',0Dh,0Ah,0

; DS:57AC  used by C107UNIT.C
STR_DB	label	byte
		db	09h,'db',09h,0
		db	09h,'extrn',09h,'DGROUP@:word',0Dh,0Ah,0
		db	09h,'extrn',09h,'__turboFloat:word',0Dh,0Ah,0
		db	09h,65h,6Eh,64h,0Dh,0Ah,1Ah,00h
		db	09h,'jmp',09h,'word ptr cs:@',0
		db	40h,43h,00h
		db	'[bx]',0Dh,0Ah,0
		db	09h,'mov',09h,'bx,offset ',0
		db	09h,'mov',09h,0
		db	',cs:DGROUP@',0Dh,0Ah,0
		db	09h,'jmp',09h,'word ptr cs:[bx+',0

; DS:5841  used by C107UNIT.C
STR_MOV_CX_OFFSET_7_PUSH	label	byte
		db	09h,'mov',09h,'cx,offset $+7',0Dh,0Ah,09h,'push',09h,'cx',0Dh,0Ah,0

; DS:5860  used by C107UNIT.C
STR_PUSH_OFFSET_6	label	byte
		db	09h,'push',09h,'offset $+6',0Dh,0Ah,0
		db	09h,'?debug',09h,'C ',0
		db	'+',0Dh,0Ah,09h,'?debug',09h,'C ',0
		db	'push',09h,'cs',0Dh,0Ah,09h,'call',09h,0
		db	'db',09h,'0cbh',0Dh,0Ah,0
		db	'FCOMPP',0Dh,0Ah,0
		db	'P',09h,'st(',0
		db	'),st( 0 )',0Dh,0Ah,0
		db	'st(0),st(',0
		db	2Ch,30h,0Dh,0Ah,00h
		db	'ax,ax,',0
		db	29h,00h
		db	'seg ',0
		db	'byte',0
		db	'qword',0
		db	'dword',0
		db	'tbyte',0
		db	'far',0
		db	'near',0
		db	09h,'comm',09h,0
		db	'far ',0
		db	'near ',0
		db	09h,'$comm',09h,0
		db	'far,',0
		db	6Eh,65h,61h,72h,2Ch

; DS:5922  used by C102UNIT.C, C107UNIT.C, C218UNIT.C, C56UNIT.C, C56UNIT.H
ASM_TYPE_NAME_TABLE	label	byte
		db	00h,00h

; DS:5924  used by C102UNIT.C, C107UNIT.C, C218UNIT.C, C56UNIT.C, C56UNIT.H
DEBUG_STATE	label	byte
		db	0FFh,0FFh,7Ah,59h
		dw	seg BCC_SEG_180
		db	7Ah,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	84h,59h
		dw	seg BCC_SEG_180
		db	8Ah,59h
		dw	seg BCC_SEG_180
		db	8Ah,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	84h,59h
		dw	seg BCC_SEG_180
		db	84h,59h
		dw	seg BCC_SEG_180
		db	00h,00h,00h,00h,90h,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	7Fh,59h
		dw	seg BCC_SEG_180
		db	'byte',0
		db	'word',0
		db	'dword',0
		db	'qword',0
		db	'far',0
		db	09h,'segment ',0
		db	'para',0
		db	' public ',0
		db	0Dh,0Ah,00h
		db	09h,'segment',09h,'virtual',0Dh,0Ah,0
		db	09h,'db',09h,0
		db	' dup (0)',0Dh,0Ah,0
		db	' dup (?)',0Dh,0Ah,0
		db	09h,'assume',09h,'cs:',0
		db	09h,'proc',09h,0
		db	'near',0
		db	09h,'label',09h,0

; DS:59FD  used by C102UNIT.C
STR_ENDP	label	byte
		db	09h,'endp',0Dh,0Ah,0
		db	09h,'dw',09h,0
		db	09h,'dd',09h,0
		db	40h,43h,00h
		db	09h,'label',09h,'word',0Dh,0Ah,0

; DS:5A20  used by C102UNIT.C
STR_ENDS	label	byte
		db	09h,'ends',0Dh,0Ah,0

; DS:5A28  used by C214UNIT.C, C240UNIT.C, C9INIT.C, C9INIT.H
INTRINSIC_TABLE	label	byte
		db	78h,5Ah,0Ch,00h,01h,00h,05h,00h,00h,00h,80h,5Ah,05h,00h,01h,00h
		db	05h,00h,00h,00h,88h,5Ah,0Ch,00h,02h,00h,05h,02h,00h,00h,95h,5Ah
		db	02h,00h,01h,00h,05h,00h,00h,00h,0A1h,5Ah,0Ch,00h,02h,00h,05h,06h
		db	00h,00h,0AEh,5Ah,06h,00h,01h,00h,05h,00h,00h,00h,0BAh,5Ah,0Ch,00h
		db	0FFh
		db	15 dup (0)
		db	'__int__',0
		db	'__abs__',0
		db	'__outportb__',0
		db	'__inportb__',0
		db	'__outportw__',0
		db	'__inportw__',0

; DS:5ABA  used by C214UNIT.C
STR_EMIT	label	byte
		db	'__emit__',0
		db	00h
		db	'FIARQQ',0
		db	'FJARQQ',0
		db	'FIERQQ',0
		db	'FISRQQ',0
		db	'FJSRQQ',0
		db	'FICRQQ',0
		db	'FJCRQQ',0
		db	'FIDRQQ',0
		db	01h,00h,00h,00h,0Ah,00h,00h,00h,64h,00h,00h,00h,0E8h,03h,00h,00h
		db	10h,27h,00h,00h,0A0h,86h,01h,00h,40h,42h,0Fh,00h,80h,96h,98h,00h
		db	00h,00h,00h,00h,00h,20h,0BCh,0BEh,19h,40h,00h,00h,00h,04h,0BFh,0C9h
		db	1Bh,8Eh,34h,40h,9Eh,0B5h,70h,2Bh,0A8h,0ADh,0C5h,9Dh,69h,40h,0D5h,0A6h
		db	0CFh,0FFh,49h,1Fh,78h,0C2h,0D3h,40h,0E0h,8Ch,0E9h,80h,0C9h,47h,0BAh,93h
		db	0A8h,41h,8Eh,0DEh,0F9h,9Dh,0FBh,0EBh,7Eh,0AAh,51h,43h,0C7h,91h,0Eh,0A6h
		db	0AEh,0A0h,19h,0E3h,0A3h,46h,17h,0Ch,75h,81h,86h,75h,76h,0C9h,48h,4Dh
		db	0E5h,5Dh,3Dh,0C5h,5Dh,3Bh,8Bh,9Eh,92h,5Ah,9Bh,97h,20h,8Ah,02h,52h
		db	60h,0C4h,25h,75h

; DS:5B80  used by C114UNIT.C, C128UNIT.C, C129UNIT.C, C130UNIT.C, C226UNIT.C, C238UNIT.C, 8 more
_CTYPE	label	byte
		db	00h

; DS:5B81  used by C218UNIT.C
CTYPE_BY_CHAR	label	byte
		db	20h,20h,20h,20h,20h,20h,20h,20h,20h,21h,21h,20h,20h,20h,20h,20h
		db	20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
		db	01h
		db	15 dup (0)
		db	02h,02h,02h,02h,02h,02h,02h,02h,02h,02h,00h,00h,00h,00h,00h,00h
		db	00h,14h,14h,14h,14h,14h,14h,04h,04h,04h,04h,04h,04h,04h,04h,04h
		db	04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,00h,00h,00h,00h,00h
		db	00h,18h,18h,18h,18h,18h,18h,08h,08h,08h,08h,08h,08h,08h,08h,08h
		db	08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,00h,00h,00h,00h,20h
		db	129 dup (0)

; DS:5C82  used by DVPRINTF.C: the digits of LONG_MIN for %ld
LONG_MIN_DIGITS	label	byte
		db	32h,31h,34h,37h,34h,38h,33h,36h,34h,38h,00h,00h

; DS:5C8E  used by SEARCHP.C
SEARCH_PATH_NAME	label	byte
		db	50h,41h

_DATA	ends
; END LG05A
		end
