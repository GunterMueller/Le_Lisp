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
	.globl	mstack
	.globl	errfs
	.globl	popj
	.globl	false
	.globl	true
	.globl	probj
	.globl	probjt
	.globl	gc
	.globl	errnaa
	.globl	errnna
	.globl	errnla
	.globl	errudv
	.globl	errudf
	.globl	errudt
	.globl	errwna
	.globl	errwla
	.globl	nreverse
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	ini_eval
	.globl	u_eval
	.globl	evalcar
	.globl	evala1
	.globl	evfexp
	.globl	itsoft
	.globl	progna3
	.globl	findtag
	.globl	.quote
	.globl	.lambda
	.globl	.internal
	.globl	.list
	.globl	evalch
	.globl	evalst
	.globl	forme
	.globl	funct
	.globl	pbind
	.globl	savep
	.globl	savech
	.data
evalch:
	.long	0
evalst:
	.long	0
forme:
	.long	0
funct:
	.long	0
pbind:
	.long	0
savep:
	.long	0
savech:
	.long	0
savea3:
	.long	0
	.text
ini_eval:
	movl	csymb,r0
	movl	r0,.eval
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eval,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eval
	.byte	0
	.word	4
	.ascii	"eval"
	movl	csymb,r0
	movl	r0,.traceval
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	traceval,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._traceval
	.byte	0
	.word	8
	.ascii	"traceval"
	movl	csymb,r0
	movl	r0,.stepeval
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	stepeval,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._stepeval
	.byte	0
	.word	8
	.ascii	"stepeval"
	movl	csymb,r0
	movl	r0,.apply
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	apply,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._apply
	.byte	0
	.word	5
	.ascii	"apply"
	movl	csymb,r0
	movl	r0,.applyn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	applyn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._applyn
	.byte	0
	.word	7
	.ascii	"funcall"
	movl	csymb,r0
	movl	r0,.quote
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	quote,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._quote
	.byte	0
	.word	5
	.ascii	"quote"
	movl	csymb,r0
	movl	r0,.function
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	function,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._function
	.byte	0
	.word	8
	.ascii	"function"
	movl	csymb,r0
	movl	r0,.lambda
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lambda,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lambda
	.byte	0
	.word	6
	.ascii	"lambda"
	movl	csymb,r0
	movl	r0,.internal
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	internal,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._internal
	.byte	0
	.word	8
	.ascii	"internal"
	movl	csymb,r0
	movl	r0,.nlambda
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nlambda,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nlambda
	.byte	0
	.word	12
	.ascii	"lambda-named"
	movl	csymb,r0
	movl	r0,.internal
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	internal,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._internal
	.byte	0
	.word	8
	.ascii	"internal"
	movl	csymb,r0
	movl	r0,.id
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	id,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._id
	.byte	0
	.word	8
	.ascii	"identity"
	movl	csymb,r0
	movl	r0,.comment
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	comment,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._comment
	.byte	0
	.word	7
	.ascii	"comment"
	movl	csymb,r0
	movl	r0,.declare
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	declare,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._declare
	.byte	0
	.word	7
	.ascii	"declare"
	movl	csymb,r0
	movl	r0,.progn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	progn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._progn
	.byte	0
	.word	5
	.ascii	"progn"
	movl	csymb,r0
	movl	r0,.eprogn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eprogn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eprogn
	.byte	0
	.word	6
	.ascii	"eprogn"
	movl	csymb,r0
	movl	r0,.prog1
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prog1,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prog1
	.byte	0
	.word	5
	.ascii	"prog1"
	movl	csymb,r0
	movl	r0,.prog2
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prog2,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prog2
	.byte	0
	.word	5
	.ascii	"prog2"
	movl	csymb,r0
	movl	r0,.list
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	list,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._list
	.byte	0
	.word	4
	.ascii	"list"
	movl	csymb,r0
	movl	r0,.evlis
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	evlis,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._evlis
	.byte	0
	.word	5
	.ascii	"evlis"
	movl	csymb,r0
	movl	r0,.tag
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tag,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tag
	.byte	0
	.word	3
	.ascii	"tag"
	movl	csymb,r0
	movl	r0,.evtag
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	evtag,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._evtag
	.byte	0
	.word	5
	.ascii	"evtag"
	movl	csymb,r0
	movl	r0,.exit
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	exit,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._exit
	.byte	0
	.word	4
	.ascii	"exit"
	movl	csymb,r0
	movl	r0,.evexit
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	evexit,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._evexit
	.byte	0
	.word	6
	.ascii	"evexit"
	movl	csymb,r0
	movl	r0,.barrier
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	barrier,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._barrier
	.byte	0
	.word	13
	.ascii	"catch-all-but"
	movl	csymb,r0
	movl	r0,.protect
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	protect,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._protect
	.byte	0
	.word	14
	.ascii	"unwind-protect"
	movl	csymb,r0
	movl	r0,.let
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	let,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._let
	.byte	0
	.word	3
	.ascii	"let"
	movl	csymb,r0
	movl	r0,.letseq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	letseq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._letseq
	.byte	0
	.word	6
	.ascii	"letseq"
	movl	csymb,r0
	movl	r0,.letv
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	letv,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._letv
	.byte	0
	.word	4
	.ascii	"letv"
	movl	csymb,r0
	movl	r0,.flet
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	flet,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._flet
	.byte	0
	.word	4
	.ascii	"flet"
	.data
