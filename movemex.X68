*-----------------------------------------------------------
* Title      : inclass movem example    
* Written by :
* Date       :
* Description: fill registers and move them to stack
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MOVEA.W #$0100,A7
    
    MOVEA.W #$0001,A0
    MOVEA.W #$0002,A1
    MOVEA.W #$0003,A2
    MOVEA.W #$0004,A3
    MOVEA.W #$0005,A4
    MOVEA.W #$0006,A5
    MOVEA.W #$0007,A6
    MOVEQ #10,D0
    MOVEQ #11,D1
    MOVEQ #12,D2
    MOVEQ #13,D3
    MOVEQ #14,D4
    MOVEQ #15,D5
    MOVEQ #16,D6
    MOVEQ #17,D7
    
    MOVEM.L A0-A6/D0-D7, -(A7)
    * Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
