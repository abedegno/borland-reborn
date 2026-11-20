		public	X056_03
		public	X056_02
		public	X056_01
		public	X056_00
		public	X056_07
		public	X056_06
		public	X056_05
		public	X056_04
		public	X056_09
		public	X056_08
		public	X056_0C
		public	X056_0B
		public	X056_0A
		public	X056_0E
		public	X056_0D
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d4a_a000
; BEGIN C108UNIT (listing ovr_1d4a_a000:0000)

		extrn	BCC_FAR_AA87:far
		extrn	BCC_FAR_AF23:far
		extrn	X043_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M000_BCC_DATA_7846	equ	7846h
M000_BCC_DATA_86D0	equ	86D0h
M000_BCC_DATA_8894	equ	8894h
M000_BCC_DATA_889E	equ	889Eh
M000_BCC_DATA_88A0	equ	88A0h
M000_BCC_DATA_88A6	equ	88A6h
M000_BCC_DATA_88A8	equ	88A8h
M000_BCC_DATA_88AA	equ	88AAh

		public	X056_0D
X056_0D	label	far
BCC_NEAR_0000	label	near
BCC_FAR_0000	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		cmp	word ptr [BP+8],0
		je	short M000_L_0085
		mov	DI,word ptr DGROUP:M000_BCC_DATA_88A6
		jmp	short M000_L_0034
M000_L_0011:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr ES:[DI+4]
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr [BP+8]
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		je	short M000_L_0038
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	DI,word ptr ES:[DI]
M000_L_0034:
		or	DI,DI
		jne	short M000_L_0011
M000_L_0038:
		or	DI,DI
		jne	short M000_L_0087
		push	DS
		mov	AX,8894h
		push	AX
		mov	AX,6
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		inc	word ptr DGROUP:M000_BCC_DATA_88AA
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	AX,DGROUP:M000_BCC_DATA_88AA
		mov	word ptr ES:[DI+2],AX
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[DI+4],AX
		mov	word ptr ES:[DI],0
		cmp	word ptr DGROUP:M000_BCC_DATA_88A6,0
		jne	short M000_L_0074
		mov	word ptr DGROUP:M000_BCC_DATA_88A6,DI
		jmp	short M000_L_007F
M000_L_0074:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	BX,word ptr DGROUP:M000_BCC_DATA_88A8
		mov	word ptr ES:[BX],DI
M000_L_007F:
		mov	word ptr DGROUP:M000_BCC_DATA_88A8,DI
		jmp	short M000_L_0087
M000_L_0085:
		xor	DI,DI
M000_L_0087:
		mov	SI,word ptr DGROUP:M000_BCC_DATA_889E
		jmp	short M000_L_00DC
M000_L_008D:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr ES:[SI+11h]
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr [BP+0Ah]
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M000_L_00D5
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		cmp	word ptr ES:[SI+2],DI
		jne	short M000_L_00D5
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr ES:[SI+0Ah]
		push	word ptr DGROUP:M000_BCC_DATA_7846
		push	word ptr [BP+6]
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M000_L_00D5
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+4]
		jmp	short M000_L_014A
M000_L_00D5:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	SI,word ptr ES:[SI]
M000_L_00DC:
		or	SI,SI
		jne	short M000_L_008D
		push	DS
		mov	AX,8894h
		push	AX
		mov	AX,1Bh
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		push	word ptr DGROUP:M000_BCC_DATA_8894
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,1Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+11h],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Ah],AX
		inc	word ptr DGROUP:M000_BCC_DATA_86D0
		mov	AX,DGROUP:M000_BCC_DATA_86D0
		mov	word ptr ES:[SI+4],AX
		mov	word ptr ES:[SI+2],DI
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI+10h],AL
		mov	word ptr ES:[SI+19h],0
		cmp	word ptr DGROUP:M000_BCC_DATA_889E,0
		je	short M000_L_013F
		mov	BX,word ptr DGROUP:M000_BCC_DATA_88A0
		mov	word ptr ES:[BX],SI
		jmp	short M000_L_0143
