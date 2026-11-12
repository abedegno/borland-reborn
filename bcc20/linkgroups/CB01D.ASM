DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_29
; BEGIN LG010 (gap CODE_29:0000)
RLSEEK_TEXT	segment byte public 'CODE'
		assume	cs:RLSEEK_TEXT
; Original-image layout stub: not recovered source



RLSEEK_TEXT	ends
; END LG010
; BEGIN RLSEEK (listing CODE_29:000E)

RLSEEK_TEXT	segment byte public 'CODE'
		assume	cs:RLSEEK_TEXT,ds:DGROUP

M001_BCC_ERRNO	equ	0

		public	BCC_FAR_A99E

		public	BCC_BUFFER_ALLOC
BCC_BUFFER_ALLOC	label	far
		public	BCC_INPUT_FLUSH
BCC_INPUT_FLUSH	label	far
		public	BCC_INPUT_SEEK
BCC_INPUT_SEEK	label	far
BCC_FAR_A99E	proc	far
		push	BP
		mov	BP,SP
		mov	AL,byte ptr [BP+6]
		mov	CX,word ptr [BP+0Ah]
		mov	DX,word ptr [BP+8]
		mov	BX,word ptr [BP+0Ch]
		mov	AH,42h
		int	21h
		jnc	short M001_L_DONE
		mov	DGROUP:M001_BCC_ERRNO,AX
		mov	DX,0FFFFh
		mov	AX,DX
		jmp	short M001_L_DONE
M001_L_DONE:
		pop	BP
		retf	8
BCC_FAR_A99E	endp
RLSEEK_TEXT	ends

; Original-target semantic aliases (zero bytes)
; END RLSEEK
		end
