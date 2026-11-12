		public	X06A_08
		public	X06A_09
		public	X06A_00
		public	X06A_01
		public	X06A_02
		public	X06A_03
		public	X06A_04
		public	X06A_05
		public	X06A_06
		public	X06A_07
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dad_add3
; BEGIN C116UNIT (listing ovr_1dad_add3:DD30)

		extrn	X00A_01:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M000_BCC_EXPR_SEGMENT	equ	639Ah
M000_BCC_DATA_8186	equ	8186h

BCC_NEAR_DD30	label	near
STAOV11D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX]
		test	byte ptr [BX+9CAh],14h
		je	short M000_L_DD90
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+2],20h
		je	short M000_L_DD90
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+7]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	word ptr ES:[SI+8],AX
M000_L_DD90:
		mov	AX,SI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV11D	endp
CO06A_TEXT	ends


		extrn	X00A_01:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M001_BCC_EXPR_SEGMENT	equ	639Ah
M001_BCC_DATA_8186	equ	8186h

		public	X06A_03
X06A_03	label	far
BCC_NEAR_DD98	label	near
STAOV11E	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX]
		test	byte ptr [BX+9CAh],14h
		je	short M001_L_DE1C
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+2]
		mov	AH,0
		test	AX,20h
		jne	short M001_L_DE1C
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		push	word ptr ES:[DI+7]
		push	word ptr ES:[DI]
		mov	AL,1
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	word ptr ES:[SI+8],AX
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[DI+0Dh]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	byte ptr ES:[BX+0Dh],AL
		mov	AX,word ptr ES:[DI+9]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	word ptr ES:[BX+9],AX
M001_L_DE1C:
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		retf	2
STAOV11E	endp
CO06A_TEXT	ends


		extrn	X007_08:far
		extrn	X023_1D:far
		extrn	X023_09:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M002_BCC_EXPR_SEGMENT	equ	639Ah
M002_BCC_DATA_6410	equ	6410h
M002_BCC_DATA_8186	equ	8186h

		public	X06A_06
X06A_06	label	far
STAOV11F	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		jne	short M002_L_DE34
		db	0E9h
		dw	000C3h
M002_L_DE34:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M002_L_DE64
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_6410
		mov	AL,byte ptr ES:[BX+7]
		mov	AH,0
		sar	AX,1
		sar	AX,1
		sar	AX,1
		cmp	AX,0Eh
		jne	short M002_L_DE64
		mov	AX,54h
		push	AX
		push	SI
		db	09Ah
		dw	X023_09
		dw	seg X023_09
		db	0E9h
		dw	00095h
M002_L_DE64:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX]
		test	byte ptr [BX+9CAh],14h
		je	short M002_L_DEF7
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+2],20h
		je	short M002_L_DEF7
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX]
		test	byte ptr [BX+9CAh],14h
		je	short M002_L_DEB9
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+7]
		cmp	word ptr ES:[BX],12h
		je	short M002_L_DEF7
M002_L_DEB9:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI],32h
		jne	short M002_L_DEEF
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+7]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	AX,word ptr ES:[BX+8]
		jne	short M002_L_DEEF
		mov	AX,word ptr ES:[SI+0Ah]
		mov	word ptr [BP-2],AX
		push	SI
		db	09Ah
		dw	X023_1D
		dw	seg X023_1D
		mov	SI,word ptr [BP-2]
		jmp	short M002_L_DEF7
M002_L_DEEF:
		push	SI
		db	09Ah
		dw	X007_08
		dw	seg X007_08
		mov	SI,AX
M002_L_DEF7:
		mov	AX,SI
M002_L_DEF9:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV11F	endp
CO06A_TEXT	ends



		extrn	X00A_01:far
		extrn	X023_0E:far
		extrn	X023_12:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

BCC_NEAR_DF00	label	near
STAOV120	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	word ptr [BP+6]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		mov	word ptr [BP-2],AX
		mov	AX,18h
		push	AX
		push	word ptr [BP-2]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X023_0E
		dw	seg X023_0E
		mov	SP,BP
		pop	BP
		retf	2
STAOV120	endp
CO06A_TEXT	ends


		extrn	X023_12:far
		extrn	X023_05:far
		extrn	X023_07:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M004_BCC_DATA_5EC8	equ	5EC8h
M004_BCC_DATA_63FC	equ	63FCh
M004_BCC_DATA_8186	equ	8186h

