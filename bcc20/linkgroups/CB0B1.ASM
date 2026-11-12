DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_177
; BEGIN RC177 (listing CODE_177:0000)
CODE_177	segment byte public 'CODE'
		assume	cs:CODE_177

		public	BCC_FAR_DE35
		public	BCC_FAR_DE44
		public	BCC_FAR_DE4E

		db	0CDh,03Fh,000h,000h,0C0h,00Bh,006h,000h,03Eh,006h,07Ch,000h,00Dh,000h	; CODE_177:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_177:000E
		db	000h,000h,000h,000h,0EAh,041h,003h,0C8h,0B3h	; CODE_177:001C
BCC_FAR_DE35	label	far
		db	0EAh,0E3h,005h,0C8h,0B3h,0EAh,0B9h,001h,0C8h,0B3h,0EAh,0E2h,001h,0C8h	; CODE_177:0025
		db	0B3h	; CODE_177:0033
		public	BCC_RF_1DE1_0034
BCC_RF_1DE1_0034	label	far
BCC_FAR_DE44	label	far
		db	0EAh,008h,006h,0C8h,0B3h,0EAh,04Ah,002h,0C8h,0B3h	; CODE_177:0034
BCC_FAR_DE4E	label	far
		db	0EAh,000h,000h,0C8h,0B3h,0EAh,06Eh,004h,0C8h,0B3h,0EAh,0A3h,004h,0C8h	; CODE_177:003E
		db	0B3h,0EAh,058h,003h,0C8h,0B3h,0EAh,02Dh,001h,0C8h,0B3h,0EAh,0E3h,003h	; CODE_177:004C
		db	0C8h,0B3h,0EAh,0CAh,004h,0C8h,0B3h,000h,000h,000h,000h,000h,000h,000h	; CODE_177:005A
		db	000h,000h,000h,000h,000h,000h,000h,000h	; CODE_177:0068

CODE_177	ends
; Target-qualified reference aliases (zero bytes)
; END RC177
		end
