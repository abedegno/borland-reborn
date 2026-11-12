; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
CO003_TEXT	     segment byte public 'CODE'
CO003_TEXT	     ends
CO005_TEXT	     segment byte public 'CODE'
CO005_TEXT	     ends
CO007_TEXT	     segment byte public 'CODE'
CO007_TEXT	     ends
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
CO00F_TEXT	     segment byte public 'CODE'
CO00F_TEXT	     ends
CO010_TEXT	     segment byte public 'CODE'
CO010_TEXT	     ends
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO021_TEXT	     segment byte public 'CODE'
CO021_TEXT	     ends
CO023_TEXT	     segment byte public 'CODE'
CO023_TEXT	     ends
CO028_TEXT	     segment byte public 'CODE'
CO028_TEXT	     ends
CO02B_TEXT	     segment byte public 'CODE'
CO02B_TEXT	     ends
CO02C_TEXT	     segment byte public 'CODE'
CO02C_TEXT	     ends
CO06A_TEXT	     segment byte public 'CODE'
CO06A_TEXT	     ends
CO06C_TEXT	     segment byte public 'CODE'
CO06C_TEXT	     ends
   	     public  X012_00
   	     public  X012_01
   	     public  X012_03
   	     public  X012_02
   	     public  X012_05
   	     public  X012_04
   	     public  X012_07
   	     public  X012_06
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1bfd_644a
; BEGIN LG071 (gap	ovr_1bfd_644a:44A0)
CO012_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO012_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,008h,056h,057h,08Bh,07Eh,006h,08Eh,006h  ; ovr_1bfd_644a:44A0
   	     db	     086h,081h,026h,08Bh,075h,00Ah,08Eh,006h,09Ah,063h,08Bh,05Eh,004h,026h  ; ovr_1bfd_644a:44AE
   	     db	     08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h,000h,074h,056h,08Eh  ; ovr_1bfd_644a:44BC
   	     db	     006h,086h,081h,026h,083h,03Ch,001h,075h,04Ch,026h,08Bh,05Ch,008h,08Eh  ; ovr_1bfd_644a:44CA
   	     db	     006h,09Ah,063h,026h,083h,03Fh,012h,075h,03Eh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:44D8
   	     db	     08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,0F7h,047h,00Ah,040h,000h,074h  ; ovr_1bfd_644a:44E6
   	     db	     013h,08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,08Ah,047h,006h,0B4h  ; ovr_1bfd_644a:44F4
   	     db	     000h,0A9h,040h,000h,074h,017h,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah  ; ovr_1bfd_644a:4502
   	     db	     08Eh,006h,010h,064h,026h,08Ah,047h,006h,0B4h,000h,0A9h,010h,000h,075h  ; ovr_1bfd_644a:4510
   	     db	     005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0FBh,080h,07Eh,0FBh  ; ovr_1bfd_644a:451E
   	     db	     000h,074h,005h,0A1h,038h,064h,0EBh,010h,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1bfd_644a:452C
   	     db	     05Dh,00Ch,026h,08Bh,05Fh,00Ch,026h,08Bh,047h,008h,089h,046h,0F8h,08Eh  ; ovr_1bfd_644a:453A
   	     db	     006h,086h,081h,026h,083h,03Ch,001h,075h,059h,026h,08Bh,05Ch,008h,08Eh  ; ovr_1bfd_644a:4548
   	     db	     006h,09Ah,063h,026h,083h,03Fh,012h,075h,04Bh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:4556
   	     db	     08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,0F6h,047h,006h,010h,074h,038h  ; ovr_1bfd_644a:4564
   	     db	     08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,0FFh,076h,0F8h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO06C_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,022h,0B8h,0B6h,000h,050h,08Eh,006h;	    ovr_1bfd_644a:4572
   	     db	     086h,081h,026h,0FFh,074h,00Ah,09Ah
   	     dw	     039h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h; ovr_1bfd_644a:458E
   	     db	     0C0h,033h,0D2h,050h,052h,057h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,0BEh,000h; ovr_1bfd_644a:459C
   	     db	     080h,07Eh,0FBh,000h,074h,003h,0E9h,0B3h,000h,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:45AA
   	     db	     08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,08Bh,01Fh,026h,08Bh,047h,004h  ; ovr_1bfd_644a:45B8
   	     db	     089h,046h,0FEh,0FFh,076h,0F8h,0FFh,076h,0FEh,0B8h,001h,000h,050h,09Ah  ; ovr_1bfd_644a:45C6
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,045h,08Eh,006h,086h,081h;	ovr_1bfd_644a:45D4

   	     db	     026h,08Bh,05Dh,00Ch,026h,0FFh,077h,00Ch,09Ah

   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     089h; ovr_1bfd_644a:45E2
   	     db	     046h,0FCh,0FFh,076h,0FCh,0FFh,076h,004h,08Eh,006h,086h,081h,026h,0FFh  ; ovr_1bfd_644a:45F0
   	     db	     074h,00Eh,0FFh,076h,0FEh,0B0h,000h,050h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO06A_TEXT
   	     db	     089h,046h,0FCh,0FFh,076h,0FCh,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h,086h; ovr_1bfd_644a:460C
   	     db	     081h,026h,08Bh,05Dh,00Ch,026h,089h,047h,00Ch,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:461A
   	     db	     08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,0F7h,047h,00Ah,040h,000h,074h  ; ovr_1bfd_644a:4628
   	     db	     02Fh,08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,0F6h,047h,006h,040h  ; ovr_1bfd_644a:4636
   	     db	     074h,020h,026h,08Bh,045h,00Ch,089h,046h,0FCh,08Bh,05Eh,0FCh,026h,08Bh  ; ovr_1bfd_644a:4644
   	     db	     047h,00Ah,026h,089h,045h,00Ch,026h,0C7h,047h,00Ah,000h,000h,0FFh,076h  ; ovr_1bfd_644a:4652
   	     db	     0FCh,09Ah
   	     dw	     043h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh; ovr_1bfd_644a:4660

   	     db	     0C2h,004h,000h; raw:466E
X012_06 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ch,056h,057h,08Bh,07Eh,008h;		    ovr_1bfd_644a:466E
   	     db	     08Eh,006h,086h,081h,026h,08Bh,075h,00Ah,026h,083h,03Ch,001h,075h,034h  ; ovr_1bfd_644a:467C
   	     db	     026h,08Bh,05Ch,008h,08Eh,006h,09Ah,063h,026h,083h,03Fh,012h,075h,026h  ; ovr_1bfd_644a:468A
   	     db	     08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,083h  ; ovr_1bfd_644a:4698
   	     db	     07Fh,013h,000h,074h,013h,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,08Eh  ; ovr_1bfd_644a:46A6
   	     db	     006h,010h,064h,026h,083h,07Fh,00Fh,002h,075h,003h,0E9h,0E0h,000h,08Eh  ; ovr_1bfd_644a:46B4
   	     db	     006h,086h,081h,026h,08Bh,045h,00Ch,0EBh,074h,08Dh,046h,0F6h,016h,050h  ; ovr_1bfd_644a:46C2
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,047h,00Ch,005h,014h,000h  ; ovr_1bfd_644a:46D0
   	     db	     0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh; ovr_1bfd_644a:46DE
   	     db	     05Eh,0FEh,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,033h,0C0h,050h,050h  ; ovr_1bfd_644a:46EC
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     050h,016h,08Dh; ovr_1bfd_644a:46FA
   	     db	     046h,0F5h,050h,09Ah
   	     dw	     075h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h; ovr_1bfd_644a:4708
   	     db	     081h,026h,089h,047h,00Ch,026h,08Bh,047h,00Ch,005h,014h,000h,0FFh,036h  ; ovr_1bfd_644a:4716
   	     db	     086h,081h,050h,08Dh,046h,0F6h,016h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,047h,00Ah,089h;	    ovr_1bfd_644a:4724
   	     db	     046h,0FEh,083h,07Eh,0FEh,000h,075h,083h,057h,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:4740
   	     db	     0FFh,074h,00Ah,033h,0C0h,050h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h;	ovr_1bfd_644a:474E
   	     db	     0FCh,083h,07Eh,0FCh,000h,075h,01Dh,0B8h,0DCh,000h,050h,057h,0FFh,076h  ; ovr_1bfd_644a:475C
   	     db	     006h,09Ah
   	     dw	     034h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h; ovr_1bfd_644a:476A

   	     db	     057h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0EBh,023h,08Eh,006h,086h,081h,08Bh,046h; ovr_1bfd_644a:4778

   	     db	     0FCh,026h,089h,044h,00Ah,026h,080h,064h,006h,0FEh,056h,033h,0C0h,050h  ; ovr_1bfd_644a:4786
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO003_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,045h,00Ah,08Bh; ovr_1bfd_644a:4794

   	     db	     0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h; raw:47A2

