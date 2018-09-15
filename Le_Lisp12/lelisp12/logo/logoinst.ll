;====================================================================
;
;    Logo-Lisp	:  LOGOINST   quelques instructions Logo
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;=====================================================================
 
(de chose (*a1)
   (if (boundp *a1) (eval *a1) (*l-err nil 'erudv *a1)))
 
(de chose? (*a1)
   (if (boundp *a1) 'vrai 'faux))
 
(de carac (*a1)
   ; caractere de code asii *a1
   (if (and (numberp *a1) (< *a1 256)) (ascii *a1)
       (*l-err 'carac 'ernva *a1)))
 
(de code (*a1)
   ; code ascii d'un caractere
   (if (numberp *a1)
       (car (explode *a1))
       (or (chrnth 0 *a1) (*l-err 'code 'ernva *a1))))
 
(df ecris *l
   (mapc 'prin1 *l) (terpri) nil)
 
(de prin1 (*l)	; un prin qui separe ses arguments avec un blanc
  (if (listp *l) (*imlist *l) (prin *l '| |)))
 
(df tape *l  ;prin
   (apply 'tyo (mapcar 'explode  *l)) nil)
 
(de *imlist (*l)   ;pour ne pas imprimer les crochets exterieurs
   (selectq (car *l)
      (*list (mapc 'prin1 (cdr *l)))
      (list (prin '/[ '| |) (mapc 'prin1 (cdr *l)) (prin '/] '| |))
      ((/: /") (prin (car *l) (cadr *l) '| |))
      (t (prin '/( ) (mapc 'prin1 *l) (prin '/) '| |) ) ))
 
(de relie (*a1 *a2)    ;affectation
   (set *a1 *a2)
   nil)
 
(de rends *a1	 ; sortie d'une fonction
  (exit *pfin (*l-eval *ligne))))
 
(de stop *a1 )	   ; sortie d'une commande
 
 
;    LES STRUCTURES DE CONTROLE
;    --------------------------
(de *liste? (*l) ;teste si c'est une liste logo
	   (and (listp *l) (memq (car *l) '(list *list)) *l)))
 
(de repete (*a1 *l)
   (repeat  *a1 (fais *l))
   nil)
 
(de si *a1  ; SI test ALORS listeinst SINON listeinst
		  ;evaluation du test
   (if (prog1 (eq (*eval-lig (nextl *ligne)) 'vrai)
	      (ifn (eq 'ALORS (nextl *ligne)) (*l-err 'si ''|attend ALORS|))
	      (ifn (*liste? (car *ligne)) (*l-err 'si 'ernva (car *ligne))))
       ;VRAI
       (*l-eval (cdr (nextl *ligne))
	   ;saute la clause SINON et poursuite si *reste
		(progn (when (eq 'SINON (car *ligne))
			     (nextl *ligne)  ;pour le sinon
			     (ifn (*liste? (car *ligne))
				  (*l-err 'si 'ernva (car *ligne))
				  (nextl *ligne)));clause sinon
		       (and *a1
			   (ifn *ligne *reste (cons *ligne *reste))))
		)
       ;FAUX
	(nextl *ligne) ;pour sauter la clause vrai
	(ifn (eq 'SINON (car *ligne)) ;pas de sinon
	  ; evaluation de l'instruction suivante sur la meme ligne
	     (and *a1 (*l-eval *ligne *reste))
	  ;evaluation de la clause sinon
	     (nextl *ligne) ;pour le sinon
	     (ifn (*liste? (car *ligne)) (*l-err 'si 'ernva (car *ligne))
		  (*l-eval (cdr (nextl *ligne))  ;pour sauter list
			 (and *a1 (ifn *ligne *reste (cons *ligne *reste))))))
      )))))
 
(de teste (*a1)
   (setq teste (if (memq *a1 '(vrai faux)) *a1 (*l-err 'teste 'ernva *a1)))
   nil)
 
(de sivrai (*a1)
    (selectq teste
      (nil (*l-err *fonc ''|n'a pas de teste associe|))
      (vrai (fais *a1))
      (t  nil)))
 
(de sifaux (*a1)
    (selectq teste
      (nil (*l-err *fonc ''|n'a pas de teste associe|))
      (faux (fais *a1))
      (t  nil)))
 
 

