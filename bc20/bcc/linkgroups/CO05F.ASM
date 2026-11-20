		public	X05F_00
		public	X05F_07
		public	X05F_09
		public	X05F_08
		public	X05F_03
		public	X05F_02
		public	X05F_01
		public	X05F_06
		public	X05F_05
		public	X05F_04
		public	X05F_0B
		public	X05F_0C
		public	X05F_0A
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d79_a596
; BEGIN C205UNIT (listing ovr_1d79_a596:5960)



CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_86E0	equ	86E0h

		public	X05F_09
X05F_09	label	far
BCC_FAR_5960	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr DGROUP:M000_BCC_DATA_86E0
		jmp	short M000_L_5988
M000_L_596A:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[SI]
		or	AX,AX
		je	short M000_L_597C
		cmp	AX,4
		je	short M000_L_597C
		jmp	short M000_L_5980
M000_L_597C:
		push	SI
		db	0E8h
		dw	0000Fh
M000_L_5980:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
M000_L_5988:
		or	SI,SI
		jne	short M000_L_596A
		pop	SI
		pop	BP
		retf
BCC_FAR_5960	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M001_BCC_DATA_8654	equ	8654h
M001_BCC_DATA_8680	equ	8680h
M001_BCC_DATA_8698	equ	8698h
M001_BCC_DATA_88AC	equ	88ACh


BCC_NEAR_598F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-2],AX
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-2]
		dec	AX
		mov	word ptr [BP-4],AX
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		db	0E9h
		dw	001D2h
M001_L_59BA:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M001_L_59C8
		db	0E9h
		dw	001BEh
M001_L_59C8:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	word ptr [BP-6],AX
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,4Bh
		je	short M001_L_5A11
		jg	short M001_L_59F5
		cmp	AX,0Eh
		je	short M001_L_5A08
		cmp	AX,4Ah
		je	short M001_L_5A11
		db	0E9h
		dw	00191h
M001_L_59F5:
		cmp	AX,4Dh
		jne	short M001_L_59FD
		db	0E9h
		dw	000C6h
M001_L_59FD:
		cmp	AX,4Fh
		jne	short M001_L_5A05
		db	0E9h
		dw	000BEh
M001_L_5A05:
		db	0E9h
		dw	0017Eh
M001_L_5A08:
		db	081h,00Eh,0ACh,088h,004h,000h
		db	0E9h
		dw	00175h
M001_L_5A11:
		cmp	word ptr [BP-2],1
		ja	short M001_L_5A1A
		db	0E9h
		dw	0016Ch
M001_L_5A1A:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	BX,CX
		cmp	byte ptr ES:[BX],0Ah
		je	short M001_L_5A43
		cmp	byte ptr ES:[BX],9
		jne	short M001_L_5A78
M001_L_5A43:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,CX
		mov	AX,word ptr ES:[BX]
		or	AX,word ptr ES:[BX+2]
		jne	short M001_L_5A78
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		or	byte ptr ES:[BX+1],40h
		and	byte ptr ES:[DI+1],0F7h
		mov	AL,byte ptr ES:[BX]
		mov	byte ptr ES:[SI],AL
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	word ptr ES:[SI+2],0
		mov	word ptr ES:[SI],0
		db	0E9h
		dw	0010Eh
M001_L_5A78:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		cmp	byte ptr ES:[DI],0Ah
		je	short M001_L_5A8B
		cmp	byte ptr ES:[DI],9
		je	short M001_L_5A8B
		db	0E9h
		dw	000FBh
M001_L_5A8B:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AX,word ptr ES:[DI]
		or	AX,word ptr ES:[DI+2]
		je	short M001_L_5A9B
		db	0E9h
		dw	000EBh
M001_L_5A9B:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		or	byte ptr ES:[DI+1],40h
		mov	BX,CX
		and	byte ptr ES:[BX+1],0F7h
		mov	AL,byte ptr ES:[DI]
		mov	byte ptr ES:[SI],AL
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	word ptr ES:[SI+2],0
		mov	word ptr ES:[SI],0
		db	0E9h
		dw	000C3h
M001_L_5AC3:
		cmp	word ptr [BP-2],1
		ja	short M001_L_5ACC
		db	0E9h
		dw	000BAh
M001_L_5ACC:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	BX,CX
		cmp	byte ptr ES:[BX],0Ah
		je	short M001_L_5AF5
		cmp	byte ptr ES:[BX],9
		jne	short M001_L_5B34
M001_L_5AF5:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,CX
		mov	AX,word ptr ES:[BX]
		or	AX,word ptr ES:[BX+2]
		jne	short M001_L_5B34
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		or	byte ptr ES:[BX+1],40h
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	word ptr ES:[SI+2],0
		mov	BX,word ptr [BP-6]
		cmp	byte ptr [BX+7],2
		jne	short M001_L_5B2A
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	byte ptr ES:[SI],99h
		jmp	short M001_L_5B86
M001_L_5B2A:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	byte ptr ES:[SI],97h
		jmp	short M001_L_5B86
