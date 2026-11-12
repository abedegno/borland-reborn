; Direct-segment relocation references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_SEG_180:far
		extrn	BCC_SEG_46:far
		extrn	BCC_SEG_47:far
		extrn	BCC_SEG_50:far
		extrn	__SEGTABLE__:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_2
; BEGIN RSTRLO2 (complete source RSTRLOW tail15 CODE_2:0000..000F)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2



		public	BCC_NEAR_0A78
		public	BCC_NEAR_0C89
		public	BCC_NEAR_0CF6
		public	HEAP_ALLOC_NODE

	db 046h
	db 006h
	db 0C4h
	db 05Eh
	db 006h
	db 026h
	db 080h
	db 03Fh
	db 000h
	db 075h
	db 0E1h
	db 05Dh
	db 0CAh
	db 004h
	db 000h
CODE_2 ends
; END RSTRLO2
; BEGIN RHCYCLE (complete source CODE_2:000F..0017)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2



	db 055h
	db 08Bh
	db 0ECh
	db 0E8h
	db 0FAh
	db 0FFh
	db 05Dh
	db 0C3h
CODE_2 ends
; END RHCYCLE
; BEGIN RG2A (raw CODE_2:0017..0233)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 008h
	db 057h
	db 0C7h
	db 046h
	db 0F8h
	db 000h
	db 000h
	db 08Bh
	db 01Eh
	db 03Ah
	db 000h
	db 08Bh
	db 047h
	db 008h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 0BAh
	db 016h
	db 000h
	db 0F7h
	db 0E2h
	db 003h
	db 046h
	db 0FEh
	db 073h
	db 003h
	db 0E9h
	db 08Fh
	db 000h
	db 089h
	db 046h
	db 0FCh
	db 0FFh
	db 036h
	db 03Ah
	db 000h
	db 0FFh
	db 076h
	db 0FCh
	db 0E8h
	db 086h
	db 014h
	db 089h
	db 046h
	db 0FAh
	db 00Bh
	db 0C0h
	db 075h
	db 003h
	db 0EBh
	db 079h
	db 090h
	db 0A3h
	db 03Ah
	db 000h
	db 0A1h
	db 03Ch
	db 000h
	db 089h
	db 046h
	db 0FAh
	db 083h
	db 07Eh
	db 0FAh
	db 000h
	db 074h
	db 01Ch
	db 0EBh
	db 009h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 010h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 05Eh
	db 0FAh
	db 083h
	db 07Fh
	db 010h
	db 000h
	db 075h
	db 0EEh
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 010h
	db 0EBh
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 03Ch
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 046h
	db 0FAh
	db 01Eh
	db 007h
	db 057h
	db 08Bh
	db 04Eh
	db 0FCh
	db 02Bh
	db 04Eh
	db 0FAh
	db 08Bh
	db 07Eh
	db 0FEh
	db 033h
	db 0C0h
	db 0FCh
	db 0F3h
	db 0AAh
	db 05Fh
	db 0EBh
	db 010h
	db 08Bh
	db 046h
	db 0FAh
	db 005h
	db 016h
	db 000h
	db 08Bh
	db 05Eh
	db 0FAh
	db 089h
	db 047h
	db 010h
	db 083h
	db 046h
	db 0FAh
	db 016h
	db 08Bh
	db 046h
	db 0FAh
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 0E8h
	db 083h
	db 06Eh
	db 0FAh
	db 016h
	db 08Bh
	db 05Eh
	db 0FAh
	db 0C7h
	db 047h
	db 010h
	db 000h
	db 000h
	db 08Bh
	db 046h
	db 004h
	db 001h
	db 006h
	db 03Eh
	db 000h
	db 0EBh
	db 005h
	db 0C7h
	db 046h
	db 0F8h
	db 001h
	db 010h
	db 08Bh
	db 046h
	db 0F8h
	db 05Fh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 08Ah
	db 01Eh
	db 0C6h
	db 006h
	db 032h
	db 0FFh
	db 0FEh
	db 0CBh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0D1h
	db 0EBh
	db 0E3h
	db 027h
	db 006h
	db 053h
	db 089h
	db 04Eh
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 016h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 071h
	db 009h
	db 08Bh
	db 046h
	db 004h
	db 048h
	db 089h
	db 046h
	db 004h
	db 00Bh
	db 0C0h
	db 075h
	db 005h
	db 083h
	db 0C4h
	db 004h
	db 0EBh
	db 009h
	db 05Bh
	db 007h
	db 026h
	db 03Ah
	db 01Eh
	db 0C6h
	db 006h
	db 075h
	db 0C5h
	db 0B8h
	db 0FFh
	db 0FFh
	db 050h
	db 0FFh
	db 016h
	db 026h
	db 000h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
BCC_NEAR_0A78	label	near
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 006h
	db 0C6h
	db 046h
	db 0FFh
	db 000h
	db 01Eh
	db 0E9h
	db 0DCh
	db 000h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 0A1h
	db 040h
	db 000h
	db 005h
	db 008h
	db 000h
	db 03Bh
	db 006h
	db 03Eh
	db 000h
	db 077h
	db 003h
	db 0E9h
	db 0BFh
	db 000h
	db 080h
	db 07Eh
	db 0FFh
	db 000h
	db 075h
	db 00Ah
	db 0B8h
	db 014h
	db 000h
	db 050h
	db 0E8h
	db 0ACh
	db 0FEh
	db 0E9h
	db 0AAh
	db 000h
	db 080h
	db 07Eh
	db 0FFh
	db 001h
	db 074h
	db 003h
	db 0E9h
	db 094h
	db 000h
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0E9h
	db 081h
	db 000h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Bh
	db 05Eh
	db 0FCh
	db 0D1h
	db 0E3h
	db 08Bh
	db 08Fh
	db 0CAh
	db 006h
	db 0E3h
	db 06Eh
	db 08Eh
	db 0D9h
	db 083h
	db 07Eh
	db 0FCh
	db 005h
	db 074h
	db 066h
	db 083h
	db 07Eh
	db 0FCh
	db 001h
	db 074h
	db 006h
	db 083h
	db 07Eh
	db 0FCh
	db 002h
	db 075h
	db 052h
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h
	db 026h
	db 0A0h
	db 0FBh
	db 006h
	db 088h
	db 046h
	db 0FBh
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h
	db 026h
	db 0A0h
	db 0FCh
	db 006h
	db 088h
	db 046h
	db 0FAh
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h
	db 026h
	db 0C6h
	db 006h
	db 0FBh
	db 006h
	db 000h
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h
	db 026h
	db 0C6h
	db 006h
	db 0FCh
	db 006h
	db 001h
	db 0B8h
	db 0FFh
	db 0FFh
	db 050h
	db 0FFh
	db 016h
	db 026h
	db 000h
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Ah
	db 056h
	db 0FBh
	db 08Eh
	db 0C0h
	db 026h
	db 088h
	db 016h
	db 0FBh
	db 006h
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Ah
	db 056h
	db 0FAh
	db 08Eh
	db 0C0h
	db 026h
	db 088h
	db 016h
	db 0FCh
	db 006h
	db 0EBh
	db 008h
	db 0B8h
	db 0FFh
	db 0FFh
	db 050h
	db 0FFh
	db 016h
	db 026h
	db 000h
	db 0FFh
	db 046h
	db 0FCh
	db 083h
	db 07Eh
	db 0FCh
	db 006h
	db 07Dh
	db 003h
	db 0E9h
	db 076h
	db 0FFh
	db 0EBh
	db 00Dh
	db 080h
	db 07Eh
	db 0FFh
	db 002h
	db 075h
	db 007h
	db 0B8h
	db 014h
	db 000h
	db 050h
	db 0E8h
	db 0C3h
	db 0FEh
	db 0FEh
	db 046h
	db 0FFh
	db 0EBh
	db 005h
	db 01Fh
	db 033h
	db 0C0h
	db 0EBh
	db 00Dh
	db 080h
	db 07Eh
	db 0FFh
	db 005h
	db 073h
	db 003h
	db 0E9h
	db 01Bh
	db 0FFh
	db 01Fh
	db 0B8h
	db 001h
	db 010h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C3h
CODE_2 ends
; END RG2A
; BEGIN RNEWNODE (complete source CODE_2:0233..0266)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 01Eh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 0A1h
	db 03Ch
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 010h
	db 0A3h
	db 03Ch
	db 000h
	db 0C7h
	db 047h
	db 010h
	db 000h
	db 000h
	db 0FFh
	db 00Eh
	db 03Eh
	db 000h
	db 01Fh
	db 08Bh
	db 046h
	db 0FEh
	db 02Bh
	db 006h
	db 020h
	db 000h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C3h
CODE_2 ends
; END RNEWNODE
; BEGIN RRETNDES (complete source CODE_2:0266..02B1)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 004h
	db 08Bh
	db 05Fh
	db 006h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 05Fh
	db 004h
	db 089h
	db 047h
	db 006h
	db 01Eh
	db 0A1h
	db 020h
	db 000h
	db 001h
	db 046h
	db 004h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 033h
	db 0C0h
	db 089h
	db 047h
	db 00Eh
	db 089h
	db 047h
	db 004h
	db 0A1h
	db 03Ch
	db 000h
	db 089h
	db 047h
	db 010h
	db 08Bh
	db 046h
	db 004h
	db 0A3h
	db 03Ch
	db 000h
	db 0FFh
	db 006h
	db 03Eh
	db 000h
	db 01Fh
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RRETNDES
; BEGIN RG2A2 (raw CODE_2:02B1..0349)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 006h
	db 057h
	db 0FFh
	db 036h
	db 032h
	db 000h
	db 0E8h
	db 063h
	db 00Fh
	db 089h
	db 046h
	db 0FEh
	db 083h
	db 07Eh
	db 0FEh
	db 000h
	db 075h
	db 003h
	db 0EBh
	db 078h
	db 090h
	db 08Bh
	db 05Eh
	db 0FEh
	db 081h
	db 04Fh
	db 00Ah
	db 008h
	db 080h
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0FCh
	db 0C6h
	db 047h
	db 00Ch
	db 000h
	db 0C7h
	db 046h
	db 0FAh
	db 000h
	db 000h
	db 0C4h
	db 05Eh
	db 0FAh
	db 08Bh
	db 046h
	db 0FCh
	db 026h
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 046h
	db 0FCh
	db 08Bh
	db 056h
	db 0FAh
	db 042h
	db 042h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 047h
	db 010h
	db 089h
	db 057h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 07Bh
	db 02Bh
	db 0C4h
	db 05Eh
	db 0FAh
	db 026h
	db 0C7h
	db 047h
	db 004h
	db 000h
	db 000h
	db 0A1h
	db 030h
	db 000h
	db 026h
	db 089h
	db 007h
	db 08Bh
	db 046h
	db 0FCh
	db 0A3h
	db 030h
	db 000h
	db 026h
	db 0C7h
	db 047h
	db 006h
	db 00Ah
	db 000h
	db 057h
	db 0C4h
	db 07Eh
	db 0FAh
	db 08Bh
	db 016h
	db 032h
	db 000h
	db 083h
	db 0C7h
	db 008h
	db 0FCh
	db 033h
	db 0C0h
	db 0ABh
	db 08Dh
	db 045h
	db 004h
	db 0ABh
	db 03Bh
	db 0FAh
	db 072h
	db 0F5h
	db 026h
	db 0C7h
	db 045h
	db 0FEh
	db 000h
	db 000h
	db 05Fh
	db 08Ch
	db 0C0h
	db 0EBh
	db 002h
	db 033h
	db 0C0h
	db 05Fh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C3h
CODE_2 ends
; END RG2A2
; BEGIN RH0349 (complete source CODE_2:0349..03B6)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
BCC_NEAR_0C89	label	near
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 008h
	db 056h
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0A1h
	db 030h
	db 000h
	db 0EBh
	db 010h
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 083h
	db 07Fh
	db 006h
	db 000h
	db 075h
	db 01Fh
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0FEh
	db 083h
	db 07Eh
	db 0FEh
	db 000h
	db 075h
	db 0E7h
	db 0E8h
	db 03Bh
	db 0FFh
	db 089h
	db 046h
	db 0FEh
	db 00Bh
	db 0C0h
	db 075h
	db 006h
	db 033h
	db 0D2h
	db 033h
	db 0C0h
	db 0EBh
	db 02Eh
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 0FFh
	db 047h
	db 004h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 046h
	db 0FAh
	db 026h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0F8h
	db 006h
	db 0C4h
	db 076h
	db 0F8h
	db 026h
	db 08Bh
	db 004h
	db 007h
	db 026h
	db 089h
	db 047h
	db 006h
	db 0C4h
	db 05Eh
	db 0F8h
	db 026h
	db 0C7h
	db 007h
	db 000h
	db 000h
	db 08Bh
	db 056h
	db 0FAh
	db 08Bh
	db 046h
	db 0F8h
	db 05Eh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C3h
CODE_2 ends
; END RH0349
; BEGIN RH03B6 (complete source CODE_2:03B6..0456)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	assume cs:CODE_2
BCC_NEAR_0CF6	label	near
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 00Ah
	db 01Eh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 08Bh
	db 047h
	db 004h
	db 048h
	db 026h
	db 089h
	db 047h
	db 004h
	db 00Bh
	db 0C0h
	db 075h
	db 057h
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 030h
	db 000h
	db 075h
	db 008h
	db 026h
	db 08Bh
	db 007h
	db 0A3h
	db 030h
	db 000h
	db 0EBh
	db 02Dh
	db 0A1h
	db 030h
	db 000h
	db 089h
	db 046h
	db 0F8h
	db 0C7h
	db 046h
	db 0F6h
	db 000h
	db 000h
	db 0EBh
	db 009h
	db 0C4h
	db 05Eh
	db 0F6h
	db 026h
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0F8h
	db 0C4h
	db 05Eh
	db 0F6h
	db 026h
	db 08Bh
	db 007h
	db 03Bh
	db 046h
	db 0FEh
	db 075h
	db 0ECh
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 08Bh
	db 007h
	db 0C4h
	db 05Eh
	db 0F6h
	db 026h
	db 089h
	db 007h
	db 01Eh
	db 08Eh
	db 01Eh
	db 00Ah
	db 000h
	db 0FFh
	db 076h
	db 0FEh
	db 016h
	db 08Dh
	db 046h
	db 0FAh
	db 050h
	db 0E8h
	db 092h
	db 02Ah
	db 01Fh
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 00Fh
	db 004h
	db 0EBh
	db 017h
	db 0C4h
	db 05Eh
	db 0FCh
	db 026h
	db 08Bh
	db 047h
	db 006h
	db 0C4h
	db 05Eh
	db 004h
	db 026h
	db 089h
	db 007h
	db 0C4h
	db 05Eh
	db 0FCh
	db 08Bh
	db 046h
	db 004h
	db 026h
	db 089h
	db 047h
	db 006h
	db 01Fh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 004h
	db 000h

CODE_2 ends
; END RH03B6
; BEGIN RHSWAP (complete source CODE_2:0456..04B8)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 05Fh
	db 004h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 007h
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 004h
	db 001h
	db 007h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RHSWAP
; BEGIN RG2A4 (raw CODE_2:04B8..0506)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 056h
	db 057h
	db 01Eh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Bh
	db 05Eh
	db 008h
	db 0D1h
	db 0E3h
	db 08Eh
	db 09Fh
	db 0CAh
	db 006h
	db 083h
	db 07Eh
	db 004h
	db 000h
	db 075h
	db 006h
	db 0E8h
	db 05Eh
	db 0FDh
	db 089h
	db 046h
	db 004h
	db 08Ch
	db 0D8h
	db 08Eh
	db 0C0h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Bh
	db 05Eh
	db 00Ah
	db 0D1h
	db 0E3h
	db 08Eh
	db 09Fh
	db 0CAh
	db 006h
	db 08Bh
	db 076h
	db 006h
	db 08Bh
	db 07Eh
	db 004h
	db 083h
	db 0C6h
	db 00Ah
	db 083h
	db 0C7h
	db 00Ah
	db 0B9h
	db 006h
	db 000h
	db 0FCh
	db 0F3h
	db 0A5h
	db 01Fh
	db 08Bh
	db 046h
	db 004h
	db 05Fh
	db 05Eh
	db 05Dh
	db 0C2h
	db 008h
	db 000h
CODE_2 ends
; END RG2A4
; BEGIN RHFADD (complete source CODE_2:0506..054E)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 0A1h
	db 012h
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 010h
	db 08Bh
	db 05Eh
	db 004h
	db 089h
	db 047h
	db 010h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 00Eh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 010h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 05Fh
	db 010h
	db 089h
	db 047h
	db 00Eh
	db 08Bh
	db 05Eh
	db 004h
	db 0C7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 0FFh
	db 006h
	db 018h
	db 000h
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 006h
	db 01Ah
	db 000h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RHFADD
; BEGIN RHUNLINK (complete source CODE_2:054E..057B)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 00Eh
	db 08Bh
	db 05Fh
	db 010h
	db 089h
	db 047h
	db 00Eh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 010h
	db 08Bh
	db 05Fh
	db 00Eh
	db 089h
	db 047h
	db 010h
	db 0FFh
	db 00Eh
	db 018h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 01Ah
	db 000h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RHUNLINK
; BEGIN RHLINK (complete source CODE_2:057B..05A3)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 006h
	db 089h
	db 047h
	db 006h
	db 05Dh
	db 0C2h
	db 004h
	db 000h
CODE_2 ends
; END RHLINK
; BEGIN RHSETCUR (complete source CODE_2:05A3..05D5)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 00Ch
	db 000h
	db 08Bh
	db 01Eh
	db 00Ch
	db 000h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 00Eh
	db 08Bh
	db 01Eh
	db 00Ch
	db 000h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 006h
	db 0A1h
	db 014h
	db 000h
	db 0A3h
	db 00Ch
	db 000h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RHSETCUR
; BEGIN RG2A1 (raw CODE_2:05D5..077F)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 08Bh
	db 05Eh
	db 008h
	db 08Bh
	db 047h
	db 002h
	db 02Bh
	db 046h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 008h
	db 089h
	db 046h
	db 0FCh
	db 08Ah
	db 046h
	db 004h
	db 0B4h
	db 000h
	db 00Bh
	db 0C0h
	db 075h
	db 006h
	db 0FFh
	db 076h
	db 008h
	db 0E8h
	db 052h
	db 0FFh
	db 083h
	db 07Eh
	db 0FEh
	db 000h
	db 076h
	db 04Ah
	db 0E8h
	db 02Eh
	db 0FCh
	db 089h
	db 046h
	db 0FCh
	db 08Bh
	db 05Eh
	db 0FCh
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 008h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 007h
	db 003h
	db 046h
	db 006h
	db 08Bh
	db 05Eh
	db 0FCh
	db 089h
	db 007h
	db 0FFh
	db 076h
	db 008h
	db 0FFh
	db 076h
	db 0FCh
	db 0E8h
	db 04Eh
	db 0FFh
	db 08Bh
	db 05Eh
	db 0FCh
	db 0C7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 08Ah
	db 046h
	db 004h
	db 0B4h
	db 000h
	db 00Bh
	db 0C0h
	db 075h
	db 021h
	db 0FFh
	db 076h
	db 0FCh
	db 0E8h
	db 0C2h
	db 0FEh
	db 08Bh
	db 046h
	db 0FCh
	db 0A3h
	db 01Ch
	db 000h
	db 0EBh
	db 013h
	db 08Ah
	db 046h
	db 004h
	db 0B4h
	db 000h
	db 00Bh
	db 0C0h
	db 075h
	db 00Ah
	db 08Bh
	db 01Eh
	db 012h
	db 000h
	db 08Bh
	db 047h
	db 010h
	db 0A3h
	db 01Ch
	db 000h
	db 08Bh
	db 05Eh
	db 008h
	db 0C7h
	db 047h
	db 00Ah
	db 000h
	db 000h
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 0A0h
	db 0C0h
	db 006h
	db 08Bh
	db 05Eh
	db 008h
	db 088h
	db 047h
	db 00Ch
	db 0A0h
	db 004h
	db 000h
	db 088h
	db 047h
	db 013h
	db 0C6h
	db 047h
	db 012h
	db 000h
	db 08Bh
	db 046h
	db 0FCh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 006h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 05Fh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 00Bh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 004h
	db 0EBh
	db 05Ah
	db 0EBh
	db 058h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0A1h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 004h
	db 001h
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 006h
	db 01Ah
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 00Ch
	db 000h
	db 075h
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 0A3h
	db 00Ch
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 01Ch
	db 000h
	db 075h
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 0A3h
	db 01Ch
	db 000h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 067h
	db 0FBh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 075h
	db 095h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 08Bh
	db 05Eh
	db 004h
	db 0C7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 08Bh
	db 05Fh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 00Bh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 004h
	db 0EBh
	db 02Ch
	db 0EBh
	db 02Ah
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 004h
	db 001h
	db 047h
	db 002h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 000h
	db 0FBh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 075h
	db 0C3h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RG2A1
; BEGIN RH077F (complete source CODE_2:077F..07D4)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 083h
	db 067h
	db 00Ah
	db 0F7h
	db 08Bh
	db 047h
	db 006h
	db 03Bh
	db 006h
	db 014h
	db 000h
	db 075h
	db 03Ch
	db 0EBh
	db 019h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 062h
	db 0FDh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 004h
	db 08Bh
	db 046h
	db 004h
	db 03Bh
	db 006h
	db 00Eh
	db 000h
	db 074h
	db 00Ah
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 000h
	db 074h
	db 0D4h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 014h
	db 000h
	db 0B8h
	db 001h
	db 000h
	db 0EBh
	db 002h
	db 033h
	db 0C0h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH077F
; BEGIN RH07D4 (complete source CODE_2:07D4..0826)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2


	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 083h
	db 067h
	db 00Ah
	db 0EFh
	db 08Bh
	db 046h
	db 004h
	db 03Bh
	db 006h
	db 016h
	db 000h
	db 075h
	db 039h
	db 0EBh
	db 019h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 00Dh
	db 0FDh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 004h
	db 08Bh
	db 046h
	db 004h
	db 03Bh
	db 006h
	db 010h
	db 000h
	db 074h
	db 00Ah
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 000h
	db 074h
	db 0D4h
	db 08Bh
	db 046h
	db 004h
	db 0A3h
	db 016h
	db 000h
	db 0B8h
	db 001h
	db 000h
	db 0EBh
	db 002h
	db 033h
	db 0C0h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH07D4
; BEGIN RH0826 (complete source CODE_2:0826..0845)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 008h
	db 000h
	db 074h
	db 008h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 046h
	db 0FFh
	db 0EBh
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 093h
	db 0FFh
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH0826
; BEGIN RH0845 (complete source CODE_2:0845..08ED)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 0C7h
	db 046h
	db 0FEh
	db 001h
	db 000h
	db 0F6h
	db 006h
	db 005h
	db 000h
	db 004h
	db 074h
	db 015h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 060h
	db 000h
	db 074h
	db 00Bh
	db 0FFh
	db 00Eh
	db 040h
	db 000h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 042h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 020h
	db 074h
	db 019h
	db 0FFh
	db 077h
	db 014h
	db 0B8h
	db 001h
	db 000h
	db 050h
	db 08Ah
	db 047h
	db 013h
	db 0B4h
	db 000h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 050h
	db 0E8h
	db 053h
	db 025h
	db 083h
	db 0C4h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 010h
	db 074h
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 06Dh
	db 003h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 000h
	db 074h
	db 009h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 078h
	db 0FFh
	db 089h
	db 046h
	db 0FEh
	db 083h
	db 07Eh
	db 0FEh
	db 000h
	db 074h
	db 028h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 01Bh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 02Fh
	db 0FCh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0ABh
	db 0FDh
	db 0EBh
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 033h
	db 0FEh
	db 033h
	db 0C0h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH0845
; BEGIN RG2A6 (raw CODE_2:08ED..0C40)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2


	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 020h
	db 074h
	db 033h
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 08Ah
	db 047h
	db 013h
	db 0B4h
	db 000h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 047h
	db 014h
	db 089h
	db 046h
	db 0FAh
	db 0FFh
	db 076h
	db 004h
	db 0B8h
	db 004h
	db 000h
	db 050h
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 08Bh
	db 047h
	db 00Ah
	db 025h
	db 000h
	db 004h
	db 050h
	db 0E8h
	db 034h
	db 03Bh
	db 0E9h
	db 08Fh
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 00Ah
	db 025h
	db 003h
	db 000h
	db 040h
	db 089h
	db 046h
	db 0FCh
	db 0C7h
	db 046h
	db 0FEh
	db 004h
	db 000h
	db 0EBh
	db 068h
	db 08Bh
	db 05Eh
	db 004h
	db 0FFh
	db 077h
	db 008h
	db 033h
	db 0C0h
	db 050h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 08Bh
	db 024h
	db 083h
	db 0C4h
	db 006h
	db 089h
	db 046h
	db 0FAh
	db 00Bh
	db 0C0h
	db 074h
	db 04Ch
	db 08Bh
	db 05Eh
	db 004h
	db 080h
	db 07Fh
	db 012h
	db 000h
	db 074h
	db 02Ch
	db 0FFh
	db 076h
	db 004h
	db 0B0h
	db 004h
	db 050h
	db 0E8h
	db 011h
	db 025h
	db 0FFh
	db 076h
	db 004h
	db 0B8h
	db 004h
	db 000h
	db 050h
	db 08Bh
	db 05Eh
	db 004h
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 08Bh
	db 047h
	db 00Ah
	db 025h
	db 000h
	db 004h
	db 050h
	db 0E8h
	db 0D8h
	db 03Ah
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 0FFh
	db 037h
	db 0FFh
	db 076h
	db 0FAh
	db 0B8h
	db 002h
	db 000h
	db 050h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 03Ah
	db 024h
	db 083h
	db 0C4h
	db 008h
	db 0EBh
	db 00Bh
	db 0FFh
	db 04Eh
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 0FCh
	db 07Dh
	db 090h
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 0FCh
	db 07Dh
	db 003h
	db 0E9h
	db 0BAh
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 060h
	db 000h
	db 074h
	db 00Bh
	db 0FFh
	db 00Eh
	db 040h
	db 000h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 042h
	db 000h
	db 0A1h
	db 042h
	db 000h
	db 0D1h
	db 0E8h
	db 0D1h
	db 0E8h
	db 03Bh
	db 006h
	db 038h
	db 000h
	db 076h
	db 003h
	db 0E8h
	db 07Bh
	db 003h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 010h
	db 074h
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 017h
	db 002h
	db 033h
	db 0C0h
	db 050h
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 004h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0B5h
	db 0FAh
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 007h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 034h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 01Bh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0D2h
	db 0FAh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 04Eh
	db 0FCh
	db 0EBh
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0D6h
	db 0FCh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0D1h
	db 0E3h
	db 08Eh
	db 09Fh
	db 0CAh
	db 006h
	db 08Bh
	db 05Eh
	db 0FAh
	db 0A0h
	db 004h
	db 000h
	db 088h
	db 047h
	db 013h
	db 081h
	db 067h
	db 00Ah
	db 0FFh
	db 0DFh
	db 081h
	db 04Fh
	db 00Ah
	db 080h
	db 000h
	db 0FFh
	db 076h
	db 0FAh
	db 0B0h
	db 002h
	db 050h
	db 0E8h
	db 014h
	db 024h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 033h
	db 0C0h
	db 0EBh
	db 003h
	db 0B8h
	db 000h
	db 010h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0FFh
	db 076h
	db 004h
	db 0B0h
	db 004h
	db 050h
	db 0E8h
	db 0EAh
	db 023h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 020h
	db 074h
	db 021h
	db 0FFh
	db 077h
	db 014h
	db 0B8h
	db 001h
	db 000h
	db 050h
	db 08Ah
	db 047h
	db 013h
	db 0B4h
	db 000h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 0D1h
	db 0F8h
	db 050h
	db 0E8h
	db 028h
	db 023h
	db 083h
	db 0C4h
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 081h
	db 067h
	db 00Ah
	db 0FFh
	db 0DFh
	db 0A1h
	db 042h
	db 000h
	db 0D1h
	db 0E8h
	db 0D1h
	db 0E8h
	db 03Bh
	db 006h
	db 038h
	db 000h
	db 076h
	db 003h
	db 0E8h
	db 08Eh
	db 002h
	db 08Bh
	db 05Eh
	db 004h
	db 080h
	db 07Fh
	db 012h
	db 000h
	db 074h
	db 016h
	db 0FFh
	db 076h
	db 004h
	db 0B8h
	db 001h
	db 000h
	db 050h
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 033h
	db 0C0h
	db 050h
	db 0E8h
	db 074h
	db 039h
	db 089h
	db 046h
	db 0FCh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 083h
	db 07Eh
	db 0FCh
	db 000h
	db 074h
	db 003h
	db 0E9h
	db 0DBh
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 0FFh
	db 077h
	db 008h
	db 033h
	db 0C0h
	db 050h
	db 0B8h
	db 005h
	db 000h
	db 050h
	db 0E8h
	db 0CCh
	db 022h
	db 083h
	db 0C4h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 00Bh
	db 0C0h
	db 075h
	db 003h
	db 0E9h
	db 0B9h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 010h
	db 074h
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0DCh
	db 000h
	db 033h
	db 0C0h
	db 050h
	db 0B8h
	db 005h
	db 000h
	db 050h
	db 0FFh
	db 076h
	db 004h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 079h
	db 0F9h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 007h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 034h
	db 000h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0D4h
	db 006h
	db 08Bh
	db 05Eh
	db 0FEh
	db 081h
	db 04Fh
	db 00Ah
	db 000h
	db 001h
	db 0A0h
	db 004h
	db 000h
	db 088h
	db 047h
	db 013h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 00Fh
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 0E8h
	db 0D3h
	db 044h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 047h
	db 008h
	db 0FFh
	db 076h
	db 0FEh
	db 0B0h
	db 002h
	db 050h
	db 0E8h
	db 0FAh
	db 022h
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 08Eh
	db 01Eh
	db 0CAh
	db 006h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 060h
	db 000h
	db 074h
	db 00Bh
	db 0FFh
	db 00Eh
	db 040h
	db 000h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 042h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 01Bh
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 042h
	db 0F9h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0BEh
	db 0FAh
	db 0EBh
	db 037h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 046h
	db 0FBh
	db 0EBh
	db 02Fh
	db 0EBh
	db 02Dh
	db 0EBh
	db 02Bh
	db 0B8h
	db 000h
	db 010h
	db 0EBh
	db 028h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 040h
	db 074h
	db 00Bh
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 0E8h
	db 0C6h
	db 0F7h
	db 0EBh
	db 00Bh
	db 08Bh
	db 05Eh
	db 004h
	db 0C4h
	db 05Fh
	db 00Eh
	db 026h
	db 0C7h
	db 007h
	db 000h
	db 000h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 042h
	db 0FCh
	db 033h
	db 0C0h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 08Ah
	db 05Fh
	db 00Dh
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 026h
	db 0C7h
	db 087h
	db 0A6h
	db 05Ch
	db 000h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 008h
	db 074h
	db 007h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 038h
	db 000h
	db 08Bh
	db 05Eh
	db 004h
	db 081h
	db 067h
	db 00Ah
	db 0FFh
	db 0E7h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RG2A6
