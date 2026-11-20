; /* target: LDRNDFLT */
; /* opts: /ml */
; /* CPP.EXE module LDRNDFLT (10E7:0006..0060): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/LDRNDFLT.ASM); its code is the same in both programs. */
;
; RTL_LDOUBLE_ROUND_TO_FLOAT, Borland run-time library (hand-written assembly).
; pascal: round the temp real at a far pointer to float precision (nearest
; even), in place; overflow gives infinity; retf 4.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP


		public	RTL_LDOUBLE_ROUND_TO_FLOAT

RTL_LDOUBLE_ROUND_TO_FLOAT	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		lds	SI,[BP+6]
		mov	AX,word ptr [SI+4]
		mov	DX,word ptr [SI+6]
		cmp	word ptr [SI],0
		jne	short LDRNDFLT_ROUND_UP
		cmp	word ptr [SI+2],0
		jne	short LDRNDFLT_ROUND_UP
		test	AL,7Fh
		jne	short LDRNDFLT_ROUND_UP
		test	AH,1
		je	short LDRNDFLT_STORE
LDRNDFLT_ROUND_UP:
		add	AL,AL
		adc	AH,0
		adc	DX,0
		jnc	short LDRNDFLT_STORE
		rcr	DX,1
		rcr	AX,1
		inc	word ptr [SI+8]
		mov	BX,7FFFh
		and	BX,word ptr [SI+8]
		inc	BX
		jo	short LDRNDFLT_SET_INFINITY
LDRNDFLT_STORE:
		mov	AL,0
		sub	BX,BX
		mov	word ptr [SI],BX
		mov	word ptr [SI+2],BX
		mov	word ptr [SI+4],AX
		mov	word ptr [SI+6],DX
		pop	DS
		jmp	short LDRNDFLT_EPILOGUE
LDRNDFLT_SET_INFINITY:
		sub	AX,AX
		mov	DX,8000h
		jmp	short LDRNDFLT_STORE
LDRNDFLT_EPILOGUE:
		pop	SI
		pop	BP
		retf	4
RTL_LDOUBLE_ROUND_TO_FLOAT	endp
CODE11	ends
		end
