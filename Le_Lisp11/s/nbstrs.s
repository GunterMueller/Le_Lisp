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
	.globl	buildat
	.globl	csymb
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	.quote
	.globl	mstack
	.globl	errfs
	.globl	gc
	.globl	getpnam
	.globl	crastrg
	.globl	reenter
	.globl	theend
	.globl	errnaa
	.globl	errnna
	.globl	errnsa
	.globl	errnla
	.globl	errwna
	.globl	errstl
	.globl	errovf
	.globl	evalcar
	.globl	evala1
	.globl	progna3
	.globl	savep
	.globl	progn
	.globl	apply
	.globl	nreverse
	.globl	ini_nbs
	.globl	.string
	.globl	.ffsymbol
	.set	minint,0xFFFF8001
	.set	maxint,0x00007FFF
	.data
	.set	maxstrg,256
	.globl	bufstr1
	.globl	bufstr2
bufstr1:
	.space	maxstrg
bufstr2:
	.space	maxstrg
	.text
ini_nbs:
	movl	csymb,r0
	movl	r0,.add1
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	add1,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._add1
	.byte	0
	.word	2
	.ascii	"1+"
	movl	csymb,r0
	movl	r0,.sub1
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	sub1,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._sub1
	.byte	0
	.word	2
	.ascii	"1-"
	movl	csymb,r0
	movl	r0,.abs
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	abs,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._abs
	.byte	0
	.word	3
	.ascii	"abs"
	movl	csymb,r0
	movl	r0,.plus
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	plus,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._plus
	.byte	0
	.word	1
	.ascii	"+"
	movl	csymb,r0
	movl	r0,.differ
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	differ,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._differ
	.byte	0
	.word	1
	.ascii	"-"
	movl	csymb,r0
	movl	r0,.times
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	times,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._times
	.byte	0
	.word	1
	.ascii	"*"
	movl	csymb,r0
	movl	r0,.quo
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	quo,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._quo
	.byte	0
	.word	1
	.byte	0x2f
	movl	csymb,r0
	movl	r0,.rem
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rem,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rem
	.byte	0
	.word	1
	.byte	0x5c
	movl	csymb,r0
	movl	r0,.scale
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	scale,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._scale
	.byte	0
	.word	5
	.ascii	"scale"
	movl	csymb,r0
	movl	r0,.lognot
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lognot,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lognot
	.byte	0
	.word	6
	.ascii	"lognot"
	movl	csymb,r0
	movl	r0,.logand
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	logand,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._logand
	.byte	0
	.word	6
	.ascii	"logand"
	movl	csymb,r0
	movl	r0,.logor
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	logor,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._logor
	.byte	0
	.word	5
	.ascii	"logor"
	movl	csymb,r0
	movl	r0,.logxor
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	logxor,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._logxor
	.byte	0
	.word	6
	.ascii	"logxor"
	movl	csymb,r0
	movl	r0,.logshift
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	logshift,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._logshift
	.byte	0
	.word	8
	.ascii	"logshift"
	movl	csymb,r0
	movl	r0,.dpn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	dpn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._dpn
	.byte	0
	.word	3
	.ascii	"2**"
	movl	csymb,r0
	movl	r0,.mskfield
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	mskfield,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._mskfield
	.byte	0
	.word	10
	.ascii	"MASK-FIELD"
	movl	csymb,r0
	movl	r0,.ldbyte
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ldbyte,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ldbyte
	.byte	0
	.word	9
	.ascii	"LOAD-BYTE"
	movl	csymb,r0
	movl	r0,.dpbyte
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	dpbyte,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._dpbyte
	.byte	0
	.word	12
	.ascii	"DEPOSIT-BYTE"
	movl	csymb,r0
	movl	r0,.dpfield
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	dpfield,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._dpfield
	.byte	0
	.word	13
	.ascii	"DEPOSIT-FIELD"
	movl	csymb,r0
	movl	r0,.ldbt
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ldbt,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ldbt
	.byte	0
	.word	14
	.ascii	"LOAD-BYTE-TEST"
	movl	csymb,r0
	movl	r0,.zerop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	zerop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._zerop
	.byte	0
	.word	2
	.ascii	"=0"
	movl	csymb,r0
	movl	r0,.nerop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nerop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nerop
	.byte	0
	.word	3
	.byte	0x3c
	.byte	0x3e
	.byte	0x30
	movl	csymb,r0
	movl	r0,.minusp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	minusp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._minusp
	.byte	0
	.word	6
	.ascii	"minusp"
	movl	csymb,r0
	movl	r0,.oddp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	oddp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._oddp
	.byte	0
	.word	4
	.ascii	"oddp"
	movl	csymb,r0
	movl	r0,.evenp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	evenp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._evenp
	.byte	0
	.word	5
	.ascii	"evenp"
	movl	csymb,r0
	movl	r0,.eqn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eqn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eqn
	.byte	0
	.word	1
	.ascii	"="
	movl	csymb,r0
	movl	r0,.neqn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	neqn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._neqn
	.byte	0
	.word	2
	.byte	0x3c
	.byte	0x3e
	movl	csymb,r0
	movl	r0,.ge
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ge,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ge
	.byte	0
	.word	2
	.byte	0x3e
	.byte	0x3d
	movl	csymb,r0
	movl	r0,.gt
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	gt,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._gt
	.byte	0
	.word	1
	.byte	0x3e
	movl	csymb,r0
	movl	r0,.le
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	le,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._le
	.byte	0
	.word	2
	.byte	0x3c
	.byte	0x3d
	movl	csymb,r0
	movl	r0,.lt
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lt,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lt
	.byte	0
	.word	1
	.byte	0x3c
	movl	csymb,r0
	movl	r0,.min
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	min,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._min
	.byte	0
	.word	3
	.ascii	"min"
	movl	csymb,r0
	movl	r0,.max
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	max,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._max
	.byte	0
	.word	3
	.ascii	"max"
	movl	csymb,r0
	movl	r0,.packline
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	packline,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._packline
	.byte	0
	.word	8
	.ascii	"packline"
	movl	csymb,r0
	movl	r0,.unpackline
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	unpackline,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._unpackline
	.byte	0
	.word	10
	.ascii	"unpackline"
	movl	csymb,r0
	movl	r0,.searchline
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	searchline,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._searchline
	.byte	0
	.word	10
	.ascii	"searchline"
	movl	csymb,r0
	movl	r0,.srchpaklin
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	srchpaklin,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._srchpaklin
	.byte	0
	.word	16
	.ascii	"searchpackedline"
	movl	csymb,r0
	movl	r0,.string
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	string,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._string
	.byte	0
	.word	6
	.ascii	"string"
	movl	csymb,r0
	movl	r0,.caten
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caten,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caten
	.byte	0
	.word	8
	.ascii	"catenate"
	movl	csymb,r0
	movl	r0,.eqstring
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eqstring,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eqstring
	.byte	0
	.word	8
	.ascii	"eqstring"
	movl	csymb,r0
	movl	r0,.ffsymbol
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ffsymbol,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ffsymbol
	.byte	0
	.word	6
	.ascii	"symbol"
