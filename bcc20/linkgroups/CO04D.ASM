		public	X04D_08
		public	X04D_03
		public	X04D_02
		public	X04D_00
		public	X04D_01
		public	X04D_06
		public	X04D_07
		public	X04D_04
		public	X04D_05
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d1a_9aac
; BEGIN C125UNIT (listing ovr_1d1a_9aac:AAC0)



CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M000_BCC_DATA_8622	equ	8622h
M000_BCC_DATA_8626	equ	8626h
M000_BCC_DATA_8630	equ	8630h
M000_BCC_DATA_8632	equ	8632h
M000_BCC_DATA_8638	equ	8638h
M000_BCC_DATA_863C	equ	863Ch

		public	X04D_05
X04D_05	label	far
BCC_FAR_AAC0	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	word ptr [BP+6]
		mov	AX,1
		push	AX
		db	0E8h
		dw	001D4h
		mov	SI,AX
		or	SI,SI
		jne	short M000_L_AAD8
		xor	AX,AX
		jmp	short M000_L_AAEC
M000_L_AAD8:
		mov	AX,DGROUP:M000_BCC_DATA_8638
		mov	DGROUP:M000_BCC_DATA_8622,AX
		mov	AX,DGROUP:M000_BCC_DATA_863C
		mov	DGROUP:M000_BCC_DATA_8626,AX
		mov	AX,DGROUP:M000_BCC_DATA_8632
		mov	DGROUP:M000_BCC_DATA_8630,AX
		mov	AX,SI
M000_L_AAEC:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_AAC0	endp
CO04D_TEXT	ends




CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M001_BCC_DATA_861C	equ	861Ch
M001_BCC_DATA_8638	equ	8638h

		public	X04D_00
X04D_00	label	far
BCC_NEAR_AAF1	label	near
BCC_FAR_AAF1	proc	far
		push	BP
		mov	BP,SP
		push	SI
		xor	AX,AX
		push	AX
		push	AX
		db	0E8h
		dw	001A6h
		mov	SI,AX
		or	SI,SI
		jne	short M001_L_AB06
		xor	AX,AX
		jmp	short M001_L_AB0E
M001_L_AB06:
		mov	AX,DGROUP:M001_BCC_DATA_8638
		mov	DGROUP:M001_BCC_DATA_861C,AX
		mov	AX,SI
M001_L_AB0E:
		pop	SI
		pop	BP
		retf
BCC_FAR_AAF1	endp
CO04D_TEXT	ends





CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

		public	X04D_01
X04D_01	label	far
BCC_FAR_AB11	proc	far
		push	BP
		mov	BP,SP
		xor	AX,AX
		push	AX
		mov	AX,0FFFFh
		push	AX
		db	0E8h
		dw	00184h
		pop	BP
		retf
BCC_FAR_AB11	endp
CO04D_TEXT	ends


		extrn	BCC_FAR_0402:far
		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M003_BCC_DATA_66BE	equ	66BEh
M003_BCC_DATA_77D3	equ	77D3h
M003_BCC_TOKEN_SAVED	equ	77FDh
M003_BCC_STMT_TYPE_CURRENT	equ	8260h

		public	X04D_08
X04D_08	label	far
BCC_NEAR_AB20	label	near
BCC_FAR_AB20	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
M003_L_AB26:
		xor	AX,AX
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-6],AX
		mov	BX,word ptr DGROUP:M003_BCC_STMT_TYPE_CURRENT
		sub	BX,46h
		cmp	BX,10h
		ja	short M003_L_ABB2
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1C0h
		mov	word ptr [BP-4],1
		db	0E9h
		dw	000A0h
		mov	word ptr [BP-4],2
		db	0E9h
		dw	00098h
		mov	word ptr [BP-4],4
		db	0E9h
		dw	00090h
		mov	word ptr [BP-4],3
		db	0E9h
		dw	00088h
		mov	word ptr [BP-6],2
		db	0E9h
		dw	00080h
		mov	word ptr [BP-6],80h
		jmp	short M003_L_ABEC
		mov	word ptr [BP-6],10h
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],2
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],4
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],1
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],3
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],7
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],8
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],9
		jmp	short M003_L_ABEC
		mov	word ptr [BP-2],0Ah
		jmp	short M003_L_ABEC
M003_L_ABB2:
		cmp	byte ptr [BP+6],0
		je	short M003_L_ABD3
		cmp	byte ptr [BP+7],3
		jg	short M003_L_ABD3
		cmp	byte ptr [BP+7],2
		jl	short M003_L_ABD3
		mov	byte ptr [BP+7],0
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M003_L_ABD3:
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		lea	AX,[BP+6]
		push	SS
		push	AX
		mov	CX,3
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	AX,word ptr [BP+0Ah]
		db	0E9h
		dw	0008Eh
M003_L_ABEC:
		mov	AL,byte ptr [BP+8]
		cbw
		test	word ptr [BP-6],AX
		je	short M003_L_AC00
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M003_L_AC00:
		mov	AL,byte ptr [BP-6]
		or	byte ptr [BP+8],AL
		cmp	word ptr [BP-4],0
		je	short M003_L_AC23
		cmp	byte ptr [BP+6],0
		je	short M003_L_AC1D
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M003_L_AC1D:
		mov	AL,byte ptr [BP-4]
		mov	byte ptr [BP+6],AL