BCC_NEAR_DF3D	label	near
STAOV121	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	DI,word ptr [BP+6]
		push	word ptr DGROUP:M004_BCC_DATA_63FC
		push	DI
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		mov	DI,AX
		cmp	word ptr [BP+8],0
		je	short M004_L_DF78
		mov	AX,16h
		push	AX
		push	DI
		push	word ptr DGROUP:M004_BCC_DATA_5EC8
		mov	AX,word ptr [BP+8]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X023_07
		dw	seg X023_07
		push	AX
		db	09Ah
		dw	X023_05
		dw	seg X023_05
		mov	DI,AX
M004_L_DF78:
		or	SI,SI
		jne	short M004_L_DF80
		mov	AX,DI
		jmp	short M004_L_DFA5
M004_L_DF80:
		mov	word ptr [BP-2],SI
		jmp	short M004_L_DF8D
M004_L_DF85:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		mov	SI,word ptr ES:[SI+0Ah]
M004_L_DF8D:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		cmp	word ptr ES:[SI],35h
		jne	short M004_L_DF85
		cmp	word ptr ES:[SI+0Ah],0
		jne	short M004_L_DF85
		mov	word ptr ES:[SI+0Ah],DI
		mov	AX,word ptr [BP-2]
M004_L_DFA5:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
STAOV121	endp
CO06A_TEXT	ends




CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M005_BCC_DATA_0002	equ	2
M005_BCC_DATA_5F3E	equ	5F3Eh
M005_BCC_EXPR_SEGMENT	equ	639Ah
M005_BCC_DATA_6408	equ	6408h

BCC_NEAR_DFAD	label	near
STAOV122	proc	far
M005_L_DFAD:
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+14h]
		les	BX,[BP+6]
		mov	byte ptr ES:[BX],0
		cmp	word ptr [BP+12h],DI
		jne	short M005_L_DFC4
		db	0E9h
		dw	000BCh
M005_L_DFC4:
		mov	BX,word ptr [BP+12h]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+5]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_5F3E
		mov	SI,word ptr ES:[BX+0Ch]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		db	026h,089h,03Eh,2,0
		jmp	short M005_L_E011
M005_L_DFE2:
		push	DI
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		push	word ptr ES:[SI+2]
		push	word ptr [BP+10h]
		push	word ptr [BP+0Eh]
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FFACh
		les	BX,[BP+6]
		cmp	byte ptr ES:[BX],0
		jne	short M005_L_E027
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		mov	SI,word ptr ES:[SI]
M005_L_E011:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+5]
		cmp	AX,word ptr ES:[DI+5]
		jne	short M005_L_DFE2
M005_L_E027:
		or	SI,SI
		jne	short M005_L_E034
		les	BX,[BP+6]
		mov	byte ptr ES:[BX],0
		jmp	short M005_L_E087
M005_L_E034:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		cmp	byte ptr ES:[SI+7],0
		je	short M005_L_E06A
		les	BX,[BP+0Ah]
		push	word ptr ES:[BX]
		les	BX,[BP+0Eh]
		push	word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		push	word ptr ES:[SI+2]
		push	CS
		db	0E8h
		dw	0FEA9h
		push	AX
		push	CS
		db	0E8h
		dw	0FEE1h
		les	BX,[BP+0Ah]
		mov	word ptr ES:[BX],AX
		les	BX,[BP+0Eh]
		mov	word ptr ES:[BX],0
M005_L_E06A:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_6408
		push	ES
		les	BX,[BP+0Eh]
		mov	AX,word ptr ES:[BX]
		pop	ES
		add	AX,word ptr ES:[SI+4]
		mov	ES,word ptr [BP+10h]
		mov	word ptr ES:[BX],AX
M005_L_E080:
		les	BX,[BP+6]
		mov	byte ptr ES:[BX],1
M005_L_E087:
		pop	DI
		pop	SI
		pop	BP
		retf	10h
STAOV122	endp
CO06A_TEXT	ends


		extrn	X003_02:far
		extrn	X007_0C:far
		extrn	X00A_01:far
		extrn	X023_0C:far
		extrn	X023_0F:far
		extrn	X023_1B:far
		extrn	X023_1E:far
		extrn	X023_12:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M006_BCC_DATA_63FC	equ	63FCh

		public	X06A_09
