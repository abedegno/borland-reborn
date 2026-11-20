DGROUP	group	_DATA
	extrn	ABSVAL:word
CODE	segment byte public 'CODE'
	assume	cs:CODE,ds:DGROUP
start:
	mov	ax,offset DGROUP:ABSVAL
	mov	bx,word ptr DGROUP:ABSVAL
	mov	ax,4C00h
	int	21h
CODE	ends
_DATA	segment word public 'DATA'
_DATA	ends
	end	start
