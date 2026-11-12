		public	X04F_13
		public	X04F_12
		public	X04F_11
		public	X04F_10
		public	X04F_09
		public	X04F_02
		public	X04F_08
		public	X04F_03
		public	X04F_01
		public	X04F_00
		public	X04F_07
		public	X04F_06
		public	X04F_05
		public	X04F_04
		public	X04F_0C
		public	X04F_0B
		public	X04F_0A
		public	X04F_0F
		public	X04F_0E
		public	X04F_0D
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d22_9b84
; BEGIN C111UNIT (listing ovr_1d22_9b84:B840)

CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP



		public	X04F_0E
X04F_0E	label	far
BCC_FAR_B840	proc	far
		push	BP
		mov	BP,SP
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		mov	DX,0Ah
		imul	DX
		pop	BP
		retf	2
BCC_FAR_B840	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_03A9:far
		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M001_BCC_EXPR_SEGMENT	equ	639Ah
M001_BCC_DATA_8164	equ	8164h

		public	X04F_13
X04F_13	label	far
BCC_FAR_B851	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		push	DI
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP+6],0
		je	short M001_L_B89A
		mov	CX,word ptr [BP-2]
		mov	BX,word ptr [BP-4]
		mov	DX,word ptr [BP+0Ch]
		mov	AX,word ptr [BP+0Ah]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		cmp	DX,0FFh
		jl	short M001_L_B8C1
		jg	short M001_L_B88D
		cmp	AX,0FFFFh
		jbe	short M001_L_B8C1
M001_L_B88D:
		mov	AX,0Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M001_L_B8C1
M001_L_B89A:
		mov	CX,word ptr [BP-2]
		mov	BX,word ptr [BP-4]
		mov	DX,word ptr [BP+0Ch]
		mov	AX,word ptr [BP+0Ah]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		or	DX,DX
		jl	short M001_L_B8C1
		jg	short M001_L_B8B6
		cmp	AX,0FFFFh
		jbe	short M001_L_B8C1
M001_L_B8B6:
		mov	AX,0Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M001_L_B8C1:
		push	DS
		mov	AX,639Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	byte ptr ES:[SI],11h
		mov	word ptr ES:[SI+7],DI
		mov	AX,word ptr [BP+0Ch]
		mov	DX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+5],AX
		mov	word ptr ES:[SI+3],DX
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[SI+9],AL
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_B851	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M002_BCC_EXPR_SEGMENT	equ	639Ah

		public	X04F_0D
X04F_0D	label	far
BCC_FAR_B90D	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,639Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	byte ptr ES:[SI],15h
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+5],AX
		mov	word ptr ES:[SI+3],2
		mov	AX,SI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_B90D	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M003_BCC_EXPR_SEGMENT	equ	639Ah

		public	X04F_08
X04F_08	label	far
BCC_FAR_B94E	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,639Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M003_BCC_EXPR_SEGMENT
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
		mov	byte ptr ES:[SI],12h
		mov	AX,word ptr [BP+0Ch]
		mov	word ptr ES:[SI+3],AX
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+5],AX
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[SI+8],AL
		mov	AL,byte ptr [BP+8]
		mov	byte ptr ES:[SI+7],AL
		mov	AX,SI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_B94E	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M004_BCC_EXPR_SEGMENT	equ	639Ah

		public	X04F_11
X04F_11	label	far
BCC_FAR_B99E	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,639Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI],AL
		mov	AL,byte ptr [BP+0Ah]
		mov	byte ptr ES:[SI+7],AL
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+5],AX
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[SI+8],AL
		mov	AX,word ptr [BP+0Eh]
		mov	word ptr ES:[SI+3],AX
		mov	AX,SI
		pop	SI
		pop	BP
		retf	0Ah
BCC_FAR_B99E	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M005_BCC_EXPR_SEGMENT	equ	639Ah

		public	X04F_12
X04F_12	label	far
BCC_FAR_B9F0	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,639Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		mov	byte ptr ES:[SI],13h
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[SI+9],AL
		mov	AX,SI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_B9F0	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_03A9:far
		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M006_BCC_DATA_5F4E	equ	5F4Eh
