	.286p
	locals

Y0CA10	segment para public 'CODE'
	assume	cs:Y0CA10
	db	0, 0, 0, 0CDh, 3Fh, 0F7h, 9, 0, 0CDh, 3Fh, 97h, 3, 0, 0CDh, 3Fh	;@0CA10
	db	9Ch, 4, 0, 0CDh, 3Fh, 58h, 0Ah, 0, 0CDh, 3Fh, 33h, 10h, 0, 0CDh
	db	3Fh, 35h, 0, 0, 0CDh, 3Fh, 18h, 6, 0, 0CDh, 3Fh, 87h, 0Dh, 0, 0CDh
	db	3Fh, 0B9h, 0Fh, 0, 0CDh, 3Fh, 0E2h, 0Fh, 0, 0CDh, 3Fh, 88h, 0Ah
	db	0, 0CDh, 3Fh, 5Eh, 2, 0, 0CDh, 3Fh, 62h, 6, 0, 0CDh, 3Fh, 8Bh
	db	0Fh, 0, 0CDh, 3Fh, 62h, 0Fh, 0, 0CDh, 3Fh, 0B5h, 8, 0, 0CDh, 3Fh
	db	4Fh, 7, 0, 0CDh, 3Fh, 36h, 5, 0, 0CDh, 3Fh, 64h, 9, 0, 0CDh, 3Fh
	db	9Ah, 7, 0, 0CDh, 3Fh, 0ECh, 3, 0, 0CDh, 3Fh, 0CDh, 5, 0, 0CDh
	db	3Fh, 0AEh, 6, 0, 0CDh, 3Fh, 46h, 4, 0, 0CDh, 3Fh, 7Ah, 0, 0
Y0CA10	ends

Y0CA90	segment para public 'CODE'
	assume	cs:Y0CA90
	db	0CDh, 3Fh, 17h, 1, 0, 0CDh, 3Fh, 0E1h, 7, 0, 0CDh, 3Fh, 13h, 7	;@0CA90
	db	0, 0CDh, 3Fh, 4Dh, 10h, 0, 0CDh, 3Fh, 0B9h, 10h, 0, 0CDh, 3Fh
	db	79h, 10h, 0, 0CDh, 3Fh, 0EDh, 10h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 40h, 0ACh, 2, 0, 16h, 1, 10h, 0, 3
	db	0, 0, 0
Y0CA90	ends

Y0CAD0	segment para public 'CODE'
	assume	cs:Y0CAD0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 2Dh	;@0CAD0
	db	0, 0, 0CDh, 3Fh, 0A3h, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0CDh, 3Fh
	db	0, 0, 70h, 0ADh, 2, 0, 0C7h, 10h, 9Ah, 0, 0Bh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0B1h, 0Eh, 0
	db	0CDh, 3Fh, 0EAh, 0Ch, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 35h, 2
	db	0, 0CDh, 3Fh, 5Dh, 0Ch, 0, 0CDh, 3Fh, 0FBh, 2, 0, 0CDh, 3Fh, 0DCh
	db	2, 0, 0CDh, 3Fh, 49h, 2, 0, 0CDh, 3Fh, 49h, 0Eh, 0, 0CDh, 3Fh
	db	1Ah, 3, 0, 0CDh, 3Fh, 0D6h, 0Ah, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0CDh, 3Fh, 0, 0, 0E0h, 0BEh, 2, 0, 0F2h, 1, 0Ch, 0, 1, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 79h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0E0h, 0C0h
	db	2, 0, 0A3h, 15h, 0DAh, 0, 0Bh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 36h, 15h, 0, 0CDh, 3Fh, 67h
	db	11h, 0, 0CDh, 3Fh, 0Ah, 11h, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	9Ch, 15h, 0, 0CDh, 3Fh, 1Fh, 0, 0, 0CDh, 3Fh
Y0CAD0	ends

Y0CBC0	segment para public 'CODE'
	assume	cs:Y0CBC0
	db	6Bh, 13h, 0, 0CDh, 3Fh, 83h, 14h, 0, 0CDh, 3Fh, 2Eh, 0Fh, 0, 0CDh	;@0CBC0
	db	3Fh, 2Bh, 9, 0, 0CDh, 3Fh, 2Dh, 11h, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0CDh, 3Fh, 0, 0, 0C0h, 0D7h, 2, 0, 5Ah, 24h, 94h, 1, 0Fh, 0
	db	0, 0
Y0CBC0	ends

