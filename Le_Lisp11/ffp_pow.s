	entry   _pow
	extern  ffppwr
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
_pow    enter   0,d6-d7
	move.l  8(a6),d7
	move.l  12(a6),d6
	jsr     ffppwr
	bvc     pow1
	move.w  #ERANGE,_errno
pow1    move.l  d7,d0
	return  d6-d7
	end
