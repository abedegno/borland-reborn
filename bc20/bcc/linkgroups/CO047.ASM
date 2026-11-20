; Recovered FBOV far-pointer references
CO049_TEXT	segment byte public 'CODE'
CO049_TEXT	ends
		public	X047_03
		public	X047_02
		public	X047_01
		public	X047_00
		public	X047_07
		public	X047_06
		public	X047_05
		public	X047_04
		public	X047_09
		public	X047_08
		public	X047_0C
		public	X047_0B
		public	X047_0A
		public	X047_0D
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cf8_92bb
; BEGIN C119UNIT (listing ovr_1cf8_92bb:2BB0)



CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

		public	X047_01
X047_01	label	far
BCC_NEAR_2BB0	label	near
BCC_STMT_EVAL_FAR	proc	far
	push	bp
	mov	bp,sp
	xor	ax,ax
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ax
	mov	ax,2
	push	ax
	db	0E8h
	dw	00004h
	pop	bp
	retf	4
BCC_STMT_EVAL_FAR	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_5BED:far
		extrn	X031_09:far
		extrn	X046_09:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M001_BCC_DATA_3502	equ	3502h
M001_BCC_DATA_66BE	equ	66BEh
M001_BCC_DATA_77D3	equ	77D3h
M001_BCC_DATA_77E2	equ	77E2h
M001_BCC_TOKEN_SAVED	equ	77FDh
M001_BCC_DATA_80B8	equ	80B8h
M001_BCC_DATA_8186	equ	8186h
M001_BCC_STMT_TYPE_CURRENT	equ	8260h

BCC_STMT_EVAL_NEAR	proc	near
M001_L_2BC8:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		cmp	SP,8F0Ch
		jnc	short M001_L_2BE2
		mov	AX,6
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M001_L_2BE2:
		push	word ptr [BP+0Ah]
		push	word ptr [BP+4]
		db	0E8h
		dw	00217h
		mov	DI,AX
		or	DI,DI
		jne	short M001_L_2BF6
		xor	AX,AX
		db	0E9h
		dw	00203h
M001_L_2BF6:
		mov	BX,word ptr [BP+0Ch]
		mov	AL,byte ptr [BX+3536h]
		cbw
		mov	word ptr [BP-4],AX
M001_L_2C01:
		cmp	word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT,29h
		jle	short M001_L_2C0B
		db	0E9h
		dw	001ECh
M001_L_2C0B:
		cmp	word ptr [BP+8],4
		jne	short M001_L_2C1B
		cmp	word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT,0Ah
		jne	short M001_L_2C1B
		db	0E9h
		dw	001DCh
M001_L_2C1B:
		cmp	word ptr [BP+8],2
		jne	short M001_L_2C2B
		cmp	word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT,8
		jne	short M001_L_2C2B
		db	0E9h
		dw	001CCh
M001_L_2C2B:
		cmp	word ptr [BP+8],3
		jne	short M001_L_2C3B
		cmp	word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT,21h
		jne	short M001_L_2C3B
		db	0E9h
		dw	001BCh
M001_L_2C3B:
		mov	BX,word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT
		mov	AL,byte ptr [BX+34E2h]
		cbw
		mov	word ptr [BP-0Ah],AX
		cmp	word ptr [BP-0Ah],0
		jne	short M001_L_2C50
		db	0E9h
		dw	001A7h
M001_L_2C50:
		mov	BX,word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT
		mov	AL,byte ptr [BX+350Ch]
		cbw
		mov	word ptr [BP-8],AX
		mov	AX,DGROUP:M001_BCC_DATA_77D3
		mov	word ptr [BP-6],AX
		mov	DGROUP:M001_BCC_DATA_66BE,AX
		mov	AX,word ptr [BP-8]
		cmp	AX,word ptr [BP+6]
		je	short M001_L_2CAA
		cmp	word ptr [BP+0Ch],7
		jl	short M001_L_2CAA
		cmp	word ptr [BP-0Ah],7
		jl	short M001_L_2CAA
		cmp	word ptr [BP+0Ch],0Ch
		jg	short M001_L_2C87
		cmp	word ptr [BP-0Ah],0Ch
		jg	short M001_L_2C87
		jmp	short M001_L_2C9F
M001_L_2C87:
		cmp	word ptr [BP+0Ch],0Dh
		jne	short M001_L_2C93
		cmp	word ptr [BP-0Ah],0Ch
		je	short M001_L_2C9F
M001_L_2C93:
		cmp	word ptr [BP+0Ch],0Ch
		jne	short M001_L_2CAA
		cmp	word ptr [BP-0Ah],0Dh
		jne	short M001_L_2CAA
M001_L_2C9F:
		mov	AX,161h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M001_L_2CAA:
		mov	AX,word ptr [BP+0Ch]
		cmp	AX,word ptr [BP-0Ah]
		jle	short M001_L_2CB5
		db	0E9h
		dw	00142h
M001_L_2CB5:
		mov	AX,word ptr [BP+0Ch]
		cmp	AX,word ptr [BP-0Ah]
		jne	short M001_L_2CC6
		cmp	word ptr [BP-4],1
		jne	short M001_L_2CC6
		db	0E9h
		dw	00131h
M001_L_2CC6:
		cmp	word ptr [BP-8],25h
		je	short M001_L_2CCF
		db	0E9h
		dw	000ABh
M001_L_2CCF:
		cmp	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		je	short M001_L_2CE0
		mov	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M001_BCC_STMT_TYPE_CURRENT
		jmp	short M001_L_2CE5
M001_L_2CE0:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M001_L_2CE5:
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FED2h
		mov	SI,AX
		or	SI,SI
		jne	short M001_L_2D01
		xor	AX,AX
		db	0E9h
		dw	000F8h
M001_L_2D01:
		cmp	word ptr DGROUP:M001_BCC_STMT_TYPE_CURRENT,21h
		je	short M001_L_2D1F
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	000DAh
M001_L_2D1F:
		cmp	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		je	short M001_L_2D30
		mov	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M001_BCC_STMT_TYPE_CURRENT
		jmp	short M001_L_2D35
M001_L_2D30:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M001_L_2D35:
		mov	AL,DGROUP:M001_BCC_DATA_3502
		cbw
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP+8]
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FE81h
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M001_L_2D55
		xor	AX,AX
		db	0E9h
		dw	000A4h
M001_L_2D55:
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M001_BCC_DATA_66BE,AX
		mov	AX,26h
		push	AX
		push	SI
		push	word ptr [BP-2]
		nop
		push	CS
		db	0E8h
		dw	01C8Ah
		mov	SI,AX
		mov	AX,25h
		push	AX
		push	DI
		push	SI
		nop
		push	CS
		db	0E8h
		dw	01C7Dh
		mov	DI,AX
		db	0E9h
		dw	0FE87h
M001_L_2D7A:
		cmp	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		je	short M001_L_2D8B
		mov	byte ptr DGROUP:M001_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M001_BCC_STMT_TYPE_CURRENT
		jmp	short M001_L_2D90
M001_L_2D8B:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M001_L_2D90:
		push	word ptr [BP-0Ah]
		xor	AX,AX
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP-8]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FE26h
		mov	SI,AX
		or	SI,SI
		jne	short M001_L_2DAC
		xor	AX,AX
		jmp	short M001_L_2DF9
M001_L_2DAC:
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M001_BCC_DATA_66BE,AX
		cmp	word ptr [BP-8],2Ah
		jne	short M001_L_2DE8
		cmp	word ptr [BP+8],1
		jne	short M001_L_2DD1
		mov	AX,2Bh
		push	AX
		push	word ptr DGROUP:M001_BCC_DATA_77E2
		push	DI
		push	SI
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		db	0E9h
		dw	0FE30h
M001_L_2DD1:
		mov	AX,2Ah
		push	AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	DI
		push	SI
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		db	0E9h
		dw	0FE19h
M001_L_2DE8:
		push	word ptr [BP-8]
		push	DI
		push	SI
		nop
		push	CS
		db	0E8h
		dw	01C00h
		mov	DI,AX
		db	0E9h
		dw	0FE0Ah
M001_L_2DF7:
		mov	AX,DI
M001_L_2DF9:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	0Ah
BCC_STMT_EVAL_NEAR	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far
		extrn	X031_06:far
		extrn	X031_09:far
		extrn	X046_03:far
		extrn	X046_09:far
		extrn	X04C_00:far
		extrn	X04C_09:far
		extrn	X04C_0E:far
		extrn	X04D_06:far
		extrn	X04F_13:far
		extrn	X04F_11:far
		extrn	X05A_00:far
		extrn	X05A_01:far
		extrn	X05A_02:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M002_BCC_DATA_16F5	equ	16F5h
M002_BCC_DATA_1708	equ	1708h
M002_BCC_DATA_5F4E	equ	5F4Eh
M002_BCC_EXPR_SEGMENT	equ	639Ah
M002_BCC_STMT_RECORD_SEG	equ	63C2h
M002_BCC_DATA_66BE	equ	66BEh
M002_BCC_DATA_679C	equ	679Ch
M002_BCC_DATA_77D0	equ	77D0h
M002_BCC_DATA_77D3	equ	77D3h
M002_BCC_DATA_77E2	equ	77E2h
M002_BCC_DATA_77E4	equ	77E4h
M002_BCC_TOKEN_SAVED	equ	77FDh
M002_BCC_DATA_781F	equ	781Fh
M002_BCC_DATA_80B4	equ	80B4h
M002_BCC_DATA_80B8	equ	80B8h
M002_BCC_DATA_80BC	equ	80BCh
M002_BCC_DATA_8108	equ	8108h
M002_BCC_DATA_8158	equ	8158h
M002_BCC_DATA_8164	equ	8164h
M002_BCC_DATA_8186	equ	8186h
M002_BCC_STMT_TYPE_CURRENT	equ	8260h
M002_BCC_DATA_8262	equ	8262h
M002_BCC_DATA_8269	equ	8269h
M002_BCC_DATA_826B	equ	826Bh
M002_BCC_DATA_85F4	equ	85F4h
M002_BCC_DATA_862C	equ	862Ch

BCC_STMT_UNARY_NEAR	proc	near
M002_L_2E02:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	AX,DGROUP:M002_BCC_DATA_77D3
		mov	DGROUP:M002_BCC_DATA_66BE,AX
		cmp	word ptr [BP+6],0
		je	short M002_L_2E1A
		db	0E9h
		dw	00704h
M002_L_2E1A:
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		cmp	AX,2Ch
		jne	short M002_L_2E25
		db	0E9h
		dw	00298h
M002_L_2E25:
		jg	short M002_L_2E74
		cmp	AX,18h
		jne	short M002_L_2E2F
		db	0E9h
		dw	00085h
M002_L_2E2F:
		jg	short M002_L_2E59
		cmp	AX,16h
		jne	short M002_L_2E39
		db	0E9h
		dw	00129h
M002_L_2E39:
		jg	short M002_L_2E4E
		cmp	AX,1
		jne	short M002_L_2E43
		db	0E9h
		dw	00453h
M002_L_2E43:
		cmp	AX,9
		jne	short M002_L_2E4B
		db	0E9h
		dw	00513h
M002_L_2E4B:
		db	0E9h
		dw	006B9h
M002_L_2E4E:
		cmp	AX,17h
		jne	short M002_L_2E56
		db	0E9h
		dw	000D2h
M002_L_2E56:
		db	0E9h
		dw	006AEh
M002_L_2E59:
		cmp	AX,1Bh
		jne	short M002_L_2E61
		db	0E9h
		dw	0008Dh
M002_L_2E61:
		cmp	AX,2Ah
		jne	short M002_L_2E69
		db	0E9h
		dw	0014Eh
M002_L_2E69:
		cmp	AX,2Bh
		jne	short M002_L_2E71
		db	0E9h
		dw	00180h
M002_L_2E71:
		db	0E9h
		dw	00693h
M002_L_2E74:
		cmp	AX,32h
		jne	short M002_L_2E7C
		db	0E9h
		dw	0056Ch
M002_L_2E7C:
		jg	short M002_L_2E99
		cmp	AX,2Dh
		jne	short M002_L_2E86
		db	0E9h
		dw	001A5h
M002_L_2E86:
		cmp	AX,2Eh
		jne	short M002_L_2E8E
		db	0E9h
		dw	001E6h
M002_L_2E8E:
		cmp	AX,31h
		jne	short M002_L_2E96
		db	0E9h
		dw	00533h
M002_L_2E96:
		db	0E9h
		dw	0066Eh
M002_L_2E99:
		cmp	AX,33h
		jne	short M002_L_2EA1
		db	0E9h
		dw	00578h
M002_L_2EA1:
		cmp	AX,34h
		jne	short M002_L_2EA9
		db	0E9h
		dw	005C4h
M002_L_2EA9:
		cmp	AX,65h
		jne	short M002_L_2EB1
		db	0E9h
		dw	00537h
M002_L_2EB1:
		db	0E9h
		dw	00653h
M002_L_2EB4:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_2EC5
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_2ECA
M002_L_2EC5:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_2ECA:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FF2Fh
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_2EDE
		xor	AX,AX
		db	0E9h
		dw	00968h
M002_L_2EDE:
		mov	AX,31h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01B07h
		db	0E9h
		dw	0063Ch
M002_L_2EEE:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_2EFF
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_2F04
M002_L_2EFF:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_2F04:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FEF5h
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_2F18
		xor	AX,AX
		db	0E9h
		dw	0092Eh
M002_L_2F18:
		mov	AX,32h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01ACDh
		db	0E9h
		dw	00602h
M002_L_2F28:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_2F39
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_2F3E
M002_L_2F39:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_2F3E:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FEBBh
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_2F52
		xor	AX,AX
		db	0E9h
		dw	008F4h
M002_L_2F52:
		mov	AX,2Eh
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01A93h
		db	0E9h
		dw	005C8h
M002_L_2F62:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_2F73
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_2F78
M002_L_2F73:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_2F78:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FE81h
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_2F8C
		xor	AX,AX
		db	0E9h
		dw	008BAh
