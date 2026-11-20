DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_44
; BEGIN LG01E (gap CODE_44:0000)
RMMOVE_TEXT	segment byte public 'CODE'
		assume	cs:RMMOVE_TEXT
; Original-image layout stub: not recovered source



RMMOVE_TEXT	ends
; END LG01E
; BEGIN RMMOVE (listing CODE_44:0001)

RMMOVE_TEXT	segment byte public 'CODE'
		assume	cs:RMMOVE_TEXT,ds:DGROUP

		public	BCC_FAR_B0F1

BCC_FAR_B0F1	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		mov	DX,word ptr [BP+0Ah]
		mov	AX,word ptr [BP+8]
		cmp	DX,word ptr [BP+0Eh]
		ja	short M001_L_FORWARD
		jc	short M001_L_BACKWARD
		cmp	AX,word ptr [BP+0Ch]
		jnc	short M001_L_FORWARD
M001_L_BACKWARD:
		std
		mov	AX,1
		jmp	short M001_L_DIRECTION
M001_L_FORWARD:
		cld
		xor	AX,AX
M001_L_DIRECTION:
		lds	SI,[BP+8]
		les	DI,[BP+0Ch]
		mov	CX,word ptr [BP+6]
		or	AX,AX
		je	short M001_L_ALIGNED_TEST
		add	SI,CX
		dec	SI
		add	DI,CX
		dec	DI
M001_L_ALIGNED_TEST:
		test	DI,1
		je	short M001_L_ALIGNED
		jcxz	M001_L_DONE
		movsb
		dec	CX
M001_L_ALIGNED:
		sub	SI,AX
		sub	DI,AX
		shr	CX,1
		rep	movsw
		jnc	short M001_L_DONE
		add	SI,AX
		add	DI,AX
		movsb
M001_L_DONE:
		cld
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	0Ah
BCC_FAR_B0F1	endp
RMMOVE_TEXT	ends

; END RMMOVE
		end
