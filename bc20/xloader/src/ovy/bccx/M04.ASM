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
DECLARE_VARIABLE:	int	3Fh	;@0BC50
	xor	byte ptr [bx+di], cl	;@0BC52
	db	0, 0CDh	; add ch, cl	;@0BC54
	aas	;@0BC56
	xchg	word ptr ds:[0CD00h], ax	;@0BC57
	aas	;@0BC5B
	push	ds	;@0BC5C
	add	ax, word ptr [bx+si]	;@0BC5D
PARSE_EXTERNAL_DECLARATIONS:	int	3Fh	;@0BC5F
	mov	di, 17h	;@0BC61
PARSE_DECL_INITIALIZER:	int	3Fh	;@0BC64
	and	ax, 11h	;@0BC66
MERGE_FUNCTION_DECLARATION:	int	3Fh	;@0BC69
	xor	ax, 4	;@0BC6B
DECLARE_TYPEDEF:	int	3Fh	;@0BC6E
	test	byte ptr [bx], al	;@0BC70
	add	byte ptr [bx+si], al	;@0BC72
	add	byte ptr [bx+si], al	;@0BC74
	add	byte ptr [bx+si], al	;@0BC76
	add	byte ptr [bx+si], al	;@0BC78
	add	byte ptr [bx+si], al	;@0BC7A
	add	byte ptr [bx+si], al	;@0BC7C
	add	byte ptr [bx+si], al	;@0BC7E
	int	3Fh	;@0BC80
	add	byte ptr [bx+si], al	;@0BC82
	push	ax	;@0BC84
	dec	si	;@0BC85
	add	byte ptr [bx+si], al	;@0BC86
	xor	ax, word ptr [di]	;@0BC88
	and	byte ptr [bx+si], al	;@0BC8A
	sbb	word ptr [bx+si], ax	;@0BC8C
	add	byte ptr [bx+si], al	;@0BC8E
	add	byte ptr [bx+si], al	;@0BC90
	add	byte ptr [bx+si], al	;@0BC92
	add	byte ptr [bx+si], al	;@0BC94
	add	byte ptr [bx+si], al	;@0BC96
	add	byte ptr [bx+si], al	;@0BC98
	add	byte ptr [bx+si], al	;@0BC9A
	add	byte ptr [bx+si], al	;@0BC9C
	add	byte ptr [bx+si], al	;@0BC9E
IS_BASED_NEAR_PTR:	int	3Fh	;@0BCA0
	jno	@@1	;@0BCA2
	db	0, 0CDh	; add ch, cl	;@0BCA4
@@1:	aas	;@0BCA6
	mov	cx, 3	;@0BCA7
STORAGE_INTRINSIC_NUMBER:	int	3Fh	;@0BCAA
	add	byte ptr [bx+si], al	;@0BCAC
	db	0, 0CDh	; add ch, cl	;@0BCAE
	aas	;@0BCB0
	add	ax, word ptr [bp+si]	;@0BCB1
	db	0, 0CDh	; add ch, cl	;@0BCB3
	aas	;@0BCB5
	sub	al, byte ptr [bx+si]	;@0BCB6
	db	0, 0CDh	; add ch, cl	;@0BCB8
	aas	;@0BCBA
	xlat	;@0BCBB
	add	byte ptr [bx+si], al	;@0BCBC
DECLARE_RUNTIME_SYMBOL:	int	3Fh	;@0BCBE
	sbb	ax, word ptr [bp+di]	;@0BCC0
	db	0, 0CDh	; add ch, cl	;@0BCC2
	aas	;@0BCC4
	jmp	short TEMP_STORAGE_FOR_TYPE+1	;@0BCC5
	db	0	;@0BCC7
TEMP_STORAGE_FOR_TYPE:	int	3Fh	;@0BCC8
	adc	al, 5	;@0BCCA
	db	0, 0CDh	; add ch, cl	;@0BCCC
	aas	;@0BCCE
	sub	word ptr [di], ax	;@0BCCF
	db	0, 0CDh	; add ch, cl	;@0BCD1
	aas	;@0BCD3
	ja	@@1+1	;@0BCD4
@@1:	db	0, 0CDh	; add ch, cl	;@0BCD6
	aas	;@0BCD8
	jne	@@2	;@0BCD9
