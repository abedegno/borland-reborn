DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_154
; BEGIN RC154 (listing CODE_154:0000)
CODE_154	segment byte public 'CODE'
		assume	cs:CODE_154

		public	BCC_FAR_D835
		public	BCC_FAR_D83F

		db	0CDh,03Fh,000h,000h,090h,036h,005h,000h,029h,016h,034h,000h,004h,000h	; CODE_154:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_154:000E
		db	000h,000h,000h,000h,0EAh,090h,00Dh,0F1h,0A6h	; CODE_154:001C
BCC_FAR_D835	label	far
		db	0EAh,028h,009h,0F1h,0A6h,0EAh,096h,015h,0F1h,0A6h	; CODE_154:0025
BCC_FAR_D83F	label	far
		db	0EAh,000h,000h,0F1h,0A6h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_154:002F
		db	000h,000h,000h	; CODE_154:003D

CODE_154	ends
; END RC154
		end
