	entry   _log,_ln
	extern  ffplog
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
_ln     equ     *
_log    enter   0,d7
	move.l  8(a6),d7
	jsr     ffplog
	bvc     log1
	move.l  #-1,d7
	move.w  #EDOM,_errno
log1    move.l  d7,d0
	return  d7
	end