M006_BCC_EXPR_SEGMENT	equ	639Ah
M006_BCC_STMT_RECORD_SEG	equ	63C2h

		public	X04F_05
X04F_05	label	far
BCC_FAR_BA2B	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		jne	short M006_L_BA42
		xor	DX,DX
		mov	AX,1
		db	0E9h
		dw	000BDh
M006_L_BA42:
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],1
		jmp	short M006_L_BA73
M006_L_BA4E:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	CX,word ptr ES:[SI+5]
		mov	BX,word ptr ES:[SI+3]
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+7]
M006_L_BA73:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		je	short M006_L_BA4E
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,13h
		je	short M006_L_BA93
		cmp	AX,14h
		je	short M006_L_BA93
		cmp	AX,15h
		je	short M006_L_BAD0
		jmp	short M006_L_BADA
M006_L_BA93:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	DI,word ptr ES:[SI+3]
		or	DI,DI
		jne	short M006_L_BAF0
		mov	word ptr DGROUP:M006_BCC_DATA_5F4E,0
		mov	BX,word ptr ES:[SI+7]
		mov	ES,word ptr DGROUP:M006_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,10Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	word ptr ES:[SI+3],1
		jmp	short M006_L_BAF0
M006_L_BAD0:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	DI,word ptr ES:[SI+3]
		jmp	short M006_L_BAF0
M006_L_BADA:
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	AL,byte ptr [BX+392Bh]
		cbw
		mov	DI,AX
M006_L_BAF0:
		mov	BX,DI
		xor	CX,CX
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
M006_L_BAFF:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_BA2B	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M007_BCC_DATA_16F5	equ	16F5h
M007_BCC_EXPR_SEGMENT	equ	639Ah
M007_BCC_DATA_8196	equ	8196h


BCC_NEAR_BB07	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M007_L_BB54
M007_L_BB19:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8196
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],5
		jnc	short M007_L_BB36
		cmp	byte ptr DGROUP:M007_BCC_DATA_16F5,1
		jne	short M007_L_BB4C
		xor	AX,AX
		jmp	short M007_L_BB5B
M007_L_BB36:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8196
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],9
		jne	short M007_L_BB4C
		xor	AX,AX
		jmp	short M007_L_BB5B
M007_L_BB4C:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8196
		mov	SI,word ptr ES:[SI+6]
M007_L_BB54:
		or	SI,SI
		jne	short M007_L_BB19
		mov	AX,1
M007_L_BB5B:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_BB07	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_AA87:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M008_BCC_EXPR_SEGMENT	equ	639Ah
M008_BCC_DATA_789C	equ	789Ch
M008_BCC_DATA_8196	equ	8196h

		public	X04F_0C
X04F_0C	label	far
BCC_FAR_BB61	proc	far
M008_L_BB61:
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	DI,word ptr [BP+8]
M008_L_BB6F:
		cmp	SI,DI
		jne	short M008_L_BB79
		mov	AX,1
		db	0E9h
		dw	002BCh
M008_L_BB79:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		cmp	AL,byte ptr ES:[DI]
		je	short M008_L_BB8A
		xor	AX,AX
		db	0E9h
		dw	002ABh
M008_L_BB8A:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		sub	AX,0Dh
		mov	BX,AX
		cmp	BX,8
		jbe	short M008_L_BBA0
		db	0E9h
		dw	00275h
M008_L_BBA0:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	5FDh
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[SI+5]
		mov	DX,word ptr ES:[SI+3]
		cmp	AX,word ptr ES:[DI+5]
		jne	short M008_L_BBBF
		cmp	DX,word ptr ES:[DI+3]
		je	short M008_L_BBDC
M008_L_BBBF:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[SI+3]
		or	AX,word ptr ES:[SI+5]
		je	short M008_L_BBDC
		mov	AX,word ptr ES:[DI+3]
		or	AX,word ptr ES:[DI+5]
		je	short M008_L_BBDC
		xor	AX,AX
		db	0E9h
		dw	00259h
