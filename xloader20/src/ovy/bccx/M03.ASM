	.286p
	locals

Y0AE30	segment para public 'CODE'
	assume	cs:Y0AE30
	db	46h, 0FCh, 89h, 5Eh, 0FAh, 0FFh, 4Eh, 0FAh, 8Bh, 5Eh, 0FAh, 26h	;@0AE30
	db	0C6h, 7, 0, 0C4h, 5Eh, 0Ah, 26h, 80h, '?lu', 6, 0FFh, 46h, 0Ah
	db	0BEh, 1, 0, 0C4h, 5Eh, 0Ah, 26h, 8Ah, 7, 98h, 3Dh, 73h, 0, 75h
	db	3, 0E9h, 0B5h, 1, 7Fh, 10h, 3Dh, 63h, 0, 75h, 3, 0E9h, 9Bh, 1
	db	3Dh, 64h, 0, 74h, 0Eh, 0E9h, 0DDh, 1, 3Dh, 78h, 0, 75h, 3, 0E9h
	db	1, 1, 0E9h, 0D2h, 1, 0Bh, 0F6h, 74h, 16h, 0C4h, 5Eh
Y0AE30	ends

Y0AE80	segment para public 'CODE'
	assume	cs:Y0AE80
	db	6, 26h, 8Bh, 57h, 2, 26h, 8Bh, 7, 89h, 56h, 0ECh, 89h, 46h, 0EAh	;@0AE80
	db	83h, 46h, 6, 4, 0EBh, 11h, 0C4h, 5Eh, 6, 26h, 8Bh, 7, 99h, 89h
	db	56h, 0ECh, 89h, 46h
Y0AE80	ends

Y0AEA0	segment para public 'CODE'
	assume	cs:Y0AEA0
	db	0EAh, 83h, 46h, 6, 2, 81h, 7Eh, 0ECh, 0, 80h, 75h, 11h, 83h, 7Eh	;@0AEA0
	db	0EAh, 0, 75h, 0Bh, 8Ch, 5Eh, 0FCh, 0C7h, 46h, 0FAh, 0A2h, 5Ch
	db	0E9h, 84h, 0, 8Bh, 46h, 0EAh
Y0AEA0	ends

