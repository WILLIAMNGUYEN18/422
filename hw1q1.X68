*-----------------------------------------------------------
* Title      :hwq1
* Written by :will
* Date       :
* Description:comparing assembly to machine code
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Q1
    MOVE.W  D1,$0000A000
    
    
    MOVE.B  $42A7,(A1)+
    
    
    ADD.L   D7,D0
    
    
    MOVEA.L D3,A0


* Q2
    MOVE.L #$C1A8E392,D0
    
    ASL.B #2,D0
    
    MOVE.L #$C1A8E392,D0
    
    ASL.L #5,D0
    
    MOVE.L #$C1A8E392,D0
    
    LSR.B #4,D0

    MOVE.L #$C1A8E392,D0
    
    ROR.W #2,D0
   
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
