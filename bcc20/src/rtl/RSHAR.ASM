; /* target: CODE_0_RSHAR */
; /* opts: /ml */
;
; CODE_0:038B..03A9, Borland run-time library (hand-written assembly).
; F_LXRSH@: signed long DX:AX >>= CL, result in DX:AX.
; F_LXRSH@: DX:AX shifted right arithmetically by CL.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXRSH@
F_LXRSH@	proc	far
		cmp	CL,10h
		jnc	short M003_L_LARGE
		mov	BX,DX
		shr	AX,CL
		sar	DX,CL
		neg	CL
		add	CL,10h
		shl	BX,CL
		or	AX,BX
		retf
M003_L_LARGE:
		sub	CL,10h
		mov	AX,DX
		cwd
		sar	AX,CL
		retf
F_LXRSH@	endp
CODE0	ends
		end
