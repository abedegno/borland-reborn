DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_133
; BEGIN RC133 (listing CODE_133:0000)
CODE_133	segment byte public 'CODE'
		assume	cs:CODE_133

		public	BCC_FAR_D220
		public	BCC_FAR_D22A
		public	BCC_FAR_D23E
		public	BCC_FAR_D266
		public	BCC_FAR_D270
		public	BCC_FAR_D275

		db	0CDh,03Fh,000h,000h,060h,080h,004h,000h,00Bh,00Bh,03Ah,000h,014h,000h	; CODE_133:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_133:000E
		db	000h,000h,000h,000h	; CODE_133:001C
BCC_FAR_D220	label	far
		db	0EAh,011h,000h,084h,09Bh
		public	BCC_RF_1D20_0025
BCC_RF_1D20_0025	label	far
		db	0EAh,0B0h,001h,084h,09Bh; CODE_133:0020
		public	BCC_STMT_TYPE_NEW
BCC_STMT_TYPE_NEW	label	far
BCC_FAR_D22A	label	far
		db	0EAh,05Eh,001h,084h,09Bh,0EAh,030h,008h,084h,09Bh,0EAh,0A2h,00Ah,084h	; CODE_133:002A
		db	09Bh
		public	BCC_STMT_TYPE_SIZE
BCC_STMT_TYPE_SIZE	label	far
		db	0EAh,0EAh,007h,084h,09Bh; CODE_133:0038
BCC_FAR_D23E	label	far
		db	0EAh,00Eh,001h,084h,09Bh,0EAh,07Ch,00Ah,084h,09Bh,0EAh,0F3h,009h,084h	; CODE_133:003E
		db	09Bh,0EAh,045h,00Ah,084h,09Bh,0EAh,08Fh,00Ah,084h,09Bh,0EAh,0B5h,00Ah	; CODE_133:004C
		db	084h,09Bh,0EAh,0EBh,001h,084h,09Bh,0EAh,058h,00Ah,084h,09Bh	; CODE_133:005A
		public	BCC_STMT_COMPARE
BCC_STMT_COMPARE	label	far
BCC_FAR_D266	label	far
		db	0EAh,021h,003h,084h,09Bh,0EAh,00Fh,006h,084h,09Bh	; CODE_133:0066
BCC_FAR_D270	label	far
		db	0EAh,027h,009h,084h,09Bh	; CODE_133:0070
BCC_FAR_D275	label	far
		db	0EAh,000h,009h,084h,09Bh,0EAh,000h,000h,084h,09Bh
		public	BCC_RF_1D20_007F
BCC_RF_1D20_007F	label	far
		db	0EAh,0CDh,000h,084h; CODE_133:0075
		db	09Bh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_133:0083

CODE_133	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC133
		end