X012_01 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch; ovr_1bfd_644a:47A2
   	     db	     056h,057h,08Bh,07Eh,008h,057h,09Ah
   	     dw	     020h
   	     dw	     seg CO00F_TEXT
   	     db	     089h,046h,0FEh; ovr_1bfd_644a:47B0
   	     db	     0B8h,030h,000h,050h,0FFh,076h,006h,0FFh,076h,0FEh,09Ah

   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,09Ah,063h,026h; ovr_1bfd_644a:47BE
   	     db	     08Bh,05Dh,005h,08Eh,006h,03Eh,05Fh,026h,0F7h,047h,018h,000h,001h,074h  ; ovr_1bfd_644a:47DA
   	     db	     005h,0A1h,09Ah,062h,0EBh,003h,0A1h,052h,061h,050h,0B8h,016h,000h,050h  ; ovr_1bfd_644a:47E8
   	     db	     056h,0FFh,076h,00Ah,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0B8h,018h,000h,050h,056h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh; ovr_1bfd_644a:47F6
   	     db	     0F0h,056h,033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F0h,05Fh; ovr_1bfd_644a:4812
   	     db	     05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h; raw:4820
X012_05 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Eh,056h; ovr_1bfd_644a:4820
   	     db	     057h,08Bh,07Eh,00Ah,08Eh,006h,086h,081h,026h,08Bh,075h,00Ah,0C7h,046h  ; ovr_1bfd_644a:482E
   	     db	     0FEh,000h,000h,026h,083h,07Ch,00Eh,000h,075h,05Dh,026h,08Bh,05Ch,00Ah  ; ovr_1bfd_644a:483C
   	     db	     08Eh,006h,010h,064h,026h,08Bh,05Fh,004h,08Eh,006h,09Ah,063h,026h,083h  ; ovr_1bfd_644a:484A
   	     db	     03Fh,012h,075h,047h,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,08Eh,006h  ; ovr_1bfd_644a:4858
   	     db	     010h,064h,026h,0F7h,047h,00Ah,000h,001h,074h,020h,0B8h,03Ch,001h,050h  ; ovr_1bfd_644a:4866
   	     db	     08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,09Ah

   	     dw	     039h
   	     dw	     seg CO021_TEXT
   	     db	     052h; ovr_1bfd_644a:4874
   	     db	     050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     0EBh,013h;	ovr_1bfd_644a:4882
   	     db	     08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,08Eh,006h,010h,064h,026h,08Bh  ; ovr_1bfd_644a:4890
   	     db	     047h,015h,089h,046h,0FEh,083h,07Eh,0FEh,000h,077h,003h,0E9h,068h,001h  ; ovr_1bfd_644a:489E
   	     db	     08Eh,006h,086h,081h,026h,08Bh,044h,008h,089h,046h,0FAh,08Eh,006h,09Ah  ; ovr_1bfd_644a:48AC
   	     db	     063h,08Bh,05Eh,0FAh,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h  ; ovr_1bfd_644a:48BA
   	     db	     014h,000h,075h,027h,08Bh,05Eh,0FAh,026h,0F6h,047h,00Ch,001h,074h,005h  ; ovr_1bfd_644a:48C8
   	     db	     0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0F3h,0FFh,076h,0FAh,033h  ; ovr_1bfd_644a:48D6
   	     db	     0C0h,050h,0B0h,000h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0FAh,0EBh; ovr_1bfd_644a:48E4
   	     db	     017h,08Eh,006h,09Ah,063h,08Bh,05Eh,0FAh,026h,083h,03Fh,00Fh,075h,005h  ; ovr_1bfd_644a:48F2
   	     db	     0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0F3h,08Eh,006h,086h,081h  ; ovr_1bfd_644a:4900
   	     db	     026h,08Bh,05Dh,00Ch,026h,0FFh,077h,00Ch,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h,086h,081h,026h; ovr_1bfd_644a:490E
   	     db	     08Bh,05Dh,00Ch,026h,089h,047h,00Ch,026h,08Bh,05Dh,00Ch,026h,08Bh,05Fh  ; ovr_1bfd_644a:492A
   	     db	     00Ch,026h,08Bh,047h,008h,089h,046h,0F8h,056h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,0FFh,077h,00Ch,09Ah

   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     089h,046h,0F6h,016h,08Dh,046h,0F6h,050h,0FFh,076h,008h;		    ovr_1bfd_644a:4946
   	     db	     0FFh,076h,006h,09Ah
   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0F6h,033h,0C0h,050h; ovr_1bfd_644a:4962
   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,0F6h,0FFh,036h,0C8h,05Eh,08Bh; ovr_1bfd_644a:4970

   	     db	     046h,0FEh,048h,033h,0D2h,052h,050h,09Ah

   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh;	ovr_1bfd_644a:497E
   	     db	     076h,0F8h,0FFh,076h,0F6h,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,00Eh,0E8h,010h; ovr_1bfd_644a:498C
   	     db	     0FEh,089h,046h,0FCh,0B8h,02Fh,000h,050h,0FFh,076h,0FCh,080h,07Eh,0F3h  ; ovr_1bfd_644a:499A
   	     db	     000h,074h,005h,0A1h,066h,061h,0EBh,003h,0A1h,064h,061h,050h,09Ah

   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F4h,0B8h,018h; ovr_1bfd_644a:49A8
   	     db	     000h,050h,0FFh,076h,0FAh,0FFh,076h,0F4h,09Ah

   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1bfd_644a:49C4
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F4h,0FFh,076h,0F6h,033h,0C0h,050h; ovr_1bfd_644a:49D2

   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h;	ovr_1bfd_644a:49E0
   	     db	     086h,081h,026h,08Bh,05Dh,00Ch,026h,089h,047h,00Ch,0FFh,076h,0F4h,0FFh  ; ovr_1bfd_644a:49EE
   	     db	     076h,0FAh,033h,0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     052h
   	     dw	     seg CO007_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,045h,00Ah,05Fh,05Eh,08Bh,0E5h;	    ovr_1bfd_644a:49FC
   	     db	     05Dh,0CAh,006h,000h,045h,055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,08Bh  ; ovr_1bfd_644a:4A18
   	     db	     076h,004h,08Eh,006h,086h,081h,026h,08Bh,05Ch,008h,08Eh,006h,09Ah,063h  ; ovr_1bfd_644a:4A26
   	     db	     026h,0F6h,047h,002h,001h,074h,061h,08Eh,006h,010h,064h,026h,08Bh,05Dh  ; ovr_1bfd_644a:4A34
   	     db	     004h,08Eh,006h,09Ah,063h,026h,08Ah,047h,002h,0B4h,000h,0A9h,001h,000h  ; ovr_1bfd_644a:4A42
   	     db	     075h,04Ah,08Eh,006h,010h,064h,026h,083h,07Dh,00Fh,003h,074h,02Ah,026h  ; ovr_1bfd_644a:4A50
   	     db	     083h,07Dh,00Fh,004h,074h,023h,0B8h,086h,001h,050h,057h,09Ah

   	     dw	     039h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,08Eh,006h,086h,081h;	    ovr_1bfd_644a:4A5E
   	     db	     026h,0FFh,074h,016h,026h,0FFh,074h,018h,09Ah

   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh; ovr_1bfd_644a:4A7A
   	     db	     006h,086h,081h,026h,0FFh,074h,008h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO010_TEXT
   	     db	     08Eh,006h;	ovr_1bfd_644a:4A88
   	     db	     086h,081h,026h,089h,044h,008h,05Fh,05Eh,05Dh,04Dh,0C2h,004h,000h;	    raw:4A96