; BEGIN RH0C40 (complete source CODE_2:0C40..0C86)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 080h
	db 075h
	db 035h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 013h
	db 0FFh
	db 076h
	db 004h
	db 0B8h
	db 006h
	db 000h
	db 050h
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 033h
	db 0C0h
	db 050h
	db 0E8h
	db 0F7h
	db 037h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 006h
	db 038h
	db 000h
	db 081h
	db 04Fh
	db 00Ah
	db 000h
	db 008h
	db 0FFh
	db 076h
	db 004h
	db 0B0h
	db 002h
	db 050h
	db 0E8h
	db 0FEh
	db 021h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH0C40
; BEGIN RH0C86 (complete source CODE_2:0C86..0CCC)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 008h
	db 074h
	db 035h
	db 081h
	db 067h
	db 00Ah
	db 0FFh
	db 0F7h
	db 0FFh
	db 076h
	db 004h
	db 0B0h
	db 004h
	db 050h
	db 0E8h
	db 0DFh
	db 021h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 013h
	db 0FFh
	db 076h
	db 004h
	db 0B8h
	db 007h
	db 000h
	db 050h
	db 0FFh
	db 077h
	db 010h
	db 0FFh
	db 077h
	db 00Eh
	db 033h
	db 0C0h
	db 050h
	db 0E8h
	db 0A3h
	db 037h
	db 08Bh
	db 05Eh
	db 004h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 006h
	db 038h
	db 000h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH0C86
; BEGIN RG2A8 (raw CODE_2:0CCC..0D8E)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 0FEh
	db 00Eh
	db 0C6h
	db 006h
	db 026h
	db 08Ah
	db 01Eh
	db 0C6h
	db 006h
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0E3h
	db 008h
	db 051h
	db 0E8h
	db 01Fh
	db 0FFh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 080h
	db 07Eh
	db 004h
	db 000h
	db 075h
	db 00Dh
	db 026h
	db 0A0h
	db 0C8h
	db 006h
	db 026h
	db 02Ah
	db 006h
	db 0C7h
	db 006h
	db 03Ch
	db 003h
	db 077h
	db 01Dh
	db 026h
	db 0FEh
	db 00Eh
	db 0C7h
	db 006h
	db 026h
	db 08Ah
	db 01Eh
	db 0C7h
	db 006h
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0E3h
	db 008h
	db 051h
	db 0E8h
	db 024h
	db 0FFh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 0FEh
	db 00Eh
	db 0C8h
	db 006h
	db 026h
	db 08Ah
	db 01Eh
	db 0C8h
	db 006h
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0E3h
	db 008h
	db 051h
	db 0E8h
	db 04Dh
	db 0FFh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 08Ah
	db 01Eh
	db 0C6h
	db 006h
	db 08Ah
	db 0CBh
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 08Bh
	db 046h
	db 006h
	db 026h
	db 089h
	db 087h
	db 0A6h
	db 05Ch
	db 08Bh
	db 05Eh
	db 006h
	db 088h
	db 04Fh
	db 00Dh
	db 081h
	db 04Fh
	db 00Ah
	db 000h
	db 010h
	db 05Dh
	db 0C2h
	db 004h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 0A0h
	db 0C7h
	db 006h
	db 026h
	db 02Ah
	db 006h
	db 0C6h
	db 006h
	db 03Ch
	db 003h
	db 072h
	db 019h
	db 026h
	db 0FEh
	db 00Eh
	db 0C7h
	db 006h
	db 026h
	db 08Ah
	db 01Eh
	db 0C7h
	db 006h
	db 032h
	db 0FFh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0E3h
	db 004h
	db 051h
	db 0E8h
	db 0B4h
	db 0FEh
	db 05Dh
	db 0C3h
CODE_2 ends
; END RG2A8
; BEGIN RH0D8E (complete source CODE_2:0D8E..0DCB)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 0A1h
	db 034h
	db 000h
	db 02Bh
	db 006h
	db 036h
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 083h
	db 07Eh
	db 0FEh
	db 000h
	db 07Dh
	db 019h
	db 0A0h
	db 005h
	db 000h
	db 00Ch
	db 040h
	db 0A2h
	db 005h
	db 000h
	db 0F6h
	db 006h
	db 005h
	db 000h
	db 001h
	db 074h
	db 002h
	db 0EBh
	db 010h
	db 0A1h
	db 01Ah
	db 000h
	db 003h
	db 046h
	db 0FEh
	db 0EBh
	db 00Bh
	db 0A0h
	db 005h
	db 000h
	db 024h
	db 0BFh
	db 0A2h
	db 005h
	db 000h
	db 0A1h
	db 01Ah
	db 000h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C3h
CODE_2 ends
; END RH0D8E
; BEGIN RH0DCB (complete source CODE_2:0DCB..0E22)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 0F6h
	db 006h
	db 005h
	db 000h
	db 040h
	db 074h
	db 016h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 004h
	db 074h
	db 00Ch
	db 0A0h
	db 005h
	db 000h
	db 0B4h
	db 000h
	db 0A9h
	db 001h
	db 000h
	db 075h
	db 002h
	db 0EBh
	db 030h
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 020h
	db 000h
	db 074h
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0F2h
	db 0FAh
	db 00Bh
	db 0C0h
	db 075h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 01Bh
	db 08Bh
	db 05Eh
	db 004h
	db 0F7h
	db 047h
	db 00Ah
	db 040h
	db 000h
	db 074h
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 06Fh
	db 0FCh
	db 00Bh
	db 0C0h
	db 075h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 003h
	db 0B8h
	db 002h
	db 010h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH0DCB
; BEGIN RG2A7 (raw CODE_2:0E22..0F0A)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2


	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 0C6h
	db 046h
	db 0FDh
	db 001h
	db 08Bh
	db 046h
	db 008h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 01Ch
	db 080h
	db 075h
	db 05Bh
	db 0F7h
	db 047h
	db 00Ah
	db 000h
	db 010h
	db 074h
	db 01Ah
	db 08Ah
	db 047h
	db 00Dh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 02Ah
	db 006h
	db 0C6h
	db 006h
	db 026h
	db 08Ah
	db 026h
	db 0C7h
	db 006h
	db 026h
	db 02Ah
	db 026h
	db 0C6h
	db 006h
	db 03Ah
	db 0C4h
	db 072h
	db 03Ah
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 068h
	db 0FFh
	db 00Bh
	db 0C0h
	db 075h
	db 00Dh
	db 0E8h
	db 024h
	db 0FFh
	db 03Bh
	db 046h
	db 00Ah
	db 072h
	db 005h
	db 033h
	db 0C0h
	db 0E9h
	db 090h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 083h
	db 07Fh
	db 004h
	db 000h
	db 075h
	db 01Ah
	db 0EBh
	db 009h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 083h
	db 07Fh
	db 004h
	db 000h
	db 074h
	db 0EEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 004h
	db 075h
	db 08Dh
	db 080h
	db 07Eh
	db 0FDh
	db 000h
	db 074h
	db 00Dh
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 0C6h
	db 046h
	db 0FDh
	db 000h
	db 0E9h
	db 07Ah
	db 0FFh
	db 08Eh
	db 006h
	db 00Ah
	db 000h
	db 026h
	db 08Ah
	db 01Eh
	db 0C6h
	db 006h
	db 032h
	db 0FFh
	db 0FEh
	db 0CBh
	db 0D1h
	db 0E3h
	db 026h
	db 08Bh
	db 08Fh
	db 0A6h
	db 05Ch
	db 0D1h
	db 0EBh
	db 0E3h
	db 02Ah
	db 006h
	db 053h
	db 089h
	db 04Eh
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 080h
	db 075h
	db 019h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0E6h
	db 0FEh
	db 00Bh
	db 0C0h
	db 075h
	db 00Fh
	db 0E8h
	db 0A2h
	db 0FEh
	db 03Bh
	db 046h
	db 00Ah
	db 072h
	db 007h
	db 083h
	db 0C4h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 00Ch
	db 05Bh
	db 007h
	db 026h
	db 03Ah
	db 01Eh
	db 0C6h
	db 006h
	db 075h
	db 0C2h
	db 0B8h
	db 000h
	db 010h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 008h
	db 000h
CODE_2 ends
; END RG2A7
; BEGIN RH0F0A (complete source CODE_2:0F0A..100A)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 008h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0EBh
	db 019h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 006h
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 046h
	db 0FCh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 006h
	db 074h
	db 008h
	db 08Bh
	db 046h
	db 0FCh
	db 03Bh
	db 046h
	db 008h
	db 072h
	db 0D7h
	db 083h
	db 07Eh
	db 0FCh
	db 000h
	db 075h
	db 003h
	db 0E9h
	db 0A6h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 046h
	db 0F8h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 0A3h
	db 014h
	db 000h
	db 0EBh
	db 044h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 017h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0F8h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0CFh
	db 0F5h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0E1h
	db 0F2h
	db 08Bh
	db 046h
	db 0F8h
	db 0EBh
	db 020h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 007h
	db 03Bh
	db 046h
	db 0FAh
	db 074h
	db 00Ah
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 016h
	db 02Ch
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 046h
	db 0FAh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 004h
	db 075h
	db 0B4h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0FFh
	db 077h
	db 004h
	db 0E8h
	db 075h
	db 0F2h
	db 050h
	db 0E8h
	db 0B9h
	db 0F5h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 0FCh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 046h
	db 0FAh
	db 089h
	db 007h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 027h
	db 0F5h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 00Ch
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 01Ch
	db 000h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 046h
	db 0FCh
	db 03Bh
	db 046h
	db 008h
	db 073h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 003h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 006h
	db 000h
CODE_2 ends
; END RH0F0A
; BEGIN RH100A (complete source CODE_2:100A..110A)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 008h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 0C7h
	db 046h
	db 0FCh
	db 000h
	db 000h
	db 0EBh
	db 019h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 006h
	db 08Bh
	db 047h
	db 002h
	db 001h
	db 046h
	db 0FCh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 046h
	db 004h
	db 074h
	db 008h
	db 08Bh
	db 046h
	db 0FCh
	db 03Bh
	db 046h
	db 008h
	db 072h
	db 0D7h
	db 083h
	db 07Eh
	db 0FCh
	db 000h
	db 075h
	db 003h
	db 0E9h
	db 0A6h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 046h
	db 0F8h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 0A3h
	db 014h
	db 000h
	db 0EBh
	db 041h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0F8h
	db 08Bh
	db 05Eh
	db 0F8h
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 00Eh
	db 0FFh
	db 076h
	db 0F8h
	db 0E8h
	db 0CCh
	db 0F4h
	db 0FFh
	db 076h
	db 0F8h
	db 0E8h
	db 0DEh
	db 0F1h
	db 0EBh
	db 020h
	db 08Bh
	db 05Eh
	db 0F8h
	db 08Bh
	db 047h
	db 002h
	db 029h
	db 046h
	db 0FAh
	db 08Bh
	db 007h
	db 03Bh
	db 046h
	db 0FAh
	db 074h
	db 00Ah
	db 0FFh
	db 076h
	db 0F8h
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 016h
	db 02Eh
	db 000h
	db 08Bh
	db 046h
	db 0F8h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0F8h
	db 03Bh
	db 046h
	db 006h
	db 075h
	db 0B7h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0FFh
	db 077h
	db 004h
	db 0E8h
	db 078h
	db 0F1h
	db 050h
	db 0E8h
	db 0BCh
	db 0F4h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 0FCh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 046h
	db 0FAh
	db 02Bh
	db 046h
	db 0FCh
	db 089h
	db 007h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 027h
	db 0F4h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 00Ch
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 01Ch
	db 000h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 046h
	db 0FCh
	db 03Bh
	db 046h
	db 008h
	db 073h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 003h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 006h
	db 000h
CODE_2 ends
; END RH100A
; BEGIN RH110A (complete source CODE_2:110A..1222)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

HEAP_ALLOC_NODE	label	near
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 0C7h
	db 046h
	db 0FEh
	db 000h
	db 000h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 034h
	db 020h
	db 089h
	db 046h
	db 0FCh
	db 0F6h
	db 006h
	db 005h
	db 000h
	db 004h
	db 074h
	db 023h
	db 0E8h
	db 066h
	db 0FCh
	db 03Bh
	db 046h
	db 0FCh
	db 073h
	db 058h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 00Ch
	db 000h
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 0E3h
	db 0FCh
	db 00Bh
	db 0C0h
	db 074h
	db 042h
	db 033h
	db 0C0h
	db 0E9h
	db 0D4h
	db 000h
	db 0A1h
	db 01Ah
	db 000h
	db 03Bh
	db 046h
	db 0FCh
	db 073h
	db 035h
	db 0F6h
	db 006h
	db 005h
	db 000h
	db 080h
	db 074h
	db 029h
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h
	db 026h
	db 080h
	db 03Eh
	db 0FBh
	db 006h
	db 000h
	db 074h
	db 01Ch
	db 0B8h
	db 001h
	db 000h
	db 033h
	db 0D2h
	db 050h
	db 052h
	db 0E8h
	db 0FAh
	db 022h
	db 00Bh
	db 0C0h
	db 075h
	db 009h
	db 0B8h
	db 080h
	db 000h
	db 050h
	db 0E8h
	db 095h
	db 006h
	db 0EBh
	db 00Ah
	db 033h
	db 0C0h
	db 0E9h
	db 09Ch
	db 000h
	db 033h
	db 0C0h
	db 0E9h
	db 097h
	db 000h
	db 0A1h
	db 01Ch
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 033h
	db 0F4h
	db 0EBh
	db 066h
	db 08Bh
	db 01Eh
	db 012h
	db 000h
	db 0EBh
	db 031h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 014h
	db 0F4h
	db 0EBh
	db 047h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 01Eh
	db 01Ch
	db 000h
	db 03Bh
	db 047h
	db 002h
	db 076h
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 01Ch
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 010h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 012h
	db 000h
	db 075h
	db 0C0h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 016h
	db 026h
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 00Bh
	db 0C0h
	db 074h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 0D1h
	db 0F3h
	db 0EBh
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 012h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 08Ah
	db 0F3h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH110A
; BEGIN RH1222 (complete source CODE_2:1222..12D3)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 08Bh
	db 01Eh
	db 00Eh
	db 000h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 017h
	db 01Fh
	db 089h
	db 046h
	db 0FCh
	db 0EBh
	db 029h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 016h
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 018h
	db 050h
	db 0E8h
	db 07Ah
	db 0F3h
	db 0EBh
	db 05Eh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 014h
	db 000h
	db 075h
	db 0CEh
	db 0E8h
	db 01Ch
	db 0FBh
	db 03Bh
	db 046h
	db 0FCh
	db 073h
	db 01Ah
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 099h
	db 0FBh
	db 00Bh
	db 0C0h
	db 074h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 03Ch
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 06Bh
	db 0FDh
	db 089h
	db 046h
	db 0FEh
	db 00Bh
	db 0C0h
	db 074h
	db 024h
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 023h
	db 0F3h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0D9h
	db 0F2h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH1222
; BEGIN RH12D3 (complete source CODE_2:12D3..1399)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 006h
	db 0A1h
	db 010h
	db 000h
	db 089h
	db 046h
	db 0FEh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 06Ah
	db 01Eh
	db 089h
	db 046h
	db 0FCh
	db 0EBh
	db 029h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 016h
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 00Eh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 018h
	db 050h
	db 0E8h
	db 0C4h
	db 0F2h
	db 0EBh
	db 06Eh
	db 08Bh
	db 046h
	db 0FEh
	db 03Bh
	db 006h
	db 016h
	db 000h
	db 075h
	db 0CEh
	db 0E8h
	db 06Fh
	db 0FAh
	db 03Bh
	db 046h
	db 0FCh
	db 073h
	db 01Ah
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 0ECh
	db 0FAh
	db 00Bh
	db 0C0h
	db 074h
	db 004h
	db 033h
	db 0C0h
	db 0EBh
	db 055h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 0BEh
	db 0FBh
	db 089h
	db 046h
	db 0FEh
	db 00Bh
	db 0C0h
	db 074h
	db 03Dh
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 0FCh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 076h
	db 0F2h
	db 089h
	db 046h
	db 0FAh
	db 03Bh
	db 046h
	db 0FEh
	db 074h
	db 014h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0E9h
	db 0F0h
	db 0A1h
	db 014h
	db 000h
	db 03Bh
	db 046h
	db 0FEh
	db 075h
	db 006h
	db 08Bh
	db 046h
	db 0FAh
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 016h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 013h
	db 0F2h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH12D3
; BEGIN RH1399 (complete source CODE_2:1399..1441)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0AAh
	db 01Dh
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 002h
	db 02Bh
	db 046h
	db 0FEh
	db 089h
	db 046h
	db 0FCh
	db 0E8h
	db 07Ch
	db 0EEh
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 046h
	db 0FCh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 007h
	db 003h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FAh
	db 089h
	db 007h
	db 0FFh
	db 076h
	db 006h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 09Ch
	db 0F1h
	db 08Bh
	db 05Eh
	db 0FAh
	db 0C7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 08Bh
	db 047h
	db 006h
	db 03Bh
	db 006h
	db 014h
	db 000h
	db 075h
	db 006h
	db 08Bh
	db 046h
	db 0FAh
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 01Bh
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 00Eh
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0F0h
	db 0F0h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 06Ch
	db 0F2h
	db 0EBh
	db 006h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0F4h
	db 0F2h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0F7h
	db 047h
	db 00Ah
	db 060h
	db 000h
	db 074h
	db 007h
	db 08Bh
	db 046h
	db 0FCh
	db 029h
	db 006h
	db 042h
	db 000h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 004h
	db 000h
CODE_2 ends
; END RH1399
; BEGIN RH1441 (complete source CODE_2:1441..148F)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 004h
	db 01Eh
	db 02Eh
	db 08Eh
	db 01Eh
	db 096h
	db 046h
	db 0C4h
	db 05Eh
	db 006h
	db 026h
	db 0FFh
	db 037h
	db 016h
	db 08Dh
	db 046h
	db 0FEh
	db 050h
	db 0E8h
	db 066h
	db 01Ah
	db 0D1h
	db 0E0h
	db 08Bh
	db 0D8h
	db 08Eh
	db 09Fh
	db 0CAh
	db 006h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0E6h
	db 01Ch
	db 08Bh
	db 05Eh
	db 0FEh
	db 02Bh
	db 047h
	db 002h
	db 089h
	db 046h
	db 0FCh
	db 083h
	db 07Eh
	db 0FCh
	db 000h
	db 074h
	db 010h
	db 0FFh
	db 076h
	db 0FEh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 018h
	db 0FFh
	db 08Bh
	db 046h
	db 0FCh
	db 001h
	db 006h
	db 034h
	db 000h
	db 01Fh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 006h
	db 000h
CODE_2 ends
; END RH1441
; BEGIN RG2A9 (raw CODE_2:148F..180E)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 08Ah
	db 046h
	db 004h
	db 088h
	db 046h
	db 004h
	db 0FFh
	db 076h
	db 008h
	db 08Bh
	db 05Eh
	db 006h
	db 0FFh
	db 037h
	db 0FFh
	db 016h
	db 02Ch
	db 000h
	db 0FFh
	db 076h
	db 006h
	db 0E8h
	db 0ACh
	db 0EFh
	db 080h
	db 07Eh
	db 004h
	db 000h
	db 074h
	db 008h
	db 0FFh
	db 076h
	db 006h
	db 0E8h
	db 062h
	db 0F2h
	db 0EBh
	db 006h
	db 0FFh
	db 076h
	db 006h
	db 0E8h
	db 0CAh
	db 0F1h
	db 0A1h
	db 014h
	db 000h
	db 03Bh
	db 046h
	db 006h
	db 075h
	db 006h
	db 08Bh
	db 046h
	db 008h
	db 0A3h
	db 014h
	db 000h
	db 05Dh
	db 0C2h
	db 006h
	db 000h
	db 055h
	db 08Bh
	db 0ECh
	db 083h
	db 0ECh
	db 00Eh
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 073h
	db 01Ch
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 006h
	db 02Bh
	db 047h
	db 002h
	db 089h
	db 046h
	db 0FCh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 00Dh
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 005h
	db 0B8h
	db 001h
	db 000h
	db 0EBh
	db 002h
	db 033h
	db 0C0h
	db 088h
	db 046h
	db 0F9h
	db 0E8h
	db 082h
	db 0F8h
	db 03Bh
	db 046h
	db 0FCh
	db 073h
	db 03Eh
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FAh
	db 03Bh
	db 006h
	db 016h
	db 000h
	db 074h
	db 014h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 0F2h
	db 0F8h
	db 00Bh
	db 0C0h
	db 074h
	db 01Bh
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 00Ch
	db 000h
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 0DCh
	db 0F8h
	db 00Bh
	db 0C0h
	db 074h
	db 005h
	db 033h
	db 0C0h
	db 0E9h
	db 0B9h
	db 002h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 05Eh
	db 0FAh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 00Bh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 003h
	db 0E9h
	db 0F8h
	db 001h
	db 08Bh
	db 05Eh
	db 006h
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 000h
	db 074h
	db 011h
	db 08Bh
	db 047h
	db 006h
	db 03Bh
	db 006h
	db 014h
	db 000h
	db 075h
	db 003h
	db 0E9h
	db 063h
	db 001h
	db 033h
	db 0C0h
	db 0E9h
	db 080h
	db 002h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 05Eh
	db 0FAh
	db 0F7h
	db 047h
	db 00Ah
	db 004h
	db 000h
	db 074h
	db 018h
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 072h
	db 010h
	db 0FFh
	db 076h
	db 006h
	db 0FFh
	db 076h
	db 0FAh
	db 08Ah
	db 046h
	db 0F9h
	db 050h
	db 0E8h
	db 0DFh
	db 0FEh
	db 0E9h
	db 0B2h
	db 001h
	db 0A1h
	db 01Ah
	db 000h
	db 03Bh
	db 046h
	db 0FEh
	db 073h
	db 003h
	db 0E9h
	db 028h
	db 001h
	db 0A1h
	db 01Ch
	db 000h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FEh
	db 073h
	db 053h
	db 08Bh
	db 01Eh
	db 012h
	db 000h
	db 0EBh
	db 023h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FEh
	db 073h
	db 042h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 01Eh
	db 01Ch
	db 000h
	db 03Bh
	db 047h
	db 002h
	db 076h
	db 006h
	db 08Bh
	db 046h
	db 0FAh
	db 0A3h
	db 01Ch
	db 000h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 010h
	db 089h
	db 046h
	db 0FAh
	db 08Bh
	db 046h
	db 0FAh
	db 03Bh
	db 006h
	db 012h
	db 000h
	db 075h
	db 0CEh
	db 080h
	db 07Eh
	db 0F9h
	db 000h
	db 075h
	db 003h
	db 0E9h
	db 0D6h
	db 000h
	db 0FFh
	db 076h
	db 004h
	db 0E8h
	db 0F4h
	db 0FAh
	db 089h
	db 046h
	db 0FAh
	db 00Bh
	db 0C0h
	db 075h
	db 011h
	db 033h
	db 0C0h
	db 0E9h
	db 0E6h
	db 001h
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 076h
	db 0FEh
	db 0B0h
	db 000h
	db 050h
	db 0E8h
	db 0A7h
	db 0EFh
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 007h
	db 089h
	db 046h
	db 0F6h
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 057h
	db 004h
	db 089h
	db 046h
	db 0F4h
	db 089h
	db 056h
	db 0F2h
	db 0FFh
	db 076h
	db 006h
	db 08Bh
	db 05Eh
	db 0FAh
	db 0FFh
	db 037h
	db 0FFh
	db 016h
	db 02Ch
	db 000h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 046h
	db 0F6h
	db 089h
	db 007h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 0FAh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 05Fh
	db 006h
	db 08Bh
	db 046h
	db 0FAh
	db 089h
	db 047h
	db 004h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 05Fh
	db 004h
	db 08Bh
	db 046h
	db 006h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 05Fh
	db 004h
	db 08Bh
	db 046h
	db 0FAh
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 006h
	db 08Bh
	db 057h
	db 004h
	db 08Bh
	db 05Eh
	db 006h
	db 089h
	db 047h
	db 006h
	db 089h
	db 057h
	db 004h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 046h
	db 0F4h
	db 08Bh
	db 056h
	db 0F2h
	db 089h
	db 047h
	db 006h
	db 089h
	db 057h
	db 004h
	db 080h
	db 07Eh
	db 0F9h
	db 000h
	db 074h
	db 008h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 046h
	db 0F0h
	db 0EBh
	db 00Ch
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 02Ch
	db 0EEh
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0A8h
	db 0EFh
	db 0E9h
	db 0F8h
	db 000h
	db 0E9h
	db 0F5h
	db 000h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FAh
	db 03Bh
	db 006h
	db 016h
	db 000h
	db 074h
	db 014h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 076h
	db 0FAh
	db 0FFh
	db 036h
	db 016h
	db 000h
	db 0E8h
	db 008h
	db 0F9h
	db 089h
	db 046h
	db 0FAh
	db 00Bh
	db 0C0h
	db 075h
	db 05Ch
	db 08Bh
	db 05Eh
	db 006h
	db 0F7h
	db 047h
	db 00Ah
	db 018h
	db 000h
	db 074h
	db 005h
	db 033h
	db 0C0h
	db 0E9h
	db 0F0h
	db 000h
	db 08Bh
	db 046h
	db 006h
	db 03Bh
	db 006h
	db 014h
	db 000h
	db 074h
	db 023h
	db 0FFh
	db 076h
	db 0FCh
	db 0FFh
	db 036h
	db 014h
	db 000h
	db 0FFh
	db 076h
	db 006h
	db 0E8h
	db 0DCh
	db 0F7h
	db 089h
	db 046h
	db 0FAh
	db 00Bh
	db 0C0h
	db 074h
	db 014h
	db 0FFh
	db 076h
	db 006h
	db 0FFh
	db 076h
	db 0FAh
	db 08Ah
	db 046h
	db 0F9h
	db 050h
	db 0E8h
	db 04Dh
	db 0FDh
	db 0EBh
	db 021h
	db 033h
	db 0C0h
	db 0E9h
	db 0BFh
	db 000h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FAh
	db 0FFh
	db 076h
	db 006h
	db 0FFh
	db 076h
	db 0FAh
	db 08Ah
	db 046h
	db 0F9h
	db 050h
	db 0E8h
	db 030h
	db 0FDh
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 023h
	db 0EFh
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 047h
	db 002h
	db 03Bh
	db 046h
	db 0FCh
	db 075h
	db 02Fh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 01Dh
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 010h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0B7h
	db 0EDh
	db 08Bh
	db 01Eh
	db 012h
	db 000h
	db 08Bh
	db 047h
	db 010h
	db 0A3h
	db 01Ch
	db 000h
	db 0FFh
	db 076h
	db 0FAh
	db 0E8h
	db 0BFh
	db 0EAh
	db 0EBh
	db 029h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 046h
	db 0FCh
	db 029h
	db 047h
	db 002h
	db 001h
	db 007h
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 03Bh
	db 007h
	db 072h
	db 014h
	db 08Bh
	db 05Eh
	db 0FAh
	db 08Bh
	db 007h
	db 08Bh
	db 01Eh
	db 016h
	db 000h
	db 03Bh
	db 007h
	db 073h
	db 007h
	db 08Bh
	db 046h
	db 0FCh
	db 029h
	db 006h
	db 01Ah
	db 000h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 01Eh
	db 014h
	db 000h
	db 08Bh
	db 047h
	db 006h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 006h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0FFh
	db 076h
	db 006h
	db 0E8h
	db 0AFh
	db 0EDh
	db 08Bh
	db 05Eh
	db 006h
	db 0F7h
	db 047h
	db 00Ah
	db 060h
	db 000h
	db 074h
	db 007h
	db 08Bh
	db 046h
	db 0FCh
	db 001h
	db 006h
	db 042h
	db 000h
	db 08Bh
	db 046h
	db 006h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 004h
	db 000h
