; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
   	     extrn   BCC_DIAGNOSTIC:far
CO003_TEXT	     segment byte public 'CODE'
CO003_TEXT	     ends
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
CO00C_TEXT	     segment byte public 'CODE'
CO00C_TEXT	     ends
CO00F_TEXT	     segment byte public 'CODE'
CO00F_TEXT	     ends
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO021_TEXT	     segment byte public 'CODE'
CO021_TEXT	     ends
CO022_TEXT	     segment byte public 'CODE'
CO022_TEXT	     ends
CO023_TEXT	     segment byte public 'CODE'
CO023_TEXT	     ends
CO02B_TEXT	     segment byte public 'CODE'
CO02B_TEXT	     ends
CO02C_TEXT	     segment byte public 'CODE'
CO02C_TEXT	     ends
CO02D_TEXT	     segment byte public 'CODE'
CO02D_TEXT	     ends
CO031_TEXT	     segment byte public 'CODE'
CO031_TEXT	     ends
CO03D_TEXT	     segment byte public 'CODE'
CO03D_TEXT	     ends
CO03F_TEXT	     segment byte public 'CODE'
CO03F_TEXT	     ends
CO040_TEXT	     segment byte public 'CODE'
CO040_TEXT	     ends
   	     public  X010_01
   	     public  X010_00
   	     public  X010_02
   	     public  X010_03
   	     public  X010_04
   	     public  X010_05
   	     public  X010_06
   	     public  X010_07
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1bf4_6216
; BEGIN LG06F (gap	ovr_1bf4_6216:2160)
CO010_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO010_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,057h,0C7h,046h,0FEh,000h,000h  ; ovr_1bf4_6216:2160
   	     db	     0C7h,046h,0FCh,000h,000h,0E9h,0ABh,000h,09Ah

   	     dw	     0DEh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh; ovr_1bf4_6216:216E
   	     db	     0F8h,08Eh,006h,028h,064h,0A1h,08Bh,063h,026h,089h,045h,004h,083h,07Eh  ; ovr_1bf4_6216:217C
   	     db	     0FEh,000h,075h,005h,089h,07Eh,0FCh,0EBh,00Ah,08Eh,006h,028h,064h,08Bh  ; ovr_1bf4_6216:218A
   	     db	     05Eh,0FEh,026h,089h,03Fh,089h,07Eh,0FEh,08Bh,076h,0FCh,0EBh,007h,08Eh  ; ovr_1bf4_6216:2198
   	     db	     006h,028h,064h,026h,08Bh,034h,08Eh,006h,028h,064h,026h,08Bh,044h,004h  ; ovr_1bf4_6216:21A6
   	     db	     03Bh,006h,08Bh,063h,075h,0EBh,03Bh,076h,0FEh,074h,01Ah,0B8h,0ADh,000h  ; ovr_1bf4_6216:21B4
   	     db	     050h,026h,0FFh,074h,004h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO019_TEXT
   	     db	     052h,050h,033h,0C0h; ovr_1bf4_6216:21C2
   	     db	     033h,0D2h,050h,052h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,074h,03Ch,083h,03Eh,0C2h,05Eh,008h,075h,027h  ; ovr_1bf4_6216:21DE
   	     db	     0EBh,01Ch,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,074h,007h; ovr_1bf4_6216:21EC
   	     db	     083h,03Eh,0C2h,05Eh,008h,075h,009h,0B8h,0D4h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,008h,074h,0DDh,0EBh,00Eh,0B8h,0CAh,000h;	    ovr_1bf4_6216:21FA
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h,078h,064h,001h,083h,03Eh,0C2h; ovr_1bf4_6216:2216

   	     db	     05Eh,031h,075h,003h,0E9h,04Bh,0FFh,083h,03Eh,0C2h,05Eh,002h,074h,017h  ; ovr_1bf4_6216:2224
   	     db	     0B8h,0E9h,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h,078h,064h,001h; ovr_1bf4_6216:2232
   	     db	     0B8h,002h,000h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h; ovr_1bf4_6216:2240
   	     db	     075h,005h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     08Bh,046h,0FCh,05Fh,05Eh,08Bh,0E5h; ovr_1bf4_6216:224E
   	     db	     05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,083h,03Eh,0C2h,05Eh,045h,074h,01Ch  ; ovr_1bf4_6216:225C
   	     db	     083h,03Eh,0C2h,05Eh,031h,075h,01Ah,0FFh,036h,08Bh,063h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO03D_TEXT
   	     db	     08Eh,006h,09Ah,063h,08Bh,0D8h,026h,083h,03Fh,00Ch,075h,005h;	    ovr_1bf4_6216:226A
   	     db	     0B8h,001h,000h,0EBh,002h,033h,0C0h,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh  ; ovr_1bf4_6216:2286
   	     db	     083h,0ECh,01Eh,056h,057h,0A1h,02Eh,078h,089h,046h,0E4h,09Ah

   	     dw	     043h
   	     dw	     seg CO02C_TEXT
   	     db	     089h,046h,0E2h,08Eh,006h,02Ah,078h,08Bh,05Eh,0E2h,0A1h,098h;	    ovr_1bf4_6216:2294
   	     db	     063h,026h,089h,007h,08Bh,046h,0E2h,0A3h,098h,063h,0FFh,006h,02Eh,05Fh  ; ovr_1bf4_6216:22B0
   	     db	     0C4h,05Eh,004h,026h,0C6h,007h,000h,0C4h,05Eh,008h,026h,0C7h,007h,000h  ; ovr_1bf4_6216:22BE
   	     db	     000h,0C7h,046h,0FEh,000h,000h,0E8h,08Ah,0FFh,00Ah,0C0h,075h,003h,0E9h  ; ovr_1bf4_6216:22CC
   	     db	     0C5h,002h,09Ah
   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,060h,082h,002h,074h,003h; ovr_1bf4_6216:22DA
   	     db	     0E9h,0B6h,002h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0E9h,0D7h,002h,09Ah
   	     dw	     0DEh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,0A1h,0C8h,05Eh,089h,046h,0FAh,033h,0C0h,050h,016h;	    ovr_1bf4_6216:22E8
   	     db	     08Dh,046h,0FCh,050h,016h,08Dh,046h,0E8h,050h,016h,08Dh,046h,0E7h,050h  ; ovr_1bf4_6216:2304
   	     db	     016h,08Dh,046h,0FAh,050h,016h,08Dh,046h,0EEh,050h,016h,08Dh,046h,0E9h  ; ovr_1bf4_6216:2312
   	     db	     050h,090h,00Eh,0E8h,0A1h,01Bh,081h,07Eh,0FCh,082h,000h,074h,006h,083h  ; ovr_1bf4_6216:2320
   	     db	     07Eh,0FCh,038h,075h,00Ch,080h,07Eh,0E8h,000h,075h,006h,080h,07Eh,0E7h  ; ovr_1bf4_6216:232E
   	     db	     000h,074h,009h,0B8h,0FEh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0FFh,076h;	ovr_1bf4_6216:233C
   	     db	     0FAh,0B8h,001h,000h,050h,016h,08Dh,046h,0FAh,050h,016h,08Dh,046h,0F8h  ; ovr_1bf4_6216:234A
   	     db	     050h,016h,08Dh,046h,0F4h,050h,016h,08Dh,046h,0F2h,050h,016h,08Dh,046h  ; ovr_1bf4_6216:2358
   	     db	     0EEh,050h,016h,08Dh,046h,0EAh,050h,090h,00Eh,0E8h,037h,00Ch,08Eh,006h  ; ovr_1bf4_6216:2366
   	     db	     09Ah,063h,08Bh,05Eh,0FAh,026h,083h,03Fh,012h,075h,007h,0FFh,076h,0FAh  ; ovr_1bf4_6216:2374
   	     db	     033h,0C0h,0EBh,01Fh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FAh,026h,083h,03Fh  ; ovr_1bf4_6216:2382
   	     db	     011h,075h,01Eh,026h,0FFh,077h,007h,026h,0F6h,047h,002h,040h,074h,005h  ; ovr_1bf4_6216:2390
   	     db	     0B8h,010h,000h,0EBh,002h,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0FAh,080h,03Eh,0A0h,062h,000h,074h,03Dh,08Eh,006h;	    ovr_1bf4_6216:239E
   	     db	     09Ah,063h,08Bh,05Eh,0FAh,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,040h,074h  ; ovr_1bf4_6216:23BA
   	     db	     02Ch,08Bh,05Eh,0FAh,026h,08Bh,05Fh,005h,08Eh,006h,03Eh,05Fh,026h,0F7h  ; ovr_1bf4_6216:23C8
   	     db	     047h,018h,080h,000h,074h,019h,0B8h,01Ah,001h,050h,0FFh,076h,0FAh,09Ah  ; ovr_1bf4_6216:23D6
   	     dw	     048h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,028h,064h,08Bh,046h,0FAh,026h,089h,044h,002h;		    ovr_1bf4_6216:23E4
   	     db	     08Bh,046h,0F8h,026h,089h,044h,004h,083h,07Eh,0F8h,000h,074h,01Eh,083h  ; ovr_1bf4_6216:2400
   	     db	     07Eh,0F4h,000h,074h,009h,0B8h,079h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     083h,07Eh,0F2h,000h,074h,009h,0B8h,0FDh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     080h,03Eh,0A0h,062h,000h,075h,003h,0E9h,090h,000h,083h,03Eh,0C2h;	    ovr_1bf4_6216:241C
   	     db	     05Eh,00Bh,074h,003h,0E9h,086h,000h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0B8h,002h;	ovr_1bf4_6216:2438
   	     db	     000h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO022_TEXT
   	     db	     089h,046h,0F6h,0FFh,076h,0F6h,09Ah; ovr_1bf4_6216:2446
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,076h,0FAh,09Ah
   	     dw	     020h
   	     dw	     seg CO003_TEXT
   	     db	     08Bh; ovr_1bf4_6216:2454
   	     db	     0F8h,0FFh,076h,0FAh,057h,09Ah
   	     dw	     0D4h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0FFh,076h; ovr_1bf4_6216:2462
   	     db	     0FAh,08Eh,006h,086h,081h,026h,0FFh,075h,008h,09Ah

   	     dw	     0E3h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,025h,0B8h,088h,000h,050h,0FFh,076h,0FAh,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,08Eh,006h,086h,081h,026h,0FFh,075h,008h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,057h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,057h; ovr_1bf4_6216:247E
   	     db	     09Ah
   	     dw	     043h
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0F6h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO02B_TEXT
   	     db	     08Eh; ovr_1bf4_6216:24A8
   	     db	     006h,028h,064h,026h,089h,044h,008h,0FFh,076h,0F6h,09Ah

   	     dw	     043h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,028h,064h,006h,083h,07Eh,0FCh,038h,075h,005h,0B8h,001h;	    ovr_1bf4_6216:24B6
   	     db	     000h,0EBh,002h,033h,0C0h,007h,026h,088h,044h,006h,08Eh,006h,028h,064h  ; ovr_1bf4_6216:24D2
   	     db	     026h,0C7h,004h,000h,000h,083h,07Eh,0FEh,000h,075h,005h,0C4h,05Eh,008h  ; ovr_1bf4_6216:24E0
   	     db	     0EBh,007h,08Eh,006h,028h,064h,08Bh,05Eh,0FEh,026h,089h,037h,089h,076h  ; ovr_1bf4_6216:24EE
   	     db	     0FEh,08Eh,006h,028h,064h,026h,083h,07Ch,004h,000h,074h,02Dh,0C4h,05Eh  ; ovr_1bf4_6216:24FC
   	     db	     008h,026h,08Bh,037h,0EBh,007h,08Eh,006h,028h,064h,026h,08Bh,034h,08Eh  ; ovr_1bf4_6216:250A
   	     db	     006h,028h,064h,026h,08Bh,044h,004h,03Bh,046h,0F8h,075h,0ECh,03Bh,076h  ; ovr_1bf4_6216:2518
   	     db	     0FEh,074h,00Ch,0B8h,0ADh,000h,050h,0FFh,076h,0F8h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,074h,065h,083h,03Eh,0C2h,05Eh,009h,075h;	    ovr_1bf4_6216:2526
   	     db	     009h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h,075h,055h,083h,03Eh,0C2h,05Eh  ; ovr_1bf4_6216:2542
   	     db	     008h,075h,017h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,075h; ovr_1bf4_6216:2550
   	     db	     042h,0B8h,0CDh,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,037h,01Eh,0B8h; ovr_1bf4_6216:255E
   	     db	     082h,063h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO03D_TEXT
   	     db	     00Ah,0C0h,074h,00Bh,0B8h,0CAh; ovr_1bf4_6216:256C
   	     db	     000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,01Eh,083h,03Eh,0C2h,05Eh,009h; ovr_1bf4_6216:257A
   	     db	     074h,017h,0B8h,0E9h,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h,078h; ovr_1bf4_6216:2588
   	     db	     064h,001h,0B8h,002h,000h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO019_TEXT
   	     db	     01Eh,0B8h,082h; ovr_1bf4_6216:2596
   	     db	     063h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO03D_TEXT
   	     db	     00Ah,0C0h,074h,00Fh,09Ah
   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,060h,082h,067h,074h,003h,0E9h,035h,0FDh,08Eh,006h;	    ovr_1bf4_6216:25A4
   	     db	     028h,064h,08Bh,05Eh,0FEh,026h,0C7h,007h,000h,000h,083h,03Eh,0C2h,05Eh  ; ovr_1bf4_6216:25C0
   	     db	     009h,075h,00Ch,0C4h,05Eh,004h,026h,0C6h,007h,001h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,074h,017h,0B8h,0E9h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h,078h,064h,001h,0B8h,002h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,002h,075h,005h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0FFh,00Eh,02Eh,05Fh,08Eh,006h,02Ah,078h,08Bh,01Eh,098h,063h,026h;	    ovr_1bf4_6216:25CE
   	     db	     08Bh,007h,0A3h,098h,063h,0C7h,006h,030h,078h,000h,000h,08Bh,046h,0E4h  ; ovr_1bf4_6216:2614
   	     db	     0A3h,02Eh,078h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,008h,000h; raw:2622

