DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_145
; BEGIN RC145 (listing CODE_145:0000)
CODE_145	segment byte public 'CODE'
		assume	cs:CODE_145

		public	BCC_FAR_D5E0
		public	BCC_FAR_D5E5
		public	BCC_FAR_D5EA
		public	BCC_FAR_D5EF
		public	BCC_FAR_D5F4
		public	BCC_FAR_D5F9
		public	BCC_FAR_D5FE
		public	BCC_FAR_D608
		public	BCC_FAR_D60D

		db	0CDh,03Fh,000h,000h,0A0h,0DDh,004h,000h,051h,022h,084h,001h,00Bh,000h	; CODE_145:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_145:000E
		db	000h,000h,000h,000h	; CODE_145:001C
BCC_FAR_D5E0	label	far
		db	0EAh,0A6h,00Ah,095h,0A1h	; CODE_145:0020
BCC_FAR_D5E5	label	far
		db	0EAh,02Fh,00Ah,095h,0A1h	; CODE_145:0025
BCC_FAR_D5EA	label	far
		db	0EAh,0DDh,00Ch,095h,0A1h	; CODE_145:002A
BCC_FAR_D5EF	label	far
		db	0EAh,031h,018h,095h,0A1h	; CODE_145:002F
BCC_FAR_D5F4	label	far
		db	0EAh,000h,000h,095h,0A1h	; CODE_145:0034
BCC_FAR_D5F9	label	far
		db	0EAh,0BEh,017h,095h,0A1h	; CODE_145:0039
BCC_FAR_D5FE	label	far
		db	0EAh,0ACh,00Ch,095h,0A1h,0EAh,00Ch,020h,095h,0A1h	; CODE_145:003E
BCC_FAR_D608	label	far
		db	0EAh,08Ah,013h,095h,0A1h	; CODE_145:0048
BCC_FAR_D60D	label	far
		db	0EAh,09Ch,015h,095h,0A1h,0EAh,03Ah,016h,095h,0A1h,000h,000h,000h,000h	; CODE_145:004D
		db	000h,000h,000h,000h,000h	; CODE_145:005B

CODE_145	ends
; END RC145
		end