M000_L_013F:
		mov	word ptr DGROUP:M000_BCC_DATA_889E,SI
M000_L_0143:
		mov	word ptr DGROUP:M000_BCC_DATA_88A0,SI
		mov	AX,DGROUP:M000_BCC_DATA_86D0
M000_L_014A:
		pop	DI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_0000	endp
CO056_TEXT	ends




CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M001_BCC_DATA_86D0	equ	86D0h
M001_BCC_DATA_8894	equ	8894h
M001_BCC_DATA_88A0	equ	88A0h

		public	X056_02
X056_02	label	far
BCC_FAR_0150	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+0Ch]
		mov	AX,DGROUP:M001_BCC_DATA_86D0
		mov	word ptr [BP-2],AX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		xor	AX,AX
		push	AX
		push	AX
		push	CS
		db	0E8h
		dw	0FE93h
		mov	AX,word ptr [BP-2]
		mov	DGROUP:M001_BCC_DATA_86D0,AX
		mov	BX,word ptr DGROUP:M001_BCC_DATA_88A0
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		mov	word ptr ES:[BX+4],SI
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[BX+19h],AX
		mov	AX,SI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_0150	endp
CO056_TEXT	ends




CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M002_BCC_DATA_86CE	equ	86CEh
M002_BCC_DATA_88A2	equ	88A2h
M002_BCC_DATA_88A4	equ	88A4h

		public	X056_06
X056_06	label	far
BCC_FAR_018F	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr DGROUP:M002_BCC_DATA_86CE
		or	SI,SI
		jne	short M002_L_01A1
		jmp	short M002_L_01B1
M002_L_01A1:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00027h
		mov	DGROUP:M002_BCC_DATA_88A2,AX
		mov	DGROUP:M002_BCC_DATA_88A4,AX
		mov	word ptr DGROUP:M002_BCC_DATA_86CE,SI
M002_L_01B1:
		mov	AX,DI
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_018F	endp
CO056_TEXT	ends


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M003_BCC_DATA_8894	equ	8894h
M003_BCC_DATA_88A2	equ	88A2h


		public	X056_0A
X056_0A	label	far
BCC_FAR_01B9	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr DGROUP:M003_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8894
		mov	DX,word ptr ES:[BX+0Eh]
		mov	AX,word ptr ES:[BX+0Ch]
		pop	BP
		retf
BCC_FAR_01B9	endp
CO056_TEXT	ends


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M004_BCC_DATA_8894	equ	8894h
M004_BCC_DATA_889E	equ	889Eh


		public	X056_0E
X056_0E	label	far
BCC_NEAR_01CE	label	near
BCC_FAR_01CE	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	SI,word ptr DGROUP:M004_BCC_DATA_889E
		jmp	short M004_L_01F1
M004_L_01DC:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		cmp	word ptr ES:[SI+4],DI
		jne	short M004_L_01EA
		mov	AX,SI
		jmp	short M004_L_01F7
M004_L_01EA:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		mov	SI,word ptr ES:[SI]
M004_L_01F1:
		or	SI,SI
		jne	short M004_L_01DC
		xor	AX,AX
M004_L_01F7:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_01CE	endp
CO056_TEXT	ends


		extrn	BCC_FAR_AF23:far
		extrn	X043_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M005_BCC_DATA_885C	equ	885Ch
M005_BCC_DATA_8894	equ	8894h

BCC_NEAR_01FD	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		push	DS
		mov	AX,885Ch
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		push	word ptr DGROUP:M005_BCC_DATA_885C
		push	DI
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+0Ch]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_885C
		mov	word ptr ES:[DI],AX
		mov	word ptr ES:[DI+8],0
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		cmp	word ptr ES:[SI+6],0
		je	short M005_L_0255
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_885C
		mov	word ptr ES:[BX+8],DI
		jmp	short M005_L_025D