M001_L_5B34:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		cmp	byte ptr ES:[DI],0Ah
		je	short M001_L_5B44
		cmp	byte ptr ES:[DI],9
		jne	short M001_L_5B86
M001_L_5B44:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AX,word ptr ES:[DI]
		or	AX,word ptr ES:[DI+2]
		jne	short M001_L_5B86
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		or	byte ptr ES:[DI+1],40h
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr ES:[SI],AX
		mov	word ptr ES:[SI+2],0
		mov	BX,word ptr [BP-6]
		cmp	byte ptr [BX+7],2
		jne	short M001_L_5B7E
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	byte ptr ES:[SI],99h
		jmp	short M001_L_5B86
M001_L_5B7E:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		mov	byte ptr ES:[SI],97h
M001_L_5B86:
		dec	word ptr [BP-2]
		sub	SI,4
M001_L_5B8C:
		cmp	word ptr [BP-2],0
		je	short M001_L_5B95
		db	0E9h
		dw	0FE25h
M001_L_5B95:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_598F	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M002_BCC_DATA_86FB	equ	86FBh


		public	X05F_08
X05F_08	label	far
BCC_FAR_5B9E	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		mov	AX,DGROUP:M002_BCC_DATA_86FB
		mov	word ptr [BP-2],AX
		or	word ptr DGROUP:M002_BCC_DATA_86FB,0FCFFh
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_5B9E	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M003_BCC_DATA_86FB	equ	86FBh


		public	X05F_03
X05F_03	label	far
BCC_FAR_5BB3	proc	far
		push	BP
		mov	BP,SP
		and	word ptr DGROUP:M003_BCC_DATA_86FB,300h
		mov	AX,word ptr [BP+6]
		or	word ptr DGROUP:M003_BCC_DATA_86FB,AX
		pop	BP
		retf	2
BCC_FAR_5BB3	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M004_BCC_DATA_86FB	equ	86FBh


		public	X05F_04
X05F_04	label	far
BCC_FAR_5BC7	proc	far
		push	BP
		mov	BP,SP
		mov	AX,DGROUP:M004_BCC_DATA_86FB
		and	AX,0AAh
		shr	AX,1
		or	word ptr DGROUP:M004_BCC_DATA_86FB,AX
		or	word ptr DGROUP:M004_BCC_DATA_86FB,0ECAAh
		mov	AX,DGROUP:M004_BCC_DATA_86FB
		not	AX
		push	AX
		mov	AX,1355h
		pop	DX
		and	AX,DX
		pop	BP
		retf
BCC_FAR_5BC7	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M005_BCC_DATA_8654	equ	8654h


		public	X05F_02
X05F_02	label	far
BCC_FAR_5BEA	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+14h]
		not	AX
		push	AX
		mov	AX,1355h
		pop	DX
		and	AX,DX
		pop	SI
		pop	BP
		retf	2
BCC_FAR_5BEA	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP



		public	X05F_0A
X05F_0A	label	far
BCC_FAR_5C07	proc	far
		push	BP
		mov	BP,SP
		mov	AX,1355h
		pop	BP
		retf
BCC_FAR_5C07	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP



		public	X05F_00
X05F_00	label	far
BCC_FAR_5C0F	proc	far
		push	BP
		mov	BP,SP
		mov	AX,55h
		pop	BP
		retf
BCC_FAR_5C0F	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP



		public	X05F_06
X05F_06	label	far
BCC_FAR_5C17	proc	far
		push	BP
		mov	BP,SP
		mov	DL,byte ptr [BP+8]
		cmp	word ptr [BP+6],1
		jne	short M008_L_5C29
		mov	AL,DL
		cbw
		inc	AX
		jmp	short M008_L_5C2F
M008_L_5C29:
		mov	AL,DL
		cbw
		add	AX,9
M008_L_5C2F:
		pop	BP
		retf	4
BCC_FAR_5C17	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP



		public	X05F_0B
X05F_0B	label	far
BCC_FAR_5C33	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		cmp	word ptr [BP+8],1
		jle	short M009_L_5C45
		mov	AX,0Bh
		jmp	short M009_L_5C54
M009_L_5C45:
		cmp	byte ptr [SI+4FBCh],0
		je	short M009_L_5C51
		mov	AX,9
		jmp	short M009_L_5C54
M009_L_5C51:
		mov	AX,1
M009_L_5C54:
		pop	SI
		pop	BP
		retf	4
BCC_FAR_5C33	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M00A_BCC_DATA_8680	equ	8680h


		public	X05F_07
X05F_07	label	far
BCC_FAR_5C59	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	AX,word ptr [BP+6]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8680
		cmp	byte ptr ES:[SI],15h
		jc	short M00A_L_5C89
		cmp	byte ptr ES:[SI],1Bh
		ja	short M00A_L_5C89
		test	byte ptr ES:[SI+1],1
		je	short M00A_L_5C89
		test	word ptr [BP+8],310h
		je	short M00A_L_5C89
		mov	AX,1
		jmp	short M00A_L_5C8B
