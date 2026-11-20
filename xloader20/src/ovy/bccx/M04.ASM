	.286p
	locals

Y0B6C0	segment para public 'CODE'
	assume	cs:Y0B6C0
	db	3Fh, 1, 27h, 0, 1, 0, 0Dh, 0, 4Fh, 1, 0B9h, 2, 1, 0, 7, 0	;@0B6C0
Y0B6C0	ends

Y0B6D0	segment para public 'CODE'
	assume	cs:Y0B6D0
	db	5Fh, 1, 7Ch, 0, 1, 0, 9, 0, 6Fh, 1, 36h, 0, 1, 0, 0Ch, 0	;@0B6D0
Y0B6D0	ends

Y0B6E0	segment para public 'CODE'
	assume	cs:Y0B6E0
	db	7Fh, 1, 24h, 0, 1, 0, 6, 0, 8Fh, 1, 23h, 0, 1, 0, 4, 0, 0AFh, 1	;@0B6E0
	db	3, 0, 1, 0, 3, 0, 0AFh, 1, 64h, 0, 1, 0, 3, 0, 0BFh, 1, 5Eh, 0
	db	1, 0, 4, 0, 0CFh, 1, 38h, 0, 1, 0, 0Eh, 0, 0DFh, 1, 9Bh, 0, 1
	db	0, 8, 0, 0EFh, 1, 30h, 0, 1, 0, 0Bh, 0, 0FFh, 1, 23h, 0, 1, 0
	db	0, 0, 0Fh, 2, 22h, 0, 1, 0, 3, 0
Y0B6E0	ends

