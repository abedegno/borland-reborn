		public	X063_01
		public	X063_00
		public	X063_03
		public	X063_02
		public	X063_05
		public	X063_04
		extrn	X053_00:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d90_a8f5
; BEGIN C207UNIT (listing ovr_1d90_a8f5:8F50)

		extrn	X058_03:far
		extrn	X065_03:far
		extrn	X065_00:far
		extrn	X065_08:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M000_BCC_DATA_16EF	equ	16EFh
M000_BCC_DATA_16FF	equ	16FFh
M000_BCC_DATA_1706	equ	1706h
M000_BCC_DATA_1776	equ	1776h
M000_BCC_DATA_814C	equ	814Ch
M000_BCC_DATA_8680	equ	8680h
M000_BCC_DATA_86E6	equ	86E6h
M000_BCC_DATA_86E8	equ	86E8h
M000_BCC_DATA_86EA	equ	86EAh
M000_BCC_DATA_86F3	equ	86F3h
M000_BCC_DATA_86FB	equ	86FBh
M000_BCC_DATA_88AC	equ	88ACh
M000_BCC_DATA_88B5	equ	88B5h
M000_BCC_DATA_88B6	equ	88B6h

BCC_NEAR_8F50	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		test	word ptr DGROUP:M000_BCC_DATA_86F3,1
		je	short M000_L_8F63
		mov	AX,1
		jmp	short M000_L_8F8E
M000_L_8F63:
		cmp	word ptr DGROUP:M000_BCC_DATA_86E6,0
		jne	short M000_L_8F87
		cmp	word ptr DGROUP:M000_BCC_DATA_86E8,0
		jne	short M000_L_8F87
		test	word ptr DGROUP:M000_BCC_DATA_88AC,4
		jne	short M000_L_8F87
		cmp	byte ptr DGROUP:M000_BCC_DATA_88B5,0
		jne	short M000_L_8F87
		cmp	byte ptr DGROUP:M000_BCC_DATA_1706,0
		je	short M000_L_8F8C
M000_L_8F87:
		mov	AX,1
		jmp	short M000_L_8F8E
M000_L_8F8C:
		xor	AX,AX
M000_L_8F8E:
		or	AX,AX
		jne	short M000_L_8F95
		db	0E9h
		dw	0014Ch
M000_L_8F95:
		mov	word ptr DGROUP:M000_BCC_DATA_86EA,2
		test	word ptr DGROUP:M000_BCC_DATA_86F3,1
		je	short M000_L_8FAF
		mov	AX,59h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M000_L_8FAF:
		mov	AX,94h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,9Ch
		push	AX
		mov	AL,0Ah
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		test	word ptr DGROUP:M000_BCC_DATA_86F3,1
		je	short M000_L_9025
		cmp	byte ptr DGROUP:M000_BCC_DATA_1776,1
		je	short M000_L_9005
		cmp	byte ptr DGROUP:M000_BCC_DATA_1776,2
		je	short M000_L_9005
		cmp	byte ptr DGROUP:M000_BCC_DATA_1776,4
		je	short M000_L_9005
		cmp	byte ptr DGROUP:M000_BCC_DATA_1776,3
		jne	short M000_L_8FF6
		test	word ptr DGROUP:M000_BCC_DATA_86F3,80h
		jne	short M000_L_9005
M000_L_8FF6:
		cmp	byte ptr DGROUP:M000_BCC_DATA_1776,5
		jne	short M000_L_9025
		test	word ptr DGROUP:M000_BCC_DATA_86F3,80h
		je	short M000_L_9025
M000_L_9005:
		mov	AX,94h
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M000_BCC_DATA_88B6,2
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M000_L_9025:
		cmp	byte ptr DGROUP:M000_BCC_DATA_16FF,0
		jne	short M000_L_902F
		db	0E9h
		dw	00093h
M000_L_902F:
		cmp	byte ptr DGROUP:M000_BCC_DATA_16EF,1
		je	short M000_L_903D
		cmp	byte ptr DGROUP:M000_BCC_DATA_16EF,3
		jne	short M000_L_9042
M000_L_903D:
		mov	AX,5342h
		jmp	short M000_L_9045
M000_L_9042:
		mov	AX,534Ch
M000_L_9045:
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		mov	DI,AX
		mov	AX,9Ch
		push	AX
		mov	AL,0
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		test	word ptr DGROUP:M000_BCC_DATA_88AC,8
		je	short M000_L_9095
		mov	AX,77h
		push	AX
		push	DI
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	SI,AX
		mov	BX,SI
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,77h
		push	AX
		push	SI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M000_L_90D9
M000_L_9095:
		mov	AX,78h
		push	AX
		push	DI
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	SI,AX
		mov	BX,SI
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,78h
		push	AX
		push	SI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M000_L_90D9
M000_L_90C2:
		cmp	word ptr DGROUP:M000_BCC_DATA_86E6,0
		je	short M000_L_90D9
		mov	AX,28h
		push	AX
		mov	AL,0Bh
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
M000_L_90D9:
		or	word ptr DGROUP:M000_BCC_DATA_86F3,100h
		jmp	short M000_L_90E7
M000_L_90E1:
		and	word ptr DGROUP:M000_BCC_DATA_86F3,0FEFFh
M000_L_90E7:
		test	word ptr DGROUP:M000_BCC_DATA_86FB,100h
		je	short M000_L_9100
		mov	AX,94h
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M000_BCC_DATA_88B6,2
M000_L_9100:
		test	word ptr DGROUP:M000_BCC_DATA_86FB,200h
		je	short M000_L_9119
		mov	AX,94h
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M000_BCC_DATA_88B6,2
M000_L_9119:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret
BCC_NEAR_8F50	endp
CO063_TEXT	ends


		extrn	X065_02:far
		extrn	X065_00:far
		extrn	X065_08:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M001_BCC_DATA_1700	equ	1700h
M001_BCC_DATA_1714	equ	1714h
M001_BCC_DATA_1776	equ	1776h
M001_BCC_DATA_80D8	equ	80D8h
M001_BCC_DATA_8138	equ	8138h
M001_BCC_DATA_86D4	equ	86D4h
M001_BCC_DATA_86E6	equ	86E6h
M001_BCC_DATA_86EA	equ	86EAh
M001_BCC_DATA_86EC	equ	86ECh
M001_BCC_DATA_86F3	equ	86F3h
M001_BCC_DATA_86FB	equ	86FBh
M001_BCC_DATA_8800	equ	8800h

