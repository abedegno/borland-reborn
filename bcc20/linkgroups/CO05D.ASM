		public	X05D_01
		public	X05D_06
		public	X05D_08
		public	X05D_09
		public	X05D_02
		public	X05D_03
		public	X05D_00
		public	X05D_07
		public	X05D_04
		public	X05D_05
		public	X05D_0C
		public	X05D_0B
		public	X05D_0A
		public	X05D_0D
		public	X05D_0E
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d6f_a49b
; BEGIN C114UNIT (listing ovr_1d6f_a49b:49B0)



CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M000_BCC_DATA_5366	equ	5366h
M000_BCC_DATA_86D2	equ	86D2h
M000_BCC_DATA_86D6	equ	86D6h
M000_BCC_DATA_87D8	equ	87D8h
M000_BCC_DATA_8840	equ	8840h
M000_BCC_DATA_8842	equ	8842h
M000_BCC_DATA_8848	equ	8848h
M000_BCC_DATA_884A	equ	884Ah

		public	X05D_06
X05D_06	label	far
BCC_FAR_49B0	proc	far
		push	BP
		mov	BP,SP
		mov	word ptr DGROUP:M000_BCC_DATA_5366,0
		mov	word ptr DGROUP:M000_BCC_DATA_884A,0
		mov	word ptr DGROUP:M000_BCC_DATA_8848,2
		mov	word ptr DGROUP:M000_BCC_DATA_8840,0
		mov	word ptr DGROUP:M000_BCC_DATA_8842,0
		push	word ptr DGROUP:M000_BCC_DATA_86D6
		db	0FFh,01Eh
		dw	87D8h
		nop
		push	CS
		db	0E8h
		dw	00008h
		db	081h,00Eh,0D2h,086h,004h,000h
		pop	BP
		retf
BCC_FAR_49B0	endp
CO05D_TEXT	ends


		extrn	X043_03:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M001_BCC_DATA_8840	equ	8840h
M001_BCC_DATA_8844	equ	8844h
M001_BCC_DATA_8848	equ	8848h
M001_BCC_DATA_8894	equ	8894h
M001_BCC_DATA_88A2	equ	88A2h
M001_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_0D
X05D_0D	label	far
BCC_NEAR_49E6	label	near
BCC_FAR_49E6	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,8844h
		push	AX
		mov	AX,18h
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	DGROUP:M001_BCC_DATA_8B1C,AX
		mov	BX,word ptr DGROUP:M001_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		mov	BX,word ptr DGROUP:M001_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8844
		mov	word ptr ES:[BX+6],AX
		mov	AX,DGROUP:M001_BCC_DATA_8840
		mov	word ptr ES:[BX+2],AX
		mov	word ptr ES:[BX+0Eh],0
		mov	AX,DGROUP:M001_BCC_DATA_8848
		mov	word ptr ES:[BX+0Ch],AX
		mov	word ptr ES:[BX],0
		mov	word ptr ES:[BX+8],100h
		mov	word ptr ES:[BX+12h],0
		mov	word ptr ES:[BX+14h],0
		mov	word ptr ES:[BX+16h],0
		pop	BP
		retf
BCC_FAR_49E6	endp
CO05D_TEXT	ends


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M002_BCC_DATA_1714	equ	1714h
M002_BCC_DATA_8840	equ	8840h
M002_BCC_DATA_8844	equ	8844h
M002_BCC_DATA_8894	equ	8894h
M002_BCC_DATA_88A2	equ	88A2h
M002_BCC_DATA_8B1C	equ	8B1Ch


		public	X05D_0A
X05D_0A	label	far
BCC_NEAR_4A45	label	near
BCC_FAR_4A45	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr DGROUP:M002_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8844
		cmp	word ptr ES:[BX+0Eh],-1
		je	short M002_L_4A85
		mov	BX,word ptr DGROUP:M002_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		mov	BX,word ptr DGROUP:M002_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8844
		sub	AX,word ptr ES:[BX+6]
		mov	word ptr ES:[BX+4],AX
		cmp	byte ptr DGROUP:M002_BCC_DATA_1714,0
		je	short M002_L_4A85
		mov	AX,DGROUP:M002_BCC_DATA_8840
		sub	AX,word ptr ES:[BX+2]
		mov	word ptr ES:[BX+0Eh],AX
M002_L_4A85:
		pop	BP
		retf
BCC_FAR_4A45	endp
CO05D_TEXT	ends




CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M003_BCC_DATA_8844	equ	8844h
M003_BCC_DATA_8894	equ	8894h
M003_BCC_DATA_88A2	equ	88A2h
M003_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_01
X05D_01	label	far
BCC_NEAR_4A87	label	near
BCC_FAR_4A87	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	BX,word ptr DGROUP:M003_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8844
		mov	AX,word ptr ES:[BX+6]
		xor	DX,DX
		mov	BX,word ptr DGROUP:M003_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8894
		cmp	DX,word ptr ES:[BX+0Eh]
		jne	short M003_L_4ABC
		cmp	AX,word ptr ES:[BX+0Ch]
		jne	short M003_L_4ABC
		mov	BX,word ptr DGROUP:M003_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8844
		cmp	word ptr ES:[BX+0Eh],-1
		jne	short M003_L_4AD2
M003_L_4ABC:
		mov	SI,word ptr DGROUP:M003_BCC_DATA_8B1C
		push	CS
		db	0E8h
		dw	0FF81h
		push	CS
		db	0E8h
		dw	0FF1Eh
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8844
		mov	AX,DGROUP:M003_BCC_DATA_8B1C
		mov	word ptr ES:[SI],AX
