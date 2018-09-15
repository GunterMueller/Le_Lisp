  nolist 
  xrefoff
 ttl 'fast floating point ascii to float (ffpafp)'
************************************
* (c) copyright 1980 motorla inc.  *
************************************
 
***********************************************************
*                        ffpafp                           *
*                    ascii to float                       *
*                                                         *
*      input:  a0 - pointer to ascii string of a format   *
*                   described below                       *
*                                                         *
*      output: d7 - fast floating point equivalent        *
*              a0 - points to the character which         *
*                   terminated the scan                   *
*                                                         *
*      condition codes:                                   *
*                n - set if result is negative            *
*                z - set if result is zero                *
*                v - set if result overflowed             *
*                c - set if invalid format detected       *
*                x - undefined                            *
*                                                         *
*      registers d3 thru d6 are volatile                  *
*                                                         *
*      code size: 246 bytes     stack work: 8 bytes       *
*                                                         *
*      input format:                                      *
*                                                         *
*     {sign}{digits}{'.'}{digits}{'e'}{sign}{digits}      *
*     <*********mantissa********><*****exponent****>      *
*                                                         *
*                   syntax rules                          *
*          both signs are optional and are '+' or '-'.    *
*          the mantissa must be present.                  *
*          the exponent need not be present.              *
*          the mantissa may lead with a decimal point.    *
*          the mantissa need not have a decimal point.    *
*                                                         *
*      examples:  all of these values represent the       *
*                 number one-hundred-twenty.              *
*                                                         *
*                       120            .120e3             *
*                       120.          +.120e+03           *
*                      +120.          0.000120e6          *
*                   0000120.00  1200000e-4                *
*                               1200000.00e-0004          *
*                                                         *
*      floating point range:                              *
*                                                         *
*          fast floating point supports the value zero    *
*          and non-zero values within the following       *
*          bounds -                                       *
*                                                         *
*                   18                             -20    *
*    9.22337177 x 10   > +number >  5.42101070 x 10       *
*                                                         *
*                   18                             -20    *
*   -9.22337177 x 10   > -number > -2.71050535 x 10       *
*                                                         *
*      precision:                                         *
*                                                         *
*          this conversion results in a 24 bit precision  *
*          with guaranteed error less than or equal to    *
*          one-half least significant bit.                *
*                                                         *
*                                                         *
*      notes:                                             *
*          1) this routine calls the dual-binary to float *
*             routine and can be used as an illustration  *
*             of how to 'front-end' that routine with     *
*             a customized scanner.                       *
*          2) underflows return a zero without any        *
*             indicators set.                             *
*          3) overflows will return the maximum value     *
*             possible with proper sign and the 'v' bit   *
*             set in the ccr.                             *
*          4) if the 'c' bit in the ccr indicates an      *
*             invalid pattern detected, then a0 will      *
*             point to the invalid character.             *
*                                                         *
*      logic summary:                                     *
*                                                         *
*          a) process leading sign                        *
*          b) process pre-decimalpoint digits and         *
*             increment 10 power bias for each            *
*             digit bypassed due to 32 bit overflow       *
*          c) process post-decimalpoint digits            *
*             decrementing the 10 power bias for each     *
*          d) process the exponent                        *
*          e) add the 10 power bias to the exponent       *
*          f) call 'ffpdbf' routine to finish conversion  *
*                                                         *
*   times: (8 mhz no wait states)                         *
*          374 microseconds converting the string         *
*                                                         *
*                                                         *
***********************************************************


*ffpafp idnt    1,1  ffp ascii to float
 
* ?          opt       pcs
 
 entry    ffpafp    entry point
 
 extern     ffpdbf,ffpcpyrt
 
 
ffpafp   move.l    #0,d7     clear mantissa build
         move.l    #0,d6     clear sign+base10 build
 
* check for leading sign
         bsr       fpanxt    obtain next character
         beq.s     fpanmb    branch digit found
         bcs.s     fpanos    branch no sign encountered
 
* leading sign encountered
         cmpi.b     #'-',d5   compare for minus
         seq     d6        set ones if so
         swap    d6        sign to high word in d6
 
* test for digit or period
         bsr       fpanxt    obtain next character
         beq.s     fpanmb    branch digit to build mantissa
fpanos   cmpi.b     #'.',d5   Q leading decimalpoint
         bne.s     fpabad    branch invalid pattern if not
 
* insure at least one digit
         bsr       fpanxt    obtain next character
         beq.s     fpadof    branch if fraction digit
 
* invalid pattern detected
fpabad   suba.l     #1,a0 point to invalid character
*        or.w      #$00001,ccr force carry bit on
         dc.l      $003c0001 ****assembler error*****
         rts                 return to caller
 
* pre-decimalpoint mantissa build
fpanxd   bsr       fpanxt    next character
         bne.s     fpanod    branch not a digit
