; Recovered FBOV far-pointer references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB51:far
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO00E_TEXT	segment byte public 'CODE'
CO00E_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO041_TEXT	segment byte public 'CODE'
CO041_TEXT	ends
CO055_TEXT	segment byte public 'CODE'
CO055_TEXT	ends
CO056_TEXT	segment byte public 'CODE'
CO056_TEXT	ends
		public	X03A_00
		public	X03A_01
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cbd_85c2
; BEGIN C231UNIT (listing ovr_1cbd_85c2:5C20)
CO03A_TEXT	segment byte public 'CODE'
		assume	cs:CO03A_TEXT
; Original-image layout stub: not recovered source


X03A_00	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,056h,057h,09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0C7h,006h; ovr_1cbd_85c2:5C20
		db	01Ch,083h,000h,000h,033h,0F6h,0EBh,070h,056h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,08Eh,006h,010h,064h,026h,08Ah,045h,007h,0B4h,000h,0D1h,0F8h	; ovr_1cbd_85c2:5C3C
		db	0D1h,0F8h,0D1h,0F8h,03Dh,002h,000h,075h,02Eh,08Eh,006h,0C2h,063h,026h	; ovr_1cbd_85c2:5C4A
		db	0F7h,044h,008h,000h,001h,074h,002h,0EBh,041h,08Eh,006h,010h,064h,026h	; ovr_1cbd_85c2:5C58
		db	0F6h,045h,006h,006h,075h,00Ch,08Eh,006h,0C2h,063h,026h,0F7h,044h,008h	; ovr_1cbd_85c2:5C66
		db	080h,000h,074h,02Eh,056h,0E8h,033h,002h,089h,046h,0FEh,0EBh,025h,08Eh	; ovr_1cbd_85c2:5C74
		db	006h,010h,064h,026h,08Ah,045h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h	; ovr_1cbd_85c2:5C82
		db	0F8h,03Dh,003h,000h,075h,010h,08Eh,006h,0C2h,063h,026h,0F7h,044h,008h	; ovr_1cbd_85c2:5C90
		db	000h,001h,074h,004h,056h,0E8h,018h,001h,083h,0C6h,00Ah,03Bh,036h,0C6h	; ovr_1cbd_85c2:5C9E
		db	063h,072h,087h,0F7h,006h,0D2h,086h,002h,000h,074h,02Ch,081h,03Eh,01Ch	; ovr_1cbd_85c2:5CAC
		db	083h,0B0h,000h,075h,00Eh,08Ah,046h,0FEh,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	01Eh,0B8h,0A0h,02Ah,050h,09Ah
		dw	025h
		dw	seg CO055_TEXT
		db	0B0h,000h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0B0h,08Ch,0EBh,00Ah,083h; ovr_1cbd_85c2:5CC8
		db	03Eh,01Ch,083h,000h,074h,009h,0A0h,01Ch,083h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	033h,0F6h,0E9h,0A6h,000h,056h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Bh,0F8h; ovr_1cbd_85c2:5CE4
		db	08Eh,006h,010h,064h,026h,08Ah,045h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h	; ovr_1cbd_85c2:5D00
		db	0D1h,0F8h,03Dh,001h,000h,074h,008h,03Dh,003h,000h,074h,00Ch,0E9h,081h	; ovr_1cbd_85c2:5D0E
		db	000h,056h,033h,0C0h,050h,0E8h,0C1h,003h,0EBh,078h,08Eh,006h,010h,064h	; ovr_1cbd_85c2:5D1C
		db	026h,0F6h,045h,006h,020h,074h,00Bh,026h,08Ah,045h,006h,0B4h,000h,0A9h	; ovr_1cbd_85c2:5D2A
		db	004h,000h,074h,062h,056h,0FFh,01Eh,034h,081h,00Bh,0C0h,075h,017h,056h	; ovr_1cbd_85c2:5D38
		db	0FFh,036h,0C8h,086h,0FFh,01Eh,040h,081h,056h,056h,0FFh,01Eh,018h,081h	; ovr_1cbd_85c2:5D46
		db	003h,046h,006h,050h,0FFh,01Eh,03Ch,081h,0A0h,009h,017h,00Ah,006h,076h	; ovr_1cbd_85c2:5D54
		db	017h,074h,039h,08Eh,006h,010h,064h,026h,08Bh,05Dh,004h,08Eh,006h,09Ah	; ovr_1cbd_85c2:5D62
		db	063h,026h,083h,03Fh,012h,075h,027h,08Eh,006h,010h,064h,026h,08Bh,05Dh	; ovr_1cbd_85c2:5D70
		db	004h,08Eh,006h,09Ah,063h,026h,0F6h,047h,00Ch,001h,074h,014h,08Eh,006h	; ovr_1cbd_85c2:5D7E
		db	010h,064h,026h,0F7h,045h,00Ah,008h,000h,074h,008h,056h,0B8h,001h,000h	; ovr_1cbd_85c2:5D8C
		db	050h,0E8h,047h,003h,083h,0C6h,00Ah,03Bh,036h,0C6h,063h,073h,003h,0E9h	; ovr_1cbd_85c2:5D9A
		db	04Eh,0FFh,080h,03Eh,000h,017h,000h,074h,005h,09Ah
		dw	043h
		dw	seg CO041_TEXT
		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h,045h,055h,08Bh,0ECh,056h,057h	; ovr_1cbd_85c2:5DB6
		db	0FFh,076h,004h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,010h,064h; ovr_1cbd_85c2:5DC4
		db	026h,08Bh,07Ch,004h,026h,08Ah,044h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h	; ovr_1cbd_85c2:5DD2
		db	0D1h,0F8h,03Dh,003h,000h,075h,015h,026h,0F6h,044h,006h,020h,074h,00Eh	; ovr_1cbd_85c2:5DE0
		db	026h,08Ah,044h,006h,0B4h,000h,0A9h,004h,000h,075h,003h,0E9h,0ACh,000h	; ovr_1cbd_85c2:5DEE
		db	083h,03Eh,01Ch,083h,000h,074h,00Eh,0A0h,01Ch,083h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	080h,03Eh,000h,017h,000h,074h,037h; ovr_1cbd_85c2:5DFC
		db	080h,03Eh,0A0h,062h,000h,074h,021h,08Eh,006h,09Ah,063h,026h,083h,03Dh	; ovr_1cbd_85c2:5E18
		db	012h,075h,017h,08Eh,006h,010h,064h,026h,0F6h,044h,006h,010h,074h,00Ch	; ovr_1cbd_85c2:5E26
		db	056h,0FFh,036h,0C6h,05Eh,09Ah
		dw	039h
		dw	seg CO041_TEXT
		db	0EBh,00Ah,057h,0FFh; ovr_1cbd_85c2:5E34
		db	036h,0C6h,05Eh,09Ah
		dw	034h
		dw	seg CO041_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0B8h; ovr_1cbd_85c2:5E42
		db	000h,0ECh,050h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	056h,033h,0C0h,050h,090h,00Eh; ovr_1cbd_85c2:5E50
		db	0E8h,067h,004h,057h,09Ah
		dw	048h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	04Dh
		dw	seg CO055_TEXT
		db	0FFh,076h,004h,09Ah
		dw	089h
		dw	seg CO02C_TEXT
		db	0A9h,020h,000h,074h,013h; ovr_1cbd_85c2:5E5E
		db	08Eh,006h,09Ah,063h,026h,080h,07Dh,00Bh,004h,075h,004h,0B0h,098h,0EBh	; ovr_1cbd_85c2:5E7A
		db	002h,0B0h,018h,0EBh,002h,0B0h,000h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0B0h; ovr_1cbd_85c2:5E88
		db	088h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0C7h,006h; ovr_1cbd_85c2:5E96
		db	01Ch,083h,000h,000h,05Fh,05Eh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh	; ovr_1cbd_85c2:5EA4
		db	0ECh,083h,0ECh,008h,056h,057h,08Bh,07Eh,004h,057h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,0C2h,063h,026h,0F7h,045h,008h,080h,000h,074h; ovr_1cbd_85c2:5EB2
		db	005h,0B8h,0B0h,000h,0EBh,003h,0B8h,08Ch,000h,089h,046h,0FEh,057h,0A1h	; ovr_1cbd_85c2:5ECE
		db	09Eh,02Ah,0FFh,006h,09Eh,02Ah,050h,0FFh,01Eh,03Ch,081h,083h,03Eh,01Ch	; ovr_1cbd_85c2:5EDC
		db	083h,000h,074h,016h,0A1h,01Ch,083h,03Bh,046h,0FEh,074h,00Eh,0A0h,01Ch	; ovr_1cbd_85c2:5EEA
		db	083h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	08Bh,046h; ovr_1cbd_85c2:5EF8
		db	0FEh,0A3h,01Ch,083h,056h,033h,0C0h,050h,090h,00Eh,0E8h,0B5h,003h,0B0h	; ovr_1cbd_85c2:5F06
		db	000h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	08Eh,006h,0C2h,063h,026h,0F7h,045h; ovr_1cbd_85c2:5F14
		db	008h,080h,000h,075h,003h,0E9h,0F7h,000h,08Eh,006h,010h,064h,026h,08Bh	; ovr_1cbd_85c2:5F22
		db	044h,004h,089h,046h,0FCh,057h,0FFh,01Eh,034h,081h,03Bh,006h,052h,086h	; ovr_1cbd_85c2:5F30
		db	075h,003h,0E9h,09Eh,000h,0B0h,061h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0C7h; ovr_1cbd_85c2:5F3E
		db	046h,0FAh,000h,000h,0C7h,046h,0F8h,001h,000h,0EBh,02Eh,08Bh,05Eh,0FCh	; ovr_1cbd_85c2:5F4C
		db	08Eh,006h,09Ah,063h,026h,08Bh,04Fh,00Bh,026h,08Bh,05Fh,009h,08Bh,056h	; ovr_1cbd_85c2:5F5A
		db	0FAh,08Bh,046h,0F8h,09Ah
		dw	03A9h
		dw	seg BCC_COPY_WORDS
		db	089h,056h,0FAh,089h,046h; ovr_1cbd_85c2:5F68
		db	0F8h,08Bh,05Eh,0FCh,08Eh,006h,09Ah,063h,026h,08Bh,047h,007h,089h,046h	; ovr_1cbd_85c2:5F76
		db	0FCh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FCh,026h,083h,03Fh,011h,074h,0C5h	; ovr_1cbd_85c2:5F84
		db	083h,07Eh,0FAh,000h,077h,00Eh,075h,007h,081h,07Eh,0F8h,080h,000h,077h	; ovr_1cbd_85c2:5F92
		db	005h,08Ah,046h,0F8h,0EBh,03Dh,083h,07Eh,0FAh,000h,077h,01Bh,075h,007h	; ovr_1cbd_85c2:5FA0
		db	081h,07Eh,0F8h,0FFh,07Fh,077h,012h,0B0h,081h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0FFh,076h,0F8h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0EBh,022h,0B0h,088h,050h; ovr_1cbd_85c2:5FAE
		db	09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0FFh,076h,0F8h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0FFh; ovr_1cbd_85c2:5FCA
		db	076h,0FAh,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0EBh,008h,0B0h,062h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0FFh,076h,0FCh,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	089h,056h,0FAh; ovr_1cbd_85c2:5FD8
		db	089h,046h,0F8h,083h,07Eh,0FAh,000h,077h,014h,075h,007h,081h,07Eh,0F8h	; ovr_1cbd_85c2:5FF4
		db	080h,000h,077h,00Bh,08Ah,046h,0F8h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0EBh; ovr_1cbd_85c2:6002
		db	010h,0B0h,081h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0FFh,076h,0F8h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	080h,03Eh,000h,017h,000h,075h,003h,0E9h,098h,000h,08Eh; ovr_1cbd_85c2:6010
		db	006h,010h,064h,026h,08Bh,044h,004h,089h,046h,0FCh,08Ah,046h,0FEh,050h	; ovr_1cbd_85c2:602C
		db	09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	080h,03Eh,0A0h,062h,000h,074h,024h,08Eh,006h; ovr_1cbd_85c2:603A
		db	09Ah,063h,08Bh,05Eh,0FCh,026h,083h,03Fh,012h,075h,017h,08Eh,006h,010h	; ovr_1cbd_85c2:6048
		db	064h,026h,0F6h,044h,006h,010h,074h,00Ch,056h,0FFh,036h,0C6h,05Eh,09Ah	; ovr_1cbd_85c2:6056
		dw	039h
		dw	seg CO041_TEXT
		db	0EBh,00Ch,0FFh,076h,0FCh,0FFh,036h,0C6h,05Eh,09Ah; ovr_1cbd_85c2:6064
		dw	034h
		dw	seg CO041_TEXT
		db	080h,03Eh,0A0h,062h,000h,074h,01Bh,08Eh,006h,010h; ovr_1cbd_85c2:6072
		db	064h,026h,0F6h,044h,006h,010h,074h,010h,026h,08Bh,01Ch,026h,0FFh,077h	; ovr_1cbd_85c2:6080
		db	004h,0FFh,036h,0C6h,05Eh,09Ah
		dw	034h
		dw	seg CO041_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0B8h,000h,0E0h,050h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0FFh,076h,0FCh,09Ah; ovr_1cbd_85c2:608E
		dw	048h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	04Dh
		dw	seg CO055_TEXT
		db	0B0h,088h,050h,09Ah; ovr_1cbd_85c2:60AA
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0EBh,016h,0F7h,006h,09Eh; ovr_1cbd_85c2:60B8
		db	02Ah,07Fh,000h,075h,00Eh,08Ah,046h,0FEh,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	08Bh,046h,0FEh,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh; ovr_1cbd_85c2:60D4
		db	0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,0ECh,008h,056h,057h,08Bh,076h	; ovr_1cbd_85c2:60E2
		db	006h,056h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,056h,0FFh,01Eh,034h,081h; ovr_1cbd_85c2:60F0
		db	089h,046h,0FCh,083h,07Eh,0FCh,000h,075h,006h,0A1h,0C8h,086h,089h,046h	; ovr_1cbd_85c2:60FE
		db	0FCh,0FFh,076h,0FCh,09Ah
		dw	061h
		dw	seg CO056_TEXT
		db	089h,046h,0FAh,08Bh,05Eh; ovr_1cbd_85c2:610C
		db	0FAh,08Eh,006h,094h,088h,026h,083h,07Fh,002h,000h,074h,00Ah,026h,08Bh	; ovr_1cbd_85c2:611A
		db	05Fh,002h,026h,08Bh,047h,002h,0EBh,002h,033h,0C0h,089h,046h,0FEh,081h	; ovr_1cbd_85c2:6128
		db	07Eh,0FCh,000h,040h,07Dh,06Dh,09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	08Ah,046h,0FEh; ovr_1cbd_85c2:6136
		db	050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	08Ah,046h,0FCh,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	056h,0FFh,01Eh,034h,081h,00Bh,0C0h,075h,01Fh,056h,0FFh,036h,0C8h; ovr_1cbd_85c2:6144
		db	086h,0FFh,01Eh,040h,081h,056h,056h,0FFh,01Eh,018h,081h,08Bh,05Eh,0FAh	; ovr_1cbd_85c2:6160
		db	08Eh,006h,094h,088h,026h,003h,047h,00Ch,050h,0FFh,01Eh,03Ch,081h,057h	; ovr_1cbd_85c2:616E
		db	033h,0C0h,050h,090h,00Eh,0E8h,044h,001h,056h,0FFh,01Eh,018h,081h,050h	; ovr_1cbd_85c2:617C
		db	09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0B0h,000h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	083h; ovr_1cbd_85c2:618A
		db	07Eh,004h,000h,074h,004h,0B0h,0B6h,0EBh,002h,0B0h,090h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	083h,07Eh,004h,000h,074h,003h,0E9h,0D1h,000h,080h,03Eh; ovr_1cbd_85c2:6198
		db	000h,017h,000h,075h,003h,0E9h,0C7h,000h,08Eh,006h,010h,064h,026h,08Bh	; ovr_1cbd_85c2:61B4
		db	045h,004h,089h,046h,0F8h,080h,03Eh,0A0h,062h,000h,074h,024h,08Eh,006h	; ovr_1cbd_85c2:61C2
		db	09Ah,063h,08Bh,05Eh,0F8h,026h,083h,03Fh,012h,075h,017h,08Eh,006h,010h	; ovr_1cbd_85c2:61D0
		db	064h,026h,0F6h,045h,006h,010h,074h,00Ch,057h,0FFh,036h,0C6h,05Eh,09Ah	; ovr_1cbd_85c2:61DE
		dw	039h
		dw	seg CO041_TEXT
		db	0EBh,00Ch,0FFh,076h,0F8h,0FFh,036h,0C6h,05Eh,09Ah; ovr_1cbd_85c2:61EC
		dw	034h
		dw	seg CO041_TEXT
		db	080h,03Eh,0A0h,062h,000h,074h,01Bh,08Eh,006h,010h; ovr_1cbd_85c2:61FA
		db	064h,026h,0F6h,045h,006h,010h,074h,010h,026h,08Bh,01Dh,026h,0FFh,077h	; ovr_1cbd_85c2:6208
		db	004h,0FFh,036h,0C6h,05Eh,09Ah
		dw	034h
		dw	seg CO041_TEXT
		db	09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0B8h,000h,0E1h,050h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0FFh,076h,0F8h,09Ah; ovr_1cbd_85c2:6216
		dw	048h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	04Dh
		dw	seg CO055_TEXT
		db	08Eh,006h,09Ah,063h; ovr_1cbd_85c2:6232
		db	08Bh,05Eh,0F8h,026h,083h,03Fh,012h,075h,024h,08Eh,006h,0C2h,063h,026h	; ovr_1cbd_85c2:6240
		db	0F7h,044h,008h,020h,000h,074h,018h,08Eh,006h,09Ah,063h,026h,080h,07Fh	; ovr_1cbd_85c2:624E
		db	00Bh,004h,075h,005h,0B8h,098h,000h,0EBh,003h,0B8h,018h,000h,089h,046h	; ovr_1cbd_85c2:625C
		db	0FEh,0EBh,005h,0C7h,046h,0FEh,000h,000h,08Ah,046h,0FEh,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0B0h,088h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	08Eh,006h,0C2h; ovr_1cbd_85c2:626A
		db	063h,026h,0F7h,044h,008h,000h,002h,074h,030h,09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0B8h,000h,0A0h,050h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0B8h,002h,000h,050h,09Ah; ovr_1cbd_85c2:6294
		dw	066h
		dw	seg CO055_TEXT
		db	057h,033h,0C0h,050h,090h,00Eh,0E8h,019h,000h,0B0h; ovr_1cbd_85c2:62A2
		db	000h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0B0h,088h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,004h,000h; ovr_1cbd_85c2:62B0