X012_04 label   far
   	     db	     055h; ovr_1bfd_644a:4A96
   	     db	     08Bh,0ECh,083h,0ECh,00Eh,056h,057h,0C4h,05Eh,00Ah,026h,08Bh,037h,08Eh  ; ovr_1bfd_644a:4AA4
   	     db	     006h,086h,081h,026h,08Bh,05Ch,00Ah,026h,08Bh,047h,008h,089h,046h,0F6h  ; ovr_1bfd_644a:4AB2
   	     db	     026h,08Ah,044h,006h,0B4h,000h,0A9h,020h,000h,074h,015h,08Eh,006h,09Ah  ; ovr_1bfd_644a:4AC0
   	     db	     063h,08Bh,05Eh,0F6h,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h  ; ovr_1bfd_644a:4ACE
   	     db	     040h,000h,075h,005h,0B0h,000h,0E9h,067h,001h,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:4ADC
   	     db	     0FFh,074h,00Ah,016h,08Dh,046h,0F9h,050h,09Ah

   	     dw	     075h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh; ovr_1bfd_644a:4AEA
   	     db	     006h,086h,081h,026h,089h,044h,00Ah,026h,0FFh,074h,00Ah,033h,0C0h,050h  ; ovr_1bfd_644a:4AF8
   	     db	     09Ah
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FEh,08Bh,05Eh,0FEh,08Eh,006h,086h; ovr_1bfd_644a:4B06

   	     db	     081h,026h,080h,04Fh,006h,040h,005h,014h,000h,0FFh,036h,086h,081h,050h  ; ovr_1bfd_644a:4B14
   	     db	     08Bh,0C6h,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah  ; ovr_1bfd_644a:4B22
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Eh,006h,086h,081h,026h,08Bh,01Ch,08Ah,087h,0D5h;	ovr_1bfd_644a:4B30

   	     db	     00Bh,0B4h,000h,0D1h,0E0h,08Bh,0D8h,08Bh,087h,082h,061h,089h,046h,0FAh  ; ovr_1bfd_644a:4B3E
   	     db	     083h,07Eh,0F6h,000h,075h,004h,033h,0C0h,0EBh,00Bh,0FFh,076h,0FAh,0FFh  ; ovr_1bfd_644a:4B4C
   	     db	     076h,0F6h,09Ah
   	     dw	     025h
   	     dw	     seg CO06C_TEXT
   	     db	     089h,046h,0F4h,083h,07Eh,0F4h,000h; ovr_1bfd_644a:4B5A
   	     db	     075h,004h,033h,0C0h,0EBh,00Bh,08Bh,05Eh,0F4h,08Eh,006h,0A4h,078h,026h  ; ovr_1bfd_644a:4B68
   	     db	     08Bh,047h,006h,089h,046h,0F2h,0B8h,001h,000h,050h,033h,0C0h,050h,0FFh  ; ovr_1bfd_644a:4B76
   	     db	     076h,0FEh,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,005h,014h,000h,0FFh,036h; ovr_1bfd_644a:4B84
   	     db	     086h,081h,050h,08Bh,0C6h,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h  ; ovr_1bfd_644a:4B92
   	     db	     006h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     057h,0FFh,076h,0FAh,09Ah
   	     dw	     0CAh
   	     dw	     seg CO02C_TEXT
   	     db	     050h,0FFh,076h,0F2h,0FFh,076h,008h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h,0FCh,083h,07Eh,0FCh,000h,075h,011h,0FFh,076h,0FEh,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     057h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,00Ah,0FFh,0FFh,076h; ovr_1bfd_644a:4BBC
   	     db	     0FCh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO003_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,045h,00Ah,026h,08Bh,045h,00Ah,005h;	    ovr_1bfd_644a:4BD8
   	     db	     014h,000h,0FFh,036h,086h,081h,050h,08Bh,0C6h,005h,014h,000h,0FFh,036h  ; ovr_1bfd_644a:4BF4
   	     db	     086h,081h,050h,0B9h,006h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,05Eh,0FCh; ovr_1bfd_644a:4C02
   	     db	     08Eh,006h,010h,064h,026h,0F6h,047h,006h,010h,074h,011h,0FFh,076h,0FCh  ; ovr_1bfd_644a:4C10
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,0FFh,077h,00Ch,0E8h,0F0h,0FDh  ; ovr_1bfd_644a:4C1E
   	     db	     057h,0FFh,076h,0F6h,0E8h,06Dh,0F8h,08Bh,0F8h,056h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     057h,0FFh,076h,006h,09Ah
   	     dw	     020h
   	     dw	     seg CO005_TEXT
   	     db	     0C4h,05Eh,00Ah,026h; ovr_1bfd_644a:4C2C
   	     db	     089h,007h,0B0h,001h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h; raw:4C48

