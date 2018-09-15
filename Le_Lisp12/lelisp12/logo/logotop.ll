;=====================================================================
;
;    Logo-Lisp	:  LOGOTOP  la boucle toplevel et les initialisations
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      2  place Jussieu	  75005 PARIS
;=====================================================================
 
(de logo ()    ;la boucle toplevel
  (flet ((syserror (*fo *a1 *a2) (*l-err *fo *a1 *a2)))
    (bind ((prompt '|! |)
	   (typech /' 8) (typech /. 8)(typech /+ 12) (typech /! 8)
	   (typech /- 12) (typech /* 12) (typech /\ 12) (typech // 12)
	   (typech /@ 2) (typech /; 8) (typech /# 8) (typech /^ 8)
	   (typech /> 12) (typech /< 12) (typech /= 12) (typech /& 8))
       (untilexit *ok
	 (tag *pfin
	    (tag syserror
	      (let ((*a1 (*l-eval (*llect))))
		   (if *a1 (*l-err nil 'er? *a1 '?)))))))))
  '|retour au Lisp|)
 
(setq procedures '(*list))
 
(de *limplo (*l)
  ;implode sans erreur si liste vide ou si *l contient des blancs
   (setq *l (*delq 32 *l))
   (if (consp *l) (implode *l) '| |))
 
(de *delq (*a1 *a2)
   (cond ((atom *a2) *a2)
	 ((eq *a1 (car *a2)) (*delq *a1 (cdr *a2)))
	 (t (rplacd *a2 (*delq *a1 (cdr *a2))))))
 
; un mot ne doit pas contenir les caracteres: (,), ,[,],|
(dmc |:| () (*prefix /:))
 
(dmc |"| () (*prefix /"))
 
(df *prefix (*a1)
  [*a1 (ifn (memq (peekcn) '#"()[] +-/\*=<>") (read)
	    '| |) ] )
 
(de aurevoir ()  ;pour sortir de Logo et revenir a CP/M
   (exit *ok))
 
; les messages d'erreur les plus courants
(setq
    er?   '|Que dois-je faire de|
    erudv '|Il n'y a pas de valeur pour|
    erudf '|Je ne sais pas comment faire pour|
    ernva '|ne veut pas de la donnee|
    ernr  '|ne produit pas de resultat|
    erni  '|a encore besoin de|
    erdp  '|On ne peut pas redefinir|
    ersxt '|Manque ) ou ]|
    erhl  '|Hors limites|
    erari '|Nombre trop grand|)
 
(setq ernaa ernva ernna ernva ernla ernva)
 
; impression des messages d'erreur et echappement
(de *l-err (*fo *a1 *a2 *a3)
   (ifn (boundp '*fonc) (setq *fonc nil))
   (ifn *a3 (setq *a3 '/!))
   (if *fo
       (if (= 0 (ptype *fo))
	   (setq *fo *fonc)))
   (when (memq *a1 '(erari ersxt))
	 (setq *a2 nil))
   (ifn *a2 (ifn *fo (print (eval *a1) *a3)
		     (print *fo '| | (eval *a1) *a3))
	    (ifn *fo (progn (prin (eval *a1) '| |) (prin1 *a2) (print *a3))
		     (prin *fo '| | (eval *a1) '| |) (prin1 *a2) (print *a3)))
   (exit syserror))
 
(=autl ltrace trace detrace fintrace)
 
(de lexi () (=lf 'logolmot))
 
;--- Initialisation de l'arite des primitives
;   1  fexpr arite 1
;   2  fexpr arite 2
;   (3	enveloppe)
;   4 a 9  pour -2 a 3
;   >= 10  pour arite >= 0 des procedures logo
 
  (mapc 'ptype '(rends stop pour si) 3)
  (mapc 'ptype '(sivrai sifaux) 1)
 
;-- arite 1 --
  (mapc 'ptype
   '(nombre? chose? chose carac code primitive? defini? non teste fais
     ramene fixedisque av re td tg fixecap sauvetout echelle
     imp edite eff trace detrace) 7)
 
;-- arite 2 --
  (mapc 'ptype
   '(egal?  pluspetit? plusgrand? et ou quotient sauve metp metd copiedef
     relie reste nonegal? definis fixecurseur fixexy repete) 8)
 
;-- arite 3 --
  (mapc 'ptype
     '(ecrisgros)
     9)

;-- arite 0 --
  (mapc 'ptype
     '(recycle place lisliste liscar imptout efps impt primitives aurevoir
       efftout vt te hasard nettoie origine cap lexi finlexi fintrace lc bc
       gomme montre cache cocci mobile) 6)
 ;-- arite -1 ---
  (mapc 'ptype
     '(ecris tape local) 5)
 ;-- arite -2 ---
  (mapc 'ptype
    '(somme produit difference) 4)
 
; ptype a 0 pour les primitives Lisp
  (mapc 'ptype
     '(list when lambda & setq exit progn if df or de until selectq untilexit
       let bind unless and while cond eprogn prog1 repeat ifn tag flet dm
       print dmc sharp protect lock evexit letrec enq env flambda mlambda
       call traceval prin) 0)

