		public	X04A_10
		public	X04A_11
		public	X04A_12
		public	X04A_13
		public	X04A_14
		public	X04A_15
		public	X04A_16
		public	X04A_01
		public	X04A_08
		public	X04A_09
		public	X04A_00
		public	X04A_02
		public	X04A_03
		public	X04A_04
		public	X04A_05
		public	X04A_06
		public	X04A_07
		public	X04A_0A
		public	X04A_0B
		public	X04A_0C
		public	X04A_0D
		public	X04A_0E
		public	X04A_0F
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d06_9746
; BEGIN C124UNIT (listing ovr_1d06_9746:7460)

		extrn	BCC_FAR_AF23:far
		extrn	X043_00:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M000_BCC_DATA_782A	equ	782Ah

		public	X04A_0D
X04A_0D	label	far
BCC_FAR_7460	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		push	DS
		mov	AX,782Ah
		push	AX
		mov	AX,8
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M000_BCC_DATA_782A
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,8
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	ES,word ptr DGROUP:M000_BCC_DATA_782A
		mov	word ptr ES:[SI+4],DI
		mov	AX,word ptr ES:[DI]
		mov	word ptr ES:[SI+2],AX
		mov	word ptr ES:[DI],SI
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_7460	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M001_BCC_STMT_RECORD_SEG	equ	63C2h
M001_BCC_DATA_782A	equ	782Ah
M001_BCC_DATA_7832	equ	7832h
M001_BCC_DATA_85F4	equ	85F4h


		public	X04A_12
X04A_12	label	far
BCC_NEAR_74A3	label	near
BCC_FAR_74A3	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DX,word ptr [BP+0Ah]
		mov	CL,byte ptr [BP+6]
		mov	DI,word ptr [BP+8]
		jmp	short M001_L_74F5
M001_L_74B3:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_782A
		mov	SI,word ptr ES:[DI+6]
		jmp	short M001_L_74E9
M001_L_74BD:
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,DX
		jne	short M001_L_74E2
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,CL
		jne	short M001_L_74E2
		cmp	byte ptr ES:[SI+5],2
		jne	short M001_L_74DE
		mov	AX,word ptr ES:[SI+8]
		jmp	short M001_L_7537
M001_L_74DE:
		mov	AX,SI
		jmp	short M001_L_7537
M001_L_74E2:
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M001_L_74E9:
		or	SI,SI
		jne	short M001_L_74BD
		mov	ES,word ptr DGROUP:M001_BCC_DATA_782A
		mov	DI,word ptr ES:[DI+4]
M001_L_74F5:
		or	DI,DI
		je	short M001_L_74FF
		cmp	DI,word ptr DGROUP:M001_BCC_DATA_85F4
		jne	short M001_L_74B3
M001_L_74FF:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_7832
		mov	BX,DX
		mov	SI,word ptr ES:[BX]
		jmp	short M001_L_7511
M001_L_750A:
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M001_L_7511:
		or	SI,SI
		je	short M001_L_7521
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,CL
		jne	short M001_L_750A
M001_L_7521:
		or	SI,SI
		je	short M001_L_7535
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],200h
		je	short M001_L_7535
		mov	AX,SI
		jmp	short M001_L_7537
M001_L_7535:
		xor	AX,AX
M001_L_7537:
		pop	DI
		pop	SI
		pop	BP
		retf	6
BCC_FAR_74A3	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M002_BCC_STMT_RECORD_SEG	equ	63C2h
M002_BCC_DATA_782A	equ	782Ah
M002_BCC_DATA_7832	equ	7832h
M002_BCC_DATA_85F4	equ	85F4h


		public	X04A_05
X04A_05	label	far
BCC_FAR_753D	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+0Ah]
		mov	CX,word ptr [BP+8]
		mov	DL,byte ptr [BP+6]
		mov	AX,CX
		cmp	AX,word ptr DGROUP:M002_BCC_DATA_85F4
		je	short M002_L_758F
		mov	BX,CX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_782A
		mov	SI,word ptr ES:[BX+6]
		jmp	short M002_L_7589
M002_L_755F:
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+2],DI
		jne	short M002_L_7582
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,DL
		jne	short M002_L_7582
		cmp	byte ptr ES:[SI+5],2
		jne	short M002_L_757E
		mov	AX,word ptr ES:[SI+8]
		jmp	short M002_L_75C5
M002_L_757E:
		mov	AX,SI
		jmp	short M002_L_75C5
M002_L_7582:
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M002_L_7589:
		or	SI,SI
		jne	short M002_L_755F
		jmp	short M002_L_75C3
M002_L_758F:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_7832
		mov	SI,word ptr ES:[DI]
		jmp	short M002_L_759F
M002_L_7598:
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M002_L_759F:
		or	SI,SI
		je	short M002_L_75AF
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,DL
		jne	short M002_L_7598
M002_L_75AF:
		or	SI,SI
		je	short M002_L_75C3
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],200h
		je	short M002_L_75C3
		mov	AX,SI
		jmp	short M002_L_75C5