X012_00 label   far
   	     db	     055h,08Bh;	ovr_1bfd_644a:4C48
   	     db	     0ECh,083h,0ECh,010h,056h,057h,0C4h,05Eh,00Ah,026h,08Bh,037h,08Eh,006h  ; ovr_1bfd_644a:4C56
   	     db	     086h,081h,026h,08Bh,05Ch,00Ah,026h,08Bh,047h,008h,089h,046h,0FEh,026h  ; ovr_1bfd_644a:4C64
   	     db	     08Ah,044h,006h,0B4h,000h,0A9h,020h,000h,074h,033h,08Eh,006h,09Ah,063h  ; ovr_1bfd_644a:4C72
   	     db	     08Bh,05Eh,0FEh,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h  ; ovr_1bfd_644a:4C80
   	     db	     000h,075h,023h,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ch,026h,08Bh,05Fh  ; ovr_1bfd_644a:4C8E
   	     db	     008h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h  ; ovr_1bfd_644a:4C9C
   	     db	     0A9h,040h,000h,075h,005h,0B0h,000h,0E9h,00Ah,002h,08Eh,006h,086h,081h  ; ovr_1bfd_644a:4CAA
   	     db	     026h,0FFh,074h,00Ah,016h,08Dh,046h,0FBh,050h,09Ah

   	     dw	     075h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ah,026h,0FFh,074h,00Ch,016h,08Dh  ; ovr_1bfd_644a:4CC6
   	     db	     046h,0FBh,050h,09Ah
   	     dw	     075h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h; ovr_1bfd_644a:4CD4
   	     db	     044h,00Ch,026h,0FFh,074h,00Ch,033h,0C0h,050h,09Ah

   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0C6h,046h,0FAh,000h,08Eh,006h,086h,081h,026h,083h,03Ch,047h  ; ovr_1bfd_644a:4CF0
   	     db	     075h,02Eh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FEh,026h,08Bh,01Fh,0F6h,087h  ; ovr_1bfd_644a:4CFE
   	     db	     0CAh,009h,040h,074h,01Dh,08Bh,05Eh,0FEh,026h,08Bh,05Fh,005h,08Eh,006h  ; ovr_1bfd_644a:4D0C
   	     db	     03Eh,05Fh,026h,0F7h,047h,018h,004h,000h,074h,005h,0B8h,001h,000h,0EBh  ; ovr_1bfd_644a:4D1A
   	     db	     002h,033h,0C0h,088h,046h,0FAh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FEh,026h  ; ovr_1bfd_644a:4D28
   	     db	     08Bh,01Fh,08Ah,087h,0CAh,009h,0B4h,000h,0A9h,040h,000h,075h,005h,0C7h  ; ovr_1bfd_644a:4D36
   	     db	     046h,0FEh,000h,000h,080h,07Eh,0FAh,000h,074h,018h,0FFh,036h,0C8h,05Eh  ; ovr_1bfd_644a:4D44
   	     db	     033h,0C0h,033h,0D2h,050h,052h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,057h,09Ah; ovr_1bfd_644a:4D52
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah;	ovr_1bfd_644a:4D60

   	     db	     057h,09Ah
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h,080h; ovr_1bfd_644a:4D6E

   	     db	     04Dh,006h,040h,026h,08Bh,01Ch,08Ah,087h,0D5h,00Bh,0B4h,000h,0D1h,0E0h  ; ovr_1bfd_644a:4D7C
   	     db	     08Bh,0D8h,08Bh,087h,082h,061h,089h,046h,0F6h,083h,07Eh,0FEh,000h,075h  ; ovr_1bfd_644a:4D8A
   	     db	     004h,033h,0C0h,0EBh,00Bh,0FFh,076h,0F6h,0FFh,076h,0FEh,09Ah

   	     dw	     025h
   	     dw	     seg CO06C_TEXT
   	     db	     089h,046h,0F4h,083h,07Eh,0F4h,000h,075h,004h,033h,0C0h,0EBh;	    ovr_1bfd_644a:4D98
   	     db	     00Bh,08Bh,05Eh,0F4h,08Eh,006h,0A4h,078h,026h,08Bh,047h,006h,089h,046h  ; ovr_1bfd_644a:4DB4
   	     db	     0F2h,0B8h,001h,000h,050h,033h,0C0h,050h,057h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F8h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Bh,0C6h,005h  ; ovr_1bfd_644a:4DD0
   	     db	     014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0FFh,076h,0F8h,0FFh,076h,0F6h,09Ah
   	     dw	     0CAh
   	     dw	     seg CO02C_TEXT
   	     db	     050h,0FFh;	ovr_1bfd_644a:4DDE
   	     db	     076h,0F2h,0FFh,076h,008h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO028_TEXT
   	     db	     089h,046h,0FCh,083h; ovr_1bfd_644a:4DFA
   	     db	     07Eh,0FCh,000h,075h,036h,080h,07Eh,0FAh,000h,074h,021h,08Eh,006h,086h  ; ovr_1bfd_644a:4E08
   	     db	     081h,026h,08Bh,05Dh,00Ah,026h,0FFh,077h,00Ch,0EBh,00Eh,089h,07Eh,0F0h  ; ovr_1bfd_644a:4E16
   	     db	     08Eh,006h,086h,081h,026h,08Bh,07Dh,00Ah,0FFh,076h,0F0h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     00Bh,0FFh,075h,0E9h,0FFh,076h,0F8h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0E9h,06Ch,0FEh,0FFh,076h,0FCh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h; ovr_1bfd_644a:4E40
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,05Eh,0F8h,08Eh,006h,086h,081h,026h; ovr_1bfd_644a:4E4E

   	     db	     089h,047h,00Ah,026h,08Bh,047h,00Ah,005h,014h,000h,0FFh,036h,086h,081h  ; ovr_1bfd_644a:4E5C
   	     db	     050h,08Bh,0C6h,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h  ; ovr_1bfd_644a:4E6A
   	     db	     09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,05Eh,0FCh,08Eh,006h,010h,064h,026h,0F6h; ovr_1bfd_644a:4E78

   	     db	     047h,006h,010h,074h,00Eh,0FFh,076h,0FCh,08Eh,006h,086h,081h,026h,0FFh  ; ovr_1bfd_644a:4E86
   	     db	     075h,00Ch,0E8h,083h,0FBh,0FFh,076h,0F8h,0FFh,076h,0FEh,0E8h,0FEh,0F5h  ; ovr_1bfd_644a:4E94
   	     db	     089h,046h,0F8h,056h,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     0FFh,076h,0F8h,0FFh,076h; ovr_1bfd_644a:4EA2
   	     db	     006h,09Ah
   	     dw	     020h
   	     dw	     seg CO005_TEXT
   	     db	     0C4h,05Eh,00Ah,026h,089h,007h,0B0h,001h; ovr_1bfd_644a:4EB0

   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h,045h,055h,08Bh,0ECh,083h,0ECh  ; ovr_1bfd_644a:4EBE
   	     db	     00Eh,056h,057h,0C4h,05Eh,00Ch,026h,08Bh,01Fh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:4ECC
   	     db	     08Bh,047h,008h,089h,046h,0FEh,08Bh,05Eh,0FEh,08Eh,006h,09Ah,063h,026h  ; ovr_1bfd_644a:4EDA
   	     db	     08Bh,05Fh,007h,026h,0F6h,047h,00Ch,001h,074h,005h,0B8h,001h,000h,0EBh  ; ovr_1bfd_644a:4EE8
   	     db	     002h,033h,0C0h,088h,046h,0F3h,0C4h,05Eh,008h,026h,08Bh,01Fh,08Eh,006h  ; ovr_1bfd_644a:4EF6
   	     db	     086h,081h,026h,08Bh,05Fh,008h,08Eh,006h,09Ah,063h,026h,08Bh,05Fh,005h  ; ovr_1bfd_644a:4F04
   	     db	     08Eh,006h,03Eh,05Fh,026h,0F7h,047h,018h,000h,001h,074h,005h,0B8h,001h  ; ovr_1bfd_644a:4F12
   	     db	     000h,0EBh,002h,033h,0C0h,088h,046h,0F2h,0C4h,05Eh,00Ch,026h,08Bh,01Fh  ; ovr_1bfd_644a:4F20
   	     db	     08Eh,006h,086h,081h,0A1h,05Ch,061h,026h,089h,047h,008h,0C4h,05Eh,00Ch  ; ovr_1bfd_644a:4F2E
   	     db	     026h,08Bh,01Fh,08Eh,006h,086h,081h,026h,080h,04Fh,006h,001h,0FFh,076h  ; ovr_1bfd_644a:4F3C
   	     db	     00Eh,0FFh,076h,00Ch,016h,08Dh,046h,0FCh,050h,09Ah

   	     dw	     061h
   	     dw	     seg CO023_TEXT
   	     db	     0C4h,05Eh,004h,026h,0FFh,037h,0FFh,076h,0FCh,09Ah

   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     0C4h,05Eh,004h,026h; ovr_1bfd_644a:4F66
   	     db	     089h,007h,0FFh,036h,0FCh,063h,0B8h,01Dh,000h,050h,0C4h,05Eh,008h,026h  ; ovr_1bfd_644a:4F74
   	     db	     0FFh,037h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     089h; ovr_1bfd_644a:4F82
   	     db	     046h,0FAh,0B8h,02Fh,000h,050h,0C4h,05Eh,00Ch,026h,0FFh,037h,09Ah

   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,088h,062h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1bfd_644a:4F90
   	     db	     09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0B8h,016h,000h,050h,0FFh,076h,0FAh; ovr_1bfd_644a:4FAC

   	     db	     056h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FAh,0B8h,02Fh,000h,050h,0C4h; ovr_1bfd_644a:4FBA

   	     db	     05Eh,00Ch,026h,0FFh,037h,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,074h; ovr_1bfd_644a:4FC8
   	     db	     061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h;	ovr_1bfd_644a:4FD6
   	     db	     0F6h,0B8h,02Fh,000h,050h,0C4h,05Eh,00Ch,026h,0FFh,037h,09Ah

   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,072h,061h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah;	ovr_1bfd_644a:4FE4
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0B8h,016h,000h,050h,0FFh,076h,0FAh,09Ah;	ovr_1bfd_644a:5000

   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F8h; ovr_1bfd_644a:500E
   	     db	     080h,07Eh,0F2h,000h,074h,005h,0A1h,02Ch,05Fh,0EBh,003h,0A1h,0FEh,063h  ; ovr_1bfd_644a:501C
   	     db	     050h,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,0FFh;	ovr_1bfd_644a:502A
   	     db	     076h,0F8h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F8h,0B8h,018h,000h,050h; ovr_1bfd_644a:5038
   	     db	     0FFh,076h,0F8h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,017h,000h,050h; ovr_1bfd_644a:5046
   	     db	     0FFh,076h,0F6h,09Ah
   	     dw	     066h
   	     dw	     seg CO023_TEXT
   	     db	     050h,0FFh,036h,0C8h,05Eh,033h; ovr_1bfd_644a:5054
   	     db	     0C0h,0BAh,001h,000h,050h,052h,09Ah
   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0B8h,016h,000h,050h,057h,056h,09Ah

   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,080h,07Eh,0F3h,000h,074h,005h,0A1h,07Ch,064h,0EBh;	    ovr_1bfd_644a:5062
   	     db	     003h,0A1h,07Ah,064h,050h,080h,07Eh,0F2h,000h,074h,005h,0B8h,00Fh,000h  ; ovr_1bfd_644a:508C
   	     db	     0EBh,003h,0B8h,00Dh,000h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,057h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,018h,000h,050h,057h; ovr_1bfd_644a:50A8
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,0B8h,02Fh,000h,050h,0C4h,05Eh,00Ch; ovr_1bfd_644a:50B6

   	     db	     026h,0FFh,037h,080h,07Eh,0F3h,000h,074h,005h,0A1h,078h,061h,0EBh,003h  ; ovr_1bfd_644a:50C4
   	     db	     0A1h,076h,061h,050h,09Ah
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0F4h,08Bh,05Eh,0FEh,08Eh,006h,09Ah,063h,026h,0FFh,077h;	    ovr_1bfd_644a:50D2
   	     db	     007h,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,0B8h;	ovr_1bfd_644a:50EE
   	     db	     020h,000h,050h,0FFh,076h,0F6h,057h,0FFh,076h,0F4h,09Ah

   	     dw	     039h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     0C4h,05Eh,00Ch,026h,089h,007h,026h; ovr_1bfd_644a:50FC
   	     db	     0FFh,037h,033h,0C0h,050h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     0C4h,05Eh,00Ch; ovr_1bfd_644a:5118
   	     db	     026h,089h,007h,0C4h,05Eh,008h,026h,08Bh,01Fh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:5126
   	     db	     0FFh,077h,008h,033h,0C0h,050h,0B0h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     050h,0FFh,076h,0FAh,09Ah
   	     dw	     084h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,0B8h,018h,000h; ovr_1bfd_644a:5142
   	     db	     050h,056h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F0h,056h,033h,0C0h,050h,050h; ovr_1bfd_644a:5150
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     0C4h,05Eh,008h,026h,089h,007h,05Fh,05Eh,08Bh; ovr_1bfd_644a:515E

   	     db	     0E5h,05Dh,04Dh,0C2h,00Ch,000h,045h,055h,08Bh,0ECh,083h,0ECh,006h,056h  ; ovr_1bfd_644a:516C
   	     db	     08Bh,076h,00Ch,0C4h,05Eh,008h,026h,0C7h,007h,000h,000h,08Eh,006h,086h  ; ovr_1bfd_644a:517A
   	     db	     081h,026h,08Bh,05Ch,00Ah,026h,0FFh,077h,00Ah,033h,0C0h,050h,050h,09Ah  ; ovr_1bfd_644a:5188
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     089h,046h,0FEh,08Eh,006h,086h,081h,026h,08Bh,05Ch;	ovr_1bfd_644a:5196

   	     db	     00Ah,026h,083h,03Fh,03Ch,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h  ; ovr_1bfd_644a:51A4
   	     db	     088h,046h,0FBh,08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah,026h,08Bh,047h  ; ovr_1bfd_644a:51B2
   	     db	     00Ch,089h,046h,0FCh,08Ah,046h,0FBh,0B4h,000h,00Bh,0C0h,074h,003h,0E9h  ; ovr_1bfd_644a:51C0
   	     db	     0ABh,000h,08Bh,05Eh,0FCh,026h,083h,03Fh,001h,074h,003h,0E9h,09Fh,000h  ; ovr_1bfd_644a:51CE
   	     db	     08Bh,05Eh,0FEh,026h,083h,03Fh,001h,075h,04Fh,08Bh,05Eh,0FCh,026h,083h  ; ovr_1bfd_644a:51DC
   	     db	     07Fh,00Eh,000h,075h,045h,08Bh,05Eh,0FEh,026h,08Bh,05Fh,00Ah,08Eh,006h  ; ovr_1bfd_644a:51EA
   	     db	     010h,064h,026h,08Bh,047h,004h,08Bh,05Eh,0FCh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:51F8
   	     db	     08Bh,05Fh,00Ah,08Eh,006h,010h,064h,026h,08Bh,01Fh,026h,03Bh,047h,004h  ; ovr_1bfd_644a:5206
   	     db	     075h,01Eh,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,05Fh,00Ah,08Eh  ; ovr_1bfd_644a:5214
   	     db	     006h,010h,064h,026h,08Bh,047h,004h,08Bh,05Eh,0FCh,08Eh,006h,086h,081h  ; ovr_1bfd_644a:5222
   	     db	     026h,089h,047h,00Eh,08Bh,05Eh,0FCh,08Eh,006h,086h,081h,026h,08Bh,05Fh  ; ovr_1bfd_644a:5230
   	     db	     00Ah,08Eh,006h,010h,064h,026h,083h,07Fh,00Fh,003h,074h,016h,08Bh,05Eh  ; ovr_1bfd_644a:523E
   	     db	     0FCh,08Eh,006h,086h,081h,026h,08Bh,05Fh,00Ah,08Eh,006h,010h,064h,026h  ; ovr_1bfd_644a:524C
   	     db	     083h,07Fh,00Fh,004h,075h,01Bh,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:525A
   	     db	     0FFh,077h,008h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO010_TEXT
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h; ovr_1bfd_644a:5268
   	     db	     081h,026h,089h,047h,008h,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1bfd_644a:5276
   	     db	     047h,008h,0C4h,05Eh,004h,026h,089h,007h,08Eh,006h,086h,081h,026h,0FFh  ; ovr_1bfd_644a:5284
   	     db	     074h,00Ah,09Ah
   	     dw	     06Bh
   	     dw	     seg CO023_TEXT
   	     db	     080h,07Eh,0FBh,000h,074h,015h,016h; ovr_1bfd_644a:5292
   	     db	     08Dh,046h,0FCh,050h,016h,08Dh,046h,0FEh,050h,0FFh,076h,00Ah,0FFh,076h  ; ovr_1bfd_644a:52A0
   	     db	     008h,0E8h,014h,0FCh,0EBh,042h,08Bh,05Eh,0FCh,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:52AE
   	     db	     08Bh,05Fh,00Ah,08Eh,006h,010h,064h,026h,083h,07Fh,00Fh,004h,075h,02Ch  ; ovr_1bfd_644a:52BC
   	     db	     08Eh,006h,086h,081h,026h,083h,07Ch,00Ch,000h,075h,021h,0FFh,036h,0C8h  ; ovr_1bfd_644a:52CA
   	     db	     05Eh,033h,0C0h,0BAh,002h,000h,050h,052h,09Ah

   	     dw	     0C5h
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1bfd_644a:52D8
   	     db	     033h,0C0h,050h,09Ah
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h; ovr_1bfd_644a:52E6
   	     db	     044h,00Ch,0FFh,076h,0FCh,033h,0C0h,050h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ah,0FFh,076h,0FEh,026h,0FFh,074h  ; ovr_1bfd_644a:5302
   	     db	     00Ch,09Ah
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ch; ovr_1bfd_644a:5310

   	     db	     026h,08Bh,05Ch,00Ch,026h,080h,04Fh,006h,040h,05Eh,08Bh,0E5h,05Dh,04Dh  ; ovr_1bfd_644a:531E
   	     db	     0C2h,00Ah,000h,045h,055h,08Bh,0ECh,056h,057h,08Bh,076h,004h,0FFh,036h  ; ovr_1bfd_644a:532C
   	     db	     084h,061h,08Eh,006h,086h,081h,026h,0FFh,074h,008h,09Ah

   	     dw	     025h
   	     dw	     seg CO06C_TEXT
   	     db	     08Bh,0F8h,00Bh,0FFh,074h,03Dh,0B8h,02Fh,000h,050h,056h,057h,09Ah;	    ovr_1bfd_644a:533A
   	     dw	     07Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     050h,033h,0C0h,050h; ovr_1bfd_644a:5356
   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F0h,005h,014h,000h,0FFh,036h,086h; ovr_1bfd_644a:5364

   	     db	     081h,050h,08Eh,006h,086h,081h,026h,08Bh,044h,00Ah,005h,014h,000h,0FFh  ; ovr_1bfd_644a:5372
   	     db	     036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh,0C6h;	ovr_1bfd_644a:5380
   	     db	     05Fh,05Eh,05Dh,04Dh,0C2h,002h,000h; raw:538E
