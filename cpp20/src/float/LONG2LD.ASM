; /* target: LONG2LD */
; /* opts: /ml */
; /* CPP.EXE module LONG2LD (1104:016F..019D): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/LONG2LD.ASM); its code is the same in both programs. */
;
; RTL_LONG_TO_LDOUBLE, Borland run-time library (hand-written assembly).
; pascal (long v, long double far *dst): sign-extends to int64, calls I642LD.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	RTL_LONG_TO_LDOUBLE

RTL_LONG_TO_LDOUBLE	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr [BP-8],AX
		mov	AX,word ptr [BP+0Ch]
		mov	word ptr [BP-6],AX
		cwd
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-2],DX
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h			; near call to I642LD in another module (push cs /
					; call near across sources: no fixup exists, so a fixed displacement)
		dw	0FE6Fh
		mov	SP,BP
		pop	BP
		retf	8
RTL_LONG_TO_LDOUBLE	endp
CODE12	ends
		end