M002_L_75C3:
		xor	AX,AX
M002_L_75C5:
		pop	DI
		pop	SI
		pop	BP
		retf	6
BCC_FAR_753D	endp
CO04A_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_AF23:far
		extrn	X019_04:far
		extrn	X043_00:far
		extrn	X04F_0C:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M003_BCC_DATA_5F4E	equ	5F4Eh
M003_BCC_EXPR_SEGMENT	equ	639Ah
M003_BCC_STMT_RECORD_SEG	equ	63C2h
M003_BCC_DATA_782A	equ	782Ah
M003_BCC_DATA_7832	equ	7832h
M003_BCC_DATA_85F2	equ	85F2h
M003_BCC_DATA_85F4	equ	85F4h
M003_BCC_DATA_8664	equ	8664h

		public	X04A_0B
X04A_0B	label	far
BCC_NEAR_75CB	label	near
BCC_FAR_75CB	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+12h]
		mov	AX,word ptr [BP+6]
		and	AX,10h
		mov	word ptr [BP-4],AX
		or	DI,DI
		jne	short M003_L_75E6
		db	0E9h
		dw	002A0h
M003_L_75E6:
		mov	AX,word ptr [BP+10h]
		cmp	AX,word ptr DGROUP:M003_BCC_DATA_85F4
		je	short M003_L_75F2
		db	0E9h
		dw	00172h
M003_L_75F2:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_7832
		mov	SI,word ptr ES:[DI]
		jmp	short M003_L_7621
M003_L_75FB:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,byte ptr [BP+0Eh]
		jne	short M003_L_761A
		cmp	word ptr [BP+0Ch],8
		jne	short M003_L_7625
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],200h
		jne	short M003_L_7625
M003_L_761A:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M003_L_7621:
		or	SI,SI
		jne	short M003_L_75FB
M003_L_7625:
		or	SI,SI
		jne	short M003_L_762C
		db	0E9h
		dw	0025Ah
M003_L_762C:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],20h
		je	short M003_L_7646
		test	word ptr [BP+6],20h
		je	short M003_L_7646
		push	DI
		db	0E8h
		dw	00569h
		db	0E9h
		dw	003B3h
M003_L_7646:
		mov	AX,word ptr [BP+0Ch]
		cmp	AX,1
		je	short M003_L_76B3
		cmp	AX,2
		je	short M003_L_765B
		cmp	AX,3
		je	short M003_L_76B3
		db	0E9h
		dw	000AFh
M003_L_765B:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Ah
		jne	short M003_L_767A
		cmp	word ptr ES:[SI+8],0
		je	short M003_L_7670
		db	0E9h
		dw	0009Eh
M003_L_7670:
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+8],AX
		db	0E9h
		dw	0037Fh
M003_L_767A:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M003_L_7695
		cmp	byte ptr ES:[SI+5],3
		je	short M003_L_7695
		cmp	byte ptr ES:[SI+5],1
		je	short M003_L_7695
		jmp	short M003_L_770A
M003_L_7695:
		cmp	word ptr [BP-4],0
		je	short M003_L_770E
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		jne	short M003_L_770E
		cmp	word ptr ES:[SI+0Ch],-1
		je	short M003_L_770E
		push	DI
		db	0E8h
		dw	004FBh
		jmp	short M003_L_770E
M003_L_76B3:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M003_L_76D2
		cmp	byte ptr ES:[SI+5],1
		je	short M003_L_76D2
		cmp	byte ptr ES:[SI+5],3
		je	short M003_L_76D2
		push	DI
		db	0E8h
		dw	004DCh
		jmp	short M003_L_76F6
M003_L_76D2:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		je	short M003_L_76F6
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI+5],AL
		db	026h,081h,04Ch,006h,040h,000h
		cmp	word ptr [BP+0Ch],1
		jne	short M003_L_76F6
		or	word ptr ES:[SI+6],80h
M003_L_76F6:
		test	word ptr [BP+6],20h
		je	short M003_L_770E
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+0Ch],AX
		jmp	short M003_L_770E
M003_L_770A:
		push	DI
		db	0E8h
		dw	0049Eh
M003_L_770E:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AX,200h
		or	AX,word ptr [BP+6]
		or	word ptr ES:[SI+6],AX
		push	word ptr ES:[SI+8]
		push	word ptr [BP+0Ah]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M003_L_774B
		mov	word ptr DGROUP:M003_BCC_DATA_5F4E,0
		push	DI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,41h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		jmp	short M003_L_7761
M003_L_774B:
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	005A8h
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI+8],AX
M003_L_7761:
		db	0E9h
		dw	00295h
M003_L_7764:
		mov	BX,word ptr [BP+10h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_782A
		mov	SI,word ptr ES:[BX+6]
		jmp	short M003_L_778B
M003_L_7771:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+2],DI
		jne	short M003_L_7784
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,byte ptr [BP+0Eh]
		je	short M003_L_778F
M003_L_7784:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M003_L_778B:
		or	SI,SI
		jne	short M003_L_7771
