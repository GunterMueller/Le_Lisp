;=================================================================
;
;      Le_Lisp  80   :  la mise au point interactive
;
;=================================================================
;   (c) 1983    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983    Emmanuel Saint-James  et  Universite Paris 6
;               4 Place Jussieu, 75005 Paris
;=================================================================

#.(unless (= (version) 12)
          (syserror 'debug 'version (version)))


;========================================
;=====    La mise au point interactive
;========================================

;-----    La fontion de mise au point
 
(setq debug ())
 
(df debug  l
    (setq debug l)
    (eprogn l) )
 
;-----    Recuperation du BREAK
 
(de break ()
    (when debug
          (printstack 10)
          (bind ((prompt (concat '|>| (prompt))))
                (print '|vous etes dans la fonction BREAK. ^D pour sortir|)
                (untilexit break
                       (tag syserror (print '|= | (eval (read)))))
                'break))
    (exit syserror 'break))
 
 
;-----   Pour sortir du break ...
 
(dmc ^D () '(exit break))
 
;-----   Impression de la pile
 
(de printstack (m)
    (let ((n (length (cstack))))
         (mapc (lambda (l)
                       (outpos 3)
                       (prin (decr n))
                       (outpos 10)
                       (tag print
                            (flet ((eol () (flush) (exit print)))
                                  (prin (or (findfn (cadr l)) l))))
                       (terpri))
               (cddr (cstack m)))))))
 
;-----   Recuperation de la place
 
(de debugend ()
    (mapc 'remfn '(debug printstack step selectuntil prindeep))
    (setq debug ())
    (autoload debug debug))
 
 
;============================
;=====   Le mode pas-a-pas
;============================

(df step (traceval)
  (let ((deep 0) (step T))
    (flet ((stepin (traceval)
                   (incr deep)
                   (ifn step
                        traceval
                        (selectuntil |EVAL> | (prindeep deep '|==> | traceval)
                           (#/=    (toplevel))
                           (#/!    (exit |EVAL> | (kwote (eval (read)))))
                           (#.$up$   (exit |EVAL> | traceval))
                           (#.$down$ (exit |EVAL> |
                                       ['traceval (kwote traceval) ]))
                           (#/. (exit |EVAL> | (setq step ()) traceval))
                           (t   (tybeep)))))
           (stepout (traceval)
                    (protect
                      (ifn step
                         traceval
                         (selectuntil |EVAL> | 
                                      (prindeep deep '|<== | traceval)
                            (#/= (toplevel))
                            ((#.$up$ #.$down$) (exit |EVAL> | traceval))
                            (#/. (exit |EVAL> | (setq step ()) traceval))
                            (t   (tybeep))))
                      (decr deep))))
           (traceval traceval))))
 
(dm selectuntil x
    (displace x
        [ 'bind [['prompt (kwote (cadr x))]]
                ['untilexit (cadr x)
                    [ 'tag 'syserror
                       [ 'selectq (caddr x)  ! (cdddr x) ] ] ] ] ) )
 
(de prindeep (a b c)
    (prin a)
    (outpos 4)
    (print b c)
    (tyi))
 

