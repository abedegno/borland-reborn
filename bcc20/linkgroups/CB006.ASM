DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_6
; BEGIN LG005 (gap CODE_6:0000)
CODE6	segment byte public 'CODE'
		assume	cs:CODE6
; Original-image layout stub: not recovered source



CODE6	ends
; END LG005
; BEGIN RFILEIO (listing CODE_6:0002)

		extrn	BCC_FAR_A7E2:far
		extrn	BCC_FAR_3504:far
		extrn	BCC_FAR_34F0:far
		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_AB9B:far
		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_258F:far
		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_AB75:far


CODE6	segment byte public 'CODE'
		assume	cs:CODE6,ds:DGROUP

M001_BCC_HANDLE	equ	38FAh
M001_BCC_COUNT	equ	863Eh
M001_BCC_OPTION	equ	8640h
M001_BCC_BUFFER	equ	8642h
M001_BCC_NAME	equ	8646h
M001_BCC_STREAM	equ	7846h
		public	BCC_FAR_5E22
		public	BCC_FAR_5E71
		public	BCC_FAR_5E92
		public	BCC_FAR_5EE3
		public	BCC_FAR_5F47

BCC_FAR_5E22	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A7E2
		dw	seg BCC_FAR_A7E2
		mov	DGROUP:M001_BCC_HANDLE,AX
		db	09Ah
		dw	BCC_FAR_3504
		dw	seg BCC_FAR_3504
		mov	AH,0
		mov	word ptr [BP-2],AX
		mov	AL,DGROUP:M001_BCC_OPTION
		push	AX
		db	09Ah
		dw	BCC_FAR_34F0
		dw	seg BCC_FAR_34F0
		push	DS
		mov	AX,M001_BCC_BUFFER
		push	AX
		mov	AX,1000h
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AL,byte ptr [BP-2]
		push	AX
		db	09Ah
		dw	BCC_FAR_34F0
		dw	seg BCC_FAR_34F0
		mov	word ptr DGROUP:M001_BCC_COUNT,0
		mov	AX,DGROUP:M001_BCC_HANDLE
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_5E22	endp

		public	BCC_OUTPUT_STRING
BCC_OUTPUT_STRING	label	far
BCC_FAR_5E71	proc	far
		push	BP
		mov	BP,SP
		jmp	short M001_L_TEST
M001_L_NEXT:
		les	BX,[BP+6]
		inc	word ptr [BP+6]
		mov	AL,byte ptr ES:[BX]
		push	AX
		db	09Ah
		dw	BCC_FAR_5E92
		dw	seg BCC_FAR_5E92
M001_L_TEST:
		les	BX,[BP+6]
		cmp	byte ptr ES:[BX],0
		jne	short M001_L_NEXT
		pop	BP
		retf	4
BCC_FAR_5E71	endp

		public	BCC_OUTPUT_CHAR
BCC_OUTPUT_CHAR	label	far
BCC_FAR_5E92	proc	far
		push	BP
		mov	BP,SP
		mov	ES,word ptr DGROUP:M001_BCC_BUFFER
		mov	BX,word ptr DGROUP:M001_BCC_COUNT
		mov	AL,byte ptr [BP+6]
		mov	byte ptr ES:[BX],AL
		inc	word ptr DGROUP:M001_BCC_COUNT
		cmp	word ptr DGROUP:M001_BCC_COUNT,1000h
		jc	short M001_L_DONE
		push	word ptr DGROUP:M001_BCC_HANDLE
		push	word ptr DGROUP:M001_BCC_BUFFER
		xor	AX,AX
		push	AX
		mov	AX,1000h
		push	AX
		db	09Ah
		dw	BCC_FAR_AB9B
		dw	seg BCC_FAR_AB9B
		cmp	AX,1000h
		je	short M001_L_RESET
		mov	word ptr DGROUP:M001_BCC_COUNT,0
		mov	AX,7
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M001_L_RESET:
		mov	word ptr DGROUP:M001_BCC_COUNT,0
M001_L_DONE:
		pop	BP
		retf	2
BCC_FAR_5E92	endp

BCC_FAR_5EE3	proc	far
		push	BP
		mov	BP,SP
		push	SI
		cmp	word ptr DGROUP:M001_BCC_HANDLE,0
		jl	M001_L_RETURN
		cmp	word ptr DGROUP:M001_BCC_COUNT,0
		je	short M001_L_NO_FLUSH
		push	word ptr DGROUP:M001_BCC_HANDLE
		push	word ptr DGROUP:M001_BCC_BUFFER
		xor	AX,AX
		push	AX
		push	word ptr DGROUP:M001_BCC_COUNT
		db	09Ah
		dw	BCC_FAR_AB9B
		dw	seg BCC_FAR_AB9B
		cmp	AX,word ptr DGROUP:M001_BCC_COUNT
		je	short M001_L_WRITTEN
		mov	AX,1
		jmp	short M001_L_STATUS
M001_L_WRITTEN:
		xor	AX,AX
M001_L_STATUS:
		mov	SI,AX
		jmp	short M001_L_CLOSE
M001_L_NO_FLUSH:
		xor	SI,SI
M001_L_CLOSE:
		push	DS
		mov	AX,M001_BCC_BUFFER
		push	AX
		db	09Ah
		dw	BCC_FAR_258F
		dw	seg BCC_FAR_258F
		push	word ptr DGROUP:M001_BCC_HANDLE
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		mov	word ptr DGROUP:M001_BCC_HANDLE,0FFFFh
		or	SI,SI
		je	short M001_L_RETURN
		mov	AX,7
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M001_L_RETURN:
		pop	SI
		pop	BP
		retf
BCC_FAR_5EE3	endp

BCC_FAR_5F47	proc	far
		push	BP
		mov	BP,SP
		cmp	word ptr DGROUP:M001_BCC_HANDLE,0
		jl	short M001_L_RETURN2
		push	word ptr DGROUP:M001_BCC_HANDLE
		db	09Ah
		dw	BCC_FAR_A7C4
		dw	seg BCC_FAR_A7C4
		push	DS
		mov	AX,M001_BCC_BUFFER
		push	AX
		db	09Ah
		dw	BCC_FAR_258F
		dw	seg BCC_FAR_258F
		mov	word ptr DGROUP:M001_BCC_HANDLE,0FFFFh
		push	word ptr DGROUP:M001_BCC_STREAM
		push	word ptr DGROUP:M001_BCC_NAME
		db	09Ah
		dw	BCC_FAR_AB75
		dw	seg BCC_FAR_AB75
M001_L_RETURN2:
		pop	BP
		retf
BCC_FAR_5F47	endp
CODE6	ends
; Original-target semantic aliases (zero bytes)
; END RFILEIO
		end
