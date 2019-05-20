*-----------------------------------------------------------
* Title      :midtermex3
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MOVE.W  #3,D5
    MOVE.W  #1,D6
    
    *loop
LOOP    
    CMP.W   #0,D5
    BEQ     END
    MULU.W  D5,D6
    SUBQ.W  #1,D5
    BRA     LOOP
END

*

     
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