false:
	movl	r7,r1
popj:
	rsb
	.data
.add1:
	.long	0
	.set	._add1,subr1
	.text
	.globl	add1
add1:
	cmpl	r6,r1
	jleq	add1err
	incw	r1
	jvs	add1ovf
	rsb
add1err:
	movl	.add1,r2
	jmp	errnna
add1ovf:
	movl	.add1,r2
	jmp	errovf
	.data
.sub1:
	.long	0
	.set	._sub1,subr1
	.text
	.globl	sub1
sub1:
	cmpl	r6,r1
	jleq	sub1err
	decw	r1
	jvs	sub1ovf
	rsb
sub1err:
	movl	.sub1,r2
	jmp	errnna
sub1ovf:
	movl	.sub1,r2
	jmp	errovf
	.data
.abs:
	.long	0
	.set	._abs,subr1
	.text
	.globl	abs
abs:
	cmpl	r6,r1
	jleq	abserr
	cmpl	r1,$0
	jgeq	absret
	mnegw	r1,r1
absret:
	rsb
abserr:
	movl	.abs,r2
	jmp	errnna
	.data
.plus:
	.long	0
	.set	._plus,subrvn
	.text
	.globl	plus
plus:
	movl	$0,r1
	jmp	plus2
plus1:
	movl	(r14)+,r2
	cmpl	r6,r2
	jleq	pluserr
	addw2	r2,r1
	jvs	plusovf
