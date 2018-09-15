  xrefoff
 ttl 'fast floating point - desk calculator driver'
***************************************
* (c) copyright 1980 by motorola inc. *
***************************************
 
desc1  equ *
	dc.b '******************************************',$0a
	dc.b '* this is a desk-calculator diagnostic   *',$0a
	dc.b '* program for the mc68344 rom fast float-*',$0a
	dc.b '* ing point subroutines. the input       *',$0a
	dc.b '* format is normal fortran expression    *',$0a
	dc.b '* syntax with an optional assignment     *',$0a
	dc.b '* statement for the only variables "x"   *',$0a
	dc.b '* and "y".  the variables can be used in *',$0a
	dc.b '* expressions.  no blanks allowed.       *',$0a
	dc.b '*                                        *',$0a
	dc.b '* a floating point value may be entirely *',$0a
	dc.b '* specified in hexadecimal.  this is done*',$0a
	dc.b '* by following a $ with eight hex digits.*',$0a
	dc.b '*                                        *',$0a
	dc.b '* a special diadic operator "Q" performs *',$0a
	dc.b '* a comparison between two values report-*',$0a
	dc.b '* ing all valid branch conditions.       *',$0a
	dc.b '*                                        *',$0a
	dc.b '* function "tst( )" returns a ccr result *',$0a
	dc.b '* for plus, minus, nan and zero.         *',$0a
	dc.b '*                                        *',$0a
	dc.b '* function "neg( )" operates exactly like*',$0a
	dc.b '* the prefix minus sign.                 *',$0a
	dc.b '*                                        *',$0a
	dc.b '* rounding (power of ten) is set with    *',$0a
	dc.b '* an "r=value" statement (default -100). *',$0a
	dc.b '* for example, r=-1 rounds tenths to     *',$0a
	dc.b '* units.                                 *',$0a
	dc.b '*                                        *',$0a
	dc.b '*   examples:      x=32.5                *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  sqrt(5)*2             *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  x                     *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  y=abs(x)**.2+3.4      *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  10e-4*cos(y-sin(x))   *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  x=10e10+y             *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  $7f80012f+atan(2)     *',$0a
	dc.b '*                                        *',$0a
	dc.b '*                  3.1Qx                 *',$0a
	dc.b '*                                        *',$0a
	dc.b '*   functions available:  sqrt log exp   *',$0a
	dc.b '*      sin cos tan atan sinh cosh tanh   *',$0a
	dc.b '*      power (via ** operator) abs neg   *',$0a
	dc.b '*      int (convert to integer)          *',$0a
	dc.b '*                                        *',$0a
	dc.b '******************************************',$0a
	dc.b $0a
desc2 equ *
	dc.w    0
* ?          opt       frs
 
 extern      ffpafp,ffpfpa,ffpsqrt,ffparnd,ffpfpi,ffpifp subroutines
 extern      ffpadd,ffpsub,ffpdiv,ffpmul,ffpcmp,ffptst,ffpabs,ffpneg
 extern      ffpsin,ffpcos,ffptan,ffpexp,ffplog,ffppwr,ffpatan
 extern      ffpsinh,ffpcosh,ffptanh
 extern      _read,_write,_exit,_signal
 entry      ffpcalc,_main
SIGZERO equ  17
SIGOVER equ  19
 

* function table
fnctntbl dc.w      0                   vanilla parenthesis
         dc.l      '(       ',fparen
         dc.w      4                   square root
         dc.l      'sqrt(   ',fsqrt
         dc.w      3                   sine
         dc.l      'sin(    ',ffpsin
         dc.w      3                   cosine
         dc.l      'cos(    ',ffpcos
         dc.w      3                   tangent
         dc.l      'tan(    ',ffptan
         dc.w      3                   exponent
         dc.l      'exp(    ',ffpexp
         dc.w      3                   logorithm
         dc.l      'log(    ',ffplog
         dc.w      4                   arctangent
         dc.l      'atan(   ',ffpatan
         dc.w      4                   hyperbolic sine
         dc.l      'sinh(   ',ffpsinh
         dc.w      4                   hyperbolic cosine
         dc.l      'cosh(   ',ffpcosh
         dc.w      4                   hyperbolic tangent
         dc.l      'tanh(   ',ffptanh
         dc.w      3                   tst
         dc.l      'tst(    ',ffptst
         dc.w      3                   negate
         dc.l      'neg(    ',ffpneg
         dc.w      3                   absolute value
         dc.l      'abs(    ',ffpabs
         dc.w      3                   integer
         dc.l      'int(    ',fint
 
