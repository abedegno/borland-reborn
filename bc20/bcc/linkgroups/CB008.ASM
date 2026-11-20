DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_8
; BEGIN R8HEAD (listing CODE_8:0000)
CODE8	segment byte public 'CODE'
		assume	cs:CODE8

; Four extracted bytes duplicated the end of CODE_7 and are not re-emitted.

CODE8	ends
; END R8HEAD
; BEGIN R8UNIT (listing CODE_8:0004)




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_FAR_7754

BCC_FAR_7754	proc	far
		push	BP
		mov	BP,SP
		sub	SP,1C0h
		db	0E8h
		dw	0004Bh
		mov	byte ptr [BP-1Bh],1
		db	0E8h
		dw	0079Dh
		mov	AX,word ptr [BP-12h]
		mov	word ptr [BP-14h],AX
		db	0E8h
		dw	001E5h
		db	0E8h
		dw	000CFh
		dec	byte ptr [BP-1Bh]
		db	0E8h
		dw	000F1h
		je	short M001_L_7790
		mov	AL,3Bh
		db	0E8h
		dw	0077Dh
		je	short M001_L_7785
		db	0E8h
		dw	011D6h
		jmp	short M001_L_7790
M001_L_7785:
		mov	AL,41h
		db	0E8h
		dw	0076Ah
		db	0E8h
		dw	001E2h
		db	0E8h
		dw	00B0Ch
M001_L_7790:
		db	0E8h
		dw	00045h
		xor	AX,AX
		mov	CX,word ptr [BP-12h]
		lds	BX,[BP+0Ah]
		mov	word ptr [BX],CX
		mov	SI,word ptr [BP-4]
		mov	DI,word ptr [BP-6]
		mov	SP,BP
		pop	BP
		retf	8
BCC_FAR_7754	endp
		public	BCC_NEAR_7795
BCC_NEAR_7795	equ	BCC_FAR_7754+65
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_77A9

BCC_NEAR_77A9	proc	near
		mov	word ptr [BP-4],SI
		mov	word ptr [BP-6],DI
		lea	AX,[BP+0FA58h]
		mov	word ptr [BP-8],AX
		les	BX,[BP+0Ah]
		les	BX,ES:[BX]
		mov	word ptr [BP-12h],BX
		mov	word ptr [BP-10h],ES
		xor	AX,AX
		mov	word ptr [BP-14h],AX
		mov	word ptr [BP-3Ah],AX
		mov	word ptr [BP-38h],AX
		mov	word ptr [BP-0Eh],AX
		mov	word ptr [BP+0FEF0h],AX
		mov	byte ptr [BP-25h],AL
		ret
BCC_NEAR_77A9	endp
CODE8	ends



		extrn	X079_00:far
ROOT_DED0	equ	X079_00+9
X079_01	equ	X079_00-89h
X079_02	equ	X079_00
X079_03	equ	X079_00-80h
X079_04	equ	X079_00-55h
X079_05	equ	X079_00-1E7h


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_77D8

BCC_NEAR_77D8	proc	near
		lea	SI,[BP+0FE82h]
M003_L_77DC:
		sub	word ptr [BP+0FEF0h],0Ah
		jc	short M003_L_7839
		cld
		push	SI
		xor	AX,AX
		lodsb
		mov	BX,AX
		lodsb
		mov	CX,AX
		lodsw
		xchg	AX,DX
		lodsw
		xchg	AX,DX
		dec	BX
		js	short M003_L_780A
		je	short M003_L_7812
		dec	BX
		je	short M003_L_7821
		push	AX
		mov	AX,CX
		and	CL,0FEh
		push	CX
		and	AL,1
		push	AX
		db	09Ah
		dw	ROOT_DED0
		dw	seg ROOT_DED0
		jmp	short M003_L_782C
M003_L_780A:
		push	AX
		db	09Ah
		dw	X079_03
		dw	seg X079_03
		jmp	short M003_L_782C
M003_L_7812:
		push	CX
		push	word ptr [SI+2]
		push	word ptr [SI]
		push	DX
		push	AX
		db	09Ah
		dw	X079_04
		dw	seg X079_04
		jmp	short M003_L_782C
M003_L_7821:
		push	AX
		push	word ptr [SI+2]
		push	word ptr [SI]
		db	09Ah
		dw	X079_02
		dw	seg X079_02
M003_L_782C:
		or	AX,AX
		je	short M003_L_7833
		db	0E9h
		dw	001AFh
M003_L_7833:
		pop	SI
		add	SI,0Ah
		jmp	short M003_L_77DC
M003_L_7839:
		mov	word ptr [BP+0FEF0h],0
		ret
BCC_NEAR_77D8	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7840

BCC_NEAR_7840	proc	near
M004_L_7840:
		cmp	DH,41h
		jne	short M004_L_7867
		mov	BX,word ptr [BP-1Eh]
		cmp	byte ptr CS:[BX],0AEh
		jne	short M004_L_7867
		mov	AL,byte ptr CS:[BX+2]
		mov	CX,5
		lea	BX,[BP-0Fh]
M004_L_7858:
		inc	BX
		cmp	byte ptr [BX],0
		loopnz	short M004_L_7858
		mov	AH,0
		mov	word ptr [BX],AX
		db	0E8h
		dw	0069Dh
		jmp	short M004_L_7840
M004_L_7867:
		ret
BCC_NEAR_7840	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7868

BCC_NEAR_7868	proc	near
		cmp	DH,41h
		jne	short M005_L_78A3
		mov	BX,word ptr [BP-1Eh]
		mov	AX,word ptr CS:[BX]
		cmp	AL,0EAh
		jne	short M005_L_78A3
		mov	byte ptr [BP-1Ah],AH
		cmp	word ptr [BP-0Eh],0
		je	short M005_L_7883
		db	0E9h
		dw	001A0h
M005_L_7883:
		db	0E8h
		dw	0067Ch
M005_L_7886:
		lea	SI,[BP+0FE6Ah]
		db	0E8h
		dw	001A0h
		push	DX
		db	0E8h
		dw	00013h
		db	0E8h
		dw	0FF44h
		pop	DX
		mov	AL,2Ch
		db	0E8h
		dw	00661h
		jne	short M005_L_7886
		mov	AL,3Bh
		db	0E8h
		dw	00653h
		xor	AX,AX
M005_L_78A3:
		ret
BCC_NEAR_7868	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_78A4

BCC_NEAR_78A4	proc	near
		mov	DI,SI
		mov	AX,word ptr [SI]
		mov	DX,word ptr [SI+2]
		mov	CX,word ptr [SI+8]
		or	CX,word ptr [SI+0Ah]
		cmp	byte ptr [BP-1Ah],2
		je	short M006_L_78E6
		ja	short M006_L_7911
		or	CX,CX
		je	short M006_L_78C0
		db	0E9h
		dw	0015Bh
M006_L_78C0:
		lea	SI,[BP+0FEF2h]
		cmp	byte ptr [SI],0
		jne	short M006_L_78D0
		db	0E8h
		dw	0101Ch
		jne	short M006_L_794D
		jmp	short M006_L_7945
M006_L_78D0:
		xor	AX,AX
		cld
		lodsb
		xchg	AX,CX
		jcxz	short M006_L_78E5
M006_L_78D7:
		cld
		lodsb
		push	SI
		push	CX
		db	0E8h
		dw	00067h
		db	0E8h
		dw	0FEF7h
		pop	CX
		pop	SI
		loop	short M006_L_78D7
M006_L_78E5:
		ret
M006_L_78E6:
		cmp	byte ptr [BP+0FEF2h],2
		ja	short M006_L_7950
		db	0E8h
		dw	01010h
		jcxz	short M006_L_7940
		mov	BX,101h
		cmp	byte ptr [SI+13h],BH
		jc	short M006_L_78FD
		mov	BH,byte ptr [SI+13h]
M006_L_78FD:
		xchg	AX,CX
		mov	AX,word ptr [BP+0FE72h]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [BP+0FE74h]
		mov	word ptr [BP+0FE80h],AX
		db	0E9h
		dw	010B9h
M006_L_7911:
		cmp	byte ptr [BP+0FEF2h],4
		ja	short M006_L_7950
		jcxz	short M006_L_793C
		xchg	AX,CX
		mov	BX,301h
		cmp	byte ptr [SI+13h],0
		je	short M006_L_7949
		mov	BH,byte ptr [SI+13h]
		mov	AX,word ptr [BP+0FE72h]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [BP+0FE74h]
		mov	word ptr [BP+0FE80h],AX
		db	0E8h
		dw	01090h
		jmp	short M006_L_793F
M006_L_793C:
		db	0E8h
		dw	00001h
M006_L_793F:
		xchg	AX,DX
M006_L_7940:
		db	0E8h
		dw	00002h
		xchg	AL,AH
M006_L_7945:
		mov	BL,0
		mov	CX,AX
M006_L_7949:
		db	0E8h
		dw	0107Eh
		ret
M006_L_794D:
		db	0E9h
		dw	000B3h
M006_L_7950:
		db	0E9h
		dw	000ACh
BCC_NEAR_78A4	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7953

BCC_NEAR_7953	proc	near
		db	0E8h
		dw	00607h
		cmp	AL,3Ah
		jne	short M007_L_796E
		lea	BX,[BP-6Ch]
		push	SS
		push	BX
		db	09Ah
		dw	X079_01
		dw	seg X079_01
		db	075h,07Ch
		db	0E8h
		dw	00599h
		mov	AL,3Ah
		db	0E8h
		dw	00586h
M007_L_796E:
		ret
BCC_NEAR_7953	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_796F

BCC_NEAR_796F	proc	near
		mov	byte ptr [BP-1Ch],0
		mov	AX,word ptr [BP-14h]
		mov	word ptr [BP-16h],AX
		mov	AL,3Bh
		db	0E8h
		dw	0057Dh
		jne	short M008_L_79E0
		lea	SI,[BP+0FE6Ah]
		db	0E8h
		dw	000A6h
		inc	byte ptr [BP-1Ch]
		mov	AL,3Bh
		db	0E8h
		dw	0056Ch
		jne	short M008_L_79E0
		mov	AL,2Ch
		db	0E8h
		dw	0055Eh
		mov	AX,word ptr [BP-14h]
		mov	word ptr [BP-18h],AX
		lea	SI,[BP+0FE56h]
		db	0E8h
		dw	0008Ah
		inc	byte ptr [BP-1Ch]
		lea	SI,[BP+0FE6Ah]
		lea	DI,[BP+0FE56h]
		mov	AX,word ptr [SI+0Ch]
		mov	CX,word ptr [DI+0Ch]
		mov	word ptr [BP-22h],CX
		jcxz	short M008_L_79C2
		or	AX,AX
		jne	short M008_L_79C5
		xchg	word ptr [SI+0Ch],CX
		jmp	short M008_L_79C5
M008_L_79C2:
		xchg	word ptr [DI+0Ch],AX
M008_L_79C5:
		mov	AL,3Bh
		db	0E8h
		dw	00531h
		jne	short M008_L_79E0
		mov	AL,2Ch
		db	0E8h
		dw	00523h
		lea	SI,[BP+0FE42h]
		db	0E8h
		dw	00055h
		inc	byte ptr [BP-1Ch]
		mov	AL,3Bh
		db	0E8h
		dw	00514h
M008_L_79E0:
		ret
BCC_NEAR_796F	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_79E1

BCC_NEAR_79E1	proc	near
M009_L_79E1:
		cbw
		push	word ptr [BP-14h]
		pop	word ptr [BP-12h]
		db	0E9h
		dw	0FDAAh
		mov	AL,0F1h
		jmp	short M009_L_79E1
		mov	AL,0F2h
		jmp	short M009_L_79E1
		mov	AL,0F3h
		jmp	short M009_L_79E1
		mov	AL,0F4h
		jmp	short M009_L_79E1
		mov	AL,0F5h
		jmp	short M009_L_79E1
		mov	AL,0F6h
		jmp	short M009_L_79E1
		mov	AL,0F7h
		jmp	short M009_L_79E1
		mov	AL,0F8h
		jmp	short M009_L_79E1
		mov	AL,0F9h
		jmp	short M009_L_79E1
		mov	AL,0FAh
		jmp	short M009_L_79E1
		mov	AL,0FBh
		jmp	short M009_L_79E1
		mov	AL,0FCh
		jmp	short M009_L_79E1
		mov	AL,0FDh
		jmp	short M009_L_79E1
M009_L_7A1F:
		mov	AL,0FEh
		jmp	short M009_L_79E1
		mov	AL,0FFh
		jmp	short M009_L_79E1
		cmp	SP,word ptr [BP-8]
		jbe	short M009_L_7A1F
		ret
BCC_NEAR_79E1	endp
		public	BCC_NEAR_79E2
BCC_NEAR_79E2	equ	BCC_NEAR_79E1+1
		public	BCC_NEAR_79EB
BCC_NEAR_79EB	equ	BCC_NEAR_79E1+10
		public	BCC_NEAR_79EF
BCC_NEAR_79EF	equ	BCC_NEAR_79E1+14
		public	BCC_NEAR_79F3
BCC_NEAR_79F3	equ	BCC_NEAR_79E1+18
		public	BCC_NEAR_79F7
BCC_NEAR_79F7	equ	BCC_NEAR_79E1+22
		public	BCC_NEAR_79FB
BCC_NEAR_79FB	equ	BCC_NEAR_79E1+26
		public	BCC_NEAR_79FF
BCC_NEAR_79FF	equ	BCC_NEAR_79E1+30
		public	BCC_NEAR_7A03
BCC_NEAR_7A03	equ	BCC_NEAR_79E1+34
		public	BCC_NEAR_7A07
BCC_NEAR_7A07	equ	BCC_NEAR_79E1+38
		public	BCC_NEAR_7A0B
BCC_NEAR_7A0B	equ	BCC_NEAR_79E1+42
		public	BCC_NEAR_7A13
BCC_NEAR_7A13	equ	BCC_NEAR_79E1+50
		public	BCC_NEAR_7A1B
BCC_NEAR_7A1B	equ	BCC_NEAR_79E1+58
		public	BCC_NEAR_7A23
BCC_NEAR_7A23	equ	BCC_NEAR_79E1+66
		public	BCC_NEAR_7A27
BCC_NEAR_7A27	equ	BCC_NEAR_79E1+70
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7A2D

BCC_NEAR_7A2D	proc	near
		db	0E8h
		dw	0FFF7h
		db	0E8h
		dw	00493h
		db	0E8h
		dw	0000Dh
		cmp	byte ptr [SI+12h],67h
		jne	short M00A_L_7A42
		test	byte ptr [SI+0Eh],40h
		db	074h,0D5h
M00A_L_7A42:
		ret
BCC_NEAR_7A2D	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7A43

BCC_NEAR_7A43	proc	near
		db	0E8h
		dw	00037h
M00B_L_7A46:
		mov	BX,326h
		db	0E8h
		dw	00454h
		je	short M00B_L_7A69
		db	0E8h
		dw	00491h
		db	0E8h
		dw	00468h
		db	0E8h
		dw	00026h
		db	0E8h
		dw	00488h
		db	0E8h
		dw	00478h
		mov	AX,word ptr [DI]
		mov	CX,word ptr [DI+2]
		call	BX
		add	SP,14h
		jmp	short M00B_L_7A46
M00B_L_7A69:
		ret
BCC_NEAR_7A43	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7A6A

BCC_NEAR_7A6A	proc	near
		or	word ptr [SI],AX
		or	word ptr [SI+2],CX
		ret
BCC_NEAR_7A6A	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7A70

