	.286p
	locals

Y0D570	segment para public 'CODE'
	assume	cs:Y0D570
	db	0CDh, 3Fh, 0, 0, 0B0h, 0A0h, 4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0	;@0D570
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D570	ends

Y0D5A0	segment para public 'CODE'
	assume	cs:Y0D5A0
	db	0CDh, 3Fh, 0, 0, 0C0h, 0A0h, 4, 0, 9Ch, 1, 2Ah, 0, 3, 0, 0, 0	;@0D5A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
CLEAR_BACKEND_STATE:	int	3Fh	;@0D5C0
	add	byte ptr [bx+si], al	;@0D5C2
	db	0, 0CDh	; add ch, cl	;@0D5C4
	aas	;@0D5C6
	pop	bx	;@0D5C7
	add	word ptr [bx+si], ax	;@0D5C8
INIT_BACKEND:	int	3Fh	;@0D5CA
	push	ss	;@0D5CC
	add	byte ptr [bx+si], al	;@0D5CD
	db	0, 0CDh	; add ch, cl	;@0D5CF
	aas	;@0D5D1
	add	byte ptr [bx+si], al	;@0D5D2
	nop	;@0D5D4
	mov	byte ptr ds:[4], al	;@0D5D5
	sti	;@0D5D8
	add	word ptr [si], sp	;@0D5D9
	add	byte ptr [bx+di], al	;@0D5DB
	add	byte ptr [bx+si], al	;@0D5DD
	add	byte ptr [bx+si], al	;@0D5DF
	add	byte ptr [bx+si], al	;@0D5E1
	add	byte ptr [bx+si], al	;@0D5E3
	add	byte ptr [bx+si], al	;@0D5E5
	add	byte ptr [bx+si], al	;@0D5E7
	add	byte ptr [bx+si], al	;@0D5E9
	add	byte ptr [bx+si], al	;@0D5EB
	add	byte ptr [bx+si], al	;@0D5ED
	db	0, 0CDh	; add ch, cl	;@0D5EF
	aas	;@0D5F1
	add	byte ptr [bx+si], al	;@0D5F2
	add	byte ptr [bx+si], al	;@0D5F4
	add	byte ptr [bx+si], al	;@0D5F6
	add	byte ptr [bx+si], al	;@0D5F8
	add	byte ptr [bx+si], al	;@0D5FA
	add	byte ptr [bx+si], al	;@0D5FC
	add	byte ptr [bx+si], al	;@0D5FE
	int	3Fh	;@0D600
	add	byte ptr [bx+si], al	;@0D602
	mov	al, 0A4h	;@0D604
	add	al, 0	;@0D606
	add	byte ptr [bx+si], al	;@0D608
	add	byte ptr [bx+si], al	;@0D60A
	add	byte ptr [bx+si], al	;@0D60C
	add	byte ptr [bx+si], al	;@0D60E
	add	byte ptr [bx+si], al	;@0D610
	add	byte ptr [bx+si], al	;@0D612
	add	byte ptr [bx+si], al	;@0D614
	add	byte ptr [bx+si], al	;@0D616
	add	byte ptr [bx+si], al	;@0D618
	add	byte ptr [bx+si], al	;@0D61A
	add	byte ptr [bx+si], al	;@0D61C
	add	byte ptr [bx+si], al	;@0D61E
	int	3Fh	;@0D620
	add	byte ptr [bx+si], al	;@0D622
	db	0C0h, 0A4h, 4, 0, 0C4h	; shl byte ptr [si+4], 0C4h	;@0D624
	db	10h, 44h, 0	; adc byte ptr [si], al	;@0D629
	or	ax, 0	;@0D62C
	db	0	; add byte ptr [bx+si], al	;@0D62F
Y0D5A0	ends

Y0D630	segment para public 'CODE'
	assume	cs:Y0D630
	db	10h dup (0)	;@0D630
EMIT_CODE_BYTE:	int	3Fh	;@0D640
	add	byte ptr [bx+si], al	;@0D642
	db	0, 0CDh	; add ch, cl	;@0D644
	aas	;@0D646
	sbb	byte ptr [bp+si], al	;@0D647
	db	0, 0CDh	; add ch, cl	;@0D649
	aas	;@0D64B
	pushf	;@0D64C
	add	al, byte ptr [bx+si]	;@0D64D
