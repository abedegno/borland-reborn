; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
CO003_TEXT	     segment byte public 'CODE'
CO003_TEXT	     ends
CO004_TEXT	     segment byte public 'CODE'
CO004_TEXT	     ends
CO007_TEXT	     segment byte public 'CODE'
CO007_TEXT	     ends
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
CO00F_TEXT	     segment byte public 'CODE'
CO00F_TEXT	     ends
CO010_TEXT	     segment byte public 'CODE'
CO010_TEXT	     ends
CO012_TEXT	     segment byte public 'CODE'
CO012_TEXT	     ends
CO014_TEXT	     segment byte public 'CODE'
CO014_TEXT	     ends
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO021_TEXT	     segment byte public 'CODE'
CO021_TEXT	     ends
CO023_TEXT	     segment byte public 'CODE'
CO023_TEXT	     ends
CO028_TEXT	     segment byte public 'CODE'
CO028_TEXT	     ends
CO02A_TEXT	     segment byte public 'CODE'
CO02A_TEXT	     ends
CO02B_TEXT	     segment byte public 'CODE'
CO02B_TEXT	     ends
CO02C_TEXT	     segment byte public 'CODE'
CO02C_TEXT	     ends
CO06A_TEXT	     segment byte public 'CODE'
CO06A_TEXT	     ends
CO06C_TEXT	     segment byte public 'CODE'
CO06C_TEXT	     ends
   	     public  X015_03
   	     public  X015_02
   	     public  X015_00
   	     public  X015_01
   	     public  X015_06
   	     public  X015_07
   	     public  X015_04
   	     public  X015_05
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1c0a_66de
; BEGIN LG074 (gap	ovr_1c0a_66de:6DE0)
CO015_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO015_TEXT
; Original-image layout stub: not recovered source


X015_03 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,004h,056h,057h,08Bh,05Eh,006h,08Eh,006h,086h; ovr_1c0a_66de:6DE0
   	     db	     081h,026h,08Bh,077h,008h,026h,08Bh,05Fh,00Ch,026h,08Bh,047h,008h,089h  ; ovr_1c0a_66de:6DEE
   	     db	     046h,0FEh,056h,0FFh,076h,0FEh,0B0h,001h,050h,09Ah

   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,053h,056h,0FFh,076h,0FEh,0B8h,001h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,040h,08Bh,05Eh,006h,08Eh,006h;		    ovr_1c0a_66de:6E0A
   	     db	     086h,081h,026h,0FFh,077h,00Ch,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F8h,057h; ovr_1c0a_66de:6E26
   	     db	     0FFh,076h,0FEh,033h,0C0h,050h,056h,0B0h,000h,050h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,057h,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h; ovr_1c0a_66de:6E50

   	     db	     089h,047h,00Ch,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h  ; ovr_1c0a_66de:6E5E
   	     db	     007h,074h,038h,08Bh,05Eh,0FEh,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,040h  ; ovr_1c0a_66de:6E6C
   	     db	     074h,02Bh,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,0B8h  ; ovr_1c0a_66de:6E7A
   	     db	     007h,000h,050h,056h,09Ah
   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h; ovr_1c0a_66de:6E88
   	     db	     086h,081h,026h,089h,047h,00Ch,026h,08Bh,05Fh,00Ch,026h,08Bh,047h,008h  ; ovr_1c0a_66de:6E96
   	     db	     089h,046h,0FEh,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,08Ah,087h,0CAh,009h  ; ovr_1c0a_66de:6EA4
   	     db	     0B4h,000h,0A9h,040h,000h,075h,033h,056h,0FFh,076h,0FEh,0B0h,000h,050h  ; ovr_1c0a_66de:6EB2
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,021h,0B8h,06Dh,000h; ovr_1c0a_66de:6EC0

   	     db	     050h,0FFh,076h,0FEh,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,056h,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,006h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h; ovr_1c0a_66de:6ECE
   	     db	     06Ah,001h,08Eh,006h,09Ah,063h,026h,083h,03Ch,015h,075h,03Dh,056h,0FFh  ; ovr_1c0a_66de:6EEA
   	     db	     076h,0FEh,0B8h,001h,000h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh; ovr_1c0a_66de:6EF8
   	     db	     0C0h,075h,02Ah,0B8h,084h,001h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,056h,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,08Bh,05Eh,006h; ovr_1c0a_66de:6F06
   	     db	     08Eh,006h,086h,081h,026h,0FFh,077h,016h,026h,0FFh,077h,018h,09Ah

   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,08Bh,07Fh,00Ah;		    ovr_1c0a_66de:6F22
   	     db	     08Eh,006h,09Ah,063h,026h,0F6h,044h,002h,008h,075h,007h,026h,0F6h,044h  ; ovr_1c0a_66de:6F3E
   	     db	     002h,010h,074h,002h,033h,0FFh,056h,08Bh,05Eh,006h,08Eh,006h,086h,081h  ; ovr_1c0a_66de:6F4C
   	     db	     026h,0FFh,077h,00Ch,057h,09Ah
   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,05Eh,006h,08Eh; ovr_1c0a_66de:6F5A
   	     db	     006h,086h,081h,026h,089h,047h,00Ch,016h,08Dh,046h,006h,050h,09Ah

   	     dw	     052h
   	     dw	     seg CO004_TEXT
   	     db	     00Ah,0C0h,074h,003h,0E9h,0D3h,000h,08Bh,05Eh,006h,08Eh;		    ovr_1c0a_66de:6F68
   	     db	     006h,086h,081h,026h,08Bh,047h,00Ah,089h,046h,0FCh,080h,03Eh,015h,05Fh  ; ovr_1c0a_66de:6F84
   	     db	     000h,075h,003h,0E9h,0BBh,000h,08Bh,05Eh,0FCh,026h,083h,03Fh,001h,074h  ; ovr_1c0a_66de:6F92
   	     db	     003h,0E9h,0AFh,000h,026h,08Bh,047h,00Ah,03Bh,006h,012h,05Fh,074h,003h  ; ovr_1c0a_66de:6FA0
   	     db	     0E9h,0A2h,000h,08Bh,05Eh,006h,026h,08Ah,047h,006h,0B4h,000h,0A9h,010h  ; ovr_1c0a_66de:6FAE
   	     db	     000h,075h,019h,0B8h,04Dh,001h,050h,033h,0C0h,033h,0D2h,050h,052h,050h  ; ovr_1c0a_66de:6FBC
   	     db	     052h,08Bh,05Eh,0FCh,026h,0FFh,077h,016h,050h,09Ah

   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h,014h,05Fh,001h,083h,03Eh,016h,05Fh,000h,074h,06Fh,0FFh,036h  ; ovr_1c0a_66de:6FD8
   	     db	     016h,05Fh,09Ah
   	     dw	     02Ah
   	     dw	     seg CO02B_TEXT
   	     db	     08Bh,0F8h,00Bh,0FFh,074h,026h,0B8h; ovr_1c0a_66de:6FE6
   	     db	     06Bh,000h,050h,0FFh,036h,012h,05Fh,09Ah

   	     dw	     0BBh
   	     dw	     seg CO00F_TEXT
   	     db	     050h,057h;	ovr_1c0a_66de:6FF4
   	     db	     0FFh,036h,0C8h,05Eh,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0FFh,076h,006h,057h,09Ah; ovr_1c0a_66de:7002
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,006h,0FFh,076h,006h,0FFh,036h,012h,05Fh;	ovr_1c0a_66de:701E

   	     db	     09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,006h; ovr_1c0a_66de:702C
   	     db	     0C6h,006h,015h,05Fh,000h,0FFh,076h,006h,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,006h,0C6h,006h,015h,05Fh,001h,08Bh,046h,006h;		    ovr_1c0a_66de:703A
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:7056

