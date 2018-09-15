;=================================================================
;
;   Le_Lisp  80   :   PEPE   -  PEPINI  initialisation des cles
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepini 'version (version)))

 
 
;-----  Initialisation des variables globales
 
(setq $buffer$ (cons (pklimplode ()) ()))
 
(setq $xcursor$ 0 $ycursor$ 0 $column$ 0 $ydisplay$ 0)
 
(setq $file$ 'TMP $commands$ () $escommands$ () $modbuf$ () $kill$ ())
 
(df defkey (k . f)
      (newl $commands$
            (cons (eval k) (if (symbolp (car f))
                               (car f)
                               f)))))))
 
 
;-----   initialisation standard (a la EMACS)
 
(progn
 
(defkey  #^A      begline)
(defkey  $left$   left)
(defkey  #^C      (exit pepe))
(defkey  #^D      deletechar)
(defkey  #^E      endline)
(defkey  #^L      redisplay)
(defkey  $right$  right)
(defkey  #^M      (breakline) (right))
(defkey  $down$   down)
(defkey  #^O      breakline)
(defkey  $up$     up)
(defkey  #^T      killline)
(defkey  #^V      nextscreen)
(defkey  #^Y      (breakline)
                  (cursor $xcursor$ $ycursor$)
                  (mapc 'insertchar (pklexplode $kill$)))
(defkey  #$7F     (left) (cursor $xcursor$ $ycursor$) (deletechar))
(defkey  27       escommand)
 
)
 
(df defesckey (k . f)
      (newl $escommands$
            (cons k (if (symbolp (car f))
                        (car f)
                        f)))))
 
(progn
 
(defesckey  #/E    2)
(defesckey  #/F    (setq $file$ (readname)) (redisplay))
(defesckey  #/I    3)
(defesckey  #/R    (readfile (setq $file$ (readname))) (redisplay))
(defesckey  #/S    (writefile $file$))
(defesckey  #/V    prevscreen)
(defesckey  #/W    (writefile (readname)) (redisplay))
(defesckey  #/Z    (writefile $file$)
                   (tycursor 0 $ymax$)
                   (loadfile $file$)
                   (exit pepe))
(defesckey  #/?    1)
(defesckey  #/)    matchparent)
(defesckey  #/<    (setq $ydisplay$ 0) (redisplayhome))
(defesckey  #/>    (setq $ydisplay$ (- (length $buffer$)
                                  #.(// $ymax$ 2)))
                   (when (< $ydisplay$ 0) (setq $ydisplay$ 0))
                   (redisplayhome))
)
)))))))


