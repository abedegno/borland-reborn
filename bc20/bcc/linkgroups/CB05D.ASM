DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_93
; BEGIN LR93 (root CODE_93:0000)
CODE_93	segment byte public 'CODE'
		assume	cs:CODE_93

		public	BCC_RF_1C5D_0020

		db	0CDh,03Fh,000h,000h,0D0h,04Bh,002h,000h,0F9h,001h,008h,000h,003h,000h	; CODE_93:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_93:000E
		db	000h,000h,000h,000h	; CODE_93:001C
BCC_RF_1C5D_0020	label	far
		db	0EAh,000h,000h,09Eh,075h,0EAh,089h,000h,09Eh,075h,0EAh,051h,001h,09Eh	; CODE_93:0020
		db	075h,000h	; CODE_93:002E

CODE_93	ends
; END LR93
		end
