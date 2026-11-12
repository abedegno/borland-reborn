DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_10
; BEGIN R10CMP (listing CODE_10:0004)

CODE10	segment byte public 'CODE'
		assume	cs:CODE10,ds:DGROUP


		public	BCC_FAR_9DA4

BCC_FAR_9DA4	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		lds	SI,[BP+0Ah]
		les	DI,[BP+6]
		mov	AX,word ptr [SI+8]
		mov	DX,word ptr ES:[DI+8]
		sub	BX,BX
		shl	AX,1
		rcr	BL,1
		shl	DX,1
		rcr	BH,1
		mov	CX,AX
		or	CX,DX
		jcxz	short M001_L_9DF5
		cmp	BL,BH
		jg	short M001_L_9E08
		jl	short M001_L_9DFF
		cmp	AX,DX
		jc	short M001_L_9DFB
		ja	short M001_L_9E04
		mov	AX,word ptr [SI+6]
		cmp	AX,word ptr ES:[DI+6]
		jne	short M001_L_9DF9
		mov	AX,word ptr [SI+4]
		cmp	AX,word ptr ES:[DI+4]
		jne	short M001_L_9DF9
		mov	AX,word ptr [SI+2]
		cmp	AX,word ptr ES:[DI+2]
		jne	short M001_L_9DF9
		mov	AX,word ptr [SI]
		cmp	AX,word ptr ES:[DI]
		jne	short M001_L_9DF9
M001_L_9DF5:
		sub	AX,AX
		jmp	short M001_L_9E0B
M001_L_9DF9:
		ja	short M001_L_9E04
M001_L_9DFB:
		or	BL,BL
		jne	short M001_L_9E08
M001_L_9DFF:
		mov	AX,0FFFFh
		jmp	short M001_L_9E0B
M001_L_9E04:
		or	BL,BL
		jne	short M001_L_9DFF
M001_L_9E08:
		mov	AX,1
M001_L_9E0B:
		or	AX,AX
		pop	DS
		db	0EBh,000h
		db	05Fh,05Eh,05Dh,0CAh,008h,000h	; epilogue, formerly R11TAIL at CODE_11:0000
BCC_FAR_9DA4	endp
CODE10	ends

; END R10CMP
		end
