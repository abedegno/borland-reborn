	.286p
	locals

Y0D570	segment para public 'CODE'
	assume	cs:Y0D570
	db	0CDh, 3Fh, 0, 0, 0B0h, 0A0h, 4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0	;@0D570
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D570	ends

Y0D5A0	segment para public 'CODE'
	assume	cs:Y0D5A0
	db	0CDh, 3Fh, 0, 0, 0C0h, 0A0h, 4, 0, 9Ch, 1, 2Ah, 0, 3, 0, 0, 0	;@0D5A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0
	db	0, 0CDh, 3Fh, 5Bh, 1, 0, 0CDh, 3Fh, 16h, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 90h, 0A2h, 4, 0, 0FBh, 1, 24h, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0B0h, 0A4h, 4, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0CDh, 3Fh, 0, 0, 0C0h, 0A4h, 4, 0, 0C4h, 10h, 44h, 0, 0Dh, 0, 0
	db	0
Y0D5A0	ends

Y0D630	segment para public 'CODE'
	assume	cs:Y0D630
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D630
	db	0, 0CDh, 3Fh, 18h, 2, 0, 0CDh, 3Fh, 9Ch, 2, 0, 0CDh, 3Fh, 0B5h
	db	0, 0, 0CDh, 3Fh, 0C4h, 0, 0, 0CDh, 3Fh, 0C8h, 2, 0, 0CDh, 3Fh
	db	48h, 3, 0, 0CDh, 3Fh, 37h, 1, 0, 0CDh, 3Fh, 0CDh, 3, 0, 0CDh, 3Fh
	db	92h
Y0D630	ends

Y0D670	segment para public 'CODE'
	assume	cs:Y0D670
	db	3, 0, 0CDh, 3Fh, 0E6h, 2, 0, 0CDh, 3Fh, 0E6h, 3, 0, 0CDh, 3Fh	;@0D670
	db	50h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	0, 0, 0D0h, 0B5h, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D670	ends

Y0D6A0	segment para public 'CODE'
	assume	cs:Y0D6A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D6A0
	db	0E0h, 0B5h, 4, 0, 0A9h, 0Dh, 20h, 0, 0Fh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D6A0	ends

Y0D6D0	segment para public 'CODE'
	assume	cs:Y0D6D0
	db	0CDh, 3Fh, 59h, 5, 0, 0CDh, 3Fh, 54h, 0, 0, 0CDh, 3Fh, 0EFh, 0	;@0D6D0
	db	0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0Bh, 0, 0, 0CDh, 3Fh, 49h, 0
	db	0, 0CDh, 3Fh, 9Ah, 0, 0, 0CDh, 3Fh, 0C1h, 4, 0, 0CDh, 3Fh, 12h
	db	1, 0, 0CDh, 3Fh, 1Fh
Y0D6D0	ends

Y0D700	segment para public 'CODE'
	assume	cs:Y0D700
	db	0, 0, 0CDh, 3Fh, 0A1h, 0Dh, 0, 0CDh, 3Fh, 0BDh, 8, 0, 0CDh, 3Fh	;@0D700
	db	47h, 4, 0, 0CDh, 3Fh, 0AEh, 1, 0, 0CDh, 3Fh, 7Fh, 0, 0, 0, 0, 0
	db	0, 0
Y0D700	ends

Y0D720	segment para public 'CODE'
	assume	cs:Y0D720
	db	0CDh, 3Fh, 0, 0, 0B0h, 0C3h, 4, 0, 53h, 7, 28h, 0, 0Fh, 0, 0, 0	;@0D720
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0CDh
	db	3, 0, 0CDh, 3Fh, 50h, 1, 0, 0CDh, 3Fh, 0F6h, 4, 0, 0CDh, 3Fh, 66h
	db	5, 0, 0CDh, 3Fh, 79h, 6, 0, 0CDh, 3Fh, 8Fh, 1, 0, 0CDh, 3Fh, 0A5h
	db	6, 0, 0CDh, 3Fh, 0CCh, 6, 0, 0CDh, 3Fh, 7Eh, 4, 0, 0CDh, 3Fh, 0F2h
	db	6, 0, 0CDh, 3Fh, 6Eh, 2, 0, 0CDh, 3Fh, 26h, 7, 0, 0CDh, 3Fh, 0B9h
	db	1, 0, 0CDh, 3Fh, 0CEh, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0
Y0D720	ends

Y0D790	segment para public 'CODE'
	assume	cs:Y0D790
	db	0CDh, 3Fh, 0, 0, 40h, 0CBh, 4, 0, 2Eh, 0Fh, 3Ch, 0, 14h, 0, 0	;@0D790
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D790	ends

Y0D7B0	segment para public 'CODE'
	assume	cs:Y0D7B0
	db	0CDh, 3Fh, 0, 1, 0, 0CDh, 3Fh, 0Eh, 0Fh, 0, 0CDh, 3Fh, 1Eh, 0Fh	;@0D7B0
	db	0, 0CDh, 3Fh, 3Bh, 0, 0, 0CDh, 3Fh, 0D7h, 4, 0, 0CDh, 3Fh, 5Bh
	db	5, 0, 0CDh, 3Fh, 2, 0Bh, 0, 0CDh, 3Fh, 87h, 5, 0, 0CDh, 3Fh, 0C2h
	db	6, 0, 0CDh, 3Fh, 1Ah, 0Eh, 0, 0CDh, 3Fh, 71h, 5, 0, 0CDh, 3Fh
	db	60h, 4, 0, 0CDh, 3Fh, 14h, 6, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	8Ch, 3, 0, 0CDh, 3Fh, 62h, 3, 0, 0CDh, 3Fh, 0CEh, 1, 0, 0CDh, 3Fh
	db	0C0h, 3, 0, 0CDh, 3Fh, 78h, 1, 0, 0CDh, 3Fh, 0D0h, 2, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D7B0	ends

Y0D820	segment para public 'CODE'
	assume	cs:Y0D820
	db	0CDh, 3Fh, 0, 0, 0D0h, 0DAh, 4, 0, 0B1h, 2, 12h, 0, 5, 0, 0, 0	;@0D820
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 94h
	db	1, 0, 0CDh, 3Fh, 40h, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0E8h
	db	1, 0, 0CDh, 3Fh, 0D9h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0A0h, 0DDh, 4, 0, 51h, 22h, 84h, 1, 0Bh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0A6h, 0Ah, 0, 0CDh
	db	3Fh, 2Fh, 0Ah, 0, 0CDh, 3Fh, 0DDh, 0Ch, 0, 0CDh
Y0D820	ends

Y0D890	segment para public 'CODE'
	assume	cs:Y0D890
	db	3Fh, 31h, 18h, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0BEh, 17h, 0	;@0D890
	db	0CDh, 3Fh, 0ACh, 0Ch, 0, 0CDh, 3Fh, 0Ch, 20h, 0, 0CDh, 3Fh, 8Ah
	db	13h, 0, 0CDh, 3Fh, 9Ch, 15h, 0, 0CDh, 3Fh, 3Ah, 16h, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 90h, 1, 5, 0, 0A5h, 0, 2, 0
	db	3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 2Bh, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 8, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 40h, 2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 50h, 2, 5, 0
	db	54h, 1, 32h, 0, 3, 0, 0, 0
Y0D890	ends
	end
