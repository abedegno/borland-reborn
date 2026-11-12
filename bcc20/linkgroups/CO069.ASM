; Recovered FBOV far-pointer references
		extrn	BCC_COMPARE_NAME:far
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B146:far
		extrn	BCC_RF_15C5_010D:far
CO030_TEXT	segment byte public 'CODE'
CO030_TEXT	ends
CO032_TEXT	segment byte public 'CODE'
CO032_TEXT	ends
		public	X069_04
		public	X069_05
		public	X069_06
		public	X069_00
		public	X069_01
		public	X069_02
		public	X069_03
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1da8_abec
; BEGIN C128UNIT (listing ovr_1da8_abec:BEC0)

		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X037_00:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M000_BCC_DATA_66C4	equ	66C4h
M000_BCC_DATA_7846	equ	7846h
M000_BCC_DATA_852E	equ	852Eh
M000_BCC_DATA_85B0	equ	85B0h
M000_BCC_DATA_85DC	equ	85DCh
M000_BCC_DATA_85EC	equ	85ECh

		public	X069_06
X069_06	label	far
STAOV0F9	proc	far
		push	BP
		mov	BP,SP
		sub	SP,50h
		push	SI
		mov	AL,DGROUP:M000_BCC_DATA_85EC
		cbw
		or	AX,AX
		je	short M000_L_BF4D
		push	DS
		mov	AX,85DCh
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr DGROUP:M000_BCC_DATA_66C4
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		add	AX,7
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_85DC
		mov	word ptr ES:[SI],0
		push	SS
		lea	AX,[BP-50h]
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr DGROUP:M000_BCC_DATA_66C4
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DX
		push	AX
		db	09Ah
		dw	X037_00
		dw	seg X037_00
		mov	ES,word ptr DGROUP:M000_BCC_DATA_85DC
		mov	word ptr ES:[SI+4],DX
		mov	word ptr ES:[SI+2],AX
		push	word ptr DGROUP:M000_BCC_DATA_85DC
		mov	AX,SI
		add	AX,6
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr DGROUP:M000_BCC_DATA_66C4
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		cmp	word ptr DGROUP:M000_BCC_DATA_85B0,0
		je	short M000_L_BF45
		mov	ES,word ptr DGROUP:M000_BCC_DATA_85DC
		mov	BX,word ptr DGROUP:M000_BCC_DATA_852E
		mov	word ptr ES:[BX],SI
		jmp	short M000_L_BF49
M000_L_BF45:
		mov	word ptr DGROUP:M000_BCC_DATA_85B0,SI
M000_L_BF49:
		mov	word ptr DGROUP:M000_BCC_DATA_852E,SI
M000_L_BF4D:
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV0F9	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M001_BCC_DATA_8524	equ	8524h
M001_BCC_DATA_85C0	equ	85C0h

BCC_NEAR_BF52	label	near
STAOV0FA	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		push	DS
		mov	AX,85C0h
		push	AX
		push	word ptr DGROUP:M001_BCC_DATA_8524
		mov	AX,DI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		add	AX,0Fh
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_85C0
		mov	word ptr ES:[SI],0
		mov	word ptr ES:[SI+2],0
		mov	word ptr ES:[SI+6],0
		mov	word ptr ES:[SI+4],0
		mov	word ptr ES:[SI+0Ah],0
		mov	word ptr ES:[SI+8],0
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8524
		mov	AX,word ptr ES:[DI+6]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_85C0
		mov	word ptr ES:[SI+0Ch],AX
		push	word ptr DGROUP:M001_BCC_DATA_85C0
		mov	AX,SI
		add	AX,0Eh
		push	AX
		push	word ptr DGROUP:M001_BCC_DATA_8524
		mov	AX,DI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV0FA	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AA87:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M002_BCC_DATA_8524	equ	8524h
M002_BCC_DATA_85C0	equ	85C0h
M002_BCC_DATA_85C4	equ	85C4h

BCC_NEAR_BFD3	label	near
STAOV0FB	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
M002_L_BFE1:
		mov	word ptr [BP-2],SI
		cmp	SI,word ptr DGROUP:M002_BCC_DATA_85C4
		jne	short M002_L_BFF2
		push	DI
		db	0E8h
		dw	0FF64h
		mov	SI,AX
		jmp	short M002_L_BFE1
M002_L_BFF2:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8524
		mov	AX,word ptr ES:[DI+6]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_85C0
		cmp	AX,word ptr ES:[SI+0Ch]
		jne	short M002_L_C050
		push	word ptr DGROUP:M002_BCC_DATA_8524
		mov	AX,DI
		add	AX,8
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_85C0
		mov	AX,SI
		add	AX,0Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M002_L_C050
		mov	ES,word ptr DGROUP:M002_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8524
		mov	DI,word ptr ES:[DI]
		or	DI,DI
		jne	short M002_L_C039
		mov	AX,word ptr [BP-2]
		jmp	short M002_L_C06E
M002_L_C039:
		or	SI,SI
		jne	short M002_L_BFE1
		push	DI
		db	0E8h
		dw	0FF11h
		mov	SI,AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_85C0
		mov	word ptr ES:[BX+2],AX
		jmp	short M002_L_BFE1
M002_L_C050:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI]
		or	SI,SI
		jne	short M002_L_BFE1
		push	DI
		db	0E8h
		dw	0FEF3h
		mov	SI,AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_85C0
		mov	BX,word ptr [BP-2]
		mov	word ptr ES:[BX],AX
		db	0E9h
		dw	0FF73h
M002_L_C06E:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV0FB	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M003_BCC_DATA_8524	equ	8524h


BCC_NEAR_C077	label	near
STAOV0FC	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		or	DI,DI
		jne	short M003_L_C08B
		mov	AX,DX
		jmp	short M003_L_C0A7
M003_L_C08B:
		mov	SI,DI
		jmp	short M003_L_C096
M003_L_C08F:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8524
		mov	SI,word ptr ES:[SI]
M003_L_C096:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8524
		cmp	word ptr ES:[SI],0
		jne	short M003_L_C08F
		mov	AX,DX
		mov	word ptr ES:[SI],AX
		mov	AX,DI
M003_L_C0A7:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV0FC	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AA87:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M004_BCC_DATA_8524	equ	8524h
M004_BCC_DATA_85BE	equ	85BEh
M004_BCC_DATA_85C0	equ	85C0h
M004_BCC_DATA_85C4	equ	85C4h

BCC_NEAR_C0AE	label	near
STAOV0FD	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	word ptr [BP-2],0
M004_L_C0C1:
		cmp	SI,word ptr DGROUP:M004_BCC_DATA_85C4
		jne	short M004_L_C0C9
		jmp	short M004_L_C125
M004_L_C0C9:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8524
		mov	AX,word ptr ES:[DI+6]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_85C0
		cmp	AX,word ptr ES:[SI+0Ch]
		jne	short M004_L_C116
		push	word ptr DGROUP:M004_BCC_DATA_8524
		mov	AX,DI
		add	AX,8
		push	AX
		push	word ptr DGROUP:M004_BCC_DATA_85C0
		mov	AX,SI
		add	AX,0Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M004_L_C116
		mov	word ptr [BP-2],SI
		mov	ES,word ptr DGROUP:M004_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8524
		mov	DI,word ptr ES:[DI]
		or	DI,DI
		jne	short M004_L_C110
		jmp	short M004_L_C125
M004_L_C110:
		or	SI,SI
		jne	short M004_L_C0C1
		jmp	short M004_L_C121
M004_L_C116:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI]
		or	SI,SI
		jne	short M004_L_C0C1
M004_L_C121:
		mov	word ptr DGROUP:M004_BCC_DATA_85BE,DI
M004_L_C125:
		mov	AX,word ptr [BP-2]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV0FD	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP



BCC_NEAR_C131	label	near
STAOV0FE	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	word ptr [BP-2],0
		mov	word ptr [BP-4],0
		mov	SI,3386h
		jmp	short M005_L_C176
M005_L_C148:
		mov	BX,word ptr [SI]
		cmp	word ptr [BX],0
		je	short M005_L_C168
		mov	BX,word ptr [SI]
		mov	AX,word ptr [BX+4]
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		mov	BX,word ptr [SI]
		mov	AX,word ptr [BX+4]
		add	word ptr [BP-4],AX
		adc	word ptr [BP-2],0
		jmp	short M005_L_C170
M005_L_C168:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0FFFFh
M005_L_C170:
		inc	SI
		inc	SI
		add	word ptr [BP+4],2
M005_L_C176:
		cmp	SI,33D0h
		jc	short M005_L_C148
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV0FE	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP



BCC_NEAR_C18A	label	near
STAOV0FF	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,33D0h
		jmp	short M006_L_C1A3
M006_L_C194:
		mov	BX,word ptr [SI]
		mov	AL,byte ptr [BX]
		les	BX,[BP+4]
		mov	byte ptr ES:[BX],AL
		inc	SI
		inc	SI
		inc	word ptr [BP+4]
M006_L_C1A3:
		cmp	SI,33E6h
		jc	short M006_L_C194
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV0FF	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP



BCC_NEAR_C1AF	label	near
STAOV100	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,33D0h
		jmp	short M007_L_C1CF
M007_L_C1B9:
		les	BX,[BP+4]
		mov	AL,byte ptr ES:[BX]
		mov	BX,word ptr [SI]
		cmp	AL,byte ptr [BX]
		je	short M007_L_C1CA
		mov	AX,1
		jmp	short M007_L_C1D7
M007_L_C1CA:
		inc	SI
		inc	SI
		inc	word ptr [BP+4]
M007_L_C1CF:
		cmp	SI,33E6h
		jc	short M007_L_C1B9
		xor	AX,AX
M007_L_C1D7:
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV100	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M008_BCC_DATA_7832	equ	7832h
M008_BCC_DATA_7836	equ	7836h
M008_BCC_DATA_783A	equ	783Ah
M008_BCC_DATA_85B6	equ	85B6h
M008_BCC_DATA_8690	equ	8690h

BCC_NEAR_C1DD	label	near
STAOV101	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,2
		db	0E9h
		dw	0009Fh
M008_L_C1EC:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_783A
		cmp	word ptr ES:[SI+2],0
		jne	short M008_L_C1FA
		db	0E9h
		dw	0008Eh
M008_L_C1FA:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_7832
		mov	BX,word ptr ES:[SI+4]
		mov	AX,word ptr [BX]
		mov	DX,word ptr ES:[SI+2]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		push	DS
		mov	AX,85B6h
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		push	word ptr DGROUP:M008_BCC_DATA_85B6
		push	DI
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DS
		mov	AX,85B6h
		push	AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_783A
		mov	AX,word ptr ES:[SI+2]
		inc	AX
		push	word ptr DGROUP:M008_BCC_DATA_8690
		push	AX
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		inc	AX
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_783A
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8690
		mov	AL,byte ptr ES:[BX]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_85B6
		mov	byte ptr ES:[DI],AL
		inc	DI
		push	word ptr DGROUP:M008_BCC_DATA_85B6
		push	DI
		mov	ES,word ptr DGROUP:M008_BCC_DATA_783A
		mov	AX,word ptr ES:[SI+2]
		inc	AX
		push	word ptr DGROUP:M008_BCC_DATA_8690
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
M008_L_C288:
		add	SI,6
M008_L_C28B:
		cmp	SI,word ptr DGROUP:M008_BCC_DATA_7836
		jnc	short M008_L_C294
		db	0E9h
		dw	0FF58h
M008_L_C294:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV101	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M009_BCC_DATA_85C0	equ	85C0h
M009_BCC_DATA_85CC	equ	85CCh
M009_BCC_DATA_85CE	equ	85CEh


BCC_NEAR_C29B	label	near
STAOV102	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		xor	SI,SI
		xor	DI,DI
		mov	AX,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-8],DX
		jmp	short M009_L_C2EB
M009_L_C2B6:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_85C0
		mov	AX,word ptr ES:[SI+8]
		mov	DX,word ptr ES:[SI+6]
		sub	DX,word ptr [BP+4]
		sbb	AX,word ptr [BP+6]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		mov	AX,word ptr [BP-2]
		cmp	AX,word ptr [BP-6]
		jg	short M009_L_C2EB
		jl	short M009_L_C2DD
		cmp	DX,word ptr [BP-8]
		jnc	short M009_L_C2EB
M009_L_C2DD:
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-8],DX
		mov	DI,SI
