; Recovered FBOV far-pointer references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_DIAGNOSTIC:far
CO003_TEXT	segment byte public 'CODE'
CO003_TEXT	ends
CO022_TEXT	segment byte public 'CODE'
CO022_TEXT	ends
CO023_TEXT	segment byte public 'CODE'
CO023_TEXT	ends
CO02A_TEXT	segment byte public 'CODE'
CO02A_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02F_TEXT	segment byte public 'CODE'
CO02F_TEXT	ends
CO030_TEXT	segment byte public 'CODE'
CO030_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
CO031_TEXT	ends
		public	X018_00
		public	X018_01
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c15_6902
; BEGIN C24UNIT (listing ovr_1c15_6902:9020)
CO018_TEXT	segment byte public 'CODE'
		assume	cs:CO018_TEXT
; Original-image layout stub: not recovered source


X018_01	label	far
		db	055h
		db	08Bh
		db	0ECh
		db	083h
		db	0ECh
		db	016h
		db	056h
		db	0A0h
		db	03Ah
		db	05Fh
		db	088h
		db	046h
		db	0FFh
		db	0C6h
		db	006h
		db	0D0h
		db	077h
		db	001h
		db	09Ah
		dw	066h
		dw	seg CO031_TEXT
		db	08Dh
		db	046h
		db	0EAh
		db	016h
		db	050h
		db	0B8h
		db	082h
		db	063h
		db	01Eh
		db	050h
		db	0B9h
		db	013h
		db	000h
		db	09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0B8h
		db	082h
		db	063h
		db	01Eh
		db	050h
		db	0B8h
		db	060h
		db	082h
		db	01Eh
		db	050h
		db	0B9h
		db	013h
		db	000h
		db	09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0C6h
		db	006h
		db	03Ah
		db	05Fh
		db	000h
		db	0A1h
		db	082h
		db	063h
		db	0A3h
		db	0C2h
		db	05Eh
		db	0C7h
		db	006h
		db	060h
		db	082h
		db	082h
		db	000h
		db	0B8h
		db	00Ah
		db	000h
		db	050h
		db	09Ah
		dw	025h
		dw	seg CO022_TEXT
		db	050h
		db	0FFh
		db	036h
		db	09Ch
		db	062h
		db	09Ah
		dw	020h
		dw	seg CO003_TEXT
		db	050h
		db	0B0h
		db	000h
		db	050h
		db	09Ah
		dw	061h
		dw	seg CO02A_TEXT
		db	08Bh
		db	0F0h
		db	0C6h
		db	006h
		db	0D0h
		db	077h
		db	000h
		db	0B8h
		db	082h
		db	063h
		db	01Eh
		db	050h
		db	08Dh
		db	046h
		db	0EAh
		db	016h
		db	050h
		db	0B9h
		db	013h
		db	000h
		db	09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0A1h
		db	082h
		db	063h
		db	0A3h
		db	0C2h
		db	05Eh
		db	08Ah
		db	046h
		db	0FFh
		db	0A2h
		db	03Ah
		db	05Fh
		db	08Eh
		db	006h
		db	086h
		db	081h
		db	026h
		db	083h
		db	03Ch
		db	002h
		db	075h
		db	01Ah
		db	026h
		db	08Bh
		db	044h
		db	00Ch
		db	026h
		db	08Bh
		db	054h
		db	00Ah
		db	0A3h
		db	06Bh
		db	082h
		db	089h
		db	016h
		db	069h
		db	082h
		db	056h
		db	09Ah
		dw	043h
		dw	seg CO023_TEXT
		db	0B8h
		db	001h
		db	000h
		db	0EBh
		db	012h
		db	0B8h
		db	0F1h
		db	000h
		db	050h
		db	09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h
		db	056h
		db	09Ah
		dw	043h
		dw	seg CO023_TEXT
		db	033h
		db	0C0h
		db	05Eh
		db	08Bh
		db	0E5h
		db	05Dh
		db	0CBh
X018_00	label	far
		db	055h
		db	08Bh
		db	0ECh
		db	056h
		db	01Eh
		db	0B8h
		db	09Eh
		db	077h
		db	050h
		db	033h
		db	0C0h
		db	050h
		db	09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	050h
		db	09Ah
		dw	0CAh
		dw	seg CO02C_TEXT
		db	08Bh
		db	0F0h
		db	00Bh
		db	0F6h
		db	075h
		db	013h
		db	0B8h
		db	05Ah
		db	000h
		db	050h
		db	01Eh
		db	0B8h
		db	09Eh
		db	077h
		db	050h
		db	09Ah
		dw	02Fh
		dw	seg CO030_TEXT
		db	0B8h
		db	0FFh
		db	0FFh
		db	0EBh
		db	035h
		db	08Eh
		db	006h
		db	010h
		db	064h
		db	026h
		db	08Bh
		db	05Ch
		db	004h
		db	08Eh
		db	006h
		db	09Ah
		db	063h
		db	026h
		db	083h
		db	03Fh
		db	012h
		db	075h
		db	021h
		db	083h
		db	07Eh
		db	006h
		db	000h
		db	075h
		db	013h
		db	08Eh
		db	006h
		db	010h
		db	064h
		db	026h
		db	08Bh
		db	05Ch
		db	004h
		db	08Eh
		db	006h
		db	09Ah
		db	063h
		db	026h
		db	083h
		db	07Fh
		db	009h
		db	000h
		db	075h
		db	008h
		db	056h
		db	09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	0EBh
		db	002h
		db	033h
		db	0C0h
		db	05Eh
		db	05Dh
		db	0CAh
		db	002h
		db	000h

CO018_TEXT	ends
; END C24UNIT
		end