X06A_09	label	far
STAOV123	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ch]
		mov	DI,word ptr [BP+0Ah]
		cmp	DI,word ptr [BP+0Eh]
		jne	short M006_L_E0A3
		db	0E9h
		dw	00123h
M006_L_E0A3:
		cmp	byte ptr [BP+8],0
		je	short M006_L_E0AD
		mov	byte ptr [BP+6],0
M006_L_E0AD:
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],0
		push	DI
		or	SI,SI
		jne	short M006_L_E0C1
		mov	AX,word ptr [BP+0Eh]
		jmp	short M006_L_E0C3
M006_L_E0C1:
		mov	AX,SI
M006_L_E0C3:
		push	AX
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FED6h
		or	SI,SI
		je	short M006_L_E0F2
		push	SI
		push	word ptr [BP+0Eh]
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FEBBh
M006_L_E0F2:
		cmp	word ptr [BP-2],0
		jne	short M006_L_E101
		cmp	word ptr [BP-4],0
		jne	short M006_L_E101
		db	0E9h
		dw	000A6h
M006_L_E101:
		push	word ptr [BP+10h]
		db	0E8h
		dw	0FC29h
		mov	word ptr [BP+10h],AX
		mov	word ptr [BP-0Ah],0
		cmp	byte ptr [BP+6],0
		je	short M006_L_E124
		push	SS
		lea	AX,[BP+10h]
		push	AX
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		db	09Ah
		dw	X023_1B
		dw	seg X023_1B
M006_L_E124:
		push	word ptr [BP-4]
		push	word ptr [BP-2]
		push	word ptr [BP+10h]
		push	CS
		db	0E8h
		dw	0FE0Ch
		mov	word ptr [BP-8],AX
		cmp	byte ptr [BP+6],0
		je	short M006_L_E165
		mov	AX,20h
		push	AX
		push	word ptr [BP+10h]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		push	word ptr [BP-8]
		push	word ptr DGROUP:M006_BCC_DATA_63FC
		push	word ptr [BP+10h]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X023_0F
		dw	seg X023_0F
		mov	word ptr [BP-8],AX
M006_L_E165:
		push	word ptr [BP-0Ah]
		push	DI
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		push	AX
		push	word ptr [BP-8]
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		mov	word ptr [BP+10h],AX
		push	word ptr [BP+10h]
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		mov	word ptr [BP+10h],AX
		cmp	byte ptr [BP+8],0
		je	short M006_L_E1C6
		push	word ptr [BP+10h]
		push	CS
		db	0E8h
		dw	0FBF6h
		mov	word ptr [BP+10h],AX
		jmp	short M006_L_E1C6
M006_L_E1A7:
		push	DI
		xor	AX,AX
		push	AX
		mov	AL,byte ptr [BP+8]
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		push	AX
		push	word ptr [BP+10h]
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X007_0C
		dw	seg X007_0C
		mov	word ptr [BP+10h],AX
M006_L_E1C6:
		mov	AX,word ptr [BP+10h]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	0Ch
STAOV123	endp
CO06A_TEXT	ends


		extrn	X003_02:far
		extrn	X007_0C:far
		extrn	X00A_01:far
		extrn	X023_0C:far
		extrn	X023_0F:far
		extrn	X023_1B:far
		extrn	X023_1E:far
		extrn	X023_12:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M007_BCC_DATA_63FC	equ	63FCh

		public	X06A_01
X06A_01	label	far
STAOV124	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],0
		push	word ptr [BP+0Ah]
		push	SI
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FDB0h
		cmp	word ptr [BP-2],0
		jne	short M007_L_E206
		db	0E9h
		dw	0009Bh
M007_L_E206:
		push	word ptr [BP+0Ch]
		db	0E8h
		dw	0FB24h
		mov	word ptr [BP+0Ch],AX
		push	SS
		lea	AX,[BP+0Ch]
		push	AX
		push	SS
		lea	AX,[BP-8]
		push	AX
		db	09Ah
		dw	X023_1B
		dw	seg X023_1B
		xor	AX,AX
		push	AX
		mov	AX,word ptr [BP-2]
		neg	AX
		push	AX
		push	word ptr [BP+0Ch]
		push	CS
		db	0E8h
		dw	0FD0Fh
		mov	DI,AX
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		or	AX,AX
		jne	short M007_L_E261
		mov	AX,20h
		push	AX
		push	word ptr [BP+0Ch]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		push	DI
		push	word ptr DGROUP:M007_BCC_DATA_63FC
		push	word ptr [BP+0Ch]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X023_0F
		dw	seg X023_0F
		mov	DI,AX