M003_L_4AD2:
		pop	SI
		pop	BP
		retf
BCC_FAR_4A87	endp
CO05D_TEXT	ends


		extrn	X043_03:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M004_BCC_DATA_8844	equ	8844h
M004_BCC_DATA_8894	equ	8894h
M004_BCC_DATA_88A2	equ	88A2h
M004_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_09
X05D_09	label	far
BCC_FAR_4AD5	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,8844h
		push	AX
		mov	AX,6
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	SI,AX
		mov	BX,word ptr DGROUP:M004_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		mov	BX,word ptr DGROUP:M004_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8844
		sub	AX,word ptr ES:[BX+6]
		mov	word ptr ES:[SI],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+2],AX
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+4],AX
		inc	word ptr ES:[BX+0Eh]
		pop	SI
		pop	BP
		retf	4
BCC_FAR_4AD5	endp
CO05D_TEXT	ends




CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M005_BCC_DATA_8844	equ	8844h
M005_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_03
X05D_03	label	far
BCC_FAR_4B1B	proc	far
		push	BP
		mov	BP,SP
		push	CS
		db	0E8h
		dw	0FF65h
		mov	BX,word ptr DGROUP:M005_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8844
		mov	word ptr ES:[BX+0Eh],0FFFFh
		mov	word ptr ES:[BX+4],0FFFFh
		push	CS
		db	0E8h
		dw	0FF4Dh
		pop	BP
		retf
BCC_FAR_4B1B	endp
CO05D_TEXT	ends




CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M006_BCC_DATA_1714	equ	1714h
M006_BCC_DATA_8114	equ	8114h
M006_BCC_DATA_8844	equ	8844h
M006_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_02
X05D_02	label	far
BCC_FAR_4B3C	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		cmp	byte ptr DGROUP:M006_BCC_DATA_1714,0
		je	short M006_L_4B51
		push	SI
		db	0FFh,01Eh
		dw	8114h
		jmp	short M006_L_4B6B
M006_L_4B51:
		push	CS
		db	0E8h
		dw	0FF32h
		mov	BX,word ptr DGROUP:M006_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8844
		mov	word ptr ES:[BX+0Eh],0FFFFh
		mov	word ptr ES:[BX+4],SI
		push	CS
		db	0E8h
		dw	0FF1Ch
M006_L_4B6B:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_4B3C	endp
CO05D_TEXT	ends





CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

		public	X05D_04
X05D_04	label	far
BCC_FAR_4B70	proc	far
		push	BP
		mov	BP,SP
		push	word ptr [BP+6]
		nop
		push	CS
		db	0E8h
		dw	000A1h
		pop	BP
		retf	2
BCC_FAR_4B70	endp
CO05D_TEXT	ends


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M008_BCC_DATA_8654	equ	8654h
M008_BCC_DATA_8844	equ	8844h
M008_BCC_DATA_8894	equ	8894h
M008_BCC_DATA_88A2	equ	88A2h
M008_BCC_DATA_8B1C	equ	8B1Ch


		public	X05D_08
X05D_08	label	far
BCC_FAR_4B7F	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ah]
		mov	DI,word ptr [BP+8]
		mov	DX,2
		cmp	SI,18h
		je	short M008_L_4BA2
		cmp	SI,14h
		jl	short M008_L_4B9C
		cmp	SI,17h
		jle	short M008_L_4BA2
M008_L_4B9C:
		cmp	word ptr [BP+6],0
		je	short M008_L_4BAC
M008_L_4BA2:
		or	SI,100h
		and	SI,0FDFFh
		jmp	short M008_L_4BBB
M008_L_4BAC:
		cmp	SI,1
		jne	short M008_L_4BB6
		mov	AX,3
		jmp	short M008_L_4BB9
M008_L_4BB6:
		mov	AX,5
M008_L_4BB9:
		mov	DX,AX
M008_L_4BBB:
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8844
		mov	word ptr ES:[BX+8],SI
		mov	AX,DX
		mov	BX,word ptr DGROUP:M008_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		add	word ptr ES:[BX+0Ch],AX
		adc	word ptr ES:[BX+0Eh],0
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		cmp	word ptr ES:[DI+1Eh],-1
		je	short M008_L_4BF7
		mov	AX,word ptr ES:[DI+1Eh]
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8844
		mov	word ptr ES:[BX+0Ah],AX
		jmp	short M008_L_4C16
M008_L_4BF7:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		mov	AX,word ptr ES:[DI+1Ah]
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B1C
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8844
		mov	word ptr ES:[BX+0Ah],AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		mov	AX,DGROUP:M008_BCC_DATA_8B1C
		mov	word ptr ES:[DI+1Ah],AX
M008_L_4C16:
		pop	DI
		pop	SI
		pop	BP
		retf	6
BCC_FAR_4B7F	endp
CO05D_TEXT	ends




CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M009_BCC_DATA_8654	equ	8654h
M009_BCC_DATA_8844	equ	8844h
M009_BCC_DATA_8B1C	equ	8B1Ch

		public	X05D_05
X05D_05	label	far
BCC_NEAR_4C1C	label	near
BCC_FAR_4C1C	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	CS
		db	0E8h
		dw	0FE62h
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	AX,DGROUP:M009_BCC_DATA_8B1C
		mov	word ptr ES:[BX+1Eh],AX
		mov	SI,word ptr ES:[BX+1Ah]
		jmp	short M009_L_4C4A
M009_L_4C39:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8844
		mov	DI,word ptr ES:[SI+0Ah]
		mov	AX,DGROUP:M009_BCC_DATA_8B1C
		mov	word ptr ES:[SI+0Ah],AX
		mov	SI,DI
