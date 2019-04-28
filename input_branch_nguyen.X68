*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
*-------Code for output-------
LOOP    LEA     MESSAGE,A1     
        MOVE.B  #14,D0          
        TRAP    #15       

*-------Code for input-------
        MOVE.B  #4,D0           Trap task 4 does the following:
        TRAP    #15             Read a number from the keyboard into D1.
        CMP.L   #1542366,D1     Compares D1 to the studentid
        BEQ     DONE            Branch to DONE if they are equal
        
        CMP.B   #20,D1           Compares D1 to 20
        BLT     INVALID         BLT branches if D1 is less than 20
        CMP.B   #25,D1           Compares D1 to 25
        BGT     INVALID         BGT branches if D1 is greater than 25

        CMP.B   #20,D1          Compares D1 and 20
        BNE     TWO             BEQ branches if D1 and 20 are not equal
        LEA     DISPONE,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP
        
TWO     CMP.B   #21,D1           Compares D1 and 2
        BNE     THREE           BEQ branches if D1 and 2 are not equal
        LEA     DISPTWO,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP

THREE   CMP.B   #22,D1           Compares D1 and 3
        BNE     FOUR            BEQ branches if D1 and 3 are not equal
        LEA     DISPTHR,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP

FOUR    CMP.B   #23,D1           Compares D1 and 4
        BNE     FIVE
        LEA     DISPFOU,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP

FIVE    CMP.B   #24,D1           Compares D1 and 2
        BNE     SIX             BEQ branches if D1 and 2 are not equal
        LEA     DISPFIV,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP

SIX     LEA     DISPSIX,A1      
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP

  

INVALID LEA     INV,A1
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     LOOP
        
DONE    MOVE.B  #9,D0
        TRAP    #15             Halt Simulator        

CR      EQU     $0D         
LF      EQU     $0A 
        
MESSAGE DC.B    'Enter a number between 20 and 25, Enter my studentid to exit: ',0        
        
INV     DC.B    'That is not between 20 and 25',CR,LF,0

DISPONE DC.B    'Creative Message 0',CR,LF,0
DISPTWO DC.B    'Creative Message 1',CR,LF,0
DISPTHR DC.B    'Creative Message 2',CR,LF,0
DISPFOU DC.B    'Creative Message 3',CR,LF,0
DISPFIV DC.B    'Creative Message 4',CR,LF,0
DISPSIX DC.B    'Creative Message 5',CR,LF,0



    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
