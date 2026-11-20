; /* target: RLMUL */
; /* opts: /ml */
; /* CPP.EXE module RLMUL (0000:02D4..02ED): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RLMUL.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; F_LXMUL@: DX:AX times CX:BX, the low 32 bits of the product in DX:AX.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LXMUL@
		public	LXMUL@
LXMUL@	label	far		; link: the Turbo C 2.01 name of the same helper (TC 2.01 code calls it without the F_ prefix)
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
