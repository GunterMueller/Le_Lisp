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
	.text
	.globl	buildat
	.globl	csymb
	.globl	.undef
	.globl	.void
	.globl	errnla
	.globl	ini_cad
ini_cad:
	movl	csymb,r0
	movl	r0,.fcar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fcar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fcar
	.byte	0
	.word	3
	.ascii	"car"
	movl	csymb,r0
	movl	r0,.fcdr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fcdr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fcdr
	.byte	0
	.word	3
	.ascii	"cdr"
	movl	csymb,r0
	movl	r0,.caar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caar
	.byte	0
	.word	4
	.ascii	"caar"
	movl	csymb,r0
	movl	r0,.cadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cadr
	.byte	0
	.word	4
	.ascii	"cadr"
	movl	csymb,r0
	movl	r0,.cdar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdar
	.byte	0
	.word	4
	.ascii	"cdar"
	movl	csymb,r0
	movl	r0,.cddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cddr
	.byte	0
	.word	4
	.ascii	"cddr"
	movl	csymb,r0
	movl	r0,.caaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caaar
	.byte	0
	.word	5
	.ascii	"caaar"
	movl	csymb,r0
	movl	r0,.caadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caadr
	.byte	0
	.word	5
	.ascii	"caadr"
	movl	csymb,r0
	movl	r0,.cadar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cadar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cadar
	.byte	0
	.word	5
	.ascii	"cadar"
	movl	csymb,r0
	movl	r0,.caddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caddr
	.byte	0
	.word	5
	.ascii	"caddr"
	movl	csymb,r0
	movl	r0,.cdaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdaar
	.byte	0
	.word	5
	.ascii	"cdaar"
	movl	csymb,r0
	movl	r0,.cdadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdadr
	.byte	0
	.word	5
	.ascii	"cdadr"
	movl	csymb,r0
	movl	r0,.cddar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cddar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cddar
	.byte	0
	.word	5
	.ascii	"cddar"
	movl	csymb,r0
	movl	r0,.cdddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdddr
	.byte	0
	.word	5
	.ascii	"cdddr"
	movl	csymb,r0
	movl	r0,.caaaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caaaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caaaar
	.byte	0
	.word	6
	.ascii	"caaaar"
	movl	csymb,r0
	movl	r0,.caaadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caaadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caaadr
	.byte	0
	.word	6
	.ascii	"caaadr"
	movl	csymb,r0
	movl	r0,.caadar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caadar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caadar
	.byte	0
	.word	6
	.ascii	"caadar"
	movl	csymb,r0
	movl	r0,.caaddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caaddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caaddr
	.byte	0
	.word	6
	.ascii	"caaddr"
	movl	csymb,r0
	movl	r0,.cadaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cadaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cadaar
	.byte	0
	.word	6
	.ascii	"cadaar"
	movl	csymb,r0
	movl	r0,.cadadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cadadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cadadr
	.byte	0
	.word	6
	.ascii	"cadadr"
	movl	csymb,r0
	movl	r0,.caddar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	caddar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._caddar
	.byte	0
	.word	6
	.ascii	"caddar"
	movl	csymb,r0
	movl	r0,.cadddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cadddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cadddr
	.byte	0
	.word	6
	.ascii	"cadddr"
	movl	csymb,r0
	movl	r0,.cdaaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdaaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdaaar
	.byte	0
	.word	6
	.ascii	"cdaaar"
	movl	csymb,r0
	movl	r0,.cdaadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdaadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdaadr
	.byte	0
	.word	6
	.ascii	"cdaadr"
	movl	csymb,r0
	movl	r0,.cdadar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdadar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdadar
	.byte	0
	.word	6
	.ascii	"cdadar"
	movl	csymb,r0
	movl	r0,.cdaddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdaddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdaddr
	.byte	0
	.word	6
	.ascii	"cdaddr"
	movl	csymb,r0
	movl	r0,.cddaar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cddaar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cddaar
	.byte	0
	.word	6
	.ascii	"cddaar"
	movl	csymb,r0
	movl	r0,.cddadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cddadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cddadr
	.byte	0
	.word	6
	.ascii	"cddadr"
	movl	csymb,r0
	movl	r0,.cdddar
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cdddar,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cdddar
	.byte	0
	.word	6
	.ascii	"cdddar"
	movl	csymb,r0
	movl	r0,.cddddr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cddddr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cddddr
	.byte	0
	.word	6
	.ascii	"cddddr"
	rsb
	.data
