; /* target: CODE_10_R10CMP */
; /* opts: /ml */
;
; CODE_10:0004..0075, Borland run-time library (hand-written assembly).
; int pascal ldcmp(long double far *a, long double far *b): -1/0/1 in AX,
; flags set; exponent 0 counts as zero.  The epilogue (pop di/si/bp,
; retf 8) lay at the start of the old CODE_11 block (the deleted R11TAIL);
; the FBOV segment table gives segment 09DA the span 0004..0076h.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE10	segment byte public 'CODE'
		assume	cs:CODE10,ds:DGROUP


		public	RTL_LDOUBLE_COMPARE

RTL_LDOUBLE_COMPARE	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		les	DI,[BP+6]
		mov	AX,word ptr [SI+8]
		mov	DX,word ptr ES:[DI+8]
		sub	BX,BX
		shl	AX,1
		rcr	BL,1
		shl	DX,1
		rcr	BH,1
		mov	CX,AX
		or	CX,DX
		jcxz	short LDCMP_EQUAL
		cmp	BL,BH
		jg	short LDCMP_GREATER
		jl	short LDCMP_LESS
		cmp	AX,DX
		jc	short LDCMP_MAG_LESS
		ja	short LDCMP_MAG_GREATER
		mov	AX,word ptr [SI+6]
		cmp	AX,word ptr ES:[DI+6]
		jne	short LDCMP_MANT_DIFFER
		mov	AX,word ptr [SI+4]
		cmp	AX,word ptr ES:[DI+4]
		jne	short LDCMP_MANT_DIFFER
		mov	AX,word ptr [SI+2]
		cmp	AX,word ptr ES:[DI+2]
		jne	short LDCMP_MANT_DIFFER
		mov	AX,word ptr [SI]
		cmp	AX,word ptr ES:[DI]
		jne	short LDCMP_MANT_DIFFER
LDCMP_EQUAL:
		sub	AX,AX
		jmp	short LDCMP_SET_FLAGS
LDCMP_MANT_DIFFER:
		ja	short LDCMP_MAG_GREATER
LDCMP_MAG_LESS:
		or	BL,BL
		jne	short LDCMP_GREATER
LDCMP_LESS:
		mov	AX,0FFFFh
		jmp	short LDCMP_SET_FLAGS
LDCMP_MAG_GREATER:
		or	BL,BL
		jne	short LDCMP_LESS
LDCMP_GREATER:
		mov	AX,1
LDCMP_SET_FLAGS:
		or	AX,AX
		pop	DS
		jmp	short LDCMP_EPILOGUE
LDCMP_EPILOGUE:
		pop	DI
		pop	SI
		pop	BP
		retf	8
RTL_LDOUBLE_COMPARE	endp
CODE10	ends
		end