CODE_2 ends
; END RG2A9
; BEGIN RH180E (complete source CODE_2:180E..1893)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 0E8h
	db 01Dh
	db 0EAh
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 01Eh
	db 010h
	db 000h
	db 08Bh
	db 007h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 007h
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 002h
	db 08Bh
	db 01Eh
	db 010h
	db 000h
	db 0FFh
	db 077h
	db 004h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 044h
	db 0EDh
	db 08Bh
	db 046h
	db 004h
	db 001h
	db 006h
	db 002h
	db 000h
	db 08Bh
	db 01Eh
	db 010h
	db 000h
	db 001h
	db 007h
	db 0A1h
	db 016h
	db 000h
	db 03Bh
	db 006h
	db 010h
	db 000h
	db 075h
	db 02Dh
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0B3h
	db 0ECh
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 02Fh
	db 0EEh
	db 08Bh
	db 01Eh
	db 010h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 002h
	db 08Bh
	db 01Eh
	db 01Ch
	db 000h
	db 03Bh
	db 047h
	db 002h
	db 076h
	db 018h
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 01Ch
	db 000h
	db 0EBh
	db 010h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 098h
	db 0EEh
	db 08Bh
	db 01Eh
	db 010h
	db 000h
	db 08Bh
	db 047h
	db 004h
	db 089h
	db 046h
	db 0FEh
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h
CODE_2 ends
; END RH180E
; BEGIN RH1893 (complete source CODE_2:1893..19BD)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 083h
	db 07Eh
	db 008h
	db 000h
	db 074h
	db 020h
	db 08Bh
	db 046h
	db 008h
	db 0BAh
	db 005h
	db 000h
	db 0F7h
	db 0EAh
	db 08Bh
	db 016h
	db 0CAh
	db 006h
	db 003h
	db 0D0h
	db 08Bh
	db 05Eh
	db 008h
	db 0D1h
	db 0E3h
	db 089h
	db 097h
	db 0CAh
	db 006h
	db 08Bh
	db 05Eh
	db 008h
	db 0D1h
	db 0E3h
	db 08Eh
	db 09Fh
	db 0CAh
	db 006h
	db 0B8h
	db 006h
	db 000h
	db 02Bh
	db 046h
	db 008h
	db 0BAh
	db 050h
	db 000h
	db 0F7h
	db 0EAh
	db 0A3h
	db 01Eh
	db 000h
	db 08Bh
	db 046h
	db 008h
	db 0BAh
	db 050h
	db 000h
	db 0F7h
	db 0EAh
	db 0A3h
	db 020h
	db 000h
	db 08Bh
	db 046h
	db 00Ch
	db 0A3h
	db 000h
	db 000h
	db 08Bh
	db 046h
	db 00Ah
	db 0A3h
	db 002h
	db 000h
	db 08Ah
	db 046h
	db 008h
	db 0A2h
	db 004h
	db 000h
	db 08Bh
	db 046h
	db 006h
	db 0A3h
	db 006h
	db 000h
	db 08Bh
	db 046h
	db 004h
	db 0A3h
	db 008h
	db 000h
	db 0C7h
	db 006h
	db 022h
	db 000h
	db 00Ah
	db 011h
	db 0C7h
	db 006h
	db 024h
	db 000h
	db 045h
	db 008h
	db 0C7h
	db 006h
	db 00Ah
	db 000h
		dw	seg BCC_SEG_180
	db 0E8h
	db 029h
	db 0E9h
	db 089h
	db 046h
	db 0FEh
	db 0A3h
	db 012h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0A1h
	db 000h
	db 000h
	db 089h
	db 007h
	db 0C7h
	db 047h
	db 00Ah
	db 004h
	db 080h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 004h
	db 089h
	db 047h
	db 006h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 00Eh
	db 089h
	db 047h
	db 010h
	db 0C7h
	db 047h
	db 002h
	db 000h
	db 000h
	db 0E8h
	db 0FCh
	db 0E8h
	db 089h
	db 046h
	db 0FEh
	db 0A3h
	db 00Eh
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0A1h
	db 000h
	db 000h
	db 089h
	db 007h
	db 0C7h
	db 047h
	db 00Ah
	db 000h
	db 080h
	db 08Bh
	db 046h
	db 0FEh
	db 089h
	db 047h
	db 004h
	db 089h
	db 047h
	db 006h
	db 0C7h
	db 047h
	db 002h
	db 000h
	db 000h
	db 0E8h
	db 0D8h
	db 0E8h
	db 089h
	db 046h
	db 0FEh
	db 0A3h
	db 00Ch
	db 000h
	db 0A3h
	db 014h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 0A1h
	db 000h
	db 000h
	db 089h
	db 007h
	db 0A1h
	db 002h
	db 000h
	db 089h
	db 047h
	db 002h
	db 0FFh
	db 036h
	db 00Eh
	db 000h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0FFh
	db 0EBh
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 084h
	db 0EBh
	db 08Bh
	db 046h
	db 0FEh
	db 0A3h
	db 01Ch
	db 000h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0A5h
	db 0E8h
	db 050h
	db 0E8h
	db 0E9h
	db 0EBh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 047h
	db 006h
	db 089h
	db 046h
	db 0FEh
	db 0A3h
	db 010h
	db 000h
	db 0A3h
	db 016h
	db 000h
	db 0A1h
	db 000h
	db 000h
	db 003h
	db 006h
	db 002h
	db 000h
	db 08Bh
	db 05Eh
	db 0FEh
	db 089h
	db 007h
	db 0C7h
	db 047h
	db 002h
	db 000h
	db 000h
	db 0C7h
	db 047h
	db 00Ah
	db 000h
	db 080h
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 00Ah
	db 000h
CODE_2 ends
; END RH1893
; BEGIN RH19BD (complete source CODE_2:19BD..19EC)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	assume cs:CODE_2
	db 055h
	db 08Bh
	db 0ECh
	db 04Ch
	db 04Ch
	db 0E8h
	db 06Eh
	db 0E8h
	db 089h
	db 046h
	db 0FEh
	db 0FFh
	db 036h
	db 00Eh
	db 000h
	db 0FFh
	db 076h
	db 0FEh
	db 0E8h
	db 0A9h
	db 0EBh
	db 08Bh
	db 05Eh
	db 0FEh
	db 08Bh
	db 046h
	db 004h
	db 089h
	db 047h
	db 008h
	db 0C6h
	db 047h
	db 013h
	db 005h
	db 0C6h
	db 047h
	db 00Ch
	db 000h
	db 08Bh
	db 046h
	db 0FEh
	db 08Bh
	db 0E5h
	db 05Dh
	db 0C2h
	db 002h
	db 000h

CODE_2 ends
; END RH19BD
; BEGIN R19EC (derived raw function CODE_2:19EC..19FB)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,0FFh,076h,004h,0E8h,071h
	db 0E8h,033h,0C0h,05Dh,0C2h,002h,000h
CODE_2 ends
; END R19EC
; BEGIN RH19FB (complete source CODE_2:19FB..1A1A)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	assume cs:CODE_2

	db 055h,08Bh,0ECh,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Eh,01Eh,0CAh,006h,0B8h,0FFh,0FFh,050h,0FFh,036h,014h,000h
	db 0FFh,036h,016h,000h,0E8h,0F3h,0F4h,01Fh,05Dh,0CBh

CODE_2 ends
; END RH19FB
; BEGIN R1A1A (derived raw function CODE_2:1A1A..1A2F)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,01Eh
	db 0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,0B8h,0FFh,0FFh,050h,09Ah,02Fh,01Ah
		dw	seg BCC_FAR_245C
	db 01Fh,05Dh,0CBh
CODE_2 ends
; END R1A1A
; BEGIN RH1A2F (complete source CODE_2:1A2F..1AE0)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0D8h,08Bh,046h,006h,089h,046h,0FCh,08Eh,01Eh,0CAh,006h,08Eh,006h,00Ah
	db 000h,08Bh,01Eh,010h,000h,08Bh,007h,026h,0A3h,0C4h,006h,0A1h,016h,000h
	db 03Bh,006h,010h,000h,075h,076h,0E8h,02Fh,0F3h,03Bh,046h,0FCh,073h,01Ch
	db 0FFh,076h,0FCh,0FFh,036h,00Ch,000h,0FFh,036h,014h,000h,0FFh,036h,016h
	db 000h,0E8h,0ACh,0F3h,00Bh,0C0h,074h,006h,0E8h,011h,0F3h,089h,046h,0FCh
	db 0FFh,076h,0FCh,0FFh,036h,014h,000h,0FFh,036h,016h,000h,0E8h,07Ch,0F4h
	db 08Bh,01Eh,010h,000h,08Bh,047h,004h,089h,046h,0FEh,08Bh,05Eh,0FEh,0F7h
	db 047h,00Ah,004h,000h,074h,030h,08Bh,047h,002h,03Bh,046h,0FCh,077h,007h
	db 08Bh,047h,002h,048h,089h,046h,0FCh,08Bh,046h,0FCh,029h,006h,01Ah,000h
	db 08Bh,05Eh,0FEh,029h,047h,002h,08Bh,007h,003h,047h,002h,08Bh,01Eh,010h
	db 000h,089h,007h,08Bh,007h,02Bh,006h,000h,000h,0A3h,002h,000h,0A1h,000h
	db 000h,003h,006h,002h,000h,01Fh,08Bh,0E5h,05Dh,0CAh,002h,000h
CODE_2 ends
; END RH1A2F
; BEGIN RH1AE0 (complete source CODE_2:1AE0..1B1C)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh
	db 0ECh,04Ch,04Ch,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Bh,046h,006h,089h,046h
	db 0FEh,083h,07Eh,0FEh,000h,075h,006h,0A1h,0C4h,006h,089h,046h,0FEh,08Eh
	db 01Eh,0CAh,006h,08Bh,01Eh,010h,000h,08Bh,007h,03Bh,046h,0FEh,073h,009h
	db 08Bh,046h,0FEh,02Bh,007h,050h,0E8h,0F9h,0FCh,01Fh,08Bh,0E5h,05Dh,0CAh
	db 002h,000h
CODE_2 ends
; END RH1AE0
; BEGIN RH1B1C (complete source CODE_2:1B1C..1B9A)



CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M001_BCC_DATA_06C2	equ	6C2h
M001_BCC_DATA_06CA	equ	6CAh
M001_BCC_DATA_4696	equ	4696h
M001_BCC_DATA_5EA8	equ	5EA8h
		public	BCC_FAR_245C

		public	BCC_POOL_CREATE_BLOCK
BCC_POOL_CREATE_BLOCK	label	far
		public	BCC_POOL_INIT
BCC_POOL_INIT	label	far
BCC_FAR_245C	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		db	0E8h
		dw	0E60Eh
		or	AX,AX
		jne	short M001_L_24B9
M001_L_246E:
		mov	word ptr DGROUP:M001_BCC_DATA_06C2,0
		mov	DS,word ptr DGROUP:M001_BCC_DATA_06CA
		push	word ptr [BP+6]
		db	0E8h
		dw	0F5CCh
		mov	word ptr [BP-2],AX
		or	AX,AX
		je	short M001_L_24A1
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr [BP+0Ah]
		mov	DX,word ptr [BP+8]
		mov	word ptr [BX+10h],AX
		mov	word ptr [BX+0Eh],DX
		push	word ptr [BP-2]
		mov	AL,1
		push	AX
		db	0E8h
		dw	01323h
		xor	AX,AX
		jmp	short M001_L_24D3
M001_L_24A1:
		db	02Eh,08Eh,01Eh
		dw	4696h
		mov	AX,1
		push	AX
		mov	AX,100h
		push	AX
		db	0FFh,01Eh
		dw	5EA8h
		cmp	word ptr DGROUP:M001_BCC_DATA_06C2,0
		je	short M001_L_246E
M001_L_24B9:
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	word ptr DGROUP:M001_BCC_DATA_06C2,1000h
		mov	AX,1
		push	AX
		mov	AX,1000h
		push	AX
		db	0FFh,01Eh
		dw	5EA8h
		mov	AX,1000h
M001_L_24D3:
		pop	DS
		mov	SP,BP
		pop	BP
		retf	6
BCC_FAR_245C	endp
CODE_2	ends

; Original-target semantic aliases (zero bytes)
; END RH1B1C
; BEGIN RH1B9A (complete source CODE_2:1B9A..1C4F)



CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M002_BCC_DATA_06C2	equ	6C2h
M002_BCC_DATA_06CA	equ	6CAh
M002_BCC_DATA_4696	equ	4696h
M002_BCC_DATA_5EA8	equ	5EA8h
		public	HEAP_ALLOC_HANDLE

HEAP_ALLOC_HANDLE	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		db	0E8h
		dw	0E58Fh
		or	AX,AX
		je	short M002_L_24F0
		jmp	short M002_L_256D
		nop
M002_L_24F0:
		mov	word ptr DGROUP:M002_BCC_DATA_06C2,0
		mov	DS,word ptr DGROUP:M002_BCC_DATA_06CA
		db	0E8h
		dw	0E78Ch
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		or	AX,word ptr [BP-4]
		je	short M002_L_256D
M002_L_2508:
		push	word ptr [BP+6]
		db	0E8h
		dw	0F53Ch
		mov	word ptr [BP-2],AX
		or	AX,AX
		je	short M002_L_253D
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		mov	DX,word ptr [BP-6]
		mov	word ptr [BX+10h],AX
		mov	word ptr [BX+0Eh],DX
		push	word ptr [BP-2]
		mov	AL,1
		push	AX
		db	0E8h
		dw	01293h
		mov	BX,word ptr [BP-2]
		or	word ptr [BX+0Ah],4000h
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		jmp	short M002_L_2588
M002_L_253D:
		db	02Eh,08Eh,01Eh
		dw	4696h
		mov	AX,1
		push	AX
		mov	AX,100h
		push	AX
		db	0FFh,01Eh
		dw	5EA8h
		cmp	word ptr DGROUP:M002_BCC_DATA_06C2,0
		jne	short M002_L_255B
		mov	DS,word ptr DGROUP:M002_BCC_DATA_06CA
		jmp	short M002_L_2508
M002_L_255B:
		db	02Eh,08Eh,01Eh
		dw	4696h
		mov	DS,word ptr DGROUP:M002_BCC_DATA_06CA
		push	word ptr [BP-4]
		push	word ptr [BP-6]
		db	0E8h
		dw	0E789h
M002_L_256D:
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	word ptr DGROUP:M002_BCC_DATA_06C2,1000h
		mov	AX,1
		push	AX
		mov	AX,1000h
		push	AX
		db	0FFh,01Eh
		dw	5EA8h
		xor	DX,DX
		xor	AX,AX
M002_L_2588:
		pop	DS
		mov	SP,BP
		pop	BP
		retf	2
HEAP_ALLOC_HANDLE	endp
CODE_2	ends

; END RH1B9A
; BEGIN RH1C4F (complete source CODE_2:1C4F..1CBF)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

		assume	cs:CODE_2,ds:DGROUP

M003_BCC_DATA_0024	equ	24h
M003_BCC_DATA_06C2	equ	6C2h
M003_BCC_DATA_5EA8	equ	5EA8h
		public	BCC_FAR_258F

BCC_FAR_258F	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		les	BX,[BP+6]
		push	word ptr ES:[BX]
		push	SS
		lea	AX,[BP-2]
		push	AX
		db	0E8h
		dw	01258h
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],6
		jge	short M003_L_25E3
		mov	BX,word ptr [BP-4]
		shl	BX,1
		mov	DS,word ptr [BX+6CAh]
		mov	BX,word ptr [BP-2]
		test	word ptr [BX+0Ah],4000h
		je	short M003_L_25D0
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	0E8h
		dw	0E728h
		jmp	short M003_L_25D8
M003_L_25D0:
		les	BX,[BP+6]
		mov	word ptr ES:[BX],0
M003_L_25D8:
		push	word ptr [BP-2]
		db	0FFh,016h
		dw	24h
		xor	AX,AX
		jmp	short M003_L_25F8
M003_L_25E3:
		mov	word ptr DGROUP:M003_BCC_DATA_06C2,1002h
		mov	AX,1
		push	AX
		mov	AX,1002h
		push	AX
		db	0FFh,01Eh
		dw	5EA8h
		mov	AX,1002h
M003_L_25F8:
		pop	DS
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_258F	endp

CODE_2 ends
; END RH1C4F
; BEGIN R25FF (listing CODE_2:1CBF)



CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M004_BCC_DATA_000E	equ	0Eh
M004_BCC_DATA_0010	equ	10h
M004_BCC_DATA_0024	equ	24h
M004_BCC_DATA_06C0	equ	6C0h
		public	BCC_FAR_25FF

BCC_FAR_25FF	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		cmp	byte ptr [BP+6],0
		jne	short M004_L_2616
		mov	AL,DGROUP:M004_BCC_DATA_06C0
		jmp	short M004_L_2619
M004_L_2616:
		mov	AL,byte ptr [BP+6]
M004_L_2619:
		mov	byte ptr [BP-1],AL
		mov	word ptr [BP-4],0
		db	0E9h
		dw	0008Bh
M004_L_2624:
		mov	BX,word ptr [BP-4]
		shl	BX,1
		mov	CX,word ptr [BX+6CAh]
		jcxz	short M004_L_2631
		jmp	short M004_L_2634
M004_L_2631:
		jmp	short M004_L_26AC
		nop
M004_L_2634:
		mov	DS,CX
		mov	BX,word ptr DGROUP:M004_BCC_DATA_000E
		jmp	short M004_L_2698
M004_L_263C:
		mov	BX,word ptr [BP-6]
		test	word ptr [BX+0Ah],4
		jne	short M004_L_2695
		mov	AL,byte ptr [BX+0Ch]
		cmp	AL,byte ptr [BP-1]
		jne	short M004_L_2695
		test	word ptr [BX+0Ah],4000h
		je	short M004_L_2660
		push	word ptr [BX+10h]
		push	word ptr [BX+0Eh]
		db	0E8h
		dw	0E698h
		jmp	short M004_L_266B
M004_L_2660:
		mov	BX,word ptr [BP-6]
		les	BX,[BX+0Eh]
		mov	word ptr ES:[BX],0
M004_L_266B:
		push	word ptr [BP-6]
		db	0FFh,016h
		dw	24h
		mov	BX,word ptr [BP-6]
		cmp	word ptr [BX+4],0
		jne	short M004_L_2695
		jmp	short M004_L_2686
M004_L_267D:
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr [BX+6]
		mov	word ptr [BP-6],AX
M004_L_2686:
		mov	BX,word ptr [BP-6]
		cmp	word ptr [BX+4],0
		je	short M004_L_267D
		mov	AX,word ptr [BX+4]
		mov	word ptr [BP-6],AX
M004_L_2695:
		mov	BX,word ptr [BP-6]
M004_L_2698:
		mov	AX,word ptr [BX+6]
		mov	word ptr [BP-6],AX
		mov	AX,word ptr [BP-6]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_0010
		jne	short M004_L_263C
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
M004_L_26AC:
		inc	word ptr [BP-4]
M004_L_26AF:
		cmp	word ptr [BP-4],6
		jge	short M004_L_26B8
		db	0E9h
		dw	0FF6Ch
M004_L_26B8:
		pop	DS
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_25FF	endp
CODE_2	ends

