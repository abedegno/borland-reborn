	.286p
	locals

Y0BFD0	segment para public 'CODE'
	assume	cs:Y0BFD0
	db	0CDh, 3Fh, 56h, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 47h, 5, 0	;@0BFD0
	db	0CDh, 3Fh, 70h, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 90h, 0EBh, 0, 0, 77h, 8, 0D4h, 0, 3, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0Bh, 3, 0
	db	0CDh, 3Fh, 0E0h, 4, 0, 0CDh, 3Fh, 64h, 7, 0, 0, 0CDh, 3Fh, 0, 0
	db	0E0h, 0F4h, 0, 0, 0C7h, 0Ch, 72h, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0BFD0	ends

Y0C040	segment para public 'CODE'
	assume	cs:Y0C040
	db	0CDh, 3Fh, 21h, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0C040
	db	0, 0, 20h, 2, 1, 0, 0F0h, 10h, 0B6h, 0, 2, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0DDh, 2, 0, 0CDh
	db	3Fh, 72h, 10h, 0, 0, 0, 0, 0, 0, 0
Y0C040	ends

Y0C080	segment para public 'CODE'
	assume	cs:Y0C080
	db	0CDh, 3Fh, 0, 0, 0D0h, 13h, 1, 0, 19h, 0Ch, 0Ch, 0, 5, 0, 0, 0	;@0C080
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 95h
	db	0Bh, 0, 0CDh, 3Fh, 0A0h, 0, 0, 0CDh, 3Fh, 69h, 0Bh, 0, 0CDh
Y0C080	ends

Y0C0B0	segment para public 'CODE'
	assume	cs:Y0C0B0
	db	3Fh, 0DAh, 8, 0, 0CDh, 3Fh, 0BEh, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh	;@0C0B0
	db	3Fh, 0, 0, 0, 20h, 1, 0, 51h, 21h, 0A4h, 1, 2Bh, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0B1h, 0Bh
	db	0, 0CDh, 3Fh, 49h, 2, 0, 0CDh, 3Fh, 71h, 12h, 0, 0CDh
Y0C0B0	ends

Y0C0F0	segment para public 'CODE'
	assume	cs:Y0C0F0
	db	3Fh, 0B1h, 19h, 0, 0CDh, 3Fh, 5Ah, 9, 0, 0CDh, 3Fh, 1Eh, 19h, 0	;@0C0F0
	db	0CDh, 3Fh, 45h, 12h, 0, 0CDh, 3Fh, 5Ah, 1Ch, 0, 0CDh, 3Fh, 0AFh
	db	14h, 0, 0CDh, 3Fh, 99h, 7, 0, 0CDh, 3Fh, 6Dh, 0, 0, 0CDh, 3Fh
	db	12h, 3, 0, 0CDh, 3Fh, 0CDh, 0Ch
Y0C0F0	ends

Y0C120	segment para public 'CODE'
	assume	cs:Y0C120
	db	0, 0CDh, 3Fh, 1Ah, 7, 0, 0CDh, 3Fh, 84h, 10h, 0, 0CDh, 3Fh, 0D6h	;@0C120
	db	8, 0, 0CDh, 3Fh, 5Bh, 12h, 0, 0CDh, 3Fh, 18h, 0Ch, 0, 0CDh, 3Fh
	db	92h, 8, 0, 0CDh, 3Fh, 2Dh, 0, 0, 0CDh, 3Fh, 4Fh, 6, 0, 0CDh, 3Fh
	db	16h, 14h, 0, 0CDh, 3Fh
Y0C120	ends

Y0C150	segment para public 'CODE'
	assume	cs:Y0C150
	db	0CAh, 13h, 0, 0CDh, 3Fh, 0F3h, 7, 0, 0CDh, 3Fh, 68h, 0Ch, 0, 0CDh	;@0C150
	db	3Fh, 0ECh, 10h, 0, 0CDh, 3Fh, 2Dh, 0Fh, 0, 0CDh, 3Fh, 13h, 10h
	db	0, 0CDh, 3Fh, 16h, 0Dh, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0D0h
	db	1, 0, 0CDh, 3Fh, 33h, 0Bh, 0
