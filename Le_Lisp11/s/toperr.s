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
	.globl	.void
	.globl	gc
	.globl	ll_ttyo
	.globl	reenter
	.globl	lel_a7
	.globl	u_read
	.globl	probj
	.globl	probjt
	.globl	u_print
	.globl	pbind
	.globl	findtag
	.globl	itsoft
	.globl	u_eval
	.globl	nreverse
	.globl	loc
	.globl	ini_top
	.globl	popj
	.globl	systop
	.globl	serror
	.globl	ferror
	.globl	errfs
	.globl	erfm
	.globl	errovf
	.globl	errudv
	.globl	errudf
	.globl	errudt
	.globl	errwla
	.globl	errwna
	.globl	errnaa
	.globl	errnna
	.globl	errnsa
	.globl	errnla
	.globl	errnva
	.globl	errnca
	.globl	errwna
	.globl	errstl
	.globl	erroob
	.globl	errios
	.globl	errsxt
	.set	nr_udv,1
	.set	nr_udf,2
	.set	nr_udt,3
	.set	nr_sxt,6
	.set	nr_ios,8
	.set	nr_ovf,9
	.set	nr_nna,10
	.set	nr_nsa,11
	.set	nr_naa,12
	.set	nr_nla,13
	.set	nr_nva,14
	.set	nr_nca,15
	.set	nr_oob,16
	.set	nr_wna,17
	.set	nr_wla,18
	.set	nr_stl,19
	.text
ini_top:
	.globl	.t
	.globl	.0subr
	.globl	.1subr
	.globl	.2subr
	.globl	.3subr
	.globl	.nsubr
	.globl	.fsubr
	.globl	.expr
	.globl	.fexpr
	.globl	.macro
	.data
.t:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.t
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	1
	.ascii	"t"
	.data
.0subr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.0subr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"0subr"
	.data
.1subr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.1subr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"1subr"
	.data
.2subr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.2subr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"2subr"
	.data
.3subr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.3subr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"3subr"
	.data
.nsubr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.nsubr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"nsubr"
	.data
.fsubr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.fsubr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"fsubr"
	.data
.expr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.expr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	4
	.ascii	"expr"
	.data
.fexpr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.fexpr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"fexpr"
	.data
.macro:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.macro
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	5
	.ascii	"macro"
	movl	csymb,r0
	movl	r0,.toplevel
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	toplevel,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._toplevel
	.byte	0
	.word	8
	.ascii	"toplevel"
	.data
.statoplevel:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.statoplevel
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	15
	.ascii	"status-toplevel"
	movl	.statoplevel,r4
	movl	.t,cval(r4)
	movl	csymb,r0
	movl	r0,.runt
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	runt,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._runt
	.byte	0
	.word	7
	.ascii	"runtime"
	movl	csymb,r0
	movl	r0,.cstack
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cstack,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cstack
	.byte	0
	.word	6
	.ascii	"cstack"
	movl	csymb,r0
	movl	r0,.syserror
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	syserror,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._syserror
	.byte	0
	.word	8
	.ascii	"syserror"
	.data
.fatalerror:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.fatalerror
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	14
	.ascii	"**errset-tag**"
	.data
.mserror:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mserror
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	3
	.ascii	"** "
	.data
.colon:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.colon
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	3
	.ascii	" : "
	.data
.trap:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.trap
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	4
	.ascii	"trap"
	.data
.k68:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.k68
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	7
	.ascii	"mc68000"
	.data
.mer0:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer0
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	8
	.ascii	"erreur 0"
	.data
.mer1:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer1
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	18
	.ascii	"variable indefinie"
	.data
.mer2:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer2
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	18
	.ascii	"fonction indefinie"
	.data
.mer3:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer3
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	20
	.ascii	"echappement indefini"
	.data
.mer4:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer4
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	21
	.ascii	"chronologie indefinie"
	.data
.mer5:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer5
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	27
	.ascii	"LAMBDA expression indefinie"
	.data
.mer6:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer6
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	17
	.ascii	"erreur de syntaxe"
	.data