M009_L_C2EB:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI]
		or	SI,SI
		jne	short M009_L_C2B6
		or	DI,DI
		je	short M009_L_C314
		mov	ES,word ptr DGROUP:M009_BCC_DATA_85C0
		mov	word ptr ES:[DI+8],0
		mov	word ptr ES:[DI+6],0
		mov	DX,word ptr ES:[DI+4]
		mov	AX,word ptr ES:[DI+2]
		jmp	short M009_L_C335
M009_L_C314:
		mov	AX,DGROUP:M009_BCC_DATA_85CE
		mov	DX,word ptr DGROUP:M009_BCC_DATA_85CC
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-0Ch],DX
		mov	AX,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		add	word ptr DGROUP:M009_BCC_DATA_85CC,DX
		adc	word ptr DGROUP:M009_BCC_DATA_85CE,AX
		mov	DX,word ptr [BP-0Ah]
		mov	AX,word ptr [BP-0Ch]
M009_L_C335:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV102	endp
CO069_TEXT	ends


		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00A_BCC_DATA_85C0	equ	85C0h

BCC_NEAR_C33E	label	near
STAOV103	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	AX,word ptr [BP+4]
		or	AX,word ptr [BP+6]
		je	short M00A_L_C3A7
		xor	DI,DI
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_85C0
		mov	SI,word ptr ES:[DI]
M00A_L_C355:
		or	SI,SI
		jne	short M00A_L_C36B
		push	DS
		mov	AX,85C0h
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		jmp	short M00A_L_C382
M00A_L_C36B:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_85C0
		mov	AX,word ptr ES:[SI+6]
		or	AX,word ptr ES:[SI+8]
		je	short M00A_L_C382
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_85C0
		mov	SI,word ptr ES:[SI]
		jmp	short M00A_L_C355
M00A_L_C382:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_85C0
		mov	word ptr ES:[SI],DI
		mov	AX,word ptr [BP+0Ah]
		mov	DX,word ptr [BP+8]
		mov	word ptr ES:[SI+4],AX
		mov	word ptr ES:[SI+2],DX
		mov	AX,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		mov	word ptr ES:[SI+8],AX
		mov	word ptr ES:[SI+6],DX
		mov	DI,SI
M00A_L_C3A7:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	8
STAOV103	endp
CO069_TEXT	ends


		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_AB75:far
		extrn	BCC_FAR_AB9B:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00B_BCC_DATA_1766	equ	1766h
M00B_BCC_DATA_1768	equ	1768h
M00B_BCC_DATA_85D2	equ	85D2h

BCC_NEAR_C3AE	label	near
STAOV104	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		or	SI,SI
		jne	short M00B_L_C3BE
M00B_L_C3BA:
		xor	AX,AX
		jmp	short M00B_L_C3F3
M00B_L_C3BE:
		push	word ptr DGROUP:M00B_BCC_DATA_85D2
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SI
		db	09Ah
		dw	BCC_FAR_AB9B
		dw	seg BCC_FAR_AB9B
		cmp	AX,SI
		jne	short M00B_L_C3D4
		jmp	short M00B_L_C3BA
M00B_L_C3D4:
		push	word ptr DGROUP:M00B_BCC_DATA_85D2
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		mov	word ptr DGROUP:M00B_BCC_DATA_85D2,0FFFFh
		push	word ptr DGROUP:M00B_BCC_DATA_1768
		push	word ptr DGROUP:M00B_BCC_DATA_1766
		db	09Ah
		dw	BCC_FAR_AB75
		dw	seg BCC_FAR_AB75
		mov	AX,1
M00B_L_C3F3:
		pop	SI
		pop	BP
		dec	BP
		ret	6
STAOV104	endp
CO069_TEXT	ends


		extrn	BCC_FAR_A99E:far
		extrn	BCC_FAR_A9E0:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00C_BCC_DATA_85C0	equ	85C0h
M00C_BCC_DATA_85D2	equ	85D2h
M00C_BCC_DATA_85DA	equ	85DAh

BCC_NEAR_C3F9	label	near
STAOV105	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,70h
		push	SI
		cmp	word ptr DGROUP:M00C_BCC_DATA_85D2,0
		jge	short M00C_L_C40B
		db	0E9h
		dw	000A5h
M00C_L_C40B:
		mov	AX,2
		push	AX
		push	word ptr DGROUP:M00C_BCC_DATA_85DA
		db	0E8h
		dw	0FBBDh
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_85C0
		mov	AX,word ptr ES:[SI+4]
		or	AX,word ptr ES:[SI+6]
		jne	short M00C_L_C429
		db	0E9h
		dw	00087h