BCC_NEAR_7A70	proc	near
		xor	word ptr [SI],AX
		xor	word ptr [SI+2],CX
		ret
BCC_NEAR_7A70	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7A76
BCC_TABLE_7A76	label	byte
		db	048h,0F4h,0FFh,049h,0FAh,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7A7D

BCC_NEAR_7A7D	proc	near
		db	0E8h
		dw	00026h
M00F_L_7A80:
		mov	AL,4Ah
		db	0E8h
		dw	00476h
		je	short M00F_L_7AA5
		db	0E8h
		dw	00458h
		db	0E8h
		dw	0042Fh
		db	0E8h
		dw	00016h
		db	0E8h
		dw	0044Fh
		db	0E8h
		dw	0043Fh
		mov	AX,word ptr [DI]
		and	word ptr [SI],AX
		mov	AX,word ptr [DI+2]
		and	word ptr [SI+2],AX
		add	SP,14h
		jmp	short M00F_L_7A80
M00F_L_7AA5:
		ret
BCC_NEAR_7A7D	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7AA6

BCC_NEAR_7AA6	proc	near
M010_L_7AA6:
		db	0E8h
		dw	0FF7Eh
		mov	BX,372h
		db	0E8h
		dw	003F1h
		db	074h,015h
		db	0E8h
		dw	0FFF2h
		db	0E8h
		dw	0042Bh
		not	word ptr [SI]
		not	word ptr [SI+2]
		mov	byte ptr [BP+0FEF2h],0
		ret
BCC_NEAR_7AA6	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7AC2
BCC_TABLE_7AC2	label	byte
		db	043h,000h,000h,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7AC6

BCC_NEAR_7AC6	proc	near
		db	0E8h
		dw	00038h
M012_L_7AC9:
		mov	BX,3AAh
		db	0E8h
		dw	003D1h
		je	short M012_L_7AF9
		db	0E8h
		dw	003E8h
		db	0E8h
		dw	0002Ah
		db	0E8h
		dw	003FBh
		call	BX
		add	SP,14h
		jmp	short M012_L_7AC9
		xchg	SI,DI
		db	0E8h
		dw	003F6h
		xchg	SI,DI
		neg	word ptr [DI]
		adc	word ptr [DI+2],0
		neg	word ptr [DI+2]
		db	0E8h
		dw	002CEh
		mov	byte ptr [BP+0FEF2h],0
M012_L_7AF9:
		ret
BCC_NEAR_7AC6	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7AFA
BCC_TABLE_7AFA	label	byte
		db	02Bh,0F7h,0FFh,02Dh,0E7h,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7B01

BCC_NEAR_7B01	proc	near
		db	0E8h
		dw	00073h
M014_L_7B04:
		mov	BX,417h
		db	0E8h
		dw	00396h
		je	short M014_L_7B53
		db	0E8h
		dw	003D3h
		db	0E8h
		dw	003AAh
		db	0E8h
		dw	00062h
		db	0E8h
		dw	003CAh
		db	0E8h
		dw	003BAh
		push	DX
		mov	AX,word ptr [SI]
		mov	DX,word ptr [SI+2]
		mov	CX,word ptr [DI]
		call	BX
		mov	word ptr [SI],AX
		mov	word ptr [SI+2],DX
		pop	DX
		add	SP,14h
		jmp	short M014_L_7B04
M014_L_7B30:
		neg	CX
		and	CX,803Fh
		js	short M014_L_7B41
		je	short M014_L_7B53
M014_L_7B3A:
		shr	DX,1
		rcr	AX,1
		loop	short M014_L_7B3A
		ret
M014_L_7B41:
		neg	CX
		jo	short M014_L_7B53
		and	CX,803Fh
		js	short M014_L_7B30
		je	short M014_L_7B53
M014_L_7B4D:
		shl	AX,1
		rcl	DX,1
		loop	short M014_L_7B4D
M014_L_7B53:
		ret
		mov	BX,word ptr [DI+2]
		db	0E9h
		dw	006C4h
M014_L_7B5A:
		mov	BX,word ptr [DI+2]
		db	0E9h
		dw	006D9h
		db	0E8h
		dw	0FFF7h
		xchg	AX,CX
		xchg	DX,BX
		ret
BCC_NEAR_7B01	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7B67
BCC_TABLE_7B67	label	byte
		db	02Ah,0EDh,0FFh,02Fh,0F3h,0FFh,04Bh,0F9h
		db	0FFh,04Ch,0CBh,0FFh,04Dh,0DEh,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7B77

BCC_NEAR_7B77	proc	near
M016_L_7B77:
		db	0E8h
		dw	0FEADh
		mov	BX,4D7h
		db	0E8h
		dw	00320h
		je	short M016_L_7B88
		push	BX
		db	0E8h
		dw	00340h
		jmp	short M016_L_7B77
M016_L_7B88:
		db	0E8h
		dw	000A6h
		mov	AL,50h
		db	0E8h
		dw	0036Bh
		jne	short M016_L_7BC1
		cmp	byte ptr [SI+10h],2
		jne	short M016_L_7BEA
		cmp	byte ptr [SI+12h],65h
		jne	short M016_L_7BEA
		mov	AL,3Ah
		db	0E8h
		dw	00358h
		je	short M016_L_7BEA
		push	word ptr [SI+11h]
		db	0E8h
		dw	0031Bh
		db	0E8h
		dw	0FFC9h
		pop	AX
		mov	CL,3
		shl	AL,CL
		or	AL,26h
		mov	byte ptr [SI+0Fh],AL
		or	byte ptr [SI+0Eh],40h
		db	0E8h
		dw	002A0h
		jmp	short M016_L_7BEA
M016_L_7BC1:
		db	0E8h
		dw	002F8h
		db	0E8h
		dw	0FFB0h
		db	0E8h
		dw	0030Bh
		push	word ptr [SI+0Ch]
		push	word ptr [SI+4]
		push	word ptr [SI+6]
		db	0E8h
		dw	001D9h
		pop	word ptr [SI+6]
		pop	word ptr [SI+4]
		pop	word ptr [SI+0Ch]
		mov	byte ptr [SI+12h],67h
		or	byte ptr [SI+0Eh],40h
		add	SP,14h
M016_L_7BEA:
		ret
BCC_NEAR_7B77	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7BEB

BCC_NEAR_7BEB	proc	near
		mov	byte ptr [SI+13h],1
		jmp	short M017_L_7C09
		mov	byte ptr [SI+13h],2
		mov	AX,word ptr [SI+2]
		mov	word ptr [SI],AX
		jmp	short M017_L_7C09
		mov	AX,word ptr [SI+0Ch]
		mov	word ptr [SI],AX
		xor	AX,AX
		mov	word ptr [SI+8],AX
		mov	word ptr [SI+0Ah],AX
M017_L_7C09:
		mov	byte ptr [SI+12h],64h
		xor	BX,BX
		mov	byte ptr [SI+0Eh],BL
		mov	byte ptr [SI+0Fh],BL
		mov	word ptr [SI+2],BX
		mov	word ptr [SI+0Ch],BX
		mov	AX,word ptr [SI+8]
		or	AX,word ptr [SI+0Ah]
		db	075h,0C7h
		mov	byte ptr [SI+13h],BL
		ret
BCC_NEAR_7BEB	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7C27
BCC_TABLE_7C27	label	byte
		db	044h,0C4h,0FFh,045h,0CAh,0FFh,046h,0D5h,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7C31

BCC_NEAR_7C31	proc	near
M019_L_7C31:
		mov	BX,501h
		db	0E8h
		dw	00269h
		db	074h,01Fh
		db	0E8h
		dw	0FDEBh
		push	BX
		jmp	short M019_L_7C31
		db	0E8h
		dw	0029Ah
		neg	word ptr [SI]
		adc	word ptr [SI+2],0
		neg	word ptr [SI+2]
		mov	byte ptr [BP+0FEF2h],0
		ret
BCC_NEAR_7C31	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7C51
BCC_TABLE_7C51	label	byte
		db	02Bh,0FAh,0FFh,02Dh,0EEh,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7C58

BCC_NEAR_7C58	proc	near
M01B_L_7C58:
		mov	BX,524h
		db	0E8h
		dw	00242h
		db	074h,01Bh
		db	0E8h
		dw	0FDC4h
		push	BX
		jmp	short M01B_L_7C58
		mov	CL,8
		ror	word ptr [SI],CL
		mov	byte ptr [SI+1],0
		mov	word ptr [SI+2],0
		ret
BCC_NEAR_7C58	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7C74
BCC_TABLE_7C74	label	byte
		db	04Eh,0F2h,0FFh,04Fh,0F6h,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7C7B

BCC_NEAR_7C7B	proc	near
		db	0E8h
		dw	0FDA9h
		db	0E8h
		dw	00066h
		cmp	DH,2Eh
		db	074h,026h
		cmp	DH,5Bh
		db	074h,006h
		cmp	DH,28h
		db	074h,001h
		ret
BCC_NEAR_7C7B	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7C91

BCC_NEAR_7C91	proc	near
		db	0E8h
		dw	00228h
		db	0E8h
		dw	00050h
		db	0E8h
		dw	0023Bh
		mov	CX,word ptr [SI+0Ch]
		jcxz	short M01E_L_7CA4
		mov	word ptr [DI+0Ch],0
M01E_L_7CA4:
		db	0E8h
		dw	0011Bh
		add	SP,14h
		db	0EBh,0D5h
		mov	AX,word ptr [SI+4]
		mov	word ptr [BP-3Ah],AX
		mov	AX,word ptr [SI+6]
		mov	word ptr [BP-38h],AX
		xor	AX,AX
		mov	word ptr [SI+4],AX
		mov	word ptr [SI+6],AX
		db	0E8h
		dw	0023Fh
		db	0E8h
		dw	001F6h
		db	0E8h
		dw	0FEAEh
		db	0E8h
		dw	00209h
		cmp	byte ptr [DI+12h],65h
		jne	short M01E_L_7CD5
		db	0E9h
		dw	0FD16h
M01E_L_7CD5:
		mov	CX,word ptr [DI+0Ch]
		jcxz	short M01E_L_7CDF
		mov	word ptr [SI+0Ch],0
M01E_L_7CDF:
		db	0E8h
		dw	000E0h
		add	SP,14h
		db	0EBh,09Ah
M01E_L_7CE7:
		mov	BX,5B4h
		db	0E8h
		dw	001B3h
		db	074h,01Ch
		push	BX
		db	0E8h
		dw	0FD50h
		ret
BCC_NEAR_7C91	endp
		public	BCC_NEAR_7CE7
BCC_NEAR_7CE7	equ	BCC_NEAR_7C91+86
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7CF4

BCC_NEAR_7CF4	proc	near
		mov	AL,29h
		jmp	short M01F_L_7D01
		db	0E8h
		dw	00164h
		or	byte ptr [SI+0Eh],40h
		mov	AL,5Dh
M01F_L_7D01:
		db	0E9h
		dw	001F0h
BCC_NEAR_7CF4	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7D04
BCC_TABLE_7D04	label	byte
		db	028h,0F0h,0FFh,05Bh,0F4h,0FFh,000h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7D0B

BCC_NEAR_7D0B	proc	near
		db	0E8h
		dw	00003h
		db	0E9h
		dw	001F1h
M021_L_7D11:
		mov	byte ptr [SI+12h],DH
		cmp	DH,65h
		je	short M021_L_7D2B
		cmp	DH,64h
		db	074h,02Bh
		cmp	DH,6Bh
		db	074h,032h
		cmp	DH,66h
		db	074h,016h
		db	0E9h
		dw	0FCF8h
M021_L_7D2B:
		mov	AX,word ptr [BP-20h]
		mov	word ptr [SI+10h],AX
		dec	AL
		js	short M021_L_7D3A
		jne	short M021_L_7D3D
		inc	word ptr [SI+0Ch]
M021_L_7D3A:
		inc	word ptr [SI+0Ch]
M021_L_7D3D:
		ret
BCC_NEAR_7D0B	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7D3E

BCC_NEAR_7D3E	proc	near
		mov	byte ptr [SI+12h],64h
		mov	AX,word ptr [BP-36h]
		mov	word ptr [SI+0Ch],AX
		ret
BCC_NEAR_7D3E	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7D49

BCC_NEAR_7D49	proc	near
		mov	AX,word ptr [BP-36h]
		mov	word ptr [SI],AX
		mov	AX,word ptr [BP-34h]
		mov	word ptr [SI+2],AX
		ret
BCC_NEAR_7D49	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7D55

BCC_NEAR_7D55	proc	near
		mov	byte ptr [SI+12h],67h
		mov	AX,word ptr [BP-3Eh]
		mov	word ptr [SI+0Ch],AX
		mov	AX,word ptr [BP-42h]
		mov	word ptr [SI],AX
		mov	AX,word ptr [BP-40h]
		mov	word ptr [SI+2],AX
		mov	AX,word ptr [BP-3Ah]
		mov	word ptr [SI+4],AX
		mov	AX,word ptr [BP-38h]
		mov	word ptr [SI+6],AX
		xor	AX,AX
		mov	word ptr [BP-3Ah],AX
		mov	word ptr [BP-38h],AX
		mov	AX,word ptr [BP-46h]
		mov	CX,word ptr [BP-44h]
		inc	CX
		db	074h,016h
		dec	CX
		mov	word ptr [SI+8],AX
		mov	word ptr [SI+0Ah],CX
		test	byte ptr [BP-3Ch],1
		je	short M024_L_7D98
		mov	byte ptr [SI+0Fh],2Eh
M024_L_7D98:
		or	byte ptr [SI+0Eh],40h
		ret
BCC_NEAR_7D55	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7D9D

BCC_NEAR_7D9D	proc	near
		cmp	AX,0FFFEh
		db	072h,007h
		db	074h,009h
		mov	byte ptr [SI+12h],64h
		ret
BCC_NEAR_7D9D	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7DA9

BCC_NEAR_7DA9	proc	near
		mov	byte ptr [SI+0Eh],4
		db	0EBh,0E9h
		push	DS
		pop	ES
		xchg	SI,DI
		mov	CX,0Ah
		cld
		rep	movsw
		sub	SI,14h
		sub	DI,14h
		xchg	SI,DI
		ret
BCC_NEAR_7DA9	endp
		public	BCC_NEAR_7DAF
BCC_NEAR_7DAF	equ	BCC_NEAR_7DA9+6
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7DC2

BCC_NEAR_7DC2	proc	near
		push	DX
		cmp	byte ptr [DI+12h],64h
		jne	short M027_L_7DE6
		cmp	byte ptr [SI+12h],64h
		je	short M027_L_7DF0
		cmp	byte ptr [SI+12h],65h
		jne	short M027_L_7DE6
		cmp	byte ptr [SI+10h],4
		jne	short M027_L_7DE6
		mov	AX,word ptr [DI]
		add	byte ptr [SI+11h],AL
		and	byte ptr [SI+11h],7
		jmp	short M027_L_7E5D
M027_L_7DE6:
		db	0E8h
		dw	00076h
		xchg	SI,DI
		db	0E8h
		dw	00071h
		xchg	SI,DI
M027_L_7DF0:
		mov	AX,word ptr [DI]
		mov	BX,word ptr [DI+2]
		add	word ptr [SI],AX
		adc	word ptr [SI+2],BX
		mov	AX,word ptr [DI+4]
		mov	DX,word ptr [DI+6]
		or	AX,DX
		je	short M027_L_7E10
		mov	AX,word ptr [DI+4]
		mov	word ptr [SI+4],AX
		mov	AX,word ptr [DI+6]
		mov	word ptr [SI+6],AX