M003_L_AC23:
		cmp	word ptr [BP-2],0
		je	short M003_L_AC40
		cmp	byte ptr [BP+7],0
		je	short M003_L_AC3A
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M003_L_AC3A:
		mov	AL,byte ptr [BP-2]
		mov	byte ptr [BP+7],AL
M003_L_AC40:
		cmp	byte ptr [BP+7],8
		jne	short M003_L_AC5B
		cmp	byte ptr [BP+6],4
		jne	short M003_L_AC5B
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	byte ptr [BP+7],0
M003_L_AC5B:
		cmp	byte ptr DGROUP:M003_BCC_TOKEN_SAVED,0
		je	short M003_L_AC6C
		mov	byte ptr DGROUP:M003_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M003_BCC_STMT_TYPE_CURRENT
		jmp	short M003_L_AC71
M003_L_AC6C:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M003_L_AC71:
		mov	AX,DGROUP:M003_BCC_DATA_77D3
		mov	DGROUP:M003_BCC_DATA_66BE,AX
		db	0E9h
		dw	0FEACh
M003_L_AC7A:
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_AB20	endp
CO04D_TEXT	ends

CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT
; Original-image layout stub: not recovered source


		db	094h,000h,08Ch,000h,084h,000h,09Ch,000h,0F2h,000h,0F2h,000h,0A4h,000h	; ovr_1d1a_9aac:AC80
		db	0B3h,000h,0ACh,000h,0DDh,000h,0E4h,000h,0BAh,000h,0C1h,000h,0C8h,000h	; ovr_1d1a_9aac:AC8E
		db	0CFh,000h,0D6h,000h,0EBh,000h	; ovr_1d1a_9aac:AC9C

CO04D_TEXT	ends

		extrn	BCC_FAR_03C2:far
		extrn	BCC_FAR_0402:far
		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_5B8B:far
		extrn	X031_0B:far
		extrn	X031_09:far
		extrn	X046_09:far
		extrn	X047_02:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M005_BCC_DATA_66BE	equ	66BEh
M005_BCC_DATA_77D3	equ	77D3h
M005_BCC_TOKEN_SAVED	equ	77FDh
M005_BCC_STMT_TYPE_CURRENT	equ	8260h
M005_BCC_DATA_8263	equ	8263h
M005_BCC_DATA_8265	equ	8265h
M005_BCC_DATA_8269	equ	8269h
M005_BCC_DATA_826B	equ	826Bh
M005_BCC_DATA_8632	equ	8632h
M005_BCC_DATA_8634	equ	8634h
M005_BCC_DATA_8635	equ	8635h
M005_BCC_DATA_8636	equ	8636h
M005_BCC_DATA_8638	equ	8638h
M005_BCC_DATA_863A	equ	863Ah
M005_BCC_DATA_863C	equ	863Ch

BCC_NEAR_ACA2	proc	near
M005_L_ACA2:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,16h
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		cmp	SP,8F0Ch
		jnc	short M005_L_ACBF
		mov	AX,6
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M005_L_ACBF:
		lea	AX,[BP-8]
		push	SS
		push	AX
		push	SS
		lea	AX,[BP-0Eh]
		push	AX
		mov	AX,8634h
		mov	DX,DS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		push	CS
		db	0E8h
		dw	0FE46h
		lea	AX,[BP-0Eh]
		push	SS
		push	AX
		mov	CX,3
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	byte ptr DGROUP:M005_BCC_DATA_8635,0
		mov	byte ptr DGROUP:M005_BCC_DATA_8634,0
		mov	byte ptr DGROUP:M005_BCC_DATA_8636,0
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,18h
		je	short M005_L_AD00
		db	0E9h
		dw	0007Fh
M005_L_AD00:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AD11
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AD16
M005_L_AD11:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AD16:
		db	0E8h
		dw	0066Bh
		mov	word ptr [BP-2],AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,34h
		jne	short M005_L_AD43
		db	09Ah
		dw	X031_0B
		dw	seg X031_0B
		mov	word ptr [BP-0Ah],AX
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AD3C
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AD41
M005_L_AD3C:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AD41:
		jmp	short M005_L_AD48
M005_L_AD43:
		mov	word ptr [BP-0Ah],0
M005_L_AD48:
		push	DI
		push	word ptr [BP+4]
		db	0E8h
		dw	0FF53h
		mov	SI,AX
		or	SI,SI
		jne	short M005_L_AD5A
		xor	AX,AX
		db	0E9h
		dw	00343h
M005_L_AD5A:
		mov	AX,0Dh
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	SI
		push	word ptr [BP-0Ah]
		mov	AL,byte ptr [BP-2]
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	00666h
		db	0E9h
		dw	0031Eh
M005_L_AD7F:
		mov	word ptr DGROUP:M005_BCC_DATA_8638,0
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,1
		je	short M005_L_AD8F
		db	0E9h
		dw	0008Fh
M005_L_AD8F:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_ADA0
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_ADA5
M005_L_ADA0:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_ADA5:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,2
		je	short M005_L_ADBE
		push	DI
		push	word ptr [BP+4]
		db	0E8h
		dw	0FEEFh
		mov	SI,AX
		or	SI,SI
		jne	short M005_L_AE06
		xor	AX,AX
		db	0E9h
		dw	002DFh