Y0B730	segment para public 'CODE'
	assume	cs:Y0B730
	db	1Fh, 2, 22h, 0, 1, 0, 2, 0, 2Fh, 2, 89h, 0, 1, 0, 2, 0, 3Fh, 2	;@0B730
	db	2Ah, 0, 1, 0, 9, 0, 4Fh, 2, 74h, 0, 1, 0, 0Ah, 0, 5Fh, 2, 1Fh
	db	0, 1, 0, 4, 0, 6Fh, 2, 57h, 0, 1, 0, 0Fh, 0, 7Fh, 2, 2Dh, 0, 1
	db	0, 7, 0, 8Fh, 2, 2Dh, 0, 1, 0, 0Dh, 0, 9Fh, 2, 93h, 2, 1, 0, 0Dh
	db	0, 0AFh, 2, 0E5h, 0, 1, 0, 3, 0, 0BFh, 2, 33h, 0, 1, 0, 5, 0, 0CFh
	db	2, 24h, 1, 1, 0, 3, 0, 0DFh, 2, 83h, 0, 1, 0, 4, 0, 0EFh, 2, 58h
	db	0, 1, 0, 3, 0, 0FFh, 2, 98h, 0, 1, 0, 8, 0, 17h, 3, 0, 0, 0, 0
	db	0, 0, 17h, 3, 30h, 8, 0, 0, 0, 0, 27h, 3, 0FFh, 0FFh, 4, 0, 0
	db	0, 37h, 3, 0FFh, 0FFh, 4, 0, 0, 0, 47h, 3, 0FFh, 0FFh, 4, 0, 0
	db	0, 67h, 3, 0FFh, 0FFh, 4, 0, 0, 0, 67h, 3, 0FFh, 0FFh, 4, 0, 0
	db	0, 77h, 3, 0FFh, 0FFh, 4, 0, 0, 0, 8Fh, 3, 10h, 0, 1, 0, 0, 0
	db	9Fh, 3, 43h, 0, 3, 0, 0, 0, 0AFh, 3, 9Dh, 0, 3, 0, 0, 0, 0BFh
	db	3, 9Dh, 0, 3, 0, 0, 0, 0CFh, 3, 2Fh, 0, 3, 0, 0, 0, 0DFh, 3, 6Bh
	db	0, 3, 0, 0, 0, 0EFh, 3, 2Fh, 0, 3, 0, 0, 0, 0FFh, 3, 3Eh, 0, 3
	db	0, 0, 0, 0Fh, 4, 66h, 0, 3, 0, 0, 0, 1Fh, 4, 39h, 0, 3, 0, 0, 0
	db	2Fh, 4, 25h, 0, 3, 0, 0, 0, 3Fh, 4, 34h, 0, 3, 0, 0, 0, 4Fh, 4
	db	2Fh, 0, 3, 0, 0, 0, 5Fh, 4, 25h, 0, 3, 0, 0, 0, 6Fh, 4, 2Ah, 0
	db	3, 0, 0, 0, 7Fh, 4, 39h, 0, 3, 0, 0, 0, 8Fh, 4, 0F7h, 0, 3, 0
	db	0, 0, 9Fh, 4, 48h, 0, 3, 0, 0, 0, 0AFh, 4, 39h, 0, 3, 0, 0, 0
	db	0BFh, 4, 48h, 0, 3, 0, 0, 0, 0CFh, 4, 34h, 0, 3, 0, 0, 0, 0DFh
	db	4, 39h, 0, 3, 0, 0, 0, 0EFh, 4, 48h, 0, 3, 0, 0, 0, 0FFh, 4, 25h
	db	0, 3, 0, 0, 0, 0Fh, 5, 2Ah, 0, 3, 0, 0, 0, 1Fh, 5, 2Ah, 0, 3, 0
	db	0, 0, 2Fh, 5, 57h, 0, 3, 0, 0, 0, 3Fh, 5, 2Ah, 0, 3, 0, 0, 0, 4Fh
	db	5, 39h, 0, 3, 0, 0, 0, 5Fh, 5, 5Ch, 0, 3, 0, 0, 0, 6Fh, 5, 43h
	db	0, 3, 0, 0, 0, 7Fh, 5, 39h, 0, 3, 0, 0, 0, 8Fh, 5, 2Fh, 0, 3, 0
	db	0, 0, 9Fh, 5, 34h, 0, 3, 0, 0, 0, 0AFh, 5, 52h, 0, 3, 0, 0, 0
	db	0BFh, 5, 3Eh, 0, 3, 0, 0, 0, 0CFh, 5, 0D9h, 0, 3, 0, 0, 0, 0DFh
	db	5, 39h, 0, 3, 0, 0, 0, 0EFh, 5, 39h, 0, 3, 0, 0, 0, 0FFh, 5, 20h
	db	0, 3, 0, 0, 0, 0Fh, 6, 20h, 0, 3, 0, 0, 0, 1Fh, 6, 2Fh, 0, 3, 0
	db	0, 0, 2Fh, 6, 34h, 0, 3, 0, 0, 0, 3Fh, 6, 25h, 0, 3, 0, 0, 0, 4Fh
	db	6, 7Ah, 0, 3, 0, 0, 0, 5Fh, 6, 34h, 0, 3, 0, 0, 0, 6Fh, 6, 0E3h
	db	0, 3, 0, 0, 0, 7Fh, 6, 2Fh, 0, 3, 0, 0, 0, 8Fh, 6, 57h, 0, 3, 0
	db	0, 0, 9Fh, 6, 25h, 0, 3, 0, 0, 0, 0AFh, 6, 57h, 0, 3, 0, 0, 0
	db	0BFh, 6, 6Bh, 0, 3, 0, 0, 0, 0CFh, 6, 5Ch, 0, 3, 0, 0, 0, 0DFh
	db	6, 39h, 0, 3, 0, 0, 0, 0EFh, 6, 48h, 0, 3, 0, 0, 0, 0FFh, 6, 4Dh
	db	0, 3, 0, 0, 0, 0Fh, 7, 25h, 0, 3, 0, 0, 0, 1Fh, 7, 25h, 0, 3, 0
	db	0, 0, 2Fh, 7, 25h, 0, 3, 0, 0, 0, 3Fh, 7, 2Fh, 0, 3, 0, 0, 0, 4Fh
	db	7, 2Ah, 0, 3, 0, 0, 0, 5Fh, 7, 48h, 0, 3, 0, 0, 0, 6Fh, 7, 39h
	db	0, 3, 0, 0, 0, 7Fh, 7, 43h, 0, 3, 0, 0, 0, 8Fh, 7, 48h, 0, 3, 0
	db	0, 0, 9Fh, 7, 84h, 0, 3, 0, 0, 0, 0AFh, 7, 39h, 0, 3, 0, 0, 0
	db	0BFh, 7, 48h, 0, 3, 0, 0, 0, 0CFh, 7, 25h, 0, 3, 0, 0, 0, 0DFh
	db	7, 39h, 0, 3, 0, 0, 0, 0EFh, 7, 2Ah, 0, 3, 0, 0, 0, 0FFh, 7, 2Fh
	db	0, 3, 0, 0, 0, 0Fh, 8, 57h, 0, 3, 0, 0, 0, 1Fh, 8, 66h, 0, 3, 0
	db	0, 0, 2Fh, 8, 2Ah, 0, 3, 0, 0, 0, 3Fh, 8, 39h, 0, 3, 0, 0, 0, 4Fh
	db	8, 93h, 0, 3, 0, 0, 0, 5Fh, 8, 2Fh, 0, 3, 0, 0, 0, 6Fh, 8, 6Bh
	db	0, 3, 0, 0, 0, 7Fh, 8, 4Dh, 0, 3, 0, 0, 0, 8Fh, 8, 25h, 0, 3, 0
	db	0, 0, 9Fh, 8, 84h, 0, 3, 0, 0, 0, 0AFh, 8, 3Eh, 0, 3, 0, 0, 0
	db	0BFh, 8, 25h, 0, 3, 0, 0, 0, 0CFh, 8, 2Fh, 0, 3, 0, 0, 0, 0DFh
	db	8, 25h, 0, 3, 0, 0, 0, 0EFh, 8, 20h, 0, 3, 0, 0, 0, 0FFh, 8, 61h
	db	0, 3, 0, 0, 0, 0Fh, 9, 20h, 0, 3, 0, 0, 0, 1Fh, 9, 6Bh, 0, 3, 0
	db	0, 0, 2Fh, 9, 6Bh, 0, 3, 0, 0, 0, 3Fh, 9, 84h, 0, 3, 0, 0, 0, 4Fh
	db	9, 39h, 0, 3, 0, 0, 0, 5Fh, 9, 57h, 0, 3, 0, 0, 0, 6Fh, 9, 2Fh
	db	0, 3, 0, 0, 0, 7Fh, 9, 20h, 0, 3, 0, 0, 0, 8Fh, 9, 2Fh, 0, 3, 0
	db	0, 0, 9Fh, 9, 2Ah, 0, 3, 0, 0, 0, 0AFh, 9, 6Bh, 0, 3, 0, 0, 0
	db	0BFh, 9, 25h, 0, 3, 0, 0, 0, 0CFh, 9, 61h, 0, 3, 0, 0, 0, 0DFh
	db	9, 2Fh, 0, 3, 0, 0, 0, 0EFh, 9, 34h, 0, 3, 0, 0, 0, 0FFh, 9, 84h
	db	0, 3, 0, 0, 0, 0Fh, 0Ah, 3Eh, 0, 3, 0, 0, 0, 1Fh, 0Ah, 34h, 0
	db	3, 0, 0, 0, 2Fh, 0Ah, 61h, 0, 3, 0, 0, 0, 3Fh, 0Ah, 25h, 0, 3
	db	0, 0, 0, 4Fh, 0Ah, 25h, 0, 3, 0, 0, 0, 5Fh, 0Ah, 25h, 0, 3, 0
	db	0, 0, 6Fh, 0Ah, 43h, 0, 3, 0, 0, 0, 7Fh, 0Ah, 52h, 0, 3, 0, 0
	db	0, 8Fh, 0Ah, 2Ah, 0, 3, 0, 0, 0, 9Fh, 0Ah, 48h, 0, 3, 0, 0, 0
	db	0AFh, 0Ah, 2Fh, 0, 3, 0, 0, 0, 0BFh, 0Ah, 2Fh, 0, 3, 0, 0, 0, 0CFh
	db	0Ah, 39h, 0, 3, 0, 0, 0, 0DFh, 0Ah, 25h, 0, 3, 0, 0, 0, 0EFh, 0Ah
	db	25h, 0, 3, 0, 0, 0, 0FFh, 0Ah, 20h, 0, 3, 0, 0, 0, 0Fh, 0Bh, 25h
	db	0, 3, 0, 0, 0, 1Fh, 0Bh, 2Ah, 0, 3, 0, 0, 0, 2Fh, 0Bh, 39h, 0
	db	3, 0, 0, 0, 3Fh, 0Bh, 25h, 0, 3, 0, 0, 0, 4Fh, 0Bh, 84h, 0, 3
	db	0, 0, 0, 5Fh, 0Bh, 61h, 0, 3, 0, 0, 0, 6Fh, 0Bh, 2Ah, 0, 3, 0
	db	0, 0, 7Fh, 0Bh, 3Eh, 0, 3, 0, 0, 0, 87h, 0Bh, 4, 0A0h, 0, 0, 0
	db	0, 97h, 0Bh, 5, 0, 4, 0, 6, 0, 0A7h, 0Bh, 9, 0, 4, 0, 0Ah, 0, 0B7h
	db	0Bh, 0FFh, 0FFh, 4, 0, 0, 0, 0CFh, 0Bh, 4, 0, 1, 0, 4, 0, 'bccx.exe'
	db	0, 0, 0, 62h, 1Eh, 1, 0C7h, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 70h, 34h, 0, 0, 0A9h, 18h, 2Ah
	db	1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0CDh, 3Fh, 30h, 9, 0, 0CDh, 3Fh, 87h, 6, 0, 0CDh, 3Fh, 1Eh, 3
	db	0, 0CDh, 3Fh, 0BFh, 17h, 0, 0CDh, 3Fh, 25h, 11h, 0, 0CDh, 3Fh
	db	35h, 4, 0, 0CDh, 3Fh, 84h, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 50h, 4Eh, 0, 0, 33h, 5, 20h, 0, 19h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 71h, 2, 0, 0CDh, 3Fh, 0B9h, 3, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 3, 2, 0, 0CDh, 3Fh, 2Ah, 0, 0, 0CDh, 3Fh, 0D7h, 0, 0, 0CDh
	db	3Fh, 1Bh, 3, 0, 0CDh, 3Fh, 0EBh, 2, 0, 0CDh, 3Fh, 14h, 5, 0, 0CDh
	db	3Fh, 29h, 5, 0, 0CDh, 3Fh, 77h, 1, 0, 0CDh, 3Fh, 75h, 0, 0, 0CDh
	db	3Fh, 4Fh, 1, 0, 0CDh, 3Fh, 0C8h, 2, 0, 0CDh, 3Fh, 0A5h, 1, 0, 0CDh
	db	3Fh, 95h, 2, 0, 0CDh, 3Fh, 0B4h, 2, 0, 0CDh, 3Fh, 0C7h, 3, 0, 0CDh
	db	3Fh, 9Dh, 3, 0, 0CDh, 3Fh, 0D4h, 1, 0, 0CDh, 3Fh, 44h, 2, 0, 0CDh
	db	3Fh, 54h, 0, 0, 0CDh, 3Fh, 2, 3, 0, 0CDh, 3Fh, 0DCh, 2, 0, 0CDh
	db	3Fh, 5Fh, 4, 0, 0, 0, 0
