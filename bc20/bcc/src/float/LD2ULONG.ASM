; /* target: CODE_12_R12I32 */
; /* opts: /ml */
;
; CODE_12:0141..016F, Borland run-time library (hand-written assembly).
; unsigned long pascal (long double far *x): high words not 0 give FFFFFFFFh.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	RTL_LDOUBLE_TO_ULONG

RTL_LDOUBLE_TO_ULONG	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	CS
		db	0E8h			; near call to LD2I64 in another module (the
					; old layout keeps it as bytes with a fixed displacement)
		dw	0FF2Eh
		mov	AX,word ptr [BP-8]
		mov	DX,word ptr [BP-6]
		mov	CX,word ptr [BP-4]
		or	CX,word ptr [BP-2]
		je	short LD2ULONG_DONE
		mov	AX,0FFFFh
		mov	DX,AX
LD2ULONG_DONE:
		mov	SP,BP
		pop	BP
		retf	4
RTL_LDOUBLE_TO_ULONG	endp
CODE12	ends
		end
