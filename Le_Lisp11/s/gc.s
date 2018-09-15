	.set	cval,0
	.set	plist,4
	.set	fval,8
	.set	pkgc,12
	.set	alink,16
	.set	ftype,20
	.set	ptype,21
	.set	plen,22
	.set	pname,24
	.set	val,0
	.set	car,0
	.set	cdr,4
	.set	subr0,1
	.set	subr1,2
	.set	subr2,3
	.set	subr3,4
	.set	subrn,5
	.set	subrf,6
	.set	expr,7
	.set	fexpr,8
	.set	macro,9
	.set	subrv1,10
	.set	subrv2,11
	.set	subrv3,12
	.set	subrvn,13
	.set	mk_eval,0xFFFFFFF0
	.set	mk_read,0xFFFFFFF1
	.set	mk_subrn,0xFFFFFFF2
	.set	mk_map,0xFFFFFFF3
	.set	_bmark,29
	.set	_binvis,28
	.set	_mmark,0x20000000
	.set	_minvis,0x10000000
	.set	gcdebug,0
	.set	mincell,400
	.set	masknb,0xFFFF
	.globl	bstack
	.globl	estack
	.globl	bcons
	.globl	econs
	.globl	bstrg
	.globl	estrg
	.globl	fstrg
	.globl	barray
	.globl	earray
	.globl	buildat
	.globl	csymb
	.globl	hashmax
	.globl	hashtab
	.globl	popj
	.globl	false
	.globl	true
	.globl	mstack
	.globl	errfs
	.globl	erfm
	.globl	errnaa
	.globl	errnna
	.globl	errnla
	.globl	itsoft
	.globl	reenter
	.globl	probj
	.globl	probjt
	.globl	.t
	.globl	.undef
	.globl	.void
	.globl	.atom
	.globl	.string
	.globl	.fcons
	.globl	.ffsymbol
	.globl	length
	.globl	gc
	.globl	ini_gc
	.text
ini_gc:
	movl	csymb,r0
	movl	r0,.gcuser
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	gcuser,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._gcuser
	.byte	0
	.word	2
	.ascii	"gc"
	movl	csymb,r0
	movl	r0,.gcalarm
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	gcalarm,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._gcalarm
	.byte	0
	.word	7
	.ascii	"gcalarm"
	movl	csymb,r0
	movl	r0,.gcinfo
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	gcinfo,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._gcinfo
	.byte	0
	.word	6
	.ascii	"gcinfo"
	movl	csymb,r0
	movl	r0,.tcons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tcons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tcons
	.byte	0
	.word	5
	.ascii	"tcons"
	movl	csymb,r0
	movl	r0,.tconsp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tconsp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tconsp
	.byte	0
	.word	6
	.ascii	"tconsp"
	movl	$0,gcn
	movl	r7,r1
	movl	barray,r2
	movl	earray,r3
	jmp	ifrsa2
ifrsa1:
	movl	r1,val(r2)
	addl2	$4,r2
ifrsa2:
	cmpl	r2,r3
	jleq	ifrsa1
	movl	r7,r1
	movl	bstrg,r2
	movl	estrg,r3
	jmp	ifrss2
ifrss1:
	movl	r1,val(r2)
	movl	r2,r1
	addl2	$4,r2
ifrss2:
	cmpl	r2,r3
	jleq	ifrss1
	movl	r1,fstrg
	movl	r7,r1
	movl	bcons,r2
	movl	econs,r3
	jmp	ifrls2
ifrls1:
	movl	r7,car(r2)
	movl	r1,cdr(r2)
	movl	r2,r1
	addl2	$8,r2
ifrls2:
	cmpl	r2,r3
	jleq	ifrls1
	movl	r1,r5
	rsb
errfm:
	jmp	erfm
gc:
	pushl	r1
	pushl	r2
	pushl	r3
	pushl	r4
	incl	gcn
	movl	r14,r4
gcst1:
	movl	(r4)+,r1
	jsb	mark
	cmpl	r4,bstack
	jlss	gcst1
	movl	hashmax,r3
gcat0:
	movl	*$hashtab[r3],r4
	jmp	gcat2
gcat1:
	movl	cval(r4),r1
	jsb	mark
	movl	plist(r4),r1
	jsb	mark
	movl	fval(r4),r1
	jsb	mark
	movl	alink(r4),r4
gcat2:
	cmpl	r7,r4
	jgtr	.1
	cmpl	r9,r4
	jgtr	gcat1