Y0B730	ends

Y0BD20	segment para public 'CODE'
	assume	cs:Y0BD20
	db	0CDh, 3Fh, 0, 0, 0B0h, 53h, 0, 0, 2Ch, 6, 80h, 0, 19h, 0, 0, 0	;@0BD20
Y0BD20	ends

Y0BD30	segment para public 'CODE'
	assume	cs:Y0BD30
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0BAh	;@0BD30
	db	0, 0, 0CDh, 3Fh, 0ACh, 5, 0, 0CDh, 3Fh, 38h, 3, 0, 0CDh, 3Fh, 0E6h
	db	2, 0, 0CDh, 3Fh, 28h, 1, 0, 0CDh, 3Fh, 15h, 0, 0, 0CDh, 3Fh, 87h
	db	3, 0, 0CDh, 3Fh, 0D7h, 0, 0, 0CDh, 3Fh, 0FCh, 4, 0, 0CDh, 3Fh
	db	0C1h, 5, 0, 0CDh, 3Fh, 4Ah, 4, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	9Ah, 1
Y0BD30	ends

Y0BD80	segment para public 'CODE'
	assume	cs:Y0BD80
	db	0, 0CDh, 3Fh, 53h, 1, 0, 0CDh, 3Fh, 0ADh, 2, 0, 0CDh, 3Fh, 0E2h	;@0BD80
	db	5, 0, 0CDh, 3Fh, 0B6h, 1, 0, 0CDh, 3Fh, 5Eh, 2, 0, 0CDh, 3Fh, 4
	db	2, 0, 0CDh, 3Fh, 0Fh, 6, 0, 0CDh, 3Fh, 2, 4, 0, 0CDh, 3Fh, 48h
	db	5, 0, 0CDh, 3Fh, 0A4h, 3, 0, 0CDh, 3Fh, 96h, 4, 0, 0CDh, 3Fh, 6Fh
	db	4, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 60h, 5Ah, 0, 0, 0ADh, 9, 6Ch, 0
	db	3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 82h, 9, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0F4h, 5, 0, 0, 0CDh
	db	3Fh, 0, 0, 90h, 64h, 0, 0, 54h, 1Bh, 3Eh, 1, 0Fh, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0D1h, 16h
	db	0, 0CDh, 3Fh, 0E1h, 0Bh, 0, 0CDh, 3Fh, 40h, 18h, 0, 0CDh
