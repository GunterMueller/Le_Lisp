;=================================================================
;
;                Le_Lisp  80   :   Le Fichier d'Initialisation
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
 
 
;=====   Le chargement initial (et silencieux)
 
(progn
 
   ;-----   Test du numero de version
 
   #.(unless (= (version) 12)
             (syserror 'startup 'version (version)))
 
   ;-----   Realisation du chargement
 
   (untilexit eof
        (tag syserror (eval (read)))
        (tyo #/.))
   (input)
   (terpri)
   (setq read () toplevel () eval ())
   (tyo '#"Systeme : " (explode (system))
        '#"  Version : " (explode (version))
        '#"  Memoire : " (explode (gc))
         #^M #^J)
   T))))
 
 
;=====   Les noms des erreurs
 
(SETQ
 
  ERSXT   '|erreur de syntaxe|
  ERIOS   '|erreur disque|
  EROOB   '|argument hors limite|
  ERUDV   '|variable indefinie|
  ERUDF   '|fonction indefinie|
  ERUDT   '|echappement indefini|
  ERWNA   '|trop d'arguments|
  ERWLA   '|liaison illegale|
  ERARI   '|erreur arithmetique|
  ERNUM   '|CDR numerique|
  ERNVA   '|l'argument n'est pas une variable|
  ERNAA   '|l'argument n'est pas un symbole|
  ERNNA   '|l'argument n'est pas un nombre|
  ERNLA   '|l'argument n'est pas une liste|
 
  FERAT   '|zone des symboles pleine|
  FERLS   '|zone des listes pleine|
  FERFS   '|zone pile pleine|
)
 
;-----   les MACROs LET, LETN et LETS
 
(dm let l
    (rplac l
           (mcons lambda (mapcar 'car (cadr l)) (cddr l))
           (mapcar 'cadr (cadr l))))
 
(dm letn (letn sym larg . corps)
    ['flet [[sym (mapcar 'car larg) !corps]]
           [sym !(mapcar 'cadr larg)]])
 
(dm lets (lets l . corps)
    (if (null (cdr l))
        ['let l !corps]
        ['let (car l) ['lets (cdr l) !corps]]))

;----   LET & Cie, paragraphees comme WHILE
 
(ptype 'let 2)
(ptype 'letn 2)
(ptype 'lets 2)

;-----   Verificateur de nom de fichier
 
(de  filename (f ext)
     ; rajouter l'extension .LL par defaut
     (if (> (plength f) 8)
         f
         (setq f (explode f))
         (repeat (- 8 (length f)) (newr f #/ ))
         (nconc f (explode (or ext 'LL)))
         (repeat (- 11 (length f)) (newr f #/ ))
         (implode (append '#"|" 
                          (mapcar (lambda (c)
                                    ; passage en caractere majuscule (CP/M)
                                    (if (and (>= c #/a) (<= c #/z))
                                        (- c #$20)
                                        c))
                                  f)
                          '#"|"))))
 
(de selectdrive (d)
    ; change le disque courant de CP/M
    (execute 
       #.(selectq (system)
           (micral90 ; systeme  CP/M86
              '[#$B2 (- (cascii d) #/a)    ; mov dl, 0/1/2 ...
                #$B1 14                    ; mov cl,code
                #$CD #$E0                  ; int 224
                #$C3])                     ; ret
           (t ; les autres cas (CP/M par defaut)
              '[#$1E (- (cascii d) #/a)    ; MVI  E, 0/1/2 ...
                #$0E 14                    ; MVI  C,code
                #$CD 05 00                 ; CALL 0005
                #$C9])))                   ; RET
     d)
 
;-----   LOAD et AUTOLOAD
 
(df load (f)
    (loadfile f)))
 
(de  loadfile (l)
     ; chargement en douceur d'un fichier disque
     (setq l (filename l))
     (ifn (input l)
          (list l '| n'existe pas|)
          (tyo '#"Je charge : " (explode l))
          (untilexit eof
                  (eval (read))
                  (tyo #/.))
          (input)
          (terpri)
          l)))
 
(dmc |%| () ['load (read)]))
 
(df autoload (f . l)
      ; definition de fonction autoload
      ; (autoload fichier sym1 ... symN)
      (mapc (lambda (A)
               (eval ['dm a 'l
                         ['remfn (kwote a)]
                         ['load f]
                         'l]))
            l))
 
(progn
      (autoload hanoi hanoi hanoiend)
      (autoload vdt vdt vdtend)
      (autoload pepe pepe pepend)
      (autoload pretty pretty prettyend)
      (autoload trace trace untrace)
      (autoload debug debug step)
      (autoload impr impr imprtout)
      (autoload sortl sortl)
)
 
;-----   Le macro-caractere d'appel de PEPE
 
(dmc |&| () ['pepe (read)])
 
 
;=====   Fabrication du fichier  LELISP.INI
 
(de  make-init (i)
     ; fabrique le fichier initial en format tasse,
     ; sans les commentaires ni les renfoncements.
     (load virtty)
     (output '|LELISP  INI|)
     (bind ((sprint t))
           (mapc (lambda (f)
                    (input f)
                    (untilexit eof
                        (let ((read (read)))
                             (when read (print read))))
                    (input))
                 (ifn i
                      '(|STARTUP LL | |VIRTTY  LL |)
                      '(|STARTUP LL | |VIRTTY  LL | |PEPE    LL |
                        |PEPTOP  LL | |PEPLN2  LL | |PEPMSC  LL |
                        |PEPCMD  LL | |PEPESC  LL | |PEPINI  LL |)))
     (output))))
 
 
 

