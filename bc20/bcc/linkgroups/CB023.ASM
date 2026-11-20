DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_35
; BEGIN LG013 (gap CODE_35:0000)
RSLEN_TEXT	segment byte public 'CODE'
		assume	cs:RSLEN_TEXT
; Original-image layout stub: not recovered source



RSLEN_TEXT	ends
; END LG013
; BEGIN RSLEN (listing CODE_35:0002)

RSLEN_TEXT	segment byte public 'CODE'
		assume	cs:RSLEN_TEXT,ds:DGROUP

		public	BCC_FAR_AB12

		public	BCC_STRING_LENGTH
BCC_STRING_LENGTH	label	far
BCC_FAR_AB12	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		les	DI,[BP+6]
		mov	AL,0
		mov	CX,0FFFFh
		cld
		repne	scasb
		mov	AX,CX
		not	AX
		dec	AX
		pop	DI
		pop	SI
		pop	BP
		retf	4
BCC_FAR_AB12	endp
RSLEN_TEXT	ends

; Original-target semantic aliases (zero bytes)
; END RSLEN
		end
