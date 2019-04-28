*-----------------------------------------------------------
* Title      :Homework 1 Question 3
* Written by :William Nguyen
* Date       :4/26/19
* Description:
*-----------------------------------------------------------
INPUT1   EQU $A000
INPUT2 EQU $A001
Addr1 EQU $00004000



    ORG    $1000
START:                  ; first instruction of program

    *Intaking 2 numbers
    MOVE.B  #5,D0           *Trap # 5 in D0
    TRAP    #15             *Read a number from the keyboard into D1.L. 
    MOVE.B  D1,$A000      
    
    *Converting values at $A000 and $A000 (2 individual characters) to hex
    
    *check if $A000 and $A001 are 41 - 46
    
    *else, assuming proper input, they are 30 - 39
    
    **layer check. first for check bottom. then check top (0-9)
    **if higher than top, check top for A-F
    
CHECK0
    CMP.B   #30,(INPUT1)           Compares D1 to 30
    BLT     INVALID         BLT branches if D1 is less than 30
    CMP.B   #40,(INPUT1)           Compares D1 to 40
    BGT     CHECK1         BGT branches if D1 is greater than 39
    BRA     SUBNUM0


CHECK1
    *CMP.B   #47,(INPUT1)           Compares D1 to 47
    *BGT     INVALID         BGT branches if D1 is greater than 46
    BRA     SUBLET0          

SUBNUM0
    SUBI.B  #30,INPUT1      Reduce to Binary equiv of 0-9
    BRA FOR

SUBLET0
    SUBI.B  #40,INPUT1      Reduce to Binary equiv of A-F
    BRA FOR
FOR   
* will need to use string or 
* single character input and convert to hex.
* Put program code here


* Assuming you want to convert each digit to 
* an individual ASCII character you 
* would proceed something like this:

* If the digit is 0 through 9 add $30 to convert to ASCII.
* If the digit is A through F add $37 to convert to ASCII.

*If the digit is '0' through '9' subtract $30 
*to convert to binary. This works because the 
*ASCII code for '0' is $30. 
*The ASCII code for '1' is $31 etc.
*If the digit is 'A' through 'F' subtract 
*$37 to convert to binary. Take a look at the 
*ASCII codes for 'A' through 'F' to see why this works.
CR      EQU     $0D         
LF      EQU     $0A 
MESSAGE DC.B    'Enter a number: ',0
INV     DC.B    'That is not between 20 and 25',CR,LF,0
INVALID LEA     INV,A1
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     DONE
        
DONE    MOVE.B  #9,D0
        TRAP    #15 

    SIMHALT             ; halt simulator
    
* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
