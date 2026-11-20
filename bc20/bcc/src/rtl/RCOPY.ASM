; /* target: CODE_0_RCOPY */
; /* opts: /ml */
;
; CODE_0:0402..0418, Borland run-time library (hand-written assembly).
; BCC_RUNTIME_COPY (Borland's struct copy helper): copies CX bytes from
; the far pointer at [bp+6] to the far pointer at [bp+0Ah]; ret 8.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_RUNTIME_COPY
BCC_RUNTIME_COPY	proc	far
		push	BP
		mov	BP,SP
		push	DS
		push	DI
		push	SI
		lds	SI,[BP+6]
		les	DI,[BP+0Ah]
		cld
		rep	movsb
		pop	SI
		pop	DI
		pop	DS
		pop	BP
		retf	8
BCC_RUNTIME_COPY	endp
CODE0	ends
		end
