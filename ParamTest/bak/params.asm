*=$1000        
        JSR $AEFD ; check for comma 
        JSR $B79E ; get 8-bit parameter into X
        stx $1200
        rts