M002_L_2F8C:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M002_L_2F9A
		db	0E9h
		dw	00592h
M002_L_2F9A:
		push	SI
		mov	AX,10h
		push	AX
		db	0E8h
		dw	0190Dh
		or	AX,AX
		je	short M002_L_2FAE
		nop
		push	CS
		db	0E8h
		dw	017B1h
		db	0E9h
		dw	0057Ch
M002_L_2FAE:
		push	SI
		db	0E8h
		dw	015D5h
		mov	SI,AX
		db	0E9h
		dw	00575h
M002_L_2FB7:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_2FC8
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_2FCD
M002_L_2FC8:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_2FCD:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FE2Ch
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_2FE1
		xor	AX,AX
		db	0E9h
		dw	00865h
M002_L_2FE1:
		mov	AX,30h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01A04h
		db	0E9h
		dw	00539h
M002_L_2FF1:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3002
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3007
M002_L_3002:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3007:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FDF2h
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_301B
		xor	AX,AX
		db	0E9h
		dw	0082Bh
M002_L_301B:
		mov	AX,2Fh
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	019CAh
		db	0E9h
		dw	004FFh
M002_L_302B:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_303C
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3041
M002_L_303C:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3041:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FDB8h
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_3055
		xor	AX,AX
		db	0E9h
		dw	007F1h
M002_L_3055:
		push	word ptr DGROUP:M002_BCC_DATA_77E2
		xor	AX,AX
		mov	DX,1
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		mov	DI,AX
		mov	AX,13h
		push	AX
		push	SI
		push	DI
		nop
		push	CS
		db	0E8h
		dw	01981h
		db	0E9h
		dw	004B6h
M002_L_3074:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3085
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_308A
M002_L_3085:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_308A:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FD6Fh
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_309E
		xor	AX,AX
		db	0E9h
		dw	007A8h
M002_L_309E:
		push	word ptr DGROUP:M002_BCC_DATA_77E2
		xor	AX,AX
		mov	DX,1
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		mov	DI,AX
		mov	AX,14h
		push	AX
		push	SI
		push	DI
		nop
		push	CS
		db	0E8h
		dw	01938h
		db	0E9h
		dw	0046Dh
M002_L_30BD:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_30CE
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_30D3
M002_L_30CE:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_30D3:
		cmp	AX,1
		je	short M002_L_30DB
		db	0E9h
		dw	000D6h
M002_L_30DB:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_30EC
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_30F1
M002_L_30EC:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_30F1:
		push	AX
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		je	short M002_L_3166
		nop
		push	CS
		db	0E8h
		dw	007E1h
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-6],0
		jne	short M002_L_310E
		xor	AX,AX
		db	0E9h
		dw	00738h
M002_L_310E:
		push	word ptr [BP-6]
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr DGROUP:M002_BCC_DATA_826B,0
		mov	DGROUP:M002_BCC_DATA_8269,AX
		or	AX,word ptr DGROUP:M002_BCC_DATA_826B
		jne	short M002_L_312F
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M002_L_312F:
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-6]
		cmp	byte ptr ES:[BX],11h
		jne	short M002_L_314A
		cmp	byte ptr ES:[BX+9],0
		je	short M002_L_314A
		mov	word ptr [BP-2],8
		jmp	short M002_L_314F
M002_L_314A:
		mov	word ptr [BP-2],6
M002_L_314F:
		push	word ptr [BP-2]
		db	0FFh,01Eh
		dw	8108h
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_826B
		push	word ptr DGROUP:M002_BCC_DATA_8269
		db	0FFh,01Eh
		dw	80B4h
		db	0E9h
		dw	003C4h
M002_L_3166:
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0E8h
		dw	0FA58h
		mov	DI,AX
		or	DI,DI
		jne	short M002_L_317B
		xor	AX,AX
		db	0E9h
		dw	006CBh
M002_L_317B:
		cmp	word ptr DGROUP:M002_BCC_STMT_TYPE_CURRENT,2
		je	short M002_L_3199
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	006ADh
M002_L_3199:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_31AA
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_31AF
M002_L_31AA:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_31AF:
		jmp	short M002_L_31C5
M002_L_31B1:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FC48h
		mov	DI,AX
		or	DI,DI
		jne	short M002_L_31C5
		xor	AX,AX
		db	0E9h
		dw	00681h
M002_L_31C5:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[DI],32h
		jne	short M002_L_31F3
		mov	BX,word ptr ES:[DI+0Ah]
		cmp	word ptr ES:[BX+2],11h
		je	short M002_L_31E5
		mov	BX,word ptr ES:[DI+0Ah]
		cmp	word ptr ES:[BX+2],12h
		jne	short M002_L_31F3
M002_L_31E5:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+0Ah]
		mov	AX,word ptr ES:[BX+8]
		jmp	short M002_L_3215
M002_L_31F3:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[DI],33h
		jne	short M002_L_320D
		mov	AX,100h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	AX,DGROUP:M002_BCC_DATA_77E2
		jmp	short M002_L_3215
M002_L_320D:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+8]
M002_L_3215:
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-6]
		cmp	byte ptr ES:[BX],12h
		jne	short M002_L_323E
		mov	AX,101h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	word ptr DGROUP:M002_BCC_DATA_826B,0
		mov	word ptr DGROUP:M002_BCC_DATA_8269,1
		jmp	short M002_L_325F
M002_L_323E:
		push	word ptr [BP-6]
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr DGROUP:M002_BCC_DATA_826B,0
		mov	DGROUP:M002_BCC_DATA_8269,AX
		or	AX,word ptr DGROUP:M002_BCC_DATA_826B
		jne	short M002_L_325F
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M002_L_325F:
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-6]
		cmp	byte ptr ES:[BX],11h
		jne	short M002_L_327A
		cmp	byte ptr ES:[BX+9],0
		je	short M002_L_327A
		mov	word ptr [BP-2],8
		jmp	short M002_L_327F
M002_L_327A:
		mov	word ptr [BP-2],6
M002_L_327F:
		push	word ptr [BP-2]
		db	0FFh,01Eh
		dw	8108h
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_826B
		push	word ptr DGROUP:M002_BCC_DATA_8269
		db	0FFh,01Eh
		dw	80B4h
		db	0E9h
		dw	00294h
M002_L_3296:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_32A7
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_32AC
M002_L_32A7:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_32AC:
		push	AX
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		je	short M002_L_3310
		nop
		push	CS
		db	0E8h
		dw	00626h
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-6],0
		jne	short M002_L_32C9
		xor	AX,AX
		db	0E9h
		dw	0057Dh
M002_L_32C9:
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0FB30h
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_32DD
		xor	AX,AX
		db	0E9h
		dw	00569h
M002_L_32DD:
		push	SI
		push	word ptr [BP-6]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	DI,AX
		or	DI,DI
		jne	short M002_L_330B
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0Ch
		jne	short M002_L_3305
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00227h
M002_L_3305:
		db	0E8h
		dw	00DA6h
		db	0E9h
		dw	00221h
M002_L_330B:
		mov	SI,DI
		db	0E9h
		dw	0021Ch
M002_L_3310:
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0F8ACh
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_3327
		xor	AX,AX
		db	0E9h
		dw	0051Fh
M002_L_3327:
		cmp	word ptr DGROUP:M002_BCC_STMT_TYPE_CURRENT,2
		je	short M002_L_3345
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00501h
M002_L_3345:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3356
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_335B
M002_L_3356:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_335B:
		db	0E9h
		dw	001CEh
M002_L_335E:
		cmp	byte ptr DGROUP:M002_BCC_DATA_16F5,1
		je	short M002_L_3385
		mov	AX,DGROUP:M002_BCC_DATA_679C
		cmp	AX,word ptr DGROUP:M002_BCC_DATA_85F4
		je	short M002_L_3385
		mov	BX,word ptr DGROUP:M002_BCC_DATA_862C
		mov	ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+8],4
		jne	short M002_L_3390
M002_L_3385:
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M002_L_3390:
		mov	AL,7
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_77E2
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X04C_09
		dw	seg X04C_09
		mov	SI,AX
		mov	AX,32h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01644h
		mov	SI,AX
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_33C1
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_33C6
M002_L_33C1:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_33C6:
		db	0E9h
		dw	00163h
M002_L_33C9:
		mov	AX,DGROUP:M002_BCC_DATA_8269
		mov	word ptr [BP+6],AX
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_33E0
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_33E5
M002_L_33E0:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_33E5:
		db	0E9h
		dw	00136h
M002_L_33E8:
		mov	AL,DGROUP:M002_BCC_DATA_8262
		cbw
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_826B
		push	word ptr DGROUP:M002_BCC_DATA_8269
		db	0FFh,01Eh
		dw	80B4h
		mov	SI,AX
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3411
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3416
M002_L_3411:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3416:
		db	0E9h
		dw	00113h
M002_L_3419:
		cmp	byte ptr DGROUP:M002_BCC_DATA_77D0,0
		je	short M002_L_343E
		cmp	byte ptr DGROUP:M002_BCC_DATA_16F5,1
		jne	short M002_L_343E
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00408h
M002_L_343E:
		push	DS
		mov	AX,8269h
		push	AX
		mov	AL,DGROUP:M002_BCC_DATA_8262
		cbw
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		db	09Ah
		dw	X04C_00
		dw	seg X04C_00
		mov	SI,AX
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3465
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_346A
M002_L_3465:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_346A:
		db	0E9h
		dw	000BFh
M002_L_346D:
		db	09Ah
		dw	X05A_01
		dw	seg X05A_01
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],0
M002_L_347A:
		push	word ptr [BP+4]
		db	09Ah
		dw	X031_06
		dw	seg X031_06
		mov	AX,DGROUP:M002_BCC_DATA_8269
		add	word ptr [BP-4],AX
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3499
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_349E
M002_L_3499:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_349E:
		cmp	AX,34h
		je	short M002_L_347A
		cmp	word ptr [BP+4],0
		je	short M002_L_34C3
		mov	AL,0
		push	AX
		db	09Ah
		dw	X05A_02
		dw	seg X05A_02
		cmp	byte ptr DGROUP:M002_BCC_DATA_1708,0
		je	short M002_L_34C3
		push	word ptr [BP-2]
		db	09Ah
		dw	X05A_00
		dw	seg X05A_00
		mov	word ptr [BP-2],AX
M002_L_34C3:
		mov	AX,word ptr [BP-4]
		inc	AX
		xor	DX,DX
		push	DX
		push	AX
		push	word ptr DGROUP:M002_BCC_DATA_77E4
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X04F_13
		dw	seg X04F_13
		mov	word ptr [BP-6],AX
		mov	AX,1
		push	AX
		push	word ptr [BP-6]
		push	word ptr DGROUP:M002_BCC_DATA_781F
		push	word ptr [BP-2]
		mov	AX,4
		push	AX
		db	0FFh,01Eh
		dw	80BCh
		mov	SI,AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+7]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	8158h
		jmp	short M002_L_352A
M002_L_3507:
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00328h
M002_L_351E:
		push	word ptr [BP+6]
		db	0E8h
		dw	0032Bh
		push	word ptr [BP+6]
		db	0E8h
		dw	0060Ah
M002_L_352A:
		mov	SI,AX
M002_L_352C:
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		cmp	AX,2Eh
		je	short M002_L_3570
		jg	short M002_L_354B
		cmp	AX,1
		jne	short M002_L_353E
		db	0E9h
		dw	00098h
M002_L_353E:
		cmp	AX,3
		je	short M002_L_3582
		cmp	AX,2Dh
		je	short M002_L_355E
		db	0E9h
		dw	002DEh
M002_L_354B:
		cmp	AX,2Fh
		jne	short M002_L_3553
		db	0E9h
		dw	000ECh
M002_L_3553:
		cmp	AX,30h
		jne	short M002_L_355B
		db	0E9h
		dw	0021Ah
M002_L_355B:
		db	0E9h
		dw	002CBh
M002_L_355E:
		mov	AX,23h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01487h
		mov	SI,AX
		db	0E9h
		dw	002BDh
M002_L_3570:
		mov	AX,24h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	01475h
		mov	SI,AX
		db	0E9h
		dw	002ABh
M002_L_3582:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3593
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3598
M002_L_3593:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3598:
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0F624h
		mov	DI,AX
		or	DI,DI
		jne	short M002_L_35AF
		xor	AX,AX
		db	0E9h
		dw	00297h
M002_L_35AF:
		cmp	word ptr DGROUP:M002_BCC_STMT_TYPE_CURRENT,4
		je	short M002_L_35CC
		push	DS
		mov	AX,35C2h
		push	AX
		mov	AX,0E5h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	0027Ah
M002_L_35CC:
		push	SI
		push	DI
		db	0E8h
		dw	005E1h
		mov	SI,AX
		db	0E9h
		dw	00257h
M002_L_35D6:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_35E7
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_35EC
M002_L_35E7:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_35EC:
		cmp	AX,2
		jne	short M002_L_35F5
		xor	DI,DI
		jmp	short M002_L_362F
M002_L_35F5:
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,1
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP+4]
		db	0E8h
		dw	0F5C2h
		mov	DI,AX
		or	DI,DI
		jne	short M002_L_3611
		xor	AX,AX
		db	0E9h
		dw	00235h
M002_L_3611:
		cmp	word ptr DGROUP:M002_BCC_STMT_TYPE_CURRENT,2
		je	short M002_L_362F
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,1Ah
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00217h
M002_L_362F:
		mov	AX,DGROUP:M002_BCC_DATA_77D3
		mov	DGROUP:M002_BCC_DATA_66BE,AX
		push	SI
		push	DI
		db	0E8h
		dw	00A80h
		mov	SI,AX
		db	0E9h
		dw	001EEh
M002_L_363F:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3650
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3655
M002_L_3650:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3655:
		cmp	AX,31h
		je	short M002_L_3671
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,18h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	001D5h
M002_L_3671:
		mov	AX,DGROUP:M002_BCC_DATA_77D3
		mov	DGROUP:M002_BCC_DATA_66BE,AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M002_L_3685
		db	0E9h
		dw	001A8h
