		public	X073_01
		public	X073_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dd0_b1e7
; BEGIN C223UNIT (listing ovr_1dd0_b1e7:1E70)

CO073_TEXT	segment byte public 'CODE'
		assume	cs:CO073_TEXT,ds:DGROUP

M000_BCC_DATA_8186	equ	8186h


		public	X073_00
X073_00	label	far
STAOV160	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	SI,word ptr ES:[DI]
		mov	AX,word ptr ES:[DI+2]
		mov	CX,AX
		cmp	SI,7
		jle	short M000_L_1E8F
		cmp	SI,31h
		jne	short M000_L_1E9D
M000_L_1E8F:
		mov	AL,byte ptr [SI+4FE9h]
		mov	AH,0
		mov	BX,CX
		mov	DL,byte ptr [BX+5020h]
		jmp	short M000_L_1EA9
M000_L_1E9D:
		mov	AL,byte ptr [SI+4FE9h]
		mov	AH,0
		mov	BX,CX
		mov	DL,byte ptr [BX+5036h]
M000_L_1EA9:
		mov	DH,0
		add	AX,DX
		pop	DI
		pop	SI
		pop	BP
		retf	2
STAOV160	endp
CO073_TEXT	ends


CO073_TEXT	segment byte public 'CODE'
		assume	cs:CO073_TEXT,ds:DGROUP

M001_BCC_DATA_866E	equ	866Eh
M001_BCC_DATA_8680	equ	8680h
M001_BCC_DATA_8698	equ	8698h


		public	X073_01
X073_01	label	far
STAOV161	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		mov	CX,word ptr [BP+6]
		cmp	DI,0Ah
		je	short M001_L_1EC8
		mov	AX,DI
		db	0E9h
		dw	000A5h
M001_L_1EC8:
		or	CX,CX
		jne	short M001_L_1ECF
		db	0E9h
		dw	0009Bh
M001_L_1ECF:
		mov	AX,CX
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		cmp	byte ptr ES:[SI],10h
		jne	short M001_L_1F15
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M001_L_1F15
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_866E
		mov	AL,byte ptr ES:[BX+7]
		mov	DL,AL
		cmp	DL,8
		je	short M001_L_1F0E
		cmp	DL,9
		jne	short M001_L_1F13
M001_L_1F0E:
		mov	AX,0Dh
		jmp	short M001_L_1F6D
M001_L_1F13:
		jmp	short M001_L_1F6A
M001_L_1F15:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		cmp	byte ptr ES:[SI],8
		jne	short M001_L_1F37
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		mov	DL,AL
		cmp	DL,8
		je	short M001_L_1F32
		cmp	DL,9
		jne	short M001_L_1F37
M001_L_1F32:
		mov	AX,0Dh
		jmp	short M001_L_1F6D
M001_L_1F37:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Dh
		jne	short M001_L_1F6A
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],5
		je	short M001_L_1F65
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],6
		jne	short M001_L_1F6A
M001_L_1F65:
		mov	AX,20h
		jmp	short M001_L_1F6D
M001_L_1F6A:
		mov	AX,0Eh
M001_L_1F6D:
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV161	endp
CO073_TEXT	ends

; END C223UNIT
		end
