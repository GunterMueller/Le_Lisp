;=================================================================
;
;    Le_Lisp  80   :  sortie sur l'imprimante
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'impr 'version (version)))

 
 
(de imprcar (n)
    ; envoi le caractere de code ascii 'n' sur l'imprimante
    (execute
      #.(selectq (system)
          (micral86 ; systeme CP/M 86
             '[#$53       ; push bx
               #$B2 n     ; mov dl, 0/1/2 ...
               #$B1 5     ; mov cl,code (ici 5)
               #$CD #$E0  ; int 224
               #$5B       ; pop bx
               #$C3])     ; ret
          (t ; les autres cas (CP/M par defaut)
             '[#$E5       ; PUSH H
               #$1E n     ; MVI E,n
               #$0E #$05  ; MVI C,code (ici 5)
               #$CD 5 0   ; CALL CP/M
               #$E1       ; POP H
               #$C9]))))) ; RET
 
(de sopag (n)
    ; realise un saut de page (ou ce qui en tient lieu)
    (repeat (or (numberp n) 1)
            (imprcar #^L)))
 
(de impr (f)
    ; imprime un fichier
    (cond ((input (filename f))
           (terpri)
           (untilexit eof (imprcar (readcn)))
           (terpri))
          (t (syserror 'impr 'erios f)))
    (input)
    f)
 
(de imprtout ()
    ; imprime tout l'environnement Le_Lisp 80
    (tag imprtout
         (flet ((iteval (n)
                    (tyo '#"j'arrete les frais .....")
                    (teread)
                    (input ())
                    (exit imprtout)))
                (mapcar 'impr
                        '( startup  virtty   hanoi    vdt
                           pepe     peptop   pepln1   pepln2
                           pepln3   pepmsc   pepcmd   pepini
                           pepesc   pepato   pephlp   impr
                           trace    debug
                           pretty   sortl    oblist)
                ))))))))
 
(de type (l)
    ; visualise un fichier sur l'ecran
    (ifn (input (filename l))
         [ l '| n'existe pas|]
         (untilexit eof (tyo (readcn)))
         (input)
         l))
 
(df savef (f . l)
    ; sauvegarde de fonctions sur disque
    ; ex d'appel :
    ; (SAVEF file at1 at2 ... atN)   sans quote !
    (output (filename f))
    (bind ((sprint T) (lmargin 0))
       (while l
             (print
                (if (symbolp (car l))
                    (getdef (nextl l))
                    (nextl l)))
             (terpri)))
    (output))
 

