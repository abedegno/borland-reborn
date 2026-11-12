DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_146
; BEGIN RC146 (listing CODE_146:0000)
CODE_146	segment byte public 'CODE'
		assume	cs:CODE_146

		public	BCC_FAR_D640
		public	BCC_FAR_D645
		public	BCC_FAR_D64A

		db	0CDh,03Fh,000h,000h,090h,001h,005h,000h,0A5h,000h,002h,000h,003h,000h	; CODE_146:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_146:000E
		db	000h,000h,000h,000h	; CODE_146:001C
		public	BCC_EMIT_FINISH
BCC_EMIT_FINISH	label	far
		public	BCC_STMT_TEMP_FREE
BCC_STMT_TEMP_FREE	label	far
BCC_FAR_D640	label	far
		db	0EAh,02Bh,000h,0BBh,0A3h	; CODE_146:0020
		public	BCC_EMIT_BEGIN
BCC_EMIT_BEGIN	label	far
		public	BCC_STMT_TEMP_NEW
BCC_STMT_TEMP_NEW	label	far
BCC_FAR_D645	label	far
		db	0EAh,000h,000h,0BBh,0A3h	; CODE_146:0025
		public	BCC_EMIT_VALUE
BCC_EMIT_VALUE	label	far
BCC_FAR_D64A	label	far
		db	0EAh,008h,000h,0BBh,0A3h,000h	; CODE_146:002A

CODE_146	ends
; Original-target semantic aliases (zero bytes)
; END RC146
		end
