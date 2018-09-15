;=================================================================
;
;    Le_Lisp  80   :   VIRTTY  -  gestion du terminal virtuel
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
;  Ce fichier contient toutes les fonctions de controle de l'ecran
;  dependantes du type du terminal (ici du systeme Le_Lisp).
;  Pour chaque nouveau systeme, il faut definir ses nouvelles
;  caracteristiques en mettant a jour ce fichier.
 
 
;-----	 La taille physique de l'ecran (comptee a partir de 0)
 
#.(selectq (system)
 
   (MICRAL     '(setq -xm 79  -ym 23))
   (SILZ       '(setq -xm 79  -ym 23))
   (LX529E     '(setq -xm 79  -ym 23))
   (t	       '(setq -xm 79  -ym 23))))
 
 
;-----	 La valeur des touches "fleches"
 
#.(selectq (system)
 
  (MICRAL  '(setq -l #^H -r #^I -u #^K -d #^J))
  (SILZ    '(setq -l #^H -r #^L -u #^K -d #^J))
  (LX529E  '(setq -l #^H -r #^Q -u #^S -d #^R))
  (t	   '(setq -l #^B -r #^F -u #^P -d #^N)))
 
;-----	 Les fonctions physiques sur l'ecran :
;
;	 en plus des fonctions standards : (tyi) (tys) et (tyo n)
;	 il faut egalement definir :
;
;	 (=tcrsr x y) positionne le curseur en "x" (col.) et "y" (ligne)
;	       fixecurseur y x	   pour LOGO
;	 (=tcls)      efface tout l'ecran,  vt pour LOGO
;
;	 les fonctions suivantes peuvent ne rien signifier
;	 pour un certain type de terminal, mais doivent etre
;	 toujours definies et retourner T ou ()
;
;	 (=tcleol)    efface du caractere courant a la fin de la ligne
;	 (=tcleos)    efface du caractere courant a la fin de l'ecran
;	 (=tbip)      declenche la sonnette
;	 (=tinsch n)  insere le caractere "n" a la position du curseur
;	 (=tdelch)    enleve le caractere a la position du curseur
;	 (=tinsln)    insere une nouvelle ligne a la position courante
;	 (=tdelln)    enleve la ligne courante
;	 (=tatt i)    change le mode de l'attribut
 
 
#.(selectq (system)
 
 
   (MICRAL '(progn
 
	  (de fixecurseur (y x) (tyo #$1B #/F (+ #$20 x) (+ #$20 y)) nil)
	  (de =tbip () (tyo #^G))
	  (de vt () (tyo #^L) nil)
	  (de =tcleol () (tyo #$1B #/K))
	  (de =tcleos () (tyo #$1B #/J))
	  (de =tinsch (n) ())
	  (de =tdelch () ())
	  ;(de =tinsln () (tyo #$1B #/L))
	  ;(de =tdelln () (tyo #$1B #/M))
	  (de =tatt (i) (tyo #$1B (if i #/3 #/4)))
 
     ))
 
   (SILZ '(progn
 
	(de fixecurseur (x y) (tyo #$1B #/= (+ #$20 y) (+ #$20 x)))
	(de =tbip () (tyo #^G))
	(de vt () (tyo #^Z))
	(de =tcleol () (tyo #^X))
	(de =tcleos () (tyo #^Q))
	(de =tinsch (n) ())
	(de =tdelch () ())
	(de =tinsln () ())
	(de =tdelln () ())
	(de =tatt (i) (execute [#$3E (if i 142 143)
				#$C3 #$0F #$F0]))
 
     ))
 
   (LX529E '(progn
 
	(de fixecurseur (x y) (tyo 9 x 11 y))
	(de =tbip () (tyo #^G))
	(de vt () (tyo #^Z))
	(de =tcleol () (tyo 1 22))
	(de =tcleos () ())
	(de =tinsch (n) ())
	(de =tdelch () ())
	(de =tinsln () ())
	(de =tdelln () ())
	(de =tatt (i) (tyo (if i 15 14)))
 
   ))
 
  (t (syserror 'VIRTTY (system) (version) ))))))))))
 
 
;-----	 Les fonctions communes a tous les systemes
 
(de =tco (x y . l)
    ; positionne le curseur et fait un TYO
    (fixecurseur y x)
    (apply 'tyo l))

