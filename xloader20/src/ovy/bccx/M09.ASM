	.286p
	locals
	public	L0CEC5

Y0CE90	segment para public 'CODE'
	assume	cs:Y0CE90
	db	10h dup (0)	;@0CE90
NEW_BITFIELD_NODE_ALT:	int	3Fh	;@0CEA0
	popa	;@0CEA2
	add	word ptr [bx+si], ax	;@0CEA3
BCC_NODE_MODE:	int	3Fh	;@0CEA5
	add	word ptr [bx+si], 0CD00h	;@0CEA7
	aas	;@0CEAB
	leave	;@0CEAC
	add	al, 0	;@0CEAD
BCC_NODE_CONVERT:	int	3Fh	;@0CEAF
	sbb	al, byte ptr [bp+si]	;@0CEB1
	db	0, 0CDh	; add ch, cl	;@0CEB3
	aas	;@0CEB5
	adc	word ptr [bx+si], ax	;@0CEB6
	db	0, 0CDh	; add ch, cl	;@0CEB8
	aas	;@0CEBA
	ret	1	;@0CEBB
BCC_NODE_RESET:	int	3Fh	;@0CEBE
Y0CE90	ends

Y0CEC0	segment para public 'CODE'
	assume	cs:Y0CEC0
	db	0, 0, 0	;@0CEC0
BCC_NODE_INTEGER:	int	3Fh	;@0CEC3
L0CEC5:	db	0F3h, 0, 0	; add byte ptr [bx+si], al	;@0CEC5
	db	0, 0	; add byte ptr [bx+si], al	;@0CEC8
	add	byte ptr [bx+si], al	;@0CECA
	add	byte ptr [bx+si], al	;@0CECC
	add	byte ptr [bx+si], al	;@0CECE
	int	3Fh	;@0CED0
	add	byte ptr [bx+si], al	;@0CED2
	adc	byte ptr [bp+3], al	;@0CED4
	add	byte ptr [di+5009h], ah	;@0CED7
	add	byte ptr [di], al	;@0CEDB
	add	byte ptr [bx+si], al	;@0CEDD
	add	byte ptr [bx+si], al	;@0CEDF
	add	byte ptr [bx+si], al	;@0CEE1
	add	byte ptr [bx+si], al	;@0CEE3
	add	byte ptr [bx+si], al	;@0CEE5
	add	byte ptr [bx+si], al	;@0CEE7
	add	byte ptr [bx+si], al	;@0CEE9
	add	byte ptr [bx+si], al	;@0CEEB
	add	byte ptr [bx+si], al	;@0CEED
	db	0	; add ch, cl	;@0CEEF
Y0CEC0	ends

Y0CEF0	segment para public 'CODE'
	assume	cs:Y0CEF0
BCC_NAME_COMPARE:	int	3Fh	;@0CEF0
	dec	ax	;@0CEF2
	add	byte ptr [bx+si], al	;@0CEF3
SCAN_ASM_TOKEN:	int	3Fh	;@0CEF5
	popa	;@0CEF7
	add	byte ptr [bx+si], al	;@0CEF8
BCC_LEX_SKIP:	int	3Fh	;@0CEFA
	call	L0CF06+1	;@0CEFC
PARSE_ASM_STATEMENT:	int	3Fh	;@0CEFF
	rol	word ptr [bp+di], 1	;@0CF01
	db	0, 0CDh	; add ch, cl	;@0CF03
	aas	;@0CF05
L0CF06:	mov	sp, 8	;@0CF06
	add	byte ptr [bx+si], al	;@0CF09
	add	byte ptr [bx+si], al	;@0CF0B
	add	byte ptr [bx+si], al	;@0CF0D
	db	0, 0CDh	; add ch, cl	;@0CF0F
	aas	;@0CF11
	add	byte ptr [bx+si], al	;@0CF12
	and	byte ptr [bx+si+3], dl	;@0CF14
	add	byte ptr [di+2], bl	;@0CF17
	sub	al, 0	;@0CF1A
	pop	es	;@0CF1C
	add	byte ptr [bx+si], al	;@0CF1D
	db	0	; add byte ptr [bx+si], al	;@0CF1F
Y0CEF0	ends

Y0CF20	segment para public 'CODE'
	assume	cs:Y0CF20
	db	10h dup (0)	;@0CF20