X010_00 label   far
   	     db	     055h,08Bh;	ovr_1bf4_6216:2622
   	     db	     0ECh,083h,0ECh,008h,056h,057h,08Bh,07Eh,00Ah,0C6h,046h,0FBh,000h,08Eh  ; ovr_1bf4_6216:2630
   	     db	     006h,09Ah,063h,026h,08Bh,01Dh,0F6h,087h,0CAh,009h,014h,074h,00Fh,026h  ; ovr_1bf4_6216:263E
   	     db	     0F6h,045h,00Dh,080h,074h,008h,057h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h;	ovr_1bf4_6216:264C
   	     db	     08Eh,006h,09Ah,063h,026h,083h,03Dh,012h,075h,005h,0B8h,002h,000h,0EBh  ; ovr_1bf4_6216:265A
   	     db	     003h,0B8h,004h,000h,089h,046h,0FCh,08Ah,046h,007h,098h,08Bh,0D8h,083h  ; ovr_1bf4_6216:2668
   	     db	     0FBh,00Bh,076h,003h,0E9h,087h,000h,0D1h,0E3h,02Eh,0FFh,0A7h,0C5h,006h  ; ovr_1bf4_6216:2676
   	     db	     08Ah,046h,007h,098h,089h,046h,0FCh,0C7h,046h,0FEh,00Dh,000h,0EBh,072h  ; ovr_1bf4_6216:2684
   	     db	     0C6h,046h,0FBh,001h,0C7h,046h,0FCh,000h,000h,0C7h,046h,0FEh,00Fh,000h  ; ovr_1bf4_6216:2692
   	     db	     0EBh,062h,0C7h,046h,0FCh,000h,000h,0C7h,046h,0FEh,00Eh,000h,0EBh,056h  ; ovr_1bf4_6216:26A0
   	     db	     0C6h,046h,0FBh,001h,0C7h,046h,0FCh,000h,000h,0C7h,046h,0FEh,010h,000h  ; ovr_1bf4_6216:26AE
   	     db	     0EBh,046h,0C6h,046h,0FBh,001h,0EBh,0C7h,08Eh,006h,09Ah,063h,026h,083h  ; ovr_1bf4_6216:26BC
   	     db	     03Dh,012h,075h,024h,026h,08Ah,045h,00Ch,0B4h,000h,089h,046h,0F8h,080h  ; ovr_1bf4_6216:26CA
   	     db	     03Eh,0D1h,077h,000h,075h,007h,0F7h,046h,0F8h,001h,000h,074h,005h,0B8h  ; ovr_1bf4_6216:26D8
   	     db	     00Fh,000h,0EBh,003h,0B8h,00Dh,000h,089h,046h,0FEh,0EBh,012h,080h,03Eh  ; ovr_1bf4_6216:26E6
   	     db	     0D2h,077h,000h,074h,005h,0B8h,00Fh,000h,0EBh,003h,0B8h,00Dh,000h,089h  ; ovr_1bf4_6216:26F4
   	     db	     046h,0FEh,0FFh,076h,0FEh,09Ah
   	     dw	     02Fh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,08Eh,006h; ovr_1bf4_6216:2702
   	     db	     09Ah,063h,026h,08Bh,01Dh,0F6h,087h,0CAh,009h,014h,074h,010h,026h,0F6h  ; ovr_1bf4_6216:2710
   	     db	     045h,002h,020h,074h,009h,0B8h,024h,001h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,01Bh,075h,02Dh,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h  ; ovr_1bf4_6216:272C
   	     db	     075h,00Bh,0B8h,0F2h,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,019h,08Eh; ovr_1bf4_6216:273A
   	     db	     006h,09Ah,063h,026h,080h,04Ch,002h,020h,026h,083h,03Dh,00Ch,075h,00Ah  ; ovr_1bf4_6216:2748
   	     db	     0B8h,026h,001h,050h,09Ah
   	     dw	     017Dh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     059h,080h,07Eh,0FBh,000h; ovr_1bf4_6216:2756
   	     db	     074h,009h,08Eh,006h,09Ah,063h,026h,080h,04Ch,002h,080h,08Eh,006h,09Ah  ; ovr_1bf4_6216:2764
   	     db	     063h,026h,089h,07Ch,007h,026h,0C7h,044h,009h,000h,000h,08Ah,046h,0FCh  ; ovr_1bf4_6216:2772
   	     db	     00Ch,080h,026h,088h,044h,00Dh,026h,0C7h,044h,00Bh,000h,000h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,034h,075h,01Dh,083h,07Eh,0FEh,00Dh;		    ovr_1bf4_6216:2780
   	     db	     075h,012h,09Ah
   	     dw	     025h
   	     dw	     seg CO031_TEXT
   	     db	     08Eh,006h,09Ah,063h,026h,089h,044h; ovr_1bf4_6216:279C
   	     db	     009h,0C6h,006h,060h,061h,000h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h; ovr_1bf4_6216:27AA
   	     db	     05Eh,04Ah,074h,051h,083h,03Eh,0C2h,05Eh,04Bh,075h,058h,0EBh,048h,083h  ; ovr_1bf4_6216:27B8
   	     db	     03Eh,0C2h,05Eh,04Ah,075h,01Fh,08Eh,006h,09Ah,063h,026h,0F6h,044h,002h  ; ovr_1bf4_6216:27C6
   	     db	     001h,074h,009h,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h;	ovr_1bf4_6216:27D4
   	     db	     09Ah,063h,026h,080h,04Ch,002h,001h,0EBh,01Dh,08Eh,006h,09Ah,063h,026h  ; ovr_1bf4_6216:27E2
   	     db	     0F6h,044h,002h,002h,074h,009h,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,09Ah,063h,026h,080h,04Ch,002h,002h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,04Ah,074h,0B1h,083h,03Eh,0C2h,05Eh,04Bh,074h;	    ovr_1bf4_6216:27F0
   	     db	     0AAh,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h,064h,005h,024h  ; ovr_1bf4_6216:281A
   	     db	     005h,024h,005h,024h,005h,024h,005h,024h,005h,024h,005h,042h,005h,05Eh  ; ovr_1bf4_6216:2828
   	     db	     005h,032h,005h,04Eh,005h,024h,005h,045h,055h,08Bh,0ECh,083h,0ECh,008h  ; ovr_1bf4_6216:2836
   	     db	     056h,057h,08Bh,076h,008h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h  ; ovr_1bf4_6216:2844
   	     db	     0CAh,009h,014h,074h,010h,026h,0F6h,044h,002h,020h,074h,009h,0B8h,025h  ; ovr_1bf4_6216:2852
   	     db	     001h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0C6h,046h;	ovr_1bf4_6216:2860
   	     db	     0FBh,000h,083h,03Eh,0C2h,05Eh,004h,075h,00Ch,0C7h,046h,0FEh,000h,000h  ; ovr_1bf4_6216:286E
   	     db	     0C7h,046h,0FCh,000h,000h,0EBh,056h,080h,07Eh,00Ah,000h,074h,012h,0B8h  ; ovr_1bf4_6216:287C
   	     db	     004h,000h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO022_TEXT
   	     db	     089h,046h,0F8h,0C6h,046h,0FBh; ovr_1bf4_6216:288A
   	     db	     001h,0EBh,03Eh,0B8h,004h,000h,050h,016h,08Dh,046h,0FCh,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO03D_TEXT
   	     db	     083h,07Eh,0FEh,000h,07Ch,017h,075h,006h,083h,07Eh,0FCh;		    ovr_1bf4_6216:2898
   	     db	     000h,072h,00Fh,08Bh,046h,0FCh,00Bh,046h,0FEh,075h,01Ah,080h,03Eh,0A0h  ; ovr_1bf4_6216:28B4
   	     db	     062h,000h,074h,013h,0B8h,06Bh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C7h; ovr_1bf4_6216:28C2
   	     db	     046h,0FEh,000h,000h,0C7h,046h,0FCh,001h,000h,083h,03Eh,0C2h,05Eh,004h  ; ovr_1bf4_6216:28D0
   	     db	     075h,007h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0EBh,014h,0B8h,0E5h,000h,050h,01Eh; ovr_1bf4_6216:28DE
   	     db	     0B8h,082h,00Fh,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,003h,075h,016h,0B0h,000h,050h,056h,08Dh,046h;	    ovr_1bf4_6216:28EC
   	     db	     004h,08Ch,0D2h,0B9h,004h,000h,09Ah
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0E8h,027h,0FFh; ovr_1bf4_6216:2908
   	     db	     0EBh,023h,083h,03Eh,0C2h,05Eh,001h,075h,01Eh,08Ah,046h,00Ah,0B4h,000h  ; ovr_1bf4_6216:2916
   	     db	     00Bh,0C0h,075h,015h,056h,08Dh,046h,004h,08Ch,0D2h,0B9h,004h,000h,09Ah  ; ovr_1bf4_6216:2924
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     090h,00Eh,0E8h,081h,000h,08Bh,0F0h,0B8h,011h,000h;	ovr_1bf4_6216:2932

   	     db	     050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,09Ah,063h,026h,089h; ovr_1bf4_6216:2940

   	     db	     075h,007h,080h,07Eh,0FBh,000h,074h,01Ah,026h,080h,04Dh,002h,020h,08Bh  ; ovr_1bf4_6216:294E
   	     db	     046h,0F8h,026h,089h,045h,00Dh,026h,0C7h,045h,00Bh,000h,000h,026h,0C7h  ; ovr_1bf4_6216:295C
   	     db	     045h,009h,000h,000h,0EBh,012h,08Eh,006h,09Ah,063h,08Bh,046h,0FEh,08Bh  ; ovr_1bf4_6216:296A
   	     db	     056h,0FCh,026h,089h,045h,00Bh,026h,089h,055h,009h,080h,07Eh,005h,00Ah  ; ovr_1bf4_6216:2978
   	     db	     075h,009h,08Eh,006h,09Ah,063h,026h,080h,04Dh,002h,040h,08Eh,006h,09Ah  ; ovr_1bf4_6216:2986
   	     db	     063h,026h,0F6h,044h,002h,004h,074h,005h,026h,080h,04Dh,002h,004h,08Eh  ; ovr_1bf4_6216:2994
   	     db	     006h,09Ah,063h,026h,0F6h,044h,002h,008h,074h,005h,026h,080h,04Dh,002h  ; ovr_1bf4_6216:29A2
   	     db	     008h,08Bh,0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,008h,000h; raw:29B0