BCC_NEAR_911E	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		test	word ptr DGROUP:M001_BCC_DATA_86F3,1
		je	short M001_L_918F
		mov	AL,DGROUP:M001_BCC_DATA_1776
		cbw
		dec	AX
		mov	BX,AX
		cmp	BX,4
		ja	short M001_L_918F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	366h
		test	word ptr DGROUP:M001_BCC_DATA_86F3,80h
		je	short M001_L_918F
		mov	AX,9Ch
		push	AX
		mov	AL,0
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		jmp	short M001_L_918F
		mov	AL,0
		push	AX
		db	0FFh,01Eh
		dw	8800h
		jmp	short M001_L_918F
		mov	AX,9Ch
		push	AX
		mov	AL,0
		push	AX
		mov	AL,0Fh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		jmp	short M001_L_918F
		test	word ptr DGROUP:M001_BCC_DATA_86F3,80h
		je	short M001_L_918F
		mov	AL,0
		push	AX
		db	0FFh,01Eh
		dw	8800h
M001_L_918F:
		test	word ptr DGROUP:M001_BCC_DATA_86F3,10h
		jne	short M001_L_919A
		db	0E9h
		dw	000E0h
M001_L_919A:
		test	word ptr DGROUP:M001_BCC_DATA_86F3,1
		je	short M001_L_91AA
		mov	word ptr DGROUP:M001_BCC_DATA_86EA,14h
		jmp	short M001_L_91B0
M001_L_91AA:
		mov	word ptr DGROUP:M001_BCC_DATA_86EA,12h
M001_L_91B0:
		or	word ptr DGROUP:M001_BCC_DATA_86FB,300h
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		test	word ptr DGROUP:M001_BCC_DATA_86F3,2
		je	short M001_L_924C
		mov	AL,0Ah
		push	AX
		db	0FFh,01Eh
		dw	8800h
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M001_L_924C:
		mov	AX,9Ch
		push	AX
		mov	AL,0Ah
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		cmp	word ptr DGROUP:M001_BCC_DATA_86E6,0
		je	short M001_L_9272
		mov	AX,28h
		push	AX
		mov	AL,0Bh
		push	AX
		push	word ptr DGROUP:M001_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
M001_L_9272:
		or	word ptr DGROUP:M001_BCC_DATA_86F3,100h
		jmp	short M001_L_927D
M001_L_927A:
		db	0E8h
		dw	0FCD3h
M001_L_927D:
		db	09Ah
		dw	0020h
		dw	seg X053_00 + 90h
		cmp	word ptr DGROUP:M001_BCC_DATA_86EC,0
		je	short M001_L_92A3
		nop
		push	CS
		db	0E8h
		dw	00BD1h
		cmp	byte ptr DGROUP:M001_BCC_DATA_1700,0
		je	short M001_L_92A0
		cmp	byte ptr DGROUP:M001_BCC_DATA_1714,0
		je	short M001_L_92A0
		db	0FFh,01Eh
		dw	80D8h
M001_L_92A0:
		db	0E8h
		dw	00CC0h
M001_L_92A3:
		test	word ptr DGROUP:M001_BCC_DATA_86F3,100h
		je	short M001_L_92B3
		push	word ptr DGROUP:M001_BCC_DATA_86D4
		db	0FFh,01Eh
		dw	8138h
M001_L_92B3:
		pop	BP
		dec	BP
		ret
BCC_NEAR_911E	endp
CO063_TEXT	ends

CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT

BCC_TABLE_92B6	label	word
		dw	001F5h
		dw	0020Eh
		dw	001EDh
		dw	00217h
		dw	00230h

CO063_TEXT	ends

		extrn	X062_00:far
		extrn	X065_09:far
		extrn	X065_02:far
		extrn	X065_00:far
		extrn	X065_06:far
		extrn	X065_08:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M003_BCC_DATA_1776	equ	1776h
M003_BCC_DATA_815C	equ	815Ch
M003_BCC_DATA_8164	equ	8164h
M003_BCC_DATA_86E6	equ	86E6h
M003_BCC_DATA_86E8	equ	86E8h
M003_BCC_DATA_86EA	equ	86EAh
M003_BCC_DATA_86EE	equ	86EEh
M003_BCC_DATA_86F2	equ	86F2h
M003_BCC_DATA_86F3	equ	86F3h
M003_BCC_DATA_86FB	equ	86FBh

BCC_NEAR_92C0	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		test	word ptr DGROUP:M003_BCC_DATA_86F3,10h
		jne	short M003_L_92D1
		db	0E9h
		dw	0014Bh
M003_L_92D1:
		mov	SI,1
		push	word ptr DGROUP:M003_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	815Ch
		mov	AH,0
		sub	AX,7
		mov	BX,AX
		cmp	BX,0Dh
		ja	short M003_L_931F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	5CBh
		push	word ptr DGROUP:M003_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	8164h
		mov	DI,AX
		cmp	DI,4
		ja	short M003_L_9309
		cmp	DI,2
		jbe	short M003_L_9309
		db	081h,0CEh,4,0
		jmp	short M003_L_931F
M003_L_9309:
		test	word ptr DGROUP:M003_BCC_DATA_86F3,1
		je	short M003_L_931F
		db	081h,0CEh,4,0
		jmp	short M003_L_931F
		db	081h,0CEh,4,0
		jmp	short M003_L_931F
		xor	SI,SI
M003_L_931F:
		or	SI,SI
		je	short M003_L_934E
		mov	AX,9Ch
		push	AX
		mov	AX,DGROUP:M003_BCC_DATA_86EA
		dec	AX
		dec	AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_09
		dw	seg X065_09
		test	SI,4
		je	short M003_L_934E
		mov	AX,9Ch
		push	AX
		mov	AX,DGROUP:M003_BCC_DATA_86EA
		sub	AX,4
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_09
		dw	seg X065_09
M003_L_934E:
		cmp	word ptr DGROUP:M003_BCC_DATA_86E6,0
		je	short M003_L_9364
		mov	AX,9Ch
		push	AX
		mov	AL,0Bh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M003_L_9364:
		mov	AX,7Fh
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		test	word ptr DGROUP:M003_BCC_DATA_86F3,1
		je	short M003_L_93E9
		mov	AX,0A1h
		jmp	short M003_L_93EC
M003_L_93E9:
		mov	AX,0A2h