M002_L_3685:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],13h
		je	short M002_L_36A5
		mov	AX,54h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		nop
		push	CS
		db	0E8h
		dw	010BCh
		mov	SI,AX
		db	0E9h
		dw	00188h
M002_L_36A5:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	02223h
		or	AX,AX
		jne	short M002_L_372A
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Ah
		jne	short M002_L_3701
		mov	AX,32h
		push	AX
		push	word ptr ES:[SI+8]
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04D_06
		dw	seg X04D_06
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ch],AX
		mov	BX,word ptr ES:[SI+0Ch]
		mov	AX,word ptr ES:[BX+2]
		mov	word ptr ES:[SI+2],AX
		mov	BX,word ptr ES:[SI+0Ch]
		mov	AX,word ptr ES:[BX+8]
		mov	word ptr ES:[SI+8],AX
		jmp	short M002_L_3739
M002_L_3701:
		mov	AX,32h
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		mov	AL,0Dh
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,3
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		jmp	short M002_L_3739
M002_L_372A:
		mov	AX,32h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	012BBh
		mov	SI,AX
M002_L_3739:
		push	SI
		push	word ptr DGROUP:M002_BCC_DATA_8269
		push	word ptr DGROUP:M002_BCC_DATA_679C
		db	0E8h
		dw	01026h
		mov	SI,AX
		or	SI,SI
		je	short M002_L_374E
		db	0E9h
		dw	000DFh
M002_L_374E:
		mov	word ptr DGROUP:M002_BCC_DATA_5F4E,0
		push	word ptr DGROUP:M002_BCC_DATA_8269
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,5Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		nop
		push	CS
		db	0E8h
		dw	00FECh
		mov	SI,AX
		db	0E9h
		dw	000B8h
M002_L_3775:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_3786
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_378B
M002_L_3786:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_378B:
		cmp	AX,31h
		je	short M002_L_37A7
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0D0h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	0009Fh
M002_L_37A7:
		mov	AX,DGROUP:M002_BCC_DATA_77D3
		mov	DGROUP:M002_BCC_DATA_66BE,AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_382D
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		test	AX,14h
		je	short M002_L_37DD
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],13h
		je	short M002_L_37F1
M002_L_37DD:
		mov	AX,51h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		nop
		push	CS
		db	0E8h
		dw	00F6Fh
		mov	SI,AX
		jmp	short M002_L_382D
M002_L_37F1:
		push	SI
		push	word ptr DGROUP:M002_BCC_DATA_8269
		push	word ptr DGROUP:M002_BCC_DATA_679C
		db	0E8h
		dw	00F6Eh
		mov	SI,AX
		or	SI,SI
		jne	short M002_L_382D
		mov	word ptr DGROUP:M002_BCC_DATA_5F4E,0
		push	word ptr DGROUP:M002_BCC_DATA_8269
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,5Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		nop
		push	CS
		db	0E8h
		dw	00F37h
		mov	SI,AX
		jmp	short M002_L_382D
M002_L_3829:
		mov	AX,SI
		jmp	short M002_L_3846
M002_L_382D:
		cmp	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		je	short M002_L_383E
		mov	byte ptr DGROUP:M002_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M002_BCC_STMT_TYPE_CURRENT
		jmp	short M002_L_3843
M002_L_383E:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M002_L_3843:
		db	0E9h
		dw	0FCE6h
M002_L_3846:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_STMT_UNARY_NEAR	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5BED:far
		extrn	X019_04:far
		extrn	X04A_12:far
		extrn	X04A_0B:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M003_BCC_DATA_1705	equ	1705h
M003_BCC_DATA_5F4E	equ	5F4Eh
M003_BCC_DATA_6454	equ	6454h
M003_BCC_DATA_679C	equ	679Ch
M003_BCC_DATA_77D1	equ	77D1h
M003_BCC_DATA_77E6	equ	77E6h
M003_BCC_STMT_TYPE_CURRENT	equ	8260h
M003_BCC_DATA_8664	equ	8664h

BCC_NEAR_384F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		cmp	word ptr DGROUP:M003_BCC_STMT_TYPE_CURRENT,1
		jne	short M003_L_38DA
		push	DI
		push	word ptr DGROUP:M003_BCC_DATA_679C
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04A_12
		dw	seg X04A_12
		or	AX,AX
		jne	short M003_L_38DA
		cmp	byte ptr DGROUP:M003_BCC_DATA_6454,0
		jne	short M003_L_3891
		mov	word ptr DGROUP:M003_BCC_DATA_5F4E,0
		push	DI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,171h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
M003_L_3891:
		xor	SI,SI
		cmp	byte ptr DGROUP:M003_BCC_DATA_1705,1
		jne	short M003_L_389F
		mov	SI,400h
		jmp	short M003_L_38A9
M003_L_389F:
		cmp	byte ptr DGROUP:M003_BCC_DATA_1705,2
		jne	short M003_L_38A9
		mov	SI,2000h
M003_L_38A9:
		cmp	byte ptr DGROUP:M003_BCC_DATA_77D1,0
		je	short M003_L_38B4
		db	81h,0CEh,10h,0
M003_L_38B4:
		push	DI
		push	word ptr DGROUP:M003_BCC_DATA_679C
		mov	AL,0
		push	AX
		mov	AX,2
		push	AX
		push	word ptr DGROUP:M003_BCC_DATA_77E6
		cmp	byte ptr DGROUP:M003_BCC_DATA_77D1,0
		je	short M003_L_38D0
		mov	AX,0FFFFh
		jmp	short M003_L_38D3
M003_L_38D0:
		mov	AX,DGROUP:M003_BCC_DATA_8664
M003_L_38D3:
		push	AX
		push	SI
		db	09Ah
		dw	X04A_0B
		dw	seg X04A_0B
M003_L_38DA:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_384F	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far
		extrn	X046_07:far
		extrn	X046_09:far
		extrn	X04D_03:far
		extrn	X04D_01:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M004_BCC_TOKEN_SAVED	equ	77FDh
M004_BCC_STMT_TYPE_CURRENT	equ	8260h
M004_BCC_DATA_8624	equ	8624h

		public	X047_06
X047_06	label	far
BCC_NEAR_38E1	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		db	09Ah
		dw	X046_07
		dw	seg X046_07
		mov	SI,AX
		cmp	word ptr DGROUP:M004_BCC_DATA_8624,0
		je	short M004_L_390B
		push	DS
		mov	BX,word ptr DGROUP:M004_BCC_DATA_8624
		shl	BX,1
		push	word ptr [BX+37DAh]
		mov	AX,102h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
M004_L_390B:
		or	SI,SI
		jne	short M004_L_3913
		xor	AX,AX
		jmp	short M004_L_395C
M004_L_3913:
		db	09Ah
		dw	X04D_01
		dw	seg X04D_01
		mov	DI,AX
		or	DI,DI
		jne	short M004_L_3922
		xor	AX,AX
		jmp	short M004_L_395C
M004_L_3922:
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_393F
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		jmp	short M004_L_395C
M004_L_393F:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_3950
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_3955
M004_L_3950:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_3955:
		push	DI
		push	SI
		db	09Ah
		dw	X04D_03
		dw	seg X04D_03
M004_L_395C:
		pop	DI
		pop	SI
		pop	BP
		retf
BCC_NEAR_38E1	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far
		extrn	X046_09:far
		extrn	X049_02:far
		extrn	X04C_04:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M005_BCC_DATA_77D0	equ	77D0h
M005_BCC_TOKEN_SAVED	equ	77FDh
M005_BCC_DATA_80C8	equ	80C8h
M005_BCC_DATA_8186	equ	8186h
M005_BCC_STMT_TYPE_CURRENT	equ	8260h
M005_BCC_DATA_8269	equ	8269h
M005_BCC_DATA_826B	equ	826Bh

		public	X047_02
X047_02	label	far
BCC_NEAR_3960	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		db	09Ah
		dw	X04C_04
		dw	seg X04C_04
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP+6]
		dec	BX
		cmp	BX,4
		jbe	short M005_L_397A
		db	0E9h
		dw	00155h
M005_L_397A:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0F7Ah
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		mov	AX,2
		push	AX
		db	0E8h
		dw	0F23Ah
		mov	SI,AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,4
		je	short M005_L_39AD
		push	DS
		mov	AX,35CFh
		push	AX
		mov	AX,0E5h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00176h
M005_L_39AD:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_39BE
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_39C3
M005_L_39BE:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_39C3:
		db	0E9h
		dw	00109h
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,2
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,2
		push	AX
		db	0E8h
		dw	0F1F0h
		mov	SI,AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,8
		jne	short M005_L_39E4
		db	0E9h
		dw	000EBh
M005_L_39E4:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,7
		jne	short M005_L_39EE
		db	0E9h
		dw	000E1h
M005_L_39EE:
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	0011Eh
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,2
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,2
		push	AX
		db	0E8h
		dw	0F1B1h
		mov	SI,AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,8
		jne	short M005_L_3A23
		db	0E9h
		dw	000ACh
M005_L_3A23:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,6
		jne	short M005_L_3A2D
		db	0E9h
		dw	000A2h
M005_L_3A2D:
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,28h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	000DFh
		mov	byte ptr DGROUP:M005_BCC_DATA_77D0,1
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_3A5A
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_3A5F
M005_L_3A5A:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_3A5F:
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,4
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,2
		push	AX
		db	0E8h
		dw	0F157h
		mov	SI,AX
		mov	byte ptr DGROUP:M005_BCC_DATA_77D0,0
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,0Ah
		je	short M005_L_3ACF
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	word ptr DGROUP:M005_BCC_DATA_826B,0
		mov	word ptr DGROUP:M005_BCC_DATA_8269,0
		xor	AX,AX
		db	0E9h
		dw	00088h
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,2
		push	AX
		db	0E8h
		dw	0F11Bh
		mov	SI,AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,21h
		je	short M005_L_3ACF
		mov	AX,1Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	word ptr DGROUP:M005_BCC_DATA_826B,0
		mov	word ptr DGROUP:M005_BCC_DATA_8269,0
		jmp	short M005_L_3B20
M005_L_3ACF:
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M005_L_3AE4
		jmp	short M005_L_3B0A
M005_L_3AE4:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8186
		cmp	word ptr ES:[SI],2
		jne	short M005_L_3AFF
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	DGROUP:M005_BCC_DATA_826B,AX
		mov	word ptr DGROUP:M005_BCC_DATA_8269,DX
		jmp	short M005_L_3B16
M005_L_3AFF:
		mov	AX,0F1h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M005_L_3B0A:
		mov	word ptr DGROUP:M005_BCC_DATA_826B,0
		mov	word ptr DGROUP:M005_BCC_DATA_8269,0
M005_L_3B16:
		cmp	word ptr [BP-2],0
		je	short M005_L_3B20
		db	0FFh,01Eh
		dw	80C8h
M005_L_3B20:
		mov	AX,1
M005_L_3B23:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_NEAR_3960	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP
M006_BCC_STMT_TABLE_3B2A:
		dw	0DD1h
		dw	0E16h
		dw	0EEBh
		dw	0E55h
		dw	0E94h

CO047_TEXT	ends




		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far
		extrn	X04A_11:far
		extrn	X04A_0B:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M006_BCC_DATA_5F4E	equ	5F4Eh
M006_BCC_DATA_679C	equ	679Ch
M006_BCC_DATA_77D0	equ	77D0h
M006_BCC_DATA_77E2	equ	77E2h
M006_BCC_DATA_80B4	equ	80B4h
M006_BCC_DATA_8108	equ	8108h



BCC_NEAR_3B34	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		push	SI
		push	word ptr DGROUP:M006_BCC_DATA_679C
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X04A_11
		dw	seg X04A_11
		mov	DI,AX
		or	DI,DI
		jne	short M006_L_3BA5
		cmp	byte ptr DGROUP:M006_BCC_DATA_77D0,0
		je	short M006_L_3B67
		push	word ptr DGROUP:M006_BCC_DATA_77E2
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		jmp	short M006_L_3BAB
M006_L_3B67:
		mov	word ptr DGROUP:M006_BCC_DATA_5F4E,0
		push	SI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,5Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		push	SI
		push	word ptr DGROUP:M006_BCC_DATA_679C
		mov	AL,0
		push	AX
		mov	AX,9
		push	AX
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X04A_0B
		dw	seg X04A_0B
		nop
		push	CS
		db	0E8h
		dw	00BB9h
		jmp	short M006_L_3BAB
M006_L_3BA5:
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00D4Bh
M006_L_3BAB:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_3B34	endp
CO047_TEXT	ends




CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M007_BCC_DATA_80B8	equ	80B8h
M007_BCC_DATA_8186	equ	8186h

BCC_NEAR_3BB2	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		cmp	word ptr ES:[DI+8],0
		jne	short M007_L_3BCD
		mov	AX,DI
		jmp	short M007_L_3C4B
M007_L_3BCD:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		cmp	word ptr ES:[SI+8],0
		jne	short M007_L_3BDA
		jmp	short M007_L_3C49
M007_L_3BDA:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0Eh
		je	short M007_L_3BEC
		cmp	word ptr ES:[SI+2],0Eh
		jne	short M007_L_3BF9
M007_L_3BEC:
		mov	AX,8
		push	AX
		push	DI
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00DFBh
		jmp	short M007_L_3C38
M007_L_3BF9:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M007_L_3C1F
		push	SI
		push	DI
		db	0E8h
		dw	00045h
		mov	SI,AX
		mov	AX,8
		push	AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		push	DI
		push	SI
		jmp	short M007_L_3C34
M007_L_3C1F:
		push	DI
		push	SI
		db	0E8h
		dw	0002Eh
		mov	DI,AX
		mov	AX,8
		push	AX
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		push	DI
M007_L_3C34:
		db	0FFh,01Eh
		dw	80B8h
M007_L_3C38:
		mov	SI,AX
		mov	AX,31h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00DABh
		mov	SI,AX
M007_L_3C49:
		mov	AX,SI
M007_L_3C4B:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_3BB2	endp
CO047_TEXT	ends




CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M008_BCC_DATA_80B8	equ	80B8h
M008_BCC_DATA_8108	equ	8108h
M008_BCC_DATA_8186	equ	8186h

BCC_NEAR_3C52	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],10h
		jne	short M008_L_3C70
		mov	AX,7
		jmp	short M008_L_3C73
M008_L_3C70:
		mov	AX,5
M008_L_3C73:
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	word ptr [BP-2],AX
		push	SI
		push	word ptr [BP-2]
		nop
		push	CS
		db	0E8h
		dw	000A5h
		mov	SI,AX
		mov	AX,0Ah
		push	AX
		push	word ptr [BP-2]
		push	SI
		push	DI
		db	0E8h
		dw	0089Ch
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_3C52	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5BED:far
		extrn	X04C_0E:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M009_BCC_DATA_8108	equ	8108h
M009_BCC_DATA_8186	equ	8186h

BCC_NEAR_3CA2	proc	near
M009_L_3CA2:
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		or	SI,SI
		jne	short M009_L_3CB3
		xor	AX,AX
		jmp	short M009_L_3D22
M009_L_3CB3:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Bh
		jne	short M009_L_3CD2
		push	word ptr ES:[SI+0Ah]
		db	0E8h
		dw	0FFDEh
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ah],AX
		mov	DI,word ptr ES:[SI+0Ch]
		jmp	short M009_L_3CD4
M009_L_3CD2:
		mov	DI,SI
M009_L_3CD4:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],13h
		jne	short M009_L_3CEC
		mov	AX,178h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M009_L_3D20
M009_L_3CEC:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],9
		jne	short M009_L_3D08
		push	DI
		mov	AX,0Ah
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		jmp	short M009_L_3D0C
M009_L_3D08:
		push	DI
		db	0E8h
		dw	0087Bh
M009_L_3D0C:
		mov	DI,AX
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Bh
		jne	short M009_L_3D1E
		mov	word ptr ES:[SI+0Ch],DI
		jmp	short M009_L_3D20
M009_L_3D1E:
		mov	SI,DI
M009_L_3D20:
		mov	AX,SI
M009_L_3D22:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_3CA2	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_5BED:far
		extrn	X050_04:far
		extrn	X049_02:far
		extrn	X04C_0E:far
		extrn	X04F_0C:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M00A_BCC_DATA_3F80	equ	3F80h
M00A_BCC_DATA_5F8B	equ	5F8Bh
M00A_BCC_EXPR_SEGMENT	equ	639Ah
M00A_BCC_DATA_8186	equ	8186h

		public	X047_0C
X047_0C	label	far
BCC_NEAR_3D29	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],0
		jne	short M00A_L_3D43
		mov	AX,SI
		db	0E9h
		dw	0026Eh
M00A_L_3D43:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-2],AX
		cmp	AX,word ptr [BP+6]
		jne	short M00A_L_3D58
		mov	AX,SI
		db	0E9h
		dw	00259h
M00A_L_3D58:
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP+6]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DI,AX
		mov	BX,DI
		sub	BX,0Ch
		cmp	BX,7
		jbe	short M00A_L_3D86
		db	0E9h
		dw	00173h
M00A_L_3D86:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1423h
		db	0E9h
		dw	00218h
		db	0E8h
		dw	0031Bh
		mov	AX,SI
		db	0E9h
		dw	00219h
		push	SI
		db	09Ah
		dw	025h
		dw	seg CO049_TEXT
		mov	SI,AX
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-4],AX
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-2],AX
		cmp	word ptr ES:[SI],2
		jne	short M00A_L_3DE6
		mov	AX,word ptr ES:[SI+0Ah]
		or	AX,word ptr ES:[SI+0Ch]
		jne	short M00A_L_3DE6
		cmp	word ptr [BP-4],0Dh
		jne	short M00A_L_3DD2
		cmp	DI,0Fh
		je	short M00A_L_3DE6
		cmp	DI,10h
		je	short M00A_L_3DE6
M00A_L_3DD2:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+8],AX
		mov	word ptr ES:[SI+2],DI
		mov	AX,SI
		db	0E9h
		dw	001CBh
M00A_L_3DE6:
		mov	BX,word ptr [BP-4]
		test	byte ptr [BX+9CAh],1
		je	short M00A_L_3E1B
		cmp	DI,0Fh
		je	short M00A_L_3E0D
		cmp	word ptr [BP-4],7
		je	short M00A_L_3E01
		cmp	word ptr [BP-4],8
		jne	short M00A_L_3E0D
M00A_L_3E01:
		mov	AX,5Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		db	0E9h
		dw	000ADh
M00A_L_3E0D:
		mov	AX,177h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	000A1h
M00A_L_3E1B:
		mov	BX,word ptr [BP-4]
		test	byte ptr [BX+9CAh],14h
		jne	short M00A_L_3E28
		db	0E9h
		dw	00094h
M00A_L_3E28:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	word ptr [BP-6],AX
		mov	BX,word ptr [BP+6]
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr [BP-6]
		and	AX,1
		mov	word ptr [BP-8],AX
		mov	AX,word ptr [BP-0Ah]
		and	AX,1
		mov	word ptr [BP-0Ch],AX
		db	81h,66h,0FAh,02h,0
		db	81h,66h,0F6h,02h,0
		mov	AX,word ptr [BP-0Ah]
		cmp	AX,word ptr [BP-6]
		jl	short M00A_L_3E6E
		mov	AX,word ptr [BP-0Ch]
		cmp	AX,word ptr [BP-8]
		jge	short M00A_L_3E70
M00A_L_3E6E:
		jmp	short M00A_L_3EB1
M00A_L_3E70:
		push	word ptr [BP-2]
		push	word ptr [BP+6]
		mov	AX,1
		push	AX
		db	0E8h
		dw	00166h
		or	AX,AX
		jne	short M00A_L_3EBC
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],2
		ja	short M00A_L_3EB1
		mov	BX,word ptr [BP+6]
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],2
		ja	short M00A_L_3EB1
		push	word ptr [BP-2]
		push	word ptr [BP+6]
		db	0E8h
		dw	0018Dh
		or	AX,AX
		je	short M00A_L_3EB1
		mov	AX,17Bh
		jmp	short M00A_L_3EB4
M00A_L_3EB1:
		mov	AX,175h
M00A_L_3EB4:
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
M00A_L_3EBA:
		inc	SP
		inc	SP
M00A_L_3EBC:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],32h
		jne	short M00A_L_3EF9
		cmp	word ptr [BP-4],DI
		jne	short M00A_L_3EF9
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	BX,word ptr [BP+6]
		push	word ptr ES:[BX+3]
		mov	AL,1
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		je	short M00A_L_3EF9
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+8],AX
		mov	AX,SI
		db	0E9h
		dw	000B8h
M00A_L_3EF9:
		mov	BX,word ptr [BP-4]
		sub	BX,7
		cmp	BX,0Ch
		jbe	short M00A_L_3F07
		db	0E9h
		dw	000A1h
M00A_L_3F07:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1409h
		cmp	DI,5
		je	short M00A_L_3F1B
		cmp	DI,6
		je	short M00A_L_3F1B
		db	0E9h
		dw	0008Dh
M00A_L_3F1B:
		mov	AX,170h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	0007Fh
		test	byte ptr [DI+9CAh],2
		je	short M00A_L_3F33
		db	0E8h
		dw	0017Bh
M00A_L_3F33:
		test	byte ptr [DI+9CAh],1
		je	short M00A_L_3FA8
		cmp	word ptr [BP-4],0Fh
		jne	short M00A_L_3F64
		cmp	DI,7
		je	short M00A_L_3F4A
		cmp	DI,8
		jne	short M00A_L_3F57
M00A_L_3F4A:
		mov	AX,177h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M00A_L_3FA8
M00A_L_3F57:
		mov	AX,5Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M00A_L_3FA8
M00A_L_3F64:
		cmp	DI,7
		je	short M00A_L_3F6E
		cmp	DI,8
		jne	short M00A_L_3F7B
M00A_L_3F6E:
		mov	AX,5Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M00A_L_3FA8
M00A_L_3F7B:
		mov	AX,177h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M00A_L_3FA8
		test	byte ptr [DI+9CAh],14h
		je	short M00A_L_3FA8
		db	0E8h
		dw	0011Ch
		jmp	short M00A_L_3FA8
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M00A_L_3FA8
		db	0E8h
		dw	0010Ah
		mov	AX,SI
		jmp	short M00A_L_3FB1
M00A_L_3FA8:
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
M00A_L_3FB1:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_NEAR_3D29	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT

BCC_STMT_TYPE_TABLE	label	word
		dw	0135Eh
		dw	0135Eh
		dw	013D8h
		dw	013D8h
		dw	013F8h
		dw	013E4h
		dw	01379h
		dw	01379h
		dw	01379h
		dw	01379h
		dw	013F8h
		dw	013F8h
		dw	013F1h
		dw	011DDh
		dw	011E8h
		dw	011E8h
		dw	011E8h
		dw	011E8h
		dw	011E0h
		dw	011E0h
		dw	011E0h

CO047_TEXT	ends

		extrn	X04F_0C:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M00C_BCC_EXPR_SEGMENT	equ	639Ah

BCC_NEAR_3FE3	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		push	SI
		push	DI
		db	0E8h
		dw	00041h
		or	AX,AX
		jne	short M00C_L_3FFC
		xor	AX,AX
		jmp	short M00C_L_402E
M00C_L_3FFC:
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		cmp	byte ptr ES:[BX],0Ch
		je	short M00C_L_4014
		mov	BX,word ptr ES:[DI+3]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M00C_L_4019
M00C_L_4014:
		mov	AX,1
		jmp	short M00C_L_402E
M00C_L_4019:
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		push	word ptr ES:[SI+3]
		push	word ptr ES:[DI+3]
		mov	AL,byte ptr [BP+4]
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
M00C_L_402E:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_3FE3	endp
CO047_TEXT	ends


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M00D_BCC_EXPR_SEGMENT	equ	639Ah


BCC_NEAR_4035	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		sub	AX,0Dh
		mov	BX,AX
		cmp	BX,3
		ja	short M00D_L_409D
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	14F6h
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],0Eh
		jne	short M00D_L_406A
		mov	AX,1
		jmp	short M00D_L_409F
M00D_L_406A:
		jmp	short M00D_L_409D
		mov	AX,1
		jmp	short M00D_L_409F
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],10h
		jne	short M00D_L_407D
		jmp	short M00D_L_409D
M00D_L_407D:
		mov	AX,1
		jmp	short M00D_L_409F
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],0Dh
		jne	short M00D_L_409B
		mov	AL,byte ptr ES:[SI+8]
		cmp	AL,byte ptr ES:[DI+8]
		jne	short M00D_L_409B
		mov	AX,1
		jmp	short M00D_L_409F
M00D_L_409B:
		jmp	short M00D_L_409D
M00D_L_409D:
		xor	AX,AX
M00D_L_409F:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_4035	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT

BCC_STMT_TYPE_JUMP_TABLE	label	word
		dw	014D2h
		dw	014ABh
		dw	014C1h
		dw	014BCh

CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

BCC_NEAR_40AE	proc	near
		mov	AX,15h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		ret
BCC_NEAR_40AE	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_5BED:far
		extrn	X019_04:far
		extrn	X049_02:far
		extrn	X078_00:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M010_BCC_DATA_5F4E	equ	5F4Eh
M010_BCC_EXPR_SEGMENT	equ	639Ah
M010_BCC_STMT_RECORD_SEG	equ	63C2h
M010_BCC_DATA_77E2	equ	77E2h
M010_BCC_DATA_80B8	equ	80B8h
M010_BCC_DATA_80BC	equ	80BCh
M010_BCC_DATA_80C4	equ	80C4h
M010_BCC_DATA_8108	equ	8108h
M010_BCC_DATA_8186	equ	8186h
M010_BCC_DATA_85EE	equ	85EEh
M010_BCC_DATA_85F0	equ	85F0h
M010_BCC_DATA_8664	equ	8664h

BCC_NEAR_40BA	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	word ptr [BP-6],0
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0
		jne	short M010_L_40DB
		mov	AX,DI
		db	0E9h
		dw	001F4h
M010_L_40DB:
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8186
		mov	SI,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	BX,AX
		test	byte ptr [BX+9CAh],14h
		jne	short M010_L_40F8
		db	0E9h
		dw	00080h
M010_L_40F8:
		mov	BX,word ptr ES:[SI+3]
		cmp	byte ptr ES:[BX],12h
		jne	short M010_L_4178
		mov	SI,word ptr ES:[SI+3]
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8186
		cmp	word ptr ES:[DI],32h
		jne	short M010_L_4162
		mov	BX,word ptr ES:[DI+0Ah]
		cmp	word ptr ES:[BX],1
		jne	short M010_L_4162
		mov	DI,word ptr ES:[DI+0Ah]
		mov	AX,word ptr ES:[DI+0Ah]
		mov	DX,AX
		mov	BX,DX
		mov	ES,word ptr DGROUP:M010_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[BX+2]
		mov	word ptr [BP-2],AX
		cmp	byte ptr ES:[BX+5],0Ah
		jne	short M010_L_413F
		mov	word ptr [BP-6],1
		jmp	short M010_L_418B
M010_L_413F:
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		test	byte ptr ES:[SI+8],1
		je	short M010_L_418B
		mov	BX,DX
		mov	ES,word ptr DGROUP:M010_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[BX+0Ch]
		cmp	AX,word ptr DGROUP:M010_BCC_DATA_8664
		je	short M010_L_418B
		or	word ptr ES:[BX+6],100h
		jmp	short M010_L_418B
M010_L_4162:
		mov	AX,31h
		push	AX
		push	SI
		push	DI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		mov	word ptr [BP-2],0
		jmp	short M010_L_418B
M010_L_4178:
		mov	AX,0F4h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		nop
		push	CS
		db	0E8h
		dw	005D4h
		db	0E9h
		dw	00144h
