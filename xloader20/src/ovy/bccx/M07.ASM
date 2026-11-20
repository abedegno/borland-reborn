	.286p
	locals

Y0C6C0	segment para public 'CODE'
	assume	cs:Y0C6C0
	db	3Fh, 41h, 13h, 0, 0CDh, 3Fh, 0D2h, 6, 0, 0CDh, 3Fh, 0E8h, 9, 0	;@0C6C0
	db	0, 0, 0CDh, 3Fh, 0, 0, 0A0h, 0Ch, 2, 0, 71h, 17h, 54h, 0, 25h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C6C0	ends

Y0C6F0	segment para public 'CODE'
	assume	cs:Y0C6F0
	db	0CDh, 3Fh, 52h, 0Ch, 0, 0CDh, 3Fh, 6, 8, 0, 0CDh, 3Fh, 2Bh, 9	;@0C6F0
	db	0, 0CDh, 3Fh, 92h, 3, 0, 0CDh, 3Fh, 0E0h, 5, 0, 0CDh, 3Fh, 3, 4
	db	0, 0CDh, 3Fh, 4Dh, 7, 0, 0CDh, 3Fh, 0B5h, 0, 0, 0CDh, 3Fh, 0DAh
	db	7, 0, 0CDh, 3Fh, 9Ch, 0Fh, 0, 0CDh, 3Fh, 73h, 2, 0, 0CDh, 3Fh
	db	91h, 0Eh, 0, 0CDh, 3Fh, 0C8h, 16h
Y0C6F0	ends

Y0C730	segment para public 'CODE'
	assume	cs:Y0C730
	db	0, 0CDh, 3Fh, 0BDh, 15h, 0, 0CDh, 3Fh, 5, 15h, 0, 0CDh, 3Fh, 35h	;@0C730
	db	1, 0, 0CDh, 3Fh, 0A4h, 0, 0, 0CDh, 3Fh, 81h, 0Ch, 0, 0CDh, 3Fh
	db	18h, 2, 0, 0CDh, 3Fh, 4Ch, 2, 0, 0CDh, 3Fh, 29h, 4, 0, 0CDh, 3Fh
	db	34h, 3, 0, 0CDh, 3Fh, 79h, 4, 0, 0CDh, 3Fh, 0EBh, 1, 0, 0CDh, 3Fh
	db	0ACh, 1, 0, 0CDh, 3Fh, 0F6h, 4, 0, 0CDh, 3Fh, 61h, 0, 0, 0CDh
	db	3Fh, 47h, 11h, 0, 0CDh, 3Fh, 0FAh, 0Dh, 0, 0CDh, 3Fh, 20h, 12h
	db	0, 0CDh, 3Fh, 49h, 1, 0, 0CDh, 3Fh, 0CAh, 3, 0
Y0C730	ends

Y0C790	segment para public 'CODE'
	assume	cs:Y0C790
	db	0CDh, 3Fh, 6Bh, 6, 0, 0CDh, 3Fh, 78h, 1, 0, 0CDh, 3Fh, 61h, 0Dh	;@0C790
	db	0, 0CDh, 3Fh, 0C1h, 7, 0, 0CDh, 3Fh, 0DCh, 0Ch, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 70h, 24h, 2, 0, 55h, 0Fh, 0CCh, 0, 5
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C790	ends