M008_L_BBDC:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+7]
		mov	DI,word ptr ES:[DI+7]
		db	0E9h
		dw	0022Ah
		xor	AX,AX
		db	0E9h
		dw	00245h
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+7]
		cmp	AL,byte ptr ES:[DI+7]
		je	short M008_L_BC03
		xor	AX,AX
		db	0E9h
		dw	00232h
M008_L_BC03:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+8]
		mov	byte ptr [BP-1],AL
		mov	AL,byte ptr ES:[DI+8]
		mov	byte ptr [BP-2],AL
		test	byte ptr [BP-1],8
		je	short M008_L_BC4D
		mov	AL,byte ptr [BP-1]
		cbw
		and	AX,0FFF7h
		push	AX
		mov	AL,byte ptr [BP-2]
		cbw
		and	AX,0FFF7h
		pop	DX
		cmp	DX,AX
		je	short M008_L_BC34
		xor	AX,AX
		db	0E9h
		dw	00201h
M008_L_BC34:
		test	byte ptr [BP-2],8
		je	short M008_L_BC3D
		db	0E9h
		dw	000CCh
M008_L_BC3D:
		push	DI
		db	0E8h
		dw	0FEC6h
		or	AX,AX
		je	short M008_L_BC48
		db	0E9h
		dw	000C1h
M008_L_BC48:
		xor	AX,AX
		db	0E9h
		dw	001E8h
M008_L_BC4D:
		test	byte ptr [BP-2],8
		je	short M008_L_BC85
		mov	AL,byte ptr [BP-2]
		cbw
		and	AX,0FFF7h
		push	AX
		mov	AL,byte ptr [BP-1]
		cbw
		and	AX,0FFF7h
		pop	DX
		cmp	DX,AX
		je	short M008_L_BC6C
		xor	AX,AX
		db	0E9h
		dw	001C9h
M008_L_BC6C:
		test	byte ptr [BP-1],8
		je	short M008_L_BC75
		db	0E9h
		dw	00094h
M008_L_BC75:
		push	SI
		db	0E8h
		dw	0FE8Eh
		or	AX,AX
		je	short M008_L_BC80
		db	0E9h
		dw	00089h
M008_L_BC80:
		xor	AX,AX
		db	0E9h
		dw	001B0h
M008_L_BC85:
		mov	AL,byte ptr [BP-1]
		cmp	AL,byte ptr [BP-2]
		je	short M008_L_BC92
		xor	AX,AX
		db	0E9h
		dw	001A3h
M008_L_BC92:
		mov	AL,byte ptr [BP+6]
		cbw
		mov	word ptr [BP-8],AX
		cmp	byte ptr [BP+6],3
		je	short M008_L_BCA4
		mov	word ptr [BP-8],0
M008_L_BCA4:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[SI+5]
		mov	word ptr [BP-4],AX
		mov	AX,word ptr ES:[DI+5]
		jmp	short M008_L_BCED
M008_L_BCB5:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8196
		push	word ptr ES:[BX+2]
		mov	BX,word ptr [BP-6]
		push	word ptr ES:[BX+2]
		mov	AL,byte ptr [BP-8]
		push	AX
		push	CS
		db	0E8h
		dw	0FE92h
		or	AX,AX
		jne	short M008_L_BCD8
		xor	AX,AX
		db	0E9h
		dw	0015Dh
M008_L_BCD8:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8196
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr ES:[BX+6]
M008_L_BCED:
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-4],0
		je	short M008_L_BCFC
		cmp	word ptr [BP-6],0
		jne	short M008_L_BCB5
M008_L_BCFC:
		mov	AX,word ptr [BP-4]
		cmp	AX,word ptr [BP-6]
		je	short M008_L_BD09
		xor	AX,AX
		db	0E9h
		dw	0012Ch
M008_L_BD09:
		db	0E9h
		dw	000FDh
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+5],0
		jne	short M008_L_BD23
		cmp	word ptr ES:[DI+5],0
		je	short M008_L_BD55
		xor	AX,AX
		db	0E9h
		dw	00112h
