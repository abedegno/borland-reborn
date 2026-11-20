		public	X079_04
		public	X079_05
		public	X079_00
		public	X079_01
		public	X079_02
		public	X079_03
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ded_b4a9
; BEGIN C213UNIT (listing ovr_1ded_b4a9:4A90)

		extrn	BCC_FAR_5B8B:far


CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP

M000_BCC_STMT_RECORD_SEG	equ	63C2h
M000_BCC_DATA_8118	equ	8118h
M000_BCC_DATA_8134	equ	8134h
M000_BCC_DATA_8664	equ	8664h
M000_BCC_DATA_866E	equ	866Eh

		public	X079_03
X079_03	label	far
STAOV210	proc	far
		push	BP
		mov	BP,SP
		push	SI
		inc	word ptr [BP+0Ah]
		les	BX,[BP+0Ah]
		cmp	byte ptr ES:[BX],40h
		je	short M000_L_4AA3
		db	0E9h
		dw	0012Dh
M000_L_4AA3:
		les	BX,[BP+6]
		mov	word ptr ES:[BX+2],0
		mov	word ptr ES:[BX],0
		inc	word ptr [BP+0Ah]
		les	BX,[BP+0Ah]
		inc	word ptr [BP+0Ah]
		cmp	byte ptr ES:[BX],53h
		je	short M000_L_4AC3
		db	0E9h
		dw	0007Fh
M000_L_4AC3:
		les	BX,[BP+0Ah]
		mov	AL,byte ptr ES:[BX]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,0Ch
		shl	AX,CL
		push	AX
		mov	AL,byte ptr ES:[BX+1]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,8
		shl	AX,CL
		pop	DX
		or	DX,AX
		mov	AL,byte ptr ES:[BX+2]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,4
		shl	AX,CL
		or	DX,AX
		mov	AL,byte ptr ES:[BX+3]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		or	DX,AX
		mov	SI,DX
		mov	AX,DGROUP:M000_BCC_STMT_RECORD_SEG
		les	BX,[BP+6]
		mov	word ptr ES:[BX+6],AX
		mov	word ptr ES:[BX+4],SI
		push	SI
		db	0FFh,01Eh
		dw	8118h
		les	BX,[BP+6]
		mov	word ptr ES:[BX+0Ah],0
		mov	word ptr ES:[BX+8],AX
		push	SI
		db	0FFh,01Eh
		dw	8134h
		cmp	AX,word ptr DGROUP:M000_BCC_DATA_8664
		jne	short M000_L_4B37
		mov	AX,1
		jmp	short M000_L_4B39
M000_L_4B37:
		xor	AX,AX
M000_L_4B39:
		les	BX,[BP+6]
		mov	word ptr ES:[BX+0Eh],AX
		jmp	short M000_L_4BBB
M000_L_4B42:
		les	BX,[BP+0Ah]
		mov	AL,byte ptr ES:[BX]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,0Ch
		shl	AX,CL
		push	AX
		mov	AL,byte ptr ES:[BX+1]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,8
		shl	AX,CL
		pop	DX
		or	DX,AX
		mov	AL,byte ptr ES:[BX+2]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		mov	CL,4
		shl	AX,CL
		or	DX,AX
		mov	AL,byte ptr ES:[BX+3]
		cbw
		add	AX,0FF9Fh
		and	AX,0Fh
		or	DX,AX
		mov	SI,DX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		test	byte ptr ES:[SI+0Eh],2
		jne	short M000_L_4BBB
		les	BX,[BP+6]
		mov	word ptr ES:[BX+6],0FFFFh
		mov	word ptr ES:[BX+4],0FFFDh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		mov	AX,word ptr ES:[SI+0Fh]
		mov	ES,word ptr [BP+8]
		mov	word ptr ES:[BX+0Ah],0
		mov	word ptr ES:[BX+8],AX
		mov	word ptr ES:[BX+0Eh],0
M000_L_4BBB:
		les	BX,[BP+0Ah]
		mov	AL,byte ptr ES:[BX+4]
		mov	AH,0
		add	AX,0FF9Fh
		les	BX,[BP+6]
		mov	word ptr ES:[BX+0Ch],AX
		jmp	short M000_L_4BE7
M000_L_4BD0:
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		mov	AX,5Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		mov	AX,5Ah
		jmp	short M000_L_4BE9
M000_L_4BE7:
		xor	AX,AX
M000_L_4BE9:
		pop	SI
		pop	BP
		retf	8
STAOV210	endp
CO079_TEXT	ends


CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP



		public	X079_05
X079_05	label	far
STAOV211	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		pop	BP
		retf	4
STAOV211	endp
CO079_TEXT	ends


		extrn	X054_02:far
		extrn	X056_0E:far


CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP

