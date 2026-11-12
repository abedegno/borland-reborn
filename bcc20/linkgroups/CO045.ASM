; Recovered FBOV far-pointer references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AF23:far
		extrn	BCC_FAR_B0F1:far
		extrn	BCC_RF_15C5_010D:far
CO019_TEXT	segment byte public 'CODE'
CO019_TEXT	ends
CO02E_TEXT	segment byte public 'CODE'
CO02E_TEXT	ends
CO02F_TEXT	segment byte public 'CODE'
CO02F_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
CO031_TEXT	ends
CO032_TEXT	segment byte public 'CODE'
CO032_TEXT	ends
CO035_TEXT	segment byte public 'CODE'
CO035_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
CO046_TEXT	segment byte public 'CODE'
CO046_TEXT	ends
CO04A_TEXT	segment byte public 'CODE'
CO04A_TEXT	ends
CO04D_TEXT	segment byte public 'CODE'
CO04D_TEXT	ends
CO04F_TEXT	segment byte public 'CODE'
CO04F_TEXT	ends
CO052_TEXT	segment byte public 'CODE'
CO052_TEXT	ends
CO056_TEXT	segment byte public 'CODE'
CO056_TEXT	ends
CO069_TEXT	segment byte public 'CODE'
CO069_TEXT	ends
		public	X045_02
		public	X045_00
		public	X045_01
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cef_8d5a
; BEGIN C240UNIT (listing ovr_1cef_8d5a:D5A0)
CO045_TEXT	segment byte public 'CODE'
		assume	cs:CO045_TEXT
; Original-image layout stub: not recovered source


X045_02	label	far
		db	055h,08Bh,0ECh,0B8h,0ACh,080h,01Eh,050h,0B8h,056h,036h,01Eh,050h,0B9h; ovr_1cef_8d5a:D5A0
		db	0C4h,000h,09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0FFh,076h,008h,0FFh,076h,006h,0E8h; ovr_1cef_8d5a:D5AE
		db	0D9h,002h,09Ah
		dw	020h
		dw	seg CO069_TEXT
		db	09Ah
		dw	043h
		dw	seg CO046_TEXT
		db	05Dh,0CAh; ovr_1cef_8d5a:D5BC
		db	004h,000h; raw:D5CA