M003_L_93EC:
		mov	DI,AX
		cmp	byte ptr DGROUP:M003_BCC_DATA_86F2,2
		je	short M003_L_93FC
		cmp	byte ptr DGROUP:M003_BCC_DATA_86F2,3
		jne	short M003_L_9413
M003_L_93FC:
		cmp	word ptr DGROUP:M003_BCC_DATA_86E8,0
		je	short M003_L_9413
		push	DI
		mov	AL,0Eh
		push	AX
		push	word ptr DGROUP:M003_BCC_DATA_86E8
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		db	0E9h
		dw	00103h
M003_L_9413:
		push	DI
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		db	0E9h
		dw	000FAh
M003_L_941C:
		test	word ptr DGROUP:M003_BCC_DATA_86F3,1
		je	short M003_L_9429
		mov	AX,0A1h
		jmp	short M003_L_942C
M003_L_9429:
		mov	AX,0A2h
M003_L_942C:
		mov	SI,AX
		test	word ptr DGROUP:M003_BCC_DATA_86FB,200h
		je	short M003_L_9442
		mov	AX,7Fh
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M003_L_9442:
		test	word ptr DGROUP:M003_BCC_DATA_86FB,100h
		je	short M003_L_9456
		mov	AX,7Fh
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M003_L_9456:
		test	word ptr DGROUP:M003_BCC_DATA_86F3,1
		je	short M003_L_94BA
		cmp	byte ptr DGROUP:M003_BCC_DATA_1776,1
		je	short M003_L_9491
		cmp	byte ptr DGROUP:M003_BCC_DATA_1776,2
		je	short M003_L_9491
		cmp	byte ptr DGROUP:M003_BCC_DATA_1776,4
		je	short M003_L_9491
		cmp	byte ptr DGROUP:M003_BCC_DATA_1776,3
		jne	short M003_L_9482
		test	word ptr DGROUP:M003_BCC_DATA_86F3,80h
		jne	short M003_L_9491
M003_L_9482:
		cmp	byte ptr DGROUP:M003_BCC_DATA_1776,5
		jne	short M003_L_94BA
		test	word ptr DGROUP:M003_BCC_DATA_86F3,80h
		je	short M003_L_94BA
M003_L_9491:
		cmp	word ptr DGROUP:M003_BCC_DATA_86E6,0
		je	short M003_L_94A8
		mov	AX,95h
		push	AX
		mov	AL,0Bh
		push	AX
		mov	AX,0FFFEh
		push	AX
		db	09Ah
		dw	X065_06
		dw	seg X065_06
M003_L_94A8:
		mov	AX,7Fh
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	word ptr DGROUP:M003_BCC_DATA_86E6,0
M003_L_94BA:
		push	word ptr DGROUP:M003_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	815Ch
		mov	AH,0
		mov	BX,AX
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		and	AX,2
		push	AX
		db	09Ah
		dw	X062_00
		dw	seg X062_00
		db	0E8h
		dw	0043Dh
		test	word ptr DGROUP:M003_BCC_DATA_86F3,1
		je	short M003_L_94EC
		mov	AX,5Bh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M003_L_94EC:
		cmp	byte ptr DGROUP:M003_BCC_DATA_86F2,2
		je	short M003_L_94FA
		cmp	byte ptr DGROUP:M003_BCC_DATA_86F2,3
		jne	short M003_L_9510
M003_L_94FA:
		cmp	word ptr DGROUP:M003_BCC_DATA_86E8,0
		je	short M003_L_9510
		push	SI
		mov	AL,0Eh
		push	AX
		push	word ptr DGROUP:M003_BCC_DATA_86E8
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		jmp	short M003_L_9516
M003_L_9510:
		push	SI
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M003_L_9516:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret
BCC_NEAR_92C0	endp
CO063_TEXT	ends

CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT

BCC_TABLE_951B	label	word
		dw	003C7h
		dw	003C7h
		dw	003CDh
		dw	003CDh
		dw	003CDh
		dw	003CDh
		dw	003CFh
		dw	003CFh
		dw	003C7h
		dw	003C7h
		dw	003CFh
		dw	003CFh
		dw	0039Fh
		dw	0039Fh

CO063_TEXT	ends

		extrn	X065_00:far
		extrn	X065_08:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M005_BCC_DATA_16EF	equ	16EFh
M005_BCC_DATA_16F0	equ	16F0h
M005_BCC_DATA_1700	equ	1700h
M005_BCC_DATA_1701	equ	1701h
M005_BCC_DATA_1702	equ	1702h
M005_BCC_DATA_1706	equ	1706h
M005_BCC_DATA_1709	equ	1709h
M005_BCC_DATA_1714	equ	1714h
M005_BCC_DATA_1776	equ	1776h
M005_BCC_DATA_80D8	equ	80D8h
M005_BCC_DATA_8138	equ	8138h
M005_BCC_DATA_86D4	equ	86D4h
M005_BCC_DATA_86D8	equ	86D8h
M005_BCC_DATA_86DA	equ	86DAh
M005_BCC_DATA_86E6	equ	86E6h
M005_BCC_DATA_86E8	equ	86E8h
M005_BCC_DATA_86EA	equ	86EAh
M005_BCC_DATA_86EC	equ	86ECh
M005_BCC_DATA_86F2	equ	86F2h
M005_BCC_DATA_86F3	equ	86F3h
M005_BCC_DATA_86FB	equ	86FBh
M005_BCC_DATA_86FD	equ	86FDh
M005_BCC_DATA_87D0	equ	87D0h
M005_BCC_DATA_87F0	equ	87F0h
M005_BCC_DATA_87F8	equ	87F8h
M005_BCC_DATA_8800	equ	8800h
M005_BCC_DATA_88AC	equ	88ACh
M005_BCC_DATA_88B5	equ	88B5h
M005_BCC_DATA_88B6	equ	88B6h

		public	X063_01
X063_01	label	far
BCC_FAR_9537	proc	far
		push	BP
		mov	BP,SP
		cmp	byte ptr DGROUP:M005_BCC_DATA_1700,0
		jne	short M005_L_954F
		cmp	byte ptr DGROUP:M005_BCC_DATA_1701,0
		jne	short M005_L_954F
		cmp	byte ptr DGROUP:M005_BCC_DATA_1714,0
		je	short M005_L_955B
M005_L_954F:
		push	word ptr DGROUP:M005_BCC_DATA_86D8
		push	word ptr DGROUP:M005_BCC_DATA_86DA
		db	0FFh,01Eh
		dw	87F0h
