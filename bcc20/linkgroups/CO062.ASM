		public	X062_11
		public	X062_10
		public	X062_13
		public	X062_12
		public	X062_01
		public	X062_00
		public	X062_03
		public	X062_02
		public	X062_05
		public	X062_04
		public	X062_07
		public	X062_06
		public	X062_09
		public	X062_08
		public	X062_0A
		public	X062_0C
		public	X062_0B
		public	X062_0E
		public	X062_0D
		public	X062_0F
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d87_a854
; BEGIN C109UNIT (listing ovr_1d87_a854:8540)

CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M000_BCC_DATA_8680	equ	8680h


BCC_NEAR_8540	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	BX,word ptr [BP+4]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AL,byte ptr [BX+3F9Fh]
		mov	AH,0
		mov	SI,AX
		cmp	SI,4
		jge	short M000_L_856D
		xor	AX,AX
		jmp	short M000_L_8572
M000_L_856D:
		mov	AX,SI
		add	AX,0FFFAh
M000_L_8572:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_8540	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP



		public	X062_09
X062_09	label	far
BCC_NEAR_8578	label	near
BCC_FAR_8578	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		cmp	SI,29h
		jl	short M001_L_8589
		cmp	SI,2Bh
		jle	short M001_L_8593
M001_L_8589:
		cmp	SI,38h
		jl	short M001_L_859A
		cmp	SI,3Ah
		jg	short M001_L_859A
M001_L_8593:
		mov	AX,SI
		add	AX,3
		jmp	short M001_L_85B7
M001_L_859A:
		cmp	SI,2Ch
		jl	short M001_L_85A4
		cmp	SI,2Eh
		jle	short M001_L_85AE
M001_L_85A4:
		cmp	SI,3Bh
		jl	short M001_L_85B5
		cmp	SI,3Dh
		jg	short M001_L_85B5
M001_L_85AE:
		mov	AX,SI
		add	AX,0FFFDh
		jmp	short M001_L_85B7
M001_L_85B5:
		mov	AX,SI
M001_L_85B7:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_8578	endp
CO062_TEXT	ends


		extrn	X058_01:far
		extrn	X073_00:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M002_BCC_DATA_8186	equ	8186h

		public	X062_0C
X062_0C	label	far
BCC_FAR_85BC	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		mov	SI,word ptr [BP+6]
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	word ptr ES:[BX+2],0Bh
		push	word ptr [BP+0Ah]
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		mov	word ptr [BP-2],AX
		cmp	SI,DI
		jnc	short M002_L_85F8
		push	word ptr [BP-2]
		push	CS
		db	0E8h
		dw	0FF8Bh
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DI
		mov	DI,SI
		mov	SI,word ptr [BP-4]
M002_L_85F8:
		push	SI
		db	0E8h
		dw	0FF44h
		mov	DX,word ptr [BP-2]
		add	DX,AX
		push	DX
		mov	AL,0
		push	AX
		push	DI
		push	SI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_85BC	endp
CO062_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M003_BCC_DATA_16F3	equ	16F3h

		public	X062_0D
X062_0D	label	far
BCC_FAR_8614	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		push	SI
		db	0E8h
		dw	0FF21h
		add	AX,84h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP+8]
		push	SI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		cmp	byte ptr DGROUP:M003_BCC_DATA_16F3,3
		jne	short M003_L_867E
		mov	AX,8Fh
		push	AX
		mov	AL,2
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,57h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0B7h
		push	AX
		mov	AL,0
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M003_L_86BC
M003_L_867E:
		mov	AX,8Fh
		push	AX
		mov	AL,2
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	0053Eh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,57h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0B7h
		push	AX
		mov	AL,0
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00513h
M003_L_86BC:
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0A9h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		pop	SI
		pop	BP
		retf	4
BCC_FAR_8614	endp
CO062_TEXT	ends



		extrn	X058_04:far
		extrn	X058_01:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

		public	X062_07