X015_06 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,006h; ovr_1c0a_66de:7056
   	     db	     056h,057h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,08Bh,077h,008h,026h  ; ovr_1c0a_66de:7064
   	     db	     08Bh,07Fh,00Ch,026h,08Bh,045h,008h,089h,046h,0FEh,08Eh,006h,09Ah,063h  ; ovr_1c0a_66de:7072
   	     db	     026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,075h,003h,0E9h,0B7h,002h,026h  ; ovr_1c0a_66de:7080
   	     db	     0F6h,044h,002h,020h,075h,003h,0E9h,0ADh,002h,08Eh,006h,086h,081h,08Bh  ; ovr_1c0a_66de:708E
   	     db	     05Eh,006h,026h,0C7h,007h,012h,000h,057h,033h,0C0h,050h,056h,09Ah

   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,0F8h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h;		    ovr_1c0a_66de:709C
   	     db	     047h,00Ch,026h,08Bh,045h,008h,089h,046h,0FEh,056h,0FFh,076h,0FEh,0B0h  ; ovr_1c0a_66de:70B8
   	     db	     000h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,003h,0E9h,0A5h,004h; ovr_1c0a_66de:70C6
   	     db	     057h,09Ah
   	     dw	     020h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,09Ah,063h,08Bh,05Eh; ovr_1c0a_66de:70D4

   	     db	     0FEh,026h,083h,03Fh,011h,075h,038h,026h,08Bh,047h,009h,026h,00Bh,047h  ; ovr_1c0a_66de:70E2
   	     db	     00Bh,075h,02Eh,026h,0FFh,074h,007h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     00Bh,0C2h;	ovr_1c0a_66de:70F0
   	     db	     074h,021h,0B8h,088h,000h,050h,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h;	ovr_1c0a_66de:70FE
   	     db	     0FFh,076h,0FEh,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,006h,09Ah; ovr_1c0a_66de:710C
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,05Bh,004h,057h,09Ah
   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     00Ah; ovr_1c0a_66de:711A
   	     db	     0C0h,075h,00Dh,057h,09Ah
   	     dw	     0A7h
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,075h,003h,0E9h; ovr_1c0a_66de:7128
   	     db	     0BBh,000h,057h,09Ah
   	     dw	     039h
   	     dw	     seg CO007_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,074h,003h; ovr_1c0a_66de:7136
   	     db	     0E9h,0ACh,000h,08Eh,006h,09Ah,063h,026h,0FFh,074h,007h,0FFh,076h,0FEh  ; ovr_1c0a_66de:7144
   	     db	     0B8h,001h,000h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     00Ah,0C0h,075h,017h,08Eh; ovr_1c0a_66de:7152
   	     db	     006h,09Ah,063h,026h,0FFh,074h,007h,0FFh,076h,0FEh,0B0h,001h,050h,09Ah  ; ovr_1c0a_66de:7160
   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,07Dh,08Bh,05Eh,006h,08Eh,006h,086h;	ovr_1c0a_66de:716E

   	     db	     081h,026h,08Bh,05Fh,00Ah,026h,083h,03Fh,03Bh,075h,03Eh,026h,083h,03Dh  ; ovr_1c0a_66de:717C
   	     db	     001h,075h,038h,026h,08Bh,05Dh,00Ah,08Eh,006h,010h,064h,026h,08Ah,047h  ; ovr_1c0a_66de:718A
   	     db	     007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,006h,000h,075h,01Fh  ; ovr_1c0a_66de:7198
   	     db	     0B8h,03Bh,001h,050h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,08Bh,05Fh  ; ovr_1c0a_66de:71A6
   	     db	     00Ah,026h,08Bh,05Fh,00Ch,026h,0FFh,077h,00Eh,09Ah

   	     dw	     02Ah
   	     dw	     seg CO019_TEXT
   	     db	     0E9h,087h,000h,057h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,056h,057h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh;	    ovr_1c0a_66de:71C2
   	     db	     077h,00Ah,09Ah
   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h; ovr_1c0a_66de:71DE
   	     db	     026h,089h,047h,00Ch,0E9h,086h,003h,057h,09Ah

   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh; ovr_1c0a_66de:71EC
   	     db	     0F8h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h,047h,00Ch,026h,08Bh  ; ovr_1c0a_66de:71FA
   	     db	     05Fh,00Ah,026h,083h,03Fh,03Bh,075h,005h,0B8h,010h,001h,0EBh,094h,08Eh  ; ovr_1c0a_66de:7208
   	     db	     006h,09Ah,063h,026h,08Bh,05Ch,007h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h  ; ovr_1c0a_66de:7216
   	     db	     040h,074h,030h,026h,08Bh,05Ch,007h,026h,08Bh,05Fh,005h,08Eh,006h,03Eh  ; ovr_1c0a_66de:7224
   	     db	     05Fh,026h,0F7h,047h,018h,080h,000h,074h,01Ch,0B8h,01Ah,001h,050h,08Eh  ; ovr_1c0a_66de:7232
   	     db	     006h,09Ah,063h,026h,0FFh,074h,007h,09Ah

   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h;	ovr_1c0a_66de:7240
   	     db	     033h,0C0h,033h,0D2h,050h,052h,0E9h,0BFh,0FEh,057h,09Ah

   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,05Bh,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,007h,026h;	    ovr_1c0a_66de:724E
   	     db	     08Ah,047h,002h,0B4h,000h,0A9h,001h,000h,075h,048h,0B8h,052h,001h,050h  ; ovr_1c0a_66de:726A
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,08Bh,05Fh,00Ah,026h,083h,03Fh  ; ovr_1c0a_66de:7278
   	     db	     001h,075h,012h,08Bh,05Eh,006h,026h,08Bh,05Fh,00Ah,026h,0FFh,077h,00Ah  ; ovr_1c0a_66de:7286
   	     db	     09Ah
   	     dw	     04Dh
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,005h,08Ch,0DAh,0B8h,0CAh,00Fh,052h,050h; ovr_1c0a_66de:7294

   	     db	     033h,0C0h,033h,0D2h,050h,052h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h  ; ovr_1c0a_66de:72A2
   	     db	     0FFh,077h,016h,026h,0FFh,077h,018h,09Ah

   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h;	ovr_1c0a_66de:72B0
   	     db	     09Ah,063h,026h,0FFh,074h,007h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FCh; ovr_1c0a_66de:72BE
   	     db	     0B8h,005h,000h,050h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h  ; ovr_1c0a_66de:72CC
   	     db	     00Ah,0FFh,076h,0FCh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FAh,005h,014h,000h,0FFh,036h,086h,081h,050h,08Bh,05Eh;	    ovr_1c0a_66de:72DA
   	     db	     006h,08Eh,006h,086h,081h,026h,08Bh,047h,00Ah,005h,014h,000h,0FFh,036h  ; ovr_1c0a_66de:72F6
   	     db	     086h,081h,050h,0B9h,006h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0FFh,076h,0FCh; ovr_1c0a_66de:7304
   	     db	     09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h; ovr_1c0a_66de:7312

   	     db	     047h,00Ah,026h,080h,067h,006h,0FEh,026h,0C7h,007h,047h,000h,0FFh,076h  ; ovr_1c0a_66de:7320
   	     db	     006h,0FFh,076h,0FAh,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h,050h; ovr_1c0a_66de:732E
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     0E9h,038h,002h,057h,09Ah
   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h,047h,00Ch,026h  ; ovr_1c0a_66de:734A
   	     db	     08Bh,045h,008h,089h,046h,0FEh,026h,08Bh,05Fh,008h,08Eh,006h,09Ah,063h  ; ovr_1c0a_66de:7358
   	     db	     026h,083h,03Fh,015h,075h,03Ch,056h,0FFh,076h,0FEh,0B8h,001h,000h,050h  ; ovr_1c0a_66de:7366
   	     db	     09Ah
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,029h,0B8h,050h,001h; ovr_1c0a_66de:7374

   	     db	     050h,056h,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,0FEh,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh;		    ovr_1c0a_66de:7382
   	     db	     077h,016h,033h,0C0h,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     056h,0FFh,076h,0FEh; ovr_1c0a_66de:739E
   	     db	     0B0h,001h,050h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h,016h  ; ovr_1c0a_66de:73AC
   	     db	     026h,0FFh,077h,018h,09Ah
   	     dw	     025h
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h,0FCh,083h,07Eh; ovr_1c0a_66de:73BA
   	     db	     0FCh,000h,075h,003h,0E9h,08Ah,000h,08Bh,05Eh,0FCh,08Eh,006h,010h,064h  ; ovr_1c0a_66de:73C8
   	     db	     026h,083h,07Fh,00Fh,003h,075h,07Ch,08Bh,05Eh,006h,08Eh,006h,086h,081h  ; ovr_1c0a_66de:73D6
   	     db	     026h,08Bh,05Fh,00Ch,026h,083h,03Fh,036h,074h,035h,056h,0B0h,000h,050h  ; ovr_1c0a_66de:73E4
   	     db	     09Ah
   	     dw	     03Eh
   	     dw	     seg CO00F_TEXT
   	     db	     00Bh,0C0h,074h,049h,08Bh,05Eh,006h,08Eh,006h; ovr_1c0a_66de:73F2

   	     db	     086h,081h,026h,0FFh,077h,00Ch,09Ah
   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,075h; ovr_1c0a_66de:7400
   	     db	     035h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,09Ah

   	     dw	     0A7h
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,075h,021h,056h,0FFh,076h,0FEh,0B8h,002h,000h;		    ovr_1c0a_66de:740E
   	     db	     050h,09Ah
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     00Ah,0C0h,075h,025h,056h,0FFh,076h,0FEh; ovr_1c0a_66de:742A

   	     db	     0B0h,001h,050h,09Ah
   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,075h,015h,016h,08Dh; ovr_1c0a_66de:7438
   	     db	     046h,006h,050h,033h,0C0h,050h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO012_TEXT
   	     db	     00Ah,0C0h;	ovr_1c0a_66de:7446
   	     db	     074h,003h,0E9h,020h,001h,056h,0FFh,076h,0FEh,0B0h,001h,050h,09Ah

   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,046h,08Bh,05Eh,006h,08Eh,006h,086h,081h;		    ovr_1c0a_66de:7454
   	     db	     026h,0FFh,077h,00Ch,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h,0FAh,0FFh,076h; ovr_1c0a_66de:7470
   	     db	     0FAh,0FFh,076h,0FEh,033h,0C0h,050h,056h,0B0h,000h,050h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO06A_TEXT
   	     db	     089h,046h,0FAh,0FFh,076h,0FAh,033h,0C0h,050h,050h,09Ah;		    ovr_1c0a_66de:747E
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,05Eh,006h,08Eh; ovr_1c0a_66de:749A
   	     db	     006h,086h,081h,026h,089h,047h,00Ch,08Eh,006h,086h,081h,08Bh,05Eh,006h  ; ovr_1c0a_66de:74A8
   	     db	     026h,0C7h,007h,012h,000h,026h,08Bh,05Fh,008h,08Eh,006h,09Ah,063h,026h  ; ovr_1c0a_66de:74B6
   	     db	     08Bh,01Fh,0F6h,087h,0CAh,009h,007h,074h,048h,08Bh,05Eh,006h,08Eh,006h  ; ovr_1c0a_66de:74C4
   	     db	     086h,081h,026h,08Bh,05Fh,00Ch,026h,08Bh,05Fh,008h,08Eh,006h,09Ah,063h  ; ovr_1c0a_66de:74D2
   	     db	     026h,08Bh,01Fh,0F6h,087h,0CAh,009h,040h,074h,02Bh,08Bh,05Eh,006h,08Eh  ; ovr_1c0a_66de:74E0
   	     db	     006h,086h,081h,026h,0FFh,077h,00Ch,0B8h,007h,000h,050h,056h,09Ah

   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h,047h,00Ch;		    ovr_1c0a_66de:74EE
   	     db	     026h,08Bh,05Fh,00Ch,026h,08Bh,047h,008h,089h,046h,0FEh,08Eh,006h,09Ah  ; ovr_1c0a_66de:750A
   	     db	     063h,026h,083h,03Ch,012h,074h,020h,026h,08Bh,01Ch,08Ah,087h,0CAh,009h  ; ovr_1c0a_66de:7518
   	     db	     0B4h,000h,0A9h,040h,000h,075h,015h,056h,0FFh,076h,0FEh,0B0h,000h,050h  ; ovr_1c0a_66de:7526
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,003h,0E9h,0BEh,0FBh; ovr_1c0a_66de:7534

   	     db	     056h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,09Ah

   	     dw	     05Ch
   	     dw	     seg CO007_TEXT
   	     db	     050h,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h;		    ovr_1c0a_66de:7542
   	     db	     00Ah,09Ah
   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h; ovr_1c0a_66de:755E

   	     db	     089h,047h,00Ch,016h,08Dh,046h,006h,050h,09Ah

   	     dw	     052h
   	     dw	     seg CO004_TEXT
   	     db	     08Bh; ovr_1c0a_66de:756C
   	     db	     046h,006h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h;	raw:757A