M005_L_955B:
		mov	word ptr DGROUP:M005_BCC_DATA_88B6,0
		push	word ptr DGROUP:M005_BCC_DATA_86D4
		db	0FFh,01Eh
		dw	87D0h
		cmp	word ptr DGROUP:M005_BCC_DATA_86EC,0
		je	short M005_L_957B
		cmp	byte ptr DGROUP:M005_BCC_DATA_1700,0
		je	short M005_L_957B
		db	0FFh,01Eh
		dw	87F8h
M005_L_957B:
		mov	word ptr DGROUP:M005_BCC_DATA_86EA,0
		mov	AX,DGROUP:M005_BCC_DATA_86FD
		or	word ptr DGROUP:M005_BCC_DATA_86FB,AX
		cmp	byte ptr DGROUP:M005_BCC_DATA_1776,0
		je	short M005_L_959C
		cmp	byte ptr DGROUP:M005_BCC_DATA_86F2,4
		je	short M005_L_959C
		db	0E8h
		dw	0FB85h
		db	0E9h
		dw	00377h
M005_L_959C:
		cmp	byte ptr DGROUP:M005_BCC_DATA_86F2,4
		je	short M005_L_95A6
		db	0E9h
		dw	000DFh
M005_L_95A6:
		db	081h,00Eh,0F3h,086h,1,0
		mov	word ptr DGROUP:M005_BCC_DATA_86EA,12h
		or	word ptr DGROUP:M005_BCC_DATA_86FB,300h
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AL,0Ah
		push	AX
		db	0FFh,01Eh
		dw	8800h
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		jne	short M005_L_9656
		cmp	word ptr DGROUP:M005_BCC_DATA_86E8,0
		jne	short M005_L_9656
		cmp	byte ptr DGROUP:M005_BCC_DATA_88B5,0
		jne	short M005_L_9656
		cmp	byte ptr DGROUP:M005_BCC_DATA_1706,0
		je	short M005_L_9665
M005_L_9656:
		mov	AX,9Ch
		push	AX
		mov	AL,0Ah
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M005_L_9665:
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		je	short M005_L_967C
		mov	AX,28h
		push	AX
		mov	AL,0Bh
		push	AX
		push	word ptr DGROUP:M005_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
M005_L_967C:
		or	word ptr DGROUP:M005_BCC_DATA_86F3,100h
		db	0E9h
		dw	00258h
M005_L_9685:
		test	word ptr DGROUP:M005_BCC_DATA_86F3,10h
		jne	short M005_L_9690
		db	0E9h
		dw	000E1h
M005_L_9690:
		test	word ptr DGROUP:M005_BCC_DATA_86F3,1
		je	short M005_L_96A0
		mov	word ptr DGROUP:M005_BCC_DATA_86EA,14h
		jmp	short M005_L_96A6
M005_L_96A0:
		mov	word ptr DGROUP:M005_BCC_DATA_86EA,12h
M005_L_96A6:
		or	word ptr DGROUP:M005_BCC_DATA_86FB,300h
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,94h
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		test	word ptr DGROUP:M005_BCC_DATA_86F3,2
		je	short M005_L_9742
		mov	AL,0Ah
		push	AX
		db	0FFh,01Eh
		dw	8800h
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M005_L_9742:
		mov	AX,9Ch
		push	AX
		mov	AL,0Ah
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		je	short M005_L_9768
		mov	AX,28h
		push	AX
		mov	AL,0Bh
		push	AX
		push	word ptr DGROUP:M005_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
M005_L_9768:
		or	word ptr DGROUP:M005_BCC_DATA_86F3,100h
		db	0E9h
		dw	0016Ch
M005_L_9771:
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		jne	short M005_L_97A7
		cmp	word ptr DGROUP:M005_BCC_DATA_86E8,0
		jne	short M005_L_97A7
		test	word ptr DGROUP:M005_BCC_DATA_88AC,4
		jne	short M005_L_97A7
		cmp	byte ptr DGROUP:M005_BCC_DATA_88B5,0
		jne	short M005_L_97A7
		cmp	byte ptr DGROUP:M005_BCC_DATA_1709,0
		je	short M005_L_979D
		test	word ptr DGROUP:M005_BCC_DATA_86F3,1
		jne	short M005_L_97A7
M005_L_979D:
		cmp	byte ptr DGROUP:M005_BCC_DATA_1706,0
		jne	short M005_L_97A7
		db	0E9h
		dw	00090h
M005_L_97A7:
		mov	word ptr DGROUP:M005_BCC_DATA_86EA,2
		cmp	byte ptr DGROUP:M005_BCC_DATA_16F0,0
		je	short M005_L_97D3
		mov	AL,DGROUP:M005_BCC_DATA_1702
		cbw
		or	AX,AX
		jne	short M005_L_97D3
		mov	AL,DGROUP:M005_BCC_DATA_1709
		cbw
		or	AX,AX
		jne	short M005_L_97D3
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		jbe	short M005_L_97D3
		mov	AX,92h
		push	AX
		mov	AL,0Eh
		jmp	short M005_L_9825
M005_L_97D3:
		cmp	byte ptr DGROUP:M005_BCC_DATA_1709,1
		jne	short M005_L_97E2
		test	word ptr DGROUP:M005_BCC_DATA_86F3,40h
		jne	short M005_L_97F1
M005_L_97E2:
		cmp	byte ptr DGROUP:M005_BCC_DATA_1709,2
		jne	short M005_L_97FD
		test	word ptr DGROUP:M005_BCC_DATA_86F3,1
		je	short M005_L_97FD
M005_L_97F1:
		mov	AX,59h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M005_L_97FD:
		mov	AX,94h
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,9Ch
		push	AX
		mov	AL,0Ah
		push	AX
		mov	AL,0Bh
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		cmp	word ptr DGROUP:M005_BCC_DATA_86E6,0
		je	short M005_L_982F
		mov	AX,28h
		push	AX
		mov	AL,0Bh
M005_L_9825:
		push	AX
		push	word ptr DGROUP:M005_BCC_DATA_86E6
		db	09Ah
		dw	X065_08
		dw	seg X065_08
M005_L_982F:
		or	word ptr DGROUP:M005_BCC_DATA_86F3,100h
		jmp	short M005_L_983D
M005_L_9837:
		and	word ptr DGROUP:M005_BCC_DATA_86F3,0FEFFh