.rarrow:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.rarrow
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	3
	.byte	0x2d
	.byte	0x3e
	.byte	0x20
	.data
.larrow:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.larrow
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	3
	.byte	0x3c
	.byte	0x2d
	.byte	0x20
	.data
.bind0:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.bind0
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"$CBIND0"
	moval	cbind0,r1
	movl	.bind0,r2
	movl	r1,cval(r2)
	.data
.bind1:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.bind1
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"$CBIND1"
	moval	cbind1,r1
	movl	.bind1,r2
	movl	r1,cval(r2)
	.data
.bind2:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.bind2
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"$CBIND2"
	moval	cbind2,r1
	movl	.bind2,r2
	movl	r1,cval(r2)
	.data
.bindn:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.bindn
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"$CBINDN"
	moval	cbindn,r1
	movl	.bindn,r2
	movl	r1,cval(r2)
	.data
.binde:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.binde
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"$CBINDE"
	moval	cbinde,r1
	movl	.binde,r2
	movl	r1,cval(r2)
	.data
.apbind:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.apbind
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	6
	.ascii	"$PBIND"
	moval	pbind,r1
	movl	.apbind,r2
	movl	r1,cval(r2)
	.data
.aexit:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.aexit
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"$EXIT"
	moval	cexit,r1
	movl	.aexit,r2
	movl	r1,cval(r2)
	.data
.atag:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.atag
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	4
	.ascii	"$TAG"
	moval	ctag,r1
	movl	.atag,r2
	movl	r1,cval(r2)
	movl	.quote,r1
	movl	r1,cval(r1)
	movl	.lambda,r1
	movl	r1,cval(r1)
	movl	r7,evalst
	rsb
	.text
u_eval:
	jsb	evala1
	rsb
	.data
.eval:
	.long	0
	.set	._eval,subr1
	.text
	.globl	eval
eval:
	jmp	evala1
	.data
.traceval:
	.long	0
	.set	._traceval,subr1
	.text
	.globl	traceval
traceval:
	pushl	evalst
	pushl	evalch
	movl	.t,evalst
	pushl	pbind
	pushl	$3
	movl	r14,pbind
	pushal	unbind
	jmp	evalan
evalcar:
	movl	car(r1),r1
evala1:
	cmpl	r7,evalst
	jneq	evalt