M003_L_778F:
		cmp	word ptr [BP+0Ch],2
		je	short M003_L_7798
		db	0E9h
		dw	000E3h
M003_L_7798:
		or	SI,SI
		je	short M003_L_77FB
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M003_L_77AB
		push	DI
		db	0E8h
		dw	00401h
M003_L_77AB:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI+8]
		push	word ptr ES:[SI+8]
		push	word ptr [BP+0Ah]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M003_L_77E3
		mov	word ptr DGROUP:M003_BCC_DATA_5F4E,0
		push	DI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,41h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		db	0E9h
		dw	00095h
M003_L_77E3:
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	00510h
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI+8],AX
		jmp	short M003_L_7878
M003_L_77FB:
		push	DI
		push	word ptr DGROUP:M003_BCC_DATA_85F4
		mov	AL,byte ptr [BP+0Eh]
		push	AX
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	0E8h
		dw	00204h
		mov	SI,AX
		push	DS
		mov	AX,63C2h
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	word ptr [BP-2],AX
		push	word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		push	word ptr [BP-2]
		xor	AX,AX
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[BX+8],SI
		mov	byte ptr ES:[BX+5],2
		mov	word ptr ES:[BX+2],DI
		mov	AX,word ptr ES:[SI+6]
		mov	word ptr ES:[BX+6],AX
		mov	BX,word ptr [BP+10h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_782A
		mov	AX,word ptr ES:[BX+6]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	BX,word ptr [BP-2]
		mov	word ptr ES:[BX],AX
		mov	BX,word ptr [BP+10h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_782A
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[BX+6],AX
M003_L_7878:
		db	0E9h
		dw	0017Eh
M003_L_787B:
		or	SI,SI
		je	short M003_L_7886
		push	DI
		db	0E8h
		dw	00329h
		db	0E9h
		dw	00173h
M003_L_7886:
		mov	AX,word ptr [BP+10h]
		cmp	AX,word ptr DGROUP:M003_BCC_DATA_85F4
		je	short M003_L_7892
		db	0E9h
		dw	000D9h
M003_L_7892:
		push	DS
		mov	AX,63C2h
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		or	DI,DI
		je	short M003_L_78CE
		mov	ES,word ptr DGROUP:M003_BCC_DATA_7832
		mov	AX,word ptr ES:[DI]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI],AX
		mov	ES,word ptr DGROUP:M003_BCC_DATA_7832
		mov	word ptr ES:[DI],SI
		jmp	short M003_L_78DC
M003_L_78CE:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AX,DGROUP:M003_BCC_DATA_85F2
		mov	word ptr ES:[SI],AX
		mov	word ptr DGROUP:M003_BCC_DATA_85F2,SI
M003_L_78DC:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI+5],AL
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+8],AX
		mov	word ptr ES:[SI+2],DI
		mov	AL,byte ptr [BP+0Eh]
		mov	byte ptr ES:[SI+4],AL
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+0Ch],AX
		mov	AX,200h
		or	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+6],AX
		cmp	word ptr [BP-4],0
		jne	short M003_L_7929
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		jne	short M003_L_7929
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AX,DGROUP:M003_BCC_DATA_8664
		mov	word ptr ES:[SI+0Ch],AX
M003_L_7929:
		mov	BX,word ptr [BP+0Ch]
		dec	BX
		cmp	BX,9
		ja	short M003_L_7968
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	5A3h
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		db	026h,081h,04Ch,006h,040h,000h
		db	0E9h
		dw	000B3h
		jmp	short M003_L_795B
		cmp	word ptr [BP-4],0
		je	short M003_L_7968
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI+0Ch],0FFFFh
		db	0E9h
		dw	0009Eh
M003_L_795B:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		or	word ptr ES:[SI+6],0C0h
		db	0E9h
		dw	00091h
M003_L_7968:
		db	0E9h
		dw	0008Eh
M003_L_796B:
		push	DS
		mov	AX,63C2h
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		mov	BX,word ptr [BP+10h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_782A
		mov	AX,word ptr ES:[BX+6]
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI],AX
		mov	ES,word ptr DGROUP:M003_BCC_DATA_782A
		mov	word ptr ES:[BX+6],SI
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI+5],AL
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+8],AX
		mov	word ptr ES:[SI+2],DI
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+0Ch],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+6],AX
		mov	AL,byte ptr [BP+0Eh]
		mov	byte ptr ES:[SI+4],AL
		mov	AX,word ptr [BP+0Ch]
		cmp	AX,4
		je	short M003_L_79EF
		cmp	AX,8
		je	short M003_L_79E5
		cmp	AX,9
		je	short M003_L_79E5
		jmp	short M003_L_79F9
M003_L_79E5:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		or	word ptr ES:[SI+6],80h
M003_L_79EF:
		mov	ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
		db	026h,081h,04Ch,006h,040h,000h
M003_L_79F9:
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	0Eh
BCC_FAR_75CB	endp
CO04A_TEXT	ends

CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT

BCC_TABLE_7A03	label	word
		dw	004FBh
		dw	004E8h
		dw	004D9h
		dw	00508h
		dw	00508h
		dw	00508h
		dw	004E6h
		dw	004FBh
		dw	004FBh
		dw	004E6h

CO04A_TEXT	ends

		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_AF23:far
		extrn	X019_04:far
		extrn	X043_00:far
		extrn	X04F_0C:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M005_BCC_DATA_5F4E	equ	5F4Eh
M005_BCC_EXPR_SEGMENT	equ	639Ah
M005_BCC_STMT_RECORD_SEG	equ	63C2h
M005_BCC_DATA_7832	equ	7832h
M005_BCC_DATA_8664	equ	8664h

BCC_NEAR_7A17	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+10h]
		mov	AX,word ptr [BP+4]
		and	AX,10h
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-2],0
		mov	ES,word ptr DGROUP:M005_BCC_DATA_7832
		mov	SI,word ptr ES:[DI]
		jmp	short M005_L_7A5C
M005_L_7A3A:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+4]
		cmp	AL,byte ptr [BP+0Ch]
		jne	short M005_L_7A52
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],8
		jne	short M005_L_7A60
M005_L_7A52:
		mov	word ptr [BP-2],SI
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M005_L_7A5C:
		or	SI,SI
		jne	short M005_L_7A3A
M005_L_7A60:
		or	SI,SI
		jne	short M005_L_7A67
		db	0E9h
		dw	000AAh
M005_L_7A67:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Ah
		jne	short M005_L_7A83
		cmp	word ptr ES:[SI+8],0
		jne	short M005_L_7ABA
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+8],AX
		db	0E9h
		dw	0011Eh
M005_L_7A83:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M005_L_7A9E
		cmp	byte ptr ES:[SI+5],3
		je	short M005_L_7A9E
		cmp	byte ptr ES:[SI+5],1
		je	short M005_L_7A9E
		jmp	short M005_L_7AB6
M005_L_7A9E:
		cmp	word ptr [BP-4],0
		je	short M005_L_7ABA
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		jne	short M005_L_7ABA
		cmp	word ptr ES:[SI+0Ch],-1
		je	short M005_L_7ABA
M005_L_7AB6:
		push	DI
		db	0E8h
		dw	000F2h
M005_L_7ABA:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+4]
		or	word ptr ES:[SI+6],AX
		push	word ptr ES:[SI+8]
		push	word ptr [BP+8]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M005_L_7AF5
		mov	word ptr DGROUP:M005_BCC_DATA_5F4E,0
		push	DI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,41h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		db	0E9h
		dw	000ACh
M005_L_7AF5:
		push	word ptr [BP+8]
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	001FEh
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[SI+8],AX
		db	0E9h
		dw	00093h
		db	0E9h
		dw	00090h
M005_L_7B11:
		push	DS
		mov	AX,63C2h
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		push	word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		push	SI
		xor	AX,AX
		push	AX
		mov	AX,10h
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		cmp	word ptr [BP-2],0
		jne	short M005_L_7B41
		mov	ES,word ptr DGROUP:M005_BCC_DATA_7832
		mov	word ptr ES:[DI],SI
		jmp	short M005_L_7B4B
M005_L_7B41:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	BX,word ptr [BP-2]
		mov	word ptr ES:[BX],SI
M005_L_7B4B:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	byte ptr ES:[SI+5],2
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[SI+8],AX
		mov	word ptr ES:[SI+2],DI
		mov	AL,byte ptr [BP+0Ch]
		mov	byte ptr ES:[SI+4],AL
		mov	AX,word ptr [BP+4]
		mov	word ptr ES:[SI+6],AX
		cmp	word ptr [BP-4],0
		je	short M005_L_7B7B
		mov	word ptr ES:[SI+0Ch],0FFFFh
		jmp	short M005_L_7BA1
M005_L_7B7B:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		jne	short M005_L_7B96
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	AX,DGROUP:M005_BCC_DATA_8664
		jmp	short M005_L_7B9D
M005_L_7B96:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+6]
M005_L_7B9D:
		mov	word ptr ES:[SI+0Ch],AX
M005_L_7BA1:
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	0Eh
BCC_NEAR_7A17	endp
CO04A_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M006_BCC_DATA_5F4E	equ	5F4Eh

BCC_NEAR_7BAC	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		mov	word ptr DGROUP:M006_BCC_DATA_5F4E,0
		push	word ptr [BP+4]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,0ADh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_7BAC	endp
CO04A_TEXT	ends


		extrn	BCC_FAR_5BED:far
		extrn	X019_04:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M007_BCC_DATA_5F4E	equ	5F4Eh
M007_BCC_EXPR_SEGMENT	equ	639Ah
M007_BCC_STMT_RECORD_SEG	equ	63C2h
M007_BCC_DATA_77DF	equ	77DFh
M007_BCC_DATA_782A	equ	782Ah

		public	X04A_16
X04A_16	label	far
BCC_FAR_7BD1	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_782A
		mov	SI,word ptr ES:[DI+6]
		db	0E9h
		dw	00110h