M007_L_E261:
		push	word ptr [BP-8]
		push	SI
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		push	AX
		push	DI
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		mov	word ptr [BP+0Ch],AX
		push	word ptr [BP+0Ch]
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		mov	word ptr [BP+0Ch],AX
		cmp	byte ptr [BP+6],0
		je	short M007_L_E2C0
		push	word ptr [BP+0Ch]
		push	CS
		db	0E8h
		dw	0FAFCh
		mov	word ptr [BP+0Ch],AX
		jmp	short M007_L_E2C0
M007_L_E2A1:
		push	SI
		xor	AX,AX
		push	AX
		mov	AL,byte ptr [BP+6]
		push	AX
		db	09Ah
		dw	X00A_01
		dw	seg X00A_01
		push	AX
		push	word ptr [BP+0Ch]
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		push	AX
		db	09Ah
		dw	X007_0C
		dw	seg X007_0C
		mov	word ptr [BP+0Ch],AX
M007_L_E2C0:
		mov	AX,word ptr [BP+0Ch]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
STAOV124	endp
CO06A_TEXT	ends


		extrn	X003_02:far
		extrn	X00F_13:far
		extrn	X023_0C:far
		extrn	X023_0F:far
		extrn	X023_1E:far
		extrn	X023_1D:far
		extrn	X023_13:far
		extrn	X023_17:far
		extrn	X023_00:far
		extrn	X023_05:far
		extrn	X023_04:far
		extrn	X023_07:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M008_BCC_DATA_5EC8	equ	5EC8h
M008_BCC_DATA_615C	equ	615Ch
M008_BCC_DATA_6288	equ	6288h
M008_BCC_DATA_8186	equ	8186h

		public	X06A_04
X06A_04	label	far
STAOV125	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ch]
		mov	word ptr [BP-4],0
		mov	word ptr [BP-6],0
		mov	byte ptr [BP-7],0
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-2],AX
		mov	DI,SI
		mov	SI,word ptr ES:[DI+0Ah]
		push	DI
		db	09Ah
		dw	X023_1D
		dw	seg X023_1D
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		je	short M008_L_E328
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	SS
		lea	AX,[BP-7]
		push	AX
		push	CS
		db	0E8h
		dw	0FC87h
		jmp	short M008_L_E349
M008_L_E328:
		push	word ptr [BP+8]
		push	word ptr [BP+0Ah]
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	SS
		lea	AX,[BP-7]
		push	AX
		push	CS
		db	0E8h
		dw	0FC6Ch
		mov	AX,word ptr [BP-4]
		neg	AX
		mov	word ptr [BP-4],AX
M008_L_E349:
		cmp	word ptr [BP-4],0
		jne	short M008_L_E352
		db	0E9h
		dw	000F9h
M008_L_E352:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	word ptr ES:[SI],48h
		jne	short M008_L_E366
		mov	AX,word ptr [BP-4]
		add	word ptr ES:[SI+0Ah],AX
		db	0E9h
		dw	000E5h
M008_L_E366:
		cmp	word ptr [BP+6],0
		je	short M008_L_E37A
		push	word ptr [BP+6]
		db	09Ah
		dw	X023_00
		dw	seg X023_00
		mov	AH,0
		or	AX,AX
		jne	short M008_L_E395
M008_L_E37A:
		push	word ptr [BP-2]
		db	09Ah
		dw	X023_04
		dw	seg X023_04
		push	AX
		db	09Ah
		dw	X023_17
		dw	seg X023_17
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		mov	word ptr [BP+6],AX
M008_L_E395:
		push	word ptr [BP+6]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		mov	DI,AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr ES:[DI+8],AX
		mov	AX,0Bh
		push	AX
		push	DI
		push	SI
		db	09Ah
		dw	X023_05
		dw	seg X023_05
		mov	SI,AX
		push	word ptr [BP+6]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		mov	DI,AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DGROUP:M008_BCC_DATA_615C
		mov	word ptr ES:[DI+8],AX
		mov	AX,2Fh
		push	AX
		push	DI
		push	word ptr DGROUP:M008_BCC_DATA_6288
		db	09Ah
		dw	X023_13
		dw	seg X023_13
		push	AX
		db	09Ah
		dw	X023_05
		dw	seg X023_05
		mov	DI,AX
		mov	AX,20h
		push	AX
		push	word ptr [BP+6]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_5EC8
		mov	AX,word ptr [BP-4]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X023_07
		dw	seg X023_07
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_5EC8
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X023_07
		dw	seg X023_07
		push	AX
		db	09Ah
		dw	X023_0F
		dw	seg X023_0F
		mov	word ptr [BP-0Ah],AX
		mov	AX,0Ch
		push	AX
		push	DI
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X023_05
		dw	seg X023_05
		mov	DI,AX
		push	SI
		push	DI
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		mov	SI,AX
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		mov	SI,AX
M008_L_E44B:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[SI+8],AX
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
STAOV125	endp
CO06A_TEXT	ends


		extrn	X003_02:far
		extrn	X00F_13:far
		extrn	X023_1D:far
		extrn	X023_12:far
		extrn	X023_05:far
		extrn	X023_07:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M009_BCC_DATA_5EC8	equ	5EC8h
