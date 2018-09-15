;===============================================================
;
;    Logo-Lisp	:  LOGOEVAL    l'evaluateur  Logo
;
;===============================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      2  place Jussieu	  75005 PARIS
;===============================================================
(setq *arg? nil)
 
(de *l-eval (*ligne *reste)
    (let ((*e1 (nextl *ligne)))
       (cond
	 ((null *e1)
	    (when *reste (*l-eval (car *reste) (cdr *reste))))
	 ((consp *e1)
	    (let ((*e1 (*eval-lig *e1)))
		 (if (and *ligne *e1) (*l-err nil 'er? *e1 '?)
		     (if (and (null *ligne) (null *reste)) *e1
			 (*l-eval *ligne *reste)))))
	 ((or (numberp *e1) (memq *e1 '(- +))) (*trel (*tnum *e1)))
	 (t (*evpaslis *e1 (ptype *e1))))))
 
(de *evpaslis (*fonc *a1)
   ; *arg? variable globale type de l'evaluation
   (selectq *a1
     (3     (apply *fonc t))
     (t     (*contr *fonc (*evlis (abs (*ptype *fonc)) *arg?)))))
 
(de *contr (*fonc *a1)
  ;evalue une procedure et verifie le resultat
   (ifn (or *reste *ligne) (apply *fonc *a1)
	(let ((*a1 (apply *fonc *a1)))
	     (if (setq *a1 (*trel (if (numberp *a1) (*tnum *a1) *a1)))
		 (*l-err nil 'er? *a1 '?)
		 (*l-eval *ligne *reste)))))
 
(de fais (*ligne)
  ; executeur logo
   (ifn (*liste?  *ligne) (*l-err *fonc 'ernva *ligne)
	(let ((*e1 (nextl *ligne)));ote *list
	     (while *ligne
		    (setq *e1 (*eval-lig (nextl *ligne))))
	     *e1)))
 
(de *eval-lig (*e1)
  ;evaluation d'une ligne
   (let ((*ev (*ex-ev *e1)))
	; si le resultat est numerique on relance l'infixe
	(*trel (if (numberp *ev) (*tnum *ev) *ev)) ) )
 
(de *ex-ev (*e1)
  ;evaluation d'une expression
   (cond
       ((or (numberp *e1) (memq *e1 '(- +))) (*tnum *e1))
       ((atom *e1) (let ((*fonc *e1))
	   (apply *e1 (*evlis (abs (*ptype *e1)) *arg?))))
       ((eq (car *e1) '/:) (chose (cadr *e1)))
       ((eq (car *e1) '/") (cadr *e1))
       (t (*evar *e1))))  ;liste logo ou arite variable
 
(de *evar (*e1)
  ;evaluation expression parenthesee
  (cond
    ((atom (car *e1))
	  (cond
	     ((null (car *e1)) (*l-err nil 'erudf 'rien))
	     ((eq (car *e1) 'list) (cons '*list (cdr *e1)))
	     ((or (numberp (car *e1)) (memq (car *e1) '(- +)))
		  (*trel (*tnum *e1)))
	     (t
		(let ((*ligne (cdr *e1)) (*fonc (car *e1))
		      (*arit (*ptype (car *e1))))
		     (setq *e1 (if (< *arit 0) (apply *fonc (*vevlis))
				   (apply *fonc (*evlis *arit *arg?))))
		     (if (and *ligne *e1)
			 (*trel (if (numberp *e1) (*tnum *e1) *e1))
			 *e1) ))) )
    ((null (caar *e1)) (*l-err nil 'erudf 'rien))
    ((eq (caar *e1) 'list) (cons '*list (cdar *e1)))
    (t (let ((*ligne (cdr *e1))) (*eval-lig (car *e1))) ) ) )
 
(de *ptype (*fonc)
    ;ramene l'arite d'une procedure
  (if (and  *fonc  (symbolp *fonc))
      (let ((*a1 (ptype *fonc)))
	   (selectq *a1
	      (0 (*l-err nil 'erudf (or *fonc 'rien)))
	      (3 0)
	      ((1 2) (setq *arg? '*arg1?) *a1)
	      (t (setq *arg? '*arg?)
		 (if (< *a1 10) (- *a1 6) (- *a1 10)))))
      (*l-err nil 'erudf (or *fonc 'rien))))
 
(df *lprogn *l
  ;pour evaluer le corps d'une procedure
  (let ((teste nil))
     (tag *pfin
       (*l-eval (car *l) (cdr *l)))))  ;pour les tail rec
 
(de *ar ()
   (or (nextl *ligne) (*l-err *fonc 'erni *arit '| donnee(s)|))))
 
(de *evlis (*arit *a1)	;evalue le bon nombre d'arguments
   ; *fonc variable globale de *l-eval et de *ex-ev
    (and (<> *arit 0)
	 (let ((*d (list (*a1 (*ar)))))
	      (let ((*l *d))
		   (if (= *arit 0)
		       *d
		       (self (placdl *l (*a1 (*ar))) ))))))
 
(de *arg? (*l)	;recupere l'argument suivant
     (decr *arit)
     (or (*eval-lig *l) (*l-err *l 'ernr))) ;l'argument est nil
 
(de *arg1? (*l) (decr *arit) *l)
 
(de *vevlis (*arit) ;prend les arguments jusqu'en fin de ligne
    (and *ligne
	 (let ((*d (list (*arg? (nextl *ligne)))))
	      (let ((*l *d))
		   (if *ligne
		       (self (placdl *l (*arg? (nextl *ligne))))
		       *d)))))
 

