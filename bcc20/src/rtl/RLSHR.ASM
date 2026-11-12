; /* target: CODE_0_RLSHR */
; /* opts: /ml */
;
; CODE_0:03E3..0402, Borland run-time library (hand-written assembly).
; F_LXURSH@: unsigned long DX:AX >>= CL, result in DX:AX.
; F_LXURSH@: DX:AX shifted right logically by CL.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXURSH@
F_LXURSH@	proc	far
		cmp	CL,10h
		jnc	short M006_L_LARGE
		mov	BX,DX
		shr	AX,CL
		shr	DX,CL
		neg	CL
		add	CL,10h
		shl	BX,CL
		or	AX,BX
		retf
M006_L_LARGE:
		sub	CL,10h
		mov	AX,DX
		xor	DX,DX
		shr	AX,CL
		retf
F_LXURSH@	endp
CODE0	ends
		end