plus2:
	sobgeq	r4,plus1
	rsb
pluserr:
	movl	r2,r1
	movl	.plus,r2
	jmp	errnna
plusovf:
	movl	.plus,r2
	jmp	errovf
	.data
.differ:
	.long	0
	.set	._differ,subrvn
	.text
	.globl	differ
differ:
	movl	$0,r1
	cmpl	$0,r4
	jeql	popj
	cmpl	$1,r4
	jneq	diff1
	movl	(r14)+,r1
	cmpl	r6,r1
	jleq	differr2
	mnegw	r1,r1
	rsb
diff1:
	decl	r4
	jmp	diff3
diff2:
	movl	(r14)+,r2
	cmpl	r6,r2
	jleq	differr1
	addw2	r2,r1
	jvs	diffovf
diff3:
	sobgeq	r4,diff2
	movl	(r14)+,r2
	cmpl	r6,r1
	jleq	differr2
	subw2	r1,r2
	jvs	diffovf
	movl	r2,r1
	rsb
differr1:
	movl	r1,r2
differr2:
	movl	.differ,r2
	jmp	errnna
diffovf:
	movl	.differ,r2
	jmp	errovf
	.data
.times:
	.long	0
	.set	._times,subrvn
	.text
	.globl	times
times:
	movl	$1,r1
	jmp	times2
times1:
	movl	(r14)+,r2
	cmpl	r6,r2
	jleq	timeserr
	mulw2	r2,r1
	jvs	timeovf
times2:
	sobgeq	r4,times1
	rsb
timeserr:
	movl	r2,r1
	movl	.times,r2
	jmp	errnna
timeovf:
	movl	.times,r2
	jmp	errovf
	.data
.quo:
	.long	0
	.set	._quo,subr2
	.text
	.globl	quo
quo:
	cmpl	r6,r1
	jleq	quoerr2
	cmpl	r6,r2
	jleq	quoerr1
	divw2	r1,r2
	jvs	quoovf
	movl	r2,r1
	rsb
quoerr1:
	movl	r2,r1
quoerr2:
	movl	.quo,r2
	jmp	errnna
quoovf:
	movl	.quo,r2
	jmp	errovf
	.data
.rem:
	.long	0
	.set	._rem,subr2
	.text
	.globl	rem
rem:
	cmpl	r6,r1
	jleq	remerr2
	cmpl	r6,r2
	jleq	remerr1
	movl	r2,r1
	rsb
remerr1:
	movl	r2,r1
remerr2:
	movl	.rem,r2
	jmp	errnna
removf:
	movl	.rem,r2
	jmp	errovf
	.data
.scale:
	.long	0
	.set	._scale,subr3
	.text
	.globl	scale
scale:
	cmpl	r6,r1
	jleq	scaerr3
	cmpl	r6,r2
	jleq	scaerr2
	cmpl	r6,r3
	jleq	scaerr1
	rsb
scaerr1:
	movl	r3,r1
	jmp	remerr1
scaerr2:
	movl	r2,r1
scaerr3:
	movl	.scale,r2
	jmp	errnna
	.data
.lognot:
	.long	0
	.set	._lognot,subr1
	.text
	.globl	lognot
lognot:
	cmpl	r6,r1
	jleq	lognoerr
	rsb
lognoerr:
	movl	.lognot,r2
	jmp	errnna
	.data