X010_01 label   far
   	     db	     055h,08Bh;	ovr_1bf4_6216:29B0
   	     db	     0ECh,083h,0ECh,008h,056h,057h,08Bh,07Eh,00Ah,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0C7h,046h,0FEh,000h,000h,0C6h,046h,0FDh,000h,0C6h,046h,0FCh,000h,0C6h  ; ovr_1bf4_6216:29CC
   	     db	     046h,0FBh,000h,080h,03Eh,0A0h,062h,000h,074h,023h,083h,03Eh,0C2h,05Eh  ; ovr_1bf4_6216:29DA
   	     db	     009h,075h,01Ch,09Ah
   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,060h,082h,002h,075h; ovr_1bf4_6216:29E8
   	     db	     010h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0C6h,046h,0FDh; ovr_1bf4_6216:29F6
   	     db	     001h,0EBh,058h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h,075h,012h,083h,03Eh  ; ovr_1bf4_6216:2A04
   	     db	     0C2h,05Eh,002h,075h,00Bh,0C6h,046h,0FCh,001h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0EBh,03Dh,083h,03Eh,0C2h,05Eh,031h,075h,029h,0FFh,036h,08Bh,063h,09Ah  ; ovr_1bf4_6216:2A20
   	     dw	     02Ah
   	     dw	     seg CO03D_TEXT
   	     db	     00Bh,0C0h,075h,01Ch,080h,03Eh,0A0h,062h,000h,074h;	ovr_1bf4_6216:2A2E

   	     db	     009h,0B8h,05Bh,001h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0E8h,017h,0F7h,089h; ovr_1bf4_6216:2A3C
   	     db	     046h,0FEh,0C6h,046h,0FBh,001h,0EBh,00Dh,016h,08Dh,046h,0FEh,050h,016h  ; ovr_1bf4_6216:2A4A
   	     db	     08Dh,046h,0FDh,050h,0E8h,031h,0F8h,083h,03Eh,0C2h,05Eh,003h,075h,016h  ; ovr_1bf4_6216:2A58
   	     db	     0B0h,000h,050h,057h,08Dh,046h,006h,08Ch,0D2h,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0E8h,0C3h,0FDh,0EBh,019h,083h,03Eh,0C2h,05Eh,001h,075h;		    ovr_1bf4_6216:2A66
   	     db	     014h,057h,08Dh,046h,006h,08Ch,0D2h,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh,0E8h,027h,0FFh,08Bh,0F8h,0B8h,012h,000h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,09Ah,063h,026h,089h,07Ch,007h,08Bh,046h;	    ovr_1bf4_6216:2A82
   	     db	     0FEh,026h,089h,044h,009h,08Ah,046h,008h,098h,089h,046h,0F8h,08Ah,046h  ; ovr_1bf4_6216:2AAC
   	     db	     007h,098h,08Bh,0D8h,083h,0FBh,00Bh,077h,045h,0D1h,0E3h,02Eh,0FFh,0A7h  ; ovr_1bf4_6216:2ABA
   	     db	     039h,00Ah,080h,03Eh,0EFh,016h,005h,075h,007h,081h,04Eh,0F8h,003h,000h  ; ovr_1bf4_6216:2AC8
   	     db	     0EBh,030h,080h,03Eh,0D1h,077h,000h,074h,005h,0B8h,001h,000h,0EBh,003h  ; ovr_1bf4_6216:2AD6
   	     db	     0B8h,040h,000h,009h,046h,0F8h,0EBh,01Ch,081h,04Eh,0F8h,040h,000h,0EBh  ; ovr_1bf4_6216:2AE4
   	     db	     00Ch,081h,04Eh,0F8h,001h,000h,0EBh,005h,081h,04Eh,0F8h,003h,000h,08Eh  ; ovr_1bf4_6216:2AF2
   	     db	     006h,09Ah,063h,026h,080h,04Ch,002h,080h,080h,07Eh,006h,000h,074h,005h  ; ovr_1bf4_6216:2B00
   	     db	     08Ah,046h,006h,0EBh,003h,0A0h,0BCh,05Eh,08Eh,006h,09Ah,063h,026h,088h  ; ovr_1bf4_6216:2B0E
   	     db	     044h,00Bh,080h,07Eh,006h,004h,075h,00Ah,081h,066h,0F8h,0BFh,0FFh,081h  ; ovr_1bf4_6216:2B1C
   	     db	     04Eh,0F8h,003h,000h,080h,07Eh,0FCh,000h,074h,005h,081h,04Eh,0F8h,008h  ; ovr_1bf4_6216:2B2A
   	     db	     000h,080h,07Eh,0FBh,000h,074h,009h,08Eh,006h,09Ah,063h,026h,080h,04Ch  ; ovr_1bf4_6216:2B38
   	     db	     002h,040h,080h,07Eh,0FDh,000h,074h,005h,081h,04Eh,0F8h,004h,000h,080h  ; ovr_1bf4_6216:2B46
   	     db	     03Eh,0A0h,062h,000h,074h,02Ah,0EBh,01Ah,083h,03Eh,0C2h,05Eh,04Ah,075h  ; ovr_1bf4_6216:2B54
   	     db	     004h,0B0h,001h,0EBh,002h,0B0h,002h,08Eh,006h,09Ah,063h,026h,008h,044h  ; ovr_1bf4_6216:2B62
   	     db	     002h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh,04Ah,074h,0DFh,083h; ovr_1bf4_6216:2B70

   	     db	     03Eh,0C2h,05Eh,04Bh,074h,0D8h,08Eh,006h,09Ah,063h,08Ah,046h,0F8h,026h  ; ovr_1bf4_6216:2B7E
   	     db	     088h,044h,00Ch,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h,06Ah  ; ovr_1bf4_6216:2B8C
   	     db	     009h,0A8h,009h,0A8h,009h,0A8h,009h,0A8h,009h,0A8h,009h,0A8h,009h,0A8h  ; ovr_1bf4_6216:2B9A
   	     db	     009h,08Ch,009h,093h,009h,09Ah,009h,06Ah,009h,045h,055h,08Bh,0ECh,083h  ; ovr_1bf4_6216:2BA8
   	     db	     0ECh,004h,056h,057h,08Bh,07Eh,006h,08Bh,076h,004h,00Bh,0FFh,075h,005h  ; ovr_1bf4_6216:2BB6
   	     db	     08Bh,0C6h,0E9h,05Eh,002h,056h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,089h; ovr_1bf4_6216:2BC4
   	     db	     07Eh,0FCh,08Eh,006h,09Ah,063h,026h,08Bh,01Dh,083h,0EBh,00Dh,083h,0FBh  ; ovr_1bf4_6216:2BD2
   	     db	     005h,077h,028h,0D1h,0E3h,02Eh,0FFh,0A7h,0DCh,00Ch,08Eh,006h,09Ah,063h  ; ovr_1bf4_6216:2BE0
   	     db	     026h,08Bh,045h,007h,089h,046h,0FEh,026h,080h,065h,00Dh,07Fh,0EBh,014h  ; ovr_1bf4_6216:2BEE
   	     db	     0EBh,000h,08Eh,006h,09Ah,063h,026h,08Bh,045h,007h,089h,046h,0FEh,0EBh  ; ovr_1bf4_6216:2BFC
   	     db	     005h,0C7h,046h,0FEh,000h,000h,083h,07Eh,0FEh,000h,074h,003h,08Bh,07Eh  ; ovr_1bf4_6216:2C0A
   	     db	     0FEh,083h,07Eh,0FEh,000h,075h,0B5h,08Eh,006h,09Ah,063h,026h,08Bh,01Dh  ; ovr_1bf4_6216:2C18
   	     db	     083h,0EBh,00Dh,083h,0FBh,005h,076h,003h,0E9h,0F3h,001h,0D1h,0E3h,02Eh  ; ovr_1bf4_6216:2C26
   	     db	     0FFh,0A7h,0D0h,00Ch,08Eh,006h,09Ah,063h,026h,089h,075h,007h,080h,03Eh  ; ovr_1bf4_6216:2C34
   	     db	     0A0h,062h,000h,074h,007h,026h,083h,07Ch,003h,000h,075h,00Dh,08Eh,006h  ; ovr_1bf4_6216:2C42
   	     db	     09Ah,063h,026h,083h,03Ch,012h,074h,003h,0E9h,0C9h,001h,0B8h,031h,000h  ; ovr_1bf4_6216:2C50
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0E9h,0BDh,001h,08Eh,006h,09Ah,063h,026h; ovr_1bf4_6216:2C5E

   	     db	     089h,075h,007h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,010h,026h  ; ovr_1bf4_6216:2C6C
   	     db	     0F6h,044h,002h,020h,074h,009h,0B8h,024h,001h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     080h,03Eh,0A0h,062h,000h,074h,045h,08Eh,006h,09Ah,063h,026h,083h;	    ovr_1bf4_6216:2C7A
   	     db	     07Dh,00Bh,000h,074h,03Ah,026h,083h,07Ch,003h,000h,075h,02Ah,056h,09Ah  ; ovr_1bf4_6216:2C96
   	     dw	     05Ch
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,09Ah,063h,026h,089h,075h,007h;	ovr_1bf4_6216:2CA4

   	     db	     026h,08Bh,045h,00Bh,026h,089h,044h,003h,026h,083h,03Ch,012h,075h,015h  ; ovr_1bf4_6216:2CB2
   	     db	     026h,0FFh,075h,00Bh,056h,09Ah
   	     dw	     08Eh
   	     dw	     seg CO00F_TEXT
   	     db	     0EBh,009h,0B8h,0BEh; ovr_1bf4_6216:2CC0
   	     db	     000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     080h,03Eh,0A0h,062h,000h,074h,013h; ovr_1bf4_6216:2CCE
   	     db	     08Eh,006h,09Ah,063h,026h,083h,07Ch,003h,000h,074h,008h,026h,0C6h,045h  ; ovr_1bf4_6216:2CDC
   	     db	     00Dh,00Bh,0E9h,035h,001h,08Eh,006h,09Ah,063h,026h,083h,03Ch,012h,074h  ; ovr_1bf4_6216:2CEA
   	     db	     003h,0E9h,028h,001h,026h,0C6h,045h,00Dh,002h,026h,0F6h,045h,002h,080h  ; ovr_1bf4_6216:2CF8
   	     db	     074h,01Bh,026h,08Ah,044h,002h,0B4h,000h,0A9h,080h,000h,074h,003h,0E9h  ; ovr_1bf4_6216:2D06
   	     db	     00Eh,001h,026h,080h,064h,00Ch,0FEh,026h,080h,04Ch,00Ch,040h,0E9h,001h  ; ovr_1bf4_6216:2D14
   	     db	     001h,08Eh,006h,09Ah,063h,026h,0F6h,044h,00Ch,001h,075h,003h,0E9h,0F3h  ; ovr_1bf4_6216:2D22
   	     db	     000h,026h,0C7h,005h,00Fh,000h,0E9h,0EBh,000h,08Eh,006h,09Ah,063h,026h  ; ovr_1bf4_6216:2D30
   	     db	     089h,075h,007h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,010h,026h  ; ovr_1bf4_6216:2D3E
   	     db	     0F6h,044h,002h,020h,074h,009h,0B8h,024h,001h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     080h,03Eh,0A0h,062h,000h,074h,02Ch,08Eh,006h,09Ah,063h,026h,083h;	    ovr_1bf4_6216:2D4C
   	     db	     07Ch,003h,000h,074h,021h,026h,0F6h,045h,002h,080h,074h,009h,0B8h,031h  ; ovr_1bf4_6216:2D68
   	     db	     000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,09Ah,063h,026h,0C6h,045h; ovr_1bf4_6216:2D76
   	     db	     00Dh,00Bh,026h,0C7h,005h,00Dh,000h,0E9h,096h,000h,08Eh,006h,09Ah,063h  ; ovr_1bf4_6216:2D84
   	     db	     026h,083h,03Ch,012h,074h,003h,0E9h,089h,000h,026h,0F6h,045h,002h,080h  ; ovr_1bf4_6216:2D92
   	     db	     074h,017h,026h,08Ah,044h,002h,0B4h,000h,0A9h,080h,000h,075h,077h,026h  ; ovr_1bf4_6216:2DA0
   	     db	     080h,064h,00Ch,0BFh,026h,080h,04Ch,00Ch,001h,0EBh,06Bh,08Eh,006h,09Ah  ; ovr_1bf4_6216:2DAE
   	     db	     063h,026h,0F6h,044h,00Ch,040h,074h,060h,026h,0C7h,005h,00Dh,000h,026h  ; ovr_1bf4_6216:2DBC
   	     db	     0C6h,045h,00Dh,002h,0EBh,054h,08Eh,006h,09Ah,063h,026h,089h,075h,007h  ; ovr_1bf4_6216:2DCA
   	     db	     026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,010h,026h,0F6h,044h,002h  ; ovr_1bf4_6216:2DD8
   	     db	     020h,074h,009h,0B8h,025h,001h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h;	ovr_1bf4_6216:2DE6
   	     db	     09Ah,063h,026h,08Ah,044h,002h,024h,00Ch,026h,008h,045h,002h,057h,09Ah  ; ovr_1bf4_6216:2DF4
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     00Bh,0D2h,07Ch,01Ah,07Fh,005h,03Dh,0FFh,0FFh,076h;	ovr_1bf4_6216:2E02

   	     db	     013h,08Eh,006h,09Ah,063h,026h,080h,04Dh,002h,040h,0EBh,008h,08Eh,006h  ; ovr_1bf4_6216:2E10
   	     db	     09Ah,063h,026h,089h,075h,007h,08Bh,046h,0FCh,05Fh,05Eh,08Bh,0E5h,05Dh  ; ovr_1bf4_6216:2E1E
   	     db	     04Dh,0C2h,004h,000h,007h,00Bh,0D8h,00Ah,0D9h,00Bh,0D9h,00Bh,070h,00Ch  ; ovr_1bf4_6216:2E2C
   	     db	     0BCh,00Ch,08Ah,00Ah,08Ah,00Ah,08Ah,00Ah,08Ah,00Ah,09Ch,00Ah,09Eh,00Ah  ; ovr_1bf4_6216:2E3A
