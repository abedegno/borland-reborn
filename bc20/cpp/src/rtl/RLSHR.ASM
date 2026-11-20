; /* target: RLSHR */
; /* opts: /ml */
; /* CPP.EXE module RLSHR (0000:030E..032D): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RLSHR.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; F_LXURSH@: unsigned long DX:AX >>= CL (logical shift), result in DX:AX.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXURSH@
		public	LXURSH@
LXURSH@	label	far		; link: the Turbo C 2.01 name of the same helper (TC 2.01 code calls it without the F_ prefix)
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