M005_L_ADBE:
		cmp	word ptr [BP+4],0
		jg	short M005_L_ADEF
		mov	AX,12h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	AX
		push	AX
		mov	AL,0
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	005FFh
		mov	SI,AX
		mov	byte ptr [BP-8],0
		mov	byte ptr [BP-7],0
		jmp	short M005_L_AE06
M005_L_ADEF:
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,79h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	00297h
M005_L_AE06:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AE17
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AE1C
M005_L_AE17:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AE1C:
		jmp	short M005_L_AE90
M005_L_AE1E:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,31h
		jne	short M005_L_AE55
		cmp	word ptr [BP+4],0
		jl	short M005_L_AE55
		mov	AX,DGROUP:M005_BCC_DATA_8269
		mov	DGROUP:M005_BCC_DATA_8638,AX
		mov	AX,DGROUP:M005_BCC_DATA_8265
		mov	DGROUP:M005_BCC_DATA_863C,AX
		mov	AX,DGROUP:M005_BCC_DATA_8263
		mov	DGROUP:M005_BCC_DATA_8632,AX
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AE4E
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AE53
M005_L_AE4E:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AE53:
		jmp	short M005_L_AE72
M005_L_AE55:
		cmp	word ptr [BP+4],0
		jle	short M005_L_AE72
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,79h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		xor	AX,AX
		db	0E9h
		dw	0022Bh
M005_L_AE72:
		xor	AX,AX
		push	AX
		xor	DX,DX
		push	AX
		push	DX
		push	AX
		push	AX
		mov	AL,0
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	00554h
		mov	SI,AX
M005_L_AE90:
		mov	AX,DGROUP:M005_BCC_DATA_77D3
		mov	DGROUP:M005_BCC_DATA_66BE,AX
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,1
		je	short M005_L_AEC7
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,3
		je	short M005_L_AEC7
		cmp	byte ptr [BP-7],0
		je	short M005_L_AEC7
		cmp	byte ptr [BP-7],8
		je	short M005_L_AEC7
		cmp	byte ptr [BP-7],0Ah
		je	short M005_L_AEC7
		cmp	byte ptr [BP-7],9
		je	short M005_L_AEC7
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M005_L_AEC7:
		mov	word ptr [BP-4],0
		db	0E9h
		dw	001B8h
M005_L_AECF:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,3
		jne	short M005_L_AED9
		db	0E9h
		dw	000B3h
M005_L_AED9:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AEEA
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AEEF
M005_L_AEEA:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AEEF:
		mov	AX,DGROUP:M005_BCC_DATA_8638
		mov	word ptr [BP-10h],AX
		mov	AX,DGROUP:M005_BCC_DATA_863C
		mov	word ptr [BP-12h],AX
		mov	AX,DGROUP:M005_BCC_DATA_8632
		mov	word ptr [BP-14h],AX
		push	DI
		nop
		push	CS
		db	0E8h
		dw	0019Fh
		mov	word ptr [BP-16h],AX
		mov	AX,word ptr [BP-10h]
		mov	DGROUP:M005_BCC_DATA_8638,AX
		mov	AX,word ptr [BP-12h]
		mov	DGROUP:M005_BCC_DATA_863C,AX
		mov	AX,word ptr [BP-14h]
		mov	DGROUP:M005_BCC_DATA_8632,AX
		cmp	byte ptr DGROUP:M005_BCC_DATA_863A,0
		jne	short M005_L_AF28
		xor	AX,AX
		db	0E9h
		dw	00175h
M005_L_AF28:
		mov	word ptr [BP-2],0
		cmp	byte ptr DGROUP:M005_BCC_DATA_863A,2
		jne	short M005_L_AF42
		xor	DI,DI
		mov	word ptr [BP-16h],0
		mov	word ptr [BP-2],8
		jmp	short M005_L_AF65
M005_L_AF42:
		cmp	byte ptr DGROUP:M005_BCC_DATA_863A,3
		jne	short M005_L_AF65
		cmp	byte ptr [BP-8],1
		je	short M005_L_AF60
		cmp	byte ptr [BP-8],0
		je	short M005_L_AF60
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M005_L_AF60:
		mov	word ptr [BP-2],4
M005_L_AF65:
		mov	AX,12h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	SI
		push	word ptr [BP-16h]
		mov	AL,byte ptr [BP-2]
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	0045Bh
		mov	SI,AX
		db	0E9h
		dw	000DFh
M005_L_AF8C:
		cmp	byte ptr [BP-7],0Ah
		jne	short M005_L_AF9D
		mov	byte ptr [BP-7],9
		mov	word ptr [BP-4],1
		jmp	short M005_L_AFBA
M005_L_AF9D:
		cmp	byte ptr [BP-7],0
		je	short M005_L_AFBA
		cmp	byte ptr [BP-7],8
		je	short M005_L_AFBA
		cmp	byte ptr [BP-7],9
		je	short M005_L_AFBA
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M005_L_AFBA:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_AFCB
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_AFD0
M005_L_AFCB:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_AFD0:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,4
		je	short M005_L_B049
		mov	AX,DGROUP:M005_BCC_DATA_8638
		mov	word ptr [BP-10h],AX
		mov	AX,1
		push	AX
		db	09Ah
		dw	X047_02
		dw	seg X047_02
		or	AX,AX
		jne	short M005_L_AFEF
		xor	AX,AX
		db	0E9h
		dw	000AEh