M00C_L_C429:
		push	word ptr DGROUP:M00C_BCC_DATA_85D2
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_85C0
		push	word ptr ES:[SI+6]
		push	word ptr ES:[SI+4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_85C0
		cmp	DX,word ptr ES:[SI+6]
		jne	short M00C_L_C4B0
		cmp	AX,word ptr ES:[SI+4]
		jne	short M00C_L_C4B0
		push	word ptr DGROUP:M00C_BCC_DATA_85D2
		push	SS
		lea	AX,[BP-70h]
		push	AX
		mov	AX,70h
		push	AX
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,70h
		jne	short M00C_L_C4B0
		cmp	word ptr [BP-70h],0EDFEh
		jne	short M00C_L_C4B0
		cmp	word ptr [BP-6Eh],6
		jne	short M00C_L_C4B0
		inc	word ptr [BP-70h]
		push	word ptr DGROUP:M00C_BCC_DATA_85D2
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_85C0
		push	word ptr ES:[SI+6]
		push	word ptr ES:[SI+4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_85C0
		cmp	DX,word ptr ES:[SI+6]
		jne	short M00C_L_C4B0
		cmp	AX,word ptr ES:[SI+4]
		jne	short M00C_L_C4B0
		push	SS
		lea	AX,[BP-70h]
		push	AX
		mov	AX,70h
		push	AX
		db	0E8h
		dw	0FF02h
		or	AX,AX
		je	short M00C_L_C4B0
M00C_L_C4B0:
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV105	endp
CO069_TEXT	ends


		extrn	BCC_FAR_A7E2:far
		extrn	BCC_FAR_A99E:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00D_BCC_DATA_0000	equ	0
M00D_BCC_DATA_1766	equ	1766h
M00D_BCC_DATA_1768	equ	1768h
M00D_BCC_DATA_5EBE	equ	5EBEh
M00D_BCC_DATA_615E	equ	615Eh
M00D_BCC_DATA_617A	equ	617Ah
M00D_BCC_DATA_7846	equ	7846h
M00D_BCC_DATA_784A	equ	784Ah
M00D_BCC_DATA_8230	equ	8230h
M00D_BCC_DATA_852C	equ	852Ch
M00D_BCC_DATA_85B6	equ	85B6h
M00D_BCC_DATA_85BA	equ	85BAh
M00D_BCC_DATA_85C0	equ	85C0h
M00D_BCC_DATA_85C4	equ	85C4h
M00D_BCC_DATA_85C8	equ	85C8h
M00D_BCC_DATA_85CA	equ	85CAh
M00D_BCC_DATA_85CC	equ	85CCh
M00D_BCC_DATA_85CE	equ	85CEh
M00D_BCC_DATA_85D0	equ	85D0h
M00D_BCC_DATA_85D2	equ	85D2h
M00D_BCC_DATA_85DA	equ	85DAh
M00D_BCC_DATA_85DC	equ	85DCh
M00D_BCC_DATA_85E0	equ	85E0h
M00D_BCC_DATA_85F2	equ	85F2h
M00D_BCC_DATA_8898	equ	8898h

BCC_NEAR_C4B6	label	near
STAOV106	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,74h
		push	SI
		push	DI
		cmp	word ptr DGROUP:M00D_BCC_DATA_85D2,0
		jge	short M00D_L_C519
		push	word ptr DGROUP:M00D_BCC_DATA_1768
		push	word ptr DGROUP:M00D_BCC_DATA_1766
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A7E2
		dw	seg BCC_FAR_A7E2
		mov	DGROUP:M00D_BCC_DATA_85D2,AX
		cmp	word ptr DGROUP:M00D_BCC_DATA_85D2,0
		jge	short M00D_L_C4E3
		db	0E9h
		dw	0022Bh
M00D_L_C4E3:
		mov	word ptr DGROUP:M00D_BCC_DATA_85C8,0D03Ch
		mov	word ptr DGROUP:M00D_BCC_DATA_85CA,2
		mov	word ptr DGROUP:M00D_BCC_DATA_85CE,0
		mov	word ptr DGROUP:M00D_BCC_DATA_85CC,0Ah
		push	DS
		mov	AX,85C8h
		push	AX
		mov	AX,0Ah
		push	AX
		db	0E8h
		dw	0FEA7h
		or	AX,AX
		je	short M00D_L_C50E
		db	0E9h
		dw	00200h
M00D_L_C50E:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		db	026h,0C7h,006h,0,0,0,0
M00D_L_C519:
		mov	AX,2
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_85DA
		db	0E8h
		dw	0FAAFh
		mov	SI,AX
		mov	AX,DGROUP:M00D_BCC_DATA_85C4
		mov	DGROUP:M00D_BCC_DATA_85D0,AX
		mov	word ptr [BP-74h],0EDFEh
		mov	word ptr [BP-72h],6
		mov	word ptr [BP-68h],0Bh
		mov	AX,DGROUP:M00D_BCC_DATA_615E
		mov	word ptr [BP-66h],AX
		mov	AX,DGROUP:M00D_BCC_DATA_85F2
		mov	word ptr [BP-64h],AX
		mov	AX,DGROUP:M00D_BCC_DATA_617A
		mov	word ptr [BP-62h],AX
		mov	AX,DGROUP:M00D_BCC_DATA_5EBE
		mov	word ptr [BP-60h],AX
		mov	AX,DGROUP:M00D_BCC_DATA_8230
		mov	word ptr [BP-5Eh],AX
		mov	AL,DGROUP:M00D_BCC_DATA_852C
		mov	byte ptr [BP-5Ch],AL
		push	SS
		lea	AX,[BP-5Bh]
		push	AX
		db	0E8h
		dw	0FC23h
		mov	word ptr [BP-50h],25h
		mov	AX,DGROUP:M00D_BCC_DATA_85BA
		mov	word ptr [BP-70h],AX
		mov	AX,DGROUP:M00D_BCC_DATA_85E0
		mov	word ptr [BP-6Eh],AX
		mov	AX,DGROUP:M00D_BCC_DATA_784A
		mov	word ptr [BP-6Ch],AX
		mov	AX,DGROUP:M00D_BCC_DATA_8898
		mov	word ptr [BP-6Ah],AX
		push	SS
		lea	AX,[BP-4Eh]
		push	AX
		db	0E8h
		dw	0FBA5h
		mov	BX,word ptr [BP-70h]
		add	BX,word ptr [BP-6Eh]
		add	BX,word ptr [BP-6Ch]
		add	BX,800h
		xor	CX,CX
		add	BX,AX
		adc	CX,DX
		add	BX,70h
		adc	CX,0
		mov	word ptr [BP-2],CX
		mov	word ptr [BP-4],BX
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		mov	AX,word ptr ES:[SI+0Ah]
		mov	DX,word ptr ES:[SI+8]
		cmp	AX,word ptr [BP-2]
		jg	short M00D_L_C606
		jl	short M00D_L_C5C3
		cmp	DX,word ptr [BP-4]
		jnc	short M00D_L_C606
M00D_L_C5C3:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		push	word ptr ES:[SI+6]
		push	word ptr ES:[SI+4]
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0FD64h
		add	word ptr [BP-4],800h
		adc	word ptr [BP-2],0
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	0E8h
		dw	0FCAFh
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		mov	word ptr ES:[SI+6],DX
		mov	word ptr ES:[SI+4],AX
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr ES:[SI+0Ah],AX
		mov	word ptr ES:[SI+8],DX
M00D_L_C606:
		push	word ptr DGROUP:M00D_BCC_DATA_85D2
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		push	word ptr ES:[SI+6]
		push	word ptr ES:[SI+4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_85C0
		cmp	DX,word ptr ES:[SI+6]
		je	short M00D_L_C62B
		db	0E9h
		dw	000E3h
M00D_L_C62B:
		cmp	AX,word ptr ES:[SI+4]
		je	short M00D_L_C634
		db	0E9h
		dw	000DAh
M00D_L_C634:
		push	SS
		lea	AX,[BP-74h]
		push	AX
		mov	AX,70h
		push	AX
		db	0E8h
		dw	0FD6Eh
		or	AX,AX
		je	short M00D_L_C647
		db	0E9h
		dw	000C7h
M00D_L_C647:
		push	word ptr DGROUP:M00D_BCC_DATA_85B6
		xor	AX,AX
		push	AX
		push	word ptr [BP-70h]
		db	0E8h
		dw	0FD5Ah
		or	AX,AX
		je	short M00D_L_C65B
		db	0E9h
		dw	000B3h
M00D_L_C65B:
		push	word ptr DGROUP:M00D_BCC_DATA_85DC
		xor	AX,AX
		push	AX
		push	word ptr [BP-6Eh]
		db	0E8h
		dw	0FD46h
		or	AX,AX
		je	short M00D_L_C66F
		db	0E9h
		dw	0009Fh
M00D_L_C66F:
		push	word ptr DGROUP:M00D_BCC_DATA_7846
		xor	AX,AX
		push	AX
		push	word ptr [BP-6Ch]
		db	0E8h
		dw	0FD32h
		or	AX,AX
		je	short M00D_L_C683
		db	0E9h
		dw	0008Bh
M00D_L_C683:
		mov	DI,3386h
		jmp	short M00D_L_C6A4
M00D_L_C688:
		mov	BX,word ptr [DI]
		cmp	word ptr [BX],0
		je	short M00D_L_C6A2
		mov	BX,word ptr [DI]
		push	word ptr [BX]
		xor	AX,AX
		push	AX
		mov	BX,word ptr [DI]
		push	word ptr [BX+4]
		db	0E8h
		dw	0FD10h
		or	AX,AX
		jne	short M00D_L_C70E
M00D_L_C6A2:
		inc	DI
		inc	DI
M00D_L_C6A4:
		cmp	DI,33D0h
		jc	short M00D_L_C688
		push	DS
		mov	AX,78ACh
		push	AX
		mov	AX,800h
		push	AX
		db	0E8h
		dw	0FCF8h
		or	AX,AX
		jne	short M00D_L_C70E
		push	word ptr DGROUP:M00D_BCC_DATA_85D2
		push	word ptr DGROUP:M00D_BCC_DATA_85CE
		push	word ptr DGROUP:M00D_BCC_DATA_85CC
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		cmp	DX,word ptr DGROUP:M00D_BCC_DATA_85CE
		jne	short M00D_L_C70E
		cmp	AX,word ptr DGROUP:M00D_BCC_DATA_85CC
		jne	short M00D_L_C70E
		push	word ptr DGROUP:M00D_BCC_DATA_85C0
		xor	AX,AX
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_85C4
		db	0E8h
		dw	0FCC6h
		or	AX,AX
		jne	short M00D_L_C70E
		push	word ptr DGROUP:M00D_BCC_DATA_85D2
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		or	AX,DX
		jne	short M00D_L_C70E
		push	DS
		mov	AX,85C8h
		push	AX
		mov	AX,0Ah
		push	AX
		db	0E8h
		dw	0FCA2h
		or	AX,AX
M00D_L_C70E:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV106	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00E_BCC_DATA_7832	equ	7832h
M00E_BCC_DATA_7836	equ	7836h


BCC_NEAR_C715	label	near
STAOV107	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,2
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7832
		mov	AX,784Eh
		sub	AX,word ptr ES:[SI+4]
		mov	DI,AX
		or	DI,DI
		jne	short M00E_L_C742
		jmp	short M00E_L_C748
M00E_L_C731:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7832
		mov	AX,word ptr ES:[SI+4]
		add	AX,DI
		mov	word ptr ES:[SI+4],AX
		add	SI,6
M00E_L_C742:
		cmp	SI,word ptr DGROUP:M00E_BCC_DATA_7836
		jc	short M00E_L_C731
M00E_L_C748:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret
STAOV107	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M00F_BCC_DATA_85B6	equ	85B6h


BCC_NEAR_C74D	label	near
STAOV108	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		jmp	short M00F_L_C772
M00F_L_C75E:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_85B6
		mov	AL,byte ptr ES:[SI]
		cmp	AL,byte ptr ES:[DI]
		je	short M00F_L_C76F
		mov	AX,1
		jmp	short M00F_L_C778
M00F_L_C76F:
		dec	DX
		inc	SI
		inc	DI
M00F_L_C772:
		or	DX,DX
		jne	short M00F_L_C75E
		xor	AX,AX
M00F_L_C778:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	6
STAOV108	endp
CO069_TEXT	ends


		extrn	BCC_FAR_B072:far
		extrn	X037_00:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M010_BCC_DATA_85DC	equ	85DCh

BCC_NEAR_C77F	label	near
STAOV109	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,50h
		push	SI
		mov	SI,2
		jmp	short M010_L_C7C3
M010_L_C78C:
		push	SS
		lea	AX,[BP-50h]
		push	AX
		push	word ptr DGROUP:M010_BCC_DATA_85DC
		mov	AX,SI
		add	AX,6
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DX
		push	AX
		db	09Ah
		dw	X037_00
		dw	seg X037_00
		mov	ES,word ptr DGROUP:M010_BCC_DATA_85DC
		cmp	DX,word ptr ES:[SI+4]
		jne	short M010_L_C7B7
		cmp	AX,word ptr ES:[SI+2]
		je	short M010_L_C7BC
M010_L_C7B7:
		mov	AX,1
		jmp	short M010_L_C7C9
M010_L_C7BC:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_85DC
		mov	SI,word ptr ES:[SI]
M010_L_C7C3:
		or	SI,SI
		jne	short M010_L_C78C
		xor	AX,AX
M010_L_C7C9:
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV109	endp
CO069_TEXT	ends


		extrn	BCC_FAR_B072:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M011_BCC_DATA_85DC	equ	85DCh
M011_BCC_DATA_87CC	equ	87CCh

BCC_NEAR_C7CF	label	near
STAOV10A	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,50h
		push	SI
		mov	SI,2
		jmp	short M011_L_C7FD
M011_L_C7DC:
		push	SS
		lea	AX,[BP-50h]
		push	AX
		push	word ptr DGROUP:M011_BCC_DATA_85DC
		mov	AX,SI
		add	AX,6
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DX
		push	AX
		db	0FFh,01Eh
		dw	87CCh
		mov	ES,word ptr DGROUP:M011_BCC_DATA_85DC
		mov	SI,word ptr ES:[SI]
M011_L_C7FD:
		or	SI,SI
		jne	short M011_L_C7DC
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV10A	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M012_BCC_DATA_818E	equ	818Eh
M012_BCC_DATA_8192	equ	8192h
M012_BCC_DATA_86CA	equ	86CAh


BCC_NEAR_C807	label	near
STAOV10B	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,2
		jmp	short M012_L_C830
M012_L_C811:
		mov	ES,word ptr DGROUP:M012_BCC_DATA_818E
		mov	AX,word ptr ES:[SI+4]
		cmp	AX,word ptr DGROUP:M012_BCC_DATA_86CA
		jbe	short M012_L_C826
		mov	AX,word ptr ES:[SI+4]
		mov	DGROUP:M012_BCC_DATA_86CA,AX
M012_L_C826:
		mov	ES,word ptr DGROUP:M012_BCC_DATA_818E
		mov	AX,word ptr [BP+4]
		add	word ptr ES:[SI],AX
M012_L_C830:
		add	SI,0Eh
		cmp	SI,word ptr DGROUP:M012_BCC_DATA_8192
		jc	short M012_L_C811
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV10B	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AB12:far
		extrn	X02E_04:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M013_BCC_DATA_85E4	equ	85E4h
M013_BCC_DATA_85E8	equ	85E8h

BCC_NEAR_C83F	label	near
STAOV10C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		xor	SI,SI
		db	0E9h
		dw	000A3h
M013_L_C84D:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		cmp	byte ptr ES:[SI],3Dh
		jne	short M013_L_C86A
		mov	AX,SI
		inc	AX
		push	word ptr DGROUP:M013_BCC_DATA_85E4
		push	AX
		mov	AX,1
		push	AX
		db	09Ah
		dw	X02E_04
		dw	seg X02E_04
		jmp	short M013_L_C8E3
M013_L_C86A:
		xor	DI,DI
		mov	word ptr [BP-2],DS
		mov	word ptr [BP-4],8B9h
		jmp	short M013_L_C8DA
M013_L_C876:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		mov	AL,byte ptr ES:[SI+1]
		les	BX,[BP-4]
		cmp	AL,byte ptr ES:[BX]
		jne	short M013_L_C8D5
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		mov	AL,byte ptr ES:[SI+2]
		mov	ES,word ptr [BP-2]
		cmp	AL,byte ptr ES:[BX+1]
		jne	short M013_L_C8D5
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		mov	AL,byte ptr ES:[SI+3]
		mov	ES,word ptr [BP-2]
		cmp	AL,byte ptr ES:[BX+2]
		jne	short M013_L_C8D5
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		cmp	byte ptr ES:[SI],2Eh
		jne	short M013_L_C8BF
		mov	ES,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX+3]
		mov	byte ptr [DI+643Ah],AL
		jmp	short M013_L_C8D5
M013_L_C8BF:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_85E4
		cmp	byte ptr ES:[SI],2Bh
		jne	short M013_L_C8D0
		mov	byte ptr [DI+643Ah],1
		jmp	short M013_L_C8D5
M013_L_C8D0:
		mov	byte ptr [DI+643Ah],0
M013_L_C8D5:
		add	word ptr [BP-4],4
		inc	DI
M013_L_C8DA:
		les	BX,[BP-4]
		cmp	byte ptr ES:[BX],0
		jne	short M013_L_C876
M013_L_C8E3:
		push	word ptr DGROUP:M013_BCC_DATA_85E4
		push	SI
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		add	SI,AX
M013_L_C8F0:
		cmp	SI,word ptr DGROUP:M013_BCC_DATA_85E8
		jnc	short M013_L_C8F9
		db	0E9h
		dw	0FF54h
M013_L_C8F9:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV10C	endp
CO069_TEXT	ends


		extrn	BCC_FAR_0402:far
		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_A99E:far
		extrn	BCC_FAR_A9C1:far
		extrn	BCC_FAR_A9E0:far
		extrn	BCC_FAR_ABBB:far
		extrn	X02E_09:far
		extrn	X035_00:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M014_BCC_DATA_1714	equ	1714h
M014_BCC_DATA_1765	equ	1765h
M014_BCC_DATA_1766	equ	1766h
M014_BCC_DATA_1768	equ	1768h
M014_BCC_DATA_5EBE	equ	5EBEh
M014_BCC_DATA_615E	equ	615Eh
M014_BCC_DATA_617A	equ	617Ah
M014_BCC_DATA_7846	equ	7846h
M014_BCC_DATA_784A	equ	784Ah
M014_BCC_DATA_8100	equ	8100h
M014_BCC_DATA_818E	equ	818Eh
M014_BCC_DATA_8192	equ	8192h
M014_BCC_DATA_8194	equ	8194h
M014_BCC_DATA_8230	equ	8230h
M014_BCC_DATA_85B6	equ	85B6h
M014_BCC_DATA_85BA	equ	85BAh
M014_BCC_DATA_85BC	equ	85BCh
M014_BCC_DATA_85C0	equ	85C0h
M014_BCC_DATA_85C4	equ	85C4h
M014_BCC_DATA_85CC	equ	85CCh
M014_BCC_DATA_85CE	equ	85CEh
M014_BCC_DATA_85D0	equ	85D0h
M014_BCC_DATA_85D2	equ	85D2h
M014_BCC_DATA_85DA	equ	85DAh
M014_BCC_DATA_85DC	equ	85DCh
M014_BCC_DATA_85F2	equ	85F2h
M014_BCC_DATA_8898	equ	8898h

BCC_NEAR_C900	label	near
STAOV10D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,88h
		push	SI
		push	DI
		push	word ptr DGROUP:M014_BCC_DATA_1768
		push	word ptr DGROUP:M014_BCC_DATA_1766
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_A9C1
		dw	seg BCC_FAR_A9C1
		mov	DGROUP:M014_BCC_DATA_85D2,AX
		cmp	word ptr DGROUP:M014_BCC_DATA_85D2,0
		jge	short M014_L_C92B
M014_L_C925:
		mov	AX,0FFFFh
		db	0E9h
		dw	0031Ah
M014_L_C92B:
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	DS
		mov	AX,85C8h
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,0Ah
		je	short M014_L_C944
		jmp	short M014_L_C925
M014_L_C944:
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	word ptr DGROUP:M014_BCC_DATA_85CE
		push	word ptr DGROUP:M014_BCC_DATA_85CC
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		cmp	DX,word ptr DGROUP:M014_BCC_DATA_85CE
		jne	short M014_L_C964
		cmp	AX,word ptr DGROUP:M014_BCC_DATA_85CC
		je	short M014_L_C966
M014_L_C964:
		jmp	short M014_L_C925
M014_L_C966:
		push	DS
		mov	AX,85C0h
		push	AX
		mov	AX,DGROUP:M014_BCC_DATA_85D0
		sub	AX,word ptr DGROUP:M014_BCC_DATA_85C4
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	word ptr DGROUP:M014_BCC_DATA_85C0
		xor	AX,AX
		push	AX
		push	word ptr DGROUP:M014_BCC_DATA_85D0
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,word ptr DGROUP:M014_BCC_DATA_85D0
		je	short M014_L_C994
		jmp	short M014_L_C925
M014_L_C994:
		cmp	byte ptr DGROUP:M014_BCC_DATA_1765,1
		jg	short M014_L_C99D
		jmp	short M014_L_C925
M014_L_C99D:
		mov	AX,2
		push	AX
		push	word ptr DGROUP:M014_BCC_DATA_85DA
		db	0E8h
		dw	0F706h
		mov	DI,AX
		or	DI,DI
		je	short M014_L_C9BC
		mov	ES,word ptr DGROUP:M014_BCC_DATA_85C0
		mov	AX,word ptr ES:[DI+4]
		or	AX,word ptr ES:[DI+6]
		jne	short M014_L_C9BF
M014_L_C9BC:
		db	0E9h
		dw	0FF66h
M014_L_C9BF:
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		mov	ES,word ptr DGROUP:M014_BCC_DATA_85C0
		push	word ptr ES:[DI+6]
		push	word ptr ES:[DI+4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A99E
		dw	seg BCC_FAR_A99E
		mov	ES,word ptr DGROUP:M014_BCC_DATA_85C0
		cmp	DX,word ptr ES:[DI+6]
		jne	short M014_L_C9E7
		cmp	AX,word ptr ES:[DI+4]
		je	short M014_L_C9EA
M014_L_C9E7:
		db	0E9h
		dw	0FF3Bh
M014_L_C9EA:
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	SS
		lea	AX,[BP-7Ah]
		push	AX
		mov	AX,70h
		push	AX
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,70h
		je	short M014_L_CA04
		db	0E9h
		dw	0FF21h
M014_L_CA04:
		cmp	byte ptr [BP-62h],0
		je	short M014_L_CA2A
		mov	AL,DGROUP:M014_BCC_DATA_1714
		cbw
		or	AX,AX
		jne	short M014_L_CA2A
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		mov	word ptr DGROUP:M014_BCC_DATA_85D2,0FFFFh
		mov	AX,3
		push	AX
		db	09Ah
		dw	X02E_09
		dw	seg X02E_09
M014_L_CA2A:
		cmp	word ptr [BP-7Ah],0EDFEh
		jne	short M014_L_CA4F
		cmp	word ptr [BP-78h],6
		jne	short M014_L_CA4F
		cmp	word ptr [BP-6Eh],0Bh
		jne	short M014_L_CA4F
		push	SS
		lea	AX,[BP-61h]
		push	AX
		db	0E8h
		dw	0F76Ah
		or	AX,AX
		jne	short M014_L_CA4F
		cmp	word ptr [BP-56h],25h
		je	short M014_L_CA52
M014_L_CA4F:
		db	0E9h
		dw	0FED3h
M014_L_CA52:
		push	DS
		mov	AX,85B6h
		push	AX
		push	word ptr [BP-76h]
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	word ptr [BP-6],AX
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	word ptr DGROUP:M014_BCC_DATA_85B6
		push	word ptr [BP-6]
		push	word ptr [BP-76h]
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,word ptr [BP-76h]
		je	short M014_L_CA7D
		db	0E9h
		dw	0FEA8h
M014_L_CA7D:
		mov	AX,word ptr [BP-76h]
		cmp	AX,word ptr [BP-6]
		jne	short M014_L_CA95
		xor	AX,AX
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-76h]
		db	0E8h
		dw	0FCBCh
		or	AX,AX
		je	short M014_L_CAA4
M014_L_CA95:
		mov	word ptr DGROUP:M014_BCC_DATA_85BC,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M014_BCC_DATA_85BA,AX
		db	0E9h
		dw	0FE81h
M014_L_CAA4:
		mov	word ptr DGROUP:M014_BCC_DATA_85BC,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M014_BCC_DATA_85BA,AX
		push	DS
		mov	AX,85DCh
		push	AX
		push	word ptr [BP-74h]
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	word ptr DGROUP:M014_BCC_DATA_85DC
		xor	AX,AX
		push	AX
		push	word ptr [BP-74h]
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,word ptr [BP-74h]
		je	short M014_L_CAD8
		db	0E9h
		dw	0FE4Dh
M014_L_CAD8:
		cmp	byte ptr DGROUP:M014_BCC_DATA_1765,2
		jne	short M014_L_CAE9
		db	0E8h
		dw	0FC9Dh
		or	AX,AX
		je	short M014_L_CAE9
		db	0E9h
		dw	0FE3Ch
M014_L_CAE9:
		db	0FFh,01Eh
		dw	8100h
		mov	AX,DGROUP:M014_BCC_DATA_784A
		mov	word ptr [BP-8],AX
		push	DS
		mov	AX,7846h
		push	AX
		push	word ptr [BP-72h]
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	word ptr DGROUP:M014_BCC_DATA_7846
		push	word ptr [BP-8]
		push	word ptr [BP-72h]
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,word ptr [BP-72h]
		je	short M014_L_CB1B
		db	0E9h
		dw	0FE0Ah
M014_L_CB1B:
		mov	AX,DGROUP:M014_BCC_DATA_8192
		mov	word ptr [BP-0Ah],AX
		cmp	word ptr [BP-0Ah],2
		jbe	short M014_L_CB44
		lea	AX,[BP+0FF78h]
		push	SS
		push	AX
		mov	AX,2
		push	word ptr DGROUP:M014_BCC_DATA_818E
		push	AX
		mov	CX,0Eh
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		jmp	short M014_L_CB44
M014_L_CB3F:
		db	09Ah
		dw	X035_00
		dw	seg X035_00
M014_L_CB44:
		mov	AX,DGROUP:M014_BCC_DATA_8898
		cmp	AX,word ptr [BP-70h]
		jc	short M014_L_CB3F
		mov	SI,3386h
		lea	AX,[BP-54h]
		mov	word ptr [BP-2],SS
		mov	word ptr [BP-4],AX
		jmp	short M014_L_CBC3
M014_L_CB5A:
		les	BX,[BP-4]
		cmp	word ptr ES:[BX],-1
		je	short M014_L_CBBD
		mov	BX,word ptr [SI]
		cmp	word ptr [BX],0
		jne	short M014_L_CB88
		mov	BX,word ptr [SI]
		xor	AX,AX
		mov	word ptr [BX+2],AX
		mov	BX,word ptr [SI]
		mov	word ptr [BX+4],AX
		mov	BX,word ptr [SI]
		mov	word ptr [BX+6],0
		push	DS
		push	word ptr [SI]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
M014_L_CB88:
		push	DS
		push	word ptr [SI]
		les	BX,[BP-4]
		mov	AX,word ptr ES:[BX]
		mov	BX,word ptr [SI]
		sub	AX,word ptr [BX+4]
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		mov	BX,word ptr [SI]
		push	word ptr [BX]
		xor	AX,AX
		push	AX
		les	BX,[BP-4]
		push	word ptr ES:[BX]
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		les	BX,[BP-4]
		cmp	AX,word ptr ES:[BX]
		je	short M014_L_CBBD
		db	0E9h
		dw	0FD68h
M014_L_CBBD:
		inc	SI
		inc	SI
		add	word ptr [BP-4],2
M014_L_CBC3:
		cmp	SI,33D0h
		jc	short M014_L_CB5A
		push	word ptr DGROUP:M014_BCC_DATA_85D2
		push	DS
		mov	AX,78ACh
		push	AX
		mov	AX,800h
		push	AX
		db	09Ah
		dw	BCC_FAR_A9E0
		dw	seg BCC_FAR_A9E0
		cmp	AX,800h
		je	short M014_L_CBE3
		db	0E9h
		dw	0FD42h
M014_L_CBE3:
		db	0E8h
		dw	0FB2Fh
		db	0E8h
		dw	0FC56h
		cmp	word ptr [BP-0Ah],2
		jbe	short M014_L_CC0D
		mov	AX,2
		push	word ptr DGROUP:M014_BCC_DATA_818E
		push	AX
		lea	AX,[BP+0FF78h]
		push	SS
		push	AX
		mov	CX,0Eh
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		push	word ptr [BP-8]
		db	0E8h
		dw	0FBFCh
		jmp	short M014_L_CC19
M014_L_CC0D:
		mov	word ptr DGROUP:M014_BCC_DATA_8194,0
		mov	AX,word ptr [BP-0Ah]
		mov	DGROUP:M014_BCC_DATA_8192,AX
M014_L_CC19:
		mov	AX,word ptr [BP-6Ch]
		mov	DGROUP:M014_BCC_DATA_615E,AX
		mov	AX,word ptr [BP-6Ah]
		mov	DGROUP:M014_BCC_DATA_85F2,AX
		mov	AX,word ptr [BP-68h]
		mov	DGROUP:M014_BCC_DATA_617A,AX
		mov	AX,word ptr [BP-66h]
		mov	DGROUP:M014_BCC_DATA_5EBE,AX
		mov	AX,word ptr [BP-64h]
		mov	DGROUP:M014_BCC_DATA_8230,AX
		push	DS
		mov	AX,340Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_ABBB
		dw	seg BCC_FAR_ABBB
		pop	CX
		pop	CX
		xor	AX,AX
M014_L_CC45:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV10D	endp
CO069_TEXT	ends


		extrn	X030_00:far
		extrn	X031_04:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M015_BCC_DATA_66BE	equ	66BEh
M015_BCC_DATA_77D3	equ	77D3h
M015_BCC_DATA_8292	equ	8292h

BCC_NEAR_CC4C	label	near
STAOV10E	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
M015_L_CC52:
		mov	AX,20h
		push	AX
		db	09Ah
		dw	X030_00
		dw	seg X030_00
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],23h
		jne	short M015_L_CC95
		mov	AX,DGROUP:M015_BCC_DATA_77D3
		mov	DGROUP:M015_BCC_DATA_66BE,AX
		mov	AX,20h
		push	AX
		db	09Ah
		dw	X030_00
		dw	seg X030_00
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		cmp	byte ptr [BX+2101h],0ECh
		jne	short M015_L_CC8B
M015_L_CC80:
		mov	AL,byte ptr [BP-2]
		push	AX
		db	09Ah
		dw	X031_04
		dw	seg X031_04
		jmp	short M015_L_CC52
M015_L_CC8B:
		cmp	word ptr [BP-2],1Ah
		jne	short M015_L_CCA7
M015_L_CC91:
		xor	AX,AX
		jmp	short M015_L_CCAE
M015_L_CC95:
		mov	BX,word ptr [BP-2]
		cmp	byte ptr [BX+2101h],0ECh
		jne	short M015_L_CCA1
		jmp	short M015_L_CC80
M015_L_CCA1:
		dec	word ptr DGROUP:M015_BCC_DATA_8292
		jmp	short M015_L_CC91
M015_L_CCA7:
		dec	word ptr DGROUP:M015_BCC_DATA_8292
		mov	AX,1
M015_L_CCAE:
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV10E	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,056h,08Bh,076h,004h,01Eh,0B8h,030h,085h,050h,01Eh	; ovr_1da8_abec:CCB3
		db	0B8h,028h,034h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,030h,085h,050h; ovr_1da8_abec:CCC1
		db	01Eh,0FFh,076h,006h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,0B8h,030h,085h,050h; ovr_1da8_abec:CCCF
		db	01Eh,0B8h,02Ah,034h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0FFh,00Eh,092h,082h; ovr_1da8_abec:CCDD
		db	00Bh,0F6h,074h,018h,01Eh,0B8h,031h,085h,050h,09Ah
		dw	057h
		dw	seg CO032_TEXT
		db	0B8h,020h,000h,050h,09Ah
		dw	039h
		dw	seg CO030_TEXT
		db	0C6h,006h,030h,085h,000h; ovr_1da8_abec:CCF9
		db	08Bh,0C6h,05Eh,05Dh,04Dh,0C2h,004h,000h,045h,055h,08Bh,0ECh,056h,0FFh	; ovr_1da8_abec:CD07
		db	076h,004h,09Ah
		dw	048h
		dw	seg CO030_TEXT
		db	089h,046h,004h,01Eh,0B8h,02Ch,034h; ovr_1da8_abec:CD15
		db	050h,01Eh,0B8h,09Eh,077h,050h,09Ah
		dw	07h
		dw	seg BCC_COMPARE_NAME
		db	00Bh,0C0h,074h; ovr_1da8_abec:CD23
		db	003h,0E9h,0CDh,000h,0FFh,076h,004h,09Ah
		dw	025h
		dw	seg CO030_TEXT
		db	089h,046h; ovr_1da8_abec:CD31
		db	004h,0C7h,006h,054h,082h,09Eh,067h,0C6h,006h,09Eh,067h,000h,083h,07Eh	; ovr_1da8_abec:CD3F
		db	004h,022h,075h,02Bh,08Bh,076h,004h,0A1h,092h,082h,03Bh,006h,08Ch,082h	; ovr_1da8_abec:CD4D
		db	072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh; ovr_1da8_abec:CD5B
		db	007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h	; ovr_1da8_abec:CD69
		db	089h,046h,004h,0EBh,003h,0BEh,01Ah,000h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h; ovr_1da8_abec:CD77
		db	082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,004h,083h	; ovr_1da8_abec:CDA1
		db	07Eh,004h,01Ah,074h,011h,083h,07Eh,004h,00Ah,074h,00Bh,083h,07Eh,004h	; ovr_1da8_abec:CDAF
		db	00Dh,074h,005h,039h,076h,004h,075h,0BAh,0C7h,006h,054h,082h,09Eh,067h	; ovr_1da8_abec:CDBD
		db	01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	010Dh
		dw	seg BCC_RF_15C5_010D
		db	089h,016h,068h,017h,0A3h,066h,017h,0FFh,036h,068h,017h; ovr_1da8_abec:CDCB
		db	0FFh,036h,066h,017h,01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,076h,004h,09Ah
		dw	03Eh
		dw	seg CO030_TEXT
		db	0B8h,001h,000h,0EBh,053h,01Eh; ovr_1da8_abec:CDF5
		db	0B8h,034h,034h,050h,01Eh,0B8h,09Eh,077h,050h,09Ah
		dw	07h
		dw	seg BCC_COMPARE_NAME
		db	00Bh,0C0h,075h,00Ch,0FFh,076h,004h,09Ah
		dw	03Eh
		dw	seg CO030_TEXT
		db	033h,0C0h; ovr_1da8_abec:CE11
		db	0EBh,034h,01Eh,0B8h,09Eh,067h,050h,01Eh,0B8h,03Ch,034h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,09Eh,067h,050h,01Eh,0B8h,09Eh,077h,050h,09Ah; ovr_1da8_abec:CE1F
		dw	06h
		dw	seg BCC_FAR_B146
		db	0B8h,09Eh,067h,050h,083h,03Eh,0DAh,085h,000h,075h; ovr_1da8_abec:CE3B
		db	005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,050h,0E8h,05Eh,0FEh,05Eh,05Dh	; ovr_1da8_abec:CE49
		db	04Dh,0C2h,002h,000h	; ovr_1da8_abec:CE57

CO069_TEXT	ends

		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M017_BCC_DATA_66BE	equ	66BEh
M017_BCC_DATA_8524	equ	8524h
M017_BCC_DATA_85D6	equ	85D6h
M017_BCC_DATA_85DA	equ	85DAh

BCC_NEAR_CE5B	label	near
STAOV10F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		push	DS
		mov	AX,8524h
		push	AX
		push	DS
		push	DI
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		add	AX,9
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8524
		mov	word ptr ES:[SI],0
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+6],AX
		mov	AX,DGROUP:M017_BCC_DATA_66BE
		mov	word ptr ES:[SI+4],AX
		push	word ptr DGROUP:M017_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		push	DS
		push	DI
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		cmp	word ptr DGROUP:M017_BCC_DATA_85DA,0
		je	short M017_L_CEBE
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8524
		mov	BX,word ptr DGROUP:M017_BCC_DATA_85D6
		mov	word ptr ES:[BX],SI
		mov	AX,DGROUP:M017_BCC_DATA_85D6
		mov	word ptr ES:[SI+2],AX
		jmp	short M017_L_CECC
