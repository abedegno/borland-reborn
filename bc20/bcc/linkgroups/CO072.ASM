; Recovered FBOV far-pointer references
CO05A_TEXT	segment byte public 'CODE'
CO05A_TEXT	ends
		public	X072_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dcd_b1c0
; BEGIN STAOV15F (listing ovr_1dcd_b1c0:1C00)

		extrn	BCC_FAR_038B:far
		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_9E70:far
		extrn	BCC_FAR_9F3B:far
		extrn	BCC_FAR_B0F1:far


CO072_TEXT	segment byte public 'CODE'
		assume	cs:CO072_TEXT,ds:DGROUP

M000_BCC_DATA_80C8	equ	80C8h
M000_BCC_DATA_8186	equ	8186h
M000_BCC_DATA_87E0	equ	87E0h
M000_BCC_DATA_87E2	equ	87E2h
M000_BCC_DATA_87E4	equ	87E4h
M000_BCC_DATA_87E8	equ	87E8h

		public	X072_00
X072_00	label	far
STAOV15F	proc	far
		push	BP
		mov	BP,SP
		sub	SP,1Ch
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		cmp	word ptr [BP+6],0
		je	short M000_L_1C1D
		mov	word ptr [BP-4],seg CO05A_TEXT
		mov	word ptr [BP-6],2Ah
		jmp	short M000_L_1C2A
M000_L_1C1D:
		mov	AX,DGROUP:M000_BCC_DATA_87E2
		mov	DX,word ptr DGROUP:M000_BCC_DATA_87E0
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-6],DX
M000_L_1C2A:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],2
		je	short M000_L_1C37
		db	0E9h
		dw	00093h
M000_L_1C37:
		mov	BX,word ptr ES:[DI+2]
		dec	BX
		cmp	BX,14h
		jbe	short M000_L_1C44
		db	0E9h
		dw	001CFh
M000_L_1C44:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	245h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AL,byte ptr ES:[DI+0Ah]
		push	AX
		db	0FFh,05Eh,0FAh
		db	0E9h
		dw	001B9h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AL,byte ptr ES:[DI+0Ah]
		push	AX
		db	0FFh,05Eh,0FAh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	DX,word ptr ES:[DI+0Ch]
		mov	AX,word ptr ES:[DI+0Ah]
		mov	CL,8
		db	09Ah
		dw	BCC_FAR_038B
		dw	seg BCC_FAR_038B
		push	AX
		db	0FFh,05Eh,0FAh
		db	0E9h
		dw	00193h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AL,byte ptr ES:[DI+0Ah]
		push	AX
		db	0FFh,05Eh,0FAh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	DX,word ptr ES:[DI+0Ch]
		mov	AX,word ptr ES:[DI+0Ah]
		mov	CL,8
		db	09Ah
		dw	BCC_FAR_038B
		dw	seg BCC_FAR_038B
		push	AX
		db	0FFh,05Eh,0FAh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+0Ch]
		cwd
		push	AX
		db	0FFh,05Eh,0FAh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	DX,word ptr ES:[DI+0Ch]
		mov	AX,word ptr ES:[DI+0Ah]
		mov	CL,18h
		db	09Ah
		dw	BCC_FAR_038B
		dw	seg BCC_FAR_038B
		push	AX
		db	0FFh,05Eh,0FAh
		db	0E9h
		dw	00149h
M000_L_1CCA:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],3
		je	short M000_L_1CD7
		db	0E9h
		dw	000A9h
M000_L_1CD7:
		mov	AX,word ptr ES:[DI+2]
		cmp	AX,9
		je	short M000_L_1CED
		cmp	AX,0Ah
		je	short M000_L_1D28
		cmp	AX,0Bh
		je	short M000_L_1D63
		db	0E9h
		dw	00126h
M000_L_1CED:
		push	SS
		lea	AX,[BP-1Ch]
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		push	SS
		lea	AX,[BP-1Ch]
		push	AX
		push	SS
		lea	AX,[BP-0Ah]
		push	AX
		db	09Ah
		dw	BCC_FAR_9E70
		dw	seg BCC_FAR_9E70
		xor	SI,SI
		jmp	short M000_L_1D20
