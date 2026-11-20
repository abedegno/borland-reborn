		public	X066_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d9f_aac9
; BEGIN STAOV0F3 (listing ovr_1d9f_aac9:AC90)

		extrn	BCC_FAR_04CF:far
		extrn	X05D_06:far
		extrn	X065_08:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M000_BCC_DATA_1700	equ	1700h
M000_BCC_DATA_5CA2	equ	5CA2h
M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_86E0	equ	86E0h
M000_BCC_DATA_87F8	equ	87F8h
M000_BCC_DATA_87FC	equ	87FCh
M000_BCC_DATA_8808	equ	8808h
M000_BCC_DATA_880C	equ	880Ch
M000_BCC_DATA_8818	equ	8818h
M000_BCC_DATA_8B16	equ	8B16h
M000_BCC_DATA_8B18	equ	8B18h

		public	X066_00
X066_00	label	far
STAOV0F3	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	word ptr DGROUP:M000_BCC_DATA_8B16,0
		mov	SI,word ptr DGROUP:M000_BCC_DATA_86E0
		db	0E9h
		dw	00169h
M000_L_ACA2:
		push	SI
		db	0FFh,01Eh
		dw	8808h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ah]
		mov	DGROUP:M000_BCC_DATA_8B18,AX
		cmp	word ptr DGROUP:M000_BCC_DATA_5CA2,0
		je	short M000_L_ACBE
		db	09Ah
		dw	BCC_FAR_04CF
		dw	seg BCC_FAR_04CF
M000_L_ACBE:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	BX,word ptr ES:[SI]
		cmp	BX,5
		jbe	short M000_L_ACCD
		db	0E9h
		dw	00136h
M000_L_ACCD:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	186h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		push	word ptr ES:[SI+12h]
		db	09Ah
		dw	003Eh
		dw	seg X05D_06
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		test	word ptr ES:[SI+8],0F8FFh
		jne	short M000_L_ACF0
		db	0E9h
		dw	00113h
M000_L_ACF0:
		push	word ptr ES:[SI+8]
		push	word ptr ES:[SI+10h]
		mov	AX,word ptr ES:[SI+8]
		and	AX,0F8FFh
		cmp	AX,1
		je	short M000_L_AD11
		test	word ptr ES:[SI+1Ch],100h
		je	short M000_L_AD11
		mov	AX,1
		jmp	short M000_L_AD13
M000_L_AD11:
		xor	AX,AX
M000_L_AD13:
		push	AX
		db	0FFh,01Eh
		dw	880Ch
		db	0E9h
		dw	000E8h
		cmp	byte ptr DGROUP:M000_BCC_DATA_1700,0
		jne	short M000_L_AD25
		db	0E9h
		dw	000DEh
M000_L_AD25:
		db	0FFh,01Eh
		dw	87F8h
		db	0E9h
		dw	000D7h
		cmp	byte ptr DGROUP:M000_BCC_DATA_1700,0
		jne	short M000_L_AD36
		db	0E9h
		dw	000CDh
M000_L_AD36:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+0Ch]
		or	DI,DI
		je	short M000_L_AD47
		cmp	DI,2
		jne	short M000_L_AD59
M000_L_AD47:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	BX,word ptr ES:[SI+10h]
		mov	AX,word ptr ES:[BX+12h]
		mov	DGROUP:M000_BCC_DATA_8B16,AX
		db	0E9h
		dw	000AAh
M000_L_AD59:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	BX,word ptr ES:[SI+10h]
		push	word ptr ES:[BX+12h]
		db	0FFh,01Eh
		dw	87FCh
		db	0E9h
		dw	00097h
		push	SI
		db	0E8h
		dw	000B2h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		test	word ptr ES:[SI+8],0F8FFh
		jne	short M000_L_AD7F
		db	0E9h
		dw	00084h
M000_L_AD7F:
		push	word ptr ES:[SI+8]
		push	word ptr ES:[SI+10h]
		mov	AX,word ptr ES:[SI+8]
		and	AX,0F8FFh
		cmp	AX,1
		je	short M000_L_ADA0
		test	word ptr ES:[SI+1Ch],100h
		je	short M000_L_ADA0
		mov	AX,1
		jmp	short M000_L_ADA2
M000_L_ADA0:
		xor	AX,AX
M000_L_ADA2:
		push	AX
		db	0FFh,01Eh
		dw	880Ch
		jmp	short M000_L_AE03
		push	SI
		db	0E8h
		dw	00075h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		test	word ptr ES:[SI+1Ch],2
		je	short M000_L_ADD7
		mov	AX,45h
		push	AX
		mov	AL,4
		push	AX
		mov	AX,1
		push	AX
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		push	word ptr ES:[SI+14h]
		db	0FFh,01Eh
		dw	8818h
		jmp	short M000_L_AE03
