DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_116
; BEGIN LR116 (root CODE_116:0000)
CODE_116	segment byte public 'CODE'
		assume	cs:CODE_116

		public	BCC_RF_1CCC_0039

		db	0CDh,03Fh,000h,000h,0B0h,052h,003h,000h,02Fh,00Eh,090h,000h,008h,000h	; CODE_116:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_116:000E
		db	000h,000h,000h,000h,0EAh,052h,00Dh,058h,087h,0EAh,084h,002h,058h,087h	; CODE_116:001C
		db	0EAh,04Dh,003h,058h,087h,0EAh,0F1h,000h,058h,087h,0EAh,08Fh,004h,058h	; CODE_116:002A
		db	087h	; CODE_116:0038
BCC_RF_1CCC_0039	label	far
		db	0EAh,020h,00Bh,058h,087h,0EAh,000h,000h,058h,087h,0EAh,061h,006h,058h	; CODE_116:0039
		db	087h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_116:0047

CODE_116	ends
; END LR116
		end
