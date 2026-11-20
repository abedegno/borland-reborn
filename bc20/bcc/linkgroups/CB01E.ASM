DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_30
; BEGIN LG011 (gap CODE_30:0000)
ROPEN_TEXT	segment byte public 'CODE'
		assume	cs:ROPEN_TEXT
; Original-image layout stub: not recovered source



ROPEN_TEXT	ends
; END LG011
; BEGIN ROPEN (listing CODE_30:0001)

ROPEN_TEXT	segment byte public 'CODE'
		assume	cs:ROPEN_TEXT,ds:DGROUP

M001_BCC_ERRNO	equ	0

		public	BCC_FAR_A9C1

BCC_FAR_A9C1	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	AL,byte ptr [BP+6]
		push	DS
		lds	DX,[BP+8]
		mov	AH,3Dh
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
BCC_FAR_A9C1	endp
ROPEN_TEXT	ends

; END ROPEN
		end