X045_00	label	far
		db	055h,08Bh,0ECh,083h,0ECh,004h,056h,08Bh,076h,006h,09Ah
		dw	02DB7h
		dw	seg BCC_FAR_245C
		db	02Bh,006h,022h,078h,01Bh,016h,024h,078h,089h,056h,0FEh; ovr_1cef_8d5a:D5CA
		db	089h,046h,0FCh,0A1h,0F6h,029h,08Bh,016h,0F4h,029h,03Bh,046h,0FEh,07Ch	; ovr_1cef_8d5a:D5E6
		db	014h,07Fh,005h,03Bh,056h,0FCh,076h,00Dh,08Bh,046h,0FEh,08Bh,056h,0FCh	; ovr_1cef_8d5a:D5F4
		db	0A3h,0F6h,029h,089h,016h,0F4h,029h,00Bh,0F6h,075h,007h,0FFh,01Eh,000h	; ovr_1cef_8d5a:D602
		db	081h,0E8h,02Bh,000h,083h,03Eh,0E4h,014h,002h,075h,006h,056h,09Ah
		dw	025h
		dw	seg CO052_TEXT
		db	0FFh,036h,026h,078h,09Ah
		dw	01CBFh
		dw	seg BCC_FAR_245C
		db	0FFh,036h; ovr_1cef_8d5a:D610
		db	026h,078h,09Ah
		dw	02C1Bh
		dw	seg BCC_FAR_245C
		db	09Ah
		dw	0FCh
		dw	seg BCC_RF_15C5_010D
		db	05Eh,08Bh; ovr_1cef_8d5a:D62C
		db	0E5h,05Dh,0CAh,002h,000h,045h,055h,08Bh,0ECh,083h,0ECh,006h,056h,057h	; ovr_1cef_8d5a:D63A
		db	08Bh,01Eh,0F4h,085h,08Eh,006h,02Ah,078h,026h,0C7h,047h,006h,000h,000h	; ovr_1cef_8d5a:D648
		db	0C7h,046h,0FCh,000h,000h,0E9h,012h,002h,08Bh,05Eh,0FCh,0D1h,0E3h,08Bh	; ovr_1cef_8d5a:D656
		db	087h,0ACh,078h,0E9h,0F7h,001h,08Eh,006h,032h,078h,08Bh,05Eh,0FAh,026h	; ovr_1cef_8d5a:D664
		db	08Bh,037h,0E9h,0D9h,001h,08Eh,006h,0C2h,063h,026h,08Bh,004h,089h,046h	; ovr_1cef_8d5a:D672
		db	0FEh,08Bh,01Eh,0F4h,085h,08Eh,006h,02Ah,078h,026h,08Bh,047h,006h,08Eh	; ovr_1cef_8d5a:D680
		db	006h,0C2h,063h,026h,089h,004h,08Eh,006h,02Ah,078h,026h,089h,077h,006h	; ovr_1cef_8d5a:D68E
		db	08Eh,006h,0C2h,063h,026h,08Ah,044h,005h,0B4h,000h,048h,08Bh,0D8h,083h	; ovr_1cef_8d5a:D69C
		db	0FBh,00Ah,076h,003h,0E9h,09Ch,001h,0D1h,0E3h,02Eh,0FFh,0A7h,0E1h,002h	; ovr_1cef_8d5a:D6AA
		db	08Eh,006h,0C2h,063h,026h,08Bh,05Ch,008h,08Eh,006h,09Ah,063h,026h,080h	; ovr_1cef_8d5a:D6B8
		db	03Fh,015h,075h,003h,0E9h,080h,001h,08Eh,006h,0C2h,063h,026h,08Bh,05Ch	; ovr_1cef_8d5a:D6C6
		db	008h,08Eh,006h,09Ah,063h,026h,083h,07Fh,003h,000h,074h,003h,0E9h,06Ah	; ovr_1cef_8d5a:D6D4
		db	001h,0C7h,006h,04Eh,05Fh,000h,000h,08Eh,006h,0C2h,063h,026h,0FFh,074h	; ovr_1cef_8d5a:D6E2
		db	002h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,0B8h,07Fh,001h,050h,09Ah
		dw	017Dh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,0E9h,046h,001h,08Eh,006h,0C2h,063h,026h; ovr_1cef_8d5a:D6F0
		db	0F7h,044h,006h,000h,008h,075h,003h,0E9h,037h,001h,026h,0FFh,074h,008h	; ovr_1cef_8d5a:D70C
		db	0FFh,01Eh,064h,081h,00Bh,0C0h,074h,003h,0E9h,028h,001h,00Bh,0D2h,074h	; ovr_1cef_8d5a:D71A
		db	003h,0E9h,021h,001h,08Eh,006h,0C2h,063h,026h,081h,064h,006h,0FFh,0F7h	; ovr_1cef_8d5a:D728
		db	0E9h,014h,001h,08Eh,006h,0C2h,063h,026h,0F7h,044h,006h,080h,000h,075h	; ovr_1cef_8d5a:D736
		db	01Dh,0C7h,006h,04Eh,05Fh,000h,000h,026h,0FFh,074h,002h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,0B8h,07Ch,001h,050h,09Ah
		dw	017Dh
		dw	seg BCC_DIAGNOSTIC
		db	083h; ovr_1cef_8d5a:D744
		db	0C4h,006h,08Eh,006h,0C2h,063h,026h,0F7h,044h,006h,020h,000h,074h,003h	; ovr_1cef_8d5a:D760
		db	0E9h,0DCh,000h,08Eh,006h,0C2h,063h,026h,08Bh,05Ch,008h,08Eh,006h,09Ah	; ovr_1cef_8d5a:D76E
		db	063h,026h,080h,03Fh,012h,075h,02Fh,08Eh,006h,0C2h,063h,026h,0F7h,044h	; ovr_1cef_8d5a:D77C
		db	006h,080h,000h,075h,003h,0E9h,0BBh,000h,0C7h,006h,04Eh,05Fh,000h,000h	; ovr_1cef_8d5a:D78A
		db	026h,0FFh,074h,002h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,0B8h,05Ah,000h; ovr_1cef_8d5a:D798
		db	050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,0E9h,09Bh,000h,08Eh,006h; ovr_1cef_8d5a:D7A6
		db	0C2h,063h,026h,083h,07Ch,00Ch,0FFh,075h,007h,0A1h,052h,086h,026h,089h	; ovr_1cef_8d5a:D7B4
		db	044h,00Ch,08Eh,006h,0C2h,063h,026h,0FFh,074h,00Ch,0FFh,01Eh,0D8h,087h	; ovr_1cef_8d5a:D7C2
		db	08Eh,006h,0C2h,063h,026h,08Bh,05Ch,008h,08Eh,006h,09Ah,063h,026h,080h	; ovr_1cef_8d5a:D7D0
		db	03Fh,011h,075h,01Bh,08Eh,006h,0C2h,063h,026h,08Bh,05Ch,008h,08Eh,006h	; ovr_1cef_8d5a:D7DE
		db	09Ah,063h,026h,080h,07Fh,009h,000h,074h,008h,056h,09Ah
		dw	02Fh
		dw	seg CO04F_TEXT
		db	0EBh,050h,08Eh,006h,0C2h,063h,026h,0FFh,074h,008h,0FFh,01Eh,0E0h; ovr_1cef_8d5a:D7EC
		db	080h,050h,0FFh,01Eh,0D4h,087h,056h,0FFh,01Eh,0D0h,087h,08Eh,006h,0C2h	; ovr_1cef_8d5a:D808
		db	063h,026h,0FFh,074h,008h,0FFh,01Eh,064h,081h,08Bh,0F8h,00Bh,0FFh,075h	; ovr_1cef_8d5a:D816
		db	023h,0C7h,006h,04Eh,05Fh,000h,000h,08Eh,006h,0C2h,063h,026h,0FFh,074h	; ovr_1cef_8d5a:D824
		db	002h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,0B8h,009h,001h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,0EBh,005h,057h,0FFh,01Eh,0DCh,087h,08Bh; ovr_1cef_8d5a:D832
		db	076h,0FEh,00Bh,0F6h,074h,003h,0E9h,020h,0FEh,08Eh,006h,03Ah,078h,08Bh	; ovr_1cef_8d5a:D84E
		db	05Eh,0FAh,026h,08Bh,007h,089h,046h,0FAh,083h,07Eh,0FAh,000h,074h,003h	; ovr_1cef_8d5a:D85C
		db	0E9h,0FDh,0FDh,0FFh,046h,0FCh,081h,07Eh,0FCh,000h,004h,07Dh,003h,0E9h	; ovr_1cef_8d5a:D86A
		db	0E4h,0FDh,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h,0C2h,001h,067h,001h,099h	; ovr_1cef_8d5a:D878
		db	001h,099h,001h,0ADh,002h,0ADh,002h,0ADh,002h,0ADh,002h,0ADh,002h,0ADh	; ovr_1cef_8d5a:D886
		db	002h,018h,001h,045h,055h,08Bh,0ECh,0C6h,006h,0AEh,063h,001h,0C7h,006h	; ovr_1cef_8d5a:D894
		db	0F2h,085h,000h,000h,0E8h,0FBh,001h,09Ah
		dw	020h
		dw	seg CO031_TEXT
		db	09Ah
		dw	03Eh
		dw	seg CO069_TEXT
		db	01Eh,0B8h,046h,078h,050h,0FFh,076h,006h,0FFh,076h,004h; ovr_1cef_8d5a:D8A2
		db	09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h,0C4h; ovr_1cef_8d5a:D8BE
		db	066h,0FFh,036h,046h,078h,0FFh,036h,0C4h,066h,0FFh,076h,006h,0FFh,076h	; ovr_1cef_8d5a:D8CC
		db	004h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0C7h,006h,02Eh,082h,000h,000h,0FFh,076h; ovr_1cef_8d5a:D8DA
		db	006h,0FFh,076h,004h,09Ah
		dw	043h
		dw	seg CO032_TEXT
		db	00Bh,0C0h,075h,012h,0FFh; ovr_1cef_8d5a:D8E8
		db	076h,006h,0FFh,076h,004h,0B8h,004h,000h,050h,09Ah
		dw	0D4h
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,0C7h,006h,0E4h,014h,001h,000h,09Ah
		dw	043h
		dw	seg CO02E_TEXT
		db	09Ah
		dw	020h
		dw	seg CO02E_TEXT
		db	05Dh,04Dh,0C2h,004h,000h; raw:D912