M010_L_418B:
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[SI+5]
		mov	word ptr [BP-4],AX
		mov	word ptr DGROUP:M010_BCC_DATA_85EE,1
		mov	word ptr DGROUP:M010_BCC_DATA_85F0,DI
		push	word ptr [BP+4]
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	word ptr [BP+4],AX
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		test	byte ptr ES:[SI+8],8
		jne	short M010_L_41D2
		mov	AL,byte ptr ES:[SI+8]
		and	AL,4
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FADCh
		push	AX
		push	word ptr [BP-2]
		db	0E8h
		dw	001B2h
		mov	word ptr [BP+4],AX
		jmp	short M010_L_4239
M010_L_41D2:
		cmp	word ptr [BP-6],0
		jne	short M010_L_4216
		push	word ptr [BP+4]
		db	0E8h
		dw	0FAC4h
		mov	word ptr [BP+4],AX
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8186
		cmp	word ptr ES:[DI],1
		jne	short M010_L_4209
		mov	word ptr DGROUP:M010_BCC_DATA_5F4E,0
		push	word ptr [BP-2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,167h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		add	SP,6
		jmp	short M010_L_4239
M010_L_4209:
		mov	AX,168h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M010_L_4239
M010_L_4216:
		push	word ptr [BP+4]
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	word ptr [BP+4],AX
		mov	ES,word ptr DGROUP:M010_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+0Ah]
		mov	ES,word ptr DGROUP:M010_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+0Eh]
		push	word ptr [BP+4]
		db	09Ah
		dw	X078_00
		dw	seg X078_00
M010_L_4239:
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[SI+3]
		cmp	byte ptr ES:[SI],15h
		jne	short M010_L_4260
		cmp	word ptr ES:[SI+3],1
		jne	short M010_L_425A
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	SI,AX
		jmp	short M010_L_42C2
M010_L_425A:
		mov	SI,word ptr DGROUP:M010_BCC_DATA_77E2
		jmp	short M010_L_42C2
M010_L_4260:
		mov	ES,word ptr DGROUP:M010_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],13h
		jne	short M010_L_42C2
		mov	AX,word ptr ES:[SI+3]
		mov	word ptr [BP-8],AX
		cmp	word ptr [BP-8],1
		je	short M010_L_42C2
		cmp	word ptr [BP-8],2
		je	short M010_L_42C2
		cmp	word ptr [BP-8],4
		je	short M010_L_42C2
		push	SI
		db	0FFh,01Eh
		dw	80C4h
		mov	word ptr [BP-0Ah],AX
		push	SI
		push	word ptr [BP+4]
		push	word ptr [BP-0Ah]
		db	0E8h
		dw	00043h
		mov	word ptr [BP+4],AX
		mov	AX,36h
		push	AX
		push	word ptr DGROUP:M010_BCC_DATA_77E2
		push	DI
		push	word ptr [BP+4]
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		mov	AX,5
		push	AX
		push	SI
		push	word ptr [BP-0Ah]
		xor	AX,AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80BCh
		mov	word ptr [BP+4],AX
		mov	AX,2Ah
		jmp	short M010_L_42C5
M010_L_42C2:
		mov	AX,36h
M010_L_42C5:
		push	AX
		push	SI
		push	DI
		push	word ptr [BP+4]
		db	0FFh,01Eh
		dw	80B8h
M010_L_42CF:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_40BA	endp
CO047_TEXT	ends


		extrn	X04F_11:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M011_BCC_DATA_80B8	equ	80B8h
M011_BCC_DATA_80BC	equ	80BCh
M011_BCC_DATA_8186	equ	8186h

BCC_NEAR_42D8	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	AX,5
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP+4]
		xor	AX,AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80BCh
		mov	word ptr [BP-2],AX
		mov	AX,32h
		push	AX
		push	word ptr [BP+8]
		mov	AL,0Fh
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	word ptr [BP-2]
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		or	DI,DI
		jne	short M011_L_4323
		mov	DI,word ptr [BP-2]
		jmp	short M011_L_4374
M011_L_4323:
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8186
		cmp	word ptr ES:[DI],2Bh
		je	short M011_L_4340
		mov	AX,2Bh
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP-2]
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		jmp	short M011_L_4374
M011_L_4340:
		mov	SI,DI
		jmp	short M011_L_434C
M011_L_4344:
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8186
		mov	SI,word ptr ES:[SI+0Ah]
M011_L_434C:
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],2Bh
		je	short M011_L_4344
		mov	AX,2Bh
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP-2]
		push	word ptr ES:[SI+0Ah]
		db	0FFh,01Eh
		dw	80B8h
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ah],AX
M011_L_4374:
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_42D8	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M012_BCC_DATA_5F4E	equ	5F4Eh

BCC_NEAR_437F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	AL,byte ptr [BP+0Ah]
		push	AX
		push	SS
		lea	AX,[BP+8]
		push	AX
		push	SI
		push	DI
		db	0E8h
		dw	00034h
		mov	SI,AX
		cmp	word ptr [BP+8],0
		je	short M012_L_43C4
		mov	word ptr DGROUP:M012_BCC_DATA_5F4E,0
		push	DI
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		or	DI,DI
		je	short M012_L_43B8
		mov	AX,2Eh
		jmp	short M012_L_43BB
M012_L_43B8:
		mov	AX,2Dh
M012_L_43BB:
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
M012_L_43C4:
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_437F	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X019_04:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M013_BCC_DATA_5F4E	equ	5F4Eh
M013_BCC_EXPR_SEGMENT	equ	639Ah
M013_BCC_DATA_77E2	equ	77E2h
M013_BCC_DATA_8108	equ	8108h
M013_BCC_DATA_8186	equ	8186h
M013_BCC_DATA_8196	equ	8196h
M013_BCC_DATA_85EE	equ	85EEh

BCC_NEAR_43CD	proc	near
M013_L_43CD:
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		jne	short M013_L_43E1
		xor	AX,AX
		db	0E9h
		dw	00144h
M013_L_43E1:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Bh
		jne	short M013_L_4426
		mov	AL,byte ptr [BP+0Ch]
		push	AX
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr ES:[SI+0Ah]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FFCEh
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ah],AX
		mov	AL,byte ptr [BP+0Ch]
		push	AX
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr ES:[SI+0Ch]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FFB2h
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ch],AX
		db	0E9h
		dw	000FDh
M013_L_4426:
		les	BX,[BP+8]
		mov	DI,word ptr ES:[BX]
		or	DI,DI
		jne	short M013_L_4433
		db	0E9h
		dw	000C3h
M013_L_4433:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8196
		mov	AX,word ptr ES:[DI+6]
		mov	ES,word ptr [BP+0Ah]
		mov	word ptr ES:[BX],AX
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8196
		mov	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-2]
		cmp	byte ptr ES:[BX],15h
		jne	short M013_L_4470
		cmp	word ptr ES:[BX+3],1
		jne	short M013_L_446A
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	8108h
		jmp	short M013_L_446D
M013_L_446A:
		mov	AX,DGROUP:M013_BCC_DATA_77E2
M013_L_446D:
		mov	word ptr [BP-2],AX
M013_L_4470:
		push	SI
		push	word ptr [BP-2]
		db	0E8h
		dw	00196h
		or	AX,AX
		je	short M013_L_4487
		push	SI
		push	word ptr [BP-2]
		push	CS
		db	0E8h
		dw	0F8A6h
		mov	SI,AX
		jmp	short M013_L_44F0
M013_L_4487:
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8196
		cmp	word ptr ES:[DI+4],0
		je	short M013_L_44C3
		mov	word ptr DGROUP:M013_BCC_DATA_5F4E,0
		push	word ptr [BP+4]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8196
		push	word ptr ES:[DI+4]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		cmp	word ptr [BP+4],0
		je	short M013_L_44BC
		mov	AX,4Eh
		jmp	short M013_L_44E7
M013_L_44BC:
		mov	AX,50h
		jmp	short M013_L_44E7
		jmp	short M013_L_44E7
M013_L_44C3:
		mov	word ptr DGROUP:M013_BCC_DATA_5F4E,0
		push	word ptr [BP+4]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,DGROUP:M013_BCC_DATA_85EE
		cwd
		push	DX
		push	AX
		cmp	word ptr [BP+4],0
		je	short M013_L_44E4
		mov	AX,4Dh
		jmp	short M013_L_44E7
M013_L_44E4:
		mov	AX,4Fh
M013_L_44E7:
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,0Ah
M013_L_44F0:
		inc	word ptr DGROUP:M013_BCC_DATA_85EE
		jmp	short M013_L_4523
M013_L_44F6:
		cmp	byte ptr [BP+0Ch],4
		je	short M013_L_4523
		mov	word ptr DGROUP:M013_BCC_DATA_5F4E,0
		push	word ptr [BP+4]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		cmp	word ptr [BP+4],0
		je	short M013_L_4517
		mov	AX,61h
		jmp	short M013_L_451A
M013_L_4517:
		mov	AX,60h
M013_L_451A:
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
M013_L_4523:
		mov	AX,SI
M013_L_4525:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	0Ah
BCC_NEAR_43CD	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X035_01:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M014_BCC_EXPR_SEGMENT	equ	639Ah
M014_BCC_DATA_80B4	equ	80B4h
M014_BCC_DATA_8164	equ	8164h
M014_BCC_DATA_8186	equ	8186h

BCC_NEAR_452E	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M014_L_4554
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M014_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		jmp	short M014_L_455C
M014_L_4554:
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		push	word ptr ES:[SI+8]
M014_L_455C:
		db	0FFh,01Eh
		dw	8164h
		mov	DI,AX
		or	DI,DI
		jne	short M014_L_4571
		mov	AX,10Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M014_L_4571:
		push	SI
		db	09Ah
		dw	X035_01
		dw	seg X035_01
		push	AX
		xor	AX,AX
		push	AX
		push	DI
		db	0FFh,01Eh
		dw	80B4h
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_452E	endp
CO047_TEXT	ends


		extrn	X04C_0E:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M015_BCC_EXPR_SEGMENT	equ	639Ah
M015_BCC_DATA_77E2	equ	77E2h
M015_BCC_DATA_8108	equ	8108h
M015_BCC_DATA_8186	equ	8186h

BCC_NEAR_4587	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+2]
		mov	BX,DI
		shl	BX,1
		cmp	word ptr [BX+2766h],0
		je	short M015_L_45BA
		push	SI
		mov	BX,DI
		shl	BX,1
		push	word ptr [BX+2766h]
		db	0FFh,01Eh
		dw	8108h
		push	AX
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	SI,AX
		jmp	short M015_L_4604
M015_L_45BA:
		cmp	DI,15h
		jne	short M015_L_4604
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M015_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+3],1
		jne	short M015_L_45E0
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		jmp	short M015_L_45E7
M015_L_45E0:
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		mov	AX,DGROUP:M015_BCC_DATA_77E2
M015_L_45E7:
		mov	word ptr ES:[SI+8],AX
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M015_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	ES,word ptr DGROUP:M015_BCC_DATA_8186
		mov	word ptr ES:[SI+2],AX
M015_L_4604:
		mov	AX,SI
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_4587	endp
CO047_TEXT	ends


		extrn	X04F_0C:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M016_BCC_DATA_1776	equ	1776h
M016_BCC_EXPR_SEGMENT	equ	639Ah
M016_BCC_DATA_8186	equ	8186h

BCC_NEAR_460D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+8]
		cmp	AX,word ptr [BP+4]
		jne	short M016_L_4628
		db	0E9h
		dw	000FEh
M016_L_4628:
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP+4]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	SI,AX
		cmp	AX,11h
		je	short M016_L_4652
		cmp	AX,12h
		je	short M016_L_4652
		cmp	AX,13h
		je	short M016_L_4652
		jmp	short M016_L_4657
M016_L_4652:
		xor	AX,AX
		db	0E9h
		dw	000D2h
M016_L_4657:
		mov	BX,word ptr [BP-2]
		dec	BX
		cmp	BX,14h
		jbe	short M016_L_4663
		db	0E9h
		dw	000C3h
M016_L_4663:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1B82h
		mov	AL,byte ptr [SI+9CAh]
		mov	AH,0
		test	AX,14h
		jne	short M016_L_4689
		cmp	byte ptr DGROUP:M016_BCC_DATA_1776,0
		je	short M016_L_4684
		cmp	SI,8
		jg	short M016_L_4684
		db	0E9h
		dw	000A2h
M016_L_4684:
		xor	AX,AX
		db	0E9h
		dw	000A0h
M016_L_4689:
		cmp	word ptr [BP-2],0Eh
		jne	short M016_L_4699
		cmp	SI,0Dh
		jne	short M016_L_4699
		xor	AX,AX
		db	0E9h
		dw	00090h
M016_L_4699:
		cmp	word ptr [BP-2],0Dh
		jne	short M016_L_46A9
		cmp	SI,0Eh
		jne	short M016_L_46A9
		xor	AX,AX
		db	0E9h
		dw	00080h
M016_L_46A9:
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],12h
		jne	short M016_L_4726
		mov	BX,word ptr [BP+4]
		push	word ptr ES:[BX+3]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,3
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M016_L_4726
		xor	AX,AX
		jmp	short M016_L_4729
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8186
		cmp	word ptr ES:[DI],2
		jne	short M016_L_46FE
		mov	AX,word ptr ES:[DI+0Ah]
		or	AX,word ptr ES:[DI+0Ch]
		jne	short M016_L_46FE
		test	byte ptr [SI+9CAh],14h
		je	short M016_L_46FE
		jmp	short M016_L_4726
M016_L_46FE:
		cmp	byte ptr DGROUP:M016_BCC_DATA_1776,0
		je	short M016_L_4714
		cmp	word ptr [BP-2],8
		jg	short M016_L_4714
		test	byte ptr [SI+9CAh],14h
		je	short M016_L_4714
		jmp	short M016_L_4726
M016_L_4714:
		cmp	SI,0Bh
		jle	short M016_L_4726
		cmp	SI,15h
		je	short M016_L_4726
		xor	AX,AX
		jmp	short M016_L_4729
		xor	AX,AX
		jmp	short M016_L_4729
