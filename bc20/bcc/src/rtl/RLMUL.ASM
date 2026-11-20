; /* target: CODE_0_RLMUL */
; /* opts: /ml */
;
; CODE_0:03A9..03C2, Borland run-time library (hand-written assembly).
; F_LXMUL@: DX:AX * CX:BX, the low 32 bits in DX:AX.
; F_LXMUL@: DX:AX times CX:BX, the low 32 bits of the product in DX:AX.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXMUL@
F_LXMUL@	proc	far
		push	SI
		xchg	AX,SI
		xchg	AX,DX
		test	AX,AX
		je	short M004_L_SKIP1
		mul	BX
M004_L_SKIP1:
		xchg	AX,CX
		test	AX,AX
		je	short M004_L_SKIP2
		mul	SI
		add	CX,AX
M004_L_SKIP2:
		xchg	AX,SI
		mul	BX
		add	DX,CX
		pop	SI
		retf
F_LXMUL@	endp
CODE0	ends
		end