Y0BD80	ends

Y0BE20	segment para public 'CODE'
	assume	cs:Y0BE20
	db	3Fh, 24h, 13h, 0, 0CDh, 3Fh, 0A0h, 4, 0, 0CDh, 3Fh, 54h, 8, 0	;@0BE20
	db	0CDh, 3Fh, 0CDh, 14h, 0, 0CDh, 3Fh, 0C1h, 6, 0, 0CDh, 3Fh, 58h
	db	0Dh, 0, 0CDh, 3Fh, 0EEh, 10h, 0, 0CDh, 3Fh, 0A4h, 3, 0, 0CDh, 3Fh
	db	5Dh, 0Eh, 0, 0CDh, 3Fh, 13h, 0Fh, 0, 0CDh, 3Fh, 0FFh, 19h, 0, 0CDh
	db	3Fh, 64h, 11h, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 30h, 81h, 0
	db	0, 0FBh, 0Ah, 88h, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 34h, 6, 0, 0CDh, 3Fh, 50h, 0Ah, 0
	db	0CDh, 3Fh, 0BFh, 3, 0, 0, 0CDh, 3Fh, 0, 0, 0C0h, 8Ch, 0, 0, 0C6h
	db	0Ch, 64h, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 1Ah, 0Ah, 0, 0CDh, 3Fh, 0ADh, 3, 0, 0CDh, 3Fh
	db	0E9h, 0, 0, 0CDh