M008_L_BD23:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[DI+5],0
		jne	short M008_L_BD33
		xor	AX,AX
		db	0E9h
		dw	00102h
M008_L_BD33:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		push	word ptr DGROUP:M008_BCC_DATA_789C
		push	word ptr ES:[SI+5]
		push	word ptr DGROUP:M008_BCC_DATA_789C
		push	word ptr ES:[DI+5]
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		je	short M008_L_BD55
		xor	AX,AX
		db	0E9h
		dw	000E0h
M008_L_BD55:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+8]
		cmp	AL,byte ptr ES:[DI+8]
		je	short M008_L_BD68
		xor	AX,AX
		db	0E9h
		dw	000CDh
M008_L_BD68:
		cmp	byte ptr [BP+6],0
		jne	short M008_L_BD81
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+7]
		cmp	AL,byte ptr ES:[DI+7]
		je	short M008_L_BD81
		xor	AX,AX
		db	0E9h
		dw	000B4h
M008_L_BD81:
		cmp	byte ptr [BP+6],3
		jne	short M008_L_BDCF
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+7]
		cmp	AL,byte ptr ES:[DI+7]
		je	short M008_L_BD9A
		xor	AX,AX
		db	0E9h
		dw	0009Bh
M008_L_BD9A:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M008_L_BDB2
		mov	BX,word ptr ES:[DI+3]
		cmp	byte ptr ES:[BX],2
		jbe	short M008_L_BDCA
M008_L_BDB2:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		cmp	byte ptr ES:[BX],2
		ja	short M008_L_BE09
		mov	BX,word ptr ES:[DI+3]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M008_L_BE09
M008_L_BDCA:
		mov	AX,1
		jmp	short M008_L_BE35
M008_L_BDCF:
		cmp	byte ptr [BP+6],1
		jne	short M008_L_BE09
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+7]
		cbw
		and	AX,1
		push	AX
		mov	AL,byte ptr ES:[DI+7]
		cbw
		and	AX,1
		pop	DX
		cmp	DX,AX
		jg	short M008_L_BE05
		mov	AL,byte ptr ES:[SI+7]
		cbw
		and	AX,2
		push	AX
		mov	AL,byte ptr ES:[DI+7]
		cbw
		and	AX,2
		pop	DX
		cmp	DX,AX
		jle	short M008_L_BE09
M008_L_BE05:
		xor	AX,AX
		jmp	short M008_L_BE35
M008_L_BE09:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+3]
		mov	DI,word ptr ES:[DI+3]
M008_L_BE15:
		cmp	byte ptr [BP+6],2
		jne	short M008_L_BE1F
		mov	byte ptr [BP+6],1
M008_L_BE1F:
		or	SI,SI
		je	short M008_L_BE2A
		or	DI,DI
		je	short M008_L_BE2A
		db	0E9h
		dw	0FD45h
M008_L_BE2A:
		cmp	SI,DI
		jne	short M008_L_BE33
		mov	AX,1
		jmp	short M008_L_BE35
M008_L_BE33:
		xor	AX,AX
M008_L_BE35:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_BB61	endp
CO04F_TEXT	ends

CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT

BCC_TABLE_BE3D	label	word
		dw	004CCh
		dw	00515h
		dw	00515h
		dw	00515h
		dw	00367h
		dw	003B0h
		dw	003ABh
		dw	003ABh
		dw	003ABh

CO04F_TEXT	ends

CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M00A_BCC_DATA_398C	equ	398Ch
M00A_BCC_DATA_398E	equ	398Eh
M00A_BCC_DATA_399C	equ	399Ch
M00A_BCC_DATA_399E	equ	399Eh
M00A_BCC_DATA_39AC	equ	39ACh
M00A_BCC_DATA_39AE	equ	39AEh


		public	X04F_0B
X04F_0B	label	far
BCC_FAR_BE4F	proc	far
		push	BP
		mov	BP,SP
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		dec	AX
		mov	BX,AX
		cmp	BX,5
		jbe	short M00A_L_BE62
		db	0E9h
		dw	000D3h
