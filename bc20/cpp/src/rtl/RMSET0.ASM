; /* target: RMSET0 */
; /* opts: /ml */
; /* CPP.EXE module RMSET0 (11D7:00D5..00EC): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RMSET0.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; void pascal itoa10(char far *buf, int v): cwd, then the signed core
; RTL_LTOA_CORE (RAHELP, 11D7:0078); retf 6.  The caller in CPP.EXE is the
; lexer (LEXER.C).  (Named RMSET0 by the BCC.EXE reconstruction's layout; it
; is not memset.)

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP
		public	RTL_ITOA10

RTL_ITOA10	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		les	DI,[BP+6]
		mov	AX,word ptr [BP+0Ah]
		cwd
		db	0E8h			; near call to the signed core RTL_LTOA_CORE (RAHELP, 11D7:0078) in another module (the
					; BCC.EXE reconstruction writes it as bytes with a fixed displacement)
		dw	0FF93h
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	6
RTL_ITOA10	endp
CODE_40	ends
		end
