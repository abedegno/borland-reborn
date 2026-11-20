; /* target: CODE_12_R12I16 */
; /* opts: /ml */
;
; CODE_12:010D..0141, Borland run-time library (hand-written assembly).
; long pascal (long double far *x): via LD2I64; out of range gives
; 80000000h.  (Named I16 by the old layout; it returns a long.)

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	RTL_LDOUBLE_TO_LONG

RTL_LDOUBLE_TO_LONG	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	CS
		db	0E8h			; near call to LD2I64 in another module (push cs /
					; call near across sources: no fixup exists, so a fixed displacement)
		dw	0FF62h
		mov	AX,word ptr [BP-6]
		cwd
		cmp	DX,word ptr [BP-4]
		jne	short LD2LONG_OUT_OF_RANGE
		cmp	DX,word ptr [BP-2]
		jne	short LD2LONG_OUT_OF_RANGE
		xchg	AX,DX
		mov	AX,word ptr [BP-8]
		jmp	short LD2LONG_EPILOGUE
LD2LONG_OUT_OF_RANGE:
		sub	AX,AX
		mov	DX,8000h
LD2LONG_EPILOGUE:
		mov	SP,BP
		pop	BP
		retf	4
RTL_LDOUBLE_TO_LONG	endp
CODE12	ends
		end