M000_L_ADD7:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		push	word ptr ES:[SI+8]
		push	word ptr ES:[SI+10h]
		mov	AX,word ptr ES:[SI+8]
		and	AX,0F8FFh
		cmp	AX,1
		je	short M000_L_ADFC
		test	word ptr ES:[SI+1Ch],100h
		je	short M000_L_ADFC
		mov	AX,1
		jmp	short M000_L_ADFE
M000_L_ADFC:
		xor	AX,AX
M000_L_ADFE:
		push	AX
		db	0FFh,01Eh
		dw	880Ch
M000_L_AE03:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
M000_L_AE0B:
		or	SI,SI
		je	short M000_L_AE12
		db	0E9h
		dw	0FE90h
M000_L_AE12:
		pop	DI
		pop	SI
		pop	BP
		retf
STAOV0F3	endp
CO066_TEXT	ends

CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT

STOVT187	label	word
		dw	000DCh
		dw	0008Bh
		dw	0009Ch
		dw	00173h
		dw	00119h
		dw	00044h

CO066_TEXT	ends
; END STAOV0F3
; BEGIN STAOV0F4 (listing ovr_1d9f_aac9:AE22)

		extrn	BCC_FAR_03E3:far
		extrn	BCC_FAR_0402:far
		extrn	X061_01:far
		extrn	X062_03:far
		extrn	X062_06:far
		extrn	X062_09:far
		extrn	X062_0B:far
		extrn	X065_02:far
		extrn	X065_03:far
		extrn	X065_00:far
		extrn	X065_07:far
		extrn	X065_04:far
		extrn	X065_08:far
		extrn	X065_0C:far
		extrn	X065_0B:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M002_BCC_DATA_16F0	equ	16F0h
M002_BCC_DATA_1702	equ	1702h
M002_BCC_DATA_8654	equ	8654h
M002_BCC_DATA_866E	equ	866Eh
M002_BCC_DATA_8680	equ	8680h
M002_BCC_DATA_8698	equ	8698h
M002_BCC_DATA_871C	equ	871Ch
M002_BCC_DATA_87E0	equ	87E0h
M002_BCC_DATA_87F0	equ	87F0h
M002_BCC_DATA_87F4	equ	87F4h
M002_BCC_DATA_881C	equ	881Ch
M002_BCC_DATA_8820	equ	8820h
M002_BCC_DATA_8824	equ	8824h
M002_BCC_DATA_88B0	equ	88B0h
M002_BCC_DATA_88B1	equ	88B1h
M002_BCC_DATA_8B14	equ	8B14h
M002_BCC_DATA_8B28	equ	8B28h
M002_BCC_DATA_8B2C	equ	8B2Ch
M002_BCC_DATA_8B31	equ	8B31h

BCC_NEAR_AE22	label	near
STAOV0F4	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,10h
		push	SI
		push	DI
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-2],AX
		mov	AX,word ptr ES:[BX+4]
		mov	word ptr [BP-4],AX
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		db	0E9h
		dw	00B22h
M002_L_AE49:
		mov	AX,word ptr [BP-4]
		mov	DGROUP:M002_BCC_DATA_871C,AX
		push	word ptr [BP-4]
		db	0E8h
		dw	00EFCh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],41h
		je	short M002_L_AE7B
		cmp	byte ptr ES:[SI],1
		je	short M002_L_AE69
		db	0E9h
		dw	00AF9h
M002_L_AE69:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+2]
		db	0FFh,01Eh
		dw	87F0h
		db	0E9h
		dw	00AE7h
M002_L_AE7B:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	DI,AX
		mov	AX,word ptr [DI+3]
		and	AX,2000h
		or	AX,0
		je	short M002_L_AE9C
		db	0E9h
		dw	00AC6h
M002_L_AE9C:
		mov	AX,word ptr [DI+3]
		and	AX,1000h
		or	AX,0
		je	short M002_L_AEAF
		push	SI
		push	DI
		db	0E8h
		dw	00BC7h
		db	0E9h
		dw	00AB3h
M002_L_AEAF:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		cmp	AX,78h
		jne	short M002_L_AEC0
		db	0E9h
		dw	00680h
M002_L_AEC0:
		jg	short M002_L_AF11
		cmp	AX,1Bh
		jne	short M002_L_AECA
		db	0E9h
		dw	0032Bh
M002_L_AECA:
		jg	short M002_L_AEDF
		dec	AX
		dec	AX
		mov	BX,AX
		cmp	BX,18h
		jbe	short M002_L_AED8
		db	0E9h
		dw	00757h
M002_L_AED8:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0DB1h
M002_L_AEDF:
		cmp	AX,56h
		jne	short M002_L_AEE7
		db	0E9h
		dw	00693h
