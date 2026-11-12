DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_7
; BEGIN R7MAIN (listing CODE_7:0009)

		extrn	BCC_FAR_5B44:far
		extrn	X058_03:far
		extrn	X059_00:far
		extrn	X062_00:far
		extrn	X073_00:far
X058_00	equ	X058_03+0BBh
X058_01	equ	X058_03+67h
X058_02	equ	X058_03-0D9h
X058_04	equ	X058_03
X059_03	equ	X059_00+1831h
X059_04	equ	X059_00
X059_05	equ	X059_00+17BEh
X062_0A	equ	X062_00-819h
X062_0E	equ	X062_00-668h
X062_0F	equ	X062_00-936h
X073_01	equ	X073_00


CODE7	segment byte public 'CODE'
		assume	cs:CODE7,ds:DGROUP

M000_BCC_DATA_16F0	equ	16F0h
M000_BCC_DATA_1712	equ	1712h
M000_BCC_DATA_8118	equ	8118h
M000_BCC_DATA_814C	equ	814Ch
M000_BCC_DATA_8186	equ	8186h
M000_BCC_DATA_8680	equ	8680h
M000_BCC_DATA_8698	equ	8698h
M000_BCC_DATA_86FB	equ	86FBh
		public	BCC_FAR_5F79

BCC_FAR_5F79	proc	far
		push	BP
		mov	BP,SP
		sub	SP,1Ch
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],35h
		jne	short M000_L_5F95
		push	SI
		db	0E8h
		dw	01114h
		db	0E9h
		dw	010A5h
M000_L_5F95:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],7
		jle	short M000_L_6008
		cmp	word ptr ES:[SI],2Dh
		jg	short M000_L_6008
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_5FD8
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		jmp	short M000_L_602B
M000_L_5FD8:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		jmp	short M000_L_602B
M000_L_6008:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Dh
		jle	short M000_L_602B
		cmp	word ptr ES:[SI],32h
		jg	short M000_L_602B
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
M000_L_602B:
		xor	AX,AX
		mov	word ptr [BP-12h],AX
		mov	word ptr [BP-14h],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		mov	DX,15h
		imul	DX
		add	AX,word ptr ES:[SI+2]
		mov	BX,AX
		mov	AL,byte ptr [BX+39B8h]
		mov	AH,0
		dec	AX
		dec	AX
		mov	BX,AX
		cmp	BX,31h
		ja	short M000_L_605B
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	10D2h
M000_L_605B:
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		test	word ptr ES:[SI+4],10h
		je	short M000_L_60CD
		mov	AX,0Dh
		push	AX
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Eh],AX
		mov	AX,0Ch
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		xor	AX,AX
		push	AX
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+5020h]
		mov	AH,0
		add	AX,15h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00F67h
M000_L_60CD:
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00F44h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		test	word ptr ES:[SI+4],10h
		je	short M000_L_615E
		mov	AX,0Dh
		push	AX
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Eh],AX
		mov	AX,0Ch
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		xor	AX,AX
		push	AX
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	AX,1Bh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		mov	AX,16h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00ED6h
M000_L_615E:
		mov	AX,11h
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,word ptr ES:[SI+0Ch]
		inc	AX
		inc	AX
		push	AX
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-12h],AX
		mov	AX,10h
		push	AX
		mov	BX,word ptr [BP-12h]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		push	word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00E91h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		db	0FFh,01Eh
		dw	8118h
		mov	word ptr [BP-0Eh],AX
		mov	AX,1
		mov	CL,byte ptr [BP-0Eh]
		shl	AX,CL
		or	word ptr DGROUP:M000_BCC_DATA_86FB,AX
		cmp	word ptr [BP-0Eh],-1
		jne	short M000_L_61DA
		mov	AX,73h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00E5Ah
M000_L_61DA:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],2
		jg	short M000_L_61FD
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00E37h
M000_L_61FD:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00E1Fh
		mov	AX,0Dh
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-14h],AX
		mov	AX,0Ch
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		xor	AX,AX
		push	AX
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00DE3h
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	word ptr ES:[SI+0Ah]
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00DC5h
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	word ptr ES:[SI+0Ah]
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00D93h
		push	SI
		db	09Ah
		dw	X062_0E
		dw	seg X062_0E
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00D87h
		mov	AX,0Dh
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-14h],AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Fh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00D51h
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00D36h
		mov	AX,1Dh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,24h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00D09h
		push	SI
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X062_0F
		dw	seg X062_0F
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00CF7h
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00CDCh
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		cmp	word ptr [BP-6],0
		je	short M000_L_637F
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00CB5h
M000_L_637F:
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00CACh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+2],10h
		jne	short M000_L_63AB
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
		mov	word ptr [BP-16h],AX
		mov	word ptr [BP-18h],DX
		mov	AX,word ptr [BP-0Ah]
		mov	DX,word ptr [BP-0Ch]
		jmp	short M000_L_63CB