M027_L_7E10:
		mov	CL,byte ptr [DI+13h]
		mov	BX,word ptr [DI+8]
		mov	DX,word ptr [DI+0Ah]
		mov	AX,DX
		or	AX,BX
		je	short M027_L_7E2F
		mov	byte ptr [SI+13h],CL
		xchg	word ptr [SI+8],BX
		xchg	word ptr [SI+0Ah],DX
		or	BX,DX
		je	short M027_L_7E2F
		db	0E9h
		dw	0FBDCh
M027_L_7E2F:
		mov	CX,word ptr [DI+0Ch]
		jcxz	short M027_L_7E37
		xchg	word ptr [SI+0Ch],CX
M027_L_7E37:
		mov	AL,byte ptr [DI+0Eh]
		mov	AH,AL
		and	AH,byte ptr [SI+0Eh]
		or	byte ptr [SI+0Eh],AL
		and	AH,0Fh
		je	short M027_L_7E4A
		db	0E9h
		dw	0FBBDh
M027_L_7E4A:
		mov	AL,byte ptr [DI+0Fh]
		or	AL,AL
		je	short M027_L_7E5D
		cmp	byte ptr [SI+0Fh],0
		jns	short M027_L_7E5A
		db	0E9h
		dw	0FBC9h
M027_L_7E5A:
		mov	byte ptr [SI+0Fh],AL
M027_L_7E5D:
		pop	DX
		ret
BCC_NEAR_7DC2	endp
CODE8	ends



		extrn	BCC_NEAR_7A17:near


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7E5F

BCC_NEAR_7E5F	proc	near
		cmp	byte ptr [SI+12h],64h
		je	short M028_L_7E90
		cmp	byte ptr [SI+12h],65h
		jne	short M028_L_7E87
		cmp	byte ptr [SI+10h],1
		db	075h,02Ch
		xor	BX,BX
		add	BL,byte ptr [SI+11h]
		add	BH,byte ptr CS:[BX+745h]
		db	078h,020h
		mov	byte ptr [SI+0Eh],BH
		mov	word ptr [SI+0Ch],0
		jmp	short M028_L_7E90
M028_L_7E87:
		cmp	byte ptr [SI+12h],67h
		je	short M028_L_7E90
		db	0E9h
		dw	0FB87h
M028_L_7E90:
		mov	byte ptr [SI+12h],67h
		ret
BCC_NEAR_7E5F	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_TABLE_7E95
BCC_TABLE_7E95	label	byte
		db	0FFh,0FFh,0FFh,008h,0FFh,004h,002h,001h
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7E9D

BCC_NEAR_7E9D	proc	near
		db	0E9h
		dw	0FB67h
BCC_NEAR_7E9D	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7EA0

BCC_NEAR_7EA0	proc	near
		mov	CX,BX
M02B_L_7EA2:
		mov	AL,byte ptr CS:[BX]
		add	BX,3
		or	AL,AL
		je	short M02B_L_7EBB
		cmp	AL,DH
		jne	short M02B_L_7EA2
		mov	BX,word ptr CS:[BX-2]
		add	BX,CX
		db	0E8h
		dw	00049h
		or	BX,BX
M02B_L_7EBB:
		ret
BCC_NEAR_7EA0	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7EBC

BCC_NEAR_7EBC	proc	near
		pop	CX
		sub	SP,14h
		mov	AX,SP
		push	SI
		push	BX
		xchg	AX,SI
		push	CX
		push	DS
		pop	ES
		xor	AX,AX
		mov	CX,0Ah
		push	DI
		lea	DI,[SI]
		cld
		rep	stosw
		pop	DI
		ret
BCC_NEAR_7EBC	endp
		public	BCC_NEAR_7EC6
BCC_NEAR_7EC6	equ	BCC_NEAR_7EBC+10
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7ED5

BCC_NEAR_7ED5	proc	near
		pop	AX
		pop	BX
		pop	SI
		mov	DI,SP
		push	AX
		ret
BCC_NEAR_7ED5	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7EDC

BCC_NEAR_7EDC	proc	near
		cmp	byte ptr [SI+12h],67h
		je	short M02E_L_7EE8
		cmp	byte ptr [SI+12h],64h
		db	075h,009h
M02E_L_7EE8:
		mov	AX,word ptr [SI+8]
		or	AX,word ptr [SI+0Ah]
		db	075h,001h
		ret
BCC_NEAR_7EDC	endp
		public	BCC_NEAR_7EE2
BCC_NEAR_7EE2	equ	BCC_NEAR_7EDC+6
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7EF1

BCC_NEAR_7EF1	proc	near
		db	0E9h
		dw	0FB1Fh
BCC_NEAR_7EF1	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7EF4

BCC_NEAR_7EF4	proc	near
		cmp	AL,DH
		db	074h,00Ah
		db	0E9h
		dw	0FB28h
		cmp	AL,DH
		db	074h,003h
		xor	AX,AX
		ret
BCC_NEAR_7EF4	endp
		public	BCC_NEAR_7EFB
BCC_NEAR_7EFB	equ	BCC_NEAR_7EF4+7
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7F02

BCC_NEAR_7F02	proc	near
		mov	DH,3Bh
		cmp	word ptr [BP+8],0
		jbe	short M031_L_7F36
		push	SI
		push	DI
		push	BX
		db	0E8h
		dw	0005Bh
		cmp	byte ptr [BP-1Bh],1
		jne	short M031_L_7F1B
		db	0E8h
		dw	0029Eh
		jne	short M031_L_7F33
M031_L_7F1B:
		db	0E8h
		dw	0019Eh
		jne	short M031_L_7F33
		db	0E8h
		dw	002A2h
		jne	short M031_L_7F33
		db	0E8h
		dw	001A7h
		jne	short M031_L_7F33
		cmp	byte ptr [BP-1Bh],1
		je	short M031_L_7F33
		db	0E8h
		dw	00147h
M031_L_7F33:
		pop	BX
		pop	DI
		pop	SI
M031_L_7F36:
		sub	DH,1
		adc	DH,1
		ret
BCC_NEAR_7F02	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7F3D

BCC_NEAR_7F3D	proc	near
		inc	word ptr [BP-12h]
		dec	word ptr [BP+8]
		xor	AX,AX
		cmp	word ptr [BP+8],AX
		db	076h,009h
		les	BX,[BP-12h]
		add	AL,byte ptr ES:[BX]
		db	074h,001h
		ret
BCC_NEAR_7F3D	endp
		public	BCC_NEAR_7F43
BCC_NEAR_7F43	equ	BCC_NEAR_7F3D+6
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_7F53

BCC_NEAR_7F53	proc	near
		mov	word ptr [BP+8],AX
		ret
BCC_NEAR_7F53	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7F57

BCC_NEAR_7F57	proc	near
M034_L_7F57:
		inc	word ptr [BP-12h]
		dec	word ptr [BP+8]
		db	0E8h
		dw	0FFE3h
		je	short M034_L_7F6A
		cmp	AL,20h
		jbe	short M034_L_7F57
		cmp	AL,7Fh
		jnc	short M034_L_7F57
M034_L_7F6A:
		ret
BCC_NEAR_7F57	endp
		public	BCC_NEAR_7F5D
BCC_NEAR_7F5D	equ	BCC_NEAR_7F57+6
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_7F6B

BCC_NEAR_7F6B	proc	near
		xor	AX,AX
		mov	word ptr [BP-6Ch],AX
		mov	word ptr [BP+0FF72h],AX
		mov	byte ptr [BP-23h],AL
		db	0E8h
		dw	0FFE3h
		mov	word ptr [BP-14h],BX
		je	short M035_L_7FEE
		db	0E8h
		dw	000C1h
		jnc	short M035_L_7FC8
M035_L_7F84:
		mov	SI,word ptr [BP-6Ch]
		and	SI,0FFh
		cmp	SI,20h
		je	short M035_L_7FA8
		inc	byte ptr [BP-6Ch]
		inc	byte ptr [BP+0FF72h]
		mov	word ptr [BP+SI-6Bh],AX
		cmp	AL,61h
		jc	short M035_L_7FA0
		and	AL,5Fh
M035_L_7FA0:
		mov	word ptr [BP+SI+0FF73h],AX
		dec	AX
		add	byte ptr [BP-23h],AL
M035_L_7FA8:
		db	0E8h
		dw	0FF92h
		je	short M035_L_7FB2
		db	0E8h
		dw	00093h
		jc	short M035_L_7F84
M035_L_7FB2:
		mov	byte ptr [BP-19h],1
		cmp	word ptr [BP+0FF72h],4503h
		jne	short M035_L_8002
		cmp	word ptr [BP+0FF74h],444Eh
		je	short M035_L_7FEE
		jmp	short M035_L_8002
M035_L_7FC8:
		mov	byte ptr [BP-19h],2
		db	0E8h
		dw	00034h
		je	short M035_L_8002
		mov	byte ptr [BP-19h],0
		inc	byte ptr [BP-6Ch]
		mov	word ptr [BP-6Bh],AX
		cmp	AL,3Bh
		je	short M035_L_7FEE
		cmp	AL,7Bh
		je	short M035_L_7FEE
		xchg	AX,DX
		db	0E8h
		dw	0FF56h
		mov	AH,DL
		cmp	AX,282Ah
		jne	short M035_L_8002
M035_L_7FEE:
		mov	byte ptr [BP-19h],0
		mov	word ptr [BP-6Ch],3B01h
		mov	word ptr [BP+8],0
		mov	AX,word ptr [BP-14h]
		mov	word ptr [BP-12h],AX
M035_L_8002:
		ret
BCC_NEAR_7F6B	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_8003

BCC_NEAR_8003	proc	near
		mov	CL,AL
		cmp	AL,27h
		db	074h,005h
		cmp	AL,22h
		db	074h,001h
		ret
BCC_NEAR_8003	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_800E

BCC_NEAR_800E	proc	near
		mov	byte ptr [BP+0FEF2h],0
		jmp	short M037_L_802D
M037_L_8015:
		mov	SI,word ptr [BP+0FEF2h]
		and	SI,0FFh
		cmp	SI,7Fh
		jne	short M037_L_8025
		db	0E9h
		dw	0F9DAh
M037_L_8025:
		inc	byte ptr [BP+0FEF2h]
		mov	byte ptr [BP+SI+0FEF3h],AL
M037_L_802D:
		db	0E8h
		dw	0FF0Dh
		jne	short M037_L_8035
		db	0E9h
		dw	0F9CAh
M037_L_8035:
		cmp	AL,CL
		jne	short M037_L_8015
		db	0E8h
		dw	0FF01h
		cmp	AL,CL
		je	short M037_L_8015
		xor	AX,AX
		ret
BCC_NEAR_800E	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8043

BCC_NEAR_8043	proc	near
		db	0E8h
		dw	0000Ah
		db	073h,001h
		ret
BCC_NEAR_8043	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_8049

BCC_NEAR_8049	proc	near
		push	AX
		sub	AL,3Ah
		add	AL,0Ah
		pop	AX
		ret
BCC_NEAR_8049	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8050

BCC_NEAR_8050	proc	near
		db	0E8h
		dw	0001Ah
		jc	short M03A_L_806B
		cmp	AL,5Fh
		je	short M03A_L_806B
		cmp	AL,24h
		je	short M03A_L_806B
		cmp	AL,40h
		je	short M03A_L_806B
		cmp	AL,26h
		je	short M03A_L_806B
		cmp	AL,3Fh
		je	short M03A_L_806B
		clc
		ret
M03A_L_806B:
		stc
		ret
BCC_NEAR_8050	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_806D

BCC_NEAR_806D	proc	near
		push	AX
		sub	AL,5Bh
		add	AL,1Ah
		jc	short M03B_L_8078
		sub	AL,3Ah
		add	AL,1Ah
M03B_L_8078:
		pop	AX
		ret
BCC_NEAR_806D	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_807A

BCC_NEAR_807A	proc	near
		lea	BX,[BP-6Ch]
		mov	AX,word ptr [BX]
		cmp	AH,26h
		jne	short M03C_L_808E
		inc	BX
		dec	AL
		jne	short M03C_L_808C
		db	0E9h
		dw	0F997h
M03C_L_808C:
		mov	byte ptr [BX],AL
M03C_L_808E:
		push	SS
		push	BX
		lea	BX,[BP-4Ah]
		push	SS
		push	BX
		mov	AX,word ptr [BP-3Ah]
		mov	word ptr [BP-4Ah],AX
		mov	AX,word ptr [BP-38h]
		mov	word ptr [BP-48h],AX
		db	09Ah
		dw	X079_05
		dw	seg X079_05
		or	AX,AX
		je	short M03C_L_80AD
		db	0E9h
		dw	0F935h
M03C_L_80AD:
		mov	AX,word ptr [BP-4Ah]
		mov	word ptr [BP-3Ah],AX
		mov	AX,word ptr [BP-48h]
		mov	word ptr [BP-38h],AX
		mov	DH,6Bh
		ret
BCC_NEAR_807A	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_80BC

BCC_NEAR_80BC	proc	near
		cmp	byte ptr [BP-19h],0
		jne	short M03D_L_80CA
		mov	DX,word ptr [BP-6Ch]
		cmp	DL,1
		je	short M03D_L_80CC
M03D_L_80CA:
		xor	DX,DX
M03D_L_80CC:
		or	DH,DH
		ret
BCC_NEAR_80BC	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_80CF

BCC_NEAR_80CF	proc	near
		cmp	byte ptr [BP-19h],1
		db	074h,024h
		db	077h,003h
		xor	AX,AX
		ret
BCC_NEAR_80CF	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_80DA

BCC_NEAR_80DA	proc	near
		lea	SI,[BP+0FEF2h]
		xor	AX,AX
		xor	DI,DI
		cwd
		cld
		lodsb
		xchg	AX,CX
		jcxz	short M03F_L_8151
M03F_L_80E8:
		and	DI,0FFh
		db	0E8h
		dw	000B2h
		db	0E8h
		dw	000AFh
		lodsb
		mov	DL,AL
		loop	short M03F_L_80E8
		jmp	short M03F_L_8151
		mov	byte ptr [BP+0FEF2h],0
		xor	CX,CX
		mov	CL,byte ptr [BP+0FF72h]
		mov	AX,word ptr [BP+0FF73h]
		mov	SI,1
		cmp	AL,24h
		je	short M03F_L_813A
		dec	SI
		db	0E8h
		dw	0FF36h
		db	073h,0C2h
		mov	DI,CX
		mov	AL,byte ptr [BP+DI+0FF72h]
		db	0E8h
		dw	0FF2Bh
		mov	BX,0A1Eh
		jc	short M03F_L_813F
		dec	CX
		cmp	AL,44h
		je	short M03F_L_813F
		mov	BX,0A0Ch
		cmp	AL,42h
		je	short M03F_L_813F
		mov	BX,0A15h
		cmp	AL,4Fh
		je	short M03F_L_813F
		cmp	AL,48h
		db	075h,077h
M03F_L_813A:
		sub	CX,SI
		mov	BX,0A27h
M03F_L_813F:
		xor	DI,DI
		xor	DX,DX
M03F_L_8143:
		jcxz	short M03F_L_8151
		dec	CX
		inc	SI
		xor	AX,AX
		mov	AL,byte ptr [BP+SI+0FF72h]
		call	BX
		jmp	short M03F_L_8143
M03F_L_8151:
		mov	word ptr [BP-36h],DX
		mov	word ptr [BP-34h],DI
		mov	DH,64h
		or	DH,DH
		ret
BCC_NEAR_80DA	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_815C