Y0AEC0	segment para public 'CODE'
	assume	cs:Y0AEC0
	db	0Bh, 46h, 0ECh, 75h, 0Ah, 0BAh, 30h, 0, 0B4h, 2, 0CDh, 21h, 0E9h	;@0AEC0
	db	6Eh, 1, 83h, 7Eh, 0ECh, 0, 7Fh, 22h, 7Ch, 6, 83h, 7Eh, 0EAh, 0
	db	73h, 1Ah, 0C7h, 46h, 0FEh, 1, 0, 8Bh, 56h, 0ECh, 8Bh, 46h, 0EAh
	db	0F7h, 0DAh, 0F7h, 0D8h, 83h, 0DAh, 0, 89h, 56h, 0ECh, 89h, 46h
	db	0EAh, 0EBh, 3Ch, 0C7h, 46h, 0FEh, 0, 0, 0EBh, 35h, 0FFh, 4Eh, 0FAh
	db	33h, 0D2h, 0B8h, 0Ah, 0, 52h, 50h, 0FFh, 76h, 0ECh, 0FFh, 76h
	db	0EAh, 9Ah, 0D2h, 2, 1Fh, 0, 4, 30h, 0C4h, 5Eh, 0FAh, 26h, 88h
	db	7, 33h, 0D2h, 0B8h, 0Ah, 0, 52h, 50h, 0FFh, 76h, 0ECh, 0FFh, 76h
	db	0EAh, 9Ah, 0C9h, 2, 1Fh, 0, 89h, 56h, 0ECh, 89h, 46h, 0EAh, 8Bh
	db	46h, 0EAh, 0Bh, 46h, 0ECh, 75h, 0C3h, 83h, 7Eh, 0FEh, 0, 74h, 7
	db	0C7h, 46h, 0FEh, 2Dh, 0, 0EBh, 5, 0C7h, 46h, 0FEh, 0, 0, 83h, 7Eh
	db	0FEh, 0, 74h, 19h, 8Bh, 56h, 0FEh, 0B4h, 2, 0CDh, 21h, 0EBh, 10h
	db	0C4h, 5Eh, 0FAh, 26h, 8Ah, 7, 98h, 8Bh, 0D0h, 0FFh, 46h, 0FAh
	db	0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0FAh, 26h, 80h, 3Fh, 0, 75h, 0E7h
	db	0E9h, 0C5h, 0, 0Bh, 0F6h, 74h, 16h, 0C4h, 5Eh, 6, 26h, 8Bh, 57h
	db	2, 26h, 8Bh, 7, 89h, 56h, 0E8h, 89h, 46h, 0E6h, 83h, 46h, 6, 4
	db	0EBh, 4Bh, 0C4h, 5Eh, 6, 26h, 8Bh, 7, 33h, 0D2h, 89h, 56h, 0E8h
	db	89h, 46h, 0E6h, 83h, 46h, 6, 2, 0EBh, 37h, 0FFh, 4Eh, 0FAh, 8Bh
	db	46h, 0E6h, 25h, 0Fh, 0, 89h, 46h, 0FEh, 3Dh, 9, 0, 7Eh, 6, 83h
	db	46h, 0FEh, 57h, 0EBh, 4, 83h, 46h, 0FEh, 30h, 8Ah, 46h, 0FEh, 0C4h
	db	5Eh, 0FAh, 26h, 88h, 7, 8Bh, 56h, 0E8h, 8Bh, 46h, 0E6h, 0B1h, 4
	db	9Ah, 0E3h, 3, 1Fh, 0, 89h, 56h, 0E8h, 89h, 46h, 0E6h, 8Bh, 46h
	db	0E6h, 0Bh, 46h, 0E8h, 75h, 0C1h, 0EBh, 10h, 0C4h, 5Eh, 0FAh, 26h
	db	8Ah, 7, 98h, 8Bh, 0D0h, 0FFh, 46h, 0FAh, 0B4h, 2, 0CDh, 21h, 0C4h
	db	5Eh, 0FAh, 26h, 80h, 3Fh, 0, 75h, 0E7h, 0EBh, 3Bh, 0C4h, 5Eh, 6
	db	26h, 8Bh, 17h, 83h, 46h, 6, 2, 0B4h, 2, 0CDh, 21h, 0EBh, 2Bh, 0C4h
	db	5Eh, 6, 26h, 0C4h, 1Fh, 8Ch, 46h, 0FCh, 89h, 5Eh, 0FAh, 83h, 46h
	db	6, 4, 0EBh, 10h, 0C4h, 5Eh, 0FAh, 26h, 8Ah, 7, 98h, 8Bh, 0D0h
	db	0FFh, 46h, 0FAh, 0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0FAh, 26h, 80h
	db	3Fh, 0, 75h, 0E7h, 0FFh, 46h, 0Ah, 0C4h, 5Eh, 0Ah, 26h, 80h, 3Fh
	db	0, 74h, 3, 0E9h, 0B1h, 0FDh, 5Eh, 8Bh, 0E5h, 5Dh, 0CAh, 8, 0, 33h
	db	0F6h, 33h, 0FFh, 0BBh, 0Ah, 0, 3Bh, 0D3h, 73h, 6, 0F7h, 0F3h, 87h
	db	0F2h, 0EBh, 1Bh, 0B9h, 20h, 0, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0D6h
	db	0D1h, 0D7h, 85h, 0FFh, 75h, 4, 3Bh, 0F3h, 72h, 6, 2Bh, 0F3h, 83h
	db	0DFh, 0, 40h, 0E2h, 0E8h, 0C3h, 26h, 0C6h, 5, 0, 33h, 0EDh, 8Bh
	db	0D8h, 0Bh, 0DAh, 74h, 11h, 57h, 0E8h, 0C3h, 0FFh, 5Fh, 8Bh, 0DEh
	db	80h, 0C3h, 30h, 26h, 89h, 1Dh, 47h, 45h, 0EBh, 0E9h, 0Bh, 0EDh
	db	75h, 7, 26h, 0C7h, 5, 30h, 0, 47h, 45h, 8Bh, 0DDh, 2Bh, 0FBh, 4Bh
	db	7Eh, 11h, 26h, 8Ah, 5, 26h, 8Ah, 21h, 26h, 88h, 25h, 26h, 88h
	db	1, 'GKK', 0EBh, 0EDh, 0C3h, 0Bh, 0D2h, 79h, 0Fh, 26h, 0C6h, 5
	db	2Dh, 47h, 0F7h, 0D2h, 0F7h, 0D0h, 5, 1, 0, 83h, 0D2h, 0, 0EBh
	db	0AAh, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 0C4h, 46h, 0Ah, 8Ch, 0C2h
	db	0C4h, 7Eh, 6, 0E8h, 99h, 0FFh, 1Fh, '_^]', 0CAh, 8, 0, 55h, 8Bh
	db	0ECh, 56h, 57h, 1Eh, 0C4h, 46h, 0Ah, 8Ch, 0C2h, 0C4h, 7Eh, 6, 0E8h
	db	0C2h, 0FFh, 1Fh, '_^]', 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh
	db	33h, 0D2h, 0C4h, 7Eh, 6, 8Bh, 46h, 0Ah, 0E8h, 69h, 0FFh, 1Fh, '_^]'
	db	0CAh, 6, 0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 0C4h, 7Eh, 6, 8Bh, 46h
	db	0Ah, 99h, 0E8h, 93h, 0FFh, 1Fh, '_^]', 0CAh, 6, 0, 55h, 8Bh, 0ECh
	db	56h, 57h, 0C4h, 7Eh, 0Ah, 8Bh, 4Eh, 6, 8Ah, 46h, 8, 8Ah, 0E0h
	db	0FCh, 0F7h, 0C7h, 1, 0, 74h, 4, 0E3h, 9, 0AAh, 49h
