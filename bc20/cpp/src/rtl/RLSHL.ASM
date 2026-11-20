; /* target: RLSHL */
; /* opts: /ml */
; /* CPP.EXE module RLSHL (0000:0297..02B6): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RLSHL.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; F_LXLSH@: long DX:AX <<= CL (register call), result in DX:AX.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXLSH@
F_LXLSH@	proc	far
		cmp	CL,10h
		jnc	short M002_L_LARGE
		mov	BX,AX
		shl	AX,CL
		shl	DX,CL
		neg	CL
		add	CL,10h
		shr	BX,CL
		or	DX,BX
		retf
M002_L_LARGE:
		sub	CL,10h
		mov	DX,AX
		xor	AX,AX
		shl	DX,CL
		retf
F_LXLSH@	endp
CODE0	ends
		end