evalan:
	cmpl	r8,r1
	jgtr	evalret
	cmpl	r9,r1
	jleq	evalis
evalat:
	movl	r1,r2
	movl	cval(r1),r1
	cmpl	.undef,r1
	jeql	evalera8
evalret:
	rsb
evalera8:
	movl	r2,r1
	movl	.eval,r2
	jmp	errudv
evalt:
	movl	r7,evalst
	movl	r1,r2
	cmpl	r5,r7
	jneq	.1
	jsb	gc
.1:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	movl	.stepeval,r1
	jsb	itsoft
	movl	.t,evalst
	rsb
	.data
.stepeval:
	.long	0
	.set	._stepeval,subr1
	.text
	.globl	stepeval
stepeval:
	pushl	r1
	movl	.rarrow,r1
	jsb	probj
	movl	(r14),r1
	jsb	probjt
	movl	(r14)+,r1
	movl	r2,evalch
	jsb	traceval
	pushl	r1
	movl	.larrow,r1
	jsb	probj
	movl	(r14),r1
	jsb	probjt
	movl	(r14)+,r1
	rsb
evalis:
	cmpl	r14,mstack
	jleq	errfs
	movl	r1,forme
	movl	car(r1),r2
	movl	cdr(r1),r1
evalfu:
	cmpl	r6,r2
	jgtr	udfer
	cmpl	r9,r2
	jleq	evalfli
evalfat:
	movl	r2,funct
	pushl	fval(r2)
	movzbl	ftype(r2),r3
evalin:
	movl	teval[r3],r0
	jmp	(r0)
teval:
	.long	udfe
	.long	eval0
	.long	eval1
	.long	eval2
	.long	eval3
	.long	evaln
	.long	evalf
	.long	evexp
	.long	evfexp
	.long	evmac
	.long	evalv1
	.long	evalv2
	.long	evalv3
	.long	evalvn
evalfli:
	movl	car(r2),r3
	cmpl	.lambda,r3
	jeql	evall
	cmpl	.internal,r3
	jeql	evali
	pushl	r1
	movl	r2,r1
	jsb	evala1
	movl	r1,r2
	movl	(r14)+,r1
	cmpl	r5,r7
	jneq	.2
	jsb	gc
.2:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	jmp	evalis
evall:
	pushl	cdr(r2)
	jmp	evexp
evali:
	movl	cdr(r2),r2
	movl	car(r2),r3
	movl	cdr(r2),r2
	pushl	car(r2)
	jmp	evalin
udfe:
	movl	(r14)+,r3
	movl	cval(r2),r3
	cmpl	r8,r3
	jgtr	udfer
	movl	cval(r3),r4
	cmpl	r4,r3
	jeql	udfer
	movl	r3,r2
	jmp	evalfu
udfer:
	movl	r2,r1
	movl	.eval,r2
	jmp	errudf
wnaer:
	movl	funct,r2
	jmp	errwna
wlaer:
	movl	forme,r1
	movl	.eval,r2
	jmp	errwla
eval0:
	cmpl	r7,r1
	jneq	wnaer
	rsb
eval1:
	cmpl	r9,r1
	jgtr	eval1e1
	cmpl	r7,cdr(r1)
	jeql	evalcar
	movl	cdr(r1),r1
eval1e1:
	jmp	wnaer
evalv1:
	jmp	evalcar
eval2:
	cmpl	r9,r1
	jgtr	eval2e2
	movl	car(r1),r2
	movl	cdr(r1),r1
	cmpl	r9,r1
	jgtr	eval2e2
	pushl	car(r1)
	movl	cdr(r1),r1
	cmpl	r7,r1
	jneq	eval2e1
	movl	r2,r1
	jsb	evala1
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	evala1
	movl	r1,r2
	movl	(r14)+,r1
	rsb
eval2e1:
	movl	(r14)+,r3
eval2e2:
	jmp	wnaer