M007_L_7BE4:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+2],0
		jne	short M007_L_7BF2
		db	0E9h
		dw	000FBh
M007_L_7BF2:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Bh
		jne	short M007_L_7C48
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],15h
		jne	short M007_L_7C0E
		db	0E9h
		dw	000DFh
M007_L_7C0E:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+3],0
		je	short M007_L_7C24
		db	0E9h
		dw	000C9h
M007_L_7C24:
		mov	word ptr DGROUP:M007_BCC_DATA_5F4E,0
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,17Fh
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
		db	0E9h
		dw	000A5h
M007_L_7C48:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		jne	short M007_L_7C56
		db	0E9h
		dw	00097h
M007_L_7C56:
		cmp	word ptr ES:[SI+2],0
		jne	short M007_L_7C60
		db	0E9h
		dw	0008Dh
M007_L_7C60:
		mov	AX,word ptr ES:[SI+6]
		and	AX,0C0h
		cmp	AX,40h
		jne	short M007_L_7CC4
		cmp	byte ptr ES:[SI+5],6
		jne	short M007_L_7C9A
		mov	AL,DGROUP:M007_BCC_DATA_77DF
		cbw
		or	AX,AX
		jne	short M007_L_7CED
		mov	word ptr DGROUP:M007_BCC_DATA_5F4E,0
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,163h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
		jmp	short M007_L_7CED
M007_L_7C9A:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+4],1
		je	short M007_L_7CED
		mov	word ptr DGROUP:M007_BCC_DATA_5F4E,0
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,173h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
		jmp	short M007_L_7CED
M007_L_7CC4:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],0C0h
		jne	short M007_L_7CED
		mov	word ptr DGROUP:M007_BCC_DATA_5F4E,0
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,17Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
M007_L_7CED:
		mov	ES,word ptr DGROUP:M007_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M007_L_7CF4:
		or	SI,SI
		je	short M007_L_7CFB
		db	0E9h
		dw	0FEE9h
M007_L_7CFB:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_7BD1	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M008_BCC_EXPR_SEGMENT	equ	639Ah


BCC_NEAR_7D01	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],12h
		jne	short M008_L_7D32
		cmp	word ptr ES:[SI+5],0
		jne	short M008_L_7D30
		cmp	word ptr ES:[DI+5],0
		jne	short M008_L_7D2C
		test	byte ptr ES:[DI+8],8
		jne	short M008_L_7D30
M008_L_7D2C:
		mov	AX,DI
		jmp	short M008_L_7D4E
M008_L_7D30:
		jmp	short M008_L_7D4C
M008_L_7D32:
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		jne	short M008_L_7D4C
		mov	AX,word ptr ES:[SI+3]
		or	AX,word ptr ES:[SI+5]
		jne	short M008_L_7D4A
		mov	AX,DI
		jmp	short M008_L_7D4E
M008_L_7D4A:
		jmp	short M008_L_7D4C
M008_L_7D4C:
		mov	AX,SI
M008_L_7D4E:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_7D01	endp
CO04A_TEXT	ends




CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M009_BCC_EXPR_SEGMENT	equ	639Ah
M009_BCC_DATA_782A	equ	782Ah
M009_BCC_DATA_78A4	equ	78A4h
M009_BCC_DATA_85F4	equ	85F4h

		public	X04A_14
X04A_14	label	far
BCC_FAR_7D55	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		cmp	word ptr [BP+6],0
		je	short M009_L_7D8B
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M009_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M009_L_7D83
M009_L_7D6F:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_78A4
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr [BP+0Ah]
		je	short M009_L_7D87
		mov	ES,word ptr DGROUP:M009_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M009_L_7D83:
		or	SI,SI
		jne	short M009_L_7D6F
M009_L_7D87:
		mov	AX,SI
		jmp	short M009_L_7DCB
M009_L_7D8B:
		mov	word ptr [BP-2],0
		mov	DI,word ptr [BP+8]
		jmp	short M009_L_7DAF
M009_L_7D95:
		push	DI
		push	word ptr [BP+0Ah]
		push	SS
		lea	AX,[BP-2]
		push	AX
		db	0E8h
		dw	000B3h
		or	AX,AX
		jne	short M009_L_7DA7
		jmp	short M009_L_7DC8
M009_L_7DA7:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_782A
		mov	DI,word ptr ES:[DI+4]
M009_L_7DAF:
		or	DI,DI
		jne	short M009_L_7D95
		push	word ptr DGROUP:M009_BCC_DATA_85F4
		push	word ptr [BP+0Ah]
		push	SS
		lea	AX,[BP-2]
		push	AX
		db	0E8h
		dw	00092h
		or	AX,AX
		jne	short M009_L_7DC8
		jmp	short M009_L_7DC8
M009_L_7DC8:
		mov	AX,word ptr [BP-2]
M009_L_7DCB:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_7D55	endp
CO04A_TEXT	ends


		extrn	X04F_0C:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M00A_BCC_EXPR_SEGMENT	equ	639Ah
