		public	X077_01
		public	X077_03
		public	X077_02
		public	X077_00
		public	X077_07
		public	X077_06
		public	X077_05
		public	X077_04
		public	X077_09
		public	X077_08
		public	X077_0C
		public	X077_0B
		public	X077_0A
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1de3_b3c8
; BEGIN C102UNIT (listing ovr_1de3_b3c8:3C80)

		extrn	X056_06:far
		extrn	X056_0E:far
		extrn	X05D_07:far
		extrn	X05D_0C:far
		extrn	X05D_0E:far
		extrn	X076_0A:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M000_BCC_DATA_5924	equ	5924h
M000_BCC_DATA_7846	equ	7846h
M000_BCC_DATA_86CE	equ	86CEh
M000_BCC_DATA_8894	equ	8894h
M000_BCC_DATA_88A2	equ	88A2h
M000_BCC_DATA_88AC	equ	88ACh

		public	X077_05
X077_05	label	far
STAOV189	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		test	word ptr DGROUP:M000_BCC_DATA_88AC,1
		jne	short M000_L_3C98
		db	09Ah
		dw	X076_0A
		dw	seg X076_0A
M000_L_3C98:
		cmp	word ptr DGROUP:M000_BCC_DATA_86CE,DI
		jne	short M000_L_3CA1
		db	0E9h
		dw	00102h
M000_L_3CA1:
		mov	word ptr DGROUP:M000_BCC_DATA_5924,0FFFFh
		db	0E8h
		dw	00545h
		mov	AX,DGROUP:M000_BCC_DATA_86CE
		mov	word ptr [BP-2],AX
		or	DI,DI
		jne	short M000_L_3CBD
		mov	word ptr DGROUP:M000_BCC_DATA_86CE,0
		db	0E9h
		dw	000E8h
M000_L_3CBD:
		push	DI
		db	09Ah
		dw	X056_06
		dw	seg X056_06
		mov	DI,AX
		mov	SI,word ptr DGROUP:M000_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+19h]
		and	AX,7FFFh
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],0
		je	short M000_L_3CE7
		push	word ptr [BP-4]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	SI,AX
M000_L_3CE7:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		push	word ptr ES:[SI+11h]
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		push	DS
		mov	AX,5994h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		cmp	byte ptr ES:[SI+10h],10h
		jne	short M000_L_3D13
		push	DS
		mov	AX,599Eh
		jmp	short M000_L_3D28
M000_L_3D13:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		cmp	byte ptr ES:[SI+10h],1
		jle	short M000_L_3D24
		push	DS
		mov	AX,597Fh
		jmp	short M000_L_3D28
M000_L_3D24:
		push	DS
		mov	AX,597Ah
M000_L_3D28:
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	DS
		mov	AX,59A3h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_7846
		cmp	byte ptr ES:[BX],0
		je	short M000_L_3D6D
		mov	AX,27h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		push	word ptr ES:[SI+0Ah]
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		mov	AX,27h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
M000_L_3D6D:
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+4]
		mov	DGROUP:M000_BCC_DATA_5924,AX
		cmp	word ptr [BP-4],0
		je	short M000_L_3DA3
		mov	BX,word ptr DGROUP:M000_BCC_DATA_88A2
		push	word ptr ES:[BX+11h]
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		push	DS
		mov	AX,59AFh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
M000_L_3DA3:
		mov	AX,DI
M000_L_3DA5:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV189	endp
CO077_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	X05D_0C:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M001_BCC_DATA_8894	equ	8894h
M001_BCC_DATA_88A2	equ	88A2h

		public	X077_0C
X077_0C	label	far
BCC_NEAR_3DAD	label	near
STAOV190	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	SI,word ptr DGROUP:M001_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+0Eh]
		mov	DX,word ptr ES:[SI+0Ch]
		add	DX,DI
		adc	AX,0
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		cmp	word ptr [BP-2],1
		jl	short M001_L_3DF5
		jg	short M001_L_3DE1
		cmp	word ptr [BP-4],0
		jbe	short M001_L_3DF5
