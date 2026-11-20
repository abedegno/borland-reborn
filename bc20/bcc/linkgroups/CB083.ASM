DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_131
; BEGIN RC131 (listing CODE_131:0000)
CODE_131	segment byte public 'CODE'
		assume	cs:CODE_131

		public	BCC_FAR_D1A5
		public	BCC_FAR_D1B4
		public	BCC_FAR_D1B9

		db	0CDh,03Fh,000h,000h,050h,072h,004h,000h,046h,00Dh,07Ah,000h,009h,000h	; CODE_131:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_131:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1D18_0020
BCC_RF_1D18_0020	label	far
		db	0EAh,060h,000h,0ACh,09Ah; CODE_131:001C
		public	BCC_STMT_BIND_TYPE
BCC_STMT_BIND_TYPE	label	far
BCC_FAR_D1A5	label	far
		db	0EAh,083h,009h,0ACh,09Ah,0EAh,0E6h,005h,0ACh,09Ah,0EAh,031h,000h,0ACh	; CODE_131:0025
		db	09Ah	; CODE_131:0033
BCC_FAR_D1B4	label	far
		db	0EAh,051h,000h,0ACh,09Ah	; CODE_131:0034
		public	BCC_STMT_BIND_TYPE2
BCC_STMT_BIND_TYPE2	label	far
BCC_FAR_D1B9	label	far
		db	0EAh,079h,00Ch,0ACh,09Ah,0EAh,0E9h,00Bh,0ACh,09Ah
		public	BCC_STMT_DECL_CHECK
BCC_STMT_DECL_CHECK	label	far
		db	0EAh,0CCh,00Bh,0ACh; CODE_131:0039
		db	09Ah
		public	BCC_RF_1D18_0048
BCC_RF_1D18_0048	label	far
		public	BCC_STMT_DECL_NEW
BCC_STMT_DECL_NEW	label	far
		db	0EAh,000h,000h,0ACh,09Ah,000h,000h,000h; CODE_131:0047

CODE_131	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC131
		end