.mer7:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer7
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	31
	.ascii	"debordement du tampon de sortie"
	.data
.mer8:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer8
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	22
	.ascii	"erreur d entree sortie"
	.data
.mer9:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer9
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	20
	.ascii	"debordement d entier"
	.data
.mer10:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer10
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	30
	.ascii	"l argument n est pas un nombre"
	.data
.mer11:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer11
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	31
	.ascii	"l argument n est pas une chaine"
	.data
.mer12:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer12
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	31
	.ascii	"l argument n est pas un symbole"
	.data
.mer13:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer13
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	30
	.ascii	"l argument n est pas une liste"
	.data
.mer14:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer14
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	33
	.ascii	"l argument n est pas une variable"
	.data
.mer15:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer15
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	33
	.ascii	"l argument n est pas un caractere"
	.data
.mer16:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer16
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	21
	.ascii	"argument hors limites"
	.data
.mer17:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer17
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	26
	.ascii	"mauvais nombre d arguments"
	.data
.mer18:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer18
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	26
	.ascii	"mauvaise liste d arguments"
	.data
.mer19:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mer19
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	32
	.ascii	"chaine de caracteres trop longue"
	.data
.mach0:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach0
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	13
	.ascii	"erreur du bus"
	.data
.mach1:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach1
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	14
	.ascii	"erreur adresse"
	.data
.mach2:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach2
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	20
	.ascii	"instruction illegale"
	.data
.mach3:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach3
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	14
	.ascii	"division par 0"
	.data
.mach4:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach4
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	15
	.ascii	"instruction CHK"
	.data
.mach5:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach5
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	17
	.ascii	"instruction TRAPV"
	.data
.mach6:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach6
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	19
	.ascii	"violation privilege"
	.data
.mach7:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach7
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	16
	.ascii	"instruction 1010"
	.data
.mach8:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.mach8
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	16
	.ascii	"instruction 1111"
	movl	$0,r0
	movl	.mer0,*$taberr[r0]
	movl	$1,r0
	movl	.mer1,*$taberr[r0]
	movl	$2,r0
	movl	.mer2,*$taberr[r0]
	movl	$3,r0
	movl	.mer3,*$taberr[r0]
	movl	$4,r0
	movl	.mer4,*$taberr[r0]
	movl	$5,r0
	movl	.mer5,*$taberr[r0]
	movl	$6,r0
	movl	.mer6,*$taberr[r0]
	movl	$7,r0
	movl	.mer7,*$taberr[r0]
	movl	$8,r0
	movl	.mer8,*$taberr[r0]
	movl	$9,r0
	movl	.mer9,*$taberr[r0]
	movl	$10,r0
	movl	.mer10,*$taberr[r0]
	movl	$11,r0
	movl	.mer11,*$taberr[r0]
	movl	$12,r0
	movl	.mer12,*$taberr[r0]
	movl	$13,r0
	movl	.mer13,*$taberr[r0]
	movl	$14,r0
	movl	.mer14,*$taberr[r0]
	movl	$15,r0
	movl	.mer15,*$taberr[r0]
	movl	$16,r0
	movl	.mer16,*$taberr[r0]
	movl	$17,r0
	movl	.mer17,*$taberr[r0]
	movl	$18,r0
	movl	.mer18,*$taberr[r0]
	movl	$19,r0
	movl	.mer19,*$taberr[r0]
	movl	$0,r0
	movl	.mach0,*$macerr[r0]
	movl	$1,r0
	movl	.mach1,*$macerr[r0]
	movl	$2,r0
	movl	.mach2,*$macerr[r0]
	movl	$3,r0
	movl	.mach3,*$macerr[r0]
	movl	$4,r0
	movl	.mach4,*$macerr[r0]
	movl	$5,r0
	movl	.mach5,*$macerr[r0]
	movl	$6,r0
	movl	.mach6,*$macerr[r0]
	movl	$7,r0
	movl	.mach7,*$macerr[r0]
	movl	$8,r0
	movl	.mach8,*$macerr[r0]
	rsb
popj:
	rsb
