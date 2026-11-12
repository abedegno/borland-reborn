DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_109
; BEGIN RC109 (listing CODE_109:0000)
CODE_109	segment byte public 'CODE'
		assume	cs:CODE_109

		public	BCC_FAR_CB40

		db	0CDh,03Fh,000h,000h,030h,02Fh,003h,000h,02Fh,000h,002h,000h,001h,000h	; CODE_109:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_109:000E
		db	000h,000h,000h,000h	; CODE_109:001C
BCC_FAR_CB40	label	far
		db	0EAh,000h,000h,03Ch,085h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_109:0020
		db	000h,000h	; CODE_109:002E

CODE_109	ends
; END RC109
		end