BCC_NEAR_815C	proc	near
		db	0E8h
		dw	0004Bh
		sub	AL,32h
		add	AL,2
		jmp	short M040_L_8184
		db	0E8h
		dw	0003Ch
		sub	AL,38h
		add	AL,8
		jmp	short M040_L_8184
		db	0E8h
		dw	0001Dh
		sub	AL,3Ah
		add	AL,0Ah
		jmp	short M040_L_8184
		db	0E8h
		dw	00027h
		cmp	AL,3Ah
		jc	short M040_L_8180
		sub	AL,7
M040_L_8180:
		sub	AL,40h
		add	AL,10h
M040_L_8184:
		db	073h,02Bh
		add	DX,AX
		adc	DI,0
		db	072h,027h
		ret
BCC_NEAR_815C	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_818E

BCC_NEAR_818E	proc	near
		push	AX
		db	0E8h
		dw	00018h
		push	DI
		push	DX
		db	0E8h
		dw	00010h
		pop	AX
		add	DX,AX
		pop	AX
		add	DI,AX
		db	072h,015h
		pop	AX
		ret
BCC_NEAR_818E	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_81A1

BCC_NEAR_81A1	proc	near
		db	0E8h
		dw	00006h
		db	0E8h
		dw	00003h
		db	0E8h
		dw	00000h
M042_L_81AA:
		add	DX,DX
		adc	DI,DI
		db	072h,004h
		ret
BCC_NEAR_81A1	endp
		public	BCC_NEAR_81A4
BCC_NEAR_81A4	equ	BCC_NEAR_81A1+3
		public	BCC_NEAR_81A7
BCC_NEAR_81A7	equ	BCC_NEAR_81A1+6
		public	BCC_NEAR_81AA
BCC_NEAR_81AA	equ	BCC_NEAR_81A1+9
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_81B1

BCC_NEAR_81B1	proc	near
		db	0E9h
		dw	0F847h
		db	0E9h
		dw	0F84Ch
		db	0E8h
		dw	00956h
		db	0E8h
		dw	00026h
		je	short M043_L_81C4
		mov	word ptr [BP-1Eh],DI
		mov	DH,41h
M043_L_81C4:
		ret
BCC_NEAR_81B1	endp
		public	BCC_NEAR_81B7
BCC_NEAR_81B7	equ	BCC_NEAR_81B1+6
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_81C5

BCC_NEAR_81C5	proc	near
		db	0E8h
		dw	013DEh
		db	0E8h
		dw	00018h
		je	short M044_L_81E2
		mov	DH,byte ptr CS:[DI]
		inc	DI
		mov	AX,word ptr CS:[DI]
		mov	word ptr [BP-20h],AX
		mov	word ptr [BP-36h],AX
		add	AX,AX
		sbb	AX,AX
		mov	word ptr [BP-34h],AX
		dec	AX
M044_L_81E2:
		ret
BCC_NEAR_81C5	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_81E3

BCC_NEAR_81E3	proc	near
		cmp	byte ptr [BP-19h],1
		jne	short M045_L_8219
		cld
		push	CS
		pop	ES
		mov	BL,byte ptr [BP-23h]
		add	BL,BL
		and	BX,word ptr ES:[DI]
		mov	BX,word ptr ES:[BX+DI+2]
		or	BX,BX
		je	short M045_L_8219
		lea	AX,[BP+0FF72h]
		mov	DL,byte ptr [BP+0FF72h]
		mov	DH,0
		inc	DX
M045_L_8207:
		lea	DI,[BX+2]
		mov	SI,AX
		mov	CX,DX
		repe cmpsb
		je	short M045_L_821B
		mov	BX,word ptr ES:[BX]
		or	BX,BX
		jne	short M045_L_8207
M045_L_8219:
		xor	DI,DI
M045_L_821B:
		or	DI,DI
		ret
BCC_NEAR_81E3	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_821E

BCC_NEAR_821E	proc	near
		push	SI
		push	DI
		mov	SI,AX
		mov	DI,DX
		mul	CX
		push	AX
		push	DX
		mov	AX,SI
		mul	BX
		xchg	AX,BX
		xchg	AX,DI
		mul	CX
		pop	DX
		add	DX,BX
		add	DX,AX
		pop	AX
		pop	DI
		pop	SI
		ret
BCC_NEAR_821E	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8239

BCC_NEAR_8239	proc	near
		push	SI
		push	DI
		push	BP
		mov	SI,CX
		or	SI,BX
		jne	short M047_L_8245
		db	0E9h
		dw	0F7AAh
M047_L_8245:
		or	BX,BX
		pushf
		jns	short M047_L_8251
		neg	CX
		adc	BX,0
		neg	BX
M047_L_8251:
		or	DX,DX
		pushf
		jns	short M047_L_825D
		neg	AX
		adc	DX,0
		neg	DX
M047_L_825D:
		mov	SI,CX
		mov	DI,BX
		xor	CX,CX
		xor	BX,BX
		mov	BP,21h
M047_L_8268:
		rcl	CX,1
		rcl	BX,1
		sub	CX,SI
		sbb	BX,DI
		jnc	short M047_L_8276
		add	CX,SI
		adc	BX,DI
M047_L_8276:
		cmc
		rcl	AX,1
		rcl	DX,1
		dec	BP
		jne	short M047_L_8268
		popf
		jns	short M047_L_828D
		neg	CX
		adc	BX,0
		neg	BX
		popf
		jns	short M047_L_8290
		jmp	short M047_L_8297
M047_L_828D:
		popf
		jns	short M047_L_8297
M047_L_8290:
		neg	AX
		adc	DX,0
		neg	DX
M047_L_8297:
		pop	BP
		pop	DI
		pop	SI
		ret
BCC_NEAR_8239	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8
		public	BCC_BYTES_829B
BCC_BYTES_829B	label	byte
		db	0
CODE8	ends




CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_829C

BCC_NEAR_829C	proc	near
M049_L_829C:
		xor	AX,AX
		mov	word ptr [BP+0FEF0h],AX
		mov	byte ptr [BP-25h],AL
		mov	byte ptr [BP-2Dh],AL
		mov	byte ptr [BP-2Eh],AL
		mov	BX,word ptr [BP-1Eh]
		mov	BX,word ptr CS:[BX]
		mov	CL,6
		shr	BH,CL
		cmp	BH,byte ptr [BP-1Ch]
		jne	short M049_L_82D2
		lea	SI,[BP+0FE6Ah]
		lea	DI,[BP+0FE56h]
		mov	AH,byte ptr [SI+12h]
		mov	AL,byte ptr [DI+12h]
		and	BX,7Eh
		call	word ptr CS:[BX+1354h]
		je	short M049_L_82E3
M049_L_82D2:
		db	0E8h
		dw	007BFh
		test	byte ptr CS:[BX],80h
		je	short M049_L_8300
		add	AX,2
		add	word ptr [BP-1Eh],AX
		jmp	short M049_L_829C
M049_L_82E3:
		mov	BX,word ptr [BP-1Eh]
		test	byte ptr CS:[BX+1],4
		je	short M049_L_82FC
		test	byte ptr [BP+6],3
		jne	short M049_L_82FC
		mov	AX,word ptr [BP-16h]
		mov	word ptr [BP-14h],AX
		db	0E9h
		dw	0F6F7h
M049_L_82FC:
		db	0E8h
		dw	0066Bh
		ret
M049_L_8300:
		mov	AX,word ptr [BP-16h]
		cmp	byte ptr [BP-1Ch],1
		jle	short M049_L_830C
		mov	AX,word ptr [BP-18h]
M049_L_830C:
		mov	word ptr [BP-14h],AX
		jle	short M049_L_831E
		mov	AX,word ptr [BP+0FE76h]
		cmp	AX,word ptr [BP+0FE62h]
		je	short M049_L_831E
		db	0E9h
		dw	0F6FDh
M049_L_831E:
		db	0E9h
		dw	0F6D6h
BCC_NEAR_829C	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8321

BCC_NEAR_8321	proc	near
		db	0E8h
		dw	00607h
		xor	AX,AX
		ret
BCC_NEAR_8321	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8327

BCC_NEAR_8327	proc	near
		db	0E9h
		dw	0F6F9h
BCC_NEAR_8327	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_832A

BCC_NEAR_832A	proc	near
		db	0E8h
		dw	004E5h
		jne	short M04C_L_8335
		db	0E8h
		dw	005F9h
		db	0E8h
		dw	006EDh
M04C_L_8335:
		ret
BCC_NEAR_832A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8336

BCC_NEAR_8336	proc	near
		db	0E8h
		dw	004E1h
		jne	short M04D_L_8345
		cmp	AL,0FFh
		jne	short M04D_L_8345
		db	0E8h
		dw	005E9h
		db	0E8h
		dw	006DDh
M04D_L_8345:
		ret
BCC_NEAR_8336	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8346

BCC_NEAR_8346	proc	near
		cmp	AH,67h
		jne	short M04E_L_8376
		cmp	word ptr [SI+0Ch],-3
		jne	short M04E_L_8376
		mov	AX,word ptr [SI]
		or	AX,word ptr [SI+2]
		jne	short M04E_L_8376
		db	0E8h
		dw	005FEh
		db	0E8h
		dw	00736h
		mov	CL,byte ptr CS:[BX+2]
		mov	BX,2
		mov	AX,word ptr [SI+8]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [SI+0Ah]
		mov	word ptr [BP+0FE80h],AX
		db	0E8h
		dw	00654h
M04E_L_8376:
		ret
BCC_NEAR_8346	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8377

BCC_NEAR_8377	proc	near
		mov	BH,0
		mov	CX,0FFFDh
		cmp	word ptr [SI+0Ch],CX
		je	short M04F_L_838A
		mov	CL,0FFh
		jmp	short M04F_L_838A
		mov	BH,3
		mov	CX,0FFFEh
M04F_L_838A:
		cmp	word ptr [SI+0Ch],CX
		jne	short M04F_L_83C3
		cmp	AH,67h
		jne	short M04F_L_83C3
		cmp	byte ptr [SI+0Eh],40h
		jne	short M04F_L_83C3
		push	BX
		db	0E8h
		dw	005BBh
		db	0E8h
		dw	006F3h
		mov	CL,byte ptr CS:[BX+2]
		mov	BL,0
		db	0E8h
		dw	00620h
		pop	BX
		mov	BL,1
		mov	CX,word ptr [SI]
		mov	DX,word ptr [SI+2]
		mov	AX,word ptr [SI+8]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [SI+0Ah]
		mov	word ptr [BP+0FE80h],AX
		db	0E8h
		dw	00607h
M04F_L_83C3:
		ret
BCC_NEAR_8377	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_83C4

BCC_NEAR_83C4	proc	near
		db	0E8h
		dw	00443h
		db	075h,036h
		db	0E8h
		dw	0055Fh
		db	0E8h
		dw	00519h
		jne	short M050_L_83EB
		cmp	AL,1
		je	short M050_L_83FC
		test	byte ptr [BP+6],3
		jne	short M050_L_83DE
		db	0E9h
		dw	0F615h
M050_L_83DE:
		sub	byte ptr [BP-24h],10h
		push	AX
		db	0E8h
		dw	00640h
		pop	AX
		db	0E8h
		dw	005D1h
		ret
M050_L_83EB:
		cmp	byte ptr [DI+12h],65h
		db	075h,00Eh
		cmp	word ptr [DI+10h],100h
		db	075h,007h
		add	byte ptr [BP-24h],2
M050_L_83FC:
		db	0E8h
		dw	00627h
		ret
BCC_NEAR_83C4	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8400

BCC_NEAR_8400	proc	near
		xchg	AL,AH
		xchg	SI,DI
		cmp	AX,6565h
		jne	short M051_L_8420
		cmp	word ptr [SI+10h],1
		jne	short M051_L_8420
		cmp	byte ptr [DI+10h],1
		jne	short M051_L_8420
		db	0E8h
		dw	00513h
		mov	AL,byte ptr [DI+11h]
		or	byte ptr [BP-24h],AL
		xor	AX,AX
M051_L_8420:
		ret
BCC_NEAR_8400	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8421

BCC_NEAR_8421	proc	near
		xchg	SI,DI
		db	0E8h
		dw	00505h
		db	0E8h
		dw	00561h
		jne	short M052_L_8430
		xchg	SI,DI
		db	0E8h
		dw	00580h
M052_L_8430:
		ret
BCC_NEAR_8421	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_RN_1775_8431

BCC_RN_1775_8431	proc	near
		db	0E8h
		dw	004F7h
		test	byte ptr [BP+7],1
		je	short M053_L_843E
		or	byte ptr [BP-24h],8
M053_L_843E:
		cmp	byte ptr [BP-1Ch],0
		jne	short M053_L_8448
		ret
		db	0E8h
		dw	004E3h
M053_L_8448:
		mov	DI,SI
		or	byte ptr [BP-24h],1
		db	0E8h
		dw	0052Bh
		jne	short M053_L_8454
		ret
M053_L_8454:
		and	byte ptr [BP-24h],0FEh
		db	0E9h
		dw	0052Fh
BCC_RN_1775_8431	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_845B

BCC_NEAR_845B	proc	near
		db	0E8h
		dw	004CDh
		xchg	SI,DI
		db	0E9h
		dw	00527h
BCC_NEAR_845B	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8463

BCC_NEAR_8463	proc	near
		xchg	SI,DI
		db	0E8h
		dw	004C3h
		db	0E8h
		dw	00464h
		jne	short M055_L_8470
		db	0E8h
		dw	0054Bh
M055_L_8470:
		ret
BCC_NEAR_8463	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8471

BCC_NEAR_8471	proc	near
		cmp	AH,65h
		jne	short M056_L_84AA
		cmp	byte ptr [SI+10h],1
		jne	short M056_L_84AA
		xchg	SI,DI
		db	0E8h
		dw	00391h
		jne	short M056_L_84AA
		db	0E8h
		dw	004A5h
		db	0E8h
		dw	00495h
		lea	DI,[BP+0FE42h]
		db	0E8h
		dw	00470h
		jne	short M056_L_84AA
		db	0E8h
		dw	0043Ah
		pushf
		jne	short M056_L_849C
		or	byte ptr [BP-24h],2
M056_L_849C:
		push	AX
		db	0E8h
		dw	00595h
		pop	AX
		popf
		jne	short M056_L_84A7
		db	0E9h
		dw	00514h
M056_L_84A7:
		db	0E8h
		dw	0050Ch
M056_L_84AA:
		ret
BCC_NEAR_8471	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_84AB

BCC_NEAR_84AB	proc	near
		cmp	AX,6567h
		jne	short M057_L_84CC
		cmp	byte ptr [SI+10h],1
		jne	short M057_L_84CC
		xchg	SI,DI
		db	0E8h
		dw	0035Fh
		xchg	SI,DI
		jne	short M057_L_84CC
		mov	byte ptr [BP-2Eh],0
		db	0E8h
		dw	00465h
		db	0E8h
		dw	00450h
		db	0E8h
		dw	00569h
M057_L_84CC:
		ret
BCC_NEAR_84AB	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_84CD

BCC_NEAR_84CD	proc	near
		xchg	SI,DI
		xchg	AL,AH
		db	0E8h
		dw	00019h
		jne	short M058_L_84D9
		db	0E8h
		dw	004D7h
M058_L_84D9:
		ret
BCC_NEAR_84CD	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_84DA

BCC_NEAR_84DA	proc	near
		xchg	SI,DI
		xchg	AL,AH
		cmp	AL,65h
		jne	short M059_L_84EC
		cmp	word ptr [DI+10h],201h
		jne	short M059_L_84EC
		db	0E8h
		dw	00001h
M059_L_84EC:
		ret
