DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_78
; BEGIN RC78 (listing CODE_78:0000)
CODE_78	segment byte public 'CODE'
		assume	cs:CODE_78

		public	BCC_FAR_C18A
		public	BCC_FAR_C199
		public	BCC_FAR_C19E
		public	BCC_FAR_C1A8

		db	0CDh,03Fh,000h,000h,040h,0BAh,001h,000h,017h,003h,00Eh,000h,00Bh,000h	; CODE_78:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_78:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1C16_0020
BCC_RF_1C16_0020	label	far
		db	0EAh,0FAh,001h,016h,069h
		public	BCC_RF_1C16_0025
BCC_RF_1C16_0025	label	far
		db	0EAh,01Eh,002h,016h,069h; CODE_78:001C
		public	BCC_MACRO_VALUE
BCC_MACRO_VALUE	label	far
		public	BCC_MEMBER_ERROR2
BCC_MEMBER_ERROR2	label	far
		public	BCC_RF_1C16_002A
BCC_RF_1C16_002A	label	far
		public	BCC_STMT_NAME
BCC_STMT_NAME	label	far
BCC_FAR_C18A	label	far
		db	0EAh,068h,002h,016h,069h
		public	BCC_MEMBER_ERROR
BCC_MEMBER_ERROR	label	far
		db	0EAh,07Fh,001h,016h,069h,0EAh,0A5h,001h,016h; CODE_78:002A
		db	069h	; CODE_78:0038
		public	BCC_MEMBER_WARN
BCC_MEMBER_WARN	label	far
		public	BCC_NODE_WARNING
BCC_NODE_WARNING	label	far
		public	BCC_TREE_ERROR
BCC_TREE_ERROR	label	far
		public	BCC_TREE_ERROR2
BCC_TREE_ERROR2	label	far
BCC_FAR_C199	label	far
		db	0EAh,0E7h,001h,016h,069h	; CODE_78:0039
		public	BCC_TREE_CALL
BCC_TREE_CALL	label	far
BCC_FAR_C19E	label	far
		db	0EAh,03Ch,001h,016h,069h,0EAh,05Eh,001h,016h,069h	; CODE_78:003E
BCC_FAR_C1A8	label	far
		db	0EAh,0EDh,002h,016h,069h,0EAh,0C3h,002h,016h,069h,0EAh,04Eh,000h,016h	; CODE_78:0048
		db	069h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_78:0056

CODE_78	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC78
		end
