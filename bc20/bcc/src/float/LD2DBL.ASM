; /* target: CODE_11_R11P64 */
; /* opts: /ml */
;
; CODE_11:012B..01D5, Borland run-time library (hand-written assembly).
; pascal (long double far *src, double far *dst): calls LDRNDDBL, rebias
; -3C00h.  The epilogue (mov sp,bp / pop bp / retf 8) lay at the start of
; the old CODE_12 block (the deleted R12TAIL).

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP
		public	RTL_LDOUBLE_TO_DOUBLE

RTL_LDOUBLE_TO_DOUBLE	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-0Ah]
		push	SS
		pop	ES
		mov	CX,5
		cld
		rep movsw
		pop	DS
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	CS
		db	0E8h			; near call to LDRNDDBL in another module (push cs /
					; call near across sources: no fixup exists, so a fixed displacement)
		dw	0FF89h
		mov	AX,word ptr [BP-9]
		mov	DI,word ptr [BP-7]
		mov	CX,word ptr [BP-5]
		mov	DL,byte ptr [BP-3]
		mov	BX,word ptr [BP-2]
		and	BX,7FFFh
		cmp	BX,7FFFh
		je	short LD2DBL_INF_OR_NAN
		add	BX,0C400h
		jle	short LD2DBL_UNDERFLOW_ZERO
		cmp	BX,7FFh
		jge	short LD2DBL_OVERFLOW
		shl	DL,1
		shr	BX,1
		rcr	DL,1
		or	AL,BH
		mov	DH,BL
		mov	BX,DI
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
		shl	word ptr [BP-2],1
		adc	AL,0
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
LD2DBL_STORE:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		jmp	short LD2DBL_EPILOGUE
LD2DBL_UNDERFLOW_ZERO:
		mov	DX,0
		jmp	short LD2DBL_SET_SIGN_ZERO_LOW
LD2DBL_INF_OR_NAN:
		and	DX,7Fh
		shr	DX,1
		shr	DX,1
		or	DX,0FFE0h
		jmp	short LD2DBL_SET_SIGN_ZERO_LOW
LD2DBL_OVERFLOW:
		mov	DX,0FFE0h
LD2DBL_SET_SIGN_ZERO_LOW:
		shl	word ptr [BP-2],1
		rcr	DX,1
		sub	CX,CX
		mov	BX,CX
		mov	AX,CX
		jmp	short LD2DBL_STORE
LD2DBL_EPILOGUE:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
RTL_LDOUBLE_TO_DOUBLE	endp
CODE11	ends
		end
