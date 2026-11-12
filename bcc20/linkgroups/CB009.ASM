DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_9
; BEGIN R9UNPACK (listing CODE_9:000B)

CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP


		public	BCC_FAR_970B

BCC_FAR_970B	proc	far
		push	SI
		push	DI
		push	SS
		pop	ES
		sub	DX,DX
		cld
		mov	CX,4
		rep movsw
		lodsw
		shl	AX,1
		rcl	DX,1
		shr	AX,1
		stosw
		xchg	AX,DX
		stosw
		pop	DI
		pop	SI
		retf
BCC_FAR_970B	endp
CODE9	ends

; END R9UNPACK
; BEGIN R9SPEC (listing CODE_9:0024)

CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP


		public	BCC_NEAR_9724

BCC_NEAR_9724	proc	near
		push	BP
		mov	BP,SP
		les	BX,[BP+4]
		cmp	word ptr ES:[BX+8],7FFFh
		jne	short M002_L_975F
		les	BX,[BP+4]
		cmp	word ptr ES:[BX+6],8000h
		jne	short M002_L_975A
		les	BX,[BP+4]
		cmp	word ptr ES:[BX],0
		jne	short M002_L_975A
		les	BX,[BP+4]
		cmp	word ptr ES:[BX+2],0
		jne	short M002_L_975A
		les	BX,[BP+4]
		cmp	word ptr ES:[BX+4],0
		je	short M002_L_975F
M002_L_975A:
		mov	AX,1
		jmp	short M002_L_9761
M002_L_975F:
		xor	AX,AX
M002_L_9761:
		jmp	short M002_L_9763
M002_L_9763:
		pop	BP
		ret	4
BCC_NEAR_9724	endp
CODE9	ends

; END R9SPEC
; BEGIN R9UNIT (listing CODE_9:0067)




CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP
		public	BCC_FAR_9767
		public	BCC_NEAR_9767

BCC_NEAR_9767	label	near
BCC_FAR_9767	proc	far
		push	BP
		mov	BP,SP
		sub	SP,1Ah
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-18h]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		lds	SI,[BP+6]
		lea	DI,[BP-0Ch]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		pop	DS
		lea	SI,[BP-18h]
		lea	DI,[BP-0Ch]
		mov	AL,byte ptr [BP+0Eh]
		xor	AL,byte ptr [BP-2]
		mov	byte ptr [BP-2],AL
		xor	AL,byte ptr [BP-0Eh]
		mov	byte ptr [BP+0Eh],AL
		mov	AX,word ptr [BP-10h]
		mov	BX,word ptr [BP-4]
		cmp	AX,7FFFh
		jnc	short M003_L_97D1
		cmp	BX,7FFFh
		jnc	short M003_L_97C3
		cmp	AX,BX
		jnc	short M003_L_97BD
		mov	CL,byte ptr [BP-2]
		mov	byte ptr [BP-0Eh],CL
		mov	word ptr [BP-10h],BX
		xchg	AX,BX
		xchg	SI,DI
M003_L_97BD:
		or	BX,BX
		ja	short M003_L_9807
		jmp	short M003_L_97F5
M003_L_97C3:
		mov	SI,DI
		mov	AX,word ptr [BP-4]
		mov	word ptr [BP-10h],AX
		mov	AX,word ptr [BP-2]
		mov	word ptr [BP-0Eh],AX
M003_L_97D1:
		mov	AX,word ptr [BP-10h]
		cmp	AX,word ptr [BP-4]
		jne	short M003_L_97F5
		mov	AX,word ptr [BP-0Eh]
		cmp	AX,word ptr [BP-2]
		je	short M003_L_97F5
		mov	word ptr [BP-0Eh],0
		mov	AX,0
		mov	BX,0
		mov	CX,0
		mov	DX,0C000h
		db	0E9h
		dw	00104h
M003_L_97F5:
		mov	AX,word ptr SS:[SI]
		mov	BX,word ptr SS:[SI+2]
		mov	CX,word ptr SS:[SI+4]
		mov	DX,word ptr SS:[SI+6]
		db	0E9h
		dw	000F2h
