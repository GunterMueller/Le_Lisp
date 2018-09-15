;=================================================================
;
;    Le_Lisp  80   :   VIRTTY  -  gestion du terminal virtuel
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'virtty 'version (version)))


;  Ce fichier contient toutes les fonctions de controle de l'ecran
;  dependantes du type du terminal (ici du systeme Le_Lisp).
;  Pour chaque nouveau systeme, il faut definir ses nouvelles
;  caracteristiques en mettant a jour ce fichier.


;-----   La taille physique de l'ecran (comptee a partir de 0)

#.(selectq (system)

   (MICRAL90   '(setq $xmax$ 79  $ymax$ 23))
   (MICRAL     '(setq $xmax$ 79  $ymax$ 23))
   (SILZ       '(setq $xmax$ 79  $ymax$ 23))
   (LX529E     '(setq $xmax$ 79  $ymax$ 23))
   (t          '(setq $xmax$ 79  $ymax$ 23))))


;-----   La code ASCII des touches "fleches"

#.(selectq (system)

  (MICRAL90 '(setq $left$ #^H $right$ 29 $up$ #^K $down$ #^J))
  (MICRAL   '(setq $left$ #^H $right$ #^I $up$ #^K $down$ #^J))
  (SILZ     '(setq $left$ #^H $right$ #^L $up$ #^K $down$ #^J))
  (LX529E   '(setq $left$ #^H $right$ #^Q $up$ #^S $down$ #^R))
  (t        '(setq $left$ #^B $right$ #^F $up$ #^P $down$ #^N)))

;-----   Les fonctions physiques sur l'ecran :
;
;        en plus des fonctions standard : (tyi) (tys) et (tyo n)
;        il faut egalement definir :
;
;        (tycursor x y) positionne le curseur en "x" (col.) et "y" (ligne)
;        (tycls)     efface tout l'ecran
;
;        les fonctions suivantes peuvent ne rien signifier
;        pour un certain type de terminal, mais doivent etre
;        toujours definies et retourner T ou ()
;
;        (tycleol)    efface du caractere courant a la fin de la ligne
;        (tycleos)    efface du caractere courant a la fin de l'ecran
;        (tybeep)     declenche la sonnette
;        (tyinsch n)  insere le caractere "n" a la position du curseur
;        (tydelch)    enleve le caractere a la position du curseur
;        (tyinsln)    insere une nouvelle ligne a la position courante
;        (tydelln)    enleve la ligne courante
;        (tyattrib i) change le mode de l'attribut


#.(selectq (system)


   (MICRAL90 '(progn

          (de tycursor (x y) (tyo #$1B #/f (+ #$20 x) (+ #$20 y)))
          (de tybeep () (tyo #^G))
          (de tycls () (tyo #^L))
          (de tycleol () (tyo #$1B #/K))
          (de tycleos () (tyo #$1B #/J))
          (de tyinsch (n) (tyo #$1B #/@ n))
          (de tydelch () (tyo #$1B #/P))
          (de tyinsln () (tyo #$1B #/L))
          (de tydelln () (tyo #$1B #/M))
          (de tyattrib (i) (tyo #$1B (if i #/b #/a)))

     ))

   (MICRAL '(progn

          (de tycursor (x y) (tyo #$1B #/F (+ #$20 x) (+ #$20 y)))
          (de tybeep () (tyo #^G))
          (de tycls () (tyo #^L))
          (de tycleol () (tyo #$1B #/K))
          (de tycleos () (tyo #$1B #/J))
          (de tyinsch (n) ())
          (de tydelch () ())
          (de tyinsln () (tyo #$1B #/L))
          (de tydelln () (tyo #$1B #/M))
          (de tyattrib (i) (tyo #$1B (if i #/3 #/4)))

     ))

   (SILZ '(progn

        (de tycursor (x y) (tyo #$1B #/= (+ #$20 y) (+ #$20 x)))
        (de tybeep () (tyo #^G))
        (de tycls () (tyo #^Z))
        (de tycleol () (tyo #^X))
        (de tycleos () (tyo #^Q))
        (de tyinsch (n) ())
        (de tydelch () ())
        (de tyinsln () ())
        (de tydelln () ())
        (de tyattrib (i) (execute [#$3E (if i 142 143)
                                   #$C3 #$0F #$F0]))

     ))

   (LX529E '(progn

        (de tycursor (x y) (tyo 9 x 11 y))
        (de tybeep () (tyo #^G))
        (de tycls () (tyo #^Z))
        (de tycleol () (tyo 1 22))
        (de tycleos () ())
        (de tyinsch (n) ())
        (de tydelch () ())
        (de tyinsln () ())
        (de tydelln () ())
        (de tyattrib (i) (tyo (if i 15 14)))

   ))

  (t (syserror 'VIRTTY (system) (version) ))))))))))


;-----   Les fonctions communes a tous les systemes

(de tyco (x y . l)
    ; positionne le curseur et fait un TYO
    (tycursor x y)
    (apply 'tyo l))