BCC_NEAR_84DA	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_84ED

BCC_NEAR_84ED	proc	near
		cmp	AH,65h
		jne	short M05A_L_8507
		cmp	byte ptr [SI+11h],0
		jne	short M05A_L_8507
		db	0E8h
		dw	00430h
		mov	AL,byte ptr [SI+10h]
		cmp	AL,1
		ja	short M05A_L_8507
		or	byte ptr [BP-24h],AL
		xor	AX,AX
M05A_L_8507:
		ret
BCC_NEAR_84ED	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8508

BCC_NEAR_8508	proc	near
		db	0E8h
		dw	00420h
		mov	DI,SI
		db	0E8h
		dw	003D8h
		jne	short M05B_L_851C
		cmp	AL,3
		je	short M05B_L_851C
		inc	byte ptr [BP-24h]
		db	0E8h
		dw	0049Fh
M05B_L_851C:
		ret
BCC_NEAR_8508	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_851D

BCC_NEAR_851D	proc	near
		xchg	AL,AH
		xchg	SI,DI
		mov	BL,byte ptr [DI+11h]
		sub	BL,1
		jne	short M05C_L_852B
		dec	BX
		ret
M05C_L_852B:
		cmp	AL,65h
		jne	short M05C_L_854D
		cmp	byte ptr [DI+10h],2
		jne	short M05C_L_854D
		db	0E8h
		dw	002E2h
		jne	short M05C_L_854D
		cmp	AL,1
		je	short M05C_L_8544
		cmp	word ptr [SI+0Ch],0
		jne	short M05C_L_854D
M05C_L_8544:
		db	0E8h
		dw	003E4h
		db	0E8h
		dw	003D4h
		db	0E8h
		dw	004E8h
M05C_L_854D:
		ret
BCC_NEAR_851D	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_854E

BCC_NEAR_854E	proc	near
		cmp	AX,6564h
		jne	short M05D_L_8572
		cmp	byte ptr [SI+10h],1
		ja	short M05D_L_8572
		db	0E8h
		dw	003CFh
		mov	AL,byte ptr [SI+11h]
		or	byte ptr [BP-24h],AL
		cmp	byte ptr [SI+10h],0
		je	short M05D_L_856F
		or	byte ptr [BP-24h],8
		db	0E9h
		dw	0041Bh
M05D_L_856F:
		db	0E8h
		dw	0043Eh
M05D_L_8572:
		ret
BCC_NEAR_854E	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8573

BCC_NEAR_8573	proc	near
		db	0E8h
		dw	00294h
		jne	short M05E_L_857E
		db	0E8h
		dw	003B0h
		db	0E8h
		dw	004A8h
M05E_L_857E:
		ret
BCC_NEAR_8573	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_857F

BCC_NEAR_857F	proc	near
		xchg	AL,AH
		xchg	SI,DI
		cmp	AX,6765h
		jne	short M05F_L_85A8
		cmp	byte ptr [DI+11h],0
		jne	short M05F_L_85A8
		db	0E8h
		dw	0026Fh
		jne	short M05F_L_85A8
		db	0E8h
		dw	00395h
		mov	AL,byte ptr [DI+10h]
		cmp	AL,1
		ja	short M05F_L_85A8
		cmp	AL,byte ptr [BP-2Ch]
		jne	short M05F_L_85A8
		or	byte ptr [BP-24h],AL
		db	0E8h
		dw	00457h
M05F_L_85A8:
		ret
BCC_NEAR_857F	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_85A9

BCC_NEAR_85A9	proc	near
		push	AX
		db	0E8h
		dw	00007h
		pop	AX
		je	short M060_L_85D4
		xchg	SI,DI
		xchg	AL,AH
M060_L_85B4:
		cmp	AL,65h
		jne	short M060_L_85D4
		cmp	byte ptr [DI+10h],1
		ja	short M060_L_85D4
		db	0E8h
		dw	00249h
		jne	short M060_L_85D4
		db	0E8h
		dw	00365h
		db	0E8h
		dw	00355h
		mov	AL,byte ptr [DI+10h]
		cmp	AL,byte ptr [BP-2Ch]
		jne	short M060_L_85D4
		db	0E8h
		dw	00465h
M060_L_85D4:
		ret
BCC_NEAR_85A9	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_85D5

BCC_NEAR_85D5	proc	near
		cmp	AX,6567h
		jne	short M061_L_85F8
		cmp	byte ptr [SI+10h],1
		jne	short M061_L_85F8
		xchg	SI,DI
		db	0E8h
		dw	00235h
		cmp	word ptr [BP-22h],0
		je	short M061_L_85EF
		cmp	AL,0FFh
		jne	short M061_L_85F8
M061_L_85EF:
		db	0E8h
		dw	00339h
		db	0E8h
		dw	00329h
		db	0E8h
		dw	0043Dh
M061_L_85F8:
		ret
BCC_NEAR_85D5	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_85F9

BCC_NEAR_85F9	proc	near
		xchg	SI,DI
		xchg	AL,AH
		cmp	AL,65h
		jne	short M062_L_8615
		cmp	byte ptr [DI+10h],1
		jne	short M062_L_8615
		db	0E8h
		dw	00208h
		jne	short M062_L_8615
		db	0E8h
		dw	0031Ch
		db	0E8h
		dw	0030Ch
		db	0E8h
		dw	00420h
M062_L_8615:
		ret
BCC_NEAR_85F9	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8616

BCC_NEAR_8616	proc	near
		db	0E8h
		dw	00201h
		jne	short M063_L_862D
		cmp	word ptr [SI+0Ch],6
		je	short M063_L_8627
		cmp	word ptr [SI+0Ch],0
		jne	short M063_L_862D
M063_L_8627:
		db	0E8h
		dw	00301h
		db	0E8h
		dw	003F5h
M063_L_862D:
		ret
BCC_NEAR_8616	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_862E

BCC_NEAR_862E	proc	near
		cmp	AL,65h
		je	short M064_L_863D
		cmp	AH,65h
		jne	short M064_L_8659
		mov	byte ptr [BP-2Dh],2
		xchg	SI,DI
M064_L_863D:
		cmp	byte ptr [DI+10h],1
		ja	short M064_L_8659
		db	0E8h
		dw	001C4h
		jne	short M064_L_8659
		db	0E8h
		dw	002E0h
		db	0E8h
		dw	002D0h
		mov	AL,byte ptr [DI+10h]
		cmp	AL,byte ptr [BP-2Ch]
		jne	short M064_L_8659
		db	0E8h
		dw	003E0h
M064_L_8659:
		ret
BCC_NEAR_862E	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_865A

BCC_NEAR_865A	proc	near
		db	0E8h
		dw	001B5h
		jne	short M065_L_8665
		db	0E8h
		dw	002C9h
		db	0E8h
		dw	003BDh
M065_L_8665:
		ret
BCC_NEAR_865A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8666

BCC_NEAR_8666	proc	near
		db	0E8h
		dw	00297h
		jne	short M066_L_8699
		db	0E8h
		dw	0019Ch
		jne	short M066_L_8699
		db	0E8h
		dw	002B8h
		cmp	byte ptr [BP-2Ch],0
		je	short M066_L_8682
		db	0E8h
		dw	00253h
		jne	short M066_L_8691
		or	byte ptr [BP-24h],2
M066_L_8682:
		db	0E8h
		dw	00263h
		jne	short M066_L_8699
		db	0E8h
		dw	0039Ch
		jne	short M066_L_8699
		db	0E8h
		dw	00321h
		jmp	short M066_L_8699
M066_L_8691:
		db	0E8h
		dw	00392h
		jne	short M066_L_8699
		db	0E8h
		dw	002F1h
M066_L_8699:
		ret
BCC_NEAR_8666	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_869A

BCC_NEAR_869A	proc	near
		cmp	AL,64h
		jne	short M067_L_86B5
		db	0E8h
		dw	00169h
		jne	short M067_L_86B5
		db	0E8h
		dw	00285h
		db	0E8h
		dw	0037Dh
		cmp	byte ptr [BP-2Ch],1
		je	short M067_L_86B2
		db	0E9h
		dw	002FEh
M067_L_86B2:
		db	0E9h
		dw	002D5h
M067_L_86B5:
		ret
BCC_NEAR_869A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_86B6

BCC_NEAR_86B6	proc	near
		cmp	AX,6564h
		jne	short M068_L_86E4
		db	0E8h
		dw	00242h
		jne	short M068_L_86E4
		cmp	byte ptr [SI+11h],0
		jne	short M068_L_86E4
		cmp	byte ptr [SI+10h],1
		ja	short M068_L_86E4
		jne	short M068_L_86D9
		db	0E8h
		dw	0025Ah
		inc	byte ptr [BP-24h]
		db	0E8h
		dw	002B3h
		jmp	short M068_L_86E4
M068_L_86D9:
		db	0E8h
		dw	0020Ch
		jne	short M068_L_86E4
		db	0E8h
		dw	0024Ah
		db	0E8h
		dw	002CCh
M068_L_86E4:
		ret
BCC_NEAR_86B6	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_86E5

BCC_NEAR_86E5	proc	near
		cmp	AH,65h
		jne	short M069_L_86FB
		cmp	byte ptr [SI+10h],1
		jne	short M069_L_86FB
		db	0E8h
		dw	00238h
		mov	AL,byte ptr [SI+11h]
		or	byte ptr [BP-24h],AL
		xor	AX,AX
M069_L_86FB:
		ret
BCC_NEAR_86E5	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_86FC

BCC_NEAR_86FC	proc	near
		mov	CL,1
		jmp	short M06A_L_8702
		mov	CL,0FFh
M06A_L_8702:
		cmp	AH,65h
		jne	short M06A_L_8721
		cmp	byte ptr [SI+10h],2
		jne	short M06A_L_8721
		cmp	byte ptr [SI+11h],CL
		je	short M06A_L_8722
		db	0E8h
		dw	00216h
		mov	AL,byte ptr [SI+11h]
		mov	CL,3
		shl	AL,CL
		or	byte ptr [BP-24h],AL
		xor	AX,AX
M06A_L_8721:
		ret
M06A_L_8722:
		inc	AX
		ret
BCC_NEAR_86FC	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8724

BCC_NEAR_8724	proc	near
		cmp	AH,65h
		jne	short M06B_L_8773
		cmp	word ptr [SI+10h],1
		jne	short M06B_L_8773
		mov	AL,0
		xchg	AX,DX
		db	0E8h
		dw	00224h
		db	0E8h
		dw	0035Ch
		mov	DH,0
		test	byte ptr [BP+6],3
		jne	short M06B_L_8742
		mov	DH,1
M06B_L_8742:
		mov	CX,word ptr CS:[BX+2]
		cmp	CL,1
		ja	short M06B_L_8751
		mov	DH,CL
		inc	BX
		dec	AX
		jmp	short M06B_L_8742
M06B_L_8751:
		cmp	CL,9Bh
		jne	short M06B_L_8758
		xor	DH,DH
M06B_L_8758:
		or	CL,DL
		mov	AH,CH
		mov	BL,3
		mov	BH,byte ptr [BP-2Eh]
		mov	byte ptr [BP-2Eh],0
		or	BH,DH
		db	0E8h
		dw	00260h
		dec	AX
		mov	byte ptr [BP-25h],AL
		mov	byte ptr [BP-24h],AH
		xor	AX,AX
M06B_L_8773:
		ret
BCC_NEAR_8724	endp
		public	BCC_NEAR_872F
BCC_NEAR_872F	equ	BCC_NEAR_8724+11
		public	BCC_NEAR_8731
BCC_NEAR_8731	equ	BCC_NEAR_8724+13
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8774

BCC_NEAR_8774	proc	near
		mov	CX,0FDFDh
		jmp	short M06C_L_8796
		mov	CX,0FEFEh
		jmp	short M06C_L_8796
		mov	CX,0FF01h
		jmp	short M06C_L_8796
		cmp	word ptr [SI+0Ch],0
		jne	short M06C_L_878E
		mov	word ptr [SI+0Ch],2
M06C_L_878E:
		mov	CX,101h
		jmp	short M06C_L_8796
		mov	CX,0FFFEh
M06C_L_8796:
		cmp	AH,67h
		jne	short M06C_L_87B6
		push	CX
		db	0E8h
		dw	0007Bh
		pop	CX
		jne	short M06C_L_87B6
		mov	AL,0
		cmp	byte ptr [BP-2Ch],CH
		je	short M06C_L_87B0
		cmp	byte ptr [BP-2Ch],CL
		jne	short M06C_L_87B6
		or	AL,4
M06C_L_87B0:
		db	0E8h
		dw	0FF7Eh
		db	0E8h
		dw	0026Ch
M06C_L_87B6:
		ret
BCC_NEAR_8774	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_87B7

BCC_NEAR_87B7	proc	near
		mov	CX,0Eh
		jmp	short M06D_L_87BF
		mov	CX,5Eh
M06D_L_87BF:
		cmp	word ptr [SI+0Ch],CX
		je	short M06D_L_87CA
		cmp	word ptr [SI+0Ch],0
		jne	short M06D_L_87DA
M06D_L_87CA:
		cmp	AH,67h
		jne	short M06D_L_87DA
		db	0E8h
		dw	00048h
		jne	short M06D_L_87DA
		db	0E8h
		dw	0FF58h
		db	0E8h
		dw	00248h
M06D_L_87DA:
		ret
BCC_NEAR_87B7	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_87DB

BCC_NEAR_87DB	proc	near
		mov	AL,65h
		jmp	short M06E_L_87E9
		xchg	SI,DI
		xchg	AL,AH
		cmp	word ptr [DI+10h],4
		jne	short M06E_L_87FF
M06E_L_87E9:
		cmp	AX,6565h
		jne	short M06E_L_87FF
		cmp	byte ptr [SI+10h],4
		jne	short M06E_L_87FF
		db	0E8h
		dw	0FF38h
		mov	AL,byte ptr [SI+11h]
		or	byte ptr [BP-24h],AL
		xor	AX,AX
M06E_L_87FF:
		ret
BCC_NEAR_87DB	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8800

BCC_NEAR_8800	proc	near
		db	0E8h
		dw	00017h
		jne	short M06F_L_8809
		cmp	byte ptr [BP-2Bh],1
M06F_L_8809:
		ret
BCC_NEAR_8800	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_880A

BCC_NEAR_880A	proc	near
		db	0E8h
		dw	0000Dh
		jne	short M070_L_8811
		test	AL,0FEh
M070_L_8811:
		ret
BCC_NEAR_880A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8812

BCC_NEAR_8812	proc	near
		db	0E8h
		dw	00005h
		jne	short M071_L_8819
		cmp	AL,1
M071_L_8819:
		ret
BCC_NEAR_8812	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_881A

BCC_NEAR_881A	proc	near
		mov	AX,word ptr [SI+8]
		mov	word ptr [BP-2Ah],AX
		mov	AX,word ptr [SI+0Ah]
		mov	word ptr [BP-28h],AX
		mov	word ptr [BP-30h],0
		mov	byte ptr [BP-2Eh],0
		cmp	byte ptr [SI+12h],65h
		je	short M072_L_889B
		cmp	byte ptr [SI+12h],67h
		jne	short M072_L_88B1
		mov	AL,byte ptr [SI+13h]
		or	AL,AL
		jne	short M072_L_8843
		inc	AX
M072_L_8843:
		mov	byte ptr [BP-31h],AL
		mov	AX,601h
		mov	BL,byte ptr [SI+0Eh]
		and	BX,0Fh
		je	short M072_L_885E
		mov	AH,byte ptr CS:[BX+1164h]
		or	AH,AH
		jns	short M072_L_885D
		db	0E9h
		dw	0F1AAh