@@2:	db	0, 0CDh	; add ch, cl	;@0BCDB
	aas	;@0BCDD
	dec	di	;@0BCDE
	add	word ptr [bx+si], ax	;@0BCDF
TYPE_ATTR_BYTE_0B:	int	3Fh	;@0BCE1
	db	0C8h, 2, 0, 0CDh	; enter 2, 0FFCDh	;@0BCE3
	aas	;@0BCE7
	movsw	;@0BCE8
	add	word ptr [bx+si], ax	;@0BCE9
NEAR_PTR_SUBKIND:	int	3Fh	;@0BCEB
	xchg	ax, bp	;@0BCED
	add	al, byte ptr [bx+si]	;@0BCEE
TYPE_ATTR_BYTE_0C:	int	3Fh	;@0BCF0
	mov	ah, 2	;@0BCF2
	db	0, 0CDh	; add ch, cl	;@0BCF4
	aas	;@0BCF6
	mov	word ptr [bp+di], 0CD00h	;@0BCF7
	aas	;@0BCFB
	popf	;@0BCFC
	add	ax, word ptr [bx+si]	;@0BCFD
SET_STORAGE_SEGMENT:	int	3Fh	;@0BCFF
	aam	1	;@0BD01
	db	0, 0CDh	; add ch, cl	;@0BD03
	aas	;@0BD05
	inc	sp	;@0BD06
	add	al, byte ptr [bx+si]	;@0BD07
SYMBOL_CATEGORY:	int	3Fh	;@0BD09
	push	sp	;@0BD0B
	add	byte ptr [bx+si], al	;@0BD0C
SYMBOL_TYPE_OF_STORAGE:	int	3Fh	;@0BD0E
	add	al, byte ptr [bp+di]	;@0BD10
	db	0, 0CDh	; add ch, cl	;@0BD12
	aas	;@0BD14
	fadd	qword ptr [bp+si]	;@0BD15
	db	0, 0CDh	; add ch, cl	;@0BD17
	aas	;@0BD19
	pop	di	;@0BD1A
	add	al, 0	;@0BD1B
	add	byte ptr [bx+si], al	;@0BD1D
	db	0	; add ch, cl	;@0BD1F
Y0B730	ends

Y0BD20	segment para public 'CODE'
	assume	cs:Y0BD20
	db	0CDh, 3Fh, 0, 0, 0B0h, 53h, 0, 0, 2Ch, 6, 80h, 0, 19h, 0, 0, 0	;@0BD20
Y0BD20	ends

Y0BD30	segment para public 'CODE'
	assume	cs:Y0BD30
	db	10h dup (0)	;@0BD30
FINISH_FUNCTION_STATE:	int	3Fh	;@0BD40
	mov	dx, 0	;@0BD42
SET_STREAM:	int	3Fh	;@0BD45
	lodsb	;@0BD47
	add	ax, 0CD00h	;@0BD48
	aas	;@0BD4B
	cmp	byte ptr [bp+di], al	;@0BD4C
	db	0, 0CDh	; add ch, cl	;@0BD4E
	aas	;@0BD50
	out	2, al	;@0BD51
	db	0, 0CDh	; add ch, cl	;@0BD53
	aas	;@0BD55
	sub	byte ptr [bx+di], al	;@0BD56
	db	0, 0CDh	; add ch, cl	;@0BD58
	aas	;@0BD5A
	adc	ax, 0	;@0BD5B
SPLICE_STATEMENT_CHAIN:	int	3Fh	;@0BD5E
	xchg	word ptr [bp+di], ax	;@0BD60
	db	0, 0CDh	; add ch, cl	;@0BD62
	aas	;@0BD64
	xlat	;@0BD65
	add	byte ptr [bx+si], al	;@0BD66
REGISTER_SYMBOL_VARIABLE:	int	3Fh	;@0BD68
	cld	;@0BD6A
	add	al, 0	;@0BD6B
EMIT_ZERO_BYTES:	int	3Fh	;@0BD6D
	rol	word ptr [di], 0	;@0BD6F
APPEND_BLOCK_IF_NONZERO:	int	3Fh	;@0BD72
	dec	dx	;@0BD74
	add	al, 0	;@0BD75
