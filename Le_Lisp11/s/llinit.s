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
	.data
	.globl	bstack
	.globl	estack
	.globl	mstack
bstack:
	.long	0
estack:
	.long	0
mstack:
	.long	0
	.globl	smemi
	.globl	bmemi
	.globl	ememi
	.globl	scode
	.globl	bcode
	.globl	ecode
	.globl	sarray
	.globl	barray
	.globl	earray
	.globl	sstrg
	.globl	bstrg
	.globl	estrg
	.globl	ssymb
	.globl	bsymb
	.globl	esymb
	.globl	scons
	.globl	bcons
	.globl	econs
	.globl	stotal
	.globl	dtotal
	.globl	fsymb
	.globl	fstrg
smemi:
	.long	0
scode:
	.long	0
sarray:
	.long	0
sstrg:
	.long	0
ssymb:
	.long	0
scons:
	.long	0
stotal:
	.long	0
dtotal:
	.long	0
bmemi:
	.long	0
ememi:
	.long	0
bcode:
	.long	0
ecode:
	.long	0
barray:
	.long	0
earray:
	.long	0
bstrg:
	.long	0
estrg:
	.long	0
bsymb:
	.long	0
esymb:
	.long	0
bcons:
	.long	0
econs:
	.long	0
fstrg:
	.long	0
fsymb:
	.long	0
	.globl	maxbucket
	.globl	hashmax
	.globl	hashtab
	.globl	csymb
	.set	maxbucket,263
hashmax:
	.long	maxbucket-1
hashtab:
	.space	263*4
csymb:
	.long	0
	.globl	filin
	.globl	filiz
filiz:
	.long	0
filin:
	.space	64
	.text
	.globl	llinit
	.globl	reenter
	.globl	theend
llinit:
	movl	bmemi,r1
	addl2	smemi,r1
	decl	r1
	movl	r1,ememi
	incl	r1
	movl	r1,bcode
	addl2	scode,r1
	decl	r1
	movl	r1,ecode
	incl	r1
	movl	r1,barray
	addl2	sarray,r1
	decl	r1
	movl	r1,earray
	incl	r1
	movl	r1,bstrg
	movl	r1,r6
	addl2	sstrg,r1
	decl	r1
	movl	r1,estrg
	incl	r1
	movl	r1,bsymb
	movl	r1,r7
	addl2	ssymb,r1
	decl	r1
	movl	r1,esymb
	incl	r1
	movl	r1,r9
	movl	r1,bcons
	addl2	scons,r1
	decl	r1
	movl	r1,econs
	movl	bstack,r14
	.globl	buildat
	.globl	.void
	.globl	.nil
	.globl	.undef
	movl	hashmax,r1
	jmp	inhas2
inhas1:
	movl	r1,r0
	movl	$0,*$hashtab[r0]
inhas2:
	sobgeq	r1,inhas1
	.globl	dibug
dibug:
	movl	bsymb,r7
	movl	bsymb,csymb
	.data
.nil:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.nil
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	3
	.ascii	"nil"
	.data
.undef:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.undef
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"undef"
	movl	csymb,r8
	movl	csymb,r0
	movl	r0,.llversion
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	llversion,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._llversion
	.byte	0
	.word	7
	.ascii	"version"
	movl	csymb,r0
	movl	r0,.ffsystem
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ffsystem,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ffsystem
	.byte	0
	.word	6
	.ascii	"system"
	.data
.vaxunix:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.vaxunix
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"vaxunix"
	.data
.sm90:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.sm90
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	4
	.ascii	"sm90"
	.data
.versados:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.versados
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	8
	.ascii	"versados"
	.data
.versamodule:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.versamodule
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	11
	.ascii	"versamodule"
	movl	csymb,r0
	movl	r0,.reset
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	reset,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._reset
	.byte	0
	.word	5
	.ascii	"reset"
	movl	csymb,r0
	movl	r0,.stop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	stop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._stop
	.byte	0
	.word	4
	.ascii	"quit"
	movl	csymb,r0
	movl	r0,.stop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	stop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._stop
	.byte	0
	.word	4
	.ascii	"stop"
	movl	csymb,r0
	movl	r0,.stop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	stop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._stop
	.byte	0
	.word	3
	.ascii	"end"
	.globl	ini_top
	.globl	ini_gc
	.globl	ini_pio
	.globl	ini_read
	.globl	ini_print
	.globl	ini_eval
	.globl	ini_cad
	.globl	ini_std
	.globl	ini_ctl
	.globl	ini_nbs
	.globl	ini_bll
	jsb	ini_top
	jsb	ini_gc
	jsb	ini_pio
	jsb	ini_read
	jsb	ini_print
	jsb	ini_eval
	jsb	ini_ctl
	jsb	ini_cad
	jsb	ini_std
	jsb	ini_nbs
	jsb	ini_bll
	movl	$70,r10
	moval	llmsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
	cmpl	$0,smemi
	jeql	imin1
	movl	$10,r10
	moval	ouimsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
	jmp	imin2
imin1:
	movl	$10,r10
	moval	nonmsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
imin2:
	.globl	tryatom
	.globl	input
	cmpl	$0,filiz
	jeql	imin3
	movl	filiz,r10
	moval	filin,r0
	jsb	tryatom
	jsb	input
imin3:
reenter:
	movl	bstack,r14
	movl	$10,r10
	moval	reemsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
	.globl	systop
	jmp	systop
theend:
	movl	$30,r10
	moval	teemsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
	movl	$2,r10
	moval	finmsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r1
	.globl	ll_exit
	jsb	ll_exit
	.data
.llversion:
	.long	0
	.set	._llversion,subr0
	.text
	.globl	llversion
llversion:
	movl	$nversion,r1
	rsb
	.data
.ffsystem:
	.long	0
	.set	._ffsystem,subr0
	.text
	.globl	ffsystem
ffsystem:
	movl	.sm90,r1
	rsb
	.data
.reset:
	.long	0
	.set	._reset,subr0
	.text
	.globl	reset
reset:
	jmp	reenter
	.data
.stop:
	.long	0
	.set	._stop,subr0
	.text
	.globl	stop
stop:
	jmp	theend
	.data
	.set	nversion,11
llmsg:
	.ascii	"*******  Le_Lisp  VAX  (by INRIA) "
	.ascii	" version 11  (1/Mars/83)          "
	.byte	13
	.byte	10
teemsg:
	.ascii	"Que Le_Lisp soit avec vous. "
finmsg:
	.byte	13
	.byte	10
ouimsg:
	.ascii	"avec MI "
	.byte	13
	.byte	10
nonmsg:
	.ascii	"sans MI "
	.byte	13
	.byte	10
tpmsg:
	.ascii	"= "
reemsg:
	.ascii	"On y va "
	.byte	13
	.byte	10