evalv2:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	evalcar
	movl	r1,r2
	movl	(r14)+,r1
	rsb
eval3:
	cmpl	r9,r1
	jgtr	eval3e4
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	cmpl	r9,r1
	jgtr	eval3e3
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	cmpl	r9,r1
	jgtr	eval3e2
	cmpl	r7,cdr(r1)
	jneq	eval3e1
	jsb	evalcar
	movl	r1,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	rsb
eval3e1:
	movl	cdr(r1),r1
eval3e2:
	movl	(r14)+,r3
eval3e3:
	movl	(r14)+,r3
eval3e4:
	jmp	wnaer
evalv3:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	evalcar
	movl	r1,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	rsb
	.data
.evlis:
	.long	0
	.set	._evlis,subr1
	.text
	.globl	evlis
evlis:
evaln:
	cmpl	r9,r1
	jgtr	listret
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r3
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	pushl	r1
list1:
	cmpl	r9,r3
	jgtr	list2
	pushl	r1
	pushl	cdr(r3)
	movl	car(r3),r1
	jsb	evala1
	movl	(r14)+,r3
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	(r14)+,r2
	movl	r1,cdr(r2)
	jmp	list1
list2:
	movl	(r14)+,r1
listret:
	rsb
evalvn:
	movl	(r14)+,r3
	movl	$0,r4
	jmp	evalvn2
evalvn1:
	pushl	r4
	pushl	r3
	pushl	cdr(r1)
	jsb	evalcar
	movl	r1,r2
	movl	(r14)+,r1
	movl	(r14)+,r3
	movl	(r14)+,r4
	pushl	r2
	incl	r4
evalvn2:
	cmpl	r9,r1
	jleq	evalvn1
	jmp	(r3)
evalf:
	rsb
evexp:
	movl	(r14),r4
	movl	car(r4),r2
	pushl	$mk_eval
	jmp	evexp2
evexp1:
	cmpl	r9,r1
	jleq	evexp11
	cmpl	r7,r1
	jneq	wlaer
evexp11:
	pushl	cdr(r1)
	pushl	r2
	jsb	evalcar
	movl	(r14)+,r2
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	pushl	car(r2)
	movl	cdr(r2),r2
evexp2:
	cmpl	r9,r2
	jleq	evexp1
	cmpl	r7,r2
	jeql	evexp3
	pushl	r2
	jsb	evlis
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	pushl	r1
evexp3:
	movl	r14,r4
	jmp	evexp5
evexp4:
	movl	cval(r2),r1
	movl	(r4),r0
	movl	r1,(r4)
	movl	r0,r1
	movl	r1,cval(r2)
	movl	(r4)+,r1
evexp5:
	movl	(r4)+,r2
	cmpl	$mk_eval,r2
	jneq	evexp4
	movl	pbind,r1
	movl	(r4),r0
	movl	r1,(r4)
	movl	r0,r1
	movl	(r4)+,r2
	movl	r4,r3
	movl	(r4)+,r2
	cmpl	$unbind,r2
	jneq	evexpn
	movl	(r4)+,r2
	cmpl	$0,r2
	jneq	evexpn
	movl	(r4)+,r2
	cmpl	r1,r2
	jneq	evexpn
	movl	r3,r14
	movl	cdr(r1),r1
	jmp	progn
evexpn:
evexpf:
	pushl	r1
	pushl	$0
	movl	r14,pbind
evexpg:
	movl	cdr(r1),r1
	jsb	progn
unbind:
	movl	$popj,r3
unbinp:
	movl	(r14)+,r4
	movl	tunbd1[r4],r0
	jmp	(r0)
tunbd1:
	.long	unbdl
	.long	unbdw
	.long	unbdf
	.long	unbds
	.long	unbdb
	.long	unbdu
unbdl:
	movl	r3,savea3
	movl	(r14)+,r4
	movl	(r14)+,r4
	jmp	unbdl2