DEFINE_ASM_LABEL:	int	3Fh	;@0D64F
	mov	ch, 0	;@0D651
	db	0, 0CDh	; add ch, cl	;@0D653
	aas	;@0D655
	les	ax, dword ptr [bx+si]	;@0D656
	db	0, 0CDh	; add ch, cl	;@0D658
	aas	;@0D65A
	db	0C8h, 2, 0, 0CDh	; enter 2, 0FFCDh	;@0D65B
	aas	;@0D65F
	dec	ax	;@0D660
	add	ax, word ptr [bx+si]	;@0D661
EMIT_THIS_ADJUST_THUNK:	int	3Fh	;@0D663
	aaa	;@0D665
	add	word ptr [bx+si], ax	;@0D666
ADD_NAMED_FIXUP:	int	3Fh	;@0D668
	db	0CDh, 3	; int 3	;@0D66A
	db	0, 0CDh	; add ch, cl	;@0D66C
	aas	;@0D66E
	xchg	ax, dx	;@0D66F
Y0D630	ends

Y0D670	segment para public 'CODE'
	assume	cs:Y0D670
	db	3, 0	;@0D670
EMIT_LOAD_DATA_SEGMENT:	int	3Fh	;@0D672
	out	2, al	;@0D674
	db	0, 0CDh	; add ch, cl	;@0D676
	aas	;@0D678
	out	3, al	;@0D679
	db	0, 0CDh	; add ch, cl	;@0D67B
	aas	;@0D67D
	push	ax	;@0D67E
	add	byte ptr [bx+si], al	;@0D67F
	add	byte ptr [bx+si], al	;@0D681
	add	byte ptr [bx+si], al	;@0D683
	add	byte ptr [bx+si], al	;@0D685
	add	byte ptr [bx+si], al	;@0D687
	add	byte ptr [bx+si], al	;@0D689
	add	byte ptr [bx+si], al	;@0D68B
	add	byte ptr [bx+si], al	;@0D68D
	db	0, 0CDh	; add ch, cl	;@0D68F
	aas	;@0D691
	add	byte ptr [bx+si], al	;@0D692
	db	0D0h, 0B5h, 4, 0	; sal byte ptr [di+4], 1	;@0D694
	db	0, 0	; add byte ptr [bx+si], al	;@0D698
	add	byte ptr [bx+si], al	;@0D69A
	add	byte ptr [bx+si], al	;@0D69C
	add	byte ptr [bx+si], al	;@0D69E
Y0D670	ends

Y0D6A0	segment para public 'CODE'
	assume	cs:Y0D6A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D6A0
	db	0E0h, 0B5h, 4, 0, 0A9h, 0Dh, 20h, 0, 0Fh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D6A0	ends

Y0D6D0	segment para public 'CODE'
	assume	cs:Y0D6D0
OBJ_WRITE_MODULE:	int	3Fh	;@0D6D0
	pop	cx	;@0D6D2
	add	ax, 0CD00h	;@0D6D3
	aas	;@0D6D6
	push	sp	;@0D6D7
	add	byte ptr [bx+si], al	;@0D6D8
OBJ_QUEUE_WORD:	int	3Fh	;@0D6DA
	out	dx, ax	;@0D6DC
	add	byte ptr [bx+si], al	;@0D6DD
OBJ_RESET_RECORD:	int	3Fh	;@0D6DF
	add	byte ptr [bx+si], al	;@0D6E1
	db	0, 0CDh	; add ch, cl	;@0D6E3
	aas	;@0D6E5
	or	ax, word ptr [bx+si]	;@0D6E6
	db	0, 0CDh	; add ch, cl	;@0D6E8
	aas	;@0D6EA
	dec	cx	;@0D6EB
	add	byte ptr [bx+si], al	;@0D6EC
OBJ_WRITE_RECORD:	int	3Fh	;@0D6EE
	db	9Ah, 0, 0, 0CDh, 3Fh	; lcall 0x3fcd, 0	;@0D6F0
	rol	word ptr [si], 0	;@0D6F5
OBJ_FLUSH_QUEUED_WORDS:	int	3Fh	;@0D6F8
	adc	al, byte ptr [bx+di]	;@0D6FA
	db	0, 0CDh	; add ch, cl	;@0D6FC
	aas	;@0D6FE
	pop	ds	;@0D6FF
Y0D6D0	ends

Y0D700	segment para public 'CODE'
	assume	cs:Y0D700
	db	0, 0	;@0D700
OBJ_RECORD_BUFFER:	int	3Fh	;@0D702
	mov	ax, word ptr ds:[0Dh]	;@0D704
OBJ_NOP:	int	3Fh	;@0D707
	mov	bp, 8	;@0D709