M000_L_63AB:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AL,byte ptr ES:[SI+6]
		neg	AL
		mov	byte ptr ES:[SI+6],AL
		mov	AX,word ptr [BP-0Ah]
		mov	DX,word ptr [BP-0Ch]
		mov	word ptr [BP-16h],AX
		mov	word ptr [BP-18h],DX
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
M000_L_63CB:
		mov	word ptr [BP-1Ah],AX
		mov	word ptr [BP-1Ch],DX
		cmp	byte ptr DGROUP:M000_BCC_DATA_1712,0
		jne	short M000_L_63DB
		db	0E9h
		dw	000FCh
M000_L_63DB:
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Eh],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],8
		jne	short M000_L_6467
		mov	AX,1Dh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-1Ch]
		push	word ptr [BP-18h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,24h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-1Ah]
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,0Dh
		push	AX
		mov	AX,3F5Ch
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,1Fh
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-16h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00BCDh
M000_L_6467:
		mov	AX,26h
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-18h]
		push	word ptr [BP-1Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,24h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-1Ah]
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,0Dh
		push	AX
		mov	AX,3F5Ch
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,28h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-16h]
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00B5Dh
M000_L_64D7:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_6503
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-18h]
		push	word ptr [BP-16h]
		jmp	short M000_L_6522
M000_L_6503:
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-18h]
		push	word ptr [BP-16h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Ah]
M000_L_6522:
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],8
		jne	short M000_L_6536
		mov	AX,3F66h
		jmp	short M000_L_6539
M000_L_6536:
		mov	AX,3F6Ch
M000_L_6539:
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00ACAh
		mov	AX,26h
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,30h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00A9Dh
		cmp	byte ptr DGROUP:M000_BCC_DATA_16F0,0
		jne	short M000_L_65BB
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	byte ptr ES:[SI+6],0
		jle	short M000_L_65BB
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Eh],AX
		mov	AX,word ptr [BP-0Ch]
		mov	word ptr [BP-8],AX
		mov	AX,word ptr [BP-0Eh]
		mov	word ptr [BP-0Ch],AX
M000_L_65BB:
		mov	AX,32h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00A61h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_65FF
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		jmp	short M000_L_661E
M000_L_65FF:
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
M000_L_661E:
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		push	SI
		db	09Ah
		dw	X059_03
		dw	seg X059_03
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	009E4h
		mov	AX,0ACh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	009B7h
		mov	AX,0B5h
		push	AX
		mov	AL,10h
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,3Fh
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00980h
		mov	AX,0B5h
		push	AX
		mov	AL,10h
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,41h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00949h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_6717
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0BDh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		jmp	short M000_L_6736
M000_L_6717:
		mov	AX,0BDh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
M000_L_6736:
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		push	SI
		db	09Ah
		dw	X059_03
		dw	seg X059_03
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	008CCh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+5036h]
		mov	AH,0
		add	AX,48h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	008A6h
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00873h
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00858h
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	0082Bh
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X062_0A
		dw	seg X062_0A
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	0081Ah
		mov	AX,1Dh
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,24h
		push	AX
		mov	AL,22h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	007EDh
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	007BAh
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	00799h
		cmp	byte ptr DGROUP:M000_BCC_DATA_1712,0
		jne	short M000_L_68A5
		db	0E9h
		dw	000A6h
M000_L_68A5:
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Eh],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],13h
		jne	short M000_L_68DB
		mov	AX,1Dh
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,24h
		jmp	short M000_L_68F3
M000_L_68DB:
		mov	AX,26h
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,30h
M000_L_68F3:
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,0Dh
		push	AX
		mov	AX,3F5Ch
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,1Fh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-6]
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	006E9h
M000_L_694B:
		cmp	word ptr [BP-6],0
		jne	short M000_L_6967
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Dh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-6],AX
M000_L_6967:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_6993
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		jmp	short M000_L_69B2
M000_L_6993:
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
M000_L_69B2:
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],14h
		jne	short M000_L_69C6
		mov	AX,3F72h
		jmp	short M000_L_69C9
M000_L_69C6:
		mov	AX,3F78h
