; /* target: ovr135_C141UNIT */
; /* opts: /ml */
;
; CO04E: LMUL_WITH_OVERFLOW, the signed 32-bit multiply used by constant folding
; (CONSTFLD's FOLD_CONSTANT_NODE).  Hand-written assembly in the original: the
; imul-then-jo overflow tests, the xchg and test ax,ax are not BCC idioms,
; and it reports overflow to its caller in OF, which a C function cannot do.
;
; Callers declare it   long far pascal LMUL_WITH_OVERFLOW(long a, long b);
; Pascal order pushes a first, so b is nearer the frame.
;
; Result: DX:AX = a.lo*b.lo (unsigned) + ((a.hi*b.lo + b.hi*a.lo) << 16),
; the product mod 2^32.  A cross product is skipped when its high-word
; factor is zero.
; Overflow check (approximate, as in the original): OF is set if either
; signed 16-bit cross product overflows (imul; jo) or their sum does
; (add cx,ax; jo); DX:AX then holds a partial value, which the caller
; replaces with 1.  Otherwise OF is whatever the final add dx,cx leaves.  The check
; misses some overflows (a = b = 10000h gives 0 with OF clear) and flags
; some products that fit.

C141UNIT_TEXT	segment byte public 'CODE'
		assume	cs:C141UNIT_TEXT

		public	LMUL_WITH_OVERFLOW

LMUL_WITH_OVERFLOW	proc	far
b_lo		equ	word ptr [bp+6]
b_hi		equ	word ptr [bp+8]
a_lo		equ	word ptr [bp+0Ah]
a_hi		equ	word ptr [bp+0Ch]
		push	bp
		mov	bp,sp
		push	si
		mov	ax,a_hi
		mov	bx,b_lo
		test	ax,ax
		je	high_b			; a.hi = 0: no a.hi*b.lo term
		imul	bx
		jo	done
high_b:
		mov	cx,b_hi
		xchg	cx,ax			; cx = a.hi*b.lo, ax = b.hi
		mov	si,a_lo
		test	ax,ax
		je	low			; b.hi = 0: no b.hi*a.lo term
		imul	si
		jo	done
		add	cx,ax			; cx = sum of the cross products
		jo	done
low:
		mov	ax,si
		mul	bx			; dx:ax = a.lo*b.lo
		add	dx,cx
done:
		pop	si
		pop	bp
		ret	8
LMUL_WITH_OVERFLOW	endp

C141UNIT_TEXT	ends

; Empty data segments, as in the original module (reconstructed/STOVR97.ASM).
DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		end
