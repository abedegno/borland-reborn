DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_38
; BEGIN LG016 (gap CODE_38:0000)
RWRITE_TEXT	segment byte public 'CODE'
		assume	cs:RWRITE_TEXT
; Original-image layout stub: not recovered source



RWRITE_TEXT	ends
; END LG016
; BEGIN RWRITE (listing CODE_38:000B)

RWRITE_TEXT	segment byte public 'CODE'
		assume	cs:RWRITE_TEXT,ds:DGROUP

M001_BCC_ERRNO	equ	0

		public	BCC_FAR_AB9B

BCC_FAR_AB9B	proc	far
		push	BP
		mov	BP,SP
		mov	CX,word ptr [BP+6]
		mov	BX,word ptr [BP+0Ch]
		mov	AH,40h
		push	DS
		lds	DX,[BP+8]
		int	21h
		pop	DS
		jc	short M001_L_ERROR
		jmp	short M001_L_DONE
M001_L_ERROR:
		mov	DGROUP:M001_BCC_ERRNO,AX
		mov	AX,0FFFFh
M001_L_DONE:
		pop	BP
		retf	8
BCC_FAR_AB9B	endp
RWRITE_TEXT	ends

; END RWRITE
		end
