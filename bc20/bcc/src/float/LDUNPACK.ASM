; /* target: CODE_9_R9UNPACK */
; /* opts: /ml */
;
; CODE_9:000B, hand-written assembly.  Unpacks an 80-bit extended real at
; DS:SI into the 12-byte work format at SS:DI used by LDARITH: the 64-bit
; mantissa, then the exponent with the sign bit removed, then the sign in
; the last word (0 or 1).  Register arguments; SI and DI are preserved,
; ES is set to SS, and AX, CX and DX are changed.

CODE9		segment byte public 'CODE'
		assume	cs:CODE9

		public	RTL_LDOUBLE_UNPACK

RTL_LDOUBLE_UNPACK	proc	far
		push	si
		push	di
		push	ss
		pop	es
		sub	dx,dx
		cld
		mov	cx,4
		rep movsw			; mantissa
		lodsw				; sign and exponent
		shl	ax,1
		rcl	dx,1			; dx = sign
		shr	ax,1
		stosw				; exponent
		xchg	ax,dx
		stosw				; sign
		pop	di
		pop	si
		ret
RTL_LDOUBLE_UNPACK	endp

CODE9		ends

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		end