M005_L_0255:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		mov	word ptr ES:[SI+6],DI
M005_L_025D:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		mov	word ptr ES:[SI+8],DI
		mov	AX,DI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_01FD	endp
CO056_TEXT	ends


		extrn	X043_02:far
		extrn	X064_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M006_BCC_DATA_818E	equ	818Eh
M006_BCC_DATA_8192	equ	8192h
M006_BCC_DATA_8664	equ	8664h
M006_BCC_DATA_86B8	equ	86B8h
M006_BCC_DATA_86BC	equ	86BCh
M006_BCC_DATA_8844	equ	8844h
M006_BCC_DATA_8894	equ	8894h
M006_BCC_DATA_88A2	equ	88A2h
M006_BCC_DATA_8B1C	equ	8B1Ch

		public	X056_0C
X056_0C	label	far
BCC_FAR_026E	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		push	word ptr [BP+8]
		db	09Ah
		dw	X064_02
		dw	seg X064_02
		mov	DI,AX
		or	DI,DI
		jne	short M006_L_0287
		db	0E9h
		dw	0013Eh
M006_L_0287:
		mov	AX,DI
		add	AX,0Eh
		mov	SI,AX
		jmp	short M006_L_02E1
M006_L_0290:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		cmp	word ptr ES:[SI+2],0
		je	short M006_L_02DE
		push	DS
		mov	AX,818Eh
		push	AX
		mov	AX,0Eh
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		mov	AX,word ptr ES:[DI]
		mov	word ptr ES:[SI],AX
		mov	AX,DGROUP:M006_BCC_DATA_8664
		mov	word ptr ES:[SI+8],AX
		mov	AX,word ptr ES:[DI+0Ah]
		mov	word ptr ES:[SI+0Ah],AX
		mov	word ptr ES:[SI+2],0
		mov	AX,word ptr ES:[DI+4]
		mov	word ptr ES:[SI+4],AX
		mov	AX,word ptr ES:[DI+6]
		mov	word ptr ES:[SI+6],AX
		mov	DI,SI
		jmp	short M006_L_02E7
M006_L_02DE:
		add	SI,0Eh
M006_L_02E1:
		cmp	SI,word ptr DGROUP:M006_BCC_DATA_8192
		jc	short M006_L_0290
M006_L_02E7:
		mov	BX,word ptr DGROUP:M006_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-6],AX
		mov	AX,DGROUP:M006_BCC_DATA_86BC
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		cmp	word ptr ES:[DI+2],0
		jne	short M006_L_030D
		mov	word ptr ES:[DI+0Ch],AX
		jmp	short M006_L_0367
M006_L_030D:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		mov	AX,word ptr ES:[DI+0Ch]
		cmp	AX,word ptr [BP-4]
		jnc	short M006_L_0367
		sub	word ptr [BP-4],4
		mov	ES,word ptr DGROUP:M006_BCC_DATA_86B8
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr ES:[BX]
		cmp	AX,word ptr [BP+6]
		jne	short M006_L_0330
		db	0E9h
		dw	00095h
M006_L_0330:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_86B8
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr ES:[BX]
		cmp	AX,word ptr [BP+6]
		jbe	short M006_L_0367
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		mov	AX,word ptr ES:[DI+0Ch]
		mov	word ptr [BP-2],AX
		jmp	short M006_L_035F
M006_L_034C:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_86B8
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
		cmp	AX,word ptr [BP+6]
		je	short M006_L_03C5
		add	word ptr [BP-2],4
M006_L_035F:
		mov	AX,word ptr [BP-2]
		cmp	AX,word ptr [BP-4]
		jbe	short M006_L_034C
