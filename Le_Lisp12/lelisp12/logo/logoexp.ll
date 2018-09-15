;=====================================================================
;
;    Logo-Lisp	:  LOGOEXP   expressions conditionnelles
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      4  place Jussieu	  75005 PARIS
;=====================================================================
 
; OPERATEURS  PREFIXES
 
(de plusgrand? (*a1 *a2)
   (cond
     ((numberp *a1)
	(if (> *a1 *a2) 'vrai 'faux))
     ((or (alphalessp *a1 *a2) (eq *a1 *a2)) 'vrai)
     (t 'faux)))
 
(de pluspetit? (*a1 *a2)  ;2 nombres ou 2 noms
   (cond
     ((numberp *a1)
	(if (< *a1 *a2) 'vrai 'faux))
     ((and (alphalessp *a1 *a2) (neq *a1 *a2)) 'vrai)
     (t 'faux)))
 
(de egal? (*a1 *a2)   ;*list pour les listes
   (if (equal *a1 *a2) 'vrai 'faux))
 
(de nonegal? (*a1 *a2)
   (ifn (equal *a1 *a2) 'vrai 'faux))
 
; OPERATEURS INFIXES
 
(de *trel (*a1)   ; traitement des relations
  (ifn	(memq (car *ligne) '(> < = <>)) *a1
       (let ((*fonc (car *ligne)))
	(selectq (nextl *ligne)
	   (>  (plusgrand? *a1 (*eval-lig (nextl *ligne))))
	   (<  (pluspetit? *a1 (*eval-lig (nextl *ligne))))
	   (<> (nonegal?   *a1 (*eval-lig (nextl *ligne))))
	   (t  (egal?	   *a1 (*eval-lig (nextl *ligne)))))))))))
 
;	   EXPRESSIONS CONDITIONNELLES
;	  -----------------------------
 
(de *bool? (*a1)
   (or (car (memq *a1 '(vrai faux)))
       (*l-err *fonc 'ernva *a1)))
 
(de non (*a1)
   (cond
     ((eq *a1 'vrai) 'faux)
     ((eq *a1 'faux) 'vrai)
     (t (*l-err 'non 'ernva *a1)))))
 
(de et (*a1 *a2)
   (if (and (eq (*bool? *a1) 'vrai) (eq (*bool? *a2) 'vrai)) 'vrai 'faux)))))
 
(de ou (*a1 *a2)
   (if (or (eq (*bool? *a1) 'vrai) (eq (*bool? *a2) 'vrai)) 'vrai 'faux)))))))
 

