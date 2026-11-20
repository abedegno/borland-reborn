DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_137
; BEGIN RC137 (listing CODE_137:0000)
CODE_137	segment byte public 'CODE'
		assume	cs:CODE_137

		public	BCC_FAR_D350

		db	0CDh,03Fh,000h,000h,090h,0A2h,004h,000h,0FBh,001h,024h,000h,001h,000h	; CODE_137:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_137:000E
		db	000h,000h,000h,000h	; CODE_137:001C
BCC_FAR_D350	label	far
		db	0EAh,000h,000h,087h,09Dh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_137:0020
		db	000h,000h	; CODE_137:002E

CODE_137	ends
; END RC137
		end