M006_L_0367:
		push	DS
		mov	AX,86B8h
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_818E
		inc	word ptr ES:[DI+2]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_86B8
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[BX],AX
		mov	AX,word ptr [BP-6]
		mov	word ptr ES:[BX+2],AX
		mov	BX,word ptr DGROUP:M006_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8844
		cmp	word ptr ES:[BX+12h],0
		jne	short M006_L_03AA
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[BX+10h],AX
M006_L_03AA:
		mov	BX,word ptr DGROUP:M006_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8844
		inc	word ptr ES:[BX+12h]
		mov	AX,word ptr ES:[BX+6]
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_86B8
		sub	word ptr ES:[BX+2],AX
M006_L_03C5:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_026E	endp
CO056_TEXT	ends


		extrn	X043_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M007_BCC_DATA_885C	equ	885Ch
M007_BCC_DATA_8884	equ	8884h
M007_BCC_DATA_8894	equ	8894h
M007_BCC_DATA_88A2	equ	88A2h

		public	X056_03
X056_03	label	far
BCC_NEAR_03CD	label	near
BCC_FAR_03CD	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	AX,DGROUP:M007_BCC_DATA_88A2
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8894
		cmp	word ptr ES:[BX+6],0
		jne	short M007_L_03F2
		push	word ptr [BP-2]
		db	0E8h
		dw	0FE0Fh
		mov	SI,AX
		jmp	short M007_L_03FD
M007_L_03F2:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8894
		mov	SI,word ptr ES:[BX+8]
M007_L_03FD:
		cmp	word ptr [BP+8],7
		jne	short M007_L_0419
		mov	ES,word ptr DGROUP:M007_BCC_DATA_885C
		cmp	word ptr ES:[SI+2],3FCh
		jbe	short M007_L_042D
		push	word ptr [BP-2]
		db	0E8h
		dw	0FDE8h
		mov	SI,AX
		jmp	short M007_L_042D
M007_L_0419:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_885C
		cmp	word ptr ES:[SI+2],3FEh
		jbe	short M007_L_042D
		push	word ptr [BP-2]
		db	0E8h
		dw	0FDD2h
		mov	SI,AX
M007_L_042D:
		push	DS
		mov	AX,8884h
		push	AX
		mov	AX,8
		push	AX
		db	09Ah
		dw	X043_02
		dw	seg X043_02
		mov	DI,AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8884
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[DI+6],AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_885C
		mov	AX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8884
		mov	word ptr ES:[DI+2],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[DI+4],AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_885C
		mov	AX,word ptr ES:[SI+4]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8884
		mov	word ptr ES:[DI],AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_885C
		mov	word ptr ES:[SI+4],DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_03CD	endp
CO056_TEXT	ends


		extrn	BCC_FAR_5B44:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M008_BCC_DATA_8894	equ	8894h
M008_BCC_DATA_88A2	equ	88A2h

		public	X056_09
X056_09	label	far
BCC_FAR_047E	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr DGROUP:M008_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		cmp	word ptr ES:[DI+6],0
		jne	short M008_L_04EA
		mov	AX,word ptr ES:[DI+0Eh]
		mov	DX,word ptr ES:[DI+0Ch]
		add	DX,SI
		adc	AX,0
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		cmp	word ptr [BP-2],1
		jl	short M008_L_04CD
		jg	short M008_L_04B9
		cmp	word ptr [BP-4],0
		jbe	short M008_L_04CD