X012_02 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch,056h,057h; ovr_1bfd_644a:538E
   	     db	     08Bh,076h,00Ah,0C4h,05Eh,006h,026h,0C7h,007h,000h,000h,0C7h,046h,0FEh  ; ovr_1bfd_644a:539C
   	     db	     000h,000h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,09Ah

   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ah,026h,08Bh,05Ch,00Ah,026h;	    ovr_1bfd_644a:53AA
   	     db	     08Bh,05Fh,008h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h  ; ovr_1bfd_644a:53C6
   	     db	     040h,074h,013h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,0E8h,04Dh,0FFh  ; ovr_1bfd_644a:53D4
   	     db	     08Eh,006h,086h,081h,026h,089h,044h,00Ah,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1bfd_644a:53E2
   	     db	     07Ch,00Ah,026h,083h,03Dh,001h,075h,01Bh,026h,08Bh,05Dh,00Ah,08Eh,006h  ; ovr_1bfd_644a:53F0
   	     db	     010h,064h,026h,08Bh,047h,002h,03Bh,006h,0BAh,063h,075h,009h,0B8h,016h  ; ovr_1bfd_644a:53FE
   	     db	     001h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,086h,081h,026h,083h,03Dh; ovr_1bfd_644a:540C
   	     db	     03Bh,074h,006h,026h,083h,03Dh,03Ch,075h,069h,08Eh,006h,086h,081h,026h  ; ovr_1bfd_644a:541A
   	     db	     08Bh,05Dh,00Ch,026h,08Bh,05Fh,008h,08Eh,006h,09Ah,063h,026h,083h,03Fh  ; ovr_1bfd_644a:5428
   	     db	     012h,074h,034h,08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,08Bh,05Fh  ; ovr_1bfd_644a:5436
   	     db	     008h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,014h,074h  ; ovr_1bfd_644a:5444
   	     db	     039h,08Eh,006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,08Bh,05Fh,008h,08Eh  ; ovr_1bfd_644a:5452
   	     db	     006h,09Ah,063h,026h,08Bh,05Fh,007h,026h,083h,03Fh,012h,075h,01Fh,08Eh  ; ovr_1bfd_644a:5460
   	     db	     006h,086h,081h,026h,08Bh,05Dh,00Ch,026h,083h,03Fh,039h,074h,011h,056h  ; ovr_1bfd_644a:546E
   	     db	     0FFh,076h,008h,0FFh,076h,006h,016h,08Dh,046h,0FEh,050h,0E8h,0E8h,0FCh  ; ovr_1bfd_644a:547C
   	     db	     0EBh,05Ch,08Eh,006h,086h,081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h  ; ovr_1bfd_644a:548A
   	     db	     026h,083h,03Fh,012h,075h,04Ah,08Eh,006h,086h,081h,026h,08Bh,05Dh,008h  ; ovr_1bfd_644a:5498
   	     db	     08Eh,006h,09Ah,063h,026h,083h,07Fh,003h,000h,074h,037h,0B8h,0E3h,000h  ; ovr_1bfd_644a:54A6
   	     db	     050h,08Eh,006h,086h,081h,026h,083h,03Dh,001h,075h,014h,056h,026h,08Bh  ; ovr_1bfd_644a:54B4
   	     db	     05Dh,008h,08Eh,006h,09Ah,063h,026h,0FFh,077h,003h,09Ah

   	     dw	     034h
   	     dw	     seg CO021_TEXT
   	     db	     0EBh,005h,08Ch,0DAh,0B8h,090h,00Fh,052h,050h,033h,0C0h,033h,0D2h;	    ovr_1bfd_644a:54C2
   	     db	     050h,052h,056h,09Ah
   	     dw	     03Eh
   	     dw	     seg CO023_TEXT
   	     db	     0EBh,013h,056h,0FFh,076h,0FEh; ovr_1bfd_644a:54DE
   	     db	     00Eh,0E8h,081h,0F1h,08Bh,0F0h,056h,0FFh,076h,0FEh,0E8h,0A7h,0EFh,08Bh  ; ovr_1bfd_644a:54EC
   	     db	     0F0h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h; raw:54FA