.1:
	sobgeq	r3,gcat0
	movl	r7,r1
	movl	$0,r2
	movl	bstrg,r4
	movl	estrg,r3
gcsws1:
	bbsc	$_bmark,val(r4),gcsws2
	movl	r1,val(r4)
	movl	r4,r1
	incl	r2
gcsws2:
	addl2	$4,r4
	cmpl	r4,r3
	jleq	gcsws1
	movl	r1,fstrg
	movl	r2,frees
	movl	r7,r1
	movl	$0,r2
	movl	econs,r3
	movl	bcons,r4
gcsw1:
	bbsc	$_bmark,(r4),gcsw2
	movl	r1,cdr(r4)
	movl	r7,car(r4)
	movl	r4,r1
	incl	r2
gcsw2:
	addl2	$8,r4
	cmpl	r4,r3
	jlss	gcsw1
	movl	r1,r5
	movl	r2,freel
	cmpl	r2,$mincell
	jlss	erfm
	movl	.gcalarm,r1
	movl	r7,r2
	jsb	itsoft
	movl	(r14)+,r4
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	rsb
mark:
	cmpl	r9,r1
	jleq	markl
	cmpl	r6,r1
	jgtr	marks2
	cmpl	r7,r1
	jleq	marks2
	bisl2	$_mmark,val(r1)
marks2:
	rsb
markl:
	cmpl	r1,econs
	jlss	markl2
	.globl	ovni
ovni:
	.globl	ll_ttyo
	jbr	b.2
m.2:
	.asciz	" ** OVNI ** "
b.2:
	movl	$12,r10
	moval	m.2,r0
	jsb	ll_ttyo
markl0:
	rsb
markl2:
	bbc	$_binvis,cdr(r1),markl3
	bbs	$_bmark,car(r1),markl0
	bicl2	$_minvis,cdr(r1)
	movl	car(r1),r2
	cmpl	r14,estack
	jleq	errfs
	pushl	cdr(r1)
	bisl2	$_mmark,car(r1)
	bisl2	$_minvis,cdr(r1)
	movl	r2,r1
	jsb	mark
	movl	(r14)+,r1
	jmp	mark
markl3:
	bbs	$_bmark,car(r1),markl0
	movl	car(r1),r2
	cmpl	r14,estack
	jleq	errfs
	pushl	cdr(r1)
	bisl2	$_mmark,car(r1)
	movl	r2,r1
	jsb	mark
	movl	(r14)+,r1
	jmp	mark
	.data
.gcuser:
	.long	0
	.set	._gcuser,subr0
	.text
	.globl	gcuser
gcuser:
	jsb	gc
gcuser1:
	movl	freel,r1
	mcomw	$masknb,r0
	bicw2	r0,r1
	rsb
	.data
.gcalarm:
	.long	0
	.set	._gcalarm,subr0
	.text
	.globl	gcalarm
gcalarm:
	movl	r7,r1
	rsb
	.data
.gcinfo:
	.long	0
	.set	._gcinfo,subr0
	.text
	.globl	gcinfo
gcinfo:
	movl	freel,r1
	mcomw	$masknb,r0
	bicw2	r0,r1
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r5,r0
	movl	.fcons,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	frees,r2
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r5,r0
	movl	.string,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	bcons,r2
	subl2	csymb,r2
	divw2	$4,r2
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	cmpl	r5,r7
	jneq	.8
	jsb	gc
.8:
	movl	r5,r0
	movl	.ffsymbol,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	cmpl	r5,r7
	jneq	.9
	jsb	gc
.9:
	movl	r5,r0
	movl	gcn,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	cmpl	r5,r7
	jneq	.10
	jsb	gc
.10:
	movl	r5,r0
	movl	.gcuser,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.tcons:
	.long	0
	.set	._tcons,subr2
	.text
	.globl	tcons
tcons:
	cmpl	r9,r2
	jgtr	tconserr
	cmpl	r5,r7
	jneq	.11
	jsb	gc
.11:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r2,cdr(r1)
	bisl2	$_minvis,cdr(r1)
	rsb
tconserr:
	movl	r2,r1
	movl	.tcons,r2
	jmp	errnla
	.data
.tconsp:
	.long	0
	.set	._tconsp,subr1
	.text
	.globl	tconsp
tconsp:
	cmpl	r9,r1
	jgtr	tconsp1
	bbs	$_binvis,cdr(r1),tconsp2
tconsp1:
	movl	r7,r1
tconsp2:
	rsb
	.data
gcn:
	.long	0
frees:
	.long	0
freel:
	.long	0