M005_L_AFEF:
		mov	AX,word ptr [BP-10h]
		mov	DGROUP:M005_BCC_DATA_8638,AX
		cmp	word ptr DGROUP:M005_BCC_DATA_826B,0
		jg	short M005_L_B01C
		jne	short M005_L_B005
		cmp	word ptr DGROUP:M005_BCC_DATA_8269,0
		ja	short M005_L_B01C
M005_L_B005:
		mov	AX,6Bh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	word ptr DGROUP:M005_BCC_DATA_826B,0
		mov	word ptr DGROUP:M005_BCC_DATA_8269,1
M005_L_B01C:
		mov	AX,11h
		push	AX
		push	word ptr DGROUP:M005_BCC_DATA_826B
		push	word ptr DGROUP:M005_BCC_DATA_8269
		push	SI
		xor	AX,AX
		push	AX
		mov	AL,byte ptr [BP-4]
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	003A2h
		mov	SI,AX
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,1
		jmp	short M005_L_B06B
M005_L_B049:
		mov	AX,11h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		push	SI
		push	AX
		mov	AL,byte ptr [BP-4]
		push	AX
		lea	AX,[BP-8]
		mov	DX,SS
		mov	CX,4
		db	09Ah
		dw	BCC_FAR_03C2
		dw	seg BCC_FAR_03C2
		db	0E8h
		dw	00379h
		mov	SI,AX
M005_L_B06B:
		cmp	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		je	short M005_L_B07C
		mov	byte ptr DGROUP:M005_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M005_BCC_STMT_TYPE_CURRENT
		jmp	short M005_L_B081
M005_L_B07C:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M005_L_B081:
		mov	AX,DGROUP:M005_BCC_DATA_77D3
		mov	DGROUP:M005_BCC_DATA_66BE,AX
M005_L_B087:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,1
		jne	short M005_L_B091
		db	0E9h
		dw	0FE3Eh
M005_L_B091:
		cmp	word ptr DGROUP:M005_BCC_STMT_TYPE_CURRENT,3
		jne	short M005_L_B09B
		db	0E9h
		dw	0FE34h
M005_L_B09B:
		mov	AX,SI
M005_L_B09D:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_ACA2	endp
CO04D_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far
		extrn	X046_03:far
		extrn	X046_02:far
		extrn	X046_07:far
		extrn	X046_09:far
		extrn	X046_08:far
		extrn	X04A_0D:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M006_BCC_DATA_16F5	equ	16F5h
M006_BCC_EXPR_SEGMENT	equ	639Ah
M006_BCC_DATA_679C	equ	679Ch
M006_BCC_TOKEN_SAVED	equ	77FDh
M006_BCC_DATA_782E	equ	782Eh
M006_BCC_DATA_7830	equ	7830h
M006_BCC_DATA_8196	equ	8196h
M006_BCC_STMT_TYPE_CURRENT	equ	8260h
M006_BCC_DATA_8269	equ	8269h
M006_BCC_DATA_861A	equ	861Ah
M006_BCC_DATA_861C	equ	861Ch
M006_BCC_DATA_8624	equ	8624h
M006_BCC_DATA_862E	equ	862Eh
M006_BCC_DATA_863A	equ	863Ah

		public	X04D_02
X04D_02	label	far
BCC_NEAR_B0A6	label	near
BCC_FAR_B0A6	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	AX,DGROUP:M006_BCC_DATA_862E
		mov	word ptr [BP-4],AX
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,2
		jne	short M006_L_B0BE
		db	0E9h
		dw	002B7h
M006_L_B0BE:
		push	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		jne	short M006_L_B0CE
		db	0E9h
		dw	001E4h
M006_L_B0CE:
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F5,1
		jne	short M006_L_B0EA
		mov	AX,DGROUP:M006_BCC_DATA_679C
		mov	word ptr [BP-8],AX
		push	word ptr DGROUP:M006_BCC_DATA_679C
		db	09Ah
		dw	X04A_0D
		dw	seg X04A_0D
		mov	word ptr [BP-6],AX
		mov	DGROUP:M006_BCC_DATA_679C,AX
M006_L_B0EA:
		xor	SI,SI
M006_L_B0EC:
		db	09Ah
		dw	X046_07
		dw	seg X046_07
		mov	DI,AX
		or	DI,DI
		jne	short M006_L_B118
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F5,1
		jne	short M006_L_B110
		mov	AX,word ptr [BP-8]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	word ptr DGROUP:M006_BCC_DATA_7830,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_782E,AX
M006_L_B110:
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		db	0E9h
		dw	00262h
M006_L_B118:
		cmp	word ptr DGROUP:M006_BCC_DATA_8624,0
		jne	short M006_L_B121
		jmp	short M006_L_B13F
M006_L_B121:
		cmp	word ptr DGROUP:M006_BCC_DATA_8624,0Dh
		je	short M006_L_B145
		push	DS
		mov	BX,word ptr DGROUP:M006_BCC_DATA_8624
		shl	BX,1
		push	word ptr [BX+37DAh]
		mov	AX,102h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
M006_L_B13F:
		mov	word ptr DGROUP:M006_BCC_DATA_8624,6
