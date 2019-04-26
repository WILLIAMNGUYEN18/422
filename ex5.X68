*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    
    MOVE.B  $00004340,D3
    
    
    MOVE.B $A340,D3
    
    MOVE.B $FFFFA340,D3
    
    
    MOVE.W $A340,D3
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
