;=================================================================
;
;    Le_Lisp  80   :   des dragons a foisons ....
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
#.(unless (= (version) 12)
        (syserror 'header 'version (version)))

 
;-----   Le plus petit dragon ...
 

(de dragon (n taille)
    (te)
    (cache)
    (fixexy 0 100)
    (cache)
    (dragon1 n t taille))
 
(de dragon1 (n sens long)
    (if (<= n 0)
        (av long)
        (cond (sens (dragon1 (1- n) sens long)
                    (tg 90)
                    (dragon1 (1- n) (null sens) long))
              (t    (dragon1 (1- n) (null sens) long)
                    (td 90)
                    (dragon1 (1- n) sens long))))))
 
 
;(dragon 8 6)
;(dragon 12 4)