M003_L_9807:
		sub	AX,BX
		cmp	AX,40h
		jg	short M003_L_97F5
		mov	byte ptr [BP-1Ah],AL
		mov	AX,word ptr SS:[DI]
		mov	BX,word ptr SS:[DI+2]
		mov	CX,word ptr SS:[DI+4]
		mov	DX,word ptr SS:[DI+6]
		mov	byte ptr [BP-19h],0
		sub	byte ptr [BP-1Ah],8
		jl	short M003_L_9843
M003_L_982A:
		mov	byte ptr [BP-19h],AL
		mov	AL,AH
		mov	AH,BL
		mov	BL,BH
		mov	BH,CL
		mov	CL,CH
		mov	CH,DL
		mov	DL,DH
		mov	DH,0
		sub	byte ptr [BP-1Ah],8
		jge	short M003_L_982A
M003_L_9843:
		and	byte ptr [BP-1Ah],7
		je	short M003_L_9859
M003_L_9849:
		shr	DX,1
		rcr	CX,1
		rcr	BX,1
		rcr	AX,1
		rcr	byte ptr [BP-19h],1
		dec	byte ptr [BP-1Ah]
		jne	short M003_L_9849
M003_L_9859:
		sub	DI,DI
		cmp	byte ptr [BP+0Eh],0
		jne	short M003_L_9882
		add	AX,word ptr SS:[SI]
		adc	BX,word ptr SS:[SI+2]
		adc	CX,word ptr SS:[SI+4]
		adc	DX,word ptr SS:[SI+6]
		jnc	short M003_L_98DA
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
		rcr	AX,1
		rcr	byte ptr [BP-19h],1
		inc	word ptr [BP-10h]
		jmp	short M003_L_98DA
M003_L_9882:
		xor	byte ptr [BP-0Eh],1
		sub	AX,word ptr SS:[SI]
		sbb	BX,word ptr SS:[SI+2]
		sbb	CX,word ptr SS:[SI+4]
		sbb	DX,word ptr SS:[SI+6]
		jnc	short M003_L_98AF
		xor	byte ptr [BP-0Eh],1
		not	DX
		not	CX
		not	BX
		not	AX
		neg	byte ptr [BP-19h]
		cmc
		adc	AX,DI
		adc	BX,DI
		adc	CX,DI
		adc	DX,DI
M003_L_98AF:
		mov	SI,40h
		or	DH,DH
		js	short M003_L_98DA
M003_L_98B6:
		dec	SI
		je	short M003_L_98CF
		shl	byte ptr [BP-19h],1
		rcl	AX,1
		rcl	BX,1
		rcl	CX,1
		adc	DX,DX
		jns	short M003_L_98B6
		sub	SI,40h
		add	word ptr [BP-10h],SI
		jmp	short M003_L_98DA
		nop
M003_L_98CF:
		mov	word ptr [BP-10h],0
		mov	byte ptr [BP-0Eh],0
		jmp	short M003_L_98F9
M003_L_98DA:
		shl	byte ptr [BP-19h],1
		adc	AX,DI
		adc	BX,DI
		adc	CX,DI
		adc	DX,DI
		jnc	short M003_L_98EC
		rcr	DX,1
		inc	word ptr [BP-10h]
M003_L_98EC:
		cmp	word ptr [BP-10h],7FFFh
		jnc	short M003_L_9911
		cmp	word ptr [BP-10h],0
		je	short M003_L_9918
M003_L_98F9:
		les	DI,[BP+0Ah]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		mov	AX,word ptr [BP-10h]
		shl	AX,1
		or	AL,byte ptr [BP-0Eh]
		ror	AX,1
		stosw
		jmp	short M003_L_9927
M003_L_9911:
		mov	word ptr [BP-10h],7FFFh
		jmp	short M003_L_991D
M003_L_9918:
		mov	word ptr [BP-10h],0
M003_L_991D:
		sub	AX,AX
		mov	BX,AX
		mov	CX,AX
		mov	DX,AX
		jmp	short M003_L_98F9
