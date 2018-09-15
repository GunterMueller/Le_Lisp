	entry   _sqrt
	extern  ffpsqrt
	extern _errno
*
EDOM    equ     33
ERANGE  equ     34
*
enter   macro
	link a6,#^1
	movem.l ^2,-(a7)
	endm
*
return  macro
	movem.l (a7)+,^1
	unlk a6
	rts
	endm
*
_sqrt   enter   0,d3-d7
	move.l  8(a6),d7
	jsr     ffpsqrt
	bvc     sqrt1
	clr.l   d7
	move.w  #EDOM,_errno
sqrt1   move.l  d7,d0
	return  d3-d7
	end