.fcar:
	.long	0
	.set	._fcar,subr1
	.text
	.globl	fcar
fcar:
	cmpl	r7,r1
	jeql	caret
	cmpl	r9,r1
	jgtr	carer
	movl	car(r1),r1
caret:
	rsb
carer:
	movl	.fcar,r2
	jmp	errnla
	.data
.fcdr:
	.long	0
	.set	._fcdr,subr1
	.text
	.globl	fcdr
fcdr:
	cmpl	r7,r1
	jeql	cdret
	cmpl	r9,r1
	jgtr	cdrer
	movl	cdr(r1),r1
cdret:
	rsb
cdrer:
	movl	.fcdr,r2
	jmp	errnla
	.data
.caar:
	.long	0
	.set	._caar,subr1
	.text
	.globl	caar
caar:
	cmpl	r7,r1
	jeql	caaret
	cmpl	r9,r1
	jgtr	caarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaret
	cmpl	r9,r1
	jgtr	caarer
	movl	car(r1),r1
caaret:
	rsb
caarer:
	movl	.caar,r2
	jmp	errnla
	.data
.cadr:
	.long	0
	.set	._cadr,subr1
	.text
	.globl	cadr
cadr:
	cmpl	r7,r1
	jeql	cadret
	cmpl	r9,r1
	jgtr	cadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadret
	cmpl	r9,r1
	jgtr	cadrer
	movl	car(r1),r1
cadret:
	rsb
cadrer:
	movl	.cadr,r2
	jmp	errnla
	.data
.cdar:
	.long	0
	.set	._cdar,subr1
	.text
	.globl	cdar
cdar:
	cmpl	r7,r1
	jeql	cdaret
	cmpl	r9,r1
	jgtr	cdarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaret
	cmpl	r9,r1
	jgtr	cdarer
	movl	cdr(r1),r1
cdaret:
	rsb
cdarer:
	movl	.cdar,r2
	jmp	errnla
	.data
.cddr:
	.long	0
	.set	._cddr,subr1
	.text
	.globl	cddr
cddr:
	cmpl	r7,r1
	jeql	cddret
	cmpl	r9,r1
	jgtr	cddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddret
	cmpl	r9,r1
	jgtr	cddrer
	movl	cdr(r1),r1
cddret:
	rsb
cddrer:
	movl	.cddr,r2
	jmp	errnla
	.data
.caaar:
	.long	0
	.set	._caaar,subr1
	.text
	.globl	caaar
caaar:
	cmpl	r7,r1
	jeql	caaaret
	cmpl	r9,r1
	jgtr	caaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaaret
	cmpl	r9,r1
	jgtr	caaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaaret
	cmpl	r9,r1
	jgtr	caaarer
	movl	car(r1),r1
caaaret:
	rsb
caaarer:
	movl	.caaar,r2
	jmp	errnla
	.data
.caadr:
	.long	0
	.set	._caadr,subr1
	.text
	.globl	caadr
caadr:
	cmpl	r7,r1
	jeql	caadret
	cmpl	r9,r1
	jgtr	caadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caadret
	cmpl	r9,r1
	jgtr	caadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caadret
	cmpl	r9,r1
	jgtr	caadrer
	movl	car(r1),r1
caadret:
	rsb
caadrer:
	movl	.caadr,r2
	jmp	errnla
	.data
.cadar:
	.long	0
	.set	._cadar,subr1
	.text
	.globl	cadar
cadar:
	cmpl	r7,r1
	jeql	cadaret
	cmpl	r9,r1
	jgtr	cadarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cadaret
	cmpl	r9,r1
	jgtr	cadarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadaret
	cmpl	r9,r1
	jgtr	cadarer
	movl	car(r1),r1
