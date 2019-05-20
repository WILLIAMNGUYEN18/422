*-----------------------------------------------------------
* Title      :Homework 2 Question 4
* Written by :William Nguyen
* Date       :4/26/19
* Description:
*-----------------------------------------------------------
    ORG    $4000
START:                  ; first instruction of program

* Put program code here
*"Please enter IEEE 32-bit floating point number in hexadecimal":
*32 bits: 1 sign, 8 exponent, 23 mantissa
*8 characters, 4 bits each
    LEA     MESSAGE,A1     
    MOVE.B  #14,D0          
    TRAP    #15
    LEA     MESSAGE1,A1     
    MOVE.B  #14,D0          
    TRAP    #15       

*-------Code for input-------
    
    LEA     STORE1,A1
    MOVE.B  #2,D0           
    TRAP    #15
    MOVE.L  (A1),$2000 
    
    LEA     MESSAGE2,A1     
    MOVE.B  #14,D0          
    TRAP    #15
   
    LEA     STORE2,A1
    MOVE.B  #2,D0     
    TRAP    #15
    MOVE.L  (A1),$2004
    
    *checking output
    MOVE.L  STORE1,D5
    MOVE.L  STORE2,D6

    *loop 8 times
    *loop through $1000-1008
    *resolve each value based on being a number or letter
STFORA  *For Loop Preparations
        MOVE.L  #0, D3
        MOVE.L  #8,D4
        *Locations in address registers
        LEA $00002000,A3
        *Example data to trigger
               
        *Checking for loop
LOOPA   CMP.B   D3,D4
        BEQ     SIGN
        *CLEAR D5 and D6 before moving
        CLR     D5
        CLR     D6
        *Moving address registers of locations to data registers
        MOVE.B  (A3),D5

        *comparing byte data of data register
CHECK0  CMP.B   #$30,D5
        BLT     INVALID         BLT branches if D1 is less than 30
        CMP.B   #$39,D5           Compares D1 to 40
        BGT     CHECK1         BGT branches if D1 is greater than 39
        BRA     SUBNUM0

CHECK1
        CMP.B   #$47,D5           Compares D1 to 47
        BGT     INVALID         BGT branches if D1 is greater than 46
        BRA     SUBLET0 

INC
        *Incrementing for loop
        ADDQ.L  #1,D3
        *Incrementing address register location
        MOVE.B  (A3)+,D5
        BRA     LOOPA
        


*Find out Sign
*reload location
*check if first byte is >= 8
SIGN    CLR D3
        
        LEA $00002000,A3
        MOVE.B  (A3)+,D3
        LEA     MSG1,A1
        MOVE.B  #14,D0
        TRAP    #15
        CMP.B   #$8,D3
        BGT     NEG
        BRA     PLUS
        
NEG     LEA     NE,A1
        MOVE.B  #13,D0
        TRAP    #15
        BRA     MANT

PLUS    LEA     P,A1
        MOVE.B  #14,D0
        TRAP    #15
        BRA     MANT   

MANT
        BRA DONE     


PRINT    
        BRA DONE

SUBNUM0
    SUBI.B  #$30,D5      Reduce to Binary equiv of 0-9
    MOVE.B  D5,(A3)
    BRA INC

SUBLET0
    SUBI.B  #$37,D5      Reduce to Binary equiv of A-F
    MOVE.B  D5,(A3)
    BRA INC
    
INVALID LEA     INV,A1
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     DONE
            
DONE    MOVE.B  #9,D0
        TRAP    #15             Halt Simulator        

CR      EQU     $0D         
LF      EQU     $0A 

MESSAGE  DC.B    'Input IEEE 32-bit floating point number in hexadecimal',CR,LF,0
MESSAGE1 DC.B    'Please enter the first 4 characters',CR,LF,0        
MESSAGE2 DC.B    'Please enter the last 4 characters',CR,LF,0
INV      DC.B    'That is not between 30 and 46',CR,LF,0

NE      DC.B     'negative',CR,LF,0
P       DC.B     'positive',CR,LF,0

MSG1    DC.B    'SIGN Bit: ',0
MSG2    DC.B    'EXP: ',CR,LF,0
MSG3    DC.B    'MANTISSA: ',CR,LF,0

STORE1   DC.L    $00002000
STORE2   DC.L    $00002004



    SIMHALT             ; halt simulator
 
* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