M006_L_B145:
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,8
		je	short M006_L_B194
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,2
		je	short M006_L_B194
		push	CS
		db	0E8h
		dw	0F99Ah
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M006_L_B187
		mov	AX,word ptr [BP-4]
		mov	DGROUP:M006_BCC_DATA_862E,AX
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F5,1
		jne	short M006_L_B17F
		mov	AX,word ptr [BP-8]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	word ptr DGROUP:M006_BCC_DATA_7830,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_782E,AX
M006_L_B17F:
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		db	0E9h
		dw	001F3h
M006_L_B187:
		push	word ptr [BP-2]
		push	DI
		nop
		push	CS
		db	0E8h
		dw	002B3h
		mov	DI,AX
		jmp	short M006_L_B19A
M006_L_B194:
		mov	word ptr DGROUP:M006_BCC_DATA_861C,0
M006_L_B19A:
		mov	AX,word ptr [BP-4]
		mov	DGROUP:M006_BCC_DATA_862E,AX
		push	SI
		push	word ptr DGROUP:M006_BCC_DATA_861C
		push	DI
		push	word ptr DGROUP:M006_BCC_DATA_8624
		db	09Ah
		dw	X046_08
		dw	seg X046_08
		mov	SI,AX
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,8
		je	short M006_L_B1C0
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,1
		db	0E9h
		dw	00089h
M006_L_B1C0:
		cmp	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		je	short M006_L_B1D1
		mov	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M006_BCC_STMT_TYPE_CURRENT
		jmp	short M006_L_B1D6
M006_L_B1D1:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M006_L_B1D6:
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,9
		jne	short M006_L_B1FA
		cmp	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		je	short M006_L_B1EE
		mov	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M006_BCC_STMT_TYPE_CURRENT
		jmp	short M006_L_B1F3
M006_L_B1EE:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M006_L_B1F3:
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,3
		jmp	short M006_L_B249
M006_L_B1FA:
		push	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		je	short M006_L_B20A
		db	0E9h
		dw	0FEE2h
M006_L_B20A:
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,2
		jne	short M006_L_B21C
		mov	AX,0CDh
		jmp	short M006_L_B21F
M006_L_B21C:
		mov	AX,0E9h
M006_L_B21F:
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F5,1
		jne	short M006_L_B241
		mov	AX,word ptr [BP-8]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	word ptr DGROUP:M006_BCC_DATA_7830,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_782E,AX
M006_L_B241:
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		db	0E9h
		dw	00131h
M006_L_B249:
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F5,1
		jne	short M006_L_B262
		mov	AX,word ptr [BP-8]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	word ptr DGROUP:M006_BCC_DATA_7830,0
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_782E,AX
M006_L_B262:
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,2
		je	short M006_L_B283
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0E9h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		db	0E9h
		dw	000F7h
M006_L_B283:
		or	SI,SI
		je	short M006_L_B2AD
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8196
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],0Ch
		jne	short M006_L_B2AD
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8196
		cmp	word ptr ES:[SI+6],0
		jne	short M006_L_B2AD
		cmp	word ptr ES:[SI+4],0
		jne	short M006_L_B2AD
		xor	SI,SI
M006_L_B2AD:
		mov	AX,SI
		db	0E9h
		dw	000CAh
M006_L_B2B2:
		cmp	word ptr [BP+6],0
		jne	short M006_L_B2D2
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,86h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		db	0E9h
		dw	000A8h
M006_L_B2D2:
		mov	AX,DGROUP:M006_BCC_DATA_679C
		mov	word ptr [BP-6],AX
		db	09Ah
		dw	X046_02
		dw	seg X046_02
		xor	SI,SI
M006_L_B2DF:
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,31h
		je	short M006_L_B305
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0E9h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		jmp	short M006_L_B37A
M006_L_B305:
		push	SI
		push	word ptr DGROUP:M006_BCC_DATA_8269
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X046_08
		dw	seg X046_08
		mov	SI,AX
		cmp	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		je	short M006_L_B326
		mov	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M006_BCC_STMT_TYPE_CURRENT
		jmp	short M006_L_B32B
M006_L_B326:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M006_L_B32B:
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,2
		je	short M006_L_B371
		cmp	word ptr DGROUP:M006_BCC_STMT_TYPE_CURRENT,8
		je	short M006_L_B358
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0CAh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M006_BCC_DATA_679C,AX
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,0
		jmp	short M006_L_B37A
M006_L_B358:
		cmp	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		je	short M006_L_B369
		mov	byte ptr DGROUP:M006_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M006_BCC_STMT_TYPE_CURRENT
		jmp	short M006_L_B36E
M006_L_B369:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M006_L_B36E:
		db	0E9h
		dw	0FF6Eh
M006_L_B371:
		mov	word ptr DGROUP:M006_BCC_DATA_861A,SI
M006_L_B375:
		mov	byte ptr DGROUP:M006_BCC_DATA_863A,2
M006_L_B37A:
		xor	AX,AX
M006_L_B37C:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_B0A6	endp
CO04D_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M007_BCC_TOKEN_SAVED	equ	77FDh
M007_BCC_STMT_TYPE_CURRENT	equ	8260h

BCC_NEAR_B384	proc	near
		push	SI
		xor	SI,SI
M007_L_B387:
		mov	AX,DGROUP:M007_BCC_STMT_TYPE_CURRENT
		cmp	AX,4Ah
		je	short M007_L_B396
		cmp	AX,4Bh
		je	short M007_L_B3AD
		jmp	short M007_L_B3C4