M002_L_AEE7:
		jg	short M002_L_AEFD
		sub	AX,44h
		mov	BX,AX
		cmp	BX,11h
		jbe	short M002_L_AEF6
		db	0E9h
		dw	00739h
M002_L_AEF6:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D8Dh
M002_L_AEFD:
		sub	AX,72h
		mov	BX,AX
		cmp	BX,5
		jbe	short M002_L_AF0A
		db	0E9h
		dw	00725h
M002_L_AF0A:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D81h
M002_L_AF11:
		cmp	AX,97h
		jne	short M002_L_AF19
		db	0E9h
		dw	001C3h
M002_L_AF19:
		jg	short M002_L_AF2F
		sub	AX,79h
		mov	BX,AX
		cmp	BX,1Ch
		jbe	short M002_L_AF28
		db	0E9h
		dw	00707h
M002_L_AF28:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0D47h
M002_L_AF2F:
		cmp	AX,0AEh
		jne	short M002_L_AF37
		db	0E9h
		dw	00A2Bh
M002_L_AF37:
		jg	short M002_L_AF71
		cmp	AX,0ABh
		jne	short M002_L_AF41
		db	0E9h
		dw	0052Eh
M002_L_AF41:
		jg	short M002_L_AF5E
		cmp	AX,98h
		jne	short M002_L_AF4B
		db	0E9h
		dw	00191h
M002_L_AF4B:
		cmp	AX,99h
		jne	short M002_L_AF53
		db	0E9h
		dw	00189h
M002_L_AF53:
		cmp	AX,0AAh
		jne	short M002_L_AF5B
		db	0E9h
		dw	004F1h
M002_L_AF5B:
		db	0E9h
		dw	006D1h
M002_L_AF5E:
		cmp	AX,0ACh
		jne	short M002_L_AF66
		db	0E9h
		dw	00509h
M002_L_AF66:
		cmp	AX,0ADh
		jne	short M002_L_AF6E
		db	0E9h
		dw	00090h
M002_L_AF6E:
		db	0E9h
		dw	006BEh
M002_L_AF71:
		cmp	AX,0B4h
		jne	short M002_L_AF79
		db	0E9h
		dw	009E9h
M002_L_AF79:
		jg	short M002_L_AF93
		cmp	AX,0AFh
		je	short M002_L_AFF0
		cmp	AX,0B0h
		jne	short M002_L_AF88
		db	0E9h
		dw	00340h
M002_L_AF88:
		cmp	AX,0B3h
		jne	short M002_L_AF90
		db	0E9h
		dw	0039Dh
M002_L_AF90:
		db	0E9h
		dw	0069Ch
M002_L_AF93:
		cmp	AX,0D3h
		jne	short M002_L_AF9B
		db	0E9h
		dw	005DFh
M002_L_AF9B:
		cmp	AX,0D4h
		jne	short M002_L_AFA3
		db	0E9h
		dw	005D7h
M002_L_AFA3:
		db	0E9h
		dw	00689h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_AFB4
		db	0E9h
		dw	009AEh
M002_L_AFB4:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		cbw
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	AX,word ptr ES:[SI]
		jne	short M002_L_AFC9
		db	0E9h
		dw	00999h
M002_L_AFC9:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	0E8h
		dw	00D59h
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		db	0E9h
		dw	00972h
M002_L_AFF0:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	0FFh,01Eh
		dw	881Ch
		db	0E9h
		dw	00964h
M002_L_AFFE:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		or	AX,word ptr ES:[SI+2]
		jne	short M002_L_B00E
		db	0E9h
		dw	00954h
M002_L_B00E:
		cmp	byte ptr DGROUP:M002_BCC_DATA_1702,0
		jne	short M002_L_B024
		cmp	word ptr ES:[SI+2],0
		jc	short M002_L_B03A
		ja	short M002_L_B024
		cmp	word ptr ES:[SI],4
		jbe	short M002_L_B03A
M002_L_B024:
		mov	AX,1Fh
		push	AX
		mov	AL,0Bh
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		db	0E9h
		dw	00928h
M002_L_B03A:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		jc	short M002_L_B059
		ja	short M002_L_B04D
		cmp	word ptr ES:[SI],2
		jbe	short M002_L_B059
M002_L_B04D:
		mov	AX,7Fh
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
M002_L_B059:
		mov	AX,7Fh
		push	AX
		mov	AL,6
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	008FAh
		mov	AX,73h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B07F
		db	0E9h
		dw	008E3h
M002_L_B07F:
		mov	AX,7Fh
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	008D2h
		mov	AX,74h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B0A7
		db	0E9h
		dw	008BBh