* numfun   equ       (*-fnctntbl)/12
numfun   equ       15
  text
 
******************************************
* fast floating point     calculator     *
*      version 1.1    4/10/81            *
******************************************
 
*
* at label 'input' the stack points to the input buffer
*
* during calculations a6 holds the above value for error aborts
*
 
_main    equ  *
ffpcalc  lea       stack,a7  load stack
 
         bsr       msg                 put blank line before heading
         dc.l      '        '          blank line
         lea       startm,a0         send startup message
         lea       startme,a1        message end
         bsr       put                 call put subroutine
         lea       startm2,a0         send startup message
         lea       startm2e,a1        message end
         bsr       put                 call put subroutine
	 lea       desc1,a0         send startup message
	 lea       desc2,a1        message end
         bsr       put                 call put subroutine
         bsr       msg       blank line after heading
         dc.l      '        '          blank line
 
         lea       0-80(a7),a7 allocate buffer
         move.l    a7,a6     setup error recovery frame pointer
 
*        move.l    #26,d0    setup exception vectors
*        lea       exctbl,a0 table address
*        trap      #1        take exceptions for zero divide and overflow
*        beq.s     input
*        trap      #15       error if something wrong
	 move.l    #errorzdv,-(a7)
	 move.w    #SIGZERO,-(a7)
	 jsr       _signal
	 addq.l    #6,a7
	 move.l    #errorv,-(a7)
	 move.w    #SIGOVER,-(a7)
	 jsr       _signal
	 addq.l    #6,a7
 
input    bsr       msg       issue prompt
         dc.l      'ready'
         move.l    a7,a0     setup start addr
         lea       79(a7),a1 and ending
         bsr       get       read a line of input
         clr.b     ovfset    clear overflow status
         clr.b     zdvset    clear zero divide status
         move.w    (a7),d0   get first two bytes
* test for 'quit' command
         cmpi.b     #'q',(a7) Q "q" command for quit
         beq       quit
* test for 'x=' assignment
         lea       2(a7),a0  default assignment scan position
         cmpi.w     #'x=',d0  Q assignment
         bne.s     notxasg   branch if not
         bsr       intrp     interpret the expression
         move.l    d7,x      save in x
         bra.s     calprnt   print out its value
* test for 'y=' assignment
notxasg  cmpi.w     #'y=',d0  Q y assignment
         bne.s     notasg    br not assignment
         bsr       intrp     interpret the expression
         move.l    d7,y      save in y
         bra.s     calprnt    print out its value
* test for 'r=' rounding assignment
notasg   cmpi.w     #'r=',d0  Q round set
         bne.s     notrnd    branch not
         bsr       intrp     interpret expression
         move.l    d7,d1     save float value
	 jsr       ffpfpi    to integer
         move.l    d7,round  save rounding factor
         move.l    d1,d7     restore float value
         bra.s     calprnt   and print it out
notrnd   lea       (a7),a0   start scan at front
         bsr       intrp     interpret expression
         bra.s     calprnt   and print it out
 
* display result back in ascii
hextbl   dc.l      '0123456789abcdef'
 
calprnt  tst.b     ovfset    Q overflow detected
         beq.s     calnov    branch if not
         bsr       msg       give overflow indicator
         dc.l      'overflow'  eye-catcher
calnov   tst.b     zdvset    Q zero divide detected
         beq.s     calnoz    branch if not
         bsr       msg       show zero divide found
         dc.l      'zero div'
calnoz   lea       0-8(a7),a7 setup hex translate area
         move.l    #7,d0     loop 8 times
         move.l    d7,d6     copy floating value
tohex    move.b    d6,d1     to next four bits
	 and.w     #$f,d1    -- %1111,d1 strip rest
         move.b    hextbl(d1),0(a7,d0) convert to hex
         lsr.l     #4,d6     to next hex digit
         dbra      d0,tohex  loop until done
         move.w    #'  ',-(a7) blank seperator
	 jsr       ffpfpa    back to ascii
         move.l    round,d6  setup rounding factor
	 jsr       ffparnd   round appropriatley
         lea       (a7),a0   setup put
         lea       23(a0),a1 arguments
         move.b    #$08,iosblk+3 force unformatted mode to inhibit cr
         bsr       put       send out result of conversion
         clr.b     iosblk+3  turn unformatted mode back off
         lea       24(a7),a7 delete work area
         move.w    ccrsave,ccr restore ccr for branch display
         bsr       dispccr   display all branch conditions valid
         bra       input     back for more
 