M005_L_983D:
		test	word ptr DGROUP:M005_BCC_DATA_86FB,100h
		je	short M005_L_9856
		mov	AX,94h
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M005_BCC_DATA_88B6,2
M005_L_9856:
		test	word ptr DGROUP:M005_BCC_DATA_86FB,200h
		je	short M005_L_986F
		mov	AX,94h
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M005_BCC_DATA_88B6,2
M005_L_986F:
		test	word ptr DGROUP:M005_BCC_DATA_86F3,2
		jne	short M005_L_987E
		cmp	byte ptr DGROUP:M005_BCC_DATA_16EF,5
		jne	short M005_L_98DD
M005_L_987E:
		mov	AX,94h
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		add	word ptr DGROUP:M005_BCC_DATA_88B6,2
		test	word ptr DGROUP:M005_BCC_DATA_86F3,20h
		je	short M005_L_98C7
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AL,0
		push	AX
		db	0FFh,01Eh
		dw	8800h
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		mov	AX,7Fh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		jmp	short M005_L_98DD
M005_L_98C7:
		mov	AL,0
		push	AX
		db	0FFh,01Eh
		dw	8800h
		mov	AX,9Ch
		push	AX
		mov	AL,0Dh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M005_L_98DD:
		db	09Ah
		dw	0020h
		dw	seg X053_00 + 90h
		cmp	word ptr DGROUP:M005_BCC_DATA_86EC,0
		je	short M005_L_9903
		nop
		push	CS
		db	0E8h
		dw	00571h
		cmp	byte ptr DGROUP:M005_BCC_DATA_1700,0
		je	short M005_L_9900
		cmp	byte ptr DGROUP:M005_BCC_DATA_1714,0
		je	short M005_L_9900
		db	0FFh,01Eh
		dw	80D8h
M005_L_9900:
		db	0E8h
		dw	00660h
M005_L_9903:
		test	word ptr DGROUP:M005_BCC_DATA_86F3,100h
		je	short M005_L_9913
		push	word ptr DGROUP:M005_BCC_DATA_86D4
		db	0FFh,01Eh
		dw	8138h
M005_L_9913:
		pop	BP
		retf
BCC_FAR_9537	endp
CO063_TEXT	ends


		extrn	X065_02:far
		extrn	X065_00:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M006_BCC_DATA_16F0	equ	16F0h
M006_BCC_DATA_86E6	equ	86E6h
M006_BCC_DATA_86F3	equ	86F3h

BCC_NEAR_9915	label	near
STAOV0D5	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		cmp	word ptr DGROUP:M006_BCC_DATA_86E6,0
		je	short M006_L_994F
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F0,0
		je	short M006_L_9932
		mov	AX,7Eh
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		jmp	short M006_L_9963
M006_L_9932:
		mov	AX,9Ch
		push	AX
		mov	AL,0Bh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		mov	AX,7Fh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		jmp	short M006_L_9963
M006_L_994F:
		test	word ptr DGROUP:M006_BCC_DATA_86F3,100h
		je	short M006_L_9963
		mov	AX,7Fh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M006_L_9963:
		pop	BP
		dec	BP
		ret
STAOV0D5	endp
CO063_TEXT	ends


		extrn	X062_00:far
		extrn	X065_09:far
		extrn	X065_02:far
		extrn	X065_00:far
		extrn	X065_08:far
		extrn	X065_0B:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M007_BCC_DATA_16EF	equ	16EFh
M007_BCC_DATA_1700	equ	1700h
M007_BCC_DATA_1701	equ	1701h
M007_BCC_DATA_1709	equ	1709h
M007_BCC_DATA_1714	equ	1714h
M007_BCC_DATA_1776	equ	1776h
M007_BCC_DATA_815C	equ	815Ch
M007_BCC_DATA_8164	equ	8164h
M007_BCC_DATA_86E6	equ	86E6h
M007_BCC_DATA_86E8	equ	86E8h
M007_BCC_DATA_86EA	equ	86EAh
M007_BCC_DATA_86EC	equ	86ECh
M007_BCC_DATA_86EE	equ	86EEh
M007_BCC_DATA_86F2	equ	86F2h
M007_BCC_DATA_86F3	equ	86F3h
M007_BCC_DATA_86FB	equ	86FBh
M007_BCC_DATA_87F0	equ	87F0h
M007_BCC_DATA_87FC	equ	87FCh
M007_BCC_DATA_8804	equ	8804h
M007_BCC_DATA_8B16	equ	8B16h

		public	X063_00
X063_00	label	far
STAOV0D6	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		cmp	byte ptr DGROUP:M007_BCC_DATA_1700,0
		jne	short M007_L_9980
		cmp	byte ptr DGROUP:M007_BCC_DATA_1701,0
		jne	short M007_L_9980
		cmp	byte ptr DGROUP:M007_BCC_DATA_1714,0
		je	short M007_L_998A
M007_L_9980:
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	0FFh,01Eh
		dw	87F0h
M007_L_998A:
		cmp	byte ptr DGROUP:M007_BCC_DATA_1776,0
		je	short M007_L_999E
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,4
		je	short M007_L_999E
		db	0E8h
		dw	0F925h
		db	0E9h
		dw	002BBh
M007_L_999E:
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,4
		je	short M007_L_99A8
		db	0E9h
		dw	00085h
M007_L_99A8:
		push	word ptr DGROUP:M007_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	815Ch
		mov	AH,0
		mov	BX,AX
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		and	AX,2
		push	AX
		db	09Ah
		dw	X062_00
		dw	seg X062_00
		db	0E8h
		dw	0FF4Fh
		mov	AX,7Fh
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,0A3h
		push	AX
		db	0E9h
		dw	00227h
M007_L_9A2D:
		test	word ptr DGROUP:M007_BCC_DATA_86F3,10h
		jne	short M007_L_9A38
		db	0E9h
		dw	0014Bh
M007_L_9A38:
		mov	SI,1
		push	word ptr DGROUP:M007_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	815Ch
		mov	AH,0
		sub	AX,7
		mov	BX,AX
		cmp	BX,0Dh
		ja	short M007_L_9A86
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D31h
		push	word ptr DGROUP:M007_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	8164h
		mov	DI,AX
		cmp	DI,4
		ja	short M007_L_9A70
		cmp	DI,2
		jbe	short M007_L_9A70
		db	081h,0CEh,4,0
		jmp	short M007_L_9A86
M007_L_9A70:
		test	word ptr DGROUP:M007_BCC_DATA_86F3,1
		je	short M007_L_9A86
		db	081h,0CEh,4,0
		jmp	short M007_L_9A86
		db	081h,0CEh,4,0
		jmp	short M007_L_9A86
		xor	SI,SI
