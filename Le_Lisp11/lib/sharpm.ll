;==========================================================================
;
;                  Le_Lisp 68K  :  la macro #  (sharp-macro)
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================
 
 
 
(de xr-sharp-macro ()
    ; fonction lancee par # (cf: sysini.ll)
     (let ((c (readch)))
          (let ((f (getprop c 'sharp-macro)))
               (if f
                   (apply f ())
                   (syserror 'sharp-macro "selecteur inconnu" c)))))
 
(df sharp-dmc (l)
    ; definition d'une nouvelle macro-sharp
    (putprop (car l) [lambda . (cdr l)] 'sharp-macro)
    (car l))
 
 
;         Les Macros
 
 
(sharp-dmc |.| ()
    ; retourne la valeur d'une evaluation au moment du READ
    (eval (read)))
 
(sharp-dmc |+| ()
    ; eval conditionnel
    (if (eval (read)) (eval (read)) (read)))
 
(sharp-dmc |-| ()
    ; eval conditionnel
    (if (eval (read)) (read) (eval (read))))
 
(sharp-dmc |/| ()
    ; retourne le code ascii du caractere
    (let ((n (readcn)))
         (if (eq (peekcn) 124)   ; i.e  val
             (sharp-lowbyte n)
             n))))
 
(sharp-dmc |\| ()
    ; retourne une valeur
    (let ((l (read)))
         (let ((n (getprop l 'sharp-value)))
              (ifn n
                   (syserror '|#| "\ : pas de valeur pour" l)
                   (if (eq (peekcn) 124)  ; i.e. val abs
                       (sharp-lowbyte n)
                       n))))))))
 
(mapc
   (lambda (x y) (putprop x y 'sharp-value))
   '(null bell bs tab lf cr eof esc sp del rubout)
   '(0    7    8  9   10 13 26  27  32 127 127)))))
 
(sharp-dmc |^| ()
    ; retourne la valeur d'un caractere control
    (let ((n (logand 31 (readcn))))
         (if (eq (peekcn) 124)  ; i.e. val abs
             (sharp-lowbyte n)
             n))))))
 
(de sharp-lowbyte (n)
    ; si on a une val abs apres
    (readcn)  ; saute le val abs
    (let ((n1 (logshift n 8)) (n2 (readcn)))
         (selectq n2
          (47 ; i.e le slash
            (+ n1 (readcn)))
          (94 ; i.e. chapeau
            (+ n1 (logand 31 (readcn))))
          (92 ; i.e le backslash
            (let ((n (getprop (read) 'sharp-value)))
                 (if n
                     (+ n1 n)
                     (syserror '|#| "\ : pas de valeur pour" ))))
        (t  ; tous les autres
            (+ n1 (readcn)))))))))
 
(sharp-dmc |"| ()
   ; retoure la liste des codes ascii
   (let ((l) (i))
        (untilexit finl
           (if (= (setq i (readcn)) #/")
               (exit finl (kwote (nreverse l)))
               (newl l i)))))))
 
(sharp-dmc |$| ()  ($-aux 4 0 (peekch))))
 
(de $-aux (n a c)
    ; lecture d'un nb hexa : a refaire avec peekcn et reread!!!
         (if (setq c (cassq c
               '((0 . 0)(1 . 1)(2 . 2)(3 . 3)
                 (4 . 4)(5 . 5)(6 . 6)(7 . 7)
                 (8 . 8)(9 . 9)(a . 10)(|a| . 10)(b . 11)(|b| . 11)
                 (c . 12)(|c| . 12)(d . 13)(|d| . 13)
                 (e . 14)(|e| . 14)(f . 15)(|f| . 15))))
             (progn (readch) ($-aux (1- n) (+ (* a 16) c) (peekch)))
             (cond
                 ((= n 4) (syserror '|#|
                               "$ : il faut 1 moins 1 chiffre hexa" ))
                 ((< n 0) (syserror '|#|
                               "$ : plus de 4 chiffres hexa" n))
                 (t a))))))))
 
(sharp-dmc |%| ()  (%-aux 16 0 (peekch))))))
 
(de %-aux (n a c)
    ; lecture d'un nb binaire : a refaire avec peekcn & reread
         (if (setq c (cassq c '((0 . 0)(1 . 1))))
             (progn (readch) (%-aux (1- n) (+ (* a 2) c) (peekch)))
             (cond
                 ((= n 16) (syserror '|#|
                               "% : il faut 1 moins 1 chiffre binaire" ))
                 ((< n 0) (syserror '|#|
                               "% : plus de 16 chiffres binaires" n))
                 (t a))))))))
