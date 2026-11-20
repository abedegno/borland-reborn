; /* target: LD2I64 */
; /* opts: /ml */
; /* CPP.EXE module LD2I64 (1104:0084..010D): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/LD2I64.ASM); its code is the same in both programs. */
;
; RTL_LDOUBLE_TO_INT64, Borland run-time library (hand-written assembly).
; pascal (long double far *src, int64 far *dst): truncates toward zero;
; overflow gives 8000...0.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	RTL_LDOUBLE_TO_INT64

RTL_LDOUBLE_TO_INT64	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		mov	DI,7FFFh
		and	DI,word ptr [SI+8]
		sub	DI,3FFEh
		cmp	DI,3Fh
		jg	short LD2I64_OVERFLOW
		or	DI,DI
		jge	short LD2I64_IN_RANGE
		sub	DX,DX
		jmp	short LD2I64_CLEAR_LOW_WORDS
LD2I64_OVERFLOW:
		mov	DX,8000h
LD2I64_CLEAR_LOW_WORDS:
		sub	AX,AX
		mov	BX,AX
		mov	CX,AX
		jmp	short LD2I64_STORE
LD2I64_IN_RANGE:
		mov	DX,word ptr [SI+6]
		mov	CX,word ptr [SI+4]
		mov	BX,word ptr [SI+2]
		mov	AX,word ptr [SI]
		sub	DI,30h
		ja	short LD2I64_SHIFT_BITS
LD2I64_SHIFT_WORD_LOOP:
		mov	AX,BX
		mov	BX,CX
		mov	CX,DX
		sub	DX,DX
		add	DI,10h
		jle	short LD2I64_SHIFT_WORD_LOOP
		and	DI,0Fh
LD2I64_SHIFT_BITS:
		neg	DI
		je	short LD2I64_APPLY_SIGN
		add	DI,10h
LD2I64_SHIFT_BIT_LOOP:
		shr	DX,1
		rcr	CX,1
		rcr	BX,1
		rcr	AX,1
		dec	DI
		jg	short LD2I64_SHIFT_BIT_LOOP
LD2I64_APPLY_SIGN:
		test	byte ptr [SI+9],80h
		je	short LD2I64_STORE
		sub	SI,SI
		not	DX
		not	CX
		not	BX
		neg	AX
		cmc
		adc	BX,SI
		adc	CX,SI
		adc	DX,SI
LD2I64_STORE:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		sub	DI,8
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	8
RTL_LDOUBLE_TO_INT64	endp
CODE12	ends
		end