Y0CBF0	segment para public 'CODE'
	assume	cs:Y0CBF0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0BAh	;@0CBF0
	db	0, 0, 0CDh, 3Fh, 0B0h, 23h, 0, 0CDh, 3Fh, 0DFh, 0Ch, 0, 0CDh, 3Fh
	db	84h, 12h, 0, 0CDh, 3Fh, 0F6h, 11h, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 24h, 1Ah, 0, 0CDh, 3Fh, 0F4h, 22h, 0, 0CDh, 3Fh, 83h, 0Ah
	db	0, 0CDh, 3Fh, 8Ch, 11h, 0, 0CDh, 3Fh, 0F0h, 1Ch, 0, 0CDh, 3Fh
	db	7Fh, 21h, 0, 0CDh, 3Fh, 33h, 13h, 0, 0CDh, 3Fh, 52h, 0Ah, 0, 0CDh
	db	3Fh, 1, 1, 0, 0, 0, 0, 0, 0
Y0CBF0	ends

Y0CC50	segment para public 'CODE'
	assume	cs:Y0CC50
	db	0CDh, 3Fh, 0, 0, 0D0h, 0FDh, 2, 0, 8, 0Ch, 42h, 0, 0Ch, 0, 0, 0	;@0CC50
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 3Dh
	db	3, 0, 0CDh, 3Fh, 32h, 0Ah, 0, 0CDh, 3Fh, 0EDh, 8, 0, 0CDh
Y0CC50	ends

Y0CC80	segment para public 'CODE'
	assume	cs:Y0CC80
	db	3Fh, 6Fh, 0Ah, 0, 0CDh, 3Fh, 63h, 1, 0, 0CDh, 3Fh, 33h, 0Bh, 0	;@0CC80
	db	0CDh, 3Fh, 46h, 5, 0, 0CDh, 3Fh, 8Ah, 0, 0, 0CDh, 3Fh, 6Bh, 2
	db	0, 0CDh, 3Fh, 0F8h, 4, 0, 0CDh, 3Fh, 0E8h, 0Bh, 0, 0CDh, 3Fh, 0A6h
	db	4, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 20h, 0Ah, 3, 0, 22h, 3, 20h
	db	0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0CDh, 3Fh, 1Eh, 2, 0, 0CDh, 3Fh, 0FDh, 1, 0, 0CDh, 3Fh, 7Ch, 0
	db	0, 0CDh
Y0CC80	ends

Y0CCE0	segment para public 'CODE'
	assume	cs:Y0CCE0
	db	3Fh, 73h, 2, 0, 0CDh, 3Fh, 9Eh, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh	;@0CCE0
	db	3Fh, 0, 0, 70h, 0Dh, 3, 0, 4Fh, 12h, 0BAh, 0, 8, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 62h, 0Eh
	db	0, 0CDh, 3Fh, 4Eh, 2, 0, 0CDh, 3Fh, 0Dh, 6, 0, 0CDh, 3Fh, 2Fh
	db	10h, 0, 0CDh, 3Fh, 2Eh, 1, 0, 0CDh, 3Fh, 0D3h, 1, 0, 0CDh, 3Fh
	db	0B2h, 5, 0, 0CDh, 3Fh, 41h, 0Eh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 80h, 20h, 3, 0, 9Ch, 8, 70h, 0, 9, 0, 0, 0
Y0CCE0	ends

Y0CD50	segment para public 'CODE'
	assume	cs:Y0CD50
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 2Ch	;@0CD50
	db	8, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 8Eh, 6, 0, 0CDh, 3Fh, 8Eh
	db	7, 0, 0CDh, 3Fh, 6Ch, 0, 0, 0CDh, 3Fh, 0A5h, 0, 0, 0CDh, 3Fh, 64h
	db	8, 0, 0CDh, 3Fh, 5Ah, 6, 0, 0CDh, 3Fh, 0B2h, 7, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 0C0h, 29h, 3, 0, 22h, 5, 48h, 0, 1, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0CD50	ends

Y0CDB0	segment para public 'CODE'
	assume	cs:Y0CDB0
	db	0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0CDB0
	db	0, 0, 30h, 2Fh, 3, 0, 2Fh, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0
Y0CDB0	ends

Y0CDF0	segment para public 'CODE'
	assume	cs:Y0CDF0
	db	0CDh, 3Fh, 0, 0, 70h, 2Fh, 3, 0, 0FCh, 0, 0, 0, 1, 0, 0, 0, 0	;@0CDF0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 80h, 30h, 3
	db	0, 2Bh, 7, 5Eh, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
Y0CDF0	ends

Y0CE40	segment para public 'CODE'
	assume	cs:Y0CE40
	db	0CDh, 3Fh, 40h, 0, 0, 0CDh, 3Fh, 0F8h, 5, 0, 0CDh, 3Fh, 4Eh, 3	;@0CE40
	db	0, 0, 0CDh, 3Fh, 0, 0, 10h, 38h, 3, 0, 0B3h, 7, 0A2h, 0, 2, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh
	db	0, 0, 0, 0CDh, 3Fh, 0A8h, 6, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 70h, 40h, 3, 0, 87h, 5, 0Ch, 0, 8, 0, 0, 0
Y0CE40	ends
	end