X062_07	label	far
BCC_FAR_86D9	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+8]
		push	SI
		db	0E8h
		dw	0FE5Ah
		add	AX,6Ch
		push	AX
		mov	AL,2
		push	AX
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,57h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,word ptr [BP-2]
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_86D9	endp
CO062_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X059_00:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M005_BCC_DATA_8164	equ	8164h
M005_BCC_DATA_8186	equ	8186h
M005_BCC_DATA_88B5	equ	88B5h

		public	X062_04
X062_04	label	far
BCC_FAR_8712	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		add	AX,61h
		mov	word ptr [BP-2],AX
		push	SI
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_00
		dw	seg X059_00
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-8],AX
		mov	AX,0ADh
		push	AX
		mov	AX,word ptr [BP-8]
		neg	AX
		xor	DX,DX
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0B2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	DI,AX
		mov	byte ptr DGROUP:M005_BCC_DATA_88B5,1
		push	word ptr [BP-2]
		mov	AL,2
		push	AX
		push	DI
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,57h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_8712	endp
CO062_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X059_00:far
		extrn	X073_00:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M006_BCC_DATA_812C	equ	812Ch
M006_BCC_DATA_8186	equ	8186h

		public	X062_05
X062_05	label	far
BCC_FAR_879C	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		mov	word ptr ES:[SI+2],0Bh
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		mov	word ptr [BP-8],AX
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		push	word ptr ES:[BX+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_00
		dw	seg X059_00
		mov	DI,AX
		push	DI
		db	0E8h
		dw	0FD64h
		add	AX,67h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,8Ch
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		mov	AX,8Bh
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-6],AX
		push	word ptr [BP-8]
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X059_00
		dw	seg X059_00
		mov	word ptr [BP-2],AX
		push	word ptr [BP-2]
		db	0E8h
		dw	0FD00h
		add	AX,6Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_879C	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP



BCC_NEAR_885C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,0Ah
		jmp	short M007_L_887F
M007_L_8866:
		les	BX,[BP+8]
		mov	AL,byte ptr ES:[BX]
		les	BX,[BP+4]
		cmp	AL,byte ptr ES:[BX]
		je	short M007_L_8879
		mov	AX,1
		jmp	short M007_L_8884
M007_L_8879:
		inc	word ptr [BP+8]
		inc	word ptr [BP+4]
M007_L_887F:
		dec	SI
		jge	short M007_L_8866
		xor	AX,AX
M007_L_8884:
		pop	SI
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_885C	endp
CO062_TEXT	ends


		extrn	BCC_FAR_9E16:far
		extrn	BCC_FAR_9E70:far
		extrn	BCC_FAR_9F3B:far
		extrn	BCC_FAR_A14F:far
		extrn	BCC_FAR_B0F1:far
		extrn	X058_04:far
		extrn	X058_03:far
		extrn	X05A_00:far
		extrn	X05A_01:far
		extrn	X05A_02:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M008_BCC_OPTION_16F2	equ	16F2h
M008_BCC_DATA_8154	equ	8154h
M008_BCC_DATA_8186	equ	8186h

		public	X062_0A
X062_0A	label	far
BCC_FAR_888A	proc	far
		push	BP
		mov	BP,SP
		sub	SP,2Eh
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	SS
		lea	AX,[BP-1Eh]
		push	AX
		db	09Ah
		dw	BCC_FAR_A14F
		dw	seg BCC_FAR_A14F
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		push	SS
		lea	AX,[BP-1Eh]
		push	AX
		db	0E8h
		dw	0FFA5h
		or	AX,AX
		jne	short M008_L_88CD
		mov	AX,8Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		db	0E9h
		dw	00152h
M008_L_88CD:
		xor	AX,AX
		mov	DX,1
		push	AX
		push	DX
		push	SS
		lea	AX,[BP-28h]
		push	AX
		db	09Ah
		dw	BCC_FAR_A14F
		dw	seg BCC_FAR_A14F
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		push	SS
		lea	AX,[BP-28h]
		push	AX
		db	0E8h
		dw	0FF6Ch
		or	AX,AX
		jne	short M008_L_8906
		mov	AX,8Bh
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		db	0E9h
		dw	00119h