M009_BCC_DATA_8186	equ	8186h

		public	X06A_05
X06A_05	label	far
STAOV126	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],0
		mov	byte ptr [BP-5],0
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+8]
		mov	word ptr [BP-8],SI
		mov	BX,word ptr [BP-8]
		mov	SI,word ptr ES:[BX+0Ah]
		push	word ptr [BP-8]
		db	09Ah
		dw	X023_1D
		dw	seg X023_1D
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		je	short M009_L_E4C0
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FAEFh
		jmp	short M009_L_E4E1
M009_L_E4C0:
		push	word ptr [BP+6]
		push	word ptr [BP+8]
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FAD4h
		mov	AX,word ptr [BP-2]
		neg	AX
		mov	word ptr [BP-2],AX
M009_L_E4E1:
		cmp	word ptr [BP-2],0
		jne	short M009_L_E4F3
M009_L_E4E7:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		mov	word ptr ES:[SI+8],DI
		mov	AX,SI
		jmp	short M009_L_E546
M009_L_E4F3:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		cmp	word ptr ES:[SI],2
		jne	short M009_L_E50B
		mov	AX,word ptr [BP-2]
		cwd
		add	word ptr ES:[SI+0Ah],AX
		adc	word ptr ES:[SI+0Ch],DX
		jmp	short M009_L_E4E7
M009_L_E50B:
		push	word ptr DGROUP:M009_BCC_DATA_5EC8
		push	SI
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		mov	SI,AX
		mov	AX,16h
		push	AX
		push	SI
		push	word ptr DGROUP:M009_BCC_DATA_5EC8
		mov	AX,word ptr [BP-2]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X023_07
		dw	seg X023_07
		push	AX
		db	09Ah
		dw	X023_05
		dw	seg X023_05
		mov	SI,AX
		push	DI
		push	SI
		db	09Ah
		dw	X023_12
		dw	seg X023_12
		mov	SI,AX
		push	SI
		push	DI
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
M009_L_E546:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
STAOV126	endp
CO06A_TEXT	ends


		extrn	X00F_08:far
		extrn	X00F_00:far
		extrn	X023_20:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M00A_BCC_EXPR_SEGMENT	equ	639Ah
M00A_BCC_DATA_6408	equ	6408h

		public	X06A_00
X06A_00	label	far
STAOV127	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],0
		mov	byte ptr [BP-5],0
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-5]
		push	AX
		push	CS
		db	0E8h
		dw	0FA30h
		mov	AL,byte ptr [BP-5]
		mov	AH,0
		or	AX,AX
		jne	short M00A_L_E58A
		xor	AX,AX
		jmp	short M00A_L_E5E8
M00A_L_E58A:
		cmp	word ptr [BP-4],0
		jne	short M00A_L_E595
		mov	AX,word ptr [BP-2]
		jmp	short M00A_L_E5E8
M00A_L_E595:
		push	word ptr [BP-4]
		db	09Ah
		dw	X023_20
		dw	seg X023_20
		push	word ptr [BP+6]
		db	09Ah
		dw	X00F_08
		dw	seg X00F_08
		mov	SI,AX
		mov	word ptr [BP-8],0
		jmp	short M00A_L_E5E1
M00A_L_E5AE:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_6408
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+5]
		mov	BX,word ptr [BP+8]
		cmp	AX,word ptr ES:[BX+5]
		jne	short M00A_L_E5D2
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_6408
		mov	AX,word ptr ES:[SI+4]
		mov	word ptr [BP-8],AX