OBJ_WRITE_MODULE_HEADER:	int	3Fh	;@0D70C
	inc	di	;@0D70E
	add	al, 0	;@0D70F
OBJ_WRITE_FILE_ENTRY:	int	3Fh	;@0D711
	scasb	;@0D713
	add	word ptr [bx+si], ax	;@0D714
OBJ_PUT_WORD:	int	3Fh	;@0D716
	jg	@@1	;@0D718
@@1:	add	byte ptr [bx+si], al	;@0D71A
	add	byte ptr [bx+si], al	;@0D71C
	add	byte ptr [bx+si], al	;@0D71E
Y0D700	ends

Y0D720	segment para public 'CODE'
	assume	cs:Y0D720
	db	0CDh, 3Fh, 0, 0, 0B0h, 0C3h, 4, 0, 53h, 7, 28h, 0, 0Fh, 0, 0, 0	;@0D720
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ADD_RELOCATION:	int	3Fh	;@0D740
	db	0CDh, 3	; int 3	;@0D742
	db	0, 0CDh	; add ch, cl	;@0D744
	aas	;@0D746
	push	ax	;@0D747
	add	word ptr [bx+si], ax	;@0D748
ALIGN_SEGMENT_EVEN:	int	3Fh	;@0D74A
	test	byte ptr [si], 0	;@0D74C
EMIT_DATA_BYTE:	int	3Fh	;@0D74F
	db	66h, 5, 0, 0CDh, 3Fh, 79h	; add eax, 793FCD00h	;@0D751
	push	es	;@0D757
	db	0, 0CDh	; add ch, cl	;@0D758
	aas	;@0D75A
	pop	word ptr [bx+di]	;@0D75B
	db	0, 0CDh	; add ch, cl	;@0D75D
	aas	;@0D75F
	movsw	;@0D760
	push	es	;@0D761
	db	0, 0CDh	; add ch, cl	;@0D762
	aas	;@0D764
	int	3	;@0D765
	push	es	;@0D766
	db	0, 0CDh	; add ch, cl	;@0D767
	aas	;@0D769
	jle	@@1+1	;@0D76A
	db	0, 0CDh	; add ch, cl	;@0D76C
	aas	;@0D76E
@@1:	db	0F2h, 6	; push es	;@0D76F
	db	0, 0CDh	; add ch, cl	;@0D771
	aas	;@0D773
	outsb	;@0D774
	add	al, byte ptr [bx+si]	;@0D775
ANY_SEGMENT_HAS_DATA:	int	3Fh	;@0D777
	db	26h, 7	; pop es	;@0D779
	db	0, 0CDh	; add ch, cl	;@0D77B
	aas	;@0D77D
	mov	cx, 1	;@0D77E
FIND_SEGMENT:	int	3Fh	;@0D781
	into	;@0D783
	add	word ptr [bx+si], ax	;@0D784
DEFINE_SEGMENT:	int	3Fh	;@0D786
	add	byte ptr [bx+si], al	;@0D788
	add	byte ptr [bx+si], al	;@0D78A
	add	byte ptr [bx+si], al	;@0D78C
	add	byte ptr [bx+si], al	;@0D78E
Y0D720	ends

Y0D790	segment para public 'CODE'
	assume	cs:Y0D790
	db	0CDh, 3Fh, 0, 0, 40h, 0CBh, 4, 0, 2Eh, 0Fh, 3Ch, 0, 14h, 0, 0	;@0D790
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D790	ends

Y0D7B0	segment para public 'CODE'
	assume	cs:Y0D7B0
INIT_FUNCTION_STATE:	int	3Fh	;@0D7B0
	add	byte ptr [bx+di], al	;@0D7B2
	db	0, 0CDh	; add ch, cl	;@0D7B4
	aas	;@0D7B6
	push	cs	;@0D7B7
	str	bp	;@0D7B8
	aas	;@0D7BB
	push	ds	;@0D7BC
	str	bp	;@0D7BD
	aas	;@0D7C0
	cmp	ax, word ptr [bx+si]	;@0D7C1
	db	0, 0CDh	; add ch, cl	;@0D7C3
	aas	;@0D7C5
	xlat	;@0D7C6
	add	al, 0	;@0D7C7
NEW_LABEL:	int	3Fh	;@0D7C9
	pop	bx	;@0D7CB
	add	ax, 0CD00h	;@0D7CC
	aas	;@0D7CF
	add	cl, byte ptr [bp+di]	;@0D7D0
	db	0, 0CDh	; add ch, cl	;@0D7D2
	aas	;@0D7D4
	xchg	word ptr [di], ax	;@0D7D5
	db	0, 0CDh	; add ch, cl	;@0D7D7
	aas	;@0D7D9
	ret	6	;@0D7DA
