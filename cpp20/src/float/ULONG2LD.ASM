; /* target: ULONG2LD */
; /* opts: /ml */
; /* CPP.EXE module ULONG2LD (1104:019D..01CC): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/ULONG2LD.ASM); its code is the same in both programs. */
;
; RTL_ULONG_TO_LDOUBLE, Borland run-time library (hand-written assembly).
; pascal (unsigned long v, long double far *dst): zero-extends and converts
; through I642LD.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	RTL_ULONG_TO_LDOUBLE

RTL_ULONG_TO_LDOUBLE	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr [BP-8],AX
		mov	AX,word ptr [BP+0Ch]
		mov	word ptr [BP-6],AX
		sub	AX,AX
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-2],AX
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h			; near call to I642LD in another module (push cs /
					; call near across sources: no fixup exists, so a fixed displacement)
		dw	0FE40h
		mov	SP,BP
		pop	BP
		retf	8
RTL_ULONG_TO_LDOUBLE	endp
CODE12	ends
		end