C11_EXPECT:	int	3Fh	;@0CF30
	add	byte ptr [bx+si], al	;@0CF32
	db	0, 0CDh	; add ch, cl	;@0CF34
	aas	;@0CF36
	add	byte ptr es:[bx+si], al	;@0CF37
TYPE_LOOKUP_FAR:	int	3Fh	;@0CF3A
	jnp	@@1	;@0CF3C
@@1:	db	0, 0CDh	; add ch, cl	;@0CF3E
	aas	;@0CF40
	db	0EAh, 1, 0, 0CDh, 3Fh	; ljmp 0x3fcd:1	;@0CF41
	xor	al, 1	;@0CF46
	db	0, 0CDh	; add ch, cl	;@0CF48
	aas	;@0CF4A
	arpl	word ptr [bx+di], ax	;@0CF4B
	db	0, 0CDh	; add ch, cl	;@0CF4D
	aas	;@0CF4F
Y0CF20	ends

Y0CF50	segment para public 'CODE'
	assume	cs:Y0CF50
	db	16h, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0CF50
	db	0, 0B0h, 52h, 3, 0, 2Fh, 0Eh, 90h, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0CF50	ends

Y0CF80	segment para public 'CODE'
	assume	cs:Y0CF80
BCC_TYPE_NORMALIZE:	int	3Fh	;@0CF80
	push	dx	;@0CF82
	or	ax, 0CD00h	;@0CF83
	aas	;@0CF86
	test	byte ptr [bp+si], al	;@0CF87
	db	0, 0CDh	; add ch, cl	;@0CF89
	aas	;@0CF8B
	dec	bp	;@0CF8C
	add	ax, word ptr [bx+si]	;@0CF8D
DEFINE_STATIC_DATA_MEMBER:	int	3Fh	;@0CF8F
	db	0F1h	; int1	;@0CF91
	add	byte ptr [bx+si], al	;@0CF92
BCC_TYPE_MATCH:	int	3Fh	;@0CF94
	pop	word ptr [si]	;@0CF96
	db	0, 0CDh	; add ch, cl	;@0CF98
	aas	;@0CF9A
	and	byte ptr [bp+di], cl	;@0CF9B
	db	0, 0CDh	; add ch, cl	;@0CF9D
	aas	;@0CF9F
	add	byte ptr [bx+si], al	;@0CFA0
	db	0, 0CDh	; add ch, cl	;@0CFA2
	aas	;@0CFA4
	popa	;@0CFA5
	push	es	;@0CFA6
	add	byte ptr [bx+si], al	;@0CFA7
	add	byte ptr [bx+si], al	;@0CFA9
	add	byte ptr [bx+si], al	;@0CFAB
	add	byte ptr [bx+si], al	;@0CFAD
	db	0, 0CDh	; add ch, cl	;@0CFAF
	aas	;@0CFB1
	add	byte ptr [bx+si], al	;@0CFB2
	db	70h, 61h	; jo TYPE_OFFSET_FAR+1	;@0CFB4
	add	ax, word ptr [bx+si]	;@0CFB6
	clc	;@0CFB8
	db	21h, 0C4h	; and sp, ax	;@0CFB9
	add	word ptr [si], dx	;@0CFBB
	add	byte ptr [bx+si], al	;@0CFBD
	add	byte ptr [bx+si], al	;@0CFBF
	add	byte ptr [bx+si], al	;@0CFC1
	add	byte ptr [bx+si], al	;@0CFC3
	add	byte ptr [bx+si], al	;@0CFC5
	add	byte ptr [bx+si], al	;@0CFC7
	add	byte ptr [bx+si], al	;@0CFC9
	add	byte ptr [bx+si], al	;@0CFCB
	add	byte ptr [bx+si], al	;@0CFCD
	db	0	; add ch, cl	;@0CFCF
Y0CF80	ends

Y0CFD0	segment para public 'CODE'
	assume	cs:Y0CFD0
BCC_DECL_CASE0:	int	3Fh	;@0CFD0
	in	al, 1Bh	;@0CFD2
	db	0, 0CDh	; add ch, cl	;@0CFD4
	aas	;@0CFD6
	mov	word ptr ds:[21h], ax	;@0CFD7
TYPE_ENUM_FAR:	int	3Fh	;@0CFDA
	pop	sp	;@0CFDC
	sbb	al, byte ptr [bx+si]	;@0CFDD
