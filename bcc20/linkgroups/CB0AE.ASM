DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_174
; BEGIN RC174 (listing CODE_174:0000)
CODE_174	segment byte public 'CODE'
		assume	cs:CODE_174

		public	BCC_FAR_DD30
		public	BCC_FAR_DD35
		public	BCC_FAR_DD3F
		public	BCC_FAR_DD44

		db	0CDh,03Fh,000h,000h,0C0h,0ECh,005h,000h,0F5h,005h,04Ch,000h,005h,000h	; CODE_174:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_174:000E
		db	000h,000h,000h,000h	; CODE_174:001C
BCC_FAR_DD30	label	far
		db	0EAh,070h,003h,0F8h,0B1h	; CODE_174:0020
BCC_FAR_DD35	label	far
		db	0EAh,011h,001h,0F8h,0B1h,0EAh,0C1h,005h,0F8h,0B1h	; CODE_174:0025
BCC_FAR_DD3F	label	far
		db	0EAh,059h,003h,0F8h,0B1h	; CODE_174:002F
BCC_FAR_DD44	label	far
		db	0EAh,000h,000h,0F8h,0B1h,000h,000h,000h,000h,000h,000h,000h	; CODE_174:0034

CODE_174	ends
; END RC174
		end
