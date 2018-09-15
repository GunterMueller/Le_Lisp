;=================================================================
;
;   Le_Lisp  80   :   PEPE   -  PEPCMD  les commandes de PEPE
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepcmd 'version (version)))


(de  left ()
     ; un coup a gauche
     (ifn (bolp)
          (setq $column$ (decr $xcursor$))
          (up)
          (endline)))
 
(de  right ()
     ; un coup a droite
     (ifn (eolp)
          (setq $column$ (incr $xcursor$))
          (down)
          (begline)))
 
(de  endline ()
     ; va a la fin de la ligne
     (setq $xcursor$ (pkllength (currentline))
           $column$ $xcursor$))
 
(de  begline ()
     ; va au debut de la ligne
     (setq $xcursor$ 0 $column$ 0)))
 
(de  up ()
     ; va la ligne precedente
     (if (bobp)
         (deadend)
         (ifn (bosp)
              (decr $ycursor$)
              (decr $ydisplay$ 6)
              (incr $ycursor$ 5)
              (when (< $ydisplay$ 0)
                    (setq $ydisplay$ 0 $ycursor$ 0))
              (redisplay))
         (setq $xcursor$ (min $column$
                              (pkllength (currentline))))))
 
(de  down ()
     ; va a la ligne suivante
     (if (eobp)
         (deadend)
         (ifn (eosp)
              (incr $ycursor$)
              (incr $ydisplay$ 6)
              (decr $ycursor$ 5)
              (redisplay))
         (setq $xcursor$ (min $column$
                              (pkllength (currentline))))))
 
(de  nextscreen ()
     ; passe a l'ecran suivant
     (when (> (+ $ydisplay$ #.(1- $ymax$)) (length $buffer$))
           (deadend))
     (incr $ydisplay$ #.(1- $ymax$))
     (redisplayhome))
 
(de  prevscreen ()
     ; passe a l'ecran precedent
     (when (< (decr $ydisplay$  #.(1- $ymax$)) 0) (setq $ydisplay$ 0))
     (redisplayhome))
 
(de  insertchar (c)
     ; rajoute le caractere "c" a la position courante
     (let ((n (pkllength (currentline))))
          (cond
             ((>= n $xmax$) (deadend))
             ((= n 0) (rplaca (nthcdr (+ $ydisplay$ $ycursor$) $buffer$)
                              (pklimplode [c])))
             (t
                (pklinschar (currentline) $xcursor$ c)))
          #.(if (tyinsch 12)
                '(tyinsch c)
                '(tyo (pklcharn (currentline) $xcursor$)))
          (setq $column$ (incr $xcursor$))
          (modbuffer))))))))
 
(de  deletechar ()
     ; enleve le caractere a la position du curseur
     (if (eolp)
         (joinlines)
         (pkldelchar (currentline) $xcursor$)
         #.(if (tydelch)
               '(tydelch)
               '(tyo (pklcharn (currentline) $xcursor$) 32))
         (modbuffer)))))
 
(de  breakline ()
     ; casse la ligne a la position du curseur
     (let ((l (nthcdr (+ $ycursor$ $ydisplay$) $buffer$)))
          (ifn (eolp)
               (let ((l1 (pklbreak (car l) $xcursor$)))
                    (rplac l (car l1) (cons (cdr l1) (cdr l))))
               (if (eobp)
                   (newr $buffer$ (pklimplode ()))
                   (rplacd l (cons (pklimplode ()) (cdr l)))))
          (modbuffer)
          (redisplay $ycursor$)))))
 
(de  joinlines ()
     ; accroche la ligne suivante a la courante
     (let ((l (nthcdr (+ $ycursor$ $ydisplay$) $buffer$)))
          (rplac l (pkljoin (car l) (cadr l)) (cddr l))
          (modbuffer)
          (redisplay $ycursor$)))
 
(de  killline ()
     ; detruit la ligne courante
     (if (bobp)
         (if (cdr $buffer$)
             (setq $kill$ (nextl $buffer$))
             (setq $buffer$ [(pklimplode ())]))
         (let ((l (nthcdr (+ $ydisplay$ (1- $ycursor$)) $buffer$)))
              (setq $kill$ (cadr l))
              (rplacd l (cddr l))))
     (modbuffer)
     (if (eobp)
         (or (bobp) (up))
         ; et l'autre cas si la ligne est plus petite
         (when (< (pkllength (currentline)) $xcursor$)
               (endline)))
     #.(if (tydelln) '(progn (tydelln) (redisplay (- $ymax$ 2)))
                     '(redisplay $ycursor$))))))
 

