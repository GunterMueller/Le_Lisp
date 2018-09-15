;=================================================================
;
;    Le_Lisp  80   :  PEPE  les fonctions autoload
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
;*******     Attention : ne pas modifier l'ordre de ces fonctions
;            voir PEPINI.LL ou cet ordre est utilise
 
;*****  (1)   Affiche le recapitulatif des commandes
;             la documentation 'en-line' de PEPE
 
 (progn
     (tycls)
     (tycursor 0 0)
     (input (filename 'PEPHLP))
     (untilexit eof (tyo (readcn)))
     (input ())
     (tyi)
     (redisplay))
 
 
 
;*****  (2)   Evaluation de tout le tampon sans sortir de PEPE
;             dependant du format des lignes
 
(let ((f $buffer$))
     (tycls)
     (untilexit eoc
        (print '|=> |
           (tag syserror
            (eval
              (flet ((bol ()
                      (ifn f
                        (exit eoc)
                        (let ((l (cdr (nextl f))) (n -1))
                             (ifn l
                                  (bol)
                                  (while l
                                        (inbuf (incr n) (nextl l)))
                                  (inbuf (incr n) 13)
                                  (inbuf (incr n) 10)
                                  (inmax (1+ n)))))))
                    (read))))))
       (tyi)
       (redisplay))
 
 
;***** (3)  insere un nouveau fichier au niveau
;           de la ligne courante.
 
(let ((l (nthcdr (+ $ydisplay$ $ycursor$) $buffer$))
      ($buffer$)
      ($xcursor$)
      ($ycursor$)
      ($ydisplay$))
     (readfile (readname))
     (displace l (nconc $buffer$ (cons (car l) (cdr l))))
     (redisplay $ycursor$))
 