M007_L_9A86:
		or	SI,SI
		je	short M007_L_9AB5
		mov	AX,9Ch
		push	AX
		mov	AX,DGROUP:M007_BCC_DATA_86EA
		dec	AX
		dec	AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_09
		dw	seg X065_09
		test	SI,4
		je	short M007_L_9AB5
		mov	AX,9Ch
		push	AX
		mov	AX,DGROUP:M007_BCC_DATA_86EA
		sub	AX,4
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_09
		dw	seg X065_09
M007_L_9AB5:
		cmp	word ptr DGROUP:M007_BCC_DATA_86E6,0
		je	short M007_L_9ACB
		mov	AX,9Ch
		push	AX
		mov	AL,0Bh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
M007_L_9ACB:
		mov	AX,7Fh
		push	AX
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,4
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,2
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,7Fh
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		test	word ptr DGROUP:M007_BCC_DATA_86F3,1
		je	short M007_L_9B50
		mov	AX,0A1h
		jmp	short M007_L_9B53
M007_L_9B50:
		mov	AX,0A2h
M007_L_9B53:
		mov	DI,AX
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,2
		je	short M007_L_9B63
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,3
		jne	short M007_L_9B7A
M007_L_9B63:
		cmp	word ptr DGROUP:M007_BCC_DATA_86E8,0
		je	short M007_L_9B7A
		push	DI
		mov	AL,0Eh
		push	AX
		push	word ptr DGROUP:M007_BCC_DATA_86E8
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		db	0E9h
		dw	000DFh
M007_L_9B7A:
		push	DI
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		db	0E9h
		dw	000D6h
M007_L_9B83:
		test	word ptr DGROUP:M007_BCC_DATA_86F3,2
		jne	short M007_L_9B92
		cmp	byte ptr DGROUP:M007_BCC_DATA_16EF,5
		jne	short M007_L_9B9E
M007_L_9B92:
		mov	AX,7Fh
		push	AX
		mov	AL,0Dh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M007_L_9B9E:
		test	word ptr DGROUP:M007_BCC_DATA_86FB,200h
		je	short M007_L_9BB2
		mov	AX,7Fh
		push	AX
		mov	AL,9
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M007_L_9BB2:
		test	word ptr DGROUP:M007_BCC_DATA_86FB,100h
		je	short M007_L_9BC6
		mov	AX,7Fh
		push	AX
		mov	AL,8
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M007_L_9BC6:
		push	word ptr DGROUP:M007_BCC_DATA_86EE
		db	0FFh,01Eh
		dw	815Ch
		mov	AH,0
		mov	BX,AX
		mov	AL,byte ptr [BX+9CAh]
		mov	AH,0
		and	AX,2
		push	AX
		db	09Ah
		dw	X062_00
		dw	seg X062_00
		db	0E8h
		dw	0FD31h
		cmp	word ptr DGROUP:M007_BCC_DATA_86E6,0
		jne	short M007_L_9BF3
		test	word ptr DGROUP:M007_BCC_DATA_86F3,100h
		je	short M007_L_9C1D
M007_L_9BF3:
		cmp	byte ptr DGROUP:M007_BCC_DATA_1709,1
		jne	short M007_L_9C02
		test	word ptr DGROUP:M007_BCC_DATA_86F3,40h
		jne	short M007_L_9C11
M007_L_9C02:
		cmp	byte ptr DGROUP:M007_BCC_DATA_1709,2
		jne	short M007_L_9C1D
		test	word ptr DGROUP:M007_BCC_DATA_86F3,1
		je	short M007_L_9C1D
M007_L_9C11:
		mov	AX,5Bh
		push	AX
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M007_L_9C1D:
		test	word ptr DGROUP:M007_BCC_DATA_86F3,1
		je	short M007_L_9C2A
		mov	AX,0A1h
		jmp	short M007_L_9C2D
M007_L_9C2A:
		mov	AX,0A2h
M007_L_9C2D:
		mov	SI,AX
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,2
		je	short M007_L_9C3D
		cmp	byte ptr DGROUP:M007_BCC_DATA_86F2,3
		jne	short M007_L_9C53
M007_L_9C3D:
		cmp	word ptr DGROUP:M007_BCC_DATA_86E8,0
		je	short M007_L_9C53
		push	SI
		mov	AL,0Eh
		push	AX
		push	word ptr DGROUP:M007_BCC_DATA_86E8
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		jmp	short M007_L_9C59
M007_L_9C53:
		push	SI
M007_L_9C54:
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M007_L_9C59:
		cmp	word ptr DGROUP:M007_BCC_DATA_86EC,0
		je	short M007_L_9C77
		cmp	byte ptr DGROUP:M007_BCC_DATA_1700,0
		je	short M007_L_9C77
		push	word ptr DGROUP:M007_BCC_DATA_8B16
		db	0FFh,01Eh
		dw	87FCh
		mov	AX,0FFFEh
		push	AX
		db	0FFh,01Eh
		dw	87FCh
M007_L_9C77:
		db	0FFh,01Eh
		dw	8804h
		pop	DI
		pop	SI
		pop	BP
		retf	4
STAOV0D6	endp
CO063_TEXT	ends

CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT

STOVT186	label	word
		dw	00B2Eh
		dw	00B2Eh
		dw	00B34h
		dw	00B34h
		dw	00B34h
		dw	00B34h
		dw	00B36h
		dw	00B36h
		dw	00B2Eh
		dw	00B2Eh
		dw	00B36h
		dw	00B36h
		dw	00B06h
		dw	00B06h

CO063_TEXT	ends

CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M009_BCC_DATA_8672	equ	8672h
M009_BCC_DATA_8674	equ	8674h
M009_BCC_DATA_88B5	equ	88B5h


		public	X063_05
X063_05	label	far
STAOV0D7	proc	far
		push	BP
		mov	BP,SP
		mov	word ptr DGROUP:M009_BCC_DATA_8674,0
		mov	word ptr DGROUP:M009_BCC_DATA_8672,2
		mov	byte ptr DGROUP:M009_BCC_DATA_88B5,0
		pop	BP
		retf
STAOV0D7	endp
CO063_TEXT	ends


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M00A_BCC_DATA_813C	equ	813Ch
M00A_BCC_DATA_8164	equ	8164h
M00A_BCC_DATA_8168	equ	8168h
M00A_BCC_DATA_8654	equ	8654h
M00A_BCC_DATA_866E	equ	866Eh
M00A_BCC_DATA_8672	equ	8672h
M00A_BCC_DATA_86E6	equ	86E6h


		public	X063_02
