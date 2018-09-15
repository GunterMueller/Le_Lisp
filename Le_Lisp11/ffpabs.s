  nolist 
  xrefoff
 ttl 'fast floating point abs/neg (ffpabs/ffpneg)'
***************************************
* (c) copyright 1981 by motorola inc. *
***************************************
 
*************************************************************
*                     ffpabs                                *
*           fast floating point absolute value              *
*                                                           *
*  input:  d7 - fast floating point argument                *
*                                                           *
*  output: d7 - fast floating point absolute value result   *
*                                                           *
*      condition codes:                                     *
*              n - cleared                                  *
*              z - set if result is zero                    *
*              v - cleared                                  *
*              c - undefined                                *
*              x - undefined                                *
*                                                           *
*               all registers transparent                   *
*                                                           *
*************************************************************


*ffpabs idnt    1,1  ffp abs/neg
 
 entry      ffpabs    fast floating point absolute value
 
 extern    ffpcpyrt        copyright notice
 
 
******************************
* absolute value entry point *
******************************
ffpabs   and.b     #$7f,d7   clear the sign bit
         rts                 and return to the caller


*************************************************************
*                     ffpneg                                *
*           fast floating point negate                      *
*                                                           *
*  input:  d7 - fast floating point argument                *
*                                                           *
*  output: d7 - fast floating point negated result          *
*                                                           *
*      condition codes:                                     *
*              n - set if result is negative                *
*              z - set if result is zero                    *
*              v - cleared                                  *
*              c - undefined                                *
*              x - undefined                                *
*                                                           *
*               all registers transparent                   *
*                                                           *
*************************************************************


 entry      ffpneg    fast floating point negate
 
**********************
* negate entry point *
**********************
ffpneg   tst.b     d7        Q is argument a zero
         beq.s     ffprtn    return if so
         eori.b     #$80,d7   invert the sign bit
ffprtn   rts                 and return to caller
 
         end
