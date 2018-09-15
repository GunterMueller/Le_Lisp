
===============================  PEPHLP.LL  ==================================
^A      va au debut de la ligne      | ESC E  execute le tampon courant
^B  <-  recule d'un caractere        | ESC F  change le nom du fichier courant
^C      sort temporairement de PEPE  | ESC I  insere un autre fichier
        retour par &()               | ESC R  lecture dans le tampon d'un
^D      detruit le caractere courant |        nouveau fichier
^E      va en fin de ligne           | ESC S  sauve le tampon courant dans le
^F  ->  avance d'un caractere        |        fichier courant
^L      re-affiche tout l'ecran      | ESC V  passe a l'ecran precedent
^M  RC  brise la ligne a la position | ESC W  ecriture du tampon courant dans
        du curseur                   |        le fichier
^N  v   passe a la ligne suivante    | ESC Z  sauve sur disque le tampon et
^O      casse la ligne au niveau du  |        charge ce tampon en memoire
        curseur                      | ESC )  se positionne sur la ) fermante
^P  ^   passe a la ligne precedente  |        suivante (a la Lisp)
^T      detruit la ligne pointee par | ESC >  va en fin du tampon
        le curseur                   | ESC <  va au debut du tampon
^V      passe a l'ecran suivant      | ESC ?  imprime cette liste
^Y      reinsere la derniere ligne   | DEL    detruit le caractere a
        detruite par ^T              |        gauche du curseur
==============================================================================
