; /* target: RSTACK */
; /* opts: /ml */
; /* CPP.EXE module RSTACK (0000:02ED..030E): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RSTACK.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; BCC_RUNTIME_BUILD (Borland's struct push helper): makes room for CX
; bytes on the caller's stack below the return address and copies them
; there from DX:AX, for passing a structure by value.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_RUNTIME_BUILD
		public	F_SPUSH@
F_SPUSH@	label	far		; link: the run-time library name BC 2.0 calls to push a struct
BCC_RUNTIME_BUILD	proc	far
		pop	BX
		pop	ES
		sub	SP,CX
		push	ES
		push	BX
		push	DI
		push	DS
		mov	DI,SP
		add	DI,8
		mov	BX,SS
		mov	ES,BX
		mov	DS,DX
		xchg	AX,SI
		cld
		shr	CX,1
		rep	movsw
		adc	CX,CX
		rep	movsb
		xchg	AX,SI
		pop	DS
		pop	DI
		retf
BCC_RUNTIME_BUILD	endp
CODE0	ends
		end