systop:
	movl	r7,pbind
	movl	.toplevel,r1
	movl	r7,r2
	jsb	itsoft
	jmp	systop
	.data
.toplevel:
	.long	0
	.set	._toplevel,subr0
	.text
	.globl	toplevel
toplevel:
	jsb	u_read
	jsb	u_eval
	movl	.statoplevel,r2
	movl	cval(r2),r2
	cmpl	r7,r2
	jeql	toplend
	movl	$2,r10
	moval	tpmsg,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	jsb	u_print
toplend:
	rsb
	.data
.cstack:
	.long	0
	.set	._cstack,subr0
	.text
	.globl	cstack
cstack:
	movl	r7,r1
	pushl	r1
	movl	pbind,r4
	jmp	evstck3
evstck1:
	movl	r7,r1
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.1
	jsb	gc
.1:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	tevstck[r3],r0
	jmp	(r0)
tevstck:
	.long	evstkl
	.long	evstka
	.long	evstke
	.long	evstks
	.long	evstkb
	.long	evstku
evstck2:
	jsb	nreverse
	movl	(r14)+,r2
	cmpl	r5,r7
	jneq	.2
	jsb	gc
.2:
	movl	r5,r0
	movl	r1,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	pushl	r2
evstck3:
	cmpl	r7,r4
	jneq	evstck1
	movl	(r14)+,r1
	jmp	nreverse
evstkl:
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
evstkl1:
	movl	(r4)+,r3
	cmpl	r3,$mk_eval
	jeql	evstkl2
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	jmp	evstkl1
evstkl2:
	movl	(r4)+,r4
	jmp	evstck2
evstka:
	movl	(r4)+,r2
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.8
	jsb	gc
.8:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	r2,r4
	jmp	evstck2
evstke:
evstkb:
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.9
	jsb	gc
.9:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r4
	jmp	evstck2
evstks:
	movl	(r4)+,r2
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.10
	jsb	gc
.10:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r3
	cmpl	r5,r7
	jneq	.11
	jsb	gc
.11:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	r2,r4
	jmp	evstck2
evstku:
	movl	(r4)+,r2
	cmpl	r5,r7
	jneq	.12
	jsb	gc
.12:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	movl	(r4)+,r4
	jmp	evstck2
	.data
.runt:
	.long	0
	.set	._runt,subr0
	.text
	.globl	runt
runt:
	.globl	ll_runt
	jsb	ll_runt
	movl	r0,r1
	rsb
serror:
	cmpl	r5,r7
	jneq	.13
	jsb	gc
.13:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	*$taberr[r3],r3
	cmpl	r5,r7
	jneq	.14
	jsb	gc
.14:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	cmpl	r5,r7
	jneq	.15
	jsb	gc
.15:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r1,cdr(r2)
	movl	.syserror,r1
	jmp	itsoft
ferror:
	movl	r7,r1
	movl	.fatalerror,r2
	movl	r7,r3
	movl	r7,r4
	jmp	findtag
	.data
.syserror:
	.long	0
	.set	._syserror,subr3
	.text
	.globl	syserror
syserror:
	pushl	r3
	pushl	r2
	pushl	r1
	movl	.mserror,r1
	jsb	probj
	movl	(r14)+,r1
	jsb	probj
	movl	.colon,r1
	jsb	probj
	movl	(r14)+,r1
	jsb	probj
	movl	.colon,r1
	jsb	probj
	movl	(r14)+,r1
	jsb	probjt
	jmp	reenter
errfs:
	jbr	b.16
m.16:
	.asciz	"**** Erreur fatale : pile pleine ****     "
b.16:
	movl	$42,r10
	moval	m.16,r0
	jsb	ll_ttyo
	jbr	b.17
m.17:
	.word	0x0d0a
b.17:
	movl	$2,r10
	moval	m.17,r0
	jsb	ll_ttyo
	jmp	ferror
erfm:
	jbr	b.18
m.18:
	.asciz	"**** Erreur fatale : plus de memoire **** "
b.18:
	movl	$42,r10
	moval	m.18,r0
	jsb	ll_ttyo
	jbr	b.19
