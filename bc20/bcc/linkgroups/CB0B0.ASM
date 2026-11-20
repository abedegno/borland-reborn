DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_176
; BEGIN RC176 (listing CODE_176:0000)
CODE_176	segment byte public 'CODE'
		assume	cs:CODE_176

		public	BCC_FAR_DDB4
		public	BCC_FAR_DDB9
		public	BCC_FAR_DDBE
		public	BCC_FAR_DDC3
		public	BCC_FAR_DDF0

		db	0CDh,03Fh,000h,000h,010h,0FAh,005h,000h,057h,010h,04Ah,001h,014h,000h	; CODE_176:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_176:000E
		db	000h,000h,000h,000h,0EAh,0CDh,005h,0C2h,0B2h,0EAh,02Ch,005h,0C2h,0B2h	; CODE_176:001C
		db	0EAh,038h,008h,0C2h,0B2h,0EAh,022h,00Fh,0C2h,0B2h	; CODE_176:002A
BCC_FAR_DDB4	label	far
		db	0EAh,003h,001h,0C2h,0B2h	; CODE_176:0034
		public	BCC_RF_1DD8_0039
BCC_RF_1DD8_0039	label	far
BCC_FAR_DDB9	label	far
		db	0EAh,000h,000h,0C2h,0B2h	; CODE_176:0039
BCC_FAR_DDBE	label	far
		db	0EAh,048h,00Fh,0C2h,0B2h	; CODE_176:003E
BCC_FAR_DDC3	label	far
		db	0EAh,0DAh,00Eh,0C2h,0B2h,0EAh,05Dh,003h,0C2h,0B2h,0EAh,0E6h,006h,0C2h	; CODE_176:0043
		db	0B2h,0EAh,059h,000h,0C2h,0B2h,0EAh,04Ah,000h,0C2h,0B2h,0EAh,0A5h,004h	; CODE_176:0051
		db	0C2h,0B2h,0EAh,081h,000h,0C2h,0B2h,0EAh,072h,000h,0C2h,0B2h,0EAh,0EDh	; CODE_176:005F
		db	004h,0C2h,0B2h	; CODE_176:006D
BCC_FAR_DDF0	label	far
		db	0EAh,070h,002h,0C2h,0B2h,0EAh,002h,006h,0C2h,0B2h,0EAh,096h,000h,0C2h	; CODE_176:0070
		db	0B2h,0EAh,01Eh,006h,0C2h,0B2h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_176:007E
		db	000h,000h,000h,000h	; CODE_176:008C

CODE_176	ends
; Target-qualified reference aliases (zero bytes)
; END RC176
		end