M016_L_4726:
		mov	AX,1
M016_L_4729:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_460D	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT

BCC_STMT_CONVERT_TABLE	label	word
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B31h
		dw	01B76h
		dw	01ABAh
		dw	01ABAh
		dw	01ABAh
		dw	01ABAh
		dw	01B76h
		dw	01B76h
		dw	01B72h
		dw	01B76h
		dw	01B31h

CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M018_BCC_DATA_80B8	equ	80B8h


		public	X047_0B
X047_0B	label	far
BCC_NEAR_475C	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		pop	BP
		retf
BCC_NEAR_475C	endp
CO047_TEXT	ends


		extrn	X04A_14:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M019_BCC_EXPR_SEGMENT	equ	639Ah
M019_BCC_DATA_8186	equ	8186h

BCC_NEAR_476B	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M019_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		db	09Ah
		dw	X04A_14
		dw	seg X04A_14
		mov	DI,AX
		or	DI,DI
		jne	short M019_L_4799
		xor	AX,AX
		jmp	short M019_L_47A0
M019_L_4799:
		push	SI
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00007h
M019_L_47A0:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_476B	endp
CO047_TEXT	ends


		extrn	X049_02:far
		extrn	X04C_0E:far
		extrn	X04F_11:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M01A_BCC_EXPR_SEGMENT	equ	639Ah
M01A_BCC_DATA_78A4	equ	78A4h
M01A_BCC_DATA_80B0	equ	80B0h
M01A_BCC_DATA_80B4	equ	80B4h
M01A_BCC_DATA_80B8	equ	80B8h
M01A_BCC_DATA_8108	equ	8108h
M01A_BCC_DATA_8186	equ	8186h

		public	X047_09
X047_09	label	far
BCC_NEAR_47A7	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01A_BCC_DATA_78A4
		mov	AX,word ptr ES:[DI+9]
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M01A_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-6],AX
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-6],10h
		jne	short M01A_L_47DD
		mov	word ptr [BP-6],0Fh
M01A_L_47DD:
		push	word ptr [BP-8]
		mov	AL,byte ptr [BP-6]
		push	AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01A_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		push	AX
		push	word ptr ES:[BX+5]
		mov	AL,byte ptr ES:[BX+8]
		cbw
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		mov	word ptr [BP-2],AX
		push	SI
		push	word ptr [BP-2]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	SI,AX
		mov	ES,word ptr DGROUP:M01A_BCC_DATA_78A4
		cmp	word ptr ES:[DI+4],0
		je	short M01A_L_4877
		mov	AX,5
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		mov	ES,word ptr DGROUP:M01A_BCC_DATA_78A4
		xor	AX,AX
		push	AX
		push	word ptr ES:[DI+4]
		db	0FFh,01Eh
		dw	80B4h
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-6],0Eh
		jne	short M01A_L_485E
		push	word ptr [BP-8]
		mov	AL,0Fh
		push	AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01A_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		mov	word ptr [BP-2],AX
		mov	AX,2Dh
		jmp	short M01A_L_4861
M01A_L_485E:
		mov	AX,8
M01A_L_4861:
		push	AX
		push	word ptr [BP-2]
		push	SI
		push	word ptr [BP-4]
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
M01A_L_4877:
		mov	AX,31h
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	0016Eh
		mov	SI,AX
		mov	ES,word ptr DGROUP:M01A_BCC_DATA_78A4
		cmp	byte ptr ES:[DI+7],0
		je	short M01A_L_48A5
		push	SI
		push	word ptr [BP-8]
		mov	AL,byte ptr ES:[DI+7]
		push	AX
		mov	AL,byte ptr ES:[DI+6]
		push	AX
		db	0FFh,01Eh
		dw	80B0h
		mov	SI,AX
M01A_L_48A5:
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_NEAR_47A7	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M01B_BCC_DATA_8186	equ	8186h

BCC_NEAR_48AF	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		mov	SI,word ptr ES:[DI+2]
		cmp	SI,9
		jl	short M01B_L_48CC
		cmp	byte ptr [SI+3594h],0
		jne	short M01B_L_48CE
M01B_L_48CC:
		jmp	short M01B_L_48ED
M01B_L_48CE:
		mov	AL,byte ptr [SI+3594h]
		mov	AH,0
		test	word ptr [BP+4],AX
		jne	short M01B_L_48ED
		mov	BX,SI
		shl	BX,1
		push	word ptr [BX+3598h]
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	AX,1
		jmp	short M01B_L_48EF
M01B_L_48ED:
		xor	AX,AX
M01B_L_48EF:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_48AF	endp
CO047_TEXT	ends


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M01C_BCC_EXPR_SEGMENT	equ	639Ah
M01C_BCC_STMT_RECORD_SEG	equ	63C2h
M01C_BCC_DATA_8158	equ	8158h
M01C_BCC_DATA_8186	equ	8186h


		public	X047_0D
X047_0D	label	far
BCC_NEAR_48F6	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01C_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],11h
		jne	short M01C_L_493F
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M01C_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],100h
		mov	ES,word ptr DGROUP:M01C_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M01C_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+7]
		push	SI
		mov	ES,word ptr DGROUP:M01C_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M01C_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+9]
		cbw
		push	AX
		db	0FFh,01Eh
		dw	8158h
		mov	SI,AX
M01C_L_493F:
		mov	ES,word ptr DGROUP:M01C_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],12h
		jne	short M01C_L_4958
		push	word ptr ES:[SI+8]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	8158h
		mov	SI,AX
M01C_L_4958:
		mov	AX,SI
		pop	SI
		pop	BP
		retf	2
BCC_NEAR_48F6	endp
CO047_TEXT	ends


		extrn	X04D_06:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M01D_BCC_DATA_1713	equ	1713h
M01D_BCC_STMT_RECORD_SEG	equ	63C2h
M01D_BCC_DATA_77D2	equ	77D2h
M01D_BCC_DATA_80B8	equ	80B8h
M01D_BCC_DATA_8186	equ	8186h

		public	X047_04
X047_04	label	far
BCC_NEAR_495F	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+8]
		mov	word ptr [BP-2],0
		cmp	word ptr [BP+6],0
		je	short M01D_L_497A
		mov	word ptr [BP-2],0Ah
		jmp	short M01D_L_49C4
M01D_L_497A:
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M01D_L_499B
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M01D_BCC_STMT_RECORD_SEG
		test	word ptr ES:[BX+6],10h
		je	short M01D_L_499B
		mov	word ptr [BP-2],9
		jmp	short M01D_L_49C4
M01D_L_499B:
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],5
		je	short M01D_L_49B1
		cmp	word ptr ES:[SI],6
		je	short M01D_L_49B1
		cmp	word ptr ES:[SI],7
		jne	short M01D_L_49C4
M01D_L_49B1:
		cmp	byte ptr DGROUP:M01D_BCC_DATA_77D2,0
		jne	short M01D_L_49C4
		cmp	byte ptr DGROUP:M01D_BCC_DATA_1713,0
		je	short M01D_L_49C4
		mov	word ptr [BP-2],3
M01D_L_49C4:
		mov	AX,32h
		push	AX
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		mov	AL,byte ptr ES:[SI+4]
		and	AL,3
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,byte ptr [BP-2]
		push	AX
		db	09Ah
		dw	X04D_06
		dw	seg X04D_06
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_NEAR_495F	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_5BED:far
		extrn	X049_02:far
		extrn	X04C_05:far
		extrn	X04C_0E:far
		extrn	X04F_11:far
		extrn	X04F_0C:far
		extrn	X057_01:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M01E_BCC_DATA_3F80	equ	3F80h
M01E_BCC_EXPR_SEGMENT	equ	639Ah
M01E_BCC_STMT_RECORD_SEG	equ	63C2h
M01E_BCC_DATA_77E2	equ	77E2h
M01E_BCC_DATA_80B4	equ	80B4h
M01E_BCC_DATA_80B8	equ	80B8h
M01E_BCC_DATA_8108	equ	8108h
M01E_BCC_DATA_812C	equ	812Ch
M01E_BCC_DATA_8158	equ	8158h
M01E_BCC_DATA_8186	equ	8186h

		public	X047_03
X047_03	label	far
BCC_NEAR_49F2	proc	far
M01E_L_49F2:
		push	BP
		mov	BP,SP
		sub	SP,0Eh
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M01E_L_4A10
		mov	AX,SI
		db	0E9h
		dw	00BC7h
M01E_L_4A10:
		or	DI,DI
		je	short M01E_L_4A24
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0
		jne	short M01E_L_4A24
		mov	AX,DI
		db	0E9h
		dw	00BB3h
M01E_L_4A24:
		or	DI,DI
		jne	short M01E_L_4A2A
		mov	DI,SI
M01E_L_4A2A:
		mov	word ptr [BP-2],SI
		cmp	word ptr [BP+0Ah],8
		jl	short M01E_L_4A39
		cmp	word ptr [BP+0Ah],33h
		jle	short M01E_L_4A40
M01E_L_4A39:
		mov	word ptr [BP-8],0
		jmp	short M01E_L_4A4C
M01E_L_4A40:
		mov	BX,word ptr [BP+0Ah]
		shl	BX,1
		mov	AX,word ptr [BX+3535h]
		mov	word ptr [BP-8],AX
M01E_L_4A4C:
		test	word ptr [BP-8],8000h
		je	short M01E_L_4AAE
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00E75h
		or	AX,AX
		jne	short M01E_L_4A6F
		mov	AX,3Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0FCF0h
		db	0E9h
		dw	00B68h
M01E_L_4A6F:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		test	word ptr ES:[SI+4],1
		jne	short M01E_L_4A9C
		cmp	word ptr ES:[SI+2],13h
		je	short M01E_L_4A89
		cmp	word ptr ES:[SI+2],14h
		jne	short M01E_L_4AAE
M01E_L_4A89:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		mov	AX,1
		push	AX
		db	0E8h
		dw	00ECAh
		or	AX,AX
		je	short M01E_L_4AAE
M01E_L_4A9C:
		mov	AX,1Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0FCB1h
		db	0E9h
		dw	00B29h
M01E_L_4AAE:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_4AC8
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_4ACD
M01E_L_4AC8:
		db	81h,66h,0F8h,0EFh,0FFh
M01E_L_4ACD:
		push	SI
		push	word ptr [BP-8]
		db	0E8h
		dw	0FDDBh
		or	AX,AX
		jne	short M01E_L_4AE3
		push	DI
		push	word ptr [BP-8]
		db	0E8h
		dw	0FDD0h
		or	AX,AX
		je	short M01E_L_4AEA
M01E_L_4AE3:
		push	CS
		db	0E8h
		dw	0FC75h
		db	0E9h
		dw	00AEDh
M01E_L_4AEA:
		mov	BX,word ptr [BP+0Ah]
		sub	BX,8
		cmp	BX,2Ah
		jbe	short M01E_L_4AF8
		db	0E9h
		dw	00927h
M01E_L_4AF8:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	2A2Fh
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		test	AX,14h
		jne	short M01E_L_4B24
		mov	AX,12h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0FC3Bh
		db	0E9h
		dw	00AB3h
M01E_L_4B24:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-6],AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+5],0
		je	short M01E_L_4B50
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00E5Ch
		mov	SI,AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-6],AX
M01E_L_4B50:
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+3]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-4]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M01E_L_4B79
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0FBE6h
		db	0E9h
		dw	00A5Eh
M01E_L_4B79:
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-4]
		cmp	byte ptr ES:[BX],11h
		jne	short M01E_L_4BE5
		mov	AX,31h
		push	AX
		push	word ptr [BP-4]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[SI+4],AX
		mov	AX,32h
		push	AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+7]
		mov	BX,word ptr [BP-6]
		mov	AL,byte ptr ES:[BX]
		push	AX
		mov	AL,byte ptr ES:[BX+7]
		cbw
		push	AX
		push	word ptr ES:[BX+5]
		mov	AL,byte ptr ES:[BX+8]
		cbw
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		db	0E9h
		dw	000C8h
M01E_L_4BE5:
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-4]
		cmp	byte ptr ES:[BX],12h
		jne	short M01E_L_4C2C
		mov	AX,31h
		push	AX
		push	word ptr [BP-4]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[SI+4],AX
		mov	AX,32h
		push	AX
		push	word ptr [BP-6]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		db	0E9h
		dw	00081h
M01E_L_4C2C:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],32h
		jne	short M01E_L_4C85
		push	word ptr ES:[SI+0Ah]
		db	09Ah
		dw	X04C_05
		dw	seg X04C_05
		or	AX,AX
		je	short M01E_L_4C85
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	SI,word ptr ES:[SI+0Ah]
		mov	AX,word ptr [BP-4]
		mov	word ptr ES:[SI+8],AX
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[SI+2],AX
		db	26h,81h,64h,04h,0FCh,0FFh
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		or	word ptr ES:[SI+4],AX
		mov	AX,SI
		db	0E9h
		dw	00952h
M01E_L_4C85:
		push	word ptr [BP+0Ah]
		push	word ptr [BP-4]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+4],AX
M01E_L_4CAD:
		db	0E9h
		dw	00924h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],32h
		jne	short M01E_L_4D21
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+3]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	AX,word ptr ES:[BX+8]
		je	short M01E_L_4D11
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+8]
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		push	AX
		push	word ptr ES:[BX+5]
		mov	AL,byte ptr ES:[BX+8]
		cbw
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[SI+8],AX
		mov	AX,SI
		db	0E9h
		dw	008C6h
M01E_L_4D11:
		mov	AX,162h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		mov	AX,SI
		db	0E9h
		dw	008B6h
M01E_L_4D21:
		push	SI
		db	0E8h
		dw	00910h
		or	AX,AX
		jne	short M01E_L_4D3D
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],33h
		je	short M01E_L_4D3D
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00B95h
		or	AX,AX
		jne	short M01E_L_4D4F
M01E_L_4D3D:
		mov	AX,0E7h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0FA10h
		db	0E9h
		dw	00888h
