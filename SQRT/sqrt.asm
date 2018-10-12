export value
export result
export sqrt

FACX    = $61 ;exponent
FAC     = $62 ;mantissa - $65
;         $66 ;sign, in MSB
ARGX    = $69 ;exponent
ARG     = $6a ;mantissa - $6d
;         $6e ;sign, in MSB
SGNCMP  = $6f
 
res8    = $fb ;lobyte of product 
 
;BASIC Subroutines
PRINTFAC = $aabc
VARtoFAC = $bba2 ;a/y, lo/hi
VARtoARG = $ba8c
FACtoVAR = $bbd4
FACadd = $b867
FACdiv = $bb0f
*=$1000


sqrt    
        JSR $AEFD       ; check for comma 
;        JSR $AD8A      ; get float into FAC1 
        JSR $AF28       ; Fetch name of variable from BASIC program and load its value
                        ; address of variable is written into memory addresses $0064-$0065; 
        ldy $48
        ldx $49
        stx resaddr
        sty resaddr+1
        JSR $AEFD       ; check for comma 
        JSR $AD8A      ; get float into FAC1 
        ldx #<value
        ldy #>value
        jsr FACtoVAR
        lda value+1
        bmi error       ;no negative square root
        lda value
        beq done        ;root of 0 is 0
 
        ldy #$00        ;fill temp result with 0
        sty result+1
        sty result+2
        sty result+3
        sty result+4
 
        lda value       ;get guess based on argument
        clc
        ror
        bcs sqrtadd
        ldx #$80
        stx result+1
sqrtadd adc #$40
        sta result
        lda value+1
        ora result+1
        lsr
        lsr
        lsr
        lsr
        tax
        lda sqrttable,x
        sta result+1
        lda #04         ;4 iterations of newton's method
        sta $fb
        lda #<result
        ldy #>result
        jsr VARtoFAC
loop    lda #<value
        ldy #>value
        jsr FACdiv
        lda #<result
        ldy #>result
        jsr FACadd
        dec $61
        ldx #<result
        ldy #>result
        jsr FACtoVAR
        dec $fb
        bne loop
        ldx resaddr
        ldy resaddr+1
        jsr FACtoVAR
done    rts
 
error   rts
 
sqrttable
        byte 03,11,18,25,32,38,44,50
        byte 58,69,79,89,98,107,115,123

value   byte $82,$49,$b2,$6c,$9c ;3.15151515
result  
        byte $00,$00,$00,$00,$00 ;0
resaddr 
        byte $00,$00
