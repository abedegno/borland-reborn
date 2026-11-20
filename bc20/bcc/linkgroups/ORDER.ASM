DOSSEG
; Zero-byte root segment ordering metadata
CODE0	segment byte public 'CODE'
CODE0	ends
CODE_1	segment byte public 'CODE'
CODE_1	ends
CODE_1	segment byte public 'CODE'
CODE_1	ends
CODE_2	segment byte public 'CODE'
CODE_2	ends
CODE_2	segment byte public 'CODE'
CODE_2	ends
CODE_3	segment byte public 'CODE'
CODE_3	ends
CODE_4	segment byte public 'CODE'
CODE_4	ends
CODE_5	segment byte public 'CODE'
CODE_5	ends
CODE6	segment byte public 'CODE'
CODE6	ends
CODE7	segment byte public 'CODE'
CODE7	ends
CODE8	segment byte public 'CODE'
CODE8	ends
CODE9	segment byte public 'CODE'
CODE9	ends
CODE10	segment byte public 'CODE'
CODE10	ends
CODE11	segment byte public 'CODE'
CODE11	ends
CODE12	segment byte public 'CODE'
CODE12	ends
CODE_13	segment byte public 'CODE'
CODE_13	ends
CODE_14	segment byte public 'CODE'
CODE_14	ends
CODE_15	segment byte public 'CODE'
CODE_15	ends
CODE_16	segment byte public 'CODE'
CODE_16	ends
CODE_17	segment byte public 'CODE'
CODE_17	ends
CODE_18	segment byte public 'CODE'
CODE_18	ends
CODE_19	segment byte public 'CODE'
CODE_19	ends
CODE_20	segment byte public 'CODE'
CODE_20	ends
CODE_21	segment byte public 'CODE'
CODE_21	ends
RCLOSE_TEXT	segment byte public 'CODE'
RCLOSE_TEXT	ends
RCREAT_TEXT	segment byte public 'CODE'
RCREAT_TEXT	ends
CODE_24	segment byte public 'CODE'
CODE_24	ends
CODE_24B	segment byte public 'CODE'
CODE_24B	ends
CODE_25	segment byte public 'CODE'
CODE_25	ends
CODE_26	segment byte public 'CODE'
CODE_26	ends
CODE_27	segment byte public 'CODE'
CODE_27	ends
CODE_28	segment byte public 'CODE'
CODE_28	ends
RLSEEK_TEXT	segment byte public 'CODE'
RLSEEK_TEXT	ends
ROPEN_TEXT	segment byte public 'CODE'
ROPEN_TEXT	ends
RREAD_TEXT	segment byte public 'CODE'
RREAD_TEXT	ends
CODE_32	segment byte public 'CODE'
CODE_32	ends
RSCMP_TEXT	segment byte public 'CODE'
RSCMP_TEXT	ends
CODE_34	segment byte public 'CODE'
CODE_34	ends
RSLEN_TEXT	segment byte public 'CODE'
RSLEN_TEXT	ends
RTOUPPER_TEXT	segment byte public 'CODE'
RTOUPPER_TEXT	ends
RACCESS_TEXT	segment byte public 'CODE'
RACCESS_TEXT	ends
RWRITE_TEXT	segment byte public 'CODE'
RWRITE_TEXT	ends
CODE_39	segment byte public 'CODE'
CODE_39	ends
CODE_40	segment byte public 'CODE'
CODE_40	ends
RMSET_TEXT	segment byte public 'CODE'
RMSET_TEXT	ends
CODE_42	segment byte public 'CODE'
CODE_42	ends
RSCPY_TEXT	segment byte public 'CODE'
RSCPY_TEXT	ends
RMMOVE_TEXT	segment byte public 'CODE'
RMMOVE_TEXT	ends
RSCAT_TEXT	segment byte public 'CODE'
RSCAT_TEXT	ends
_OVERLAY_	segment byte public 'OVRINFO'
_OVERLAY_	ends
CODE_47	segment byte public 'BSS'
CODE_47	ends
CODE_48	segment byte public 'BSS'
CODE_48	ends
CODE_49	segment byte public 'BSS'
CODE_49	ends
CODE_50	segment word public 'BSS'
CODE_50	ends
CODE_50A	segment byte public 'BSS'
CODE_50A	ends
CODE_50B	segment byte public 'BSS'
CODE_50B	ends
CODE_52	segment byte public 'OVRDATA'
CODE_52	ends
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment byte public 'DATA'
_BSS	ends
CODE_182	segment byte public 'DATA'
CODE_182	ends
CODE_183	segment byte stack 'STACK'
CODE_183	ends
CODE_184	segment byte public 'STACK'
CODE_184	ends
DGROUP	group	_DATA,_BSS,CODE_182,CODE_183,CODE_184
		end
