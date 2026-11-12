DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_100
; BEGIN RC100 (listing CODE_100:0000)
CODE_100	segment byte public 'CODE'
		assume	cs:CODE_100

		public	BCC_FAR_C87F
		public	BCC_FAR_C893
		public	BCC_FAR_C898
		public	BCC_FAR_C89D

		db	0CDh,03Fh,000h,000h,070h,0ADh,002h,000h,0C7h,010h,09Ah,000h,00Bh,000h	; CODE_100:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_100:000E
		db	000h,000h,000h,000h,0EAh,0B1h,00Eh,096h,07Bh,0EAh,0EAh,00Ch,096h,07Bh	; CODE_100:001C
		db	0EAh,000h,000h,096h,07Bh	; CODE_100:002A
		public	BCC_MODE_FALLBACK
BCC_MODE_FALLBACK	label	far
BCC_FAR_C87F	label	far
		db	0EAh,035h,002h,096h,07Bh,0EAh,05Dh,00Ch,096h,07Bh,0EAh,0FBh,002h,096h	; CODE_100:002F
		db	07Bh,0EAh,0DCh,002h,096h,07Bh	; CODE_100:003D
		public	BCC_PATH_CLOSE
BCC_PATH_CLOSE	label	far
BCC_FAR_C893	label	far
		db	0EAh,049h,002h,096h,07Bh	; CODE_100:0043
		public	BCC_PATH_OPEN
BCC_PATH_OPEN	label	far
BCC_FAR_C898	label	far
		db	0EAh,049h,00Eh,096h,07Bh	; CODE_100:0048
BCC_FAR_C89D	label	far
		db	0EAh,01Ah,003h,096h,07Bh,0EAh,0D6h,00Ah,096h,07Bh,000h,000h,000h,000h	; CODE_100:004D
		db	000h,000h,000h,000h,000h	; CODE_100:005B

CODE_100	ends
; Original-target semantic aliases (zero bytes)
; END RC100
		end