M01E_L_4D4F:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],31h
		jne	short M01E_L_4DB7
		mov	AX,word ptr ES:[SI+0Ah]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX+8]
		mov	word ptr [BP-4],AX
		push	word ptr ES:[SI+8]
		mov	AL,byte ptr ES:[BX+2]
		push	AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX+7]
		cbw
		push	AX
		push	word ptr ES:[BX+5]
		mov	AL,byte ptr ES:[BX+8]
		cbw
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+8],AX
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+2],AX
		db	0E9h
		dw	0081Dh
M01E_L_4DB7:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],25h
		jne	short M01E_L_4E2B
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-0Ch],AX
		mov	AX,32h
		push	AX
		mov	BX,word ptr [BP-0Ch]
		push	word ptr ES:[BX+0Ah]
		xor	AX,AX
		push	AX
		push	CS
		db	0E8h
		dw	0FC18h
		mov	BX,word ptr [BP-0Ch]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+0Ah],AX
		mov	word ptr [BP-0Eh],AX
		mov	AX,32h
		push	AX
		push	word ptr ES:[BX+0Ch]
		xor	AX,AX
		push	AX
		push	CS
		db	0E8h
		dw	0FBFBh
		mov	BX,word ptr [BP-0Ch]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+0Ch],AX
		mov	BX,word ptr [BP-0Eh]
		mov	AX,word ptr ES:[BX+2]
		mov	BX,word ptr [BP-0Ch]
		mov	word ptr ES:[BX+2],AX
		mov	word ptr ES:[SI+2],AX
		mov	BX,word ptr [BP-0Eh]
		mov	AX,word ptr ES:[BX+8]
		mov	BX,word ptr [BP-0Ch]
		mov	word ptr ES:[BX+8],AX
		mov	word ptr ES:[SI+8],AX
		mov	AX,SI
		db	0E9h
		dw	007ACh
M01E_L_4E2B:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		je	short M01E_L_4E3B
		cmp	word ptr ES:[SI],5
		jne	short M01E_L_4E4D
M01E_L_4E3B:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M01E_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],100h
M01E_L_4E4D:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	8158h
		db	0E9h
		dw	00777h
		push	SI
		db	0E8h
		dw	0F723h
		mov	SI,AX
		mov	AX,30h
		push	AX
		push	word ptr DGROUP:M01E_BCC_DATA_77E2
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	0075Eh
		push	SI
		db	0E8h
		dw	0F70Ah
		mov	SI,AX
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	00742h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_4EAA
		push	SI
		db	0E8h
		dw	0F686h
		jmp	short M01E_L_4EC6
M01E_L_4EAA:
		push	word ptr DGROUP:M01E_BCC_DATA_77E2
		xor	AX,AX
		mov	DX,1
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		push	AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	CS
		db	0E8h
		dw	0EE63h
M01E_L_4EC6:
		mov	word ptr [BP-2],AX
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		push	word ptr [BP-2]
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	006F8h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_4EF1
		db	0E9h
		dw	001DBh
M01E_L_4EF1:
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-4],AX
		cmp	word ptr ES:[SI+2],0Eh
		je	short M01E_L_4F02
		db	0E9h
		dw	000D2h
M01E_L_4F02:
		cmp	word ptr ES:[DI+2],0Eh
		je	short M01E_L_4F10
		cmp	word ptr ES:[DI+2],0Fh
		jne	short M01E_L_4F22
M01E_L_4F10:
		mov	AX,52h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F83Dh
		db	0E9h
		dw	006B5h
M01E_L_4F22:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0Dh
		je	short M01E_L_4F36
		push	DI
		push	SI
		db	0E8h
		dw	0ED20h
		mov	DI,AX
		jmp	short M01E_L_4F92
M01E_L_4F36:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		je	short M01E_L_4F92
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		je	short M01E_L_4F92
		mov	BX,word ptr [BP-4]
		push	word ptr ES:[BX+3]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M01E_L_4F92
		mov	AX,13h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F7CDh
		db	0E9h
		dw	00645h
M01E_L_4F92:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M01E_L_4FAE
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+8]
		mov	word ptr [BP-4],AX
M01E_L_4FAE:
		mov	AX,2Dh
		push	AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,0Fh
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	00603h
M01E_L_4FD4:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0Eh
		je	short M01E_L_4FE2
		db	0E9h
		dw	000B7h
M01E_L_4FE2:
		cmp	word ptr ES:[SI+2],0Fh
		jne	short M01E_L_4FFB
		mov	AX,52h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F764h
		db	0E9h
		dw	005DCh
M01E_L_4FFB:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		je	short M01E_L_5057
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		je	short M01E_L_5057
		mov	BX,word ptr [BP-4]
		push	word ptr ES:[BX+3]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,0
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M01E_L_5057
		mov	AX,13h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F708h
		db	0E9h
		dw	00580h
M01E_L_5057:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[BX+3]
		cmp	byte ptr ES:[BX],0Ch
		jne	short M01E_L_5073
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+8]
		mov	word ptr [BP-4],AX
M01E_L_5073:
		mov	AX,2Dh
		push	AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,0Fh
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	DI
		push	SI
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	0053Eh
M01E_L_5099:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_50BA
		mov	AX,52h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F6A5h
		db	0E9h
		dw	0051Dh
M01E_L_50BA:
		push	DI
		push	SI
		db	0E8h
		dw	0EB93h
		mov	DI,AX
		mov	AX,8
		push	AX
		push	word ptr [BP-4]
		push	SI
		push	DI
		jmp	short M01E_L_512C
M01E_L_50CC:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_50DE
		db	0E9h
		dw	00341h
M01E_L_50DE:
		cmp	word ptr ES:[DI+2],0Eh
		jne	short M01E_L_5117
		push	SI
		push	DI
		db	0E8h
		dw	0EB68h
		mov	SI,AX
		mov	AX,2Dh
		push	AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+8]
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+3]
		mov	AL,0Fh
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		push	AX
		push	DI
		push	SI
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	004C0h
M01E_L_5117:
		push	SI
		push	DI
		db	0E8h
		dw	0EB36h
		mov	SI,AX
		mov	AX,8
		push	AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		push	DI
		push	SI
M01E_L_512C:
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		db	0E9h
		dw	0049Eh
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_517D
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_5162
		mov	AX,52h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F5FDh
		db	0E9h
		dw	00475h
M01E_L_5162:
		push	DI
		push	SI
		db	0E8h
		dw	0EAEBh
		mov	DI,AX
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	0045Ah
M01E_L_517D:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_518F
		db	0E9h
		dw	00290h
M01E_L_518F:
		mov	AX,13h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F5BEh
		db	0E9h
		dw	00436h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_51B3
		db	0E9h
		dw	000F2h
M01E_L_51B3:
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_51C1
		db	0E9h
		dw	000C6h
M01E_L_51C1:
		cmp	word ptr [BP+0Ah],14h
		jne	short M01E_L_51D9
		mov	AX,53h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F586h
		db	0E9h
		dw	003FEh
M01E_L_51D9:
		push	DI
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	CS
		db	0E8h
		dw	0EB43h
		mov	DI,AX
		push	SI
		db	0E8h
		dw	0F342h
		mov	word ptr [BP-0Eh],AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0Fh
		je	short M01E_L_5201
		cmp	word ptr ES:[DI+2],10h
		jne	short M01E_L_5206
M01E_L_5201:
		mov	AX,7
		jmp	short M01E_L_5209
M01E_L_5206:
		mov	AX,5
M01E_L_5209:
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M01E_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-4]
		cmp	byte ptr ES:[BX],7
		jne	short M01E_L_524A
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0Fh
		jne	short M01E_L_524A
		mov	AX,6
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	word ptr [BP-0Ch],AX
		push	SI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	SI,AX
		push	DI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	DI,AX
M01E_L_524A:
		mov	AX,2Ch
		push	AX
		push	word ptr [BP-4]
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-4]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	word ptr [BP-0Eh],AX
		mov	AX,0Bh
		push	AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[BX+8]
		push	word ptr [BP-2]
		push	word ptr [BP-0Eh]
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		db	0E9h
		dw	0034Dh
M01E_L_5287:
		push	DI
		push	SI
		db	0E8h
		dw	0E9C6h
		mov	DI,AX
		push	word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		db	0E9h
		dw	0032Fh
M01E_L_52A5:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		jne	short M01E_L_52B7
		db	0E9h
		dw	00168h
M01E_L_52B7:
		mov	AX,53h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F496h
		db	0E9h
		dw	0030Eh
		db	0E9h
		dw	00308h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],2
		je	short M01E_L_52DE
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00393h
		mov	SI,AX
M01E_L_52DE:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI],26h
		je	short M01E_L_52F3
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M01E_L_52F3:
		mov	AX,25h
		push	AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		db	0E9h
		dw	002C9h
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],13h
		je	short M01E_L_5317
		cmp	word ptr ES:[DI+2],13h
		je	short M01E_L_5317
		db	0E9h
		dw	00108h
M01E_L_5317:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	word ptr ES:[DI+8]
		mov	AL,1
		push	AX
		db	09Ah
		dw	X04F_0C
		dw	seg X04F_0C
		or	AX,AX
		jne	short M01E_L_5341
		mov	AX,54h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		push	CS
		db	0E8h
		dw	0F41Eh
		db	0E9h
		dw	00296h
M01E_L_5341:
		mov	AX,12h
		push	AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		db	0E9h
		dw	0027Bh
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		test	AX,14h
		jne	short M01E_L_53BB
		mov	BX,word ptr ES:[DI+2]
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		test	AX,14h
		jne	short M01E_L_53BB
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	DI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	DI,AX
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[DI],2
		je	short M01E_L_53A3
		mov	BX,word ptr [BP-2]
		push	word ptr ES:[BX]
		db	09Ah
		dw	X057_01
		dw	seg X057_01
		push	AX
		push	SI
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[DI+2]
		jmp	short M01E_L_53B8
M01E_L_53A3:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		cmp	word ptr ES:[SI],2
		je	short M01E_L_53BB
		mov	BX,word ptr [BP-2]
		push	word ptr ES:[BX]
		push	DI
		push	word ptr ES:[SI+2]
M01E_L_53B8:
		db	0E8h
		dw	00317h
M01E_L_53BB:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_541F
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_541F
		cmp	word ptr ES:[DI+2],0Fh
		jne	short M01E_L_53EF
		cmp	word ptr ES:[SI+2],0Fh
		je	short M01E_L_53EF
		push	SI
		push	word ptr ES:[DI+8]
		db	0E8h
		dw	00481h
		mov	SI,AX
		jmp	short M01E_L_541F
M01E_L_53EF:
		push	DI
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	00471h
		mov	DI,AX
		jmp	short M01E_L_541F
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0026Ah
		mov	SI,AX
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00262h
		mov	DI,AX
		push	word ptr [BP+0Ah]
		push	word ptr DGROUP:M01E_BCC_DATA_77E2
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		db	0E9h
		dw	001B8h
M01E_L_541F:
		test	word ptr [BP-8],2000h
		je	short M01E_L_5432
		push	DI
		db	0E8h
		dw	0F15Dh
		mov	DI,AX
		push	SI
		db	0E8h
		dw	0F157h
		mov	SI,AX
M01E_L_5432:
		mov	AX,word ptr [BP-8]
		and	AX,3
		mov	word ptr [BP-0Ah],AX
		cmp	word ptr [BP-0Ah],3
		jne	short M01E_L_5455
		push	DI
		mov	AX,2
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	DI,AX
		db	0E9h
		dw	00159h
M01E_L_5455:
		cmp	word ptr [BP-0Ah],1
		je	short M01E_L_545E
		db	0E9h
		dw	000ADh
M01E_L_545E:
		cmp	word ptr [BP+0Ah],13h
		jge	short M01E_L_5467
		db	0E9h
		dw	00092h
M01E_L_5467:
		cmp	word ptr [BP+0Ah],17h
		jle	short M01E_L_5470
		db	0E9h
		dw	00089h
M01E_L_5470:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		shl	BX,1
		shl	BX,1
		mov	AL,byte ptr [BX+3928h]
		mov	BX,word ptr ES:[SI+2]
		shl	BX,1
		shl	BX,1
		cmp	AL,byte ptr [BX+3928h]
		jle	short M01E_L_54F9
		push	word ptr [BP+0Ah]
		push	word ptr ES:[DI+8]
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
		push	word ptr [BP-2]
		db	0FFh,01Eh
		dw	812Ch
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-0Ch],AX
		mov	BX,word ptr [BP-0Ch]
		push	word ptr ES:[BX+0Ah]
		push	word ptr ES:[DI+8]
		push	CS
		db	0E8h
		dw	0E864h
		mov	BX,word ptr [BP-0Ch]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+0Ah],AX
		push	word ptr [BP-0Ch]
		push	word ptr ES:[SI+8]
		push	CS
		db	0E8h
		dw	0E84Eh
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	word ptr ES:[BX+0Ch],AX
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr ES:[BX+2],AX
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr ES:[BX+8],AX
		db	0E9h
		dw	000DBh
M01E_L_54F9:
		push	DI
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		push	CS
		db	0E8h
		dw	0E823h
		mov	DI,AX
		db	0E9h
		dw	00083h
M01E_L_550B:
		cmp	word ptr [BP-0Ah],2
		jne	short M01E_L_551D
		push	DI
		mov	AX,2
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		jmp	short M01E_L_5588
M01E_L_551D:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_5548
		cmp	word ptr ES:[DI],2
		jne	short M01E_L_5548
		mov	AX,word ptr ES:[DI+0Ah]
		or	AX,word ptr ES:[DI+0Ch]
		jne	short M01E_L_5548
		push	DI
		push	word ptr ES:[SI+8]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		jmp	short M01E_L_558C
M01E_L_5548:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		test	byte ptr [BX+9CAh],14h
		je	short M01E_L_5575
		cmp	word ptr ES:[SI],2
		jne	short M01E_L_5575
		mov	AX,word ptr ES:[SI+0Ah]
		or	AX,word ptr ES:[SI+0Ch]
		jne	short M01E_L_5575
		push	SI
		push	word ptr ES:[DI+8]
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		mov	SI,AX
		jmp	short M01E_L_558E