TYPE_FINALIZE_FAR:	int	3Fh	;@0CFDF
	outsw	;@0CFE1
	or	ax, word ptr [bx+si]	;@0CFE2
TYPE_RELINK_FAR:	int	3Fh	;@0CFE4
	mov	ax, word ptr ds:[18h]	;@0CFE6
BCC_DECL_CASE3:	int	3Fh	;@0CFE9
	mov	bp, 1Ch	;@0CFEB
TYPE_SCOPE_FAR:	int	3Fh	;@0CFEE
	add	bl, byte ptr [bp+si]	;@0CFF0
	db	0, 0CDh	; add ch, cl	;@0CFF2
	aas	;@0CFF4
	adc	ax, 1Ch	;@0CFF5
TYPE_PATH_FAR:	int	3Fh	;@0CFF8
	rol	byte ptr [bx+si], cl	;@0CFFA
	db	0, 0CDh	; add ch, cl	;@0CFFC
	aas	;@0CFFE
	add	byte ptr [bx+si], al	;@0CFFF
	db	0, 0CDh	; add ch, cl	;@0D001
	aas	;@0D003
	pop	es	;@0D004
	and	byte ptr [bx+si], al	;@0D005
TYPE_OPERATOR_FAR:	int	3Fh	;@0D007
	out	2, ax	;@0D009
	db	0, 0CDh	; add ch, cl	;@0D00B
	aas	;@0D00D
	lahf	;@0D00E
	pop	ss	;@0D00F
Y0CFD0	ends

Y0D010	segment para public 'CODE'
	assume	cs:Y0D010
	db	0	;@0D010
BCC_TYPE_RESOLVE_NAME:	int	3Fh	;@0D011
	db	3Eh, 0, 0	; add byte ptr ds:[bx+si], al	;@0D013
TYPE_OFFSET_FAR:	db	0CDh, 3Fh	; int 3Fh	;@0D016
	stc	;@0D018
	adc	word ptr [bx+si], ax	;@0D019
TYPE_DEFER_FAR:	int	3Fh	;@0D01B
	sbb	ax, 1Bh	;@0D01D
TYPE_DECLARE_FAR:	int	3Fh	;@0D020
	adc	cx, word ptr ds:[0CD00h]	;@0D022
	aas	;@0D026
	mov	word ptr [bx+di], bx	;@0D027
	db	0, 0CDh	; add ch, cl	;@0D029
	aas	;@0D02B
	inc	dx	;@0D02C
	push	ds	;@0D02D
	db	0, 0CDh	; add ch, cl	;@0D02E
	aas	;@0D030
	mov	dx, word ptr [si]	;@0D031
	add	byte ptr [bx+si], al	;@0D033
	add	byte ptr [bx+si], al	;@0D035
	add	byte ptr [bx+si], al	;@0D037
	add	byte ptr [bx+si], al	;@0D039
	add	byte ptr [bx+si], al	;@0D03B
	add	byte ptr [bx+si], al	;@0D03D
	db	0, 0CDh	; add ch, cl	;@0D03F
	aas	;@0D041
	add	byte ptr [bx+si], al	;@0D042
	db	30h, 85h, 3, 0	; xor byte ptr [di+3], al	;@0D044
	db	45h	; inc bp	;@0D048
	or	al, 94h	;@0D049
	add	byte ptr [di], al	;@0D04B
	add	byte ptr [bx+si], al	;@0D04D
	add	byte ptr [bx+si], al	;@0D04F
	add	byte ptr [bx+si], al	;@0D051
	add	byte ptr [bx+si], al	;@0D053
	add	byte ptr [bx+si], al	;@0D055
	add	byte ptr [bx+si], al	;@0D057
	add	byte ptr [bx+si], al	;@0D059
	add	byte ptr [bx+si], al	;@0D05B
	add	byte ptr [bx+si], al	;@0D05D
	db	0	; add ch, cl	;@0D05F
Y0D010	ends

Y0D060	segment para public 'CODE'
	assume	cs:Y0D060
TYPE_CLOSE:	int	3Fh	;@0D060
	mov	al, byte ptr [bx]	;@0D062
	db	0, 0CDh	; add ch, cl	;@0D064
	aas	;@0D066
	push	di	;@0D067
	or	word ptr [bx+si], ax	;@0D068