M002_L_B0A7:
		mov	AX,73h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		mov	AX,7Fh
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	0089Dh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	byte ptr ES:[SI],0Ah
		mov	AX,72h
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	00886h
M002_L_B0DC:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B0EA
		db	0E9h
		dw	00878h
M002_L_B0EA:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		db	0E9h
		dw	0085Bh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B115
		db	0E9h
		dw	0084Dh
M002_L_B115:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		db	0E9h
		dw	0082Fh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B141
		db	0E9h
		dw	00821h
M002_L_B141:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-8],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	AX,95h
		push	AX
		mov	AL,byte ptr [BP-8]
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-8]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	007F3h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		db	0E9h
		dw	007E4h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	DX,word ptr ES:[SI+2]
		mov	AX,word ptr ES:[SI]
		mov	CL,8
		db	09Ah
		dw	BCC_FAR_03E3
		dw	seg BCC_FAR_03E3
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		db	0E9h
		dw	007BEh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	007A9h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B1C7
		db	0E9h
		dw	0079Bh
M002_L_B1C7:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-7],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	AX,9Ch
		push	AX
		mov	AL,byte ptr [BP-7]
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-7]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	0076Dh
M002_L_B1F5:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B203
		db	0E9h
		dw	0075Fh
M002_L_B203:
		mov	AX,SI
		add	AX,4
		mov	word ptr [BP-0Ah],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-7],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	BX,word ptr [BP-0Ah]
		mov	AL,byte ptr ES:[BX+1]
		mov	AH,0
		and	AX,49h
		cmp	AX,8
		jne	short M002_L_B269
		cmp	byte ptr [BP-7],0Ch
		jne	short M002_L_B269
		or	byte ptr ES:[BX+1],40h
		mov	AX,word ptr [BP-4]
		inc	AX
		push	AX
		db	0E8h
		dw	00B12h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		cmp	byte ptr ES:[SI],1Bh
		jne	short M002_L_B24F
		mov	byte ptr ES:[SI],16h
		jmp	short M002_L_B258
M002_L_B24F:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		sub	word ptr ES:[SI+2],2
M002_L_B258:
		mov	AX,96h
		push	AX
		mov	BX,word ptr [BP-0Ah]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[BX+2]
		jmp	short M002_L_B270
M002_L_B269:
		mov	AX,9Ch
		push	AX
		mov	AL,byte ptr [BP-7]
M002_L_B270:
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-7]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	006DBh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B295
		db	0E9h
		dw	006CDh
M002_L_B295:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-7],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr [BP-7]
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-7]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	0069Ah
M002_L_B2C8:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	0FFh,01Eh
		dw	8820h
		db	0E9h
		dw	0068Ch
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B2E4
		db	0E9h
		dw	0067Eh
M002_L_B2E4:
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	00668h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AL,byte ptr ES:[SI]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	0064Eh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	00635h
M002_L_B32D:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		je	short M002_L_B33B
		db	0E9h
		dw	00627h
M002_L_B33B:
		mov	AX,90h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		db	0E9h
		dw	0061Bh
		db	0E9h
		dw	00609h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B373
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr ES:[SI+2]
		shl	BX,1
		shl	BX,1
		push	word ptr ES:[BX]
		db	09Ah
		dw	X062_0B
		dw	seg X062_0B
		or	AX,AX
		je	short M002_L_B373
		mov	AX,90h
		db	0E9h
		dw	005E9h
M002_L_B373:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B381
		db	0E9h
		dw	005E1h
M002_L_B381:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		mov	byte ptr [BP-7],AL
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		cmp	AL,byte ptr [BP-7]
		jne	short M002_L_B3A0
		db	0E9h
		dw	005C2h
M002_L_B3A0:
		mov	AX,9Ch
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	AL,byte ptr [BP-7]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		db	0E9h
		dw	005ADh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B3C3
		db	0E9h
		dw	0059Fh
M002_L_B3C3:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,61h
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	0058Bh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B40A
		mov	BX,word ptr ES:[SI+2]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M002_L_B40A
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M002_L_B444
M002_L_B40A:
		mov	AL,DGROUP:M002_BCC_DATA_8B14
		cbw
		or	AX,AX
		jne	short M002_L_B435
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		test	word ptr ES:[BX+8],0F8FFh
		je	short M002_L_B435
		push	word ptr ES:[BX+8]
		db	09Ah
		dw	X062_03
		dw	seg X062_03
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+8],AX
M002_L_B435:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M002_L_B444:
		mov	byte ptr DGROUP:M002_BCC_DATA_8B14,0
		db	0E9h
		dw	00516h
M002_L_B44C:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-7],AL
		inc	AL
		mov	byte ptr [BP-7],AL
		mov	AX,9Bh
		push	AX
		mov	AL,byte ptr [BP-7]
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X065_08
		dw	seg X065_08
		db	0E9h
		dw	004F3h