M00A_L_BE62:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	6FFh
		mov	AX,DGROUP:M00A_BCC_DATA_398E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_398C
		and	word ptr [BP+8],DX
		and	word ptr [BP+0Ah],AX
		add	DX,1
		adc	AX,0
		sar	AX,1
		rcr	DX,1
		mov	BX,word ptr [BP+0Ah]
		mov	CX,word ptr [BP+8]
		and	CX,DX
		and	BX,AX
		or	CX,BX
		jne	short M00A_L_BE91
		db	0E9h
		dw	000A4h
M00A_L_BE91:
		mov	AX,DGROUP:M00A_BCC_DATA_398E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_398C
		not	DX
		not	AX
		or	word ptr [BP+8],DX
		or	word ptr [BP+0Ah],AX
		db	0E9h
		dw	00090h
		mov	AX,DGROUP:M00A_BCC_DATA_398E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_398C
		db	0E9h
		dw	00080h
		mov	AX,DGROUP:M00A_BCC_DATA_399E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_399C
		and	word ptr [BP+8],DX
		and	word ptr [BP+0Ah],AX
		add	DX,1
		adc	AX,0
		sar	AX,1
		rcr	DX,1
		mov	BX,word ptr [BP+0Ah]
		mov	CX,word ptr [BP+8]
		and	CX,DX
		and	BX,AX
		or	CX,BX
		je	short M00A_L_BF35
		mov	AX,DGROUP:M00A_BCC_DATA_399E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_399C
		not	DX
		not	AX
		or	word ptr [BP+8],DX
		or	word ptr [BP+0Ah],AX
		jmp	short M00A_L_BF35
		mov	AX,DGROUP:M00A_BCC_DATA_399E
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_399C
		jmp	short M00A_L_BF2F
		mov	AX,DGROUP:M00A_BCC_DATA_39AE
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_39AC
		and	word ptr [BP+8],DX
		and	word ptr [BP+0Ah],AX
		add	DX,1
		adc	AX,0
		sar	AX,1
		rcr	DX,1
		mov	BX,word ptr [BP+0Ah]
		mov	CX,word ptr [BP+8]
		and	CX,DX
		and	BX,AX
		or	CX,BX
		je	short M00A_L_BF35
		mov	AX,DGROUP:M00A_BCC_DATA_39AE
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_39AC
		not	DX
		not	AX
		or	word ptr [BP+8],DX
		or	word ptr [BP+0Ah],AX
		jmp	short M00A_L_BF35
		mov	AX,DGROUP:M00A_BCC_DATA_39AE
		mov	DX,word ptr DGROUP:M00A_BCC_DATA_39AC
M00A_L_BF2F:
		and	word ptr [BP+8],DX
		and	word ptr [BP+0Ah],AX
M00A_L_BF35:
		mov	DX,word ptr [BP+0Ah]
		mov	AX,word ptr [BP+8]
		pop	BP
		retf	6
BCC_FAR_BE4F	endp
CO04F_TEXT	ends

CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT

BCC_TABLE_BF3F	label	word
		dw	00629h
		dw	00665h
		dw	0066Fh
		dw	006A7h
		dw	006B0h
		dw	006E8h

CO04F_TEXT	ends

		extrn	BCC_FAR_02D2:far
		extrn	BCC_FAR_03A9:far
		extrn	BCC_FAR_5B8B:far
		extrn	X049_04:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M00C_BCC_EXPR_SEGMENT	equ	639Ah
M00C_BCC_DATA_8164	equ	8164h

BCC_NEAR_BF4B	label	near
BCC_FAR_BF4B	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	word ptr [BP-4],0
		mov	word ptr [BP-6],1
		jmp	short M00C_L_BF87
