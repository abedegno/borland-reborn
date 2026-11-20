	.286p
	locals

Y0C3A0	segment para public 'CODE'
	assume	cs:Y0C3A0
	db	0CDh, 3Fh, 0, 0, 0E0h, 0B6h, 1, 0, 0EBh, 1, 24h, 0, 2, 0, 0, 0	;@0C3A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0
	db	0, 0CDh, 3Fh, 60h, 1, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0F0h
	db	0B8h, 1, 0, 32h, 1, 1Ch, 0, 2, 0, 0, 0
Y0C3A0	ends

Y0C3E0	segment para public 'CODE'
	assume	cs:Y0C3E0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0C8h	;@0C3E0
	db	0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 40h
	db	0BAh, 1, 0, 17h, 3, 0Eh, 0, 0Bh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C3E0	ends

Y0C420	segment para public 'CODE'
	assume	cs:Y0C420
	db	0CDh, 3Fh, 0FAh, 1, 0, 0CDh, 3Fh, 1Eh, 2, 0, 0CDh, 3Fh, 68h, 2	;@0C420
	db	0, 0CDh, 3Fh, 7Fh, 1, 0, 0CDh, 3Fh, 0A5h, 1, 0, 0CDh, 3Fh, 0E7h
	db	1, 0, 0CDh, 3Fh, 3Ch, 1, 0, 0CDh, 3Fh, 5Eh, 1, 0, 0CDh, 3Fh, 0EDh
	db	2, 0, 0CDh, 3Fh, 0C3h, 2, 0, 0CDh, 3Fh, 4Eh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 70h, 0BDh, 1, 0, 0B3h, 3, 34h
	db	0, 2, 0, 0, 0
Y0C420	ends

Y0C470	segment para public 'CODE'
	assume	cs:Y0C470
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0BAh	;@0C470
	db	1, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 60h
	db	0C1h, 1, 0, 69h, 9, 6Eh, 0, 5, 0, 0, 0
Y0C470	ends

Y0C4A0	segment para public 'CODE'
	assume	cs:Y0C4A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 4Fh	;@0C4A0
	db	7, 0, 0CDh, 3Fh, 0EEh, 8, 0, 0CDh, 3Fh, 1Ah, 5, 0, 0CDh, 3Fh, 0BAh
	db	6, 0, 0CDh, 3Fh, 94h, 2, 0, 0, 0, 0, 0, 0, 0, 0
Y0C4A0	ends

Y0C4D0	segment para public 'CODE'
	assume	cs:Y0C4D0
	db	0CDh, 3Fh, 0, 0, 40h, 0CBh, 1, 0, 4, 8, 16h, 0, 0Ch, 0, 0, 0, 0	;@0C4D0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0F9h, 6
	db	0, 0CDh, 3Fh, 69h, 5, 0, 0CDh, 3Fh, 0Dh, 7, 0, 0CDh
Y0C4D0	ends

Y0C500	segment para public 'CODE'
	assume	cs:Y0C500
	db	3Fh, 0Dh, 6, 0, 0CDh, 3Fh, 5Ah, 7, 0, 0CDh, 3Fh, 8Ch, 2, 0, 0CDh	;@0C500
	db	3Fh, 8Fh, 5, 0, 0CDh, 3Fh, 0D7h, 7, 0, 0CDh, 3Fh, 0EFh, 4, 0, 0CDh
	db	3Fh, 0E5h, 6, 0, 0CDh, 3Fh, 0D1h, 6, 0, 0CDh, 3Fh, 2Ah, 6, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 70h, 0D3h, 1, 0, 77h, 8, 0DAh, 0, 7
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0DEh, 5, 0, 0CDh, 3Fh, 78h, 4, 0, 0CDh, 3Fh, 0B1h, 3, 0, 0CDh
Y0C500	ends

Y0C560	segment para public 'CODE'
	assume	cs:Y0C560
	db	3Fh, 4Eh, 5, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0F3h, 6, 0, 0CDh	;@0C560
	db	3Fh, 8Ch, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	0, 0, 0D0h, 0DCh, 1, 0, 13h, 4, 40h, 0, 5, 0, 0, 0
Y0C560	ends

Y0C590	segment para public 'CODE'
	assume	cs:Y0C590
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0BEh	;@0C590
	db	3, 0, 0CDh, 3Fh, 8Dh, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 58h
	db	1, 0, 0CDh, 3Fh, 0F6h, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 30h, 0E1h, 1, 0, 2Ah, 4, 54h, 0, 3, 0, 0, 0
Y0C590	ends

Y0C5D0	segment para public 'CODE'
	assume	cs:Y0C5D0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0C5D0
	db	0, 0CDh, 3Fh, 54h, 1, 0, 0CDh, 3Fh, 69h, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0B0h, 0E5h, 1, 0, 20h, 6, 5Ch, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0EEh, 3, 0, 0CDh, 3Fh
	db	5Ch, 5, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0DAh, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C5D0	ends

Y0C630	segment para public 'CODE'
	assume	cs:Y0C630
	db	0CDh, 3Fh, 0, 0, 30h, 0ECh, 1, 0, 17h, 0Ch, 4, 0, 0Ah, 0, 0, 0	;@0C630
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 96h
	db	9, 0, 0CDh, 3Fh, 0DAh, 0Ah, 0, 0CDh, 3Fh, 80h, 0Ah, 0, 0CDh, 3Fh
	db	0Ah, 0Bh, 0, 0CDh, 3Fh, 84h, 6, 0, 0CDh, 3Fh, 80h, 7, 0, 0CDh
	db	3Fh, 62h, 8, 0, 0CDh, 3Fh, 4Ch, 0Ah, 0, 0CDh, 3Fh, 75h, 9, 0, 0CDh
	db	3Fh, 36h
Y0C630	ends

Y0C680	segment para public 'CODE'
	assume	cs:Y0C680
	db	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0C680
	db	50h, 0F8h, 1, 0, 73h, 13h, 0D8h, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0A8h, 12h, 0, 0CDh
	db	3Fh, 98h, 12h, 0, 0CDh, 3Fh, 0B8h, 12h, 0, 0CDh
Y0C680	ends
	end