X045_01	label	far
		db	055h,08Bh,0ECh,056h; ovr_1cef_8d5a:D912
		db	083h,03Eh,0E4h,014h,002h,075h,003h,0E9h,077h,001h,0B8h,003h,000h,050h	; ovr_1cef_8d5a:D920
		db	0FFh,01Eh,008h,081h,0A3h,008h,083h,01Eh,0B8h,050h,05Fh,050h,0FFh,036h	; ovr_1cef_8d5a:D92E
		db	046h,078h,0A1h,02Eh,082h,040h,040h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh; ovr_1cef_8d5a:D93C
		db	0B8h,050h,05Fh,050h,09Ah
		dw	039h
		dw	seg CO035_TEXT
		db	0C7h,006h,0EAh,077h,001h; ovr_1cef_8d5a:D94A
		db	000h,0FFh,036h,0E2h,077h,033h,0C0h,050h,0B0h,000h,050h,0B0h,008h,050h	; ovr_1cef_8d5a:D958
		db	09Ah
		dw	03Eh
		dw	seg CO04D_TEXT
		db	0A3h,0E6h,077h,0FFh,036h,0E2h,077h,033h,0C0h; ovr_1cef_8d5a:D966
		db	050h,0B0h,002h,050h,080h,03Eh,0F1h,016h,000h,074h,005h,0B8h,040h,000h	; ovr_1cef_8d5a:D974
		db	0EBh,003h,0B8h,001h,000h,050h,09Ah
		dw	03Eh
		dw	seg CO04F_TEXT
		db	0A3h,0E8h,077h; ovr_1cef_8d5a:D982
		db	0FFh,036h,02Ah,078h,0FFh,036h,018h,086h,033h,0C0h,050h,0B8h,008h,000h	; ovr_1cef_8d5a:D990
		db	050h,09Ah
		dw	03h
		dw	seg BCC_FAR_AF23
		db	01Eh,0B8h,09Ch,037h,050h,033h,0C0h,050h; ovr_1cef_8d5a:D99E
		db	09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	050h,0FFh,036h,018h,086h,0B0h,000h,050h,0B8h; ovr_1cef_8d5a:D9AC
		db	003h,000h,050h,0FFh,036h,0E2h,077h,033h,0C0h,050h,0B8h,0E4h,000h,050h	; ovr_1cef_8d5a:D9BA
		db	09Ah
		dw	07Ah
		dw	seg CO04A_TEXT
		db	0A3h,01Fh,078h,0C7h,006h,0E4h,014h,002h,000h; ovr_1cef_8d5a:D9C8
		db	01Eh,0B8h,050h,05Fh,050h,0FFh,036h,046h,078h,0A1h,02Eh,082h,040h,040h	; ovr_1cef_8d5a:D9D6
		db	050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,050h,05Fh,050h,09Ah
		dw	02Ah
		dw	seg CO052_TEXT
		db	080h,03Eh,076h,017h,000h,074h,005h,0B8h,002h,000h,0EBh,003h; ovr_1cef_8d5a:D9E4
		db	0B8h,001h,000h,050h,0FFh,036h,0E2h,082h,0FFh,036h,0EAh,082h,0FFh,036h	; ovr_1cef_8d5a:DA00
		db	0F2h,082h,09Ah
		dw	066h
		dw	seg CO056_TEXT
		db	0A3h,064h,086h,0A3h,07Eh,086h,0B8h; ovr_1cef_8d5a:DA0E
		db	002h,000h,050h,0FFh,036h,002h,083h,0FFh,036h,006h,083h,0FFh,036h,00Ch	; ovr_1cef_8d5a:DA1C
		db	083h,09Ah
		dw	066h
		dw	seg CO056_TEXT
		db	0A3h,0C8h,086h,08Bh,01Eh,01Fh,078h,08Eh; ovr_1cef_8d5a:DA2A
		db	006h,0C2h,063h,026h,089h,047h,00Ch,083h,03Eh,0ECh,082h,000h,074h,017h	; ovr_1cef_8d5a:DA38
		db	0B8h,002h,000h,050h,0FFh,036h,0DCh,082h,0FFh,036h,0E4h,082h,0FFh,036h	; ovr_1cef_8d5a:DA46
		db	0EEh,082h,09Ah
		dw	066h
		dw	seg CO056_TEXT
		db	0EBh,003h,0A1h,0C8h,086h,0A3h,052h; ovr_1cef_8d5a:DA54
		db	086h,08Bh,036h,02Eh,082h,0EBh,023h,01Eh,0B8h,050h,05Fh,050h,0FFh,036h	; ovr_1cef_8d5a:DA62
		db	046h,078h,08Bh,0C6h,040h,040h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h; ovr_1cef_8d5a:DA70
		db	050h,05Fh,050h,0FFh,01Eh,0CCh,087h,08Eh,006h,046h,078h,026h,08Bh,034h	; ovr_1cef_8d5a:DA7E
		db	00Bh,0F6h,075h,0D9h,01Eh,0B8h,09Fh,037h,050h,0B8h,031h,000h,050h,09Ah	; ovr_1cef_8d5a:DA8C
		dw	020h
		dw	seg CO02F_TEXT
		db	0A3h,0BAh,063h,05Eh,05Dh,0CBh,045h,055h,08Bh,0ECh; ovr_1cef_8d5a:DA9A
		db	083h,0ECh,010h,056h,057h,01Eh,0B8h,0ACh,078h,050h,033h,0C0h,050h,0B8h	; ovr_1cef_8d5a:DAA8
		db	000h,008h,050h,09Ah
		dw	03h
		dw	seg BCC_FAR_AF23
		db	0A0h,026h,078h,050h,09Ah
		dw	02BB0h
		dw	seg BCC_FAR_245C
		db	0B8h,082h,000h,0A3h,09Ch,063h,0A3h,09Eh,063h,0C7h,006h; ovr_1cef_8d5a:DAB6
		db	0A0h,063h,000h,000h,01Eh,0B8h,09Ah,063h,050h,0B8h,082h,000h,050h,09Ah	; ovr_1cef_8d5a:DAD2
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,080h,081h,0A3h,082h,081h,0C7h; ovr_1cef_8d5a:DAE0
		db	006h,084h,081h,000h,000h,01Eh,0B8h,07Eh,081h,050h,0B8h,002h,000h,050h	; ovr_1cef_8d5a:DAEE
		db	09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0FFh,036h,09Ah,063h,033h,0C0h,050h,01Eh,0B8h; ovr_1cef_8d5a:DAFC
		db	01Ah,037h,050h,0B8h,082h,000h,050h,09Ah
		dw	01h
		dw	seg BCC_FAR_B0F1
		db	0B8h,002h; ovr_1cef_8d5a:DB0A
		db	000h,0A3h,0C4h,063h,0A3h,0C6h,063h,0C7h,006h,0C8h,063h,000h,000h,01Eh	; ovr_1cef_8d5a:DB18
		db	0B8h,0C2h,063h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h; ovr_1cef_8d5a:DB26
		db	002h,000h,0A3h,0A6h,078h,0A3h,0A8h,078h,0C7h,006h,0AAh,078h,000h,000h	; ovr_1cef_8d5a:DB34
		db	01Eh,0B8h,0A4h,078h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,02Ch,078h,0A3h,02Eh,078h,0C7h,006h,030h,078h,000h	; ovr_1cef_8d5a:DB50
		db	000h,01Eh,0B8h,02Ah,078h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,034h,078h,0A3h,036h,078h,0C7h,006h,038h,078h; ovr_1cef_8d5a:DB5E
		db	000h,000h,01Eh,0B8h,032h,078h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,03Ch,078h,0A3h,03Eh,078h,0C7h,006h,040h; ovr_1cef_8d5a:DB7A
		db	078h,000h,000h,01Eh,0B8h,03Ah,078h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,001h,000h,0A3h,09Eh,078h,0A3h,0A0h,078h,0C7h,006h; ovr_1cef_8d5a:DB96
		db	0A2h,078h,000h,000h,01Eh,0B8h,09Ch,078h,050h,0B8h,001h,000h,050h,09Ah	; ovr_1cef_8d5a:DBB2
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	033h,0C0h,0A3h,030h,082h,08Bh,0D8h,0D1h,0E3h,0D1h; ovr_1cef_8d5a:DBC0
		db	0E3h,0D1h,0E3h,0B8h,001h,000h,089h,087h,050h,078h,033h,0D2h,089h,016h	; ovr_1cef_8d5a:DBCE
		db	030h,082h,08Bh,0DAh,0D1h,0E3h,0D1h,0E3h,0D1h,0E3h,089h,087h,052h,078h	; ovr_1cef_8d5a:DBDC
		db	033h,0C0h,0A3h,030h,082h,08Bh,0D8h,0D1h,0E3h,0D1h,0E3h,0D1h,0E3h,0C7h	; ovr_1cef_8d5a:DBEA
		db	087h,054h,078h,000h,000h,01Eh,033h,0C0h,0A3h,030h,082h,0D1h,0E0h,0D1h	; ovr_1cef_8d5a:DBF8
		db	0E0h,0D1h,0E0h,005h,04Eh,078h,050h,0B8h,001h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,098h,081h,0A3h,09Ah,081h,0C7h,006h,09Ch; ovr_1cef_8d5a:DC06
		db	081h,000h,000h,01Eh,0B8h,096h,081h,050h,0B8h,002h,000h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,088h,081h,0A3h,08Ah,081h,0C7h,006h; ovr_1cef_8d5a:DC22
		db	08Ch,081h,000h,000h,01Eh,0B8h,086h,081h,050h,0B8h,002h,000h,050h,09Ah	; ovr_1cef_8d5a:DC3E
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,001h,000h,0A3h,048h,078h,0A3h,04Ah,078h,0C7h; ovr_1cef_8d5a:DC4C
		db	006h,04Ch,078h,000h,000h,01Eh,0B8h,046h,078h,050h,0B8h,001h,000h,050h	; ovr_1cef_8d5a:DC5A
		db	09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0B8h,002h,000h,0A3h,090h,081h,0A3h,092h,081h; ovr_1cef_8d5a:DC68
		db	0C7h,006h,094h,081h,000h,000h,01Eh,0B8h,08Eh,081h,050h,0B8h,002h,000h	; ovr_1cef_8d5a:DC76
		db	050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0A0h,0F5h,016h,098h,00Bh,0C0h,074h,003h; ovr_1cef_8d5a:DC84
		db	0E9h,084h,000h,0C7h,046h,0F6h,0B8h,027h,0EBh,075h,01Eh,08Bh,05Eh,0F6h	; ovr_1cef_8d5a:DC92
		db	0FFh,037h,033h,0C0h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	089h,046h,0F4h,0FFh; ovr_1cef_8d5a:DCA0
		db	076h,0F4h,0FFh,036h,0F4h,085h,0B0h,000h,050h,0B8h,007h,000h,050h,08Bh	; ovr_1cef_8d5a:DCAE
		db	05Eh,0F6h,08Ah,047h,004h,098h,050h,0FFh,01Eh,008h,081h,050h,033h,0C0h	; ovr_1cef_8d5a:DCBC
		db	050h,050h,09Ah
		dw	07Ah
		dw	seg CO04A_TEXT
		db	089h,046h,0F2h,08Bh,05Eh,0F2h,08Eh; ovr_1cef_8d5a:DCCA
		db	006h,0C2h,063h,053h,08Bh,05Eh,0F6h,08Bh,047h,002h,05Bh,026h,089h,047h	; ovr_1cef_8d5a:DCD8
		db	00Eh,08Bh,05Eh,0F2h,026h,083h,07Fh,00Eh,00Ah,075h,008h,08Bh,046h,0F2h	; ovr_1cef_8d5a:DCE6
		db	0A3h,0FEh,082h,0EBh,014h,08Bh,05Eh,0F2h,08Eh,006h,0C2h,063h,026h,083h	; ovr_1cef_8d5a:DCF4
		db	07Fh,00Eh,00Bh,075h,006h,08Bh,046h,0F2h,0A3h,000h,083h,083h,046h,0F6h	; ovr_1cef_8d5a:DD02
		db	007h,08Bh,05Eh,0F6h,083h,03Fh,000h,075h,083h,080h,03Eh,0EFh,016h,003h	; ovr_1cef_8d5a:DD10
		db	07Ch,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,089h,046h,0F0h,08Ch,05Eh	; ovr_1cef_8d5a:DD1E
		db	0FAh,0C7h,046h,0F8h,028h,05Ah,033h,0FFh,0E9h,08Eh,000h,033h,0F6h,0EBh	; ovr_1cef_8d5a:DD2C
		db	025h,0C4h,05Eh,0F8h,026h,08Ah,040h,006h,098h,08Bh,0D8h,0F6h,087h,0CAh	; ovr_1cef_8d5a:DD3A
		db	009h,014h,074h,013h,083h,07Eh,0F0h,000h,074h,004h,0B0h,00Fh,0EBh,002h	; ovr_1cef_8d5a:DD48
		db	0B0h,00Dh,0C4h,05Eh,0F8h,026h,088h,040h,006h,046h,0C4h,05Eh,0F8h,026h	; ovr_1cef_8d5a:DD56
		db	08Ah,047h,004h,098h,03Bh,0C6h,07Fh,0CFh,01Eh,026h,0FFh,037h,033h,0C0h	; ovr_1cef_8d5a:DD64
		db	050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	050h,0FFh,036h,0F4h,085h,0B0h,000h,050h; ovr_1cef_8d5a:DD72
		db	0B8h,00Ah,000h,050h,033h,0C0h,050h,050h,050h,09Ah
		dw	07Ah
		dw	seg CO04A_TEXT
		db	089h,046h,0F2h,0C4h,05Eh,0F8h,026h,08Ah,047h,002h,098h,08Bh,0D8h,0F6h	; ovr_1cef_8d5a:DD8E
		db	087h,0CAh,009h,014h,074h,013h,083h,07Eh,0F0h,000h,074h,004h,0B0h,00Fh	; ovr_1cef_8d5a:DD9C
		db	0EBh,002h,0B0h,00Dh,0C4h,05Eh,0F8h,026h,088h,047h,002h,08Bh,05Eh,0F2h	; ovr_1cef_8d5a:DDAA
		db	08Eh,006h,0C2h,063h,026h,089h,07Fh,00Eh,083h,046h,0F8h,00Ah,047h,0C4h	; ovr_1cef_8d5a:DDB8
		db	05Eh,0F8h,026h,083h,03Fh,000h,074h,003h,0E9h,066h,0FFh,0C7h,006h,0C2h	; ovr_1cef_8d5a:DDC6
		db	066h,000h,000h,0C7h,006h,0C0h,066h,000h,000h,033h,0C0h,0A3h,0E6h,010h	; ovr_1cef_8d5a:DDD4
		db	0A3h,044h,086h,09Ah
		dw	03Eh
		dw	seg CO02E_TEXT
		db	09Ah
		dw	020h
		dw	seg CO052_TEXT
		db	09Ah; ovr_1cef_8d5a:DDE2
		dw	039h
		dw	seg CO031_TEXT
		db	01Eh,0B8h,02Ah,078h,050h,0B8h,008h,000h,050h,09Ah; ovr_1cef_8d5a:DDF0
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h,0F4h,085h,0FFh,036h,02Ah,078h,0FFh,036h,0F4h; ovr_1cef_8d5a:DDFE
		db	085h,033h,0C0h,050h,0B8h,008h,000h,050h,09Ah
		dw	03h
		dw	seg BCC_FAR_AF23
		db	01Eh; ovr_1cef_8d5a:DE0C
		db	0B8h,02Ah,078h,050h,0B8h,008h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h; ovr_1cef_8d5a:DE1A
		db	018h,086h,0C6h,006h,010h,078h,001h,01Eh,0B8h,09Eh,067h,050h,033h,0C0h	; ovr_1cef_8d5a:DE28
		db	050h,0B8h,083h,010h,050h,09Ah
		dw	03h
		dw	seg BCC_FAR_AF23
		db	0A1h,0F4h,085h,0A3h; ovr_1cef_8d5a:DE36
		db	09Ch,067h,0A1h,0F4h,085h,0A3h,0C0h,063h,0A3h,098h,063h,0C7h,006h,0ECh	; ovr_1cef_8d5a:DE44
		db	077h,001h,000h,0C6h,006h,0FCh,077h,001h,0A0h,0F5h,016h,098h,08Bh,0F0h	; ovr_1cef_8d5a:DE52
		db	0EBh,04Ch,08Bh,0C6h,0BAh,006h,000h,0F7h,0EAh,08Bh,0D8h,08Bh,087h,0CCh	; ovr_1cef_8d5a:DE60
		db	016h,08Bh,097h,0CAh,016h,089h,046h,0FEh,089h,056h,0FCh,08Bh,0C6h,0BAh	; ovr_1cef_8d5a:DE6E
		db	006h,000h,0F7h,0EAh,08Bh,0D8h,08Bh,0BFh,0CEh,016h,0EBh,021h,01Eh,0C4h	; ovr_1cef_8d5a:DE7C
		db	05Eh,0FCh,026h,0FFh,077h,002h,026h,0FFh,037h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	0C4h,05Eh,0FCh,026h,08Bh,01Fh,0D1h,0E3h,089h,087h,082h,061h,083h,046h	; ovr_1cef_8d5a:DE98
		db	0FCh,004h,04Fh,00Bh,0FFh,075h,0DBh,046h,083h,0FEh,003h,07Eh,0AFh,0B8h	; ovr_1cef_8d5a:DEA6
		db	005h,000h,050h,0FFh,01Eh,008h,081h,0A3h,0E2h,077h,080h,03Eh,0F6h,016h	; ovr_1cef_8d5a:DEB4
		db	000h,074h,005h,0B8h,002h,000h,0EBh,003h,0B8h,001h,000h,050h,0FFh,01Eh	; ovr_1cef_8d5a:DEC2
		db	008h,081h,0A3h,0E4h,077h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h	; ovr_1cef_8d5a:DED0

CO045_TEXT	ends
; END C240UNIT
		end