Y0AEC0	ends

Y0B150	segment para public 'CODE'
	assume	cs:Y0B150
	db	0D1h, 0E9h, 0F3h, 0ABh, 73h, 1, 0AAh, 8Bh, 56h, 0Ch, 8Bh, 46h	;@0B150
	db	0Ah, '_^]', 0CAh, 8, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 33h, 0C0h
	db	50h, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 0Ch, 0, 6Fh, 1, 83h, 0C4h
	db	6, 3Dh, 0FFh, 0FFh, 74h, 3, 0E9h, 0E7h, 0, 1Eh, 0B8h, 0AEh, 5Ch
	db	50h, 9Ah, 8, 0, 0DFh, 1, 89h, 56h, 0FEh, 89h, 46h, 0FCh, 0Bh, 0C2h
	db	75h, 3, 0E9h, 0CAh, 0, 0C4h, 5Eh, 0FCh, 8Ch, 46h, 0FAh, 89h, 5Eh
	db	0F8h, 0EBh, 3, 0FFh, 46h, 0F8h, 0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh
	db	0, 74h, 6, 26h, 80h, '?;u', 0EEh, 1Eh, 0B8h, 0EAh, 8Dh, 50h, 0FFh
	db	76h, 0FEh, 0FFh, 76h, 0FCh, 8Bh, 46h, 0F8h, 33h, 0D2h, 2Bh, 46h
	db	0FCh, 83h, 0DAh, 0, 50h, 9Ah, 3, 0, 0EFh, 2, 8Bh, 46h, 0F8h, 33h
	db	0D2h, 2Bh, 46h, 0FCh, 83h, 0DAh, 0, 8Bh, 0D8h, 0C6h, 87h, 0EAh
	db	8Dh, 0, 0C4h, 5Eh, 0F8h, 43h, 8Ch, 46h, 0FEh, 89h, 5Eh, 0FCh, 1Eh
	db	0B8h, 0EAh, 8Dh, 50h, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0D8h, 81h, 0C3h
	db	0E9h, 8Dh, 8Ch, 0D8h, 8Eh, 0C0h, 8Ch, 46h, 0FAh, 89h, 5Eh, 0F8h
	db	0B8h, 0EAh, 8Dh, 8Ch, 0DAh, 3Bh, 0C3h, 's!&', 80h, '?:t', 1Bh
	db	26h, 80h, '?/t', 15h, 26h, 80h, '?\t', 0Fh, 1Eh, 0B8h, 0EAh, 8Dh
	db	50h, 1Eh, 0B8h, 0B3h, 5Ch, 50h, 9Ah, 8, 0