M008_L_8906:
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-2Eh],AX
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		db	09Ah
		dw	BCC_FAR_9E16
		dw	seg BCC_FAR_9E16
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		db	0E8h
		dw	0FF17h
		or	AX,AX
		jne	short M008_L_894E
		mov	word ptr [BP-2Eh],9
M008_L_894E:
		push	SS
		lea	AX,[BP-14h]
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		mov	AX,word ptr [BP-2Eh]
		cmp	AX,9
		je	short M008_L_897A
		cmp	AX,0Ah
		je	short M008_L_8990
		cmp	AX,0Bh
		je	short M008_L_89A6
		jmp	short M008_L_89C3
M008_L_897A:
		push	SS
		lea	AX,[BP-14h]
		push	AX
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		db	09Ah
		dw	BCC_FAR_9E70
		dw	seg BCC_FAR_9E70
		mov	word ptr [BP-2Ch],4
		jmp	short M008_L_89C3
M008_L_8990:
		push	SS
		lea	AX,[BP-14h]
		push	AX
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		db	09Ah
		dw	BCC_FAR_9F3B
		dw	seg BCC_FAR_9F3B
		mov	word ptr [BP-2Ch],8
		jmp	short M008_L_89C3
M008_L_89A6:
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		mov	word ptr [BP-2Ch],0Ah
M008_L_89C3:
		db	09Ah
		dw	X05A_01
		dw	seg X05A_01
		mov	word ptr [BP-2Ah],AX
		cmp	byte ptr DGROUP:M008_BCC_OPTION_16F2,0
		je	short M008_L_89E4
		test	word ptr [BP-2Ah],1
		je	short M008_L_89E4
		mov	AL,0
		push	AX
		db	09Ah
		dw	X05A_02
		dw	seg X05A_02
		inc	word ptr [BP-2Ah]
M008_L_89E4:
		xor	SI,SI
		jmp	short M008_L_89F2
M008_L_89E8:
		mov	AL,byte ptr [BP+SI-0Ah]
		push	AX
		db	09Ah
		dw	X05A_02
		dw	seg X05A_02
		inc	SI
M008_L_89F2:
		cmp	SI,word ptr [BP-2Ch]
		jl	short M008_L_89E8
		push	word ptr [BP-2Ah]
		db	09Ah
		dw	X05A_00
		dw	seg X05A_00
		mov	word ptr [BP-2Ah],AX
		mov	BX,word ptr [BP-2Eh]
		mov	AL,byte ptr [BX+5020h]
		mov	AH,0
		add	AX,0Fh
		push	AX
		db	0FFh,01Eh
		dw	8154h
		push	AX
		push	word ptr [BP-2Ah]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
M008_L_8A1F:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_888A	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M009_BCC_DATA_8654	equ	8654h
M009_BCC_DATA_8666	equ	8666h
M009_BCC_DATA_866A	equ	866Ah
M009_BCC_DATA_8680	equ	8680h
M009_BCC_DATA_8698	equ	8698h
M009_BCC_DATA_86E0	equ	86E0h
M009_BCC_DATA_88B5	equ	88B5h


		public	X062_12
X062_12	label	far
BCC_FAR_8A27	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		cmp	byte ptr DGROUP:M009_BCC_DATA_88B5,0
		jne	short M009_L_8A39
		db	0E9h
		dw	0011Dh
M009_L_8A39:
		xor	SI,SI
		mov	AX,DGROUP:M009_BCC_DATA_86E0
		db	0E9h
		dw	00109h
M009_L_8A41:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		mov	word ptr [BP-4],AX
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	DI,word ptr ES:[BX+0Ah]
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-6],AX
		db	0E9h
		dw	0009Eh
M009_L_8A63:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8666
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		cmp	AX,1
		je	short M009_L_8A78
		cmp	AX,2
		je	short M009_L_8A7C
		jmp	short M009_L_8A7E
M009_L_8A78:
		dec	SI
		dec	SI
		jmp	short M009_L_8A7E
M009_L_8A7C:
		inc	SI
		inc	SI
M009_L_8A7E:
		add	DI,9
M009_L_8A81:
		cmp	DI,word ptr DGROUP:M009_BCC_DATA_866A
		jnc	short M009_L_8A94
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8666
		mov	AX,word ptr ES:[DI+3]
		cmp	AX,word ptr [BP-4]
		je	short M009_L_8A63
