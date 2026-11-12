DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_155
; BEGIN RC155 (listing CODE_155:0000)
CODE_155	segment byte public 'CODE'
		assume	cs:CODE_155

		public	BCC_FAR_D87A
		public	BCC_FAR_D87F
		public	BCC_FAR_D884
		public	BCC_FAR_D889
		public	BCC_FAR_D88E
		public	BCC_FAR_D893
		public	BCC_FAR_D898
		public	BCC_FAR_D89D
		public	BCC_FAR_D8A2
		public	BCC_FAR_D8A7
		public	BCC_FAR_D8AC
		public	BCC_FAR_D8B1
		public	BCC_FAR_D8B6
		public	BCC_FAR_D8BB
		public	BCC_FAR_D8C0
		public	BCC_FAR_D8CA
		public	BCC_FAR_D8CF

		db	0CDh,03Fh,000h,000h,0F0h,04Ch,005h,000h,00Ah,00Ah,06Ch,000h,014h,000h	; CODE_155:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_155:000E
		db	000h,000h,000h,000h,0EAh,090h,009h,054h,0A8h,0EAh,070h,006h,054h,0A8h	; CODE_155:001C
BCC_FAR_D87A	label	far
		db	0EAh,044h,008h,054h,0A8h	; CODE_155:002A
BCC_FAR_D87F	label	far
		db	0EAh,0E7h,004h,054h,0A8h	; CODE_155:002F
BCC_FAR_D884	label	far
		db	0EAh,0F4h,006h,054h,0A8h	; CODE_155:0034
BCC_FAR_D889	label	far
		db	0EAh,0B2h,009h,054h,0A8h	; CODE_155:0039
BCC_FAR_D88E	label	far
		db	0EAh,07Dh,009h,054h,0A8h	; CODE_155:003E
BCC_FAR_D893	label	far
		db	0EAh,0D5h,008h,054h,0A8h	; CODE_155:0043
BCC_FAR_D898	label	far
		db	0EAh,05Ch,002h,054h,0A8h	; CODE_155:0048
BCC_FAR_D89D	label	far
		db	0EAh,0D2h,001h,054h,0A8h	; CODE_155:004D
BCC_FAR_D8A2	label	far
		db	0EAh,099h,001h,054h,0A8h	; CODE_155:0052
BCC_FAR_D8A7	label	far
		db	0EAh,0FBh,008h,054h,0A8h	; CODE_155:0057
BCC_FAR_D8AC	label	far
		db	0EAh,038h,000h,054h,0A8h	; CODE_155:005C
BCC_FAR_D8B1	label	far
		db	0EAh,01Ch,006h,054h,0A8h	; CODE_155:0061
BCC_FAR_D8B6	label	far
		db	0EAh,04Ah,003h,054h,0A8h	; CODE_155:0066
BCC_FAR_D8BB	label	far
		db	0EAh,07Ch,000h,054h,0A8h	; CODE_155:006B
BCC_FAR_D8C0	label	far
		db	0EAh,063h,007h,054h,0A8h,0EAh,033h,006h,054h,0A8h	; CODE_155:0070
BCC_FAR_D8CA	label	far
		db	0EAh,0D4h,000h,054h,0A8h	; CODE_155:007A
BCC_FAR_D8CF	label	far
		db	0EAh,08Fh,006h,054h,0A8h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_155:007F
		db	000h,000h,000h	; CODE_155:008D

CODE_155	ends
; END RC155
		end