* invalid response - target the character in error (a0->)
errorsyn move.l    a6,a7     restore stack back to normal
         suba.l     a7,a0     find offset to bad character
         move.l    a0,d0     pad with blanks
loop2pd  move.b    #' ',0(a7,d0) blank out front end
         dbra      d0,loop2pd loop until done
         move.b    #'^',0(a7,a0) set pointer
	 move.b    #$0a,1(a7,a0) set end of line
         lea       1(a7,a0),a1 end of text
         move.l    a7,a0     start of text
         bsr       put       place out flag
         bsr       msg       send message
         dc.l      'syntax'
         bra       input
 
* negative square root error
errorsqt move.l    a6,a7     restore stack
         bsr       msg       send msg
         dc.l      'neg sqrt'          eye-catcher
         bra       calprnt   and print result
 
* divide by zero error
errorzdv move.b    #1,zdvset signal divide by zero detected
	 move.l    #errorzdv,-(a7)
	 move.w    #SIGZERO,-(a7)
	 jsr       _signal
	 addq.l    #6,a7
	 rts       and continue with divide (overflow mode)
 
* overflow error
errorv   move.b    #1,ovfset signal overflow detected
	 move.l    #errorv,-(a7)
	 move.w    #SIGOVER,-(a7)
	 jsr       _signal
	 addq.l    #6,a7
	 rts       and continue with next operation
 
 
****************************
* interpret the expression *
* output - d7              *
* if errors occur will not *
* return to caller         *
****************************
 
intrp    cmpi.b     #$0a,(a0)           Q null expression
         beq       errorsyn            ***syntax error***
         bsr.s     eval                evaulate as an expression
	 cmpi.b     #$0a,(a0)           Q expression end at the cr
         bne       errorsyn            ***syntax error***
         rts                           return to caller
 
****************************
* sub expression evaluator *
*       subroutine         *
* output: d7 - result      *
*  if errors will not      *
*  return to caller.       *
****************************
eval     bsr       term      obtain first term
evalnxt  move.w    sr,ccrsave save last function ccr status
         trapv               set overflow had bit
         move.l    d7,-(a7)  save first argument on stack
* test for diadic operator and one more term
         move.b    (a0)+,d0  load next character
         cmpi.b     #'+',d0    Q add
         bne.s     notadd    branch if not
*  "+" add operator
	 bsr       term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  reload arg1 for arg2
         jsr       ffpadd    add them
         bra.s     evalnxt   try for another term
notadd   cmpi.b     #'-',d0    Q subtract
         bne.s     notsub    branch if not
*  "-" subtract operator
	 bsr       term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  reload arg1
         exg     d6,d7     must swap for correct order
         jsr       ffpsub    subtract them
         bra.s     evalnxt   try for another term
notsub   cmpi.b     #'*',d0    Q multiply
         bne.s     notmult   branch if not
         cmpi.b     #'*',(a0) Q power function
         bne.s     ismult    branch no, is multiply
*  "**" power operator
         adda.l     #1,a0     strip off second asterisk
	 bsr      term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  reload base value
         exg     d6,d7     swap for function call
         jsr       ffppwr    perform power function
         bra.s     evalnxt   try another item
*  "*" multiply operator
ismult   bsr     term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  reload arg1
         jsr       ffpmul    multiply them
         bra.s     evalnxt   try another term
notmult  cmpi.b     #'/',d0    Q divide
         bne.s     notdiv    branch if not divide
*  "/" divide operator
	 bsr     term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  reload arg1
         exg     d6,d7     swap args (arg2 into arg1)
         jsr       ffpdiv    divide them
         bra       evalnxt   try for another term
notdiv   cmpi.b     #'Q',d0   Q test for compare operator
         bne.s     exprtn    return if not
*  "Q" comparison operator
	 bsr     term      get next term
         trapv               check overflow
         move.l    (a7)+,d6  restore first argument
         jsr       ffpcmp    do ieee format comparison
         bsr       dispcmp   display ccr for comparison
         move.l    a6,a7     restore stack to top level
         bra       input     and perform next request
 
