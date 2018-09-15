(bind ((typecn 47 1)(typecn 59 2)(typecn 39 5)(typecn 94 5)(typecn 35 7)
       (typecn 43 8)(typecn 45 8)(typecn 42 8)(typecn 92 8)(typecn 64 8)
       (typecn 62 8)(typecn 60 8)(typecn 61 8)(typecn 46 9))
      (untilexit eof (eval (read))))
;=============================================================================
;
;    Le_Lisp  80   :   LOGOPLAN -  gestion de la tortue plancher sous LOGO
;
;=============================================================================
;   (c) 1982 M.RICART &  C.N.D.P. 21-23, rue de la Vanne 92120 MONTROUGE France
;=============================================================================
;
;  Ce fichier contient toutes les fonctions de controle de la voie V24 :
;   (=i24)		  renvoie le caractere lu sur la V24
;   (=o24 n)		  envoie le caractere de code ASCII n sur la V24
;  ainsi que les commandes de la tortue plancher ("promobile" Jeulin).
 
;--- l'acces a la voie V24 (alias RS232)
 
(de =i24 ()
    ; entree d'un caractere
    (while (= 0 (logand 4 (memoryb '(#$FF #$FC)))))
    (memoryb '(#$FF #$FB)))
 
(de =o24 (n)
    ; sortie d'un caractere
    (while (= 0 (logand 8 (memoryb '(#$FF #$FC)))))
    (memoryb '(#$FF #$FB) n))
 
;--- la gestion du Promobile Jeulin. Utilise =i24 et =o24
;    Remarque : le "(=i24)" apres chaque utilisation de "=o24" est necessaire
; pour attendre l'acquittement du mobile, et eviter de perdre des caracteres
; par exces de velocite de Lisp.
 
(de av (n)
      ; pour avancer, ou reculer si l'argument est negatif
      (repeat (abs n)
	      (=o24 (if (> n 0) #/a #/r))
	      (=i24))
      ())
 
(de re (n)
      ; itou, dans l'autre sens
      (repeat (abs n)
	      (=o24 (if (> n 0) #/r #/a))
	      (=i24))
      ())
 
(de td (n)
      ; a droite
      (repeat (* (abs n) 4)
	      (=o24 (if (> n 0) #/d #/g))
	      (=i24))
      ())
 
(de tg (n)
      ; et a gauche
      (repeat (* (abs n) 4)
	      (=o24 (if (> n 0) #/g #/d))
	      (=i24))
      ())
 
(de bc ()
      ; plume en "B"as
      (=o24 #/B)
      (=i24)
      ())
 
(de lc ()
      ; plume en "H"aut
      (=o24 #/H)
      (=i24)
      ())
 
(de te ()
      ; pour revenir a l'ecran
      (mapc 'remfn '(=i24 =o24))
      (mapc '=lf '(logograp logograf)))
 