M072_L_885D:
		dec	AX
M072_L_885E:
		mov	byte ptr [BP-2Bh],AL
		mov	CX,word ptr [SI]
		mov	word ptr [BP-30h],CX
		mov	CL,0FCh
		mov	BX,word ptr [SI+0Ch]
		cmp	BX,0Ah
		ja	short M072_L_8875
		mov	CL,byte ptr CS:[BX+1174h]
M072_L_8875:
		mov	byte ptr [BP-2Ch],CL
		mov	byte ptr [BP-26h],AH
		mov	AH,byte ptr [SI+0Fh]
		or	AH,AH
		je	short M072_L_88AF
		mov	AL,3Eh
		cmp	byte ptr [BP-2Bh],1
		je	short M072_L_8892
		test	byte ptr [SI+0Eh],4
		je	short M072_L_8892
		mov	AL,36h
M072_L_8892:
		cmp	AL,AH
		je	short M072_L_88AF
		mov	byte ptr [BP-2Eh],AH
		jmp	short M072_L_88AF
M072_L_889B:
		mov	byte ptr [BP-2Bh],0
		mov	AX,word ptr [SI+10h]
		or	AH,0C0h
		mov	byte ptr [BP-26h],AH
		cmp	AL,1
		ja	short M072_L_88B1
		mov	byte ptr [BP-2Ch],AL
M072_L_88AF:
		xor	AX,AX
M072_L_88B1:
		mov	AL,byte ptr [BP-2Ch]
		ret
BCC_NEAR_881A	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8

		public	BCC_TABLE_88B5
BCC_TABLE_88B5	label	word
		dw	00405h
		dw	006FFh
		dw	00203h
		dw	007FFh
		dw	00001h
		dw	0FFFFh
		dw	0FFFFh
		dw	0FCFFh
		dw	00100h
		dw	0FFFCh
		dw	0FCFCh
		dw	0FEFCh
		dw	0FDFCh

CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_88CF

BCC_NEAR_88CF	proc	near
		cmp	byte ptr [DI+12h],64h
		jne	short M074_L_88E7
		cmp	byte ptr [DI+13h],0
		jne	short M074_L_88E7
		mov	AL,byte ptr [DI]
		cbw
		cwd
		cmp	AH,byte ptr [DI+1]
		jne	short M074_L_88E7
		cmp	DX,word ptr [DI+2]
M074_L_88E7:
		ret
BCC_NEAR_88CF	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_88E8

BCC_NEAR_88E8	proc	near
		db	0E8h
		dw	00015h
		jne	short M075_L_88FF
		cmp	byte ptr [DI+13h],0
		jne	short M075_L_88FF
		or	DX,DX
		js	short M075_L_88FA
		or	AH,AH
		ret
M075_L_88FA:
		mov	DX,AX
		cbw
		cmp	AX,DX
M075_L_88FF:
		ret
BCC_NEAR_88E8	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8900

BCC_NEAR_8900	proc	near
		cmp	byte ptr [DI+12h],64h
		jne	short M076_L_8918
		mov	AX,word ptr [DI]
		cwd
		cmp	word ptr [DI+2],DX
		je	short M076_L_8918
		xor	DX,DX
		cmp	word ptr [DI+2],DX
		je	short M076_L_8918
		db	0E9h
		dw	0F0EBh
M076_L_8918:
		ret
BCC_NEAR_8900	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_8919

BCC_NEAR_8919	proc	near
		mov	AL,byte ptr [SI+11h]
		jmp	short M077_L_8921
		mov	AL,byte ptr [DI+11h]
M077_L_8921:
		shl	AL,1
		shl	AL,1
		shl	AL,1
		or	byte ptr [BP-26h],AL
		ret
BCC_NEAR_8919	endp
		public	BCC_NEAR_891E
BCC_NEAR_891E	equ	BCC_NEAR_8919+5
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_892B

BCC_NEAR_892B	proc	near
		db	0E8h
		dw	0002Bh
		mov	AL,byte ptr [BP-2Eh]
		or	AL,AL
		je	short M078_L_8938
		db	0E8h
		dw	00083h
M078_L_8938:
		db	0E8h
		dw	00007h
		inc	byte ptr [BP-25h]
		mov	byte ptr [BP-24h],AL
		ret
BCC_NEAR_892B	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8942

BCC_NEAR_8942	proc	near
		db	0E8h
		dw	0014Fh
		xchg	AX,CX
		dec	CX
		je	short M079_L_8953
		js	short M079_L_8953
M079_L_894B:
		db	0E8h
		dw	00005h
		db	0E8h
		dw	0006Ah
		loop	short M079_L_894B
M079_L_8953:
		mov	AL,byte ptr CS:[BX+2]
		inc	BX
		ret
BCC_NEAR_8942	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8959

BCC_NEAR_8959	proc	near
		lea	BX,[BP-0Eh]
M07A_L_895C:
		xor	AX,AX
		add	AL,byte ptr SS:[BX]
		je	short M07A_L_8969
		db	0E8h
		dw	00055h
		inc	BX
		jmp	short M07A_L_895C
M07A_L_8969:
		ret
BCC_NEAR_8959	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_896A

BCC_NEAR_896A	proc	near
		push	AX
		xor	AX,AX
		xchg	byte ptr [BP-25h],AL
		or	AL,AL
		je	short M07B_L_897A
		mov	AL,byte ptr [BP-24h]
		db	0E8h
		dw	00041h
M07B_L_897A:
		pop	AX
		ret
BCC_NEAR_896A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_897C

BCC_NEAR_897C	proc	near
		cmp	byte ptr [DI+13h],0
		jne	short M07C_L_8989
		db	0E8h
		dw	0FF7Bh
		jne	short M07C_L_8989
		or	AX,AX
M07C_L_8989:
		ret
BCC_NEAR_897C	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_898A

BCC_NEAR_898A	proc	near
		mov	BH,byte ptr [DI+13h]
		or	BH,BH
		jne	short M07D_L_8997
		db	0E8h
		dw	0FF6Ch
		db	074h,020h
		ret
M07D_L_8997:
		mov	BL,1
		mov	CX,word ptr [DI]
		mov	DX,word ptr [DI+2]
		mov	AX,word ptr [DI+8]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [DI+0Ah]
		mov	word ptr [BP+0FE80h],AX
		db	0E8h
		dw	0001Bh
		ret
BCC_NEAR_898A	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_89B0

BCC_NEAR_89B0	proc	near
		db	0E8h
		dw	0FF35h
		je	short M07E_L_89BB
		ret
		db	0E8h
		dw	00002h
		xchg	AL,AH
M07E_L_89BB:
		db	0E8h
		dw	0FFACh
		push	BX
		push	CX
		mov	BL,0
		mov	CX,AX
		db	0E8h
		dw	00003h
		pop	CX
		pop	BX
		ret
BCC_NEAR_89B0	endp
		public	BCC_NEAR_89B6
BCC_NEAR_89B6	equ	BCC_NEAR_89B0+6
		public	BCC_NEAR_89BB
BCC_NEAR_89BB	equ	BCC_NEAR_89B0+11
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_89CA

BCC_NEAR_89CA	proc	near
		db	0E8h
		dw	0FF9Dh
		push	SI
		mov	SI,word ptr [BP+0FEF0h]
		cmp	SI,6Eh
		jne	short M07F_L_89DA
		db	0E9h
		dw	0F049h
M07F_L_89DA:
		mov	word ptr [BP+SI+0FE82h],BX
		mov	word ptr [BP+SI+0FE84h],CX
		mov	word ptr [BP+SI+0FE86h],DX
		push	word ptr [BP+0FE7Eh]
		pop	word ptr [BP+SI+0FE88h]
		push	word ptr [BP+0FE80h]
		pop	word ptr [BP+SI+0FE8Ah]
		add	word ptr [BP+0FEF0h],0Ah
		pop	SI
		cmp	AX,AX
		ret
BCC_NEAR_89CA	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_89FF

BCC_NEAR_89FF	proc	near
		mov	AX,word ptr [BP-30h]
		mov	CX,word ptr [BP-2Ah]
		or	CX,word ptr [BP-28h]
		db	074h,0ACh
		xchg	AX,CX
		xor	DX,DX
		mov	BL,1
		mov	BH,byte ptr [BP-31h]
		mov	AX,word ptr [BP-2Ah]
		mov	word ptr [BP+0FE7Eh],AX
		mov	AX,word ptr [BP-28h]
		mov	word ptr [BP+0FE80h],AX
		db	0EBh,0A8h
BCC_NEAR_89FF	endp
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8A22

BCC_NEAR_8A22	proc	near
		mov	byte ptr [BP-2Ch],0
		db	0E8h
		dw	00073h
		and	AL,38h
		or	byte ptr [BP-26h],AL
		cmp	byte ptr [BP-2Dh],0
		je	short M081_L_8A39
		ret
		mov	byte ptr [BP-2Ch],0
M081_L_8A39:
		mov	AL,byte ptr [BP-2Ch]
		or	AL,byte ptr [BP-2Dh]
		or	byte ptr [BP-24h],AL
		mov	AL,byte ptr [BP-26h]
		mov	AH,AL
		and	AX,0C7C0h
		cmp	AL,0C0h
		je	short M081_L_8A85
		cmp	byte ptr [BP-2Bh],1
		je	short M081_L_8A71
		mov	CX,word ptr [BP-2Ah]
		or	CX,word ptr [BP-28h]
		jne	short M081_L_8A6D
		mov	CX,word ptr [BP-30h]
		cmp	AH,6
		je	short M081_L_8A66
		jcxz	short M081_L_8A85
M081_L_8A66:
		mov	AX,CX
		cbw
		cmp	AX,CX
		je	short M081_L_8A79
M081_L_8A6D:
		or	byte ptr [BP-26h],80h
M081_L_8A71:
		db	0E8h
		dw	00011h
		db	0E8h
		dw	0FF88h
		jmp	short M081_L_8A8B
M081_L_8A79:
		or	byte ptr [BP-26h],40h
		db	0E8h
		dw	00005h
		mov	AX,word ptr [BP-30h]
		jmp	short M081_L_8A88
M081_L_8A85:
		mov	AL,byte ptr [BP-26h]
M081_L_8A88:
		db	0E8h
		dw	0FF30h
M081_L_8A8B:
		cmp	byte ptr [BP-2Ch],0FDh
		ja	short M081_L_8A93
		xor	AX,AX
M081_L_8A93:
		ret
BCC_NEAR_8A22	endp
		public	BCC_NEAR_8A26
BCC_NEAR_8A26	equ	BCC_NEAR_8A22+4
		public	BCC_NEAR_8A35
BCC_NEAR_8A35	equ	BCC_NEAR_8A22+19
		public	BCC_NEAR_8A39
BCC_NEAR_8A39	equ	BCC_NEAR_8A22+23
CODE8	ends





CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP
		public	BCC_NEAR_8A94

BCC_NEAR_8A94	proc	near
		db	0E8h
		dw	00005h
		and	AX,3
		inc	AX
		ret
BCC_NEAR_8A94	endp
CODE8	ends


CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_8A9C

BCC_NEAR_8A9C	proc	near
		mov	BX,word ptr [BP-1Eh]
		mov	AL,byte ptr CS:[BX+1]
		ret
BCC_NEAR_8A9C	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8

		public	BCC_TABLE_8AA4
BCC_TABLE_8AA4	label	word
		dw	00BD1h
		dw	00D0Bh
		dw	00D13h
		dw	00D5Bh
		dw	00D8Ah
		dw	00D7Dh
		dw	00D8Eh
		dw	00D81h
		dw	00CB0h
		dw	00CB4h
		dw	00DB8h
		dw	00CD1h
		dw	00F66h
		dw	00DFEh
		dw	00BDAh
		dw	00C35h
		dw	00BE6h
		dw	00BF6h
		dw	00C27h
		dw	00E33h
		dw	00E2Fh
		dw	00CE1h
		dw	00CF5h
		dw	00BD7h
		dw	00FB0h
		dw	00FACh
		dw	00F95h
		dw	00EC6h
		dw	00EA9h
		dw	00EADh
		dw	00D21h
		dw	00DCDh
		dw	00DDBh
		dw	00EDEh
		dw	00E59h
		dw	00F0Ah
		dw	00F16h
		dw	00F4Ah
		dw	00E23h
		dw	00E85h
		dw	00C74h
		dw	00FDFh
		dw	00FD4h
		dw	0108Bh
		dw	01093h
		dw	0108Fh
		dw	01043h
		dw	01024h
		dw	01033h
		dw	0102Eh
		dw	01029h
		dw	01067h
		dw	0106Ch
		dw	00BD7h

CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP

		public	BCC_NEAR_8B10

BCC_NEAR_8B10	proc	near
		mov	DI,13C4h
		ret
BCC_NEAR_8B10	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8

		public	BCC_TABLE_8B14