exprtn   suba.l     #1,a0     back to current position
         move.l    (a7)+,d7  restore unused argument
         rts                 return to caller
 
 
*************************
* obtain a term (value) *
*  output: d7 - value   *
*          v - overflow *
* will not return to    *
* caller if error       *
*************************
* scan function table for match
term     lea       fnctntbl,a1 setup table address
         move.l    #numfun,d1 count table entries
fncnxt   move.w    (a1)+,d2  prepare compare length
         move.l    a1,a2     prepare entry string pointer
         move.l    a0,a3     with input scan string
fncmpr   cmpm.b     (a2)+,(a3)+ Q still valid match
         dbne      d2,fncmpr loop if so
         beq.s     gotfunc   branch for match
         lea       12(a1),a1 to next entry position
         dbra      d1,fncnxt loop if more to check
         bra       notfunc   branch not a function
 
gotfunc  move.l    8(a1),-(a7) save entry point address
         move.l    a3,a0     bump scan to after paren
         bsr       eval      obtain inside expression
         move.l    (a7)+,a1  load function routine address
         jsr       (a1)      call appropriate routine
         move.w    sr,-(a7)  save return code
         cmpi.b     #')',(a0)+  are theyQ
         bne       errorsyn  branch syntax error if not
         rtr                 return with condition code
 
* parenthesis expression
fparen   rts       no function required
 
* square root call
fsqrt    jsr       ffpsqrt   call square root
         bvs       errorsqt  branch if negative argument attempted
         rts                 return to caller
 
* integer function
fint     move.l    d7,-(a7)  save original argument in case of overflow
         jsr       ffpfpi    convert to integer
         bvc.s     fintok    branch if no overflow detected
* overflow - return original argument since has no fraction anyway
         move.l    (a7)+,d7  return original argument
         tst.b     d7        set ccr properly
         rts                 return to caller
* no overflow - convert back
fintok   jsr       ffpifp    back to float
         adda.l     #4,a7     delete saved argument from stack
         rts                 and return
 
* test for variables or infix + and -
notfunc  move.b    (a0)+,d0  load next character
         move.l    x,d7      default to x
         cmpi.b     #'x',d0   is itQ
         beq.s     termrtn   return if so
         move.l    y,d7      default to y
         cmpi.b     #'y',d0   Q is it
         beq.s     termrtn   return if so
         cmpi.b     #'+',d0    test plus
         beq       notfunc   br yes to skip it
         cmpi.b     #'-',d0    infix minus
         bne.s     notminus  no, try somthing else
* if this is a negative ascii value, we must let it be converted since
* a positive value has less range than a negative one
         cmpi.b     #'.',(a0)  Q numeric ascii follows
         beq.s     notminus  yes, let conversion handle it properly
         cmpi.b     #'0',(a0)  Q ascii number
         bls.s     doneg     nope, complement the following value
         cmpi.b     #'9',(a0)  Q ascii number
         bls.s     notminus   yep, allow proper conversion
doneg    bsr       term      obtain term
         jsr       ffpneg    negate the result
termrtn  rts                 return to caller
 
* check for direct hexadecimal specification
notminus cmpi.b     #'$',d0   Q hexadecimal here
         bne.s     nothex    branch if not
         clr.l     d7        start building the value
prshex   move.b    (a0),d0   load next character
         cmpi.b     #'0',d0   Q less than ascii zero
         bcs.s     termrtn   return with result in d7 if so
         cmpi.b     #'9',d0   Q greater than nine
         bls.s     gothex    branch not, is a valid decimal digit
         cmpi.b     #'a',d0   Q less than ascii "a"
         bcs.s     termrtn   return result if not hex digit
         cmpi.b     #'f',d0   Q greater than "f"
         bhi.s     termrtn   return result if not hex digit
         addi.b     #9,d0     re-map into binary range
gothex   adda.l     #1,a0     bump past this character
         and.b     #$f,d0    isolate hex digit
         cmpi.l     #$0fffffff,d7 Q will another digit overflow
         bhi       errorsyn  yes, branch for syntax error
         lsl.l     #4,d7     shift over safely for next digit
         or.b      d0,d7     or new digit in low byte
         bra.s     prshex    go parse another hex digit
 
 
* attempt to treat it as an ascii number
nothex   suba.l     #1,a0     attempt ascii input value
         jsr       ffpafp    attempt ascii to float
         bcs       errorsyn  syntax error if no good
         rts                 return if got value
 