M00C_L_BF62:
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		mov	CX,word ptr ES:[SI+5]
		mov	BX,word ptr ES:[SI+3]
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+7]
M00C_L_BF87:
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		je	short M00C_L_BF62
		push	SI
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		xor	CX,CX
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		les	BX,[BP+6]
		mov	word ptr ES:[BX],0
		cmp	word ptr [BP-4],1
		jg	short M00C_L_BFC7
		jne	short M00C_L_BFC5
		cmp	word ptr [BP-6],0
		ja	short M00C_L_BFC7
M00C_L_BFC5:
		jmp	short M00C_L_C01C
M00C_L_BFC7:
		xor	AX,AX
		push	AX
		push	word ptr [BP-2]
		db	09Ah
		dw	X049_04
		dw	seg X049_04
		mov	DI,AX
		or	DI,DI
		jge	short M00C_L_C01C
		xor	AX,AX
		push	AX
		push	word ptr [BP-2]
		mov	AX,1
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	BCC_FAR_02D2
		dw	seg BCC_FAR_02D2
		mov	DI,AX
		cwd
		mov	BX,word ptr [BP-4]
		mov	CX,word ptr [BP-6]
		add	CX,AX
		adc	BX,DX
		cmp	BX,2
		jl	short M00C_L_C00D
		jg	short M00C_L_C002
		or	CX,CX
		jbe	short M00C_L_C00D
M00C_L_C002:
		mov	AX,0Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M00C_L_C00D:
		mov	AX,DI
		cwd
		add	word ptr [BP-6],AX
		adc	word ptr [BP-4],DX
		les	BX,[BP+6]
		mov	word ptr ES:[BX],DI
M00C_L_C01C:
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_BF4B	endp
CO04F_TEXT	ends



		extrn	X035_00:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

		public	X04F_02
X04F_02	label	far
BCC_FAR_C02A	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	CS
		db	0E8h
		dw	0FF0Fh
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		db	09Ah
		dw	X035_00
		dw	seg X035_00
		mov	word ptr [BP-6],AX
		jmp	short M00D_L_C059
M00D_L_C04C:
		db	09Ah
		dw	X035_00
		dw	seg X035_00
		sub	word ptr [BP-4],0
		sbb	word ptr [BP-2],1
M00D_L_C059:
		cmp	word ptr [BP-2],1
		jg	short M00D_L_C04C
		jne	short M00D_L_C067
		cmp	word ptr [BP-4],0
		ja	short M00D_L_C04C
M00D_L_C067:
		mov	AX,word ptr [BP-6]
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_C02A	endp
CO04F_TEXT	ends




CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M00E_BCC_STMT_RECORD_SEG	equ	63C2h
M00E_BCC_DATA_87D0	equ	87D0h
M00E_BCC_DATA_87D8	equ	87D8h
M00E_BCC_DATA_87DC	equ	87DCh

		public	X04F_10
X04F_10	label	far
BCC_FAR_C070	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00E_BCC_STMT_RECORD_SEG
		push	word ptr ES:[DI+8]
		push	SS
		lea	AX,[BP-6]
		push	AX
		push	CS
		db	0E8h
		dw	0FEBFh
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-6],0
		je	short M00E_L_C0BC
		push	word ptr [BP-6]
		db	0FFh,01Eh
		dw	87DCh
		mov	AX,1
		xor	DX,DX
		sub	DX,word ptr [BP-6]
		sbb	AX,0
		mov	word ptr [BP-8],AX
		mov	word ptr [BP-0Ah],DX
		mov	AX,word ptr [BP-6]
		sub	word ptr [BP-4],AX
		sbb	word ptr [BP-2],0
		jmp	short M00E_L_C0C6
M00E_L_C0BC:
		mov	word ptr [BP-8],1
		mov	word ptr [BP-0Ah],0
M00E_L_C0C6:
		push	DI
		db	0FFh,01Eh
		dw	87D0h
		mov	ES,word ptr DGROUP:M00E_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[DI+0Ch]
		jmp	short M00E_L_C130