NEW_LABEL_IF_ENABLED:	int	3Fh	;@0BD77
	add	byte ptr [bx+si], al	;@0BD79
	db	0, 0CDh	; add ch, cl	;@0BD7B
	aas	;@0BD7D
	db	9Ah, 1	; lcall 0x3fcd, 1	;@0BD7E
Y0BD30	ends

Y0BD80	segment para public 'CODE'
	assume	cs:Y0BD80
	db	0	;@0BD80
APPEND_SWITCH_BLOCK:	int	3Fh	;@0BD81
	push	bx	;@0BD83
	add	word ptr [bx+si], ax	;@0BD84
APPEND_JUMP_BLOCK:	int	3Fh	;@0BD86
	lodsw	;@0BD88
	add	al, byte ptr [bx+si]	;@0BD89
EMIT_CONST_INIT_VALUE:	int	3Fh	;@0BD8B
	loop	@@1	;@0BD8D
	db	0, 0CDh	; add ch, cl	;@0BD8F
	aas	;@0BD91
	mov	dh, 1	;@0BD92
@@1:	db	0, 0CDh	; add ch, cl	;@0BD94
	aas	;@0BD96
	pop	si	;@0BD97
	add	al, byte ptr [bx+si]	;@0BD98
MAKE_JUMP_IF_TRUE_BLOCK:	int	3Fh	;@0BD9A
	add	al, 2	;@0BD9C
	db	0, 0CDh	; add ch, cl	;@0BD9E
	aas	;@0BDA0
	clts	;@0BDA1
	db	0, 0CDh	; add ch, cl	;@0BDA3
	aas	;@0BDA5
	add	al, byte ptr [si]	;@0BDA6
	db	0, 0CDh	; add ch, cl	;@0BDA8
	aas	;@0BDAA
	dec	ax	;@0BDAB
	add	ax, 0CD00h	;@0BDAC
	aas	;@0BDAF
	movsb	;@0BDB0
	add	ax, word ptr [bx+si]	;@0BDB1
APPEND_ANALYZED_EXPRESSION:	int	3Fh	;@0BDB3
	xchg	ax, si	;@0BDB5
	add	al, 0	;@0BDB6
APPEND_BLOCK_AND_MARK:	int	3Fh	;@0BDB8
	outsw	;@0BDBA
	add	al, 0	;@0BDBB
	add	byte ptr [bx+si], al	;@0BDBD
	db	0, 0CDh	; add ch, cl	;@0BDBF
	aas	;@0BDC1
	add	byte ptr [bx+si], al	;@0BDC2
	pusha	;@0BDC4
	pop	dx	;@0BDC5
	add	byte ptr [bx+si], al	;@0BDC6
	lodsw	;@0BDC8
	db	9, 6Ch, 0	; or word ptr [si], bp	;@0BDC9
	db	3, 0	; add ax, word ptr [bx+si]	;@0BDCC
	add	byte ptr [bx+si], al	;@0BDCE
	add	byte ptr [bx+si], al	;@0BDD0
	add	byte ptr [bx+si], al	;@0BDD2
	add	byte ptr [bx+si], al	;@0BDD4
	add	byte ptr [bx+si], al	;@0BDD6
	add	byte ptr [bx+si], al	;@0BDD8
	add	byte ptr [bx+si], al	;@0BDDA
	add	byte ptr [bx+si], al	;@0BDDC
	add	byte ptr [bx+si], al	;@0BDDE
ANALYZE_AND_DECAY:	int	3Fh	;@0BDE0
	db	82h, 9, 0	; or byte ptr [bx+di], 0	;@0BDE2