; END R25FF
; BEGIN RHAPI (complete source CODE_2:1D7F..2BB0)
CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh; CODE_2:1D7F
		db	00Ah,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,028h,011h,089h,046h	; CODE_2:1D8D
		db	0FCh,083h,07Eh,0FCh,006h,07Dh,026h,0C7h,006h,0C2h,006h,000h,000h,08Bh	; CODE_2:1D9B
		db	05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,0FFh,076h,008h,0FFh,076h,006h	; CODE_2:1DA9
		db	0E8h,0C2h,026h,08Bh,05Eh,0FEh,088h,047h,012h,00Ah,0C0h,074h,004h,033h	; CODE_2:1DB7
		db	0C0h,0EBh,009h,0C7h,006h,0C2h,006h,002h,010h,0B8h,002h,010h,01Fh,08Bh	; CODE_2:1DC5
		db	0E5h,05Dh,0CAh,008h,000h,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh,006h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h; CODE_2:1DD3
		db	0E8h,0CFh,010h,089h,046h,0FCh,083h,07Eh,0FCh,000h,075h,022h,0E8h,03Ah	; CODE_2:1DEF
		db	0E3h,00Bh,0C0h,075h,01Bh,0C7h,006h,0C2h,006h,000h,000h,01Eh,08Bh,05Eh	; CODE_2:1DFD
		db	0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,0FFh,076h,0FEh,0E8h,06Ah,0ECh,01Fh	; CODE_2:1E0B
		db	033h,0C0h,0EBh,009h,0C7h,006h,0C2h,006h,000h,010h,0B8h,000h,010h,01Fh	; CODE_2:1E19
		db	08Bh,0E5h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,04Ch,04Ch,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,08Bh,046h,006h,00Bh,046h,008h,074h,050h,0E8h,0F5h,0E2h; CODE_2:1E27
		db	00Bh,0C0h,075h,049h,0C7h,006h,0C2h,006h,000h,000h,08Eh,01Eh,0D4h,006h	; CODE_2:1E43
		db	0FFh,076h,00Ah,0E8h,066h,0FBh,089h,046h,0FEh,08Bh,05Eh,0FEh,08Bh,046h	; CODE_2:1E51
		db	00Ah,089h,047h,008h,0C7h,047h,00Ah,061h,007h,08Bh,046h,00Eh,08Bh,056h	; CODE_2:1E5F
		db	00Ch,089h,047h,010h,089h,057h,00Eh,0FFh,076h,008h,0FFh,076h,006h,0E8h	; CODE_2:1E6D
		db	0FFh,025h,08Bh,05Eh,0FEh,088h,047h,012h,0FFh,076h,0FEh,0B0h,003h,050h	; CODE_2:1E7B
		db	0E8h,0F4h,00Fh,033h,0C0h,0EBh,009h,0C7h,006h,0C2h,006h,002h,010h,0B8h	; CODE_2:1E89
		db	002h,010h,01Fh,08Bh,0E5h,05Dh,0CAh,00Ah,000h,055h,08Bh,0ECh,083h,0ECh	; CODE_2:1E97
		db	008h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,08Bh,046h,006h,08Bh,056h,008h,005h; CODE_2:1EA5
		db	00Fh,000h,083h,0D2h,000h,0D1h,0EAh,0D1h,0D8h,0D1h,0EAh,0D1h,0D8h,0D1h	; CODE_2:1EB3
		db	0EAh,0D1h,0D8h,0D1h,0EAh,0D1h,0D8h,089h,046h,0FCh,08Eh,01Eh,0CAh,006h	; CODE_2:1EC1
		db	0A1h,034h,000h,003h,006h,01Ah,000h,03Bh,046h,0FCh,073h,017h,08Bh,046h	; CODE_2:1ECF
		db	0FCh,02Bh,006h,034h,000h,050h,0FFh,036h,00Ch,000h,0FFh,036h,014h,000h	; CODE_2:1EDD
		db	0FFh,036h,016h,000h,0E8h,030h,0EFh,0A1h,034h,000h,003h,006h,01Ah,000h	; CODE_2:1EEB
		db	089h,046h,0FEh,08Bh,046h,0FCh,03Bh,046h,0FEh,073h,002h,0EBh,003h,08Bh	; CODE_2:1EF9
		db	046h,0FEh,0A3h,036h,000h,0A1h,036h,000h,033h,0D2h,0D1h,0E0h,0D1h,0D2h	; CODE_2:1F07
		db	0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,089h,046h	; CODE_2:1F15
		db	0F8h,089h,056h,0FAh,08Bh,056h,0FAh,08Bh,046h,0F8h,01Fh,08Bh,0E5h,05Dh	; CODE_2:1F23
		db	0CAh,004h,000h,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh; CODE_2:1F31
		db	0D8h,08Eh,01Eh,0CAh,006h,0A1h,036h,000h,033h,0D2h,0D1h,0E0h,0D1h,0D2h	; CODE_2:1F3F
		db	0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,089h,046h	; CODE_2:1F4D
		db	0FCh,089h,056h,0FEh,08Bh,056h,0FEh,08Bh,046h,0FCh,01Fh,08Bh,0E5h,05Dh	; CODE_2:1F5B
		db	0CBh,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h; CODE_2:1F69
		db	05Eh,008h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,03Dh,00Fh,089h	; CODE_2:1F77
		db	046h,0FCh,083h,07Eh,0FCh,005h,075h,017h,0C7h,006h,0C2h,006h,000h,000h	; CODE_2:1F85
		db	08Eh,01Eh,0D4h,006h,08Bh,05Eh,0FEh,08Bh,046h,006h,089h,047h,008h,033h	; CODE_2:1F93
		db	0C0h,0EBh,009h,0C7h,006h,0C2h,006h,002h,010h,0B8h,002h,010h,01Fh,08Bh	; CODE_2:1FA1
		db	0E5h,05Dh,0CAh,006h,000h,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh,006h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h; CODE_2:1FAF
		db	0E8h,0F3h,00Eh,089h,046h,0FCh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh	; CODE_2:1FCB
		db	006h,08Bh,05Eh,0FEh,081h,04Fh,00Ah,000h,080h,01Fh,08Bh,0E5h,05Dh,0CAh	; CODE_2:1FD9
		db	004h,000h,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h; CODE_2:1FE7
		db	0C4h,05Eh,006h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,0BEh,00Eh	; CODE_2:1FF5
		db	089h,046h,0FCh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh	; CODE_2:2003
		db	0FEh,081h,067h,00Ah,0FFh,07Fh,01Fh,08Bh,0E5h,05Dh,0CAh,004h,000h,055h	; CODE_2:2011
		db	08Bh,0ECh,083h,0ECh,006h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh,006h; CODE_2:201F
		db	026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,089h,00Eh,089h,046h,0FCh	; CODE_2:202D
		db	0C7h,046h,0FAh,000h,010h,083h,07Eh,0FCh,000h,075h,02Bh,0E8h,0EFh,0E0h	; CODE_2:203B
		db	00Bh,0C0h,075h,024h,01Eh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h	; CODE_2:2049
		db	08Bh,05Eh,0FEh,083h,07Fh,008h,000h,074h,00Bh,0FFh,076h,0FEh,0E8h,087h	; CODE_2:2057
		db	0E8h,089h,046h,0FAh,0EBh,005h,0C7h,046h,0FAh,000h,000h,01Fh,08Bh,046h	; CODE_2:2065
		db	0FAh,0A3h,0C2h,006h,08Bh,046h,0FAh,01Fh,08Bh,0E5h,05Dh,0CAh,004h,000h	; CODE_2:2073
		db	055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh; CODE_2:2081
		db	006h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,026h,00Eh,089h,046h	; CODE_2:208F
		db	0FCh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FEh,08Bh	; CODE_2:209D
		db	047h,00Ah,01Fh,08Bh,0E5h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,083h,0ECh	; CODE_2:20AB
		db	004h,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,08Eh,01Eh,0CAh,006h,0F7h,046h,00Eh,000h; CODE_2:20B9
		db	004h,074h,008h,0A0h,005h,000h,00Ch,001h,0A2h,005h,000h,0F7h,046h,00Eh	; CODE_2:20C7
		db	008h,000h,074h,008h,0FFh,076h,008h,0E8h,043h,0F1h,0EBh,015h,0F7h,046h	; CODE_2:20D5
		db	00Eh,010h,000h,074h,008h,0FFh,076h,008h,0E8h,0E5h,0F1h,0EBh,006h,0FFh	; CODE_2:20E3
		db	076h,008h,0E8h,014h,0F0h,089h,046h,0FEh,0A0h,005h,000h,024h,0FEh,0A2h	; CODE_2:20F1
		db	005h,000h,083h,07Eh,0FEh,000h,075h,018h,02Eh,08Eh,01Eh,096h,046h,0B8h	; CODE_2:20FF
		db	001h,000h,050h,0B8h,000h,001h,050h,0FFh,01Eh,0A8h,05Eh,083h,03Eh,0C2h	; CODE_2:210D
		db	006h,000h,074h,0A0h,083h,07Eh,0FEh,000h,075h,003h,0E9h,0F9h,000h,08Bh	; CODE_2:211B
		db	05Eh,0FEh,08Bh,046h,00Ch,08Bh,056h,00Ah,089h,047h,010h,089h,057h,00Eh	; CODE_2:2129
		db	08Bh,046h,00Eh,025h,000h,006h,009h,047h,00Ah,083h,07Eh,004h,000h,075h	; CODE_2:2137
		db	003h,0E9h,0C3h,000h,08Bh,007h,089h,046h,0FCh,01Eh,02Eh,08Eh,01Eh,096h	; CODE_2:2145
		db	046h,08Bh,05Eh,006h,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,004h,08Bh	; CODE_2:2153
		db	047h,008h,03Bh,046h,008h,076h,006h,08Bh,046h,008h,089h,047h,008h,0FFh	; CODE_2:2161
		db	076h,006h,033h,0C0h,050h,0FFh,076h,004h,0FFh,076h,0FEh,0E8h,03Bh,0E3h	; CODE_2:216F
		db	0FFh,076h,004h,0FFh,076h,0FCh,0FFh,016h,02Ah,000h,08Bh,05Eh,004h,0F7h	; CODE_2:217D
		db	047h,00Ah,000h,002h,074h,02Eh,083h,07Eh,006h,001h,07Ch,028h,083h,07Eh	; CODE_2:218B
		db	006h,005h,07Dh,022h,01Fh,08Bh,05Eh,0FEh,081h,04Fh,00Ah,000h,020h,08Ah	; CODE_2:2199
		db	046h,006h,0B1h,003h,0D2h,0E0h,00Ah,006h,004h,000h,08Bh,05Eh,0FEh,088h	; CODE_2:21A7
		db	047h,013h,08Bh,046h,004h,089h,047h,014h,0EBh,014h,0FFh,076h,004h,0FFh	; CODE_2:21B5
		db	016h,024h,000h,01Fh,08Bh,05Eh,0FEh,081h,067h,00Ah,0FFh,0DFh,0C6h,047h	; CODE_2:21C3
		db	013h,000h,08Bh,05Eh,0FEh,0F7h,047h,00Ah,000h,004h,074h,007h,08Bh,047h	; CODE_2:21D1
		db	002h,001h,006h,034h,000h,08Bh,05Eh,0FEh,081h,067h,00Ah,07Fh,0FEh,0FFh	; CODE_2:21DF
		db	076h,0FEh,0B0h,001h,050h,0E8h,08Bh,00Ch,08Bh,05Eh,0FEh,0F7h,047h,00Ah	; CODE_2:21ED
		db	060h,000h,074h,016h,0FFh,006h,040h,000h,08Bh,047h,002h,001h,006h,042h	; CODE_2:21FB
		db	000h,0EBh,009h,0FFh,076h,0FEh,0B0h,001h,050h,0E8h,06Bh,00Ch,08Bh,046h	; CODE_2:2209
		db	00Eh,025h,018h,000h,08Bh,05Eh,0FEh,009h,047h,00Ah,08Bh,046h,0FEh,08Bh	; CODE_2:2217
		db	0E5h,05Dh,0C2h,00Ch,000h,055h,08Bh,0ECh,083h,0ECh,00Ah,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C7h,046h,0F8h,000h,000h,0C7h,006h,0C2h,006h,000h,000h; CODE_2:2225
		db	0E8h,0F4h,0DEh,089h,046h,0F8h,00Bh,0C0h,074h,03Dh,0F7h,046h,00Eh,018h	; CODE_2:2241
		db	078h,074h,036h,081h,07Eh,00Eh,000h,020h,074h,003h,0E9h,0F1h,004h,0C4h	; CODE_2:224F
		db	05Eh,008h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,057h,00Ch,089h	; CODE_2:225D
		db	046h,0FAh,01Eh,08Bh,05Eh,0FAh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh	; CODE_2:226B
		db	0FEh,0F7h,047h,00Ah,000h,004h,074h,003h,01Fh,0EBh,004h,01Fh,0E9h,0C5h	; CODE_2:2279
		db	004h,0C7h,046h,0F8h,000h,000h,0F7h,046h,00Eh,000h,048h,074h,016h,0C7h	; CODE_2:2287
		db	046h,0FAh,000h,000h,08Eh,01Eh,0CAh,006h,0C7h,046h,0FEh,000h,000h,08Bh	; CODE_2:2295
		db	046h,00Ch,021h,046h,00Eh,0EBh,05Fh,0C4h,05Eh,008h,026h,0FFh,037h,016h	; CODE_2:22A3
		db	08Dh,046h,0FEh,050h,0E8h,009h,00Ch,089h,046h,0FAh,083h,07Eh,0FAh,006h	; CODE_2:22B1
		db	07Ch,008h,0C7h,046h,0F8h,002h,010h,0E9h,084h,004h,08Bh,05Eh,0FAh,0D1h	; CODE_2:22BF
		db	0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FEh,08Bh,047h,00Ah,08Bh,056h,00Ch	; CODE_2:22CD
		db	0F7h,0D2h,023h,0C2h,025h,0FFh,087h,08Bh,056h,00Eh,023h,056h,00Ch,00Bh	; CODE_2:22DB
		db	0D0h,089h,056h,00Eh,0F7h,047h,00Ah,000h,008h,074h,015h,0FFh,076h,0FEh	; CODE_2:22E9
		db	0E8h,08Ch,0E9h,0FFh,076h,0FEh,0E8h,00Bh,0E9h,0FFh,076h,0FEh,0B0h,000h	; CODE_2:22F7
		db	050h,0E8h,0C3h,0E9h,0F7h,046h,00Eh,004h,000h,074h,027h,08Bh,05Eh,0FEh	; CODE_2:2305
		db	0F7h,047h,00Ah,000h,040h,074h,00Bh,0FFh,076h,00Ah,0FFh,076h,008h,0E8h	; CODE_2:2313
		db	093h,0E0h,0EBh,008h,0C4h,05Eh,008h,026h,0C7h,007h,000h,000h,0FFh,076h	; CODE_2:2321
		db	0FEh,0FFh,016h,024h,000h,0E9h,016h,004h,0F7h,046h,00Eh,000h,048h,074h	; CODE_2:232F
		db	022h,0FFh,076h,00Eh,0FFh,076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,033h	; CODE_2:233D
		db	0C0h,050h,050h,0E8h,063h,0FDh,089h,046h,0FEh,00Bh,0C0h,075h,008h,0C7h	; CODE_2:234B
		db	046h,0F8h,000h,010h,0E9h,0EDh,003h,0A0h,005h,000h,0B4h,000h,0A9h,004h	; CODE_2:2359
		db	000h,074h,003h,0E9h,086h,000h,0F7h,046h,00Eh,000h,010h,074h,00Dh,08Bh	; CODE_2:2367
		db	046h,006h,089h,046h,0F6h,081h,066h,00Eh,0FFh,0EFh,0EBh,009h,08Bh,05Eh	; CODE_2:2375
		db	0FEh,08Bh,047h,008h,089h,046h,0F6h,08Bh,05Eh,0FEh,0F7h,047h,00Ah,000h	; CODE_2:2383
		db	004h,074h,005h,081h,04Eh,00Eh,000h,004h,0FFh,076h,00Eh,0FFh,076h,00Ah	; CODE_2:2391
		db	0FFh,076h,008h,0FFh,076h,0F6h,0FFh,076h,0FAh,0FFh,076h,0FEh,0E8h,006h	; CODE_2:239F
		db	0FDh,089h,046h,0FEh,00Bh,0C0h,075h,008h,0C7h,046h,0F8h,000h,010h,0E9h	; CODE_2:23AD
		db	090h,003h,08Bh,05Eh,0FEh,080h,07Fh,012h,000h,074h,02Dh,083h,07Eh,0FAh	; CODE_2:23BB
		db	005h,075h,008h,0FFh,076h,0FEh,0B8h,002h,000h,0EBh,006h,0FFh,076h,0FEh	; CODE_2:23C9
		db	0B8h,005h,000h,050h,0FFh,076h,00Ah,0FFh,076h,008h,0C4h,05Eh,008h,026h	; CODE_2:23D7
		db	0FFh,037h,0E8h,077h,020h,02Eh,08Eh,01Eh,096h,046h,08Eh,01Eh,0CAh,006h	; CODE_2:23E5
		db	0F7h,046h,00Eh,000h,010h,075h,003h,0E9h,08Bh,000h,0FFh,076h,006h,0E8h	; CODE_2:23F3
		db	04Ch,00Dh,08Bh,05Eh,0FEh,02Bh,047h,002h,089h,046h,0F6h,0F7h,047h,00Ah	; CODE_2:2401
		db	000h,020h,074h,021h,0FFh,077h,014h,0B8h,001h,000h,050h,08Ah,047h,013h	; CODE_2:240F
		db	0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,050h,0E8h,0B5h,009h,083h,0C4h	; CODE_2:241D
		db	006h,08Bh,05Eh,0FEh,081h,067h,00Ah,0FFh,0DFh,083h,07Eh,0F6h,000h,07Dh	; CODE_2:242B
		db	00Bh,0FFh,076h,0FEh,0FFh,076h,006h,0E8h,056h,0EFh,0EBh,043h,083h,07Eh	; CODE_2:2439
		db	0F6h,000h,07Eh,034h,08Bh,05Eh,0FEh,081h,04Fh,00Ah,000h,080h,0FFh,076h	; CODE_2:2447
		db	0FEh,0FFh,076h,006h,0E8h,074h,0F0h,089h,046h,0FCh,00Bh,0C0h,074h,006h	; CODE_2:2455
		db	08Bh,046h,0FCh,089h,046h,0FEh,08Bh,05Eh,0FEh,081h,067h,00Ah,0FFh,07Fh	; CODE_2:2463
		db	083h,07Eh,0FCh,000h,075h,011h,0C7h,046h,0F8h,000h,010h,0E9h,0CEh,002h	; CODE_2:2471
		db	08Bh,05Eh,0FEh,08Bh,046h,006h,089h,047h,008h,08Bh,05Eh,0FEh,0F7h,047h	; CODE_2:247F
		db	00Ah,060h,000h,074h,014h,0F7h,046h,00Eh,060h,000h,075h,022h,0FFh,00Eh	; CODE_2:248D
		db	040h,000h,08Bh,047h,002h,029h,006h,042h,000h,0EBh,015h,0F7h,046h,00Eh	; CODE_2:249B
		db	060h,000h,074h,00Eh,0FFh,006h,040h,000h,08Bh,05Eh,0FEh,08Bh,047h,002h	; CODE_2:24A9
		db	001h,006h,042h,000h,08Bh,05Eh,0FEh,08Bh,047h,00Ah,031h,046h,00Eh,08Bh	; CODE_2:24B7
		db	046h,00Eh,025h,063h,002h,031h,047h,00Ah,0F7h,046h,00Eh,000h,002h,074h	; CODE_2:24C5
		db	02Fh,0F7h,047h,00Ah,000h,002h,075h,028h,0F7h,047h,00Ah,000h,020h,074h	; CODE_2:24D3
		db	021h,0FFh,077h,014h,0B8h,001h,000h,050h,08Ah,047h,013h,0B4h,000h,0D1h	; CODE_2:24E1
		db	0F8h,0D1h,0F8h,0D1h,0F8h,050h,0E8h,0E6h,008h,083h,0C4h,006h,08Bh,05Eh	; CODE_2:24EF
		db	0FEh,081h,067h,00Ah,0FFh,0DFh,08Bh,05Eh,0FEh,08Bh,047h,00Ah,025h,060h	; CODE_2:24FD
		db	010h,03Dh,000h,010h,075h,006h,0FFh,076h,0FEh,0E8h,0F4h,0E6h,08Bh,05Eh	; CODE_2:250B
		db	0FEh,0F7h,047h,00Ah,060h,000h,074h,010h,0F7h,047h,00Ah,018h,010h,075h	; CODE_2:2519
		db	009h,0FFh,076h,0FEh,0B0h,001h,050h,0E8h,09Bh,0E7h,0F7h,046h,00Eh,008h	; CODE_2:2527
		db	000h,075h,003h,0E9h,0EEh,000h,08Bh,05Eh,0FEh,0F7h,047h,00Ah,008h,000h	; CODE_2:2535
		db	074h,009h,0FFh,076h,0FEh,0E8h,034h,0E2h,0E9h,0DBh,000h,08Bh,05Eh,0FEh	; CODE_2:2543
		db	0F7h,047h,00Ah,000h,010h,074h,006h,0FFh,076h,0FEh,0E8h,0ADh,0E6h,08Bh	; CODE_2:2551
		db	05Eh,0FEh,08Bh,047h,004h,089h,046h,0FCh,08Bh,05Eh,0FCh,0F7h,047h,00Ah	; CODE_2:255F
		db	004h,000h,074h,01Bh,03Bh,006h,014h,000h,075h,015h,0FFh,076h,0FEh,0FFh	; CODE_2:256D
		db	037h,0FFh,016h,02Ch,000h,0FFh,076h,0FCh,0E8h,0D0h,0DEh,0FFh,076h,0FCh	; CODE_2:257B
		db	0E8h,0FCh,0E0h,08Bh,05Eh,0FEh,08Bh,007h,08Bh,01Eh,014h,000h,03Bh,007h	; CODE_2:2589
		db	076h,06Ah,08Bh,046h,0FEh,089h,046h,0FCh,08Bh,05Eh,0FEh,081h,04Fh,00Ah	; CODE_2:2597
		db	000h,080h,08Bh,047h,00Ah,00Dh,008h,000h,050h,0FFh,076h,00Ah,0FFh,076h	; CODE_2:25A5
		db	008h,0FFh,077h,008h,0FFh,076h,0FAh,0FFh,076h,0FEh,0E8h,0F4h,0FAh,089h	; CODE_2:25B3
		db	046h,0FEh,00Bh,0C0h,075h,032h,08Bh,05Eh,0FCh,081h,067h,00Ah,0FFh,07Fh	; CODE_2:25C1
		db	0FFh,076h,0FCh,0E8h,018h,0E3h,00Bh,0C0h,075h,018h,0B8h,008h,000h,050h	; CODE_2:25CF
		db	050h,0FFh,076h,00Ah,0FFh,076h,008h,033h,0C0h,050h,00Eh,0E8h,03Fh,0FCh	; CODE_2:25DD
		db	089h,046h,0F8h,0E9h,05Ch,001h,0C7h,046h,0F8h,000h,010h,0E9h,054h,001h	; CODE_2:25EB
		db	08Bh,05Eh,0FEh,081h,067h,00Ah,0FFh,07Fh,0EBh,026h,08Bh,05Eh,0FEh,083h	; CODE_2:25F9
		db	04Fh,00Ah,008h,0A1h,014h,000h,03Bh,046h,0FEh,075h,006h,08Bh,047h,006h	; CODE_2:2607
		db	0A3h,014h,000h,0A1h,00Ch,000h,03Bh,046h,0FEh,075h,009h,08Bh,05Eh,0FEh	; CODE_2:2615
		db	08Bh,047h,006h,0A3h,00Ch,000h,0F7h,046h,00Eh,010h,000h,075h,003h,0E9h	; CODE_2:2623
		db	01Ah,001h,08Bh,05Eh,0FEh,0F7h,047h,00Ah,010h,000h,074h,009h,0FFh,076h	; CODE_2:2631
		db	0FEh,0E8h,091h,0E1h,0E9h,007h,001h,08Bh,05Eh,0FEh,0F7h,047h,00Ah,000h	; CODE_2:263F
		db	010h,074h,006h,0FFh,076h,0FEh,0E8h,0B5h,0E5h,08Bh,05Eh,0FEh,08Bh,047h	; CODE_2:264D
		db	006h,089h,046h,0FCh,08Bh,05Eh,0FCh,0F7h,047h,00Ah,004h,000h,074h,045h	; CODE_2:265B
		db	08Bh,047h,006h,03Bh,006h,016h,000h,075h,03Ch,08Bh,05Eh,0FEh,08Bh,007h	; CODE_2:2669
		db	089h,046h,0F6h,0FFh,076h,0FEh,08Bh,007h,08Bh,05Eh,0FCh,003h,047h,002h	; CODE_2:2677
		db	050h,0FFh,016h,02Eh,000h,08Bh,05Eh,0FEh,08Bh,046h,0F6h,089h,007h,0FFh	; CODE_2:2685
		db	076h,0FEh,0E8h,0BEh,0DDh,0A1h,014h,000h,03Bh,046h,0FEh,075h,008h,08Bh	; CODE_2:2693
		db	046h,0FCh,0A3h,014h,000h,0EBh,006h,0FFh,076h,0FCh,0E8h,0DAh,0DFh,08Bh	; CODE_2:26A1
		db	05Eh,0FEh,08Bh,007h,003h,047h,002h,08Bh,01Eh,016h,000h,03Bh,007h,073h	; CODE_2:26AF
		db	068h,08Bh,046h,0FEh,089h,046h,0FCh,08Bh,05Eh,0FEh,081h,04Fh,00Ah,000h	; CODE_2:26BD
		db	080h,08Bh,047h,00Ah,00Dh,010h,000h,050h,0FFh,076h,00Ah,0FFh,076h,008h	; CODE_2:26CB
		db	0FFh,077h,008h,0FFh,076h,0FAh,0FFh,076h,0FEh,0E8h,0CFh,0F9h,089h,046h	; CODE_2:26D9
		db	0FEh,00Bh,0C0h,075h,030h,08Bh,05Eh,0FCh,081h,067h,00Ah,0FFh,07Fh,0FFh	; CODE_2:26E7
		db	076h,0FCh,0E8h,0F3h,0E1h,00Bh,0C0h,075h,017h,0B8h,010h,000h,050h,050h	; CODE_2:26F5
		db	0FFh,076h,00Ah,0FFh,076h,008h,033h,0C0h,050h,00Eh,0E8h,01Ah,0FBh,089h	; CODE_2:2703
		db	046h,0F8h,0EBh,038h,0C7h,046h,0F8h,000h,010h,0EBh,031h,08Bh,05Eh,0FEh	; CODE_2:2711
		db	081h,067h,00Ah,0FFh,07Fh,0EBh,027h,08Bh,05Eh,0FEh,083h,04Fh,00Ah,010h	; CODE_2:271F
		db	08Bh,047h,006h,03Bh,006h,016h,000h,075h,006h,08Bh,046h,0FEh,0A3h,016h	; CODE_2:272D
		db	000h,0A1h,00Ch,000h,03Bh,046h,0FEh,075h,009h,08Bh,05Eh,0FEh,08Bh,047h	; CODE_2:273B
		db	004h,0A3h,00Ch,000h,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,08Bh,046h,0F8h,0A3h,0C2h; CODE_2:2749
		db	006h,083h,07Eh,0F8h,000h,074h,00Bh,0B8h,001h,000h,050h,0FFh,076h,0F8h	; CODE_2:2757
		db	0FFh,01Eh,0A8h,05Eh,08Bh,046h,0F8h,01Fh,08Bh,0E5h,05Dh,0CAh,00Ah,000h	; CODE_2:2765
		db	055h,08Bh,0ECh,083h,0ECh,006h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,083h,07Eh; CODE_2:2773
		db	006h,000h,075h,008h,0A0h,0C0h,006h,0B4h,000h,089h,046h,006h,0C7h,046h	; CODE_2:2781
		db	0FCh,000h,000h,0EBh,07Dh,090h,08Bh,05Eh,0FCh,0D1h,0E3h,08Bh,08Fh,0CAh	; CODE_2:278F
		db	006h,0E3h,06Eh,08Eh,0D9h,08Bh,01Eh,00Eh,000h,0EBh,052h,08Bh,05Eh,0FEh	; CODE_2:279D
		db	0F7h,047h,00Ah,004h,000h,075h,026h,08Ah,047h,00Ch,0B4h,000h,03Bh,046h	; CODE_2:27AB
		db	006h,075h,01Ch,0FFh,076h,00Ah,0FFh,076h,008h,0FFh,077h,010h,0FFh,077h	; CODE_2:27B9
		db	00Eh,033h,0C0h,050h,00Eh,0E8h,05Bh,0FAh,089h,046h,0FAh,00Bh,0C0h,074h	; CODE_2:27C7
		db	002h,0EBh,044h,08Bh,05Eh,0FEh,083h,07Fh,004h,000h,075h,016h,0EBh,009h	; CODE_2:27D5
		db	08Bh,05Eh,0FEh,08Bh,047h,006h,089h,046h,0FEh,08Bh,05Eh,0FEh,083h,07Fh	; CODE_2:27E3
		db	004h,000h,074h,0EEh,0EBh,009h,08Bh,05Eh,0FEh,08Bh,047h,006h,089h,046h	; CODE_2:27F1
		db	0FEh,08Bh,046h,0FEh,03Bh,006h,010h,000h,075h,09Fh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh; CODE_2:27FF
		db	0D8h,0FFh,046h,0FCh,083h,07Eh,0FCh,006h,07Dh,003h,0E9h,07Bh,0FFh,033h	; CODE_2:280D
		db	0C0h,01Fh,08Bh,0E5h,05Dh,0CAh,006h,000h,055h,08Bh,0ECh,04Ch,04Ch,0E8h	; CODE_2:281B
		db	008h,0DAh,089h,046h,0FEh,08Bh,05Eh,006h,08Bh,047h,002h,02Bh,046h,004h	; CODE_2:2829
		db	08Bh,05Eh,0FEh,089h,047h,002h,08Bh,05Eh,006h,08Bh,046h,004h,089h,047h	; CODE_2:2837
		db	002h,08Bh,05Eh,0FEh,08Bh,047h,002h,029h,006h,01Ah,000h,08Bh,05Eh,006h	; CODE_2:2845
		db	08Bh,007h,003h,046h,004h,08Bh,05Eh,0FEh,089h,007h,0FFh,076h,006h,0FFh	; CODE_2:2853
		db	076h,0FEh,0E8h,015h,0DDh,08Bh,05Eh,0FEh,0C7h,047h,00Ah,004h,000h,0FFh	; CODE_2:2861
		db	076h,0FEh,0E8h,092h,0DCh,08Bh,046h,0FEh,0A3h,01Ch,000h,08Bh,046h,0FEh	; CODE_2:286F
		db	08Bh,0E5h,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,083h,0ECh,018h,01Eh,0B8h	; CODE_2:287D
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C7h,046h,0F6h,0FFh,0FFh,0C7h,046h,0F4h,0FFh,0FFh; CODE_2:288B
		db	0C7h,046h,0F0h,000h,000h,08Eh,01Eh,0CAh,006h,0C7h,046h,0FCh,000h,000h	; CODE_2:2899
		db	083h,07Eh,006h,000h,074h,017h,08Bh,046h,006h,089h,046h,0FEh,0C4h,05Eh	; CODE_2:28A7
		db	0FCh,026h,08Bh,047h,006h,026h,08Bh,057h,004h,089h,046h,0F6h,089h,056h	; CODE_2:28B5
		db	0F4h,08Bh,046h,008h,089h,046h,0FEh,0A1h,01Ah,000h,033h,0D2h,0D1h,0E0h	; CODE_2:28C3
		db	0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h	; CODE_2:28D1
		db	0C4h,05Eh,0FCh,08Bh,046h,0FAh,08Bh,056h,0F8h,026h,003h,057h,004h,026h	; CODE_2:28DF
		db	013h,047h,006h,03Bh,046h,0F6h,077h,01Eh,072h,005h,03Bh,056h,0F4h,073h	; CODE_2:28ED
		db	017h,0C4h,05Eh,0FCh,08Bh,046h,0FAh,08Bh,056h,0F8h,026h,003h,057h,004h	; CODE_2:28FB
		db	026h,013h,047h,006h,089h,046h,0F6h,089h,056h,0F4h,08Bh,04Eh,008h,08Eh	; CODE_2:2909
		db	0C1h,026h,08Bh,00Eh,012h,000h,0E3h,018h,08Eh,0C1h,026h,0A1h,004h,000h	; CODE_2:2917
		db	026h,08Bh,016h,006h,000h,02Bh,046h,0F4h,01Bh,056h,0F6h,079h,005h,0FFh	; CODE_2:2925
		db	046h,0F0h,0EBh,0E1h,08Ch,0C0h,03Bh,046h,008h,075h,003h,0E9h,021h,002h	; CODE_2:2933
		db	08Bh,046h,0F0h,0BAh,003h,000h,0F7h,0EAh,050h,0E8h,0CAh,0D6h,00Bh,0C0h	; CODE_2:2941
		db	074h,003h,0E9h,00Eh,002h,0C4h,05Eh,0FCh,026h,08Bh,047h,006h,026h,08Bh	; CODE_2:294F
		db	057h,004h,029h,056h,0F4h,019h,046h,0F6h,0B1h,004h,08Bh,056h,0F6h,08Bh	; CODE_2:295D
		db	046h,0F4h,09Ah,0E3h,003h
		dw	seg BCC_COPY_WORDS
		db	089h,056h,0F6h,089h,046h,0F4h,0A1h; CODE_2:296B
		db	01Ah,000h,033h,0D2h,03Bh,056h,0F6h,077h,012h,072h,005h,03Bh,046h,0F4h	; CODE_2:2979
		db	073h,00Bh,0A1h,01Ah,000h,0C7h,046h,0F6h,000h,000h,089h,046h,0F4h,0FFh	; CODE_2:2987
		db	076h,0F4h,0FFh,036h,014h,000h,0FFh,036h,016h,000h,0E8h,068h,0E5h,089h	; CODE_2:2995
		db	046h,0EEh,00Bh,0C0h,075h,003h,0E9h,0B6h,001h,0FFh,076h,008h,08Bh,05Eh	; CODE_2:29A3
		db	0EEh,033h,0C0h,050h,0FFh,037h,0FFh,076h,0F6h,0FFh,076h,0F4h,0E8h,03Bh	; CODE_2:29B1
		db	020h,00Bh,0C0h,074h,003h,0E9h,09Bh,001h,0C4h,05Eh,0FCh,026h,08Bh,047h	; CODE_2:29BF
		db	006h,026h,08Bh,057h,004h,089h,046h,0FAh,089h,056h,0F8h,08Bh,05Eh,0EEh	; CODE_2:29CD
		db	08Bh,007h,089h,046h,0F2h,0E9h,076h,001h,01Eh,08Eh,01Eh,00Ah,000h,0C4h	; CODE_2:29DB
		db	05Eh,0FCh,026h,0FFh,077h,00Eh,016h,08Dh,046h,0EAh,050h,0E8h,0CAh,004h	; CODE_2:29E9
		db	089h,046h,0E8h,01Fh,083h,07Eh,0E8h,000h,075h,025h,08Bh,05Eh,0EEh,0F7h	; CODE_2:29F7
		db	047h,00Ah,000h,008h,075h,003h,0E9h,041h,001h,0FFh,076h,0EEh,0E8h,072h	; CODE_2:2A05
		db	0E2h,0FFh,076h,0EEh,0E8h,0F1h,0E1h,0FFh,076h,0EEh,0B0h,000h,050h,0E8h	; CODE_2:2A13
		db	0A9h,0E2h,0E9h,029h,001h,0C4h,05Eh,0FCh,026h,08Bh,047h,006h,026h,08Bh	; CODE_2:2A21
		db	057h,004h,02Bh,056h,0F8h,01Bh,046h,0FAh,089h,046h,0F6h,089h,056h,0F4h	; CODE_2:2A2F
		db	0B1h,004h,08Bh,056h,0F6h,08Bh,046h,0F4h,09Ah,0E3h,003h
		dw	seg BCC_COPY_WORDS
		db	089h; CODE_2:2A3D
		db	056h,0F6h,089h,046h,0F4h,08Bh,046h,0F2h,001h,046h,0F4h,083h,056h,0F6h	; CODE_2:2A4B
		db	000h,08Bh,05Eh,0EEh,08Bh,046h,0F6h,08Bh,056h,0F4h,02Bh,017h,01Dh,000h	; CODE_2:2A59
		db	000h,00Bh,0C0h,072h,018h,077h,004h,00Bh,0D2h,076h,012h,0FFh,076h,0EEh	; CODE_2:2A67
		db	08Bh,05Eh,0EEh,08Bh,046h,0F4h,02Bh,007h,050h,0E8h,0A2h,0FDh,089h,046h	; CODE_2:2A75
		db	0EEh,0FFh,076h,0EEh,0C4h,05Eh,0FCh,026h,0FFh,077h,008h,0E8h,0BEh,006h	; CODE_2:2A83
		db	050h,0B0h,000h,050h,0E8h,03Dh,0DBh,089h,046h,0ECh,0C4h,05Eh,0FCh,026h	; CODE_2:2A91
		db	08Bh,047h,008h,08Bh,05Eh,0EEh,089h,047h,008h,01Eh,02Eh,08Eh,01Eh,096h	; CODE_2:2A9F
		db	046h,08Bh,05Eh,0E8h,0D1h,0E3h,08Eh,09Fh,0CAh,006h,0FFh,076h,0E8h,033h	; CODE_2:2AAD
		db	0C0h,050h,0FFh,076h,0EAh,0FFh,076h,0EEh,0E8h,0F2h,0D9h,083h,07Eh,0E8h	; CODE_2:2ABB
		db	001h,07Ch,028h,083h,07Eh,0E8h,005h,07Dh,022h,01Fh,08Bh,05Eh,0EEh,081h	; CODE_2:2AC9
		db	04Fh,00Ah,000h,020h,08Ah,046h,0E8h,0B1h,003h,0D2h,0E0h,00Ah,006h,004h	; CODE_2:2AD7
		db	000h,08Bh,05Eh,0EEh,088h,047h,013h,08Bh,046h,0EAh,089h,047h,014h,0EBh	; CODE_2:2AE5
		db	00Fh,0FFh,076h,0EAh,0FFh,016h,024h,000h,01Fh,08Bh,05Eh,0EEh,0C6h,047h	; CODE_2:2AF3
		db	013h,000h,08Bh,05Eh,0EEh,08Bh,047h,002h,001h,006h,034h,000h,081h,067h	; CODE_2:2B01
		db	00Ah,07Fh,0FEh,0FFh,076h,0EEh,0B0h,001h,050h,0E8h,065h,003h,08Bh,05Eh	; CODE_2:2B0F
		db	0EEh,0F7h,047h,00Ah,060h,000h,074h,00Bh,0FFh,006h,040h,000h,08Bh,047h	; CODE_2:2B1D
		db	002h,001h,006h,042h,000h,08Bh,05Eh,0EEh,0F7h,047h,00Ah,000h,010h,075h	; CODE_2:2B2B
		db	009h,0FFh,076h,0EEh,0B0h,001h,050h,0E8h,089h,0E1h,08Eh,046h,0FEh,0E8h	; CODE_2:2B39
		db	03Eh,01Fh,08Bh,046h,0ECh,089h,046h,0EEh,0C4h,05Eh,0FCh,026h,08Bh,047h	; CODE_2:2B47
		db	01Ch,089h,046h,0FEh,083h,07Eh,0FEh,000h,074h,003h,0E9h,081h,0FEh,01Fh	; CODE_2:2B55
		db	08Bh,0E5h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,083h,0ECh,004h,01Eh,02Eh	; CODE_2:2B63
		db	08Eh,01Eh,096h,046h,0FFh,076h,004h,016h,08Dh,046h,0FEh,050h,0E8h,041h	; CODE_2:2B71
		db	003h,089h,046h,0FCh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,0FFh	; CODE_2:2B7F
		db	076h,0FEh,0E8h,0F4h,0E0h,0FFh,076h,0FEh,0E8h,073h,0E0h,0FFh,076h,0FEh	; CODE_2:2B8D
		db	0B0h,000h,050h,0E8h,02Bh,0E1h,01Fh,08Bh,0E5h,05Dh,0C2h,002h,000h,055h	; CODE_2:2B9B
		db	08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h	; CODE_2:2BA9