M009_L_8A94:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8680
		mov	BX,CX
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		cmp	AX,94h
		je	short M009_L_8AD5
		jg	short M009_L_8AB7
		cmp	AX,73h
		je	short M009_L_8AC8
		cmp	AX,7Fh
		je	short M009_L_8AD9
		cmp	AX,93h
		je	short M009_L_8AD5
		jmp	short M009_L_8AF8
M009_L_8AB7:
		cmp	AX,0ADh
		je	short M009_L_8ADD
		cmp	AX,0AEh
		je	short M009_L_8ADD
		cmp	AX,0B2h
		je	short M009_L_8AE8
		jmp	short M009_L_8AF8
M009_L_8AC8:
		mov	BX,CX
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8680
		cmp	byte ptr ES:[BX+2],0FFh
		jne	short M009_L_8AF8
M009_L_8AD5:
		dec	SI
		dec	SI
		jmp	short M009_L_8AF8
M009_L_8AD9:
		inc	SI
		inc	SI
		jmp	short M009_L_8AF8
M009_L_8ADD:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8698
		mov	BX,CX
		add	SI,word ptr ES:[BX]
		jmp	short M009_L_8AF8
M009_L_8AE8:
		mov	AX,SI
		cwd
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8698
		mov	BX,CX
		mov	word ptr ES:[BX+2],DX
		mov	word ptr ES:[BX],AX
M009_L_8AF8:
		add	CX,4
		inc	word ptr [BP-4]
		dec	word ptr [BP-6]
M009_L_8B01:
		cmp	word ptr [BP-6],0
		jbe	short M009_L_8B0A
		db	0E9h
		dw	0FF77h
M009_L_8B0A:
		jmp	short M009_L_8B2A
M009_L_8B0C:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8666
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		cmp	AX,1
		je	short M009_L_8B21
		cmp	AX,2
		je	short M009_L_8B25
		jmp	short M009_L_8B27
M009_L_8B21:
		dec	SI
		dec	SI
		jmp	short M009_L_8B27
M009_L_8B25:
		inc	SI
		inc	SI
M009_L_8B27:
		add	DI,9
M009_L_8B2A:
		cmp	DI,word ptr DGROUP:M009_BCC_DATA_866A
		jnc	short M009_L_8B3F
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8666
		mov	AX,word ptr [BP-4]
		neg	AX
		cmp	word ptr ES:[DI+3],AX
		je	short M009_L_8B0C
M009_L_8B3F:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
M009_L_8B4A:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M009_L_8B56
		db	0E9h
		dw	0FEEBh
M009_L_8B56:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_8A27	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00A_BCC_DATA_5316	equ	5316h
M00A_BCC_DATA_531A	equ	531Ah
M00A_BCC_DATA_531C	equ	531Ch


		public	X062_08
X062_08	label	far
BCC_FAR_8B5C	proc	far
		push	BP
		mov	BP,SP
		mov	word ptr DGROUP:M00A_BCC_DATA_531A,0FFFFh
		mov	word ptr DGROUP:M00A_BCC_DATA_531C,0
		mov	word ptr DGROUP:M00A_BCC_DATA_5316,0FFFFh
		pop	BP
		retf
BCC_FAR_8B5C	endp
CO062_TEXT	ends


		extrn	X060_02:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00B_BCC_DATA_531A	equ	531Ah
M00B_BCC_DATA_866E	equ	866Eh

		public	X062_0E
X062_0E	label	far
BCC_NEAR_8B73	label	near
BCC_FAR_8B73	proc	far
		push	BP
		mov	BP,SP
		push	SI
		cmp	word ptr DGROUP:M00B_BCC_DATA_531A,0
		jge	short M00B_L_8B9F
		xor	AX,AX
		push	AX
		mov	AL,0Bh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X060_02
		dw	seg X060_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_866E
		or	byte ptr ES:[SI+0Eh],4
		mov	word ptr ES:[SI+11h],1
		jmp	short M00B_L_8BAD
