;=====================================================================
;
;    Logo-Lisp	:  LOGOIMP   primitives d'impression
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;=====================================================================
 
(de imp (*a1)	 ;pretty d'une procedure
    (ifn (memq *a1 procedures) (print *a1 '| n'est pas une procedure|)
			       (*improc *a1))
    nil)
 
(de *improc (*a1)
   (unless (symbolp *a1)
       (output)   ;si on vient de SAUVE il faut fermer le fichier de sortie
       (*l-err *fonc 'ernva *a1))
   (let ((*l (valfn *a1)) (*a2 (- (ptype *a1) 10)))
       ; entete
	(prin 'pour '| | *a1 '| |)
	(ifn (getdef *a1) (terpri)
	   ; parametres
	     (*impar *a2 (car *l))
	   ; variables locales
	     (*imploc (- (length (car *l)) *a2) (nthcdr *a2 (car *l)))
	     (nextl *l)
	   ; corps
	     (mapc '*impcorps (cdar *l)))
	(print 'fin) (terpri))))
 
(de imptout ()	 ;pretty de toutes les procedures de l'espace de travail
   (mapc 'im (cdr procedures)))
 
(de impt ()	;titres de toutes les procedures de l'espace de travail
   (mapc (lambda (*a1)
	      (prin 'pour '| | *a1 '| |)
	      (*impar (- (ptype *a1) 10) (car (valfn *a1))))
	 (cdr procedures)))
 
(de *impc (*a1 *a2)
   (prin *a1 *a2 '| |))
 
(de *impar (*n *a1)  ;impression des parametres
   (repeat *n (*impc  '/: (nextl *a1)))
   (terpri))
 
(de *imploc (*n *l)  ;impression des variables locales
     (cond
	 ((= *n 1) (prin 'local '| |) (*impc '/" (car *l)) (terpri))
	 ((> *n 1) (prin '|(| 'local '| |)
	      (repeat  *n (*impc '/" (nextl *l)))
	      (print '|)|))
))))
 
(de *l-prin (*a1)   ;impression d'une ligne
   (cond
       ((nlistp *a1) (prin *a1 '| |))
       ((eq (car *a1) 'list)
	 (prin '/[) (mapc '*l-prin (cdr *a1)) (prin '/]))
       ((memq (car *a1) '(/: /")) (*impc (car *a1) (cadr *a1)))
       (t (prin '/() (mapc '*l-prin *a1) (prin '/)))))))))
 
(de *impcorps (*a1) ;impression du corps de procedure
   (mapc '*l-prin *a1)
   (terpri))
 

