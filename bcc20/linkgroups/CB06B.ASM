DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_107
; BEGIN RC107 (listing CODE_107:0000)
CODE_107	segment byte public 'CODE'
		assume	cs:CODE_107

		public	BCC_FAR_CAC5
		public	BCC_FAR_CACA
		public	BCC_FAR_CACF
		public	BCC_FAR_CAD4

		db	0CDh,03Fh,000h,000h,080h,020h,003h,000h,09Ch,008h,070h,000h,009h,000h	; CODE_107:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_107:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1CAA_0020
BCC_RF_1CAA_0020	label	far
		db	0EAh,02Ch,008h,05Fh,084h; CODE_107:001C
BCC_FAR_CAC5	label	far
		db	0EAh,000h,000h,05Fh,084h	; CODE_107:0025
		public	BCC_RF_1CAA_002A
BCC_RF_1CAA_002A	label	far
		public	BCC_STMT_TYPE_DEFAULT
BCC_STMT_TYPE_DEFAULT	label	far
BCC_FAR_CACA	label	far
		db	0EAh,08Eh,006h,05Fh,084h	; CODE_107:002A
BCC_FAR_CACF	label	far
		db	0EAh,08Eh,007h,05Fh,084h	; CODE_107:002F
		public	BCC_DEBUG_OPEN2
BCC_DEBUG_OPEN2	label	far
BCC_FAR_CAD4	label	far
		db	0EAh,06Ch,000h,05Fh,084h,0EAh,0A5h,000h,05Fh,084h
		public	BCC_COMMIT_NUMBER_A
BCC_COMMIT_NUMBER_A	label	far
		db	0EAh,064h,008h,05Fh; CODE_107:0034
		db	084h
		public	BCC_NAME_LOOKUP
BCC_NAME_LOOKUP	label	far
		db	0EAh,05Ah,006h,05Fh,084h,0EAh,0B2h,007h,05Fh,084h,000h,000h,000h; CODE_107:0042

CODE_107	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC107
		end
