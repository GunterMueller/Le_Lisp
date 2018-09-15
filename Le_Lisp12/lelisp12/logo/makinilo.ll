;=====	 Fabrication du fichier  LELISP.INI  pour Logo
 
(de  =lf (l)
     ; chargement en douceur d'un fichier disque
     (ifn (input l)
	  (list l '| n'existe pas|)
	  (tyo '#"Je charge : " (explode l))
	  (untilexit eof
		  (eval (read))
		  (tyo #/.))
	  (input)
	  (terpri)
	  l)))
 
(de  makinilo ()
     ; fabrique le fichier initial, pour Logo, en format tasse,
     ; sans les commentaires ni les renfoncements.
     (=lf '|LVIRTTY LL |)
     (output '|LELISP  INI|)
     (bind ((sprint t))
	   (mapc (lambda (f)
		    (input f)
		    (untilexit eof (print (read)))
		    (input))
		 '(|LSTARTUPLL | |LVIRTTY LL | |LPEPE	LL | |LPEPTOP LL |
		   |LPEPLN1 LL | |LPEPMSC LL | |LPEPCMD LL | |LPEPINI LL |
		   |LOGOINSTLL | |LOGOARITLL | |LOGOEXP LL | |LOGOIMP LL |
		   |LOGOESP LL | |LOGOLECTLL | |LOGODEF LL | |LOGOTOP LL |
		   |LOGOEVALLL | )))
     (output))
 