CODE_2	ends
; END RHAPI
; BEGIN R34F0 (listing CODE_2:2BB0)

CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M006_BCC_DATA_06C0	equ	6C0h

		public	BCC_FAR_34F0

		public	BCC_SET_OPTION
BCC_SET_OPTION	label	far
BCC_FAR_34F0	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	AL,byte ptr [BP+6]
		mov	DGROUP:M006_BCC_DATA_06C0,AL
		pop	DS
		pop	BP
		retf	2
BCC_FAR_34F0	endp
CODE_2	ends

; Original-target semantic aliases (zero bytes)
; END R34F0
; BEGIN R3504 (listing CODE_2:2BC4)

CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M007_BCC_DATA_06C0	equ	6C0h

		public	BCC_FAR_3504

BCC_FAR_3504	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	AL,DGROUP:M007_BCC_DATA_06C0
		pop	DS
		pop	BP
		retf
BCC_FAR_3504	endp
CODE_2	ends

; END R3504
; BEGIN R3513 (listing CODE_2:2BD3)

CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M008_BCC_DATA_06DA	equ	6DAh
M008_BCC_DATA_06FA	equ	6FAh

		public	BCC_FAR_3513

BCC_FAR_3513	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		cld
		db	08Dh,016h
		dw	6FAh
		db	08Dh,036h
		dw	6DAh
M008_L_3526:
		lodsw
		cmp	AX,0FFFFh
		je	short M008_L_3535
		mov	CX,10h
M008_L_352F:
		ror	AX,1
		jnc	short M008_L_353D
		loop	short M008_L_352F
M008_L_3535:
		cmp	SI,DX
		jc	short M008_L_3526
		mov	AL,0
		jmp	short M008_L_3557
M008_L_353D:
		or	AX,8000h
		mov	BX,CX
		dec	CX
		ror	AX,CL
		mov	word ptr [SI-2],AX
		sub	SI,6DCh
		mov	CL,3
		shl	SI,CL
		mov	AX,SI
		add	AX,10h
		sub	AX,BX
M008_L_3557:
		pop	DS
		pop	SI
		pop	BP
		retf
BCC_FAR_3513	endp
CODE_2	ends

; R355B (CODE_2:2C1B) is part of the same module




CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP
		public	BCC_FAR_355B

BCC_FAR_355B	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	AL,byte ptr [BP+6]
		push	AX
		db	09Ah
		dw	BCC_FAR_25FF
		dw	seg BCC_FAR_25FF
		mov	BL,byte ptr [BP+6]
		xor	BH,BH
		mov	CX,BX
		and	CL,7
		mov	AL,0FEh
		rol	AL,CL
		mov	CL,3
		shr	BX,CL
		and	byte ptr [BX+6DAh],AL
		pop	DS
		pop	BP
		retf	2
BCC_FAR_355B	endp
CODE_2	ends

; Original-target semantic aliases (zero bytes)
		public	BCC_OUTPUT_FLUSH
BCC_OUTPUT_FLUSH	equ	BCC_FAR_355B+14Ch
; END R3513
; BEGIN RH2C48 (complete raw function CODE_2:2C48..2C7B)
CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh; CODE_2:2C48
		db	006h,026h,0FFh,037h,016h,08Dh,046h,0FEh,050h,0E8h,05Fh,002h,089h,046h	; CODE_2:2C56
		db	0FCh,08Bh,05Eh,0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FEh,08Bh	; CODE_2:2C64
		db	047h,008h,01Fh,08Bh,0E5h,05Dh,0CAh,004h,000h ; CODE_2:2C72
CODE_2 ends
; END RH2C48
; BEGIN RH2C7B (gap CODE_2:2C7B)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
		db	055h,08Bh,0ECh,04Ch,04Ch ; CODE_2:2C7B
		db	01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0C4h,05Eh,006h,026h,0FFh,037h,016h,08Dh; CODE_2:2C80
		db	046h,0FEh,050h,0E8h,02Dh,002h,03Dh,005h,000h,075h,005h,0B8h,001h,000h	; CODE_2:2C8E
		db	0EBh,002h,033h,0C0h,01Fh,08Bh,0E5h,05Dh,0CAh,004h,000h ; CODE_2:2C9C
CODE_2 ends
; END RH2C7B
; BEGIN RH2CA7 (complete raw function CODE_2:2CA7..2CAF)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
		db	055h,08Bh,0ECh ; CODE_2:2CA7
		db	0E8h,0FAh,0FFh,05Dh,0C3h ; CODE_2:2CAA
CODE_2 ends
; END RH2CA7
; BEGIN RHINIT (complete source CODE_2:2CAF..2D67)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
		db	055h,08Bh,0ECh,01Eh,0B8h ; CODE_2:2CAF
		dw	seg BCC_SEG_180
		db	08Eh,0D8h; CODE_2:2CAA
		db	0C6h,006h,0C0h,006h,000h,08Bh,046h,00Ch,08Bh,056h,00Ah,0A3h,0AAh,05Eh	; CODE_2:2CB8
		db	089h,016h,0A8h,05Eh,0C6h,006h,0FAh,006h,001h,090h,054h,058h,03Bh,0C4h	; CODE_2:2CC6
		db	075h,032h,0FEh,006h,0FAh,006h,01Eh,0B8h,006h,035h,0CDh,021h,006h,053h	; CODE_2:2CD4
		db	00Eh,01Fh,0BAh,0FCh,02Ch,0B8h,006h,025h,0CDh,021h,09Ch,066h,08Bh,0C3h	; CODE_2:2CE2
		db	02Eh,08Eh,01Eh,096h,046h,0FEh,006h,0FAh,006h,083h,0ECh,006h,083h,0C4h	; CODE_2:2CF0
		db	006h,09Dh,05Ah,01Fh,0B8h,006h,025h,0CDh,021h,01Fh,0C7h,006h,0C2h,006h	; CODE_2:2CFE
		db	002h,010h,0FFh,076h,012h,0FFh,076h,010h,0B8h,03Ch,000h,050h,0FFh,076h	; CODE_2:2D0C
		db	00Eh,0E8h,0D2h,005h,00Bh,0C0h,074h,005h,0B8h,002h,010h,0EBh,03Bh,0E8h	; CODE_2:2D1A
		db	0E7h,00Bh,08Bh,046h,006h,00Bh,046h,008h,074h,014h,0B8h,001h,000h,050h	; CODE_2:2D28
		db	0B8h,002h,000h,033h,0D2h,050h,052h,0FFh,076h,008h,0FFh,076h,006h,0E8h	; CODE_2:2D36
		db	07Ch,00Ah,0FFh,076h,012h,0FFh,076h,010h,033h,0C0h,033h,0D2h,050h,052h	; CODE_2:2D44
		db	09Ah,09Fh,046h
		dw	seg BCC_FAR_245C
		db	00Bh,0C0h,074h,005h,0B8h,002h,010h,0EBh,002h; CODE_2:2D52
		db	033h,0C0h,01Fh,05Dh,0CAh,00Eh,000h ; CODE_2:2D60
CODE_2 ends
; END RHINIT
; BEGIN RH2D67 (complete raw function CODE_2:2D67..2DA8)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
		db	055h,08Bh,0ECh,01Eh,0B8h ; CODE_2:2D67
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,083h,03Eh,0CCh,006h,000h,074h,007h,0B8h,001h,000h,050h,0E8h	; CODE_2:2D6E
		db	049h,00Bh,083h,03Eh,0CEh,006h,000h,074h,007h,0B8h,002h,000h,050h,0E8h	; CODE_2:2D7C
		db	03Bh,00Bh,083h,03Eh,0D0h,006h,000h,074h,003h,0E8h,047h,00Fh,083h,03Eh	; CODE_2:2D8A
		db	0D2h,006h,000h,074h,003h,0E8h,0DEh,011h,09Ah,02Fh,048h
		dw	seg BCC_FAR_245C
		db	01Fh; CODE_2:2D98
		db	05Dh,0CBh
CODE_2 ends
; END RH2D67
; BEGIN GETSTAT (derived raw function CODE_2:2DA8..2DB7)
CODE_2 segment byte public 'CODE'
		assume cs:CODE_2
		db	055h,08Bh,0ECh,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0A1h,0C2h,006h,01Fh,05Dh,0CBh

CODE_2	ends
; END GETSTAT
; BEGIN R36F7 (listing CODE_2:2DB7)

CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP

M00B_BCC_DATA_001A	equ	1Ah
M00B_BCC_DATA_0036	equ	36h
M00B_BCC_DATA_0042	equ	42h
M00B_BCC_DATA_06CA	equ	6CAh

		public	BCC_FAR_36F7

BCC_FAR_36F7	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,seg BCC_SEG_180
		mov	DS,AX
		mov	DS,word ptr DGROUP:M00B_BCC_DATA_06CA
		mov	AX,DGROUP:M00B_BCC_DATA_001A
		add	AX,word ptr DGROUP:M00B_BCC_DATA_0042
		sub	AX,word ptr DGROUP:M00B_BCC_DATA_0036
		mov	CL,4
		rol	AX,CL
		mov	DX,AX
		and	AX,0FFF0h
		and	DX,0Fh
		pop	DS
		pop	BP
		retf
BCC_FAR_36F7	endp
CODE_2	ends

; END R36F7
; BEGIN RG2B (listing CODE_2:2DDE)
CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2

		public	BCC_NEAR_37C0
		public	BCC_NEAR_3801

		db	055h,08Bh,0ECh,083h,0ECh,004h,0C7h,046h,0FEh,000h,000h,0C7h,046h,0FCh	; CODE_2:2DDE
		db	0FFh,000h,08Ch,0D8h,03Dh
		dw	seg BCC_SEG_180
		db	074h,00Dh,0A0h,004h,000h,0B4h,000h; CODE_2:2DEC
		db	089h,046h,0FCh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,08Bh,05Eh,004h,0D1h,0E3h,083h; CODE_2:2DFA
		db	0BFh,0CAh,006h,000h,074h,04Dh,08Bh,05Eh,004h,0D1h,0E3h,08Eh,09Fh,0CAh	; CODE_2:2E08
		db	006h,08Bh,05Eh,006h,083h,0FBh,003h,077h,037h,0D1h,0E3h,02Eh,0FFh,0A7h	; CODE_2:2E16
		db	078h,02Eh,0FFh,076h,008h,0FFh,016h,022h,000h,089h,046h,0FEh,0EBh,029h	; CODE_2:2E24
		db	0FFh,076h,008h,0FFh,016h,024h,000h,089h,046h,0FEh,0EBh,01Dh,0FFh,076h	; CODE_2:2E32
		db	008h,0FFh,076h,00Ah,0FFh,016h,028h,000h,0EBh,00Ch,0FFh,076h,008h,0FFh	; CODE_2:2E40
		db	076h,00Ah,0FFh,016h,02Ah,000h,0EBh,000h,0C7h,046h,0FEh,000h,000h,0B8h	; CODE_2:2E4E
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,081h,07Eh,0FCh,0FFh,000h,074h,009h,08Bh,05Eh,0FCh; CODE_2:2E5C
		db	0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,046h,0FEh,08Bh,0E5h,05Dh,0C3h,000h	; CODE_2:2E6A
		db	026h,02Eh,032h,02Eh,03Eh,02Eh,04Ah,02Eh	; CODE_2:2E78
BCC_NEAR_37C0	label	near
		db	055h,08Bh,0ECh,056h,0F6h,046h,004h,002h,074h,018h,08Bh,046h,006h,08Bh	; CODE_2:2E80
		db	0D8h,02Bh,006h,01Eh,000h,0B9h,016h,000h,033h,0D2h,0F7h,0F1h,0C4h,05Fh	; CODE_2:2E8E
		db	00Eh,026h,089h,007h,0EBh,01Ah,08Bh,05Eh,006h,0C4h,05Fh,00Eh,08Bh,076h	; CODE_2:2E9C
		db	006h,08Bh,004h,026h,089h,007h,08Bh,0C8h,049h,08Eh,0C1h,08Bh,046h,006h	; CODE_2:2EAA
		db	026h,0A3h,00Eh,000h,05Eh,05Dh,0C2h,004h,000h	; CODE_2:2EB8
BCC_NEAR_3801	label	near
		db	055h,08Bh,0ECh,081h,07Eh,008h,000h,010h,072h,010h,08Bh,046h,008h,048h	; CODE_2:2EC1
		db	08Eh,0C0h,026h,08Bh,00Eh,00Eh,000h,0B8h,000h,000h,0EBh,024h,08Bh,046h	; CODE_2:2ECF
		db	008h,0BAh,016h,000h,0F7h,0E2h,005h,0E0h,001h,08Bh,0D8h,08Eh,006h,0CAh	; CODE_2:2EDD
		db	006h,026h,08Ah,047h,013h,025h,007h,000h,08Bh,0C8h,0BAh,050h,000h,0F7h	; CODE_2:2EEB
		db	0E2h,02Bh,0D8h,08Bh,0C3h,091h,0C4h,05Eh,004h,026h,089h,00Fh,05Dh,0C2h	; CODE_2:2EF9
		db	006h,000h
CODE_2 ends
; END RG2B
; BEGIN RT2F09 (derived raw function CODE_2:2F09..2F23)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
		db	055h,08Bh,0ECh,01Eh,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,0FFh,076h,00Ah; CODE_2:2F07
		db	0FFh,076h,008h,0FFh,076h,006h,0E8h,0A3h,0FFh,01Fh,05Dh,0CAh,006h,000h	; CODE_2:2F15