RESOLVE_SYMBOL_REFERENCE:	int	3Fh	;@0BDE5
	add	byte ptr [bx+si], al	;@0BDE7
	db	0, 0CDh	; add ch, cl	;@0BDE9
	aas	;@0BDEB
	hlt	;@0BDEC
	add	ax, 0	;@0BDED
	int	3Fh	;@0BDF0
	add	byte ptr [bx+si], al	;@0BDF2
	nop	;@0BDF4
	db	64h, 0, 0	; add byte ptr [bx+si], al	;@0BDF5
	db	54h	; push sp	;@0BDF8
	sbb	di, word ptr ds:[0F01h]	;@0BDF9
	add	byte ptr [bx+si], al	;@0BDFD
	add	byte ptr [bx+si], al	;@0BDFF
	add	byte ptr [bx+si], al	;@0BE01
	add	byte ptr [bx+si], al	;@0BE03
	add	byte ptr [bx+si], al	;@0BE05
	add	byte ptr [bx+si], al	;@0BE07
	add	byte ptr [bx+si], al	;@0BE09
	add	byte ptr [bx+si], al	;@0BE0B
	add	byte ptr [bx+si], al	;@0BE0D
	db	0, 0CDh	; add ch, cl	;@0BE0F
	aas	;@0BE11
	rcl	word ptr ds:[0CD00h], 1	;@0BE12
	aas	;@0BE16
	db	0E1h, 0Bh	; loope CHECK_ASSIGNMENT	;@0BE17
	db	0, 0CDh	; add ch, cl	;@0BE19
	aas	;@0BE1B
	inc	ax	;@0BE1C
	sbb	byte ptr [bx+si], al	;@0BE1D
CHECK_ADDITION:	db	0CDh	; int 3Fh	;@0BE1F
Y0BD80	ends

Y0BE20	segment para public 'CODE'
	assume	cs:Y0BE20
	db	3Fh, 24h, 13h, 0	;@0BE20
CHECK_ASSIGNMENT:	int	3Fh	;@0BE24
	mov	al, byte ptr ds:[4]	;@0BE26
CHECK_COMPOUND_ASSIGNMENT:	int	3Fh	;@0BE29
	push	sp	;@0BE2B
	or	byte ptr [bx+si], al	;@0BE2C
CHECK_SUBTRACTION:	int	3Fh	;@0BE2E
	int	14h	;@0BE30
	db	0, 0CDh	; add ch, cl	;@0BE32
	aas	;@0BE34
	rol	word ptr ds:[0CD00h], 3Fh	;@0BE35
	pop	ax	;@0BE3A
	or	ax, 0CD00h	;@0BE3B
	aas	;@0BE3E
	out	dx, al	;@0BE3F
	adc	byte ptr [bx+si], al	;@0BE40
ELIDE_COPY_ASSIGN:	int	3Fh	;@0BE42
	movsb	;@0BE44
	add	ax, word ptr [bx+si]	;@0BE45
CHECK_INTEGRAL_OP:	int	3Fh	;@0BE47
	pop	bp	;@0BE49
	push	cs	;@0BE4A
	db	0, 0CDh	; add ch, cl	;@0BE4B
	aas	;@0BE4D
	adc	cx, word ptr [bx]	;@0BE4E
	db	0, 0CDh	; add ch, cl	;@0BE50
	aas	;@0BE52
	call	dword ptr [bx+di]	;@0BE53
	db	0, 0CDh	; add ch, cl	;@0BE55
	aas	;@0BE57
	db	64h, 11h, 0	; adc word ptr [bx+si], ax	;@0BE58
	db	0, 0	; add byte ptr [bx+si], al	;@0BE5B
	add	byte ptr [bx+si], al	;@0BE5D
	db	0, 0CDh	; add ch, cl	;@0BE5F
	aas	;@0BE61
	add	byte ptr [bx+si], al	;@0BE62
	db	30h, 81h, 0, 0	; xor byte ptr [bx+di], al	;@0BE64
	db	0FBh	; sti	;@0BE68
	or	cl, byte ptr [bx+si+300h]	;@0BE69
	add	byte ptr [bx+si], al	;@0BE6D
	add	byte ptr [bx+si], al	;@0BE6F
	add	byte ptr [bx+si], al	;@0BE71
	add	byte ptr [bx+si], al	;@0BE73
	add	byte ptr [bx+si], al	;@0BE75
	add	byte ptr [bx+si], al	;@0BE77
	add	byte ptr [bx+si], al	;@0BE79
	add	byte ptr [bx+si], al	;@0BE7B
	add	byte ptr [bx+si], al	;@0BE7D
	db	0, 0CDh	; add ch, cl	;@0BE7F
	aas	;@0BE81
	xor	al, 6	;@0BE82
	db	0, 0CDh	; add ch, cl	;@0BE84
	aas	;@0BE86
	push	ax	;@0BE87
	or	al, byte ptr [bx+si]	;@0BE88