M002_L_B46F:
		db	0E9h
		dw	004E1h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B480
		db	0E9h
		dw	004E2h
M002_L_B480:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-6],AX
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_866E
		cmp	byte ptr ES:[BX+0Dh],5
		je	short M002_L_B4A2
		cmp	byte ptr ES:[BX+0Dh],6
		je	short M002_L_B4A2
		db	0E9h
		dw	0018Dh
M002_L_B4A2:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-8],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	byte ptr ES:[SI],10h
		mov	AX,95h
		push	AX
		mov	AL,byte ptr [BP-8]
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-8]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	0048Eh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-0Eh],AX
		mov	BX,word ptr [BP-0Eh]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		jne	short M002_L_B527
		mov	AX,94h
		push	AX
		mov	AL,0Eh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0FFh,01Eh
		dw	8824h
		mov	AX,94h
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	AX,94h
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	AX,0A1h
		db	0E9h
		dw	00435h
M002_L_B527:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	00422h
M002_L_B540:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-8],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	word ptr ES:[SI+2],0
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-8]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	003E8h
M002_L_B57A:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-0Ch],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	BX,word ptr [BP-0Ch]
		cmp	byte ptr ES:[BX],9
		je	short M002_L_B599
		db	0E9h
		dw	00096h
M002_L_B599:
		test	byte ptr ES:[BX+1],1
		jne	short M002_L_B5A3
		db	0E9h
		dw	0008Ch
M002_L_B5A3:
		cmp	byte ptr DGROUP:M002_BCC_DATA_16F0,0
		je	short M002_L_B5AD
		db	0E9h
		dw	00082h
M002_L_B5AD:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-10h],AX
		jmp	short M002_L_B5D6
M002_L_B5B9:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X065_07
		dw	seg X065_07
		dec	word ptr [BP-10h]
M002_L_B5D6:
		cmp	word ptr [BP-10h],0
		ja	short M002_L_B5B9
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+1]
		mov	AH,0
		and	AX,0Ah
		cmp	AX,0Ah
		je	short M002_L_B5F1
		db	0E9h
		dw	00371h
M002_L_B5F1:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		cbw
		mov	word ptr [BP-10h],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		cbw
		cmp	AX,word ptr [BP-10h]
		jne	short M002_L_B612
		db	0E9h
		dw	00350h
M002_L_B612:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		db	0E9h
		dw	00333h
M002_L_B62F:
		mov	AX,word ptr [DI+3]
		and	AX,2
		or	AX,0
		jne	short M002_L_B63D
		db	0E9h
		dw	00106h
M002_L_B63D:
		mov	AX,word ptr [DI+3]
		and	AX,1
		or	AX,0
		je	short M002_L_B66A
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B656
		db	0E9h
		dw	000E5h
M002_L_B656:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,61h
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	000D1h
M002_L_B66A:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M002_L_B6CD
		test	byte ptr ES:[SI+1],8
		je	short M002_L_B683
		push	SI
		db	0E8h
		dw	005E2h
		db	0E9h
		dw	000B8h
M002_L_B683:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],80h
		je	short M002_L_B691
		db	0E9h
		dw	000A1h
M002_L_B691:
		mov	AX,word ptr [DI+3]
		and	AX,4
		or	AX,0
		je	short M002_L_B6B5
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	00086h
M002_L_B6B5:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X062_06
		dw	seg X062_06
		jmp	short M002_L_B73B
M002_L_B6CD:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B700
		mov	BX,word ptr ES:[SI+2]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M002_L_B700
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M002_L_B727
M002_L_B700:
		cmp	byte ptr DGROUP:M002_BCC_DATA_8B14,0
		je	short M002_L_B718
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	09Ah
		dw	X062_09
		dw	seg X062_09
		jmp	short M002_L_B721
M002_L_B718:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
M002_L_B721:
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M002_L_B727:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B73B
M002_L_B732:
		mov	AX,90h
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M002_L_B73B:
		mov	byte ptr DGROUP:M002_BCC_DATA_8B14,0
		db	0E9h
		dw	0021Fh
M002_L_B743:
		mov	AX,word ptr [DI+3]
		and	AX,9
		or	AX,0
		jne	short M002_L_B751
		db	0E9h
		dw	0007Fh
M002_L_B751:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		jne	short M002_L_B79D
		cmp	word ptr [BP-2],1
		jbe	short M002_L_B765
		db	0E9h
		dw	001FDh
M002_L_B765:
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+8]
		and	AX,0F8FFh
		cmp	AX,1
		jne	short M002_L_B77B
		db	0E9h
		dw	001E7h
M002_L_B77B:
		test	word ptr ES:[BX+8],0F8FFh
		jne	short M002_L_B786
		db	0E9h
		dw	001DCh
