;=================================================================
;
;    Le_Lisp  80   :   PEPE   -   (P)epe (E)st (P)resque (E)macs
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
;============================================================== ATTENTION
; ATTENTION !! : ceci est une version reduite de Pepe destinee
; a l'interpreteur Logo du CNDP.
;============================================================== ATTENTION
 
;-----	 Organisation des fichiers de PEPE :
 
;	 PEPE.LL	 la racine du mal ...
;	 PEPTOP.LL	 la boucle principale
;	 PEPLN1.LL	 la gestion des lignes tassees
;	 PEPMSC.LL	 un ensemble de fonctions auxiliaires
;	 PEPCMD.LL	 les fonctions des commandes simples
;	 PEPINI.LL	 les affectations initiales des cles
;	 PEPEND.LL	 la fonction (pepend)
 
;-----	 Les variables globales de PEPE,
;	 en plus de $xmax$ $ymax$ (dans VIRTTY) :
;		     |--> renommees -xm et -ym
;      ancien nom :  nouveau nom :
;
;	 $buffer$    -buf	  la liste des lignes
;	 $file$      -fn	  nom du fichier ou de la fonction du buffer
;	 $ydisplay$  -ydisp	  no de la 1ere ligne de la fenetre visible
;	 $xcursor$   -xcr	  la colonne courante du curseur
;	 $ycursor$   -ycr	  la ligne courante du curseur
;	 $commands$  -cmds	  la A-Liste des cles
 
 
;-----	 La fonction AUTOLOAD qui charge le reste
(dm =pepe l
    (=lf 'PEPTOP)
    (=lf 'PEPLN1)
    (=lf 'PEPMSC)
    (=lf 'PEPCMD)
    (=lf 'PEPINI)
    l))
 

