*-----------------------------------------------------------
* Title      : Hello World
* Written by : William Nguyen
* Date       : 4/10/19
* Description:Sample Program 1 from Quickstart
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
        LEA     MESSAGE, A1 Loads MESSAGE into address register A1
        MOVE.B  #14,D0      Moves the number 14 into data register D0
        TRAP    #15         Displays Message
        
        MOVE.B  #9,D0   
        TRAP    #15         HALT Simulator

CR      EQU     $0D         ASCII code for CARRIAGE RETURN
LF      EQU     $0A         ASCII code for Line Feed
MESSAGE DC.B    'HELLO, My name is Will Nguyen',CR,LF   ASCII string with new line
        DC.B    'I hope to pass this class. I heard it was quite difficult.',CR,LF
        DC.B    'Lectures are dense and long so far.',CR,LF 
        DC.B    'I hope exams have practice material.',CR,LF,CR,LF
        DC.B    'Thank you for listening',CR,LF,0

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
