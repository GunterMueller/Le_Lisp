  nolist 
  xrefoff
 ttl 'fast floating point cmp/tst (ffpcmp/ffptst)'
***************************************
* (c) copyright 1981 by motorola inc. *
***************************************
 
*************************************************************
*                      ffpcmp                               *
*              fast floating point compare                  *
*                                                           *
*  input:  d6 - fast floating point argument (source)       *
*          d7 - fast floating point argument (destination)  *
*                                                           *
*  output: condition code reflecting the following branches *
*          for the result of comparing the destination      *
*          minus the source:                                *
*                                                           *
*                  gt - destination greater                 *
*                  ge - destination greater or equal to     *
*                  eq - destination equal                   *
*                  ne - destination not equal               *
*                  lt - destination less than               *
*                  le - destination less than or equal to   *
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


*ffpcmp idnt    1,3  ffp cmp/tst
 
 entry      ffpcmp    fast floating point compare
 
 extern    ffpcpyrt        copyright notice
 
 
***********************
* compare entry point *
***********************
ffpcmp   tst.b     d6        Q first negative
         bpl.s     ffpcp     no first is positive
         tst.b     d7        Q second negative
         bpl.s     ffpcp     no, one is positive
* if both negative then compare must be done backwards
         cmp.b     d7,d6     compare sign and exponent only first
         bne.s     ffpcrtn   return if that is sufficient
         cmp.l     d7,d6     compare reverse order if both negative
         rts                 return to caller
ffpcp    cmp.b     d6,d7     compare sign and exponent only first
         bne.s     ffpcrtn   return if that is sufficient
         cmp.l     d6,d7     no, compare full longwords then
ffpcrtn  rts                 and return to the caller


*************************************************************
*                     ffptst                                *
*           fast floating point test                        *
*                                                           *
*  input:  d7 - fast floating point argument                *
*                                                           *
*  output: condition codes set for the following branches:  *
*                                                           *
*                  eq - argument equals zero                *
*                  ne - argument not equal zero             *
*                  pl - argument is positive (includes zero)*
*                  mi - argument is negative                *
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


 entry      ffptst    fast floating point test
 
********************
* test entry point *
********************
ffptst   tst.b     d7        return tested condition code
         rts                 to caller
 
         end