X063_02	label	far
STAOV0D8	proc	far
M00A_L_9CB3:
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,2
		db	0E9h
		dw	000D3h
M00A_L_9CC1:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr [BP+0Ah]
		je	short M00A_L_9CD1
		db	0E9h
		dw	000C0h
M00A_L_9CD1:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],5
		je	short M00A_L_9CDF
		db	0E9h
		dw	000B2h
M00A_L_9CDF:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	word ptr ES:[SI+11h],0
		jne	short M00A_L_9CED
		db	0E9h
		dw	000A4h
M00A_L_9CED:
		test	byte ptr ES:[SI+0Eh],2
		je	short M00A_L_9CF7
		db	0E9h
		dw	0009Ah
M00A_L_9CF7:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],11h
		jne	short M00A_L_9D11
		push	word ptr ES:[SI]
		db	0FFh,01Eh
		dw	8168h
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	word ptr ES:[SI+0Bh],AX
M00A_L_9D11:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	word ptr ES:[SI+0Bh],0
		je	short M00A_L_9D2D
		cmp	byte ptr ES:[SI+6],10h
		jbe	short M00A_L_9D2D
		push	word ptr ES:[SI+0Bh]
		db	0FFh,01Eh
		dw	8164h
		jmp	short M00A_L_9D42
M00A_L_9D2D:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	AL,byte ptr [BX+392Bh]
		cbw
M00A_L_9D42:
		mov	DI,AX
		cmp	DI,0Ah
		jbe	short M00A_L_9D51
		cmp	word ptr [BP+6],0
		jne	short M00A_L_9D57
		jmp	short M00A_L_9D91
M00A_L_9D51:
		cmp	word ptr [BP+6],0
		jne	short M00A_L_9D91
M00A_L_9D57:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	AX,word ptr [BP+8]
		sub	AX,DI
		mov	word ptr ES:[SI+0Fh],AX
		cmp	byte ptr ES:[SI+6],2
		jbe	short M00A_L_9D71
		db	026h,081h,064h,00Fh,0FEh,0FFh
M00A_L_9D71:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	word ptr ES:[SI],0
		je	short M00A_L_9D86
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+0Fh]
		db	0FFh,01Eh
		dw	813Ch
M00A_L_9D86:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	AX,word ptr ES:[SI+0Fh]
		mov	word ptr [BP+8],AX
M00A_L_9D91:
		add	SI,1Dh
M00A_L_9D94:
		cmp	SI,word ptr DGROUP:M00A_BCC_DATA_8672
		jnc	short M00A_L_9D9D
		db	0E9h
		dw	0FF24h
M00A_L_9D9D:
		mov	AX,word ptr [BP+8]
		neg	AX
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+16h]
		jmp	short M00A_L_9DD4
M00A_L_9DB2:
		push	word ptr [BP-2]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FEF4h
		mov	DI,AX
		cmp	DI,word ptr [BP-4]
		jbe	short M00A_L_9DC9
		mov	word ptr [BP-4],DI
M00A_L_9DC9:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+18h]
M00A_L_9DD4:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M00A_L_9DB2
		mov	AX,word ptr [BP-4]
		inc	AX
		and	AX,0FFFEh
		mov	DGROUP:M00A_BCC_DATA_86E6,AX
		mov	AX,word ptr [BP-4]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	6
STAOV0D8	endp
CO063_TEXT	ends


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M00B_BCC_DATA_8108	equ	8108h
M00B_BCC_DATA_8164	equ	8164h
M00B_BCC_DATA_866E	equ	866Eh
M00B_BCC_DATA_8672	equ	8672h
M00B_BCC_DATA_86E8	equ	86E8h
M00B_BCC_DATA_86F0	equ	86F0h


		public	X063_04
X063_04	label	far
STAOV0D9	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		xor	DI,DI
		mov	SI,2
		jmp	short M00B_L_9E51
M00B_L_9DFE:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		jne	short M00B_L_9E4E
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],9
		jne	short M00B_L_9E20
		cmp	word ptr DGROUP:M00B_BCC_DATA_86F0,0
		jne	short M00B_L_9E20
		add	DI,8
		jmp	short M00B_L_9E4E
M00B_L_9E20:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],8
		ja	short M00B_L_9E39
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		jmp	short M00B_L_9E41
M00B_L_9E39:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_866E
		push	word ptr ES:[SI+0Bh]
M00B_L_9E41:
		db	0FFh,01Eh
		dw	8164h
		add	DI,AX
		test	DI,1
		je	short M00B_L_9E4E
		inc	DI
M00B_L_9E4E:
		add	SI,1Dh
M00B_L_9E51:
		cmp	SI,word ptr DGROUP:M00B_BCC_DATA_8672
		jc	short M00B_L_9DFE
		mov	word ptr DGROUP:M00B_BCC_DATA_86E8,DI
		pop	DI
		pop	SI
		pop	BP
		retf
STAOV0D9	endp
CO063_TEXT	ends


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M00C_BCC_DATA_8108	equ	8108h
M00C_BCC_DATA_813C	equ	813Ch
M00C_BCC_DATA_8164	equ	8164h
M00C_BCC_DATA_866E	equ	866Eh
M00C_BCC_DATA_8672	equ	8672h
M00C_BCC_DATA_86E8	equ	86E8h
M00C_BCC_DATA_86EA	equ	86EAh
M00C_BCC_DATA_86F0	equ	86F0h
M00C_BCC_DATA_86F2	equ	86F2h
M00C_BCC_DATA_86F3	equ	86F3h
M00C_BCC_DATA_88AE	equ	88AEh


		public	X063_03
X063_03	label	far
BCC_NEAR_9E5F	label	near
STAOV0DA	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		cmp	byte ptr DGROUP:M00C_BCC_DATA_86F2,4
		jne	short M00C_L_9E75
		mov	word ptr [BP-6],0
		jmp	short M00C_L_9E8F
M00C_L_9E75:
		test	word ptr DGROUP:M00C_BCC_DATA_86F3,1
		je	short M00C_L_9E84
		mov	word ptr [BP-6],4
		jmp	short M00C_L_9E89
M00C_L_9E84:
		mov	word ptr [BP-6],2
M00C_L_9E89:
		mov	AX,DGROUP:M00C_BCC_DATA_86EA
		add	word ptr [BP-6],AX
