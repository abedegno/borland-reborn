	.286p
	locals

Y0C6C0	segment para public 'CODE'
	assume	cs:Y0C6C0
	db	3Fh, 41h, 13h, 0	;@0C6C0
BUILD_IDENTIFIER_NODE:	int	3Fh	;@0C6C4
	rol	byte ptr ds:[0CD00h], cl	;@0C6C6
	aas	;@0C6CA
	call	@@1	;@0C6CB
	add	byte ptr [bx+si], al	;@0C6CE
	int	3Fh	;@0C6D0
	add	byte ptr [bx+si], al	;@0C6D2
	mov	al, byte ptr ds:[20Ch]	;@0C6D4
@@1:	add	byte ptr [bx+di+17h], dh	;@0C6D7
	push	sp	;@0C6DA
	add	byte ptr [di], ah	;@0C6DB
	add	byte ptr [bx+si], al	;@0C6DD
	add	byte ptr [bx+si], al	;@0C6DF
	add	byte ptr [bx+si], al	;@0C6E1
	add	byte ptr [bx+si], al	;@0C6E3
	add	byte ptr [bx+si], al	;@0C6E5
	add	byte ptr [bx+si], al	;@0C6E7
	add	byte ptr [bx+si], al	;@0C6E9
	add	byte ptr [bx+si], al	;@0C6EB
	add	byte ptr [bx+si], al	;@0C6ED
	db	0	; add ch, cl	;@0C6EF
Y0C6C0	ends

Y0C6F0	segment para public 'CODE'
	assume	cs:Y0C6F0
PICK_WIDER_TYPE:	int	3Fh	;@0C6F0
	push	dx	;@0C6F2
	or	al, 0	;@0C6F3
JOIN_COMMA_EXPR:	int	3Fh	;@0C6F5
	push	es	;@0C6F7
	or	byte ptr [bx+si], al	;@0C6F8
C7_TYPE_COMPAT:	int	3Fh	;@0C6FA
	sub	cx, word ptr [bx+di]	;@0C6FC
	db	0, 0CDh	; add ch, cl	;@0C6FE
	aas	;@0C700
	xchg	ax, dx	;@0C701
	add	ax, word ptr [bx+si]	;@0C702
CREATE_TEMP_SYMBOL:	int	3Fh	;@0C704
	loopne	@@1	;@0C706
	db	0, 0CDh	; add ch, cl	;@0C708
	aas	;@0C70A
	add	ax, word ptr [si]	;@0C70B
@@1:	db	0, 0CDh	; add ch, cl	;@0C70D
	aas	;@0C70F
	dec	bp	;@0C710
	pop	es	;@0C711
	db	0, 0CDh	; add ch, cl	;@0C712
	aas	;@0C714
	mov	ch, 0	;@0C715
	db	0, 0CDh	; add ch, cl	;@0C717
	aas	;@0C719
	fiadd	dword ptr [bx]	;@0C71A
	db	0, 0CDh	; add ch, cl	;@0C71C
	aas	;@0C71E
	pushf	;@0C71F
	str	bp	;@0C720
	aas	;@0C723
	jae	@@2	;@0C724
	db	0, 0CDh	; add ch, cl	;@0C726
@@2:	aas	;@0C728
	xchg	ax, cx	;@0C729
	push	cs	;@0C72A
	db	0, 0CDh	; add ch, cl	;@0C72B
	aas	;@0C72D
	db	0C8h, 16h	; enter 16h, 0FFCDh	;@0C72E
Y0C6F0	ends

Y0C730	segment para public 'CODE'
	assume	cs:Y0C730
	db	0	;@0C730
SAVE_EXPR_IN_TEMP:	int	3Fh	;@0C731
	mov	bp, 15h	;@0C733
COPY_EXPR_TREE:	int	3Fh	;@0C736
	add	ax, 15h	;@0C738
FREE_EXPR_NODE:	int	3Fh	;@0C73B
	xor	ax, 1	;@0C73D
RESET_EXPR_POOL_ALT:	int	3Fh	;@0C740
	movsb	;@0C742
	add	byte ptr [bx+si], al	;@0C743