M009_L_4C4A:
		or	SI,SI
		jne	short M009_L_4C39
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_4C1C	endp
CO05D_TEXT	ends


		extrn	BCC_FAR_5E71:far
		extrn	BCC_FAR_5E92:far
		extrn	X032_00:far
		extrn	X032_02:far
		extrn	X032_09:far
		extrn	X065_0A:far
		extrn	X077_07:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M00A_BCC_DATA_1700	equ	1700h
M00A_BCC_DATA_1701	equ	1701h
M00A_BCC_DATA_1715	equ	1715h
M00A_BCC_DATA_5364	equ	5364h
M00A_BCC_DATA_5366	equ	5366h
M00A_BCC_DATA_86D8	equ	86D8h
M00A_BCC_DATA_86DA	equ	86DAh
M00A_BCC_DATA_86DC	equ	86DCh
M00A_BCC_DATA_86DE	equ	86DEh
M00A_BCC_DATA_86F5	equ	86F5h
M00A_BCC_DATA_883C	equ	883Ch
M00A_BCC_DATA_8844	equ	8844h

BCC_NEAR_4C54	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		push	word ptr DGROUP:M00A_BCC_DATA_86DA
		push	word ptr DGROUP:M00A_BCC_DATA_86D8
		push	word ptr DGROUP:M00A_BCC_DATA_86DE
		push	word ptr DGROUP:M00A_BCC_DATA_86DC
		db	09Ah
		dw	X032_00
		dw	seg X032_00
		mov	word ptr [BP-2],2
		db	0E9h
		dw	00250h
M00A_L_4C7A:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8844
		test	word ptr ES:[BX+16h],1
		je	short M00A_L_4CB4
		mov	AL,40h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		push	word ptr DGROUP:M00A_BCC_DATA_86F5
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		mov	AL,40h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		push	word ptr [BP-2]
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		push	DS
		mov	AX,540Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
M00A_L_4CB4:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8844
		mov	AX,word ptr ES:[BX+8]
		mov	word ptr [BP-4],AX
		mov	AX,word ptr ES:[BX+0Eh]
		mov	word ptr [BP-8],AX
		mov	SI,word ptr ES:[BX+2]
		db	0E9h
		dw	000ABh
M00A_L_4CD0:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_883C
		cmp	byte ptr ES:[SI],0FFh
		je	short M00A_L_4CDD
		db	0E9h
		dw	0008Eh
M00A_L_4CDD:
		inc	SI
		dec	word ptr [BP-8]
		mov	BX,SI
		inc	SI
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		cmp	AX,1
		je	short M00A_L_4CF1
		db	0E9h
		dw	0008Ah
M00A_L_4CF1:
		xor	DI,DI
		mov	word ptr [BP-0Ah],0
		jmp	short M00A_L_4D14
M00A_L_4CFA:
		mov	AX,DI
		mov	CL,4
		shl	AX,CL
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_883C
		mov	DL,byte ptr ES:[SI]
		mov	DH,0
		add	AX,DX
		sub	AX,61h
		mov	DI,AX
		inc	SI
		inc	word ptr [BP-0Ah]
M00A_L_4D14:
		cmp	word ptr [BP-0Ah],4
		jc	short M00A_L_4CFA
		mov	AL,DGROUP:M00A_BCC_DATA_1715
		cbw
		or	AX,AX
		jne	short M00A_L_4D32
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_883C
		cmp	byte ptr ES:[SI],30h
		je	short M00A_L_4D32
		push	DI
		db	09Ah
		dw	X032_02
		dw	seg X032_02
M00A_L_4D32:
		inc	SI
		sub	word ptr [BP-8],5
		cmp	DI,word ptr DGROUP:M00A_BCC_DATA_5366
		je	short M00A_L_4D7B
		mov	word ptr DGROUP:M00A_BCC_DATA_5366,DI
		cmp	byte ptr DGROUP:M00A_BCC_DATA_1701,0
		jne	short M00A_L_4D4F
		cmp	byte ptr DGROUP:M00A_BCC_DATA_1700,0
		je	short M00A_L_4D7B
M00A_L_4D4F:
		push	DS
		mov	AX,540Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		push	DI
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		push	DS
		mov	AX,540Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		jmp	short M00A_L_4D7B
M00A_L_4D6B:
		mov	BX,SI
		inc	SI
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_883C
		mov	AL,byte ptr ES:[BX]
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
M00A_L_4D7B:
		mov	AX,word ptr [BP-8]
		dec	word ptr [BP-8]
		or	AX,AX
		je	short M00A_L_4D88
		db	0E9h
		dw	0FF48h
M00A_L_4D88:
		mov	word ptr [BP-6],0
		test	word ptr [BP-4],0F8FFh
		jne	short M00A_L_4D97
		db	0E9h
		dw	00126h
M00A_L_4D97:
		mov	AL,9
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		cmp	word ptr [BP-4],118h
		jne	short M00A_L_4DB3
		push	DS
		mov	AX,5419h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		db	0E9h
		dw	000AEh
M00A_L_4DB3:
		test	word ptr [BP-4],100h
		jne	short M00A_L_4DCB
		cmp	word ptr [BP-4],1
		je	short M00A_L_4DCB
		mov	AX,word ptr [BP-4]
		and	AX,0F9FFh
		cmp	AX,1
		jne	short M00A_L_4E1F