M017_L_CEBE:
		mov	word ptr DGROUP:M017_BCC_DATA_85DA,SI
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8524
		mov	word ptr ES:[SI+2],0
M017_L_CECC:
		mov	word ptr DGROUP:M017_BCC_DATA_85D6,SI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV10F	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,057h,0C7h,006h,054h,082h,09Eh	; ovr_1da8_abec:CED7
		db	067h,083h,07Eh,004h,03Ch,074h,009h,083h,07Eh,004h,022h,074h,003h,0E9h	; ovr_1da8_abec:CEE5
		db	0AFh,000h,0C6h,006h,09Eh,067h,000h,083h,07Eh,004h,03Ch,075h,007h,0C7h	; ovr_1da8_abec:CEF3
		db	046h,0FEh,03Eh,000h,0EBh,005h,0C7h,046h,0FEh,022h,000h,08Ah,046h,004h	; ovr_1da8_abec:CF01
		db	050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h; ovr_1da8_abec:CF0F
		db	007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h; ovr_1da8_abec:CF1D
		db	08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h	; ovr_1da8_abec:CF2B
		db	046h,004h,083h,07Eh,004h,01Ah,074h,011h,083h,07Eh,004h,00Ah,074h,00Bh	; ovr_1da8_abec:CF39
		db	083h,07Eh,004h,00Dh,074h,005h,03Bh,046h,0FEh,075h,0BAh,08Bh,046h,004h	; ovr_1da8_abec:CF47
		db	03Bh,046h,0FEh,075h,00Eh,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0C7h,046h,004h,020h,000h,0C7h,006h,054h,082h,09Eh,067h,0FFh,076h,004h	; ovr_1da8_abec:CF63
		db	09Ah
		dw	03Eh
		dw	seg CO030_TEXT
		db	09Ah
		dw	04Dh
		dw	seg CO030_TEXT
		db	08Bh,0F0h,01Eh,056h; ovr_1da8_abec:CF71
		db	09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	08Bh,0D6h,003h,0D0h,04Ah,08Bh,0FAh,080h,03Ch; ovr_1da8_abec:CF7F
		db	022h,074h,047h,080h,03Ch,03Ch,074h,042h,0B8h,011h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,033h,0C0h,0E9h,080h,000h,0FFh,00Eh,092h,082h,01Eh; ovr_1da8_abec:CF8D
		db	0B8h,030h,085h,050h,01Eh,0B8h,028h,034h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,030h,085h,050h,01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,0B8h,030h,085h,050h,01Eh,0B8h,02Ah,034h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0EBh,0C8h,080h,03Ch,022h,075h,005h,080h,03Dh,022h,075h,00Ah; ovr_1da8_abec:CFB7
		db	080h,03Ch,03Ch,075h,00Ah,080h,03Dh,03Eh,074h,005h,0B8h,03Ah,000h,0EBh	; ovr_1da8_abec:CFE1
		db	0A8h,08Ah,004h,098h,089h,046h,0FEh,0C6h,005h,000h,046h,01Eh,056h,09Ah	; ovr_1da8_abec:CFEF
		dw	02h
		dw	seg BCC_FAR_AB12
		db	089h,046h,0FCh,083h,07Eh,0FCh,050h,07Eh,005h,0B8h; ovr_1da8_abec:CFFD
		db	030h,000h,0EBh,089h,083h,07Eh,0FEh,03Ch,075h,004h,033h,0C0h,0EBh,003h	; ovr_1da8_abec:D00B
		db	0B8h,001h,000h,050h,056h,0E8h,03Ah,0FEh,0B8h,001h,000h,05Fh,05Eh,08Bh	; ovr_1da8_abec:D019
		db	0E5h,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,0B8h,09Eh,067h,050h	; ovr_1da8_abec:D027
		db	083h,03Eh,0DAh,085h,000h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h	; ovr_1da8_abec:D035
		db	050h,0E8h,06Ch,0FCh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,0B8h	; ovr_1da8_abec:D043
		db	09Eh,067h,050h,0B8h,001h,000h,050h,0E8h,058h,0FCh,05Dh,04Dh,0C2h,002h	; ovr_1da8_abec:D051
		db	000h,045h,055h,08Bh,0ECh,0C7h,006h,054h,082h,09Eh,067h,0EBh,02Fh,08Ah	; ovr_1da8_abec:D05F
		db	046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch; ovr_1da8_abec:D06D
		db	082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h; ovr_1da8_abec:D07B
		db	08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h	; ovr_1da8_abec:D089
		db	000h,089h,046h,004h,083h,07Eh,004h,01Ah,074h,00Ch,083h,07Eh,004h,00Ah	; ovr_1da8_abec:D097
		db	074h,006h,083h,07Eh,004h,00Dh,075h,0BFh,0C7h,006h,054h,082h,09Eh,067h	; ovr_1da8_abec:D0A5
		db	0FFh,076h,004h,09Ah
		dw	03Eh
		dw	seg CO030_TEXT
		db	09Ah
		dw	04Dh
		dw	seg CO030_TEXT
		db	05Dh; ovr_1da8_abec:D0B3
		db	04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,03Eh,0DAh,085h,000h,075h	; ovr_1da8_abec:D0C1
		db	00Dh,0B8h,09Eh,067h,050h,0B8h,001h,000h,050h,0E8h,0D8h,0FBh,0EBh,00Eh	; ovr_1da8_abec:D0CF
		db	0B8h,002h,000h,050h,0FFh,076h,004h,0E8h,079h,0FFh,050h,0E8h,070h,0FDh	; ovr_1da8_abec:D0DD
		db	0B8h,001h,000h,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,03Eh	; ovr_1da8_abec:D0EB
		db	0DAh,085h,000h,075h,00Dh,0B8h,09Eh,067h,050h,0B8h,001h,000h,050h,0E8h	; ovr_1da8_abec:D0F9
		db	0AAh,0FBh,0EBh,011h,0FFh,076h,004h,0FFh,076h,006h,0E8h,04Ch,0FFh,050h	; ovr_1da8_abec:D107
		db	0E8h,043h,0FDh,0FFh,006h,0B4h,085h,0B8h,001h,000h,05Dh,04Dh,0C2h,004h	; ovr_1da8_abec:D115
		db	000h,045h,055h,08Bh,0ECh,0FFh,076h,004h,0B8h,003h,000h,050h,0E8h,0C1h	; ovr_1da8_abec:D123
		db	0FFh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,0FFh,076h,004h,0B8h	; ovr_1da8_abec:D131
		db	004h,000h,050h,0E8h,0AEh,0FFh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh	; ovr_1da8_abec:D13F
		db	0ECh,0FFh,076h,004h,0B8h,005h,000h,050h,0E8h,09Bh,0FFh,05Dh,04Dh,0C2h	; ovr_1da8_abec:D14D
		db	002h,000h,045h,055h,08Bh,0ECh,083h,03Eh,0B4h,085h,000h,07Fh,00Dh,0B8h	; ovr_1da8_abec:D15B
		db	09Eh,067h,050h,0B8h,001h,000h,050h,0E8h,040h,0FBh,0EBh,012h,0B8h,006h	; ovr_1da8_abec:D169
		db	000h,050h,0FFh,076h,004h,0E8h,0E1h,0FEh,050h,0E8h,0D8h,0FCh,0FFh,00Eh	; ovr_1da8_abec:D177
		db	0B4h,085h,0B8h,001h,000h,05Dh,04Dh,0C2h,002h,000h	; ovr_1da8_abec:D185