CHECK_NULL_CONSTANT:	int	3Fh	;@0C745
	or	word ptr [si], 0CD00h	;@0C747
	aas	;@0C74B
	sbb	byte ptr [bp+si], al	;@0C74C
	db	0, 0CDh	; add ch, cl	;@0C74E
	aas	;@0C750
	dec	sp	;@0C751
	add	al, byte ptr [bx+si]	;@0C752
MAKE_CAST_NODE:	int	3Fh	;@0C754
	sub	word ptr [si], ax	;@0C756
	db	0, 0CDh	; add ch, cl	;@0C758
	aas	;@0C75A
	xor	al, 3	;@0C75B
	db	0, 0CDh	; add ch, cl	;@0C75D
	aas	;@0C75F
	jns	@@1+1	;@0C760
	db	0, 0CDh	; add ch, cl	;@0C762
	aas	;@0C764
@@1:	jmp	short MAKE_REAL_CONSTANT	;@0C765
	db	0	;@0C767
MAKE_REAL_CONSTANT:	int	3Fh	;@0C768
	lodsb	;@0C76A
	add	word ptr [bx+si], ax	;@0C76B
BUILD_SYMBOL_EXPR:	int	3Fh	;@0C76D
	test	byte ptr [si], 0	;@0C76F
ALLOC_EXPR_NODE:	int	3Fh	;@0C772
	popa	;@0C774
	add	byte ptr [bx+si], al	;@0C775
IS_NAMED_OBJECT_EXPR:	int	3Fh	;@0C777
	inc	di	;@0C779
	adc	word ptr [bx+si], ax	;@0C77A
IS_SIDE_EFFECT_FREE:	int	3Fh	;@0C77C
	cli	;@0C77E
	or	ax, 0CD00h	;@0C77F
	aas	;@0C782
	and	byte ptr [bp+si], dl	;@0C783
	db	0, 0CDh	; add ch, cl	;@0C785
	aas	;@0C787
	dec	cx	;@0C788
	add	word ptr [bx+si], ax	;@0C789
MAKE_BINARY_NODE:	int	3Fh	;@0C78B
	retf	3	;@0C78D
Y0C730	ends

Y0C790	segment para public 'CODE'
	assume	cs:Y0C790
CREATE_LOCAL_TEMP:	int	3Fh	;@0C790
	imul	ax, word ptr ds:[0CD00h], 3Fh	;@0C792
	js	@@1+1	;@0C797
@@1:	db	0, 0CDh	; add ch, cl	;@0C799
	aas	;@0C79B
	popa	;@0C79C
	or	ax, 0CD00h	;@0C79D
	aas	;@0C7A0
	rol	word ptr [bx], 0	;@0C7A1
NULL_CONSTANT_TO_POINTER:	int	3Fh	;@0C7A4
	fmul	qword ptr [si]	;@0C7A6
	add	byte ptr [bx+si], al	;@0C7A8
	add	byte ptr [bx+si], al	;@0C7AA
	add	byte ptr [bx+si], al	;@0C7AC
	add	byte ptr [bx+si], al	;@0C7AE
	int	3Fh	;@0C7B0
	add	byte ptr [bx+si], al	;@0C7B2
	db	70h, 24h	; jo INIT_SCALAR	;@0C7B4
	add	al, byte ptr [bx+si]	;@0C7B6
	push	bp	;@0C7B8
	db	0Fh, 0CCh	; bswap sp	;@0C7B9
	add	byte ptr [di], al	;@0C7BB
	add	byte ptr [bx+si], al	;@0C7BD
	add	byte ptr [bx+si], al	;@0C7BF
	add	byte ptr [bx+si], al	;@0C7C1
	add	byte ptr [bx+si], al	;@0C7C3
	add	byte ptr [bx+si], al	;@0C7C5
	add	byte ptr [bx+si], al	;@0C7C7
	add	byte ptr [bx+si], al	;@0C7C9
	add	byte ptr [bx+si], al	;@0C7CB
	add	byte ptr [bx+si], al	;@0C7CD
	db	0	; add ch, cl	;@0C7CF
Y0C790	ends

