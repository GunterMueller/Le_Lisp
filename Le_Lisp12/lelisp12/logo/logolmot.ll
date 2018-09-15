(bind ((typecn 47 1)(typecn 59 2)(typecn 39 5)(typecn 94 5)(typecn 35 7)
       (typecn 43 8)(typecn 45 8)(typecn 42 8)(typecn 92 8)(typecn 64 8)
       (typecn 62 8)(typecn 60 8)(typecn 61 8)(typecn 46 9))
      (untilexit eof (eval (read))))
;=====================================================================
;
;    Logo-Lisp	:  LOGOLMOT   operations sur les listes et les mots
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;=====================================================================
 
; Initialisation de l'arite
(mapc 'ptype '(item membre?) 8)
(mapc 'ptype '(compte prem der sp sd liste? mot? vide?) 7)
(mapc 'ptype '(mot liste phrase) 4)
 
(de compte (*l)  ;nombre d'elements d'une liste
  (if (listp *l)
      (1- (length *l))
      (cond ((numberp *l) (length (explode *l)))
	    ((eq *l '| |) 0)
	    (t (plength *l)) ) ) )
 
(de item (*a1 *l)  ;le nth lisp (cdr de *l pour *list)
   (cond
     ((or (> *a1 (length (cdr *l))) (< *a1 1)) (*l-err 'item 'ernva *a1))
     (t (nth (1- *a1) (cdr *l))) ) )
 
(de *v? (*a1 *l)
   ;mot ou liste vide
    (if (or (eq *l '| |) (equal *l '(*list)))
	(*l-err *a1 'ernva *l)))
 
(de prem (*l)
  ;erreur si liste ou mot vide
   (cond
     ((*v? 'prem *l))
     ((listp *l) (if (listp (cadr *l)) (rplaca (cadr *l) '*list))
		 (cadr *l))    ;on ote *list
     ( t	(ascii (car (explode *l))))))  ;(ok si nombre)
 
(de der (*l)
  ;erreur si liste ou mot vide
   (cond
     ((*v? 'der *l))
     ((listp *l)  (let ((*l (car (last *l))))
		      (or (nlistp *l)
			  (if (neq (car *l) 'list)
			      *l
			      (cons '*list (cdr *l))  ) ) ))
     ( t  (ascii (car (last (explode  *l)))))))  ;(ok si nombre)
 
(de sp (*l)
  ;erreur si liste ou mot vide
   (cond
     ((*v? 'sp *l))
     ((*liste? *l) (cons '*list (cddr *l)))
     (t (*limplo (cdr (explode *l))))))
 
(de sd (*l)
  ;erreur si liste ou mot vide
   (cond
     ((*v? 'sd *l))
     ((*liste? *l)  (cons '*list (nreconc (cdr (reverse (cdr *l))))))
     (t  (*limplo (nreconc (cdr (nreconc (explode *l))))))))
 
(de metp (*a1 *l)
   (if (consp *l)
       (mcons '*list (if (consp *a1) (subst 'list '*list *a1) *a1)
		     (cdr *l))
       (*l-err 'metp 'ernva *l)))
 
(de metd (*a1 *l)
   (if (consp *l)
       (nconc *l [(if (consp *a1) (rplaca *a1 'list) *a1)])
       (*l-err 'metd 'ernva *l)))
 
(de mot *l
   (*limplo (mapcan
		(lambda (*a1) (if (consp *a1) (*l-err 'mot 'ernva *a1)
			      (explode *a1)))
	      *l)))
 
(de liste *l
   (cons '*list (subst 'list '*list *l)))
 
(de phrase *l
   (cons '*list
	 (mapcan (lambda (*l) (if (consp *l) (append (cdr *l)) [*l]))
		 *l)))
 
; Les predicats sur les listes et les mots
 
(de membre? (*a1 *l)
   (ifn (*liste? *l) (*l-err 'membre? 'ernva *l)
	(if (*liste? *a1) (rplaca *a1 'list)) ;*list -> list
	(if (member *a1 (cdr *l)) 'vrai 'faux)))
 
(de liste? (*l)
   (if (*liste? *l) 'vrai 'faux))
 
(de mot? (*l)
   (if (listp *l) 'faux 'vrai))
 
(de vide? (*l)
   (if (or (eq *l '| |) (equal *l '(*list))) 'vrai 'faux))
 
(de finlexi ()
   (mapc 'REMFN
	  '(compte item prem der sp sd mot liste phrase
	    membre? liste? mot? vide?))
   (mapc 'ptype
	  '(compte item prem der sp sd mot liste phrase
	    membre? liste? mot? vide?) 0)
   (=autl logolmot lexi finlexi))
 

