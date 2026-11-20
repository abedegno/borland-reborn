DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_104
; BEGIN RC104 (listing CODE_104:0000)
CODE_104	segment byte public 'CODE'
		assume	cs:CODE_104

		public	BCC_FAR_C9DF
		public	BCC_FAR_C9E4
		public	BCC_FAR_C9E9
		public	BCC_FAR_C9EE
		public	BCC_FAR_C9F3
		public	BCC_FAR_C9FD
		public	BCC_FAR_CA02
		public	BCC_FAR_CA07

		db	0CDh,03Fh,000h,000h,0D0h,0FDh,002h,000h,008h,00Ch,042h,000h,00Ch,000h	; CODE_104:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_104:000E
		db	000h,000h,000h,000h,0EAh,03Dh,003h,046h,082h
		public	BCC_RF_1C9B_0025
BCC_RF_1C9B_0025	label	far
		db	0EAh,032h,00Ah,046h,082h; CODE_104:001C
		public	BCC_RF_1C9B_002A
BCC_RF_1C9B_002A	label	far
		db	0EAh,0EDh,008h,046h,082h	; CODE_104:002A
BCC_FAR_C9DF	label	far
		db	0EAh,06Fh,00Ah,046h,082h	; CODE_104:002F
BCC_FAR_C9E4	label	far
		db	0EAh,063h,001h,046h,082h	; CODE_104:0034
BCC_FAR_C9E9	label	far
		db	0EAh,033h,00Bh,046h,082h	; CODE_104:0039
		public	BCC_INPUT_REFILL
BCC_INPUT_REFILL	label	far
		public	BCC_LEX_REFILL
BCC_LEX_REFILL	label	far
BCC_FAR_C9EE	label	far
		db	0EAh,046h,005h,046h,082h	; CODE_104:003E
		public	BCC_PATH_INCLUDE
BCC_PATH_INCLUDE	label	far
BCC_FAR_C9F3	label	far
		db	0EAh,08Ah,000h,046h,082h,0EAh,06Bh,002h,046h,082h	; CODE_104:0043
BCC_FAR_C9FD	label	far
		db	0EAh,0F8h,004h,046h,082h	; CODE_104:004D
BCC_FAR_CA02	label	far
		db	0EAh,0E8h,00Bh,046h,082h	; CODE_104:0052
BCC_FAR_CA07	label	far
		db	0EAh,0A6h,004h,046h,082h,000h,000h,000h,000h	; CODE_104:0057

CODE_104	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC104
		end