CO069_TEXT	ends

		extrn	X030_00:far
		extrn	X031_04:far
		extrn	X032_05:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M019_BCC_DATA_827C	equ	827Ch
M019_BCC_DATA_828C	equ	828Ch
M019_BCC_DATA_8292	equ	8292h

BCC_NEAR_D18F	label	near
STAOV110	proc	near
		inc	BP
		push	BP
		mov	BP,SP
M019_L_D193:
		push	word ptr [BP+4]
		db	09Ah
		dw	X030_00
		dw	seg X030_00
		mov	word ptr [BP+4],AX
		mov	BX,word ptr [BP+4]
		cmp	byte ptr [BX+2101h],0ECh
		jne	short M019_L_D1D9
		mov	AL,byte ptr [BP+4]
		push	AX
		db	09Ah
		dw	X031_04
		dw	seg X031_04
		mov	AX,DGROUP:M019_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M019_BCC_DATA_828C
		jc	short M019_L_D1C1
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M019_L_D1D2
M019_L_D1C1:
		mov	BX,word ptr DGROUP:M019_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M019_BCC_DATA_8292
		inc	word ptr DGROUP:M019_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M019_L_D1D2:
		mov	AH,0
		mov	word ptr [BP+4],AX
		jmp	short M019_L_D193