Y0B150	ends

Y0B230	segment para public 'CODE'
	assume	cs:Y0B230
	db	0FFh, 2, 1Eh, 0B8h, 0EAh, 8Dh, 50h, 0FFh, 76h, 8, 0FFh, 76h, 6	;@0B230
	db	9Ah, 8, 0, 0FFh, 2, 33h, 0C0h, 50h, 1Eh, 0B8h, 0EAh, 8Dh, 50h
	db	9Ah, 0Ch, 0, 6Fh, 1, 83h, 0C4h, 6, 3Dh, 0FFh, 0FFh, 75h, 22h, 0C4h
	db	5Eh, 0FCh, 26h, 80h, 3Fh, 0, 74h, 3
Y0B230	ends

Y0B260	segment para public 'CODE'
	assume	cs:Y0B260
	db	0E9h, 36h, 0FFh, 33h, 0D2h, 8Bh, 0C2h, 0EBh, 15h, 1Eh, 0B8h, 0EAh	;@0B260
	db	8Dh, 50h, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 4, 0, 0DFh, 2, 0B8h
	db	0EAh, 8Dh, 8Ch, 0DAh, 8Bh, 0E5h, 5Dh, 0CAh, 4, 0, 55h, 8Bh, 0ECh
	db	0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 0FFh
	db	76h, 8, 0FFh, 76h, 6, 9Ah, 4, 0, 5Fh, 2, 40h, 50h, 9Ah, 3, 0, 0EFh
	db	2, 8Bh, 56h, 0Ch, 8Bh, 46h, 0Ah, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh
	db	56h, 57h, 8Bh, 7Eh, 6, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 9Ah, 4, 0
	db	5Fh, 2, 8Bh, 0F0h, 3Bh, 0F7h, 76h, 2, 8Bh, 0F7h, 0FFh, 76h, 0Eh
	db	0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 56h, 9Ah, 3, 0, 0EFh
	db	2, 3Bh, 0F7h, 73h, 17h, 8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, 3, 0C6h
	db	'RP3', 0C0h, 50h, 8Bh, 0C7h, 2Bh, 0C6h, 50h, 9Ah, 5, 0, 0BFh, 2
	db	8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, '_^]', 0CAh, 0Ah, 0, 55h, 8Bh, 0ECh
	db	56h, 57h, 1Eh, 8Bh, 56h, 0Ah, 8Bh, 46h, 8, 3Bh, 56h, 0Eh, 77h
	db	0Dh, 72h, 5, 3Bh, 46h, 0Ch, 73h, 6, 0FDh, 0B8h, 1, 0, 0EBh, 3
	db	0FCh, 33h, 0C0h, 0C5h, 76h, 8, 0C4h, 7Eh, 0Ch, 8Bh, 4Eh, 6, 0Bh
	db	0C0h, 74h, 6, 3, 0F1h, 4Eh, 3, 0F9h, 4Fh, 0F7h, 0C7h, 1, 0, 74h
	db	4, 0E3h, 11h, 0A4h, 49h, 2Bh, 0F0h, 2Bh, 0F8h, 0D1h, 0E9h, 0F3h
	db	0A5h, 73h, 5, 3, 0F0h, 3, 0F8h, 0A4h, 0FCh, 1Fh, '_^]', 0CAh, 0Ah
	db	0, 55h, 8Bh, 0ECh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 9Ah, 4, 0, 5Fh
	db	2, 8Bh, 4Eh, 0Ch, 8Bh, 5Eh, 0Ah, 3, 0D8h, 51h, 53h, 0FFh, 76h
	db	8, 0FFh, 76h, 6, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 4, 0, 5Fh
