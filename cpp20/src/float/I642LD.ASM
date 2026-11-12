; /* target: I642LD */
; /* opts: /ml */
; /* CPP.EXE module I642LD (1104:0006..0084): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/I642LD.ASM); its code is the same in both programs. */
;
; RTL_INT64_TO_LDOUBLE, Borland run-time library (hand-written assembly).
; pascal (int64 far *src, long double far *dst): normalize, exponent 403Eh.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	RTL_INT64_TO_LDOUBLE

RTL_INT64_TO_LDOUBLE	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		mov	AX,word ptr [SI]
		mov	BX,word ptr [SI+2]
		mov	CX,word ptr [SI+4]
		mov	DX,word ptr [SI+6]
		pop	DS
		mov	DI,0
		or	DX,DX
		jl	short I642LD_NEGATE
		jg	short I642LD_NORMALIZE
		or	CX,CX
		jne	short I642LD_NORMALIZE
		or	BX,BX
		jne	short I642LD_NORMALIZE
		or	AX,AX
		jne	short I642LD_NORMALIZE
		sub	SI,SI
		jmp	short I642LD_STORE
I642LD_NEGATE:
		not	DX
		not	CX
		not	BX
		neg	AX
		cmc
		adc	BX,0
		adc	CX,0
		adc	DX,0
		mov	DI,1
I642LD_NORMALIZE:
		mov	SI,40h
I642LD_WORD_SHIFT_LOOP:
		or	DX,DX
		jne	short I642LD_TOP_WORD_NONZERO
		xchg	DX,CX
		xchg	CX,BX
		xchg	AX,BX
		sub	SI,10h
		jmp	short I642LD_WORD_SHIFT_LOOP
I642LD_TOP_WORD_NONZERO:
		js	short I642LD_SET_EXPONENT
I642LD_BIT_SHIFT_LOOP:
		dec	SI
		add	AX,AX
		adc	BX,BX
		adc	CX,CX
		adc	DX,DX
		jns	short I642LD_BIT_SHIFT_LOOP
I642LD_SET_EXPONENT:
		add	SI,3FFEh
		shl	SI,1
		or	SI,DI
		ror	SI,1
I642LD_STORE:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		xchg	AX,SI
		stosw
		pop	DI
		pop	SI
		pop	BP
		retf	8
RTL_INT64_TO_LDOUBLE	endp
CODE12	ends
		end