unbdl1:
	movl	(r14)+,r3
	movl	r3,cval(r4)
	movl	(r14)+,r4
unbdl2:
	cmpl	$mk_eval,r4
	jneq	unbdl1
	movl	(r14)+,pbind
	movl	savea3,r3
	jmp	(r3)
unbdw:
	movl	r3,savea3
	movl	(r14)+,pbind
	movl	(r14)+,r4
	movl	(r14)+,r3
	movl	r3,fval(r4)
	movl	(r14)+,r3
	movb	r3,ftype(r4)
	movl	savea3,r3
	jmp	(r3)
unbdf:
unbdb:
	movl	(r14)+,r4
	movl	(r14)+,pbind
	jmp	(r3)
unbds:
	movl	(r14)+,pbind
	movl	(r14)+,evalch
	movl	(r14)+,evalst
	jmp	(r3)
unbdu:
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	pushl	r2
	pushl	r3
	jsb	progn
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	movl	(r14)+,pbind
	jmp	(r3)
evmac:
	movl	forme,r1
	movl	(r14)+,r4
	pushal	evala1
	jmp	evfexb
evfexp:
	movl	(r14)+,r4
evfexb:
	movl	car(r4),r2
	pushl	pbind
	pushl	$mk_eval
	jmp	evfex3
evfex2:
	movl	car(r2),r3
	pushl	cval(r3)
	movl	r1,cval(r3)
	pushl	r3
	movl	r7,r1
	movl	cdr(r2),r2
evfex3:
	cmpl	r9,r2
	jleq	evfex2
	movl	r4,r1
	jmp	evexpf
	.data
.applyn:
	.long	0
	.set	._applyn,subrn
	.text
	.globl	applyn
applyn:
	movl	cdr(r1),r2
	movl	car(r1),r1
	jmp	apply
	nop
	.data
.apply:
	.long	0
	.set	._apply,subr2
	.text
	.globl	apply
apply:
	movl	r1,r4
	cmpl	r7,r1
	jgtr	applys
	cmpl	r9,r1
	jleq	applys
	pushl	fval(r1)
	movzbl	ftype(r1),r3
	movl	r2,r1
applin:
	movl	tapply[r3],r0
	jmp	(r0)
tapply:
	.long	udfa
	.long	popj
	.long	apply1
	.long	apply2
	.long	apply3
	.long	popj
	.long	popj
	.long	appexp
	.long	evfexp
	.long	appmac
	.long	apply1
	.long	apply2
	.long	apply3
	.long	applyvn
udfa:
	movl	(r14)+,r3
udfa1:
	movl	.apply,r2
	jmp	errudf
applys:
	cmpl	r6,r1
	jgtr	udfa1
	movl	car(r1),r3
	cmpl	.lambda,r3
	jeql	applyl
	cmpl	.internal,r3
	jeql	applyi
	pushl	r2
	jsb	evala1
	movl	(r14)+,r2
	jmp	apply
applyl:
	pushl	cdr(r1)
	movl	r2,r1
	jmp	appexp
applyi:
	movl	cdr(r1),r1
	movl	car(r1),r3
	movl	cdr(r1),r1
	pushl	car(r1)
	jmp	applin
apply1:
	movl	car(r1),r1
	rsb
apply2:
	movl	cdr(r1),r2
	movl	car(r1),r1
	movl	car(r2),r2
	rsb
apply3:
	movl	cdr(r1),r2
	movl	car(r1),r1
	movl	cdr(r2),r3
	movl	car(r2),r2
	movl	car(r3),r3
	rsb
applyvn:
	movl	(r14)+,r3
	movl	$0,r4
	jmp	applyvn2
applyvn1:
	pushl	car(r1)
	movl	cdr(r1),r1
	incl	r4
applyvn2:
	cmpl	r9,r1
	jleq	applyvn1
	jmp	(r3)
appexp:
	movl	(r14)+,r2
	pushl	pbind
	pushl	$mk_eval
	movl	car(r2),r3
	jmp	appex2
