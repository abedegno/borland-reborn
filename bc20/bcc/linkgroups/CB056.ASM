DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_86
; BEGIN RC86 (listing CODE_86:0000)
CODE_86	segment byte public 'CODE'
		assume	cs:CODE_86

		public	BCC_FAR_C3B0
		public	BCC_FAR_C3C9
		public	BCC_FAR_C3D8

		db	0CDh,03Fh,000h,000h,030h,0ECh,001h,000h,017h,00Ch,004h,000h,00Ah,000h	; CODE_86:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_86:000E
		db	000h,000h,000h,000h	; CODE_86:001C
BCC_FAR_C3B0	label	far
		db	0EAh,096h,009h,00Bh,06Ch
		public	BCC_EXPR_NUMBER
BCC_EXPR_NUMBER	label	far
		db	0EAh,0DAh,00Ah,00Bh,06Ch,0EAh,080h,00Ah,00Bh; CODE_86:0020
		db	06Ch
		public	BCC_RF_1C39_002F
BCC_RF_1C39_002F	label	far
		public	BCC_TREE_BUILD5
BCC_TREE_BUILD5	label	far
		db	0EAh,00Ah,00Bh,00Bh,06Ch,0EAh,084h,006h,00Bh,06Ch; CODE_86:002E
		public	BCC_EXPR_NODE
BCC_EXPR_NODE	label	far
		public	BCC_TREE_MAKE
BCC_TREE_MAKE	label	far
BCC_FAR_C3C9	label	far
		db	0EAh,080h,007h,00Bh,06Ch,0EAh,062h,008h,00Bh,06Ch
		public	BCC_RF_1C39_0043
BCC_RF_1C39_0043	label	far
		db	0EAh,04Ch,00Ah,00Bh; CODE_86:0039
		db	06Ch	; CODE_86:0047
BCC_FAR_C3D8	label	far
		db	0EAh,075h,009h,00Bh,06Ch
		public	BCC_EXPR_BUILD2
BCC_EXPR_BUILD2	label	far
		db	0EAh,036h,009h,00Bh,06Ch,000h,000h,000h,000h; CODE_86:0048
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_86:0056

CODE_86	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC86
		end