M00A_L_E5D2:
		mov	DI,SI
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_6408
		mov	SI,word ptr ES:[SI]
		push	DI
		db	09Ah
		dw	X00F_00
		dw	seg X00F_00
M00A_L_E5E1:
		or	SI,SI
		jne	short M00A_L_E5AE
		mov	AX,word ptr [BP-8]
M00A_L_E5E8:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV127	endp
CO06A_TEXT	ends


		extrn	X003_02:far
		extrn	X00A_00:far
		extrn	X00F_1E:far
		extrn	X00F_25:far
		extrn	X023_0C:far
		extrn	X023_0E:far
		extrn	X023_1E:far
		extrn	X023_17:far
		extrn	X023_00:far
		extrn	X023_04:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M00B_BCC_DATA_6398	equ	6398h
M00B_BCC_DATA_782A	equ	782Ah
M00B_BCC_DATA_8186	equ	8186h

		public	X06A_02
X06A_02	label	far
STAOV128	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		je	short M00B_L_E626
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	word ptr [BP+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X00A_00
		dw	seg X00A_00
		mov	AH,0
		or	AX,AX
		je	short M00B_L_E624
		push	SI
		db	09Ah
		dw	X023_00
		dw	seg X023_00
		mov	AH,0
		or	AX,AX
		jne	short M00B_L_E626
M00B_L_E624:
		xor	SI,SI
M00B_L_E626:
		or	SI,SI
		jne	short M00B_L_E63A
		push	word ptr [BP+0Ah]
		db	09Ah
		dw	X023_04
		dw	seg X023_04
		push	AX
		db	09Ah
		dw	X023_17
		dw	seg X023_17
		jmp	short M00B_L_E640
M00B_L_E63A:
		push	SI
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
M00B_L_E640:
		mov	word ptr [BP-2],AX
		push	word ptr [BP-2]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		mov	DI,AX
		or	SI,SI
		jne	short M00B_L_E65D
		mov	AX,1Dh
		push	AX
		push	DI
		db	09Ah
		dw	X023_0E
		dw	seg X023_0E
		mov	DI,AX
M00B_L_E65D:
		push	word ptr [BP-2]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		db	09Ah
		dw	X00F_1E
		dw	seg X00F_1E
		push	AX
		push	DI
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		mov	DI,AX
		or	SI,SI
		jne	short M00B_L_E6AD
		mov	AX,18h
		push	AX
		push	DI
		db	09Ah
		dw	X023_0E
		dw	seg X023_0E
		mov	DI,AX
		push	word ptr [BP-2]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		push	word ptr [BP+0Ah]
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_6398
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_782A
		push	word ptr ES:[BX+10h]
		db	09Ah
		dw	X00F_25
		dw	seg X00F_25
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_6398
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_782A
		mov	word ptr ES:[BX+10h],AX
M00B_L_E6AD:
		push	DI
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
STAOV128	endp
CO06A_TEXT	ends


		extrn	X023_06:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M00C_BCC_DATA_8186	equ	8186h

		public	X06A_07
X06A_07	label	far
BCC_NEAR_E6BF	label	near
STAOV129	proc	far
M00C_L_E6BF:
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-2],AX
		mov	CX,0Fh
		mov	BX,0A54h
M00C_L_E6D9:
		mov	AX,word ptr CS:[BX]
		cmp	AX,word ptr [BP-2]
		je	short M00C_L_E6E8
		inc	BX
		inc	BX
		loop	short M00C_L_E6D9
		db	0E9h
		dw	00092h
M00C_L_E6E8:
		db	02Eh,0FFh,067h,01Eh
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		and	AX,2
		neg	AX
		sbb	AX,AX
		inc	AX
		jmp	short M00C_L_E77C
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		db	09Ah
		dw	X023_06
		dw	seg X023_06
		or	AL,AL
		jne	short M00C_L_E721
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	CS
		db	0E8h
		dw	0FFA2h
		or	AL,AL
		je	short M00C_L_E726
M00C_L_E721:
		mov	AX,1
		jmp	short M00C_L_E774
M00C_L_E726:
		jmp	short M00C_L_E772
		jmp	short M00C_L_E774
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+0Ch]
		push	word ptr ES:[DI+0Ah]
		db	09Ah
		dw	X023_06
		dw	seg X023_06
		or	AL,AL
		jne	short M00C_L_E74F
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		push	word ptr ES:[DI+0Ah]
		push	CS
		db	0E8h
		dw	0FF74h
		or	AL,AL
		je	short M00C_L_E772
