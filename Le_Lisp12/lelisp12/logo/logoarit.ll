;=====================================================================
;
;    Logo-Lisp	:  LOGOARIT   l'arithmetique
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;=====================================================================
 
 
;  ARITHMETIQUE INFIXEE
 
; l'arithmetique est analysee en n'utilisant pas de pile d'operandes
 
(de *tnum (*exp)
  ; <exp> ::= (<terme> | <terme signe>) (<terme2>)*
  ;-------
   (*terme2? (*terme? *exp) (car *ligne))))
 
(de *terme2? (*a1 *fonc)
   ; <terme2> ::= (+ | -) <terme>
   ;----------
   (ifn (memq *fonc '(+ -))
       *a1
       (self ((nextl *ligne) *a1 (*terme? (nextl *ligne)))
	     (car *ligne))
      ))))))
 
(de *terme? (*a1)
   ; <terme> ::= <opde> (<facteur>)*
   ;---------
   (*facteur? (*opde? *a1) (car *ligne)))
 
(de *opde? (*a1)  ;nombre, variable, fonction ou expression parenthesee
   ; <opde> ::= (variable num | nombre | fonction | (<exp>))
   ; ------
   (selectq *a1
       ; manque un operande
     (nil (*l-err *fonc 'erni 1))
     (-  (-  (*opde? (nextl *ligne))))
     (+  (*opde? (nextl *ligne)))
     (t (or (numberp *a1);nombre
	; expression parenthesee
	 (if (and (listp *a1) (or (numberp (car *a1)) (memq (car *a1) '(- +))))
	     (let ((*ligne (cdr *a1))) (*eval-lig (car *a1)))
	     (*eval-lig *a1))))))
 
(de *facteur? (*a1 *fonc)
   ; <facteur> ::= ( * | // | \) <opde>
   (selectq *fonc
      ((* // \)
	 ((nextl *ligne) *a1 (*opde? (nextl *ligne))))
      (t *a1))))
 
;   LES OPERATEURS  PREFIXES
 
(valfn 'somme (valfn '+))
(typefn 'somme (typefn '+))
 
(valfn 'difference (valfn '-))
(typefn 'difference (typefn '-))
 
(valfn 'produit (valfn '*))
(typefn 'produit (typefn '*))
 
(valfn 'quotient (valfn '//))
(typefn 'quotient (typefn '//))
 
(valfn 'reste (valfn '\))
(typefn 'reste (typefn '\))
 
(de hasard ()
    (scale 100
	   (execute [#$ED #$5F	    ; LD   A,R
		     #$6F	    ; LD   L,A
		     #$26 #$00 ])   ; LD   H,00
	   128 ))
 
(de nombre? (*a1)
   (if (numberp *a1) 'vrai 'faux))
 

