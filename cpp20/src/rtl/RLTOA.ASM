; /* target: RLTOA */
; /* opts: /ml */
; /* CPP.EXE module RLTOA (11D7:008D..00D5): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RLTOA.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly):
; number-to-decimal wrappers around RAHELP's cores (RTL_ULTOA_CORE unsigned,
; RTL_LTOA_CORE signed), which take the value in DX:AX and the buffer in
; ES:DI.  Far pascal.
;   RTL_ULTOA10  ultoa10(char far *buf, unsigned long v); retf 8
;   RTL_LTOA10  ltoa10(char far *buf, long v); retf 8
;   RTL_UTOA10  utoa10(char far *buf, unsigned v); retf 6

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE_40		segment byte public 'CODE'
		assume	cs:CODE_40
		extrn	RTL_ULTOA_CORE:near
		extrn	RTL_LTOA_CORE:near
		public	RTL_ULTOA10
		public	RTL_LTOA10
		public	RTL_UTOA10

RTL_ULTOA10	proc	far
		push	bp
		mov	bp,sp
		push	si
		push	di
		push	ds
		les	ax,[bp+0Ah]		; dx:ax = v
		mov	dx,es
		les	di,[bp+6]		; es:di = buf
		call	RTL_ULTOA_CORE
		pop	ds
		pop	di
		pop	si
		pop	bp
		ret	8
RTL_ULTOA10	endp

RTL_LTOA10	proc	far
		push	bp
		mov	bp,sp
		push	si
		push	di
		push	ds
		les	ax,[bp+0Ah]
		mov	dx,es
		les	di,[bp+6]
		call	RTL_LTOA_CORE
		pop	ds
		pop	di
		pop	si
		pop	bp
		ret	8
RTL_LTOA10	endp

RTL_UTOA10	proc	far
		push	bp
		mov	bp,sp
		push	si
		push	di
		push	ds
		xor	dx,dx
		les	di,[bp+6]
		mov	ax,[bp+0Ah]
		call	RTL_ULTOA_CORE
		pop	ds
		pop	di
		pop	si
		pop	bp
		ret	6
RTL_UTOA10	endp

CODE_40		ends
		end