X010_07 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ah,08Dh,046h,0FCh,016h,050h,08Dh,046h,006h; ovr_1bf4_6216:2E48
   	     db	     016h,050h,0B9h,003h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     033h,0C0h,089h,046h; ovr_1bf4_6216:2E56
   	     db	     0FAh,089h,046h,0F8h,089h,046h,0F6h,08Bh,01Eh,0C2h,05Eh,083h,0EBh,046h  ; ovr_1bf4_6216:2E64
   	     db	     083h,0FBh,010h,077h,06Ch,0D1h,0E3h,02Eh,0FFh,0A7h,027h,00Eh,0C7h,046h  ; ovr_1bf4_6216:2E72
   	     db	     0F8h,001h,000h,0E9h,090h,000h,0C7h,046h,0F8h,002h,000h,0E9h,088h,000h  ; ovr_1bf4_6216:2E80
   	     db	     0C7h,046h,0F8h,004h,000h,0E9h,080h,000h,0C7h,046h,0F6h,002h,000h,0EBh  ; ovr_1bf4_6216:2E8E
   	     db	     079h,0C7h,046h,0F6h,080h,000h,0EBh,072h,0C7h,046h,0F6h,010h,000h,0EBh  ; ovr_1bf4_6216:2E9C
   	     db	     06Bh,0C7h,046h,0FAh,002h,000h,0EBh,064h,0C7h,046h,0FAh,004h,000h,0EBh  ; ovr_1bf4_6216:2EAA
   	     db	     05Dh,0C7h,046h,0FAh,001h,000h,0EBh,056h,0C7h,046h,0FAh,003h,000h,0EBh  ; ovr_1bf4_6216:2EB8
   	     db	     04Fh,0C7h,046h,0FAh,007h,000h,0EBh,048h,0C7h,046h,0FAh,008h,000h,0EBh  ; ovr_1bf4_6216:2EC6
   	     db	     041h,0C7h,046h,0FAh,009h,000h,0EBh,03Ah,0C7h,046h,0FAh,00Ah,000h,0EBh  ; ovr_1bf4_6216:2ED4
   	     db	     033h,080h,07Eh,0FCh,000h,074h,015h,080h,07Eh,0FDh,003h,07Fh,00Fh,080h  ; ovr_1bf4_6216:2EE2
   	     db	     07Eh,0FDh,002h,07Ch,009h,0B8h,031h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0FFh,076h,00Ch,0FFh,076h,00Ah,08Dh,046h,0FCh,016h,050h,0B9h,003h,000h  ; ovr_1bf4_6216:2EFE
   	     db	     09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,046h,00Ah,0EBh,06Bh,08Ah,046h,0FEh,098h; ovr_1bf4_6216:2F0C

   	     db	     085h,046h,0F6h,074h,009h,0B8h,031h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Ah,046h,0F6h,008h,046h,0FEh,083h,07Eh,0F8h,000h,074h,02Ah,080h,07Eh  ; ovr_1bf4_6216:2F28
   	     db	     0FCh,000h,074h,009h,0B8h,031h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     083h; ovr_1bf4_6216:2F36
   	     db	     07Eh,0F8h,004h,075h,00Fh,080h,07Eh,0FDh,008h,075h,009h,0B8h,031h,000h  ; ovr_1bf4_6216:2F44
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Ah,046h,0F8h,088h,046h,0FCh,083h,07Eh; ovr_1bf4_6216:2F52

   	     db	     0FAh,000h,074h,015h,080h,07Eh,0FDh,000h,074h,009h,0B8h,031h,000h,050h  ; ovr_1bf4_6216:2F60
   	     db	     09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Ah,046h,0FAh,088h,046h,0FDh,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0E9h,0DFh,0FEh,08Bh,0E5h,05Dh,0CAh,008h,000h,02Eh,00Dh,026h;	    ovr_1bf4_6216:2F6E
   	     db	     00Dh,01Eh,00Dh,083h,00Dh,083h,00Dh,083h,00Dh,036h,00Dh,044h,00Dh,03Dh  ; ovr_1bf4_6216:2F8A
   	     db	     00Dh,06Eh,00Dh,075h,00Dh,04Bh,00Dh,052h,00Dh,059h,00Dh,060h,00Dh,067h  ; ovr_1bf4_6216:2F98
   	     db	     00Dh,07Ch,00Dh; raw:2FA6