M003_L_9927:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	0Ah
BCC_FAR_9767	endp
CODE9	ends





CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP
		public	BCC_FAR_992F

BCC_FAR_992F	proc	far
		push	BP
		mov	BP,SP
		mov	AL,0
		push	AX
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FE22h
		pop	BP
		retf	8
BCC_FAR_992F	endp
CODE9	ends





CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP
		public	BCC_FAR_9949

BCC_FAR_9949	proc	far
		push	BP
		mov	BP,SP
		mov	AL,1
		push	AX
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FE08h
		pop	BP
		retf	8
BCC_FAR_9949	endp
CODE9	ends





CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP
		public	BCC_FAR_9963

BCC_FAR_9963	proc	far
		push	BP
		mov	BP,SP
		sub	SP,18h
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-18h]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		lds	SI,[BP+6]
		lea	DI,[BP-0Ch]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		pop	DS
		mov	CL,byte ptr [BP-2]
		xor	byte ptr [BP-0Eh],CL
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr [BP-10h]
		cmp	AX,7FFFh
		jnc	short M006_L_99C3
		cmp	BX,7FFFh
		jnc	short M006_L_99F3
		cmp	AX,BX
		jc	short M006_L_999F
		xchg	AX,BX
M006_L_999F:
		or	AX,AX
		je	short M006_L_99B5
		add	AX,BX
		sub	AX,3FFEh
		jc	short M006_L_99B5
		jmp	short M006_L_9A21
		nop
M006_L_99AD:
		mov	DI,7FFFh
		mov	DX,8000h
		jmp	short M006_L_99BA
M006_L_99B5:
		sub	DI,DI
		mov	DX,0
M006_L_99BA:
		sub	AX,AX
		mov	BX,AX
		mov	CX,AX
		db	0E9h
		dw	0016Dh
M006_L_99C3:
		cmp	word ptr [BP-4],0
		je	short M006_L_99D5
		push	SS
		lea	AX,[BP-18h]
		push	AX
		db	0E8h
		dw	0FD53h
		or	AX,AX
		je	short M006_L_99D7
M006_L_99D5:
		jmp	short M006_L_9A19
M006_L_99D7:
		les	BX,[BP+0Ah]
		and	word ptr ES:[BX+8],7FFFh
		test	word ptr [BP-0Eh],0FFh
		je	short M006_L_99F0
		les	BX,[BP+0Ah]
		xor	word ptr ES:[BX+8],8000h
M006_L_99F0:
		db	0E9h
		dw	00153h
M006_L_99F3:
		cmp	word ptr [BP-10h],0
		je	short M006_L_9A05
		push	SS
		lea	AX,[BP-0Ch]
		push	AX
		db	0E8h
		dw	0FD23h
		or	AX,AX
		je	short M006_L_9A07
M006_L_9A05:
		jmp	short M006_L_9A19
M006_L_9A07:
		mov	DI,7FFFh
		mov	AX,word ptr [BP-0Ch]
		mov	BX,word ptr [BP-0Ah]
		mov	CX,word ptr [BP-8]
		mov	DX,word ptr [BP-6]
		db	0E9h
		dw	00117h
M006_L_9A19:
		mov	DX,0C000h
		mov	DI,7FFFh
		jmp	short M006_L_99BA
M006_L_9A21:
		mov	word ptr [BP-10h],AX
		sub	DI,DI
		mov	CX,DI
		mov	SI,DI
		test	byte ptr [BP-9],80h
		je	short M006_L_9A36
		mov	CX,word ptr [BP-18h]
		mov	SI,word ptr [BP-16h]
M006_L_9A36:
		test	byte ptr [BP-15h],80h
		je	short M006_L_9A4B
		add	CX,word ptr [BP-0Ch]
		adc	SI,word ptr [BP-0Ah]
		adc	DI,DI
		test	byte ptr [BP-9],80h
		je	short M006_L_9A4B
		dec	DI
