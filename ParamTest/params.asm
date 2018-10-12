export start
export result
*=$1000        

start
        JSR $AEFD ; check for comma 
;        JSR $B79E ; get 8-bit parameter into X
        JSR $AD8A ; get float into FAC1 
;        JSR $BAFE ; FAC := FAC / 10.
        JSR $BAE2 ; FAC := FAC * 10.
        JSR $B7F7 ; Convert FAC into unsigned integer value at memory addresses $0014-$0015
        ldx $14
        stx result
        ldx $15
        stx result+1
        rts
result  byte $00,$00
