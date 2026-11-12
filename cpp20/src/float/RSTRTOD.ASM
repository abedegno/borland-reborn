; /* target: RSTRTOD */
; /* opts: /ml */
; /* CPP.EXE module RSTRTOD (1128:0008..0129): source taken unchanged from the BCC.EXE
;    reconstruction (src/float/RSTRTOD.ASM); its code is the same in both programs. */
;
; RTL_SCAN_LDOUBLE, Borland run-time
; library floating point (hand-written assembly): the decimal scanner behind
; strtod/atof.
;   int pascal _scantod(char far *s, long double far *result)
; Reads digits into a 64-bit mantissa in bx:cx:dx:di (multiplying by 10 with
; shifts and adds; digits past 64 bits only raise the decimal exponent), an
; optional '.', and an optional e/E exponent with sign (limited to 1000).
; The mantissa goes to RTL_INT64_TO_LDOUBLE (I642LD) for conversion and RTL_LDOUBLE_SCALE_POW10
; (RPOW10) scales the result, in two steps when the exponent is below -4096.
; Returns the number of characters consumed (end of scan - s).  The caller
; in CPP.EXE is the lexer (LEXER.C), for floating constants.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

		extrn	RTL_INT64_TO_LDOUBLE:far
		extrn	RTL_LDOUBLE_SCALE_POW10:far

CODE_14		segment byte public 'CODE'
		assume	cs:CODE_14
		public	RTL_SCAN_LDOUBLE

; [bp+0Ah] s, [bp+6] result; [bp-8] 64-bit mantissa; [bp-0Ah] digits after
; the point step: 0 before a '.', -1 after it, added per digit; [bp-0Ch] decimal exponent
RTL_SCAN_LDOUBLE	proc	far
		push	bp
		mov	bp,sp
		sub	sp,0Ch
		push	si
		push	di
		push	ds
		lds	si,dword ptr [bp+0Ah]
		cld
		xor	di,di
		mov	dx,di
		mov	cx,di
		mov	bx,di
		mov	word ptr [bp-0Ch],di
		mov	word ptr [bp-0Ah],di
M_MANTISSA:
		lodsb
		cmp	al,30h
		jb	M_NOTDIGIT
		cmp	al,39h
		ja	M_NOTDIGIT
		sub	al,30h
		cbw
		or	bx,bx
		jne	M_BIG
		or	cx,cx
		jne	M_TIMES10
		or	dx,dx
		jne	M_TIMES10
		xchg	di,ax
		mov	dx,0Ah
		mul	dx
M_ADDDIGIT:
		add	di,ax
		adc	dx,0
		adc	cx,0
		adc	bx,0
		mov	ax,word ptr [bp-0Ah]
		add	word ptr [bp-0Ch],ax
		jmp	M_MANTISSA
M_BIG:
		cmp	bx,0CCCh
		jae	M_OVERFLOW
M_TIMES10:
		push	ax
		shl	di,1
		rcl	dx,1
		rcl	cx,1
		rcl	bx,1
		push	bx
		push	cx
		push	dx
		push	di
		shl	di,1
		rcl	dx,1
		rcl	cx,1
		rcl	bx,1
		shl	di,1
		rcl	dx,1
		rcl	cx,1
		rcl	bx,1
		pop	ax
		add	di,ax
		pop	ax
		adc	dx,ax
		pop	ax
		adc	cx,ax
		pop	ax
		adc	bx,ax
		pop	ax
		jmp	M_ADDDIGIT
M_OVERFLOW:
		mov	ax,word ptr [bp-0Ah]
		inc	ax
		add	word ptr [bp-0Ch],ax
		jmp	M_MANTISSA
M_NOTDIGIT:
		cmp	al,2Eh
		jne	M_EXPONENT
		cmp	word ptr [bp-0Ah],0
		jne	M_EXPONENT
		dec	word ptr [bp-0Ah]
		jmp	M_MANTISSA
M_EXPONENT:
		mov	word ptr [bp-8],di
		mov	word ptr [bp-6],dx
		mov	word ptr [bp-4],cx
		mov	word ptr [bp-2],bx
		mov	di,word ptr [bp-0Ch]
		cmp	al,45h
		je	M_EXPSIGN
		cmp	al,65h
		jne	M_CONVERT
M_EXPSIGN:
		xor	bx,bx
		lodsb
		mov	cl,al
		cmp	al,2Dh
		je	M_EXPNEXT
		cmp	al,2Bh
		je	M_EXPNEXT
M_EXPDIGIT:
		cmp	al,30h
		jb	M_EXPEND
		cmp	al,39h
		ja	M_EXPEND
		cmp	bx,3E8h
		jae	M_EXPEND
		sub	al,30h
		cbw
		shl	bx,1
		mov	dx,bx
		shl	bx,1
		shl	bx,1
		add	bx,dx
		add	bx,ax
M_EXPNEXT:
		lodsb
		jmp	M_EXPDIGIT
M_EXPEND:
		cmp	cl,2Dh
		jne	M_EXPPOS
		neg	bx
M_EXPPOS:
		add	di,bx
M_CONVERT:
		pop	ds
		lea	ax,[bp-8]
		push	ss
		push	ax
		les	ax,dword ptr [bp+6]
		push	es
		push	ax
		call	far ptr RTL_INT64_TO_LDOUBLE
		mov	ax,0F000h
		cmp	di,ax
		jge	M_SCALE
		sub	di,ax
		push	ax
		les	ax,dword ptr [bp+6]
		push	es
		push	ax
		call	far ptr RTL_LDOUBLE_SCALE_POW10
M_SCALE:
		push	di
		les	ax,dword ptr [bp+6]
		push	es
		push	ax
		call	far ptr RTL_LDOUBLE_SCALE_POW10
		xchg	si,ax
		dec	ax
		sub	ax,word ptr [bp+0Ah]
		jmp	short M_RETURN
M_RETURN:
		pop	di
		pop	si
		mov	sp,bp
		pop	bp
		retf	8
RTL_SCAN_LDOUBLE	endp
CODE_14		ends
		end