CODE_2 ends
; END RT2F09
; BEGIN RG2BTAIL (derived raw prefix CODE_2:2F23..38C7)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h,08Bh,0ECh,083h,0ECh,004h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,0FFh,076h
	db 006h,016h,08Dh,046h,0FEh,050h,0E8h,087h,0FFh,089h,046h,0FCh,08Bh,05Eh
	db 0FCh,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FEh,08Bh,057h,010h,08Bh
	db 047h,00Eh,01Fh,08Bh,0E5h,05Dh,0CAh,002h,000h,055h,08Bh,0ECh,083h,0ECh
	db 010h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Bh,046h,006h,0BAh,00Eh,000h,089h
	db 046h,0FEh,089h,056h,0FCh,0C4h,05Eh,0FCh,026h,0FFh,037h,016h,08Dh,046h
	db 0FAh,050h,0E8h,045h,0FFh,0D1h,0E0h,08Bh,0D8h,08Eh,09Fh,0CAh,006h,08Bh
	db 05Eh,0FAh,0F7h,047h,00Ah,018h,000h,074h,003h,0E9h,0C2h,000h,02Eh,08Eh
	db 01Eh,096h,046h,0FFh,076h,006h,09Ah,0AEh,04Ch
		dw	seg BCC_FAR_245C
	db 0C4h,05Eh,0FCh
	db 026h,0FFh,037h,016h,08Dh,046h,0FAh,050h,0E8h,015h,0FFh,0D1h,0E0h,08Bh
	db 0D8h,08Eh,09Fh,0CAh,006h,09Ah,034h,01Fh
		dw	seg BCC_FAR_245C
	db 089h,056h,0F8h,089h
	db 046h,0F6h,08Bh,05Eh,0FAh,08Bh,047h,002h,089h,046h,0F0h,08Bh,046h,0F0h
	db 033h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h
	db 0D1h,0E0h,0D1h,0D2h,089h,046h,0F2h,089h,056h,0F4h,08Bh,046h,0F8h,08Bh
	db 056h,0F6h,003h,056h,0F2h,013h,046h,0F4h,050h,052h,09Ah,0A0h,01Eh
		dw	seg BCC_FAR_245C
	db 08Bh,05Eh,0F8h,08Bh,04Eh,0F6h,003h,04Eh,0F2h,013h,05Eh,0F4h,03Bh
	db 0D3h,075h,004h,03Bh,0C1h,074h,005h,0B8h,000h,010h,0EBh,046h,08Bh,05Eh
	db 0FAh,0F7h,047h,00Ah,000h,004h,074h,007h,08Bh,047h,002h,029h,006h,034h
	db 000h,0FFh,00Eh,040h,000h,08Bh,05Eh,0FAh,08Bh,047h,002h,029h,006h,042h
	db 000h,081h,067h,00Ah,09Fh,0FBh,0FFh,076h,0F8h,0FFh,076h,0F6h,09Ah,0A0h
	db 01Eh
		dw	seg BCC_FAR_245C
	db 0B8h,008h,000h,050h,050h,0FFh,076h,0FEh,0FFh,076h,0FCh
	db 033h,0C0h,050h,09Ah,02Ah,022h
		dw	seg BCC_FAR_245C
	db 0EBh,002h,033h,0C0h,01Fh,08Bh
	db 0E5h,05Dh,0CAh,002h,000h,055h,08Bh,0ECh,083h,0ECh,008h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Bh,046h,006h,0BAh,00Eh,000h,089h,046h,0FEh,089h,056h
	db 0FCh,0C4h,05Eh,0FCh,026h,0FFh,037h,016h,08Dh,046h,0FAh,050h,0E8h,03Fh
	db 0FEh,0D1h,0E0h,08Bh,0D8h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FAh,0F7h,047h
	db 00Ah,008h,000h,074h,06Ah,033h,0C0h,050h,0B8h,008h,000h,050h,0FFh,076h
	db 0FEh,0FFh,076h,0FCh,033h,0C0h,050h,09Ah,02Ah,022h
		dw	seg BCC_FAR_245C
	db 08Bh,05Eh
	db 0FAh,081h,04Fh,00Ah,060h,004h,0F7h,047h,00Ah,000h,004h,074h,007h,08Bh
	db 047h,002h,001h,006h,034h,000h,0FFh,006h,040h,000h,08Bh,05Eh,0FAh,08Bh
	db 047h,002h,001h,006h,042h,000h,0F7h,047h,00Ah,000h,020h,074h,02Ah,08Ah
	db 047h,013h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,089h,046h,0F8h,08Bh
	db 047h,014h,089h,046h,0FAh,02Eh,08Eh,01Eh,096h,046h,08Bh,05Eh,0F8h,0D1h
	db 0E3h,08Eh,09Fh,0CAh,006h,08Bh,05Eh,0FAh,081h,04Fh,00Ah,000h,004h,01Fh
	db 08Bh,0E5h,05Dh,0CAh,002h,000h,055h,08Bh,0ECh,04Ch,04Ch,08Bh,01Eh,012h
	db 000h,08Bh,047h,010h,089h,046h,0FEh,03Bh,006h,012h,000h,075h,004h,033h
	db 0C0h,0EBh,02Bh,08Bh,05Eh,0FEh,08Bh,047h,010h,03Bh,006h,012h,000h,075h
	db 011h,08Bh,047h,002h,03Bh,046h,004h,072h,005h,08Bh,046h,0FEh,0EBh,012h
	db 033h,0C0h,0EBh,00Eh,0FFh,076h,004h,0FFh,036h,014h,000h,0FFh,036h,016h
	db 000h,0E8h,0C1h,0DDh,08Bh,0E5h,05Dh,0C2h,002h,000h,055h,08Bh,0ECh,08Bh
	db 046h,004h,033h,0D2h,003h,006h,006h,000h,083h,0D2h,000h,0F7h,036h,008h
	db 000h,05Dh,0C2h,002h,000h,055h,08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h,055h
	db 08Bh,0ECh,056h,057h,01Eh,08Bh,07Eh,006h,08Bh,04Dh,008h,083h,0C1h,001h
	db 0D1h,0D9h,08Eh,01Dh,08Eh,046h,004h,033h,0F6h,033h,0FFh,0FCh,0EBh,007h
	db 0D1h,0E9h,0F3h,066h,0A5h,0D1h,0D1h,0F3h,0A5h,058h,08Ch,0DBh,08Ch,0C6h
	db 03Bh,0C3h,075h,020h,0BFh,0CAh,006h,02Eh,08Eh,006h,096h,046h,0B9h,006h
	db 000h,08Bh,0C6h,026h,083h,03Dh,000h,074h,003h,026h,089h,005h,005h,005h
	db 000h,083h,0C7h,002h,0E2h,0EFh,08Bh,0C6h,08Eh,0D8h,04Eh,08Eh,0C6h,08Bh
	db 046h,006h,026h,0A3h,00Eh,000h,08Bh,05Eh,006h,0F7h,047h,00Ah,000h,008h
	db 075h,009h,0C4h,05Fh,00Eh,08Bh,046h,004h,026h,089h,007h,08Bh,05Eh,006h
	db 08Bh,046h,004h,089h,007h,080h,07Fh,012h,000h,074h,012h,0FFh,076h,006h
	db 0B8h,003h,000h,050h,0FFh,077h,010h,0FFh,077h,00Eh,0FFh,037h,0E8h,065h
	db 012h,05Fh,05Eh,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,056h,057h,01Eh,08Bh
	db 07Eh,006h,08Bh,04Dh,008h,083h,0C1h,001h,0D1h,0D9h,08Eh,01Dh,08Eh,046h
	db 004h,08Bh,0F1h,04Eh,0D1h,0E6h,0FDh,0EBh,010h,0D1h,0E9h,073h,003h,08Bh
	db 0FEh,0A5h,04Eh,04Eh,08Bh,0FEh,0F3h,066h,0A5h,0EBh,004h,08Bh,0FEh,0F3h
	db 0A5h,0FCh,058h,08Ch,0DBh,08Ch,0C6h,03Bh,0C3h,075h,020h,0BFh,0CAh,006h
	db 02Eh,08Eh,006h,096h,046h,0B9h,006h,000h,08Bh,0C6h,026h,083h,03Dh,000h
	db 074h,003h,026h,089h,005h,005h,005h,000h,083h,0C7h,002h,0E2h,0EFh,08Bh
	db 0C6h,08Eh,0D8h,04Eh,08Eh,0C6h,08Bh,046h,006h,026h,0A3h,00Eh,000h,08Bh
	db 05Eh,006h,0F7h,047h,00Ah,000h,008h,075h,009h,0C4h,05Fh,00Eh,08Bh,046h
	db 004h,026h,089h,007h,08Bh,05Eh,006h,08Bh,046h,004h,089h,007h,080h,07Fh
	db 012h,000h,074h,012h,0FFh,076h,006h,0B8h,003h,000h,050h,0FFh,077h,010h
	db 0FFh,077h,00Eh,0FFh,037h,0E8h,0C4h,011h,05Fh,05Eh,05Dh,0C2h,004h,000h
	db 055h,08Bh,0ECh,056h,057h,01Eh,056h,057h,08Bh,07Eh,006h,08Bh,04Dh,008h
	db 083h,0C1h,001h,0D1h,0D9h,08Eh,01Dh,08Eh,046h,004h,033h,0F6h,033h,0FFh
	db 0FCh,0EBh,007h,0D1h,0E9h,0F3h,066h,0A5h,0D1h,0D1h,0F3h,0A5h,05Fh,05Eh
	db 01Fh,08Bh,05Eh,006h,080h,07Fh,012h,000h,074h,013h,0FFh,076h,006h,0B8h
	db 003h,000h,050h,0FFh,077h,010h,0FFh,077h,00Eh,0FFh,076h,004h,0E8h,077h
	db 011h,05Fh,05Eh,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,083h,0ECh,004h,057h
	db 08Bh,046h,006h,0BAh,016h,000h,0F7h,0EAh,005h,0E0h,001h,089h,046h,0FCh
	db 080h,03Eh,0FAh,006h,003h,075h,00Fh,0B8h,090h,090h,02Eh,0A3h,089h,031h
	db 02Eh,0A3h,01Eh,032h,02Eh,0A3h,0C0h,032h,08Bh,046h,008h,02Bh,046h,00Ah
	db 03Dh,000h,004h,073h,006h,0B8h,000h,010h,0E9h,0DCh,000h,02Eh,08Ch,00Eh
	db 05Fh,044h,01Eh,0FFh,046h,00Ah,08Bh,046h,00Ah,0A3h,0CAh,006h,08Bh,046h
	db 00Ah,08Eh,0D8h,08Eh,0C0h,033h,0FFh,08Bh,0C7h,08Bh,04Eh,0FCh,0D1h,0E9h
	db 0FCh,0F3h,0ABh,0B8h,0E0h,001h,089h,046h,0FEh,0A3h,03Ch,000h,0EBh,010h
	db 08Bh,046h,0FEh,005h,016h,000h,08Bh,05Eh,0FEh,089h,047h,010h,083h,046h
	db 0FEh,016h,08Bh,046h,0FEh,03Bh,046h,0FCh,072h,0E8h,083h,06Eh,0FEh,016h
	db 08Bh,05Eh,0FEh,0C7h,047h,010h,000h,000h,08Bh,046h,006h,0A3h,03Eh,000h
	db 0FFh,076h,00Ah,08Bh,046h,008h,02Bh,046h,00Ah,050h,033h,0C0h,050h,0B8h
	db 013h,000h,050h,0B8h,010h,000h,050h,0E8h,0F8h,0E4h,0A0h,005h,000h,00Ch
	db 006h,0A2h,005h,000h,0FFh,076h,0FCh,0E8h,061h,0DDh,089h,046h,0FEh,0A3h
	db 03Ah,000h,08Bh,05Eh,0FEh,0C7h,047h,00Eh,0CAh,006h,0C7h,047h,010h
		dw	seg BCC_SEG_180
	db 08Bh,05Eh,0FEh,081h,04Fh,00Ah,000h,080h,0FFh,076h,0FEh,0B0h,000h
	db 050h,0E8h,0B3h,0FAh,0C7h,006h,028h,000h,06Eh,031h,0C7h,006h,02Ah,000h
	db 0A3h,032h,0C7h,006h,02Ch,000h,06Eh,031h,0C7h,006h,02Eh,000h,002h,032h
	db 0C7h,006h,026h,000h,005h,031h,083h,07Eh,004h,020h,073h,005h,0B8h,020h
	db 000h,0EBh,006h,08Bh,046h,004h,025h,0FCh,0FFh,0A3h,032h,000h,0E8h,0AFh
	db 0CEh,0A3h,030h,000h,01Fh,033h,0C0h,05Fh,08Bh,0E5h,05Dh,0C2h,008h,000h
	db 055h,08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h,055h,08Bh,0ECh,04Ch,04Ch,0A0h
	db 004h,000h,0B4h,000h,089h,046h,0FEh,01Eh,02Eh,08Eh,01Eh,096h,046h,083h
	db 03Eh,0BEh,006h,000h,075h,030h,0FFh,006h,0BEh,006h,01Fh,01Eh,0B8h,002h
	db 000h,033h,0D2h,050h,052h,0E8h,027h,000h,00Bh,0C0h,074h,01Ch,02Eh,08Eh
	db 01Eh,096h,046h,0FFh,076h,0FEh,0E8h,077h,004h,08Bh,05Eh,0FEh,0D1h,0E3h
	db 0C7h,087h,0CAh,006h,000h,000h,01Fh,0B8h,003h,010h,0EBh,003h,01Fh,033h
	db 0C0h,08Bh,0E5h,05Dh,0C3h,055h,08Bh,0ECh,083h,0ECh,004h,0E8h,0A6h,0FFh
	db 0C7h,046h,0FEh,000h,040h,0FFh,036h,030h,000h,033h,0C0h,033h,0D2h,050h
	db 052h,0B8h,002h,000h,050h,0E8h,0C1h,011h,083h,0FAh,0FFh,075h,044h,03Dh
	db 0FFh,0FFh,074h,058h,0EBh,03Dh,083h,07Eh,006h,000h,072h,010h,077h,007h
	db 081h,07Eh,004h,000h,080h,076h,007h,0C7h,046h,0FCh,000h,080h,0EBh,006h
	db 08Bh,046h,004h,089h,046h,0FCh,0FFh,036h,030h,000h,033h,0C0h,0FFh,076h
	db 0FEh,050h,0FFh,076h,0FCh,0E8h,06Fh,011h,03Bh,046h,0FCh,074h,002h,0EBh
	db 02Ch,08Bh,046h,0FCh,029h,046h,004h,083h,05Eh,006h,000h,08Bh,046h,004h
	db 00Bh,046h,006h,075h,0BBh,0FFh,036h,030h,000h,0E8h,0A3h,011h,00Bh,0C0h
	db 076h,008h,050h,0E8h,08Dh,011h,0EBh,004h,0EBh,007h,0EBh,005h,033h,0C0h
	db 0EBh,004h,01Fh,0B8h,003h,010h,08Bh,0E5h,05Dh,0C2h,004h,000h,055h,08Bh
	db 0ECh,0E8h,016h,0FFh,08Bh,05Eh,006h,083h,07Fh,008h,000h,075h,003h,0EBh
	db 064h,090h,0FFh,036h,030h,000h,08Bh,01Fh,033h,0C9h,0A1h,008h,000h,033h
	db 0D2h,09Ah,0A9h,003h
		dw	seg BCC_COPY_WORDS
	db 052h,050h,033h,0C0h,050h,0E8h,021h,011h
	db 08Bh,046h,004h,0FFh,036h,030h,000h,050h,08Bh,05Eh,006h,08Bh,04Fh,008h
	db 083h,0F9h,0F0h,076h,01Ah,0BAh,0F0h,0FFh,052h,02Bh,0CAh,051h,0FFh,036h
	db 030h,000h,050h,033h,0C9h,051h,052h,0E8h,0C7h,010h,073h,009h,083h,0C4h
	db 008h,0EBh,009h,033h,0C0h,050h,051h,0E8h,0B9h,010h,073h,013h,01Eh,0B8h
	db 001h,000h,050h,0B8h,000h,0E0h,050h,02Eh,08Eh,01Eh,096h,046h,0FFh,01Eh
	db 0A8h,05Eh,01Fh,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,0E8h,09Dh,0FEh,08Bh
	db 05Eh,006h,083h,07Fh,008h,000h,075h,003h,0EBh,064h,090h,0FFh,036h,030h
	db 000h,08Bh,01Fh,033h,0C9h,0A1h,008h,000h,033h,0D2h,09Ah,0A9h,003h
		dw	seg BCC_COPY_WORDS
	db 052h,050h,033h,0C0h,050h,0E8h,0A8h,010h,08Bh,046h,004h,0FFh,036h
	db 030h,000h,050h,08Bh,05Eh,006h,08Bh,04Fh,008h,083h,0F9h,0F0h,076h,01Ah
	db 0BAh,0F0h,0FFh,052h,02Bh,0CAh,051h,0FFh,036h,030h,000h,050h,033h,0C9h
	db 051h,052h,0E8h,068h,010h,073h,009h,083h,0C4h,008h,0EBh,009h,033h,0C0h
	db 050h,051h,0E8h,05Ah,010h,073h,013h,01Eh,0B8h,001h,000h,050h,0B8h,001h
	db 0E0h,050h,02Eh,08Eh,01Eh,096h,046h,0FFh,01Eh,0A8h,05Eh,01Fh,05Dh,0C2h
	db 004h,000h,055h,08Bh,0ECh,04Ch,04Ch,0E8h,022h,0FEh,08Eh,006h,00Ah,000h
	db 026h,08Eh,006h,0CAh,006h,026h,0A1h,000h,000h,089h,046h,0FEh,0FFh,076h
	db 006h,0FFh,076h,0FEh,0E8h,0EDh,0FEh,08Bh,05Eh,006h,08Bh,046h,004h,089h
	db 007h,0FFh,076h,006h,0FFh,076h,0FEh,0E8h,055h,0FFh,08Bh,0E5h,05Dh,0C2h
	db 004h,000h,055h,08Bh,0ECh,083h,0ECh,00Ah,0C7h,046h,0FAh,000h,000h,0C7h
	db 046h,0F8h,000h,000h,0A0h,004h,000h,0B4h,000h,089h,046h,0F6h,0E8h,0D7h
	db 0FDh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0C0h,026h,080h,03Eh,0FBh,006h,000h,074h,026h
	db 0B8h,001h,000h,033h,0D2h,050h,052h,0E8h,011h,0FEh,00Bh,0C0h,075h,018h
	db 0B8h,080h,000h,050h,0E8h,0ACh,0E1h,089h,046h,0FEh,08Bh,05Eh,0FEh,08Bh
	db 047h,002h,03Bh,046h,004h,072h,003h,0E9h,046h,001h,0B8h
		dw	seg BCC_SEG_180
	db 08Eh
	db 0C0h,026h,080h,03Eh,0FCh,006h,000h,075h,005h,033h,0C0h,0E9h,037h,001h
	db 08Bh,01Eh,012h,000h,08Bh,047h,010h,089h,046h,0FEh,03Bh,006h,012h,000h
	db 075h,005h,033h,0C0h,0E9h,022h,001h,08Bh,05Eh,0FEh,08Bh,047h,010h,03Bh
	db 006h,012h,000h,075h,010h,08Bh,047h,002h,03Bh,046h,004h,072h,003h,0E9h
	db 008h,001h,033h,0C0h,0E9h,006h,001h,02Eh,08Eh,01Eh,096h,046h,08Eh,01Eh
	db 0CAh,006h,0A1h,03Ah,000h,089h,046h,0FEh,0A1h,000h,000h,089h,046h,0FCh
	db 08Bh,05Eh,0FEh,08Bh,007h,02Bh,006h,000h,000h,03Dh,000h,010h,073h,050h
	db 08Bh,047h,002h,005h,000h,010h,03Bh,006h,002h,000h,076h,013h,02Eh,08Eh
	db 01Eh,096h,046h,08Bh,05Eh,0F6h,0D1h,0E3h,08Eh,09Fh,0CAh,006h,033h,0C0h
	db 0E9h,0C4h,000h,0A1h,000h,000h,003h,006h,002h,000h,08Bh,05Eh,0FEh,02Bh
	db 047h,002h,08Eh,0C0h,08Ch,0C0h,08Ch,0DAh,02Bh,0C2h,089h,046h,0F8h,08Bh
	db 047h,008h,089h,046h,0FAh,08Bh,0C8h,08Bh,0D9h,04Bh,04Bh,0D1h,0E9h,08Bh
	db 007h,026h,087h,007h,089h,007h,04Bh,04Bh,0E2h,0F5h,02Eh,08Eh,01Eh,096h
	db 046h,08Bh,05Eh,0F6h,0D1h,0E3h,08Bh,046h,0F8h,001h,087h,0CAh,006h,001h
	db 006h,0CAh,006h,02Eh,08Eh,01Eh,096h,046h,08Bh,05Eh,0F6h,0D1h,0E3h,08Eh
	db 09Fh,0CAh,006h,0FFh,036h,032h,000h,0FFh,076h,0FCh,0E8h,01Eh,0FEh,0B8h
	db 0FFh,0FFh,050h,0FFh,036h,014h,000h,0FFh,036h,016h,000h,0E8h,0A5h,0D7h
	db 089h,046h,0FEh,0FFh,036h,032h,000h,0FFh,076h,0FCh,0E8h,089h,0FDh,08Bh
	db 04Eh,0FAh,0E3h,042h,02Eh,08Eh,01Eh,096h,046h,08Eh,01Eh,0CAh,006h,08Ch
	db 0D8h,02Bh,046h,0F8h,08Eh,0C0h,033h,0DBh,0D1h,0E9h,08Bh,007h,026h,087h
	db 007h,089h,007h,043h,043h,0E2h,0F5h,02Eh,08Eh,01Eh,096h,046h,08Bh,05Eh
	db 0F6h,0D1h,0E3h,08Bh,046h,0F8h,029h,087h,0CAh,006h,029h,006h,0CAh,006h
	db 02Eh,08Eh,01Eh,096h,046h,08Bh,05Eh,0F6h,0D1h,0E3h,08Eh,09Fh,0CAh,006h
	db 08Bh,046h,0FEh,08Bh,0E5h,05Dh,0C2h,002h,000h,055h,08Bh,0ECh,083h,0ECh
	db 004h,083h,07Eh,00Ah,002h,077h,00Bh,072h,006h,083h,07Eh,008h,000h,073h
	db 003h,0E9h,0BBh,000h,08Bh,046h,004h,08Bh,056h,006h,052h,050h,033h,0C0h
	db 050h,0E8h,016h,00Eh,089h,046h,0FCh,083h,07Eh,0FCh,0FFh,075h,006h,0B8h
	db 002h,010h,0E9h,0A0h,000h,01Eh,08Bh,046h,00Ch,0BAh,005h,000h,0F7h,0EAh
	db 08Bh,016h,0CAh,006h,003h,0D0h,08Bh,05Eh,00Ch,0D1h,0E3h,089h,097h,0CAh
	db 006h,08Bh,05Eh,00Ch,0D1h,0E3h,08Eh,09Fh,0CAh,006h,08Bh,046h,0FCh,0A3h
	db 030h,000h,08Bh,046h,006h,08Bh,056h,004h,0A3h,036h,000h,089h,016h,034h
	db 000h,01Fh,01Eh,033h,0C0h,050h,08Bh,056h,00Ah,08Bh,046h,008h,0B1h,009h
	db 09Ah,0E3h,003h
		dw	seg BCC_COPY_WORDS
	db 050h,0FFh,076h,00Ch,0B8h,0FFh,001h,050h,0B8h
	db 000h,002h,050h,0E8h,048h,0E0h,0B8h,0FFh,0FFh,050h,0E8h,0B8h,0D8h,089h
	db 046h,0FEh,0A3h,032h,000h,08Bh,05Eh,0FEh,081h,04Fh,00Ah,008h,080h,0C7h
	db 047h,010h,000h,000h,0C7h,047h,00Eh,000h,000h,08Bh,047h,006h,0A3h,00Ch
	db 000h,0A3h,014h,000h,0A0h,005h,000h,00Ch,080h,0A2h,005h,000h,0C7h,006h
	db 028h,000h,074h,035h,0C7h,006h,02Ah,000h,0FBh,034h,0C7h,006h,02Ch,000h
	db 0EDh,035h,0C7h,006h,026h,000h,025h,036h,01Fh,033h,0C0h,08Bh,0E5h,05Dh
	db 0C2h,00Ah,000h,055h,08Bh,0ECh,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,0E8h,090h
	db 0C8h,00Bh,0C0h,075h,013h,0B8h,002h,000h,050h,033h,0D2h,050h,052h,0FFh
	db 076h,008h,0FFh,076h,006h,0E8h,005h,0FFh,0EBh,003h,0B8h,000h,010h,01Fh
	db 05Dh,0CAh,004h,000h ; CODE_2:38C3
CODE_2 ends
; END RG2BTAIL
; BEGIN RH38C7 (complete raw function CODE_2:38C7..38FB)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,083h,0ECh,004h,01Eh,08Bh,05Eh,004h ; CODE_2:38C7
	db 0D1h,0E3h,08Eh,09Fh,0CAh,006h,0A1h,036h,000h,08Bh,016h,034h,000h,089h
	db 046h,0FEh,089h,056h,0FCh,0FFh,036h,030h,000h,0E8h,089h,00Dh,01Fh,0FFh
	db 076h,0FEh,0FFh,076h,0FCh,0E8h,06Fh,00Dh,08Bh,0E5h,05Dh,0C2h,002h,000h
CODE_2 ends
; END RH38C7
; BEGIN RH38FB (derived raw tail CODE_2:38FB..3903)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h
CODE_2 ends
; END RH38FB
; BEGIN RNOOPS (derived raw functions CODE_2:3903..3911)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,05Dh,0C2h,004h
	db 000h,055h,08Bh,0ECh,05Dh,0C2h,002h,000h
CODE_2 ends
; END RNOOPS
; BEGIN RG2BEND (derived native CODE_2:3911..3CDD)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2

	db 055h,08Bh,0ECh,01Eh,033h,0C0h
	db 050h,050h,0B8h,005h,000h,050h,033h,0C0h,050h,050h,0E8h,06Fh,0DFh,0C7h
	db 006h,022h,000h,0BDh,019h,0C7h,006h,024h,000h,0ECh,019h,0C7h,006h,028h
	db 000h,003h,039h,0C7h,006h,02Ah,000h,003h,039h,0C7h,006h,02Ch,000h,003h
	db 039h,0C7h,006h,026h,000h,00Ah,039h,01Fh,033h,0C0h,05Dh,0C3h,055h,08Bh
	db 0ECh,0E8h,0FAh,0FFh,05Dh,0C3h,055h,08Bh,0ECh,04Ch,04Ch,056h,057h,0C6h
	db 046h,0FFh,000h,050h,058h,08Bh,07Eh,006h,08Bh,016h,032h,000h,0B4h,047h
	db 0CDh,067h,0D0h,0E4h,072h,078h,08Bh,005h,0F7h,026h,008h,000h,003h,006h
	db 038h,000h,013h,016h,03Ah,000h,0BBh,000h,040h,0F7h,0F3h,08Bh,0D8h,08Bh
	db 0F2h,0D1h,0EEh,08Bh,055h,008h,083h,0C2h,001h,0D1h,0DAh,033h,0FFh,0B9h
	db 000h,020h,02Bh,0CEh,03Bh,0CAh,072h,002h,08Bh,0CAh,02Bh,0D1h,052h,08Bh
	db 016h,032h,000h,0B8h,000h,044h,0CDh,067h,05Ah,0D0h,0E4h,072h,02Dh,0D1h
	db 0E6h,01Eh,053h,08Bh,046h,004h,08Bh,01Eh,034h,000h,080h,07Eh,0FFh,000h
	db 074h,003h,093h,087h,0F7h,08Eh,0C0h,08Eh,0DBh,05Bh,0FCh,0F3h,0A5h,01Fh
	db 043h,080h,07Eh,0FFh,000h,074h,002h,087h,0F7h,033h,0F6h,00Bh,0D2h,075h
	db 0B8h,0F8h,09Ch,08Bh,016h,032h,000h,0B4h,048h,0CDh,067h,09Dh,073h,013h
	db 01Eh,0B8h,001h,000h,050h,0B8h,010h,0E0h,050h,02Eh,08Eh,01Eh,096h,046h
	db 0FFh,01Eh,0A8h,05Eh,01Fh,05Fh,05Eh,08Bh,0E5h,05Dh,0C2h,004h,000h,055h
	db 08Bh,0ECh,04Ch,04Ch,056h,057h,0C6h,046h,0FFh,001h,0BEh,002h,000h,0BFh
	db 002h,000h,0E8h,049h,0FFh,05Fh,05Eh,08Bh,0E5h,05Dh,0C2h,004h,000h,055h
	db 08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,05Eh,006h,08Bh,047h,008h,089h,046h
	db 0FEh,08Bh,046h,004h,0F7h,026h,008h,000h,003h,006h,038h,000h,013h,016h
	db 03Ah,000h,0BBh,000h,040h,0F7h,0F3h,050h,0D1h,0EAh,052h,08Bh,076h,006h
	db 08Bh,004h,0F7h,026h,008h,000h,003h,006h,038h,000h,013h,016h,03Ah,000h
	db 0BBh,000h,040h,0F7h,0F3h,08Bh,0D8h,052h,08Bh,0FAh,0D1h,0EFh,08Bh,056h
	db 0FEh,083h,0C2h,001h,0D1h,0DAh,0B8h,001h,044h,033h,0F6h,050h,052h,08Bh
	db 016h,032h,000h,0CDh,067h,05Ah,0D0h,0E4h,072h,07Eh,0B9h,000h,020h,02Bh
	db 0CFh,03Bh,0CAh,072h,002h,08Bh,0CAh,003h,0F1h,043h,033h,0FFh,02Bh,0D1h
	db 058h,074h,006h,0FEh,0C0h,03Ch,004h,072h,0D8h,0D1h,0E2h,089h,056h,0FEh
	db 08Bh,0D6h,0D1h,0E6h,08Bh,0C6h,08Bh,076h,006h,052h,033h,0D2h,0F7h,036h
	db 008h,000h,001h,004h,05Ah,05Eh,05Fh,05Bh,0B9h,000h,020h,02Bh,0CFh,03Bh
	db 0CAh,072h,002h,08Bh,0CAh,02Bh,0D1h,052h,08Bh,016h,032h,000h,0B8h,000h
	db 044h,0CDh,067h,05Ah,0D0h,0E4h,072h,02Ch,0D1h,0E7h,01Eh,0A1h,034h,000h
	db 08Eh,0C0h,003h,006h,036h,000h,08Eh,0D8h,0FCh,0F3h,0A5h,01Fh,081h,0FFh
	db 000h,040h,075h,003h,043h,033h,0FFh,00Bh,0D2h,075h,0C5h,083h,07Eh,0FEh
	db 000h,074h,01Dh,053h,0D1h,0EFh,057h,0E9h,04Bh,0FFh,083h,0C4h,008h,01Eh
	db 0B8h,001h,000h,050h,0B8h,010h,0E0h,050h,02Eh,08Eh,01Eh,096h,046h,0FFh
	db 01Eh,0A8h,05Eh,01Fh,08Bh,05Eh,006h,08Bh,046h,004h,089h,007h,05Fh,05Eh
	db 08Bh,0E5h,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,04Ch,04Ch,08Bh,01Eh,012h
	db 000h,08Bh,047h,010h,089h,046h,0FEh,03Bh,006h,012h,000h,075h,005h,033h
	db 0C0h,0EBh,05Fh,090h,08Bh,05Eh,0FEh,08Bh,047h,010h,03Bh,006h,012h,000h
	db 075h,00Fh,08Bh,047h,002h,03Bh,046h,004h,072h,003h,0EBh,045h,090h,033h
	db 0C0h,0EBh,043h,08Eh,006h,00Ah,000h,08Bh,016h,032h,000h,0B4h,047h,0CDh
	db 067h,0D0h,0E4h,072h,01Dh,0FFh,076h,004h,0FFh,036h,014h,000h,0FFh,036h
	db 016h,000h,0E8h,094h,0D3h,089h,046h,0FEh,08Bh,016h,032h,000h,0B4h,048h
	db 0CDh,067h,0D0h,0E4h,073h,013h,01Eh,0B8h,001h,000h,050h,0B8h,010h,0E0h
	db 050h,02Eh,08Eh,01Eh,096h,046h,0FFh,01Eh,0A8h,05Eh,01Fh,08Bh,046h,0FEh
	db 08Bh,0E5h,05Dh,0C2h,002h,000h,055h,08Bh,0ECh,083h,0ECh,008h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,02Eh,08Eh,01Eh,096h,046h,08Eh,01Eh,0CAh,006h,0B8h
	db 014h,000h,050h,0E8h,05Ah,0C4h,00Bh,0C0h,074h,007h,033h,0D2h,033h,0C0h
	db 0E9h,00Eh,001h,02Eh,08Eh,01Eh,096h,046h,083h,07Eh,00Ah,000h,075h,071h
	db 09Ah,091h,03Fh
		dw	seg BCC_FAR_245C
	db 00Bh,0C0h,075h,007h,033h,0D2h,033h,0C0h,0E9h
	db 0F3h,000h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,026h,000h,03Bh,046h,008h
	db 077h,007h,033h,0D2h,033h,0C0h,0E9h,0DEh,000h,083h,07Eh,006h,000h,074h
	db 011h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,026h,000h,02Bh,046h,008h,03Bh
	db 046h,006h,073h,00Fh,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,026h,000h,02Bh
	db 046h,008h,089h,046h,006h,083h,07Eh,006h,004h,073h,007h,033h,0D2h,033h
	db 0C0h,0E9h,0ABh,000h,0FFh,076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,09Ah
	db 043h,040h
		dw	seg BCC_FAR_245C
	db 00Bh,0C0h,074h,014h,033h,0D2h,033h,0C0h,0E9h,092h
	db 000h,083h,07Eh,006h,004h,073h,007h,033h,0D2h,033h,0C0h,0E9h,085h,000h
	db 0B8h,000h,040h,0F7h,066h,008h,089h,046h,0FCh,089h,056h,0FEh,0B8h,000h
	db 040h,0F7h,066h,006h,089h,046h,0F8h,089h,056h,0FAh,08Bh,0CAh,0BBh,001h
	db 000h,0EBh,002h,0D1h,0CBh,0D1h,0E1h,073h,0FAh,0F7h,0F3h,033h,0C9h,051h
	db 050h,0B8h,003h,000h,050h,04Bh,053h,043h,053h,0E8h,00Ch,0DCh,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,022h,000h,0A3h,032h,000h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh
	db 0C0h,026h,0A1h,020h,000h,0A3h,034h,000h,08Bh,046h,0FEh,08Bh,056h,0FCh
	db 0A3h,03Ah,000h,089h,016h,038h,000h,0C7h,006h,030h,000h,0FFh,0FFh,0C7h
	db 006h,036h,000h,000h,004h,0C7h,006h,028h,000h,004h,03Ah,0C7h,006h,02Ah
	db 000h,055h,039h,0C7h,006h,02Ch,000h,020h,03Ah,0C7h,006h,026h,000h,023h
	db 03Bh,08Bh,056h,0FAh,08Bh,046h,0F8h,01Fh,08Bh,0E5h,05Dh,0CAh,006h,000h