M000_L_69C9:
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	0063Ah
		mov	AX,26h
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,30h
		push	AX
		mov	AL,22h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	0060Dh
		mov	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	005B8h
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	00563h
		mov	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,0ABh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	004F9h
		mov	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,0ABh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,30h
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		mov	AX,1
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	00479h
		mov	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,0AAh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,3Eh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	00412h
		mov	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,0AAh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,3Eh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		mov	AX,1
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-8]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FBh
		db	0E9h
		dw	00395h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+5036h]
		mov	AH,0
		add	AX,48h
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	0036Fh
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
		mov	word ptr [BP-12h],AX
		mov	word ptr [BP-14h],DX
		db	0E9h
		dw	00360h
		mov	AX,word ptr [BP-0Ah]
		mov	DX,word ptr [BP-0Ch]
		mov	word ptr [BP-12h],AX
		mov	word ptr [BP-14h],DX
		db	0E9h
		dw	00351h
		mov	AX,28h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00339h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+2],10h
		je	short M000_L_6D0D
		db	0E9h
		dw	0008Ch
M000_L_6D0D:
		cmp	byte ptr ES:[SI+6],0
		jge	short M000_L_6D35
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		jmp	short M000_L_6D54
M000_L_6D35:
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
M000_L_6D54:
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		cmp	byte ptr DGROUP:M000_BCC_DATA_1712,0
		je	short M000_L_6D65
		mov	AX,3F7Eh
		jmp	short M000_L_6D68
M000_L_6D65:
		mov	AX,3F84h
M000_L_6D68:
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-14h],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	0029Bh
M000_L_6D99:
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Eh],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,26h
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,30h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-0Eh]
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	0024Dh
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-12h],AX
		mov	AX,word ptr [BP-0Ch]
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	0023Eh
		push	SI
		db	09Ah
		dw	X073_01
		dw	seg X073_01
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00223h
		mov	AX,51h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-10h],AX
		mov	AX,51h
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,30h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-10h]
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	001D2h
		mov	AX,52h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	001BAh
		mov	AX,54h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		mov	AX,54h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-12h],AX
		db	0E9h
		dw	0018Dh
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Eh],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+2],2
		jg	short M000_L_6ED1
		mov	AX,0ABh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
M000_L_6ED1:
		mov	AX,51h
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,30h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Eh],AX
		mov	AX,59h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	00121h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ah]
		mov	word ptr [BP-2],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Fh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-4],AX
		mov	AX,0Dh
		push	AX
		mov	BX,word ptr [BP-4]
		push	word ptr ES:[BX+0Ah]
		push	word ptr ES:[BX+0Ch]
		mov	AL,byte ptr ES:[BX+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-8],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Dh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-2],AX
		mov	AX,0Dh
		push	AX
		mov	BX,word ptr [BP-2]
		push	word ptr ES:[BX+0Ah]
		push	word ptr ES:[BX+0Ch]
		mov	AL,byte ptr ES:[BX+4]
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Ch],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		push	word ptr ES:[BX+0Ch]
		push	word ptr ES:[BX+0Ah]
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Eh],AX
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,3F8Ah
		push	AX
		mov	AX,1040h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0AEh
		push	AX
		xor	AX,AX
		mov	DX,8
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		jmp	short M000_L_7034
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M000_L_7034:
		mov	DX,word ptr [BP-12h]
		mov	AX,word ptr [BP-14h]
M000_L_703A:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_5F79	endp
CODE7	ends

CODE7	segment byte public 'CODE'
		assume	cs:CODE7

		public	BCC_TABLE_7042
BCC_TABLE_7042	label	word
		dw	000F6h
		dw	00180h
		dw	00233h
		dw	002A5h
		dw	002E1h
		dw	002FFh
		dw	00331h
		dw	0033Dh
		dw	00373h
		dw	0038Eh
		dw	003BBh
		dw	003CDh
		dw	003E8h
		dw	00418h
		dw	005FAh
		dw	00627h
		dw	00663h
		dw	006E0h
		dw	0070Dh
		dw	00744h
		dw	0077Bh
		dw	007F8h
		dw	0081Eh
		dw	00851h
		dw	0086Ch
		dw	00899h
		dw	008AAh
		dw	008D7h
		dw	0090Ah
		dw	0092Bh
		dw	00A8Ah
		dw	00AB7h
		dw	00B0Ch
		dw	00B61h
		dw	00BCBh
		dw	00C4Bh
		dw	00CB2h
		dw	00D2Fh
		dw	00D55h
		dw	00D64h
		dw	00D73h
		dw	00D8Bh
		dw	00E77h
		dw	00E86h
		dw	00EA1h
		dw	00EF2h
		dw	00F0Ah
		dw	00F37h
		dw	00FA3h
		dw	010B9h