M00A_L_5C89:
		xor	AX,AX
M00A_L_5C8B:
		pop	SI
		pop	BP
		retf	4
BCC_FAR_5C59	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M00B_BCC_DATA_8680	equ	8680h


		public	X05F_0C
X05F_0C	label	far
BCC_FAR_5C90	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		cmp	byte ptr ES:[SI],98h
		je	short M00B_L_5CA7
		cmp	byte ptr ES:[SI],97h
		jne	short M00B_L_5CAC
M00B_L_5CA7:
		mov	AX,1
		jmp	short M00B_L_5D19
M00B_L_5CAC:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		cmp	byte ptr ES:[SI],1Bh
		je	short M00B_L_5CBA
		xor	AX,AX
		jmp	short M00B_L_5D19
M00B_L_5CBA:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		cmp	byte ptr ES:[SI+4],16h
		je	short M00B_L_5CC9
		xor	AX,AX
		jmp	short M00B_L_5D19
M00B_L_5CC9:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		test	byte ptr ES:[SI+1],40h
		je	short M00B_L_5CD8
		xor	AX,AX
		jmp	short M00B_L_5D19
M00B_L_5CD8:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		test	byte ptr ES:[SI+5],40h
		je	short M00B_L_5CE7
		xor	AX,AX
		jmp	short M00B_L_5D19
M00B_L_5CE7:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		test	byte ptr ES:[SI+1],1
		je	short M00B_L_5CF7
		mov	AX,1
		jmp	short M00B_L_5D19
M00B_L_5CF7:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		test	byte ptr ES:[SI+5],1
		je	short M00B_L_5D07
		mov	AX,1
		jmp	short M00B_L_5D19
M00B_L_5D07:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8680
		cmp	byte ptr ES:[SI+3],15h
		je	short M00B_L_5D17
		mov	AX,1
		jmp	short M00B_L_5D19
M00B_L_5D17:
		xor	AX,AX
M00B_L_5D19:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_5C90	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M00C_BCC_DATA_8680	equ	8680h


		public	X05F_01
X05F_01	label	far
BCC_FAR_5D1E	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8680
		cmp	byte ptr ES:[SI],1Bh
		je	short M00C_L_5D33
		xor	AX,AX
		jmp	short M00C_L_5D73
M00C_L_5D33:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8680
		cmp	byte ptr ES:[SI+4],16h
		je	short M00C_L_5D42
		xor	AX,AX
		jmp	short M00C_L_5D73
M00C_L_5D42:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8680
		test	byte ptr ES:[SI+5],40h
		je	short M00C_L_5D51
		xor	AX,AX
		jmp	short M00C_L_5D73
M00C_L_5D51:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8680
		test	byte ptr ES:[SI+5],1
		je	short M00C_L_5D61
		mov	AX,1
		jmp	short M00C_L_5D73
M00C_L_5D61:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8680
		cmp	byte ptr ES:[SI+3],15h
		je	short M00C_L_5D71
		mov	AX,1
		jmp	short M00C_L_5D73
M00C_L_5D71:
		xor	AX,AX
M00C_L_5D73:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_5D1E	endp
CO05F_TEXT	ends




CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M00D_BCC_DATA_1709	equ	1709h
M00D_BCC_DATA_82E6	equ	82E6h
M00D_BCC_DATA_8652	equ	8652h
M00D_BCC_DATA_8654	equ	8654h
M00D_BCC_DATA_8664	equ	8664h
M00D_BCC_DATA_866E	equ	866Eh
M00D_BCC_DATA_8680	equ	8680h
M00D_BCC_DATA_8698	equ	8698h
M00D_BCC_STMT_CURRENT	equ	86C8h
M00D_BCC_DATA_86E0	equ	86E0h
M00D_BCC_DATA_86F9	equ	86F9h

		public	X05F_05
X05F_05	label	far
BCC_FAR_5D78	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,4
		mov	AX,DGROUP:M00D_BCC_DATA_86F9
		dec	AX
		mov	DX,AX
		db	0E9h
		dw	00081h
M00D_L_5D89:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Ch
		jne	short M00D_L_5E06
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		cmp	word ptr ES:[BX],0
		je	short M00D_L_5E06
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8698
		mov	DI,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		mov	AX,word ptr ES:[DI+9]
		cmp	AX,word ptr DGROUP:M00D_BCC_DATA_8664
		jne	short M00D_L_5DCB
		cmp	byte ptr DGROUP:M00D_BCC_DATA_1709,0
		jne	short M00D_L_5E06
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8698
		mov	word ptr ES:[SI],0Eh
		jmp	short M00D_L_5DFE