M002_L_B786:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,7Fh
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X065_07
		dw	seg X065_07
		db	0E9h
		dw	001C5h
M002_L_B79D:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-7],AL
		mov	byte ptr ES:[SI+2],0FFh
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr [BP-7]
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr [BP-7]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	00192h
M002_L_B7D0:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		mov	byte ptr [BP-7],AL
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M002_L_B7ED
		db	0E9h
		dw	000C1h
M002_L_B7ED:
		test	byte ptr ES:[SI+1],8
		je	short M002_L_B851
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B81E
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		db	0E9h
		dw	00144h
M002_L_B81E:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI],0
		je	short M002_L_B83F
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	00123h
M002_L_B83F:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		db	0E9h
		dw	00111h
M002_L_B851:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B879
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_04
		dw	seg X065_04
		db	0E9h
		dw	000E9h
M002_L_B879:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI],0
		je	short M002_L_B89C
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		db	0E9h
		dw	000C6h
M002_L_B89C:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		db	0E9h
		dw	000B4h
M002_L_B8AE:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],8
		je	short M002_L_B8FF
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B8CC
		push	SI
		push	DI
		db	0E8h
		dw	0023Bh
		db	0E9h
		dw	00096h
M002_L_B8CC:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI],0
		je	short M002_L_B8EE
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M002_L_B962
M002_L_B8EE:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
		jmp	short M002_L_B962
M002_L_B8FF:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[SI+1],80h
		jne	short M002_L_B962
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M002_L_B931
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_04
		dw	seg X065_04
		jmp	short M002_L_B962
M002_L_B931:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		cmp	word ptr ES:[SI],0
		je	short M002_L_B953
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		jmp	short M002_L_B962
M002_L_B953:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
M002_L_B95C:
		push	AX
		db	09Ah
		dw	X065_02
		dw	seg X065_02
M002_L_B962:
		dec	word ptr [BP-2]
		inc	word ptr [BP-4]
		add	SI,4
M002_L_B96B:
		cmp	word ptr [BP-2],0
		je	short M002_L_B974
		db	0E9h
		dw	0F4D5h
M002_L_B974:
		cmp	byte ptr DGROUP:M002_BCC_DATA_88B0,0
		je	short M002_L_B994
		mov	word ptr DGROUP:M002_BCC_DATA_8B28,0
		mov	word ptr DGROUP:M002_BCC_DATA_8B31,0
		mov	AX,57h
		push	AX
		db	0FFh,01Eh
		dw	87F4h
		mov	byte ptr DGROUP:M002_BCC_DATA_88B0,0
M002_L_B994:
		cmp	byte ptr DGROUP:M002_BCC_DATA_88B1,0
		je	short M002_L_B9C5
		mov	word ptr DGROUP:M002_BCC_DATA_8B28,1
		mov	byte ptr DGROUP:M002_BCC_DATA_8B2C,0Ch
		mov	AX,8B31h
		push	DS
		push	AX
		mov	AX,8B1Eh
		push	DS
		push	AX
		mov	CX,9
		db	09Ah
		dw	BCC_FAR_0402
		dw	seg BCC_FAR_0402
		mov	AX,9Ch
		push	AX
		db	0FFh,01Eh
		dw	87F4h
		mov	byte ptr DGROUP:M002_BCC_DATA_88B1,0
M002_L_B9C5:
		mov	AX,word ptr [BP-4]
		neg	AX
		push	AX
		db	0E8h
		dw	00383h
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
STAOV0F4	endp
CO066_TEXT	ends

CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT

STOVT188	label	word
		dw	004EEh
		dw	004DFh
		dw	00514h
		dw	00514h
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	00747h
		dw	00747h
		dw	00747h
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	00646h
		dw	0066Ah
		dw	0066Ah
		dw	00684h
		dw	006B7h
		dw	006B7h
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	00477h
		dw	00435h
		dw	003D8h
		dw	00400h
		dw	00897h
		dw	00844h
		dw	008B0h
		dw	008EAh
		dw	008EAh
		dw	008EAh
		dw	008EAh
		dw	008EAh
		dw	008EAh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	008EAh
		dw	00CD2h
		dw	006BAh
		dw	0099Fh
		dw	00CD2h
		dw	00CD2h
		dw	00316h
		dw	00316h
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	007E2h
		dw	004A3h
		dw	0099Fh
		dw	0099Fh
		dw	00529h
		dw	0099Fh
		dw	0099Fh
		dw	0099Fh
		dw	005F7h
		dw	005F7h
		dw	0099Fh
		dw	00725h
		dw	00725h
		dw	00725h

