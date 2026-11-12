DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_143
; BEGIN RC143 (listing CODE_143:0006)
CODE_143	segment byte public 'CODE'
		assume	cs:CODE_143

		public	BCC_FAR_D515
		public	BCC_FAR_D51A
		public	BCC_FAR_D524
		public	BCC_FAR_D529
		public	BCC_FAR_D52E
		public	BCC_FAR_D533
		public	BCC_FAR_D538
		public	BCC_FAR_D53D
		public	BCC_FAR_D542
		public	BCC_FAR_D547
		public	BCC_FAR_D54C
		public	BCC_FAR_D551
		public	BCC_FAR_D556
		public	BCC_FAR_D55B
		public	BCC_FAR_D560
		public	BCC_FAR_D565
		public	BCC_FAR_D56A

		db	004h,000h,02Eh,00Fh,03Ch,000h,014h,000h,000h,000h,000h,000h,000h,000h	; CODE_143:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0EAh,000h	; CODE_143:000E
		db	001h,076h,0A0h,0EAh
		public	BCC_RF_1D4F_0020
BCC_RF_1D4F_0020	label	far
		db	00Eh,00Fh,076h,0A0h,0EAh; CODE_143:001C
BCC_FAR_D515	label	far
		db	01Eh,00Fh,076h,0A0h,0EAh	; CODE_143:0025
BCC_FAR_D51A	label	far
		db	03Bh,000h,076h,0A0h,0EAh
		public	BCC_PARSE_ALLOC
BCC_PARSE_ALLOC	label	far
		db	0D7h,004h,076h,0A0h,0EAh; CODE_143:002A
BCC_FAR_D524	label	far
		db	05Bh,005h,076h,0A0h,0EAh	; CODE_143:0034
BCC_FAR_D529	label	far
		db	002h,00Bh,076h,0A0h,0EAh	; CODE_143:0039
BCC_FAR_D52E	label	far
		db	087h,005h,076h,0A0h,0EAh	; CODE_143:003E
BCC_FAR_D533	label	far
		public	BCC_PARSE_REPORT
BCC_PARSE_REPORT	label	far
		public	BCC_STMT_ATTACH
BCC_STMT_ATTACH	label	far
		db	0C2h,006h,076h,0A0h,0EAh	; CODE_143:0043
BCC_FAR_D538	label	far
		db	01Ah,00Eh,076h,0A0h,0EAh	; CODE_143:0048
BCC_FAR_D53D	label	far
		db	071h,005h,076h,0A0h,0EAh	; CODE_143:004D
BCC_FAR_D542	label	far
		db	060h,004h,076h,0A0h,0EAh	; CODE_143:0052
BCC_FAR_D547	label	far
		db	014h,006h,076h,0A0h,0EAh	; CODE_143:0057
BCC_FAR_D54C	label	far
		db	000h,000h,076h,0A0h,0EAh	; CODE_143:005C
BCC_FAR_D551	label	far
		db	08Ch,003h,076h,0A0h,0EAh	; CODE_143:0061
BCC_FAR_D556	label	far
		db	062h,003h,076h,0A0h,0EAh	; CODE_143:0066
BCC_FAR_D55B	label	far
		public	BCC_STMT_JOIN
BCC_STMT_JOIN	label	far
		db	0CEh,001h,076h,0A0h,0EAh	; CODE_143:006B
BCC_FAR_D560	label	far
		db	0C0h,003h,076h,0A0h,0EAh	; CODE_143:0070
BCC_FAR_D565	label	far
		db	078h,001h,076h,0A0h,0EAh	; CODE_143:0075
BCC_FAR_D56A	label	far
		public	BCC_STMT_ALLOC2
BCC_STMT_ALLOC2	label	far
		db	0D0h,002h,076h,0A0h,000h
		public	BCC_STMT_SETPOS
BCC_STMT_SETPOS	label	far
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h; CODE_143:007A
		db	000h,000h	; CODE_143:0088

CODE_143	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC143
		end