M00D_L_5DCB:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		mov	AL,byte ptr ES:[DI+0Eh]
		mov	AH,0
		test	AX,1
		jne	short M00D_L_5E06
		mov	AX,word ptr ES:[DI+9]
		cmp	AX,word ptr DGROUP:M00D_BCC_STMT_CURRENT
		je	short M00D_L_5DF5
		mov	AX,word ptr ES:[DI+9]
		cmp	AX,word ptr DGROUP:M00D_BCC_DATA_8652
		jne	short M00D_L_5E06
		cmp	word ptr DGROUP:M00D_BCC_DATA_82E6,0
		jne	short M00D_L_5E06
M00D_L_5DF5:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8698
		mov	word ptr ES:[SI],0Dh
M00D_L_5DFE:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		mov	byte ptr ES:[SI],8
M00D_L_5E06:
		dec	DX
		add	SI,4
M00D_L_5E0A:
		or	DX,DX
		je	short M00D_L_5E11
		db	0E9h
		dw	0FF78h
M00D_L_5E11:
		mov	SI,word ptr DGROUP:M00D_BCC_DATA_86E0
		jmp	short M00D_L_5E35
M00D_L_5E17:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		mov	AX,word ptr ES:[SI]
		or	AX,AX
		je	short M00D_L_5E29
		cmp	AX,4
		je	short M00D_L_5E29
		jmp	short M00D_L_5E2D
M00D_L_5E29:
		push	SI
		db	0E8h
		dw	00010h
M00D_L_5E2D:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
M00D_L_5E35:
		or	SI,SI
		jne	short M00D_L_5E17
		pop	DI
		pop	SI
		pop	BP
		retf
BCC_FAR_5D78	endp
CO05F_TEXT	ends




CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M00E_BCC_DATA_16F0	equ	16F0h
M00E_BCC_DATA_74FF	equ	74FFh
M00E_BCC_DATA_8654	equ	8654h
M00E_BCC_DATA_8680	equ	8680h
M00E_BCC_DATA_8698	equ	8698h

BCC_NEAR_5E3D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-2],AX
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-2]
		dec	AX
		mov	word ptr [BP-4],AX
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		db	0E9h
		dw	00404h
M00E_L_5E68:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	byte ptr ES:[SI+2],0FFh
		mov	byte ptr ES:[SI+3],0
		test	byte ptr ES:[SI+1],41h
		je	short M00E_L_5E80
		db	0E9h
		dw	003E6h
M00E_L_5E80:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	DI,AX
		mov	AX,word ptr [DI+3]
		mov	word ptr [BP-0Ch],AX
		test	word ptr [BP-0Ch],29h
		je	short M00E_L_5EA3
		db	0E9h
		dw	003C3h
M00E_L_5EA3:
		mov	word ptr [BP-0Ah],7
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		dec	AX
		dec	AX
		mov	BX,AX
		cmp	BX,0D2h
		jbe	short M00E_L_5EBE
		db	0E9h
		dw	00321h
M00E_L_5EBE:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	91Eh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M00E_L_5EDD
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,5
		db	0E9h
		dw	0037Ch
M00E_L_5EDD:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		mov	AX,1
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	0052Fh
		db	0E9h
		dw	0036Eh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M00E_L_5F10
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,5
		db	0E9h,049h,003h
M00E_L_5F10:
		db	08Eh,006h,098h,086h,026h,0FFh,074h,002h,0B8h,005h,000h
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	004FCh
		db	0E9h
		dw	0033Bh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,5
		db	0E9h
		dw	00321h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	0E8h
		dw	00889h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	00847h
		db	0E9h
		dw	00316h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	BX,word ptr [BP-8]
		cmp	byte ptr ES:[BX],9
		je	short M00E_L_5F72
		cmp	byte ptr ES:[BX],0Ah
		jne	short M00E_L_5F9D
M00E_L_5F72:
		cmp	byte ptr DGROUP:M00E_BCC_DATA_16F0,0
		jne	short M00E_L_5F8F
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	BX,word ptr [BP-8]
		cmp	word ptr ES:[BX+2],0
		db	077h,02Dh,075h,006h
		cmp	word ptr ES:[BX],3
		ja	short M00E_L_5FB4
M00E_L_5F8F:
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
		jmp	short M00E_L_5FB4
M00E_L_5F9D:
		push	word ptr [BP-8]
		db	0E8h
		dw	006EFh
		cmp	AX,6
		jne	short M00E_L_5FB4
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
M00E_L_5FB4:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		jne	short M00E_L_5FC4
		mov	word ptr [BP-0Ah],0
M00E_L_5FC4:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr [BP-0Ah]
		db	0E9h
		dw	00289h
		mov	word ptr [BP-0Ah],0Dh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr [BP-0Ah]
		db	0E9h
		dw	00277h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-8],AX
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-6],AX
		push	word ptr ES:[SI+2]
		mov	AX,4
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	00414h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,4
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	003FDh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	BX,word ptr [BP-6]
		cmp	byte ptr ES:[BX],16h
		jne	short M00E_L_6077
		mov	BX,word ptr [BP-8]
		cmp	byte ptr ES:[BX],1Bh
		jne	short M00E_L_6077
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	AX,word ptr ES:[BX]
		mov	BX,word ptr [BP-6]
		cmp	AX,word ptr ES:[BX]
		jne	short M00E_L_6077
		mov	BX,word ptr [BP-8]
		mov	AX,word ptr ES:[BX+2]
		mov	BX,word ptr [BP-6]
		cmp	AX,word ptr ES:[BX+2]
		jne	short M00E_L_6077
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M00E_L_6077
		mov	BX,word ptr [BP-6]
		test	byte ptr ES:[BX+1],1
		je	short M00E_L_6077
		db	0E9h
		dw	001EFh