M008_L_04B9:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		push	word ptr ES:[DI+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M008_L_04CD:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr ES:[DI+0Eh],AX
		mov	word ptr ES:[DI+0Ch],DX
		jmp	short M008_L_04EE
M008_L_04E1:
		dec	SI
		mov	AL,0
		push	AX
		nop
		push	CS
		db	0E8h
		dw	0007Ch
M008_L_04EA:
		or	SI,SI
		jne	short M008_L_04E1
M008_L_04EE:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_047E	endp
CO056_TEXT	ends


		extrn	X054_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M009_BCC_DATA_86D2	equ	86D2h
M009_BCC_DATA_8894	equ	8894h
M009_BCC_DATA_88A2	equ	88A2h

		public	X056_01
X056_01	label	far
BCC_FAR_04F6	proc	far
		push	BP
		mov	BP,SP
		push	SI
		cmp	word ptr [BP+6],2
		jl	short M009_L_0561
		mov	SI,word ptr DGROUP:M009_BCC_DATA_88A2
		test	word ptr DGROUP:M009_BCC_DATA_86D2,4
		je	short M009_L_0526
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+0Ch]
		and	AX,1
		or	AX,0
		je	short M009_L_0561
		mov	AL,0
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		jmp	short M009_L_0561
M009_L_0526:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8894
		cmp	word ptr ES:[SI+6],0
		jne	short M009_L_0549
		add	word ptr ES:[SI+0Ch],1
		adc	word ptr ES:[SI+0Eh],0
		db	026h,081h,064h,00Ch
		dw	0FFFEh
		db	026h,081h,064h,00Eh
		dw	0FFFFh
		jmp	short M009_L_0561
M009_L_0549:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+0Ch]
		and	AX,1
		or	AX,0
		je	short M009_L_0561
		mov	AL,0
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00005h
M009_L_0561:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_04F6	endp
CO056_TEXT	ends


		extrn	HEAP_ALLOC_HANDLE:far
		extrn	BCC_FAR_4EB6:far
		extrn	BCC_FAR_5B44:far
		extrn	X054_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M00A_BCC_DATA_86D2	equ	86D2h
M00A_BCC_DATA_885C	equ	885Ch
M00A_BCC_DATA_8894	equ	8894h
M00A_BCC_DATA_88A2	equ	88A2h

		public	X056_00
X056_00	label	far
BCC_NEAR_0566	label	near
BCC_FAR_0566	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,word ptr DGROUP:M00A_BCC_DATA_88A2
		test	word ptr DGROUP:M00A_BCC_DATA_86D2,4
		je	short M00A_L_0586
		mov	AL,byte ptr [BP+6]
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		db	0E9h
		dw	000EBh
M00A_L_0586:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		mov	DI,word ptr ES:[SI+8]
		or	DI,DI
		je	short M00A_L_059E
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_885C
		cmp	word ptr ES:[DI+2],400h
		jc	short M00A_L_05A4
M00A_L_059E:
		push	SI
		db	0E8h
		dw	0FC5Bh
		mov	DI,AX
M00A_L_05A4:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+13h]
		or	AX,word ptr ES:[SI+15h]
		jne	short M00A_L_05DA
		mov	AX,400h
		push	AX
		db	09Ah
		dw	HEAP_ALLOC_HANDLE
		dw	seg HEAP_ALLOC_HANDLE
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		mov	word ptr ES:[SI+15h],DX
		mov	word ptr ES:[SI+13h],AX
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_885C
		mov	AX,word ptr ES:[DI]
		add	AX,word ptr ES:[DI+2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		mov	word ptr ES:[SI+17h],AX
M00A_L_05DA:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_885C
		mov	AX,word ptr ES:[DI]
		add	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		sub	AX,word ptr ES:[SI+17h]
		mov	word ptr [BP-2],AX
		test	word ptr [BP-2],3FFh
		jne	short M00A_L_061F
		add	AX,400h
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-6],0
		jne	short M00A_L_060B
		mov	word ptr [BP-6],0FFFFh
M00A_L_060B:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		push	word ptr ES:[SI+15h]
		push	word ptr ES:[SI+13h]
		push	word ptr [BP-6]
		db	09Ah
		dw	BCC_FAR_4EB6
		dw	seg BCC_FAR_4EB6
