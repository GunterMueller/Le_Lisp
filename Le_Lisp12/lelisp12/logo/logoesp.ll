;=====================================================================
;
;    Logo-Lisp	:  LOGOESP   espace de travail Logo
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      2  place Jussieu	  75005 PARIS
;=====================================================================
 
 
;   GESTION DE L'ESPACE DE TRAVAIL
;   ------------------------------
 
(de recycle () (gc) nil)
 
(de place ()
  ;le 1er terme de la liste sera pris pour *list
   (gc)
   (cddr (gcinfo)))
 
(de copiedef (*a1 *a2)
   (synonym *a1 *a2)
   (ifn (memq *a1 procedures) (newr procedures *a1))
   nil)
 
(de defini? (*l)
   (if (memq *l procedures) 'vrai 'faux))
 
(de *list? (*l)  ;si *l est une liste logo alors ote *list
   (if (and (listp (car *l)) (eq (caar *l) '*list)) (cdr (car *l)) *l))
 
(de eff (*a1) ;efface une procedure de l'espace de travail
   ; on verifie que l'argument est un symbole
   (ifn (or (symbolp *a1) (memq *a1 procedures))
	(*l-err 'eff 'ernva *a1))
   (remfn *a1)
   (ptype *a1 0)
   ; on l'ote de la liste des procedures
   (*delq *a1 procedures)
   nil)
 
(de efftout () (mapc (lambda (*a1) (remfn *a1) (ptype *a1 0)) 'procedures)
	    (setq procedures '(*list))
	    nil)
 
(de ramene (*l)
  ; charge un fichier, syntaxe: ramene "toto
  ; on peut redefinir une procedure mais pas une primitive
  (flet ((*limplo (*l)
	     (if (consp *l) (implode *l) '| |))
 
	 ( *readl ()  ;ramene la liste des codes de la ligne lue
	 (let ((*l())(*c (readcn)))
	      (if (eq *c #^M) (*limplo (cons #/( (nreconc (cons #/) *l))))
		  (self (cons *c *l) (readcn)))))
 
	 (*def? (*a1) (if (and (typefn *a1) (< (ptype *a1 10)))
			  (*l-err nil 'erdp *a1))))
    (setq *l (=fn *l 'OGO))
    (ifn (input *l) (*l-err nil ''|Je n'ai pas trouve| *l)
	(untilexit eof
	    (tag syserror
	       (*l-eval (*readl))))
	(input)
	nil))))
 
(de sauve *l  ;sauve fichier liste_de_procedures
  ; sauve "toto "truc	 ou  sauve "toto [truc1 truc2 ... trucN]
   (output (=fn (nextl *l) 'OGO))
   (mapc '*improc (*list? *l))	; pretty logo
   (output)
   nil)
 
(de sauvetout (*a1)
   (output (=fn *a1 'OGO))
   (mapc '*improc (cdr procedures))
   (output)
   nil)
 
(de primitives ()
   (ifn (input '|LOGOHELPOGO|) (input)
	(vt)
	(untilexit eof (tyo (readcn)))
	(input))
    nil)
 
(de primitive? (*l)
   (if (and (> (ptype *l) 0) (< (ptype *l) 10)) 'vrai 'faux))
 
;	EDITEUR
;	-------
 
(de edite (*a1)
   ; edite toto
   ; on ne peut pas editer une primitive
  (flet ((*def? (*a2) (if (and (typefn *a2)
			       (< (ptype *a2) 10))
			  (*l-err nil 'erdp *a2)) ))
	(=pepe (*improc *a1))))
 

