	.286p
	locals

Y0D1D0	segment para public 'CODE'
	assume	cs:Y0D1D0
	db	3Fh, 3, 1Eh, 0, 0CDh, 3Fh, 47h, 1, 0, 0CDh, 3Fh, 0F8h, 1Ch, 0	;@0D1D0
	db	0CDh, 3Fh, 8Fh, 1Fh, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0EFh, 0Eh
	db	0, 0CDh, 3Fh, 24h, 1Dh, 0, 0CDh, 3Fh, 5Dh, 1Ch, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
Y0D1D0	ends

Y0D200	segment para public 'CODE'
	assume	cs:Y0D200
	db	0CDh, 3Fh, 0, 0, 20h, 0EFh, 3, 0, 0D3h, 2Eh, 68h, 1, 0Eh, 0, 0	;@0D200
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 42h
	db	1Eh, 0, 0CDh, 3Fh, 0B0h, 0Dh, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	97h, 2Eh, 0, 0CDh, 3Fh, 0BCh, 2Eh, 0, 0CDh, 3Fh, 31h, 0Dh, 0, 0CDh
	db	3Fh
Y0D200	ends

Y0D240	segment para public 'CODE'
	assume	cs:Y0D240
	db	1Eh, 2Dh, 0, 0CDh, 3Fh, 0AFh, 1Dh, 0, 0CDh, 3Fh, 0F7h, 1Bh, 0	;@0D240
	db	0CDh, 3Fh, 0EFh, 2Dh, 0, 0CDh, 3Fh, 79h, 11h, 0, 0CDh, 3Fh, 0ACh
	db	1Bh, 0, 0CDh, 3Fh, 0BFh, 2Ah, 0, 0CDh, 3Fh, 46h, 1Dh, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
Y0D240	ends

Y0D270	segment para public 'CODE'
	assume	cs:Y0D270
	db	0CDh, 3Fh, 0, 0, 0B0h, 1Fh, 4, 0, 7Bh, 0, 8, 0, 2, 0, 0, 0, 0	;@0D270
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0
	db	0CDh, 3Fh, 0Eh, 0, 0, 0, 0, 0, 0, 0, 0
Y0D270	ends

Y0D2A0	segment para public 'CODE'
	assume	cs:Y0D2A0
	db	0CDh, 3Fh, 0, 0, 40h, 20h, 4, 0, 4Ah, 19h, 4Ch, 0, 5, 0, 0, 0	;@0D2A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 4Bh
	db	16h, 0, 0CDh, 3Fh, 0A0h, 16h, 0, 0CDh, 3Fh, 26h, 0Ah, 0, 0CDh
	db	3Fh, 0E2h, 2, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 0F0h, 39h, 4, 0, 7Bh, 0Eh, 4Ah, 0, 17h, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D2A0	ends

Y0D300	segment para public 'CODE'
	assume	cs:Y0D300
	db	0CDh, 3Fh, 95h, 0Dh, 0, 0CDh, 3Fh, 87h, 0Bh, 0, 0CDh, 3Fh, 43h	;@0D300
	db	0, 0, 0CDh, 3Fh, 42h, 0Eh, 0, 0CDh, 3Fh, 0F5h, 8, 0, 0CDh, 3Fh
	db	0D3h, 0Dh, 0, 0CDh, 3Fh, 71h, 7, 0, 0CDh, 3Fh, 0EAh, 0Dh, 0, 0CDh
	db	3Fh, 1, 0Eh, 0, 0CDh, 3Fh, 18h, 0Eh, 0, 0CDh, 3Fh, 2Eh, 0Eh, 0
	db	0CDh, 3Fh, 73h, 0Eh, 0, 0CDh, 3Fh, 0ABh, 0Dh, 0, 0CDh, 3Fh, 56h
	db	0Eh, 0, 0CDh, 3Fh, 0DDh, 0, 0, 0CDh, 3Fh, 84h, 0Ch, 0, 0CDh, 3Fh
	db	68h, 0Dh, 0, 0CDh, 3Fh, 0BFh, 0Dh, 0, 0CDh, 3Fh, 6Bh, 1, 0, 0CDh
	db	3Fh, 0F5h, 0Ah, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 3Bh, 0Dh, 0
	db	0CDh, 3Fh
Y0D300	ends