X012_03 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1bfd_644a:54FA
   	     db	     00Ch,056h,057h,08Bh,07Eh,00Ch,08Bh,05Eh,00Ah,08Eh,006h,028h,064h,026h  ; ovr_1bfd_644a:5508
   	     db	     08Bh,077h,002h,08Dh,046h,0F4h,016h,050h,08Bh,0C7h,005h,014h,000h,0FFh  ; ovr_1bfd_644a:5516
   	     db	     036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Eh,006h;	ovr_1bfd_644a:5524
   	     db	     09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,026h,026h,08Bh  ; ovr_1bfd_644a:5532
   	     db	     05Ch,007h,026h,083h,03Fh,012h,075h,01Ch,08Eh,006h,086h,081h,026h,083h  ; ovr_1bfd_644a:5540
   	     db	     03Dh,001h,074h,006h,026h,083h,03Dh,032h,075h,00Ch,08Eh,006h,086h,081h  ; ovr_1bfd_644a:554E
   	     db	     026h,080h,065h,006h,0FEh,0E9h,0A3h,003h,08Eh,006h,09Ah,063h,026h,08Bh  ; ovr_1bfd_644a:555C
   	     db	     01Ch,0F6h,087h,0CAh,009h,040h,075h,003h,0E9h,01Dh,001h,026h,0F6h,044h  ; ovr_1bfd_644a:556A
   	     db	     002h,004h,075h,003h,0E9h,013h,001h,057h,056h,033h,0C0h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F8h,005h,014h,000h; ovr_1bfd_644a:5578
   	     db	     0FFh,036h,086h,081h,050h,08Dh,046h,0F4h,016h,050h,0B9h,006h,000h,09Ah  ; ovr_1bfd_644a:5594
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Eh,006h,09Ah,063h,026h,0F6h,044h,002h,001h,074h;	ovr_1bfd_644a:55A2

   	     db	     008h,057h,09Ah
   	     dw	     020h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h; ovr_1bfd_644a:55B0
   	     db	     0FFh,075h,008h,056h,0B8h,002h,000h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     00Ah; ovr_1bfd_644a:55BE
   	     db	     0C0h,074h,028h,057h,09Ah
   	     dw	     0A7h
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,075h,015h,057h; ovr_1bfd_644a:55CC
   	     db	     09Ah
   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,014h,08Eh,006h,09Ah,063h,026h; ovr_1bfd_644a:55DA

   	     db	     0F6h,044h,002h,001h,074h,009h,057h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     0E9h,088h;	ovr_1bfd_644a:55E8
   	     db	     000h,056h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FCh,0FFh,076h,0FCh,09Ah; ovr_1bfd_644a:55F6
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h,08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h;	ovr_1bfd_644a:5604

   	     db	     026h,0FFh,077h,010h,09Ah
   	     dw	     084h
   	     dw	     seg CO00F_TEXT
   	     db	     08Bh,01Eh,098h,063h,08Eh; ovr_1bfd_644a:5612
   	     db	     006h,02Ah,078h,026h,089h,047h,010h,0B8h,005h,000h,050h,0FFh,076h,0FCh  ; ovr_1bfd_644a:5620
   	     db	     09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,057h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h;	ovr_1bfd_644a:562E
   	     db	     005h,014h,000h,0FFh,036h,086h,081h,050h,08Eh,006h,086h,081h,026h,08Bh  ; ovr_1bfd_644a:563C
   	     db	     045h,00Ch,005h,014h,000h,0FFh,036h,086h,081h,050h,0B9h,006h,000h,09Ah  ; ovr_1bfd_644a:564A
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     057h,0B8h,01Dh,000h,050h,0FFh,076h,0FCh,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h,033h,0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F8h,056h; ovr_1bfd_644a:5658
   	     db	     033h,0C0h,050h,0B0h,000h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     08Bh,0F0h,0E9h; ovr_1bfd_644a:5682
   	     db	     075h,002h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h  ; ovr_1bfd_644a:5690
   	     db	     075h,003h,0E9h,064h,002h,026h,0F6h,044h,002h,020h,075h,003h,0E9h,05Ah  ; ovr_1bfd_644a:569E
   	     db	     002h,057h,056h,033h,0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,056h,08Eh,006h,086h,081h,026h,0FFh,075h,008h;		    ovr_1bfd_644a:56AC
   	     db	     0B0h,001h,050h,033h,0C0h,050h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO028_TEXT
   	     db	     00Bh,0C0h;	ovr_1bfd_644a:56C8
   	     db	     074h,00Ch,056h,057h,033h,0C0h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F8h;	ovr_1bfd_644a:56D6
   	     db	     08Bh,0C7h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Dh,046h,0F4h,016h  ; ovr_1bfd_644a:56E4
   	     db	     050h,0B9h,006h,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     057h,09Ah
   	     dw	     020h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,056h,08Eh,006h,086h,081h,026h,0FFh,075h,008h,0B0h,000h;	    ovr_1bfd_644a:56F2
   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,074h,003h,0E9h,0EAh; ovr_1bfd_644a:570E

   	     db	     001h,057h,09Ah
   	     dw	     048h
   	     dw	     seg CO06A_TEXT
   	     db	     08Bh,0F8h,057h,09Ah
   	     dw	     0CAh
   	     dw	     seg CO023_TEXT
   	     db	     088h,046h,0FBh,08Eh,006h,086h,081h,026h,0FFh,075h,008h,033h,0C0h;	    ovr_1bfd_644a:571C
   	     db	     050h,0B0h,001h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO00A_TEXT
   	     db	     089h,046h,0FEh,080h,07Eh; ovr_1bfd_644a:5738
   	     db	     0FBh,000h,075h,00Ah,057h,09Ah
   	     dw	     0A7h
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,032h; ovr_1bfd_644a:5746
   	     db	     057h,09Ah
   	     dw	     039h
   	     dw	     seg CO007_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,026h,056h,0FFh; ovr_1bfd_644a:5754

   	     db	     076h,0FEh,0B0h,000h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,016h; ovr_1bfd_644a:5762
   	     db	     057h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,08Bh,046h; ovr_1bfd_644a:5770

   	     db	     0FEh,026h,089h,045h,008h,0E9h,081h,001h,080h,07Eh,0FBh,000h,074h,04Bh  ; ovr_1bfd_644a:577E
   	     db	     057h,09Ah
   	     dw	     04Dh
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,03Fh,08Eh,006h; ovr_1bfd_644a:578C

   	     db	     09Ah,063h,026h,08Bh,05Ch,007h,026h,08Ah,047h,002h,0B4h,000h,0A9h,001h  ; ovr_1bfd_644a:579A
   	     db	     000h,075h,02Ch,0B8h,052h,001h,050h,056h,09Ah

   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h; ovr_1bfd_644a:57A8
   	     db	     050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h;	ovr_1bfd_644a:57B6
   	     db	     086h,081h,026h,0FFh,075h,008h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO010_TEXT
   	     db	     08Eh,006h,086h; ovr_1bfd_644a:57C4
   	     db	     081h,026h,089h,045h,008h,08Eh,006h,09Ah,063h,026h,0FFh,074h,007h,08Eh  ; ovr_1bfd_644a:57D2
   	     db	     006h,086h,081h,026h,0FFh,075h,008h,09Ah

   	     dw	     0E3h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h;	ovr_1bfd_644a:57E0
   	     db	     075h,02Eh,08Eh,006h,086h,081h,026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h  ; ovr_1bfd_644a:57EE
   	     db	     026h,083h,03Fh,011h,075h,01Fh,026h,08Bh,05Ch,007h,026h,083h,03Fh,011h  ; ovr_1bfd_644a:57FC
   	     db	     075h,015h,056h,0FFh,076h,0FEh,0B0h,000h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     0B4h,000h,00Bh,0C0h,075h,003h,0E9h,0DBh,001h,08Eh,006h,09Ah,063h,026h  ; ovr_1bfd_644a:5818
   	     db	     0FFh,074h,007h,08Eh,006h,086h,081h,026h,0FFh,075h,008h,0B0h,001h,050h  ; ovr_1bfd_644a:5826
   	     db	     09Ah
   	     dw	     0A2h
   	     dw	     seg CO00F_TEXT
   	     db	     00Ah,0C0h,074h,027h,08Eh,006h,086h,081h,026h; ovr_1bfd_644a:5834

   	     db	     0FFh,075h,008h,09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FCh,08Eh,006h,086h; ovr_1bfd_644a:5842
   	     db	     081h,026h,0FFh,075h,008h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO010_TEXT
   	     db	     08Eh,006h,086h,081h; ovr_1bfd_644a:5850
   	     db	     026h,089h,045h,008h,0EBh,010h,08Eh,006h,09Ah,063h,026h,0FFh,074h,007h  ; ovr_1bfd_644a:585E
   	     db	     09Ah
   	     dw	     0C0h
   	     dw	     seg CO023_TEXT
   	     db	     089h,046h,0FCh,0FFh,076h,0FCh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,08Bh,05Eh,0FCh,08Eh,006h,010h,064h,026h,0FFh,077h,004h;	    ovr_1bfd_644a:586C
   	     db	     08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,0FFh,077h,010h,09Ah

   	     dw	     084h
   	     dw	     seg CO00F_TEXT
   	     db	     08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,089h,047h;		    ovr_1bfd_644a:5888
   	     db	     010h,0B8h,005h,000h,050h,0FFh,076h,0FCh,09Ah

   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h; ovr_1bfd_644a:58A4
   	     db	     057h,09Ah
   	     dw	     0BBh
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,005h,014h,000h,0FFh,036h,086h; ovr_1bfd_644a:58B2

   	     db	     081h,050h,08Eh,006h,086h,081h,026h,08Bh,045h,00Ch,005h,014h,000h,0FFh  ; ovr_1bfd_644a:58C0
   	     db	     036h,086h,081h,050h,0B9h,006h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     057h,0B8h;	ovr_1bfd_644a:58CE
   	     db	     01Dh,000h,050h,0FFh,076h,0FCh,09Ah
   	     dw	     093h
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO023_TEXT
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO023_TEXT
   	     db	     050h,056h,033h,0C0h,050h; ovr_1bfd_644a:58DC
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,086h,081h,026h,089h,075h; ovr_1bfd_644a:58F8

   	     db	     008h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h  ; ovr_1bfd_644a:5906
   	     db	     007h,026h,0F6h,044h,002h,020h,075h,027h,057h,056h,033h,0C0h,050h,09Ah  ; ovr_1bfd_644a:5914
   	     dw	     02Ah
   	     dw	     seg CO003_TEXT
   	     db	     050h,09Ah
   	     dw	     048h
   	     dw	     seg CO007_TEXT
   	     db	     08Bh,0F8h,005h,014h; ovr_1bfd_644a:5922
   	     db	     000h,0FFh,036h,086h,081h,050h,08Dh,046h,0F4h,016h,050h,0B9h,006h,000h  ; ovr_1bfd_644a:5930
   	     db	     09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Eh,006h,086h,081h,026h,08Bh,05Dh,008h,08Eh; ovr_1bfd_644a:593E

   	     db	     006h,09Ah,063h,026h,083h,03Fh,00Ch,075h,006h,0B8h,0FAh,000h,0E9h,0B6h  ; ovr_1bfd_644a:594C
   	     db	     000h,056h,057h,09Ah
   	     dw	     0D4h
   	     dw	     seg CO023_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,09Ah,063h; ovr_1bfd_644a:595A
   	     db	     026h,08Bh,01Ch,0F6h,087h,0CAh,009h,040h,075h,02Bh,08Eh,006h,086h,081h  ; ovr_1bfd_644a:5968
   	     db	     026h,08Bh,05Dh,008h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h,087h,0CAh  ; ovr_1bfd_644a:5976
   	     db	     009h,040h,075h,015h,056h,08Eh,006h,086h,081h,026h,0FFh,075h,008h,0B0h  ; ovr_1bfd_644a:5984
   	     db	     000h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO023_TEXT
   	     db	     00Ah,0C0h,074h,05Fh,08Eh,006h,09Ah; ovr_1bfd_644a:5992
   	     db	     063h,026h,083h,03Ch,015h,075h,043h,056h,08Eh,006h,086h,081h,026h,0FFh  ; ovr_1bfd_644a:59A0
   	     db	     075h,008h,0B8h,001h,000h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO00A_TEXT
   	     db	     0B4h,000h,00Bh; ovr_1bfd_644a:59AE
   	     db	     0C0h,075h,02Bh,0B8h,084h,001h,050h,08Eh,006h,086h,081h,026h,0FFh,075h  ; ovr_1bfd_644a:59BC
   	     db	     008h,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,056h,09Ah
   	     dw	     043h
   	     dw	     seg CO021_TEXT
   	     db	     052h,050h,08Eh,006h,086h,081h,026h,0FFh,075h,016h,033h,0C0h,050h,09Ah  ; ovr_1bfd_644a:59D8
   	     dw	     052h
   	     dw	     seg CO019_TEXT
   	     db	     056h,057h,09Ah
   	     dw	     05Ch
   	     dw	     seg CO007_TEXT
   	     db	     050h,033h,0C0h; ovr_1bfd_644a:59E6
   	     db	     050h,09Ah
   	     dw	     020h
   	     dw	     seg CO007_TEXT
   	     db	     0EBh,01Ch,057h,0FFh,076h,00Ah,0FFh,076h; ovr_1bfd_644a:59F4

   	     db	     008h,0FFh,076h,006h,0B8h,04Dh,000h,050h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO005_TEXT
   	     db	     033h; ovr_1bfd_644a:5A02
   	     db	     0C0h,050h,057h,09Ah
   	     dw	     0CFh
   	     dw	     seg CO023_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh; ovr_1bfd_644a:5A10
   	     db	     008h,000h;	raw:5A1E
X012_07 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h,00Bh,0F6h,074h,01Fh,08Eh;	    ovr_1bfd_644a:5A1E
   	     db	     006h,028h,064h,026h,083h,07Ch,008h,000h,074h,014h,026h,0FFh,074h,008h  ; ovr_1bfd_644a:5A2C
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO02B_TEXT
   	     db	     050h,033h,0C0h,050h,09Ah
   	     dw	     0B6h
   	     dw	     seg CO023_TEXT
   	     db	     0EBh,002h,033h,0C0h,05Eh,05Dh,0CAh,002h,000h    ; ovr_1bfd_644a:5A48


CO012_TEXT	     ends
; END LG071
   	     end