M006_L_9A4B:
		sub	BX,BX
		mov	AX,word ptr [BP-0Ch]
		mul	word ptr [BP-14h]
		add	CX,AX
		adc	SI,DX
		adc	DI,0
		mov	AX,word ptr [BP-8]
		or	AX,AX
		je	short M006_L_9A78
		mul	word ptr [BP-18h]
		add	CX,AX
		adc	SI,DX
		adc	DI,0
		mov	AX,word ptr [BP-8]
		mul	word ptr [BP-16h]
		add	SI,AX
		adc	DI,DX
		adc	BX,0
M006_L_9A78:
		mov	AX,word ptr [BP-0Ch]
		mul	word ptr [BP-12h]
		add	SI,AX
		adc	DI,DX
		adc	BX,0
		mov	AX,word ptr [BP-0Ah]
		mul	word ptr [BP-14h]
		add	SI,AX
		adc	DI,DX
		adc	BX,0
		mov	AX,word ptr [BP-6]
		or	AX,AX
		je	short M006_L_9AA3
		mul	word ptr [BP-18h]
		add	SI,AX
		adc	DI,DX
		adc	BX,0
M006_L_9AA3:
		sub	CX,CX
		push	SI
		mov	SI,CX
		mov	AX,word ptr [BP-0Ah]
		mul	word ptr [BP-12h]
		add	DI,AX
		adc	BX,DX
		adc	CX,0
		mov	AX,word ptr [BP-8]
		or	AX,AX
		je	short M006_L_9AD3
		mul	word ptr [BP-14h]
		add	DI,AX
		adc	BX,DX
		adc	CX,0
		mov	AX,word ptr [BP-8]
		mul	word ptr [BP-12h]
		add	BX,AX
		adc	CX,DX
		adc	SI,0
M006_L_9AD3:
		mov	AX,word ptr [BP-6]
		or	AX,AX
		je	short M006_L_9AFE
		mul	word ptr [BP-16h]
		add	DI,AX
		adc	BX,DX
		adc	CX,0
		adc	SI,0
		mov	AX,word ptr [BP-6]
		mul	word ptr [BP-14h]
		add	BX,AX
		adc	CX,DX
		adc	SI,0
		mov	AX,word ptr [BP-6]
		mul	word ptr [BP-12h]
		add	CX,AX
		adc	SI,DX
M006_L_9AFE:
		mov	DX,SI
		xchg	AX,DI
		pop	SI
		mov	DI,word ptr [BP-10h]
		or	DX,DX
		js	short M006_L_9B14
		dec	DI
		shl	SI,1
		rcl	AX,1
		rcl	BX,1
		rcl	CX,1
		rcl	DX,1
M006_L_9B14:
		shl	SI,1
		adc	AX,0
		adc	BX,0
		adc	CX,0
		adc	DX,0
		jnc	short M006_L_9B27
		rcr	DX,1
		inc	DI
M006_L_9B27:
		cmp	DI,7FFFh
		jc	short M006_L_9B30
		db	0E9h
		dw	0FE7Dh
M006_L_9B30:
		mov	SI,DI
		les	DI,[BP+0Ah]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		xchg	AX,SI
		shl	AX,1
		or	AL,byte ptr [BP-0Eh]
		ror	AX,1
		stosw
M006_L_9B46:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_9963	endp
CODE9	ends





CODE9	segment byte public 'CODE'
		assume	cs:CODE9,ds:DGROUP
		public	BCC_FAR_9B4E

BCC_FAR_9B4E	proc	far
		push	BP
		mov	BP,SP
		sub	SP,28h
		push	SI
		push	DI
		mov	word ptr [BP-4],0
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-28h]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		lds	SI,[BP+6]
		lea	DI,[BP-1Ch]
		db	09Ah
		dw	BCC_FAR_970B
		dw	seg BCC_FAR_970B
		pop	DS
		mov	AL,byte ptr [BP-1Eh]
		xor	AL,byte ptr [BP-12h]
		mov	byte ptr [BP-6],AL
		mov	SI,word ptr [BP-14h]
		mov	AX,word ptr [BP-20h]
		cmp	SI,7FFFh
		jnc	short M007_L_9BB1
		cmp	AX,7FFFh
		jnc	short M007_L_9BC3
		or	SI,SI
		je	short M007_L_9B9F
		or	AX,AX
		je	short M007_L_9BC3
		add	AX,3FFEh
		sub	AX,SI
		jc	short M007_L_9BB1
		jmp	short M007_L_9BDF
		nop