fpanmb   bsr.s     fpax10    multiply times ten
         bcc.s     fpanxd    loop for more digits
 
* pre-decimalpoint mantissa overflow, count till end or decimal reached
fpamov   addi.w     #1,d6     increment ten power by one
	 bsr       fpanxt    obtain next pattern
         beq.s     fpamov    loop until non-digit
         cmpi.b     #'.',d5   Q decimal point reached
         bne.s     fpatse    no, no check for exponent
 
* flush remaining fractional digits
fpasrd   bsr.s     fpanxt    next character
         beq.s     fpasrd    ignore it if still digit
fpatse   cmpi.b    #'e',d5   Q exponent here
	 beq.s     e         no, finished - go convert
	 cmpi.b    #'E',d5
	 bne.s     fpacnv
 
* now process the exponent
e:       bsr.s     fpanxt    obtain first digit
         beq.s     fpante    branch got it
         bcs.s     fpabad    branch invalid format, no sign or digits
         rol.l     #8,d6     high byte of d6 into low
         cmpi.b     #'-',d5   Q minus sign
         seq     d6        set ones or zero
         ror.l     #8,d6     d6 high byte is exponents sign
         bsr.s     fpanxt    now to first digit
         bne.s     fpabad    branch invalid - digit expected
 
* process exponent's digits
fpante   move.w    d5,d4     copy digit just loaded
fpanxe   bsr.s     fpanxt    examine next character
         bne.s     fpafne    branch end of exponent
         mulu    #10,d4    previous value times ten
         cmpi.w     #2000,d4  Q too large
         bhi.s     fpabad    branch exponent way off base
         add.w     d5,d4     add latest digit
         bra.s     fpanxe    loop for next character
 
* adjust for sign and add to original index
fpafne   tst.l     d6        Q was exponent negative
         bpl.s     fpaadp    branch if so
         neg.w     d4        convert to negative value
fpaadp   add.w     d4,d6     final result
fpacnv   suba.l     #1,a0 point to termination character
	 jmp       ffpdbf    now convert to float
 
* pre-decimalpoint non-digit encountered
fpanod   cmpi.b     #'.',d5   Q decimal point here
         bne.s     fpatse    nope, try for the 'e'
 
* post-decimalpoint processing
fpadpn   bsr.s     fpanxt    obtain next character
         bne.s     fpatse    not a digit, test for 'e'
fpadof   bsr.s     fpax10    times ten previous value
         bcs.s     fpasrd    flush if overflow now
         subi.w     #1,d6     adjust 10 power bias
         bra.s     fpadpn    and to next character
 
*   *
*   * fpax10 subroutine - process next digit
*   *  output: c=0 no overflow, c=1 overflow (d7 unaltered)
*   *
fpax10   move.l    d7,d3     copy value
         lsl.l     #1,d3     times two
         bcs.s     fpaxrt    return if overflow
         lsl.l     #1,d3     times four
         bcs.s     fpaxrt    return if overflow
         lsl.l     #1,d3     times eight
         bcs.s     fpaxrt    return if overflow
         add.l     d7,d3     add one to make x 9
         bcs.s     fpaxrt    return if overflow
         add.l     d7,d3     add one to make x 10
         bcs.s     fpaxrt    return if overflow
         add.l     d5,d3     add new units digit
         bcs.s     fpaxrt    return if overflow
         move.l    d3,d7     update result
fpaxrt   rts                 return to caller
 
 
*
* fpanxt subroutine - return next input pattern
*
*    input:  a0
*
*    output:  a0 incremented by one
*             if z=1 then digit encountered and d5.l set to binary value
*             if z=0 then d6.b set to character encountered
*                         and c=0 if plus or minus sign
*                             c=1 if not plus or minus sign
*
 
fpanxt   moveq     #0,d5     zero return register
         move.b    (a0)+,d5  load character
         cmpi.b     #'+',d5   Q plus sign
         beq.s     fpasgn    branch if sign
         cmpi.b     #'-',d5   Q minus sign
         beq.s     fpasgn    branch if sign
         cmpi.b     #'0',d5   Q lower than a digit
         bcs.s     fpaotr    branch if non-signdigit
         cmpi.b     #'9',d5   Q higher than a digit
         bhi.s     fpaotr    branch if non-signdigit
* it is a digit
         and.b     #$0f,d5   to binary
*        move.w    #$0004,ccr set z=1 for digit
         dc.l      $44fc0004 ***assembler error***
         rts                 return to caller
* it is a sign
*fpasgn   move.w    #$0000,ccr set z=0 and c=0
fpasgn   dc.l      $44fc0000 ***assembler error***
         rts                 return to caller
* it is neither sign nor digit
*fpaotr   move.w    #$0001,ccr set z=0 and c=1
fpaotr   dc.l      $44fc0001 ***assembler error***
         rts       return to caller
 
         end