.logand:
	.long	0
	.set	._logand,subr2
	.text
	.globl	logand
logand:
	cmpl	r6,r1
	jleq	logaerr2
	cmpl	r6,r2
	jleq	logaerr1
	mcomw	r2,r0
	bicw2	r0,r1
	rsb
logaerr1:
	movl	r2,r1
logaerr2:
	movl	.logand,r2
	jmp	errnna
	.data
.logor:
	.long	0
	.set	._logor,subr2
	.text
	.globl	logor
logor:
	cmpl	r6,r1
	jleq	logoerr2
	cmpl	r6,r2
	jleq	logoerr1
	bisw2	r2,r1
	rsb
logoerr1:
	movl	r2,r1
logoerr2:
	movl	.logor,r2
	jmp	errnna
	.data
.logxor:
	.long	0
	.set	._logxor,subr2
	.text
	.globl	logxor
logxor:
	cmpl	r6,r1
	jleq	logxerr2
	cmpl	r6,r2
	jleq	logxerr1
	xorw2	r2,r1
	rsb
logxerr1:
	movl	r2,r1
logxerr2:
	movl	.logxor,r2
	jmp	errnna
	.data
.logshift:
	.long	0
	.set	._logshift,subr2
	.text
	.globl	logshift
logshift:
	cmpl	r6,r1
	jleq	logserr2
	cmpl	r6,r2
	jleq	logserr1
	rsb
logsh2:
	rsb
logserr1:
	movl	r2,r1
logserr2:
	movl	.logshift,r2
	jmp	errnna
	.data
.dpn:
	.long	0
	.set	._dpn,subr1
	.text
	.globl	dpn
dpn:
	cmpl	r6,r1
	jleq	dpnerr
	rsb
dpnerr:
	movl	.dpn,r2
	jmp	errnna
	.data
.mskfield:
	.long	0
	.set	._mskfield,subr3
	.text
	.globl	mskfield
mskfield:
	cmpl	r6,r1
	jleq	mskfier3
	cmpl	r6,r2
	jleq	mskfier2
	cmpl	r6,r3
	jleq	mskfier1
	rsb
mskfier1:
	movl	r3,r1
	jmp	mskfier3
mskfier2:
	movl	r2,r1
mskfier3:
	movl	.mskfield,r2
	jmp	errnna
	.data
.ldbyte:
	.long	0
	.set	._ldbyte,subr3
	.text
	.globl	ldbyte
ldbyte:
	cmpl	r6,r1
	jleq	ldbyter3
	cmpl	r6,r2
	jleq	ldbyter2
	cmpl	r6,r3
	jleq	ldbyter1
	rsb
ldbyter1:
	movl	r3,r1
	jmp	ldbyter3
ldbyter2:
	movl	r2,r1
ldbyter3:
	movl	.ldbyte,r2
	jmp	errnna
	.data
.ldbt:
	.long	0
	.set	._ldbt,subr3
	.text
	.globl	ldbt
ldbt:
	cmpl	r6,r1
	jleq	ldbterr3
	cmpl	r6,r2
	jleq	ldbterr2
	cmpl	r6,r3
	jleq	ldbterr1
	cmpl	$0,r1
	jeql	false
	rsb
ldbterr1:
	movl	r3,r1
	jmp	ldbterr3
ldbterr2:
	movl	r2,r1
ldbterr3:
	movl	.ldbt,r2
	jmp	errnna
	.data
.dpbyte:
	.long	0
	.set	._dpbyte,subr0
	.text
	.globl	dpbyte
dpbyte:
	rsb
	.data
.dpfield:
	.long	0
	.set	._dpfield,subr0
	.text
	.globl	dpfield
dpfield:
	rsb
	.data
.zerop:
	.long	0
	.set	._zerop,subr1
	.text
	.globl	zerop
zerop:
	cmpl	r6,r1
	jleq	zererr
	cmpl	$0,r1
	jneq	false
	rsb