CODE_2 ends
; END RG2BEND
; BEGIN RH3CDD (derived native CODE_2:3CDD..3CE7)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,09Ah,0A8h,040h
		dw	seg BCC_FAR_245C
	db 05Dh,0C3h
CODE_2 ends
; END RH3CDD
; BEGIN RH3CE7 (derived native CODE_2:3CE7..3CEF)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,0E8h
	db 0FAh,0FFh,05Dh,0C3h
CODE_2 ends
; END RH3CE7
; BEGIN RG2BMID (derived native CODE_2:3CEF..3F7E)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,056h,057h,056h,057h,08Bh,046h,004h
	db 0BAh,010h,000h,0F7h,0E2h,08Bh,0CAh,08Bh,0D8h,08Bh,07Eh,006h,08Bh,005h
	db 0F7h,026h,008h,000h,003h,006h,030h,000h,013h,016h,032h,000h,08Bh,075h
	db 008h,033h,0FFh,0E8h,093h,006h,073h,010h,01Eh,06Ah,001h,068h,020h,0E0h
	db 02Eh,08Eh,01Eh,096h,046h,0FFh,01Eh,0A8h,05Eh,01Fh,05Fh,05Eh,05Fh,05Eh
	db 05Dh,0C2h,004h,000h,055h,08Bh,0ECh,056h,057h,056h,057h,08Bh,046h,004h
	db 0BAh,010h,000h,0F7h,0E2h,08Bh,07Eh,006h,052h,050h,08Bh,005h,0F7h,026h
	db 008h,000h,003h,006h,030h,000h,013h,016h,032h,000h,08Bh,0D8h,08Bh,0CAh
	db 058h,05Ah,08Bh,075h,008h,033h,0FFh,0E8h,049h,006h,073h,010h,01Eh,06Ah
	db 001h,068h,020h,0E0h,02Eh,08Eh,01Eh,096h,046h,0FFh,01Eh,0A8h,05Eh,01Fh
	db 05Fh,05Eh,05Fh,05Eh,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,056h,057h,056h
	db 057h,08Bh,046h,004h,0F7h,026h,008h,000h,003h,006h,030h,000h,013h,016h
	db 032h,000h,08Bh,0D8h,08Bh,0CAh,08Bh,07Eh,006h,08Bh,005h,0F7h,026h,008h
	db 000h,003h,006h,030h,000h,013h,016h,032h,000h,08Bh,075h,008h,033h,0FFh
	db 0E8h,0FCh,005h,073h,010h,01Eh,06Ah,001h,068h,020h,0E0h,02Eh,08Eh,01Eh
	db 096h,046h,0FFh,01Eh,0A8h,05Eh,01Fh,05Fh,05Eh,08Bh,05Eh,006h,08Bh,046h
	db 004h,089h,007h,05Fh,05Eh,05Dh,0C2h,004h,000h,055h,08Bh,0ECh,04Ch,04Ch
	db 08Bh,01Eh,012h,000h,08Bh,047h,010h,089h,046h,0FEh,03Bh,006h,012h,000h
	db 075h,004h,033h,0C0h,0EBh,02Bh,08Bh,05Eh,0FEh,08Bh,047h,010h,03Bh,006h
	db 012h,000h,075h,011h,08Bh,047h,002h,03Bh,046h,004h,072h,005h,08Bh,046h
	db 0FEh,0EBh,012h,033h,0C0h,0EBh,00Eh,0FFh,076h,004h,0FFh,036h,014h,000h
	db 0FFh,036h,016h,000h,0E8h,0F2h,0D0h,08Bh,0E5h,05Dh,0C2h,002h,000h,055h
	db 08Bh,0ECh,04Ch,04Ch,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,0C6h,046h,0FFh,000h
	db 02Eh,08Eh,01Eh,096h,046h,08Eh,01Eh,0CAh,006h,0B8h,014h,000h,050h,0E8h
	db 0DAh,0C1h,00Bh,0C0h,074h,007h,033h,0D2h,033h,0C0h,0E9h,02Fh,001h,02Eh
	db 08Eh,01Eh,096h,046h,09Ah,0D2h,040h
		dw	seg BCC_FAR_245C
	db 00Bh,0C2h,075h,007h,033h
	db 0D2h,033h,0C0h,0E9h,01Ah,001h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,02Ch
	db 000h,026h,08Bh,016h,02Ah,000h,03Bh,046h,00Ch,072h,01Bh,077h,005h,03Bh
	db 056h,00Ah,076h,014h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,02Ch,000h,026h
	db 08Bh,016h,02Ah,000h,089h,046h,00Ch,089h,056h,00Ah,0B8h
		dw	seg BCC_SEG_46
	db 08Eh
	db 0C0h,026h,0A1h,030h,000h,026h,08Bh,016h,02Eh,000h,03Bh,046h,00Ch,077h
	db 00Eh,075h,005h,03Bh,056h,00Ah,077h,007h,033h,0D2h,033h,0C0h,0E9h,0CBh
	db 000h,08Bh,046h,006h,00Bh,046h,008h,074h,020h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h
	db 026h,0A1h,030h,000h,026h,08Bh,016h,02Eh,000h,02Bh,056h,00Ah,01Bh,046h
	db 00Ch,03Bh,046h,008h,077h,021h,072h,005h,03Bh,056h,006h,073h,01Ah,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,026h,0A1h,030h,000h,026h,08Bh,016h,02Eh,000h,02Bh
	db 056h,00Ah,01Bh,046h,00Ch,089h,046h,008h,089h,056h,006h,083h,07Eh,008h
	db 001h,077h,00Fh,072h,006h,083h,07Eh,006h,000h,073h,007h,033h,0D2h,033h
	db 0C0h,0EBh,075h,090h,080h,07Eh,0FFh,000h,075h,022h,0FFh,076h,00Ch,0FFh
	db 076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,09Ah,082h,042h
		dw	seg BCC_FAR_245C
	db 00Bh
	db 0C0h,074h,007h,033h,0D2h,033h,0C0h,0EBh,053h,090h,0FEh,046h,0FFh,0E9h
	db 032h,0FFh,08Bh,046h,006h,08Bh,056h,008h,08Bh,0CAh,0BBh,001h,000h,0EBh
	db 002h,0D1h,0CBh,0D1h,0E1h,073h,0FAh,0F7h,0F3h,06Ah,000h,050h,06Ah,004h
	db 04Bh,053h,043h,053h,0E8h,047h,0D9h,08Bh,046h,00Ch,08Bh,056h,00Ah,0A3h
	db 032h,000h,089h,016h,030h,000h,0C7h,006h,028h,000h,035h,03Dh,0C7h,006h
	db 02Ah,000h,0EFh,03Ch,0C7h,006h,02Ch,000h,07Fh,03Dh,0C7h,006h,026h,000h
	db 0D4h,03Dh,08Bh,056h,008h,08Bh,046h,006h,01Fh,08Bh,0E5h,05Dh,0CAh,008h
	db 000h
CODE_2 ends
; END RG2BMID
; BEGIN RH3F7E (derived native CODE_2:3F7E..3F88)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,09Ah,05Ah,043h
		dw	seg BCC_FAR_245C
	db 05Dh,0C3h
CODE_2 ends
; END RH3F7E
; BEGIN RG2BREST (complete source CODE_2:3F88..45D6)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 045h,04Dh,04Dh
	db 058h,058h,058h,058h,030h,000h,055h,08Bh,0ECh,081h,0ECh,002h,001h,01Eh
	db 02Eh,08Eh,01Eh,094h,046h,056h,057h,0F6h,006h,028h,000h,001h,074h,010h
	db 0F6h,006h,028h,000h,002h,075h,003h,0EBh,06Fh,090h,0A1h,026h,000h,0E9h
	db 085h,000h,01Eh,00Eh,01Fh,0BAh,088h,03Fh,0B8h,000h,03Dh,0CDh,021h,01Fh
	db 08Bh,0D8h,072h,022h,0B8h,000h,044h,0CDh,021h,072h,017h,0F7h,0C2h,080h
	db 000h,074h,011h,0B8h,007h,044h,0CDh,021h,072h,00Ah,050h,0B4h,03Eh,0CDh
	db 021h,058h,03Ch,0FFh,074h,007h,0B4h,03Eh,0CDh,021h,0EBh,04Ah,090h,0B8h
	db 067h,035h,0CDh,021h,08Ch,0C0h,00Bh,0C3h,074h,0F2h,0B4h,040h,0CDh,067h
	db 00Ah,0E4h,075h,0EAh,0C6h,006h,028h,000h,001h,0B4h,046h,0CDh,067h,00Ah
	db 0E4h,075h,0DDh,03Ch,032h,072h,0D9h,0A2h,029h,000h,0B4h,041h,0CDh,067h
	db 00Ah,0E4h,075h,0CEh,089h,01Eh,020h,000h,0B4h,042h,0CDh,067h,00Ah,0E4h
	db 075h,00Eh,089h,01Eh,026h,000h,0C7h,006h,022h,000h,0FFh,0FFh,08Bh,0C3h
	db 0EBh,007h,033h,0C0h,0C6h,006h,028h,000h,000h,05Fh,05Eh,01Fh,08Bh,0E5h
	db 05Dh,0CBh,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h,0F6h,006h,028h
	db 000h,001h,075h,003h,0EBh,04Bh,090h,0F6h,006h,028h,000h,002h,074h,005h
	db 033h,0C0h,0EBh,042h,090h,080h,00Eh,028h,000h,002h,08Bh,046h,008h,0A3h
	db 024h,000h,08Bh,05Eh,006h,089h,01Eh,026h,000h,08Bh,056h,00Ah,00Bh,0D2h
	db 075h,00Dh,0B4h,043h,0CDh,067h,00Ah,0E4h,075h,01Dh,080h,00Eh,028h,000h
	db 004h,089h,016h,022h,000h,0B4h,047h,0CDh,067h,00Ah,0E4h,075h,00Ch,08Bh
	db 016h,022h,000h,0B4h,048h,0CDh,067h,08Ah,0C4h,0EBh,003h,0B8h,0FFh,0FFh
	db 01Fh,05Dh,0CAh,006h,000h,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h
	db 0F6h,006h,028h,000h,004h,074h,017h,08Bh,016h,022h,000h,00Bh,0D2h,078h
	db 00Fh,0B4h,045h,0CDh,067h,0C7h,006h,022h,000h,0FFh,0FFh,0C6h,006h,028h
	db 000h,000h,01Fh,05Dh,0CBh,055h,08Bh,0ECh,083h,0ECh,022h,01Eh,02Eh,08Eh
	db 01Eh,094h,046h,056h,057h,0F6h,006h,032h,000h,001h,074h,00Ah,0F6h,006h
	db 032h,000h,002h,074h,008h,0E9h,076h,001h,0C6h,006h,032h,000h,001h,0C7h
	db 006h,02Ah,000h,000h,000h,0C7h,006h,02Ch,000h,010h,000h,0C7h,006h,02Eh
	db 000h,000h,000h,0C7h,006h,030h,000h,010h,000h,054h,058h,03Bh,0C4h,075h
	db 008h,0B4h,030h,0CDh,021h,03Ch,00Ah,072h,003h,0E9h,059h,001h,086h,0C4h
	db 089h,046h,0DEh,0B8h,000h,0F0h,08Eh,0C0h,026h,0A0h,0FEh,0FFh,03Ch,0FCh
	db 077h,0EBh,03Ch,0FBh,074h,0E7h,03Ch,0F9h,074h,0E3h,083h,07Eh,0DEh,031h
	db 073h,003h,0E9h,07Fh,000h,0B8h,000h,043h,0CDh,02Fh,03Ch,080h,075h,0F4h
	db 0B8h,010h,043h,0CDh,02Fh,089h,01Eh,033h,000h,08Ch,006h,035h,000h,033h
	db 0C0h,0FFh,01Eh,033h,000h,080h,0FCh,002h,072h,05Eh,0B4h,008h,0FFh,01Eh
	db 033h,000h,00Bh,0C0h,074h,051h,08Bh,0F0h,092h,0B4h,009h,0FFh,01Eh,033h
	db 000h,00Bh,0C0h,074h,044h,089h,016h,037h,000h,0B4h,00Ch,0FFh,01Eh,033h
	db 000h,00Bh,0C0h,074h,01Ch,089h,01Eh,02Ah,000h,089h,016h,02Ch,000h,0B8h
	db 000h,004h,0F7h,0E6h,003h,006h,02Ah,000h,013h,016h,02Ch,000h,0A3h,02Eh
	db 000h,089h,016h,030h,000h,0B4h,00Dh,08Bh,016h,037h,000h,0FFh,01Eh,033h
	db 000h,0B4h,00Ah,08Bh,016h,037h,000h,0FFh,01Eh,033h,000h,0C7h,006h,037h
	db 000h,000h,000h,0E9h,0A6h,000h,0B4h,088h,0CDh,015h,00Bh,0C0h,075h,003h
	db 0E9h,0ACh,000h,0BAh,000h,004h,0F7h,0E2h,080h,0C2h,010h,0A3h,02Eh,000h
	db 089h,016h,030h,000h,08Bh,00Eh,033h,000h,00Bh,00Eh,035h,000h,0E3h,00Bh
	db 0C6h,006h,02Ch,000h,011h,0C7h,006h,02Ah,000h,000h,000h,08Ch,0D0h,0BAh
	db 010h,000h,0F7h,0E2h,08Dh,05Eh,0E0h,033h,0C9h,003h,0D8h,013h,0CAh,0B8h
	db 000h,000h,0BAh,010h,000h,0BEh,020h,000h,033h,0FFh,0E8h,0A0h,001h,072h
	db 0B9h,08Dh,07Eh,0E3h,016h,007h,08Dh,036h,000h,000h,0B9h,005h,000h,0FCh
	db 0F3h,0A6h,075h,010h,08Bh,046h,0EBh,0F7h,066h,0F3h,080h,0C2h,010h,0A3h
	db 02Ah,000h,088h,016h,02Ch,000h,033h,0C0h,08Eh,0C0h,026h,08Eh,006h,066h
	db 000h,0BFh,012h,000h,08Dh,036h,000h,000h,0B9h,005h,000h,0FCh,0F3h,0A6h
	db 075h,01Eh,026h,0A1h,02Ch,000h,026h,08Ah,016h,02Eh,000h,03Ah,016h,02Ch
	db 000h,072h,00Fh,077h,006h,03Bh,006h,02Ah,000h,076h,007h,0A3h,02Ah,000h
	db 088h,016h,02Ch,000h,0A1h,02Eh,000h,08Bh,016h,030h,000h,02Bh,006h,02Ah
	db 000h,01Bh,016h,02Ch,000h,0EBh,003h,033h,0C0h,099h,05Fh,05Eh,01Fh,08Bh
	db 0E5h,05Dh,0CBh,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h,056h,057h
	db 0F6h,006h,032h,000h,001h,075h,003h,0E9h,0B9h,000h,0F6h,006h,032h,000h
	db 002h,074h,005h,033h,0C0h,0E9h,0B0h,000h,080h,00Eh,032h,000h,002h,08Bh
	db 046h,00Ah,08Bh,056h,00Ch,08Bh,076h,006h,08Bh,07Eh,008h,08Bh,01Eh,033h
	db 000h,00Bh,01Eh,035h,000h,074h,043h,08Bh,0C6h,08Bh,0D7h,005h,0FFh,003h
	db 083h,0D2h,000h,0BBh,000h,004h,0F7h,0F3h,092h,0B4h,009h,0FFh,01Eh,033h
	db 000h,00Bh,0C0h,074h,026h,089h,016h,037h,000h,0B4h,00Ch,0FFh,01Eh,033h
	db 000h,00Bh,0C0h,074h,018h,089h,01Eh,02Ah,000h,089h,016h,02Ch,000h,089h
	db 01Eh,039h,000h,089h,016h,03Bh,000h,08Bh,0C3h,003h,0C6h,013h,0D7h,0EBh
	db 047h,0EBh,050h,090h,0A3h,02Ah,000h,089h,016h,02Ch,000h,033h,0DBh,08Eh
	db 0C3h,01Eh,0BBh
		dw	seg BCC_SEG_180 - 2BBh
	db 08Eh,0DBh,026h,08Bh,01Eh,064h,000h,089h,01Eh
	db 02Fh,000h,026h,08Bh,01Eh,066h,000h,089h,01Eh,031h,000h,026h,0C7h,006h
	db 064h,000h,03Fh,000h,026h,0C7h,006h,066h,000h
		dw	seg BCC_SEG_180 - 2BBh
	db 0A3h,03Ah,000h
	db 088h,016h,03Ch,000h,003h,0C6h,013h,0D7h,0A3h,02Ch,000h,088h,016h,02Eh
	db 000h,01Fh,0A3h,02Eh,000h,089h,016h,030h,000h,033h,0C0h,0EBh,003h,0B8h
	db 0FFh,0FFh,05Fh,05Eh,01Fh,05Dh,0CAh,008h,000h,055h,08Bh,0ECh,01Eh,02Eh
	db 08Eh,01Eh,094h,046h,080h,03Eh,032h,000h,000h,074h,041h,083h,03Eh,037h
	db 000h,000h,074h,016h,0B4h,00Dh,08Bh,016h,037h,000h,0FFh,01Eh,033h,000h
	db 0B4h,00Ah,08Bh,016h,037h,000h,0FFh,01Eh,033h,000h,0EBh,024h,033h,0C0h
	db 08Eh,0C0h,026h,0A1h,066h,000h,03Dh
		dw	seg BCC_SEG_180 - 2BBh
	db 075h,017h,01Eh,08Eh,0D8h
	db 0A1h,02Fh,000h,026h,0A3h,064h,000h,0A1h,031h,000h,026h,0A3h,066h,000h
	db 01Fh,0C6h,006h,032h,000h,000h,01Fh,05Dh,0CBh,01Eh,006h,083h,0C6h,001h
	db 083h,0D7h,000h,083h,0E6h,0FEh,0FCh,02Eh,08Eh,01Eh,094h,046h,083h,03Eh
	db 037h,000h,000h,074h,06Ah,089h,036h,03Dh,000h,089h,03Eh,03Fh,000h,080h
	db 0FAh,010h,072h,013h,08Bh,036h,037h,000h,089h,036h,041h,000h,02Bh,006h
	db 039h,000h,01Bh,016h,03Bh,000h,0EBh,00Ah,090h,0C7h,006h,041h,000h,000h
	db 000h,0C1h,0CAh,004h,0A3h,043h,000h,089h,016h,045h,000h,080h,0F9h,010h
	db 072h,013h,08Bh,036h,037h,000h,089h,036h,047h,000h,02Bh,01Eh,039h,000h
	db 01Bh,00Eh,03Bh,000h,0EBh,00Ah,090h,0C7h,006h,047h,000h,000h,000h,0C1h
	db 0C9h,004h,089h,01Eh,049h,000h,089h,00Eh,04Bh,000h,0B4h,00Bh,08Dh,036h
	db 03Dh,000h,0FFh,01Eh,033h,000h,00Bh,0C0h,075h,029h,0F9h,0EBh,021h,0D1h
	db 0EFh,0D1h,0DEh,0A3h,04Fh,000h,088h,016h,051h,000h,089h,01Eh,057h,000h
	db 088h,00Eh,059h,000h,08Bh,0CEh,08Dh,036h,03Dh,000h,01Eh,007h,0B4h,087h
	db 0CDh,015h,073h,005h,01Bh,0C0h,0F9h,0EBh,002h,033h,0C0h,007h,01Fh,0C3h
	db 0CBh,0CBh,000h,000h,000h,000h,058h,08Bh,0DCh,036h,087h,047h,008h,08Bh
	db 0D8h,08Ah,05Fh,012h,032h,0FFh,0D1h,0E3h,0D1h,0E3h,02Eh,08Eh,006h,05Dh
	db 044h,026h,0FFh,01Fh,0C3h,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h
	db 02Eh,08Bh,00Eh,05Dh,044h,0E3h,07Ah,08Eh,0C1h,08Bh,046h,004h,08Bh,056h
	db 006h,08Bh,00Eh,012h,000h,0D1h,0E9h,0D1h,0E9h,033h,0DBh,026h,039h,057h
	db 002h,075h,005h,026h,039h,007h,074h,052h,083h,0C3h,004h,0E2h,0F0h,08Bh
	db 01Eh,012h,000h,03Bh,01Eh,010h,000h,072h,028h,081h,0FBh,000h,001h,072h
	db 005h,033h,0DBh,0EBh,03Dh,090h,0B8h,000h,010h,050h,050h,02Eh,0FFh,036h
	db 05Fh,044h,0B8h,05Dh,044h,050h,083h,0C3h,010h,053h,09Ah,02Ah,022h
		dw	seg BCC_FAR_245C
	db 033h,0DBh,00Bh,0C0h,075h,01Fh,02Eh,08Eh,006h,05Dh,044h,08Bh,01Eh
	db 012h,000h,08Bh,046h,004h,026h,089h,007h,08Bh,046h,006h,026h,089h,047h
	db 002h,083h,006h,012h,000h,004h,0D1h,0EBh,0D1h,0EBh,08Bh,0C3h,01Fh,05Dh
	db 0C2h,004h,000h,02Eh,08Eh,006h,096h,046h,026h,0A0h,0C0h,006h,050h,026h
	db 0C6h,006h,0C0h,006h,000h,02Eh,0FFh,036h,05Fh,044h,0B8h,05Dh,044h,050h
	db 0B8h,010h,000h,050h,09Ah,01Ch,01Bh
		dw	seg BCC_FAR_245C
	db 02Eh,08Eh,006h,096h,046h
	db 05Bh,026h,088h,01Eh,0C0h,006h,033h,0DBh,00Bh,0C0h,075h,0C6h,0C7h,006h
	db 010h,000h,010h,000h,0C7h,006h,012h,000h,004h,000h,0EBh,099h,08Bh,0DCh
	db 036h,087h,057h,008h,036h,087h,047h,006h,05Bh,007h,059h,052h,050h,051h
	db 006h,053h,0EAh,02Ah,022h
		dw	seg BCC_FAR_245C
	db 08Bh,0DCh,036h,087h,057h,006h,036h
	db 087h,047h,004h,05Bh,007h,052h,050h,033h,0C9h,051h,006h,053h,0EAh,02Ah
	db 022h
		dw	seg BCC_FAR_245C

CODE_2 ends

CODE_2	segment byte public 'CODE'
		assume	cs:CODE_2,ds:DGROUP


		public	BCC_FAR_4EB6

BCC_FAR_4EB6	proc	far
		mov	DX,1000h
		mov	AX,DX
		db	0EBh,0CAh
BCC_FAR_4EB6	endp
CODE_2	ends

CODE_2 segment byte public 'CODE'
	assume cs:CODE_2



		public	BCC_FAR_577C

	db 0BAh,020h,000h,08Bh,0C2h,0EBh,0DAh,033h,0D2h,0B8h,020h,000h,0EBh,0D3h
	db 0BAh,000h,020h,08Bh,0C2h,0EBh,0CCh,0BAh,008h,000h,08Bh,0C2h,0EBh,0C5h
	db 0BAh,010h,000h,08Bh,0C2h,0EBh,0BEh,033h,0D2h,0B8h,018h,000h,0EBh,0B7h
	db 0BAh,008h,008h,08Bh,0C2h,0EBh,099h,0BAh,010h,008h,08Bh,0C2h,0EBh,092h
	db 0BAh,008h,020h,08Bh,0C2h,0EBh,0A2h,0BAh,040h,000h,08Bh,0C2h,0EBh,09Bh
	db 0BAh,060h,000h,08Bh,0C2h,0EBh,094h,033h,0D2h,0B8h,040h,000h,0EBh,08Dh
	db 0EAh,04Fh,01Ch
		dw	seg BCC_FAR_245C
CODE_2 ends
; END RG2BREST
; BEGIN RH45D6 (derived native CODE_2:45D6..45DE)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h
CODE_2 ends
; END RH45D6
; BEGIN RH45DE (derived native CODE_2:45DE..45E6)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h
	db 08Bh,0ECh,0E8h,0FAh,0FFh,05Dh,0C3h
CODE_2 ends
; END RH45DE
; BEGIN RG2CREST (derived native CODE_2:45E6..4664)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,01Eh,0C5h,056h,006h
	db 08Ah,046h,004h,0B4h,03Dh,0CDh,021h,01Fh,073h,002h,01Bh,0C0h,05Dh,0C2h
	db 006h,000h,055h,08Bh,0ECh,01Eh,0C5h,056h,006h,0B8h,000h,03Ch,033h,0C9h
	db 0CDh,021h,01Fh,073h,002h,01Bh,0C0h,05Dh,0C2h,006h,000h,055h,08Bh,0ECh
	db 01Eh,08Bh,05Eh,00Ah,0C5h,056h,006h,08Bh,04Eh,004h,0B4h,03Fh,0CDh,021h
	db 072h,002h,03Bh,0C1h,01Fh,05Dh,0C2h,008h,000h,055h,08Bh,0ECh,01Eh,08Bh
	db 05Eh,00Ah,0C5h,056h,006h,08Bh,04Eh,004h,0B4h,040h,0CDh,021h,072h,002h
	db 03Bh,0C1h,01Fh,05Dh,0C2h,008h,000h,055h,08Bh,0ECh,08Bh,05Eh,00Ah,08Bh
	db 056h,006h,08Bh,04Eh,008h,08Ah,046h,004h,0B4h,042h,0CDh,021h,073h,003h
	db 01Bh,0C0h,099h,05Dh,0C2h,008h,000h