Y0B260	ends

Y0B380	segment para public 'CODE'
	assume	cs:Y0B380
	db	2, 40h, 50h, 9Ah, 3, 0, 0EFh, 2, 8Bh, 56h, 0Ch, 8Bh, 46h, 0Ah	;@0B380
	db	5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h, 0FFh, 76h, 0Eh, 0FFh
	db	76h, 0Ch, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0F8h, 0FFh, 76h, 0Ah, 0FFh, 76h
	db	8, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0F0h, 3Bh, 76h, 6, 76h, 3, 8Bh, 76h
	db	6, 8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, 3, 0C7h, 52h, 50h, 0FFh, 76h
	db	0Ah, 0FFh, 76h, 8, 56h, 9Ah, 3, 0, 0EFh, 2, 8Bh, 0C7h, 3, 0C6h
	db	0C4h, 5Eh, 0Ch, 3, 0D8h, 26h, 0C6h, 7, 0, 8Bh, 56h, 0Eh, 8Bh, 46h
	db	0Ch, '_^]', 0CAh, 0Ah, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK', 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y0B380	ends

Y0B400	segment para public 'CODE'
	assume	cs:Y0B400
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh	;@0B400
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0B400	ends

Y0B450	segment para public 'CODE'
	assume	cs:Y0B450
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0B450
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0A0h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h
	db	0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h
	db	0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0
	db	0
Y0B450	ends

Y0B4F0	segment para public 'CODE'
	assume	cs:Y0B4F0
	db	0, 0, 0E9h, 4Eh, 3Fh, 0, 16h, 52h, 84h, 'Q6R', 16h, 'R-R', 0Eh	;@0B4F0
	db	50h, 0CFh, 4Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80h, 2, 1Fh
	db	0, 0Ch, 0, 8Fh, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK FAKE', 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1Fh, 0, 18h, 4, 1, 0, 0, 0, 2Fh
	db	0, 3Fh, 5, 1, 0, 8, 0, 3Fh, 0, 76h, 52h, 1, 0, 0Fh, 0, 4Fh, 0
	db	0E0h, 0, 1, 0, 6, 0, 5Fh, 0, 0DFh, 1, 1, 0, 0, 0, 6Fh, 0, 0D4h
	db	1, 1, 0, 0Fh, 0, 7Fh, 0, 5Bh, 1, 1, 0, 4, 0, 8Fh, 0, 0E6h, 17h
	db	1, 0, 0Bh, 0, 9Fh, 0, 0BDh, 1Fh, 1, 0, 6, 0, 0AFh, 0, 0A6h, 6
	db	1, 0, 0Dh, 0, 0BFh, 0, 78h, 0, 1, 0, 6, 0, 0CFh, 0, 0D8h, 1, 1
	db	0, 8, 0, 0DFh, 0, 0CEh, 1, 1, 0, 8, 0, 0EFh, 0, 8Ah, 0, 1, 0, 0Eh
	db	0
Y0B4F0	ends

Y0B6A0	segment para public 'CODE'
	assume	cs:Y0B6A0
	db	0FFh, 0, 2Bh, 1, 1, 0, 0Ah, 0, 0Fh, 1, 0B5h, 0, 1, 0, 0Bh, 0, 1Fh	;@0B6A0
	db	1, 61h, 0, 1, 0, 5, 0, 3Fh, 1, 0Dh, 0, 1, 0, 1, 0
Y0B6A0	ends
	end