Y0C150	ends

Y0C180	segment para public 'CODE'
	assume	cs:Y0C180
	db	0CDh, 3Fh, 7Ah, 0Dh, 0, 0CDh, 3Fh, 88h, 17h, 0, 0CDh, 3Fh, 11h	;@0C180
	db	17h, 0, 0CDh, 3Fh, 0FBh, 12h, 0, 0CDh, 3Fh, 0FDh, 20h, 0, 0CDh
	db	'?b ', 0, 0CDh, 3Fh, 0E9h, 20h, 0, 0CDh, 3Fh, 4Ch, 1, 0, 0CDh
	db	3Fh, 21h, 6, 0, 0CDh, 3Fh, 51h, 1Fh, 0, 0CDh, 3Fh, 3Bh, 6, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
Y0C180	ends

Y0C1C0	segment para public 'CODE'
	assume	cs:Y0C1C0
	db	0CDh, 3Fh, 0, 0, 10h, 43h, 1, 0, 9Eh, 1Fh, 72h, 1, 8, 0, 0, 0	;@0C1C0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 5Ch
	db	8, 0, 0CDh, 3Fh, 0CEh, 4, 0, 0CDh, 3Fh, 0F4h, 18h, 0, 0CDh, 3Fh
	db	55h, 12h, 0, 0CDh, 3Fh, 67h, 1Dh, 0, 0CDh, 3Fh, 53h, 18h, 0, 0CDh
	db	3Fh, 49h, 0Eh, 0, 0CDh, 3Fh, 0E8h, 0Ch, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0CDh, 3Fh, 0, 0, 30h, 64h, 1, 0, 94h, 3, 20h, 0, 5, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0FAh
	db	0, 0, 0CDh, 3Fh, 40h, 1, 0, 0CDh, 3Fh, 0CEh, 2, 0, 0CDh, 3Fh, 4
	db	3, 0, 0CDh, 3Fh, 34h, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0F0h, 67h, 1, 0, 0B1h, 15h, 90h, 1, 8, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0B4h, 7, 0, 0CDh
	db	3Fh, 0Bh, 3, 0, 0CDh, 3Fh, 63h, 10h, 0, 0CDh, 3Fh, 0F5h, 0Eh, 0
	db	0CDh, 3Fh, 87h, 3, 0, 0CDh, 3Fh, 3, 6, 0, 0CDh, 3Fh, 80h, 15h
	db	0, 0CDh, 3Fh, 0D1h, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 40h, 7Fh, 1, 0, 0CEh, 9, 0BEh, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C1C0	ends

Y0C2C0	segment para public 'CODE'
	assume	cs:Y0C2C0
	db	0CDh, 3Fh, 0BCh, 8, 0, 0CDh, 3Fh, 0E6h, 7, 0, 0CDh, 3Fh, 0A1h	;@0C2C0
	db	2, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 0D0h, 89h, 1, 0, 0A7h, 9, 9Ch, 0, 5, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0Fh, 2, 0
	db	0CDh, 3Fh, 0FFh, 7, 0, 0CDh, 3Fh, 4Eh, 8, 0, 0CDh
Y0C2C0	ends

Y0C310	segment para public 'CODE'
	assume	cs:Y0C310
	db	3Fh, 3Fh, 2, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh	;@0C310
	db	3Fh, 0, 0, 20h, 94h, 1, 0, 0BBh, 1Dh, 52h, 2, 8, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 9Fh, 16h, 0, 0CDh, 3Fh, 26h, 1Bh, 0, 0CDh
Y0C310	ends

Y0C350	segment para public 'CODE'
	assume	cs:Y0C350
	db	3Fh, 81h, 13h, 0, 0CDh, 3Fh, 7Eh, 2, 0, 0CDh, 3Fh, 18h, 0Dh, 0	;@0C350
	db	0CDh, 3Fh, 0A4h, 7, 0, 0CDh, 3Fh, 33h, 11h, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 30h, 0B4h, 1, 0, 8Eh, 2, 22h, 0, 1, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 86h
	db	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0C350	ends
	end