X015_04 label   far
   	     db	     055h,08Bh,0ECh,083h; ovr_1c0a_66de:757A
   	     db	     0ECh,00Ch,056h,057h,08Bh,05Eh,008h,08Eh,006h,086h,081h,026h,08Bh,077h  ; ovr_1c0a_66de:7588
   	     db	     008h,026h,08Bh,07Fh,00Ch,026h,08Bh,045h,008h,089h,046h,0FCh,08Eh,006h  ; ovr_1c0a_66de:7596
   	     db	     09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,025h,026h,0F6h  ; ovr_1c0a_66de:75A4
   	     db	     044h,002h,020h,074h,01Eh,057h,033h,0C0h,050h,056h,09Ah

   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,0F8h,08Bh,05Eh,008h,08Eh,006h,086h,081h,026h,089h,047h,00Ch;	    ovr_1c0a_66de:75B2
   	     db	     026h,08Bh,045h,008h,089h,046h,0FCh,08Eh,006h,09Ah,063h,026h,08Bh,01Ch  ; ovr_1c0a_66de:75CE
   	     db	     0F6h,087h,0CAh,009h,014h,075h,003h,0E9h,02Eh,001h,026h,0F6h,044h,002h  ; ovr_1c0a_66de:75DC
   	     db	     020h,075h,003h,0E9h,024h,001h,056h,0FFh,076h,0FCh,0B0h,000h,050h,09Ah  ; ovr_1c0a_66de:75EA
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,074h,003h,0E9h,00Fh,001h,057h;	ovr_1c0a_66de:75F8

   	     db	     09Ah
   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     050h,09Ah
   	     dw	     020h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,057h; ovr_1c0a_66de:7606
   	     db	     09Ah
   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,00Fh,0B8h,00Dh,001h; ovr_1c0a_66de:7614

   	     db	     050h,0FFh,076h,008h,09Ah
   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0B1h,003h,089h,07Eh; ovr_1c0a_66de:7622
   	     db	     0FEh,0EBh,00Eh,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,047h,00Ch  ; ovr_1c0a_66de:7630
   	     db	     089h,046h,0FEh,08Eh,006h,086h,081h,08Bh,05Eh,0FEh,026h,083h,03Fh,02Ah  ; ovr_1c0a_66de:763E
   	     db	     074h,0E5h,057h,09Ah
   	     dw	     0A7h
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,005h,0B8h,02Dh; ovr_1c0a_66de:764C
   	     db	     001h,0EBh,0C5h,08Eh,006h,086h,081h,08Bh,05Eh,0FEh,026h,083h,03Fh,001h  ; ovr_1c0a_66de:765A
   	     db	     075h,040h,026h,08Bh,05Fh,00Ah,08Eh,006h,010h,064h,026h,08Ah,047h,007h  ; ovr_1c0a_66de:7668
   	     db	     0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,005h,000h,075h,027h,0B8h  ; ovr_1c0a_66de:7676
   	     db	     0D9h,000h,050h,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,0FFh,077h,00Ah  ; ovr_1c0a_66de:7684
   	     db	     09Ah
   	     dw	     04Dh
   	     dw	     seg CO019_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,0FFh; ovr_1c0a_66de:7692

   	     db	     076h,008h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,035h,003h,08Eh,006h,09Ah,063h; ovr_1c0a_66de:76A0
   	     db	     026h,0FFh,074h,007h,0FFh,076h,0FCh,0B8h,001h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     00Ah,0C0h,075h,03Bh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FCh,026h;	    ovr_1c0a_66de:76AE
   	     db	     08Bh,01Fh,0F6h,087h,0CAh,009h,014h,074h,013h,026h,0FFh,074h,007h,0FFh  ; ovr_1c0a_66de:76CA
   	     db	     076h,0FCh,0B0h,000h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,075h,017h; ovr_1c0a_66de:76D8
   	     db	     08Eh,006h,09Ah,063h,026h,0FFh,074h,007h,0FFh,076h,0FCh,0B0h,001h,050h  ; ovr_1c0a_66de:76E6
   	     db	     09Ah
   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,014h,056h,057h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO06A_TEXT
   	     db	     050h,033h,0C0h,050h,0E9h,0E3h; ovr_1c0a_66de:76F4
   	     db	     001h,0E9h,0CDh,001h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh  ; ovr_1c0a_66de:7710
   	     db	     009h,014h,074h,007h,026h,0F6h,044h,002h,020h,075h,024h,08Bh,05Eh,008h  ; ovr_1c0a_66de:771E
   	     db	     08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,09Ah

   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh; ovr_1c0a_66de:772C
   	     db	     0F8h,08Bh,05Eh,008h,08Eh,006h,086h,081h,026h,089h,047h,00Ch,026h,08Bh  ; ovr_1c0a_66de:773A
   	     db	     045h,008h,089h,046h,0FCh,08Eh,006h,09Ah,063h,026h,083h,03Ch,015h,075h  ; ovr_1c0a_66de:7748
   	     db	     03Ch,0FFh,076h,0FCh,056h,0B8h,001h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,029h,0B8h,050h,001h,050h,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h;	ovr_1c0a_66de:7764
   	     db	     08Bh,05Eh,008h,08Eh,006h,086h,081h,026h,0FFh,077h,016h,033h,0C0h,050h  ; ovr_1c0a_66de:7780
   	     db	     09Ah
   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h; ovr_1c0a_66de:778E

   	     db	     0CAh,009h,040h,075h,010h,08Bh,05Eh,0FCh,026h,08Bh,01Fh,0F6h,087h,0CAh  ; ovr_1c0a_66de:779C
   	     db	     009h,040h,075h,003h,0E9h,00Fh,001h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch  ; ovr_1c0a_66de:77AA
   	     db	     0F6h,087h,0CAh,009h,007h,074h,01Dh,08Bh,05Eh,0FCh,026h,08Bh,01Fh,0F6h  ; ovr_1c0a_66de:77B8
   	     db	     087h,0CAh,009h,040h,074h,010h,057h,0B8h,007h,000h,050h,056h,09Ah

   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,0F8h,0E9h,0E4h,000h,016h,08Dh,046h,008h,050h,09Ah;		    ovr_1c0a_66de:77C6
   	     dw	     052h
   	     dw	     seg CO004_TEXT
   	     db	     00Ah,0C0h,074h,026h,0FFh,076h,008h,08Bh,01Eh,098h;	ovr_1c0a_66de:77E2

   	     db	     063h,08Eh,006h,02Ah,078h,026h,0FFh,077h,010h,0FFh,076h,006h,09Ah

   	     dw	     061h
   	     dw	     seg CO00F_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,008h,0FFh,076h; ovr_1c0a_66de:77F0
   	     db	     008h,0E9h,0A4h,000h,056h,0FFh,076h,0FCh,0B0h,001h,050h,08Bh,05Eh,008h  ; ovr_1c0a_66de:780C
   	     db	     08Eh,006h,086h,081h,026h,0FFh,077h,016h,026h,0FFh,077h,018h,09Ah

   	     dw	     025h
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h,0FAh,083h,07Eh,0FAh,000h,074h,022h,08Bh,05Eh;		    ovr_1c0a_66de:781A
   	     db	     0FAh,08Eh,006h,010h,064h,026h,083h,07Fh,00Fh,003h,074h,014h,056h,057h  ; ovr_1c0a_66de:7836
   	     db	     08Bh,05Eh,008h,08Eh,006h,086h,081h,026h,0FFh,077h,00Ah,09Ah

   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     0EBh,081h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh;	    ovr_1c0a_66de:7844
   	     db	     009h,040h,074h,05Ch,026h,0F6h,044h,002h,004h,074h,055h,08Bh,05Eh,008h  ; ovr_1c0a_66de:7860
   	     db	     08Eh,006h,086h,081h,026h,0FFh,077h,00Ah,056h,057h,033h,0C0h,050h,09Ah  ; ovr_1c0a_66de:786E
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     05Ch
   	     dw	     seg CO00F_TEXT
   	     db	     089h,046h,0FEh,0FFh; ovr_1c0a_66de:787C
   	     db	     076h,008h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0FEh,08Bh,01Eh,098h,063h; ovr_1c0a_66de:788A
   	     db	     08Eh,006h,02Ah,078h,026h,0FFh,077h,010h,0FFh,076h,006h,09Ah

   	     dw	     061h
   	     dw	     seg CO00F_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,0FFh,076h,0FEh; ovr_1c0a_66de:7898
   	     db	     033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     0E9h,01Fh,001h,08Eh,006h; ovr_1c0a_66de:78B4
   	     db	     09Ah,063h,026h,083h,03Ch,00Ch,074h,01Dh,056h,08Eh,006h,086h,081h,026h  ; ovr_1c0a_66de:78C2
   	     db	     0FFh,075h,008h,0B0h,000h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh; ovr_1c0a_66de:78D0
   	     db	     0C0h,075h,006h,0B8h,098h,000h,0E9h,03Bh,0FDh,056h,057h,08Bh,05Eh,008h  ; ovr_1c0a_66de:78DE
   	     db	     08Eh,006h,086h,081h,026h,0FFh,077h,00Ah,09Ah

   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh; ovr_1c0a_66de:78EC
   	     db	     05Eh,008h,08Eh,006h,086h,081h,026h,089h,047h,00Ch,08Eh,006h,086h,081h  ; ovr_1c0a_66de:78FA
   	     db	     08Bh,05Eh,008h,026h,0C7h,007h,012h,000h,026h,083h,07Fh,00Ah,000h,075h  ; ovr_1c0a_66de:7908
   	     db	     017h,08Bh,046h,008h,089h,046h,0FEh,026h,08Bh,047h,00Ch,089h,046h,008h  ; ovr_1c0a_66de:7916
   	     db	     0FFh,076h,0FEh,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0EBh,00Ah,016h,08Dh,046h,008h; ovr_1c0a_66de:7924
   	     db	     050h,09Ah
   	     dw	     052h
   	     dw	     seg CO004_TEXT
   	     db	     08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h; ovr_1c0a_66de:7932

   	     db	     026h,0FFh,077h,010h,0FFh,076h,006h,09Ah

   	     dw	     061h
   	     dw	     seg CO00F_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:7940
   	     db	     0F8h,083h,07Eh,0F8h,000h,075h,003h,0E9h,084h,000h,08Eh,006h,09Ah,063h  ; ovr_1c0a_66de:794E
   	     db	     026h,08Bh,01Ch,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h,000h,075h,055h  ; ovr_1c0a_66de:795C
   	     db	     08Eh,006h,086h,081h,08Bh,05Eh,008h,026h,083h,03Fh,012h,074h,048h,026h  ; ovr_1c0a_66de:796A
   	     db	     0FFh,077h,008h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F6h,0B8h,005h,000h; ovr_1c0a_66de:7978
   	     db	     050h,0FFh,076h,0F6h,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,008h,09Ah; ovr_1c0a_66de:7986
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F4h,0FFh,076h,0F4h,0FFh,076h,0F8h,09Ah;	ovr_1c0a_66de:7994

   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F4h,0FFh,076h,0F4h,0FFh,076h,0F6h,09Ah;	ovr_1c0a_66de:79A2

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,008h,0EBh; ovr_1c0a_66de:79B0
   	     db	     00Eh,0FFh,076h,008h,0FFh,076h,0F8h,09Ah

   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:79BE
   	     db	     008h,0FFh,076h,008h,056h,033h,0C0h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h; ovr_1c0a_66de:79CC
   	     db	     046h,008h,08Bh,046h,008h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h,055h  ; ovr_1c0a_66de:79DA
   	     db	     08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,05Eh,006h,08Eh,006h,086h,081h  ; ovr_1c0a_66de:79E8
   	     db	     026h,08Bh,077h,00Ch,026h,083h,07Ch,00Ch,000h,075h,00Ah,026h,08Bh,05Fh  ; ovr_1c0a_66de:79F6
   	     db	     00Ah,026h,08Bh,047h,008h,0EBh,008h,08Eh,006h,086h,081h,026h,08Bh,044h  ; ovr_1c0a_66de:7A04
   	     db	     00Ch,089h,046h,0FCh,08Eh,006h,086h,081h,026h,0FFh,074h,00Eh,0FFh,076h  ; ovr_1c0a_66de:7A12
   	     db	     0FCh,0B0h,001h,050h,026h,0FFh,074h,016h,026h,0FFh,074h,018h,09Ah

   	     dw	     025h
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h,0FEh,083h,07Eh,0FEh,000h,074h,00Eh,08Bh,05Eh;		    ovr_1c0a_66de:7A20
   	     db	     0FEh,08Eh,006h,010h,064h,026h,083h,07Fh,00Fh,002h,074h,050h,0B8h,012h  ; ovr_1c0a_66de:7A3C
   	     db	     000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO02C_TEXT
   	     db	     089h,046h,0FAh,08Eh,006h,086h,081h; ovr_1c0a_66de:7A4A
   	     db	     026h,08Bh,044h,00Eh,08Bh,05Eh,0FAh,08Eh,006h,09Ah,063h,026h,089h,047h  ; ovr_1c0a_66de:7A58
   	     db	     007h,0B8h,0D1h,000h,050h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,026h  ; ovr_1c0a_66de:7A66
   	     db	     0FFh,074h,010h,0FFh,076h,0FAh,0FFh,076h,0FCh,09Ah

   	     dw	     02Fh
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h; ovr_1c0a_66de:7A82
   	     db	     006h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0EBh,058h,0FFh,076h,0FEh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Bh,0C6h;	    ovr_1c0a_66de:7A90
   	     db	     005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,010h,064h,026h,08Bh,047h,004h,08Eh;	    ovr_1c0a_66de:7AAC
   	     db	     006h,086h,081h,026h,089h,045h,008h,026h,08Bh,044h,00Ch,026h,089h,045h  ; ovr_1c0a_66de:7AC8
   	     db	     00Eh,026h,080h,04Dh,006h,001h,056h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,05Eh;	ovr_1c0a_66de:7AD6
   	     db	     006h,08Eh,006h,086h,081h,026h,089h,07Fh,00Ch,08Bh,046h,006h,05Fh,05Eh  ; ovr_1c0a_66de:7AE4
   	     db	     08Bh,0E5h,05Dh,0CAh,002h,000h; raw:7AF2
