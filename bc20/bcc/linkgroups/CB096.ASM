DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_150
; BEGIN RC150 (listing CODE_150:0000)
CODE_150	segment byte public 'CODE'
		assume	cs:CODE_150

		public	BCC_FAR_D6F0
		public	BCC_FAR_D6F5
		public	BCC_FAR_D6FA
		public	BCC_FAR_D6FF
		public	BCC_FAR_D704
		public	BCC_FAR_D70E
		public	BCC_FAR_D713
		public	BCC_FAR_D71D
		public	BCC_FAR_D722
		public	BCC_FAR_D727
		public	BCC_FAR_D736

		db	0CDh,03Fh,000h,000h,080h,010h,005h,000h,0EBh,00Ch,08Ah,000h,00Fh,000h	; CODE_150:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_150:000E
		db	000h,000h,000h,000h	; CODE_150:001C
BCC_FAR_D6F0	label	far
		db	0EAh,0D7h,000h,09Bh,0A4h	; CODE_150:0020
BCC_FAR_D6F5	label	far
		db	0EAh,000h,000h,09Bh,0A4h	; CODE_150:0025
BCC_FAR_D6FA	label	far
		db	0EAh,0CFh,001h,09Bh,0A4h	; CODE_150:002A
BCC_FAR_D6FF	label	far
		db	0EAh,025h,001h,09Bh,0A4h	; CODE_150:002F
BCC_FAR_D704	label	far
		db	0EAh,08Ch,001h,09Bh,0A4h,0EAh,06Bh,001h,09Bh,0A4h	; CODE_150:0034
		public	BCC_PARSE_FREE
BCC_PARSE_FREE	label	far
BCC_FAR_D70E	label	far
		db	0EAh,035h,009h,09Bh,0A4h	; CODE_150:003E
		public	BCC_DEBUG_CHAR
BCC_DEBUG_CHAR	label	far
BCC_FAR_D713	label	far
		db	0EAh,0D2h,008h,09Bh,0A4h,0EAh,0C0h,001h,09Bh,0A4h	; CODE_150:0043
BCC_FAR_D71D	label	far
		db	0EAh,06Ch,002h,09Bh,0A4h	; CODE_150:004D
		public	BCC_DEBUG_STRING
BCC_DEBUG_STRING	label	far
BCC_FAR_D722	label	far
		db	0EAh,04Ch,00Ch,09Bh,0A4h	; CODE_150:0052
BCC_FAR_D727	label	far
		db	0EAh,087h,007h,09Bh,0A4h,0EAh,095h,000h,09Bh,0A4h,0EAh,036h,000h,09Bh	; CODE_150:0057
		db	0A4h	; CODE_150:0065
BCC_FAR_D736	label	far
		db	0EAh,094h,00Ch,09Bh,0A4h,000h,000h,000h,000h,000h	; CODE_150:0066

CODE_150	ends
; Original-target semantic aliases (zero bytes)
; END RC150
		end
