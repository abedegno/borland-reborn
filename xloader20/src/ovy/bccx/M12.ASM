	.286p
	locals

Y0D920	segment para public 'CODE'
	assume	cs:Y0D920
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 25h	;@0D920
	db	1, 0, 0CDh, 3Fh, 20h, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0E0h, 3, 5, 0, 0EEh, 0Bh, 0ACh, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D920	ends

Y0D960	segment para public 'CODE'
	assume	cs:Y0D960
	db	0CDh, 3Fh, 0C1h, 0Bh, 0, 0CDh, 3Fh, 1Dh, 0, 0, 0, 0, 0, 0, 0, 0	;@0D960
	db	0CDh, 3Fh, 0, 0, 80h, 10h, 5, 0, 0EBh, 0Ch, 8Ah, 0, 0Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0D7h
	db	0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0CFh, 1, 0, 0CDh, 3Fh, 25h
	db	1, 0, 0CDh, 3Fh, 8Ch, 1, 0, 0CDh, 3Fh, 6Bh, 1, 0, 0CDh, 3Fh, 35h
	db	9, 0, 0CDh, 3Fh, 0D2h, 8, 0, 0CDh, 3Fh, 0C0h, 1, 0, 0CDh, 3Fh
	db	6Ch
Y0D960	ends

Y0D9C0	segment para public 'CODE'
	assume	cs:Y0D9C0
	db	2, 0, 0CDh, 3Fh, 4Ch, 0Ch, 0, 0CDh, 3Fh, 87h, 7, 0, 0CDh, 3Fh	;@0D9C0
	db	95h, 0, 0, 0CDh, 3Fh, 36h, 0, 0, 0CDh, 3Fh, 94h, 0Ch, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 10h, 1Eh, 5, 0, 0B1h, 2, 0, 0, 1, 0
	db	0, 0
Y0D9C0	ends

Y0D9F0	segment para public 'CODE'
	assume	cs:Y0D9F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D9F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D9F0	ends

Y0DA10	segment para public 'CODE'
	assume	cs:Y0DA10
	db	0CDh, 3Fh, 0, 0, 0D0h, 20h, 5, 0, 6Dh, 10h, 0, 0, 0Dh, 0, 0, 0	;@0DA10
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0AFh
	db	2, 0, 0CDh, 3Fh, 0F9h, 2, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
Y0DA10	ends

Y0DA40	segment para public 'CODE'
	assume	cs:Y0DA40
	db	3Fh, 3Eh, 2, 0, 0CDh, 3Fh, 53h, 2, 0, 0CDh, 3Fh, 8Ah, 2, 0, 0CDh	;@0DA40
	db	3Fh, 0BEh, 3, 0, 0CDh, 3Fh, 0B7h, 2, 0, 0CDh, 3Fh, 18h, 4, 0, 0CDh
	db	3Fh, 67h, 2, 0, 0CDh, 3Fh, 0D3h, 2, 0, 0CDh, 3Fh, 30h, 3, 0, 0CDh
	db	3Fh, 0A7h, 2
Y0DA40	ends

Y0DA70	segment para public 'CODE'
	assume	cs:Y0DA70
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DA70
	db	50h, 31h, 5, 0, 34h, 5, 0Ah, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0FAh
	db	4, 0, 0CDh, 3Fh, 0D5h, 3, 0, 0, 0CDh, 3Fh, 0, 0, 90h, 36h, 5, 0
	db	29h, 16h, 34h, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0CDh, 3Fh, 90h, 0Dh, 0, 0CDh, 3Fh, 28h, 9, 0, 0CDh
	db	3Fh, 96h, 15h, 0, 0CDh
Y0DA70	ends

Y0DAE0	segment para public 'CODE'
	assume	cs:Y0DAE0
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0DAE0
	db	0, 0F0h, 4Ch, 5, 0, 0Ah, 0Ah, 6Ch, 0, 14h, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DAE0	ends

Y0DB10	segment para public 'CODE'
	assume	cs:Y0DB10
	db	0CDh, 3Fh, 90h, 9, 0, 0CDh, 3Fh, 70h, 6, 0, 0CDh, 3Fh, 44h, 8	;@0DB10
	db	0, 0CDh, 3Fh, 0E7h, 4, 0, 0CDh, 3Fh, 0F4h, 6, 0, 0CDh, 3Fh, 0B2h
	db	9, 0, 0CDh, 3Fh, 7Dh, 9, 0, 0CDh, 3Fh, 0D5h, 8, 0, 0CDh, 3Fh, 5Ch
	db	2, 0, 0CDh, 3Fh, 0D2h, 1, 0, 0CDh, 3Fh, 99h, 1, 0, 0CDh, 3Fh, 0FBh
	db	8, 0, 0CDh, 3Fh, 38h, 0, 0, 0CDh, 3Fh, 1Ch, 6, 0, 0CDh, 3Fh, 4Ah
	db	3, 0, 0CDh, 3Fh, 7Ch, 0, 0, 0CDh, 3Fh, 63h, 7, 0, 0CDh, 3Fh, 33h
	db	6, 0, 0CDh, 3Fh, 0D4h, 0, 0, 0CDh, 3Fh, 8Fh, 6, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
Y0DB10	ends

Y0DB80	segment para public 'CODE'
	assume	cs:Y0DB80
	db	0CDh, 3Fh, 0, 0, 70h, 57h, 5, 0, 0B5h, 11h, 10h, 1, 6, 0, 0, 0	;@0DB80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0E7h
	db	5, 0, 0CDh, 3Fh, 16h, 0Ah, 0, 0CDh, 3Fh, 0Fh, 0Fh, 0, 0CDh
Y0DB80	ends

Y0DBB0	segment para public 'CODE'
	assume	cs:Y0DBB0
	db	3Fh, 63h, 0Dh, 0, 0CDh, 3Fh, 4Dh, 0Dh, 0, 0CDh, 3Fh, 0A2h, 0Eh	;@0DBB0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 40h, 6Ah, 5, 0, 79h, 1, 6, 0, 4, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 4Bh
	db	1, 0, 0CDh, 3Fh, 57h, 0, 0, 0CDh, 3Fh, 0C5h, 0, 0, 0CDh
Y0DBB0	ends

Y0DBF0	segment para public 'CODE'
	assume	cs:Y0DBF0
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0DBF0
	db	0, 0D0h, 6Bh, 5, 0, 0F3h, 9, 10h, 0, 0Dh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 19h, 0, 0, 0CDh
	db	3Fh, 0, 0, 0, 0CDh, 3Fh, 0C2h, 0, 0, 0CDh, 3Fh, 0A3h, 0, 0, 0CDh
	db	3Fh, 0FAh, 1, 0, 0CDh, 3Fh, 5Eh, 0, 0, 0CDh, 3Fh, 0D7h, 1, 0, 0CDh
	db	3Fh, 0B6h, 1, 0, 0CDh, 3Fh, 93h, 1, 0, 0CDh, 3Fh, 6Eh, 1, 0, 0CDh
	db	3Fh, 32h, 1, 0, 0CDh, 3Fh, 0DFh, 0, 0, 0CDh, 3Fh, 0E3h, 9, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0E0h
	db	75h, 5, 0, 9, 12h, 0AAh, 0, 1, 0, 0, 0
Y0DBF0	ends
	end
