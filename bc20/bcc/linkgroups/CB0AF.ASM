DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_175
; BEGIN RC175 (listing CODE_175:0000)
CODE_175	segment byte public 'CODE'
		assume	cs:CODE_175

		public	BCC_FAR_DD70

		db	0CDh,03Fh,000h,000h,010h,0F3h,005h,000h,09Dh,006h,054h,000h,001h,000h	; CODE_175:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_175:000E
		db	000h,000h,000h,000h	; CODE_175:001C
BCC_FAR_DD70	label	far
		db	0EAh,000h,000h,058h,0B2h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_175:0020
		db	000h,000h	; CODE_175:002E

CODE_175	ends
; END RC175
		end
