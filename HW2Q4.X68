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

*-------Code for input-------
    
    MOVE.B  #2,D0           
    CLR.L   (A1)
    TRAP    #15
    
    
    
    MOVE.L  (A1), $1000
    
    LEA     MESSAGE1,A1     
    MOVE.B  #14,D0          
    TRAP    #15
    
    MOVE.B  #2,D0     
    CLR.L   (A1)
    TRAP    #15
    
    MOVE.L  (A1), $1004
    
    
    *loop 8 times
    *loop through $1000-1008
    *resolve each value based on being a number or letter
    
            
DONE    MOVE.B  #9,D0
        TRAP    #15             Halt Simulator        

CR      EQU     $0D         
LF      EQU     $0A 
        
MESSAGE DC.B    'Please enter the first 4 characters of a IEEE 32-bit floating point number in hexadecimal',CR,LF,0        
MESSAGE1 DC.B    'Please enter the last 4 charaacters of a IEEE 32-bit floating point number in hexadecimal',CR,LF,0        
 

    SIMHALT             ; halt simulator
 
* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
