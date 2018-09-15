  nolist 
  xrefoff
 ttl 'fast floating point ascii round routine (ffparnd)'
****************************************
* (c) copyright 1981 by motorola inc.  *
****************************************
 
***********************************************
*                  ffparnd                    *
*           ascii round subroutine            *
*                                             *
*  this routine is normally called after the  *
*  'ffpfpa' float to ascii routine and acts   *
*  upon its results.                          *
*                                             *
*  input:  d6 - rounding magnitude in binary  *
*               as explained below.           *
*          d7 - binary representation of the  *
*               base 10 exponent.             *
*          sp ->  return address and output   *
*                 from ffpfpa routine         *
*                                             *
*  output: the ascii value on the stack is    *
*          correctly rounded                  *
*                                             *
*          the condition codes are undefined  *
*                                             *
*          all registers transparent          *
*                                             *
*     the rounding precision represents the   *
*     power of ten to which the rounding will *
*     occur.  (i.e. a -2 means round the digit*
*     in the hundredth position for resultant *
*     rounding to tenths.)  a positive value  *
*     indicates rounding to the left of the   *
*     decimal point (0 is units, 1 is tens    *
*     e.t.c.)                                 *
*                                             *
*     the base ten exponent in binary is d7   *
*     from the 'ffpfpa' routine or computed by*
*     the caller.                             *
*                                             *
*     the stack contains the return address   *
*     followed by the ascii number as from    *
*     the 'ffpfpa' routine.  see the          *
*     description of that routine for the     *
*     required format.                        *
*                                             *
*  example:                                   *
*                                             *
*  input pattern '+.98765432+01' = 9.8765432  *
*                                             *
*     round +1 is +.00000000+00 =  0.         *
*     round  0 is +.10000000+02 = 10.         *
*     round -1 is +.10000000+02 = 10.         *
*     round -2 is +.99000000+01 =  9.9        *
*     round -3 is +.98800000+01 =  9.88       *
*     round -6 is +.98765400+01 =  9.87654    *
*                                             *
*  notes:                                     *
*     1) if the rounding digit is to the left *
*        of the most significant digit, a zero*
*        results.  if the rounding digit is to*
*        the right of the least significant   *
*        digit, then no rounding occurs       *
*     2) rounding is handy for eliminating the*
*        dangling '999...' problem common with*
*        float to decimal conversions.        *
*     3) positions from the rounded digit and *
*        to the right are set to zeroes.      *
*     4) the exponent may be affected.        *
*     5) rounding is forced by adding five.   *
*     6) the binary exponent in d7 may be     *
*        pre-biased by the caller to provide  *
*        enhanced editing control.            *
*     7) the return address is removed from   *
*        the stack upon exit.                 *
***********************************************


*ffparnd  idnt      1,1       ffp ascii round subroutine
 
 entry      ffparnd   entry point
 
 
ffparnd  movem.l   d7/a0,-(a7)         save work on stack
         sub.w     d6,d7               compute rounding digit offset
         ble.s     fafzro              branch if larger than value
         cmpi.w     #8,d7               insure not past last digit
         bhi       fartn               return if so
         lea       8+4+1(a7,d7),a0       point to rounding digit
         cmpi.b     #'5',(a0)           Q must round up
         bcc.s     fadornd             yep - go round
         subi.w     #1,d7               Q round leading digit zero (d7=1)
	 bne.l     fazerol             nope, just zero out
fafzro   lea       8+4+2(a7),a0        force zeroes all the way across
         move.l    #'e+00',8+4+10(a7)  force zero exponent
         move.b    #'+',8+4(a7)        zero is always positive
         bra.s     fazerol            zero mantissa then return
 
* round up must occur
fadornd  move.l    a0,-(a7)            save zero start address on stack
facarry  cmpi.b     #'.',-(a0)          Q hit beginning
         beq.s     fashift             yes, must shift down
         addi.b     #1,(a0)             up by one
         cmpi.b     #'9'+1,(a0)         Q past nine
         bne.s     fazero              no, now zero the end
         move.b    #'0',(a0)           force zero for overflow
         bra       facarry             loop for carry
 
* overflow past top digit - shift right and up exponent
fashift  addi.l     #1,(a7)             zero padd starts one lower now
         adda.l     #1,a0               back to leading digit
         move.l    #$31,d7             default first digit ascii one
         swap    d7                  initialize old digit
         move.b    (a0),d7             pre-load current digit
fashftr  swap    d7                  to previous digit
         move.b    d7,(a0)+            store into this position
         move.b    (a0),d7             load up next digit
         cmpi.b     #'e',d7             Q the end
         bne.s     fashftr             no, shift another to the right
 
* increment exponent for shift right
         cmpi.b     #'+',1(a0)          Q positive exponent
         adda.l     #3,a0               point to least exp digit
         bne.s     fangexp             branch negative exponent
         addi.b     #1,(a0)             add one to exponent
         cmpi.b     #'9'+1,(a0)         Q overflow past nine
         bne.s     fazero              no, now zero
         addi.b     #1,-(a0)            carry to next digit
         bra.s     fazero              and now zero end
fangexp  cmpi.w     #'01',-1(a0)        Q going from 0-1 to +0
         bne.s     fangok              branch if not
         move.b    #'+',-2(a0)         change minus to plus
fangok   subi.b     #1,(a0)             subtract one from exponent
         cmpi.b     #'0'-1,(a0)         Q underflow below zero
         bne.s     fazero              no, zero remainder
         subi.b     #1,-(a0)            borrow from next digit
 
* zero the digits past precision required
fazero   move.l    (a7)+,a0            reload saved precision
fazerol  cmpi.b     #'e',(a0)           Q at end
         beq.s     fartn               branch if so
         move.b    #'0',(a0)+          zero next digit
         bra.s     fazerol             and test again
 
* return to the caller
fartn    movem.l   (a7)+,d7/a0         restore registers
         rts                           return to caller
 
         end