M00A_L_061F:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		les	BX,ES:[SI+13h]
		mov	ES,word ptr ES:[BX]
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[BX],AL
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_885C
		inc	word ptr ES:[DI+2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		cmp	word ptr ES:[SI+0Eh],1
		jl	short M00A_L_0663
		jne	short M00A_L_064F
		cmp	word ptr ES:[SI+0Ch],0
		jc	short M00A_L_0663
M00A_L_064F:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		push	word ptr ES:[SI+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M00A_L_0663:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8894
		add	word ptr ES:[SI+0Ch],1
		adc	word ptr ES:[SI+0Eh],0
M00A_L_0671:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_0566	endp
CO056_TEXT	ends


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M00B_BCC_DATA_813C	equ	813Ch
M00B_BCC_DATA_8140	equ	8140h
M00B_BCC_DATA_8894	equ	8894h
M00B_BCC_DATA_88A2	equ	88A2h


		public	X056_07
X056_07	label	far
BCC_FAR_0679	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	SI,word ptr DGROUP:M00B_BCC_DATA_88A2
		push	DI
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		push	word ptr ES:[SI+4]
		db	0FFh,01Eh
		dw	8140h
		push	DI
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		push	word ptr ES:[SI+0Ch]
		db	0FFh,01Eh
		dw	813Ch
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_0679	endp
CO056_TEXT	ends


		extrn	X05D_00:far
		extrn	X05D_02:far


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M00C_BCC_DATA_8654	equ	8654h

		public	X056_05
X056_05	label	far
BCC_FAR_06A5	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AX,18h
		push	AX
		push	SI
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+1Ch]
		and	AX,100h
		push	AX
		db	09Ah
		dw	X05D_02
		dw	seg X05D_02
		db	09Ah
		dw	X05D_00
		dw	seg X05D_00
		pop	SI
		pop	BP
		retf	2
BCC_FAR_06A5	endp
CO056_TEXT	ends





CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

		public	X056_04
X056_04	label	far
BCC_FAR_06CC	proc	far
		push	BP
		mov	BP,SP
		mov	AX,1
		push	AX
		push	word ptr [BP+8]
		push	CS
		db	0E8h
		dw	0FCF3h
		mov	AL,byte ptr [BP+6]
		push	AX
		push	CS
		db	0E8h
		dw	0FE84h
		mov	AX,word ptr [BP+6]
		mov	CL,8
		shr	AX,CL
		push	AX
		push	CS
		db	0E8h
		dw	0FE78h
		pop	BP
		retf	4
BCC_FAR_06CC	endp
CO056_TEXT	ends





CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

		public	X056_08
X056_08	label	far
BCC_FAR_06F2	proc	far
		push	BP
		mov	BP,SP
		mov	AX,7
		push	AX
		push	word ptr [BP+8]
		push	CS
		db	0E8h
		dw	0FCCDh
		mov	AL,byte ptr [BP+6]
		push	AX
		push	CS
		db	0E8h
		dw	0FE5Eh
		mov	AX,word ptr [BP+6]
		mov	CL,8
		shr	AX,CL
		push	AX
		push	CS
		db	0E8h
		dw	0FE52h
		mov	AL,0
		push	AX
		push	CS
		db	0E8h
		dw	0FE4Bh
		mov	AL,0
		push	AX
		push	CS
		db	0E8h
		dw	0FE44h
		pop	BP
		retf	4
BCC_FAR_06F2	endp
CO056_TEXT	ends


CO056_TEXT	segment byte public 'CODE'
		assume	cs:CO056_TEXT,ds:DGROUP

M00F_BCC_DATA_8894	equ	8894h
M00F_BCC_DATA_889E	equ	889Eh


		public	X056_0B
X056_0B	label	far
BCC_FAR_0726	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr DGROUP:M00F_BCC_DATA_889E
		jmp	short M00F_L_074A
M00F_L_0730:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+0Ch]
		or	AX,word ptr ES:[SI+0Eh]
		je	short M00F_L_0743
		mov	AX,1
		jmp	short M00F_L_0750
M00F_L_0743:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8894
		mov	SI,word ptr ES:[SI]
M00F_L_074A:
		or	SI,SI
		jne	short M00F_L_0730
		xor	AX,AX
M00F_L_0750:
		pop	SI
		pop	BP
		retf
BCC_FAR_0726	endp
CO056_TEXT	ends

; END C108UNIT
		end
