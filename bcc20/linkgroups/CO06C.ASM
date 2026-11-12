		public	X06C_01
		public	X06C_00
		public	X06C_03
		public	X06C_02
		public	X06C_05
		public	X06C_04
		public	X06C_07
		public	X06C_06
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1db6_af54
; BEGIN C112UNIT (listing ovr_1db6_af54:F540)

CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M000_BCC_DATA_6410	equ	6410h
M000_BCC_DATA_78A4	equ	78A4h


BCC_NEAR_F540	label	near
STAOV136	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+4]
		mov	AH,0
		and	AX,3
		or	AX,AX
		je	short M000_L_F560
		cmp	AX,1
		je	short M000_L_F56A
		jmp	short M000_L_F56C
M000_L_F560:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_78A4
		mov	AX,word ptr ES:[SI+0Ah]
		jmp	short M000_L_F57F
M000_L_F56A:
		jmp	short M000_L_F560
M000_L_F56C:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_78A4
		mov	BX,word ptr ES:[SI+6]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_6410
		mov	BX,word ptr ES:[BX]
		mov	AX,word ptr ES:[BX+4]
M000_L_F57F:
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV136	endp
CO06C_TEXT	ends


		extrn	X00F_13:far
		extrn	X02C_13:far


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M001_BCC_DATA_5F3E	equ	5F3Eh
M001_BCC_DATA_62A0	equ	62A0h
M001_BCC_EXPR_SEGMENT	equ	639Ah
M001_BCC_DATA_6408	equ	6408h
M001_BCC_DATA_78A4	equ	78A4h

		public	X06C_03
X06C_03	label	far
BCC_NEAR_F585	label	near
STAOV137	proc	far
M001_L_F585:
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	word ptr [BP-2],0
		push	word ptr [BP+14h]
		push	word ptr [BP+12h]
		db	09Ah
		dw	X02C_13
		dw	seg X02C_13
		mov	SI,AX
		mov	word ptr [BP-4],0
		cmp	byte ptr DGROUP:M001_BCC_DATA_62A0,0
		jne	short M001_L_F5AE
		db	0E9h
		dw	00103h
M001_L_F5AE:
		or	SI,SI
		je	short M001_L_F5B5
		db	0E9h
		dw	000FCh
M001_L_F5B5:
		mov	BX,word ptr [BP+12h]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+5]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_5F3E
		mov	DI,word ptr ES:[BX+0Ch]
		db	0E9h
		dw	000DFh
M001_L_F5CB:
		push	word ptr [BP+14h]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_6408
		push	word ptr ES:[DI+2]
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	CS
		db	0E8h
		dw	0FF9Ch
		cmp	word ptr [BP-2],0
		je	short M001_L_F5F5
		mov	SI,word ptr [BP-6]
		db	0E9h
		dw	000BCh
M001_L_F5F5:
		cmp	word ptr [BP-6],0
		jne	short M001_L_F5FE
		db	0E9h
		dw	000A5h
M001_L_F5FE:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_6408
		mov	AL,byte ptr ES:[DI+7]
		mov	AH,0
		or	word ptr [BP-8],AX
		or	SI,SI
		jne	short M001_L_F61B
		mov	SI,word ptr [BP-6]
		mov	AX,word ptr [BP-8]
		mov	word ptr [BP-4],AX
		db	0E9h
		dw	00088h
M001_L_F61B:
		cmp	word ptr [BP-4],0
		je	short M001_L_F626
		cmp	SI,word ptr [BP-6]
		je	short M001_L_F6A3
M001_L_F626:
		mov	AX,word ptr [BP-4]
		cmp	AX,word ptr [BP-8]
		je	short M001_L_F69B
		mov	ES,word ptr DGROUP:M001_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+4]
		mov	AH,0
		and	AX,3
		cmp	AX,3
		jne	short M001_L_F69B
		mov	BX,word ptr [BP-6]
		mov	AL,byte ptr ES:[BX+4]
		mov	AH,0
		and	AX,3
		cmp	AX,3
		jne	short M001_L_F69B
		push	SI
		db	0E8h
		dw	0FEEBh
		mov	word ptr [BP-0Ah],AX
		push	word ptr [BP-6]
		db	0E8h
		dw	0FEE2h
		mov	word ptr [BP-0Ch],AX
		cmp	word ptr [BP-8],0
		je	short M001_L_F679
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		jne	short M001_L_F6A3
M001_L_F679:
		cmp	word ptr [BP-4],0
		je	short M001_L_F69B
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		je	short M001_L_F69B
		mov	SI,word ptr [BP-6]
		mov	word ptr [BP-4],0
		jmp	short M001_L_F6A3