Y0C7D0	segment para public 'CODE'
	assume	cs:Y0C7D0
IS_CONSTANT_INITIALIZER:	int	3Fh	;@0C7D0
	pop	word ptr [bx+si]	;@0C7D2
	db	0, 0CDh	; add ch, cl	;@0C7D4
	aas	;@0C7D6
	db	0C6h, 0Eh, 0	;@0C7D7
INIT_SCALAR:	int	3Fh	;@0C7DA
	pop	si	;@0C7DC
	add	word ptr [bx+si], ax	;@0C7DD
INIT_OBJECT:	int	3Fh	;@0C7DF
	or	byte ptr [si], cl	;@0C7E1
	db	0, 0CDh	; add ch, cl	;@0C7E3
	aas	;@0C7E5
	outsb	;@0C7E6
	or	ax, 0	;@0C7E7
	add	byte ptr [bx+si], al	;@0C7EA
	add	byte ptr [bx+si], al	;@0C7EC
	add	byte ptr [bx+si], al	;@0C7EE
	int	3Fh	;@0C7F0
	add	byte ptr [bx+si], al	;@0C7F2
	mov	al, byte ptr ds:[234h]	;@0C7F4
	add	byte ptr [bp+si], dl	;@0C7F7
	push	ss	;@0C7F9
	add	al, 1	;@0C7FA
	add	ax, 0	;@0C7FC
	add	byte ptr [bx+si], al	;@0C7FF
	add	byte ptr [bx+si], al	;@0C801
	add	byte ptr [bx+si], al	;@0C803
	add	byte ptr [bx+si], al	;@0C805
	add	byte ptr [bx+si], al	;@0C807
	add	byte ptr [bx+si], al	;@0C809
	add	byte ptr [bx+si], al	;@0C80B
	add	byte ptr [bx+si], al	;@0C80D
	db	0, 0CDh	; add ch, cl	;@0C80F
	aas	;@0C811
	xchg	ax, bp	;@0C812
	add	ax, 0CD00h	;@0C813
	aas	;@0C816
	mov	ah, 3	;@0C817
	db	0, 0CDh	; add ch, cl	;@0C819
	aas	;@0C81B
	sub	byte ptr ds:[0CD00h], al	;@0C81C
	aas	;@0C820
	adc	byte ptr [bp+di], 0	;@0C821
SUBSTITUTE_PARAMETERS:	int	3Fh	;@0C824
	sahf	;@0C826
	or	byte ptr [bx+si], al	;@0C827
	add	byte ptr [bx+si], al	;@0C829
	add	byte ptr [bx+si], al	;@0C82B
	add	byte ptr [bx+si], al	;@0C82D
	db	0, 0CDh	; add ch, cl	;@0C82F
	aas	;@0C831
	add	byte ptr [bx+si], al	;@0C832
	ror	byte ptr [bp+di+2], 0	;@0C834
	add	byte ptr [bx+si], al	;@0C838
	add	byte ptr [bx+si], al	;@0C83A
	add	byte ptr [bx+si], al	;@0C83C
	add	byte ptr [bx+si], al	;@0C83E
	add	byte ptr [bx+si], al	;@0C840
	add	byte ptr [bx+si], al	;@0C842
	add	byte ptr [bx+si], al	;@0C844
	add	byte ptr [bx+si], al	;@0C846
	add	byte ptr [bx+si], al	;@0C848
	add	byte ptr [bx+si], al	;@0C84A
	add	byte ptr [bx+si], al	;@0C84C
	add	byte ptr [bx+si], al	;@0C84E