CODE7	ends
; END R7MAIN
; BEGIN R7HELP (listing CODE_7:1136)

X059_06	equ	X059_00+0CACh
X062_13	equ	X062_00-323h


CODE7	segment byte public 'CODE'
		assume	cs:CODE7,ds:DGROUP

M002_BCC_DATA_16F4	equ	16F4h
M002_BCC_DATA_8104	equ	8104h
M002_BCC_DATA_8186	equ	8186h
		public	BCC_NEAR_70A6

BCC_NEAR_70A6	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr ES:[SI+0Ah]
		mov	AX,word ptr ES:[BX+2]
		mov	word ptr [BP-2],AX
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_04
		dw	seg X059_04
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		xor	AX,AX
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-0Ch],AX
		mov	AX,word ptr [BP-2]
		mov	DX,11h
		imul	DX
		add	AX,word ptr [BP-4]
		mov	BX,AX
		mov	AL,byte ptr [BX+3E3Bh]
		mov	AH,0
		dec	AX
		mov	BX,AX
		cmp	BX,18h
		ja	short M002_L_7105
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	17B2h
M002_L_7105:
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-0Ch],DX
		db	0E9h
		dw	005F4h
		cmp	byte ptr DGROUP:M002_BCC_DATA_16F4,0
		je	short M002_L_7135
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-0Ch],DX
		db	0E9h
		dw	005DEh
M002_L_7135:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		add	AX,61h
		push	AX
		mov	AL,2
		push	AX
		push	word ptr ES:[SI+2]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		push	word ptr ES:[SI+2]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	005A4h
		mov	AX,0ABh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	0058Ch
		mov	AX,0ABh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-8],AX
		mov	AX,0ACh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ah],AX
		db	0E9h
		dw	0054Dh
		mov	AX,0ABh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-8],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Ch
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	004FAh
		mov	AX,0AAh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	004E2h
		mov	AX,0AAh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-8],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	004B2h
		mov	AX,0AAh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-8],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Ch
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	0045Fh
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	00456h
		mov	AX,0ACh
		push	AX
		mov	AL,10h
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ah],AX
		db	0E9h
		dw	0042Ch
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Ch
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	003EEh
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Dh
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,7
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	00384h
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	00369h
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Dh
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,7
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	002FFh
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	002F6h
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	002EDh
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Dh
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,7
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	00292h
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,6
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Eh
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	001DFh
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+8]
		db	0FFh,01Eh
		dw	8104h
		push	AX
		db	09Ah
		dw	X059_06
		dw	seg X059_06
		cbw
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	001ACh
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+8]
		db	0FFh,01Eh
		dw	8104h
		push	AX
		db	09Ah
		dw	X059_06
		dw	seg X059_06
		cbw
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		mov	AX,6
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		push	DI
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,5Eh
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X062_13
		dw	seg X062_13
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	000D2h
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-0Ah],AX
		db	0E9h
		dw	000B7h
		mov	AX,0B4h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,3F91h
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		db	0E9h
		dw	00083h
		mov	AX,0B4h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,3F91h
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		jmp	short M002_L_7713
		mov	AX,0B4h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_02
		dw	seg X058_02
		mov	AX,3F91h
		push	AX
		mov	AX,1055h
		push	AX
		db	09Ah
		dw	X059_05
		dw	seg X059_05
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ah],AX
		jmp	short M002_L_7713
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M002_L_7713:
		mov	DX,word ptr [BP-0Ah]
		mov	AX,word ptr [BP-0Ch]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_70A6	endp
CODE7	ends

CODE7	segment byte public 'CODE'
		assume	cs:CODE7

		public	BCC_TABLE_7722
BCC_TABLE_7722	label	word
		dw	011A0h
		dw	011AFh
		dw	011FFh
		dw	01217h
		dw	01256h
		dw	012A9h
		dw	012C1h
		dw	012F1h
		dw	01344h
		dw	0134Dh
		dw	01377h
		dw	013B5h
		dw	0141Fh
		dw	0143Ah
		dw	014A4h
		dw	014ADh
		dw	014B6h
		dw	01511h
		dw	015C4h
		dw	015F7h
		dw	016D1h
		dw	016ECh
		dw	01720h
		dw	01753h
		dw	01798h

CODE7	ends
; END R7HELP
		end