M001_L_F69B:
		mov	AX,word ptr [BP+12h]
		mov	word ptr [BP-2],AX
		jmp	short M001_L_F6B1
M001_L_F6A3:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_6408
		mov	DI,word ptr ES:[DI]
M001_L_F6AA:
		or	DI,DI
		je	short M001_L_F6B1
		db	0E9h
		dw	0FF1Ah
M001_L_F6B1:
		les	BX,[BP+0Ah]
		mov	word ptr ES:[BX],SI
		les	BX,[BP+0Eh]
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[BX],AX
		les	BX,[BP+6]
		mov	AX,word ptr [BP-4]
		mov	word ptr ES:[BX],AX
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	10h
STAOV137	endp
CO06C_TEXT	ends



		extrn	X019_01:far
		extrn	X019_03:far
		extrn	X019_06:far


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

		public	X06C_00
X06C_00	label	far
STAOV138	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	CS
		db	0E8h
		dw	0FE95h
		cmp	word ptr [BP-4],0
		je	short M002_L_F713
		mov	AX,65h
		push	AX
		push	word ptr [BP-2]
		db	09Ah
		dw	X019_03
		dw	seg X019_03
		push	DX
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X019_06
		dw	seg X019_06
		push	DX
		push	AX
		db	09Ah
		dw	X019_01
		dw	seg X019_01
M002_L_F713:
		mov	AX,word ptr [BP-2]
		mov	SP,BP
		pop	BP
		retf	4
STAOV138	endp
CO06C_TEXT	ends





CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

		public	X06C_04
X06C_04	label	far
STAOV139	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-4]
		push	AX
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	CS
		db	0E8h
		dw	0FE4Ah
		mov	AX,word ptr [BP-2]
		mov	SP,BP
		pop	BP
		retf	4
STAOV139	endp
CO06C_TEXT	ends


		extrn	X00A_00:far
		extrn	X00F_13:far


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M004_BCC_DATA_0002	equ	2
M004_BCC_DATA_5F3E	equ	5F3Eh
M004_BCC_EXPR_SEGMENT	equ	639Ah
M004_BCC_DATA_63E2	equ	63E2h
M004_BCC_DATA_6408	equ	6408h

		public	X06C_07
X06C_07	label	far
BCC_NEAR_F744	label	near
STAOV13A	proc	far
M004_L_F744:
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		push	DI
		push	word ptr [BP+8]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X00A_00
		dw	seg X00A_00
		or	AL,AL
		jne	short M004_L_F772
		push	word ptr [BP+8]
		push	DI
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		mov	AH,0
		or	AX,AX
		jne	short M004_L_F778
M004_L_F772:
		mov	AX,word ptr [BP+0Ch]
		db	0E9h
		dw	000B3h
M004_L_F778:
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[DI+5]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_5F3E
		mov	AX,word ptr ES:[BX+0Eh]
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_63E2
		mov	AX,word ptr [BP+0Ah]
		db	026h,0A3h,2,0
		jmp	short M004_L_F7A5
M004_L_F798:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_63E2
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-6],AX
M004_L_F7A5:
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_63E2
		mov	AX,word ptr ES:[BX+2]
		cmp	AX,word ptr [BP+0Ah]
		jne	short M004_L_F798
		cmp	word ptr [BP-6],0
		je	short M004_L_F7BD
		jmp	short M004_L_F772
M004_L_F7BD:
		mov	word ptr [BP-2],3
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[DI+5]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_5F3E
		mov	SI,word ptr ES:[BX+0Ch]
		jmp	short M004_L_F81E
M004_L_F7D4:
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_6408
		push	word ptr ES:[SI+2]
		push	CS
		db	0E8h
		dw	0FF5Bh
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],1
		jle	short M004_L_F7F9
		mov	word ptr [BP-4],3
		jmp	short M004_L_F80C