X015_07 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,010h,056h,057h; ovr_1c0a_66de:7AF2

   	     db	     08Bh,076h,008h,0C7h,046h,0FEh,000h,000h,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1c0a_66de:7B00
   	     db	     07Ch,00Ch,026h,08Bh,044h,00Ah,089h,046h,0FCh,08Bh,05Eh,0FCh,026h,08Bh  ; ovr_1c0a_66de:7B0E
   	     db	     047h,008h,089h,046h,0FAh,0C7h,046h,0F8h,000h,000h,0C7h,046h,0F4h,000h  ; ovr_1c0a_66de:7B1C
   	     db	     000h,026h,083h,03Dh,000h,075h,00Ch,033h,0C0h,050h,056h,09Ah

   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0C6h,003h,08Eh,006h,086h,081h,026h,083h,03Dh,001h,075h;	    ovr_1c0a_66de:7B2A
   	     db	     017h,026h,0FFh,074h,00Ch,033h,0C0h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO003_TEXT
   	     db	     08Eh; ovr_1c0a_66de:7B46
   	     db	     006h,086h,081h,026h,089h,044h,00Ch,0E9h,0A3h,003h,08Eh,006h,086h,081h  ; ovr_1c0a_66de:7B54
   	     db	     026h,083h,03Dh,04Ah,075h,017h,026h,08Bh,045h,00Ch,089h,046h,0F4h,08Bh  ; ovr_1c0a_66de:7B62
   	     db	     046h,0FAh,089h,046h,0F2h,026h,08Bh,045h,00Ah,089h,046h,0FEh,0E9h,0A7h  ; ovr_1c0a_66de:7B70
   	     db	     000h,08Eh,006h,086h,081h,026h,083h,07Dh,010h,002h,075h,008h,056h,00Eh  ; ovr_1c0a_66de:7B7E
   	     db	     0E8h,058h,0FEh,0E9h,071h,003h,08Eh,006h,086h,081h,026h,08Bh,045h,00Ch  ; ovr_1c0a_66de:7B8C
   	     db	     089h,046h,0F4h,083h,07Eh,0F4h,000h,075h,005h,08Bh,046h,0FAh,0EBh,003h  ; ovr_1c0a_66de:7B9A
   	     db	     08Bh,046h,0F4h,089h,046h,0F2h,08Eh,006h,086h,081h,026h,0FFh,075h,00Ah  ; ovr_1c0a_66de:7BA8
   	     db	     0FFh,076h,0F2h,016h,08Dh,046h,0F8h,050h,016h,08Dh,046h,0FEh,050h,016h  ; ovr_1c0a_66de:7BB6
   	     db	     08Dh,046h,0F6h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO06C_TEXT
   	     db	     083h,07Eh,0F8h,000h,074h; ovr_1c0a_66de:7BC4
   	     db	     02Bh,0B8h,065h,000h,050h,08Eh,006h,086h,081h,026h,0FFh,075h,00Ah,026h  ; ovr_1c0a_66de:7BD2
   	     db	     0FFh,075h,010h,033h,0C0h,050h,0FFh,076h,0F2h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,0F8h,09Ah
   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,057h,0E9h; ovr_1c0a_66de:7BEE
   	     db	     0F0h,000h,083h,07Eh,0FEh,000h,075h,022h,0B8h,0D1h,000h,050h,08Eh,006h  ; ovr_1c0a_66de:7BFC
   	     db	     086h,081h,026h,0FFh,075h,00Ah,026h,0FFh,075h,010h,033h,0C0h,050h,0FFh  ; ovr_1c0a_66de:7C0A
   	     db	     076h,0F2h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h,0F2h,0EBh,0CDh; ovr_1c0a_66de:7C18
   	     db	     083h,07Eh,0F4h,000h,074h,02Fh,0FFh,076h,0F4h,0FFh,076h,0FAh,0B0h,000h  ; ovr_1c0a_66de:7C26
   	     db	     050h,09Ah
   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,01Bh,0B8h,0BFh; ovr_1c0a_66de:7C34

   	     db	     000h,050h,0FFh,076h,0F4h,09Ah
   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0FFh,076h; ovr_1c0a_66de:7C42
   	     db	     0FAh,09Ah
   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,0E9h,092h,000h,083h,07Eh,0F4h; ovr_1c0a_66de:7C50

   	     db	     000h,074h,043h,0FFh,076h,0F4h,0FFh,076h,0FAh,09Ah

   	     dw	     066h
   	     dw	     seg CO00F_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,032h,08Bh,05Eh,0FEh,08Eh,006h,0A4h,078h,026h  ; ovr_1c0a_66de:7C6C
   	     db	     08Ah,047h,004h,0B4h,000h,025h,003h,000h,03Dh,003h,000h,075h,00Fh,026h  ; ovr_1c0a_66de:7C7A
   	     db	     08Bh,05Fh,006h,08Eh,006h,010h,064h,026h,083h,07Fh,00Fh,003h,074h,00Eh  ; ovr_1c0a_66de:7C88
   	     db	     0B8h,065h,000h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     03Eh
   	     dw	     seg CO021_TEXT
   	     db	     0EBh,0A8h;	ovr_1c0a_66de:7C96
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,0A4h,078h,026h,08Ah,047h,004h,0B4h,000h,025h  ; ovr_1c0a_66de:7CA4
   	     db	     003h,000h,03Dh,003h,000h,075h,00Fh,026h,08Bh,05Fh,006h,08Eh,006h,010h  ; ovr_1c0a_66de:7CB2
   	     db	     064h,026h,083h,07Fh,013h,000h,075h,02Eh,0FFh,076h,0FEh,0FFh,076h,0FAh  ; ovr_1c0a_66de:7CC0
   	     db	     09Ah
   	     dw	     034h
   	     dw	     seg CO06C_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,01Dh,0B8h,0B6h,000h; ovr_1c0a_66de:7CCE

   	     db	     050h,0FFh,076h,0FEh,09Ah
   	     dw	     03Eh
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h; ovr_1c0a_66de:7CDC
   	     db	     0D2h,050h,052h,056h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,00Dh,002h,08Bh,05Eh; ovr_1c0a_66de:7CEA
   	     db	     0FEh,08Eh,006h,0A4h,078h,026h,08Ah,047h,004h,0B4h,000h,025h,003h,000h  ; ovr_1c0a_66de:7CF8
   	     db	     08Bh,0D8h,083h,0FBh,003h,076h,003h,0E9h,0D2h,001h,0D1h,0E3h,02Eh,0FFh  ; ovr_1c0a_66de:7D06
   	     db	     0A7h,02Bh,011h,080h,07Eh,006h,000h,074h,06Ch,08Eh,006h,086h,081h,026h  ; ovr_1c0a_66de:7D14
   	     db	     0F6h,044h,006h,002h,074h,061h,083h,07Eh,0F4h,000h,074h,05Bh,0FFh,076h  ; ovr_1c0a_66de:7D22
   	     db	     0FEh,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F0h,08Bh,05Eh,0F0h,08Eh,006h; ovr_1c0a_66de:7D30

   	     db	     086h,081h,08Bh,046h,0F4h,026h,089h,047h,00Ch,08Bh,05Eh,0FEh,08Eh,006h  ; ovr_1c0a_66de:7D3E
   	     db	     0A4h,078h,026h,08Bh,047h,008h,08Bh,05Eh,0F0h,08Eh,006h,086h,081h,026h  ; ovr_1c0a_66de:7D4C
   	     db	     089h,047h,008h,08Bh,046h,0F0h,005h,014h,000h,0FFh,036h,086h,081h,050h  ; ovr_1c0a_66de:7D5A
   	     db	     08Bh,0C7h,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah  ; ovr_1c0a_66de:7D68
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,05Eh,0F0h,08Eh,006h,086h,081h,026h,080h,04Fh;	ovr_1c0a_66de:7D76

   	     db	     006h,001h,0E9h,043h,001h,08Bh,05Eh,0FEh,08Eh,006h,0A4h,078h,026h,08Bh  ; ovr_1c0a_66de:7D84
   	     db	     05Fh,00Ah,08Eh,006h,09Ah,063h,026h,08Bh,047h,005h,08Bh,05Eh,0FAh,026h  ; ovr_1c0a_66de:7D92
   	     db	     03Bh,047h,005h,074h,036h,0FFh,076h,0FCh,09Ah

   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     050h; ovr_1c0a_66de:7DA0
   	     db	     0FFh,076h,0FAh,0FFh,076h,0F4h,08Bh,05Eh,0FEh,08Eh,006h,0A4h,078h,026h  ; ovr_1c0a_66de:7DAE
   	     db	     0FFh,077h,00Ah,0B0h,000h,050h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO06A_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:7DBC
   	     db	     0FCh,0FFh,076h,0FCh,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h,086h,081h,026h; ovr_1c0a_66de:7DCA
   	     db	     089h,044h,00Ah,0FFh,076h,0FEh,08Bh,0C7h,005h,014h,000h,08Bh,016h,086h  ; ovr_1c0a_66de:7DD8
   	     db	     081h,0B9h,006h,000h,09Ah
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     09Ah
   	     dw	     052h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ch,026h,08Bh,05Ch,00Ch,026h,0FFh  ; ovr_1c0a_66de:7DF4
   	     db	     077h,008h,08Bh,05Eh,0FAh,08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,002h  ; ovr_1c0a_66de:7E02
   	     db	     074h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,050h,08Bh,05Eh,0FAh,08Eh  ; ovr_1c0a_66de:7E10
   	     db	     006h,09Ah,063h,026h,0F6h,047h,002h,001h,074h,005h,0B8h,001h,000h,0EBh  ; ovr_1c0a_66de:7E1E
   	     db	     002h,033h,0C0h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO010_TEXT
   	     db	     08Eh,006h,086h,081h,026h; ovr_1c0a_66de:7E2C
   	     db	     08Bh,05Ch,00Ch,026h,089h,047h,008h,0E9h,09Eh,000h,08Bh,05Eh,0FEh,08Eh  ; ovr_1c0a_66de:7E3A
   	     db	     006h,0A4h,078h,026h,0FFh,077h,008h,026h,08Bh,047h,006h,099h,052h,050h  ; ovr_1c0a_66de:7E48
   	     db	     09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F0h,0EBh,06Ch,08Bh,05Eh,0FEh,08Eh; ovr_1c0a_66de:7E56

   	     db	     006h,0A4h,078h,026h,0FFh,077h,006h,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:7E64
   	     db	     0F0h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Bh,0C7h,005h,014h,000h  ; ovr_1c0a_66de:7E72
   	     db	     0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh; ovr_1c0a_66de:7E80
   	     db	     05Eh,0FEh,08Eh,006h,0A4h,078h,026h,08Bh,05Fh,006h,08Eh,006h,010h,064h  ; ovr_1c0a_66de:7E8E
   	     db	     026h,08Bh,047h,004h,08Bh,05Eh,0F0h,08Eh,006h,086h,081h,026h,089h,047h  ; ovr_1c0a_66de:7E9C
   	     db	     008h,08Bh,046h,0F4h,026h,089h,047h,00Eh,026h,080h,04Fh,006h,001h,08Bh  ; ovr_1c0a_66de:7EAA
   	     db	     05Eh,0FEh,08Eh,006h,0A4h,078h,026h,08Ah,047h,004h,0B4h,000h,025h,003h  ; ovr_1c0a_66de:7EB8
   	     db	     000h,03Dh,002h,000h,075h,00Bh,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,046h;	ovr_1c0a_66de:7EC6
   	     db	     0F0h,0EBh,02Ch,08Eh,006h,086h,081h,08Bh,046h,0F0h,026h,089h,044h,00Ch  ; ovr_1c0a_66de:7ED4
   	     db	     08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ch,026h,08Bh,047h,008h,026h,089h  ; ovr_1c0a_66de:7EE2
   	     db	     044h,008h,057h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,080h; ovr_1c0a_66de:7EF0
   	     db	     04Ch,006h,001h,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h,037h  ; ovr_1c0a_66de:7EFE
   	     db	     00Fh,064h,010h,080h,010h,080h,010h; raw:7F0C