M00A_L_4DCB:
		push	DS
		mov	BX,word ptr [BP-4]
		and	BX,0F8FFh
		shl	BX,1
		push	word ptr [BX+5368h]
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		mov	AL,9
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		test	word ptr [BP-4],100h
		je	short M00A_L_4DF9
		push	DS
		mov	AX,541Dh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		jmp	short M00A_L_4E61
M00A_L_4DF9:
		test	word ptr [BP-4],200h
		je	short M00A_L_4E0C
		push	DS
		mov	AX,5424h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		jmp	short M00A_L_4E61
M00A_L_4E0C:
		test	word ptr [BP-4],400h
		je	short M00A_L_4E61
		push	DS
		mov	AX,542Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		jmp	short M00A_L_4E61
M00A_L_4E1F:
		push	DS
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0A
		dw	seg X065_0A
		shl	AX,1
		mov	BX,AX
		push	word ptr [BX+5368h]
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		push	DS
		mov	AX,5437h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		push	word ptr DGROUP:M00A_BCC_DATA_5364
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		push	DS
		mov	AX,540Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		push	DS
		mov	AX,543Bh
		push	AX
		nop
		push	CS
		db	0E8h
		dw	007A0h
		mov	word ptr [BP-6],1
M00A_L_4E61:
		push	DS
		mov	AX,5439h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		push	word ptr DGROUP:M00A_BCC_DATA_86F5
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		mov	AL,40h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8844
		push	word ptr ES:[BX+0Ah]
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		push	DS
		mov	AX,540Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		cmp	word ptr [BP-6],0
		je	short M00A_L_4EBD
		push	DS
		mov	AX,5438h
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
		mov	AX,DGROUP:M00A_BCC_DATA_5364
		inc	word ptr DGROUP:M00A_BCC_DATA_5364
		push	AX
		db	09Ah
		dw	X077_07
		dw	seg X077_07
		push	DS
		mov	AX,540Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
M00A_L_4EBD:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8844
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-2],AX
M00A_L_4ECA:
		cmp	word ptr [BP-2],0
		je	short M00A_L_4ED3
		db	0E9h
		dw	0FDA7h
M00A_L_4ED3:
		db	09Ah
		dw	X032_09
		dw	seg X032_09
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
BCC_NEAR_4C54	endp
CO05D_TEXT	ends


		extrn	X055_00:far
		extrn	X055_08:far
		extrn	X056_03:far
		extrn	X056_00:far
		extrn	X065_0A:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M00B_BCC_DATA_1700	equ	1700h
M00B_BCC_DATA_80D8	equ	80D8h
M00B_BCC_DATA_8110	equ	8110h
M00B_BCC_DATA_8114	equ	8114h
M00B_BCC_DATA_8654	equ	8654h
M00B_BCC_DATA_883C	equ	883Ch
M00B_BCC_DATA_8844	equ	8844h
M00B_BCC_DATA_8894	equ	8894h
M00B_BCC_DATA_88A2	equ	88A2h

BCC_NEAR_4EDF	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,12h
		push	SI
		push	DI
		mov	word ptr [BP-2],1
		mov	DI,2
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[DI+6]
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		mov	word ptr ES:[BX+0Eh],0
		mov	word ptr ES:[BX+0Ch],AX
		db	0E9h
		dw	00210h
M00B_L_4F0D:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		cmp	word ptr ES:[DI+0Eh],-1
		jne	short M00B_L_4F52
		cmp	word ptr ES:[DI+4],-1
		jne	short M00B_L_4F43
		push	word ptr ES:[DI+6]
		db	0FFh,01Eh
		dw	8110h
		cmp	word ptr [BP-2],0
		jne	short M00B_L_4F30
		db	0E9h
		dw	001E6h
M00B_L_4F30:
		cmp	byte ptr DGROUP:M00B_BCC_DATA_1700,0
		je	short M00B_L_4F3B
		db	0FFh,01Eh
		dw	80D8h
M00B_L_4F3B:
		mov	word ptr [BP-2],0
		db	0E9h
		dw	001D3h
M00B_L_4F43:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		push	word ptr ES:[DI+4]
		db	0FFh,01Eh
		dw	8114h
		db	0E9h
		dw	001C4h
M00B_L_4F52:
		cmp	byte ptr DGROUP:M00B_BCC_DATA_1700,0
		je	short M00B_L_4F6D
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		cmp	word ptr ES:[DI+4],0
		je	short M00B_L_4F6D
		push	word ptr ES:[DI+6]
		db	09Ah
		dw	X055_00
		dw	seg X055_00
M00B_L_4F6D:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[DI+8]
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],100h
		jne	short M00B_L_4F86
		mov	word ptr [BP-6],0
		jmp	short M00B_L_4FB4
M00B_L_4F86:
		cmp	word ptr [BP-4],118h
		jne	short M00B_L_4F94
		mov	word ptr [BP-6],2
		jmp	short M00B_L_4FB4
M00B_L_4F94:
		test	word ptr [BP-4],100h
		je	short M00B_L_4FA2
		mov	word ptr [BP-6],2
		jmp	short M00B_L_4FB4
M00B_L_4FA2:
		cmp	word ptr [BP-4],1
		jne	short M00B_L_4FAF
		mov	word ptr [BP-6],3
		jmp	short M00B_L_4FB4
M00B_L_4FAF:
		mov	word ptr [BP-6],5
M00B_L_4FB4:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[DI+4]
		sub	AX,word ptr [BP-6]
		mov	word ptr [BP-0Ah],AX
		mov	SI,word ptr ES:[DI+0Ch]
		mov	AX,word ptr ES:[DI+0Eh]
		mov	word ptr [BP-0Eh],AX
		mov	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-12h],AX
		mov	word ptr [BP-10h],0
		db	0E9h
		dw	0008Fh