M004_L_F7F9:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_6408
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		or	AX,AX
		jne	short M004_L_F80C
		mov	word ptr [BP-4],2
M004_L_F80C:
		mov	AX,word ptr [BP-4]
		cmp	AX,word ptr [BP-2]
		jge	short M004_L_F817
		mov	word ptr [BP-2],AX
M004_L_F817:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_6408
		mov	SI,word ptr ES:[SI]
M004_L_F81E:
		or	SI,SI
		je	short M004_L_F828
		cmp	word ptr [BP-2],0
		jg	short M004_L_F7D4
M004_L_F828:
		mov	AX,word ptr [BP-2]
M004_L_F82B:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
STAOV13A	endp
CO06C_TEXT	ends


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M005_BCC_DATA_0002	equ	2
M005_BCC_DATA_5EE0	equ	5EE0h
M005_BCC_DATA_5F3E	equ	5F3Eh
M005_BCC_EXPR_SEGMENT	equ	639Ah
M005_BCC_DATA_63EA	equ	63EAh
M005_BCC_DATA_6438	equ	6438h


		public	X06C_01
X06C_01	label	far
BCC_NEAR_F833	label	near
STAOV13B	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	SI,word ptr DGROUP:M005_BCC_DATA_5EE0
		mov	ES,word ptr DGROUP:M005_BCC_DATA_63EA
		db	026h,089h,03Eh,2,0
		mov	SI,word ptr DGROUP:M005_BCC_DATA_5EE0
		jmp	short M005_L_F855
M005_L_F84E:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_63EA
		mov	SI,word ptr ES:[SI]
M005_L_F855:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_63EA
		cmp	word ptr ES:[SI+2],DI
		jne	short M005_L_F84E
		or	SI,SI
		jne	short M005_L_F891
		cmp	word ptr DGROUP:M005_BCC_DATA_6438,0
		je	short M005_L_F891
		mov	BX,word ptr DGROUP:M005_BCC_DATA_6438
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+5]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_5F3E
		mov	SI,word ptr ES:[BX+0Ah]
		jmp	short M005_L_F887
M005_L_F880:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_63EA
		mov	SI,word ptr ES:[SI]
M005_L_F887:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_63EA
		cmp	word ptr ES:[SI+2],DI
		jne	short M005_L_F880
M005_L_F891:
		or	SI,SI
		je	short M005_L_F89A
		mov	AX,1
		jmp	short M005_L_F89C
M005_L_F89A:
		xor	AX,AX
M005_L_F89C:
		pop	DI
		pop	SI
		pop	BP
		retf	2
STAOV13B	endp
CO06C_TEXT	ends


		extrn	X00A_00:far
		extrn	X00F_13:far


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M006_BCC_DATA_5F3E	equ	5F3Eh
M006_BCC_EXPR_SEGMENT	equ	639Ah
M006_BCC_DATA_6438	equ	6438h

		public	X06C_06
X06C_06	label	far
BCC_NEAR_F8A2	label	near
STAOV13C	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	DI,word ptr [BP+8]
		or	DI,DI
		je	short M006_L_F8B6
		cmp	SI,4
		jne	short M006_L_F8BB
M006_L_F8B6:
		mov	AL,1
		db	0E9h
		dw	000E4h
M006_L_F8BB:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[DI+5]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_5F3E
		push	word ptr ES:[BX+6]
		push	CS
		db	0E8h
		dw	0FF64h
		or	AL,AL
		je	short M006_L_F8FA
		cmp	word ptr [BP+6],0
		je	short M006_L_F8E9
		push	DI
		push	word ptr [BP+6]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		je	short M006_L_F8FA
M006_L_F8E9:
		cmp	SI,3
		je	short M006_L_F8F4
M006_L_F8EE:
		mov	AX,1
		db	0E9h
		dw	000A7h
M006_L_F8F4:
		db	0E9h
		dw	000A2h
		db	0E9h
		dw	000A1h
M006_L_F8FA:
		push	SI
		push	word ptr [BP+0Ch]
		push	DI
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FE3Eh
		mov	SI,AX
		or	SI,SI
		jne	short M006_L_F90E
		jmp	short M006_L_F8B6