X015_05 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,004h,056h; ovr_1c0a_66de:7F0C
   	     db	     057h,08Bh,076h,006h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,033h,0C0h  ; ovr_1c0a_66de:7F1A
   	     db	     050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     08Eh; ovr_1c0a_66de:7F28
   	     db	     006h,086h,081h,026h,089h,044h,00Ah,026h,08Bh,05Ch,00Ah,026h,083h,03Fh  ; ovr_1c0a_66de:7F36
   	     db	     000h,075h,00Ch,033h,0C0h,050h,056h,09Ah

   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0CEh;	ovr_1c0a_66de:7F44
   	     db	     001h,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,026h,08Bh,05Fh,008h,08Eh  ; ovr_1c0a_66de:7F52
   	     db	     006h,09Ah,063h,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h  ; ovr_1c0a_66de:7F60
   	     db	     000h,075h,00Ch,0B8h,0EFh,000h,050h,056h,09Ah

   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh; ovr_1c0a_66de:7F6E
   	     db	     0F0h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ch,033h,0C0h,050h,050h,09Ah  ; ovr_1c0a_66de:7F7C
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F8h,057h,0B8h,080h,000h,050h,033h,0C0h,050h;	ovr_1c0a_66de:7F8A

   	     db	     09Ah
   	     dw	     020h
   	     dw	     seg CO028_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h,089h,044h; ovr_1c0a_66de:7F98

   	     db	     00Ch,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h,083h,03Fh,00Dh,075h  ; ovr_1c0a_66de:7FA6
   	     db	     013h,08Eh,006h,086h,081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h  ; ovr_1c0a_66de:7FB4
   	     db	     080h,07Fh,00Dh,00Bh,074h,006h,0B8h,0F6h,000h,0E9h,07Bh,0FFh,08Eh,006h  ; ovr_1c0a_66de:7FC2
   	     db	     086h,081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h  ; ovr_1c0a_66de:7FD0
   	     db	     087h,0CAh,009h,014h,075h,003h,0E9h,094h,000h,08Eh,006h,086h,081h,026h  ; ovr_1c0a_66de:7FDE
   	     db	     08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h,08Bh,047h,007h,089h,046h,0FCh  ; ovr_1c0a_66de:7FEC
   	     db	     08Bh,05Eh,0FCh,026h,0FFh,077h,003h,08Eh,006h,086h,081h,026h,08Bh,05Ch  ; ovr_1c0a_66de:7FFA
   	     db	     00Ah,026h,0FFh,077h,008h,0B0h,001h,050h,09Ah

   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     0B4h; ovr_1c0a_66de:8008
   	     db	     000h,00Bh,0C0h,075h,006h,0B8h,08Ch,000h,0E9h,028h,0FFh,08Bh,05Eh,0FCh  ; ovr_1c0a_66de:8016
   	     db	     08Eh,006h,09Ah,063h,026h,08Bh,047h,003h,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1c0a_66de:8024
   	     db	     05Ch,00Ah,026h,03Bh,047h,008h,074h,041h,026h,0FFh,074h,00Ah,09Ah

   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h,0FEh,08Bh,05Eh,0FCh,08Eh,006h,09Ah,063h,026h;		    ovr_1c0a_66de:8032
   	     db	     0FFh,077h,003h,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,0FFh,076h,0FEh,033h,0C0h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:805C
   	     db	     0FEh,0FFh,076h,0FEh,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h,086h,081h,026h; ovr_1c0a_66de:806A
   	     db	     089h,044h,00Ah,08Eh,006h,086h,081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah  ; ovr_1c0a_66de:8078
   	     db	     063h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,014h,074h,016h,08Eh,006h,086h  ; ovr_1c0a_66de:8086
   	     db	     081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h,08Bh,05Fh,007h,026h  ; ovr_1c0a_66de:8094
   	     db	     083h,03Fh,012h,074h,078h,0B8h,017h,000h,050h,0FFh,036h,0C8h,05Eh,057h  ; ovr_1c0a_66de:80A2
   	     db	     09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,0C8h,05Eh,033h,0C0h,0BAh,001h; ovr_1c0a_66de:80B0

   	     db	     000h,050h,052h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h,089h,07Ch,00Ch,0FFh,036h,0FCh,063h  ; ovr_1c0a_66de:80CC
   	     db	     026h,0FFh,074h,00Ah,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     050h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ah,026h,0C7h,004h,008h,000h;	    ovr_1c0a_66de:80DA
   	     db	     0FFh,076h,0FCh,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,056h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F0h,056h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F0h,08Bh; ovr_1c0a_66de:8104
   	     db	     0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h,045h,055h,08Bh,0ECh,056h  ; ovr_1c0a_66de:8120
   	     db	     08Bh,076h,004h,08Eh,006h,086h,081h,026h,083h,03Ch,048h,075h,01Eh,026h  ; ovr_1c0a_66de:812E
   	     db	     083h,07Ch,00Ah,000h,075h,013h,026h,083h,07Ch,00Ch,000h,075h,00Ch,026h  ; ovr_1c0a_66de:813C
   	     db	     083h,07Ch,00Eh,000h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,0EBh  ; ovr_1c0a_66de:814A
   	     db	     002h,0B0h,000h,05Eh,05Dh,04Dh,0C2h,002h,000h; raw:8158