CO066_TEXT	ends
; END STAOV0F4
; BEGIN STAOV0F5 (listing ovr_1d9f_aac9:BA73)

		extrn	X060_02:far
		extrn	X065_03:far
		extrn	X065_00:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M004_BCC_DATA_16EF	equ	16EFh
M004_BCC_DATA_16F1	equ	16F1h
M004_BCC_DATA_814C	equ	814Ch
M004_BCC_DATA_8680	equ	8680h
M004_BCC_DATA_8698	equ	8698h
M004_BCC_DATA_871C	equ	871Ch

BCC_NEAR_BA73	label	near
STAOV0F5	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	byte ptr [BP-1],AL
		mov	byte ptr ES:[SI],10h
		mov	byte ptr ES:[SI+2],0FFh
		mov	BX,word ptr [DI+0Dh]
		shl	BX,1
		push	word ptr [BX+5338h]
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		mov	AL,0
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X060_02
		dw	seg X060_02
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8698
		mov	word ptr ES:[SI],AX
		mov	word ptr ES:[SI+2],0
		cmp	byte ptr DGROUP:M004_BCC_DATA_16EF,0
		jne	short M004_L_BAD7
		mov	AX,94h
		push	AX
		mov	AL,0Eh
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	AX,77h
		jmp	short M004_L_BAE6
M004_L_BAD7:
		cmp	byte ptr DGROUP:M004_BCC_DATA_16F1,0
		je	short M004_L_BAE3
		mov	AX,77h
		jmp	short M004_L_BAE6
M004_L_BAE3:
		mov	AX,78h
M004_L_BAE6:
		push	AX
		push	word ptr DGROUP:M004_BCC_DATA_871C
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8680
		mov	AL,byte ptr [BP-1]
		mov	byte ptr ES:[SI+2],AL
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV0F5	endp
CO066_TEXT	ends

; END STAOV0F5
; BEGIN STAOV0F6 (listing ovr_1d9f_aac9:BB04)

		extrn	X061_01:far
		extrn	X065_04:far
		extrn	X065_0C:far
		extrn	X065_0B:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M005_BCC_DATA_8680	equ	8680h
M005_BCC_DATA_8698	equ	8698h

BCC_NEAR_BB04	label	near
STAOV0F6	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		mov	byte ptr [BP-1],AL
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		mov	byte ptr [BP-2],AL
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,4
		or	AX,0
		je	short M005_L_BBBB
		test	byte ptr ES:[SI+1],80h
		jne	short M005_L_BB6A
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_04
		dw	seg X065_04
M005_L_BB6A:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		cmp	AL,byte ptr [BP-1]
		jne	short M005_L_BB7A
		db	0E9h
		dw	000DFh
M005_L_BB7A:
		cmp	byte ptr [BP-1],0FFh
		je	short M005_L_BB9A
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	AL,byte ptr [BP-1]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		db	0E9h
		dw	000BFh
M005_L_BB9A:
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		db	0E9h
		dw	0009Eh
M005_L_BBBB:
		cmp	byte ptr [BP-2],0FFh
		je	short M005_L_BC02
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	AL,byte ptr [BP-2]
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		cmp	AL,byte ptr [BP-2]
		je	short M005_L_BC59
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	AL,byte ptr [BP-2]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		jmp	short M005_L_BC59
M005_L_BC02:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		cmp	byte ptr ES:[SI+2],0FFh
		je	short M005_L_BC3E
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	X065_04
		dw	seg X065_04
		mov	AL,byte ptr [DI+7]
		mov	AH,0
		add	AX,9Ah
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		jmp	short M005_L_BC54
M005_L_BC3E:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	AL,byte ptr [BP-2]
		push	AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI+2]
M005_L_BC54:
		db	09Ah
		dw	X065_0C
		dw	seg X065_0C
M005_L_BC59:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV0F6	endp
CO066_TEXT	ends

; END STAOV0F6
; BEGIN STAOV0F7 (listing ovr_1d9f_aac9:BC62)

		extrn	X065_03:far
		extrn	X065_00:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M006_BCC_DATA_16F4	equ	16F4h
M006_BCC_DATA_866E	equ	866Eh
M006_BCC_DATA_8680	equ	8680h
M006_BCC_DATA_8698	equ	8698h

BCC_NEAR_BC62	label	near
STAOV0F7	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		test	byte ptr ES:[SI+1],80h
		je	short M006_L_BC7B
		db	0E9h
		dw	000ABh
M006_L_BC7B:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		cmp	byte ptr ES:[SI],6Ch
		jne	short M006_L_BCE2
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,1
		or	AX,0
		je	short M006_L_BCCB
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8698
		mov	AX,word ptr ES:[DI]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M006_L_BCCB
		mov	AX,68h
		jmp	short M006_L_BD19
