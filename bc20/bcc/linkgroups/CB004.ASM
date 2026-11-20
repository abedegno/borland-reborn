; Direct-segment relocation references
		extrn	BCC_FAR_ABBB:far
		extrn	BCC_SEG_03:far
		extrn	__SEGTABLE__:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_4
; BEGIN RG4TAIL (raw tail CODE_4:0000..000E)
CODE_4	segment byte public 'CODE'
		assume cs:CODE_4

CODE_4 ends
; END RG4TAIL
; BEGIN MSGGET (raw function CODE_4:000E..003D)
CODE_4	segment byte public 'CODE'
		assume cs:CODE_4
		db	055h,08Bh,0ECh,083h,0ECh,004h,0B8h
		dw	seg __SEGTABLE__ + 122h
		db	050h,0B8h,000h,000h,050h; CODE_4:000E
		db	09Ah,004h,000h
		dw	seg BCC_SEG_03
		db	089h,056h,0FEh,089h,046h,0FCh,08Bh,056h,0FEh; CODE_4:001C
		db	08Bh,046h,006h,0D1h,0E0h,0C4h,05Eh,0FCh,003h,0D8h,026h,08Bh,007h,08Bh	; CODE_4:002A
		db	0E5h,05Dh,0CAh,002h,000h	; CODE_4:0038

CODE_4 ends
; END MSGGET
; BEGIN RG4A (listing CODE_4:003D)
CODE_4	segment byte public 'CODE'
		assume cs:CODE_4
	public BCC_NEAR_5AAD
BCC_NEAR_5AAD	label	near
		db	045h,055h,08Bh,0ECh,0FFh,076h,00Ch,0FFh,076h,00Ah,09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	059h,059h,083h,03Eh,0C4h,066h,000h,074h,015h,0FFh,036h,046h,078h; CODE_4:003D
		db	0FFh,036h,0C4h,066h,01Eh,0B8h,0E8h,010h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	083h,0C4h,008h,083h,03Eh,0BEh,066h,000h,074h,014h,033h,0C0h,050h,0FFh	; CODE_4:0067
		db	036h,0BEh,066h,01Eh,0B8h,0ECh,010h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	083h; CODE_4:0075
		db	0C4h,008h,01Eh,0B8h,0F1h,010h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	059h,059h; CODE_4:0083
		db	0FFh,076h,004h,00Eh,0E8h,076h,0FFh,052h,050h,0FFh,076h,008h,0FFh,076h	; CODE_4:0091
		db	006h,09Ah,031h,000h
		dw	seg BCC_FAR_ABBB
		db	0A1h,0C0h,066h,00Bh,006h,0C2h,066h,074h; CODE_4:009F
		db	015h,0FFh,036h,0C2h,066h,0FFh,036h,0C0h,066h,01Eh,0B8h,0C8h,010h,050h	; CODE_4:00AD
		db	09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	083h,0C4h,008h,01Eh,0B8h,0F4h,010h,050h,09Ah; CODE_4:00BB
		db	00Bh,000h
		dw	seg BCC_FAR_ABBB
		db	059h,059h,05Dh,04Dh,0C2h,00Ah,000h; CODE_4:00C9

CODE_4 ends
; END RG4A
; BEGIN R5B44 (listing CODE_4:00D4)

		extrn	BCC_FAR_577C:far


CODE_4	segment byte public 'CODE'
		assume	cs:CODE_4,ds:DGROUP

M001_BCC_DATA_10E6	equ	10E6h
M001_BCC_DATA_8644	equ	8644h
		public	BCC_FAR_5B44

		public	BCC_STRING_WARNING
BCC_STRING_WARNING	label	far
BCC_FAR_5B44	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	SI,word ptr [BP+6]
		lea	AX,[BP+8]
		mov	word ptr [BP-2],SS
		mov	word ptr [BP-4],AX
		push	DS
		cmp	SI,4
		jge	short M001_L_5B62
		mov	AX,10C2h
		jmp	short M001_L_5B65
M001_L_5B62:
		mov	AX,10E0h