M006_L_F90E:
		cmp	word ptr DGROUP:M006_BCC_DATA_6438,0
		je	short M006_L_F977
		push	word ptr DGROUP:M006_BCC_DATA_6438
		push	DI
		mov	AX,1
		push	AX
		db	09Ah
		dw	X00A_00
		dw	seg X00A_00
		or	AL,AL
		jne	short M006_L_F93B
		push	word ptr DGROUP:M006_BCC_DATA_6438
		push	word ptr [BP+6]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X00A_00
		dw	seg X00A_00
		or	AL,AL
		je	short M006_L_F946
M006_L_F93B:
		cmp	SI,3
		je	short M006_L_F942
M006_L_F940:
		jmp	short M006_L_F8EE
M006_L_F942:
		jmp	short M006_L_F999
		jmp	short M006_L_F99B
M006_L_F946:
		push	DI
		push	word ptr DGROUP:M006_BCC_DATA_6438
		mov	AL,0
		push	AX
		db	09Ah
		dw	X00F_13
		dw	seg X00F_13
		or	AL,AL
		je	short M006_L_F977
		push	word ptr DGROUP:M006_BCC_DATA_6438
		push	word ptr [BP+6]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X00A_00
		dw	seg X00A_00
		or	AL,AL
		je	short M006_L_F977
		cmp	SI,1
		jg	short M006_L_F973
		db	0E9h
		dw	0FF7Bh
M006_L_F973:
		jmp	short M006_L_F999
		jmp	short M006_L_F99B
M006_L_F977:
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+5]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_5F3E
		push	word ptr ES:[BX+6]
		push	CS
		db	0E8h
		dw	0FEA5h
		or	AL,AL
		je	short M006_L_F99D
		cmp	SI,3
		je	short M006_L_F999
		jmp	short M006_L_F940
M006_L_F999:
		xor	AX,AX
M006_L_F99B:
		jmp	short M006_L_F99F
M006_L_F99D:
		mov	AL,0
M006_L_F99F:
		pop	DI
		pop	SI
		pop	BP
		retf	8
STAOV13C	endp
CO06C_TEXT	ends




CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M007_BCC_DATA_6410	equ	6410h
M007_BCC_DATA_78A4	equ	78A4h

		public	X06C_05
X06C_05	label	far
STAOV13D	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+4]
		mov	AH,0
		and	AX,3
		mov	BX,AX
		cmp	BX,3
		ja	short M007_L_F9E7
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	4C8h
M007_L_F9C8:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_78A4
		mov	DI,word ptr ES:[SI+0Ah]
		jmp	short M007_L_F9E7
		jmp	short M007_L_F9C8
		mov	ES,word ptr DGROUP:M007_BCC_DATA_78A4
		mov	BX,word ptr ES:[SI+6]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_6410
		mov	BX,word ptr ES:[BX]
		mov	DI,word ptr ES:[BX+4]
M007_L_F9E7:
		push	SI
		mov	ES,word ptr DGROUP:M007_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+4]
		mov	AH,0
		sar	AX,1
		sar	AX,1
		and	AX,7
		push	AX
		push	DI
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FEA0h
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV13D	endp
CO06C_TEXT	ends

CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT
; Original-image layout stub: not recovered source


		db	088h,004h,092h,004h,094h,004h,094h,004h	; ovr_1db6_af54:FA08

CO06C_TEXT	ends

		extrn	X02C_13:far


CO06C_TEXT	segment byte public 'CODE'
		assume	cs:CO06C_TEXT,ds:DGROUP

M009_BCC_DATA_6410	equ	6410h

		public	X06C_02
X06C_02	label	far
STAOV13E	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_6410
		push	word ptr ES:[SI+2]
		mov	BX,word ptr ES:[SI]
		push	word ptr ES:[BX+4]
		db	09Ah
		dw	X02C_13
		dw	seg X02C_13
		mov	word ptr [BP-2],AX
		push	word ptr [BP-2]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_6410
		mov	AL,byte ptr ES:[SI+0Ch]
		mov	AH,0
		sar	AX,1
		sar	AX,1
		push	AX
		mov	BX,word ptr ES:[SI]
		push	word ptr ES:[BX+4]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FE52h
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV13E	endp
CO06C_TEXT	ends

; END C112UNIT
		end
