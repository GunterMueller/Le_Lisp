;=================================================================
;
;   Le_Lisp  80   :   LOADER  :  Le Chargeur Memoire
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
#.(unless (= (version) 12)
          (syserror 'loader 'version (version)))


; Ce chargeur suppose que les 2 variables globales :
;          $bcode$ et $ecode$
; contiennent les bornes de la zone code du systeme hote
; sous la forme (high low), ce qui est realise actuellement
; dans les systemes : MICRAL, SILZ, LOGABAX
 
 
;-----   Test si le systeme supporte le LAP
 
(unless (and (boundp '$bcode$) (boundp '$ecode$))
        (input)
        (output)
        (syserror '|le systeme | (system) '| ne supporte pas de chargeur|))
 
;-----   Fonction principale de chargement
 
(de  loader (listobj PCcurrent)
     ; listobj est la liste des objets a charger
     ; PCcurrent (optionnel) est l'adresse de debut de chargement
     (or PCcurrent (setq PCcurrent $bcode$))
     (tag loaderror
          ; $bcode$ ne sera actualise que si tout se passe bien
          (while listobj
             (cond
                ((numberp (car listobj)) (load1 (car listobj)))
                ((atom (car listobj))
                    (loaderr1 'loader (car listobj)))
                ((eq (caar listobj) 'fentry)
                    ; la pseudo (fentry nom type)
                    (valfn (cadar listobj) PCcurrent)
                    (typefn (cadar listobj) (cadr (cdar listobj)))
                    (print 'loader '| : | (cadar listobj)
                           '| | (cadr (cdar listobj))))
                ((eq (caar listobj) 'high)
                    ; la pseudo 'poids forts'
                    (load1 (car (loadadr (cadar listobj)))))
                ((eq (caar listobj) 'low)
                    ; la pseudo 'poids faibles'
                    (load1 (cadr (loadadr (cadar listobj)))))
                (t  ; c'est donc une adresse
                    (loadadr (car listobj))))
             (setq listobj (cdr listobj)))
         (setq $bcode$ PCcurrent)))))))
 
 
;-----   fonction de chargement d'1 seul octet
 
(de  load1 (obj)
     ; charge 1 octet obj
     (if (and (>= (car PCcurrent) (car $ecode$))
              (> (cadr PCcurrent) (cadr $ecode$)))
         (loaderr1 '|plus de place : | PCcurrent))
     (memoryb PCcurrent obj)
     (setq PCcurrent (adadr PCcurrent 1)))
 
;-----   fonction de chargement d'1 adresse
 
(de  loadadr (adr)
     ; charge une adresse sur 16 bits
     (setq adr (valadr adr))
     (load1 (cadr adr))
     (load1 (car adr)))
 
;-----   fonction de calcul de la valeur d'une adresse
 
(de  valadr (adr)
     ; calcule la valeur d'une adresse de type :
     ; n (nh nl) (quote s) (* +/- n) (fval at)
     (cond
        ((numberp adr)
           (if (and (>= adr 0) (< adr 256))
               (list 0 adr)
               (loaderr1 'valadr adr)))
        ((listp adr)
           (cond
             ((numberp (car adr))
                (if (numberp (cadr adr))
                    adr
                    (loaderr1 'valadr adr)))
             ((eq (car adr) quote)
                (loc (cadr adr)))
             ((eq (car adr) '*)
                (adadr PCcurrent (cadr adr)))
             ((eq (car adr) 'valfn)
                (valfn (cadr adr)))
             (t ; pour l'instant il n'y a que ca
                (loaderr1 'valadr adr)))))))
 
 
;-----   fonction d'addition d'adresse
 
(de  adadr (adr val)
     ; adr est de type (high low)
     ; val est un nombre
     (setq val (+ val (cadr adr)))
     (if (> val 255)
         (list (1+ (car adr)) (- val 256))
         (list (car adr) val)))
 
;-----   fonction auxiliaire d'erreur
 
(de  loaderr1 (f a)
     ; erreur dans la fonction f argument a
     (print '**** f a)
     (exit loaderror))
 
;-----   fonction qui detruit tout le chargeur (recupere la place)
 
(de  loadend ()
     (mapc 'remfn
         '(loader load1 loadadr valadr adadr loaderr1 loadend))
     (autoload loader loader loadend))
 