M00C_L_E74F:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		push	word ptr ES:[DI+0Ch]
		db	09Ah
		dw	X023_06
		dw	seg X023_06
		or	AL,AL
		jne	short M00C_L_E770
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8186
		push	word ptr ES:[DI+0Ch]
		push	CS
		db	0E8h
		dw	0FF53h
		or	AL,AL
		je	short M00C_L_E772
M00C_L_E770:
		jmp	short M00C_L_E721
M00C_L_E772:
		xor	AX,AX
M00C_L_E774:
		jmp	short M00C_L_E77C
		mov	AL,1
		jmp	short M00C_L_E77C
M00C_L_E77A:
		mov	AL,0
M00C_L_E77C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV129	endp
CO06A_TEXT	ends

CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT

STOVT193	label	word
		dw	00012h
		dw	00013h
		dw	00014h
		dw	00015h
		dw	00016h
		dw	00017h
		dw	00018h
		dw	00019h
		dw	0001Ah
		dw	0001Bh
		dw	0001Ch
		dw	00025h
		dw	0002Ah
		dw	0003Fh
		dw	00040h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	00A46h
		dw	009FAh
		dw	009D0h
		dw	009BCh
		dw	009BCh

CO06A_TEXT	ends

		extrn	X003_02:far
		extrn	X007_0B:far
		extrn	X023_0C:far
		extrn	X023_0E:far
		extrn	X023_1B:far
		extrn	X023_1E:far
		extrn	X023_06:far


CO06A_TEXT	segment byte public 'CODE'
		assume	cs:CO06A_TEXT,ds:DGROUP

M00E_BCC_EXPR_SEGMENT	equ	639Ah
M00E_BCC_DATA_8186	equ	8186h

		public	X06A_08
X06A_08	label	far
STAOV12A	proc	far
M00E_L_E7C0:
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX]
		test	byte ptr [BX+9CAh],14h
		je	short M00E_L_E7FA
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00E_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+2],20h
		jne	short M00E_L_E80F
M00E_L_E7FA:
		push	SI
		db	09Ah
		dw	X023_06
		dw	seg X023_06
		or	AL,AL
		jne	short M00E_L_E80F
		push	SI
		push	CS
		db	0E8h
		dw	0FEB6h
		mov	AH,0
		or	AX,AX
		jne	short M00E_L_E814
M00E_L_E80F:
		mov	AX,SI
		db	0E9h
		dw	000D2h
M00E_L_E814:
		cmp	word ptr [BP-2],2Ah
		jne	short M00E_L_E837
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	CS
		db	0E8h
		dw	0FF9Ah
		push	AX
		db	09Ah
		dw	X007_0B
		dw	seg X007_0B
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ch],AX
		db	0E9h
		dw	00092h
M00E_L_E837:
		cmp	word ptr [BP-2],25h
		jne	short M00E_L_E873
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+0Ch]
		push	word ptr ES:[DI+0Ah]
		push	CS
		db	0E8h
		dw	0FF73h
		push	AX
		db	09Ah
		dw	X007_0B
		dw	seg X007_0B
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	word ptr ES:[DI+0Ah],AX
		push	word ptr ES:[DI+0Ch]
		push	CS
		db	0E8h
		dw	0FF5Dh
		push	AX
		db	09Ah
		dw	X007_0B
		dw	seg X007_0B
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	word ptr ES:[DI+0Ch],AX
		jmp	short M00E_L_E8C9
M00E_L_E873:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ah]
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-6],0
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		db	09Ah
		dw	X023_1B
		dw	seg X023_1B
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ah],AX
		push	word ptr [BP-6]
		push	SI
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X023_1E
		dw	seg X023_1E
		push	AX
		db	09Ah
		dw	X007_0B
		dw	seg X007_0B
		push	AX
		db	09Ah
		dw	X023_0C
		dw	seg X023_0C
		mov	SI,AX
M00E_L_E8C9:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8186
		and	byte ptr ES:[SI+6],0FEh
		mov	AX,18h
		push	AX
		push	SI
		db	09Ah
		dw	X023_0E
		dw	seg X023_0E
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X003_02
		dw	seg X003_02
M00E_L_E8E6:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV12A	endp
CO06A_TEXT	ends

; END C116UNIT
		end