M00B_L_8B9F:
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_531A
		dec	word ptr DGROUP:M00B_BCC_DATA_531A
		shl	BX,1
		mov	AX,word ptr [BX+8A4Ch]
M00B_L_8BAD:
		pop	SI
		pop	BP
		retf
BCC_FAR_8B73	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00C_BCC_DATA_531A	equ	531Ah


		public	X062_10
X062_10	label	far
BCC_NEAR_8BB0	label	near
BCC_FAR_8BB0	proc	far
		push	BP
		mov	BP,SP
		cmp	word ptr DGROUP:M00C_BCC_DATA_531A,63h
		jge	short M00C_L_8BCB
		inc	word ptr DGROUP:M00C_BCC_DATA_531A
		mov	BX,word ptr DGROUP:M00C_BCC_DATA_531A
		shl	BX,1
		mov	AX,word ptr [BP+6]
		mov	word ptr [BX+8A4Ch],AX
M00C_L_8BCB:
		pop	BP
		retf	2
BCC_FAR_8BB0	endp
CO062_TEXT	ends


		extrn	X058_00:far
		extrn	X060_02:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00D_BCC_DATA_531C	equ	531Ch
M00D_BCC_DATA_866E	equ	866Eh

		public	X062_0F
X062_0F	label	far
BCC_NEAR_8BCF	label	near
BCC_FAR_8BCF	proc	far
		push	BP
		mov	BP,SP
		cmp	word ptr DGROUP:M00D_BCC_DATA_531C,0
		jne	short M00D_L_8BFD
		xor	AX,AX
		push	AX
		mov	AL,3
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X060_02
		dw	seg X060_02
		mov	DGROUP:M00D_BCC_DATA_531C,AX
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_531C
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		or	byte ptr ES:[BX+0Eh],4
		mov	word ptr ES:[BX+11h],1
M00D_L_8BFD:
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_531C
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		mov	AL,byte ptr ES:[BX+6]
		mov	AH,0
		cmp	AX,word ptr [BP+8]
		jge	short M00D_L_8C17
		mov	AL,byte ptr [BP+8]
		mov	byte ptr ES:[BX+6],AL
M00D_L_8C17:
		mov	BX,word ptr [BP+8]
		mov	AL,byte ptr [BX+5020h]
		mov	AH,0
		add	AX,0Fh
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_531C
		push	word ptr [BP+6]
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		pop	BP
		retf	4
BCC_FAR_8BCF	endp
CO062_TEXT	ends


		extrn	X043_03:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00E_BCC_DATA_5314	equ	5314h
M00E_BCC_DATA_5318	equ	5318h
M00E_BCC_DATA_8666	equ	8666h

		public	X062_01
X062_01	label	far
BCC_FAR_8C34	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr DGROUP:M00E_BCC_DATA_5314
		jmp	short M00E_L_8C91
M00E_L_8C3F:
		push	DS
		mov	AX,8666h
		push	AX
		mov	AX,9
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8666
		mov	byte ptr ES:[SI],4
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+3],AX
		mov	byte ptr ES:[SI+1],0
		mov	byte ptr ES:[SI+2],0
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		mov	AX,word ptr [BX+88BCh]
		mov	word ptr ES:[SI+5],AX
		push	CS
		db	0E8h
		dw	0FEF9h
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8666
		mov	word ptr ES:[SI+7],AX
		mov	AX,word ptr ES:[SI+7]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		mov	word ptr [BX+88BEh],AX
		dec	DI
M00E_L_8C91:
		cmp	DI,word ptr DGROUP:M00E_BCC_DATA_5318
		jg	short M00E_L_8C3F
		mov	AX,DGROUP:M00E_BCC_DATA_5314
		mov	DGROUP:M00E_BCC_DATA_5318,AX
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_8C34	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M00F_BCC_DATA_8680	equ	8680h
M00F_BCC_DATA_8698	equ	8698h


		public	X062_0B
X062_0B	label	far
BCC_NEAR_8CA3	label	near
BCC_FAR_8CA3	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		or	DI,DI
		jne	short M00F_L_8CB1
		jmp	short M00F_L_8D12