M019_L_D1D9:
		mov	AX,word ptr [BP+4]
		pop	BP
		dec	BP
		ret	2
STAOV110	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AA87:far
		extrn	BCC_FAR_B072:far
		extrn	BCC_FAR_B146:far
		extrn	X032_05:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M01A_BCC_DATA_66BE	equ	66BEh
M01A_BCC_DATA_77D3	equ	77D3h
M01A_BCC_DATA_827C	equ	827Ch
M01A_BCC_DATA_828C	equ	828Ch
M01A_BCC_DATA_8292	equ	8292h

BCC_NEAR_D1E1	label	near
STAOV111	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	AX,DGROUP:M01A_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01A_BCC_DATA_828C
		jc	short M01A_L_D1F8
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01A_L_D209
M01A_L_D1F8:
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_8292
		inc	word ptr DGROUP:M01A_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01A_L_D209:
		mov	AH,0
		mov	word ptr [BP-2],AX
		mov	AX,DGROUP:M01A_BCC_DATA_77D3
		mov	DGROUP:M01A_BCC_DATA_66BE,AX
		cmp	word ptr [BP-2],7Dh
		jne	short M01A_L_D224
		mov	AX,8
		push	AX
		mov	AX,3427h
		db	0E9h
		dw	0015Ch
M01A_L_D224:
		mov	SI,679Eh
		jmp	short M01A_L_D255
M01A_L_D229:
		mov	AL,byte ptr [BP-2]
		mov	byte ptr [SI],AL
		inc	SI
		mov	AX,DGROUP:M01A_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01A_BCC_DATA_828C
		jc	short M01A_L_D23F
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01A_L_D250
M01A_L_D23F:
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_8292
		inc	word ptr DGROUP:M01A_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01A_L_D250:
		mov	AH,0
		mov	word ptr [BP-2],AX
M01A_L_D255:
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr [BX+5B81h]
		cbw
		test	AX,0Ch
		jne	short M01A_L_D229
		mov	byte ptr [SI],0
		push	DS
		mov	AX,3444h
		push	AX
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		je	short M01A_L_D290
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,679Eh
M01A_L_D281:
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
M01A_L_D287:
		dec	word ptr DGROUP:M01A_BCC_DATA_8292
		xor	AX,AX
		db	0E9h
		dw	000F7h
M01A_L_D290:
		push	word ptr [BP-2]
		db	0E8h
		dw	0FEF9h
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],22h
		je	short M01A_L_D2AA
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,344Bh
		jmp	short M01A_L_D281
M01A_L_D2AA:
		mov	AX,DGROUP:M01A_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01A_BCC_DATA_828C
		jc	short M01A_L_D2BA
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01A_L_D2CB
M01A_L_D2BA:
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_8292
		inc	word ptr DGROUP:M01A_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01A_L_D2CB:
		mov	AH,0
		mov	word ptr [BP-2],AX
		mov	SI,679Eh
		jmp	short M01A_L_D301
M01A_L_D2D5:
		mov	AL,byte ptr [BP-2]
		mov	byte ptr [SI],AL
		inc	SI
		mov	AX,DGROUP:M01A_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01A_BCC_DATA_828C
		jc	short M01A_L_D2EB
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01A_L_D2FC
M01A_L_D2EB:
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_8292
		inc	word ptr DGROUP:M01A_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01A_L_D2FC:
		mov	AH,0
		mov	word ptr [BP-2],AX
M01A_L_D301:
		cmp	word ptr [BP-2],22h
		jne	short M01A_L_D2D5
		mov	byte ptr [SI],0
		cmp	word ptr [BP-2],22h
		jne	short M01A_L_D336
		mov	AX,DGROUP:M01A_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01A_BCC_DATA_828C
		jc	short M01A_L_D320
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01A_L_D331
M01A_L_D320:
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01A_BCC_DATA_8292
		inc	word ptr DGROUP:M01A_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01A_L_D331:
		mov	AH,0
		mov	word ptr [BP-2],AX
M01A_L_D336:
		push	word ptr [BP-2]
		db	0E8h
		dw	0FE53h
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],7Bh
		je	short M01A_L_D379
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,3453h
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,345Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		dec	word ptr DGROUP:M01A_BCC_DATA_77D3
		db	0E9h
		dw	0FF0Eh
M01A_L_D379:
		mov	AX,7
		push	AX
		mov	AX,679Eh
M01A_L_D380:
		push	AX
		db	0E8h
		dw	0FAD7h
		mov	AX,1
M01A_L_D387:
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV111	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AA87:far
		extrn	BCC_FAR_B072:far
		extrn	BCC_FAR_B146:far
		extrn	X030_00:far
		extrn	X032_05:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M01B_BCC_DATA_66BE	equ	66BEh
M01B_BCC_DATA_77D3	equ	77D3h
M01B_BCC_DATA_827C	equ	827Ch
M01B_BCC_DATA_828C	equ	828Ch
M01B_BCC_DATA_8292	equ	8292h

BCC_NEAR_D38D	label	near
STAOV112	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		db	0E8h
		dw	0F8B4h
		or	AX,AX
		jne	short M01B_L_D3A2
		db	0E8h
		dw	0FE42h
		db	0E9h
		dw	000D2h
M01B_L_D3A2:
		mov	AX,DGROUP:M01B_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01B_BCC_DATA_828C
		jc	short M01B_L_D3B2
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01B_L_D3C3
M01B_L_D3B2:
		mov	BX,word ptr DGROUP:M01B_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01B_BCC_DATA_8292
		inc	word ptr DGROUP:M01B_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01B_L_D3C3:
		mov	AH,0
		mov	word ptr [BP-2],AX
		mov	AX,DGROUP:M01B_BCC_DATA_77D3
		mov	DGROUP:M01B_BCC_DATA_66BE,AX
		mov	DI,679Eh
		jmp	short M01B_L_D3FF
M01B_L_D3D3:
		mov	AL,byte ptr [BP-2]
		mov	byte ptr [DI],AL
		inc	DI
		mov	AX,DGROUP:M01B_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M01B_BCC_DATA_828C
		jc	short M01B_L_D3E9
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M01B_L_D3FA
M01B_L_D3E9:
		mov	BX,word ptr DGROUP:M01B_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M01B_BCC_DATA_8292
		inc	word ptr DGROUP:M01B_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M01B_L_D3FA:
		mov	AH,0
		mov	word ptr [BP-2],AX
M01B_L_D3FF:
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr [BX+5B81h]
		cbw
		test	AX,0Ch
		jne	short M01B_L_D3D3
		mov	byte ptr [DI],0
		push	word ptr [BP-2]
		db	09Ah
		dw	X030_00
		dw	seg X030_00
		mov	word ptr [BP-2],AX
		mov	SI,33E6h
		jmp	short M01B_L_D43B
M01B_L_D41F:
		push	DS
		push	word ptr [SI]
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M01B_L_D438
		push	word ptr [BP-2]
		call	word ptr [SI+2]
		jmp	short M01B_L_D474
M01B_L_D438:
		add	SI,4
M01B_L_D43B:
		cmp	SI,340Ah
		jc	short M01B_L_D41F
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,3428h
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,8530h
		push	AX
		push	DS
		mov	AX,342Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		dec	word ptr DGROUP:M01B_BCC_DATA_8292
		xor	AX,AX
M01B_L_D474:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV112	endp
CO069_TEXT	ends


		extrn	X043_03:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M01C_BCC_DATA_8528	equ	8528h
M01C_BCC_DATA_852A	equ	852Ah
M01C_BCC_DATA_852C	equ	852Ch
M01C_BCC_DATA_85BA	equ	85BAh
M01C_BCC_DATA_85BC	equ	85BCh
M01C_BCC_DATA_85C4	equ	85C4h
M01C_BCC_DATA_85C6	equ	85C6h
M01C_BCC_DATA_85E0	equ	85E0h
M01C_BCC_DATA_85E2	equ	85E2h
M01C_BCC_DATA_85E8	equ	85E8h
M01C_BCC_DATA_85EA	equ	85EAh

BCC_NEAR_D47B	label	near
STAOV113	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		mov	word ptr DGROUP:M01C_BCC_DATA_852A,0
		mov	word ptr DGROUP:M01C_BCC_DATA_8528,2
		mov	word ptr DGROUP:M01C_BCC_DATA_85C6,0
		mov	word ptr DGROUP:M01C_BCC_DATA_85C4,2
		mov	word ptr DGROUP:M01C_BCC_DATA_85BC,0
		mov	word ptr DGROUP:M01C_BCC_DATA_85BA,0
		mov	word ptr DGROUP:M01C_BCC_DATA_85E2,0
		mov	word ptr DGROUP:M01C_BCC_DATA_85E0,2
		mov	word ptr DGROUP:M01C_BCC_DATA_85EA,0
		mov	word ptr DGROUP:M01C_BCC_DATA_85E8,2
		push	DS
		mov	AX,8524h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		push	DS
		mov	AX,85C0h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		push	DS
		mov	AX,85B6h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		push	DS
		mov	AX,85DCh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		push	DS
		mov	AX,85E4h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	byte ptr DGROUP:M01C_BCC_DATA_852C,0
		pop	BP
		dec	BP
		ret
STAOV113	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M01D_BCC_DATA_8524	equ	8524h


BCC_NEAR_D504	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	DI,1
M01D_L_D510:
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8524
		mov	BX,word ptr ES:[SI+6]
		sub	BX,3
		cmp	BX,3
		ja	short M01D_L_D52F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1687h
		inc	DI
		jmp	short M01D_L_D52F
		dec	DI
		jne	short M01D_L_D52F
		jmp	short M01D_L_D53E
M01D_L_D52F:
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8524
		cmp	word ptr ES:[SI],0
		je	short M01D_L_D53E
		mov	SI,word ptr ES:[SI]
		jmp	short M01D_L_D510
M01D_L_D53E:
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_D504	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT
; Original-image layout stub: not recovered source


		db	067h,016h,067h,016h,067h,016h,06Ah,016h	; ovr_1da8_abec:D547

CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M01F_BCC_DATA_8524	equ	8524h


BCC_NEAR_D54F	label	near
STAOV114	proc	near
M01F_L_D54F:
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		jmp	short M01F_L_D5D4
M01F_L_D55A:
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		mov	BX,word ptr ES:[SI+6]
		sub	BX,3
		cmp	BX,5
		ja	short M01F_L_D5CD
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1721h
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		push	word ptr ES:[SI]
		mov	AX,1
		push	AX
		db	0E8h
		dw	0FFD0h
		mov	DI,AX
		or	DI,DI
		je	short M01F_L_D594
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		cmp	word ptr ES:[DI+6],8
		jne	short M01F_L_D594
M01F_L_D590:
		mov	SI,DI
		jmp	short M01F_L_D5CD
M01F_L_D594:
		cmp	word ptr [BP+4],0
		je	short M01F_L_D59E
M01F_L_D59A:
		xor	AX,AX
		jmp	short M01F_L_D5DA
M01F_L_D59E:
		jmp	short M01F_L_D5D8
		jmp	short M01F_L_D5D8
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		push	word ptr ES:[SI]
		mov	AX,1
		push	AX
		db	0E8h
		dw	0FF9Fh
		mov	DI,AX
		or	DI,DI
		je	short M01F_L_D5C3
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		cmp	word ptr ES:[DI+6],6
		jne	short M01F_L_D5C3
		jmp	short M01F_L_D590
M01F_L_D5C3:
		cmp	word ptr [BP+4],0
		je	short M01F_L_D5CB
		jmp	short M01F_L_D59A
M01F_L_D5CB:
		jmp	short M01F_L_D5D8
M01F_L_D5CD:
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8524
		mov	SI,word ptr ES:[SI]
M01F_L_D5D4:
		or	SI,SI
		jne	short M01F_L_D55A
M01F_L_D5D8:
		mov	AX,SI
