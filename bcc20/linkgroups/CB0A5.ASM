DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_165
; BEGIN RC165 (listing CODE_165:0000)
CODE_165	segment byte public 'CODE'
		assume	cs:CODE_165

		public	BCC_FAR_DB6F

		db	0CDh,03Fh,000h,000h,040h,0C2h,005h,000h,017h,005h,01Ch,000h,008h,000h	; CODE_165:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_165:000E
		db	000h,000h,000h,000h,0EAh,0F3h,002h,054h,0AFh
		public	BCC_RF_1DB4_0025
BCC_RF_1DB4_0025	label	far
		db	0EAh,091h,001h,054h,0AFh; CODE_165:001C
		db	0EAh,045h,000h,054h,0AFh	; CODE_165:002A
BCC_FAR_DB6F	label	far
		db	0EAh,0D0h,004h,054h,0AFh,0EAh,065h,004h,054h,0AFh
		public	BCC_TYPE_FIND_CONTEXT
BCC_TYPE_FIND_CONTEXT	label	far
		db	0EAh,0DCh,001h,054h; CODE_165:002F
		db	0AFh,0EAh,004h,002h,054h,0AFh,0EAh,062h,003h,054h,0AFh,000h,000h,000h	; CODE_165:003D
		db	000h,000h,000h,000h,000h	; CODE_165:004B

CODE_165	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC165
		end
