DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_98
; BEGIN RC98 (listing CODE_98:0000)
CODE_98	segment byte public 'CODE'
		assume	cs:CODE_98

		public	BCC_FAR_C778
		public	BCC_FAR_C796
		public	BCC_FAR_C7AF
		public	BCC_FAR_C7B9
		public	BCC_FAR_C7F5

		db	0CDh,03Fh,000h,000h,0D0h,09Ah,002h,000h,017h,011h,046h,000h,027h,000h	; CODE_98:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_98:000E
		db	000h,000h,000h,000h,0EAh,04Fh,00Dh,072h,07Ah,0EAh,011h,00Dh,072h,07Ah	; CODE_98:001C
		public	BCC_RF_1C73_002A
BCC_RF_1C73_002A	label	far
		db	0EAh,08Dh,010h,072h,07Ah
		public	BCC_RF_1C73_002F
BCC_RF_1C73_002F	label	far
		db	0EAh,05Bh,003h,072h,07Ah,0EAh,018h,010h,072h; CODE_98:002A
		db	07Ah
		public	BCC_RF_1C73_0039
BCC_RF_1C73_0039	label	far
		db	0EAh,049h,008h,072h,07Ah,0EAh,000h,000h,072h,07Ah,0EAh,0F7h,009h; CODE_98:0038
		db	072h,07Ah	; CODE_98:0046
		public	BCC_TYPE_FROM_NODE
BCC_TYPE_FROM_NODE	label	far
		public	BCC_TYPE_QUERY_THUNK
BCC_TYPE_QUERY_THUNK	label	far
BCC_FAR_C778	label	far
		db	0EAh,097h,003h,072h,07Ah
		public	BCC_RF_1C73_004D
BCC_RF_1C73_004D	label	far
		db	0EAh,09Ch,004h,072h,07Ah,0EAh,058h,00Ah,072h; CODE_98:0048
		db	07Ah,0EAh,033h,010h,072h,07Ah
		public	BCC_EXPR_PARENT
BCC_EXPR_PARENT	label	far
		db	0EAh,035h,000h,072h,07Ah,0EAh,018h,006h; CODE_98:0056
		db	072h,07Ah	; CODE_98:0064
		public	BCC_RF_1C73_0066
BCC_RF_1C73_0066	label	far
		public	BCC_TYPE_PREPARE
BCC_TYPE_PREPARE	label	far
BCC_FAR_C796	label	far
		db	0EAh,087h,00Dh,072h,07Ah
		public	BCC_RF_1C73_006B
BCC_RF_1C73_006B	label	far
		db	0EAh,0B9h,00Fh,072h,07Ah,0EAh,0E2h,00Fh,072h; CODE_98:0066
		db	07Ah,0EAh,088h,00Ah,072h,07Ah
		public	BCC_MEMBER_KIND
BCC_MEMBER_KIND	label	far
		public	BCC_TYPE_CLASS
BCC_TYPE_CLASS	label	far
		db	0EAh,05Eh,002h,072h,07Ah; CODE_98:0074
		public	BCC_RF_1C73_007F
BCC_RF_1C73_007F	label	far
BCC_FAR_C7AF	label	far
		db	0EAh,062h,006h,072h,07Ah
		public	BCC_TYPE_ATTR
BCC_TYPE_ATTR	label	far
		db	0EAh,08Bh,00Fh,072h,07Ah; CODE_98:007F
		public	BCC_RF_1C73_0089
BCC_RF_1C73_0089	label	far
		public	BCC_TYPE_FLAGS
BCC_TYPE_FLAGS	label	far
BCC_FAR_C7B9	label	far
		db	0EAh,062h,00Fh,072h,07Ah
		public	BCC_MEMBER_CREATE
BCC_MEMBER_CREATE	label	far
		public	BCC_MEMBER_CREATE2
BCC_MEMBER_CREATE2	label	far
		db	0EAh,0B5h,008h,072h,07Ah,0EAh,04Fh,007h,072h; CODE_98:0089
		db	07Ah
		public	BCC_TYPE_CLONE2
BCC_TYPE_CLONE2	label	far
		public	BCC_TYPE_CREATE2
BCC_TYPE_CREATE2	label	far
		db	0EAh,036h,005h,072h,07Ah,0EAh,064h,009h,072h,07Ah
		public	BCC_MEMBER_CLONE
BCC_MEMBER_CLONE	label	far
		db	0EAh,09Ah,007h; CODE_98:0097
		db	072h,07Ah
		public	BCC_TYPE_UNIQUE
BCC_TYPE_UNIQUE	label	far
		db	0EAh,0ECh,003h,072h,07Ah
		public	BCC_MEMBER_ADD
BCC_MEMBER_ADD	label	far
		db	0EAh,0CDh,005h,072h,07Ah
		public	BCC_TYPE_FIND
BCC_TYPE_FIND	label	far
		db	0EAh,0AEh; CODE_98:00A5
		db	006h,072h,07Ah
		public	BCC_RF_1C73_00B6
BCC_RF_1C73_00B6	label	far
		public	BCC_TYPE_ALLOC2
BCC_TYPE_ALLOC2	label	far
		db	0EAh,046h,004h,072h,07Ah,0EAh,07Ah,000h,072h,07Ah,0EAh; CODE_98:00B3
		db	017h,001h,072h,07Ah	; CODE_98:00C1
		public	BCC_MEMBER_FIND
BCC_MEMBER_FIND	label	far
		public	BCC_MEMBER_RESOLVE
BCC_MEMBER_RESOLVE	label	far
BCC_FAR_C7F5	label	far
		db	0EAh,0E1h,007h,072h,07Ah
		public	BCC_MEMBER_OUTER
BCC_MEMBER_OUTER	label	far
		db	0EAh,013h,007h,072h,07Ah
		public	BCC_MEMBER_APPEND
BCC_MEMBER_APPEND	label	far
		db	0EAh,04Dh,010h,072h; CODE_98:00C5
		db	07Ah,0EAh,0B9h,010h,072h,07Ah,0EAh,079h,010h,072h,07Ah,0EAh,0EDh,010h	; CODE_98:00D3
		db	072h,07Ah,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_98:00E1
		db	000h	; CODE_98:00EF

CODE_98	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC98
		end