M01F_L_D5DA:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV114	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT
; Original-image layout stub: not recovered source


		db	0E2h,016h,0E2h,016h,0E2h,016h,0E0h,016h,0B1h,016h,0E0h,016h	; ovr_1da8_abec:D5E1

CO069_TEXT	ends



CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M021_BCC_DATA_8524	equ	8524h
M021_BCC_DATA_85D6	equ	85D6h

BCC_NEAR_D5ED	label	near
STAOV115	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		push	SI
		xor	AX,AX
		push	AX
		db	0E8h
		dw	0FF52h
		mov	DI,AX
		or	DI,DI
		je	short M021_L_D60D
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8524
		mov	SI,word ptr ES:[DI+2]
		jmp	short M021_L_D61D
M021_L_D60D:
		mov	SI,word ptr DGROUP:M021_BCC_DATA_85D6
		jmp	short M021_L_D61D
M021_L_D613:
		mov	DI,SI
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8524
		mov	SI,word ptr ES:[SI+2]
M021_L_D61D:
		or	SI,SI
		je	short M021_L_D62C
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8524
		cmp	word ptr ES:[SI+6],2
		je	short M021_L_D613
M021_L_D62C:
		mov	AX,DI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV115	endp
CO069_TEXT	ends


		extrn	BCC_FAR_B146:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M022_BCC_DATA_66BE	equ	66BEh
M022_BCC_DATA_77D3	equ	77D3h
M022_BCC_DATA_8524	equ	8524h

BCC_NEAR_D635	label	near
STAOV116	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	AX,DGROUP:M022_BCC_DATA_77D3
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8524
		mov	AX,word ptr ES:[SI+4]
		dec	AX
		mov	DI,AX
		mov	DGROUP:M022_BCC_DATA_77D3,AX
		mov	DGROUP:M022_BCC_DATA_66BE,AX
		db	0E9h
		dw	0011Ah
M022_L_D65A:
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,345Dh
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		inc	DI
M022_L_D66A:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8524
		cmp	word ptr ES:[SI+4],DI
		jg	short M022_L_D65A
		mov	BX,word ptr ES:[SI+6]
		cmp	BX,8
		jbe	short M022_L_D680
		db	0E9h
		dw	000EDh
M022_L_D680:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	18DBh
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,3496h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	word ptr DGROUP:M022_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34A1h
		db	0E9h
		dw	000B1h
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34A3h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	word ptr DGROUP:M022_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,345Ah
		db	0E9h
		dw	00082h
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34AEh
		jmp	short M022_L_D70F
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34B7h
		jmp	short M022_L_D70F
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34BCh
		jmp	short M022_L_D70F
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34C4h
M022_L_D70F:
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	word ptr DGROUP:M022_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		jmp	short M022_L_D767
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34CDh
		jmp	short M022_L_D767
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,3453h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	word ptr DGROUP:M022_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34D5h
		jmp	short M022_L_D767
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,34D9h
M022_L_D767:
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
M022_L_D76D:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8524
		mov	SI,word ptr ES:[SI]
M022_L_D774:
		or	SI,SI
		je	short M022_L_D77B
		db	0E9h
		dw	0FEEFh
M022_L_D77B:
		jmp	short M022_L_D78D
M022_L_D77D:
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,345Dh
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		inc	DI
M022_L_D78D:
		cmp	DI,word ptr [BP-2]
		jl	short M022_L_D77D
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
STAOV116	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT

STOVT192	label	word
		dw	017C7h
		dw	017F6h
		dw	01825h
		dw	01830h
		dw	0183Bh
		dw	01846h
		dw	01865h
		dw	01870h
		dw	0189Eh

CO069_TEXT	ends

		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M024_BCC_DATA_85E4	equ	85E4h

		public	X069_05
X069_05	label	far
STAOV117	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,85E4h
		push	AX
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		inc	AX
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M024_BCC_DATA_85E4
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[SI],AL
		inc	SI
		push	word ptr DGROUP:M024_BCC_DATA_85E4
		push	SI
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		pop	SI
		pop	BP
		retf	6
STAOV117	endp
CO069_TEXT	ends


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M025_BCC_DATA_852C	equ	852Ch


		public	X069_00
X069_00	label	far
STAOV118	proc	far
		push	BP
		mov	BP,SP
		mov	byte ptr DGROUP:M025_BCC_DATA_852C,1
		pop	BP
		retf
STAOV118	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X043_02:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M026_BCC_DATA_85E4	equ	85E4h

		public	X069_01
X069_01	label	far
STAOV119	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,85E4h
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		inc	AX
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M026_BCC_DATA_85E4
		mov	byte ptr ES:[SI],3Dh
		inc	SI
		push	word ptr DGROUP:M026_BCC_DATA_85E4
		push	SI
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		pop	SI
		pop	BP
		retf	4
STAOV119	endp
CO069_TEXT	ends


		extrn	BCC_FAR_AA87:far
		extrn	X019_00:far
		extrn	X043_00:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M027_BCC_DATA_62B4	equ	62B4h
M027_BCC_DATA_63BE	equ	63BEh
M027_BCC_DATA_647E	equ	647Eh

BCC_NEAR_D831	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,62B4h
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		mov	ES,word ptr DGROUP:M027_BCC_DATA_62B4
		mov	AX,DGROUP:M027_BCC_DATA_647E
		mov	word ptr ES:[SI],AX
		mov	AX,DGROUP:M027_BCC_DATA_63BE
		mov	word ptr ES:[SI+2],AX
		mov	word ptr DGROUP:M027_BCC_DATA_63BE,SI
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		push	DS
		mov	AX,34DBh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M027_L_D877
		mov	word ptr DGROUP:M027_BCC_DATA_647E,1
		jmp	short M027_L_D8A2
M027_L_D877:
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		push	DS
		mov	AX,34DFh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M027_L_D893
		mov	word ptr DGROUP:M027_BCC_DATA_647E,2
		jmp	short M027_L_D8A2
M027_L_D893:
		mov	word ptr DGROUP:M027_BCC_DATA_647E,0
		mov	AX,80h
		push	AX
		db	09Ah
		dw	X019_00
		dw	seg X019_00
M027_L_D8A2:
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_D831	endp
CO069_TEXT	ends


		extrn	X019_00:far
		extrn	X043_04:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M028_BCC_DATA_62B4	equ	62B4h
M028_BCC_DATA_63BE	equ	63BEh
M028_BCC_DATA_647E	equ	647Eh

BCC_NEAR_D8A8	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		cmp	word ptr DGROUP:M028_BCC_DATA_63BE,0
		jne	short M028_L_D8BF
		mov	AX,0B5h
		push	AX
		db	09Ah
		dw	X019_00
		dw	seg X019_00
		jmp	short M028_L_D8DF
M028_L_D8BF:
		mov	SI,word ptr DGROUP:M028_BCC_DATA_63BE
		mov	ES,word ptr DGROUP:M028_BCC_DATA_62B4
		mov	AX,word ptr ES:[SI+2]
		mov	DGROUP:M028_BCC_DATA_63BE,AX
		mov	AX,word ptr ES:[SI]
		mov	DGROUP:M028_BCC_DATA_647E,AX
		push	DS
		mov	AX,62B4h
		push	AX
		push	SI
		db	09Ah
		dw	X043_04
		dw	seg X043_04
M028_L_D8DF:
		pop	SI
		pop	BP
		dec	BP
		ret
BCC_NEAR_D8A8	endp
CO069_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	BCC_FAR_B146:far
		extrn	X02E_06:far
		extrn	X02E_07:far
		extrn	X030_04:far
		extrn	X032_05:far
		extrn	X032_04:far
		extrn	X032_06:far
		extrn	X032_08:far
		extrn	X033_01:far
		extrn	X043_02:far
		extrn	X056_0B:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M029_BCC_DATA_1756	equ	1756h
M029_BCC_DATA_63BE	equ	63BEh
M029_BCC_DATA_66BE	equ	66BEh
M029_BCC_DATA_679E	equ	679Eh
M029_BCC_DATA_77D3	equ	77D3h
M029_BCC_DATA_80EC	equ	80ECh
M029_BCC_DATA_8100	equ	8100h
M029_BCC_DATA_8269	equ	8269h
M029_BCC_DATA_826B	equ	826Bh
M029_BCC_DATA_827C	equ	827Ch
M029_BCC_DATA_828C	equ	828Ch
M029_BCC_DATA_8292	equ	8292h
M029_BCC_DATA_8524	equ	8524h
M029_BCC_DATA_8530	equ	8530h
M029_BCC_DATA_85B2	equ	85B2h
M029_BCC_DATA_85D2	equ	85D2h
M029_BCC_DATA_85D4	equ	85D4h
M029_BCC_DATA_85D8	equ	85D8h
M029_BCC_DATA_85EC	equ	85ECh
M029_BCC_DATA_8644	equ	8644h

		public	X069_02
X069_02	label	far
BCC_NEAR_D8E3	label	near
STAOV11A	proc	far
		push	BP
		mov	BP,SP
		sub	SP,100h
		push	SI
		push	DI
		mov	SI,word ptr DGROUP:M029_BCC_DATA_85D4
		db	0E9h
		dw	001D6h
M029_L_D8F3:
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		push	word ptr DGROUP:M029_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		mov	AX,word ptr ES:[SI+4]
		mov	DGROUP:M029_BCC_DATA_66BE,AX
		mov	BX,word ptr ES:[SI+6]
		cmp	BX,8
		jbe	short M029_L_D91F
		db	0E9h
		dw	001A3h
M029_L_D91F:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1CE8h
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		cmp	word ptr ES:[SI+6],1
		je	short M029_L_D950
		cmp	byte ptr [BP+0FF01h],3Ah
		je	short M029_L_D950
		cmp	byte ptr [BP+0FF00h],2Fh
		je	short M029_L_D950
		cmp	byte ptr [BP+0FF00h],5Ch
		je	short M029_L_D950
		les	BX,DGROUP:M029_BCC_DATA_1756
		cmp	byte ptr ES:[BX],0
		jne	short M029_L_D971
M029_L_D950:
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X032_04
		dw	seg X032_04
		or	AX,AX
		je	short M029_L_D971
M029_L_D95F:
		db	09Ah
		dw	X02E_06
		dw	seg X02E_06
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		mov	AX,word ptr ES:[SI]
		mov	DGROUP:M029_BCC_DATA_85D4,AX
		db	0E9h
		dw	00231h
M029_L_D971:
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X02E_07
		dw	seg X02E_07
		or	AX,AX
		jne	short M029_L_D994
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		mov	AX,39h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		jmp	short M029_L_D95F
M029_L_D994:
		jmp	short M029_L_D95F
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		push	DS
		mov	AX,34AFh
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		push	word ptr DGROUP:M029_BCC_DATA_8524
		mov	AX,SI
		add	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		push	DS
		mov	AX,3426h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X032_08
		dw	seg X032_08
		mov	AX,20h
		push	AX
		db	09Ah
		dw	X030_04
		dw	seg X030_04
		mov	AX,DGROUP:M029_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M029_BCC_DATA_828C
		jc	short M029_L_D9EF
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M029_L_DA00
M029_L_D9EF:
		mov	BX,word ptr DGROUP:M029_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M029_BCC_DATA_8292
		inc	word ptr DGROUP:M029_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M029_L_DA00:
		mov	AH,0
		mov	BX,AX
		cmp	byte ptr [BX+2101h],0ECh
		jne	short M029_L_DA27
		mov	AX,DGROUP:M029_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M029_BCC_DATA_828C
		jc	short M029_L_DA16
		jmp	short M029_L_DA6F
M029_L_DA16:
		mov	BX,word ptr DGROUP:M029_BCC_DATA_827C
		mov	ES,word ptr [BX]
		mov	BX,word ptr DGROUP:M029_BCC_DATA_8292
		inc	word ptr DGROUP:M029_BCC_DATA_8292
		mov	AL,byte ptr ES:[BX]
M029_L_DA27:
		dec	word ptr DGROUP:M029_BCC_DATA_8292
		db	0E9h
		dw	00094h
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		push	DS
		mov	AX,3426h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X032_08
		dw	seg X032_08
		db	0FFh,01Eh
		dw	80ECh
		or	AX,AX
		je	short M029_L_DA5A
		mov	AX,DGROUP:M029_BCC_DATA_8269
		or	AX,word ptr DGROUP:M029_BCC_DATA_826B
		jne	short M029_L_DA66