appex1:
	movl	car(r3),r4
	pushl	cval(r4)
	pushl	r3
	movl	car(r1),r3
	movl	cdr(r1),r1
	movl	r3,cval(r4)
	movl	(r14),r0
	movl	r4,(r14)
	movl	r0,r4
	movl	cdr(r4),r3
appex2:
	cmpl	r9,r3
	jleq	appex1
	cmpl	r7,r3
	jeql	appex3
	pushl	cval(r3)
	pushl	r3
	movl	r1,cval(r3)
appex3:
	movl	r2,r1
	jmp	evexpf
appmac:
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r14)+,r4
	pushal	evala1
	jmp	evfexb
	.text
	.data
.let:
	.long	0
	.set	._let,subrf
	.text
	.globl	let
let:
	pushl	cdr(r1)
	movl	car(r1),r1
	movl	r7,r2
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	pushl	r2
	movl	r7,r3
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r3,car(r5)
	movl	r5,r3
	movl	cdr(r5),r5
	movl	r7,cdr(r3)
	pushl	r3
let2:
	cmpl	r7,r1
	jeql	let8
	movl	car(r1),r4
	pushl	cdr(r1)
	movl	car(r4),r1
	cmpl	r5,r7
	jneq	.8
	jsb	gc
.8:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	r1,cdr(r2)
	movl	r1,r2
	movl	cdr(r4),r4
	movl	car(r4),r1
	cmpl	r5,r7
	jneq	.9
	jsb	gc
.9:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	r1,cdr(r3)
	movl	r1,r3
	movl	(r14)+,r1
	jmp	let2
let8:
	movl	(r14)+,r3
	movl	cdr(r3),r3
	movl	(r14)+,r2
	movl	cdr(r2),r2
	movl	(r14)+,r4
	cmpl	r5,r7
	jneq	.10
	jsb	gc
.10:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r4,cdr(r2)
	cmpl	r5,r7
	jneq	.11
	jsb	gc
.11:
	movl	r5,r0
	movl	.lambda,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	forme,r1
	movl	r2,car(r1)
	movl	r3,cdr(r1)
	jmp	evala1
	.data
.letseq:
	.long	0
	.set	._letseq,subrf
	.text
	.globl	letseq
letseq:
	rsb
	.data
.letv:
	.long	0
	.set	._letv,subrf
	.text
	.globl	letv
letv:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r2
	movl	(r14)+,r3
	cmpl	r5,r7
	jneq	.12
	jsb	gc
.12:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	pushl	r2
	jmp	appexp
	.data
.flet:
	.long	0
	.set	._flet,subrf
	.text
	.globl	flet
flet:
	movl	car(r1),r3
	movl	cdr(r1),r1
	movl	car(r3),r2
	movl	cdr(r3),r3
	movl	$expr,r4
fbind:
	pushl	r3
	movzbl	ftype(r2),r3
	movl	(r14),r0
	movl	r3,(r14)
	movl	r0,r3
	pushl	fval(r2)
	pushl	r2
	movb	r4,ftype(r2)
	movl	r3,fval(r2)
	pushl	pbind
	pushl	$1
	movl	r14,pbind
	pushal	unbind
	jmp	progn
	.data
.tag:
	.long	0
	.set	._tag,subrf
	.text
	.globl	tag
tag:
	pushl	pbind
	pushl	car(r1)
tag3:
	pushl	$2
	movl	r14,pbind
	jmp	evexpg
	.data
.evtag:
	.long	0
	.set	._evtag,subrf
	.text
	.globl	evtag
evtag:
	pushl	r1
	jsb	evalcar
	cmpl	r7,r1
	jgtr	evtagerr
	cmpl	r9,r1
	jleq	evtagerr
	movl	r1,r2
	movl	(r14)+,r1
	pushl	pbind
	pushl	r2
	jmp	tag3