X015_01 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1c0a_66de:8158
   	     db	     008h,056h,057h,08Bh,076h,006h,08Eh,006h,086h,081h,026h,083h,03Ch,01Dh  ; ovr_1c0a_66de:8166
   	     db	     074h,013h,026h,083h,03Ch,01Eh,074h,00Dh,0B8h,007h,001h,050h,056h,09Ah  ; ovr_1c0a_66de:8174
   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,03Dh,002h,08Eh,006h,086h,081h,026h,0FFh,074h;	ovr_1c0a_66de:8182

   	     db	     00Ah,0E8h,095h,0FFh,00Ah,0C0h,074h,008h,056h,09Ah

   	     dw	     048h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ch,0E8h,07Eh,0FFh,00Ah  ; ovr_1c0a_66de:819E
   	     db	     0C0h,074h,049h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,09Ah

   	     dw	     02Ah
   	     dw	     seg CO014_TEXT
   	     db	     089h,046h,0FEh,08Eh,006h,086h,081h,026h,083h,03Ch,01Dh,075h;	    ovr_1c0a_66de:81AC
   	     db	     019h,0B8h,02Ah,000h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1c0a_66de:81C8
   	     db	     033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,0FEh,08Eh,006h; ovr_1c0a_66de:81D6
   	     db	     086h,081h,026h,0FFh,074h,00Ch,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     056h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0CBh,001h,08Eh,006h,086h,081h,026h,08Bh,044h,00Ah;		    ovr_1c0a_66de:81E4
   	     db	     089h,046h,0FCh,08Bh,05Eh,0FCh,0A1h,05Ch,061h,026h,089h,047h,008h,016h  ; ovr_1c0a_66de:8200
   	     db	     08Dh,046h,0FCh,050h,016h,08Dh,046h,0F8h,050h,09Ah

   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,08Bh,044h,00Ch,089h,046h,0FAh,08Bh,05Eh,0FAh  ; ovr_1c0a_66de:821C
   	     db	     0A1h,05Ch,061h,026h,089h,047h,008h,016h,08Dh,046h,0FAh,050h,016h,08Dh  ; ovr_1c0a_66de:822A
   	     db	     046h,0FEh,050h,09Ah
   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0F8h,0FFh,076h,0FEh; ovr_1c0a_66de:8238
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F8h,0B8h,024h,000h,050h,0B8h,02Fh; ovr_1c0a_66de:8246

   	     db	     000h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,09Ah; ovr_1c0a_66de:8254
   	     db	     064h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,0B8h;	ovr_1c0a_66de:8262
   	     db	     02Fh,000h,050h,0FFh,076h,0FAh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h; ovr_1c0a_66de:8270
   	     db	     09Ah,064h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1c0a_66de:827E
   	     db	     09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,0B8h,024h,000h,050h,0B8h,02Fh; ovr_1c0a_66de:828C

   	     db	     000h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,072h; ovr_1c0a_66de:829A
   	     db	     061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,0B8h;	ovr_1c0a_66de:82A8
   	     db	     02Fh,000h,050h,0FFh,076h,0FAh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h; ovr_1c0a_66de:82B6
   	     db	     072h,061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1c0a_66de:82C4
   	     db	     09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,023h,000h,050h,057h,0FFh,076h; ovr_1c0a_66de:82D2

   	     db	     0FEh,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,0B8h,024h,000h,050h,0B8h; ovr_1c0a_66de:82E0

   	     db	     02Fh,000h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h; ovr_1c0a_66de:82EE
   	     db	     074h,061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1c0a_66de:82FC
   	     db	     0B8h,02Fh,000h,050h,0FFh,076h,0FAh,09Ah

   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh;	ovr_1c0a_66de:830A
   	     db	     036h,074h,061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,023h,000h,050h,057h,0FFh; ovr_1c0a_66de:8326

   	     db	     076h,0FEh,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,0B8h,024h,000h,050h; ovr_1c0a_66de:8334
   	     db	     0B8h,02Fh,000h,050h,0FFh,076h,0FCh,0FFh,036h,088h,062h,09Ah

   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,0B8h,02Fh,000h,050h,0FFh; ovr_1c0a_66de:8342
   	     db	     076h,0FAh,0FFh,036h,088h,062h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,023h,000h; ovr_1c0a_66de:835E
   	     db	     050h,057h,0FFh,076h,0FEh,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,08Eh; ovr_1c0a_66de:837A
   	     db	     006h,086h,081h,026h,083h,03Ch,01Eh,075h,00Fh,0B8h,02Ah,000h,050h,0FFh  ; ovr_1c0a_66de:8388
   	     db	     076h,0FEh,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,0FFh,076h,0F8h,0FFh; ovr_1c0a_66de:8396
   	     db	     076h,0FEh,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,056h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0FEh,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,0FEh,08Bh,046h,0FEh,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h  ; ovr_1c0a_66de:83C0
   	     db	     045h,055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,076h,00Ch,080h,07Eh,004h  ; ovr_1c0a_66de:83CE
   	     db	     000h,075h,006h,083h,07Eh,00Ah,000h,074h,077h,0B8h,018h,000h,050h,0FFh  ; ovr_1c0a_66de:83DC
   	     db	     076h,006h,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,098h,064h,08Bh,05Eh; ovr_1c0a_66de:83EA
   	     db	     008h,08Eh,006h,09Ah,063h,026h,0FFh,077h,007h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     052h,050h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h; ovr_1c0a_66de:8406
   	     db	     046h,0FEh,00Bh,0F6h,075h,004h,08Bh,036h,0D2h,063h,0B8h,001h,000h,050h  ; ovr_1c0a_66de:8414
   	     db	     056h,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0FEh,0FFh,076h,00Ah,09Ah; ovr_1c0a_66de:8422

   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,08Eh,006h; ovr_1c0a_66de:8430
   	     db	     010h,064h,026h,0F6h,044h,006h,010h,074h,026h,026h,08Bh,01Ch,026h,08Bh  ; ovr_1c0a_66de:843E
   	     db	     047h,004h,08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ah,026h,089h,047h,00Eh  ; ovr_1c0a_66de:844C
   	     db	     0EBh,011h,0FFh,036h,0C8h,05Eh,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0FFh,076h,008h,057h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,00Ah,000h; raw:8476