M007_L_B396:
		test	SI,1
		je	short M007_L_B3A7
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M007_L_B3A7:
		db	081h,0CEh,001h,000h
		jmp	short M007_L_B3C8
M007_L_B3AD:
		test	SI,2
		je	short M007_L_B3BE
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M007_L_B3BE:
		db	081h,0CEh,002h,000h
		jmp	short M007_L_B3C8
M007_L_B3C4:
		mov	AX,SI
		jmp	short M007_L_B3E0
M007_L_B3C8:
		cmp	byte ptr DGROUP:M007_BCC_TOKEN_SAVED,0
		je	short M007_L_B3D9
		mov	byte ptr DGROUP:M007_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M007_BCC_STMT_TYPE_CURRENT
		jmp	short M007_L_B3DE
M007_L_B3D9:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M007_L_B3DE:
		jmp	short M007_L_B387
M007_L_B3E0:
		pop	SI
		ret
BCC_NEAR_B384	endp
CO04D_TEXT	ends


		extrn	BCC_FAR_0402:far
		extrn	X043_00:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M008_BCC_DATA_817E	equ	817Eh

BCC_NEAR_B3E2	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,817Eh
		push	AX
		mov	AX,0Dh
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	SI,AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_817E
		mov	AL,byte ptr [BP+12h]
		mov	byte ptr ES:[SI],AL
		mov	AX,word ptr [BP+0Ah]
		mov	word ptr ES:[SI+9],AX
		mov	AX,word ptr [BP+10h]
		mov	DX,word ptr [BP+0Eh]
		mov	word ptr ES:[SI+4],AX
		mov	word ptr ES:[SI+2],DX
		mov	AL,byte ptr [BP+8]
		mov	byte ptr ES:[SI+1],AL
		mov	AX,word ptr [BP+0Ch]
		mov	word ptr ES:[SI+0Bh],AX
		mov	AX,SI
		add	AX,6
		push	word ptr DGROUP:M008_BCC_DATA_817E
		push	AX
		lea	AX,[BP+4]
		push	SS
		push	AX
		mov	CX,3
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	AX,SI
		pop	SI
		pop	BP
		dec	BP
		ret	10h
BCC_NEAR_B3E2	endp
CO04D_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	X043_04:far
		extrn	X04F_13:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M009_BCC_EXPR_SEGMENT	equ	639Ah
M009_BCC_DATA_817E	equ	817Eh
M009_BCC_DATA_861E	equ	861Eh
M009_BCC_DATA_8620	equ	8620h
M009_BCC_DATA_862E	equ	862Eh

		public	X04D_03
X04D_03	label	far
BCC_NEAR_B443	label	near
BCC_FAR_B443	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		mov	word ptr DGROUP:M009_BCC_DATA_861E,0
		mov	word ptr DGROUP:M009_BCC_DATA_8620,0
		db	0E9h
		dw	00211h
M009_L_B45D:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	DI,word ptr ES:[SI+0Bh]
		cmp	byte ptr ES:[SI],11h
		jne	short M009_L_B4BE
		mov	ES,word ptr DGROUP:M009_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP+6]
		cmp	byte ptr ES:[BX],12h
		je	short M009_L_B47E
		cmp	byte ptr ES:[BX],0Ch
		jne	short M009_L_B481
M009_L_B47E:
		db	0E8h
		dw	001FFh
M009_L_B481:
		mov	ES,word ptr DGROUP:M009_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP+6]
		cmp	byte ptr ES:[BX],11h
		jne	short M009_L_B49E
		cmp	byte ptr ES:[BX+9],0
		je	short M009_L_B49E
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	byte ptr ES:[SI+1],1
M009_L_B49E:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		push	word ptr ES:[SI+4]
		push	word ptr ES:[SI+2]
		push	word ptr [BP+6]
		mov	AL,byte ptr ES:[SI+1]
		cbw
		push	AX
		db	09Ah
		dw	X04F_13
		dw	seg X04F_13
		mov	word ptr [BP+6],AX
		db	0E9h
		dw	001A3h
M009_L_B4BE:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[SI],12h
		je	short M009_L_B4CB
		db	0E9h
		dw	000ECh
M009_L_B4CB:
		mov	AL,byte ptr ES:[SI+7]
		cbw
		mov	word ptr [BP-2],AX
		mov	AL,byte ptr ES:[SI+6]
		cbw
		mov	word ptr [BP-6],AX
		or	DI,DI
		je	short M009_L_B55C
		cmp	word ptr [BP-2],0
		jne	short M009_L_B4ED
		mov	AL,byte ptr ES:[DI+7]
		cbw
		mov	word ptr [BP-2],AX
M009_L_B4ED:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[SI+8],0
		jne	short M009_L_B505
		mov	AL,byte ptr ES:[DI+8]
		mov	byte ptr ES:[SI+8],AL
		mov	byte ptr ES:[DI+8],0
M009_L_B505:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[DI],0Dh
		jne	short M009_L_B51F
		cmp	byte ptr ES:[DI+7],0
		jne	short M009_L_B541
		mov	AL,byte ptr [BP-2]
		mov	byte ptr ES:[DI+7],AL
		jmp	short M009_L_B541
