; /* target: LDRNDDBL */
; /* opts: /ml */
; /* CPP.EXE module LDRNDDBL (10E7:00D5..012B): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/LDRNDDBL.ASM); its code is the same in both programs. */
;
; RTL_LDOUBLE_ROUND_TO_DOUBLE, Borland run-time library (hand-written assembly).
; pascal: round a temp real to double precision (nearest even), in place;
; retf 4.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP


		public	RTL_LDOUBLE_ROUND_TO_DOUBLE

RTL_LDOUBLE_ROUND_TO_DOUBLE	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+6]
		mov	AX,word ptr [SI+1]
		mov	DH,3
		and	DH,AL
		or	DH,byte ptr [SI]
		jne	short LDRNDDBL_ROUND_UP
		test	AL,8
		je	short LDRNDDBL_TRUNCATE
LDRNDDBL_ROUND_UP:
		add	AX,4
		jnc	short LDRNDDBL_TRUNCATE
		sub	BX,BX
		adc	word ptr [SI+3],BX
		adc	word ptr [SI+5],BX
		adc	byte ptr [SI+7],BL
		jnc	short LDRNDDBL_TRUNCATE
		inc	word ptr [SI+8]
		mov	DI,7FFFh
		and	DI,word ptr [SI+8]
		inc	DI
		jo	short LDRNDDBL_SET_INFINITY
LDRNDDBL_TRUNCATE:
		and	AL,0F8h
		mov	byte ptr [SI],0
		mov	word ptr [SI+1],AX
LDRNDDBL_DONE:
		pop	DS
		jmp	short LDRNDDBL_EPILOGUE
LDRNDDBL_SET_INFINITY:
		mov	word ptr [SI],BX
		mov	word ptr [SI+2],BX
		mov	word ptr [SI+4],BX
		mov	word ptr [SI+6],8000h
		jmp	short LDRNDDBL_DONE
LDRNDDBL_EPILOGUE:
		pop	DI
		pop	SI
		pop	BP
		retf	4
RTL_LDOUBLE_ROUND_TO_DOUBLE	endp
CODE11	ends
		end