REPORT_ARGUMENT_MISMATCH:	int	3Fh	;@0BE8A
	mov	di, 3	;@0BE8C
	db	0, 0CDh	; add ch, cl	;@0BE8F
	aas	;@0BE91
	add	byte ptr [bx+si], al	;@0BE92
	db	0C0h, 8Ch, 0, 0, 0C6h	; ror byte ptr [si], 0C6h	;@0BE94
	db	0Ch, 64h	; or al, 64h	;@0BE99
	add	byte ptr ds:[0], al	;@0BE9B
	add	byte ptr [bx+si], al	;@0BE9F
	add	byte ptr [bx+si], al	;@0BEA1
	add	byte ptr [bx+si], al	;@0BEA3
	add	byte ptr [bx+si], al	;@0BEA5
	add	byte ptr [bx+si], al	;@0BEA7
	add	byte ptr [bx+si], al	;@0BEA9
	add	byte ptr [bx+si], al	;@0BEAB
	add	byte ptr [bx+si], al	;@0BEAD
	db	0, 0CDh	; add ch, cl	;@0BEAF
	aas	;@0BEB1
	sbb	cl, byte ptr [bp+si]	;@0BEB2
	db	0, 0CDh	; add ch, cl	;@0BEB4
	aas	;@0BEB6
	lodsw	;@0BEB7
	add	ax, word ptr [bx+si]	;@0BEB8
BUILD_DEREF:	int	3Fh	;@0BEBA
	db	0E9h, 0, 0	; jmp near ptr BUILD_LOGICAL_NOT	;@0BEBC
BUILD_LOGICAL_NOT:	db	0CDh	; int 3Fh	;@0BEBF
Y0BE20	ends

Y0BEC0	segment para public 'CODE'
	assume	cs:Y0BEC0
	db	3Fh, 0C6h, 0Bh, 0	;@0BEC0
BUILD_COMPLEMENT:	int	3Fh	;@0BEC4
	cli	;@0BEC6
	or	al, byte ptr [bx+si]	;@0BEC7
BUILD_INCDEC:	int	3Fh	;@0BEC9
	add	cl, byte ptr [bx+di]	;@0BECB
	add	byte ptr [bx+si], al	;@0BECD
	db	0, 0CDh	; add ch, cl	;@0BECF
	aas	;@0BED1
	add	byte ptr [bx+si], al	;@0BED2
	db	0F0h, 99h, 0, 0, 9Eh, 10h, 6Ch, 0, 0Eh, 0, 0, 0, 0, 0, 0, 0, 0	;@0BED4
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0BEC0	ends

Y0BEF0	segment para public 'CODE'
	assume	cs:Y0BEF0
CONVERT_EXPR_TO_TYPE:	int	3Fh	;@0BEF0
	lahf	;@0BEF2
	add	al, byte ptr [bx+si]	;@0BEF3
CHECK_CAST:	int	3Fh	;@0BEF5
	stosb	;@0BEF7
	or	byte ptr [bx+si], al	;@0BEF8
MAKE_ADDRESS_OF:	int	3Fh	;@0BEFA
	xchg	word ptr [bp+si], ax	;@0BEFC
	db	0, 0CDh	; add ch, cl	;@0BEFE
	aas	;@0BF00
	mov	bl, 0Ah	;@0BF01
	db	0, 0CDh	; add ch, cl	;@0BF03
	aas	;@0BF05
	or	ax, 7	;@0BF06
IS_BIT_FIELD_NODE:	int	3Fh	;@0BF09
	push	bp	;@0BF0B
	pop	es	;@0BF0C
	db	0, 0CDh	; add ch, cl	;@0BF0D
	aas	;@0BF0F
	push	bx	;@0BF10
	add	byte ptr [bx+si], al	;@0BF11
BALANCE_BINARY_OPERANDS:	int	3Fh	;@0BF13
	mov	di, 0Ch	;@0BF15
CONVERT_TO_RVALUE:	int	3Fh	;@0BF18
	db	0C8h, 5, 0, 0CDh	; enter 5, 0FFCDh	;@0BF1A
	aas	;@0BF1E
	sbb	al, 10h	;@0BF1F
	db	0, 0CDh	; add ch, cl	;@0BF21
	aas	;@0BF23
	sahf	;@0BF24
	add	al, 0	;@0BF25
