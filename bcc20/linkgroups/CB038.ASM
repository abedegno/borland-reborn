DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_56
; BEGIN RC56 (listing CODE_56:0000)
CODE_56	segment byte public 'CODE'
		assume	cs:CODE_56

		public	BCC_FAR_BB4A

		db	0CDh,03Fh,000h,000h,060h,05Ah,000h,000h,0ADh,009h,06Ch,000h,003h,000h	; CODE_56:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_56:000E
		db	000h,000h,000h,000h,0EAh,082h,009h,042h,052h,0EAh,000h,000h,042h,052h	; CODE_56:001C
BCC_FAR_BB4A	label	far
		db	0EAh,0F4h,005h,042h,052h,000h	; CODE_56:002A

CODE_56	ends
; END RC56
		end
