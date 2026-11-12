		public	X04E_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d1f_9b81
; BEGIN C141UNIT (listing ovr_1d1f_9b81:B810)

CO04E_TEXT	segment byte public 'CODE'
		assume	cs:CO04E_TEXT,ds:DGROUP



		public	X04E_00
X04E_00	label	far
BCC_FAR_B810	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	AX,word ptr [BP+0Ch]
		mov	BX,word ptr [BP+6]
		test	AX,AX
		je	short M000_L_B822
		imul	BX
		jo	short M000_L_B83B
M000_L_B822:
		mov	CX,word ptr [BP+8]
		xchg	AX,CX
		mov	SI,word ptr [BP+0Ah]
		test	AX,AX
		je	short M000_L_B835
		imul	SI
		jo	short M000_L_B83B
		add	CX,AX
		jo	short M000_L_B83B
M000_L_B835:
		mov	AX,SI
		mul	BX
		add	DX,CX
M000_L_B83B:
		pop	SI
		pop	BP
		retf	8
BCC_FAR_B810	endp
CO04E_TEXT	ends

; END C141UNIT
		end