M00B_L_4FDC:
		cmp	word ptr [BP-0Eh],0
		je	short M00B_L_4FEE
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[SI]
		sub	AX,word ptr [BP-10h]
		jmp	short M00B_L_4FF1
M00B_L_4FEE:
		mov	AX,word ptr [BP-0Ah]
M00B_L_4FF1:
		mov	word ptr [BP-0Ch],AX
		mov	AX,word ptr [BP-0Ch]
		add	word ptr [BP-10h],AX
		sub	word ptr [BP-0Ah],AX
		jmp	short M00B_L_5012
M00B_L_4FFF:
		mov	BX,word ptr [BP-12h]
		inc	word ptr [BP-12h]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_883C
		mov	AL,byte ptr ES:[BX]
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
M00B_L_5012:
		mov	AX,word ptr [BP-0Ch]
		dec	word ptr [BP-0Ch]
		or	AX,AX
		jne	short M00B_L_4FFF
		cmp	word ptr [BP-0Eh],0
		je	short M00B_L_506B
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		cmp	word ptr ES:[SI+4],5
		jne	short M00B_L_5054
		cmp	word ptr ES:[SI+2],0
		je	short M00B_L_5054
		mov	AX,word ptr ES:[SI+2]
		mov	DX,AX
		mov	BX,DX
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+1Eh]
		mov	CX,AX
		mov	BX,CX
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr ES:[SI+2],AX
M00B_L_5054:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		push	word ptr ES:[SI+4]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X056_03
		dw	seg X056_03
		add	SI,6
		dec	word ptr [BP-0Eh]
M00B_L_506B:
		cmp	word ptr [BP-0Ah],0
		je	short M00B_L_5074
		db	0E9h
		dw	0FF68h
M00B_L_5074:
		cmp	word ptr [BP-4],100h
		jne	short M00B_L_507E
		db	0E9h
		dw	00098h
M00B_L_507E:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	AX,word ptr ES:[DI+6]
		add	AX,word ptr ES:[DI+4]
		mov	BX,word ptr ES:[DI+0Ah]
		mov	DX,word ptr ES:[BX+6]
		sub	DX,AX
		mov	word ptr [BP-8],DX
		cmp	word ptr [BP-4],118h
		jne	short M00B_L_50B7
		mov	BX,word ptr ES:[DI+0Ah]
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-8],AX
		mov	AX,5
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X056_03
		dw	seg X056_03
		jmp	short M00B_L_50FE
M00B_L_50B7:
		test	word ptr [BP-4],100h
		je	short M00B_L_50D4
		mov	BX,word ptr [BP-4]
		and	BX,0FEFFh
		mov	AL,byte ptr [BX+5398h]
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
		mov	AL,byte ptr [BP-8]
		jmp	short M00B_L_5110
M00B_L_50D4:
		cmp	word ptr [BP-4],1
		je	short M00B_L_50F6
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0A
		dw	seg X065_0A
		mov	BX,AX
		mov	AL,byte ptr [BX+5398h]
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
		mov	AL,3
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
M00B_L_50F6:
		mov	AL,0E9h
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
M00B_L_50FE:
		mov	AL,byte ptr [BP-8]
		and	AL,0FFh
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
		mov	AX,word ptr [BP-8]
		mov	CL,8
		sar	AX,CL
M00B_L_5110:
		push	AX
		db	09Ah
		dw	X056_00
		dw	seg X056_00
M00B_L_5116:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8844
		mov	DI,word ptr ES:[DI]
M00B_L_511D:
		or	DI,DI
		je	short M00B_L_5124
		db	0E9h
		dw	0FDE9h
M00B_L_5124:
		cmp	byte ptr DGROUP:M00B_BCC_DATA_1700,0
		je	short M00B_L_5130
		db	09Ah
		dw	X055_08
		dw	seg X055_08
M00B_L_5130:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
BCC_NEAR_4EDF	endp
CO05D_TEXT	ends




CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M00C_BCC_DATA_1714	equ	1714h
M00C_BCC_DATA_86B8	equ	86B8h
M00C_BCC_DATA_86D2	equ	86D2h
M00C_BCC_DATA_8844	equ	8844h

		public	X05D_0B
X05D_0B	label	far
BCC_FAR_5137	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		push	CS
		db	0E8h
		dw	0F902h
M00C_L_5143:
		mov	word ptr [BP-0Ah],0
		mov	AL,0
		mov	byte ptr [BP-2],AL
		mov	byte ptr [BP-1],AL
		mov	SI,2
		db	0E9h
		dw	000BCh
M00C_L_5156:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	AX,word ptr [BP-0Ah]
		sub	word ptr ES:[SI+6],AX
		cmp	word ptr ES:[SI+0Eh],-1
		jne	short M00C_L_516B
		db	0E9h
		dw	000A0h
M00C_L_516B:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-8],AX
		test	word ptr [BP-8],0F8FFh
		je	short M00C_L_5187
		mov	BX,word ptr ES:[SI+0Ah]
		db	026h,081h,04Fh,016h,001h,000h
M00C_L_5187:
		test	word ptr [BP-8],700h
		jne	short M00C_L_520B
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	AX,word ptr ES:[SI+6]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr ES:[SI+0Ah]
		mov	AX,word ptr ES:[BX+6]
		mov	CX,AX
		cmp	AX,word ptr [BP-4]
		jbe	short M00C_L_51B0
		mov	AX,word ptr [BP-0Ah]
		add	AX,3
		sub	CX,AX
