*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
        MOVE.B  #5,D0   Five numbers to add
        LEA Table,A0    A0 points at the numbers
        CLR.B   D1      Clear the sum
LOOP    ADD.B   -(A0),D1    REPEAT ADD # to total
        MOVE.B D1,-(A0)
        SUB.B   #1,D0
        BNE     LOOP    Until all #s added 
        STOP    #$2700
        
Table   DC.B    1,4,2,6,5   Example Data
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