M00A_BCC_STMT_RECORD_SEG	equ	63C2h
M00A_BCC_DATA_78A4	equ	78A4h

BCC_NEAR_7DD3	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M00A_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+8]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M00A_L_7E46
M00A_L_7DF1:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_78A4
		cmp	word ptr ES:[SI+2],DI
		jne	short M00A_L_7E3F
		les	BX,[BP+4]
		cmp	word ptr ES:[BX],0
		jne	short M00A_L_7E09
		mov	word ptr ES:[BX],SI
		jmp	short M00A_L_7E4A
M00A_L_7E09:
		les	BX,[BP+4]
		mov	BX,word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_78A4
		mov	AX,word ptr ES:[BX+4]
		cmp	AX,word ptr ES:[SI+4]
		jne	short M00A_L_7E3B
		les	BX,[BP+4]
		mov	BX,word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_78A4
		push	word ptr ES:[BX+9]
		push	word ptr ES:[SI+9]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M00A_L_7E3F
M00A_L_7E3B:
		xor	AX,AX
		jmp	short M00A_L_7E4D
M00A_L_7E3F:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M00A_L_7E46:
		or	SI,SI
		jne	short M00A_L_7DF1
M00A_L_7E4A:
		mov	AX,1
M00A_L_7E4D:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_7DD3	endp
CO04A_TEXT	ends




CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M00B_BCC_STMT_RECORD_SEG	equ	63C2h
M00B_BCC_DATA_782A	equ	782Ah
M00B_BCC_DATA_7832	equ	7832h
M00B_BCC_DATA_783A	equ	783Ah
M00B_BCC_DATA_85F2	equ	85F2h
M00B_BCC_DATA_85F4	equ	85F4h

BCC_NEAR_7E54	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	AX,word ptr [BP+0Ah]
		cmp	AX,word ptr DGROUP:M00B_BCC_DATA_85F4
		je	short M00B_L_7E69
		db	0E9h
		dw	0009Bh
M00B_L_7E69:
		mov	word ptr [BP-4],0
		jmp	short M00B_L_7EBE
M00B_L_7E70:
		mov	BX,word ptr [BP-4]
		shl	BX,1
		mov	DI,word ptr [BX+78ACh]
		jmp	short M00B_L_7EB7
M00B_L_7E7B:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_7832
		mov	SI,word ptr ES:[DI]
		jmp	short M00B_L_7EAC
M00B_L_7E84:
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Bh
		jne	short M00B_L_7EA5
		push	SI
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FF37h
		or	AX,AX
		jne	short M00B_L_7EA5
		xor	AX,AX
		db	0E9h
		dw	000A7h
M00B_L_7EA5:
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M00B_L_7EAC:
		or	SI,SI
		jne	short M00B_L_7E84
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_783A
		mov	DI,word ptr ES:[DI]
M00B_L_7EB7:
		or	DI,DI
		jne	short M00B_L_7E7B
		inc	word ptr [BP-4]
M00B_L_7EBE:
		cmp	word ptr [BP-4],400h
		jl	short M00B_L_7E70
		mov	AX,DGROUP:M00B_BCC_DATA_85F2
		jmp	short M00B_L_7EF9
M00B_L_7ECA:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[BX+5],0Bh
		jne	short M00B_L_7EEF
		push	word ptr [BP-2]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FEECh
		or	AX,AX
		jne	short M00B_L_7EEF
		xor	AX,AX
		jmp	short M00B_L_7F4C
M00B_L_7EEF:
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
M00B_L_7EF9:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M00B_L_7ECA
		jmp	short M00B_L_7F49
M00B_L_7F04:
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_782A
		mov	AX,word ptr ES:[BX+6]
		jmp	short M00B_L_7F40
M00B_L_7F11:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[BX+5],0Bh
		jne	short M00B_L_7F36
		push	word ptr [BP-2]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FEA5h
		or	AX,AX
		jne	short M00B_L_7F36
		xor	AX,AX
		jmp	short M00B_L_7F4C
M00B_L_7F36:
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
M00B_L_7F40:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M00B_L_7F11
M00B_L_7F49:
		mov	AX,1
M00B_L_7F4C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_7E54	endp
CO04A_TEXT	ends


		extrn	X043_00:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M00C_BCC_DATA_78A4	equ	78A4h

		public	X04A_0C
X04A_0C	label	far
BCC_FAR_7F55	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+10h]
		or	SI,SI
		je	short M00C_L_7F8B
M00C_L_7F61:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_78A4
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr [BP+12h]
		jne	short M00C_L_7F78
		push	word ptr [BP+12h]
		db	0E8h
		dw	0FC38h
		mov	AX,SI
		jmp	short M00C_L_7FE1
M00C_L_7F78:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_78A4
		cmp	word ptr ES:[SI],0
		je	short M00C_L_7F8B
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
		jmp	short M00C_L_7F61
M00C_L_7F8B:
		push	DS
		mov	AX,78A4h
		push	AX
		mov	AX,0Bh
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	DI,AX
		or	SI,SI
		je	short M00C_L_7FA8
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_78A4
		mov	word ptr ES:[SI],DI
		jmp	short M00C_L_7FAB