M00C_L_51B0:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	AX,word ptr [BP-4]
		add	AX,word ptr ES:[SI+4]
		sub	AX,3
		mov	DX,CX
		sub	DX,AX
		mov	DI,DX
		cmp	word ptr [BP-8],1
		jne	short M00C_L_51D5
		dec	DI
		dec	DI
		mov	AX,CX
		cmp	AX,word ptr [BP-4]
		jbe	short M00C_L_51D5
		inc	DI
		inc	DI
M00C_L_51D5:
		cmp	DI,-80h
		jl	short M00C_L_5207
		cmp	DI,7Fh
		jge	short M00C_L_5207
		mov	byte ptr [BP-1],1
		cmp	word ptr [BP-8],1
		jne	short M00C_L_51EE
		mov	AX,1
		jmp	short M00C_L_51F1
M00C_L_51EE:
		mov	AX,3
M00C_L_51F1:
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		or	word ptr ES:[SI+8],100h
		sub	word ptr ES:[SI+4],AX
		add	word ptr [BP-0Ah],AX
		jmp	short M00C_L_520B
M00C_L_5207:
		mov	byte ptr [BP-2],1
M00C_L_520B:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	SI,word ptr ES:[SI]
M00C_L_5212:
		or	SI,SI
		je	short M00C_L_5219
		db	0E9h
		dw	0FF3Dh
M00C_L_5219:
		cmp	byte ptr [BP-1],0
		je	short M00C_L_5228
		cmp	byte ptr [BP-2],0
		je	short M00C_L_5228
		db	0E9h
		dw	0FF1Bh
M00C_L_5228:
		mov	SI,2
		jmp	short M00C_L_5263
M00C_L_522D:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		cmp	word ptr ES:[SI+12h],0
		je	short M00C_L_525C
		mov	DI,word ptr ES:[SI+10h]
		mov	AX,word ptr ES:[SI+12h]
		mov	DX,AX
		jmp	short M00C_L_5258
M00C_L_5244:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	AX,word ptr ES:[SI+6]
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_86B8
		add	word ptr ES:[DI+2],AX
		add	DI,4
		dec	DX
M00C_L_5258:
		or	DX,DX
		jne	short M00C_L_5244
M00C_L_525C:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8844
		mov	SI,word ptr ES:[SI]
M00C_L_5263:
		or	SI,SI
		jne	short M00C_L_522D
		db	081h,026h,0D2h,086h,0FBh,0FFh
		cmp	byte ptr DGROUP:M00C_BCC_DATA_1714,0
		je	short M00C_L_5279
		db	0E8h
		dw	0F9DDh
		jmp	short M00C_L_527C
M00C_L_5279:
		db	0E8h
		dw	0FC63h
M00C_L_527C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_5137	endp
CO05D_TEXT	ends


		extrn	BCC_FAR_5E92:far
		extrn	X043_03:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M00D_BCC_DATA_8664	equ	8664h
M00D_BCC_DATA_86D2	equ	86D2h
M00D_BCC_DATA_883C	equ	883Ch
M00D_BCC_DATA_883E	equ	883Eh
M00D_BCC_DATA_8840	equ	8840h
M00D_BCC_DATA_8894	equ	8894h
M00D_BCC_DATA_88A2	equ	88A2h

		public	X05D_07
X05D_07	label	far
BCC_NEAR_5282	label	near
BCC_FAR_5282	proc	far
		push	BP
		mov	BP,SP
		test	word ptr DGROUP:M00D_BCC_DATA_86D2,4
		je	short M00D_L_52D8
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+4]
		cmp	AX,word ptr DGROUP:M00D_BCC_DATA_8664
		jne	short M00D_L_52D8
		mov	AX,DGROUP:M00D_BCC_DATA_8840
		cmp	AX,word ptr DGROUP:M00D_BCC_DATA_883E
		jc	short M00D_L_52C4
		push	DS
		mov	AX,883Ch
		push	AX
		mov	AX,1
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_883C
		mov	DL,byte ptr [BP+6]
		mov	BX,AX
		mov	byte ptr ES:[BX],DL
		jmp	short M00D_L_52E1
M00D_L_52C4:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_883C
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_8840
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[BX],AL
		inc	word ptr DGROUP:M00D_BCC_DATA_8840
		jmp	short M00D_L_52E1
M00D_L_52D8:
		mov	AL,byte ptr [BP+6]
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
M00D_L_52E1:
		pop	BP
		retf	2
BCC_FAR_5282	endp
CO05D_TEXT	ends


		extrn	BCC_FAR_036C:far
		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_7754:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B072:far
		extrn	X035_03:far
		extrn	X077_03:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M00E_BCC_DATA_16F0	equ	16F0h
M00E_BCC_DATA_1700	equ	1700h
M00E_BCC_DATA_1701	equ	1701h
M00E_BCC_DATA_1714	equ	1714h
M00E_BCC_DATA_5366	equ	5366h
M00E_BCC_DATA_7846	equ	7846h
M00E_BCC_DATA_80C0	equ	80C0h
M00E_BCC_DATA_866E	equ	866Eh
M00E_BCC_DATA_86D8	equ	86D8h
M00E_BCC_DATA_87F0	equ	87F0h
M00E_BCC_DATA_8894	equ	8894h
M00E_BCC_DATA_88A2	equ	88A2h

		public	X05D_00
X05D_00	label	far
BCC_FAR_52E5	proc	far
		push	BP
		mov	BP,SP
		sub	SP,20Ah
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	word ptr [BP-2],SI
		jmp	short M00E_L_52F9
M00E_L_52F6:
		inc	word ptr [BP-2]