M006_L_BCCB:
		mov	AX,8Ch
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		jmp	short M006_L_BD19
M006_L_BCE2:
		cmp	byte ptr DGROUP:M006_BCC_DATA_16F4,0
		je	short M006_L_BCF7
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		add	AX,0FFFEh
		jmp	short M006_L_BD19
M006_L_BCF7:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		push	AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		add	AX,0FFFBh
M006_L_BD19:
		push	AX
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X065_03
		dw	seg X065_03
M006_L_BD26:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
STAOV0F7	endp
CO066_TEXT	ends

; END STAOV0F7
; BEGIN STAG001 (listing ovr_1d9f_aac9:BD2F)

CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP



BCC_NEAR_BD2F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		mov	AX,word ptr [BP+4]
		mov	DX,13h
		imul	DX
		mov	BX,AX
		cmp	byte ptr [BX+3F9Fh],1
		je	short M007_L_BD49
		mov	AX,9Ch
		jmp	short M007_L_BD4C
M007_L_BD49:
		mov	AX,9Bh
M007_L_BD4C:
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_BD2F	endp
CO066_TEXT	ends

; END STAG001
; BEGIN STAOV0F8 (listing ovr_1d9f_aac9:BD51)

		extrn	X065_00:far
		extrn	X065_01:far
		extrn	X065_0B:far


CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT,ds:DGROUP

M008_BCC_DATA_8666	equ	8666h
M008_BCC_DATA_866A	equ	866Ah
M008_BCC_DATA_8680	equ	8680h
M008_BCC_DATA_8B14	equ	8B14h
M008_BCC_DATA_8B18	equ	8B18h

BCC_NEAR_BD51	label	near
STAOV0F8	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		db	0E9h
		dw	0010Dh
M008_L_BD5B:
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		mov	AX,word ptr ES:[BX+5]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	AL,byte ptr ES:[BX+2]
		mov	byte ptr [BP-1],AL
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		dec	AX
		mov	BX,AX
		cmp	BX,5
		jbe	short M008_L_BD84
		db	0E9h
		dw	000DFh
M008_L_BD84:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	11FDh
		mov	AX,9Ah
		push	AX
		mov	AL,byte ptr [BP-1]
		push	AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		mov	BX,word ptr ES:[BX+7]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	byte ptr ES:[BX+2],AL
		mov	AL,byte ptr [BP-1]
		mov	byte ptr ES:[SI+2],AL
		db	0E9h
		dw	00098h
		mov	AX,94h
		push	AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		db	0E9h
		dw	00083h
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr [BP-1]
		mov	byte ptr ES:[SI+2],AL
		mov	AX,7Fh
		push	AX
		mov	AL,byte ptr [BP-1]
		push	AX
		db	09Ah
		dw	X065_00
		dw	seg X065_00
		jmp	short M008_L_BE63
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		test	byte ptr ES:[BX+1],1
		je	short M008_L_BE0E
		mov	AX,9Ch
		jmp	short M008_L_BE11
M008_L_BE0E:
		mov	AX,9Bh
M008_L_BE11:
		push	AX
		mov	AL,byte ptr [BP-1]
		push	AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	09Ah
		dw	X065_0B
		dw	seg X065_0B
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8680
		mov	AL,byte ptr [BP-1]
		mov	byte ptr ES:[SI+2],AL
		jmp	short M008_L_BE63
		mov	AX,6Ch
		push	AX
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		push	word ptr ES:[BX+7]
		db	09Ah
		dw	X065_01
		dw	seg X065_01
		jmp	short M008_L_BE63
		mov	AX,67h
		push	AX
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		push	word ptr ES:[BX+7]
		db	09Ah
		dw	X065_01
		dw	seg X065_01
		mov	AL,byte ptr [BP-1]
		mov	DGROUP:M008_BCC_DATA_8B14,AL
M008_L_BE63:
		add	word ptr DGROUP:M008_BCC_DATA_8B18,9
M008_L_BE68:
		mov	AX,DGROUP:M008_BCC_DATA_8B18
		cmp	AX,word ptr DGROUP:M008_BCC_DATA_866A
		jnc	short M008_L_BE85
		mov	BX,word ptr DGROUP:M008_BCC_DATA_8B18
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8666
		mov	AX,word ptr ES:[BX+3]
		cmp	AX,word ptr [BP+4]
		jne	short M008_L_BE85
		db	0E9h
		dw	0FED6h
M008_L_BE85:
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
STAOV0F8	endp
CO066_TEXT	ends

CO066_TEXT	segment byte public 'CODE'
		assume	cs:CO066_TEXT

STOVT189	label	word
		dw	0113Bh
		dw	01150h
		dw	0116Ah
		dw	011A1h
		dw	011B8h
		dw	010FBh

CO066_TEXT	ends
; END STAOV0F8
		end