cadaret:
	rsb
cadarer:
	movl	.cadar,r2
	jmp	errnla
	.data
.caddr:
	.long	0
	.set	._caddr,subr1
	.text
	.globl	caddr
caddr:
	cmpl	r7,r1
	jeql	caddret
	cmpl	r9,r1
	jgtr	caddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caddret
	cmpl	r9,r1
	jgtr	caddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caddret
	cmpl	r9,r1
	jgtr	caddrer
	movl	car(r1),r1
caddret:
	rsb
caddrer:
	movl	.caddr,r2
	jmp	errnla
	.data
.cdaar:
	.long	0
	.set	._cdaar,subr1
	.text
	.globl	cdaar
cdaar:
	cmpl	r7,r1
	jeql	cdaaret
	cmpl	r9,r1
	jgtr	cdaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaaret
	cmpl	r9,r1
	jgtr	cdaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaaret
	cmpl	r9,r1
	jgtr	cdaarer
	movl	cdr(r1),r1
cdaaret:
	rsb
cdaarer:
	movl	.cdaar,r2
	jmp	errnla
	.data
.cdadr:
	.long	0
	.set	._cdadr,subr1
	.text
	.globl	cdadr
cdadr:
	cmpl	r7,r1
	jeql	cdadret
	cmpl	r9,r1
	jgtr	cdadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdadret
	cmpl	r9,r1
	jgtr	cdadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdadret
	cmpl	r9,r1
	jgtr	cdadrer
	movl	cdr(r1),r1
cdadret:
	rsb
cdadrer:
	movl	.cdadr,r2
	jmp	errnla
	.data
.cddar:
	.long	0
	.set	._cddar,subr1
	.text
	.globl	cddar
cddar:
	cmpl	r7,r1
	jeql	cddaret
	cmpl	r9,r1
	jgtr	cddarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cddaret
	cmpl	r9,r1
	jgtr	cddarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddaret
	cmpl	r9,r1
	jgtr	cddarer
	movl	cdr(r1),r1
cddaret:
	rsb
cddarer:
	movl	.cddar,r2
	jmp	errnla
	.data
.cdddr:
	.long	0
	.set	._cdddr,subr1
	.text
	.globl	cdddr
cdddr:
	cmpl	r7,r1
	jeql	cdddret
	cmpl	r9,r1
	jgtr	cdddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdddret
	cmpl	r9,r1
	jgtr	cdddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdddret
	cmpl	r9,r1
	jgtr	cdddrer
	movl	cdr(r1),r1
cdddret:
	rsb
cdddrer:
	movl	.cdddr,r2
	jmp	errnla
	.data
.caaaar:
	.long	0
	.set	._caaaar,subr1
	.text
	.globl	caaaar
caaaar:
	cmpl	r7,r1
	jeql	caaaaret
	cmpl	r9,r1
	jgtr	caaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaaaret
	cmpl	r9,r1
	jgtr	caaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaaaret
	cmpl	r9,r1
	jgtr	caaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaaaret
	cmpl	r9,r1
	jgtr	caaaarer
	movl	car(r1),r1
caaaaret:
	rsb
caaaarer:
	movl	.caaaar,r2
	jmp	errnla
	.data
.caaadr:
	.long	0
	.set	._caaadr,subr1
	.text
	.globl	caaadr
caaadr:
	cmpl	r7,r1
	jeql	caaadret
	cmpl	r9,r1
	jgtr	caaadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caaadret
	cmpl	r9,r1
	jgtr	caaadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaadret
	cmpl	r9,r1
	jgtr	caaadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaadret
	cmpl	r9,r1
	jgtr	caaadrer
	movl	car(r1),r1
caaadret:
	rsb
caaadrer:
	movl	.caaadr,r2
	jmp	errnla
	.data
.caadar:
	.long	0
	.set	._caadar,subr1
	.text
	.globl	caadar
