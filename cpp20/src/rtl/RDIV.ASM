; /* target: RDIV */
; /* opts: /ml */
; /* CPP.EXE module RDIV (0000:01F4..0297): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RDIV.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; Long division helpers called by compiled code: F_LDIV@ (signed /),
; F_LUDIV@ (unsigned /), F_LMOD@ (signed %) and F_LUMOD@ (unsigned %).
; Dividend and divisor are longs on the stack (dividend first); result in
; DX:AX; ret 8.  CX selects the operation for the shared body (bit 0
; unsigned, bit 1 remainder); a 16-bit divisor with a 16-bit dividend
; takes the single div.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	F_LDIV@
		public	LDIV@
		public	F_LUDIV@
		public	F_LMOD@
		public	LMOD@
		public	F_LUMOD@

LDIV@	label	far		; link: the Turbo C 2.01 name of the same helper (TC 2.01 code calls it without the F_ prefix)
F_LDIV@	proc	far
		xor	CX,CX
		jmp	short M001_L_BODY
F_LDIV@	endp
F_LUDIV@	proc	far
		mov	CX,1
		jmp	short M001_L_BODY
F_LUDIV@	endp
LMOD@	label	far		; link: the Turbo C 2.01 name of the same helper (TC 2.01 code calls it without the F_ prefix)
F_LMOD@	proc	far
		mov	CX,2
		jmp	short M001_L_BODY
F_LMOD@	endp
F_LUMOD@	proc	far
		mov	CX,3
M001_L_BODY:
		push	BP
		push	SI
		push	DI
		mov	BP,SP
		mov	DI,CX
		mov	AX,word ptr [BP+0Ah]
		mov	DX,word ptr [BP+0Ch]
		mov	BX,word ptr [BP+0Eh]
		mov	CX,word ptr [BP+10h]
		or	CX,CX
		jne	short M001_L_CHECK_SIGNS
		or	DX,DX
		je	short M001_L_SMALL_DIVIDE
		or	BX,BX
		je	short M001_L_SMALL_DIVIDE
M001_L_CHECK_SIGNS:
		test	DI,1
		jne	short M001_L_DIVIDE
		or	DX,DX
		jns	short M001_L_CHECK_DIVISOR
		neg	DX
		neg	AX
		sbb	DX,0
		or	DI,0Ch
M001_L_CHECK_DIVISOR:
		or	CX,CX
		jns	short M001_L_DIVIDE
		neg	CX
		neg	BX
		sbb	CX,0
		xor	DI,4
M001_L_DIVIDE:
		mov	BP,CX
		mov	CX,20h
		push	DI
		xor	DI,DI
		xor	SI,SI
M001_L_LOOP:
		shl	AX,1
		rcl	DX,1
		rcl	SI,1
		rcl	DI,1
		cmp	DI,BP
		jc	short M001_L_NEXT
		ja	short M001_L_SUBTRACT
		cmp	SI,BX
		jc	short M001_L_NEXT
M001_L_SUBTRACT:
		sub	SI,BX
		sbb	DI,BP
		inc	AX
M001_L_NEXT:
		loop	M001_L_LOOP
		pop	BX
		test	BX,2
		je	short M001_L_QUOTIENT
		mov	AX,SI
		mov	DX,DI
		shr	BX,1
M001_L_QUOTIENT:
		test	BX,4
		je	short M001_L_RETURN
		neg	DX
		neg	AX
		sbb	DX,0
M001_L_RETURN:
		pop	DI
		pop	SI
		pop	BP
		retf	8
M001_L_SMALL_DIVIDE:
		div	BX
		test	DI,2
		je	short M001_L_SMALL_QUOTIENT
		mov	AX,DX
M001_L_SMALL_QUOTIENT:
		xor	DX,DX
		jmp	short M001_L_RETURN
F_LUMOD@	endp
CODE0	ends
		end