M00E_L_52F9:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX]
		cbw
		mov	BX,AX
		test	byte ptr [BX+5B81h],1
		je	short M00E_L_5316
		mov	BX,word ptr [BP-2]
		cmp	byte ptr ES:[BX],0
		jne	short M00E_L_52F6
M00E_L_5316:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		mov	BX,word ptr [BP-2]
		cmp	byte ptr ES:[BX],0
		jne	short M00E_L_5326
		db	0E9h
		dw	002B0h
M00E_L_5326:
		cmp	byte ptr ES:[BX],0Dh
		jne	short M00E_L_532F
		db	0E9h
		dw	002A7h
M00E_L_532F:
		mov	AL,DGROUP:M00E_BCC_DATA_1714
		cbw
		or	AX,AX
		je	short M00E_L_533A
		db	0E9h
		dw	00273h
M00E_L_533A:
		lea	AX,[BP+0FDF6h]
		mov	word ptr [BP-6],SS
		mov	word ptr [BP-8],AX
		push	word ptr [BP-6]
		push	word ptr [BP-8]
		push	word ptr DGROUP:M00E_BCC_DATA_7846
		push	SI
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		les	BX,[BP-8]
		cmp	byte ptr ES:[BX],0FFh
		jne	short M00E_L_53BB
		inc	word ptr [BP-8]
		les	BX,[BP-8]
		cmp	byte ptr ES:[BX],1
		jne	short M00E_L_53BB
		mov	word ptr [BP-0Ah],0
		xor	DI,DI
		jmp	short M00E_L_538E
M00E_L_5372:
		inc	word ptr [BP-8]
		mov	AX,word ptr [BP-0Ah]
		mov	CL,4
		shl	AX,CL
		les	BX,[BP-8]
		push	AX
		mov	AL,byte ptr ES:[BX]
		cbw
		pop	DX
		add	DX,AX
		sub	DX,61h
		mov	word ptr [BP-0Ah],DX
		inc	DI
M00E_L_538E:
		cmp	DI,4
		jc	short M00E_L_5372
		inc	word ptr [BP-8]
		mov	AX,word ptr [BP-0Ah]
		cmp	AX,word ptr DGROUP:M00E_BCC_DATA_5366
		je	short M00E_L_53BB
		mov	DGROUP:M00E_BCC_DATA_5366,AX
		cmp	byte ptr DGROUP:M00E_BCC_DATA_1701,0
		jne	short M00E_L_53B0
		cmp	byte ptr DGROUP:M00E_BCC_DATA_1700,0
		je	short M00E_L_53BB
M00E_L_53B0:
		push	word ptr DGROUP:M00E_BCC_DATA_86D8
		push	word ptr [BP-0Ah]
		db	0FFh,01Eh
		dw	87F0h
M00E_L_53BB:
		inc	word ptr [BP-8]
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-8]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		push	AX
		cmp	byte ptr DGROUP:M00E_BCC_DATA_16F0,0
		jne	short M00E_L_53DA
		xor	AX,AX
		jmp	short M00E_L_53DD
M00E_L_53DA:
		mov	AX,1
M00E_L_53DD:
		push	AX
		db	09Ah
		dw	BCC_FAR_7754
		dw	seg BCC_FAR_7754
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],0
		jne	short M00E_L_53EF
		db	0E9h
		dw	001E7h
M00E_L_53EF:
		cmp	word ptr [BP-4],0
		jl	short M00E_L_53F8
		db	0E9h
		dw	001DEh
M00E_L_53F8:
		mov	BX,word ptr [BP-4]
		sub	BX,-0Fh
		cmp	BX,0Eh
		jbe	short M00E_L_5406
		db	0E9h
		dw	001D0h
M00E_L_5406:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0C2Eh
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	001BBh
		mov	AX,12Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	001ADh
		mov	AX,12Fh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0019Fh
		mov	AX,0F1h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00191h
		mov	AX,0F7h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00183h
		mov	AX,130h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00175h
		mov	AX,131h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00167h
		mov	AX,1Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00159h
		mov	AX,4Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0014Bh
		mov	AX,132h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0013Dh
		mov	AX,133h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0012Fh
		mov	AX,0A7h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00121h
		mov	AX,0D0h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00113h
M00E_L_54C3:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		cmp	byte ptr ES:[SI],1Ah
		je	short M00E_L_54D0
		db	0E9h
		dw	000CFh
M00E_L_54D0:
		inc	SI
		mov	word ptr [BP-6],0
		mov	word ptr [BP-8],0
		mov	word ptr [BP-4],0
		jmp	short M00E_L_5510
M00E_L_54E2:
		mov	DX,word ptr [BP-6]
		mov	AX,word ptr [BP-8]
		mov	CL,4
		db	09Ah
		dw	BCC_FAR_036C
		dw	seg BCC_FAR_036C
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		push	AX
		mov	AL,byte ptr ES:[SI]
		cbw
		push	DX
		cwd
		pop	BX
		pop	CX
		add	CX,AX
		adc	BX,DX
		add	CX,-61h
		adc	BX,-1
		mov	word ptr [BP-6],BX
		mov	word ptr [BP-8],CX
		inc	SI
		inc	word ptr [BP-4]
M00E_L_5510:
		cmp	word ptr [BP-4],4
		jl	short M00E_L_54E2
		mov	DI,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_866E
		cmp	byte ptr ES:[DI+0Dh],3
		je	short M00E_L_552B
		cmp	byte ptr ES:[DI+0Dh],4
		jne	short M00E_L_5538
