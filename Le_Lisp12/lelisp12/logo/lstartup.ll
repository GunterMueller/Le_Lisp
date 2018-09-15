;=================================================================
;
;    Le_Lisp  80   :   LSTARTUP   :   Le Fichier d'Initialisation
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
;=====	 Le chargement initial (et silencieux)
(progn
 
;-----	 Test du numero de version
      #.(unless (= (version) 12)
		(syserror 'startup 'version (version)))
 
;-----	 Realisation du chargement et lancement de Logo
      (terpri)
      (tyo '#"Un moment : chargement de Logo..." 13 10)
      (untilexit eof
	   (tag syserror (eval (read))))
      (input) (output)
      (=lf 'logograp)
      (=lf 'logograf)
      ; on charge le graphique par defaut
      (vt)
      (tyo
   '#"Logo - Education Nationale (Version experimentale) - (c) CNDP Juin 1983")
      (terpri)
      (logo))
 
;=== les messages d'erreurs
(setq  FERAT   '|zone des symboles pleine|
       FERLS   '|zone des listes pleine|
       FERFS   '|zone pile pleine|   )
 
;-----	 les MACROs LET et LETN
(dm let l
    (rplac l
	   (mcons lambda (mapcar 'car (cadr l)) (cddr l))
	   (mapcar 'cadr (cadr l))))
 
;(dm letn (letn sym larg . corps)
;    ['flet [[sym (mapcar 'car larg) !corps]]
;	    [sym !(mapcar 'cadr larg)]])
 
;-----	 Verificateur de nom de fichier

(de  =fn (f e)
     ; rajoute l'extension .LL par defaut
     (if (> (plength f) 8)
	 f
	 (setq f (explode f))
	 (repeat (- 8 (length f)) (newr f #/ ))
	 (nconc f (explode (or e 'LL)))
	 (repeat (- 11 (length f)) (newr f #/ ))
	 (implode (append '#"|" 
                          (mapcar (lambda (c)
                                    ; passage en caractere majuscule (CP/M)
                                    (if (and (>= c #/a) (<= c #/z))
                                        (- c #$20)
                                        c))
                                  f)
                          '#"|")))))))
 
(de fixedisque (d)
    ; change le disque courant de CP/M
    (execute [#$1E (- (cascii d) #/A)	 ; MVI	E, 0/1/2 ...
	      #$0E 14			 ; MVI	C,code
	      #$CD 05 00])		 ; CALL 0005
    ())
 
;-----	 LOAD et AUTOLOAD
 
(de  =lf (l)
     ; chargement en douceur d'un fichier disque
     (setq l (=fn l))
     (ifn (input l)
	  (progn (print l '| n'existe pas|)
		 ())
	  (tyo '#"Patience...")
	  (eval (read))
	  (input)
	  (terpri)))
 
(df =autl (f . l)
      ; definition de fonction autoload : (AUTOLOAD fichier at1 ... atN)
      (mapc (lambda (a)
	       (eval ['dm a 'l
			 ['remfn (kwote a)]
			 ['=lf (kwote f)]
			 'l]))
	    l))
 

