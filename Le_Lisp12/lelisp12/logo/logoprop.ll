;=====================================================================
;
;    Logo-Lisp	:  LOGOPROP   listes de propriete en Logo
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      2  place Jussieu	  75005 PARIS
;=====================================================================
 
; Initialisation de l'arite
(ptype 'pliste 7)
(ptype 'dprop 9)
(mapc 'ptype '(rprop aprop) 8)
 
(de rprop (*l *a1)
   ;ramene la valeur d'une propriete
   (getprop *l *a1))
 
(de pliste (*l) ['*list (plist *l)])
 
(de dprop (*l *a1 *a2)
   ;donne une propriete
   (putprop *l *a2 *a1) nil)
 
(de annuleprop (*l *a1)
   ;annule une propriete
   (remprop *l *a1) nil)
 
 
 