M00E_L_552B:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_866E
		push	word ptr ES:[DI]
		db	0FFh,01Eh
		dw	80C0h
		jmp	short M00E_L_55AD
M00E_L_5538:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_866E
		test	byte ptr ES:[DI+0Eh],2
		je	short M00E_L_5564
		mov	AL,byte ptr ES:[DI+7]
		push	AX
		cmp	byte ptr ES:[DI+6],2
		ja	short M00E_L_5553
		mov	AL,2
		jmp	short M00E_L_5555
M00E_L_5553:
		mov	AL,6
M00E_L_5555:
		push	AX
		db	09Ah
		dw	X035_03
		dw	seg X035_03
		push	DX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	0009Ah
		jmp	short M00E_L_55AD
M00E_L_5564:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_866E
		mov	AX,word ptr ES:[DI+0Fh]
		mov	word ptr [BP-4],AX
		push	DS
		mov	AX,5441h
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00083h
		cmp	word ptr [BP-4],0
		je	short M00E_L_5595
		cmp	word ptr [BP-4],0
		jle	short M00E_L_558D
		mov	AX,2Bh
		push	AX
		push	CS
		db	0E8h
		dw	0FCF5h
M00E_L_558D:
		push	word ptr [BP-4]
		db	09Ah
		dw	X077_03
		dw	seg X077_03
M00E_L_5595:
		mov	AX,5Dh
		push	AX
		push	CS
		db	0E8h
		dw	0FCE5h
		jmp	short M00E_L_55AD
M00E_L_559F:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		mov	AL,byte ptr ES:[SI]
		cbw
		push	AX
		push	CS
		db	0E8h
		dw	0FCD6h
		inc	SI
M00E_L_55AD:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_7846
		cmp	byte ptr ES:[SI],0
		je	short M00E_L_55BA
		db	0E9h
		dw	0FF09h
M00E_L_55BA:
		push	DS
		mov	AX,540Bh
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00038h
		mov	BX,word ptr DGROUP:M00E_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8894
		add	word ptr ES:[BX+0Ch],6
		adc	word ptr ES:[BX+0Eh],0
M00E_L_55D6:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_52E5	endp
CO05D_TEXT	ends

CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT

BCC_TABLE_55DE	label	word
		dw	00B05h
		dw	00AF7h
		dw	00AE9h
		dw	00ADBh
		dw	00ACDh
		dw	00ABFh
		dw	00ACDh
		dw	00AB1h
		dw	00AA3h
		dw	00A95h
		dw	00A87h
		dw	00A79h
		dw	00ADBh
		dw	00A6Bh
		dw	00A5Dh

CO05D_TEXT	ends

		extrn	BCC_FAR_5E71:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M010_BCC_DATA_8664	equ	8664h
M010_BCC_DATA_86D2	equ	86D2h
M010_BCC_DATA_8894	equ	8894h
M010_BCC_DATA_88A2	equ	88A2h

		public	X05D_0C
X05D_0C	label	far
BCC_NEAR_55FC	label	near
BCC_FAR_55FC	proc	far
		push	BP
		mov	BP,SP
		test	word ptr DGROUP:M010_BCC_DATA_86D2,4
		je	short M010_L_5635
		mov	BX,word ptr DGROUP:M010_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+4]
		cmp	AX,word ptr DGROUP:M010_BCC_DATA_8664
		jne	short M010_L_5635
		jmp	short M010_L_562A
M010_L_561B:
		les	BX,[BP+6]
		inc	word ptr [BP+6]
		mov	AL,byte ptr ES:[BX]
		cbw
		push	AX
		push	CS
		db	0E8h
		dw	0FC58h
M010_L_562A:
		les	BX,[BP+6]
		cmp	byte ptr ES:[BX],0
		jne	short M010_L_561B
		jmp	short M010_L_5640
M010_L_5635:
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	09Ah
		dw	BCC_FAR_5E71
		dw	seg BCC_FAR_5E71
M010_L_5640:
		pop	BP
		retf	4
BCC_FAR_55FC	endp
CO05D_TEXT	ends


		extrn	BCC_FAR_5E92:far


CO05D_TEXT	segment byte public 'CODE'
		assume	cs:CO05D_TEXT,ds:DGROUP

M011_BCC_DATA_8664	equ	8664h
M011_BCC_DATA_86D2	equ	86D2h
M011_BCC_DATA_8894	equ	8894h
M011_BCC_DATA_88A2	equ	88A2h

		public	X05D_0E
X05D_0E	label	far
BCC_FAR_5644	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		test	word ptr DGROUP:M011_BCC_DATA_86D2,4
		je	short M011_L_568D
		mov	BX,word ptr DGROUP:M011_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+4]
		cmp	AX,word ptr DGROUP:M011_BCC_DATA_8664
		jne	short M011_L_568D
		jmp	short M011_L_5677
M011_L_566B:
		mov	ES,word ptr [DI]
		mov	AL,byte ptr ES:[SI]
		cbw
		push	AX
		push	CS
		db	0E8h
		dw	0FC0Ch
		inc	SI
M011_L_5677:
		mov	ES,word ptr [DI]
		cmp	byte ptr ES:[SI],0
		jne	short M011_L_566B
		jmp	short M011_L_5695
M011_L_5681:
		mov	ES,word ptr [DI]
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
		inc	SI
M011_L_568D:
		mov	ES,word ptr [DI]
		cmp	byte ptr ES:[SI],0
		jne	short M011_L_5681
M011_L_5695:
		pop	DI
		pop	SI
		pop	BP
		retf	4
BCC_FAR_5644	endp
CO05D_TEXT	ends

; END C114UNIT
		end
