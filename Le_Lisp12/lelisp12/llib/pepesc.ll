;=================================================================
;
;   Le_Lisp  80   :   PEPE   -   les commandes de type <esc> X
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepesc 'version (version)))

 
 
;-----   L'interprete des commandes <esc>
;        la A-Liste des commandes se trouve dans :escommand:
 
(de  escommand ()
     (let ((c (or (nextl lcmd) (tyi))))
          ; passage en majuscule
          (when (and (>= c #/a) (<= c #/z))
                (decr c 32))
          (let ((l (cassq c $escommands$)))
               (cond
                  ((null l)
                     ; ce n'est pas une commande <esc>
                     (deadend))
                  ((symbolp l)
                     ; c'est une commande
                     (apply l))
                  ((numberp (car l))
                     ; c'est une action autoload
                     (when (input (filename 'pepato))
                           (repeat (1- (car l)) (read))
                           (eval (prog1 (read) (input ()) (teread)))))
                  (t ; egalement
                     (eprogn l))))))
 
 
;-----   Lecture d'un nom sur le terminal
 
(de  readname ()
     (tyco 40  #.$ymax$ '#" Nom ")
     (read))
 
;-----   Lecture d'un fichier
 
(de  readfile (f)
     (let ((l) (c))
          (setq $buffer$ ()
                $xcursor$ 0
                $ycursor$ 0
                $ydisplay$ 0)
          (unless (input (filename f))
                  (setq $buffer$ [(pklimplode ())])
                  (input)
                  (deadend))
          (inmax 0) (readcn)
          (untilexit eof
               (setq c (readcn))
               (cond ((= c #^M)   ; rc
                         (while (and (consp l) (= (car l) #/  ))
                                (nextl l))
                         (newl $buffer$ (pklimplode (nreconc l ())))
                         (setq l ()))
                     ((< c 32))   ; cntrl-car
                     (t (newl l c)))))
          (setq $buffer$ (nreconc $buffer$ ()))
          (input))
 
;-----   Ecriture d'un fichier
 
(de  writefile (f)
     (unless (output (filename f))
             (output)
             (deadend))
     (let (($xcursor$ $xcursor$)
           ($ycursor$ $ycursor$))
          (cursor 33 $ymax$)
          (bind ((rmargin 80))
                (mapc 'pklprint $buffer$)))
     (output)
     (setq $modbuf$ ())
     (redisplay $ymax$))
 
 
;-----   verificateur de parentheses a la Lisp
 
(de matchparent ()
    (let ((l (pklcharn (currentline) $xcursor$))
          (n 0))
         (decr $xcursor$)
         (untilexit fin
            (selectq (matchparenc)
                (#/( (incr n))
                (#/) (when (= n 1) (right) (exit fin))
                     (when (<> n 0) (decr n)))
                (#/# (selectq (matchparenc)
                        (#// (matchparenc))
                        (#/" (until (= (matchparenc) #/")))
                        (t ())))
                (#/; (setq l ()))
                (t ())))))
 
(de matchparenc ()
    ; retourne le caractere suivant
    (incr $xcursor$)
    (or (nextl l)
        (progn (begline)
               (down)
               (setq l (pklexplode (currentline)))
               (nextl l))))
 