M00E_L_6077:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		mov	BX,word ptr [BP-6]
		cmp	byte ptr ES:[BX],10h
		jne	short M00E_L_60D0
		mov	BX,word ptr [BP-8]
		cmp	byte ptr ES:[BX],11h
		jne	short M00E_L_60D0
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr ES:[BX]
		mov	BX,word ptr [BP-8]
		cmp	AX,word ptr ES:[BX]
		jne	short M00E_L_60D0
		mov	BX,word ptr [BP-6]
		push	ES
		push	BX
		mov	BX,word ptr [BP-8]
		mov	AX,word ptr ES:[BX+2]
		dec	AX
		dec	AX
		pop	BX
		pop	ES
		cmp	word ptr ES:[BX+2],AX
		jne	short M00E_L_60D0
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M00E_L_60D0
		mov	BX,word ptr [BP-6]
		test	byte ptr ES:[BX+1],1
		je	short M00E_L_60D0
		db	0E9h
		dw	00196h
M00E_L_60D0:
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		and	byte ptr ES:[BX+1],0FEh
		mov	BX,word ptr [BP-6]
		and	byte ptr ES:[BX+1],0FEh
		db	0E9h
		dw	0017Fh
		cmp	byte ptr DGROUP:M00E_BCC_DATA_16F0,0
		jne	short M00E_L_60F5
		mov	word ptr [BP-0Ah],9
		jmp	short M00E_L_60FA
M00E_L_60F5:
		mov	word ptr [BP-0Ah],0Bh
M00E_L_60FA:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr [BP-0Ah]
		db	0E9h
		dw	00153h
		cmp	byte ptr DGROUP:M00E_BCC_DATA_16F0,0
		jne	short M00E_L_6115
		mov	word ptr [BP-0Ah],0Dh
		jmp	short M00E_L_611A
M00E_L_6115:
		mov	word ptr [BP-0Ah],0Fh
M00E_L_611A:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr [BP-0Ah]
		db	0E9h
		dw	00133h
		mov	word ptr [BP-0Ah],0Fh
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr [BP-0Ah]
		db	0E9h
		dw	00121h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		cmp	AX,word ptr ES:[SI+2]
		jnc	short M00E_L_618E
		push	word ptr ES:[SI+2]
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	002CBh
		mov	word ptr [BP-0Ah],AX
		test	word ptr [BP-0Ch],4
		je	short M00E_L_6171
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		je	short M00E_L_6171
		db	0E9h
		dw	000F5h
M00E_L_6171:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,word ptr [BP-0Ah]
		and	AX,0FFFDh
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	00299h
		db	0E9h
		dw	000D8h
M00E_L_618E:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,word ptr [BP-0Ah]
		and	AX,0FFFDh
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	0027Ch
		mov	word ptr [BP-0Ah],AX
		test	word ptr [BP-0Ch],4
		je	short M00E_L_61C0
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		je	short M00E_L_61C0
		db	0E9h
		dw	000A6h
M00E_L_61C0:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	0024Dh
		db	0E9h
		dw	0008Ch
		mov	word ptr [BP-0Ah],0Dh
M00E_L_61DF:
		test	word ptr [BP-0Ch],40h
		jne	short M00E_L_61F1
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M00E_L_6239
M00E_L_61F1:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,word ptr [BP-0Ah]
		and	AX,0FFFDh
		push	AX
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	00219h
		mov	word ptr [BP-0Ah],AX
		test	word ptr [BP-0Ch],4
		je	short M00E_L_6220
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M00E_L_6266
M00E_L_6220:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	001EDh
		jmp	short M00E_L_6266
M00E_L_6239:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	001D4h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8698
		push	word ptr ES:[SI]
		xor	AX,AX
M00E_L_6259:
		push	AX
M00E_L_625A:
		push	word ptr [BP-0Ch]
		mov	AL,byte ptr [DI+8]
		mov	AH,0
		push	AX
		db	0E8h
		dw	001BEh
M00E_L_6266:
		dec	word ptr [BP-2]
		sub	SI,4
M00E_L_626C:
		cmp	word ptr [BP-2],0
		je	short M00E_L_6275
		db	0E9h
		dw	0FBF3h
M00E_L_6275:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_5E3D	endp
CO05F_TEXT	ends

CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT

BCC_TABLE_627E	label	word
		dw	00906h
		dw	00906h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005D8h
		dw	005D8h
		dw	005D8h
		dw	005D8h
		dw	005D8h
		dw	005D8h
		dw	005D8h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00598h
		dw	00598h
		dw	00565h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00598h
		dw	00598h
		dw	00565h
		dw	00598h
		dw	00598h
		dw	00565h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00598h
		dw	00598h
		dw	00565h
		dw	0087Fh
		dw	0087Fh
		dw	00598h
		dw	00598h
		dw	00565h
		dw	00598h
		dw	00598h
		dw	00565h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005F0h
		dw	005F0h
		dw	005F0h
		dw	005F0h
		dw	005F0h
		dw	005F0h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005F0h
		dw	005F0h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	005CBh
		dw	0087Fh
		dw	00906h
		dw	00906h
		dw	00906h
		dw	00906h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	007BAh
		dw	00683h
		dw	007BAh
		dw	007BAh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00671h
		dw	007D9h
		dw	007D9h
		dw	00598h
		dw	00598h
		dw	00565h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00787h
		dw	007A7h
		dw	007BAh
		dw	0087Fh
		dw	0087Fh
		dw	007C7h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Ah
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00906h
		dw	00906h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	00906h
		dw	00906h
		dw	00906h
		dw	00906h
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	0087Fh
		dw	005F0h
		dw	005F0h

CO05F_TEXT	ends



CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M010_BCC_DATA_866E	equ	866Eh
M010_BCC_DATA_8680	equ	8680h
M010_BCC_DATA_8698	equ	8698h

BCC_NEAR_6424	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		cmp	word ptr [BP+0Ah],0
		jne	short M010_L_6438
		mov	AX,7
		db	0E9h
		dw	00231h
M010_L_6438:
		mov	AX,word ptr [BP+0Ah]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0B2h
		jne	short M010_L_6463
		test	word ptr [BP+8],4
		je	short M010_L_645D
		or	byte ptr ES:[SI+1],1
		mov	AX,3
		db	0E9h
		dw	0020Ch
M010_L_645D:
		mov	AX,7
		db	0E9h
		dw	00206h
M010_L_6463:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AL,byte ptr [BX+3F9Fh]
		mov	AH,0
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP+4],0
		je	short M010_L_6499
		cmp	AX,word ptr [BP+4]
		je	short M010_L_6499
		cmp	word ptr [BP-2],3
		jg	short M010_L_6499
		cmp	word ptr [BP+4],3
		jg	short M010_L_6499
		mov	AX,7
		db	0E9h
		dw	001D0h
M010_L_6499:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,13h
		jne	short M010_L_64AA
		db	0E9h
		dw	00152h
M010_L_64AA:
		jg	short M010_L_64C0
		sub	AX,7
		mov	BX,AX
		cmp	BX,0Bh
		jbe	short M010_L_64B9
		db	0E9h
		dw	001A7h
M010_L_64B9:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D1Ah
M010_L_64C0:
		cmp	AX,18h
		jne	short M010_L_64C8
		db	0E9h
		dw	000B6h
M010_L_64C8:
		jg	short M010_L_64DE
		sub	AX,14h
		mov	BX,AX
		cmp	BX,3
		jbe	short M010_L_64D7
		db	0E9h
		dw	00189h
M010_L_64D7:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D12h
M010_L_64DE:
		cmp	AX,1Bh
		jne	short M010_L_64E6
		db	0E9h
		dw	00098h
M010_L_64E6:
		jg	short M010_L_64FB
		cmp	AX,19h
		jne	short M010_L_64F0
		db	0E9h
		dw	0008Eh
M010_L_64F0:
		cmp	AX,1Ah
		jne	short M010_L_64F8
		db	0E9h
		dw	00086h
M010_L_64F8:
		db	0E9h
		dw	00165h
M010_L_64FB:
		cmp	AX,0B2h
		jne	short M010_L_6503
		db	0E9h
		dw	00142h
M010_L_6503:
		db	0E9h
		dw	0015Ah
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		mov	DI,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M010_BCC_DATA_866E
		cmp	byte ptr ES:[DI+0Dh],5
		je	short M010_L_651F
		cmp	byte ptr ES:[DI+0Dh],6
		jne	short M010_L_6525
M010_L_651F:
		mov	AX,7
		db	0E9h
		dw	00144h
M010_L_6525:
		test	word ptr [BP+8],2
		je	short M010_L_653C
		test	word ptr [BP+6],4000h
		je	short M010_L_653C
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M010_L_653C:
		mov	AX,7
		db	0E9h
		dw	00127h
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		cmp	word ptr ES:[SI],0Ch
		jc	short M010_L_6568
		cmp	word ptr ES:[SI],0Fh
		ja	short M010_L_6568
		test	word ptr [BP+8],8
		je	short M010_L_6562
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M010_L_6562:
		mov	AX,5
		db	0E9h
		dw	00101h
M010_L_6568:
		test	word ptr [BP+8],1
		je	short M010_L_6578
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M010_L_6578:
		mov	AX,7
		db	0E9h
		dw	000EBh
