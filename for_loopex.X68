*-----------------------------------------------------------
* Title      :for_loop example
* Written by :William Nguyen
* Date       :
* Description:loop 0-15
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program


            move.l  #1, D0            *D0 is counter
            move.l  #16, D1        *D1 holds terminal value
            
            

for_loop    cmp.b   D0,D1            *test and compare D0 and D1
            beq     next_code        *are we done?

                        *execute other loop instructions

            addq.l  #1, D0            *increment counter
            bra     for_loop        *go back

Next_code                    *execute instruction after loop*


addZero


addOne


DATALOCATION DC.B $6000


* LOCATION  DC.L  $6000         *Define a location without needing to know exact location, reference via LOCATION
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