M00C_L_9E8F:
		mov	AX,word ptr [BP-6]
		mov	DGROUP:M00C_BCC_DATA_88AE,AX
		cmp	byte ptr DGROUP:M00C_BCC_DATA_86F2,2
		jne	short M00C_L_9EA4
		mov	AX,DGROUP:M00C_BCC_DATA_86E8
		mov	word ptr [BP-4],AX
		jmp	short M00C_L_9EA9
M00C_L_9EA4:
		mov	word ptr [BP-4],0
M00C_L_9EA9:
		mov	SI,2
		db	0E9h
		dw	000A5h
M00C_L_9EAF:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		je	short M00C_L_9EBD
		db	0E9h
		dw	00094h
M00C_L_9EBD:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_866E
		mov	AX,word ptr ES:[SI+0Bh]
		mov	word ptr [BP-2],AX
		cmp	byte ptr ES:[SI+6],9
		jne	short M00C_L_9EDB
		cmp	word ptr DGROUP:M00C_BCC_DATA_86F0,0
		jne	short M00C_L_9EDB
		mov	DI,8
		jmp	short M00C_L_9F04
M00C_L_9EDB:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],8
		ja	short M00C_L_9EF4
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	word ptr [BP-2],AX
M00C_L_9EF4:
		push	word ptr [BP-2]
		db	0FFh,01Eh
		dw	8164h
		mov	DI,AX
		test	DI,1
		je	short M00C_L_9F04
		inc	DI
M00C_L_9F04:
		cmp	byte ptr DGROUP:M00C_BCC_DATA_86F2,2
		jne	short M00C_L_9F2F
		sub	word ptr [BP-4],DI
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_866E
		mov	AX,word ptr [BP-4]
		add	AX,word ptr [BP-6]
		mov	word ptr ES:[SI+0Fh],AX
		cmp	word ptr ES:[SI],0
		je	short M00C_L_9F51
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+0Fh]
		db	0FFh,01Eh
		dw	813Ch
		jmp	short M00C_L_9F51
M00C_L_9F2F:
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_866E
		mov	AX,word ptr [BP-4]
		add	AX,word ptr [BP-6]
		mov	word ptr ES:[SI+0Fh],AX
		cmp	word ptr ES:[SI],0
		je	short M00C_L_9F4E
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+0Fh]
		db	0FFh,01Eh
		dw	813Ch
M00C_L_9F4E:
		add	word ptr [BP-4],DI
M00C_L_9F51:
		add	SI,1Dh
M00C_L_9F54:
		cmp	SI,word ptr DGROUP:M00C_BCC_DATA_8672
		jnc	short M00C_L_9F5D
		db	0E9h
		dw	0FF52h
M00C_L_9F5D:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV0DA	endp
CO063_TEXT	ends


		extrn	X058_03:far
		extrn	X065_02:far
		extrn	X065_03:far
		extrn	X065_00:far
		extrn	X065_01:far
		extrn	X065_0C:far


CO063_TEXT	segment byte public 'CODE'
		assume	cs:CO063_TEXT,ds:DGROUP

M00D_BCC_DATA_866E	equ	866Eh
M00D_BCC_DATA_8672	equ	8672h
M00D_BCC_DATA_8680	equ	8680h
M00D_BCC_DATA_8698	equ	8698h
M00D_BCC_DATA_86F0	equ	86F0h

BCC_NEAR_9F63	label	near
STAOV0DB	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,2
		db	0E9h
		dw	00099h
M00D_L_9F72:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		je	short M00D_L_9F80
		db	0E9h
		dw	00088h
M00D_L_9F80:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		test	byte ptr ES:[SI+0Eh],2
		jne	short M00D_L_A008
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],9
		jne	short M00D_L_A008
		cmp	word ptr DGROUP:M00D_BCC_DATA_86F0,0
		jne	short M00D_L_A008
		mov	AX,13h
		push	AX
		push	word ptr ES:[SI]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,12h
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		push	word ptr ES:[SI]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	DI,AX
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,66h
		push	AX
		push	word ptr [BP-2]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	AX,6Ah
		push	AX
		push	DI
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	AX,57h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M00D_L_A008:
		add	SI,1Dh
M00D_L_A00B:
		cmp	SI,word ptr DGROUP:M00D_BCC_DATA_8672
		jnc	short M00D_L_A014
		db	0E9h
		dw	0FF5Eh
M00D_L_A014:
		mov	SI,2
		db	0E9h
		dw	000DBh
M00D_L_A01A:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		je	short M00D_L_A028
		db	0E9h
		dw	000CAh
M00D_L_A028:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		test	byte ptr ES:[SI+0Eh],2
		jne	short M00D_L_A036
		db	0E9h
		dw	000BCh
M00D_L_A036:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		mov	AL,byte ptr ES:[SI+7]
		mov	byte ptr [BP-5],AL
		and	byte ptr ES:[SI+0Eh],0FDh
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		mov	BX,AX
		test	byte ptr [BX+9CAh],2
		je	short M00D_L_A076
		mov	AL,byte ptr ES:[SI+6]
		mov	AH,0
		add	AX,5Ch
		push	AX
		push	SI
		db	09Ah
		dw	X065_01
		dw	seg X065_01
		mov	AX,6Ah
		push	AX
		mov	AL,byte ptr [BP-5]
		add	AL,0F1h
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		jmp	short M00D_L_A0E9
M00D_L_A076:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		cmp	byte ptr ES:[SI+6],2
		jbe	short M00D_L_A0B4
		mov	AX,10h
		push	AX
		push	word ptr ES:[SI]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	DI,AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8698
		mov	BX,word ptr [BP-4]
		mov	word ptr ES:[BX],SI
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,9Ch
		jmp	short M00D_L_A0DE
M00D_L_A0B4:
		mov	AX,0Fh
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		push	word ptr ES:[SI]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	DI,AX
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],0FFh
		mov	AX,9Bh
M00D_L_A0DE:
		push	AX
		mov	AL,byte ptr [BP-5]
		push	AX
		push	DI
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
M00D_L_A0E9:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_866E
		or	byte ptr ES:[SI+0Eh],2
M00D_L_A0F2:
		add	SI,1Dh
M00D_L_A0F5:
		cmp	SI,word ptr DGROUP:M00D_BCC_DATA_8672
		jnc	short M00D_L_A0FE
		db	0E9h
		dw	0FF1Ch
M00D_L_A0FE:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret
STAOV0DB	endp
CO063_TEXT	ends

; END C207UNIT
		end