M00C_L_7FA8:
		mov	word ptr [BP+10h],DI
M00C_L_7FAB:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_78A4
		mov	word ptr ES:[DI],0
		mov	AX,word ptr [BP+12h]
		mov	word ptr ES:[DI+2],AX
		mov	AX,word ptr [BP+0Ch]
		mov	word ptr ES:[DI+4],AX
		mov	AL,byte ptr [BP+0Ah]
		mov	byte ptr ES:[DI+6],AL
		mov	AL,byte ptr [BP+8]
		mov	byte ptr ES:[DI+7],AL
		mov	AX,word ptr [BP+0Eh]
		mov	word ptr ES:[DI+9],AX
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[DI+8],AL
		mov	AX,word ptr [BP+10h]
M00C_L_7FE1:
		pop	DI
		pop	SI
		pop	BP
		retf	0Eh
BCC_FAR_7F55	endp
CO04A_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_5B8B:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M00D_BCC_STMT_RECORD_SEG	equ	63C2h
M00D_BCC_DATA_80B4	equ	80B4h
M00D_BCC_DATA_80B8	equ	80B8h
M00D_BCC_DATA_80BC	equ	80BCh
M00D_BCC_DATA_8108	equ	8108h

		public	X04A_11
X04A_11	label	far
BCC_FAR_7FE7	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		mov	AL,byte ptr [BP+6]
		push	AX
		push	CS
		db	0E8h
		dw	0F4A7h
		mov	SI,AX
		or	SI,SI
		jne	short M00D_L_8007
		xor	AX,AX
		db	0E9h
		dw	000C1h
M00D_L_8007:
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-2],AX
		mov	AL,byte ptr ES:[SI+5]
		mov	AH,0
		dec	AX
		mov	BX,AX
		cmp	BX,9
		jbe	short M00D_L_8023
		db	0E9h
		dw	0008Ch
M00D_L_8023:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0C70h
		mov	AX,4
		push	AX
		push	word ptr [BP-2]
		push	SI
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		push	word ptr ES:[SI+6]
		db	0FFh,01Eh
		dw	80BCh
		mov	DI,AX
		db	0E9h
		dw	0007Fh
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+8],0
		jne	short M00D_L_805D
		mov	AX,3
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M00D_L_805D:
		mov	AX,1
		push	AX
		push	word ptr [BP-2]
		push	SI
		xor	AX,AX
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+6]
		db	0FFh,01Eh
		dw	80BCh
		mov	DI,AX
		jmp	short M00D_L_80C6
		mov	AX,5
		push	AX
		push	word ptr [BP-2]
		push	SI
		xor	AX,AX
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+6]
		db	0FFh,01Eh
		dw	80BCh
		mov	DI,AX
		jmp	short M00D_L_80C6
		mov	AX,5
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Eh]
		cwd
		push	DX
		push	AX
		db	0FFh,01Eh
		dw	80B4h
		mov	DI,AX
		jmp	short M00D_L_80C6
M00D_L_80AF:
		mov	AX,10h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		jmp	short M00D_L_80C8
M00D_L_80C6:
		mov	AX,DI
M00D_L_80C8:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_7FE7	endp
CO04A_TEXT	ends

CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT

BCC_TABLE_80D0	label	word
		dw	00BFDh
		dw	00BFDh
		dw	00BFDh
		dw	00BFDh
		dw	00C18h
		dw	00C18h
		dw	00BCAh
		dw	00C4Fh
		dw	00C33h
		dw	00BE7h

CO04A_TEXT	ends

		extrn	BCC_FAR_AA87:far
		extrn	X02F_00:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M00F_BCC_DATA_16F1	equ	16F1h
M00F_BCC_STMT_RECORD_SEG	equ	63C2h
M00F_BCC_DATA_77E8	equ	77E8h
M00F_BCC_DATA_8108	equ	8108h
M00F_BCC_DATA_85F4	equ	85F4h

		public	X04A_06