M00F_L_8CB1:
		mov	AX,DI
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8680
		test	byte ptr ES:[SI+1],40h
		je	short M00F_L_8CDF
		jmp	short M00F_L_8D12
M00F_L_8CC6:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	DI,word ptr ES:[SI]
		mov	AX,DI
		shl	AX,1
		shl	AX,1
		mov	SI,AX
M00F_L_8CDF:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8680
		cmp	byte ptr ES:[SI],3
		je	short M00F_L_8CC6
		test	byte ptr ES:[SI+1],1
		je	short M00F_L_8CF2
		jmp	short M00F_L_8D12
M00F_L_8CF2:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,2
		or	AX,0
		je	short M00F_L_8D12
		mov	AX,DI
		jmp	short M00F_L_8D14
M00F_L_8D12:
		xor	AX,AX
M00F_L_8D14:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_8CA3	endp
CO062_TEXT	ends


		extrn	X043_03:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M010_BCC_DATA_5314	equ	5314h
M010_BCC_DATA_5318	equ	5318h
M010_BCC_DATA_8666	equ	8666h

BCC_NEAR_8D1A	label	near
BCC_FAR_8D1A	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,8666h
		push	AX
		mov	AX,9
		push	AX
		db	09Ah
		dw	X043_03
		dw	seg X043_03
		mov	SI,AX
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8666
		mov	byte ptr ES:[SI],5
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+3],AX
		mov	byte ptr ES:[SI+1],0
		push	ES
		mov	AX,DGROUP:M010_BCC_DATA_5318
		cmp	AX,word ptr DGROUP:M010_BCC_DATA_5314
		jge	short M010_L_8D51
		mov	AX,1
		jmp	short M010_L_8D53
M010_L_8D51:
		xor	AX,AX
M010_L_8D53:
		pop	ES
		mov	byte ptr ES:[SI+2],AL
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8666
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+5],AX
		mov	BX,word ptr DGROUP:M010_BCC_DATA_5318
		shl	BX,1
		shl	BX,1
		mov	AX,word ptr [BX+88BEh]
		mov	word ptr ES:[SI+7],AX
		push	word ptr ES:[SI+7]
		push	CS
		db	0E8h
		dw	0FE35h
		dec	word ptr DGROUP:M010_BCC_DATA_5318
		pop	SI
		pop	BP
		retf	4
BCC_FAR_8D1A	endp
CO062_TEXT	ends




CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M011_BCC_DATA_5314	equ	5314h
M011_BCC_DATA_5318	equ	5318h
M011_BCC_DATA_8680	equ	8680h
M011_BCC_DATA_8698	equ	8698h

		public	X062_13
X062_13	label	far
BCC_FAR_8D84	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr DGROUP:M011_BCC_DATA_5314
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8680
		cmp	byte ptr ES:[SI],3
		jne	short M011_L_8DB9
		mov	BX,word ptr [BP-4]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8698
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-4],AX
M011_L_8DB9:
		push	word ptr [BP-4]
		push	CS
		db	0E8h
		dw	0FEE3h
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],0
		je	short M011_L_8DDA
		cmp	word ptr DGROUP:M011_BCC_DATA_5318,DI
		jne	short M011_L_8DD9
		push	word ptr [BP-4]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FF41h
M011_L_8DD9:
		dec	DI
M011_L_8DDA:
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	CS
		db	0E8h
		dw	0FEBEh
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M011_L_8E09
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8680
		cmp	byte ptr ES:[SI],3
		je	short M011_L_8E09
		cmp	word ptr DGROUP:M011_BCC_DATA_5318,DI
		jne	short M011_L_8E08
		push	word ptr [BP-2]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FF12h
M011_L_8E08:
		dec	DI
M011_L_8E09:
		mov	word ptr DGROUP:M011_BCC_DATA_5314,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_8D84	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M012_BCC_DATA_5314	equ	5314h
M012_BCC_DATA_5316	equ	5316h


		public	X062_02