X010_06 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,01Ch,056h,057h,08Bh,07Eh,01Eh;		    ovr_1bf4_6216:2FA6
   	     db	     08Bh,076h,020h,0C4h,05Eh,012h,026h,0C7h,007h,000h,000h,0C7h,046h,0FEh  ; ovr_1bf4_6216:2FB4
   	     db	     000h,000h,0C4h,05Eh,00Eh,026h,0C7h,007h,000h,000h,0C4h,05Eh,016h,026h  ; ovr_1bf4_6216:2FC2
   	     db	     0C7h,007h,000h,000h,08Dh,046h,0F8h,016h,050h,0FFh,076h,00Ch,0FFh,076h  ; ovr_1bf4_6216:2FD0
   	     db	     00Ah,0B9h,003h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Dh,046h,0F0h,016h,050h; ovr_1bf4_6216:2FDE
   	     db	     0B8h,0CEh,063h,01Eh,050h,0B9h,003h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     080h; ovr_1bf4_6216:2FEC
   	     db	     03Eh,0A0h,062h,000h,074h,044h,056h,057h,0FFh,076h,010h,0FFh,076h,00Eh  ; ovr_1bf4_6216:2FFA
   	     db	     016h,08Dh,046h,0F8h,050h,0FFh,076h,008h,0FFh,076h,006h,09Ah

   	     dw	     048h
   	     dw	     seg CO03F_TEXT
   	     db	     08Bh,0F0h,083h,0FFh,006h,074h,003h,0E9h,09Eh,000h,056h,09Ah;	    ovr_1bf4_6216:3008
   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     0C4h,05Eh,01Ah,026h,089h,007h,0FFh,076h,00Ch,0FFh;	ovr_1bf4_6216:3024

   	     db	     076h,00Ah,08Dh,046h,0F8h,016h,050h,0B9h,003h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0E9h,069h,003h,08Dh,046h,0F8h,016h,050h,016h,08Dh,046h,0E8h,050h;	    ovr_1bf4_6216:3032
   	     db	     08Dh,046h,0F8h,08Ch,0D2h,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh; ovr_1bf4_6216:304E
   	     db	     0E8h,0E9h,0FDh,08Dh,046h,0E8h,016h,050h,0B9h,003h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Dh,046h,0ECh,016h,050h,08Dh,046h,0F8h,0EBh,032h,056h,08Dh;	    ovr_1bf4_6216:305C
   	     db	     046h,0ECh,08Ch,0D2h,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh,0E8h;	ovr_1bf4_6216:3078
   	     db	     0A6h,0F5h,08Bh,0F0h,08Dh,046h,0ECh,016h,050h,016h,08Dh,046h,0E4h,050h  ; ovr_1bf4_6216:3086
   	     db	     0B8h,0CEh,063h,08Ch,0DAh,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh; ovr_1bf4_6216:3094
   	     db	     0E8h,0A3h,0FDh,08Dh,046h,0E4h,016h,050h,0B9h,003h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     083h,03Eh,0C2h,05Eh,018h,074h,0BDh,083h,03Eh,0C2h,05Eh,01Bh;	    ovr_1bf4_6216:30A2
   	     db	     074h,0B6h,08Dh,046h,0F4h,016h,050h,08Dh,046h,0F8h,016h,050h,0B9h,003h  ; ovr_1bf4_6216:30BE
   	     db	     000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Dh,046h,0F0h,016h,050h,08Dh,046h,0F8h; ovr_1bf4_6216:30CC

   	     db	     016h,050h,0B9h,003h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     083h,03Eh,0C2h,05Eh; ovr_1bf4_6216:30DA
   	     db	     031h,075h,027h,00Bh,0FFh,074h,00Ah,083h,0FFh,002h,074h,005h,083h,0FFh  ; ovr_1bf4_6216:30E8
   	     db	     001h,075h,019h,0C4h,05Eh,016h,0A1h,08Bh,063h,026h,089h,007h,0C4h,05Eh  ; ovr_1bf4_6216:30F6
   	     db	     012h,026h,0C7h,007h,000h,000h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0E9h,024h,001h; ovr_1bf4_6216:3104
   	     db	     080h,03Eh,0A0h,062h,000h,074h,031h,083h,03Eh,0C2h,05Eh,06Dh,074h,007h  ; ovr_1bf4_6216:3112
   	     db	     083h,03Eh,0C2h,05Eh,02Bh,075h,023h,056h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     050h; ovr_1bf4_6216:3120
   	     db	     0C4h,05Eh,00Eh,026h,0FFh,037h,0FFh,076h,018h,0FFh,076h,016h,0FFh,076h  ; ovr_1bf4_6216:312E
   	     db	     014h,0FFh,076h,012h,09Ah
   	     dw	     057h
   	     dw	     seg CO03F_TEXT
   	     db	     08Bh,0F0h,0E9h,0ECh,000h; ovr_1bf4_6216:313C
   	     db	     083h,03Eh,0C2h,05Eh,001h,074h,003h,0E9h,0E2h,000h,083h,0FFh,004h,075h  ; ovr_1bf4_6216:314A
   	     db	     003h,0E9h,0DAh,000h,09Ah
   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     08Bh,01Eh,060h,082h,0D1h; ovr_1bf4_6216:3158
   	     db	     0E3h,0F7h,087h,0B3h,007h,010h,000h,075h,003h,0E9h,0C4h,000h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     033h,0C0h,050h,057h,016h,08Dh,046h,0FEh,050h,0FFh,076h;		    ovr_1bf4_6216:3166
   	     db	     018h,0FFh,076h,016h,0FFh,076h,014h,0FFh,076h,012h,0FFh,076h,010h,0FFh  ; ovr_1bf4_6216:3182
   	     db	     076h,00Eh,016h,08Dh,046h,0F4h,050h,016h,08Dh,046h,0F0h,050h,00Eh,0E8h  ; ovr_1bf4_6216:3190
   	     db	     009h,0FEh,083h,07Eh,0FEh,000h,075h,06Fh,080h,07Eh,0F5h,000h,074h,01Fh  ; ovr_1bf4_6216:319E
   	     db	     080h,07Eh,0F9h,000h,074h,013h,08Ah,046h,0F9h,03Ah,046h,0F5h,074h,00Bh  ; ovr_1bf4_6216:31AC
   	     db	     0B8h,031h,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,006h,08Ah,046h,0F5h; ovr_1bf4_6216:31BA
   	     db	     088h,046h,0F9h,080h,07Eh,0F4h,000h,074h,01Fh,080h,07Eh,0F8h,000h,074h  ; ovr_1bf4_6216:31C8
   	     db	     013h,08Ah,046h,0F8h,03Ah,046h,0F4h,074h,00Bh,0B8h,031h,000h,050h,09Ah  ; ovr_1bf4_6216:31D6
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,006h,08Ah,046h,0F4h,088h,046h,0F8h,080h,07Eh;	ovr_1bf4_6216:31E4

   	     db	     0F6h,000h,074h,01Fh,080h,07Eh,0FAh,000h,074h,013h,08Ah,046h,0F6h,03Ah  ; ovr_1bf4_6216:31F2
   	     db	     046h,0FAh,074h,00Bh,0B8h,031h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh; ovr_1bf4_6216:3200
   	     db	     006h,08Ah,046h,0F6h,088h,046h,0FAh,083h,03Eh,0C2h,05Eh,002h,075h,003h  ; ovr_1bf4_6216:320E
   	     db	     0E9h,0EBh,0FEh,0B8h,0E9h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h;	ovr_1bf4_6216:321C
   	     db	     078h,064h,001h,0B8h,002h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO019_TEXT
   	     db	     083h,03Eh;	ovr_1bf4_6216:322A
   	     db	     0C2h,05Eh,003h,075h,03Ch,083h,0FFh,004h,074h,005h,083h,0FFh,005h,075h  ; ovr_1bf4_6216:3238
   	     db	     005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,050h,056h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     050h,08Dh,046h,0F8h,08Ch,0D2h,0B9h,004h,000h,09Ah

   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0E8h,0D7h,0F5h,089h,046h,0FCh,080h,07Eh,0F9h,00Ah,074h,003h,0E9h;	    ovr_1bf4_6216:3246
   	     db	     0A8h,000h,0C6h,046h,0F5h,000h,0E9h,0A1h,000h,083h,03Eh,0C2h,05Eh,001h  ; ovr_1bf4_6216:3270
   	     db	     074h,003h,0E9h,094h,000h,0C6h,046h,0FBh,000h,080h,03Eh,0A0h,062h,000h  ; ovr_1bf4_6216:327E
   	     db	     074h,072h,083h,0FFh,004h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h  ; ovr_1bf4_6216:328C
   	     db	     088h,046h,0FBh,00Bh,0FFh,075h,038h,08Eh,006h,09Ah,063h,08Bh,05Eh,020h  ; ovr_1bf4_6216:329A
   	     db	     026h,08Bh,01Fh,0F6h,087h,0CAh,009h,040h,074h,027h,0C4h,05Eh,016h,026h  ; ovr_1bf4_6216:32A8
   	     db	     083h,03Fh,000h,074h,019h,0C4h,05Eh,012h,026h,083h,03Fh,000h,075h,010h  ; ovr_1bf4_6216:32B6
   	     db	     09Ah
   	     dw	     04Dh
   	     dw	     seg CO03F_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,005h,0B8h,001h,000h; ovr_1bf4_6216:32C4

   	     db	     0EBh,002h,033h,0C0h,088h,046h,0FBh,080h,07Eh,0FBh,000h,074h,004h,08Bh  ; ovr_1bf4_6216:32D2
   	     db	     0C6h,0EBh,018h,056h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     050h,08Dh,046h,0F0h,08Ch; ovr_1bf4_6216:32E0
   	     db	     0D2h,0B9h,004h,000h,09Ah
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh,0E8h,0C1h,0F6h,089h; ovr_1bf4_6216:32EE
   	     db	     046h,0FCh,0EBh,01Ah,056h,08Dh,046h,0F0h,08Ch,0D2h,0B9h,004h,000h,09Ah  ; ovr_1bf4_6216:32FC
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     00Eh,0E8h,0AAh,0F6h,089h,046h,0FCh,0EBh,003h,089h;	ovr_1bf4_6216:330A

   	     db	     076h,0FCh,0FFh,076h,0FEh,0FFh,076h,0FCh,0E8h,08Eh,0F8h,050h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO02C_TEXT
   	     db	     0C4h,05Eh,01Ah,026h,089h,007h,0FFh,076h,00Ch,0FFh,076h;		    ovr_1bf4_6216:3318
   	     db	     00Ah,08Dh,046h,0F8h,016h,050h,0B9h,003h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0C4h,05Eh,01Ah,026h,08Bh,01Fh,08Eh,006h,09Ah,063h,026h,083h,03Fh,011h  ; ovr_1bf4_6216:3342
   	     db	     075h,05Bh,0C4h,05Eh,01Ah,026h,08Bh,007h,03Bh,046h,020h,074h,050h,026h  ; ovr_1bf4_6216:3350
   	     db	     08Bh,01Fh,08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,040h,074h,023h,0C4h  ; ovr_1bf4_6216:335E
   	     db	     05Eh,01Ah,026h,0FFh,037h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     081h,0FAh,0FFh,000h; ovr_1bf4_6216:336C
   	     db	     07Ch,031h,07Fh,005h,03Dh,0FFh,0FFh,076h,02Ah,0B8h,00Ch,000h,050h,09Ah  ; ovr_1bf4_6216:337A
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,01Fh,0C4h,05Eh,01Ah,026h,0FFh,037h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     00Bh,0D2h,07Ch,010h,07Fh,005h,03Dh,0FFh,0FFh,076h,009h;		    ovr_1bf4_6216:3388
   	     db	     0B8h,00Ch,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh; ovr_1bf4_6216:33A4
   	     db	     0CAh,01Ch,000h; raw:33B2