JOIN_BLOCK_CHAINS:	int	3Fh	;@0D7DD
	sbb	cl, byte ptr ds:[0CD00h]	;@0D7DF
	aas	;@0D7E3
	jno	@@1+1	;@0D7E4
	db	0, 0CDh	; add ch, cl	;@0D7E6
	aas	;@0D7E8
	pusha	;@0D7E9
@@1:	add	al, 0	;@0D7EA
NEW_RETURN_JUMP_BLOCK:	int	3Fh	;@0D7EC
	adc	al, 6	;@0D7EE
	db	0, 0CDh	; add ch, cl	;@0D7F0
	aas	;@0D7F2
	add	byte ptr [bx+si], al	;@0D7F3
	db	0, 0CDh	; add ch, cl	;@0D7F5
	aas	;@0D7F7
	mov	word ptr [bp+di], es	;@0D7F8
	db	0, 0CDh	; add ch, cl	;@0D7FA
	aas	;@0D7FC
	bound	ax, dword ptr [bp+di]	;@0D7FD
	db	0, 0CDh	; add ch, cl	;@0D7FF
	aas	;@0D801
	into	;@0D802
	add	word ptr [bx+si], ax	;@0D803
NEW_EXPRESSION_BLOCK:	int	3Fh	;@0D805
	rol	byte ptr [bp+di], 0	;@0D807
NEW_SCOPE_ENTER_BLOCK:	int	3Fh	;@0D80A
	js	@@1+1	;@0D80C
@@1:	db	0, 0CDh	; add ch, cl	;@0D80E
	aas	;@0D810
	rol	byte ptr [bp+si], 1	;@0D811
	add	byte ptr [bx+si], al	;@0D813
	add	byte ptr [bx+si], al	;@0D815
	add	byte ptr [bx+si], al	;@0D817
	add	byte ptr [bx+si], al	;@0D819
	add	byte ptr [bx+si], al	;@0D81B
	add	byte ptr [bx+si], al	;@0D81D
	db	0	; add ch, cl	;@0D81F
Y0D7B0	ends

Y0D820	segment para public 'CODE'
	assume	cs:Y0D820
	db	0CDh, 3Fh, 0, 0, 0D0h, 0DAh, 4, 0, 0B1h, 2, 12h, 0, 5, 0, 0, 0	;@0D820
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NEW_CONSTANT_NODE:	int	3Fh	;@0D840
	xchg	ax, sp	;@0D842
	add	word ptr [bx+si], ax	;@0D843
NEW_PLAIN_CODE_NODE:	int	3Fh	;@0D845
	inc	ax	;@0D847
	add	word ptr [bx+si], ax	;@0D848
NEW_CODE_NODE:	int	3Fh	;@0D84A
	add	byte ptr [bx+si], al	;@0D84C
	db	0, 0CDh	; add ch, cl	;@0D84E
	aas	;@0D850
	call	NEW_VARIABLE_NODE+1	;@0D851
NEW_VARIABLE_NODE:	int	3Fh	;@0D854
	fld	dword ptr [bx+si]	;@0D856
	add	byte ptr [bx+si], al	;@0D858
	add	byte ptr [bx+si], al	;@0D85A
	add	byte ptr [bx+si], al	;@0D85C
	add	byte ptr [bx+si], al	;@0D85E
	int	3Fh	;@0D860
	add	byte ptr [bx+si], al	;@0D862
	mov	al, byte ptr ds:[4DDh]	;@0D864
	add	byte ptr [bx+di+22h], dl	;@0D867
	test	byte ptr [bx+di], al	;@0D86A
	or	ax, word ptr [bx+si]	;@0D86C
	add	byte ptr [bx+si], al	;@0D86E
	add	byte ptr [bx+si], al	;@0D870
	add	byte ptr [bx+si], al	;@0D872
	add	byte ptr [bx+si], al	;@0D874
	add	byte ptr [bx+si], al	;@0D876
	add	byte ptr [bx+si], al	;@0D878
	add	byte ptr [bx+si], al	;@0D87A
	add	byte ptr [bx+si], al	;@0D87C
	add	byte ptr [bx+si], al	;@0D87E
EMIT_TEST_ZERO:	int	3Fh	;@0D880
	cmpsb	;@0D882
	or	al, byte ptr [bx+si]	;@0D883
