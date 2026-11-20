DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_103
; BEGIN RC103 (listing CODE_103:0000)
CODE_103	segment byte public 'CODE'
		assume	cs:CODE_103

		public	BCC_FAR_C965
		public	BCC_FAR_C97E
		public	BCC_FAR_C98D
		public	BCC_FAR_C997
		public	BCC_FAR_C9A6

		db	0CDh,03Fh,000h,000h,0C0h,0D7h,002h,000h,05Ah,024h,094h,001h,00Fh,000h	; CODE_103:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_103:000E
		db	000h,000h,000h,000h,0EAh,0BAh,000h,000h,080h	; CODE_103:001C
BCC_FAR_C965	label	far
		db	0EAh,0B0h,023h,000h,080h
		public	BCC_NAME_VALIDATE
BCC_NAME_VALIDATE	label	far
		public	BCC_RF_1C94_002A
BCC_RF_1C94_002A	label	far
		db	0EAh,0DFh,00Ch,000h,080h,0EAh,084h,012h,000h; CODE_103:0025
		db	080h,0EAh,0F6h,011h,000h,080h,0EAh,000h,000h,000h,080h	; CODE_103:0033
BCC_FAR_C97E	label	far
		db	0EAh,024h,01Ah,000h,080h,0EAh,0F4h,022h,000h,080h
		public	BCC_INPUT_SET
BCC_INPUT_SET	label	far
		db	0EAh,083h,00Ah,000h; CODE_103:003E
		db	080h	; CODE_103:004C
BCC_FAR_C98D	label	far
		db	0EAh,08Ch,011h,000h,080h,0EAh,0F0h,01Ch,000h,080h	; CODE_103:004D
		public	BCC_LEX_RESTORE
BCC_LEX_RESTORE	label	far
BCC_FAR_C997	label	far
		db	0EAh,07Fh,021h,000h,080h
		public	BCC_LEX_LOOKUP
BCC_LEX_LOOKUP	label	far
		db	0EAh,033h,013h,000h,080h
		public	BCC_RF_1C94_0061
BCC_RF_1C94_0061	label	far
		db	0EAh,052h,00Ah,000h; CODE_103:0057
		db	080h	; CODE_103:0065
		public	BCC_LEX_NEXT
BCC_LEX_NEXT	label	far
BCC_FAR_C9A6	label	far
		db	0EAh,001h,001h,000h,080h,000h,000h,000h,000h,000h	; CODE_103:0066

CODE_103	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC103
		end