evtagerr:
	movl	(r14)+,r2
	movl	.evtag,r2
	jmp	errnaa
	.data
.evexit:
	.long	0
	.set	._evexit,subrf
	.text
	.globl	evexit
evexit:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jmp	exit1
	.data
.exit:
	.long	0
	.set	._exit,subrf
	.text
	.globl	exit
exit:
	pushl	car(r1)
	movl	cdr(r1),r1
exit1:
	jsb	progn
	movl	(r14)+,r2
findtag:
evesc1:
	movl	pbind,r4
	cmpl	r7,r4
	jeql	eresc
	movl	pbind,r14
	movl	(r14),r3
	cmpl	$2,r3
	jeql	evesc3
	cmpl	$4,r3
	jeql	evesc4
	movl	$evesc1,r3
	jmp	unbinp
evesc3:
	movl	(r14)+,r3
	movl	(r14)+,r3
	movl	(r14)+,pbind
	cmpl	r3,r2
	jneq	evesc1
	rsb
evesc4:
	movl	(r14)+,r3
	movl	(r14)+,r3
	movl	(r14)+,pbind
	cmpl	r3,r2
	jeql	evesc1
eresc:
	movl	r2,r1
	movl	.exit,r2
	jmp	errudt
	.data
.barrier:
	.long	0
	.set	._barrier,subrf
	.text
	.globl	barrier
barrier:
	pushl	pbind
	pushl	car(r1)
	pushl	$4
	movl	r14,pbind
	jmp	evexpg
	.data
.protect:
	.long	0
	.set	._protect,subrf
	.text
	.globl	protect
protect:
	pushl	pbind
	pushl	cdr(r1)
	pushl	$5
	movl	r14,pbind
	pushal	unbind
	jmp	evalcar
itsoft:
	pushl	evalst
	pushl	evalch
	pushl	pbind
	pushl	$3
	movl	r14,pbind
	movl	r7,evalst
	pushal	unbind
	jmp	apply
cbind0:
	movl	(r14)+,r2
	pushl	pbind
	pushl	$mk_eval
	pushl	car(r4)
	pushl	$0
	movl	r14,pbind
	pushal	unbind
	jmp	(r2)
cbind1:
	movl	(r14)+,r2
	pushl	pbind
	pushl	$mk_eval
	movl	car(r4),r3
	movl	cdr(r4),r4
	movl	car(r4),r4
	pushl	cval(r4)
	pushl	r4
	movl	r1,cval(r4)
	pushl	r3
	pushl	$0
	movl	r14,pbind
	pushal	unbind
	jmp	(r2)
cbind2:
	movl	(r14)+,savep
	pushl	pbind
	pushl	$mk_eval
	movl	car(r4),funct
	movl	cdr(r4),r4
	movl	car(r4),r3
	pushl	cval(r3)
	pushl	r3
	movl	r1,cval(r3)
	movl	cdr(r4),r4
	movl	car(r4),r3
	pushl	cval(r3)
	pushl	r3
	movl	r2,cval(r3)
	pushl	funct
	pushl	$0
	movl	r14,pbind
	pushal	unbind
	movl	savep,r4
	jmp	(r4)
cbindn:
	movl	(r14)+,savep
	pushl	pbind
	pushl	$mk_eval
	movl	car(r4),funct
	jmp	cbindn2
cbindn1:
	movl	car(r4),r3
	pushl	cval(r3)
	pushl	r3
	movl	car(r1),cval(r3)
	movl	cdr(r1),r1
cbindn2:
	movl	cdr(r4),r4
	cmpl	r9,r4
	jleq	cbindn1
	pushl	funct
	pushl	$0
	movl	r14,pbind
	pushal	unbind
	movl	savep,r4
	jmp	(r4)
cbinde:
	movl	(r14)+,r4
	movl	r4,funct
	movl	r14,r4
	jmp	cbinde3