M010_L_657E:
		test	word ptr [BP+8],4
		jne	short M010_L_6588
		db	0E9h
		dw	000D8h
M010_L_6588:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	0E8h
		dw	00230h
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	001EEh
		mov	AX,word ptr [BP+8]
		and	AX,9
		or	AX,2
		db	0E9h
		dw	000B7h
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		mov	DI,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M010_BCC_DATA_866E
		test	byte ptr ES:[DI+0Eh],2
		je	short M010_L_65E7
		cmp	byte ptr ES:[DI+7],7
		jle	short M010_L_65D1
		mov	AX,7
		db	0E9h
		dw	00098h
M010_L_65D1:
		test	word ptr [BP+8],1
		je	short M010_L_65E1
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M010_L_65E1:
		mov	AX,7
		db	0E9h
		dw	00082h
M010_L_65E7:
		test	word ptr [BP+8],4
		je	short M010_L_6660
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		mov	AX,3
		jmp	short M010_L_6669
M010_L_65FC:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8698
		mov	DI,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M010_BCC_DATA_866E
		test	byte ptr ES:[DI+0Eh],2
		je	short M010_L_6645
		cmp	byte ptr ES:[DI+7],0Ch
		jl	short M010_L_6631
		cmp	byte ptr ES:[DI+7],0Fh
		jg	short M010_L_6631
		test	word ptr [BP+8],8
		je	short M010_L_662C
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M010_L_662C:
		mov	AX,5
		jmp	short M010_L_6669
M010_L_6631:
		test	word ptr [BP+8],1
		je	short M010_L_6643
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		jmp	short M010_L_6660
M010_L_6643:
		jmp	short M010_L_6660
M010_L_6645:
		test	word ptr [BP+8],4
		je	short M010_L_6660
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		mov	AX,word ptr [BP+8]
		and	AX,9
		or	AX,2
		jmp	short M010_L_6669
M010_L_6660:
		mov	AX,word ptr [BP+8]
		and	AX,9
		or	AX,7
M010_L_6669:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_6424	endp
CO05F_TEXT	ends

CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT

BCC_TABLE_6672	label	word
		dw	00C9Ch
		dw	00C1Eh
		dw	00C1Eh
		dw	00C1Eh
		dw	00C08h
		dw	00BE2h
		dw	00BC5h
		dw	00BC5h
		dw	00D00h
		dw	00BC5h
		dw	00BA6h
		dw	00D00h
		dw	00C52h
		dw	00C9Ch
		dw	00C9Ch
		dw	00C9Ch

CO05F_TEXT	ends

CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M012_BCC_DATA_866E	equ	866Eh
M012_BCC_DATA_8680	equ	8680h
M012_BCC_DATA_8698	equ	8698h


BCC_NEAR_6692	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8680
		cmp	byte ptr ES:[SI],8
		je	short M012_L_66AA
		cmp	byte ptr ES:[SI],7
		jne	short M012_L_66B3
M012_L_66AA:
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		jmp	short M012_L_66EF
M012_L_66B3:
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8680
		cmp	byte ptr ES:[SI],10h
		je	short M012_L_66C9
		cmp	byte ptr ES:[SI],11h
		je	short M012_L_66C9
		cmp	byte ptr ES:[SI],0Fh
		jne	short M012_L_66ED
M012_L_66C9:
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M012_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M012_L_66ED
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M012_BCC_DATA_866E
		mov	AL,byte ptr ES:[BX+7]
		cbw
		jmp	short M012_L_66EF
M012_L_66ED:
		xor	AX,AX
M012_L_66EF:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_6692	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M013_BCC_DATA_866E	equ	866Eh
M013_BCC_DATA_8680	equ	8680h
M013_BCC_DATA_8698	equ	8698h


BCC_NEAR_66F5	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Ah
		je	short M013_L_670D
		cmp	byte ptr ES:[SI],0Ch
		jne	short M013_L_6712
M013_L_670D:
		mov	AX,1
		jmp	short M013_L_6749
M013_L_6712:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Dh
		jne	short M013_L_6747
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M013_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],5
		je	short M013_L_6740
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M013_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],6
		jne	short M013_L_6742
M013_L_6740:
		jmp	short M013_L_6747
M013_L_6742:
		mov	AX,1
		jmp	short M013_L_6749
M013_L_6747:
		xor	AX,AX
M013_L_6749:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_66F5	endp
CO05F_TEXT	ends


CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M014_BCC_DATA_866E	equ	866Eh
M014_BCC_DATA_8680	equ	8680h
M014_BCC_DATA_8698	equ	8698h


BCC_NEAR_674F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Dh
		jne	short M014_L_678C
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M014_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],5
		je	short M014_L_6785
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M014_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],6
		jne	short M014_L_678A
M014_L_6785:
		mov	AX,1
		jmp	short M014_L_678E
M014_L_678A:
		jmp	short M014_L_678C
M014_L_678C:
		xor	AX,AX
M014_L_678E:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_674F	endp
CO05F_TEXT	ends




CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M015_BCC_DATA_8680	equ	8680h

BCC_NEAR_6794	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		or	DI,DI
		je	short M015_L_67C4
		mov	AX,DI
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		push	SI
		db	0E8h
		dw	0FEE5h
		cmp	AX,0Ch
		jc	short M015_L_67C4
		push	SI
		db	0E8h
		dw	0FEDCh
		cmp	AX,0Fh
		ja	short M015_L_67C4
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M015_L_67C4:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_6794	endp
CO05F_TEXT	ends




CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT,ds:DGROUP

M016_BCC_DATA_866E	equ	866Eh
M016_BCC_DATA_8680	equ	8680h
M016_BCC_DATA_8698	equ	8698h

BCC_NEAR_67CB	proc	near
M016_L_67CB:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	AX,word ptr [BP+4]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M016_L_67EB
		db	0E9h
		dw	001A1h
M016_L_67EB:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,0Dh
		jne	short M016_L_67FC
		db	0E9h
		dw	00091h
M016_L_67FC:
		jg	short M016_L_680E
		cmp	AX,8
		je	short M016_L_681B
		cmp	AX,0Ah
		jne	short M016_L_680B
		db	0E9h
		dw	00082h
M016_L_680B:
		db	0E9h
		dw	0017Eh
M016_L_680E:
		cmp	AX,10h
		je	short M016_L_684F
		cmp	AX,1Fh
		je	short M016_L_6890
		db	0E9h
		dw	00171h
M016_L_681B:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		sub	BX,4
		cmp	BX,6
		jbe	short M016_L_682D
		db	0E9h
		dw	0015Fh
M016_L_682D:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	105Fh
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	0013Dh
M016_L_684F:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		mov	DI,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_866E
		test	byte ptr ES:[DI+0Eh],2
		jne	short M016_L_6864
		db	0E9h
		dw	00128h
M016_L_6864:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_866E
		mov	AL,byte ptr ES:[DI+7]
		cbw
		sub	AX,4
		mov	BX,AX
		cmp	BX,6
		jbe	short M016_L_687A
		db	0E9h
		dw	00112h
M016_L_687A:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1051h
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
		db	0E9h
		dw	000FFh
M016_L_688D:
		db	0E9h
		dw	000F3h
M016_L_6890:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		test	byte ptr ES:[SI+1],10h
		je	short M016_L_689E
		db	0E9h
		dw	000EEh
M016_L_689E:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-2],AX
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		push	DI
		db	0E8h
		dw	0FE3Bh
		or	AX,AX
		je	short M016_L_68CB
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	0E8h
		dw	0FF03h
		db	0E9h
		dw	000AFh
M016_L_68CB:
		push	word ptr [BP-2]
		db	0E8h
		dw	0FE24h
		or	AX,AX
		je	short M016_L_68EF
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	0FEEBh
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
		db	0E9h
		dw	00094h
M016_L_68EF:
		push	word ptr [BP-2]
		db	0E8h
		dw	0FD9Dh
		sub	AX,4
		mov	BX,AX
		cmp	BX,6
		ja	short M016_L_694F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1043h
		push	DI
		db	0E8h
		dw	0FE45h
		or	AX,AX
		je	short M016_L_6917
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[DI+1],1
M016_L_6917:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
		jmp	short M016_L_6983
		push	DI
		db	0E8h
		dw	0FD69h
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],8
		je	short M016_L_6938
		cmp	word ptr [BP-4],9
		jne	short M016_L_6941
M016_L_6938:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[DI+1],1
M016_L_6941:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
		jmp	short M016_L_6983
M016_L_694F:
		push	DI
		db	0E8h
		dw	0FD3Fh
		sub	AX,4
		mov	BX,AX
		cmp	BX,6
		ja	short M016_L_698C
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1035h
		push	word ptr [BP-2]
		db	0E8h
		dw	0FDE5h
		or	AX,AX
		je	short M016_L_697A
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[BX+1],1
M016_L_697A:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[DI+1],1
M016_L_6983:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8680
		or	byte ptr ES:[SI+1],1
M016_L_698C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_67CB	endp
CO05F_TEXT	ends

CO05F_TEXT	segment byte public 'CODE'
		assume	cs:CO05F_TEXT

BCC_TABLE_6995	label	word
		dw	0101Ah
		dw	0102Ch
		dw	0102Ch
		dw	0102Ch
		dw	01004h
		dw	01004h
		dw	0101Ah
		dw	0102Ch
		dw	00FEFh
		dw	00FEFh
		dw	00FEFh
		dw	00FA6h
		dw	00FA6h
		dw	00FC5h
		dw	00F21h
		dw	0102Ch
		dw	0102Ch
		dw	0102Ch
		dw	00F21h
		dw	00F21h
		dw	00F21h
		dw	00ED4h
		dw	0102Ch
		dw	0102Ch
		dw	0102Ch
		dw	00ED4h
		dw	00ED4h
		dw	00ED4h

CO05F_TEXT	ends
; END C205UNIT
		end
