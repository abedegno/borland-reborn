DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_159
; BEGIN RC159 (listing CODE_159:0000)
CODE_159	segment byte public 'CODE'
		assume	cs:CODE_159

		public	BCC_FAR_D9F0

		db	0CDh,03Fh,000h,000h,0E0h,075h,005h,000h,009h,012h,0AAh,000h,001h,000h	; CODE_159:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_159:000E
		db	000h,000h,000h,000h	; CODE_159:001C
BCC_FAR_D9F0	label	far
		db	0EAh,000h,000h,0C9h,0AAh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_159:0020
		db	000h,000h	; CODE_159:002E

CODE_159	ends
; END RC159
		end