CODE_2 ends
; END RG2CREST
; BEGIN RH4664 (derived native CODE_2:4664..4674)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,01Eh,0C5h,056h,004h
	db 0B4h,041h,0CDh,021h,01Fh,05Dh,0C2h,004h,000h
CODE_2 ends
; END RH4664
; BEGIN RH4674 (derived native CODE_2:4674..4682)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,08Bh,05Eh
	db 004h,0B4h,03Eh,0CDh,021h,05Dh,0C2h,002h,000h
CODE_2 ends
; END RH4674
; BEGIN RG2CEND (derived native CODE_2:4682..5060)
CODE_2 segment byte public 'CODE'
	assume cs:CODE_2
	db 055h,08Bh,0ECh,08Bh,05Eh
	db 004h,0B4h,045h,0CDh,021h,073h,002h,01Bh,0C0h,05Dh,0C2h,002h,000h
		public	__OVRGROUP
		public	__OVRINIT
__OVRGROUP	label	far
		dw	seg BCC_SEG_46
		dw	seg BCC_SEG_180
	db 050h,041h,054h,048h,03Dh,000h,000h
__OVRINIT	label	far
	db 055h,08Bh,0ECh,083h
	db 0ECh,014h,01Eh,02Eh,08Eh,01Eh,094h,046h,056h,057h,083h,03Eh,032h,001h
	db 000h,074h,003h,0E9h,018h,001h,0FCh,083h,03Eh,020h,001h,000h,075h,003h
	db 0E9h,00Dh,001h,0E8h,08Eh,001h,073h,02Fh,08Bh,046h,006h,00Bh,046h,008h
	db 075h,00Ah,0C7h,046h,006h,0E0h,005h,0C7h,046h,008h
		dw	seg __SEGTABLE__
	db 0E8h,06Bh
	db 001h,073h,018h,0E8h,0B2h,001h,073h,013h,0B8h,0FEh,0FFh,0E9h,0E8h,000h
	db 0FFh,036h,038h,001h,0E8h,084h,0FFh,0B8h,0FFh,0FFh,0E9h,0DBh,000h,08Bh
	db 0D8h,089h,01Eh,038h,001h,0B9h,014h,000h,0E8h,014h,002h,0B9h,0FDh,0FFh
	db 072h,0E2h,033h,0C0h,033h,0D2h,081h,07Eh,0ECh,04Dh,05Ah,074h,005h,0B9h
	db 0FCh,0FFh,0EBh,0D2h,08Bh,046h,0F0h,08Bh,04Eh,0EEh,0E3h,001h,048h,0BAh
	db 000h,002h,0F7h,0E2h,003h,0C1h,052h,050h,0FFh,036h,038h,001h,052h,050h
	db 033h,0C0h,050h,0E8h,013h,0FFh,0B9h,010h,000h,0E8h,0DBh,001h,058h,05Ah
	db 0B9h,0FDh,0FFh,072h,0A7h,005h,010h,000h,083h,0D2h,000h,081h,07Eh,0ECh
	db 046h,042h,0B9h,0FCh,0FFh,075h,097h,081h,07Eh,0EEh,04Fh,056h,074h,008h
	db 003h,046h,0F0h,013h,056h,0F2h,0EBh,0C6h,0A3h,024h,001h,089h,016h,026h
	db 001h,02Eh,08Eh,006h,096h,046h,08Bh,046h,0F0h,026h,0A3h,0FEh,006h,08Bh
	db 046h,0F2h,026h,0A3h,000h,007h,0FFh,036h,038h,001h,0E8h,0F2h,0FEh,0C7h
	db 006h,038h,001h,000h,000h,09Ah,0DAh,047h
		dw	seg BCC_FAR_245C
	db 08Bh,046h,00Ch,0A3h
	db 034h,001h,08Bh,046h,00Ah,0A3h,036h,001h,0E8h,088h,001h,00Bh,0C0h,075h
	db 031h,0A1h,02Ah,001h,033h,0D2h,0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h
	db 0D1h,0E0h,0D1h,0D2h,0D1h,0E0h,0D1h,0D2h,052h,050h,08Bh,0FAh,08Bh,0F0h
	db 09Ah,0A0h,01Eh
		dw	seg BCC_FAR_245C
	db 03Bh,0D7h,072h,006h,077h,009h,03Bh,0C6h,073h
	db 005h,0B8h,0FFh,0FFh,0EBh,002h,033h,0C0h,05Fh,05Eh,01Fh,08Bh,0E5h,05Dh
	db 0CAh,008h,000h,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h,0A0h,021h
	db 001h,0B4h,035h,0CDh,021h,006h,053h,01Eh,0A0h,021h,001h,08Bh,016h,072h
	db 000h,08Eh,01Eh,074h,000h,0B4h,025h,0CDh,021h,01Fh,08Fh,006h,072h,000h
	db 08Fh,006h,074h,000h,083h,03Eh,038h,001h,000h,074h,00Fh,0FFh,036h,038h
	db 001h,0E8h,061h,0FEh,0C7h,006h,038h,001h,000h,000h,0EBh,011h,0B8h
		dw	seg BCC_SEG_46
	db 050h,0B8h,09Ah,000h,050h,033h,0C0h,050h,0E8h,0BDh,0FDh,0A3h,038h
	db 001h,01Fh,05Dh,0CBh,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h,083h
	db 03Eh,038h,001h,000h,074h,005h,09Ah,0DAh,047h
		dw	seg BCC_FAR_245C
	db 01Fh,05Dh,0CBh
	db 01Eh,08Dh,03Eh,09Ah,000h,01Eh,007h,0E8h,09Fh,000h,01Fh,0C3h,0B4h,030h
	db 0CDh,021h,03Ch,003h,072h,037h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Eh,01Eh
	db 014h,000h,033h,0F6h,0FCh,0ACh,00Ah,0C0h,075h,0FBh,0ACh,00Ah,0C0h,075h
	db 0F6h,0ADh,08Dh,03Eh,09Ah,000h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,08Bh,0DFh,0ACh
	db 0AAh,00Ah,0C0h,074h,008h,03Ch,05Ch,075h,0F6h,08Bh,0DFh,0EBh,0F2h,08Bh
	db 0FBh,0E8h,05Fh,000h,01Fh,0C3h,01Eh,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0D8h,08Eh,01Eh
	db 014h,000h,033h,0F6h,0BFh,098h,046h,00Eh,007h,0B9h,005h,000h,0FCh,0F3h
	db 0A6h,074h,00Dh,04Eh,0ACh,00Ah,0C0h,075h,0FBh,03Ah,004h,075h,0E9h,01Fh
	db 0F9h,0C3h,080h,03Ch,000h,074h,0F8h,08Dh,03Eh,09Ah,000h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0C0h,032h,0C0h,08Ah,0E0h,0ACh,00Ah,0C0h,074h,007h,03Ch,03Bh,074h
	db 004h,0AAh,0EBh,0F2h,04Eh,080h,0FCh,03Ah,074h,008h,080h,0FCh,05Ch,074h
	db 003h,0B0h,05Ch,0AAh,01Eh,056h,0E8h,006h,000h,05Eh,01Fh,072h,0CBh,01Fh
	db 0C3h,0C5h,076h,006h,08Ch,0D8h,00Bh,0C6h,074h,00Eh,0B9h,00Ch,000h,0ACh
	db 0AAh,00Ah,0C0h,074h,005h,0E2h,0F8h,02Ah,0C0h,0AAh,0B8h
		dw	seg BCC_SEG_46
	db 050h
	db 0B8h,09Ah,000h,050h,033h,0C0h,050h,0E8h,0D1h,0FCh,0C3h,0FFh,036h,038h
	db 001h,016h,08Dh,046h,0ECh,050h,051h,0E8h,0F1h,0FCh,0C3h,0B8h
		dw	seg BCC_SEG_180
	db 08Eh,0C0h,026h,0A1h,016h,000h,005h,010h,000h,02Eh,0A3h,09Dh,046h,0B8h
		dw	seg BCC_SEG_180 - 2BFh
	db 08Eh,0C0h,033h,0DBh,033h,0FFh,08Dh,036h,0B0h,001h,0F7h,044h
	db 004h,002h,000h,074h,006h,083h,07Ch,002h,000h,075h,003h,0EBh,07Ch,090h
	db 08Bh,004h,006h,026h,0A3h,012h,000h,08Eh,0C0h,026h,080h,03Eh,01Ah,000h
	db 0FFh,075h,00Bh,007h,026h,0C7h,006h,012h,000h,000h,000h,0EBh,060h,090h
	db 058h,026h,0C7h,006h,018h,000h,0DAh,04Bh,0A1h,024h,001h,08Bh,016h,026h
	db 001h,026h,001h,006h,004h,000h,026h,011h,016h,006h,000h,026h,08Bh,016h
	db 008h,000h,026h,003h,016h,00Ah,000h,073h,011h,026h,08Bh,016h,008h,000h
	db 026h,03Bh,03Eh,00Ah,000h,073h,005h,026h,08Bh,03Eh,00Ah,000h,03Bh,0DAh
	db 073h,002h,08Bh,0DAh,006h,053h,006h,0B8h,00Eh,000h,050h,052h,0B8h
		dw	seg BCC_FAR_245C
	db 050h,0B8h,04Dh,04Fh,050h,09Ah,02Dh,01Eh
		dw	seg BCC_FAR_245C
	db 05Bh,007h,00Bh
	db 0C0h,074h,008h,0B8h,000h,0F0h,0EAh,09Bh,002h
		dw	seg BCC_COPY_WORDS
	db 083h,0C6h,008h
	db 081h,0FEh,090h,007h,073h,003h,0E9h,069h,0FFh,033h,0C0h,083h,0C3h,00Fh
	db 0B1h,004h,0D3h,0EBh,083h,0C3h,002h,089h,01Eh,02Ah,001h,00Bh,0FFh,074h
	db 00Eh,0B8h
		dw	seg BCC_SEG_46
	db 050h,0B8h,070h,000h,050h,057h,09Ah,01Ch,01Bh
		dw	seg BCC_FAR_245C
	db 0C3h,055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh,094h,046h,056h,057h,08Bh
	db 04Eh,00Ch,089h,00Eh,03Ch,001h,08Eh,0D9h,08Bh,036h,004h,000h,08Bh,03Eh
	db 006h,000h,08Bh,046h,004h,0BAh,010h,000h,0F7h,0E2h,003h,0F0h,013h,0FAh
	db 033h,0DBh,08Eh,0D9h,08Bh,00Eh,012h,000h,0E3h,019h,08Eh,0C1h,026h,0A1h
	db 004h,000h,026h,08Bh,016h,006h,000h,02Bh,0C6h,01Bh,0D7h,079h,008h,089h
	db 00Eh,01Ch,000h,08Ch,0DBh,0EBh,0DFh,00Bh,0DBh,074h,02Fh,08Bh,036h,004h
	db 000h,08Bh,03Eh,006h,000h,08Eh,0DBh,0C7h,006h,01Ch,000h,000h,000h,02Eh
	db 08Eh,01Eh,094h,046h,08Bh,046h,008h,08Eh,006h,03Ch,001h,026h,08Bh,016h
	db 004h,000h,026h,08Bh,00Eh,006h,000h,02Bh,0F2h,01Bh,0F9h,0E8h,085h,000h
	db 073h,005h,0B8h,0FFh,0FFh,0EBh,002h,033h,0C0h,05Fh,05Eh,01Fh,05Dh,0C2h
	db 00Ah,000h
		public	__OvrPrepare
__OvrPrepare	label	near
	db 01Eh,056h,057h,02Eh,08Eh,01Eh,094h,046h,026h,08Bh,03Eh,00Eh
	db 000h,026h,089h,03Eh,010h,000h,026h,08Bh,00Eh,00Ah,000h,0E3h,024h,026h
	db 0A1h,008h,000h,003h,0C1h,073h,019h,051h,026h,0A1h,008h,000h,08Bh,0F0h
	db 083h,0E6h,00Fh,0B1h,004h,0D3h,0E8h,026h,003h,006h,010h,000h,059h,0E8h
	db 08Bh,000h,0EBh,003h,0E8h,079h,000h,0E8h,029h,002h,026h,0A1h,010h,000h
	db 048h,08Eh,0D8h,08Ch,006h,00Ch,000h,0B8h,0FFh,0FFh,08Bh,0D8h,02Eh,08Eh
	db 01Eh,094h,046h,0FFh,01Eh,090h,000h,05Fh,05Eh,01Fh,0C3h,0B1h,004h,0D3h
	db 0E8h,0D3h,0CAh,081h,0E2h,000h,0F0h,00Bh,0C2h,0C3h,01Eh,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0D8h,0E8h,0E0h,000h,01Fh,0CBh,050h,0FFh,036h,038h,001h,051h,052h
	db 033h,0C0h,050h,0E8h,03Fh,0FBh,08Bh,01Eh,038h,001h,058h,01Eh,08Eh,0D8h
	db 0EBh,007h,08Ch,0D8h,005h,0FFh,00Fh,08Eh,0D8h,0B9h,0F0h,0FFh,00Bh,0FFh
	db 075h,002h,08Bh,0CEh,053h,053h,01Eh,033h,0C0h,050h,051h,0E8h,0E7h,0FAh
	db 05Bh,072h,00Bh,02Bh,0F0h,083h,0DFh,000h,08Bh,0C6h,00Bh,0C7h,075h,0D8h
	db 01Fh,0C3h,01Eh,006h,026h,08Bh,036h,008h,000h,026h,0A1h,010h,000h,0EBh
	db 002h,01Eh,006h,08Eh,0D8h,026h,08Eh,006h,010h,000h,0D1h,0E9h,0FCh,0ADh
	db 08Bh,0D8h,026h,08Bh,03Fh,01Eh,0B8h
		dw	seg __SEGTABLE__
	db 08Eh,0D8h,08Bh,0C7h,083h
	db 0E7h,0F8h,08Bh,015h,026h,089h,017h,0A9h,001h,000h,074h,003h,0E8h,006h
	db 000h,01Fh,0E2h,0DFh,007h,01Fh,0C3h,051h,08Eh,0DAh,026h,08Ah,067h,0FFh
	db 08Ah,0C4h,025h,007h,0F8h,080h,0FCh,0B8h,075h,04Bh,08Bh,0C8h,026h,08Ah
	db 067h,002h,08Ah,0C4h,025h,007h,0F8h,080h,0FCh,050h,075h,03Bh,03Ah,0C1h
	db 075h,037h,08Bh,0D0h,026h,08Ah,067h,003h,08Ah,0C4h,025h,007h,0F8h,03Bh
	db 0C8h,075h,028h,026h,08Ah,067h,006h,08Ah,0C4h,025h,007h,0F8h,03Bh,0C2h
	db 075h,01Bh,0BFh,020h,000h,08Bh,00Eh,00Ch,000h,026h,08Bh,047h,004h,03Bh
	db 045h,002h,074h,007h,083h,0C7h,005h,0E2h,0F6h,0EBh,006h,026h,089h,07Fh
	db 004h,059h,0C3h,059h,0C3h,026h,08Bh,036h,008h,000h,033h,0FFh,026h,003h
	db 036h,00Ah,000h,083h,0D7h,000h,026h,08Bh,016h,004h,000h,026h,08Bh,00Eh
	db 006h,000h,026h,0A1h,010h,000h,0E8h,002h,0FFh,072h,00Bh,026h,08Bh,00Eh
	db 00Ah,000h,0E3h,003h,0E8h,037h,0FFh,0F8h,0C3h,055h,08Bh,0ECh,0F7h,0C5h
	db 001h,000h,074h,008h,0B8h,001h,0F0h,0EAh,09Bh,002h
		dw	seg BCC_COPY_WORDS
	db 050h,053h
	db 051h,052h,056h,057h,01Eh,006h,0B8h
		dw	seg BCC_SEG_46
	db 08Eh,0D8h,0FBh,0C4h,05Eh
	db 002h,026h,0FFh,037h,083h,06Eh,002h,002h,075h,005h,0E8h,03Bh,000h,0EBh
	db 018h,083h,0C5h,006h,08Bh,046h,000h,087h,046h,0FAh,089h,046h,000h,0E8h
	db 02Ah,000h,08Bh,046h,000h,087h,046h,0FAh,089h,046h,000h,05Bh,026h,0A0h
	db 01Ah,000h,024h,008h,026h,080h,026h,01Ah,000h,0F7h,098h,02Eh,08Eh,01Eh
	db 094h,046h,0FFh,01Eh,090h,000h,007h,01Fh,05Fh,05Eh,05Ah,059h,05Bh,058h
	db 05Dh,0CFh,026h,083h,03Eh,010h,000h,000h,074h,002h,0EBh,006h,026h,080h
	db 00Eh,01Ah,000h,008h,006h,006h,0B8h,00Eh,000h,050h,09Ah,08Bh,045h
		dw	seg BCC_FAR_245C
	db 007h,00Bh,0C0h,075h,015h,026h,0A1h,00Eh,000h,026h,0A3h,010h,000h
	db 01Eh,048h,08Eh,0D8h,08Ch,006h,00Ch,000h,01Fh,0E8h,04Bh,000h,0C3h,0B8h
	db 004h,0F0h,0EAh,09Bh,002h
		dw	seg BCC_COPY_WORDS
	db 055h,08Bh,0ECh,01Eh,02Eh,08Eh,01Eh
	db 094h,046h,056h,057h,08Eh,046h,006h,026h,083h,03Eh,010h,000h,000h,074h
	db 009h,026h,081h,03Eh,00Eh,000h,000h,010h,073h,01Ch,0E8h,0A1h,0FFh,0BBh
	db 0FFh,0FFh,026h,0A0h,01Ah,000h,024h,008h,026h,080h,026h,01Ah,000h,0F7h
	db 098h,02Eh,08Eh,01Eh,094h,046h,0FFh,01Eh,090h,000h,05Fh,05Eh,01Fh,05Dh
	db 0CAh,002h,000h,026h,083h,03Eh,00Ch,000h,000h,075h,001h,0C3h,026h,080h
	db 03Eh,020h,000h,0EAh,074h,02Dh,026h,08Bh,00Eh,002h,000h,0E3h,009h,026h
	db 0A1h,010h,000h,08Ch,0C2h,0E8h,051h,000h,026h,08Bh,01Eh,010h,000h,026h
	db 08Bh,00Eh,00Ch,000h,0BFh,020h,000h,0FCh,026h,08Bh,055h,002h,0B0h,0EAh
	db 0AAh,08Bh,0C2h,0ABh,08Bh,0C3h,0ABh,0E2h,0F1h,0C3h,026h,080h,03Eh,020h
	db 000h,0CDh,074h,02Ah,08Ch,0C0h,026h,08Bh,016h,010h,000h,033h,0C9h,0E8h
	db 01Fh,000h,026h,089h,00Eh,002h,000h,026h,08Bh,00Eh,00Ch,000h,0BFh,020h
	db 000h,0FCh,026h,08Bh,055h,001h,0A1h,020h,001h,0ABh,08Bh,0C2h,0ABh,032h
	db 0C0h,0AAh,0E2h,0F0h,0C3h,0E8h,009h,000h,00Bh,0DBh,074h,004h,036h,087h
	db 04Fh,002h,0C3h,033h,0DBh,051h,055h,0EBh,004h,0D1h,0E1h,08Bh,0E9h,08Bh
	db 04Eh,000h,0D1h,0E9h,074h,012h,072h,0F3h,03Bh,056h,004h,075h,0EEh,089h
	db 046h,004h,00Bh,0DBh,075h,0E7h,08Bh,0DDh,0EBh,0E3h,05Dh,059h,0C3h,0A1h
	db 03Ch,001h,00Bh,0C0h,074h,00Ch,08Eh,0C0h,026h,0A1h,010h,000h,02Bh,006h
	db 030h,001h,073h,008h,0A1h,036h,001h,02Bh,006h,030h,001h,0F9h,0C3h,026h
	db 0A1h,008h,000h,005h,011h,000h,0B1h,004h,0D3h,0E8h,0C3h,0B1h,004h,026h
	db 0A1h,008h,000h,005h,011h,000h,0D3h,0E8h,026h,08Bh,016h,00Ah,000h,083h
	db 0C2h,00Fh,0D3h,0EAh,003h,0D0h,0C3h,01Eh,006h,02Eh,08Eh,01Eh,094h,046h
	db 03Bh,006h,034h,001h,072h,024h,03Bh,006h,036h,001h,073h,01Eh,050h,050h
	db 09Ah,023h,02Fh
		dw	seg BCC_FAR_245C
	db 058h,08Eh,0C2h,08Bh,01Eh,020h,001h,026h,03Bh
	db 01Eh,000h,000h,075h,009h,026h,03Bh,006h,010h,000h,08Ch,0C0h,074h,003h
	db 033h,0C0h,0F9h,007h,01Fh,0CBh,055h,08Bh,0ECh,057h,057h,0C4h,07Eh,006h
	db 0FCh,08Bh,0C5h,0ABh,08Bh,046h,000h,0ABh,08Bh,046h,002h,0ABh,08Bh,046h
	db 004h,09Ah,0D4h,04Dh
		dw	seg BCC_FAR_245C
	db 073h,003h,08Bh,046h,004h,0ABh,058h,0ABh
	db 08Ch,0D8h,0ABh,08Bh,0C6h,0ABh,033h,0C0h,05Fh,05Dh,0CAh,004h,000h
BCC_FAR_577C	label	far
	db 055h,08Bh,0ECh,083h,0ECh,002h,02Eh,08Eh,01Eh,094h,046h,0C6h,046h,0FEh
	db 000h,0C4h,076h,008h,026h,08Bh,04Ch,002h,08Bh,0DDh,0A1h,020h,001h,08Bh
	db 016h,034h,001h,0EBh,004h,0D1h,0E6h,08Bh,0DEh,03Bh,0D9h,073h,02Ah,036h
	db 08Bh,037h,0D1h,0EEh,074h,023h,072h,0EFh,036h,08Bh,07Fh,004h,03Bh,0FAh
	db 073h,0E7h,08Eh,0C7h,036h,08Bh,07Fh,002h,00Bh,0FFh,075h,0DDh,026h,039h
	db 005h,075h,0D8h,0C6h,046h,0FEh,001h,026h,089h,07Dh,002h,0EBh,0CEh,080h
	db 07Eh,0FEh,001h,074h,007h,0EBh,03Ah,090h,0D1h,0E6h,08Bh,0DEh,036h,08Bh
	db 037h,0D1h,0EEh,074h,02Eh,072h,0F3h,036h,08Bh,07Fh,004h,03Bh,0FAh,073h
	db 0EBh,08Eh,0C7h,036h,08Bh,07Fh,002h,00Bh,0FFh,074h,0E1h,026h,039h,006h
	db 000h,000h,075h,0DAh,026h,083h,03Eh,002h,000h,000h,075h,0D2h,026h,087h
	db 03Eh,002h,000h,036h,089h,07Fh,002h,0EBh,0C7h,08Bh,07Eh,006h,0C4h,076h
	db 008h,0FCh,026h,0ADh,095h,026h,0ADh,089h,046h,000h,026h,0ADh,089h,046h
	db 002h,026h,0ADh,006h,08Eh,0C0h,08Bh,00Eh,020h,001h,026h,03Bh,00Eh,000h
	db 000h,075h,03Bh,026h,083h,03Eh,010h,000h,000h,074h,008h,026h,080h,03Eh
	db 020h,000h,0CDh,075h,027h,0C7h,046h,004h,000h,000h,056h,057h,0E8h,062h
	db 0FDh,05Fh,05Eh,08Bh,05Eh,002h,006h,026h,0A0h,01Ah,000h,024h,008h,026h
	db 080h,026h,01Ah,000h,0F7h,098h,02Eh,08Eh,01Eh,094h,046h,0FFh,01Eh,090h
	db 000h,007h,026h,0A1h,010h,000h,007h,089h,046h,004h,08Bh,0D7h,026h,0ADh
	db 097h,026h,0ADh,08Eh,0D8h,026h,0ADh,096h,083h,0FAh,001h,083h,0D2h,000h
	db 092h,08Bh,0E5h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,083h,0ECh,002h,01Eh
	db 02Eh,08Eh,01Eh,094h,046h,056h,057h,08Eh,046h,00Ah,08Bh,05Eh,00Ch,04Bh
	db 0D1h,0E3h,0FFh,097h,076h,000h,05Fh,05Eh,033h,0C0h,01Fh,08Bh,0E5h,05Dh
	db 0CAh,008h,000h,026h,0A1h,00Eh,000h,026h,0A3h,010h,000h,0FFh,036h,038h
	db 001h,026h,0FFh,036h,006h,000h,026h,0FFh,036h,004h,000h,033h,0C0h,050h
	db 0E8h,0B9h,0F6h,026h,08Bh,00Eh,008h,000h,026h,003h,00Eh,00Ah,000h,073h
	db 005h,026h,08Bh,00Eh,008h,000h,09Ch,0FFh,036h,038h,001h,026h,0FFh,036h
	db 010h,000h,033h,0C0h,050h,051h,0E8h,063h,0F6h,072h,03Ch,026h,08Bh,00Eh
	db 00Ah,000h,09Dh,0E3h,033h,072h,014h,0E8h,07Dh,0FBh,006h,006h,0B8h,00Eh
	db 000h,050h,026h,0FFh,036h,008h,000h,0E8h,073h,0C4h,007h,0EBh,01Dh,0FFh
	db 036h,038h,001h,0FFh,036h,070h,000h,033h,0C0h,050h,026h,0FFh,036h,00Ah
	db 000h,0E8h,030h,0F6h,072h,009h,0A1h,070h,000h,033h,0F6h,0E8h,05Ch,0FBh
	db 0C3h,0B8h,002h,0F0h,0EAh,09Bh,002h
		dw	seg BCC_COPY_WORDS
	db 0E8h,035h,0FDh,083h,07Eh
	db 006h,000h,074h,009h,006h,0B8h,001h,000h,0FFh,01Eh,090h,000h,007h,026h
	db 0C7h,006h,010h,000h,000h,000h,0C3h,026h,0A1h,00Eh,000h,026h,0A3h,010h
	db 000h,0C3h,08Bh,046h,006h,026h,080h,03Eh,020h,000h,0CDh,074h,017h,026h
	db 08Bh,016h,010h,000h,0E8h,041h,0FDh,026h,08Bh,00Eh,00Ch,000h,0BFh,023h
	db 000h,0FCh,0ABh,083h,0C7h,003h,0E2h,0FAh,026h,0A3h,010h,000h,01Eh,048h
	db 08Eh,0D8h,08Ch,006h,00Ch,000h,01Fh,0C3h,055h,08Bh,0ECh,08Eh,046h,006h
	db 026h,0A1h,008h,000h,026h,003h,006h,00Ah,000h,073h,004h,026h,0A1h,008h
	db 000h,05Dh

		db	0C2h,004h,000h	; moved from CODE_3:0000 (segment span per FBOV table)
CODE_2 ends
; END RG2CEND
		end
