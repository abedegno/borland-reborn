; /* target: CODE_13_RPOW10 */
; /* opts: /ml */
;
; Segment 0A1A:000C..0087 (CODE_13 through CODE_14:0007), Borland run-time
; library floating point: scale a long double by a power of ten.
;   void pascal _pow10scale(int n, long double far *x)
; |n| is limited to 4999.  10^(|n| mod 8) comes from a table of unsigned longs
; (converted by RTL_ULONG_TO_LDOUBLE) and is multiplied (RTL_LDOUBLE_MUL) by the long
; double powers 10^8, 10^16, ... picked by the remaining bits; *x is then
; multiplied (n > 0) or divided (RTL_LDOUBLE_DIV, n < 0) by the result.  Kept as
; assembly like the other floating-point modules: its far-pointer pushes (les
; ax / push es / push ax) are not BC 2.0's.  The first 12 bytes of the old
; CODE_13 block were ULONG2LD's tail; the last 8 bytes lay in CODE_14.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

		extrn	RTL_ULONG_TO_LDOUBLE:far
		extrn	RTL_LDOUBLE_MUL:far
		extrn	RTL_LDOUBLE_DIV:far

CODE_13		segment byte public 'CODE'
		assume	cs:CODE_13
		public	RTL_LDOUBLE_SCALE_POW10

POW10_SMALL	equ	5AFCh			; DS:5AFC, 10^0..10^7 as unsigned longs
POW10_LARGE	equ	5B1Ch			; DS:5B1C, 10^8, 10^16, ... as long doubles

RTL_LDOUBLE_SCALE_POW10	proc	far
		push	bp
		mov	bp,sp
		sub	sp,0Ah
		push	si
		push	di
		mov	si,word ptr [bp+0Ah]
		or	si,si
		je	M_RETURN
		jns	M_ABS
		neg	si
M_ABS:
		cmp	si,1387h
		jbe	M_LIMITED
		mov	si,1387h
M_LIMITED:
		mov	bx,7
		and	bx,si
		shl	bx,1
		shl	bx,1
		add	bx,POW10_SMALL
		push	word ptr [bx+2]
		push	word ptr [bx]
		lea	ax,[bp-0Ah]
		push	ss
		push	ax
		call	far ptr RTL_ULONG_TO_LDOUBLE
		mov	cl,3
		shr	si,cl
		mov	di,POW10_LARGE
M_POWLOOP:
		or	si,si
		je	M_APPLY
		shr	si,1
		jae	M_NEXTPOW
		lea	ax,[bp-0Ah]
		push	ss
		push	ax
		push	ds
		push	di
		call	far ptr RTL_LDOUBLE_MUL
M_NEXTPOW:
		add	di,0Ah
		jmp	M_POWLOOP
M_APPLY:
		les	ax,dword ptr [bp+6]
		push	es
		push	ax
		lea	ax,[bp-0Ah]
		push	ss
		push	ax
		cmp	word ptr [bp+0Ah],0
		jns	M_MULTIPLY
		call	far ptr RTL_LDOUBLE_DIV
		jmp	short M_RETURN
M_MULTIPLY:
		call	far ptr RTL_LDOUBLE_MUL
M_RETURN:
		pop	di
		pop	si
		mov	sp,bp
		pop	bp
		retf	6
RTL_LDOUBLE_SCALE_POW10	endp

CODE_13		ends
		end
