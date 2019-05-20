*-----------------------------------------------------------
* Title      :Midterm Exercise 1
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    
reset   LEA $6000,A1
        CLR D0
        CLR D1
        MOVE.W  #0,D0
        MOVE.W  #5,D1

    LEA     $6000,A1
    MOVE.W  #$7C08,(A1)+
    MOVE.W  #$4428,(A1)+
    MOVE.W  #$4408,(A1)+
    MOVE.W  #$4408,(A1)+
    MOVE.W  #$7C3E,(A1)+
    
    *loop AND 00 FF w/ A2+
    LEA     $6000,A1
    
    AND     #$00FF,(A1)+
    AND     #$00FF,(A1)+
    AND     #$00FF,(A1)+
    AND     #$00FF,(A1)+
    AND     #$00FF,(A1)+

        
    
    LEA     $6000,A1
    *push to decrement
    
    MOVE.W  (A1)+,-(SP)
    MOVE.W  (A1)+,-(SP)
    MOVE.W  (A1)+,-(SP)
    MOVE.W  (A1)+,-(SP)
    MOVE.W  (A1)+,-(SP)

    LEA     $6000,A1
    MOVE.W  (SP)+,(A1)+
    MOVE.W  (SP)+,(A1)+
    MOVE.W  (SP)+,(A1)+
    MOVE.W  (SP)+,(A1)+
    MOVE.W  (SP)+,(A1)+    
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