M01E_L_5575:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+2]
		cmp	AX,word ptr ES:[SI+2]
		jge	short M01E_L_558E
		push	DI
		push	word ptr ES:[SI+8]
M01E_L_5588:
		push	CS
		db	0E8h
		dw	0E79Dh
M01E_L_558C:
		mov	DI,AX
M01E_L_558E:
		test	word ptr [BP-8],4
		jne	short M01E_L_55AE
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr ES:[DI+2]
		jge	short M01E_L_55AE
		push	SI
		push	word ptr ES:[DI+8]
		push	CS
		db	0E8h
		dw	0E77Dh
		mov	SI,AX
M01E_L_55AE:
		test	word ptr [BP-8],8
		je	short M01E_L_55BA
		mov	AX,DGROUP:M01E_BCC_DATA_77E2
		jmp	short M01E_L_55C2
M01E_L_55BA:
		mov	ES,word ptr DGROUP:M01E_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+8]
M01E_L_55C2:
		mov	word ptr [BP-4],AX
		push	word ptr [BP+0Ah]
		push	word ptr [BP-4]
M01E_L_55CB:
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-2],AX
M01E_L_55D4:
		mov	AX,word ptr [BP-2]
M01E_L_55D7:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
BCC_NEAR_49F2	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT

BCC_STMT_BINARY_JUMP_TABLE	label	word
		dw	0232Fh
		dw	025F1h
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	02752h
		dw	02586h
		dw	025F1h
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	027A0h
		dw	027A0h
		dw	027A0h
		dw	027A0h
		dw	027A0h
		dw	027A0h
		dw	022E5h
		dw	022E5h
		dw	0271Ch
		dw	0286Fh
		dw	0284Fh
		dw	0284Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	0286Fh
		dw	022C9h
		dw	022C9h
		dw	022B0h
		dw	01F4Fh
		dw	02100h

CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M020_BCC_STMT_RECORD_SEG	equ	63C2h
M020_BCC_DATA_8186	equ	8186h


BCC_NEAR_5635	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M020_BCC_DATA_8186
		cmp	word ptr ES:[SI],5
		jne	short M020_L_5658
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M020_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[BX+6]
		and	AX,8
		jmp	short M020_L_5669
M020_L_5658:
		mov	ES,word ptr DGROUP:M020_BCC_DATA_8186
		cmp	word ptr ES:[SI],4
		jne	short M020_L_5667
		mov	AX,1
		jmp	short M020_L_5669
M020_L_5667:
		xor	AX,AX
M020_L_5669:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_5635	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5BED:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M021_BCC_DATA_77E2	equ	77E2h
M021_BCC_DATA_80B4	equ	80B4h
M021_BCC_DATA_8186	equ	8186h

		public	X047_0A
X047_0A	label	far
BCC_NEAR_566F	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8186
		cmp	word ptr ES:[SI],12h
		jne	short M021_L_568B
		mov	AX,16Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M021_L_568B:
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8186
		cmp	word ptr ES:[SI],1Dh
		jl	short M021_L_569B
		cmp	word ptr ES:[SI],22h
		jle	short M021_L_56B1
M021_L_569B:
		mov	ES,word ptr DGROUP:M021_BCC_DATA_8186
		cmp	word ptr ES:[SI],27h
		je	short M021_L_56B1
		cmp	word ptr ES:[SI],28h
		je	short M021_L_56B1
		cmp	word ptr ES:[SI],30h
		jne	short M021_L_56B5
M021_L_56B1:
		mov	AX,SI
		jmp	short M021_L_56CD
M021_L_56B5:
		mov	AX,1Eh
		push	AX
		push	SI
		push	word ptr DGROUP:M021_BCC_DATA_77E2
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		push	AX
		push	CS
		db	0E8h
		dw	0F325h
M021_L_56CD:
		pop	SI
		pop	BP
		retf	2
BCC_NEAR_566F	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5BED:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M022_BCC_DATA_80F0	equ	80F0h
M022_BCC_DATA_8186	equ	8186h

BCC_NEAR_56D2	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		cmp	word ptr ES:[SI],2
		je	short M022_L_56EB
		db	0E9h
		dw	0017Ah
M022_L_56EB:
		cmp	DI,7
		jl	short M022_L_56F3
		db	0E9h
		dw	00172h
M022_L_56F3:
		test	byte ptr [DI+9CAh],20h
		jne	short M022_L_56FD
		db	0E9h
		dw	0008Fh
M022_L_56FD:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Eh]
		jc	short M022_L_572D
		ja	short M022_L_571F
		cmp	DX,word ptr [BX+397Ch]
		jbe	short M022_L_572D
M022_L_571F:
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	00138h
M022_L_572D:
		cmp	word ptr [BP+8],21h
		jne	short M022_L_574F
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ah]
		or	AX,word ptr ES:[SI+0Ch]
		jne	short M022_L_574F
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	00116h
M022_L_574F:
		cmp	word ptr [BP+8],22h
		je	short M022_L_5758
		db	0E9h
		dw	000ECh
M022_L_5758:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Eh]
		je	short M022_L_5775
		db	0E9h
		dw	000CFh
M022_L_5775:
		cmp	DX,word ptr [BX+397Ch]
		je	short M022_L_577E
		db	0E9h
		dw	000C6h
M022_L_577E:
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	000D9h
M022_L_578C:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Ah]
		jl	short M022_L_57D0
		jne	short M022_L_57AE
		cmp	DX,word ptr [BX+3978h]
		jc	short M022_L_57D0
M022_L_57AE:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Eh]
		jl	short M022_L_57DE
		jg	short M022_L_57D0
		cmp	DX,word ptr [BX+397Ch]
		jbe	short M022_L_57DE
M022_L_57D0:
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		db	0E9h
		dw	00087h
M022_L_57DE:
		cmp	word ptr [BP+8],21h
		jne	short M022_L_5811
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Ah]
		jne	short M022_L_5811
		cmp	DX,word ptr [BX+3978h]
		jne	short M022_L_5811
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M022_L_5865
M022_L_5811:
		cmp	word ptr [BP+8],22h
		jne	short M022_L_5844
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,word ptr ES:[SI+0Ah]
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		shl	BX,1
		cmp	AX,word ptr [BX+397Eh]
		jne	short M022_L_5844
		cmp	DX,word ptr [BX+397Ch]
		jne	short M022_L_5844
		mov	AX,16Ch
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M022_L_5865
M022_L_5844:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	word ptr ES:[SI+0Ah]
		push	DI
		db	0FFh,01Eh
		dw	80F0h
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ch],DX
		mov	word ptr ES:[SI+0Ah],AX
		mov	word ptr ES:[SI+2],DI
M022_L_5865:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_56D2	endp
CO047_TEXT	ends


		extrn	BCC_FAR_5BED:far
		extrn	X04C_0E:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M023_BCC_EXPR_SEGMENT	equ	639Ah
M023_BCC_DATA_8186	equ	8186h

BCC_NEAR_586C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M023_BCC_DATA_8186
		mov	DI,word ptr ES:[BX+8]
		push	DI
		push	SI
		mov	AX,3
		push	AX
		db	0E8h
		dw	0E75Ah
		or	AX,AX
		jne	short M023_L_58BE
		mov	ES,word ptr DGROUP:M023_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[DI+3]
		cmp	byte ptr ES:[BX],2
		ja	short M023_L_58B3
		mov	BX,word ptr ES:[SI+3]
		cmp	byte ptr ES:[BX],2
		ja	short M023_L_58B3
		push	DI
		push	SI
		db	0E8h
		dw	0E78Bh
		or	AX,AX
		je	short M023_L_58B3
		mov	AX,17Bh
		jmp	short M023_L_58B6
M023_L_58B3:
		mov	AX,175h
M023_L_58B6:
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M023_L_58BE:
		push	word ptr [BP+6]
		push	SI
		db	09Ah
		dw	X04C_0E
		dw	seg X04C_0E
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_586C	endp
CO047_TEXT	ends


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M024_BCC_DATA_8186	equ	8186h


		public	X047_05
X047_05	label	far
BCC_NEAR_58CE	label	near
BCC_FAR_58CE	proc	far
M024_L_58CE:
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M024_BCC_DATA_8186
		mov	BX,word ptr ES:[SI]
		cmp	BX,7
		je	short M024_L_593C
		jg	short M024_L_58F1
		dec	BX
		cmp	BX,5
		ja	short M024_L_594E
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	2DA6h
M024_L_58F1:
		cmp	BX,25h
		je	short M024_L_5902
		cmp	BX,31h
		je	short M024_L_593C
		cmp	BX,33h
		je	short M024_L_593C
		jmp	short M024_L_594E
M024_L_5902:
		mov	ES,word ptr DGROUP:M024_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],13h
		je	short M024_L_590F
		jmp	short M024_L_594E
M024_L_590F:
		mov	ES,word ptr DGROUP:M024_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+0Ch]
		push	word ptr ES:[DI+0Ah]
		push	CS
		db	0E8h
		dw	0FFAFh
		or	AX,AX
		je	short M024_L_5938
		mov	ES,word ptr DGROUP:M024_BCC_DATA_8186
		push	word ptr ES:[DI+0Ch]
		push	CS
		db	0E8h
		dw	0FF9Fh
		or	AX,AX
		je	short M024_L_5938
		mov	AX,1
		jmp	short M024_L_593A
M024_L_5938:
		xor	AX,AX
M024_L_593A:
		jmp	short M024_L_5950
M024_L_593C:
		mov	ES,word ptr DGROUP:M024_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],11h
		jne	short M024_L_5949
		jmp	short M024_L_594E
M024_L_5949:
		mov	AX,1
		jmp	short M024_L_5950
M024_L_594E:
		xor	AX,AX
M024_L_5950:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_58CE	endp
CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT

BCC_TABLE_5956	label	word
		dw	02D8Ch
		dw	02D9Eh
		dw	02D9Eh
		dw	02D8Ch
		dw	02D8Ch
		dw	02D8Ch

CO047_TEXT	ends

CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M026_BCC_EXPR_SEGMENT	equ	639Ah
M026_BCC_DATA_78A4	equ	78A4h


BCC_NEAR_5962	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M026_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M026_L_5992
M026_L_5978:
		mov	ES,word ptr DGROUP:M026_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+8]
		mov	AH,0
		db	085h,0C7h
		je	short M026_L_598B
		mov	AX,1
		jmp	short M026_L_5998
M026_L_598B:
		mov	ES,word ptr DGROUP:M026_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M026_L_5992:
		or	SI,SI
		jne	short M026_L_5978
		xor	AX,AX
M026_L_5998:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_5962	endp
CO047_TEXT	ends


		extrn	BCC_FAR_0402:far
		extrn	X031_09:far
		extrn	X032_03:far
		extrn	X032_06:far
		extrn	X046_09:far


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M027_BCC_EXPR_SEGMENT	equ	639Ah
M027_BCC_TOKEN_SAVED	equ	77FDh
M027_BCC_DATA_8186	equ	8186h
M027_BCC_STMT_TYPE_CURRENT	equ	8260h

		public	X047_08
X047_08	label	far
BCC_NEAR_599F	label	near
BCC_FAR_599F	proc	far
		push	BP
		mov	BP,SP
		sub	SP,14h
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		lea	AX,[BP-14h]
		push	SS
		push	AX
		mov	AX,8260h
		push	DS
		push	AX
		mov	CX,13h
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	AX,789Ch
		push	AX
		mov	ES,word ptr DGROUP:M027_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M027_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+5]
		db	09Ah
		dw	X032_06
		dw	seg X032_06
		cmp	byte ptr DGROUP:M027_BCC_TOKEN_SAVED,0
		je	short M027_L_59E6
		mov	byte ptr DGROUP:M027_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M027_BCC_STMT_TYPE_CURRENT
		jmp	short M027_L_59EB
M027_L_59E6:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M027_L_59EB:
		xor	AX,AX
		push	AX
		push	AX
		push	CS
		db	0E8h
		dw	0D1BDh
		mov	DI,AX
		or	DI,DI
		jne	short M027_L_59FD
		mov	AX,SI
		jmp	short M027_L_5A3F
M027_L_59FD:
		cmp	word ptr DGROUP:M027_BCC_STMT_TYPE_CURRENT,7
		je	short M027_L_5A1A
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,2Bh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		mov	AX,SI
		jmp	short M027_L_5A3F
M027_L_5A1A:
		mov	AX,1
		push	AX
		db	09Ah
		dw	X032_03
		dw	seg X032_03
		mov	AX,8260h
		push	DS
		push	AX
		lea	AX,[BP-14h]
		push	SS
		push	AX
		mov	CX,13h
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	AX,8
		push	AX
		push	DI
		push	SI
		push	CS
		db	0E8h
		dw	0EFB3h
M027_L_5A3F:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_599F	endp
CO047_TEXT	ends


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M028_BCC_DATA_8186	equ	8186h


		public	X047_00
X047_00	label	far
BCC_FAR_5A47	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M028_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M028_L_5A65
		test	word ptr ES:[SI+4],4
		jne	short M028_L_5A65
		mov	AX,1
		jmp	short M028_L_5A67
M028_L_5A65:
		xor	AX,AX
M028_L_5A67:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_5A47	endp
CO047_TEXT	ends


CO047_TEXT	segment byte public 'CODE'
		assume	cs:CO047_TEXT,ds:DGROUP

M029_BCC_DATA_781F	equ	781Fh


		public	X047_07
X047_07	label	far
BCC_FAR_5A6C	proc	far
		push	BP
		mov	BP,SP
		mov	AX,word ptr [BP+6]
		cmp	AX,word ptr DGROUP:M029_BCC_DATA_781F
		jne	short M029_L_5A7D
		mov	AX,1
		jmp	short M029_L_5A7F
M029_L_5A7D:
		xor	AX,AX
M029_L_5A7F:
		pop	BP
		retf	2
BCC_FAR_5A6C	endp
CO047_TEXT	ends

; END C119UNIT
		end