ADD_DATA_MEMBER:	int	3Fh	;@0D06A
	push	es	;@0D06C
	add	al, byte ptr [bx+si]	;@0D06D
TYPE_LOOP_FAR:	int	3Fh	;@0D06F
	push	bp	;@0D071
	add	ax, 0CD00h	;@0D072
	aas	;@0D075
	db	8Bh, 6, 0, 0	; mov ax, word ptr ds:[0]	;@0D076
	db	0, 0	; add byte ptr [bx+si], al	;@0D07A
	add	byte ptr [bx+si], al	;@0D07C
	add	byte ptr [bx+si], al	;@0D07E
	int	3Fh	;@0D080
	add	byte ptr [bx+si], al	;@0D082
	db	10h, 92h, 3, 0	; adc byte ptr [bp+si+3], dl	;@0D084
	db	19h, 22h	; sbb word ptr [bp+si], sp	;@0D088
	sbb	al, 2	;@0D08A
	or	byte ptr [bx+si], al	;@0D08C
	add	byte ptr [bx+si], al	;@0D08E
	add	byte ptr [bx+si], al	;@0D090
	add	byte ptr [bx+si], al	;@0D092
	add	byte ptr [bx+si], al	;@0D094
	add	byte ptr [bx+si], al	;@0D096
	add	byte ptr [bx+si], al	;@0D098
	add	byte ptr [bx+si], al	;@0D09A
	add	byte ptr [bx+si], al	;@0D09C
	add	byte ptr [bx+si], al	;@0D09E
EMIT_DEBUG_SCOPE_SYMBOLS:	int	3Fh	;@0D0A0
	db	72h, 15h	; jb L0D0B6+3	;@0D0A2
	db	0, 0CDh	; add ch, cl	;@0D0A4
	aas	;@0D0A6
	inc	sp	;@0D0A7
	adc	ax, 0CD00h	;@0D0A8
	aas	;@0D0AB
	hlt	;@0D0AC
	sbb	al, byte ptr [bx+si]	;@0D0AD
EMIT_DEBUG_MEMBER_PTR_TYPE:	db	0CDh	; int 3Fh	;@0D0AF
Y0D060	ends

Y0D0B0	segment para public 'CODE'
	assume	cs:Y0D0B0
	db	3Fh, 5Ch, 0Bh, 0	;@0D0B0
EMIT_DEBUG_TYPE:	int	3Fh	;@0D0B4
L0D0B6:	test	word ptr ds:[0CD00h], ax	;@0D0B6
	aas	;@0D0BA
	inc	bx	;@0D0BB
	or	al, 0	;@0D0BC
EMIT_DEBUG_TREE_LOCALS:	int	3Fh	;@0D0BE
	xor	word ptr [bp+si], bx	;@0D0C0
	db	0, 0CDh	; add ch, cl	;@0D0C2
	aas	;@0D0C4
	add	byte ptr es:[bx+si], al	;@0D0C5
	add	byte ptr [bx+si], al	;@0D0C8
	add	byte ptr [bx+si], al	;@0D0CA
	add	byte ptr [bx+si], al	;@0D0CC
	add	byte ptr [bx+si], al	;@0D0CE
	int	3Fh	;@0D0D0
	add	byte ptr [bx+si], al	;@0D0D2
	push	ax	;@0D0D4
	mov	dh, 3	;@0D0D5
	add	byte ptr [bx+di], al	;@0D0D7
	add	byte ptr [bx+si], al	;@0D0D9
	add	byte ptr [bx+di], al	;@0D0DB
	add	byte ptr [bx+si], al	;@0D0DD
	add	byte ptr [bx+si], al	;@0D0DF
	add	byte ptr [bx+si], al	;@0D0E1
	add	byte ptr [bx+si], al	;@0D0E3
	add	byte ptr [bx+si], al	;@0D0E5
	add	byte ptr [bx+si], al	;@0D0E7
	add	byte ptr [bx+si], al	;@0D0E9
	add	byte ptr [bx+si], al	;@0D0EB
	add	byte ptr [bx+si], al	;@0D0ED
	db	0, 0CDh	; add ch, cl	;@0D0EF
	aas	;@0D0F1
	add	byte ptr [bx+si], al	;@0D0F2
	add	byte ptr [bx+si], al	;@0D0F4
	add	byte ptr [bx+si], al	;@0D0F6
	add	byte ptr [bx+si], al	;@0D0F8
	add	byte ptr [bx+si], al	;@0D0FA
	add	byte ptr [bx+si], al	;@0D0FC
	add	byte ptr [bx+si], al	;@0D0FE
	int	3Fh	;@0D100
	add	byte ptr [bx+si], al	;@0D102
	pusha	;@0D104
	mov	dh, 3	;@0D105
	add	byte ptr [bx+di+1], dl	;@0D107
	or	byte ptr [bx+si], al	;@0D10A
	add	ax, 0	;@0D10C
	add	byte ptr [bx+si], al	;@0D10F
	add	byte ptr [bx+si], al	;@0D111
	add	byte ptr [bx+si], al	;@0D113
	add	byte ptr [bx+si], al	;@0D115
	add	byte ptr [bx+si], al	;@0D117
	add	byte ptr [bx+si], al	;@0D119
	add	byte ptr [bx+si], al	;@0D11B
	add	byte ptr [bx+si], al	;@0D11D
	db	0, 0CDh	; add ch, cl	;@0D11F
	aas	;@0D121
	adc	byte ptr [bx+di], al	;@0D122
	db	0, 0CDh	; add ch, cl	;@0D124
	aas	;@0D126
	add	byte ptr [bx+si], al	;@0D127
	db	0, 0CDh	; add ch, cl	;@0D129
	aas	;@0D12B
	in	ax, 0	;@0D12C
	db	0, 0CDh	; add ch, cl	;@0D12E
	aas	;@0D130
	push	si	;@0D131
	add	byte ptr [bx+si], al	;@0D132
