	.286p
	locals
	public	S46C_START
	extrn	S32C_START:byte
	extrn	L052FB:far
	extrn	L05AD7:far
	extrn	L063F9:far
	extrn	L06BC9:far
	extrn	S6BE_START:byte
	extrn	L06C45:far

S46C	segment para public 'CODE'
	assume	cs:S46C
S46C_START	db	100h dup (0)	;@046C0
S46C	ends

S47C	segment para public 'CODE'
	assume	cs:S47C
	db	20h dup (0)	;@047C0
S47C	ends

S438	segment byte public 'CODE'
	assume	cs:S438
	db	0Eh, 0, 1Eh, 0B8h, 14h, 0Fh, 50h, 0B8h, 8, 0, 50h, 33h, 0C0h, 50h, 0FFh, 74h	;@0438C
	db	1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 6, 0, 9Ah
	dd	L052FB
	db	83h, 0C4h, 0Eh, 0C4h, 6, 18h, 0Fh, 0A3h, 0Ch, 0Fh, 8Ch, 6, 0Eh, 0Fh, 0C7h, 6
	db	0Eh, 0, 0, 0, 0C7h, 6, 1Ah, 0
	dw	S47C
	db	0C7h, 6, 12h, 0, 4Ah, 6, 0C7h, 6, 16h, 0
	dw	seg S32C_START
	db	0C7h, 6, 26h, 0, 6Ch, 6, 0C7h, 6, 2Ah, 0
	dw	seg S32C_START
	db	0C3h, 0BEh, 0Eh, 0, 1Eh, 0B8h, 8Ch, 0Dh, 50h, 0FFh, 74h, 8, 33h, 0C0h, 50h, 0FFh
	db	74h, 1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 6, 0, 9Ah
	dd	L052FB
	db	83h, 0C4h, 0Eh, 0BEh, 0Eh, 0, 68h
	dw	S46C
	db	0B8h, 80h, 0, 50h, 0FFh, 74h, 0Ch, 33h, 0DBh, 53h, 50h, 0FFh, 74h, 18h, 0FFh, 36h
	db	6, 0, 9Ah
	dd	L052FB
	db	83h, 0C4h, 0Eh, 1Eh, 0B8h, 8Ch, 0Dh, 50h, 0Eh, 0E8h, 0AFh, 0, 90h, 0A3h, 0Eh, 0
	db	0C3h, 0Eh, 0E8h, 0ABh, 1, 90h, 0A3h, 0Eh, 0, 9Ah
	dd	L05AD7
	db	0C3h, 0Eh, 0E8h, 4Bh, 1, 90h, 0A3h, 0Eh, 0, 0C3h, 0Eh, 0E8h, 14h, 2, 90h, 0C3h
	db	0C7h, 6, 0Eh, 0, 0E4h, 0, 0C7h, 6, 1Ah, 0
	dw	seg S6BE_START
	db	0C3h, 0A1h, 0Eh, 0, 0FFh, 36h, 1Ah, 0, 0FFh, 36h, 16h, 0, 8Bh, 0DCh, 36h, 0FFh
	db	1Fh, 83h, 0C4h, 4, 0A3h, 0Eh, 0, 0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Eh, 6
	db	0Ah, 0, 0BFh, 81h, 0, 0C5h, 76h, 6, 33h, 0C9h, 0FCh, 0ACh, 0Ah, 0C0h, 74h, 7
	db	0AAh, 41h, 83h, 0F9h, 7Eh, 7Ch, 0F4h, 0B0h, 0Dh, 0AAh, 26h, 88h, 0Eh, 80h, 0, 6
	db	1Fh, 0BEh, 81h, 0, 0BFh, 5Ch, 0, 0B8h, 1, 29h, 0CDh, 21h, 0BFh, 6Ch, 0, 0B8h
	db	1, 29h, 0CDh, 21h, 1Fh, 5Fh, 5Eh, 5Dh, 0CAh, 4, 0, 8Eh, 6, 0Ah, 0, 26h
	db	0A1h, 2Eh, 0, 0A3h, 7Ah, 0Dh, 26h, 0A1h, 30h, 0, 0A3h, 7Ch, 0Dh, 0C3h, 8Eh, 6
	db	0Ah, 0, 0A1h, 7Ah, 0Dh, 26h, 0A3h, 2Eh, 0, 0A1h, 7Ch, 0Dh, 26h, 0A3h, 30h, 0
	db	0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 0B4h, 51h, 0CDh, 21h, 89h, 1Eh, 12h, 0Fh, 0BBh
	dw	S46C
	db	0B4h, 50h, 0CDh, 21h, 0BBh, 60h, 0Dh, 1Eh, 7, 8Bh, 0FBh, 0BAh
	dw	S46C
	db	0FCh, 0A1h, 0Ch, 0, 0ABh, 0B8h, 80h, 0, 0ABh, 8Bh, 0C2h, 0ABh, 0B8h, 5Ch, 0, 0ABh
	db	8Bh, 0C2h, 0ABh, 0B8h, 6Ch, 0, 0ABh, 8Bh, 0C2h, 0ABh, 0FFh, 36h, 2Eh, 0, 0FFh, 36h
	db	30h, 0, 89h, 26h, 76h, 0Dh, 8Ch, 16h, 78h, 0Dh, 0BCh, 0Ch, 0Fh, 0C5h, 56h, 6
	db	0B8h, 1, 4Bh, 0CDh, 21h, 0BAh
	dw	seg S32C_START
	db	8Eh, 0DAh, 0FAh, 8Eh, 16h, 78h, 0Dh, 8Bh, 26h, 76h, 0Dh, 0FBh, 9Ch, 50h, 0B4h, 30h
	db	0CDh, 21h, 86h, 0C4h, 3Dh, 0Ah, 2, 7Dh, 13h, 0B8h
	dw	S46C
	db	8Eh, 0C0h, 0A1h, 2Eh, 0, 26h, 0A3h, 2Eh, 0, 0A1h, 30h, 0, 26h, 0A3h, 30h, 0
	db	58h, 9Dh, 8Fh, 6, 30h, 0, 8Fh, 6, 2Eh, 0, 72h, 0Dh, 83h, 6, 6Eh, 0Dh
	db	2, 0E8h, 44h, 0FFh, 0B8h, 0, 0, 0EBh, 12h, 92h, 0B8h, 0FEh, 0FFh, 80h, 0FAh, 2
	db	74h, 9, 0B0h, 0FCh, 80h, 0FAh, 8, 74h, 2, 0B0h, 0FAh, 5Fh, 5Eh, 5Dh, 0CAh, 4
	db	0, 55h, 8Bh, 0ECh, 56h, 57h, 0B4h, 51h, 0CDh, 21h, 0E8h, 2Eh, 0FFh, 8Ch, 16h, 78h
	db	0Dh, 89h, 26h, 76h, 0Dh, 0FAh, 8Eh, 16h, 70h, 0Dh, 8Bh, 26h, 6Eh, 0Dh, 0FBh, 0C4h
	db	6, 72h, 0Dh, 6, 50h, 8Eh, 0DBh, 8Eh, 0C3h, 0C7h, 6, 0Ah, 0, 3Ah, 2, 8Ch
	db	0Eh, 0Ch, 0, 0CBh, 0B8h
	dw	seg S32C_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 16h, 78h, 0Dh, 8Bh, 26h, 76h, 0Dh, 0FBh, 8Bh, 1Eh, 0Ah, 0
	db	0B4h, 50h, 0CDh, 21h, 0B4h, 4Dh, 0CDh, 21h, 5Fh, 5Eh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 56h
	db	57h, 0B4h, 51h, 0CDh, 21h, 89h, 1Eh, 5Eh, 0Dh, 0C4h, 3Eh, 66h, 6, 0FCh, 33h, 0C0h
	db	0B9h, 7, 0, 0F3h, 0ABh, 8Bh, 0C3h, 0ABh, 0ABh, 0A1h, 72h, 0Dh, 0ABh, 0A1h, 74h, 0Dh
	db	0ABh, 9Ch, 58h, 0ABh, 0A1h, 6Eh, 0Dh, 0ABh, 0A1h, 70h, 0Dh, 0ABh, 8Eh, 0C3h, 26h, 0C7h
	db	6, 0Ah, 0, 0B5h, 2, 26h, 8Ch, 0Eh, 0Ch, 0, 53h, 9Ah
	dd	L06C45
	db	8Bh, 1Eh, 0Ah, 0, 0B4h, 50h, 0CDh, 21h, 0C7h, 6, 10h, 0Fh, 2, 0, 0A1h, 5Eh
	db	0Dh, 5, 10h, 0, 5Fh, 5Eh, 5Dh, 0CBh, 0B8h
	dw	seg S32C_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 0D0h, 8Bh, 26h, 0Ch, 0Fh, 0FBh, 8Bh, 1Eh, 0Ah, 0, 0B4h, 50h
	db	0CDh, 21h, 0B4h, 4Dh, 0CDh, 21h, 50h, 33h, 0C0h, 0A3h, 5Eh, 0Dh, 9Ah
	dd	L063F9
	db	55h, 8Bh, 0ECh, 56h, 57h, 8Bh, 1Eh, 5Eh, 0Dh, 0Bh, 0DBh, 74h, 45h, 0E8h, 58h, 0FEh
	db	55h, 8Ch, 16h, 78h, 0Dh, 89h, 26h, 76h, 0Dh, 8Eh, 0C3h, 26h, 0C7h, 6, 0Ah, 0
	db	9, 3, 26h, 8Ch, 0Eh, 0Ch, 0, 0B4h, 50h, 0CDh, 21h, 0B8h, 0, 4Ch, 0CDh, 21h
	db	0B8h
	dw	seg S32C_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 16h, 78h, 0Dh, 8Bh, 26h, 76h, 0Dh, 0FBh, 8Bh, 1Eh, 0Ah, 0
	db	0B4h, 50h, 0CDh, 21h, 5Dh, 9Ah
	dd	L06BC9
	db	33h, 0C0h, 0A3h, 5Eh, 0Dh, 0C7h, 6, 10h, 0Fh, 3, 0, 5Fh, 5Eh, 5Dh, 0CBh, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S438	ends

S736	segment byte public 'CODE'
	assume	cs:S736
	db	0, 11h, 6, 11h, 4, 0	;@07368
	dw	S438
S736	ends
	end