BCC_MESSAGE_IMAGE:	int	3Fh	;@0C850
	add	byte ptr [bx+si], al	;@0C852
	add	byte ptr [bx+si], al	;@0C854
	add	byte ptr [bx+si], al	;@0C856
	pop	si	;@0C858
	xor	al, 0	;@0C859
	add	byte ptr [bx+si], al	;@0C85B
	add	byte ptr [bx+si], al	;@0C85D
	add	byte ptr [bx+si], al	;@0C85F
	add	byte ptr [bx+si], al	;@0C861
	add	byte ptr [bx+si], al	;@0C863
	add	byte ptr [bx+si], al	;@0C865
	add	byte ptr [bx+si], al	;@0C867
	add	byte ptr [bx+si], al	;@0C869
	add	byte ptr [bx+si], al	;@0C86B
	add	byte ptr [bx+si], al	;@0C86D
	db	0, 0CDh	; add ch, cl	;@0C86F
	aas	;@0C871
	add	byte ptr [bx+si], al	;@0C872
	ror	byte ptr [bp+di+2], 1	;@0C874
	db	0, 0F9h	; add cl, bh	;@0C877
	add	word ptr [bx+si], cx	;@0C879
	add	byte ptr [bp+di], al	;@0C87B
	add	byte ptr [bx+si], al	;@0C87D
	add	byte ptr [bx+si], al	;@0C87F
	add	byte ptr [bx+si], al	;@0C881
	add	byte ptr [bx+si], al	;@0C883
	add	byte ptr [bx+si], al	;@0C885
	add	byte ptr [bx+si], al	;@0C887
	add	byte ptr [bx+si], al	;@0C889
	add	byte ptr [bx+si], al	;@0C88B
	add	byte ptr [bx+si], al	;@0C88D
	db	0, 0CDh	; add ch, cl	;@0C88F
	aas	;@0C891
	add	byte ptr [bx+si], al	;@0C892
	db	0, 0CDh	; add ch, cl	;@0C894
	aas	;@0C896
	mov	word ptr [bx+si], ax	;@0C897
	db	0, 0CDh	; add ch, cl	;@0C899
	aas	;@0C89B
	push	cx	;@0C89C
	add	word ptr [bx+si], ax	;@0C89D
	db	0, 0CDh	; add ch, cl	;@0C89F
	aas	;@0C8A1
	add	byte ptr [bx+si], al	;@0C8A2
	db	0E0h, 4Dh	; loopne L0C8F3	;@0C8A4
	add	al, byte ptr [bx+si]	;@0C8A6
	push	ax	;@0C8A8
	db	11h, 54h, 0	; adc word ptr [si], dx	;@0C8A9
	db	4, 0	; add al, 0	;@0C8AC
	add	byte ptr [bx+si], al	;@0C8AE
Y0C7D0	ends

Y0C8B0	segment para public 'CODE'
	assume	cs:Y0C8B0
	db	10h dup (0)	;@0C8B0
APPLY_CONVERSION_FUNCTION:	int	3Fh	;@0C8C0
	sahf	;@0C8C2
	adc	byte ptr [bx+si], al	;@0C8C3
FIND_USER_CONVERSION:	int	3Fh	;@0C8C5
	add	al, 0Fh	;@0C8C7
	db	0, 0CDh	; add ch, cl	;@0C8C9
	aas	;@0C8CB
	pop	di	;@0C8CC
	add	ax, word ptr [bx+si]	;@0C8CD
SELECT_OVERLOAD:	int	3Fh	;@0C8CF
	out	0Bh, ax	;@0C8D1
	add	byte ptr [bx+si], al	;@0C8D3
	add	byte ptr [bx+si], al	;@0C8D5
	add	byte ptr [bx+si], al	;@0C8D7
	add	byte ptr [bx+si], al	;@0C8D9
	add	byte ptr [bx+si], al	;@0C8DB
	add	byte ptr [bx+si], al	;@0C8DD
	db	0, 0CDh	; add ch, cl	;@0C8DF
	aas	;@0C8E1
	add	byte ptr [bx+si], al	;@0C8E2
	nop	;@0C8E4
	pop	di	;@0C8E5
	add	al, byte ptr [bx+si]	;@0C8E6
	dec	cx	;@0C8E8
	push	es	;@0C8E9
	xor	al, byte ptr [bx+si]	;@0C8EA
	add	word ptr [bx+si], ax	;@0C8EC
	add	byte ptr [bx+si], al	;@0C8EE
Y0C8B0	ends

Y0C8F0	segment para public 'CODE'
	assume	cs:Y0C8F0
	db	0, 0, 0	;@0C8F0