M001_L_5B65:
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		push	SI
		db	0E8h
		dw	0FF3Dh
		inc	word ptr DGROUP:M001_BCC_DATA_8644
		inc	word ptr DGROUP:M001_BCC_DATA_10E6
		push	DS
		mov	AX,788Eh
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_577C
		dw	seg BCC_FAR_577C
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_5B44	endp
CODE_4	ends

; Original-target semantic aliases (zero bytes)
; END R5B44
; BEGIN R5B8B (listing CODE_4:011B)

		extrn	BCC_FAR_577C:far


CODE_4	segment byte public 'CODE'
		assume	cs:CODE_4,ds:DGROUP

M002_BCC_DATA_10E6	equ	10E6h
M002_BCC_DATA_16F9	equ	16F9h
M002_BCC_DATA_8644	equ	8644h
		public	BCC_FAR_5B8B

		public	BCC_DIAGNOSTIC
BCC_DIAGNOSTIC	label	far
		public	BCC_FATAL
BCC_FATAL	label	far
		public	BCC_OUTPUT_ERROR
BCC_OUTPUT_ERROR	label	far
		public	BCC_RF_15A7_011B
BCC_RF_15A7_011B	label	far
BCC_FAR_5B8B	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		lea	AX,[BP+8]
		mov	word ptr [BP-2],SS
		mov	word ptr [BP-4],AX
		push	DS
		mov	AX,10E0h
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		push	word ptr [BP+6]
		db	0E8h
		dw	0FF02h
		inc	word ptr DGROUP:M002_BCC_DATA_8644
		inc	word ptr DGROUP:M002_BCC_DATA_10E6
		cmp	byte ptr DGROUP:M002_BCC_DATA_16F9,0
		je	short M002_L_5BE9
		mov	AL,DGROUP:M002_BCC_DATA_16F9
		mov	AH,0
		cmp	AX,word ptr DGROUP:M002_BCC_DATA_8644
		jg	short M002_L_5BE9
		push	DS
		mov	AX,10E0h
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		mov	AX,3Dh
		push	AX
		db	0E8h
		dw	0FED6h
		inc	word ptr DGROUP:M002_BCC_DATA_8644
		push	DS
		mov	AX,788Eh
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_577C
		dw	seg BCC_FAR_577C
M002_L_5BE9:
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_5B8B	endp
CODE_4	ends

; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END R5B8B
; BEGIN R5BED (listing CODE_4:017D)

		extrn	BCC_FAR_577C:far


CODE_4	segment byte public 'CODE'
		assume	cs:CODE_4,ds:DGROUP

M003_BCC_DATA_10E6	equ	10E6h
M003_BCC_DATA_16FA	equ	16FAh
M003_BCC_DATA_8644	equ	8644h
		public	BCC_FAR_5BED

		public	BCC_DIAGNOSTIC_ALT
BCC_DIAGNOSTIC_ALT	label	far
		public	BCC_RF_15A7_017D
BCC_RF_15A7_017D	label	far
BCC_FAR_5BED	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AL,byte ptr [SI+62EDh]
		cbw
		or	AX,AX
		je	short M003_L_5C58
		lea	AX,[BP+8]
		mov	word ptr [BP-2],SS
		mov	word ptr [BP-4],AX
		push	DS
		mov	AX,10D8h
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		push	SI
		db	0E8h
		dw	0FE95h
		inc	word ptr DGROUP:M003_BCC_DATA_10E6
		cmp	byte ptr DGROUP:M003_BCC_DATA_16FA,0
		je	short M003_L_5C58
		mov	AL,DGROUP:M003_BCC_DATA_16FA
		mov	AH,0
		mov	DX,word ptr DGROUP:M003_BCC_DATA_10E6
		sub	DX,word ptr DGROUP:M003_BCC_DATA_8644
		cmp	AX,DX
		jg	short M003_L_5C58
		push	DS
		mov	AX,10E0h
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		mov	AX,3Dh
		push	AX
		db	0E8h
		dw	0FE67h
		inc	word ptr DGROUP:M003_BCC_DATA_8644
		push	DS
		mov	AX,788Eh
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_577C
		dw	seg BCC_FAR_577C
M003_L_5C58:
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_5BED	endp
CODE_4	ends

; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END R5BED
		end