Y0BE20	ends

Y0BEC0	segment para public 'CODE'
	assume	cs:Y0BEC0
	db	3Fh, 0C6h, 0Bh, 0, 0CDh, 3Fh, 0FAh, 0Ah, 0, 0CDh, 3Fh, 2, 9, 0	;@0BEC0
	db	0, 0, 0CDh, 3Fh, 0, 0, 0F0h, 99h, 0, 0, 9Eh, 10h, 6Ch, 0, 0Eh
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0BEC0	ends

Y0BEF0	segment para public 'CODE'
	assume	cs:Y0BEF0
	db	0CDh, 3Fh, 9Fh, 2, 0, 0CDh, 3Fh, 0AAh, 8, 0, 0CDh, 3Fh, 87h, 2	;@0BEF0
	db	0, 0CDh, 3Fh, 0B3h, 0Ah, 0, 0CDh, 3Fh, 0Dh, 7, 0, 0CDh, 3Fh, 55h
	db	7, 0, 0CDh, 3Fh, 53h, 0, 0, 0CDh, 3Fh, 0BFh, 0Ch, 0, 0CDh, 3Fh
	db	0C8h, 5, 0, 0CDh, 3Fh, 1Ch, 10h, 0, 0CDh, 3Fh, 9Eh, 4, 0, 0CDh
	db	3Fh, 0EAh, 5, 0, 0CDh, 3Fh, 10h, 6, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0ABh, 0, 0, 0A0h, 26h
	db	0D8h, 2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0
Y0BEF0	ends

Y0BF60	segment para public 'CODE'
	assume	cs:Y0BF60
	db	0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0DDh, 24h, 0, 0CDh, 3Fh, 8, 0Eh	;@0BF60
	db	0, 0CDh, 3Fh, 96h, 4, 0, 0CDh, 3Fh, 0CFh, 25h, 0, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 80h, 0D4h, 0, 0, 37h, 10h, 8Ah, 0, 1, 0
	db	0, 0
Y0BF60	ends

Y0BF90	segment para public 'CODE'
	assume	cs:Y0BF90
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 75h	;@0BF90
	db	0Eh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 50h
	db	0E5h, 0, 0, 2Dh, 6, 8, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0
Y0BF90	ends
	end