M00E_L_C0D5:
		push	SI
		db	0FFh,01Eh
		dw	87D8h
		mov	AX,word ptr [BP-8]
		mov	DX,word ptr [BP-0Ah]
		cmp	AX,word ptr [BP-2]
		jl	short M00E_L_C0F8
		jg	short M00E_L_C0EC
		cmp	DX,word ptr [BP-4]
		jbe	short M00E_L_C0F8
M00E_L_C0EC:
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr [BP-8],AX
		mov	word ptr [BP-0Ah],DX
M00E_L_C0F8:
		cmp	word ptr [BP-8],1
		jne	short M00E_L_C112
		cmp	word ptr [BP-0Ah],0
		jne	short M00E_L_C112
		mov	AX,8000h
		push	AX
		db	0FFh,01Eh
		dw	87DCh
		mov	AX,8000h
		push	AX
		jmp	short M00E_L_C115
M00E_L_C112:
		push	word ptr [BP-0Ah]
M00E_L_C115:
		db	0FFh,01Eh
		dw	87DCh
		mov	AX,word ptr [BP-8]
		mov	DX,word ptr [BP-0Ah]
		sub	word ptr [BP-4],DX
		sbb	word ptr [BP-2],AX
		mov	word ptr [BP-8],1
		mov	word ptr [BP-0Ah],0
		inc	SI
M00E_L_C130:
		mov	AX,word ptr [BP-4]
		or	AX,word ptr [BP-2]
		jne	short M00E_L_C0D5
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_C070	endp
CO04F_TEXT	ends


		extrn	X056_0A:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M00F_BCC_DATA_87D8	equ	87D8h

		public	X04F_0F
X04F_0F	label	far
BCC_NEAR_C140	label	near
BCC_FAR_C140	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		db	09Ah
		dw	X056_0A
		dw	seg X056_0A
		cmp	DX,1
		jne	short M00F_L_C163
		or	AX,AX
		jne	short M00F_L_C163
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	87D8h
		mov	word ptr [BP-2],AX
		inc	AX
		push	AX
		db	0FFh,01Eh
		dw	87D8h
M00F_L_C163:
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_C140	endp
CO04F_TEXT	ends


		extrn	BCC_FAR_03A9:far
		extrn	X056_0A:far


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M010_BCC_EXPR_SEGMENT	equ	639Ah
M010_BCC_DATA_87DC	equ	87DCh

		public	X04F_0A
X04F_0A	label	far
BCC_FAR_C167	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		push	word ptr ES:[SI+7]
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	CS
		db	0E8h
		dw	0FDC9h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	AX,word ptr [BP-0Ah]
		sub	word ptr [BP-8],AX
		sbb	word ptr [BP-6],0
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		mov	CX,word ptr ES:[SI+5]
		mov	BX,word ptr ES:[SI+3]
		sub	BX,word ptr [BP+6]
		sbb	CX,0
		mov	DX,word ptr [BP-6]
		mov	AX,word ptr [BP-8]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		db	09Ah
		dw	X056_0A
		dw	seg X056_0A
		mov	BX,1
		xor	CX,CX
		sub	CX,AX
		sbb	BX,DX
		mov	word ptr [BP-2],BX
		mov	word ptr [BP-4],CX
M010_L_C1C9:
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		cmp	AX,word ptr [BP-6]
		jl	short M010_L_C1E7
		jg	short M010_L_C1DB
		cmp	DX,word ptr [BP-8]
		jbe	short M010_L_C1E7
M010_L_C1DB:
		mov	AX,word ptr [BP-6]
		mov	DX,word ptr [BP-8]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
M010_L_C1E7:
		cmp	word ptr [BP-2],1
		jne	short M010_L_C201
		cmp	word ptr [BP-4],0
		jne	short M010_L_C201
		mov	AX,8000h
		push	AX
		db	0FFh,01Eh
		dw	87DCh
		mov	AX,8000h
		push	AX
		jmp	short M010_L_C204
M010_L_C201:
		push	word ptr [BP-4]