M007_L_9B9F:
		mov	DX,7FFFh
		mov	SI,8000h
		or	AX,AX
		jne	short M007_L_9BBA
M007_L_9BA9:
		mov	DX,7FFFh
		mov	SI,0C000h
		jmp	short M007_L_9BBA
M007_L_9BB1:
		sub	DX,DX
		sub	SI,SI
		cmp	AX,7FFFh
		je	short M007_L_9BA9
M007_L_9BBA:
		sub	AX,AX
		mov	BX,AX
		mov	CX,AX
		db	0E9h
		dw	001C5h
M007_L_9BC3:
		les	BX,[BP+0Ah]
		and	word ptr ES:[BX+8],7FFFh
		test	word ptr [BP-6],0FFh
		je	short M007_L_9BDC
		les	BX,[BP+0Ah]
		xor	word ptr ES:[BX+8],8000h
M007_L_9BDC:
		db	0E9h
		dw	001BDh
M007_L_9BDF:
		mov	word ptr [BP-8],AX
		sub	CX,CX
		mov	DX,word ptr [BP-22h]
		mov	SI,word ptr [BP-16h]
		cmp	SI,DX
		ja	short M007_L_9BF1
		sub	DX,SI
		inc	CX
M007_L_9BF1:
		mov	AX,word ptr [BP-24h]
		div	SI
		adc	AX,1
		adc	CL,CH
		mov	byte ptr [BP-1],CL
		mov	word ptr [BP-0Ah],AX
		push	AX
		mov	AX,word ptr [BP-1Ch]
		mov	BX,word ptr [BP-1Ah]
		jcxz	short M007_L_9C1B
		mov	DX,word ptr [BP-18h]
M007_L_9C0D:
		sub	word ptr [BP-28h],AX
		sbb	word ptr [BP-26h],BX
		sbb	word ptr [BP-24h],DX
		sbb	word ptr [BP-22h],SI
		loop	short M007_L_9C0D
M007_L_9C1B:
		pop	SI
		mul	SI
		mov	word ptr [BP-4],AX
		xchg	AX,DX
		xchg	AX,BX
		mul	SI
		add	BX,AX
		adc	CX,DX
		mov	AX,word ptr [BP-18h]
		mul	SI
		add	CX,AX
		adc	DX,0
		xchg	AX,DX
		xchg	AX,SI
		mul	word ptr [BP-16h]
		add	AX,SI
		adc	DX,0
		sub	BX,word ptr [BP-28h]
		sbb	CX,word ptr [BP-26h]
		sbb	AX,word ptr [BP-24h]
		sbb	DX,word ptr [BP-22h]
		mov	word ptr [BP-28h],BX
		mov	word ptr [BP-26h],CX
		mov	word ptr [BP-24h],AX
		mov	SI,word ptr [BP-16h]
		div	SI
		xchg	AX,CX
		div	SI
		sub	DX,DX
		stc
		adc	AX,DX
		adc	CX,DX
		sub	DX,AX
		mov	word ptr [BP-0Ch],DX
		sbb	word ptr [BP-0Ah],CX
		sbb	byte ptr [BP-1],0
		push	AX
		mov	AX,word ptr [BP-1Ch]
		mov	BX,word ptr [BP-1Ah]
		jcxz	short M007_L_9C87
		mov	DX,word ptr [BP-18h]
M007_L_9C79:
		sub	word ptr [BP-4],AX
		sbb	word ptr [BP-28h],BX
		sbb	word ptr [BP-26h],DX
		sbb	word ptr [BP-24h],SI
		loop	short M007_L_9C79