M000_L_1D18:
		mov	AL,byte ptr [BP+SI-0Ah]
		push	AX
		db	0FFh,05Eh,0FAh
		inc	SI
M000_L_1D20:
		cmp	SI,4
		jl	short M000_L_1D18
		db	0E9h
		dw	000EBh
M000_L_1D28:
		push	SS
		lea	AX,[BP-1Ch]
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,DI
		add	AX,0Ah
		push	AX
		mov	AX,0Ah
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		push	SS
		lea	AX,[BP-1Ch]
		push	AX
		push	SS
		lea	AX,[BP-12h]
		push	AX
		db	09Ah
		dw	BCC_FAR_9F3B
		dw	seg BCC_FAR_9F3B
		xor	SI,SI
		jmp	short M000_L_1D5B
M000_L_1D53:
		mov	AL,byte ptr [BP+SI-12h]
		push	AX
		db	0FFh,05Eh,0FAh
		inc	SI
M000_L_1D5B:
		cmp	SI,8
		jl	short M000_L_1D53
		db	0E9h
		dw	000B0h
M000_L_1D63:
		xor	SI,SI
		jmp	short M000_L_1D78
M000_L_1D67:
		mov	BX,DI
		add	BX,0Ah
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AL,byte ptr ES:[BX+SI]
		push	AX
		db	0FFh,05Eh,0FAh
		inc	SI
M000_L_1D78:
		cmp	SI,0Ah
		jl	short M000_L_1D67
		db	0E9h
		dw	00093h
M000_L_1D80:
		mov	word ptr [BP-2],DI
		jmp	short M000_L_1D93
M000_L_1D85:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-2],AX
M000_L_1D93:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],35h
		je	short M000_L_1D85
		cmp	word ptr ES:[BX],32h
		jne	short M000_L_1DB0
		mov	BX,word ptr ES:[BX+0Ah]
		cmp	word ptr ES:[BX],1
		je	short M000_L_1DB2
M000_L_1DB0:
		jmp	short M000_L_1E08
M000_L_1DB2:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr ES:[DI+2]
		sub	BX,3
		cmp	BX,12h
		ja	short M000_L_1E08
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	21Fh
		mov	AX,38h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[BX+0Ah]
		push	word ptr ES:[BX+0Ch]
		db	0FFh,01Eh
		dw	87E4h
		jmp	short M000_L_1E13
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[BX+0Ah]
		push	word ptr ES:[BX+0Ch]
		db	0FFh,01Eh
		dw	87E8h
		jmp	short M000_L_1E13
M000_L_1E08:
		mov	AX,38h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M000_L_1E13:
		db	0FFh,01Eh
		dw	80C8h
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV15F	endp
CO072_TEXT	ends

CO072_TEXT	segment byte public 'CODE'
		assume	cs:CO072_TEXT

STOVT198	label	word
		dw	001DEh
		dw	001DEh
		dw	001DEh
		dw	001DEh
		dw	001F3h
		dw	001F3h
		dw	00208h
		dw	00208h
		dw	00208h
		dw	00208h
		dw	001DEh
		dw	001D3h
		dw	001F3h
		dw	001F3h
		dw	00208h
		dw	00208h
		dw	00208h
		dw	00208h
		dw	001DEh

CO072_TEXT	ends
CO072_TEXT	segment byte public 'CODE'
		assume	cs:CO072_TEXT

STOVT199	label	word
		dw	0004Bh
		dw	0004Bh
		dw	0005Ah
		dw	0005Ah
		dw	0005Ah
		dw	0005Ah
		dw	00080h
		dw	00080h
		dw	00213h
		dw	00213h
		dw	00213h
		dw	00213h
		dw	0005Ah
		dw	0005Ah
		dw	00080h
		dw	00080h
		dw	00213h
		dw	00213h
		dw	00213h
		dw	00213h
		dw	0005Ah

CO072_TEXT	ends
; END STAOV15F
		end
