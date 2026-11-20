DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_12
; BEGIN R12EXT (listing CODE_12:0006)

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	BCC_FAR_9FE6
		public	BCC_NEAR_9FE6

BCC_NEAR_9FE6	label	near
BCC_FAR_9FE6	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		mov	AX,word ptr [SI]
		mov	BX,word ptr [SI+2]
		mov	CX,word ptr [SI+4]
		mov	DX,word ptr [SI+6]
		pop	DS
		mov	DI,0
		or	DX,DX
		jl	short M001_L_A014
		jg	short M001_L_A029
		or	CX,CX
		jne	short M001_L_A029
		or	BX,BX
		jne	short M001_L_A029
		or	AX,AX
		jne	short M001_L_A029
		sub	SI,SI
		jmp	short M001_L_A051
M001_L_A014:
		not	DX
		not	CX
		not	BX
		neg	AX
		cmc
		adc	BX,0
		adc	CX,0
		adc	DX,0
		mov	DI,1
M001_L_A029:
		mov	SI,40h
M001_L_A02C:
		or	DX,DX
		jne	short M001_L_A03A
		xchg	DX,CX
		xchg	CX,BX
		xchg	AX,BX
		sub	SI,10h
		jmp	short M001_L_A02C
M001_L_A03A:
		js	short M001_L_A047
M001_L_A03C:
		dec	SI
		add	AX,AX
		adc	BX,BX
		adc	CX,CX
		adc	DX,DX
		jns	short M001_L_A03C
M001_L_A047:
		add	SI,3FFEh
		shl	SI,1
		or	SI,DI
		ror	SI,1
M001_L_A051:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		xchg	AX,SI
		stosw
		pop	DI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_9FE6	endp
CODE12	ends

; END R12EXT
; BEGIN R12TRUNC (listing CODE_12:0084)

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	BCC_FAR_A064
		public	BCC_NEAR_A064

BCC_NEAR_A064	label	near
BCC_FAR_A064	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		mov	DI,7FFFh
		and	DI,word ptr [SI+8]
		sub	DI,3FFEh
		cmp	DI,3Fh
		jg	short M002_L_A084
		or	DI,DI
		jge	short M002_L_A08F
		sub	DX,DX
		jmp	short M002_L_A087
M002_L_A084:
		mov	DX,8000h
M002_L_A087:
		sub	AX,AX
		mov	BX,AX
		mov	CX,AX
		jmp	short M002_L_A0D8
M002_L_A08F:
		mov	DX,word ptr [SI+6]
		mov	CX,word ptr [SI+4]
		mov	BX,word ptr [SI+2]
		mov	AX,word ptr [SI]
		sub	DI,30h
		ja	short M002_L_A0AF
M002_L_A09F:
		mov	AX,BX
		mov	BX,CX
		mov	CX,DX
		sub	DX,DX
		add	DI,10h
		jle	short M002_L_A09F
		and	DI,0Fh
M002_L_A0AF:
		neg	DI
		je	short M002_L_A0C1
		add	DI,10h
M002_L_A0B6:
		shr	DX,1
		rcr	CX,1
		rcr	BX,1
		rcr	AX,1
		dec	DI
		jg	short M002_L_A0B6
M002_L_A0C1:
		test	byte ptr [SI+9],80h
		je	short M002_L_A0D8
		sub	SI,SI
		not	DX
		not	CX
		not	BX
		neg	AX
		cmc
		adc	BX,SI
		adc	CX,SI
		adc	DX,SI
M002_L_A0D8:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		sub	DI,8
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_A064	endp
CODE12	ends

; END R12TRUNC
; BEGIN R12I16 (listing CODE_12:010D)




CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	BCC_FAR_A0ED

BCC_FAR_A0ED	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	CS
		db	0E8h
		dw	0FF62h
		mov	AX,word ptr [BP-6]
		cwd
		cmp	DX,word ptr [BP-4]
		jne	short M003_L_A116
		cmp	DX,word ptr [BP-2]
		jne	short M003_L_A116
		xchg	AX,DX
		mov	AX,word ptr [BP-8]
		jmp	short M003_L_A11B
M003_L_A116:
		sub	AX,AX
		mov	DX,8000h
M003_L_A11B:
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_A0ED	endp
CODE12	ends

; END R12I16
; BEGIN R12I32 (listing CODE_12:0141)




CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	BCC_FAR_A121

BCC_FAR_A121	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	SS
		lea	AX,[BP-8]
		push	AX
		push	CS
		db	0E8h
		dw	0FF2Eh
		mov	AX,word ptr [BP-8]
		mov	DX,word ptr [BP-6]
		mov	CX,word ptr [BP-4]
		or	CX,word ptr [BP-2]
		je	short M004_L_A149
		mov	AX,0FFFFh
		mov	DX,AX
M004_L_A149:
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_A121	endp
CODE12	ends

; END R12I32
; BEGIN R12FROMI (listing CODE_12:016F)




CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP
		public	BCC_FAR_A14F

BCC_FAR_A14F	proc	far
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
		db	0E8h
		dw	0FE6Fh
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_A14F	endp
CODE12	ends

; END R12FROMI
; BEGIN R12FROMU (listing CODE_12:019D)

CODE12	segment byte public 'CODE'
		assume	cs:CODE12,ds:DGROUP


		public	BCC_FAR_A17D

BCC_FAR_A17D	proc	far
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
BCC_FAR_A17D	endp
		db	0FFh,076h,006h,00Eh,0E8h,040h,0FEh,08Bh,0E5h,05Dh,0CAh,008h,000h	; rest of the function (formerly R12BYTE and CODE_13:0000..000B)
CODE12	ends

; END R12FROMU
		end