X010_03 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,083h,07Eh,008h;		    ovr_1bf4_6216:33B2
   	     db	     043h,075h,005h,0B8h,014h,000h,0EBh,003h,0B8h,013h,000h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,080h,03Eh,0A0h,062h,000h,074h,061h,083h,07Eh;		    ovr_1bf4_6216:33C0
   	     db	     008h,068h,075h,012h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h  ; ovr_1bf4_6216:33DC
   	     db	     03Eh,05Fh,026h,081h,04Fh,018h,020h,000h,083h,0FFh,04Fh,075h,014h,08Eh  ; ovr_1bf4_6216:33EA
   	     db	     006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh,026h,081h,04Fh  ; ovr_1bf4_6216:33F8
   	     db	     018h,010h,000h,0EBh,030h,083h,0FFh,050h,075h,014h,08Eh,006h,09Ah,063h  ; ovr_1bf4_6216:3406
   	     db	     026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh,026h,081h,04Fh,018h,008h,000h  ; ovr_1bf4_6216:3414
   	     db	     0EBh,017h,083h,0FFh,056h,075h,012h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch  ; ovr_1bf4_6216:3422
   	     db	     005h,08Eh,006h,03Eh,05Fh,026h,081h,04Fh,018h,000h,001h,083h,03Eh,02Eh  ; ovr_1bf4_6216:3430
   	     db	     05Fh,000h,074h,017h,0B8h,082h,001h,050h,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     08Bh; ovr_1bf4_6216:344C
   	     db	     0C6h,05Fh,05Eh,05Dh,0CAh,004h,000h,045h,055h,08Bh,0ECh,04Ch,04Ch,056h  ; ovr_1bf4_6216:345A
   	     db	     057h,08Bh,07Eh,006h,0FFh,076h,004h,0B8h,001h,000h,050h,09Ah

   	     dw	     0B6h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,010h,064h,026h,089h,07Ch,004h,00Bh,0FFh;	    ovr_1bf4_6216:3468
   	     db	     074h,010h,08Eh,006h,09Ah,063h,026h,08Bh,05Dh,005h,08Eh,006h,03Eh,05Fh  ; ovr_1bf4_6216:3484
   	     db	     026h,089h,077h,006h,08Eh,006h,010h,064h,026h,08Ah,044h,007h,024h,007h  ; ovr_1bf4_6216:3492
   	     db	     00Ch,040h,026h,088h,044h,007h,026h,08Ah,044h,007h,024h,0F8h,00Ch,002h  ; ovr_1bf4_6216:34A0
   	     db	     026h,088h,044h,007h,0A1h,006h,062h,089h,046h,0FEh,08Eh,006h,032h,078h  ; ovr_1bf4_6216:34AE
   	     db	     08Bh,05Eh,0FEh,026h,08Bh,007h,08Eh,006h,010h,064h,026h,089h,004h,08Eh  ; ovr_1bf4_6216:34BC
   	     db	     006h,032h,078h,026h,089h,037h,0B0h,001h,050h,09Ah

   	     dw	     0D4h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,004h,000h,045h,055h,08Bh  ; ovr_1bf4_6216:34D8
   	     db	     0ECh,083h,0ECh,004h,056h,057h,033h,0FFh,0C7h,046h,0FEh,000h,000h,0C4h  ; ovr_1bf4_6216:34E6
   	     db	     05Eh,004h,026h,0C6h,007h,001h,083h,03Eh,0C2h,05Eh,031h,075h,00Bh,0A1h  ; ovr_1bf4_6216:34F4
   	     db	     08Bh,063h,089h,046h,0FEh,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,07Eh,0FEh,000h; ovr_1bf4_6216:3502
   	     db	     074h,026h,080h,07Eh,008h,000h,074h,016h,0FFh,076h,0FEh,08Bh,01Eh,098h  ; ovr_1bf4_6216:3510
   	     db	     063h,08Eh,006h,02Ah,078h,026h,0FFh,077h,006h,09Ah

   	     dw	     07Fh
   	     dw	     seg CO02C_TEXT
   	     db	     0EBh,008h,0FFh,076h,0FEh,09Ah
   	     dw	     039h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h,00Bh,0FFh; ovr_1bf4_6216:352C
   	     db	     075h,003h,0E9h,0F4h,000h,08Eh,006h,010h,064h,026h,08Bh,075h,004h,08Eh  ; ovr_1bf4_6216:353A
   	     db	     006h,09Ah,063h,026h,08Bh,01Ch,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h  ; ovr_1bf4_6216:3548
   	     db	     000h,075h,020h,0B8h,0F0h,000h,050h,0FFh,076h,0FEh,09Ah

   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     0FFh,076h,00Ch,0FFh,076h,00Ah,00Eh,0E8h,046h,0FEh,050h,0FFh,076h;	    ovr_1bf4_6216:3556
   	     db	     0FEh,0E8h,0EBh,0FEh,0E9h,05Ch,001h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch  ; ovr_1bf4_6216:3572
   	     db	     005h,08Eh,006h,03Eh,05Fh,026h,083h,07Fh,004h,000h,074h,02Bh,080h,07Eh  ; ovr_1bf4_6216:3580
   	     db	     008h,000h,074h,025h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h,074h,007h,083h  ; ovr_1bf4_6216:358E
   	     db	     03Eh,0C2h,05Eh,007h,074h,015h,0B8h,0ADh,000h,050h,0FFh,076h,0FEh,09Ah  ; ovr_1bf4_6216:359C
   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     0C4h,05Eh,004h,026h,0C6h,007h,000h,0EBh,0AEh,080h;	ovr_1bf4_6216:35AA

   	     db	     03Eh,0A0h,062h,000h,074h,072h,083h,07Eh,00Ch,068h,075h,012h,08Eh,006h  ; ovr_1bf4_6216:35B8
   	     db	     09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh,026h,081h,04Fh,018h  ; ovr_1bf4_6216:35C6
   	     db	     020h,000h,083h,07Eh,00Ah,04Fh,075h,014h,08Eh,006h,09Ah,063h,026h,08Bh  ; ovr_1bf4_6216:35D4
   	     db	     05Ch,005h,08Eh,006h,03Eh,05Fh,026h,0F7h,047h,018h,008h,001h,075h,034h  ; ovr_1bf4_6216:35E2
   	     db	     083h,07Eh,00Ah,050h,075h,014h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h  ; ovr_1bf4_6216:35F0
   	     db	     08Eh,006h,03Eh,05Fh,026h,0F7h,047h,018h,010h,001h,075h,01Ah,083h,07Eh  ; ovr_1bf4_6216:35FE
   	     db	     00Ah,056h,075h,020h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h  ; ovr_1bf4_6216:360C
   	     db	     03Eh,05Fh,026h,0F7h,047h,018h,018h,000h,074h,00Ch,0B8h,031h,000h,050h  ; ovr_1bf4_6216:361A
   	     db	     09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0E9h,0A3h,000h,0E9h,0A0h,000h,0FFh,076h,00Ch; ovr_1bf4_6216:3628

   	     db	     0FFh,076h,00Ah,00Eh,0E8h,078h,0FDh,08Bh,0F0h,083h,07Eh,0FEh,000h,074h  ; ovr_1bf4_6216:3636
   	     db	     030h,0FFh,076h,0FEh,09Ah
   	     dw	     098h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,010h; ovr_1bf4_6216:3644
   	     db	     064h,026h,08Ah,045h,007h,024h,007h,00Ch,058h,026h,088h,045h,007h,026h  ; ovr_1bf4_6216:3652
   	     db	     089h,075h,004h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h,03Eh  ; ovr_1bf4_6216:3660
   	     db	     05Fh,026h,089h,07Fh,006h,0EBh,009h,056h,033h,0C0h,050h,0E8h,0E5h,0FDh  ; ovr_1bf4_6216:366E
   	     db	     08Bh,0F8h,080h,03Eh,0A0h,062h,000h,074h,04Eh,083h,07Eh,0FEh,000h,074h  ; ovr_1bf4_6216:367C
   	     db	     048h,0FFh,076h,0FEh,08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,0FFh  ; ovr_1bf4_6216:368A
   	     db	     077h,004h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO02C_TEXT
   	     db	     089h,046h,0FCh,083h,07Eh,0FCh,000h; ovr_1bf4_6216:3698
   	     db	     074h,02Bh,08Bh,05Eh,0FCh,08Eh,006h,010h,064h,026h,08Ah,047h,007h,0B4h  ; ovr_1bf4_6216:36A6
   	     db	     000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,008h,000h,075h,013h,026h,039h  ; ovr_1bf4_6216:36B4
   	     db	     077h,004h,074h,00Dh,0B8h,051h,001h,050h,026h,0FFh,077h,002h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     08Bh,0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,00Ah,000h;		    ovr_1bf4_6216:36C2
   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,03Ah,056h,057h,0BFh,082h,000h,0C6h,046h  ; ovr_1bf4_6216:36DE
   	     db	     0F9h,000h,0A1h,044h,086h,089h,046h,0F2h,0EBh,039h,083h,03Eh,0C2h,05Eh  ; ovr_1bf4_6216:36EC
   	     db	     04Fh,074h,00Eh,083h,03Eh,0C2h,05Eh,050h,074h,007h,083h,03Eh,0C2h,05Eh  ; ovr_1bf4_6216:36FA
   	     db	     056h,075h,006h,08Bh,03Eh,0C2h,05Eh,0EBh,007h,0C6h,046h,0F9h,001h,0BFh  ; ovr_1bf4_6216:3708
   	     db	     056h,000h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h,075h,009h,0B8h,031h,000h  ; ovr_1bf4_6216:3716
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h; ovr_1bf4_6216:3724
   	     db	     05Eh,04Fh,074h,0C0h,083h,03Eh,0C2h,05Eh,050h,074h,0B9h,083h,03Eh,0C2h  ; ovr_1bf4_6216:3732
   	     db	     05Eh,056h,074h,0B2h,083h,03Eh,0C2h,05Eh,04Eh,074h,0ABh,083h,03Eh,0C2h  ; ovr_1bf4_6216:3740
   	     db	     05Eh,031h,075h,00Ah,09Ah
   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     0A1h,060h,082h,0EBh,003h; ovr_1bf4_6216:374E
   	     db	     0A1h,0C2h,05Eh,089h,046h,0FEh,083h,07Eh,0FEh,005h,074h,00Dh,080h,03Eh  ; ovr_1bf4_6216:375C
   	     db	     0A0h,062h,000h,074h,00Bh,083h,07Eh,0FEh,021h,075h,005h,0B8h,001h,000h  ; ovr_1bf4_6216:376A
   	     db	     0EBh,002h,033h,0C0h,088h,046h,0FDh,0FFh,076h,006h,057h,080h,07Eh,0FDh  ; ovr_1bf4_6216:3778
   	     db	     000h,075h,00Ch,083h,07Eh,0FEh,007h,075h,00Bh,080h,07Eh,004h,000h,074h  ; ovr_1bf4_6216:3786
   	     db	     005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,050h,016h,08Dh,046h,0FCh,050h  ; ovr_1bf4_6216:3794
   	     db	     0E8h,03Eh,0FDh,08Bh,0F0h,08Ah,046h,0FDh,0B4h,000h,00Bh,0C0h,075h,00Bh  ; ovr_1bf4_6216:37A2
   	     db	     08Eh,006h,010h,064h,026h,08Bh,044h,004h,0E9h,025h,001h,0A1h,0DCh,05Eh  ; ovr_1bf4_6216:37B0
   	     db	     089h,046h,0F4h,0C7h,006h,0DCh,05Eh,000h,000h,0A1h,0DAh,05Eh,0FFh,006h  ; ovr_1bf4_6216:37BE
   	     db	     0DAh,05Eh,00Bh,0C0h,074h,012h,08Dh,046h,0C6h,016h,050h,0B8h,0E8h,062h  ; ovr_1bf4_6216:37CC
   	     db	     01Eh,050h,0B9h,02Ch,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,036h,0EAh,062h; ovr_1bf4_6216:37DA
   	     db	     08Eh,006h,010h,064h,026h,08Bh,044h,004h,0A3h,0E8h,062h,0A1h,038h,064h  ; ovr_1bf4_6216:37E8
   	     db	     089h,046h,0F6h,0A1h,0E8h,062h,0A3h,038h,064h,08Bh,046h,006h,0A3h,0F2h  ; ovr_1bf4_6216:37F6
   	     db	     062h,089h,03Eh,00Dh,063h,0C7h,006h,0EEh,062h,000h,000h,0C7h,006h,0ECh  ; ovr_1bf4_6216:3804
   	     db	     062h,000h,000h,0C7h,006h,0F0h,062h,000h,000h,08Ah,046h,0F9h,0A2h,013h  ; ovr_1bf4_6216:3812
   	     db	     063h,080h,03Eh,0A0h,062h,000h,074h,005h,09Ah

   	     dw	     075h
   	     dw	     seg CO03F_TEXT
   	     db	     083h; ovr_1bf4_6216:3820
   	     db	     03Eh,0C2h,05Eh,005h,074h,006h,0A1h,0E8h,062h,0E9h,0A6h,000h,08Ah,046h  ; ovr_1bf4_6216:382E
   	     db	     0FCh,0B4h,000h,00Bh,0C0h,075h,00Ch,09Ah

   	     dw	     025h
   	     dw	     seg CO019_TEXT
   	     db	     0C6h,006h;	ovr_1bf4_6216:383C
   	     db	     078h,064h,000h,0EBh,041h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0A0h,0A0h,062h,0B4h; ovr_1bf4_6216:384A
   	     db	     000h,00Bh,0C0h,075h,019h,0A0h,0CCh,05Eh,0B4h,000h,00Bh,0C0h,075h,010h  ; ovr_1bf4_6216:3858
   	     db	     083h,03Eh,0C2h,05Eh,006h,075h,009h,0B8h,0CDh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     020h
   	     dw	     seg CO040_TEXT
   	     db	     080h,03Eh,0A0h,062h,000h,074h,00Eh; ovr_1bf4_6216:3866
   	     db	     08Bh,046h,0F2h,03Bh,006h,044h,086h,075h,005h,09Ah

   	     dw	     020h
   	     dw	     seg CO00C_TEXT
   	     db	     0A1h,0E8h,062h,089h,046h,0FAh,08Bh,046h,0F2h,03Bh,006h,044h,086h,074h  ; ovr_1bf4_6216:3890
   	     db	     015h,08Bh,05Eh,0FAh,08Eh,006h,09Ah,063h,026h,08Bh,05Fh,005h,08Eh,006h  ; ovr_1bf4_6216:389E
   	     db	     03Eh,05Fh,026h,081h,04Fh,018h,000h,002h,0FFh,00Eh,0DAh,05Eh,0A1h,0DAh  ; ovr_1bf4_6216:38AC
   	     db	     05Eh,00Bh,0C0h,074h,012h,0B8h,0E8h,062h,01Eh,050h,08Dh,046h,0C6h,016h  ; ovr_1bf4_6216:38BA
   	     db	     050h,0B9h,02Ch,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,046h,0F6h,0A3h,038h; ovr_1bf4_6216:38C8
   	     db	     064h,08Bh,046h,0F4h,0A3h,0DCh,05Eh,08Bh,046h,0FAh,05Fh,05Eh,08Bh,0E5h  ; ovr_1bf4_6216:38D6
   	     db	     05Dh,04Dh,0C2h,004h,000h,045h,055h,08Bh,0ECh,083h,0ECh,016h,056h,057h  ; ovr_1bf4_6216:38E4
   	     db	     0C6h,046h,0FFh,000h,083h,03Eh,0C2h,05Eh,031h,075h,01Bh,08Dh,046h,0EAh  ; ovr_1bf4_6216:38F2
   	     db	     016h,050h,0B8h,082h,063h,01Eh,050h,0B9h,013h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0C6h,046h,0FFh,001h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,0C2h,05Eh; ovr_1bf4_6216:3900
   	     db	     005h,075h,038h,0A0h,0DAh,05Eh,0A2h,000h,064h,016h,08Dh,046h,0EAh,050h  ; ovr_1bf4_6216:391C
   	     db	     08Ah,046h,0FFh,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO040_TEXT
   	     db	     08Bh,0F8h,083h,03Eh,02Eh; ovr_1bf4_6216:392A
   	     db	     05Fh,000h,074h,017h,0B8h,082h,001h,050h,057h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     08Bh; ovr_1bf4_6216:3946
   	     db	     0C7h,0EBh,055h,080h,07Eh,0FFh,000h,074h,044h,0FFh,076h,0F3h,09Ah

   	     dw	     039h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h,00Bh,0F6h,075h,010h,016h,08Dh,046h,0EAh,050h;		    ovr_1bf4_6216:3954
   	     db	     0B8h,05Ah,000h,050h,09Ah
   	     dw	     034h
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,02Fh,08Eh,006h,010h; ovr_1bf4_6216:3970
   	     db	     064h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,083h,03Fh,015h,075h  ; ovr_1bf4_6216:397E
   	     db	     00Ah,08Eh,006h,010h,064h,026h,08Bh,044h,004h,0EBh,015h,016h,08Dh,046h  ; ovr_1bf4_6216:398C
   	     db	     0EAh,050h,0B8h,0CEh,000h,0EBh,0D2h,0B8h,0D4h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     033h,0C0h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h; ovr_1bf4_6216:399A