M010_L_C204:
		db	0FFh,01Eh
		dw	87DCh
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		sub	word ptr [BP-8],DX
		sbb	word ptr [BP-6],AX
		mov	AX,word ptr [BP-8]
		or	AX,word ptr [BP-6]
		je	short M010_L_C22C
		mov	word ptr [BP-2],1
		mov	word ptr [BP-4],0
		push	CS
		db	0E8h
		dw	0FF16h
		jmp	short M010_L_C1C9
M010_L_C22C:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_C167	endp
CO04F_TEXT	ends




CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M011_BCC_EXPR_SEGMENT	equ	639Ah

		public	X04F_01
X04F_01	label	far
BCC_FAR_C233	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M011_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		jne	short M011_L_C264
		cmp	byte ptr ES:[SI+9],0
		je	short M011_L_C264
		push	SI
		push	SS
		lea	AX,[BP-2]
		push	AX
		push	CS
		db	0E8h
		dw	0FCF4h
		mov	AX,word ptr [BP-2]
		jmp	short M011_L_C27E
M011_L_C25C:
		mov	ES,word ptr DGROUP:M011_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+7]
M011_L_C264:
		mov	ES,word ptr DGROUP:M011_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		je	short M011_L_C25C
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	AL,byte ptr [BX+392Ah]
		cbw
M011_L_C27E:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_C233	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M012_BCC_EXPR_SEGMENT	equ	639Ah


		public	X04F_00
X04F_00	label	far
BCC_FAR_C285	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M012_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+8]
		cbw
		pop	BP
		retf	2
BCC_FAR_C285	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M013_BCC_EXPR_SEGMENT	equ	639Ah


		public	X04F_04
X04F_04	label	far
BCC_FAR_C298	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],0Dh
		jne	short M013_L_C2B5
		cmp	word ptr ES:[SI+5],0
		je	short M013_L_C2B5
		mov	AX,1
		jmp	short M013_L_C2B7
M013_L_C2B5:
		xor	AX,AX
M013_L_C2B7:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_C298	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M014_BCC_EXPR_SEGMENT	equ	639Ah


		public	X04F_03
X04F_03	label	far
BCC_FAR_C2BC	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M014_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		pop	BP
		retf	2
BCC_FAR_C2BC	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M015_BCC_EXPR_SEGMENT	equ	639Ah


		public	X04F_07
X04F_07	label	far
BCC_FAR_C2CF	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M015_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+8]
		cbw
		pop	BP
		retf	2
BCC_FAR_C2CF	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M016_BCC_EXPR_SEGMENT	equ	639Ah


		public	X04F_09
X04F_09	label	far
BCC_FAR_C2E2	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		pop	SI
		pop	BP
		retf	2
BCC_FAR_C2E2	endp
CO04F_TEXT	ends


CO04F_TEXT	segment byte public 'CODE'
		assume	cs:CO04F_TEXT,ds:DGROUP

M017_BCC_EXPR_SEGMENT	equ	639Ah
M017_BCC_DATA_8196	equ	8196h


		public	X04F_06
X04F_06	label	far
BCC_FAR_C2F5	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M017_BCC_EXPR_SEGMENT
		test	byte ptr ES:[DI+8],8
		je	short M017_L_C30D
		mov	AX,7FFFh
		jmp	short M017_L_C345
M017_L_C30D:
		xor	DX,DX
		mov	ES,word ptr DGROUP:M017_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[DI+5]
		jmp	short M017_L_C322
M017_L_C319:
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8196
		mov	SI,word ptr ES:[SI+6]
		inc	DX
M017_L_C322:
		or	SI,SI
		jne	short M017_L_C319
		mov	ES,word ptr DGROUP:M017_BCC_EXPR_SEGMENT
		mov	DI,word ptr ES:[DI+3]
		cmp	byte ptr ES:[DI],13h
		jne	short M017_L_C343
		cmp	word ptr ES:[DI+3],4
		ja	short M017_L_C342
		cmp	word ptr ES:[DI+3],3
		jne	short M017_L_C343
M017_L_C342:
		inc	DX
M017_L_C343:
		mov	AX,DX
M017_L_C345:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_C2F5	endp
CO04F_TEXT	ends

; END C111UNIT
		end