zererr:
	movl	.zerop,r2
	jmp	errnna
	.data
.nerop:
	.long	0
	.set	._nerop,subr1
	.text
	.globl	nerop
nerop:
	cmpl	r6,r1
	jleq	nererr
	cmpl	$0,r1
	jeql	false
	rsb
nererr:
	movl	.nerop,r2
	jmp	errnna
	.data
.minusp:
	.long	0
	.set	._minusp,subr1
	.text
	.globl	minusp
minusp:
	cmpl	r6,r1
	jleq	minperr
	cmpl	r1,$0
	jlss	false
	rsb
minperr:
	movl	.minusp,r2
	jmp	errnna
	.data
.oddp:
	.long	0
	.set	._oddp,subr1
	.text
	.globl	oddp
oddp:
	cmpl	r6,r1
	jleq	oddperr
	rsb
oddperr:
	movl	.oddp,r2
	jmp	errnna
	.data
.evenp:
	.long	0
	.set	._evenp,subr1
	.text
	.globl	evenp
evenp:
	cmpl	r6,r1
	jleq	evenperr
	rsb
evenperr:
	movl	.evenp,r2
	jmp	errnna
	.data
.eqn:
	.long	0
	.set	._eqn,subr2
	.text
	.globl	eqn
eqn:
	cmpl	r6,r1
	jleq	eqnerr2
	cmpl	r6,r2
	jleq	eqnerr1
	rsb
eqnerr1:
	movl	r2,r1
eqnerr2:
	movl	.eqn,r2
	jmp	errnna
	.data
.neqn:
	.long	0
	.set	._neqn,subr2
	.text
	.globl	neqn
neqn:
	cmpl	r6,r1
	jleq	neqnerr2
	cmpl	r6,r2
	jleq	neqnerr1
	rsb
neqnerr1:
	movl	r2,r1
neqnerr2:
	movl	.neqn,r2
	jmp	errnna
	.data
.gt:
	.long	0
	.set	._gt,subr2
	.text
	.globl	gt
gt:
	cmpl	r6,r1
	jleq	gterr2
	cmpl	r6,r2
	jleq	gterr1
	rsb
gterr1:
	movl	r2,r1
gterr2:
	movl	.gt,r2
	jmp	errnna
	.data
.ge:
	.long	0
	.set	._ge,subr2
	.text
	.globl	ge
ge:
	cmpl	r6,r1
	jleq	geerr2
	cmpl	r6,r2
	jleq	geerr1
	rsb
geerr1:
	movl	r2,r1
geerr2:
	movl	.ge,r2
	jmp	errnna
	.data
.lt:
	.long	0
	.set	._lt,subr2
	.text
	.globl	lt
lt:
	cmpl	r6,r1
	jleq	lterr2
	cmpl	r6,r2
	jleq	lterr1
	rsb
lterr1:
	movl	r2,r1
lterr2:
	movl	.lt,r2
	jmp	errnna
	.data
.le:
	.long	0
	.set	._le,subr2
	.text
	.globl	le
le:
	cmpl	r6,r1
	jleq	leerr2
	cmpl	r6,r2
	jleq	leerr1
	rsb
leerr1:
	movl	r2,r1
leerr2:
	movl	.le,r2
	jmp	errnna
	.data
.min:
	.long	0
	.set	._min,subrvn
	.text
	.globl	min
min:
	cmpl	$0,r4
	jeql	minerr1
	jmp	min2
min1:
	movl	(r14)+,r1
	cmpl	r6,r1
	jleq	minerr2
min2:
	sobgeq	r4,min1
	rsb
minerr1:
	movl	r4,r1
	movl	.min,r2
	jmp	errwna
minerr2:
	movl	.min,r2
	jmp	errnna
	.data
.max:
	.long	0
	.set	._max,subrvn
	.text
	.globl	max
max:
	cmpl	$0,r4
	jeql	maxerr1
	jmp	max2
max1:
	movl	(r14)+,r1
	cmpl	r6,r1
	jleq	maxerr2
