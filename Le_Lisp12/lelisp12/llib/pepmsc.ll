;=================================================================
;
;   Le_Lisp  80   :   PEPE   -   PEPMSC  fonctions auxiliaires
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepmsc 'version (version)))

 
 
 
(de  deadend ()
     ; fin de la route : on ne plus plus bouger
     (tybeep)
     (exit eoc))
 
(de  currentline ()
     ; retourne la ligne courante
     (nth (+ $ydisplay$ $ycursor$) $buffer$))
 
(de  cursor (x y)
     ; change la position du curseur de PEPE
     (setq $xcursor$ x $ycursor$ y)
     (tycursor x y))
 
(de modbuffer ()
    ; positionne l'indicateur  <M>
    (unless $modbuf$
            (setq $modbuf$ t)
            (redisplay $ymax$)
            (tycursor $xcursor$ $ycursor$)))
 
(de  redisplayhome ()
     ; reaffiche tout l'ecran et se positionne en haut
     (setq $xcursor$ 0 $ycursor$ 0 $column$ 0)
     (redisplay))
 
(de  redisplay (n)
     ; reaffiche toute la fenetre visible a partir de 'n' (optionnel)
     (let (($ycursor$ (or (numberp n)
                          0)))
          (let ((b (nthcdr (+ $ydisplay$ $ycursor$) $buffer$)))
               (cursor $xcursor$ $ycursor$)
               (repeat (- $ymax$ $ycursor$)
                  (tycursor 0 $ycursor$)
                  (tycleol)
                  (when b (pkldisplay (nextl b)))
                  (incr $ycursor$))))
     (tycursor 0 $ymax$)
     (tycleol)
     (tyattrib t)
     (tyo '#"Pepe : " (explode $file$) '#"  "
           (explode (length $buffer$)) '#" ligne")
     (when (> (length $buffer$) 1) (tyo #/s))
     (when $modbuf$ (tyco 32 $ymax$ '#"<M>"))
     (tyattrib ()))
 
 
;-----   une brouette de predicats utiles
 
(de  bolp ()
     ; teste si on se trouve en debut de ligne
     (= $xcursor$ 0)))
 
(de  eolp ()
     ; teste si on se trouve en fin de ligne
     (>= $xcursor$ (pkllength (currentline))))
 
(de  bobp ()
     ; teste si on se trouve en debut de buffer
     (and (= $ydisplay$ 0) (= $ycursor$ 0)))
 
(de  eobp ()
     ; teste si on se trouve en fin de buffer
     (>= (+ $ydisplay$ $ycursor$ 1) (length $buffer$)))
 
(de  bosp ()
     ; teste si on se trouve au debut de l'ecran
     (= $ycursor$ 0))
 
(de  eosp ()
     ; teste si on se trouve a la fin de l'ecran
     (>= $ycursor$ #.(1- $ymax$))))))
 