BCC_TABLE_8B14	label	word
		dw	0001Eh
		dw	01E18h
		dw	01B9Fh
		dw	01E33h
		dw	01C69h
		dw	01CD8h
		dw	01DCBh
		dw	01D2Fh
		dw	01DA4h
		dw	01D3Ah
		dw	01D0Bh
		dw	01D97h
		dw	01DBEh
		dw	01CA9h
		dw	01E25h
		dw	01DB2h
		dw	01E44h
		dw	00000h
		dw	04402h
		dw	0EA42h
		dw	00001h
		dw	00200h
		dw	05744h
		dw	002EAh
		dw	00000h
		dw	04402h
		dw	0EA44h
		dw	00004h
		dw	00400h
		dw	04F4Ch
		dw	04B43h
		dw	000AEh
		dw	0E6F0h
		dw	00313h
		dw	04552h
		dw	0AE50h
		dw	0F300h
		dw	00000h
		dw	05204h
		dw	05045h
		dw	0AE45h
		dw	0F300h
		dw	00000h
		dw	05204h
		dw	05045h
		dw	0AE5Ah
		dw	0F300h
		dw	013FBh
		dw	05205h
		dw	05045h
		dw	0454Eh
		dw	000AEh
		dw	000F2h
		dw	00500h
		dw	04552h
		dw	04E50h
		dw	0AE5Ah
		dw	0F200h
		dw	00000h
		dw	05305h
		dw	04745h
		dw	05345h
		dw	000AEh
		dw	00026h
		dw	00500h
		dw	04553h
		dw	04347h
		dw	0AE53h
		dw	02E00h
		dw	01443h
		dw	05305h
		dw	04745h
		dw	05353h
		dw	000AEh
		dw	00036h
		dw	00500h
		dw	04553h
		dw	04447h
		dw	0AE53h
		dw	03E00h
		dw	01422h
		dw	04103h
		dw	04344h
		dw	08098h
		dw	0C214h
		dw	01080h
		dw	09048h
		dw	0F480h
		dw	00313h
		dw	04441h
		dw	09844h
		dw	00480h
		dw	080C2h
		dw	04800h
		dw	08080h
		dw	0144Eh
		dw	04103h
		dw	0444Eh
		dw	08098h
		dw	0C224h
		dw	02080h
		dw	0A04Ah
		dw	08280h
		dw	00314h
		dw	04141h
		dw	00041h
		dw	03700h
		dw	01438h
		dw	04103h
		dw	05341h
		dw	00000h
		dw	0003Fh
		dw	00300h
		dw	04141h
		dw	08044h
		dw	0D501h
		dw	0040Ah
		dw	0D540h
		dw	00000h
		dw	04103h
		dw	04D41h
		dw	00180h
		dw	00AD4h
		dw	04004h
		dw	0A3D4h
		dw	00514h
		dw	04F42h
		dw	04E55h
		dw	04E44h
		dw	06284h
		dw	0140Eh
		dw	04304h
		dw	04C41h
		dw	0A44Ch
		dw	0E840h
		dw	0409Eh
		dw	09C9Ah
		dw	0FF50h
		dw	05820h
		dw	018FFh
		dw	00314h
		dw	04D43h
		dw	09850h
		dw	03C80h
		dw	080C2h
		dw	04838h
		dw	080B8h
		dw	013EDh
		dw	04303h
		dw	05742h
		dw	00000h
		dw	00098h
		dw	00300h
		dw	05743h
		dw	00044h
		dw	09900h
		dw	00000h
		dw	04303h
		dw	0434Ch
		dw	00000h
		dw	091F8h
		dw	00314h
		dw	04C43h
		dw	00044h
		dw	0FC00h
		dw	01464h
		dw	04303h
		dw	0494Ch
		dw	00000h
		dw	005FAh
		dw	00315h
		dw	04D43h
		dw	00043h
		dw	0F500h
		dw	01517h
		dw	04305h
		dw	0504Dh
		dw	04253h
		dw	00000h
		dw	00EA6h
		dw	00515h
		dw	04D43h
		dw	05350h
		dw	00057h
		dw	0A700h
		dw	014BDh
		dw	04403h
		dw	04141h
		dw	00000h
		dw	02B27h
		dw	00315h
		dw	04144h
		dw	00053h
		dw	02F00h
		dw	014EAh
		dw	04403h
		dw	04345h
		dw	040B4h
		dw	04C48h
		dw	0FE48h
		dw	01520h
		dw	04403h
		dw	05649h
		dw	0704Ch
		dw	048F6h
		dw	00515h
		dw	04E45h
		dw	04554h
		dw	01652h
		dw	0C884h
		dw	0153Fh
		dw	04803h
		dw	0544Ch
		dw	00000h
		dw	0C8F4h
		dw	00414h
		dw	04449h
		dw	05649h
		dw	0784Ch
		dw	036F6h
		dw	00415h
		dw	04D49h
		dw	04C55h
		dw	068CCh
		dw	03CF6h
		dw	069C4h
		dw	01568h
		dw	04902h
		dw	08C4Eh
		dw	0EC80h
		dw	0800Eh
		dw	000E4h
		dw	00300h
		dw	04E49h
		dw	0B443h
		dw	04040h
		dw	0404Ch
		dw	071FEh
		dw	00415h
		dw	04E49h
		dw	04253h
		dw	00400h
		dw	0DB6Ch
		dw	00414h
		dw	04E49h
		dw	05753h
		dw	00400h
		dw	09F6Dh
		dw	00315h
		dw	04E49h
		dw	01454h
		dw	0CC40h
		dw	01473h
		dw	04904h
		dw	0544Eh
		dw	0004Fh
		dw	0CE00h
		dw	01554h
		dw	04904h
		dw	04552h
		dw	00054h
		dw	0CF00h
		dw	01405h
		dw	04A03h
		dw	0504Dh
		dw	040A2h
		dw	0A4EBh
		dw	0E940h
		dw	0409Eh
		dw	09CEAh
		dw	0FF60h
		dw	06820h
		dw	093FFh
		dw	00215h
		dw	04F4Ah
		dw	04022h
		dw	0D070h
		dw	00315h
		dw	04E4Ah
		dw	0224Fh
		dw	07140h
		dw	014F3h
		dw	04A02h
		dw	02243h
		dw	07240h
		dw	0142Dh
		dw	04A02h
		dw	02242h
		dw	07240h
		dw	015FEh
		dw	04A04h
		dw	0414Eh
		dw	02245h
		dw	07240h
		dw	015B3h
		dw	04A03h
		dw	0434Eh
		dw	04022h
		dw	0A973h
		dw	00315h
		dw	0414Ah
		dw	02245h
		dw	07340h
		dw	015E5h
		dw	04A03h
		dw	0424Eh
		dw	04022h
		dw	01973h
		dw	00216h
		dw	0454Ah
		dw	04022h
		dw	09A74h
		dw	00214h
		dw	05A4Ah
		dw	04022h
		dw	00674h
		dw	00316h
		dw	04E4Ah
		dw	02245h
		dw	07540h
		dw	014FCh
		dw	04A03h
		dw	05A4Eh
		dw	04022h
		dw	00075h
		dw	00300h
		dw	0424Ah
		dw	02245h
		dw	07640h
		dw	015BCh
		dw	04A03h
		dw	0414Eh
		dw	04022h
		dw	05D76h
		dw	00215h
		dw	0414Ah
		dw	04022h
		dw	0F677h
		dw	00415h
		dw	04E4Ah
		dw	04542h
		dw	04022h
		dw	06777h
		dw	00216h
		dw	0534Ah
		dw	04022h
		dw	01078h
		dw	00316h
		dw	04E4Ah
		dw	02253h
		dw	07940h
		dw	01679h
		dw	04A02h
		dw	02250h
		dw	07A40h
		dw	014B0h
		dw	04A03h
		dw	04550h
		dw	04022h
		dw	0887Ah
		dw	00315h
		dw	04E4Ah
		dw	02250h
		dw	07B40h
		dw	01656h
		dw	04A03h
		dw	04F50h
		dw	04022h
		dw	0ED7Bh
		dw	00215h
		dw	04C4Ah
		dw	04022h
		dw	0C67Ch
		dw	00415h
		dw	04E4Ah
		dw	04547h
		dw	04022h
		dw	07B7Ch
		dw	00315h
		dw	0474Ah
		dw	02245h
		dw	07D40h
		dw	01459h
		dw	04A03h
		dw	04C4Eh
		dw	04022h
		dw	0827Dh
		dw	00316h
		dw	04C4Ah
		dw	02245h
		dw	07E40h
		dw	0168Ah
		dw	04A03h
		dw	0474Eh
		dw	04022h
		dw	0447Eh
		dw	00216h
		dw	0474Ah
		dw	04022h
		dw	0937Fh
		dw	00416h
		dw	04E4Ah
		dw	0454Ch
		dw	04022h
		dw	0717Fh
		dw	00416h
		dw	0434Ah
		dw	05A58h
		dw	04022h
		dw	022E3h
		dw	00416h
		dw	0414Ch
		dw	04648h
		dw	00000h
		dw	0AD9Fh
		dw	00316h
		dw	0444Ch
		dw	04E53h
		dw	0C580h
		dw	016DBh
		dw	04C03h
		dw	04145h
		dw	08006h
		dw	0C98Dh
		dw	00516h
		dw	0454Ch
		dw	05641h
		dw	00045h
		dw	0C904h
		dw	016C0h
		dw	04C03h
		dw	05345h
		dw	0804Eh
		dw	00AC4h
		dw	00517h
		dw	04F4Ch
		dw	05344h
		dw	00042h
		dw	0AC00h
		dw	016A5h
		dw	04C05h
		dw	0444Fh
		dw	05753h
		dw	00000h
		dw	09CADh
		dw	00416h
		dw	04F4Ch
		dw	0504Fh
		dw	04022h
		dw	03BE2h
		dw	00516h
		dw	04F4Ch
		dw	0504Fh
		dw	02245h
		dw	0E140h
		dw	01727h
		dw	04C05h
		dw	04F4Fh
		dw	05A50h
		dw	04022h
		dw	0F7E1h
		dw	00616h
		dw	04F4Ch
		dw	0504Fh
		dw	0454Eh
		dw	04022h
		dw	0D2E0h
		dw	00616h
		dw	04F4Ch
		dw	0504Fh
		dw	05A4Eh
		dw	04022h
		dw	052E0h
		dw	00317h
		dw	04F4Dh
		dw	0A856h
		dw	0A080h
		dw	080A6h
		dw	09AA2h
		dw	0B080h
		dw	080CAh
		dw	0C2C6h
		dw	08880h
		dw	080C0h
		dw	03E8Ch
		dw	08E80h
		dw	01633h
		dw	04D05h
		dw	0564Fh
		dw	04253h
		dw	00000h
		dw	05DA4h
		dw	00517h
		dw	04F4Dh
		dw	05356h
		dw	00057h
		dw	0A500h
		dw	016EDh
		dw	04D03h
		dw	04C55h
		dw	0604Ch
		dw	09BF6h
		dw	00317h
		dw	0454Eh
		dw	04C47h
		dw	0F658h
		dw	01747h
		dw	04E03h
		dw	0504Fh
		dw	00000h
		dw	04D90h
		dw	00316h
		dw	04F4Eh
		dw	04C54h
		dw	0F650h
		dw	01775h
		dw	04F02h
		dw	09852h
		dw	00C80h
		dw	080C2h
		dw	04A08h
		dw	08088h
		dw	016E3h
		dw	04F03h
		dw	05455h
		dw	08088h
		dw	00AEEh
		dw	0E680h
		dw	01713h
		dw	04F05h
		dw	05455h
		dw	04253h
		dw	00400h
		dw	02B6Eh
		dw	00516h
		dw	0554Fh
		dw	05354h
		dw	00057h
		dw	06F04h
		dw	01769h
		dw	05003h
		dw	0504Fh
		dw	040B4h
		dw	0B258h
		dw	00740h
		dw	04046h
		dw	0FA8Fh
		dw	00417h
		dw	04F50h
		dw	04150h
		dw	00400h
		dw	01E61h
		dw	00417h
		dw	04F50h
		dw	04650h
		dw	00000h
		dw	0099Dh
		dw	00418h
		dw	05550h
		dw	04853h
		dw	040B4h
		dw	0B050h
		dw	00640h
		dw	070C6h
		dw	084FFh
		dw	06A44h
		dw	04402h
		dw	01D68h
		dw	00518h
		dw	05550h
		dw	04853h
		dw	00041h
		dw	06004h
		dw	01813h
		dw	05005h
		dw	05355h
		dw	04648h
		dw	00000h
		dw	0E49Ch
		dw	00317h
		dw	04552h
		dw	0AA54h
		dw	0C300h
		dw	0402Ah
		dw	0D8C2h
		dw	00417h
		dw	04552h
		dw	04E54h
		dw	00080h
		dw	02CC3h
		dw	0C240h
		dw	017EFh
		dw	05204h
		dw	05445h
		dw	08046h
		dw	0CB00h
		dw	0402Ch
		dw	0AFCAh
		dw	00317h
		dw	05553h
		dw	09842h
		dw	02C80h
		dw	080C2h
		dw	04828h
		dw	080A8h
		dw	01732h
		dw	05303h
		dw	04242h
		dw	08098h
		dw	0C21Ch
		dw	01880h
		dw	09848h
		dw	0C180h
		dw	00317h
		dw	04352h
		dw	0504Ch
		dw	0D090h
		dw	0187Eh
		dw	05203h
		dw	05243h
		dw	09850h
		dw	0B8D0h
		dw	00317h
		dw	04F52h
		dw	0504Ch
		dw	0D080h
		dw	01701h
		dw	05203h
		dw	0524Fh
		dw	08850h
		dw	062D0h
		dw	00318h
		dw	04153h
		dw	0504Ch
		dw	0D0A0h
		dw	01896h
		dw	05303h
		dw	04C48h
		dw	0A050h
		dw	0B7D0h
		dw	00316h
		dw	04153h
		dw	05052h
		dw	0D0B8h
		dw	0189Fh
		dw	05303h
		dw	05248h
		dw	0A850h
		dw	08DD0h
		dw	00418h
		dw	04153h
		dw	04648h
		dw	00000h
		dw	06F9Eh
		dw	00518h
		dw	04353h
		dw	05341h
		dw	00042h
		dw	0AE00h
		dw	01833h
		dw	05305h
		dw	04143h
		dw	05753h
		dw	00000h
		dw	0DFAFh
		dw	00318h
		dw	05453h
		dw	00043h
		dw	0F900h
		dw	01849h
		dw	05303h
		dw	04454h
		dw	00000h
		dw	0B1FDh
		dw	00318h
		dw	05453h
		dw	00049h
		dw	0FB00h
		dw	0173Dh
		dw	05305h
		dw	04F54h
		dw	04253h
		dw	00000h
		dw	0A6AAh
		dw	00517h
		dw	05453h
		dw	0534Fh
		dw	00057h
		dw	0AB00h
		dw	018EAh
		dw	05404h
		dw	05345h
		dw	09854h
		dw	0A880h
		dw	080CAh
		dw	044F6h
		dw	08480h
		dw	0183Eh
		dw	05704h
		dw	04941h
		dw	00054h
		dw	09B00h
		dw	01910h
		dw	05804h
		dw	04843h
		dw	09047h
		dw	09080h
		dw	08092h
		dw	04490h
		dw	08680h
		dw	01855h
		dw	05804h
		dw	0414Ch
		dw	00054h
		dw	0D700h
		dw	01940h
		dw	05803h
		dw	0524Fh
		dw	08098h
		dw	0C234h
		dw	03080h
		dw	0B04Ah
		dw	01B80h
		dw	00419h
		dw	05241h
		dw	04C50h
		dw	0843Ah
		dw	02663h
		dw	00319h
		dw	0414Ch
		dw	03852h
		dw	00F85h
		dw	09002h
		dw	00417h
		dw	04C43h
		dw	05354h
		dw	00500h
		dw	0060Fh
		dw	018F5h
		dw	04C04h
		dw	04447h
		dw	03654h
		dw	00F55h
		dw	0D501h
		dw	00418h
		dw	04753h
		dw	05444h
		dw	04536h
		dw	0010Fh
		dw	0165Fh
		dw	04C04h
		dw	04449h
		dw	03654h
		dw	00F5Dh
		dw	0A801h
		dw	00418h
		dw	04953h
		dw	05444h
		dw	04D36h
		dw	0010Fh
		dw	01973h
		dw	04C04h
		dw	0444Ch
		dw	04654h
		dw	00F55h
		dw	0C300h
		dw	00418h
		dw	04C53h
		dw	05444h
		dw	04546h
		dw	0000Fh
		dw	017CAh
		dw	04C04h
		dw	0534Dh
		dw	04657h
		dw	00F75h
		dw	05A01h
		dw	00419h
		dw	04D53h
		dw	05753h
		dw	06546h
		dw	0010Fh
		dw	018FEh
		dw	04C03h
		dw	04C53h
		dw	08538h
		dw	0030Fh
		dw	019CAh
		dw	04C03h
		dw	05254h
		dw	05D46h
		dw	0000Fh
		dw	019D5h
		dw	05303h
		dw	05254h
		dw	04D46h
		dw	0000Fh
		dw	01969h
		dw	05604h
		dw	05245h
		dw	04652h
		dw	00F65h
		dw	0A900h
		dw	00419h
		dw	04556h
		dw	05752h
		dw	06D46h
		dw	0000Fh
		dw	019BFh
		dw	04603h
		dw	0444Ch
		dw	001D2h
		dw	0C1D9h
		dw	041D6h
		dw	0C0D9h
		dw	040DCh
		dw	05ED9h
		dw	0DB68h
		dw	019FEh
		dw	04604h
		dw	04C49h
		dw	0E244h
		dw	0DB40h
		dw	06864h
		dw	0CCDFh
		dw	00318h
		dw	05346h
		dw	0D254h
		dw	0DD01h
		dw	0D6D1h
		dw	0DD41h
		dw	05CD0h
		dw	0D950h
		dw	0199Eh
		dw	04604h
		dw	05453h
		dw	0D250h
		dw	0DD01h
		dw	0D6D9h
		dw	0DD41h
		dw	0DCD8h
		dw	0D958h
		dw	0785Eh
		dw	07DDBh
		dw	00419h
		dw	04946h
		dw	05453h
		dw	05062h
		dw	036DBh
		dw	00519h
		dw	04946h
		dw	05453h
		dw	0E250h
		dw	0DB58h
		dw	07864h
		dw	028DFh
		dw	0041Ah
		dw	04146h
		dw	04444h
		dw	001D2h
		dw	0C1DEh
		dw	081DAh
		dw	0C0D8h
		dw	081D8h
		dw	0C0DCh
		dw	0405Ch
		dw	035D8h
		dw	0051Ah
		dw	04146h
		dw	04444h
		dw	0D250h
		dw	0DE01h
		dw	058C1h
		dw	0DE81h
		dw	014C0h
		dw	0051Ah
		dw	04946h
		dw	04441h
		dw	06244h
		dw	0DA40h
		dw	019B4h
		dw	04604h
		dw	05553h
		dw	0D242h
		dw	0DE01h
		dw	0DAE9h
		dw	0D881h
		dw	0D8E0h
		dw	0DC81h
		dw	05CE8h
		dw	0D860h
		dw	01A73h
		dw	04605h
		dw	05553h
		dw	05042h
		dw	001D2h
		dw	0E9DEh
		dw	08158h
		dw	0E8DEh
		dw	01907h
		dw	04605h
		dw	05553h
		dw	05242h
		dw	001D2h
		dw	0E1DEh
		dw	081DAh
		dw	0E8D8h
		dw	081D8h
		dw	0E0DCh
		dw	0685Ch
		dw	0A4D8h
		dw	0061Ah
		dw	05346h
		dw	04255h
		dw	05052h
		dw	001D2h
		dw	0E1DEh
		dw	08158h
		dw	0E0DEh
		dw	018BAh
		dw	04605h
		dw	05349h
		dw	04255h
		dw	06062h
		dw	050DAh
		dw	00619h
		dw	04946h
		dw	05553h
		dw	05242h
		dw	06862h
		dw	009DAh
		dw	0041Ah
		dw	04D46h
		dw	04C55h
		dw	001D2h
		dw	0C9DEh
		dw	081DAh
		dw	0C8D8h
		dw	081D8h
		dw	0C8DCh
		dw	0485Ch
		dw	0EAD8h
		dw	00519h
		dw	04D46h
		dw	04C55h
		dw	0D250h
		dw	0DE01h
		dw	058C9h
		dw	0DE81h
		dw	0E0C8h
		dw	00519h
		dw	04946h
		dw	0554Dh
		dw	0624Ch
		dw	0DA48h
		dw	01AFDh
		dw	04604h
		dw	04944h
		dw	0D256h
		dw	0DE01h
		dw	0DAF9h
		dw	0D881h
		dw	0D8F0h
		dw	0DC81h
		dw	05CF8h
		dw	0D870h
		dw	01AF2h
		dw	04605h
		dw	04944h
		dw	05056h
		dw	001D2h
		dw	0F9DEh
		dw	08158h
		dw	0F8DEh
		dw	019F4h
		dw	04605h
		dw	04944h
		dw	05256h
		dw	001D2h
		dw	0F1DEh
		dw	081DAh
		dw	0F8D8h
		dw	081D8h
		dw	0F0DCh
		dw	0785Ch
		dw	03AD8h
		dw	0061Bh
		dw	04446h
		dw	05649h
		dw	05052h
		dw	001D2h
		dw	0F1DEh
		dw	08158h
		dw	0F0DEh
		dw	01ACAh
		dw	04605h
		dw	04449h
		dw	05649h
		dw	07062h
		dw	093DAh
		dw	00619h
		dw	04946h
		dw	04944h
		dw	05256h
		dw	07862h
		dw	065DAh
		dw	0041Ah
		dw	04346h
		dw	04D4Fh
		dw	001D2h
		dw	0D1D8h
		dw	041D6h
		dw	0D0D8h
		dw	0505Ch
		dw	009D8h
		dw	0051Bh
		dw	04346h
		dw	04D4Fh
		dw	0D250h
		dw	0D801h
		dw	0D6D9h
		dw	0D841h
		dw	05CD8h
		dw	0D858h
		dw	01B1Fh
		dw	04606h
		dw	04F43h
		dw	0504Dh
		dw	05250h
		dw	0DE01h
		dw	046D9h
		dw	0051Ah
		dw	04946h
		dw	04F43h
		dw	0624Dh
		dw	0DA50h
		dw	01B2Fh
		dw	04606h
		dw	04349h
		dw	04D4Fh
		dw	06250h
		dw	0DA58h
		dw	01BD1h
		dw	04605h
		dw	05832h
		dw	0314Dh
		dw	00152h
		dw	0F0D9h
		dw	01BDCh
		dw	04604h
		dw	04241h
		dw	05253h
		dw	0D901h
		dw	050E1h
		dw	0041Bh
		dw	04246h
		dw	0444Ch
		dw	0605Eh
		dw	089DFh
		dw	0051Ah
		dw	04246h
		dw	05453h
		dw	05E50h
		dw	0DF70h
		dw	01BB1h
		dw	04604h
		dw	04843h
		dw	05253h
		dw	0D901h
		dw	05BE0h
		dw	0071Ah
		dw	04446h
		dw	04345h
		dw	05453h
		dw	05250h
		dw	0D901h
		dw	099F6h
		dw	0051Ah
		dw	04646h
		dw	04552h
		dw	05645h
		dw	0DD41h
		dw	014C0h
		dw	0071Ch
		dw	04946h
		dw	0434Eh
		dw	05453h
		dw	05250h
		dw	0D901h
		dw	02DF7h
		dw	0041Ch
		dw	04C46h
		dw	03144h
		dw	00152h
		dw	0E8D9h
		dw	01ABAh
		dw	04605h
		dw	0444Ch
		dw	05743h
		dw	06860h
		dw	0E8D9h
		dw	0061Bh
		dw	04C46h
		dw	04544h
		dw	0564Eh
		dw	06066h
		dw	047D9h
		dw	0061Ch
		dw	04C46h
		dw	04C44h
		dw	04532h
		dw	00152h
		dw	0EAD9h
		dw	01C1Fh
		dw	04606h
		dw	0444Ch
		dw	0324Ch
		dw	05254h
		dw	0D901h
		dw	077E9h
		dw	0061Bh
		dw	04C46h
		dw	04C44h
		dw	03247h
		dw	00152h
		dw	0ECD9h
		dw	01AE1h
		dw	04606h
		dw	0444Ch
		dw	04E4Ch
		dw	05232h
		dw	0D905h
		dw	009EDh
		dw	0051Ch
		dw	04C46h
		dw	05044h
		dw	05249h
		dw	0D901h
		dw	090EBh
		dw	0041Ch
		dw	04C46h
		dw	05A44h
		dw	00152h
		dw	0EED9h
		dw	01BC4h
		dw	04604h
		dw	04F4Eh
		dw	05250h
		dw	0D901h
		dw	0FFD0h
		dw	0061Bh
		dw	05046h
		dw	05441h
		dw	04E41h
		dw	00152h
		dw	0F3D9h
		dw	01C83h
		dw	04605h
		dw	05250h
		dw	04D45h
		dw	00152h
		dw	0F8D9h
		dw	01CBFh
		dw	04605h
		dw	05450h
		dw	04E41h
		dw	00152h
		dw	0F2D9h
		dw	01B93h
		dw	04607h
		dw	04E52h
		dw	04944h
		dw	0544Eh
		dw	00152h
		dw	0FCD9h
		dw	01C9Dh
		dw	04606h
		dw	05352h
		dw	04F54h
		dw	06852h
		dw	0DD60h
		dw	01BF4h
		dw	04606h
		dw	04353h
		dw	04C41h
		dw	05245h
		dw	0D901h
		dw	05DFDh
		dw	0061Ch
		dw	05346h
		dw	05445h
		dw	04D50h
		dw	00552h
		dw	0E4DBh
		dw	01C52h
		dw	04605h
		dw	05153h
		dw	05452h
		dw	00152h
		dw	0FAD9h
		dw	01B88h
		dw	04604h
		dw	05354h
		dw	05254h
		dw	0D901h
		dw	060E4h
		dw	0051Bh
		dw	05746h
		dw	04941h
		dw	05254h
		dw	09B00h
		dw	01CFEh
		dw	04604h
		dw	04158h
		dw	0524Dh
		dw	0D901h
		dw	0CCE5h
		dw	0041Ch
		dw	05846h
		dw	04843h
		dw	001D2h
		dw	0C9D9h
		dw	04156h
		dw	0C8D9h
		dw	01D45h
		dw	04607h
		dw	05458h
		dw	04152h
		dw	05443h
		dw	00152h
		dw	0F4D9h
		dw	01C39h
		dw	04605h
		dw	04C59h
		dw	05832h
		dw	00152h
		dw	0F1D9h
		dw	01CB4h
		dw	04607h
		dw	04C59h
		dw	05832h
		dw	03150h
		dw	00152h
		dw	0F9D9h
		dw	01D24h
		dw	04605h
		dw	04C43h
		dw	05845h
		dw	00252h
		dw	0DB01h
		dw	0F2E2h
		dw	0061Ch
		dw	04E46h
		dw	04C43h
		dw	05845h
		dw	00252h
		dw	0DB00h
		dw	089E2h
		dw	0051Dh
		dw	04446h
		dw	05349h
		dw	05249h
		dw	00102h
		dw	0E1DBh
		dw	01988h
		dw	04606h
		dw	0444Eh
		dw	05349h
		dw	05249h
		dw	00002h
		dw	0E1DBh
		dw	01CE4h
		dw	04604h
		dw	04E45h
		dw	05249h
		dw	00102h
		dw	0E0DBh
		dw	01D18h
		dw	04605h
		dw	0454Eh
		dw	0494Eh
		dw	00252h
		dw	0DB00h
		dw	054E0h
		dw	0051Dh
		dw	04946h
		dw	0494Eh
		dw	05254h
		dw	00102h
		dw	0E3DBh
		dw	01C76h
		dw	04606h
		dw	0494Eh
		dw	0494Eh
		dw	05254h
		dw	00002h
		dw	0E3DBh
		dw	01D62h
		dw	04605h
		dw	04153h
		dw	04556h
		dw	07168h
		dw	0DD01h
		dw	01D7Ch
		dw	04606h
		dw	0534Eh
		dw	05641h
		dw	06845h
		dw	00071h
		dw	0D8DDh
		dw	0051Dh
		dw	05346h
		dw	04354h
		dw	06057h
		dw	00179h
		dw	06ED9h
		dw	0061Dh
		dw	04E46h
		dw	05453h
		dw	05743h
		dw	07960h
		dw	0D900h
		dw	01DE6h
		dw	04606h
		dw	05453h
		dw	04E45h
		dw	06656h
		dw	00171h
		dw	0F2D9h
		dw	0071Dh
		dw	04E46h
		dw	05453h
		dw	04E45h
		dw	06656h
		dw	00071h
		dw	0FFD9h
		dw	0051Dh
		dw	05346h
		dw	05354h
		dw	0E057h
		dw	00179h
		dw	054DDh
		dw	00146h
		dw	0E0DFh
		dw	01E0Bh
		dw	04606h
		dw	0534Eh
		dw	05354h
		dw	0E057h
		dw	00079h
		dw	054DDh
		dw	00046h
		dw	0E0DFh

CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP


		public	BCC_NEAR_95A6

BCC_NEAR_95A6	proc	near
		mov	DI,1E5Ah
		ret
BCC_NEAR_95A6	endp
CODE8	ends

CODE8	segment byte public 'CODE'
		assume	cs:CODE8

		public	BCC_TABLE_95AA
BCC_TABLE_95AA	label	word
		dw	0000Eh
		dw	01F8Bh
		dw	01F7Bh
		dw	01F83h
		dw	01F53h
		dw	01FA3h
		dw	01FB3h
		dw	01F93h
		dw	01F73h
		dw	00000h
		dw	04F06h
		dw	04646h
		dw	04553h
		dw	04454h
		dw	00000h
		dw	05303h
		dw	04745h
		dw	00045h
		dw	00400h
		dw	05954h
		dw	04550h
		dw	00046h
		dw	00300h
		dw	05450h
		dw	05052h
		dw	01E7Dh
		dw	04E03h
		dw	0544Fh
		dw	00043h
		dw	00200h
		dw	0524Fh
		dw	08C48h
		dw	0031Eh
		dw	04F58h
		dw	04952h
		dw	00000h
		dw	04103h
		dw	0444Eh
		dw	0004Ah
		dw	00300h
		dw	04F4Dh
		dw	04B44h
		dw	00000h
		dw	05303h
		dw	05248h
		dw	0764Ch
		dw	0031Eh
		dw	04853h
		dw	04D4Ch
		dw	01EB5h
		dw	04804h
		dw	04749h
		dw	04E48h
		dw	01E93h
		dw	04C03h
		dw	0574Fh
		dw	0A04Fh
		dw	0041Eh
		dw	05942h
		dw	04554h
		dw	00166h
		dw	0CB00h
		dw	0041Eh
		dw	04F57h
		dw	04452h
		dw	00266h
		dw	08500h
		dw	0051Eh
		dw	05744h
		dw	0524Fh
		dw	06644h
		dw	00004h
		dw	01ED5h
		dw	05105h
		dw	04F57h
		dw	04452h
		dw	00866h
		dw	0DF00h
		dw	0051Eh
		dw	04254h
		dw	05459h
		dw	06645h
		dw	0000Ah
		dw	01EAEh
		dw	04E04h
		dw	04145h
		dw	06652h
		dw	0FFFFh
		dw	01E99h
		dw	04603h
		dw	05241h
		dw	0FE66h
		dw	0C4FFh
		dw	0021Eh
		dw	05841h
		dw	00165h
		dw	06C00h
		dw	0021Eh
		dw	05843h
		dw	00165h
		dw	00001h
		dw	0021Fh
		dw	05844h
		dw	00165h
		dw	0EA02h
		dw	0021Eh
		dw	05842h
		dw	00165h
		dw	01B03h
		dw	0021Fh
		dw	05053h
		dw	00165h
		dw	02B04h
		dw	0021Fh
		dw	05042h
		dw	00165h
		dw	02305h
		dw	0021Fh
		dw	04953h
		dw	00165h
		dw	0F506h
		dw	0021Eh
		dw	04944h
		dw	00165h
		dw	04B07h
		dw	0021Fh
		dw	04C41h
		dw	00065h
		dw	0A700h
		dw	0021Eh
		dw	04C43h
		dw	00065h
		dw	00A01h
		dw	0021Fh
		dw	04C44h
		dw	00065h
		dw	0BC02h
		dw	0021Eh
		dw	04C42h
		dw	00065h
		dw	01303h
		dw	0021Fh
		dw	04841h
		dw	00065h
		dw	03304h
		dw	0021Fh
		dw	04843h
		dw	00065h
		dw	04305h
		dw	0021Fh
		dw	04844h
		dw	00065h
		dw	03B06h
		dw	0021Fh
		dw	04842h
		dw	00065h
		dw	06307h
		dw	0021Fh
		dw	05345h
		dw	00265h
		dw	06B00h
		dw	0021Fh
		dw	05343h
		dw	00265h
		dw	09B01h
		dw	0021Fh
		dw	05353h
		dw	00265h
		dw	05B02h
		dw	0021Fh
		dw	05344h

		db	065h,002h,003h,0ABh,01Fh,002h,053h,054h,065h,004h,000h	; register table tail (was R9HEAD)
CODE8	ends
; END R8UNIT
		end