X015_02 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1c0a_66de:8476
   	     db	     01Ah,056h,057h,0C7h,046h,0F8h,000h,000h,0C6h,046h,0EFh,000h,08Bh,05Eh  ; ovr_1c0a_66de:8484
   	     db	     006h,08Eh,006h,086h,081h,026h,08Bh,077h,008h,026h,083h,07Fh,00Ah,000h  ; ovr_1c0a_66de:8492
   	     db	     075h,01Bh,0FFh,036h,0C8h,05Eh,033h,0C0h,0BAh,001h,000h,050h,052h,09Ah  ; ovr_1c0a_66de:84A0
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,089h,047h;	ovr_1c0a_66de:84AE

   	     db	     00Ah,08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,08Bh,047h,00Ah,089h,046h  ; ovr_1c0a_66de:84BC
   	     db	     0FEh,026h,08Bh,07Fh,00Ch,026h,08Bh,045h,00Ah,089h,046h,0FCh,026h,08Bh  ; ovr_1c0a_66de:84CA
   	     db	     045h,00Ch,089h,046h,0FAh,026h,08Ah,047h,006h,0B4h,000h,025h,020h,000h  ; ovr_1c0a_66de:84D8
   	     db	     0F7h,0D8h,01Bh,0C0h,040h,088h,046h,0F3h,056h,033h,0C0h,050h,0B0h,000h  ; ovr_1c0a_66de:84E6
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0F4h,08Eh,006h,09Ah,063h,026h; ovr_1c0a_66de:84F4

   	     db	     0F6h,044h,002h,004h,074h,039h,0EBh,02Dh,0B8h,018h,000h,050h,0FFh,076h  ; ovr_1c0a_66de:8502
   	     db	     0FEh,0FFh,036h,0C8h,05Eh,08Eh,006h,09Ah,063h,026h,0FFh,074h,00Bh,026h  ; ovr_1c0a_66de:8510
   	     db	     0FFh,074h,009h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,08Eh,006h,09Ah,063h,026h,08Bh,074h,007h,08Eh,006h,09Ah  ; ovr_1c0a_66de:852C
   	     db	     063h,026h,083h,03Ch,011h,074h,0C9h,0FFh,076h,0FEh,0FFh,036h,0C8h,05Eh  ; ovr_1c0a_66de:853A
   	     db	     033h,0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h,0FEh,0C6h,046h,0F2h,001h,0FFh,076h,0FEh,09Ah

   	     dw	     04Dh
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,033h,0FFh,076h,0FEh,0B0h,000h,050h,09Ah

   	     dw	     061h
   	     dw	     seg CO02A_TEXT
   	     db	     089h,046h,0FEh,08Eh,006h,086h,081h,08Bh,05Eh,0FEh,026h,083h;	    ovr_1c0a_66de:8556
   	     db	     03Fh,002h,075h,018h,026h,083h,07Fh,00Ch,000h,075h,007h,026h,083h,07Fh  ; ovr_1c0a_66de:8580
   	     db	     00Ah,001h,074h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0F2h  ; ovr_1c0a_66de:858E
   	     db	     080h,07Eh,0F3h,000h,075h,006h,080h,07Eh,0F2h,000h,074h,005h,0B8h,001h  ; ovr_1c0a_66de:859C
   	     db	     000h,0EBh,002h,033h,0C0h,088h,046h,0F3h,056h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0F0h,080h,07Eh,0F3h,000h,074h,006h,0A1h,0D2h,063h,089h,046h  ; ovr_1c0a_66de:85B8
   	     db	     0F8h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,040h,074h  ; ovr_1c0a_66de:85C6
   	     db	     075h,026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh,026h,0F7h,047h,018h,080h  ; ovr_1c0a_66de:85D4
   	     db	     000h,074h,01Dh,0B8h,01Ah,001h,050h,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h; ovr_1c0a_66de:85E2
   	     db	     050h,033h,0C0h,033h,0D2h,050h,052h,0FFh,076h,006h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,087h,002h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h;	    ovr_1c0a_66de:85F0
   	     db	     03Eh,05Fh,026h,0F7h,047h,018h,004h,000h,074h,005h,0B8h,001h,000h,0EBh  ; ovr_1c0a_66de:860C
   	     db	     002h,033h,0C0h,088h,046h,0EFh,08Ah,046h,0F3h,0B4h,000h,00Bh,0C0h,075h  ; ovr_1c0a_66de:861A
   	     db	     021h,0FFh,036h,05Ah,062h,056h,09Ah
   	     dw	     025h
   	     dw	     seg CO06C_TEXT
   	     db	     089h,046h,0EAh; ovr_1c0a_66de:8628
   	     db	     083h,07Eh,0EAh,000h,074h,00Eh,08Bh,05Eh,0EAh,08Eh,006h,0A4h,078h,026h  ; ovr_1c0a_66de:8636
   	     db	     08Bh,047h,006h,089h,046h,0F8h,083h,07Eh,0F0h,000h,075h,00Fh,0B8h,008h  ; ovr_1c0a_66de:8644
   	     db	     001h,050h,0FFh,076h,006h,09Ah
   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,02Ah,002h,08Eh; ovr_1c0a_66de:8652
   	     db	     006h,09Ah,063h,026h,0F6h,044h,002h,004h,075h,003h,0E9h,049h,001h,080h  ; ovr_1c0a_66de:8660
   	     db	     07Eh,0F2h,000h,075h,003h,0E9h,0F7h,000h,056h,0B0h,001h,050h,09Ah

   	     dw	     09Dh
   	     dw	     seg CO00F_TEXT
   	     db	     089h,046h,0F6h,083h,07Eh,0FAh,000h,074h,00Fh,0B8h,0CBh;		    ovr_1c0a_66de:866E
   	     db	     000h,050h,0FFh,076h,006h,09Ah
   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0F2h,001h,083h; ovr_1c0a_66de:868A
   	     db	     07Eh,0F6h,000h,075h,003h,0E9h,0B9h,000h,0C7h,046h,0EAh,000h,000h,080h  ; ovr_1c0a_66de:8698
   	     db	     07Eh,0EFh,000h,074h,005h,0A1h,03Ch,05Fh,0EBh,003h,0A1h,0C4h,05Eh,089h  ; ovr_1c0a_66de:86A6
   	     db	     046h,0ECh,08Bh,05Eh,0F4h,08Eh,006h,09Ah,063h,026h,0FFh,077h,007h,0B8h  ; ovr_1c0a_66de:86B4
   	     db	     00Fh,000h,050h,0B0h,000h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0F4h; ovr_1c0a_66de:86C2
   	     db	     080h,07Eh,0F3h,000h,075h,006h,083h,07Eh,0FCh,000h,074h,00Fh,016h,08Dh  ; ovr_1c0a_66de:86D0
   	     db	     046h,0FEh,050h,016h,08Dh,046h,0EAh,050h,09Ah

   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     0FFh; ovr_1c0a_66de:86DE
   	     db	     076h,0ECh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0F8h,0FFh,076h,0FCh; ovr_1c0a_66de:86EC
   	     db	     0FFh,076h,0F4h,0FFh,076h,0FEh,08Ah,046h,0F3h,050h,0E8h,0C7h,0FCh,050h  ; ovr_1c0a_66de:86FA
   	     db	     0FFh,036h,098h,064h,033h,0C0h,050h,0FFh,076h,0F0h,09Ah

   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0FEh,0FFh,036h,0C8h,05Eh,056h,0FFh,076h,0F6h,09Ah;	    ovr_1c0a_66de:8708
   	     dw	     04Dh
   	     dw	     seg CO00F_TEXT
   	     db	     099h,052h,050h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0B8h;	ovr_1c0a_66de:8724
   	     db	     01Dh,000h,050h,0FFh,076h,0F6h,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     08Eh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0FFh,076h,0EAh; ovr_1c0a_66de:8732
   	     db	     057h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0E9h,01Bh,001h,0B8h,0E1h,000h; ovr_1c0a_66de:874E

   	     db	     050h,0B8h,005h,000h,050h,033h,0C0h,050h,056h,09Ah

   	     dw	     020h
   	     dw	     seg CO021_TEXT
   	     db	     0E9h,082h,0FEh,0FFh,076h,0F8h,0FFh,076h,0FCh,0FFh,076h,0F4h,0FFh,076h  ; ovr_1c0a_66de:876A
   	     db	     0FEh,08Ah,046h,0F3h,050h,0E8h,04Eh,0FCh,08Bh,0F8h,0B8h,018h,000h,050h  ; ovr_1c0a_66de:8778
   	     db	     057h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h,0FFh,076h,0FAh,09Ah
   	     dw	     05Ch
   	     dw	     seg CO00F_TEXT
   	     db	     08Bh,0F8h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Bh,046h;	    ovr_1c0a_66de:8786
   	     db	     006h,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0E9h,0BEh,000h,0FFh,076h,0F8h,0FFh,076h,0FCh,0FFh,076h;		    ovr_1c0a_66de:87A2
   	     db	     0F4h,0FFh,076h,0FEh,0B0h,001h,050h,0E8h,006h,0FCh,08Bh,0F8h,083h,07Eh  ; ovr_1c0a_66de:87BE
   	     db	     0FAh,000h,075h,003h,0E9h,0A1h,000h,0C7h,046h,0EAh,000h,000h,0EBh,032h  ; ovr_1c0a_66de:87CC
   	     db	     0FFh,076h,0EAh,08Bh,05Eh,0FAh,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch  ; ovr_1c0a_66de:87DA
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0EAh,08Bh,046h,0FAh,089h,046h,0E8h; ovr_1c0a_66de:87E8

   	     db	     08Bh,05Eh,0FAh,08Eh,006h,086h,081h,026h,08Bh,047h,00Ah,089h,046h,0FAh  ; ovr_1c0a_66de:87F6
   	     db	     0FFh,076h,0E8h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     083h,07Eh,0FAh,000h,075h,0C8h; ovr_1c0a_66de:8804
   	     db	     0FFh,076h,0F4h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0E6h,0B8h,005h,000h; ovr_1c0a_66de:8812
   	     db	     050h,0FFh,076h,0E6h,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0F4h,057h; ovr_1c0a_66de:8820
   	     db	     09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,057h; ovr_1c0a_66de:882E
   	     db	     0B8h,00Bh,000h,050h,0B8h,018h,000h,050h,0FFh,076h,0E6h,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0EAh,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,057h,0FFh,076h; ovr_1c0a_66de:883C
   	     db	     0E6h,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h;	ovr_1c0a_66de:8866
   	     db	     0FFh,076h,0F4h,057h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0F4h,033h; ovr_1c0a_66de:8874
   	     db	     0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h; ovr_1c0a_66de:8882
   	     db	     000h,045h,055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,07Eh,004h,08Eh,006h  ; ovr_1c0a_66de:8890
   	     db	     09Ah,063h,026h,08Bh,01Dh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h,000h  ; ovr_1c0a_66de:889E
   	     db	     075h,004h,033h,0C0h,0EBh,04Bh,0FFh,036h,054h,062h,057h,09Ah

   	     dw	     025h
   	     dw	     seg CO06C_TEXT
   	     db	     089h,046h,0FEh,083h,07Eh,0FEh,000h,075h,002h,0EBh,0E7h,08Bh;	    ovr_1c0a_66de:88AC
   	     db	     05Eh,0FEh,08Eh,006h,0A4h,078h,026h,08Bh,077h,006h,08Eh,006h,010h,064h  ; ovr_1c0a_66de:88C8
   	     db	     026h,083h,07Ch,013h,000h,074h,01Eh,026h,08Bh,05Ch,004h,08Eh,006h,09Ah  ; ovr_1c0a_66de:88D6
   	     db	     063h,026h,08Bh,05Fh,009h,08Eh,006h,028h,064h,026h,083h,03Fh,000h,075h  ; ovr_1c0a_66de:88E4
   	     db	     008h,08Eh,006h,010h,064h,026h,08Bh,074h,013h,08Bh,0C6h,05Fh,05Eh,08Bh  ; ovr_1c0a_66de:88F2
   	     db	     0E5h,05Dh,04Dh,0C2h,002h,000h; raw:8900
