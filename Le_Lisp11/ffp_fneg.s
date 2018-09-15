	entry fneg
	extern ffpneg
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
fneg    enter   0,d7
	move.l  8(a6),d7
	jsr     ffpneg
	move.l  d7,d0
	return  d7
	end
