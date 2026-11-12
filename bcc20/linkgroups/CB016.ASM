DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_22
; BEGIN RCLOSE (listing CODE_22:0004)

RCLOSE_TEXT	segment byte public 'CODE'
		assume	cs:RCLOSE_TEXT,ds:DGROUP

M000_BCC_ERRNO	equ	0

		public	BCC_FAR_A7C4

BCC_FAR_A7C4	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	BX,SI
		mov	AH,3Eh
		int	21h
		jnc	short M000_L_SUCCESS
		mov	DGROUP:M000_BCC_ERRNO,AX
		mov	AX,0FFFFh
		jmp	short M000_L_DONE
M000_L_SUCCESS:
		xor	AX,AX
M000_L_DONE:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_A7C4	endp
RCLOSE_TEXT	ends

; END RCLOSE
		end