POOL_FREE_ITEM:	int	3Fh	;@0D134
	add	byte ptr ss:[bx+si], al	;@0D136
	add	byte ptr [bx+si], al	;@0D139
	add	byte ptr [bx+si], al	;@0D13B
	add	byte ptr [bx+si], al	;@0D13D
	db	0	; add ch, cl	;@0D13F
Y0D0B0	ends

Y0D140	segment para public 'CODE'
	assume	cs:Y0D140
	db	0CDh, 3Fh, 0, 0, 0C0h, 0B7h, 3, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0	;@0D140
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0D0h, 0B7h, 3
	db	0, 3Ch, 9, 88h, 0, 3, 0, 0, 0
Y0D140	ends

Y0D180	segment para public 'CODE'
	assume	cs:Y0D180
	db	10h dup (0)	;@0D180
COMPILE_C_SOURCE:	int	3Fh	;@0D190
	add	byte ptr [bx+si], al	;@0D192
	db	0, 0CDh	; add ch, cl	;@0D194
	aas	;@0D196
	sub	al, 0	;@0D197
	db	0, 0CDh	; add ch, cl	;@0D199
	aas	;@0D19B
	jl	@@1+1	;@0D19C
	add	byte ptr [bx+si], al	;@0D19E
@@1:	int	3Fh	;@0D1A0
	add	byte ptr [bx+si], al	;@0D1A2
	mov	al, byte ptr ds:[3C1h]	;@0D1A4
	add	byte ptr [bx-55D5h], ch	;@0D1A7
	add	word ptr [bp+di], cx	;@0D1AB
	add	byte ptr [bx+si], al	;@0D1AD
	add	byte ptr [bx+si], al	;@0D1AF
	add	byte ptr [bx+si], al	;@0D1B1
	add	byte ptr [bx+si], al	;@0D1B3
	add	byte ptr [bx+si], al	;@0D1B5
	add	byte ptr [bx+si], al	;@0D1B7
	add	byte ptr [bx+si], al	;@0D1B9
	add	byte ptr [bx+si], al	;@0D1BB
	add	byte ptr [bx+si], al	;@0D1BD
	db	0, 0CDh	; add ch, cl	;@0D1BF
	aas	;@0D1C1
	sbb	byte ptr [bx+di], al	;@0D1C2
	db	0, 0CDh	; add ch, cl	;@0D1C4
	aas	;@0D1C6
	add	ax, 1Ch	;@0D1C7
BCC_STMT_DECL_PARSE:	int	3Fh	;@0D1CA
	fimul	word ptr [bx]	;@0D1CC
	db	0, 0CDh	; add ch, cl	;@0D1CE
Y0D180	ends
	end