EMIT_RETURN_VALUE:	int	3Fh	;@0D885
	das	;@0D887
	or	al, byte ptr [bx+si]	;@0D888
EMIT_COMPARE:	int	3Fh	;@0D88A
	db	0DDh, 0Ch	; fisttp qword ptr [si]	;@0D88C
	db	0, 0CDh	; add ch, cl	;@0D88E
Y0D820	ends

Y0D890	segment para public 'CODE'
	assume	cs:Y0D890
	db	3Fh, 31h, 18h, 0	;@0D890
GENERATE_EXPRESSION:	int	3Fh	;@0D894
	add	byte ptr [bx+si], al	;@0D896
	db	0, 0CDh	; add ch, cl	;@0D898
	aas	;@0D89A
	mov	si, 17h	;@0D89B
SEGMENT_REGISTER_CODE:	int	3Fh	;@0D89E
	lodsb	;@0D8A0
	or	al, 0	;@0D8A1
DEFAULT_SEGMENT_NODE:	int	3Fh	;@0D8A3
	or	al, 20h	;@0D8A5
	db	0, 0CDh	; add ch, cl	;@0D8A7
	aas	;@0D8A9
	mov	dl, byte ptr [bp+di]	;@0D8AA
	db	0, 0CDh	; add ch, cl	;@0D8AC
	aas	;@0D8AE
	pushf	;@0D8AF
	adc	ax, 0CD00h	;@0D8B0
	aas	;@0D8B3
	cmp	dl, byte ptr ds:[0]	;@0D8B4
	add	byte ptr [bx+si], al	;@0D8B8
	add	byte ptr [bx+si], al	;@0D8BA
	add	byte ptr [bx+si], al	;@0D8BC
	add	byte ptr [bx+si], al	;@0D8BE
	int	3Fh	;@0D8C0
	add	byte ptr [bx+si], al	;@0D8C2
	nop	;@0D8C4
	add	word ptr [di], ax	;@0D8C5
	add	byte ptr [di+200h], ah	;@0D8C7
	add	byte ptr [bp+di], al	;@0D8CB
	add	byte ptr [bx+si], al	;@0D8CD
	add	byte ptr [bx+si], al	;@0D8CF
	add	byte ptr [bx+si], al	;@0D8D1
	add	byte ptr [bx+si], al	;@0D8D3
	add	byte ptr [bx+si], al	;@0D8D5
	add	byte ptr [bx+si], al	;@0D8D7
	add	byte ptr [bx+si], al	;@0D8D9
	add	byte ptr [bx+si], al	;@0D8DB
	add	byte ptr [bx+si], al	;@0D8DD
	db	0, 0CDh	; add ch, cl	;@0D8DF
	aas	;@0D8E1
	sub	ax, word ptr [bx+si]	;@0D8E2
	db	0, 0CDh	; add ch, cl	;@0D8E4
	aas	;@0D8E6
	add	byte ptr [bx+si], al	;@0D8E7
	db	0, 0CDh	; add ch, cl	;@0D8E9
	aas	;@0D8EB
	or	byte ptr [bx+si], al	;@0D8EC
	add	byte ptr [bx+si], al	;@0D8EE
	int	3Fh	;@0D8F0
	add	byte ptr [bx+si], al	;@0D8F2
	inc	ax	;@0D8F4
	add	al, byte ptr [di]	;@0D8F5
	add	byte ptr [bx+si], al	;@0D8F7
	add	byte ptr [bx+si], al	;@0D8F9
	add	byte ptr [bx+si], al	;@0D8FB
	add	byte ptr [bx+si], al	;@0D8FD
	add	byte ptr [bx+si], al	;@0D8FF
	add	byte ptr [bx+si], al	;@0D901
	add	byte ptr [bx+si], al	;@0D903
	add	byte ptr [bx+si], al	;@0D905
	add	byte ptr [bx+si], al	;@0D907
	add	byte ptr [bx+si], al	;@0D909
	add	byte ptr [bx+si], al	;@0D90B
	add	byte ptr [bx+si], al	;@0D90D
	db	0, 0CDh	; add ch, cl	;@0D90F
	aas	;@0D911
	add	byte ptr [bx+si], al	;@0D912
	push	ax	;@0D914
	add	al, byte ptr [di]	;@0D915
	add	byte ptr [si+1], dl	;@0D917
	xor	al, byte ptr [bx+si]	;@0D91A
	add	ax, word ptr [bx+si]	;@0D91C
	add	byte ptr [bx+si], al	;@0D91E
Y0D890	ends
	end
