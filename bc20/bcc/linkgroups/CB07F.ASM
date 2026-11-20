DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_127
; BEGIN RC127 (listing CODE_127:0000)
CODE_127	segment byte public 'CODE'
		assume	cs:CODE_127

		public	BCC_FAR_D020
		public	BCC_FAR_D02F
		public	BCC_FAR_D034

		db	0CDh,03Fh,000h,000h,040h,020h,004h,000h,04Ah,019h,04Ch,000h,005h,000h	; CODE_127:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_127:000E
		db	000h,000h,000h,000h	; CODE_127:001C
BCC_FAR_D020	label	far
		db	0EAh,04Bh,016h,0B1h,095h,0EAh,0A0h,016h,0B1h,095h,0EAh,026h,00Ah,0B1h	; CODE_127:0020
		db	095h	; CODE_127:002E
BCC_FAR_D02F	label	far
		db	0EAh,0E2h,002h,0B1h,095h	; CODE_127:002F
BCC_FAR_D034	label	far
		db	0EAh,000h,000h,0B1h,095h,000h,000h,000h,000h,000h,000h,000h	; CODE_127:0034

CODE_127	ends
; END RC127
		end
