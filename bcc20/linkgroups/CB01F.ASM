DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_31
; BEGIN RREAD (listing CODE_31:0000)

RREAD_TEXT	segment byte public 'CODE'
		assume	cs:RREAD_TEXT,ds:DGROUP

M000_BCC_ERRNO	equ	0

		public	BCC_FAR_A9E0

		public	BCC_INPUT_READ
BCC_INPUT_READ	label	far
BCC_FAR_A9E0	proc	far
		push	BP
		mov	BP,SP
		mov	CX,word ptr [BP+6]
		mov	BX,word ptr [BP+0Ch]
		mov	AH,3Fh
		push	DS
		lds	DX,[BP+8]
		int	21h
		pop	DS
		jc	short M000_L_ERROR
		jmp	short M000_L_DONE
M000_L_ERROR:
		mov	DGROUP:M000_BCC_ERRNO,AX
		mov	AX,0FFFFh
M000_L_DONE:
		pop	BP
		retf	8
BCC_FAR_A9E0	endp
RREAD_TEXT	ends

; Original-target semantic aliases (zero bytes)
; END RREAD
		end