caadar:
	cmpl	r7,r1
	jeql	caadaret
	cmpl	r9,r1
	jgtr	caadarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caadaret
	cmpl	r9,r1
	jgtr	caadarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caadaret
	cmpl	r9,r1
	jgtr	caadarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caadaret
	cmpl	r9,r1
	jgtr	caadarer
	movl	car(r1),r1
caadaret:
	rsb
caadarer:
	movl	.caadar,r2
	jmp	errnla
	.data
.caaddr:
	.long	0
	.set	._caaddr,subr1
	.text
	.globl	caaddr
caaddr:
	cmpl	r7,r1
	jeql	caaddret
	cmpl	r9,r1
	jgtr	caaddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caaddret
	cmpl	r9,r1
	jgtr	caaddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caaddret
	cmpl	r9,r1
	jgtr	caaddrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caaddret
	cmpl	r9,r1
	jgtr	caaddrer
	movl	car(r1),r1
caaddret:
	rsb
caaddrer:
	movl	.caaddr,r2
	jmp	errnla
	.data
.cadaar:
	.long	0
	.set	._cadaar,subr1
	.text
	.globl	cadaar
cadaar:
	cmpl	r7,r1
	jeql	cadaaret
	cmpl	r9,r1
	jgtr	cadaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cadaaret
	cmpl	r9,r1
	jgtr	cadaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cadaaret
	cmpl	r9,r1
	jgtr	cadaarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadaaret
	cmpl	r9,r1
	jgtr	cadaarer
	movl	car(r1),r1
cadaaret:
	rsb
cadaarer:
	movl	.cadaar,r2
	jmp	errnla
	.data
.cadadr:
	.long	0
	.set	._cadadr,subr1
	.text
	.globl	cadadr
cadadr:
	cmpl	r7,r1
	jeql	cadadret
	cmpl	r9,r1
	jgtr	cadadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadadret
	cmpl	r9,r1
	jgtr	cadadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cadadret
	cmpl	r9,r1
	jgtr	cadadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadadret
	cmpl	r9,r1
	jgtr	cadadrer
	movl	car(r1),r1
cadadret:
	rsb
cadadrer:
	movl	.cadadr,r2
	jmp	errnla
	.data
.caddar:
	.long	0
	.set	._caddar,subr1
	.text
	.globl	caddar
caddar:
	cmpl	r7,r1
	jeql	caddaret
	cmpl	r9,r1
	jgtr	caddarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	caddaret
	cmpl	r9,r1
	jgtr	caddarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caddaret
	cmpl	r9,r1
	jgtr	caddarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	caddaret
	cmpl	r9,r1
	jgtr	caddarer
	movl	car(r1),r1
caddaret:
	rsb
caddarer:
	movl	.caddar,r2
	jmp	errnla
	.data
.cadddr:
	.long	0
	.set	._cadddr,subr1
	.text
	.globl	cadddr
cadddr:
	cmpl	r7,r1
	jeql	cadddret
	cmpl	r9,r1
	jgtr	cadddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadddret
	cmpl	r9,r1
	jgtr	cadddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadddret
	cmpl	r9,r1
	jgtr	cadddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cadddret
	cmpl	r9,r1
	jgtr	cadddrer
	movl	car(r1),r1
cadddret:
	rsb
cadddrer:
	movl	.cadddr,r2
	jmp	errnla
	.data
.cdaaar:
	.long	0
	.set	._cdaaar,subr1
	.text
	.globl	cdaaar
cdaaar:
	cmpl	r7,r1
	jeql	cdaaaret
	cmpl	r9,r1
	jgtr	cdaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaaaret
	cmpl	r9,r1
	jgtr	cdaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaaaret
	cmpl	r9,r1
	jgtr	cdaaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaaaret
	cmpl	r9,r1
	jgtr	cdaaarer
	movl	cdr(r1),r1
cdaaaret:
	rsb
cdaaarer:
	movl	.cdaaar,r2
	jmp	errnla
	.data
.cdaadr:
	.long	0
	.set	._cdaadr,subr1
	.text
	.globl	cdaadr
