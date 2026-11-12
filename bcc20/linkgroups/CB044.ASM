DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_68
; BEGIN RC68 (listing CODE_68:0000)
CODE_68	segment byte public 'CODE'
		assume	cs:CODE_68

		public	BCC_FAR_BE45
		public	BCC_FAR_BE54
		public	BCC_FAR_BE63
		public	BCC_FAR_BE6D
		public	BCC_FAR_BE7C
		public	BCC_FAR_BEA4
		public	BCC_FAR_BEB8
		public	BCC_FAR_BEC2
		public	BCC_FAR_BED6
		public	BCC_FAR_BEE0
		public	BCC_FAR_BEE5
		public	BCC_FAR_BEEA
		public	BCC_FAR_BEFE
		public	BCC_FAR_BF0D

		db	0CDh,03Fh,000h,000h,000h,020h,001h,000h,051h,021h,0A4h,001h,02Bh,000h	; CODE_68:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_68:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1BE2_0020
BCC_RF_1BE2_0020	label	far
		db	0EAh,0B1h,00Bh,000h,060h; CODE_68:001C
BCC_FAR_BE45	label	far
		db	0EAh,049h,002h,000h,060h,0EAh,071h,012h,000h,060h,0EAh,0B1h,019h,000h	; CODE_68:0025
		db	060h	; CODE_68:0033
BCC_FAR_BE54	label	far
		db	0EAh,05Ah,009h,000h,060h,0EAh,01Eh,019h,000h,060h,0EAh,045h,012h,000h	; CODE_68:0034
		db	060h	; CODE_68:0042
BCC_FAR_BE63	label	far
		db	0EAh,05Ah,01Ch,000h,060h
		public	BCC_TYPE_EQUIV
BCC_TYPE_EQUIV	label	far
		db	0EAh,0AFh,014h,000h,060h; CODE_68:0043
BCC_FAR_BE6D	label	far
		db	0EAh,099h,007h,000h,060h,0EAh,06Dh,000h,000h,060h,0EAh,012h,003h,000h	; CODE_68:004D
		db	060h	; CODE_68:005B
BCC_FAR_BE7C	label	far
		db	0EAh,0CDh,00Ch,000h,060h,0EAh,01Ah,007h,000h,060h,0EAh,084h,010h,000h	; CODE_68:005C
		db	060h,0EAh,0D6h,008h,000h,060h,0EAh,05Bh,012h,000h,060h
		public	BCC_TYPE_MERGE
BCC_TYPE_MERGE	label	far
		db	0EAh,018h,00Ch; CODE_68:006A
		db	000h,060h,0EAh,092h,008h,000h,060h,0EAh,02Dh,000h,000h,060h	; CODE_68:0078
BCC_FAR_BEA4	label	far
		db	0EAh,04Fh,006h,000h,060h
		public	BCC_TYPE_PRED
BCC_TYPE_PRED	label	far
		db	0EAh,016h,014h,000h,060h
		public	BCC_TYPE_JOIN
BCC_TYPE_JOIN	label	far
		db	0EAh,0CAh,013h,000h; CODE_68:0084
		db	060h,0EAh,0F3h,007h,000h,060h	; CODE_68:0092
BCC_FAR_BEB8	label	far
		db	0EAh,068h,00Ch,000h,060h,0EAh,0ECh,010h,000h,060h	; CODE_68:0098
BCC_FAR_BEC2	label	far
		db	0EAh,02Dh,00Fh,000h,060h,0EAh,013h,010h,000h,060h,0EAh,016h,00Dh,000h	; CODE_68:00A2
		db	060h,0EAh,000h,000h,000h,060h	; CODE_68:00B0
BCC_FAR_BED6	label	far
		db	0EAh,0D0h,001h,000h,060h,0EAh,033h,00Bh,000h,060h	; CODE_68:00B6
BCC_FAR_BEE0	label	far
		db	0EAh,07Ah,00Dh,000h,060h	; CODE_68:00C0
BCC_FAR_BEE5	label	far
		db	0EAh,088h,017h,000h,060h	; CODE_68:00C5
BCC_FAR_BEEA	label	far
		db	0EAh,011h,017h,000h,060h,0EAh,0FBh,012h,000h,060h
		public	BCC_TYPE_MARK
BCC_TYPE_MARK	label	far
		db	0EAh,0FDh,020h,000h; CODE_68:00CA
		db	060h
		public	BCC_EXPR_CHECK
BCC_EXPR_CHECK	label	far
		db	0EAh,062h,020h,000h,060h; CODE_68:00D8
BCC_FAR_BEFE	label	far
		db	0EAh,0E9h,020h,000h,060h,0EAh,04Ch,001h,000h,060h,0EAh,021h,006h,000h	; CODE_68:00DE
		db	060h	; CODE_68:00EC
BCC_FAR_BF0D	label	far
		db	0EAh,051h,01Fh,000h,060h,0EAh,03Bh,006h,000h,060h,000h,000h,000h,000h	; CODE_68:00ED
		db	000h,000h,000h,000h,000h	; CODE_68:00FB

CODE_68	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC68
		end