L0C8F3:	add	byte ptr [bx+si], al	;@0C8F3
	add	byte ptr [bx+si], al	;@0C8F5
	add	byte ptr [bx+si], al	;@0C8F7
	add	byte ptr [bx+si], al	;@0C8F9
	add	byte ptr [bx+si], al	;@0C8FB
	add	byte ptr [bx+si], al	;@0C8FD
	db	0, 0CDh	; add ch, cl	;@0C8FF
	aas	;@0C901
	xor	al, 6	;@0C902
	add	byte ptr [bx+si], al	;@0C904
	add	byte ptr [bx+si], al	;@0C906
	add	byte ptr [bx+si], al	;@0C908
	add	byte ptr [bx+si], al	;@0C90A
	add	byte ptr [bx+si], al	;@0C90C
	add	byte ptr [bx+si], al	;@0C90E
	int	3Fh	;@0C910
	add	byte ptr [bx+si], al	;@0C912
	adc	byte ptr [bp+2], ah	;@0C914
	db	0, 0D4h	; add ah, dl	;@0C917
	sbb	byte ptr cs:[bx+di], al	;@0C919
	adc	al, byte ptr [bx+si]	;@0C91C
	add	byte ptr [bx+si], al	;@0C91E
	add	byte ptr [bx+si], al	;@0C920
	add	byte ptr [bx+si], al	;@0C922
	add	byte ptr [bx+si], al	;@0C924
	add	byte ptr [bx+si], al	;@0C926
	add	byte ptr [bx+si], al	;@0C928
	add	byte ptr [bx+si], al	;@0C92A
	add	byte ptr [bx+si], al	;@0C92C
	add	byte ptr [bx+si], al	;@0C92E
Y0C8F0	ends

Y0C930	segment para public 'CODE'
	assume	cs:Y0C930
FOLD_ADD_UNSIGNED:	int	3Fh	;@0C930
	adc	ax, word ptr [bx+si]	;@0C932
	db	0, 0CDh	; add ch, cl	;@0C934
	aas	;@0C936
	sbb	ax, 1	;@0C937
FOLD_ADD_SIGNED:	int	3Fh	;@0C93A
	add	byte ptr [bx+si], al	;@0C93C
	db	0, 0CDh	; add ch, cl	;@0C93E
	aas	;@0C940
	or	al, byte ptr [bx+di]	;@0C941
	db	0, 0CDh	; add ch, cl	;@0C943
	aas	;@0C945
	xor	byte ptr [bx+di], al	;@0C946
	db	0, 0CDh	; add ch, cl	;@0C948
	aas	;@0C94A
	movsb	;@0C94B
	add	byte ptr [bx+si], al	;@0C94C
FOLD_SUB_UNSIGNED:	int	3Fh	;@0C94E
Y0C930	ends

Y0C950	segment para public 'CODE'
	assume	cs:Y0C950
	db	39h, 0, 0	;@0C950
FOLD_MUL_UNSIGNED:	int	3Fh	;@0C953
	db	64h, 0, 0	; add byte ptr [bx+si], al	;@0C955
FOLD_MOD_UNSIGNED:	db	0CDh, 3Fh	; int 3Fh	;@0C958
	in	al, 0	;@0C95A
	db	0, 0CDh	; add ch, cl	;@0C95C
	aas	;@0C95E
	js	@@1+1	;@0C95F
@@1:	db	0, 0CDh	; add ch, cl	;@0C961
	aas	;@0C963
	pop	ss	;@0C964
	add	al, byte ptr [bx+si]	;@0C965
FOLD_SHIFT_SIGNED:	int	3Fh	;@0C967
	inc	bx	;@0C969
	add	word ptr [bx+si], ax	;@0C96A
FOLD_DIV_SIGNED:	int	3Fh	;@0C96C
	db	7Ch, 0	; jl L0C970	;@0C96E
Y0C950	ends

Y0C970	segment para public 'CODE'
	assume	cs:Y0C970
L0C970:	db	0, 0CDh	; add ch, cl	;@0C970
	aas	;@0C972
	movsb	;@0C973
	db	2Eh, 0, 0CDh	; add ch, cl	;@0C974
	db	3Fh	; aas	;@0C977
	add	byte ptr es:[bx+si], al	;@0C978