max2:
	sobgeq	r4,max1
	rsb
maxerr1:
	movl	r4,r1
	movl	.max,r2
	jmp	errwna
maxerr2:
	movl	.max,r2
	jmp	errnna
	.data
.packline:
	.long	0
	.set	._packline,subr1
	.text
	.globl	packline
packline:
	rsb
	.data
.unpackline:
	.long	0
	.set	._unpackline,subr1
	.text
	.globl	unpackline
unpackline:
	rsb
	.data
.searchline:
	.long	0
	.set	._searchline,subr2
	.text
	.globl	searchline
searchline:
	cmpl	r9,r1
	jgtr	search9
search1:
	pushl	r1
	pushl	r2
search2:
	movl	car(r1),r3
	movl	car(r2),r4
	cmpl	r4,r3
	jneq	search3
	movl	cdr(r2),r2
	cmpl	r7,r2
	jeql	search5
	movl	cdr(r1),r1
	cmpl	r9,r1
	jleq	search2
search3:
	movl	(r14)+,r2
	movl	(r14)+,r1
	cmpl	r9,r1
	jgtr	search9
	movl	cdr(r1),r1
	jmp	search1
search5:
	movl	(r14)+,r2
	movl	(r14)+,r1
search9:
	rsb
	.data
.srchpaklin:
	.long	0
	.set	._srchpaklin,subr2
	.text
	.globl	srchpaklin
srchpaklin:
	rsb
	.data
.string:
	.long	0
	.set	._string,subr1
	.text
	.globl	string
string:
	cmpl	r6,r1
	jgtr	.1
	cmpl	r7,r1
	jgtr	string4
.1:
	cmpl	r9,r1
	jleq	string9
	moval	bufstr1,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r1
	movl	r1,r10
	moval	bufstr1,r0
	jsb	crastrg
string4:
	rsb
string9:
	movl	.string,r2
	jmp	errnsa
	.data
.caten:
	.long	0
	.set	._caten,subrvn
	.text
	.globl	caten
caten:
	pushl	r4
	movl	$0,r2
	jmp	caten6
caten2:
	movl	r4,r0
	incl	r0
	movl	(r14)[r0],r1
	pushl	r4
	pushl	r2
	moval	bufstr2,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r1
	movl	(r14)+,r2
	movl	$0,r3
	jmp	caten4
caten3:
	movzbl	*$bufstr2[r3],r4
	cmpl	r2,$maxstrg
	jgeq	catener
	movl	r2,r0
	movb	r4,*$bufstr1[r0]
	incl	r3
	incl	r2
caten4:
	sobgeq	r1,caten3
	movl	(r14)+,r4
caten6:
	sobgeq	r4,caten2
	movl	r2,r10
	moval	bufstr1,r0
	jsb	crastrg
	ashl	$2,(r14)+,r0
	addl2	r0,r14
	rsb
catener:
	movl	r2,r1
	movl	.caten,r2
	jmp	errstl
	.data
.eqstring:
	.long	0
	.set	._eqstring,subr2
	.text
	.globl	eqstring
eqstring:
	cmpl	r6,r1
	jgtr	.2
	cmpl	r7,r1
	jgtr	eqstr1
.2:
	pushl	r2
	jsb	string
	movl	(r14)+,r2
eqstr1:
	cmpl	r6,r2
	jgtr	.3
	cmpl	r7,r2
	jgtr	eqstr2
.3:
	pushl	r1
	movl	r2,r1
	jsb	string
	movl	(r14)+,r2
eqstr2:
	movl	val(r2),r3
	cmpl	val(r1),r3
	jeql	eqstr9
	movl	r7,r1
eqstr9:
	rsb
	.data
.ffsymbol:
	.long	0
	.set	._ffsymbol,subr1
	.text
	.globl	ffsymbol
ffsymbol:
	cmpl	r6,r1
	jgtr	symb1
	cmpl	r7,r1
	jleq	symb1
	movl	val(r1),r1
symb1:
	rsb
