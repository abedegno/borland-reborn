DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_41
; BEGIN LG01A (gap CODE_41:0000)
RMSET_TEXT	segment byte public 'CODE'
		assume	cs:RMSET_TEXT
; Original-image layout stub: not recovered source



RMSET_TEXT	ends
; END LG01A
; BEGIN RMSET (listing CODE_41:0003)

RMSET_TEXT	segment byte public 'CODE'
		assume	cs:RMSET_TEXT,ds:DGROUP

		public	BCC_FAR_AF23

		public	BCC_STMT_SCOPE_PUSH
BCC_STMT_SCOPE_PUSH	label	far
		public	MEMSET
MEMSET	label	far
BCC_FAR_AF23	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		les	DI,[BP+0Ah]
		mov	CX,word ptr [BP+6]
		mov	AL,byte ptr [BP+8]
		mov	AH,AL
		cld
		test	DI,1
		je	short M001_L_ALIGNED
		jcxz	M001_L_RETURN
		stosb
		dec	CX
M001_L_ALIGNED:
		shr	CX,1
		rep	stosw
		jnc	short M001_L_RETURN
		stosb
M001_L_RETURN:
		mov	DX,word ptr [BP+0Ch]
		mov	AX,word ptr [BP+0Ah]
		pop	DI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_AF23	endp
RMSET_TEXT	ends

; Original-target semantic aliases (zero bytes)
; END RMSET
		end