X015_00 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,010h,056h,057h; ovr_1c0a_66de:8900

   	     db	     08Bh,05Eh,006h,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,033h,0C0h,050h  ; ovr_1c0a_66de:890E
   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h;	ovr_1c0a_66de:891C
   	     db	     0FEh,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,05Fh,008h,08Eh,006h  ; ovr_1c0a_66de:892A
   	     db	     09Ah,063h,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,014h,000h  ; ovr_1c0a_66de:8938
   	     db	     075h,00Fh,0B8h,012h,000h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,03Ch,002h,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,05Fh,008h  ; ovr_1c0a_66de:8954
   	     db	     08Eh,006h,09Ah,063h,026h,08Bh,047h,007h,089h,046h,0FAh,0FFh,076h,0FAh  ; ovr_1c0a_66de:8962
   	     db	     0E8h,01Eh,0FFh,08Bh,0F8h,00Bh,0FFh,074h,017h,08Bh,05Eh,006h,08Eh,006h  ; ovr_1c0a_66de:8970
   	     db	     086h,081h,026h,08Ah,047h,006h,0B4h,000h,0A9h,020h,000h,075h,005h,0B8h  ; ovr_1c0a_66de:897E
   	     db	     001h,000h,0EBh,002h,033h,0C0h,088h,046h,0F9h,08Bh,05Eh,006h,08Eh,006h  ; ovr_1c0a_66de:898C
   	     db	     086h,081h,026h,0FFh,077h,00Ah,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h,0FCh,08Eh,006h,086h,081h; ovr_1c0a_66de:899A
   	     db	     08Bh,05Eh,0FCh,026h,083h,03Fh,002h,075h,013h,026h,083h,07Fh,00Ch,000h  ; ovr_1c0a_66de:89B6
   	     db	     075h,00Ch,026h,083h,07Fh,00Ah,001h,075h,005h,0B8h,001h,000h,0EBh,002h  ; ovr_1c0a_66de:89C4
   	     db	     033h,0C0h,088h,046h,0F8h,08Bh,05Eh,0FAh,08Eh,006h,09Ah,063h,026h,0F6h  ; ovr_1c0a_66de:89D2
   	     db	     047h,002h,008h,075h,003h,0E9h,007h,001h,0FFh,036h,08Eh,061h,0FFh,076h  ; ovr_1c0a_66de:89E0
   	     db	     0FAh,09Ah
   	     dw	     0C5h
   	     dw	     seg CO02C_TEXT
   	     db	     089h,046h,0F6h,083h,07Eh,0F6h,000h,074h; ovr_1c0a_66de:89EE

   	     db	     01Bh,08Bh,05Eh,0F6h,08Eh,006h,0A4h,078h,026h,08Bh,05Fh,006h,08Eh,006h  ; ovr_1c0a_66de:89FC
   	     db	     010h,064h,026h,083h,07Fh,015h,000h,074h,005h,0B8h,001h,000h,0EBh,002h  ; ovr_1c0a_66de:8A0A
   	     db	     033h,0C0h,088h,046h,0F5h,0C7h,046h,0F2h,000h,000h,080h,07Eh,0F5h,000h  ; ovr_1c0a_66de:8A18
   	     db	     075h,006h,080h,07Eh,0F9h,000h,074h,00Fh,016h,08Dh,046h,0FEh,050h,016h  ; ovr_1c0a_66de:8A26
   	     db	     08Dh,046h,0F2h,050h,09Ah
   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0FEh,033h,0C0h; ovr_1c0a_66de:8A34
   	     db	     050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,0FEh,0FFh,076h,0FEh,09Ah; ovr_1c0a_66de:8A42
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     050h,0FFh,076h,0FAh; ovr_1c0a_66de:8A50
   	     db	     0FFh,076h,0FCh,080h,07Eh,0F9h,000h,074h,005h,0B8h,002h,000h,0EBh,003h  ; ovr_1c0a_66de:8A5E
   	     db	     0B8h,003h,000h,050h,09Ah
   	     dw	     057h
   	     dw	     seg CO00F_TEXT
   	     db	     08Bh,0F0h,080h,07Eh,0F9h; ovr_1c0a_66de:8A6C
   	     db	     000h,074h,02Ch,0FFh,036h,08Ch,064h,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh;	ovr_1c0a_66de:8A7A
   	     db	     076h,0FEh,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h,050h,050h,050h; ovr_1c0a_66de:8A88
   	     db	     09Ah
   	     dw	     08Eh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F0h,056h,0FFh,076h,0F0h,09Ah

   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,080h,07Eh,0F5h,000h,075h,003h,0E9h,0D7h,000h;		    ovr_1c0a_66de:8A96
   	     db	     0B8h,06Bh,000h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h;	ovr_1c0a_66de:8AB2
   	     db	     0FFh,036h,09Eh,062h,0FFh,036h,0C8h,05Eh,033h,0C0h,033h,0D2h,050h,052h  ; ovr_1c0a_66de:8AC0
   	     db	     09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0FFh,076h,0F2h,056h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0E9h,09Ah,000h,08Ah,046h,0F8h,0B4h,000h,00Bh,0C0h,074h,00Ah  ; ovr_1c0a_66de:8AEA
   	     db	     080h,07Eh,0F9h,000h,075h,004h,00Bh,0FFh,075h,004h,08Bh,03Eh,08Ch,064h  ; ovr_1c0a_66de:8AF8
   	     db	     08Eh,006h,010h,064h,026h,08Bh,05Dh,004h,08Eh,006h,09Ah,063h,026h,08Bh  ; ovr_1c0a_66de:8B06
   	     db	     05Fh,009h,08Eh,006h,028h,064h,026h,083h,03Fh,000h,074h,02Dh,0B8h,018h  ; ovr_1c0a_66de:8B14
   	     db	     000h,050h,0FFh,076h,0FCh,0FFh,036h,098h,064h,08Bh,05Eh,0FEh,08Eh,006h  ; ovr_1c0a_66de:8B22
   	     db	     086h,081h,026h,0FFh,077h,008h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     052h,050h,09Ah; ovr_1c0a_66de:8B30
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FCh,0EBh; ovr_1c0a_66de:8B3E
   	     db	     005h,0C7h,046h,0FCh,000h,000h,057h,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh;	ovr_1c0a_66de:8B4C
   	     db	     076h,0FEh,0FFh,076h,0FCh,033h,0C0h,050h,050h,050h,09Ah

   	     dw	     08Eh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,010h,064h,026h,0F6h,045h,006h,010h,074h,013h;	    ovr_1c0a_66de:8B5A
   	     db	     026h,08Bh,01Dh,026h,08Bh,047h,004h,08Eh,006h,086h,081h,026h,08Bh,05Ch  ; ovr_1c0a_66de:8B76
   	     db	     00Ah,026h,089h,047h,00Eh,056h,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; ovr_1c0a_66de:8B84


CO015_TEXT	     ends
; END LG074
   	     end