M002_BCC_STMT_CURRENT	equ	86C8h
M002_BCC_DATA_87E0	equ	87E0h
M002_BCC_DATA_88A2	equ	88A2h

		public	X079_01
X079_01	label	far
STAOV212	proc	far
		push	BP
		mov	BP,SP
		push	word ptr DGROUP:M002_BCC_STMT_CURRENT
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		cmp	AX,word ptr DGROUP:M002_BCC_DATA_88A2
		jne	short M002_L_4C13
		mov	AL,byte ptr [BP+6]
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		jmp	short M002_L_4C1C
M002_L_4C13:
		mov	AL,byte ptr [BP+6]
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
M002_L_4C1C:
		xor	AX,AX
		pop	BP
		retf	2
STAOV212	endp
CO079_TEXT	ends



		extrn	X054_0A:far
		extrn	X05D_09:far


CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP

		public	X079_02
X079_02	label	far
STAOV213	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	AL,byte ptr [BP+0Eh]
		cbw
		mov	BX,AX
		cmp	BX,3
		ja	short M003_L_4C4A
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1DFh
		mov	SI,3
		jmp	short M003_L_4C4A
		mov	SI,1
		jmp	short M003_L_4C4A
		mov	SI,1
		jmp	short M003_L_4C4A
		mov	SI,7
M003_L_4C4A:
		push	SI
		push	word ptr [BP+0Ah]
		db	09Ah
		dw	X05D_09
		dw	seg X05D_09
		push	word ptr [BP+6]
		db	09Ah
		dw	X054_0A
		dw	seg X054_0A
		cmp	SI,3
		jne	short M003_L_4C68
		push	word ptr [BP+8]
		db	09Ah
		dw	X054_0A
		dw	seg X054_0A
M003_L_4C68:
		xor	AX,AX
		pop	SI
		pop	BP
		retf	0Ah
STAOV213	endp
CO079_TEXT	ends

CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT

STAOV214	label	word
		dw	001ADh
		dw	001B2h
		dw	001A8h
		dw	001B7h

CO079_TEXT	ends

CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP



		public	X079_00
X079_00	label	far
STAOV215	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		pop	BP
		retf	6
STAOV215	endp
CO079_TEXT	ends



		extrn	X054_02:far
		extrn	X054_08:far


CO079_TEXT	segment byte public 'CODE'
		assume	cs:CO079_TEXT,ds:DGROUP

		public	X079_04
X079_04	label	far
STAOV216	proc	far
		push	BP
		mov	BP,SP
		mov	AL,byte ptr [BP+8]
		cbw
		cmp	AX,36h
		je	short M006_L_4CE2
		jg	short M006_L_4C9B
		cmp	AX,26h
		je	short M006_L_4CC7
		cmp	AX,2Eh
		je	short M006_L_4D06
		db	0E9h
		dw	0008Fh
M006_L_4C9B:
		cmp	AX,3Eh
		je	short M006_L_4CA3
		db	0E9h
		dw	00087h
M006_L_4CA3:
		cmp	byte ptr [BP+6],0
		je	short M006_L_4CC3
		mov	AX,5AC4h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
		mov	AL,9Bh
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		mov	AX,5ACBh
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
M006_L_4CC3:
		mov	AL,3Eh
		jmp	short M006_L_4D3B
M006_L_4CC7:
		cmp	byte ptr [BP+6],0
		je	short M006_L_4CDE
		mov	AX,5AD2h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
		mov	AL,9Bh
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
M006_L_4CDE:
		mov	AL,26h
		jmp	short M006_L_4D3B
M006_L_4CE2:
		cmp	byte ptr [BP+6],0
		je	short M006_L_4D02
		mov	AX,5AD9h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
		mov	AL,9Bh
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		mov	AX,5AE0h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
M006_L_4D02:
		mov	AL,36h
		jmp	short M006_L_4D3B
M006_L_4D06:
		cmp	byte ptr [BP+6],0
		je	short M006_L_4D26
		mov	AX,5AE7h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
		mov	AL,9Bh
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		mov	AX,5AEEh
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
M006_L_4D26:
		mov	AL,2Eh
		jmp	short M006_L_4D3B
M006_L_4D2A:
		cmp	byte ptr [BP+6],0
		je	short M006_L_4D41
		mov	AX,5AF5h
		push	AX
		db	09Ah
		dw	X054_08
		dw	seg X054_08
		mov	AL,9Bh
M006_L_4D3B:
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
M006_L_4D41:
		mov	AL,byte ptr [BP+0Ah]
		push	AX
		db	09Ah
		dw	X054_02
		dw	seg X054_02
		xor	AX,AX
		pop	BP
		retf	6
STAOV216	endp
CO079_TEXT	ends

; END C213UNIT
		end