m.19:
	.word	0x0d0a
b.19:
	movl	$2,r10
	moval	m.19,r0
	jsb	ll_ttyo
	jmp	ferror
errudv:
	movl	$nr_udv,r3
	jmp	serror
errudf:
	movl	$nr_udf,r3
	jmp	serror
errudt:
	movl	$nr_udt,r3
	jmp	serror
errwna:
	movl	$nr_wna,r3
	jmp	serror
errwla:
	movl	$nr_wla,r3
	jmp	serror
errsxt:
	movl	$nr_sxt,r3
	jmp	serror
errios:
	movl	$nr_ios,r3
	jmp	serror
errovf:
	movl	$nr_ovf,r3
	jmp	serror
errnaa:
	movl	$nr_naa,r3
	jmp	serror
errnna:
	movl	$nr_nna,r3
	jmp	serror
errnsa:
	movl	$nr_nsa,r3
	jmp	serror
errnla:
	movl	$nr_nla,r3
	jmp	serror
errnva:
	movl	$nr_nva,r3
	jmp	serror
errnca:
	movl	$nr_nca,r3
	jmp	serror
errstl:
	movl	$nr_stl,r3
	jmp	serror
erroob:
	movl	$nr_oob,r3
	jmp	serror
merror:
	pushl	r1
	movl	r14,r1
	jsb	loc
	cmpl	r5,r7
	jneq	.20
	jsb	gc
.20:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	(r14)+,r2
	movl	*$macerr[r2],r2
	cmpl	r5,r7
	jneq	.21
	jsb	gc
.21:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r1,cdr(r2)
	movl	.k68,r1
	cmpl	r5,r7
	jneq	.22
	jsb	gc
.22:
	movl	r5,r0
	movl	r1,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	.syserror,r1
	jmp	itsoft
evta0:
	movl	$0,r1
	jmp	merror
evta1:
	movl	$1,r1
	jmp	merror
evta2:
	movl	$2,r1
	jmp	merror
evta3:
	movl	$3,r1
	jmp	merror
evta4:
	movl	$4,r1
	jmp	merror
evta5:
	movl	$5,r1
	jmp	merror
terror:
	cmpl	r5,r7
	jneq	.23
	jsb	gc
.23:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	cmpl	r5,r7
	jneq	.24
	jsb	gc
.24:
	movl	r5,r0
	movl	r1,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	.trap,r1
	cmpl	r5,r7
	jneq	.25
	jsb	gc
.25:
	movl	r5,r0
	movl	r1,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	.syserror,r1
	jmp	itsoft
trp1:
	movl	$1,r1
	jmp	terror
trp2:
	movl	$2,r1
	jmp	terror
trp3:
	movl	$3,r1
	jmp	terror
trp4:
	movl	$4,r1
	jmp	terror
trp5:
	movl	$5,r1
	jmp	terror
trp6:
	movl	$6,r1
	jmp	terror
trp7:
	movl	$7,r1
	jmp	terror
trp8:
	movl	$8,r1
	jmp	terror
trp9:
	movl	$9,r1
	jmp	terror
trp10:
	movl	$10,r1
	jmp	terror
trp11:
	movl	$11,r1
	jmp	terror
trp12:
	movl	$12,r1
	jmp	terror
trp13:
	movl	$13,r1
	jmp	terror
trp14:
	movl	$14,r1
	jmp	terror
trp15:
	movl	$15,r1
	jmp	terror
tevta:
	.long	evta1
	.long	evta1
	.long	evta2
	.long	evta3
	.long	evta4
	.long	evta5
	.long	0
	.long	0
	.long	0
tbtrp:
	.long	0
	.long	0
	.long	0
	.long	trp5
	.long	trp6
	.long	trp7
	.long	trp8
	.long	trp9
	.long	trp10
	.long	trp11
	.long	trp12
	.long	trp13
	.long	trp14
	.long	0
tpmsg:
	.ascii	"= "
	.data
	.globl	taberr
taberr:
	.space	20*4
macerr:
	.space	10*4