X03A_01	label	far
		db	055h,08Bh,0ECh,083h; ovr_1cbd_85c2:62BE
		db	0ECh,004h,056h,057h,08Bh,076h,008h,080h,03Eh,0A0h,062h,000h,074h,029h	; ovr_1cbd_85c2:62CC
		db	08Eh,006h,010h,064h,026h,0F6h,044h,006h,010h,075h,019h,026h,08Bh,05Ch	; ovr_1cbd_85c2:62DA
		db	004h,08Eh,006h,09Ah,063h,026h,083h,03Fh,012h,075h,010h,08Eh,006h,010h	; ovr_1cbd_85c2:62E8
		db	064h,026h,083h,07Ch,011h,001h,075h,005h,0B8h,001h,000h,0EBh,002h,033h	; ovr_1cbd_85c2:62F6
		db	0C0h,08Bh,0F8h,00Bh,0FFh,074h,008h,056h,09Ah
		dw	02Ah
		dw	seg CO00E_TEXT
		db	0EBh; ovr_1cbd_85c2:6304
		db	02Ch,01Eh,0B8h,050h,05Fh,050h,08Eh,006h,010h,064h,026h,08Bh,05Ch,002h	; ovr_1cbd_85c2:6312
		db	08Eh,006h,032h,078h,026h,08Bh,05Fh,004h,0FFh,037h,08Eh,006h,010h,064h	; ovr_1cbd_85c2:6320
		db	026h,08Bh,05Ch,002h,08Eh,006h,032h,078h,026h,0FFh,077h,002h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	089h,056h,0FEh,089h,046h,0FCh,08Eh,006h,010h,064h,026h; ovr_1cbd_85c2:632E
		db	0F6h,044h,006h,040h,074h,02Eh,0FFh,076h,0FEh,0FFh,076h,0FCh,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	0EBh,010h,0C4h,05Eh,0FCh,0FFh,046h,0FCh,026h,08Ah,007h; ovr_1cbd_85c2:634A
		db	098h,050h,09Ah
		dw	031h
		dw	seg BCC_FAR_AB51
		db	050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0C4h; ovr_1cbd_85c2:6366
		db	05Eh,0FCh,026h,080h,03Fh,000h,075h,0E1h,0EBh,04Dh,00Bh,0FFh,075h,024h	; ovr_1cbd_85c2:6374
		db	083h,07Eh,006h,000h,075h,01Eh,080h,03Eh,016h,017h,000h,074h,017h,0FFh	; ovr_1cbd_85c2:6382
		db	076h,0FEh,0FFh,076h,0FCh,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	0FEh,0C0h,050h,09Ah; ovr_1cbd_85c2:6390
		dw	034h
		dw	seg CO055_TEXT
		db	0B0h,05Fh,0EBh,016h,0FFh,076h,0FEh,0FFh,076h,0FCh; ovr_1cbd_85c2:639E
		db	09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	0EBh,009h,0C4h,05Eh,0FCh,0FFh,046h,0FCh,026h; ovr_1cbd_85c2:63AC
		db	08Ah,007h,050h,09Ah
		dw	034h
		dw	seg CO055_TEXT
		db	0C4h,05Eh,0FCh,026h,080h,03Fh; ovr_1cbd_85c2:63BA
		db	000h,075h,0E8h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h	; ovr_1cbd_85c2:63C8

CO03A_TEXT	ends
; END C231UNIT
		end
