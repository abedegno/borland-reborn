DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_124
; BEGIN RC124 (listing CODE_124:0000)
CODE_124	segment byte public 'CODE'
		assume	cs:CODE_124

		public	BCC_FAR_CF20
		public	BCC_FAR_CF25
		public	BCC_FAR_CF2A
		public	BCC_FAR_CF34
		public	BCC_FAR_CF48
		public	BCC_FAR_CF4D

		db	0CDh,03Fh,000h,000h,0A0h,0C1h,003h,000h,0AFh,02Bh,0AAh,001h,00Bh,000h	; CODE_124:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_124:000E
		db	000h,000h,000h,000h	; CODE_124:001C
BCC_FAR_CF20	label	far
		db	0EAh,018h,001h,000h,090h	; CODE_124:0020
BCC_FAR_CF25	label	far
		db	0EAh,005h,01Ch,000h,090h	; CODE_124:0025
BCC_FAR_CF2A	label	far
		db	0EAh,0DEh,00Fh,000h,090h,0EAh,003h,01Eh,000h,090h	; CODE_124:002A
BCC_FAR_CF34	label	far
		db	0EAh,047h,001h,000h,090h,0EAh,0F8h,01Ch,000h,090h,0EAh,08Fh,01Fh,000h	; CODE_124:0034
		db	090h,0EAh,000h,000h,000h,090h	; CODE_124:0042
BCC_FAR_CF48	label	far
		db	0EAh,0EFh,00Eh,000h,090h	; CODE_124:0048
BCC_FAR_CF4D	label	far
		db	0EAh,024h,01Dh,000h,090h,0EAh,05Dh,01Ch,000h,090h,000h,000h,000h,000h	; CODE_124:004D
		db	000h,000h,000h,000h,000h	; CODE_124:005B

CODE_124	ends
; END RC124
		end