Y0D370	segment para public 'CODE'
	assume	cs:Y0D370
	db	1Bh, 0Dh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0D370
	db	0, 0, 0C0h, 48h, 4, 0, 4Fh, 18h, 52h, 1, 3, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D370	ends

Y0D3A0	segment para public 'CODE'
	assume	cs:Y0D3A0
	db	0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0C3h, 14h, 0, 0CDh, 3Fh, 0CCh, 15h	;@0D3A0
	db	0, 0, 0CDh, 3Fh, 0, 0, 80h, 62h, 4, 0, 89h, 0Fh, 34h, 0, 0Fh, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	0E3h, 1, 0, 0CDh, 3Fh, 94h, 0, 0, 0CDh, 3Fh, 24h, 0, 0, 0CDh
Y0D3A0	ends

Y0D3E0	segment para public 'CODE'
	assume	cs:Y0D3E0
	db	3Fh, 30h, 0Bh, 0, 0CDh, 3Fh, 0A4h, 0Ah, 0, 0CDh, 3Fh, 0FEh, 0Eh	;@0D3E0
	db	0, 0CDh, 3Fh, 0FBh, 0Ah, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 13h
	db	0, 0, 0CDh, 3Fh, 75h, 1, 0, 0CDh, 3Fh, 48h, 2, 0, 0CDh, 3Fh, 3
	db	1, 0, 0CDh, 3Fh, 3Dh, 0Eh, 0, 0CDh, 3Fh, 0A9h, 2, 0, 0CDh, 3Fh
	db	88h, 0Bh, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 50h, 72h, 4, 0, 46h
	db	0Dh, 7Ah, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 60h, 0, 0, 0CDh, 3Fh, 83h, 9, 0, 0CDh, 3Fh
	db	0E6h, 5, 0, 0CDh, 3Fh, 31h, 0, 0, 0CDh, 3Fh, 51h, 0, 0, 0CDh, 3Fh
	db	79h, 0Ch, 0, 0CDh, 3Fh, 0E9h, 0Bh, 0, 0CDh, 3Fh, 0CCh, 0Bh, 0
	db	0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 20h, 80h, 4, 0, 30h
	db	0, 0, 0, 1, 0, 0, 0
Y0D3E0	ends

Y0D480	segment para public 'CODE'
	assume	cs:Y0D480
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D480
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 60h, 80h
	db	4, 0, 0Bh, 0Bh, 3Ah, 0, 14h, 0, 0, 0
Y0D480	ends

Y0D4B0	segment para public 'CODE'
	assume	cs:Y0D4B0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 11h	;@0D4B0
	db	0, 0, 0CDh, 3Fh, 0B0h, 1, 0, 0CDh, 3Fh, 5Eh, 1, 0, 0CDh, 3Fh, 30h
	db	8, 0, 0CDh, 3Fh, 0A2h, 0Ah, 0, 0CDh, 3Fh, 0EAh, 7, 0, 0CDh, 3Fh
	db	0Eh, 1, 0, 0CDh, 3Fh, 7Ch, 0Ah, 0, 0CDh, 3Fh, 0F3h, 9, 0, 0CDh
	db	3Fh, 45h, 0Ah, 0, 0CDh, 3Fh, 8Fh, 0Ah, 0, 0CDh, 3Fh, 0B5h, 0Ah
	db	0, 0CDh, 3Fh, 0EBh, 1, 0, 0CDh, 3Fh, 58h, 0Ah, 0, 0CDh, 3Fh, 21h
	db	3, 0, 0CDh, 3Fh, 0Fh, 6, 0, 0CDh, 3Fh, 27h, 9, 0, 0CDh, 3Fh, 0
	db	9, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
Y0D4B0	ends

Y0D520	segment para public 'CODE'
	assume	cs:Y0D520
	db	3Fh, 0CDh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0D520
	db	0, 0, 0B0h, 8Bh, 4, 0, 61h, 13h, 8Eh, 1, 6, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	74h, 0Fh, 0, 0CDh, 3Fh, 0D7h, 0Bh, 0, 0CDh, 3Fh, 3, 0Dh, 0, 0CDh
	db	3Fh, 0D5h, 0Ch, 0, 0CDh, 3Fh, 0CEh, 10h, 0, 0, 0
Y0D520	ends
	end