X062_02	label	far
BCC_FAR_8E15	proc	far
		push	BP
		mov	BP,SP
		inc	word ptr DGROUP:M012_BCC_DATA_5314
		mov	BX,word ptr DGROUP:M012_BCC_DATA_5314
		shl	BX,1
		shl	BX,1
		mov	AX,word ptr [BP+6]
		mov	word ptr [BX+88BCh],AX
		mov	AX,DGROUP:M012_BCC_DATA_5314
		cmp	AX,word ptr DGROUP:M012_BCC_DATA_5316
		jle	short M012_L_8E37
		mov	DGROUP:M012_BCC_DATA_5316,AX
M012_L_8E37:
		pop	BP
		retf	2
BCC_FAR_8E15	endp
CO062_TEXT	ends


		extrn	X065_02:far
		extrn	X065_03:far
		extrn	X065_05:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M013_BCC_DATA_866E	equ	866Eh
M013_BCC_DATA_8680	equ	8680h
M013_BCC_DATA_8698	equ	8698h

		public	X062_06
X062_06	label	far
BCC_FAR_8E3B	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	AX,SI
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8698
		mov	AX,word ptr ES:[DI]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M013_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M013_L_8E73
		push	word ptr [BP+8]
		push	SI
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_05
		dw	seg X065_05
		jmp	short M013_L_8EB5
M013_L_8E73:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8680
		cmp	byte ptr ES:[DI],14h
		jne	short M013_L_8E99
		mov	AX,67h
		push	AX
		push	SI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		push	word ptr [BP+8]
		push	CS
		db	0E8h
		dw	0F6EAh
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		mov	AX,6Ch
		jmp	short M013_L_8EAE
M013_L_8E99:
		push	word ptr [BP+8]
		push	CS
		db	0E8h
		dw	0F6D8h
		push	AX
		push	SI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		push	SI
		db	0E8h
		dw	0F695h
		add	AX,6Ch
M013_L_8EAE:
		push	AX
		push	SI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
M013_L_8EB5:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_8E3B	endp
CO062_TEXT	ends


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP



		public	X062_03
X062_03	label	far
BCC_FAR_8EBD	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AL,byte ptr [SI+531Eh]
		cbw
		mov	SI,AX
		pop	SI
		pop	BP
		retf	2
BCC_FAR_8EBD	endp
CO062_TEXT	ends


		extrn	X065_02:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M015_BCC_DATA_86FF	equ	86FFh

		public	X062_11
X062_11	label	far
BCC_FAR_8ED0	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr DGROUP:M015_BCC_DATA_86FF
		jmp	short M015_L_8EEB
M015_L_8EDA:
		test	SI,1
		je	short M015_L_8EE9
		mov	AX,8Ah
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M015_L_8EE9:
		shr	SI,1
M015_L_8EEB:
		or	SI,SI
		jne	short M015_L_8EDA
		pop	SI
		pop	BP
		retf
BCC_FAR_8ED0	endp
CO062_TEXT	ends


		extrn	X065_02:far
		extrn	X065_03:far


CO062_TEXT	segment byte public 'CODE'
		assume	cs:CO062_TEXT,ds:DGROUP

M016_BCC_DATA_86FF	equ	86FFh

		public	X062_00
X062_00	label	far
BCC_FAR_8EF2	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	word ptr [BP-2],0
		mov	SI,word ptr DGROUP:M016_BCC_DATA_86FF
		jmp	short M016_L_8F12
M016_L_8F03:
		mov	AX,SI
		and	AX,1
		mov	DX,word ptr [BP-2]
		add	DX,AX
		mov	word ptr [BP-2],DX
		shr	SI,1
M016_L_8F12:
		or	SI,SI
		jne	short M016_L_8F03
		cmp	word ptr [BP+6],0
		je	short M016_L_8F3D
		cmp	word ptr [BP-2],0
		jle	short M016_L_8F3D
		mov	AX,6Ch
		push	AX
		mov	AL,byte ptr [BP-2]
		push	AX
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M016_L_8F3A
M016_L_8F31:
		mov	AX,90h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M016_L_8F3A:
		dec	word ptr [BP-2]
M016_L_8F3D:
		cmp	word ptr [BP-2],0
		jne	short M016_L_8F31
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_8EF2	endp
CO062_TEXT	ends

; END C109UNIT
		end