X010_05 label   far
   	     db	     055h,08Bh,0ECh; ovr_1bf4_6216:39A8
   	     db	     083h,0ECh,004h,056h,057h,08Bh,076h,00Ah,08Eh,006h,09Ah,063h,026h,08Ah  ; ovr_1bf4_6216:39B6
   	     db	     044h,002h,0B4h,000h,025h,003h,000h,08Bh,0F8h,080h,07Eh,008h,000h,074h  ; ovr_1bf4_6216:39C4
   	     db	     004h,081h,0CFh,002h,000h,080h,07Eh,006h,000h,074h,004h,081h,0CFh,001h  ; ovr_1bf4_6216:39D2
   	     db	     000h,08Eh,006h,09Ah,063h,026h,08Ah,044h,002h,0B4h,000h,025h,003h,000h  ; ovr_1bf4_6216:39E0
   	     db	     03Bh,0C7h,075h,004h,08Bh,0C6h,0EBh,056h,08Eh,006h,09Ah,063h,026h,083h  ; ovr_1bf4_6216:39EE
   	     db	     03Ch,00Ch,07Fh,045h,0F7h,0C7h,002h,000h,074h,004h,033h,0C0h,0EBh,003h  ; ovr_1bf4_6216:39FC
   	     db	     0B8h,001h,000h,089h,046h,0FEh,0F7h,0C7h,001h,000h,074h,004h,033h,0C0h  ; ovr_1bf4_6216:3A0A
   	     db	     0EBh,003h,0B8h,001h,000h,089h,046h,0FCh,08Bh,046h,0FEh,0BAh,034h,000h  ; ovr_1bf4_6216:3A18
   	     db	     0F7h,0EAh,050h,08Bh,046h,0FCh,0BAh,01Ah,000h,0F7h,0EAh,05Bh,003h,0D8h  ; ovr_1bf4_6216:3A26
   	     db	     08Eh,006h,09Ah,063h,026h,08Bh,004h,0D1h,0E0h,003h,0D8h,08Bh,087h,014h  ; ovr_1bf4_6216:3A34
   	     db	     063h,0EBh,007h,056h,057h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO02C_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h; ovr_1bf4_6216:3A42
   	     db	     05Dh,0CAh,006h,000h; raw:3A50
X010_02 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h,08Eh,006h,09Ah;	ovr_1bf4_6216:3A50

   	     db	     063h,026h,08Ah,044h,002h,0B4h,000h,0A9h,003h,000h,075h,004h,08Bh,0C6h  ; ovr_1bf4_6216:3A5E
   	     db	     0EBh,01Eh,08Eh,006h,09Ah,063h,026h,083h,03Ch,00Ch,07Fh,00Bh,026h,08Bh  ; ovr_1bf4_6216:3A6C
   	     db	     01Ch,0D1h,0E3h,08Bh,087h,062h,063h,0EBh,009h,056h,033h,0C0h,050h,09Ah  ; ovr_1bf4_6216:3A7A
   	     dw	     0C0h
   	     dw	     seg CO02C_TEXT
   	     db	     05Eh,05Dh,0CAh,002h,000h,045h,055h,08Bh,0ECh,04Ch;	ovr_1bf4_6216:3A88

   	     db	     04Ch,0C4h,05Eh,008h,026h,08Bh,007h,03Bh,006h,0C2h,05Eh,074h,014h,026h  ; ovr_1bf4_6216:3A96
   	     db	     08Bh,047h,002h,03Bh,006h,0C2h,05Eh,074h,00Ah,026h,08Bh,047h,004h,03Bh  ; ovr_1bf4_6216:3AA4
   	     db	     006h,0C2h,05Eh,075h,02Fh,083h,03Eh,0C2h,05Eh,042h,074h,023h,083h,03Eh  ; ovr_1bf4_6216:3AB2
   	     db	     0C2h,05Eh,043h,074h,01Ch,083h,03Eh,0C2h,05Eh,068h,074h,015h,083h,03Eh  ; ovr_1bf4_6216:3AC0
   	     db	     0C2h,05Eh,044h,074h,00Eh,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0B0h,001h,0E9h,00Dh,002h,0A1h,0C2h,05Eh,089h; ovr_1bf4_6216:3ADC

   	     db	     046h,0FEh,0B9h,00Fh,000h,0BBh,09Ah,01Bh,02Eh,08Bh,007h,03Bh,046h,0FEh  ; ovr_1bf4_6216:3AEA
   	     db	     074h,007h,043h,043h,0E2h,0F4h,0E9h,0F0h,001h,02Eh,0FFh,067h,01Eh,0C4h  ; ovr_1bf4_6216:3AF8
   	     db	     05Eh,008h,026h,081h,03Fh,082h,000h,075h,010h,026h,081h,07Fh,002h,082h  ; ovr_1bf4_6216:3B06
   	     db	     000h,075h,008h,026h,081h,07Fh,004h,082h,000h,074h,002h,0EBh,0C0h,0C4h  ; ovr_1bf4_6216:3B14
   	     db	     05Eh,008h,026h,0C7h,007h,045h,000h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0E9h,0C0h;	ovr_1bf4_6216:3B22
   	     db	     001h,0C4h,05Eh,008h,026h,081h,03Fh,082h,000h,075h,008h,026h,081h,07Fh  ; ovr_1bf4_6216:3B30
   	     db	     004h,082h,000h,074h,002h,0EBh,09Ch,0C4h,05Eh,008h,026h,0C7h,007h,03Ah  ; ovr_1bf4_6216:3B3E
   	     db	     000h,0EBh,0DAh,0C4h,05Eh,008h,026h,081h,03Fh,082h,000h,074h,002h,0EBh  ; ovr_1bf4_6216:3B4C
   	     db	     086h,0C4h,05Eh,008h,026h,0C7h,007h,03Ch,000h,0EBh,0C4h,0C4h,05Eh,008h  ; ovr_1bf4_6216:3B5A
   	     db	     026h,081h,03Fh,082h,000h,075h,01Dh,026h,081h,07Fh,002h,082h,000h,075h  ; ovr_1bf4_6216:3B68
   	     db	     015h,026h,083h,07Fh,004h,03Bh,074h,00Eh,083h,03Eh,0C2h,05Eh,040h,075h  ; ovr_1bf4_6216:3B76
   	     db	     00Ah,026h,083h,07Fh,004h,03Fh,075h,003h,0E9h,052h,0FFh,0C4h,05Eh,008h  ; ovr_1bf4_6216:3B84
   	     db	     0A1h,0C2h,05Eh,026h,089h,007h,0EBh,08Fh,0C4h,05Eh,008h,026h,081h,03Fh  ; ovr_1bf4_6216:3B92
   	     db	     082h,000h,074h,006h,026h,083h,03Fh,03Ch,075h,00Bh,0C4h,05Eh,008h,026h  ; ovr_1bf4_6216:3BA0
   	     db	     081h,07Fh,004h,082h,000h,074h,003h,0E9h,029h,0FFh,0C4h,05Eh,008h,026h  ; ovr_1bf4_6216:3BAE
   	     db	     0C7h,047h,004h,03Bh,000h,0E9h,065h,0FFh,0C4h,05Eh,008h,026h,081h,03Fh  ; ovr_1bf4_6216:3BBC
   	     db	     082h,000h,074h,00Ch,026h,083h,03Fh,03Ch,074h,006h,026h,083h,03Fh,041h  ; ovr_1bf4_6216:3BCA
   	     db	     075h,00Bh,0C4h,05Eh,008h,026h,081h,07Fh,004h,082h,000h,074h,003h,0E9h  ; ovr_1bf4_6216:3BD8
   	     db	     0F9h,0FEh,0C4h,05Eh,008h,026h,0C7h,047h,004h,03Fh,000h,0E9h,035h,0FFh  ; ovr_1bf4_6216:3BE6
   	     db	     0C4h,05Eh,008h,026h,081h,03Fh,082h,000h,074h,00Ch,026h,083h,03Fh,03Ah  ; ovr_1bf4_6216:3BF4
   	     db	     074h,006h,026h,083h,03Fh,03Ch,075h,00Bh,0C4h,05Eh,008h,026h,081h,07Fh  ; ovr_1bf4_6216:3C02
   	     db	     002h,082h,000h,074h,003h,0E9h,0C9h,0FEh,0C4h,05Eh,008h,0A1h,0C2h,05Eh  ; ovr_1bf4_6216:3C10
   	     db	     026h,089h,047h,002h,0E9h,004h,0FFh,0C4h,05Eh,004h,026h,083h,03Fh,000h  ; ovr_1bf4_6216:3C1E
   	     db	     074h,024h,0C4h,05Eh,008h,026h,080h,07Fh,006h,000h,075h,011h,0C4h,05Eh  ; ovr_1bf4_6216:3C2C
   	     db	     004h,026h,08Bh,01Fh,08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,001h,074h  ; ovr_1bf4_6216:3C3A
   	     db	     009h,0B8h,0AFh,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C4h,05Eh,008h,026h; ovr_1bf4_6216:3C48
   	     db	     0C6h,047h,006h,001h,0E9h,0CCh,0FEh,0C4h,05Eh,004h,026h,083h,03Fh,000h  ; ovr_1bf4_6216:3C56
   	     db	     074h,024h,0C4h,05Eh,008h,026h,080h,07Fh,007h,000h,075h,011h,0C4h,05Eh  ; ovr_1bf4_6216:3C64
   	     db	     004h,026h,08Bh,01Fh,08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,002h,074h  ; ovr_1bf4_6216:3C72
   	     db	     009h,0B8h,0AFh,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C4h,05Eh,008h,026h; ovr_1bf4_6216:3C80
   	     db	     0C6h,047h,007h,001h,0E9h,094h,0FEh,0C4h,05Eh,008h,026h,081h,03Fh,082h  ; ovr_1bf4_6216:3C8E
   	     db	     000h,075h,010h,026h,081h,07Fh,002h,082h,000h,075h,008h,026h,081h,07Fh  ; ovr_1bf4_6216:3C9C
   	     db	     004h,082h,000h,074h,003h,0E9h,02Fh,0FEh,0C4h,05Eh,008h,0A1h,0C2h,05Eh  ; ovr_1bf4_6216:3CAA
   	     db	     026h,089h,007h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0C4h,05Eh,008h,026h,083h,03Fh; ovr_1bf4_6216:3CB8
   	     db	     044h,075h,00Bh,0E8h,01Dh,0FCh,0C4h,05Eh,004h,026h,089h,007h,0EBh,01Dh  ; ovr_1bf4_6216:3CC6
   	     db	     0C4h,05Eh,008h,026h,0FFh,037h,083h,07Eh,00Ch,000h,075h,005h,0B8h,001h  ; ovr_1bf4_6216:3CD4
   	     db	     000h,0EBh,002h,033h,0C0h,050h,0E8h,0F3h,0F9h,0C4h,05Eh,004h,026h,089h  ; ovr_1bf4_6216:3CE2
   	     db	     007h,0B0h,000h,08Bh,0E5h,05Dh,04Dh,0C2h,00Ah,000h,03Ah,000h,03Bh,000h  ; ovr_1bf4_6216:3CF0
   	     db	     03Ch,000h,03Dh,000h,03Eh,000h,03Fh,000h,040h,000h,041h,000h,042h,000h  ; ovr_1bf4_6216:3CFE
   	     db	     043h,000h,044h,000h,045h,000h,04Ah,000h,04Bh,000h,068h,000h,0D1h,019h  ; ovr_1bf4_6216:3D0C
   	     db	     03Ah,01Ah,0EFh,019h,094h,01Ah,094h,01Ah,064h,01Ah,005h,01Ah,005h,01Ah  ; ovr_1bf4_6216:3D1A
   	     db	     035h,01Bh,035h,01Bh,035h,01Bh,0A5h,019h,0C5h,01Ah,0FDh,01Ah,035h,01Bh  ; ovr_1bf4_6216:3D28
   	     db	     045h,055h,08Bh,0ECh,056h,057h,033h,0F6h,08Ah,046h,006h,0B4h,000h,00Bh  ; ovr_1bf4_6216:3D36
   	     db	     0C0h,075h,043h,083h,07Eh,008h,045h,074h,039h,083h,07Eh,008h,03Ah,074h  ; ovr_1bf4_6216:3D44
   	     db	     033h,083h,07Eh,008h,03Ch,074h,02Dh,083h,07Eh,008h,040h,074h,027h,083h  ; ovr_1bf4_6216:3D52
   	     db	     07Eh,008h,041h,074h,021h,080h,07Eh,00Eh,000h,075h,006h,080h,07Eh,00Fh  ; ovr_1bf4_6216:3D60
   	     db	     000h,074h,007h,081h,07Eh,008h,082h,000h,074h,00Eh,081h,07Eh,00Ah,082h  ; ovr_1bf4_6216:3D6E
   	     db	     000h,075h,007h,081h,07Eh,00Ch,082h,000h,074h,004h,033h,0FFh,0EBh,00Eh  ; ovr_1bf4_6216:3D7C
   	     db	     083h,07Eh,004h,000h,075h,005h,033h,0C0h,0E9h,0B9h,000h,08Bh,07Eh,004h  ; ovr_1bf4_6216:3D8A
   	     db	     00Bh,0FFh,074h,003h,0E9h,0A2h,000h,083h,07Eh,008h,040h,074h,006h,083h  ; ovr_1bf4_6216:3D98
   	     db	     07Eh,008h,041h,075h,01Bh,083h,07Eh,00Ch,03Fh,075h,005h,0BEh,00Bh,000h  ; ovr_1bf4_6216:3DA6
   	     db	     0EBh,07Eh,083h,07Eh,008h,041h,075h,005h,0BEh,00Ah,000h,0EBh,073h,0BEh  ; ovr_1bf4_6216:3DB4
   	     db	     009h,000h,0EBh,06Eh,083h,07Eh,008h,03Ah,075h,01Ch,083h,07Eh,00Ah,03Eh  ; ovr_1bf4_6216:3DC2
   	     db	     075h,005h,0BEh,001h,000h,0EBh,05Dh,083h,07Eh,00Ah,03Dh,075h,005h,0BEh  ; ovr_1bf4_6216:3DD0
   	     db	     002h,000h,0EBh,052h,08Bh,036h,002h,064h,0EBh,04Ch,081h,07Eh,008h,082h  ; ovr_1bf4_6216:3DDE
   	     db	     000h,075h,01Ah,081h,07Eh,00Ah,082h,000h,075h,013h,080h,07Eh,00Eh,000h  ; ovr_1bf4_6216:3DEC
   	     db	     075h,00Dh,080h,07Eh,00Fh,000h,075h,007h,081h,07Eh,00Ch,082h,000h,074h  ; ovr_1bf4_6216:3DFA
   	     db	     02Bh,083h,07Eh,008h,045h,075h,005h,0BEh,00Ch,000h,0EBh,019h,083h,07Eh  ; ovr_1bf4_6216:3E08
   	     db	     00Ch,03Bh,075h,005h,0BEh,003h,000h,0EBh,00Eh,083h,07Eh,00Ch,03Fh,075h  ; ovr_1bf4_6216:3E16
   	     db	     005h,0BEh,007h,000h,0EBh,003h,0BEh,005h,000h,083h,07Eh,00Ah,03Dh,075h  ; ovr_1bf4_6216:3E24
   	     db	     001h,046h,08Bh,0C6h,0D1h,0E0h,0C4h,01Eh,01Ch,064h,003h,0D8h,026h,08Bh  ; ovr_1bf4_6216:3E32
   	     db	     03Fh,057h,08Ah,046h,00Fh,050h,08Ah,046h,00Eh,050h,00Eh,0E8h,065h,0FBh  ; ovr_1bf4_6216:3E40
   	     db	     05Fh,05Eh,05Dh,04Dh,0C2h,00Ch,000h,045h,055h,08Bh,0ECh,056h,08Bh,076h  ; ovr_1bf4_6216:3E4E
   	     db	     004h,01Eh,0B8h,082h,063h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO03D_TEXT
   	     db	     00Ah,0C0h,074h; ovr_1bf4_6216:3E5C
   	     db	     054h,083h,03Eh,0C2h,05Eh,02Bh,074h,04Dh,083h,03Eh,0C2h,05Eh,031h,075h  ; ovr_1bf4_6216:3E6A
   	     db	     006h,081h,0FEh,082h,000h,075h,040h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h  ; ovr_1bf4_6216:3E78
   	     db	     074h,032h,083h,03Eh,0C2h,05Eh,031h,075h,02Bh,09Ah

   	     dw	     020h
   	     dw	     seg CO02D_TEXT
   	     db	     083h,03Eh,060h,082h,067h,074h,024h,081h,0FEh,082h,000h,074h,019h,083h  ; ovr_1bf4_6216:3E94
   	     db	     0FEh,045h,074h,014h,083h,0FEh,03Ah,074h,00Fh,083h,0FEh,03Ch,074h,00Ah  ; ovr_1bf4_6216:3EA2
   	     db	     083h,0FEh,040h,074h,005h,083h,0FEh,041h,075h,005h,0B8h,001h,000h,0EBh  ; ovr_1bf4_6216:3EB0
   	     db	     002h,033h,0C0h,05Eh,05Dh,04Dh,0C2h,002h,000h; raw:3EBE

