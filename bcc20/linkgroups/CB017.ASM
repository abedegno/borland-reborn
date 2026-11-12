DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_23
; BEGIN LG00B (gap CODE_23:0000)
RCREAT_TEXT	segment byte public 'CODE'
		assume	cs:RCREAT_TEXT
; Original-image layout stub: not recovered source



RCREAT_TEXT	ends
; END LG00B
; BEGIN RCREAT (listing CODE_23:0002)

RCREAT_TEXT	segment byte public 'CODE'
		assume	cs:RCREAT_TEXT,ds:DGROUP

M001_BCC_ERRNO	equ	0

		public	BCC_FAR_A7E2

BCC_FAR_A7E2	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	CX,word ptr [BP+6]
		push	DS
		lds	DX,[BP+8]
		mov	AH,3Ch
		int	21h
		pop	DS
		jnc	short M001_L_DONE
		mov	DGROUP:M001_BCC_ERRNO,AX
		mov	AX,0FFFFh
		jmp	short M001_L_DONE
M001_L_DONE:
		pop	SI
		pop	BP
		retf	6
BCC_FAR_A7E2	endp
RCREAT_TEXT	ends

; END RCREAT
		end