cbinde2:
	movl	cval(r2),r1
	movl	(r4),r0
	movl	r1,(r4)
	movl	r0,r1
	movl	r1,cval(r2)
	movl	(r4)+,r1
cbinde3:
	movl	(r4)+,r2
	cmpl	$mk_eval,r2
	jneq	cbinde2
	movl	pbind,r1
	movl	(r4),r0
	movl	r1,(r4)
	movl	r0,r1
	movl	(r4)+,r2
	movl	r4,r3
	movl	(r4)+,r2
	cmpl	$unbind,r2
	jneq	cbinde8
	movl	(r4)+,r2
	cmpl	$0,r2
	jneq	cbinde8
	movl	(r4)+,r2
	cmpl	r1,r2
	jneq	cbinde8
	movl	r3,r14
	movl	cdr(r1),r1
	movl	funct,r4
	jmp	(r4)
cbinde8:
	pushl	r1
	pushl	$0
	movl	r14,pbind
	pushal	unbind
	movl	funct,r4
	jmp	(r4)
ctag:
	movl	(r14)+,r2
	pushl	pbind
	pushl	r1
	pushl	$2
	movl	r14,pbind
	pushal	unbind
	jmp	(r2)
	.set	cexit,findtag
	.data
.quote:
	.long	0
	.set	._quote,subrf
	.text
	.globl	quote
quote:
	movl	car(r1),r1
	rsb
	.data
.function:
	.long	0
	.set	._function,subrf
	.text
	.globl	function
function:
	movl	car(r1),r1
	rsb
	.data
.lambda:
	.long	0
	.set	._lambda,subrf
	.text
	.globl	lambda
lambda:
	cmpl	r5,r7
	jneq	.13
	jsb	gc
.13:
	movl	r5,r0
	movl	.lambda,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.nlambda:
	.long	0
	.set	._nlambda,subrf
	.text
	.globl	nlambda
nlambda:
	cmpl	r5,r7
	jneq	.14
	jsb	gc
.14:
	movl	r5,r0
	movl	.nlambda,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.internal:
	.long	0
	.set	._internal,subrf
	.text
	.globl	internal
internal:
	cmpl	r5,r7
	jneq	.15
	jsb	gc
.15:
	movl	r5,r0
	movl	.internal,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.comment:
	.long	0
	.set	._comment,subrf
	.text
	.globl	comment
comment:
	movl	.comment,r1
	rsb
	.data
.declare:
	.long	0
	.set	._declare,subrf
	.text
	.globl	declare
declare:
	movl	.declare,r1
	rsb
	.data
.id:
	.long	0
	.set	._id,subr1
	.text
	.globl	id
id:
	rsb
progna3:
	movl	r3,r1
	jmp	progn
	.data
.eprogn:
	.long	0
	.set	._eprogn,subr1
	.text
	.globl	eprogn
eprogn:
	jmp	progn
	nop
	.data
.progn:
	.long	0
	.set	._progn,subrf
	.text
	.globl	progn
progn:
	jmp	progn2
progn1:
	pushl	r2
	jsb	evalcar
	movl	(r14)+,r1
progn2:
	movl	cdr(r1),r2
	cmpl	r9,r2
	jleq	progn1
	jmp	evalcar
	.data
.prog1:
	.long	0
	.set	._prog1,subrf
	.text
	.globl	prog1
prog1:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	progn
	movl	(r14)+,r1
	rsb
	.data
.prog2:
	.long	0
	.set	._prog2,subrf
	.text
	.globl	prog2
prog2:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r1
	jmp	prog1
	.data
.list:
	.long	0
	.set	._list,subrvn
	.text
	.globl	list
list:
	movl	r7,r1
	jmp	lists2
lists1:
	movl	(r14)+,r2
	cmpl	r5,r7
	jneq	.16
	jsb	gc
.16:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
lists2:
	sobgeq	r4,lists1
	rsb