X010_04 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1bf4_6216:3EBE
   	     db	     00Ah,0C4h,05Eh,00Eh,026h,08Bh,007h,089h,046h,0F6h,0C4h,05Eh,00Ah,026h  ; ovr_1bf4_6216:3ECC
   	     db	     0C6h,007h,000h,026h,0C6h,047h,001h,000h,026h,0C6h,047h,002h,000h,0C7h  ; ovr_1bf4_6216:3EDA
   	     db	     046h,0F8h,082h,000h,0C7h,046h,0FAh,082h,000h,0C7h,046h,0FCh,082h,000h  ; ovr_1bf4_6216:3EE8
   	     db	     0C6h,046h,0FEh,000h,0C6h,046h,0FFh,000h,0C4h,05Eh,006h,026h,0C6h,007h  ; ovr_1bf4_6216:3EF6
   	     db	     000h,0C4h,05Eh,01Ah,026h,0C7h,007h,082h,000h,0C4h,05Eh,016h,026h,0C6h  ; ovr_1bf4_6216:3F04
   	     db	     007h,000h,0C4h,05Eh,012h,026h,0C6h,007h,000h,0C6h,006h,000h,064h,000h  ; ovr_1bf4_6216:3F12
   	     db	     0E9h,0A8h,001h,08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0F7h,087h,0B3h,007h,001h  ; ovr_1bf4_6216:3F20
   	     db	     000h,075h,003h,0E9h,0B4h,000h,083h,03Eh,0C2h,05Eh,06Eh,075h,01Fh,0B8h  ; ovr_1bf4_6216:3F2E
   	     db	     05Ch,001h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C4h,05Eh,01Ah,026h,081h,03Fh; ovr_1bf4_6216:3F3C
   	     db	     082h,000h,074h,003h,0E9h,094h,000h,0A1h,0C2h,05Eh,026h,089h,007h,0E9h  ; ovr_1bf4_6216:3F4A
   	     db	     043h,001h,083h,03Eh,0C2h,05Eh,06Ah,075h,017h,0C4h,05Eh,016h,026h,080h  ; ovr_1bf4_6216:3F58
   	     db	     03Fh,000h,074h,009h,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C4h; ovr_1bf4_6216:3F66
   	     db	     05Eh,016h,0EBh,01Ch,083h,03Eh,0C2h,05Eh,073h,075h,01Ch,0C4h,05Eh,012h  ; ovr_1bf4_6216:3F74
   	     db	     026h,080h,03Fh,000h,074h,009h,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0C4h,05Eh,012h,026h,0C6h,007h,001h,0E9h,002h,001h,083h,03Eh,0C2h;	    ovr_1bf4_6216:3F82
   	     db	     05Eh,06Bh,075h,00Bh,0C4h,05Eh,01Ah,026h,083h,03Fh,035h,075h,002h,0EBh  ; ovr_1bf4_6216:3F9E
   	     db	     02Ch,083h,03Eh,0C2h,05Eh,035h,075h,009h,0C4h,05Eh,01Ah,026h,083h,03Fh  ; ovr_1bf4_6216:3FAC
   	     db	     06Bh,074h,028h,0C4h,05Eh,01Ah,026h,081h,03Fh,082h,000h,074h,012h,026h  ; ovr_1bf4_6216:3FBA
   	     db	     083h,03Fh,06Eh,074h,00Ch,0B8h,023h,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     0E9h,0C4h,000h,0C4h,05Eh,01Ah,0A1h,0C2h,05Eh,026h,089h,007h,0E9h,0B8h  ; ovr_1bf4_6216:3FD6
   	     db	     000h,0E9h,0B5h,000h,08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0F7h,087h,0B3h,007h  ; ovr_1bf4_6216:3FE4
   	     db	     002h,000h,074h,01Ah,0FFh,076h,01Eh,016h,08Dh,046h,0F8h,050h,016h,08Dh  ; ovr_1bf4_6216:3FF2
   	     db	     046h,0F6h,050h,0E8h,08Bh,0FAh,00Ah,0C0h,075h,003h,0E9h,0BEh,000h,0E9h  ; ovr_1bf4_6216:4000
   	     db	     0C8h,000h,083h,03Eh,0C2h,05Eh,031h,074h,003h,0E9h,091h,000h,0FFh,036h  ; ovr_1bf4_6216:400E
   	     db	     08Bh,063h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO03D_TEXT
   	     db	     089h,046h,0F6h,081h,07Eh,0F8h,082h; ovr_1bf4_6216:401C
   	     db	     000h,075h,077h,081h,07Eh,0FAh,082h,000h,075h,070h,081h,07Eh,0FCh,082h  ; ovr_1bf4_6216:402A
   	     db	     000h,075h,069h,0C7h,046h,0F8h,031h,000h,0C4h,05Eh,006h,026h,0C6h,007h  ; ovr_1bf4_6216:4038
   	     db	     001h,0FFh,076h,00Ch,0FFh,076h,00Ah,0FFh,036h,08Bh,063h,09Ah

   	     dw	     0CAh
   	     dw	     seg CO02C_TEXT
   	     db	     005h,008h,000h,0FFh,036h,010h,064h,050h,0B9h,003h,000h,09Ah;	    ovr_1bf4_6216:4046
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     083h,07Eh,0F6h,000h,074h,031h,080h,07Eh,0FEh,000h;	ovr_1bf4_6216:4062

   	     db	     074h,00Eh,08Bh,05Eh,0F6h,08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,001h  ; ovr_1bf4_6216:4070
   	     db	     075h,014h,080h,07Eh,0FFh,000h,074h,017h,08Bh,05Eh,0F6h,08Eh,006h,09Ah  ; ovr_1bf4_6216:407E
   	     db	     063h,026h,0F6h,047h,002h,002h,074h,009h,0B8h,0AFh,000h,050h,09Ah

   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     0EBh,027h,0C7h,046h,0F6h,000h; ovr_1bf4_6216:408C
   	     db	     000h,0EBh,02Dh,0B8h,09Bh,000h,050h,08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0FFh  ; ovr_1bf4_6216:40A8
   	     db	     0B7h,082h,061h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO019_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h; ovr_1bf4_6216:40B6
   	     db	     050h,052h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     0FFh,076h,0F8h,0E8h,084h,0FDh,00Ah; ovr_1bf4_6216:40C4
   	     db	     0C0h,074h,003h,0E9h,04Bh,0FEh,08Dh,046h,0F8h,08Ch,0D2h,0B9h,008h,000h  ; ovr_1bf4_6216:40D2
   	     db	     09Ah
   	     dw	     03C2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0C4h,05Eh,006h,026h,08Ah,007h,050h,0FFh,076h; ovr_1bf4_6216:40E0

   	     db	     0F6h,0E8h,044h,0FCh,0C4h,05Eh,00Eh,026h,089h,007h,08Bh,0E5h,05Dh,0CAh  ; ovr_1bf4_6216:40EE
   	     db	     01Ah,000h	     ; ovr_1bf4_6216:40FC

CO010_TEXT	     ends
; END LG06F
   	     end