ENUM_UNDERLYING_TYPE:	int	3Fh	;@0BF27
	db	0EAh, 5, 0, 0CDh, 3Fh	; ljmp 0x3fcd:5	;@0BF29
	adc	byte ptr ds:[0CD00h], al	;@0BF2E
	aas	;@0BF32
	add	byte ptr [bx+si], al	;@0BF33
	add	byte ptr [bx+si], al	;@0BF35
	add	byte ptr [bx+si], al	;@0BF37
	add	byte ptr [bx+si], al	;@0BF39
	add	byte ptr [bx+si], al	;@0BF3B
	add	byte ptr [bx+si], al	;@0BF3D
	db	0, 0CDh	; add ch, cl	;@0BF3F
	aas	;@0BF41
	add	byte ptr [bx+si], al	;@0BF42
	db	0, 0ABh, 0, 0	; add byte ptr [bp+di], ch	;@0BF44
	db	0A0h, 26h, 0D8h	; mov al, byte ptr ds:[0D826h]	;@0BF48
	add	al, byte ptr [di]	;@0BF4B
	add	byte ptr [bx+si], al	;@0BF4D
	add	byte ptr [bx+si], al	;@0BF4F
	add	byte ptr [bx+si], al	;@0BF51
	add	byte ptr [bx+si], al	;@0BF53
	add	byte ptr [bx+si], al	;@0BF55
	add	byte ptr [bx+si], al	;@0BF57
	add	byte ptr [bx+si], al	;@0BF59
	add	byte ptr [bx+si], al	;@0BF5B
	add	byte ptr [bx+si], al	;@0BF5D
	db	0	; add ch, cl	;@0BF5F
Y0BEF0	ends

Y0BF60	segment para public 'CODE'
	assume	cs:Y0BF60
RELEASE_SCOPE_OBJECTS:	int	3Fh	;@0BF60
	add	byte ptr [bx+si], al	;@0BF62
	db	0, 0CDh	; add ch, cl	;@0BF64
	aas	;@0BF66
	frstor	dword ptr [si]	;@0BF67
	db	0, 0CDh	; add ch, cl	;@0BF69
	aas	;@0BF6B
	or	byte ptr ds:[0CD00h], cl	;@0BF6C
	aas	;@0BF70
	xchg	ax, si	;@0BF71
	add	al, 0	;@0BF72
PARSE_FUNCTION_BODY:	int	3Fh	;@0BF74
	iret	;@0BF76
	db	25h, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 80h, 0D4h, 0, 0	;@0BF77
	db	37h, 10h, 8Ah, 0, 1, 0, 0, 0
Y0BF60	ends

Y0BF90	segment para public 'CODE'
	assume	cs:Y0BF90
	db	10h dup (0)	;@0BF90
INIT_PARSER:	int	3Fh	;@0BFA0
	jne	@@1	;@0BFA2
	add	byte ptr [bx+si], al	;@0BFA4
	add	byte ptr [bx+si], al	;@0BFA6
	add	byte ptr [bx+si], al	;@0BFA8
	add	byte ptr [bx+si], al	;@0BFAA
	add	byte ptr [bx+si], al	;@0BFAC
	add	byte ptr [bx+si], al	;@0BFAE
	int	3Fh	;@0BFB0
@@1:	add	byte ptr [bx+si], al	;@0BFB2
	push	ax	;@0BFB4
	in	ax, 0	;@0BFB5
	add	byte ptr [di], ch	;@0BFB7
	push	es	;@0BFB9
	or	byte ptr [bx+si], al	;@0BFBA
	add	al, 0	;@0BFBC
	add	byte ptr [bx+si], al	;@0BFBE
	add	byte ptr [bx+si], al	;@0BFC0
	add	byte ptr [bx+si], al	;@0BFC2
	add	byte ptr [bx+si], al	;@0BFC4
	add	byte ptr [bx+si], al	;@0BFC6
	add	byte ptr [bx+si], al	;@0BFC8
	add	byte ptr [bx+si], al	;@0BFCA
	add	byte ptr [bx+si], al	;@0BFCC
	add	byte ptr [bx+si], al	;@0BFCE
Y0BF90	ends
	end