Y0C7D0	segment para public 'CODE'
	assume	cs:Y0C7D0
	db	0CDh, 3Fh, 8Fh, 0, 0, 0CDh, 3Fh, 0C6h, 0Eh, 0, 0CDh, 3Fh, 5Eh	;@0C7D0
	db	1, 0, 0CDh, 3Fh, 8, 0Ch, 0, 0CDh, 3Fh, 6Eh, 0Dh, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 0A0h, 34h, 2, 0, 12h, 16h, 4, 1, 5, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	95h, 5, 0, 0CDh, 3Fh, 0B4h, 3, 0, 0CDh, 3Fh, 28h, 6, 0, 0CDh, 3Fh
	db	80h, 13h, 0, 0CDh, 3Fh, 9Eh, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	0, 0, 0C0h, 4Bh, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 5Eh
	db	34h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 0D0h, 4Bh, 2, 0, 0F9h, 1, 8, 0, 3, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0, 0CDh, 3Fh, 89h, 0, 0, 0CDh, 3Fh, 51h, 1, 0, 0, 0CDh, 3Fh
	db	0, 0, 0E0h, 4Dh, 2, 0, 50h, 11h, 54h, 0, 4, 0, 0, 0
Y0C7D0	ends

Y0C8B0	segment para public 'CODE'
	assume	cs:Y0C8B0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 9Eh	;@0C8B0
	db	10h, 0, 0CDh, 3Fh, 4, 0Fh, 0, 0CDh, 3Fh, 5Fh, 3, 0, 0CDh, 3Fh
	db	0E7h, 0Bh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 90h, 5Fh, 2, 0, 49h, 6, 32h, 0, 1, 0, 0, 0
Y0C8B0	ends

Y0C8F0	segment para public 'CODE'
	assume	cs:Y0C8F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 34h	;@0C8F0
	db	6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 10h, 66h
	db	2, 0, 0D4h, 2Eh, 18h, 1, 12h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
Y0C8F0	ends

Y0C930	segment para public 'CODE'
	assume	cs:Y0C930
	db	0CDh, 3Fh, 13h, 0, 0, 0CDh, 3Fh, 1Dh, 1, 0, 0CDh, 3Fh, 0, 0, 0	;@0C930
	db	0CDh, 3Fh, 0Ah, 1, 0, 0CDh, 3Fh, 30h, 1, 0, 0CDh, 3Fh, 0A4h, 0
	db	0, 0CDh, 3Fh
Y0C930	ends

Y0C950	segment para public 'CODE'
	assume	cs:Y0C950
	db	39h, 0, 0, 0CDh, 3Fh, 64h, 0, 0, 0CDh, 3Fh, 0E4h, 0, 0, 0CDh, 3Fh	;@0C950
	db	78h, 1, 0, 0CDh, 3Fh, 17h, 2, 0, 0CDh, 3Fh, 43h, 1, 0, 0CDh, 3Fh
	db	7Ch, 0
Y0C950	ends

Y0C970	segment para public 'CODE'
	assume	cs:Y0C970
	db	0, 0CDh, 3Fh, 0A4h, 2Eh, 0, 0CDh, 3Fh, 26h, 0, 0, 0CDh, 3Fh, 4Ch	;@0C970
	db	0, 0, 0CDh, 3Fh, 0CCh, 0, 0, 0CDh, 3Fh, 76h, 2, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 0, 96h, 2, 0, 0B1h, 4, 1Ah, 0, 4, 0, 0
	db	0
Y0C970	ends

Y0C9A0	segment para public 'CODE'
	assume	cs:Y0C9A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 96h	;@0C9A0
	db	4, 0, 0CDh, 3Fh, 9Eh, 4, 0, 0CDh, 3Fh, 8Ah, 2, 0, 0CDh, 3Fh, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0D0h
	db	9Ah, 2, 0, 17h, 11h, 46h, 0, 27h, 0, 0, 0
Y0C9A0	ends

Y0C9E0	segment para public 'CODE'
	assume	cs:Y0C9E0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 4Fh	;@0C9E0
	db	0Dh, 0, 0CDh, 3Fh, 11h, 0Dh, 0, 0CDh, 3Fh, 8Dh, 10h, 0, 0CDh, 3Fh
	db	5Bh, 3, 0, 0CDh, 3Fh, 18h, 10h, 0, 0CDh, 3Fh, 49h, 8, 0, 0CDh
	db	3Fh
Y0C9E0	ends
	end