M029_L_DA5A:
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		push	word ptr ES:[SI]
		db	0E8h
		dw	0FAA0h
		mov	SI,AX
M029_L_DA66:
		mov	AX,DGROUP:M029_BCC_DATA_8292
		cmp	AX,word ptr DGROUP:M029_BCC_DATA_828C
		jc	short M029_L_DA76
M029_L_DA6F:
		db	09Ah
		dw	X032_05
		dw	seg X032_05
		jmp	short M029_L_DA27
M029_L_DA76:
		jmp	short M029_L_DA16
		jmp	short M029_L_DA27
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X033_01
		dw	seg X033_01
		or	AX,AX
		jne	short M029_L_DAC2
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		push	word ptr ES:[SI]
		db	0E8h
		dw	0FA71h
		mov	SI,AX
		jmp	short M029_L_DAC2
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	09Ah
		dw	X033_01
		dw	seg X033_01
		or	AX,AX
		je	short M029_L_DAC2
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		push	word ptr ES:[SI]
		db	0E8h
		dw	0FA54h
		mov	SI,AX
		jmp	short M029_L_DAC2
		push	SS
		lea	AX,[BP+0FF00h]
		push	AX
		db	0E8h
		dw	0FD74h
		jmp	short M029_L_DAC2
		db	0E8h
		dw	0FDE6h
M029_L_DAC2:
		mov	ES,word ptr DGROUP:M029_BCC_DATA_8524
		mov	SI,word ptr ES:[SI]
M029_L_DAC9:
		or	SI,SI
		je	short M029_L_DAD0
		db	0E9h
		dw	0FE23h
M029_L_DAD0:
		mov	word ptr DGROUP:M029_BCC_DATA_85D4,0
		cmp	byte ptr DGROUP:M029_BCC_DATA_85D8,0
		je	short M029_L_DB05
		mov	byte ptr DGROUP:M029_BCC_DATA_85D8,0
		db	0FFh,01Eh
		dw	8100h
		cmp	word ptr DGROUP:M029_BCC_DATA_8644,0
		jne	short M029_L_DAFD
		db	09Ah
		dw	X056_0B
		dw	seg X056_0B
		or	AX,AX
		jne	short M029_L_DAFD
		cmp	word ptr DGROUP:M029_BCC_DATA_63BE,0
		je	short M029_L_DB02
M029_L_DAFD:
		db	0E8h
		dw	0E8F9h
		jmp	short M029_L_DB05
M029_L_DB02:
		db	0E8h
		dw	0E9B1h
M029_L_DB05:
		mov	byte ptr DGROUP:M029_BCC_DATA_85EC,0
		cmp	word ptr DGROUP:M029_BCC_DATA_85D2,0
		jl	short M029_L_DB20
		push	word ptr DGROUP:M029_BCC_DATA_85D2
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		mov	word ptr DGROUP:M029_BCC_DATA_85D2,0FFFFh
M029_L_DB20:
		mov	byte ptr DGROUP:M029_BCC_DATA_679E,0
		cmp	word ptr DGROUP:M029_BCC_DATA_85B2,0
		je	short M029_L_DB39
		push	word ptr DGROUP:M029_BCC_DATA_85B2
		db	0E8h
		dw	0FB02h
		mov	word ptr DGROUP:M029_BCC_DATA_85B2,0
M029_L_DB39:
		cmp	byte ptr DGROUP:M029_BCC_DATA_8530,0
		je	short M029_L_DB6E
		cmp	byte ptr DGROUP:M029_BCC_DATA_679E,0
		jne	short M029_L_DB5A
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,345Dh
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		dec	word ptr DGROUP:M029_BCC_DATA_77D3
M029_L_DB5A:
		push	DS
		mov	AX,679Eh
		push	AX
		push	DS
		mov	AX,8530h
		push	AX
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		mov	byte ptr DGROUP:M029_BCC_DATA_8530,0
M029_L_DB6E:
		db	0E8h
		dw	0F90Ah
		push	DS
		mov	AX,8524h
		push	AX
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		push	word ptr DGROUP:M029_BCC_DATA_8524
		push	DI
		push	DS
		mov	AX,679Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		mov	AX,8524h
		push	AX
		push	DI
		db	09Ah
		dw	X032_06
		dw	seg X032_06
M029_L_DBA2:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV11A	endp
CO069_TEXT	ends

CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT
; Original-image layout stub: not recovered source


		db	066h,01Ah,066h,01Ah,0D6h,01Ah,06Eh,01Bh,0BAh,01Bh,0D7h,01Bh,002h,01Ch	; ovr_1da8_abec:DBA8
		db	0F4h,01Bh,0FFh,01Bh	; ovr_1da8_abec:DBB6

CO069_TEXT	ends

		extrn	BCC_FAR_245C:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M02B_BCC_DATA_8526	equ	8526h
M02B_BCC_DATA_8528	equ	8528h
M02B_BCC_DATA_852A	equ	852Ah
M02B_BCC_DATA_852E	equ	852Eh
M02B_BCC_DATA_8530	equ	8530h
M02B_BCC_DATA_85B0	equ	85B0h
M02B_BCC_DATA_85B2	equ	85B2h
M02B_BCC_DATA_85B8	equ	85B8h
M02B_BCC_DATA_85BA	equ	85BAh
M02B_BCC_DATA_85BC	equ	85BCh
M02B_BCC_DATA_85BE	equ	85BEh
M02B_BCC_DATA_85C2	equ	85C2h
M02B_BCC_DATA_85C4	equ	85C4h
M02B_BCC_DATA_85C6	equ	85C6h
M02B_BCC_DATA_85D2	equ	85D2h
M02B_BCC_DATA_85D4	equ	85D4h
M02B_BCC_DATA_85D6	equ	85D6h
M02B_BCC_DATA_85D8	equ	85D8h
M02B_BCC_DATA_85DA	equ	85DAh
M02B_BCC_DATA_85DE	equ	85DEh
M02B_BCC_DATA_85E0	equ	85E0h
M02B_BCC_DATA_85E2	equ	85E2h
M02B_BCC_DATA_85E6	equ	85E6h
M02B_BCC_DATA_85E8	equ	85E8h
M02B_BCC_DATA_85EA	equ	85EAh
M02B_BCC_DATA_85EC	equ	85ECh

		public	X069_03
X069_03	label	far
STAOV11B	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		mov	DGROUP:M02B_BCC_DATA_85BE,AX
		mov	DGROUP:M02B_BCC_DATA_85D6,AX
		mov	DGROUP:M02B_BCC_DATA_85DA,AX
		mov	DGROUP:M02B_BCC_DATA_85B2,AX
		mov	DGROUP:M02B_BCC_DATA_85D4,AX
		mov	byte ptr DGROUP:M02B_BCC_DATA_8530,0
		mov	byte ptr DGROUP:M02B_BCC_DATA_85D8,0
		mov	byte ptr DGROUP:M02B_BCC_DATA_85EC,0
		mov	word ptr DGROUP:M02B_BCC_DATA_85D2,0FFFFh
		mov	AX,2
		mov	DGROUP:M02B_BCC_DATA_8526,AX
		mov	DGROUP:M02B_BCC_DATA_8528,AX
		mov	word ptr DGROUP:M02B_BCC_DATA_852A,0
		push	DS
		mov	AX,8524h
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,2
		mov	DGROUP:M02B_BCC_DATA_85C2,AX
		mov	DGROUP:M02B_BCC_DATA_85C4,AX
		mov	word ptr DGROUP:M02B_BCC_DATA_85C6,0
		push	DS
		mov	AX,85C0h
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M02B_BCC_DATA_85B8,AX
		mov	DGROUP:M02B_BCC_DATA_85BA,AX
		mov	word ptr DGROUP:M02B_BCC_DATA_85BC,0
		push	DS
		mov	AX,85B6h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,2
		mov	DGROUP:M02B_BCC_DATA_85DE,AX
		mov	DGROUP:M02B_BCC_DATA_85E0,AX
		mov	word ptr DGROUP:M02B_BCC_DATA_85E2,0
		push	DS
		mov	AX,85DCh
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M02B_BCC_DATA_85E6,AX
		mov	DGROUP:M02B_BCC_DATA_85E8,AX
		mov	word ptr DGROUP:M02B_BCC_DATA_85EA,0
		push	DS
		mov	AX,85E4h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M02B_BCC_DATA_852E,AX
		mov	DGROUP:M02B_BCC_DATA_85B0,AX
		pop	BP
		retf
STAOV11B	endp
CO069_TEXT	ends


		extrn	BCC_FAR_A7C4:far


CO069_TEXT	segment byte public 'CODE'
		assume	cs:CO069_TEXT,ds:DGROUP

M02C_BCC_DATA_1765	equ	1765h
M02C_BCC_STMT_TYPE_CURRENT	equ	8260h
M02C_BCC_DATA_8524	equ	8524h
M02C_BCC_DATA_85B2	equ	85B2h
M02C_BCC_DATA_85B4	equ	85B4h
M02C_BCC_DATA_85BE	equ	85BEh
M02C_BCC_DATA_85D2	equ	85D2h
M02C_BCC_DATA_85D4	equ	85D4h
M02C_BCC_DATA_85D8	equ	85D8h
M02C_BCC_DATA_85DA	equ	85DAh
M02C_BCC_DATA_85E0	equ	85E0h
M02C_BCC_DATA_85E2	equ	85E2h
M02C_BCC_DATA_85EC	equ	85ECh

		public	X069_04
X069_04	label	far
STAOV11C	proc	far
		push	BP
		mov	BP,SP
		cmp	byte ptr DGROUP:M02C_BCC_DATA_1765,0
		jne	short M02C_L_DC87
		db	0E9h
		dw	000A4h
M02C_L_DC87:
		mov	word ptr DGROUP:M02C_BCC_DATA_85B4,0
M02C_L_DC8D:
		db	0E8h
		dw	0F6FDh
		or	AX,AX
		jne	short M02C_L_DC8D
		mov	AX,DGROUP:M02C_BCC_DATA_85DA
		mov	DGROUP:M02C_BCC_DATA_85D4,AX
		push	word ptr DGROUP:M02C_BCC_DATA_85DA
		db	0E8h
		dw	0F94Ch
		mov	DGROUP:M02C_BCC_DATA_85B2,AX
		cmp	word ptr DGROUP:M02C_BCC_DATA_85B2,0
		je	short M02C_L_DCCB
		mov	BX,word ptr DGROUP:M02C_BCC_DATA_85B2
		mov	ES,word ptr DGROUP:M02C_BCC_DATA_8524
		cmp	word ptr ES:[BX+2],0
		je	short M02C_L_DCC5
		mov	BX,word ptr ES:[BX+2]
		mov	word ptr ES:[BX],0
		jmp	short M02C_L_DCCB
M02C_L_DCC5:
		mov	word ptr DGROUP:M02C_BCC_DATA_85D4,0
M02C_L_DCCB:
		cmp	word ptr DGROUP:M02C_BCC_DATA_85D4,0
		je	short M02C_L_DD15
		db	0E8h
		dw	0E508h
		db	0E8h
		dw	0EC28h
		or	AX,AX
		jne	short M02C_L_DD04
		db	0E8h
		dw	0EAF0h
		push	word ptr DGROUP:M02C_BCC_DATA_85D2
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		mov	word ptr DGROUP:M02C_BCC_DATA_85D2,0FFFFh
		mov	word ptr DGROUP:M02C_BCC_DATA_85D4,0
		push	word ptr DGROUP:M02C_BCC_DATA_85BE
		push	word ptr DGROUP:M02C_BCC_DATA_85B2
		db	0E8h
		dw	0E378h
		mov	DGROUP:M02C_BCC_DATA_85B2,AX
		jmp	short M02C_L_DD15
M02C_L_DD04:
		cmp	byte ptr DGROUP:M02C_BCC_DATA_1765,4
		je	short M02C_L_DD15
		mov	byte ptr DGROUP:M02C_BCC_DATA_85EC,1
		mov	byte ptr DGROUP:M02C_BCC_DATA_85D8,1
M02C_L_DD15:
		mov	word ptr DGROUP:M02C_BCC_DATA_85E2,0
		mov	word ptr DGROUP:M02C_BCC_DATA_85E0,2
		push	CS
		db	0E8h
		dw	0FBBEh
		mov	word ptr DGROUP:M02C_BCC_STMT_TYPE_CURRENT,82h
M02C_L_DD2B:
		pop	BP
		retf
STAOV11C	endp
CO069_TEXT	ends

; END C128UNIT
		end