FOLD_MUL_SIGNED:	int	3Fh	;@0C97B
	dec	sp	;@0C97D
	add	byte ptr [bx+si], al	;@0C97E
FOLD_MOD_SIGNED:	int	3Fh	;@0C980
	int	3	;@0C982
	add	byte ptr [bx+si], al	;@0C983
CONSTANT_TRUTH_VALUE:	int	3Fh	;@0C985
	jbe	@@1	;@0C987
	add	byte ptr [bx+si], al	;@0C989
@@1:	add	byte ptr [bx+si], al	;@0C98B
	add	byte ptr [bx+si], al	;@0C98D
	db	0, 0CDh	; add ch, cl	;@0C98F
	aas	;@0C991
	add	byte ptr [bx+si], al	;@0C992
	db	0, 96h, 2, 0	; add byte ptr [bp+2], dl	;@0C994
	db	0B1h, 4	; mov cl, 4	;@0C998
	sbb	al, byte ptr [bx+si]	;@0C99A
	add	al, 0	;@0C99C
	add	byte ptr [bx+si], al	;@0C99E
Y0C970	ends

Y0C9A0	segment para public 'CODE'
	assume	cs:Y0C9A0
	db	10h dup (0)	;@0C9A0
EXPR_BANK_MARK:	int	3Fh	;@0C9B0
	xchg	ax, si	;@0C9B2
	add	al, 0	;@0C9B3
EXPR_BANK_RESET:	int	3Fh	;@0C9B5
	sahf	;@0C9B7
	add	al, 0	;@0C9B8
UNPACK_EXPR_TREE:	int	3Fh	;@0C9BA
	mov	al, byte ptr [bp+si]	;@0C9BC
	db	0, 0CDh	; add ch, cl	;@0C9BE
	aas	;@0C9C0
	add	byte ptr [bx+si], al	;@0C9C1
	add	byte ptr [bx+si], al	;@0C9C3
	add	byte ptr [bx+si], al	;@0C9C5
	add	byte ptr [bx+si], al	;@0C9C7
	add	byte ptr [bx+si], al	;@0C9C9
	add	byte ptr [bx+si], al	;@0C9CB
	add	byte ptr [bx+si], al	;@0C9CD
	db	0, 0CDh	; add ch, cl	;@0C9CF
	aas	;@0C9D1
	add	byte ptr [bx+si], al	;@0C9D2
	db	0D0h, 9Ah, 2, 0	; rcr byte ptr [bp+si+2], 1	;@0C9D4
	db	17h	; pop ss	;@0C9D8
	adc	word ptr [bp], ax	;@0C9D9
	daa	;@0C9DC
	add	byte ptr [bx+si], al	;@0C9DD
	db	0	; add byte ptr [bx+si], al	;@0C9DF
Y0C9A0	ends

Y0C9E0	segment para public 'CODE'
	assume	cs:Y0C9E0
	db	10h dup (0)	;@0C9E0
ALLOC_JUMP_RECORD:	int	3Fh	;@0C9F0
	dec	di	;@0C9F2
	or	ax, 0CD00h	;@0C9F3
	aas	;@0C9F6
	adc	word ptr [di], cx	;@0C9F7
	db	0, 0CDh	; add ch, cl	;@0C9F9
	aas	;@0C9FB
	lea	dx, [bx+si]	;@0C9FC
	db	0, 0CDh	; add ch, cl	;@0C9FE
	aas	;@0CA00
	pop	bx	;@0CA01
	add	ax, word ptr [bx+si]	;@0CA02
SET_PREPARED_SYMBOL_FLAGS:	int	3Fh	;@0CA04
	sbb	byte ptr [bx+si], dl	;@0CA06
	db	0, 0CDh	; add ch, cl	;@0CA08
	aas	;@0CA0A
	dec	cx	;@0CA0B
	or	byte ptr [bx+si], al	;@0CA0C
C9_ALLOC_MEMBER:	int	3Fh	;@0CA0E
Y0C9E0	ends
	end