M007_L_9C87:
		pop	SI
		mul	SI
		xchg	AX,DX
		xchg	AX,BX
		mul	SI
		add	BX,AX
		adc	CX,DX
		mov	AX,word ptr [BP-18h]
		mul	SI
		add	CX,AX
		adc	DX,0
		xchg	AX,DX
		xchg	AX,SI
		mul	word ptr [BP-16h]
		add	AX,SI
		adc	DX,0
		sub	BX,word ptr [BP-4]
		sbb	CX,word ptr [BP-28h]
		sbb	AX,word ptr [BP-26h]
		sbb	DX,word ptr [BP-24h]
		mov	word ptr [BP-4],BX
		mov	word ptr [BP-28h],CX
		mov	word ptr [BP-26h],AX
		mov	SI,word ptr [BP-16h]
		div	SI
		xchg	AX,CX
		div	SI
		sub	DX,DX
		stc
		adc	AX,DX
		adc	CX,DX
		mov	word ptr [BP-0Eh],AX
		add	word ptr [BP-0Ch],CX
		adc	word ptr [BP-0Ah],DX
		adc	byte ptr [BP-1],DL
		xchg	AX,SI
		mov	DX,word ptr [BP-1Ah]
		xchg	AX,DX
		mov	BX,word ptr [BP-18h]
		jcxz	short M007_L_9CEB
M007_L_9CE0:
		sub	word ptr [BP-4],AX
		sbb	word ptr [BP-28h],BX
		sbb	word ptr [BP-26h],DX
		loop	short M007_L_9CE0
M007_L_9CEB:
		mul	SI
		xchg	AX,DX
		xchg	AX,BX
		mul	SI
		add	BX,AX
		adc	CX,DX
		mov	AX,word ptr [BP-16h]
		mul	SI
		add	AX,CX
		adc	DX,0
		sub	BX,word ptr [BP-4]
		sbb	AX,word ptr [BP-28h]
		sbb	DX,word ptr [BP-26h]
		mov	word ptr [BP-4],BX
		mov	word ptr [BP-28h],AX
		mov	SI,word ptr [BP-18h]
		add	SI,SI
		mov	SI,word ptr [BP-16h]
		adc	SI,0
		jnc	short M007_L_9D1F
		xchg	BX,DX
		jmp	short M007_L_9D30
M007_L_9D1F:
		shl	BX,1
		rcl	AX,1
		rcl	DX,1
		div	SI
		xchg	AX,BX
		div	SI
		shr	BX,1
		rcr	AX,1
		rcr	DH,1
M007_L_9D30:
		mov	CX,0FFFFh
		mov	SI,CX
		mov	DL,CL
		not	BX
		not	AX
		neg	DH
		cmc
		adc	AX,0
		adc	BX,word ptr [BP-0Eh]
		adc	CX,word ptr [BP-0Ch]
		adc	SI,word ptr [BP-0Ah]
		adc	DL,byte ptr [BP-1]
		shr	DL,1
		jnc	short M007_L_9D5E
		rcr	SI,1
		rcr	CX,1
		rcr	BX,1
		rcr	AX,1
		rcr	DH,1
		inc	word ptr [BP-8]
M007_L_9D5E:
		sub	DI,DI
		add	DH,DH
		adc	AX,DI
		adc	BX,DI
		adc	CX,DI
		adc	SI,DI
		adc	DL,0
		mov	DX,word ptr [BP-8]
		je	short M007_L_9D76
		mov	SI,8000h
		inc	DX
M007_L_9D76:
		cmp	DX,7FFFh
		jc	short M007_L_9D7F
		db	0E9h
		dw	0FE20h
M007_L_9D7F:
		cmp	DX,7FFFh
		jc	short M007_L_9D88
		db	0E9h
		dw	0FE17h
M007_L_9D88:
		les	DI,[BP+0Ah]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,SI
		stosw
		xchg	AX,DX
		shl	AX,1
		or	AL,byte ptr [BP-6]
		ror	AX,1
		stosw
M007_L_9D9C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		ret	8
BCC_FAR_9B4E	endp
CODE9	ends

; END R9UNIT
		end
