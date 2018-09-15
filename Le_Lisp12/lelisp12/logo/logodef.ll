;=====================================================================
;
;    Logo-Lisp	:  LOGODEF   definition de procedure Logo
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;====================================================================
 
(de local (*l)	 ; utilise si local est tape au toplevel
  (*l-err 'local ''| s'utilise dans une procedure|))
 
(de *def? (*a1) (if (or (typefn *a1) (null *a1))
		    (if (>= (ptype *a1) 10)
			(*l-err nil ''|Tu as deja defini | *foo)
			(*l-err nil 'erdp *a1))))
 
(de pour *a1
	    ; Definition de procedure
  (let ((*foo (car *ligne)) (*par (cons nil (*ote (cdr *ligne))))
	(*d ['*lprogn]))
      (*def? *foo)
      ; on ajoute le nom de la procedure a la liste
      (ifn (memq *foo procedures) (newr procedures *foo))
      (ptype *foo (+ (length (cdr *par)) 10))  ; garde l'arite sur le ptype
      (bind ((prompt '|> |))
	(*corps *d (last *par) (*readl)))  ;construction de la procedure
      (eval ['de *foo (cdr *par) *d])	   ;creation de la procedure
      (print *foo '| est defini|)
      (setq *ligne nil))))))
 
(de *corps (*l *par *a1)
  ; le corps est enveloppe par *lprogn	(logo-progn)
  ; les variables locales sont rajoutees aux parametres
    (unless (equal *a1 ['fin])
	   ; ((local "n "m))  => (local "n "m)
	  (and (listp (car *a1))
	       (eq (caar *a1) 'local)
	       (setq *a1 (car *a1)))
	   ; (local "n "m)
	  (ifn (eq (car *a1) 'local) (*corps (placdl *l *a1) *par (*readl))
		; on les rajoute aux parametres
		; l'instruction local n'apparaitra pas dans le corps
	       (*corps *l (last (rplacd *par (*ote (cdr *a1)))) (*readl))))))))
 
(de *ote (*l)	;rends une liste de variables ou les " et : sont otes
  (mapcar (lambda (*a1)
	      (cond
		 ((and (listp *a1) (memq (car *a1) '(/: /"))) (cadr *a1))
		 ((atom *a1) *a1)
		 (t (*l-err 'pour 'ernva *a1))))
	  *l))
 
(de definis (*a1 *a2)
   (nextl *a2)
   (ifn (memq *a1 procedures) (newr procedures *a1))
   (ptype *a1 (+ 10 (length (cdar *a2))))
   (eval
     ['de *a1 (cdr (nextl *a2))
       (cons '*lprogn (mapcar 'cdr *a2))])) )
 
(de lisliste ()
    (cons '*list (*llect)))
 
(de liscar ()  (tyi))