cdaadr:
	cmpl	r7,r1
	jeql	cdaadret
	cmpl	r9,r1
	jgtr	cdaadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdaadret
	cmpl	r9,r1
	jgtr	cdaadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaadret
	cmpl	r9,r1
	jgtr	cdaadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaadret
	cmpl	r9,r1
	jgtr	cdaadrer
	movl	cdr(r1),r1
cdaadret:
	rsb
cdaadrer:
	movl	.cdaadr,r2
	jmp	errnla
	.data
.cdadar:
	.long	0
	.set	._cdadar,subr1
	.text
	.globl	cdadar
cdadar:
	cmpl	r7,r1
	jeql	cdadaret
	cmpl	r9,r1
	jgtr	cdadarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdadaret
	cmpl	r9,r1
	jgtr	cdadarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdadaret
	cmpl	r9,r1
	jgtr	cdadarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdadaret
	cmpl	r9,r1
	jgtr	cdadarer
	movl	cdr(r1),r1
cdadaret:
	rsb
cdadarer:
	movl	.cdadar,r2
	jmp	errnla
	.data
.cdaddr:
	.long	0
	.set	._cdaddr,subr1
	.text
	.globl	cdaddr
cdaddr:
	cmpl	r7,r1
	jeql	cdaddret
	cmpl	r9,r1
	jgtr	cdaddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdaddret
	cmpl	r9,r1
	jgtr	cdaddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdaddret
	cmpl	r9,r1
	jgtr	cdaddrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdaddret
	cmpl	r9,r1
	jgtr	cdaddrer
	movl	cdr(r1),r1
cdaddret:
	rsb
cdaddrer:
	movl	.cdaddr,r2
	jmp	errnla
	.data
.cddaar:
	.long	0
	.set	._cddaar,subr1
	.text
	.globl	cddaar
cddaar:
	cmpl	r7,r1
	jeql	cddaaret
	cmpl	r9,r1
	jgtr	cddaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cddaaret
	cmpl	r9,r1
	jgtr	cddaarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cddaaret
	cmpl	r9,r1
	jgtr	cddaarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddaaret
	cmpl	r9,r1
	jgtr	cddaarer
	movl	cdr(r1),r1
cddaaret:
	rsb
cddaarer:
	movl	.cddaar,r2
	jmp	errnla
	.data
.cddadr:
	.long	0
	.set	._cddadr,subr1
	.text
	.globl	cddadr
cddadr:
	cmpl	r7,r1
	jeql	cddadret
	cmpl	r9,r1
	jgtr	cddadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddadret
	cmpl	r9,r1
	jgtr	cddadrer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cddadret
	cmpl	r9,r1
	jgtr	cddadrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddadret
	cmpl	r9,r1
	jgtr	cddadrer
	movl	cdr(r1),r1
cddadret:
	rsb
cddadrer:
	movl	.cddadr,r2
	jmp	errnla
	.data
.cdddar:
	.long	0
	.set	._cdddar,subr1
	.text
	.globl	cdddar
cdddar:
	cmpl	r7,r1
	jeql	cdddaret
	cmpl	r9,r1
	jgtr	cdddarer
	movl	car(r1),r1
	cmpl	r7,r1
	jeql	cdddaret
	cmpl	r9,r1
	jgtr	cdddarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdddaret
	cmpl	r9,r1
	jgtr	cdddarer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cdddaret
	cmpl	r9,r1
	jgtr	cdddarer
	movl	cdr(r1),r1
cdddaret:
	rsb
cdddarer:
	movl	.cdddar,r2
	jmp	errnla
	.data
.cddddr:
	.long	0
	.set	._cddddr,subr1
	.text
	.globl	cddddr
cddddr:
	cmpl	r7,r1
	jeql	cddddret
	cmpl	r9,r1
	jgtr	cddddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddddret
	cmpl	r9,r1
	jgtr	cddddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddddret
	cmpl	r9,r1
	jgtr	cddddrer
	movl	cdr(r1),r1
	cmpl	r7,r1
	jeql	cddddret
	cmpl	r9,r1
	jgtr	cddddrer
	movl	cdr(r1),r1
cddddret:
	rsb
cddddrer:
	movl	.cddddr,r2
	jmp	errnla