X04A_06	label	far
BCC_FAR_80E4	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		push	DS
		push	word ptr [BP+8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X02F_00
		dw	seg X02F_00
		mov	word ptr [BP-2],AX
		push	word ptr [BP-2]
		push	word ptr DGROUP:M00F_BCC_DATA_85F4
		mov	AL,0
		push	AX
		push	CS
		db	0E8h
		dw	0F39Ah
		mov	SI,AX
		or	SI,SI
		je	short M00F_L_811B
		mov	ES,word ptr DGROUP:M00F_BCC_STMT_RECORD_SEG
		db	026h,081h,04Ch,006h,080h,000h
		jmp	short M00F_L_8171
M00F_L_811B:
		mov	DI,80h
		mov	AL,DGROUP:M00F_BCC_DATA_16F1
		cbw
		or	AX,AX
		jne	short M00F_L_812A
		db	081h,0CFh,010h,000h
M00F_L_812A:
		cmp	word ptr [BP+6],0
		je	short M00F_L_8134
		or	DI,400h
M00F_L_8134:
		push	DS
		push	word ptr [BP+8]
		push	DS
		mov	AX,35DEh
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		je	short M00F_L_814B
		mov	AX,DGROUP:M00F_BCC_DATA_77E8
		jmp	short M00F_L_8153
M00F_L_814B:
		mov	AX,6
		push	AX
		db	0FFh,01Eh
		dw	8108h
M00F_L_8153:
		mov	word ptr [BP-4],AX
		push	word ptr [BP-2]
		push	word ptr DGROUP:M00F_BCC_DATA_85F4
		mov	AL,0
		push	AX
		mov	AX,2
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		push	DI
		push	CS
		db	0E8h
		dw	0F45Ch
		mov	SI,AX
M00F_L_8171:
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_80E4	endp
CO04A_TEXT	ends




CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M010_BCC_DATA_679C	equ	679Ch

		public	X04A_0F
X04A_0F	label	far
BCC_FAR_817B	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		push	AX
		push	word ptr DGROUP:M010_BCC_DATA_679C
		mov	AL,0
		push	AX
		mov	AX,5
		push	AX
		push	word ptr [BP+6]
		xor	AX,AX
		push	AX
		push	AX
		push	CS
		db	0E8h
		dw	0F434h
		pop	BP
		retf	2
BCC_FAR_817B	endp
CO04A_TEXT	ends


		extrn	BCC_FAR_5BED:far
		extrn	X019_04:far


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M011_BCC_DATA_5F4E	equ	5F4Eh
M011_BCC_STMT_RECORD_SEG	equ	63C2h

		public	X04A_0E
X04A_0E	label	far
BCC_FAR_819B	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	word ptr DGROUP:M011_BCC_DATA_5F4E,0
		mov	ES,word ptr DGROUP:M011_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,16Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
		pop	SI
		pop	BP
		retf	2
BCC_FAR_819B	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M012_BCC_EXPR_SEGMENT	equ	639Ah
M012_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_07
X04A_07	label	far
BCC_FAR_81C8	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M012_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[DI+8]
		jmp	short M012_L_81E2
M012_L_81DA:
		mov	ES,word ptr DGROUP:M012_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+7]
M012_L_81E2:
		mov	ES,word ptr DGROUP:M012_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],11h
		je	short M012_L_81DA
		mov	AL,byte ptr ES:[SI]
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_81C8	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M013_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_10
X04A_10	label	far
BCC_FAR_81F5	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M013_BCC_STMT_RECORD_SEG
		db	026h,081h,04Ch,006h,020h,000h
		pop	SI
		pop	BP
		retf	2
BCC_FAR_81F5	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M014_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_03
X04A_03	label	far
BCC_FAR_820B	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M014_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Eh]
		pop	SI
		pop	BP
		retf	2
BCC_FAR_820B	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M015_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_0A
X04A_0A	label	far
BCC_FAR_821F	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M015_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Ch]
		pop	SI
		pop	BP
		retf	2
BCC_FAR_821F	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M016_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_15
X04A_15	label	far
BCC_FAR_8233	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Eh],AX
		pop	SI
		pop	BP
		retf	4
BCC_FAR_8233	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M017_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_01
X04A_01	label	far
BCC_FAR_824A	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M017_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Ch],AX
		pop	SI
		pop	BP
		retf	4
BCC_FAR_824A	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M018_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_08
X04A_08	label	far
BCC_FAR_8261	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M018_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Ah],AX
		pop	SI
		pop	BP
		retf	4
BCC_FAR_8261	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M019_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_09
X04A_09	label	far
BCC_FAR_8278	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M019_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+5]
		mov	AH,0
		pop	SI
		pop	BP
		retf	2
BCC_FAR_8278	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M01A_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_00
X04A_00	label	far
BCC_FAR_828E	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01A_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+8]
		pop	SI
		pop	BP
		retf	2
BCC_FAR_828E	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M01B_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_13
X04A_13	label	far
BCC_FAR_82A2	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01B_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Ah]
		pop	SI
		pop	BP
		retf	2
BCC_FAR_82A2	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M01C_BCC_STMT_RECORD_SEG	equ	63C2h


		public	X04A_04
X04A_04	label	far
BCC_FAR_82B6	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M01C_BCC_STMT_RECORD_SEG
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Ch],AX
		or	word ptr ES:[SI+6],1000h
		pop	SI
		pop	BP
		retf	4
BCC_FAR_82B6	endp
CO04A_TEXT	ends


CO04A_TEXT	segment byte public 'CODE'
		assume	cs:CO04A_TEXT,ds:DGROUP

M01D_BCC_DATA_781F	equ	781Fh


		public	X04A_02
X04A_02	label	far
BCC_FAR_82D3	proc	far
		push	BP
		mov	BP,SP
		mov	AX,DGROUP:M01D_BCC_DATA_781F
		pop	BP
		retf
BCC_FAR_82D3	endp
CO04A_TEXT	ends

; END C124UNIT
		end
