; /* target: CODE_11_R11P32 */
; /* opts: /ml */
;
; CODE_11:0060..00D5, Borland run-time library (hand-written assembly).
; pascal (long double far *src, float far *dst): calls LDRNDFLT, rebias
; -3F80h; underflow gives 0.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP
		public	RTL_LDOUBLE_TO_FLOAT

RTL_LDOUBLE_TO_FLOAT	proc	far
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
		db	0E8h			; near call to LDRNDFLT in another module (the
					; old layout keeps it as bytes with a fixed displacement)
		dw	0FF85h
		mov	BX,word ptr [BP-2]
		mov	CL,0
		shl	BX,1
		rcl	CL,1
		shr	BX,1
		cmp	BX,7FFFh
		je	short LD2FLT_INF_OR_NAN
		add	BX,0C080h
		jle	short LD2FLT_UNDERFLOW_ZERO
		cmp	BX,0FFh
		jge	short LD2FLT_OVERFLOW
		mov	BH,byte ptr [BP-3]
		mov	AX,word ptr [BP-5]
		xchg	BH,BL
		shl	BL,1
LD2FLT_SET_SIGN_STORE:
		shr	CL,1
		rcr	BX,1
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		jmp	short LD2FLT_EPILOGUE
LD2FLT_INF_OR_NAN:
		mov	BL,byte ptr [BP-3]
		shl	BL,1
		mov	BH,0FFh
		sub	AX,AX
		jmp	short LD2FLT_SET_SIGN_STORE
LD2FLT_OVERFLOW:
		mov	BX,0FF00h
		sub	AX,AX
		jmp	short LD2FLT_SET_SIGN_STORE
LD2FLT_UNDERFLOW_ZERO:
		sub	BX,BX
		sub	AX,AX
		jmp	short LD2FLT_SET_SIGN_STORE
LD2FLT_EPILOGUE:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
RTL_LDOUBLE_TO_FLOAT	endp
CODE11	ends
		end
