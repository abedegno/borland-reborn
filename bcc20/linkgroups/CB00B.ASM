DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_11
; BEGIN R11NORM (listing CODE_11:0006)

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP


		public	BCC_FAR_9E16
		public	BCC_NEAR_9E16

BCC_NEAR_9E16	label	near
BCC_FAR_9E16	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		lds	SI,[BP+6]
		mov	AX,word ptr [SI+4]
		mov	DX,word ptr [SI+6]
		cmp	word ptr [SI],0
		jne	short M001_L_9E38
		cmp	word ptr [SI+2],0
		jne	short M001_L_9E38
		test	AL,7Fh
		jne	short M001_L_9E38
		test	AH,1
		je	short M001_L_9E52
M001_L_9E38:
		add	AL,AL
		adc	AH,0
		adc	DX,0
		jnc	short M001_L_9E52
		rcr	DX,1
		rcr	AX,1
		inc	word ptr [SI+8]
		mov	BX,7FFFh
		and	BX,word ptr [SI+8]
		inc	BX
		jo	short M001_L_9E64
M001_L_9E52:
		mov	AL,0
		sub	BX,BX
		mov	word ptr [SI],BX
		mov	word ptr [SI+2],BX
		mov	word ptr [SI+4],AX
		mov	word ptr [SI+6],DX
		pop	DS
		jmp	short M001_L_9E6B
M001_L_9E64:
		sub	AX,AX
		mov	DX,8000h
		jmp	short M001_L_9E52
M001_L_9E6B:
		pop	SI
		pop	BP
		retf	4
BCC_FAR_9E16	endp
CODE11	ends

; END R11NORM
; BEGIN R11P32 (listing CODE_11:0060)




CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP
		public	BCC_FAR_9E70

BCC_FAR_9E70	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-0Ah]
		push	SS
		pop	ES
		mov	CX,5
		cld
		rep movsw
		pop	DS
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	CS
		db	0E8h
		dw	0FF85h
		mov	BX,word ptr [BP-2]
		mov	CL,0
		shl	BX,1
		rcl	CL,1
		shr	BX,1
		cmp	BX,7FFFh
		je	short M002_L_9EC5
		add	BX,0C080h
		jle	short M002_L_9ED7
		cmp	BX,0FFh
		jge	short M002_L_9ED0
		mov	BH,byte ptr [BP-3]
		mov	AX,word ptr [BP-5]
		xchg	BH,BL
		shl	BL,1
M002_L_9EB8:
		shr	CL,1
		rcr	BX,1
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		jmp	short M002_L_9EDD
M002_L_9EC5:
		mov	BL,byte ptr [BP-3]
		shl	BL,1
		mov	BH,0FFh
		sub	AX,AX
		jmp	short M002_L_9EB8
M002_L_9ED0:
		mov	BX,0FF00h
		sub	AX,AX
		jmp	short M002_L_9EB8
M002_L_9ED7:
		sub	BX,BX
		sub	AX,AX
		jmp	short M002_L_9EB8
M002_L_9EDD:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_9E70	endp
CODE11	ends

; END R11P32
; BEGIN R11ROUND (listing CODE_11:00D5)

CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP


		public	BCC_FAR_9EE5
		public	BCC_NEAR_9EE5

BCC_NEAR_9EE5	label	near
BCC_FAR_9EE5	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+6]
		mov	AX,word ptr [SI+1]
		mov	DH,3
		and	DH,AL
		or	DH,byte ptr [SI]
		jne	short M003_L_9EFD
		test	AL,8
		je	short M003_L_9F1B
M003_L_9EFD:
		add	AX,4
		jnc	short M003_L_9F1B
		sub	BX,BX
		adc	word ptr [SI+3],BX
		adc	word ptr [SI+5],BX
		adc	byte ptr [SI+7],BL
		jnc	short M003_L_9F1B
		inc	word ptr [SI+8]
		mov	DI,7FFFh
		and	DI,word ptr [SI+8]
		inc	DI
		jo	short M003_L_9F26
M003_L_9F1B:
		and	AL,0F8h
		mov	byte ptr [SI],0
		mov	word ptr [SI+1],AX
M003_L_9F23:
		pop	DS
		jmp	short M003_L_9F35
M003_L_9F26:
		mov	word ptr [SI],BX
		mov	word ptr [SI+2],BX
		mov	word ptr [SI+4],BX
		mov	word ptr [SI+6],8000h
		jmp	short M003_L_9F23
M003_L_9F35:
		pop	DI
		pop	SI
		pop	BP
		retf	4
BCC_FAR_9EE5	endp
CODE11	ends

; END R11ROUND
; BEGIN R11P64 (listing CODE_11:012B)




CODE11	segment byte public 'CODE'
		assume	cs:CODE11,ds:DGROUP
		public	BCC_FAR_9F3B

BCC_FAR_9F3B	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		lea	DI,[BP-0Ah]
		push	SS
		pop	ES
		mov	CX,5
		cld
		rep movsw
		pop	DS
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		push	CS
		db	0E8h
		dw	0FF89h
		mov	AX,word ptr [BP-9]
		mov	DI,word ptr [BP-7]
		mov	CX,word ptr [BP-5]
		mov	DL,byte ptr [BP-3]
		mov	BX,word ptr [BP-2]
		and	BX,7FFFh
		cmp	BX,7FFFh
		je	short M004_L_9FC2
		add	BX,0C400h
		jle	short M004_L_9FBD
		cmp	BX,7FFh
		jge	short M004_L_9FCE
		shl	DL,1
		shr	BX,1
		rcr	DL,1
		or	AL,BH
		mov	DH,BL
		mov	BX,DI
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
		shl	word ptr [BP-2],1
		adc	AL,0
		shr	DI,1
		rcr	AX,1
		rcr	DX,1
		rcr	CX,1
		rcr	BX,1
M004_L_9FB0:
		les	DI,[BP+6]
		cld
		stosw
		xchg	AX,BX
		stosw
		xchg	AX,CX
		stosw
		xchg	AX,DX
		stosw
		jmp	short M004_L_9FDE
M004_L_9FBD:
		mov	DX,0
		jmp	short M004_L_9FD1
M004_L_9FC2:
		and	DX,7Fh
		shr	DX,1
		shr	DX,1
		or	DX,0FFE0h
		jmp	short M004_L_9FD1
M004_L_9FCE:
		mov	DX,0FFE0h
M004_L_9FD1:
		shl	word ptr [BP-2],1
		rcr	DX,1
		sub	CX,CX
		mov	BX,CX
		mov	AX,CX
		jmp	short M004_L_9FB0
M004_L_9FDE:
		pop	DI
		pop	SI
BCC_FAR_9F3B	endp
		db	08Bh,0E5h,05Dh,0CAh,008h,000h	; epilogue, formerly R12TAIL at CODE_12:0000
CODE11	ends

; END R11P64
		end