M009_L_B51F:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	AL,byte ptr ES:[DI+7]
		cbw
		cmp	AX,word ptr [BP-2]
		je	short M009_L_B538
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M009_L_B538:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	byte ptr ES:[DI+7],0
M009_L_B541:
		cmp	word ptr [BP-6],0
		jne	short M009_L_B553
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	AL,byte ptr ES:[DI+6]
		cbw
		mov	word ptr [BP-6],AX
M009_L_B553:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	byte ptr ES:[DI+6],0
M009_L_B55C:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	AL,byte ptr ES:[SI+1]
		or	AL,byte ptr ES:[SI+8]
		cbw
		mov	word ptr [BP-4],AX
		mov	AX,word ptr [BP-2]
		cmp	AX,8
		je	short M009_L_B580
		cmp	AX,9
		je	short M009_L_B587
		cmp	AX,0Ah
		je	short M009_L_B58E
		jmp	short M009_L_B593
M009_L_B580:
		db	081h,04Eh,0FCh,040h,000h
		jmp	short M009_L_B593
M009_L_B587:
		db	081h,04Eh,0FCh,001h,000h
		jmp	short M009_L_B593
M009_L_B58E:
		db	081h,04Eh,0FCh,003h,000h
M009_L_B593:
		push	word ptr [BP+6]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		push	word ptr ES:[SI+9]
		mov	AL,byte ptr [BP-6]
		push	AX
		mov	AL,byte ptr [BP-4]
		push	AX
		nop
		push	CS
		db	0E8h
		dw	000FEh
		mov	word ptr [BP+6],AX
		mov	word ptr DGROUP:M009_BCC_DATA_862E,0
		db	0E9h
		dw	000AAh
M009_L_B5B7:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[SI],0Dh
		jne	short M009_L_B62E
		or	DI,DI
		je	short M009_L_B5DF
		cmp	byte ptr ES:[DI],0
		jne	short M009_L_B5DF
		cmp	byte ptr ES:[DI+6],0
		jne	short M009_L_B5DF
		mov	AL,byte ptr ES:[SI+6]
		mov	byte ptr ES:[DI+6],AL
		mov	byte ptr ES:[SI+6],0
M009_L_B5DF:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[SI+6],0
		jne	short M009_L_B5F1
		cmp	byte ptr ES:[SI+8],0
		je	short M009_L_B5FC
M009_L_B5F1:
		mov	AX,31h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M009_L_B5FC:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	AL,byte ptr ES:[SI+1]
		cbw
		mov	word ptr [BP-2],AX
		mov	AX,DGROUP:M009_BCC_DATA_862E
		mov	word ptr [BP-8],AX
		push	word ptr [BP+6]
		mov	AL,byte ptr [BP-8]
		push	AX
		push	word ptr ES:[SI+9]
		mov	AL,byte ptr ES:[SI+7]
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00116h
		mov	word ptr [BP+6],AX
		mov	AX,word ptr [BP-2]
		mov	DGROUP:M009_BCC_DATA_862E,AX
		jmp	short M009_L_B661
M009_L_B62E:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		mov	AL,byte ptr ES:[SI+6]
		cbw
		mov	DGROUP:M009_BCC_DATA_861E,AX
		cmp	byte ptr ES:[SI+7],9
		je	short M009_L_B648
		cmp	byte ptr ES:[SI+7],0Ah
		jne	short M009_L_B650
M009_L_B648:
		mov	word ptr DGROUP:M009_BCC_DATA_8620,9
		jmp	short M009_L_B661
M009_L_B650:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_817E
		cmp	byte ptr ES:[SI+7],8
		jne	short M009_L_B661
		mov	word ptr DGROUP:M009_BCC_DATA_8620,8
M009_L_B661:
		push	DS
		mov	AX,817Eh
		push	AX
		push	SI
		db	09Ah
		dw	X043_04
		dw	seg X043_04
		mov	SI,DI
M009_L_B66E:
		or	SI,SI
		je	short M009_L_B675
		db	0E9h
		dw	0FDE8h
M009_L_B675:
		mov	AX,word ptr [BP+6]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_B443	endp
CO04D_TEXT	ends



		extrn	BCC_FAR_5B8B:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

BCC_NEAR_B680	proc	near
		mov	AX,14h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		ret
BCC_NEAR_B680	endp
CO04D_TEXT	ends


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M00B_BCC_DATA_817E	equ	817Eh


		public	X04D_04
X04D_04	label	far
BCC_FAR_B68C	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_817E
		cmp	byte ptr ES:[SI],0
		jne	short M00B_L_B6A2
		mov	AX,1
		jmp	short M00B_L_B6A4
M00B_L_B6A2:
		xor	AX,AX
M00B_L_B6A4:
		pop	SI
		pop	BP
		retf	2
BCC_FAR_B68C	endp
CO04D_TEXT	ends


		extrn	X04F_08:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M00C_BCC_DATA_16EF	equ	16EFh
M00C_BCC_DATA_1705	equ	1705h
M00C_BCC_EXPR_SEGMENT	equ	639Ah
M00C_BCC_DATA_77D1	equ	77D1h

		public	X04D_07
X04D_07	label	far
BCC_NEAR_B6A9	label	near
BCC_FAR_B6A9	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+0Ch]
		cmp	byte ptr [BP+8],4
		jne	short M00C_L_B6BC
		or	byte ptr [BP+6],3
		jmp	short M00C_L_B70A
