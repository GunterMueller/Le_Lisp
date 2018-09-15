;=================================================================
;
;    Le_Lisp  80   :   PEPE   -   PEPTOP  la boucle principale
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'peptop 'version (version)))

 
 
;-----   les appels de PEPE
 
 
(df pepe (f)
    ; la forme FSUBRee de la fonction suivante
    (pepefile f)))
 
(de  pepefile (f)
     ; la fonction qui evalue son nom de fichier
     (when f
           (setq $buffer$ ()
                 $file$ 'tmp
                 $xcursor$ 0 $ycursor$ 0
                 $column$ 0 $ydisplay$ 0
                 $modbuf$ ())
           (cond
               ((eq f T)
                   ; je veux un fichier scratch
                   (setq $buffer$ (cons (pklimplode ()) ())))
               ((symbolp f)
                   ; ce doit etre un fichier qui existe
                   (tag eoc (readfile f))
                   (setq $file$ f))
               ((consp f)
                   ; c'est une liste de fonctions
                   (flet ((eol ()
                               (let ((i 0) (r ()))
                                    (repeat (outpos) (newr r (outbuf i))
                                            (outbuf i #/ )
                                            (incr i))
                                    (outpos 0)
                                    (repeat (lmargin) (outbuf (outpos) #/ )
                                                      (outpos (1+ (outpos))))
                                    (newl $buffer$ (pklimplode r)))))
                         (eval f))
                    (setq $buffer$ (nreconc $buffer$ ())))
               (t (syserror 'pepe '| mauvais argument | f))))
     (tyattrib ())
     (redisplay)
     ;
     ; le top-level proprement dit de PEPE
     ;
     (let ((lcmd))
      ; lcmd est la liste des commandes non encore executees
      (flet ((iteval (n) (newr lcmd n)))
        (untilexit pepe
          (tag eoc
             (tycursor $xcursor$ $ycursor$)
             (let ((c (or (nextl lcmd) (tyi))))
                  (let ((l (cassq c $commands$)))
                       (cond
                           ((null l)
                                ; ce n'est pas une commande
                                (if (< c 32)
                                    (deadend)
                                    (insertchar c)))
                           ((symbolp l)
                                ; c'est une commande
                                (apply l))
                           (t   ; egalement
                                (eprogn l)))))))
     ; je sors de PEPE : qu'Il soit avec vous!
     (tycursor 0 $ymax$)
     (tycleol)
     (tycursor 0 #.(1- $ymax$))
     (tycleol)
     'PEPE)))))))
 

