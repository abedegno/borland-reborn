; /* target: CODE_9_R9UNIT */
; /* opts: /ml */
;
; CODE_9 (from 0067h): software arithmetic on 80-bit extended reals, used
; by constant folding (CONSTFLD's FOLD_CONSTANT_NODE).  Hand-written assembly.
; Each entry is  void far pascal f(void far *a, void far *b)  and leaves
; a op b in *a:
;
;     RTL_LDOUBLE_ADD  add         RTL_LDOUBLE_MUL  multiply
;     RTL_LDOUBLE_SUB  subtract    RTL_LDOUBLE_DIV  divide
;
; Add and subtract call the common routine RTL_LDOUBLE_ADDSUB, whose extra
; argument (0 or 1) flips the sign of b.  Operands are first unpacked to
; a work format on the stack by RTL_LDOUBLE_UNPACK (LDUNPACK, kept separate:
; the C function BCC_EXTENDED_HAS_PAYLOAD, src/LDISNAN.C, lies between it
; and this module in the segment).  Multiply calls that function to tell
; a NaN operand from an infinity; the result is then the default NaN.
;
; Add and subtract reach RTL_LDOUBLE_ADDSUB with a plain `call`: TASM assembles
; a call to a far proc defined earlier in the segment as push cs / near
; call.  The section banners name the listing modules an earlier
; reconstruction split this module into.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

		extrn	RTL_LDOUBLE_UNPACK:far
		extrn	BCC_EXTENDED_HAS_PAYLOAD:near

CODE9		segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP

; ---- R9ADD (CODE_9:0067) ----

		public	RTL_LDOUBLE_ADDSUB

RTL_LDOUBLE_ADDSUB	proc	far
		push	bp
		mov	bp,sp
		sub	sp,1Ah
		push	si
		push	di
		push	ds
		lds	si,[bp+0Ah]
		lea	di,[bp-18h]
		call	RTL_LDOUBLE_UNPACK
		lds	si,[bp+6]
		lea	di,[bp-0Ch]
		call	RTL_LDOUBLE_UNPACK
		pop	ds
		lea	si,[bp-18h]
		lea	di,[bp-0Ch]
		mov	al,byte ptr [bp+0Eh]
		xor	al,byte ptr [bp-2]
		mov	byte ptr [bp-2],al
		xor	al,byte ptr [bp-0Eh]
		mov	byte ptr [bp+0Eh],al
		mov	ax,word ptr [bp-10h]
		mov	bx,word ptr [bp-4]
		cmp	ax,7FFFh
		jnc	LDADD_INF_CHECK
		cmp	bx,7FFFh
		jnc	LDADD_B_SPECIAL
		cmp	ax,bx
		jnc	LDADD_ORDERED
		mov	cl,byte ptr [bp-2]
		mov	byte ptr [bp-0Eh],cl
		mov	word ptr [bp-10h],bx
		xchg	ax,bx
		xchg	si,di
LDADD_ORDERED:
		or	bx,bx
		ja	LDADD_ALIGN
		jmp	short LDADD_RETURN_LARGER
LDADD_B_SPECIAL:
		mov	si,di
		mov	ax,word ptr [bp-4]
		mov	word ptr [bp-10h],ax
		mov	ax,word ptr [bp-2]
		mov	word ptr [bp-0Eh],ax
LDADD_INF_CHECK:
		mov	ax,word ptr [bp-10h]
		cmp	ax,word ptr [bp-4]
		jne	LDADD_RETURN_LARGER
		mov	ax,word ptr [bp-0Eh]
		cmp	ax,word ptr [bp-2]
		je	LDADD_RETURN_LARGER
		mov	word ptr [bp-0Eh],0
		mov	ax,0
		mov	bx,0
		mov	cx,0
		mov	dx,0C000h
		jmp	LDADD_STORE
LDADD_RETURN_LARGER:
		mov	ax,word ptr ss:[si]
		mov	bx,word ptr ss:[si+2]
		mov	cx,word ptr ss:[si+4]
		mov	dx,word ptr ss:[si+6]
		jmp	LDADD_STORE
LDADD_ALIGN:
		sub	ax,bx
		cmp	ax,40h
		jg	LDADD_RETURN_LARGER
		mov	byte ptr [bp-1Ah],al
		mov	ax,word ptr ss:[di]
		mov	bx,word ptr ss:[di+2]
		mov	cx,word ptr ss:[di+4]
		mov	dx,word ptr ss:[di+6]
		mov	byte ptr [bp-19h],0
		sub	byte ptr [bp-1Ah],8
		jl	LDADD_SHIFT_BITS
LDADD_SHIFT_BYTE_LOOP:
		mov	byte ptr [bp-19h],al
		mov	al,ah
		mov	ah,bl
		mov	bl,bh
		mov	bh,cl
		mov	cl,ch
		mov	ch,dl
		mov	dl,dh
		mov	dh,0
		sub	byte ptr [bp-1Ah],8
		jge	LDADD_SHIFT_BYTE_LOOP
LDADD_SHIFT_BITS:
		and	byte ptr [bp-1Ah],7
		je	LDADD_ADD_OR_SUB
LDADD_SHIFT_BIT_LOOP:
		shr	dx,1
		rcr	cx,1
		rcr	bx,1
		rcr	ax,1
		rcr	byte ptr [bp-19h],1
		dec	byte ptr [bp-1Ah]
		jne	LDADD_SHIFT_BIT_LOOP
LDADD_ADD_OR_SUB:
		sub	di,di
		cmp	byte ptr [bp+0Eh],0
		jne	LDADD_SUBTRACT
		add	ax,word ptr ss:[si]
		adc	bx,word ptr ss:[si+2]
		adc	cx,word ptr ss:[si+4]
		adc	dx,word ptr ss:[si+6]
		jnc	LDADD_ROUND
		rcr	dx,1
		rcr	cx,1
		rcr	bx,1
		rcr	ax,1
		rcr	byte ptr [bp-19h],1
		inc	word ptr [bp-10h]
		jmp	short LDADD_ROUND
LDADD_SUBTRACT:
		xor	byte ptr [bp-0Eh],1
		sub	ax,word ptr ss:[si]
		sbb	bx,word ptr ss:[si+2]
		sbb	cx,word ptr ss:[si+4]
		sbb	dx,word ptr ss:[si+6]
		jnc	LDADD_NORMALIZE
		xor	byte ptr [bp-0Eh],1
		not	dx
		not	cx
		not	bx
		not	ax
		neg	byte ptr [bp-19h]
		cmc
		adc	ax,di
		adc	bx,di
		adc	cx,di
		adc	dx,di
LDADD_NORMALIZE:
		mov	si,40h
		or	dh,dh
		js	LDADD_ROUND
LDADD_NORM_LOOP:
		dec	si
		je	LDADD_RESULT_ZERO
		shl	byte ptr [bp-19h],1
		rcl	ax,1
		rcl	bx,1
		rcl	cx,1
		adc	dx,dx
		jns	LDADD_NORM_LOOP
		sub	si,40h
		add	word ptr [bp-10h],si
		jmp	LDADD_ROUND
LDADD_RESULT_ZERO:
		mov	word ptr [bp-10h],0
		mov	byte ptr [bp-0Eh],0
		jmp	short LDADD_STORE
LDADD_ROUND:
		shl	byte ptr [bp-19h],1
		adc	ax,di
		adc	bx,di
		adc	cx,di
		adc	dx,di
		jnc	LDADD_CHECK_RANGE
		rcr	dx,1
		inc	word ptr [bp-10h]
LDADD_CHECK_RANGE:
		cmp	word ptr [bp-10h],7FFFh
		jnc	LDADD_OVERFLOW
		cmp	word ptr [bp-10h],0
		je	LDADD_UNDERFLOW
LDADD_STORE:
		les	di,[bp+0Ah]
		cld
		stosw
		xchg	ax,bx
		stosw
		xchg	ax,cx
		stosw
		xchg	ax,dx
		stosw
		mov	ax,word ptr [bp-10h]
		shl	ax,1
		or	al,byte ptr [bp-0Eh]
		ror	ax,1
		stosw
		jmp	short LDADD_RETURN
LDADD_OVERFLOW:
		mov	word ptr [bp-10h],7FFFh
		jmp	short LDADD_ZERO_MANTISSA
LDADD_UNDERFLOW:
		mov	word ptr [bp-10h],0
LDADD_ZERO_MANTISSA:
		sub	ax,ax
		mov	bx,ax
		mov	cx,ax
		mov	dx,ax
		jmp	short LDADD_STORE
LDADD_RETURN:
		pop	di
		pop	si
		mov	sp,bp
		pop	bp
		retf	0Ah
RTL_LDOUBLE_ADDSUB	endp

; ---- R9ADDPOS (CODE_9:022F) ----

		public	RTL_LDOUBLE_ADD

RTL_LDOUBLE_ADD	proc	far
		push	bp
		mov	bp,sp
		mov	al,0
		push	ax
		push	word ptr [bp+0Ch]
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	RTL_LDOUBLE_ADDSUB
		pop	bp
		retf	8
RTL_LDOUBLE_ADD	endp

; ---- R9ADDNEG (CODE_9:0249) ----

		public	RTL_LDOUBLE_SUB

RTL_LDOUBLE_SUB	proc	far
		push	bp
		mov	bp,sp
		mov	al,1
		push	ax
		push	word ptr [bp+0Ch]
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		call	RTL_LDOUBLE_ADDSUB
		pop	bp
		retf	8
RTL_LDOUBLE_SUB	endp

; ---- R9MUL (CODE_9:0263) ----

		public	RTL_LDOUBLE_MUL

RTL_LDOUBLE_MUL	proc	far
		push	bp
		mov	bp,sp
		sub	sp,18h
		push	si
		push	di
		push	ds
		lds	si,[bp+0Ah]
		lea	di,[bp-18h]
		call	RTL_LDOUBLE_UNPACK
		lds	si,[bp+6]
		lea	di,[bp-0Ch]
		call	RTL_LDOUBLE_UNPACK
		pop	ds
		mov	cl,byte ptr [bp-2]
		xor	byte ptr [bp-0Eh],cl
		mov	bx,word ptr [bp-4]
		mov	ax,word ptr [bp-10h]
		cmp	ax,7FFFh
		jnc	LDMUL_A_SPECIAL
		cmp	bx,7FFFh
		jnc	LDMUL_B_SPECIAL
		cmp	ax,bx
		jc	LDMUL_SUM_EXPONENTS
		xchg	ax,bx
LDMUL_SUM_EXPONENTS:
		or	ax,ax
		je	LDMUL_RESULT_ZERO
		add	ax,bx
		sub	ax,3FFEh
		jc	LDMUL_RESULT_ZERO
		jmp	LDMUL_MULTIPLY
LDMUL_OVERFLOW:
		mov	di,7FFFh
		mov	dx,8000h
		jmp	short LDMUL_CLEAR_LOW
LDMUL_RESULT_ZERO:
		sub	di,di
		mov	dx,0
LDMUL_CLEAR_LOW:
		sub	ax,ax
		mov	bx,ax
		mov	cx,ax
		jmp	LDMUL_STORE
LDMUL_A_SPECIAL:
		cmp	word ptr [bp-4],0
		je	LDMUL_A_NAN
		push	ss
		lea	ax,[bp-18h]
		push	ax
		call	BCC_EXTENDED_HAS_PAYLOAD
		or	ax,ax
		je	LDMUL_A_INFINITE
LDMUL_A_NAN:
		jmp	short LDMUL_DEFAULT_NAN
LDMUL_A_INFINITE:
		les	bx,[bp+0Ah]
		and	word ptr es:[bx+8],7FFFh
		test	word ptr [bp-0Eh],0FFh
		je	LDMUL_A_INF_DONE
		les	bx,[bp+0Ah]
		xor	word ptr es:[bx+8],8000h
LDMUL_A_INF_DONE:
		jmp	LDMUL_RETURN
LDMUL_B_SPECIAL:
		cmp	word ptr [bp-10h],0
		je	LDMUL_B_NAN
		push	ss
		lea	ax,[bp-0Ch]
		push	ax
		call	BCC_EXTENDED_HAS_PAYLOAD
		or	ax,ax
		je	LDMUL_B_INFINITE
LDMUL_B_NAN:
		jmp	short LDMUL_DEFAULT_NAN
LDMUL_B_INFINITE:
		mov	di,7FFFh
		mov	ax,word ptr [bp-0Ch]
		mov	bx,word ptr [bp-0Ah]
		mov	cx,word ptr [bp-8]
		mov	dx,word ptr [bp-6]
		jmp	LDMUL_STORE
LDMUL_DEFAULT_NAN:
		mov	dx,0C000h
		mov	di,7FFFh
		jmp	short LDMUL_CLEAR_LOW
LDMUL_MULTIPLY:
		mov	word ptr [bp-10h],ax
		sub	di,di
		mov	cx,di
		mov	si,di
		test	byte ptr [bp-9],80h
		je	LDMUL_TEST_A_BIT31
		mov	cx,word ptr [bp-18h]
		mov	si,word ptr [bp-16h]
LDMUL_TEST_A_BIT31:
		test	byte ptr [bp-15h],80h
		je	LDMUL_PARTIAL_PRODUCTS
		add	cx,word ptr [bp-0Ch]
		adc	si,word ptr [bp-0Ah]
		adc	di,di
		test	byte ptr [bp-9],80h
		je	LDMUL_PARTIAL_PRODUCTS
		dec	di
LDMUL_PARTIAL_PRODUCTS:
		sub	bx,bx
		mov	ax,word ptr [bp-0Ch]
		mul	word ptr [bp-14h]
		add	cx,ax
		adc	si,dx
		adc	di,0
		mov	ax,word ptr [bp-8]
		or	ax,ax
		je	LDMUL_SKIP_B_W2_LOW
		mul	word ptr [bp-18h]
		add	cx,ax
		adc	si,dx
		adc	di,0
		mov	ax,word ptr [bp-8]
		mul	word ptr [bp-16h]
		add	si,ax
		adc	di,dx
		adc	bx,0
LDMUL_SKIP_B_W2_LOW:
		mov	ax,word ptr [bp-0Ch]
		mul	word ptr [bp-12h]
		add	si,ax
		adc	di,dx
		adc	bx,0
		mov	ax,word ptr [bp-0Ah]
		mul	word ptr [bp-14h]
		add	si,ax
		adc	di,dx
		adc	bx,0
		mov	ax,word ptr [bp-6]
		or	ax,ax
		je	LDMUL_HIGH_COLUMNS
		mul	word ptr [bp-18h]
		add	si,ax
		adc	di,dx
		adc	bx,0
LDMUL_HIGH_COLUMNS:
		sub	cx,cx
		push	si
		mov	si,cx
		mov	ax,word ptr [bp-0Ah]
		mul	word ptr [bp-12h]
		add	di,ax
		adc	bx,dx
		adc	cx,0
		mov	ax,word ptr [bp-8]
		or	ax,ax
		je	LDMUL_SKIP_B_W2_HIGH
		mul	word ptr [bp-14h]
		add	di,ax
		adc	bx,dx
		adc	cx,0
		mov	ax,word ptr [bp-8]
		mul	word ptr [bp-12h]
		add	bx,ax
		adc	cx,dx
		adc	si,0
LDMUL_SKIP_B_W2_HIGH:
		mov	ax,word ptr [bp-6]
		or	ax,ax
		je	LDMUL_NORMALIZE
		mul	word ptr [bp-16h]
		add	di,ax
		adc	bx,dx
		adc	cx,0
		adc	si,0
		mov	ax,word ptr [bp-6]
		mul	word ptr [bp-14h]
		add	bx,ax
		adc	cx,dx
		adc	si,0
		mov	ax,word ptr [bp-6]
		mul	word ptr [bp-12h]
		add	cx,ax
		adc	si,dx
LDMUL_NORMALIZE:
		mov	dx,si
		xchg	ax,di
		pop	si
		mov	di,word ptr [bp-10h]
		or	dx,dx
		js	LDMUL_ROUND
		dec	di
		shl	si,1
		rcl	ax,1
		rcl	bx,1
		rcl	cx,1
		rcl	dx,1
LDMUL_ROUND:
		shl	si,1
		adc	ax,0
		adc	bx,0
		adc	cx,0
		adc	dx,0
		jnc	LDMUL_CHECK_OVERFLOW
		rcr	dx,1
		inc	di
LDMUL_CHECK_OVERFLOW:
		cmp	di,7FFFh
		jc	LDMUL_STORE
		jmp	LDMUL_OVERFLOW
LDMUL_STORE:
		mov	si,di
		les	di,[bp+0Ah]
		cld
		stosw
		xchg	ax,bx
		stosw
		xchg	ax,cx
		stosw
		xchg	ax,dx
		stosw
		xchg	ax,si
		shl	ax,1
		or	al,byte ptr [bp-0Eh]
		ror	ax,1
		stosw
LDMUL_RETURN:
		pop	di
		pop	si
		mov	sp,bp
		pop	bp
		retf	8
RTL_LDOUBLE_MUL	endp

; ---- R9DIV (CODE_9:044E) ----

		public	RTL_LDOUBLE_DIV

RTL_LDOUBLE_DIV	proc	far
		push	bp
		mov	bp,sp
		sub	sp,28h
		push	si
		push	di
		mov	word ptr [bp-4],0
		push	ds
		lds	si,[bp+0Ah]
		lea	di,[bp-28h]
		call	RTL_LDOUBLE_UNPACK
		lds	si,[bp+6]
		lea	di,[bp-1Ch]
		call	RTL_LDOUBLE_UNPACK
		pop	ds
		mov	al,byte ptr [bp-1Eh]
		xor	al,byte ptr [bp-12h]
		mov	byte ptr [bp-6],al
		mov	si,word ptr [bp-14h]
		mov	ax,word ptr [bp-20h]
		cmp	si,7FFFh
		jnc	LDDIV_RESULT_ZERO
		cmp	ax,7FFFh
		jnc	LDDIV_RETURN_A
		or	si,si
		je	LDDIV_INFINITY
		or	ax,ax
		je	LDDIV_RETURN_A
		add	ax,3FFEh
		sub	ax,si
		jc	LDDIV_RESULT_ZERO
		jmp	LDDIV_DIVIDE
LDDIV_INFINITY:
		mov	dx,7FFFh
		mov	si,8000h
		or	ax,ax
		jne	LDDIV_CLEAR_LOW
LDDIV_DEFAULT_NAN:
		mov	dx,7FFFh
		mov	si,0C000h
		jmp	short LDDIV_CLEAR_LOW
LDDIV_RESULT_ZERO:
		sub	dx,dx
		sub	si,si
		cmp	ax,7FFFh
		je	LDDIV_DEFAULT_NAN
LDDIV_CLEAR_LOW:
		sub	ax,ax
		mov	bx,ax
		mov	cx,ax
		jmp	LDDIV_STORE
LDDIV_RETURN_A:
		les	bx,[bp+0Ah]
		and	word ptr es:[bx+8],7FFFh
		test	word ptr [bp-6],0FFh
		je	LDDIV_RETURN_A_DONE
		les	bx,[bp+0Ah]
		xor	word ptr es:[bx+8],8000h
LDDIV_RETURN_A_DONE:
		jmp	LDDIV_RETURN
LDDIV_DIVIDE:
		mov	word ptr [bp-8],ax
		sub	cx,cx
		mov	dx,word ptr [bp-22h]
		mov	si,word ptr [bp-16h]
		cmp	si,dx
		ja	LDDIV_Q1_ESTIMATE
		sub	dx,si
		inc	cx
LDDIV_Q1_ESTIMATE:
		mov	ax,word ptr [bp-24h]
		div	si
		adc	ax,1
		adc	cl,ch
		mov	byte ptr [bp-1],cl
		mov	word ptr [bp-0Ah],ax
		push	ax
		mov	ax,word ptr [bp-1Ch]
		mov	bx,word ptr [bp-1Ah]
		jcxz	LDDIV_Q1_MULSUB
		mov	dx,word ptr [bp-18h]
LDDIV_Q1_SUB_LOOP:
		sub	word ptr [bp-28h],ax
		sbb	word ptr [bp-26h],bx
		sbb	word ptr [bp-24h],dx
		sbb	word ptr [bp-22h],si
		loop	LDDIV_Q1_SUB_LOOP
LDDIV_Q1_MULSUB:
		pop	si
		mul	si
		mov	word ptr [bp-4],ax
		xchg	ax,dx
		xchg	ax,bx
		mul	si
		add	bx,ax
		adc	cx,dx
		mov	ax,word ptr [bp-18h]
		mul	si
		add	cx,ax
		adc	dx,0
		xchg	ax,dx
		xchg	ax,si
		mul	word ptr [bp-16h]
		add	ax,si
		adc	dx,0
		sub	bx,word ptr [bp-28h]
		sbb	cx,word ptr [bp-26h]
		sbb	ax,word ptr [bp-24h]
		sbb	dx,word ptr [bp-22h]
		mov	word ptr [bp-28h],bx
		mov	word ptr [bp-26h],cx
		mov	word ptr [bp-24h],ax
		mov	si,word ptr [bp-16h]
		div	si
		xchg	ax,cx
		div	si
		sub	dx,dx
		stc
		adc	ax,dx
		adc	cx,dx
		sub	dx,ax
		mov	word ptr [bp-0Ch],dx
		sbb	word ptr [bp-0Ah],cx
		sbb	byte ptr [bp-1],0
		push	ax
		mov	ax,word ptr [bp-1Ch]
		mov	bx,word ptr [bp-1Ah]
		jcxz	LDDIV_Q2_MULSUB
		mov	dx,word ptr [bp-18h]
LDDIV_Q2_SUB_LOOP:
		sub	word ptr [bp-4],ax
		sbb	word ptr [bp-28h],bx
		sbb	word ptr [bp-26h],dx
		sbb	word ptr [bp-24h],si
		loop	LDDIV_Q2_SUB_LOOP
LDDIV_Q2_MULSUB:
		pop	si
		mul	si
		xchg	ax,dx
		xchg	ax,bx
		mul	si
		add	bx,ax
		adc	cx,dx
		mov	ax,word ptr [bp-18h]
		mul	si
		add	cx,ax
		adc	dx,0
		xchg	ax,dx
		xchg	ax,si
		mul	word ptr [bp-16h]
		add	ax,si
		adc	dx,0
		sub	bx,word ptr [bp-4]
		sbb	cx,word ptr [bp-28h]
		sbb	ax,word ptr [bp-26h]
		sbb	dx,word ptr [bp-24h]
		mov	word ptr [bp-4],bx
		mov	word ptr [bp-28h],cx
		mov	word ptr [bp-26h],ax
		mov	si,word ptr [bp-16h]
		div	si
		xchg	ax,cx
		div	si
		sub	dx,dx
		stc
		adc	ax,dx
		adc	cx,dx
		mov	word ptr [bp-0Eh],ax
		add	word ptr [bp-0Ch],cx
		adc	word ptr [bp-0Ah],dx
		adc	byte ptr [bp-1],dl
		xchg	ax,si
		mov	dx,word ptr [bp-1Ah]
		xchg	ax,dx
		mov	bx,word ptr [bp-18h]
		jcxz	LDDIV_Q3_MULSUB
LDDIV_Q3_SUB_LOOP:
		sub	word ptr [bp-4],ax
		sbb	word ptr [bp-28h],bx
		sbb	word ptr [bp-26h],dx
		loop	LDDIV_Q3_SUB_LOOP
LDDIV_Q3_MULSUB:
		mul	si
		xchg	ax,dx
		xchg	ax,bx
		mul	si
		add	bx,ax
		adc	cx,dx
		mov	ax,word ptr [bp-16h]
		mul	si
		add	ax,cx
		adc	dx,0
		sub	bx,word ptr [bp-4]
		sbb	ax,word ptr [bp-28h]
		sbb	dx,word ptr [bp-26h]
		mov	word ptr [bp-4],bx
		mov	word ptr [bp-28h],ax
		mov	si,word ptr [bp-18h]
		add	si,si
		mov	si,word ptr [bp-16h]
		adc	si,0
		jnc	LDDIV_Q4_DIVIDE
		xchg	bx,dx
		jmp	short LDDIV_COMBINE
LDDIV_Q4_DIVIDE:
		shl	bx,1
		rcl	ax,1
		rcl	dx,1
		div	si
		xchg	ax,bx
		div	si
		shr	bx,1
		rcr	ax,1
		rcr	dh,1
LDDIV_COMBINE:
		mov	cx,0FFFFh
		mov	si,cx
		mov	dl,cl
		not	bx
		not	ax
		neg	dh
		cmc
		adc	ax,0
		adc	bx,word ptr [bp-0Eh]
		adc	cx,word ptr [bp-0Ch]
		adc	si,word ptr [bp-0Ah]
		adc	dl,byte ptr [bp-1]
		shr	dl,1
		jnc	LDDIV_ROUND
		rcr	si,1
		rcr	cx,1
		rcr	bx,1
		rcr	ax,1
		rcr	dh,1
		inc	word ptr [bp-8]
LDDIV_ROUND:
		sub	di,di
		add	dh,dh
		adc	ax,di
		adc	bx,di
		adc	cx,di
		adc	si,di
		adc	dl,0
		mov	dx,word ptr [bp-8]
		je	LDDIV_CHECK_OVERFLOW			; flags from adc dl,0 (mov keeps them)
		mov	si,8000h
		inc	dx
LDDIV_CHECK_OVERFLOW:
		cmp	dx,7FFFh
		jc	LDDIV_CHECK_AGAIN
		jmp	LDDIV_INFINITY
LDDIV_CHECK_AGAIN:
		cmp	dx,7FFFh		; repeats the test above; never taken
		jc	LDDIV_STORE
		jmp	LDDIV_INFINITY
LDDIV_STORE:
		les	di,[bp+0Ah]
		cld
		stosw
		xchg	ax,bx
		stosw
		xchg	ax,cx
		stosw
		xchg	ax,si
		stosw
		xchg	ax,dx
		shl	ax,1
		or	al,byte ptr [bp-6]
		ror	ax,1
		stosw
LDDIV_RETURN:
		pop	di
		pop	si
		mov	sp,bp
		pop	bp
		ret	8
RTL_LDOUBLE_DIV	endp

CODE9		ends
		end