************
* end test *
************
quit     bsr       msg       issue done message
         dc.l      '  done'
         move.l    #15,d0    terminate task
	 jsr       _exit     here
 
 
*   *
*   * display the ccr branch conditions subroutine
*   *   everything transparent (including ccr)
*   *
 
dispcmp  movem.l   d0-d1/a0-a1,-(a7) save work registers on the stack
         move.w    sr,d0     save condition code register for tests
         move.l    a7,a1     stack frame pointer
         move.w    #'gt',-(a7)  default condition
         move.w    d0,ccr    reset ccr
         bgt.s     dispgt    branch correct
         move.w    #'le',(a7) change
dispgt   move.l    #'ge  ',-(a7)  default condition
         move.w    d0,ccr    reset ccr
         bge.s     disppl    branch correct
         move.w    #'lt',(a7) change
         bra.s     disppl    enter common code
 
* regular display
dispccr  movem.l   d0-d1/a0-a1,-(a7) save work registers on the stack
         move.w    sr,d0     save condition code register for tests
         move.l    a7,a1     stack frame pointer
* test for overflow (v set)
         bvc.s     notvs     branch not overflow
         move.l    #'flow',-(a7) setup overflow eye-catcher
         move.l    #'over',-(a7) ditto
* setup arithmetic comparisons
notvs    move.l    #'pl  ',-(a7)  default condition
         move.w    d0,ccr    reset ccr
         bpl.s     disppl    branch correct
         move.w    #'mi',(a7) change
disppl   move.l    #'eq  ',-(a7)  default condition
         move.w    d0,ccr    reset ccr
         beq.s     dispeq    branch correct
         move.w    #'ne',(a7) change
dispeq   move.l    #'    ',-(a7) add blanks to beginning
         move.l    a7,a0     start of string print
         suba.l     #1,a1     point to last character
	 bsr     put       send string to console
         lea       1(a1),a7  restore stack back
         move.w    d0,ccr  restore ccr
         movem.l   (a7)+,d0-d1/a0-a1 restore registers
         rts                 return to caller
 
*   *
*   * msg subroutine
*   *  input: (sp) point to eight byte text following bsr/jsr
*   *
msg      movem.l   d0/a0/a1,-(a7) save regs
         move.l    3*4(a7),a0 load return pointer
         lea       7(a0),a1   point to buffer end
         bsr     put       issue ios call
         movem.l   (a7)+,d0/a0/a1 reload registers
         addi.l     #8,(a7)   adjust return address
         rts                 return to caller
 
*   *
*   * put subroutine
*   *  input: a0->text start, a1->text end
*   *
put     movem.l   d0-d3/a0-a3,-(a7) save regs
 suba.l a0,a1
 addq.l #1,a1
 move   a1,-(a7)
 move.l a0,-(a7)
 move   #1,-(a7)

 jsr    _write
 addq   #8,a7
 tst.b  iosblk+3
 bne    put1
 move   #1,-(a7)
 pea    nl
 move   #1,-(a7)
 jsr    _write
 addq   #8,a7
put1    movem.l   (a7)+,d0-d3/a0-a3  reload registers
	rts                 return to caller
nl  dc.b  $0a

 
*   *
*   * get subroutine
*   *   input: a0->buffer start, a1->last of buffer
*   *
get      movem.l   d0/a0/a1,-(a7) save regs
	 suba.l a0,a1
	 move   a1,-(a7)
	 move.l a0,-(a7)
	 move   #0,-(a7)
	 jsr    _read
	 addq   #8,a7
         movem.l   (a7)+,d0/a0/a1 restore registers
         rts                 return to caller
	data
iosblk   dc.l      0
* variables
x        dc.l      0
y        dc.l      0
ccrsave  dc.w      0
round    dc.l      0-100      rounding factor
 
* overflow flags
ovfset   dc.b      0         overflow returned flag
zdvset   dc.b      0         zero divide set
 
* exception vector substitution
exctbl   dc.l      0,0,0,errorzdv,0,errorv,0,0,0
 
* startup message
startm   dc.w      '  fast floating point calculator'
startme  dc.w     0
startm2  dc.w      '(c) copyright 1980 by motorola inc.'
startm2e dc.w      0
 
* program stack
  bss 
                    ds  100 0      stack area
stack    equ       *
 
         end       ffpcalc
