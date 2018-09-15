	entry fadd,fsub
	extern ffpadd,ffpsub
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
fadd    enter   0,d3-d7
	move.l  8(a6),d7
	move.l  12(a6),d6
	jsr     ffpadd
	move.l  d7,d0
	return  d3-d7
fsub    enter   0,d3-d7
	move.l  8(a6),d7
	move.l  12(a6),d6
	jsr     ffpsub
	move.l  d7,d0
	return  d3-d7
	end