M001_L_3DE1:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		push	word ptr ES:[SI+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M001_L_3DF5:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr ES:[SI+0Eh],AX
		mov	word ptr ES:[SI+0Ch],DX
		push	DS
		mov	AX,59C2h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00471h
		push	DS
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		cmp	word ptr ES:[SI+6],0
		je	short M001_L_3E28
		mov	AX,59C7h
		jmp	short M001_L_3E2B
M001_L_3E28:
		mov	AX,59D2h
M001_L_3E2B:
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV190	endp
CO077_TEXT	ends




CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M002_BCC_DATA_8894	equ	8894h
M002_BCC_DATA_88A2	equ	88A2h

		public	X077_02
X077_02	label	far
STAOV191	proc	far
		push	BP
		mov	BP,SP
		cmp	word ptr [BP+6],2
		jl	short M002_L_3E5E
		mov	BX,word ptr DGROUP:M002_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		and	AX,1
		or	AX,0
		je	short M002_L_3E5E
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FF4Fh
M002_L_3E5E:
		pop	BP
		retf	2
STAOV191	endp
CO077_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	X05D_0C:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M003_BCC_DATA_8894	equ	8894h
M003_BCC_DATA_88A2	equ	88A2h

		public	X077_00
X077_00	label	far
STAOV192	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr DGROUP:M003_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8894
		cmp	word ptr ES:[SI+0Eh],1
		jl	short M003_L_3E92
		jne	short M003_L_3E7E
		cmp	word ptr ES:[SI+0Ch],0
		jc	short M003_L_3E92
M003_L_3E7E:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8894
		push	word ptr ES:[SI+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M003_L_3E92:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8894
		add	word ptr ES:[SI+0Ch],1
		adc	word ptr ES:[SI+0Eh],0
		mov	word ptr ES:[SI+6],1
		push	DS
		mov	AX,59C2h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		push	AX
		nop
		push	CS
		db	0E8h
		dw	003A8h
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	SI
		pop	BP
		retf	2
STAOV192	endp
CO077_TEXT	ends


		extrn	X056_07:far
		extrn	X056_0E:far
		extrn	X05D_0C:far
		extrn	X05D_0E:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M004_BCC_DATA_80C0	equ	80C0h
M004_BCC_DATA_80D4	equ	80D4h
M004_BCC_DATA_8150	equ	8150h
M004_BCC_DATA_8160	equ	8160h
M004_BCC_DATA_8168	equ	8168h
M004_BCC_DATA_8664	equ	8664h
M004_BCC_DATA_8894	equ	8894h

		public	X077_06
X077_06	label	far
STAOV193	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		push	DI
		db	09Ah
		dw	X056_07
		dw	seg X056_07
		push	DI
		db	0FFh,01Eh
		dw	8150h
		cmp	AX,1
		je	short M004_L_3EEF
		push	DI
		db	0FFh,01Eh
		dw	8150h
		cmp	AX,3
		je	short M004_L_3EEF
		db	0E9h
		dw	000CCh
M004_L_3EEF:
		push	DI
		db	0FFh,01Eh
		dw	8160h
		cmp	AL,12h
		je	short M004_L_3EFB
		db	0E9h
		dw	0008Dh
M004_L_3EFB:
		push	DS
		mov	AX,59DDh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	word ptr DGROUP:M004_BCC_DATA_8664
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	SI,AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		cmp	word ptr ES:[SI+19h],0
		jle	short M004_L_3F26
		push	word ptr ES:[SI+19h]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	SI,AX
M004_L_3F26:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		cmp	word ptr ES:[SI+2],0
		je	short M004_L_3F3B
		mov	BX,word ptr ES:[SI+2]
		mov	AX,word ptr ES:[BX+4]
		jmp	short M004_L_3F43
M004_L_3F3B:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		mov	AX,word ptr ES:[SI+11h]
M004_L_3F43:
		push	AX
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	DI
		db	0FFh,01Eh
		dw	80C0h
		push	DS
		mov	AX,59E9h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	DI
		db	0FFh,01Eh
		dw	8168h
		push	AX
		db	0FFh,01Eh
		dw	80D4h
		test	AX,1
		je	short M004_L_3F7C
		push	DS
		mov	AX,5990h
		push	AX
		jmp	short M004_L_3FAC
M004_L_3F7C:
		push	DS
		mov	AX,59F0h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		jmp	short M004_L_3FB1
M004_L_3F88:
		push	DI
		db	0FFh,01Eh
		dw	80C0h
		push	DS
		mov	AX,59F5h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	DI
		db	0FFh,01Eh
		dw	8160h
		mov	AH,0
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		push	word ptr [BX+5924h]
		push	word ptr [BX+5922h]
M004_L_3FAC:
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
M004_L_3FB1:
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
M004_L_3FBB:
		pop	DI
		pop	SI
		pop	BP
		retf	2
STAOV193	endp
CO077_TEXT	ends


		extrn	X05D_0C:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M005_BCC_DATA_80C0	equ	80C0h
M005_BCC_DATA_86D4	equ	86D4h

		public	X077_01
X077_01	label	far
STAOV194	proc	far
		push	BP
		mov	BP,SP
		push	word ptr DGROUP:M005_BCC_DATA_86D4
		db	0FFh,01Eh
		dw	80C0h
		push	DS
		mov	AX,59FDh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	BP
		retf
STAOV194	endp
CO077_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	X05D_07:far
		extrn	X05D_0C:far
		extrn	X076_00:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M006_BCC_DATA_80C0	equ	80C0h
M006_BCC_DATA_8894	equ	8894h
M006_BCC_DATA_88A2	equ	88A2h

		public	X077_08
X077_08	label	far
STAOV195	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		mov	BX,word ptr DGROUP:M006_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8894
		add	word ptr ES:[BX+0Ch],2
		adc	word ptr ES:[BX+0Eh],0
		cmp	word ptr ES:[BX+0Eh],1
		jl	short M006_L_401D
		jg	short M006_L_4005
		cmp	word ptr ES:[BX+0Ch],0
		jbe	short M006_L_401D
M006_L_4005:
		mov	BX,word ptr DGROUP:M006_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8894
		push	word ptr ES:[BX+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M006_L_401D:
		mov	BX,word ptr DGROUP:M006_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8894
		mov	word ptr ES:[BX+6],1
		push	DS
		mov	AX,5A05h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	SI
		db	09Ah
		dw	X076_00
		dw	seg X076_00
		push	SI
		db	0FFh,01Eh
		dw	80C0h
		or	DI,DI
		je	short M006_L_4053
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00235h
M006_L_4053:
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV195	endp
CO077_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	X05D_07:far
		extrn	X05D_0C:far
		extrn	X076_00:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M007_BCC_DATA_80C0	equ	80C0h
M007_BCC_DATA_8894	equ	8894h
M007_BCC_DATA_88A2	equ	88A2h

		public	X077_0B
X077_0B	label	far
STAOV196	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		mov	BX,word ptr DGROUP:M007_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8894
		add	word ptr ES:[BX+0Ch],4
		adc	word ptr ES:[BX+0Eh],0
		cmp	word ptr ES:[BX+0Eh],1
		jl	short M007_L_40A8
		jg	short M007_L_4090
		cmp	word ptr ES:[BX+0Ch],0
		jbe	short M007_L_40A8
M007_L_4090:
		mov	BX,word ptr DGROUP:M007_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8894
		push	word ptr ES:[BX+11h]
		mov	AX,21h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		add	SP,4
M007_L_40A8:
		mov	BX,word ptr DGROUP:M007_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8894
		mov	word ptr ES:[BX+6],1
		push	DS
		mov	AX,5A0Ah
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	SI
		db	09Ah
		dw	X076_00
		dw	seg X076_00
		push	SI
		db	0FFh,01Eh
		dw	80C0h
		or	DI,DI
		je	short M007_L_40DE
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		push	DI
		nop
		push	CS
		db	0E8h
		dw	001AAh
M007_L_40DE:
		push	DS
		mov	AX,59ACh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV196	endp
CO077_TEXT	ends


		extrn	X05D_07:far
		extrn	X05D_0C:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M008_BCC_DATA_86F5	equ	86F5h

		public	X077_04
X077_04	label	far
STAOV197	proc	far
		push	BP
		mov	BP,SP
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		push	word ptr DGROUP:M008_BCC_DATA_86F5
		nop
		push	CS
		db	0E8h
		dw	00185h
		push	DS
		mov	AX,5A0Fh
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		push	word ptr [BP+6]
		nop
		push	CS
		db	0E8h
		dw	00173h
		push	DS
		mov	AX,5A12h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		pop	BP
		retf	2
STAOV197	endp
CO077_TEXT	ends


		extrn	X05D_00:far
		extrn	X05D_02:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M009_BCC_DATA_8654	equ	8654h

		public	X077_09
X077_09	label	far
STAOV198	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AX,18h
		push	AX
		push	SI
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
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
STAOV198	endp
CO077_TEXT	ends


		extrn	X055_0D:far
		extrn	X05D_07:far
		extrn	X064_02:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M00A_BCC_DATA_1700	equ	1700h
M00A_BCC_DATA_86D8	equ	86D8h
M00A_BCC_DATA_8B48	equ	8B48h

		public	X077_0A
X077_0A	label	far
STAOV199	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		push	word ptr [BP+8]
		db	09Ah
		dw	X064_02
		dw	seg X064_02
		mov	DI,AX
		or	DI,DI
		jne	short M00A_L_4163
		db	0E9h
		dw	00086h
M00A_L_4163:
		cmp	byte ptr DGROUP:M00A_BCC_DATA_1700,0
		je	short M00A_L_417A
		cmp	word ptr DGROUP:M00A_BCC_DATA_8B48,DI
		je	short M00A_L_417A
		push	DI
		db	09Ah
		dw	X055_0D
		dw	seg X055_0D
		mov	word ptr DGROUP:M00A_BCC_DATA_8B48,DI
M00A_L_417A:
		mov	AX,0FFh
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,1
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,SI
		mov	CL,0Ch
		shr	AX,CL
		and	AX,0Fh
		add	AX,61h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,SI
		mov	CL,8
		shr	AX,CL
		and	AX,0Fh
		add	AX,61h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,SI
		mov	CL,4
		shr	AX,CL
		and	AX,0Fh
		add	AX,61h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,SI
		and	AX,0Fh
		add	AX,61h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,word ptr [BP+8]
		cmp	AX,word ptr DGROUP:M00A_BCC_DATA_86D8
		jne	short M00A_L_41DE
		mov	AX,1
		jmp	short M00A_L_41E0
M00A_L_41DE:
		xor	AX,AX
M00A_L_41E0:
		add	AX,30h
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
M00A_L_41E9:
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV199	endp
CO077_TEXT	ends


		extrn	X056_0E:far
		extrn	X05D_0C:far
		extrn	X05D_0E:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

M00B_BCC_DATA_5924	equ	5924h
M00B_BCC_DATA_8894	equ	8894h
M00B_BCC_DATA_88A2	equ	88A2h

BCC_NEAR_41EF	label	near
STAOV200	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		cmp	word ptr DGROUP:M00B_BCC_DATA_88A2,0
		je	short M00B_L_425F
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		push	word ptr ES:[BX+11h]
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		push	DS
		mov	AX,5A20h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		cmp	word ptr ES:[BX+19h],0
		je	short M00B_L_4253
		mov	AX,word ptr ES:[BX+19h]
		and	AX,7FFFh
		push	AX
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		push	word ptr ES:[SI+11h]
		mov	AX,7846h
		push	AX
		db	09Ah
		dw	X05D_0E
		dw	seg X05D_0E
		push	DS
		mov	AX,5A20h
		push	AX
		db	09Ah
		dw	X05D_0C
		dw	seg X05D_0C
M00B_L_4253:
		mov	word ptr DGROUP:M00B_BCC_DATA_88A2,0
		mov	word ptr DGROUP:M00B_BCC_DATA_5924,0
M00B_L_425F:
		pop	SI
		pop	BP
		dec	BP
		ret
STAOV200	endp
CO077_TEXT	ends



		extrn	X05D_07:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

		public	X077_03
X077_03	label	far
BCC_NEAR_4263	label	near
STAOV201	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		jge	short M00C_L_427D
		mov	AX,2Dh
		push	AX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		mov	AX,SI
		neg	AX
		mov	SI,AX
M00C_L_427D:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00005h
		pop	SI
		pop	BP
		retf	2
STAOV201	endp
CO077_TEXT	ends



		extrn	X05D_07:far


CO077_TEXT	segment byte public 'CODE'
		assume	cs:CO077_TEXT,ds:DGROUP

		public	X077_07
X077_07	label	far
BCC_NEAR_4288	label	near
STAOV202	proc	far
M00D_L_4288:
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AX,SI
		mov	BX,0Ah
		xor	DX,DX
		div	BX
		or	AX,AX
		je	short M00D_L_42A7
		mov	AX,SI
		xor	DX,DX
		div	BX
		push	AX
		push	CS
		db	0E8h
		dw	0FFE1h
M00D_L_42A7:
		mov	AX,SI
		mov	BX,0Ah
		xor	DX,DX
		div	BX
		add	DX,30h
		push	DX
		db	09Ah
		dw	X05D_07
		dw	seg X05D_07
		pop	SI
		pop	BP
		retf	2
STAOV202	endp
CO077_TEXT	ends

; END C102UNIT
		end