M00C_L_B6BC:
		cmp	byte ptr [BP+8],0
		jne	short M00C_L_B6E6
		mov	AL,DGROUP:M00C_BCC_DATA_1705
		cbw
		or	AX,AX
		je	short M00C_L_B6D6
		cmp	AX,1
		je	short M00C_L_B6DC
		cmp	AX,2
		je	short M00C_L_B6E2
		jmp	short M00C_L_B6E6
M00C_L_B6D6:
		mov	byte ptr [BP+8],1
		jmp	short M00C_L_B6E6
M00C_L_B6DC:
		mov	byte ptr [BP+8],2
		jmp	short M00C_L_B6E6
M00C_L_B6E2:
		mov	byte ptr [BP+8],3
M00C_L_B6E6:
		test	byte ptr [BP+6],43h
		jne	short M00C_L_B70A
		cmp	byte ptr DGROUP:M00C_BCC_DATA_16EF,5
		jne	short M00C_L_B6F9
		or	byte ptr [BP+6],3
		jmp	short M00C_L_B70A
M00C_L_B6F9:
		cmp	byte ptr DGROUP:M00C_BCC_DATA_77D1,0
		je	short M00C_L_B706
		or	byte ptr [BP+6],1
		jmp	short M00C_L_B70A
M00C_L_B706:
		or	byte ptr [BP+6],40h
M00C_L_B70A:
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,11h
		je	short M00C_L_B71F
		cmp	AX,12h
		je	short M00C_L_B71F
		jmp	short M00C_L_B722
M00C_L_B71F:
		db	0E8h
		dw	0FF5Eh
M00C_L_B722:
		push	SI
		push	word ptr [BP+0Ah]
		mov	AL,byte ptr [BP+8]
		push	AX
		mov	AL,byte ptr [BP+6]
		cbw
		push	AX
		db	09Ah
		dw	X04F_08
		dw	seg X04F_08
		pop	SI
		pop	BP
		retf	8
BCC_FAR_B6A9	endp
CO04D_TEXT	ends

; END C125UNIT
; BEGIN STOVR95 (listing ovr_1d1a_9aac:B739)

		extrn	X04F_11:far


CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT,ds:DGROUP

M00D_BCC_EXPR_SEGMENT	equ	639Ah
M00D_BCC_DATA_77D1	equ	77D1h
M00D_BCC_DATA_77D2	equ	77D2h

		public	X04D_06
X04D_06	label	far
BCC_NEAR_B739	label	near
BCC_FAR_B739	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Ch]
		xor	DI,DI
		mov	AL,byte ptr [BP+6]
		cbw
		mov	BX,AX
		cmp	BX,0Ah
		jbe	short M00D_L_B754
		db	0E9h
		dw	00081h
M00D_L_B754:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D30h
		mov	AL,byte ptr [BP+6]
		cbw
		mov	DI,AX
		jmp	short M00D_L_B7D0
		mov	word ptr [BP-2],0Fh
		jmp	short M00D_L_B7D5
		mov	word ptr [BP-2],0Eh
		jmp	short M00D_L_B7D5
		mov	word ptr [BP-2],10h
		jmp	short M00D_L_B7D5
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],12h
		jne	short M00D_L_B787
		mov	DI,2
		jmp	short M00D_L_B7D0
M00D_L_B787:
		mov	DI,4
		jmp	short M00D_L_B7D0
		jmp	short M00D_L_B7D0
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI],12h
		jne	short M00D_L_B7BF
		mov	AL,byte ptr ES:[SI+8]
		cbw
		mov	word ptr [BP-4],AX
		cmp	byte ptr DGROUP:M00D_BCC_DATA_77D1,0
		jne	short M00D_L_B7AE
		test	word ptr [BP-4],1
		je	short M00D_L_B7B5
M00D_L_B7AE:
		mov	word ptr [BP-2],0Fh
		jmp	short M00D_L_B7D5
M00D_L_B7B5:
		mov	DI,2
		mov	word ptr [BP-2],0Dh
		jmp	short M00D_L_B7D5
M00D_L_B7BF:
		cmp	byte ptr DGROUP:M00D_BCC_DATA_77D2,0
		je	short M00D_L_B7CD
		mov	word ptr [BP-2],0Fh
		jmp	short M00D_L_B7D5
M00D_L_B7CD:
		mov	DI,4
M00D_L_B7D0:
		mov	word ptr [BP-2],0Dh
M00D_L_B7D5:
		push	SI
		mov	AL,byte ptr [BP-2]
		push	AX
		mov	AL,byte ptr [BP+0Ah]
		cbw
		push	AX
		push	word ptr [BP+8]
		push	DI
		db	09Ah
		dw	X04F_11
		dw	seg X04F_11
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_B739	endp
CO04D_TEXT	ends

; STOVT96 (B7F0): STOVR95's jump table, part of the same module
CO04D_TEXT	segment byte public 'CODE'
		assume	cs:CO04D_TEXT

BCC_TABLE_B7F0	label	word
		dw	00CCEh
		dw	00C9Bh
		dw	00C9Bh
		dw	00C9Bh
		dw	00C9Bh
		dw	00C9Bh
		dw	00C9Bh
		dw	00CAAh
		dw	00CB8h
		dw	00CA3h
		dw	00CB1h

CO04D_TEXT	ends
; END STOVR95
		end
